from phgl_main import *
from .counters import counter

#queue_io and queue classes are rewrite from chisel
#source code coming from: https://github.com/chipsalliance/rocket-chip/chisel3/src/main/scala/chisel3/util/Decoupled.scala
#re-write by python and do some modifications
class queue_io(bundle):
    def set_par(self):
        super(queue_io, self).set_par()
        self.p.par('gen', None)
        self.p.par('gen_p', None)
        self.p.par('entries', None)
        self.p.par('flush_en', 0)

    def set_var(self):
        super(queue_io, self).set_var()
        if (self.p.gen_p is None):
            self.var((ready_valid('enq', gen = self.p.gen).flip()))
            self.var((ready_valid('deq', gen = self.p.gen)))
        else:
            self.var((ready_valid('enq', gen = self.p.gen, p = self.p.gen_p).flip()))
            self.var((ready_valid('deq', gen = self.p.gen, p = self.p.gen_p)))
        if (self.p.entries > 0):
            self.var(outp('count', w = log2_ceil(self.p.entries + 1)))
        if (self.p.flush_en):
            self.var(inp('flush'))


class queue(module):
    def set_par(self):
        super(queue, self).set_par()
        self.p.par('gen', None)
        self.p.par('gen_p', None)
        self.p.par('entries', None)
        self.p.par("data_bypass", 0)
        self.p.par("ready_bypass", 0)
        self.p.par("flush_en", 0)

    def set_port(self):
        super(queue, self).set_port()
        self.io = queue_io(
            'io',
            gen = self.p.gen,
            gen_p = self.p.gen_p,
            entries = self.p.entries,
            flush_en = self.p.flush_en)

    def main(self):
        super(queue, self).main()
        if (self.p.entries == 0):
            self.io.deq.valid /= self.io.enq.valid
            self.io.deq.bits /= self.io.enq.bits
            self.io.enq.ready /= self.io.deq.ready
            return

        if (self.p.gen_p is None):
            ram_gen = self.p.gen
        else:
            ram_gen = lambda _: self.p.gen(_, p = self.p.gen_p)
        ram = vec('ram', gen = ram_gen, n = self.p.entries).as_reg()
        enq_ptr = counter('enq_ptr', n = self.p.entries)
        deq_ptr = counter('deq_ptr', n = self.p.entries)
        maybe_full = reg_r('maybe_full')

        ptr_match = enq_ptr.value == deq_ptr.value
        empty = ptr_match & ~maybe_full
        full = ptr_match & maybe_full
        do_enq = bits('do_enq', init = self.io.enq.fire())
        do_deq = bits('do_deq', init = self.io.deq.fire())

        with when (do_enq):
            ram.idx_write(enq_ptr.value, self.io.enq.bits)
            enq_ptr.inc()
        with when (do_deq):
            deq_ptr.inc()
        with when (do_enq != do_deq):
            maybe_full /= do_enq

        self.io.deq.valid /= ~empty
        self.io.enq.ready /= ~full
        self.io.deq.bits /= ram[deq_ptr.value]

        if (self.p.data_bypass):
            with when (self.io.enq.valid):
                self.io.deq.valid /= 1 
            with when (empty):
                self.io.deq.bits /= self.io.enq.bits
                do_deq /= 0
                with when (self.io.deq.ready):
                    do_enq /= 0 

        if (self.p.ready_bypass):
            with when (self.io.deq.ready):
                self.io.enq.ready /= 1 

        ptr_diff = enq_ptr.value - deq_ptr.value
        if (is_pow_of_2(self.p.entries)):
            self.io.count /= cat([
                maybe_full & ptr_match,
                ptr_diff[deq_ptr.value.get_w() - 1 : 0]])
        else:
            self.io.count /= mux(ptr_match,
                mux(maybe_full,
                self.p.entries, 0),
                mux(deq_ptr.value > enq_ptr.value,
                self.p.entries + ptr_diff, ptr_diff))

        if (self.p.flush_en):
            with when(self.io.flush):
                maybe_full /= 0
                enq_ptr.value /= 0
                deq_ptr.value /= 0

#link list queue
class queue_ll_info(bundle):
    def set_par(self):
        super(queue_ll_info, self).set_par()
        self.p.par('next_w', None)

    def set_var(self):
        super(queue_ll_info, self).set_var()
        self.var(bits('valid'))
        self.var(bits('head'))
        self.var(bits('tail'))
        self.var(bits('next', w = self.p.next_w))

