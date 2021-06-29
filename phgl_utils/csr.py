from phgl_imp import *
from .fifo import queue

class csr_reg_field_desc(parameter):
    def set_par(self):
        super(csr_reg_field_desc, self).set_par()
        self.par('access', 'RW')
        self.par('wr_action', 'WRITE')
        self.par('rd_action', 'READ')
        self.par('width', 1)
        self.par('reset', None)
        self.par('read', None)
        self.par('write', None)
        self.par('comments', '')

    def check_par(self):
        super(csr_reg_field_desc, self).check_par()
        assert(self.width > 0), "width must > 0, not %d" % (self.width)

    def reserved(self):
        return csr_reg_field_desc("reserved", access = 'RO', reset = 0)

    def gen_field(self):
        if ((self.access == 'VOL') or (self.access == 'WO')):
            res = bits(
                self.name,
                w = self.width,
                init = 0 if (self.reset is None) else self.reset)
        else:
            if (self.reset is None):
                res = reg(self.name, w = self.width)
            else:
                assert(isinstance(self.reset, (int)))
                res = reg_rs(self.name, w = self.width, rs = self.reset)

        self.field = res
        return res

    def default_bus_write(self, fire, address, size, wdata, mask_bit):
        mask_wdata_and = wdata & mask_bit
        mask_wdata_or = wdata | ~mask_bit
        
        if (self.access == 'VOL'):
            return (1, 1)
        else:
            if (self.access == 'RW'):
                with when(fire):
                    if (self.wr_action == 'ONE_TO_CLEAR'):
                        self.field /= self.field & (~mask_wdata_and)
                    elif (self.wr_action == 'ONE_TO_SET'):
                        self.field /= self.field | mask_wdata_and
                    elif (self.wr_action == 'ONE_TO_TOGGLE'):
                        self.trigger_toggle(wdata[0])
                    elif (self.wr_action == 'ZERO_TO_CLEAR'):
                        self.field /= self.field & mask_wdata_or
                    elif (self.wr_action == 'ZERO_TO_SET'):
                        self.field /= self.field | ~mask_wdata_or
                    elif (self.wr_action == 'ZERO_TO_TOGGLE'):
                        self.trigger_toggle(wdata[0])
                    elif (self.wr_action == 'CLEAR'):
                        self.field /= self.field & ~mask_bit
                    elif (self.wr_action == 'SET'):
                        self.field /= self.field | mask_bit
                    elif (self.wr_action == 'WRITE'):
                        self.field /= (self.field & ~mask_bit) | mask_wdata_and
            elif (self.access == 'WO'):
                with when(fire):
                    self.field /= mask_wdata_and
            return (1, 1)

    def bus_write(self, fire, address, size, wdata, mask_bit):
        if (self.write is not None):
            return self.write(self.field, fire, address, size, wdata, mask_bit)
        else:
            return self.default_bus_write(fire, address, size, wdata, mask_bit)

    def default_bus_read(self, fire, address, size, mask_bit):
        if (self.rd_action == 'CLEAR'):
            with when(fire):
                self.field /= self.field & ~mask_bit
        elif (self.rd_action == 'SET'):
            with when(fire):
                self.field /= self.field | mask_bit
        return (1, 1, self.field)

    def bus_read(self, fire, address, size, mask_bit):
        if (self.read is not None):
            return self.read(self.field, fire, address, size, mask_bit)
        else:
            return self.default_bus_read(fire, address, size, mask_bit)

