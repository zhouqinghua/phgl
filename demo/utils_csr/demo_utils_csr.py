from phgl_imp import *

class utils_csr_top(csr_module):
    def set_par(self):
        super(utils_csr_top, self).set_par()

    def set_port(self):
        super(utils_csr_top, self).set_port()
        self.io.var(csr_reg_io(
            'reg',
            addr_bits = 12,
            data_bits = 32))
        self.io.var(inp('op', w = 4))
        self.io.var(inp('in0', w = 8))
        self.io.var(inp('in1', w = 8))
        self.io.var(inp('out', w = 8))

    def main(self):
        super(utils_csr_top, self).main()
        self.reg_if = self.io.reg

        self.cfg_reg(csr_reg_group(
            'cfg_regs_rw',
            offset = 0x000,
            size = 4,
            fields_desc = [
                csr_reg_field_desc('field_rw3',  width = 8, reset = 0),
                csr_reg_field_desc('field_rw2',  width = 4, reset = 5),
                csr_reg_field_desc('field_rw1',  width = 3),
                csr_reg_field_desc('field_rw0',  width = 1, reset = 0)]))

        self.cfg_reg(csr_reg_group(
            'cfg_res_rw_ro',
            offset = 0x0004,
            size = 4,
            fields_desc = [
                csr_reg_field_desc('field_ro3',  width = 8, reset = 0, access = 'RO'),
                csr_reg_field_desc('field_rw2',  width = 4, reset = 0),
                csr_reg_field_desc('field_ro1',  width = 3, reset = 0, access = 'RO'),
                csr_reg_field_desc('field_rw0',  width = 1, reset = 0)]))
        with when(self.io.op == 1):
            self.regs['cfg_res_rw_ro'].field_ro1 /= self.io.in0
        with when(self.io.op == 1):
            self.regs['cfg_res_rw_ro'].field_ro3 /= self.io.in1
        rw_reg_v = reg_r('rw_reg_v', w = 4)
        rw_reg_v /= self.regs['cfg_res_rw_ro'].field_rw2

        self.cfg_reg(csr_reg_group(
            'cfg_res_zc_oc_zs_os',
            offset = 0x0008,
            size = 4,
            fields_desc = [
                csr_reg_field_desc('field_os3',  width = 8, reset = 0, wr_action = 'ONE_TO_SET'),
                csr_reg_field_desc('field_zs2',  width = 4, reset = 0, wr_action = 'ZERO_TO_SET'),
                csr_reg_field_desc('field_oc1',  width = 3, reset = 0, wr_action = 'ONE_TO_CLEAR'),
                csr_reg_field_desc('field_zc0',  width = 1, reset = 0, wr_action = 'ZERO_TO_CLEAR')]))

        self.cfg_reg(csr_reg_group(
            'cfg_res_rw_vol',
            offset = 0x000c,
            size = 4,
            fields_desc = [
                csr_reg_field_desc('field_vol3',  width = 8, access = 'VOL'),
                csr_reg_field_desc('field_rw2',   width = 4, reset = 0),
                csr_reg_field_desc('field_vol1',  width = 3, access = 'VOL'),
                csr_reg_field_desc('field_rw0',   width = 1, reset = 0)]))

        write_flag_reg = reg_r('write_flag_reg')
        write_data_reg = reg('write_data_reg', w = 8)
        def func_write_action(reg_ptr, fire, address, size, wdata, mask_bit):
            with when(fire):
                #set write flag
                flag = write_flag_reg
                flag /= 1

                #store write data
                data = write_data_reg
                data /= wdata[7:0]

                #write this field
                reg_ptr /= wdata[7:0]
            return (1, 1)
        self.cfg_reg(csr_reg_group(
            'cfg_res_write_action',
            offset = 0x0010,
            size = 4,
            fields_desc = [
                csr_reg_field_desc('field_rw3',  width = 8, reset = 0, write = func_write_action),
                csr_reg_field_desc('field_rw2',  width = 4, reset = 0),
                csr_reg_field_desc('field_rw1',  width = 3, reset = 0),
                csr_reg_field_desc('field_rw0',  width = 1, reset = 0)]))

        read_flag = bits('read_flag', init = 0)
        read_data = reg_r('read_data', w = 8, next = self.io.in1)
        def func_read_action(reg_ptr, fire, address, size, mask_bit):
            with when(fire):
                flag = read_flag
                flag /= 1
            return (1, 1, read_data)
        self.cfg_reg(csr_reg_group(
            'cfg_res_read_action',
            offset = 0x0014,
            size = 4,
            fields_desc = [
                csr_reg_field_desc('field_rw3',  width = 8, reset = 0, read = func_read_action),
                csr_reg_field_desc('field_rw2',  width = 4, reset = 0),
                csr_reg_field_desc('field_rw1',  width = 3, reset = 0),
                csr_reg_field_desc('field_rw0',  width = 1, reset = 0)]))