class queue_ll_io(bundle):
    def set_par(self):
        super(queue_ll_io, self).set_par()
        self.p.par('gen', None)
        self.p.par('gen_p', None)
        self.p.par('entries', None)
        self.p.par('flush_en', 0)
        self.p.par('ll_num', None)
        #tmp self.p.par('deq_single_port', 1)

    def set_var(self):
        super(queue_ll_io, self).set_var()
        if (self.p.gen_p is None):
            self.var((ready_valid('enq', gen = self.p.gen).flip()))
            #tmp if (self.p.deq_single_port):
            #tmp     self.var(vec(
            #tmp         'deq',
            #tmp         gen = lambda _: ready_valid(_, gen = bits),
            #tmp         n = self.p.ll_num))
            #tmp     self.var(self.p.gen('deq_dp_bits').as_output())
            #tmp else:
            #tmp     self.var(vec(
            #tmp         'deq',
            #tmp         gen = lambda _: ready_valid(_, gen = self.p.gen),
            #tmp         n = self.p.ll_num))
            self.var(vec(
                'deq',
                gen = lambda _: ready_valid(_, gen = bits),
                n = self.p.ll_num))
            self.var(self.p.gen('deq_dp_bits').as_output())
        else:
            self.var((ready_valid('enq', gen = self.p.gen, p = self.p.gen_p).flip()))
            #tmp if (self.p.deq_single_port):
            #tmp     self.var(vec(
            #tmp         'deq',
            #tmp         gen = lambda _: ready_valid(_, gen = bits),
            #tmp         n = self.p.ll_num))
            #tmp     self.var(self.p.gen('deq_dp_bits', p = self.p.gen_p).as_output())
            #tmp else:
            #tmp     self.var(vec(
            #tmp         'deq',
            #tmp         gen = lambda _: ready_valid(_, gen = self.p.gen, p = self.p.gen_p),
            #tmp         n = self.p.ll_num))
            self.var(vec(
                'deq',
                gen = lambda _: ready_valid(_, gen = bits),
                n = self.p.ll_num))
            self.var(self.p.gen('deq_dp_bits', p = self.p.gen_p).as_output())
        #tmp if (self.p.deq_single_port):
        #tmp     self.var(vec('deq_dp_grant', gen = inp, n = self.p.ll_num))
        if (self.p.entries > 0):
            self.var(outp('count', w = log2_ceil(self.p.entries + 1)))
        if (self.p.flush_en):
            self.var(inp('flush'))