class csr_reg_group(bundle):
    def set_par(self):
        super(csr_reg_group, self).set_par()
        self.p.par('offset', None)
        self.p.par('size', 1) #size of bytes
        self.p.par('mem_size', None) #used for memory map access, bytes
        self.p.par('fields_desc', [])
        self.p.par('comments', '')

    def set_var(self):
        super(csr_reg_group, self).set_var()
        for i in list(filter(lambda _: _ is not None, flatten_all(self.p.fields_desc))):
            self.var(i.gen_field())

    def bus_write(self, fire, address, size, wdata, mask_bit):
        assert(self.p.size == 4 or self.p.size == 8)
        if (self.p.size <= (mask_bit.get_w()//8)):
            ah = log2_ceil(mask_bit.get_w()//8) - 1
            al = log2_ceil(self.p.size)
            wdata_grp = wdata.grouped(self.p.size * 8)
            mask_bit_grp = mask_bit.grouped(self.p.size * 8)
            a_sel = address[ah:al]
            cur_wdata = sel(a_sel, wdata_grp)
            cur_mask = sel(a_sel, mask_bit_grp)
        else:
            ah = log2_ceil(self.p.size) - 1
            al = log2_ceil(mask_bit.get_w()//8)
            a_sel = address[ah:al]
            cur_wdata = wdata.rep(self.p.size // (mask_bit.get_w()//8))
            cur_mask = cat_rvs(map(
                lambda _: mux(a_sel == _, mask_bit, 0),
                range(self.p.size // (mask_bit.get_w()//8))))

        #from lsb to msb
        descs = list(reversed(list(filter(
            lambda _: _ is not None,
            flatten_all(self.p.fields_desc)))))
        ready_valid_q = []
        for i in descs:
            ready_valid = i.bus_write(fire, address, size, cur_wdata, cur_mask)
            ready_valid_q.append(ready_valid)
            cur_mask = cur_mask >> i.width
            cur_wdata = cur_wdata >> i.width
        return reduce(lambda a,b: (a[0] & b[0], a[1] & b[1]), ready_valid_q)

    def bus_read(self, fire, address, size, mask_bit):
        assert(self.p.size == 4 or self.p.size == 8)
        if (self.p.size <= (mask_bit.get_w()//8)):
            ah = log2_ceil(mask_bit.get_w()//8) - 1
            al = log2_ceil(self.p.size)
            mask_bit_grp = mask_bit.grouped(self.p.size * 8)
            a_sel = address[ah:al]
            cur_mask = sel(a_sel, mask_bit_grp)
        else:
            ah = log2_ceil(self.p.size) - 1
            al = log2_ceil(mask_bit.get_w()//8)
            a_sel = address[ah:al]
            cur_mask = cat_rvs(map(
                lambda _: mux(a_sel == _, mask_bit, 0),
                range(self.p.size // (mask_bit.get_w()//8))))

        ready_valid_data_q = []
        descs = list(reversed(list(filter(
            lambda _: _ is not None,
            flatten_all(self.p.fields_desc)))))
        #from lsb to msb
        for i in descs:
            #tmp (rd_ready, rd_valid, rd_data) = i.bus_read(fire, address, size, cur_mask)
            (rd_ready, rd_valid, rd_data) = i.bus_read(fire, address, size, cur_mask)
            tmp = bits(w = i.width, init = rd_data)
            ready_valid_data_q.append((rd_ready, rd_valid, tmp))
            cur_mask = cur_mask >> i.width

        ready_q = list(map(lambda _: _[0], ready_valid_data_q))
        valid_q = list(map(lambda _: _[1], ready_valid_data_q))
        data_q = list(map(lambda _: _[2], ready_valid_data_q))
        ready_merge = reduce(lambda a, b: a & b, ready_q)
        valid_merge = reduce(lambda a, b: a & b, valid_q)
        data_merge = cat_rvs(data_q).u_ext(self.p.size * 8)
        if (self.p.size <= (mask_bit.get_w()//8)):
            return (
                ready_merge,
                valid_merge,
                data_merge.rep((mask_bit.get_w()//8)//self.p.size))
        else:
            ah = log2_ceil(self.p.size) - 1
            al = log2_ceil(mask_bit.get_w()//8)
            a_sel = address[ah:al]
            return (
                ready_merge, 
                valid_merge,
                sel(a_sel, data_merge.grouped(mask_bit.get_w())))


class csr_reg_req(bundle):
    def set_par(self):
        super(csr_reg_req, self).set_par()

    def set_var(self):
        super(csr_reg_req, self).set_var()
        self.var(bits('write'))
        self.var(bits('addr', w = self.p.addr_bits))
        self.var(bits('data', w = self.p.data_bits))
        self.var(bits('be', w = self.p.be_bits))

class csr_reg_resp(bundle):
    def set_par(self):
        super(csr_reg_resp, self).set_par()

    def set_var(self):
        super(csr_reg_resp, self).set_var()
        self.var(bits('data', w = self.p.data_bits))

class csr_reg_io(bundle):
    def set_par(self):
        super(csr_reg_io, self).set_par()
        self.p.par('addr_bits', None)
        self.p.par('data_bits', None)

    def check_par(self):
        super(csr_reg_io, self).check_par()
        self.p.par('be_bits', self.p.data_bits//8)

    def set_var(self):
        super(csr_reg_io, self).set_var()
        self.var(ready_valid('req', gen = csr_reg_req, p = self.p).flip())
        self.var(ready_valid('resp', gen = csr_reg_resp, p = self.p))

class csr_module(module):
    def cfg_reg(self, a):
        self.reg_q.append(a)
        self.regs[a.name] = a
        return a

    def address_align(self, address, size, mem_size):
        shift_w = log2_ceil(size)
        if (mem_size is not None):
            assert(is_pow_of_2(mem_size))
            mask = value((1 << log2_ceil(mem_size)) - 1, w = address.get_w())
        else:
            mask = value(0, w = address.get_w())
        return ((address >> shift_w) << shift_w) & ~mask.to_bits()

    def reg_req_data_width(self):
        return self.reg_if.req.bits.data.get_w()

    def reg_req_addr_width(self):
        return self.reg_if.req.bits.addr.get_w()

    def reg_req(self):
        return self.reg_if.req

    def reg_req_is_wr(self, req_bits):
        return req_bits.write

    def reg_req_is_rd(self, req_bits):
        return ~req_bits.write

    def reg_req_addr(self, req_bits):
        return req_bits.addr

    def reg_req_data(self, req_bits):
        return req_bits.data

    def reg_req_be(self, req_bits):
        return req_bits.be

    def reg_req_size(self, req_bits):
        return log2_ceil(req_bits.data.get_w()//8)

    def reg_resp(self):
        return self.reg_if.resp

    def gen_reg_resp_bits(self, req_bits, data):
        res = self.reg_resp().bits.clone().as_bits()
        res.data /= data
        return res

    def do_reg_access(self):
        eff_reg_q = list(filter(lambda _: _ is not None, self.reg_q))
        if (len(eff_reg_q) > 0):
            #none mapped address's access will do dummy access to this reg: read get 0, write do nothing
            dummy_reg = self.cfg_reg(csr_reg_group(
                'dumy_mapped_space',
                offset = 0,
                size = self.reg_req_data_width()//8,
                mem_size = 1 << self.reg_req_addr_width(),
                fields_desc = [
                    csr_reg_field_desc(
                        'data',
                        access = 'VOL',
                        width = self.reg_req_data_width(),
                        reset = 0)]))
            eff_reg_q.append(dummy_reg)

            resp_block = reg_r()
            tl_in_a_reg = self.reg_req().bits.clone().as_reg()
            tl_fire = self.reg_req().fire()
            tl_in_a = mux(resp_block, tl_in_a_reg, self.reg_req().bits)
            tl_op_wr = self.reg_req_is_wr(tl_in_a)
            tl_op_rd = self.reg_req_is_rd(tl_in_a)
            tl_address = self.reg_req_addr(tl_in_a)
            tl_data = self.reg_req_data(tl_in_a)
            tl_be_bit = cat_rvs(list(map(
                lambda _: _.rep(8), 
                self.reg_req_be(tl_in_a).grouped())))
            tl_size = self.reg_req_size(tl_in_a)

            reg_resp_buf = queue(
                'reg_resp_buf',
                gen = type(self.reg_resp().bits),
                gen_p = self.reg_resp().bits.p,
                entries = 2)
            reg_resp_buf.io.enq.valid /= 0

            rd_wr_valid_last = 0
            rd_wr_ready_last = 0
            rdata_last = 0
            match_any = 0
            reg_len = len(eff_reg_q)
            for i in range(reg_len):
                offset = eff_reg_q[i].p.offset
                size = eff_reg_q[i].p.size
                mem_size = eff_reg_q[i].p.mem_size
                address_align = self.address_align(tl_address, size, mem_size)

                #last reg is default dummy reg
                if (i == reg_len - 1):
                    address_match = ~match_any
                else:
                    address_match = address_align == offset
                match_any = match_any | address_match

                (wr_ready, wr_valid) = eff_reg_q[i].bus_write(
                    tl_fire & tl_op_wr & address_match,
                    tl_address,
                    tl_size,
                    tl_data,
                    tl_be_bit)
                (rd_ready, rd_valid, rdata) = eff_reg_q[i].bus_read(
                    tl_fire & tl_op_rd & address_match,
                    tl_address,
                    tl_size,
                    tl_be_bit)
                rd_wr_valid_last = rd_wr_valid_last | (
                    mux(tl_op_wr, wr_valid, rd_valid) & 
                    address_match)
                rd_wr_ready_last = rd_wr_ready_last | (
                    mux(tl_op_wr, wr_ready, rd_ready) & 
                    address_match)
                rdata_last = rdata_last | (
                    address_match.rep(self.reg_req_data_width()) & 
                    rdata)

            reg_resp_buf.io.enq.valid /= rd_wr_valid_last & (tl_fire | resp_block)
            reg_resp_buf.io.enq.bits /= self.gen_reg_resp_bits(tl_in_a, rdata_last)
            self.reg_req().ready /= (
                reg_resp_buf.io.enq.ready & 
                ~resp_block & 
                rd_wr_ready_last)
            resp = self.reg_resp()
            resp /= reg_resp_buf.io.deq

            with when(tl_fire & ~reg_resp_buf.io.enq.fire()):
                resp_block /= 1
                tl_in_a_reg /= self.reg_req().bits
            with elsewhen(resp_block & reg_resp_buf.io.enq.fire()):
                resp_block /= 0

    def gen_xls(self):
        reg_info_q = []
        for r in self.reg_q:
            f_q = []
            bits_offset = 0
            if (r.name == 'dumy_mapped_space'):
                continue;
            for f in reversed(r.p.fields_desc):
                if (f is None):
                    continue
                bits_range = '[%d:%d]' %(bits_offset + f.width - 1, bits_offset)
                bits_offset = bits_offset + f.width
                if (((f.access == 'VOL') or (f.access == 'WO')) and (f.reset is None)):
                    reset_v = '0x0'
                else:
                    if (f.reset is None):
                        reset_v = 'x'
                    elif (isinstance(f.reset, int)):
                        reset_v = '0x%x' %(f.reset)
                    else:
                        reset_v = 'x'

                f_q.append([f.name, f.access, f.wr_action, f.rd_action, str(f.width), bits_range, reset_v, f.comments])
            reg_info_q.append([r.name, '0x%x' %(r.p.offset), str(r.p.size), 'NA' if (r.p.mem_size is None) else str(r.p.mem_size), r.p.comments, f_q])
        return reg_info_q


    def post_main(self):
        super(csr_module, self).post_main()
        self.do_reg_access()

    def main(self):
        super(csr_module, self).main()
        self.reg_q = [] #bus access registors
        self.regs = {} #use name to index reg
        self.reg_if = None