class queue_ll_cam(module):
    def set_par(self):
        super(queue_ll_cam, self).set_par()
        self.p.par('gen', None)
        self.p.par('gen_p', None)
        self.p.par('entries', None)
        self.p.par("data_bypass", 0)
        self.p.par("ready_bypass", 0)
        self.p.par("flush_en", 0)
        self.p.par('get_tag', None)
        self.p.par('ll_num', None)
        #tmp self.p.par('deq_single_port', 1)

    def set_port(self):
        super(queue_ll_cam, self).set_port()
        self.io = queue_ll_io(
            'io',
            gen = self.p.gen,
            gen_p = self.p.gen_p,
            entries = self.p.entries,
            flush_en = self.p.flush_en,
            ll_num = self.p.ll_num)
            #tmp deq_single_port = self.p.deq_single_port)

    def main(self):
        super(queue_ll_cam, self).main()
        if (self.p.entries == 0):
            assert(0)
            return

        if (self.p.gen_p is None):
            ram_gen = self.p.gen
        else:
            ram_gen = lambda _: self.p.gen(_, p = self.p.gen_p)
        ram = vec('ram', gen = ram_gen, n = self.p.entries).as_reg()

        enq_tag = self.p.get_tag(self.io.enq.bits)

        #enqueue side should treat this entry as invalid
        cam_cur_deq_mask = vec(
            'cam_cur_deq_mask',
            gen = bits,
            n = self.p.entries,
            init = 0)

        #link list enqueue
        cam_valids = vec('cam_valids', gen = reg_r, n = self.p.entries)
        cam_heads = vec('cam_heads', gen = reg_r, n = self.p.entries)
        cam_tails = vec('cam_tails', gen = reg_r, n = self.p.entries)
        cam_nexts = vec(
            'cam_nexts',
            gen = reg_r,
            n = self.p.entries,
            w = log2_ceil(self.p.entries))
        cam_tags = list(map(lambda _: self.p.get_tag(ram[_]), range(self.p.entries)))
        cam_empty = ~reduce(lambda a,b:a|b, cam_valids)
        cam_full = reduce(lambda a,b:a&b, cam_valids)
        cam_enq_ll_valids = list(map(
            lambda _: cam_valids[_] & (enq_tag == cam_tags[_]) & ~cam_cur_deq_mask[_],
            range(self.p.entries)))
        cam_enq_ll_empty = ~reduce(lambda a,b:a|b, cam_enq_ll_valids)
        cam_alloc_oh = pri_lsb_enc_oh(~cat_rvs(cam_valids))
        cam_alloc_bin = pri_lsb_enc(~cat_rvs(cam_valids))
        with when(self.io.enq.fire()):
            for i in range(self.p.entries):
                with when(cam_enq_ll_valids[i] & cam_tails[i]):
                    cam_tails[i] /= 0
                    cam_nexts[i] /= cam_alloc_bin

                with when(cam_alloc_oh[i]):
                    cam_valids[i] /= 1
                    with when(cam_enq_ll_empty):
                        cam_heads[i] /= 1
                    cam_tails[i] /= 1
                    ram[i] /= self.io.enq.bits
        self.io.enq.ready /= ~cam_full
        self.io.count /= count_ones(list(cam_valids))


        #link list dequeue
        cam_tags_ll_cmp = list(map(
            lambda _: list(map(lambda i: cam_tags[_] == i, range(self.p.ll_num))),
            range(self.p.entries)))
        cam_deq_ll_valids = list(map(
            lambda i: list(map(
                lambda _: cam_valids[_] & cam_tags_ll_cmp[_][i],
                range(self.p.entries))),
            range(self.p.ll_num)))
        cam_deq_ll_valids_any = list(map(
            lambda _: reduce(lambda a,b: a|b,  _),
            cam_deq_ll_valids))
        cam_deq_ll_fire = list(map(lambda i: i.fire(), list(self.io.deq)))
        cam_deq_ll_head_ptr_oh = list(map(
            lambda i: list(map(
                lambda _: cam_heads[_] & cam_tags_ll_cmp[_][i],
                range(self.p.entries))),
            range(self.p.ll_num)))
        for i in range(self.p.ll_num):
            self.io.deq[i].valid /= cam_deq_ll_valids_any[i]

        #tmp if (self.p.deq_single_port):
        cam_deq_ll_fire_any = reduce(lambda a,b:a|b, cam_deq_ll_fire)
        cam_deq_ll_head_ptr_oh_sel = reduce(
            lambda a,b:a|b,
            list(map(
                lambda i: (
                    #tmp self.io.deq_dp_grant[i].rep(self.p.entries) & 
                    self.io.deq[i].ready.rep(self.p.entries) & 
                    cat_rvs(cam_deq_ll_head_ptr_oh[i])),
                range(self.p.ll_num))))
        cam_deq_ll_head_next_ptr_sel = sel_oh(cam_deq_ll_head_ptr_oh_sel, cam_nexts)
        cam_deq_ll_head_tail_sel = sel_oh(cam_deq_ll_head_ptr_oh_sel, cam_tails)
        cam_deq_ll_ram_bits_sel = sel_oh(cam_deq_ll_head_ptr_oh_sel, ram) 

        self.io.deq_dp_bits /= cam_deq_ll_ram_bits_sel
        for i in range(self.p.ll_num):
            self.io.deq[i].bits /= 0

        with when(cam_deq_ll_fire_any):
            #clean current head
            cam_cur_deq_mask.oh_write(cam_deq_ll_head_ptr_oh_sel, 1)
            cam_valids.oh_write(cam_deq_ll_head_ptr_oh_sel, 0)
            cam_heads.oh_write(cam_deq_ll_head_ptr_oh_sel, 0)
            cam_tails.oh_write(cam_deq_ll_head_ptr_oh_sel, 0)

            #next entry update to head if current head is not tail
            with when(~cam_deq_ll_head_tail_sel):
                cam_heads.idx_write(cam_deq_ll_head_next_ptr_sel, 1)
        #tmp else:
        #tmp     cam_deq_ll_head_next_ptr = list(map(
        #tmp         lambda i: sel_oh(cam_deq_ll_head_ptr_oh[i], cam_nexts),
        #tmp         range(self.p.ll_num)))
        #tmp     cam_deq_ll_head_tail = list(map(
        #tmp         lambda i: sel_oh(cam_deq_ll_head_ptr_oh[i], cam_tails),
        #tmp         range(self.p.ll_num)))
        #tmp     cam_deq_ll_ram_bits = list(map(
        #tmp         lambda i: sel_oh(cam_deq_ll_head_ptr_oh[i], ram),
        #tmp         range(self.p.ll_num)))

        #tmp     for i in range(self.p.ll_num):
        #tmp         self.io.deq[i].bits /= cam_deq_ll_ram_bits[i]

        #tmp         with when(cam_deq_ll_fire[i]):
        #tmp             #clean current head
        #tmp             cam_cur_deq_mask.oh_write(cam_deq_ll_head_ptr_oh[i], 1)
        #tmp             cam_valids.oh_write(cam_deq_ll_head_ptr_oh[i], 0)
        #tmp             cam_heads.oh_write(cam_deq_ll_head_ptr_oh[i], 0)
        #tmp             cam_tails.oh_write(cam_deq_ll_head_ptr_oh[i], 0)

        #tmp             #next entry update to head if current head is not tail
        #tmp             with when(~cam_deq_ll_head_tail[i]):
        #tmp                 cam_heads.idx_write(cam_deq_ll_head_next_ptr[i], 1)

class queue_ll(module):
    def set_par(self):
        super(queue_ll, self).set_par()
        self.p.par('gen', None)
        self.p.par('gen_p', None)
        self.p.par('entries', None)
        self.p.par("data_bypass", 0)
        self.p.par("ready_bypass", 0)
        self.p.par("flush_en", 0)
        self.p.par('get_tag', None)
        self.p.par('ll_num', None)
        #tmp self.p.par('deq_single_port', 1)

    def set_port(self):
        super(queue_ll, self).set_port()
        self.io = queue_ll_io(
            'io',
            gen = self.p.gen,
            gen_p = self.p.gen_p,
            entries = self.p.entries,
            flush_en = self.p.flush_en,
            ll_num = self.p.ll_num)
            #tmp deq_single_port = self.p.deq_single_port)

    def main(self):
        super(queue_ll, self).main()
        if (self.p.entries == 0):
            assert(0)
            return

        if (self.p.gen_p is None):
            ram_gen = self.p.gen
        else:
            ram_gen = lambda _: self.p.gen(_, p = self.p.gen_p)

        busy_bit_map = vec('busy_bit_map', gen = reg_r, n = self.p.entries)
        entry_alloc_oh = pri_lsb_enc_oh(~cat_rvs(busy_bit_map))
        entry_alloc_bin = pri_lsb_enc(~cat_rvs(busy_bit_map))

        ram_addr_w = log2_ceil(self.p.entries)
        data_ram = vec('data_ram', gen = ram_gen, n = self.p.entries).as_reg()
        next_ram = vec('next_ram', reg, n = self.p.entries, w = ram_addr_w)

        head_valids = vec('head_valids', reg_r, n = self.p.ll_num)
        head_ptrs = vec('head_ptrs', reg, n = self.p.ll_num, w = ram_addr_w)

        tail_valids = vec('tail_valids', reg_r, n = self.p.ll_num)
        tail_ptrs = vec('tail_ptrs', reg, n = self.p.ll_num, w = ram_addr_w)

        enq_tag = self.p.get_tag(self.io.enq.bits)
        enq_do = vec('enq_do', bits, n = self.p.ll_num)
        for i in range(self.p.ll_num):
            enq_do[i] /= self.io.enq.fire() & (enq_tag == i)

        deq_do = vec('deq_do', bits, n = self.p.ll_num)
        for i in range(self.p.ll_num):
            deq_do[i] /= self.io.deq[i].fire()
        deq_do_any = reduce(lambda a,b: a|b, list(deq_do))
        deq_ready = vec('deq_ready', bits, n = self.p.ll_num)
        for i in range(self.p.ll_num):
            deq_ready[i] /= self.io.deq[i].ready
        deq_ready_bin = oh2bin(cat_rvs(deq_ready))

        empty = vec('empty', bits, n = self.p.ll_num)
        for i in range(self.p.ll_num):
            empty[i] /= ~head_valids[i] | (deq_do[i] & tail_valids[i] & (tail_ptrs[i] == head_ptrs[i]))

        full = reduce(lambda a,b: a&b, list(busy_bit_map))
        self.io.enq.ready /= ~full


        deq_head_ptr_sel = sel_oh(deq_ready, head_ptrs)
        deq_tail_ptr_sel = sel_oh(deq_ready, tail_ptrs)
        deq_next_head_ptr = next_ram[deq_head_ptr_sel]
        with when(deq_do_any):
            head_ptrs(deq_ready_bin, deq_next_head_ptr)

            #head == tail, means this is the last entry
            #need clean head and tail's valid flag
            with when(deq_head_ptr_sel == deq_tail_ptr_sel):
                head_valids(deq_ready_bin, 0)
                tail_valids(deq_ready_bin, 0)

            #de-alloc ram entry
            busy_bit_map(deq_head_ptr_sel, 0)

        self.io.deq_dp_bits /= data_ram[deq_head_ptr_sel]

        for i in range(self.p.ll_num):
            self.io.deq[i].valid /= head_valids[i]
            self.io.deq[i].bits /= 0

        
        enq_tail_ptr_sel = sel_bin(enq_tag, tail_ptrs)
        with when(self.io.enq.fire()):
            data_ram(entry_alloc_bin, self.io.enq.bits)
            next_ram(enq_tail_ptr_sel, entry_alloc_bin)
            tail_ptrs(enq_tag, entry_alloc_bin)
            tail_valids(enq_tag, 1)

            head_valids(enq_tag, 1)
            #list will be empty, need set it's head ptr same as tails
            with when(empty[enq_tag]):
                head_ptrs(enq_tag, entry_alloc_bin)

            #alloc ram entry
            busy_bit_map(entry_alloc_bin, 1)

        self.io.count /= count_ones(list(busy_bit_map))





#vijay2 style
class async_queue(module):
    def set_par(self):
        super(async_queue, self).set_par()
        self.p.par('gen', None)
        self.p.par('gen_p', None)
        self.p.par('entries', None)
        self.p.par('flush_en', 0)
        self.p.par('th_full', None)
        self.p.par('enq_sync_n', 3)
        self.p.par('deq_sync_n', 3)

    def check_par(self):
        super(async_queue, self).check_par()
        assert(self.p.entries > 3)
        assert(self.p.enq_sync_n > 1)
        assert(self.p.deq_sync_n > 1)
        if (self.p.th_full is None):
            self.p.th_full = self.p.entries - 2
        assert(self.p.th_full < self.p.entries and self.p.th_full > 0)

        self.reset_async()

    def set_port(self):
        super(async_queue, self).set_port()
        self.io = queue_io(
            'io', 
            gen = self.p.gen, 
            gen_p = self.p.gen_p,
            entries = self.p.entries,
            flush_en = self.p.flush_en)
        self.io.var(inp('enq_clock'))
        self.io.var(inp('enq_reset'))
        self.io.var(inp('deq_clock'))
        self.io.var(inp('deq_reset'))

    def add1(self, a):
        if (is_pow_of_2(self.p.entries)):
            return a + 1
        else:
            return mux(a == self.p.entries - 1, 0, a + 1)

    def main(self):
        super(async_queue, self).main()

        if (self.p.gen_p is None):
            ram_gen = self.p.gen
        else:
            ram_gen = lambda _: self.p.gen(_, p = self.p.gen_p)

        
        #flush sync to enq/deq side, similar as reset
        if (self.p.flush_en):
            flush_enq = async_dff_r(
                self.io.flush,
                self.p.enq_sync_n,
                clock = self.io.enq_clock,
                reset = self.io.enq_reset)
            flush_deq = async_dff_r(
                self.io.flush,
                self.p.deq_sync_n,
                clock = self.io.deq_clock,
                reset = self.io.deq_reset)


        ram = vec(
            'ram', 
            gen = ram_gen,
            n = self.p.entries).as_reg(
                clock = self.io.enq_clock,
                reset = self.io.enq_reset)
        rd_ptr = reg_r(
            'rd_ptr',
            w = log2_ceil(self.p.entries),
            clock = self.io.deq_clock,
            reset = self.io.deq_reset)
        wr_ptr = reg_r(
            'wr_ptr',
            w = log2_ceil(self.p.entries),
            clock = self.io.enq_clock,
            reset = self.io.enq_reset)
        empty = bits('empty')
        full = bits('full')
        rd_ptr_next = self.add1(rd_ptr)
        wr_ptr_next = self.add1(wr_ptr)

        #rd_ptr sync to write side
        rd_ptr_gray = bin2gray(rd_ptr, self.p.entries)
        rd_ptr_gray_dly0 = reg_rs(
            'rd_ptr_gray_dly0',
            w = rd_ptr_gray.get_w(),
            clock = self.io.deq_clock,
            reset = self.io.deq_reset,
            rs = gray_start(rd_ptr, self.p.entries),
            next = rd_ptr_gray)
        rd_ptr_sync = gray2bin(
            async_dff_rs(
                rd_ptr_gray_dly0,
                self.p.enq_sync_n,
                rs = gray_start(rd_ptr, self.p.entries),
                clock = self.io.enq_clock,
                reset = self.io.enq_reset),
            self.p.entries)

        #wr_ptr sync to read side
        wr_ptr_gray = bin2gray(wr_ptr, self.p.entries)
        wr_ptr_gray_dly0 = reg_rs(
            'wr_ptr_gray_dly0',
            w = wr_ptr_gray.get_w(),
            clock = self.io.enq_clock,
            reset = self.io.enq_reset,
            rs = gray_start(wr_ptr, self.p.entries),
            next = wr_ptr_gray)
        wr_ptr_sync = gray2bin(
            async_dff_rs(
                wr_ptr_gray_dly0,
                self.p.deq_sync_n,
                rs = gray_start(wr_ptr, self.p.entries),
                clock = self.io.deq_clock,
                reset = self.io.deq_reset),
            self.p.entries)

        wr_word_count = bits('wr_word_count', w = log2_ceil(self.p.entries) + 1)
        rd_word_count = bits('rd_word_count', w = log2_ceil(self.p.entries) + 1)
        wr_direction_flagwr = reg_r(
            'wr_direction_flagwr',
            clock = self.io.enq_clock,
            reset = self.io.enq_reset)
        wr_direction_flagrd = reg_s(
            'wr_direction_flagrd',
            clock = self.io.enq_clock,
            reset = self.io.enq_reset)
        rd_direction_flagwr = reg_r(
            'rd_direction_flagwr', 
            clock = self.io.deq_clock, 
            reset = self.io.deq_reset)
        rd_direction_flagrd = reg_s(
            'rd_direction_flagrd', 
            clock = self.io.deq_clock, 
            reset = self.io.deq_reset)
        wr_ptr_cmp0 = (wr_ptr > rd_ptr_sync)
        wr_ptr_cmp1 = (rd_ptr_sync > wr_ptr)
        rd_ptr_cmp0 = (wr_ptr_sync > rd_ptr)
        rd_ptr_cmp1 = (rd_ptr > wr_ptr_sync)
        wr_word_count /= mux(
            wr_ptr_cmp0, 
            wr_ptr - rd_ptr_sync, 
            mux(
                wr_ptr_cmp1, 
                self.p.entries - (rd_ptr_sync - wr_ptr),
                mux(
                    wr_direction_flagwr,
                    self.p.entries,
                    0)))[wr_word_count.get_w() - 1 : 0]
        rd_word_count /= mux(
            rd_ptr_cmp0,
            wr_ptr_sync - rd_ptr,
            mux(
                rd_ptr_cmp1,
                self.p.entries - (rd_ptr - wr_ptr_sync),
                mux(
                    rd_direction_flagwr,
                    self.p.entries,
                    0)))[rd_word_count.get_w() - 1 : 0]

        wr_direction_flagwr /= mux(
            wr_word_count >= self.p.entries - 1,
            1,
            mux(wr_word_count <= 1, 0, wr_direction_flagwr))
        rd_direction_flagwr /= mux(
            rd_word_count >= self.p.entries - 1,
            1,
            mux(rd_word_count <= 1, 0, rd_direction_flagwr))

        wr_direction_flagrd /= mux(
            wr_word_count >= self.p.entries - 1,
            0,
            mux(wr_word_count <= 1, 1, wr_direction_flagrd))
        rd_direction_flagrd /= mux(
            rd_word_count >= self.p.entries - 1,
            0,
            mux(rd_word_count <= 1, 1, rd_direction_flagrd))

        full  /= wr_direction_flagwr & (wr_ptr == rd_ptr_sync)
        empty /= rd_direction_flagrd & (wr_ptr_sync == rd_ptr)

        valid_rd = ~empty & self.io.deq.fire()
        valid_wr = ~full & self.io.enq.fire()

        wr_ptr /= mux(valid_wr, wr_ptr_next, wr_ptr)
        rd_ptr /= mux(valid_rd, rd_ptr_next, rd_ptr)

        a_full = wr_word_count >= self.p.th_full
        self.io.enq.ready /= ~a_full
        self.io.deq.valid /= ~empty

        with when(valid_wr):
            ram(wr_ptr, self.io.enq.bits)

        self.io.deq.bits /= ram[rd_ptr]

        self.io.count /= wr_word_count


        if (self.p.flush_en):
            with when(flush_enq):
                wr_ptr /= 0
                wr_direction_flagwr /= 0
                wr_direction_flagrd /= 1

            with when(flush_deq):
                rd_ptr /= 0
                rd_direction_flagwr /= 0
                rd_direction_flagrd /= 1

class async_ready_valid(module):
    def set_par(self):
        super(async_ready_valid, self).set_par()
        self.p.par('gen', None)
        self.p.par('gen_p', None)
        self.p.par('enq_sync_n', 3)
        self.p.par('deq_sync_n', 3)
        self.p.par('flush_en', 0)

    def check_par(self):
        super(async_ready_valid, self).check_par()
        assert(self.p.enq_sync_n > 1)
        assert(self.p.deq_sync_n > 1)
        self.reset_async()

    def set_port(self):
        super(async_ready_valid, self).set_port()
        self.io = queue_io(
            'io',
            gen = self.p.gen,
            gen_p = self.p.gen_p,
            entries = 0,
            flush_en = self.p.flush_en)
        self.io.var(inp('enq_clock'))
        self.io.var(inp('enq_reset'))
        self.io.var(inp('deq_clock'))
        self.io.var(inp('deq_reset'))

    def main(self):
        super(async_ready_valid, self).main()

        if (self.p.gen_p is None):
            entry_gen = self.p.gen
        else:
            entry_gen = lambda _: self.p.gen(_, p = self.p.gen_p)

        #flush sync to enq/deq side, similar as reset
        if (self.p.flush_en):
            flush_enq = async_dff_r(
                self.io.flush,
                self.p.enq_sync_n,
                clock = self.io.enq_clock,
                reset = self.io.enq_reset)
            flush_deq = async_dff_r(
                self.io.flush,
                self.p.deq_sync_n,
                clock = self.io.deq_clock,
                reset = self.io.deq_reset)

        entry = entry_gen('entry').as_reg(
            clock = self.io.enq_clock,
            reset = self.io.enq_reset)

        enq_valid = reg_r(
            'enq_valid', 
            clock = self.io.enq_clock,
            reset = self.io.enq_reset)
        #sync to deq side
        enq_valid_sync = async_dff_r(
            enq_valid, 
            self.p.deq_sync_n,
            clock = self.io.deq_clock,
            reset = self.io.deq_reset)

        deq_valid = reg_r(
            'deq_valid', 
            clock = self.io.deq_clock, 
            reset = self.io.deq_reset)
        #sync to enq side
        deq_valid_sync = async_dff_r(
            deq_valid, 
            self.p.enq_sync_n,
            clock = self.io.enq_clock, 
            reset = self.io.enq_reset)

        self.io.enq.ready /= ~enq_valid & ~deq_valid_sync
        with when(self.io.enq.fire()):
            enq_valid /= 1
            entry /= self.io.enq.bits
        with elsewhen(deq_valid_sync):
            enq_valid /= 0


        self.io.deq.valid /= enq_valid_sync & ~deq_valid
        with when(self.io.deq.fire()):
            deq_valid /= 1
        with elsewhen(~enq_valid_sync):
            deq_valid /= 0

        self.io.deq.bits /= 0
        with when(self.io.deq.valid):
            self.io.deq.bits /= entry


        if (self.p.flush_en):
            with when(flush_enq):
                enq_valid /= 0

            with when(flush_deq):
                deq_valid /= 0
