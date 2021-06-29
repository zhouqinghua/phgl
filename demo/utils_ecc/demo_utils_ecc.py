from phgl_imp import *

class sram_control_io(bundle):
    def set_var(self):
        super(sram_control_io, self).set_var()
        self.var(inp('read_en'))
        self.var(inp('write_en'))
        self.var(inp('address', w = 4))
        self.var(inp('write_data', w = 64))
        self.var(outp('read_data', w = 64))

class utils_ecc_top(module):
    def set_port(self):
        super(utils_ecc_top, self).set_port()
        self.io.var(sram_control_io('sram_ctrl'))

    def main(self):
        super(utils_ecc_top, self).main()

        data_width = 64

        parity_code_obj = ecc_code('parity')
        parity_code_width = parity_code_obj.width(data_width)
        mem_parity = vec('mem_parity', reg, n = 16, w = parity_code_width)
        parity_out_data_pre_correct = reg('parity_out_data_pre_correct', w = data_width)
        parity_out_data_post_correct = reg('parity_out_data_post_correct', w = data_width)
        parity_out_error = reg('parity_out_error')
        parity_out_error_uncorrectable = reg('parity_out_error_uncorrectable')
        #parity encode
        with when(self.io.sram_ctrl.write_en):
            mem_parity.idx_write(
                self.io.sram_ctrl.address,
                parity_code_obj.encode(self.io.sram_ctrl.write_data))
        #parity decode
        with when(self.io.sram_ctrl.read_en):
            mem_data = mem_parity[self.io.sram_ctrl.address]
            data_decode = parity_code_obj.decode(mem_data)
            parity_out_data_pre_correct /= data_decode.pre_correct
            parity_out_data_post_correct /= data_decode.post_correct
            parity_out_error /= data_decode.error()
            parity_out_error_uncorrectable /= data_decode.uncorrectable



        ecc_code_obj = ecc_code('secded') # 'secded' or 'sec'
        ecc_code_width = ecc_code_obj.width(data_width)
        mem_ecc = vec('mem_ecc', reg, n = 16, w = ecc_code_width)
        ecc_out_data_pre_correct = reg('ecc_out_data_pre_correct', w = data_width)
        ecc_out_data_post_correct = reg('ecc_out_data_post_correct', w = data_width)
        ecc_out_error = reg('ecc_out_error')
        ecc_out_error_uncorrectable = reg('ecc_out_error_uncorrectable')
        #ecc encode
        with when(self.io.sram_ctrl.write_en):
            mem_ecc.idx_write(
                self.io.sram_ctrl.address,
                ecc_code_obj.encode(self.io.sram_ctrl.write_data))
        #ecc decode
        with when(self.io.sram_ctrl.read_en):
            mem_data = mem_ecc[self.io.sram_ctrl.address]
            data_decode = ecc_code_obj.decode(mem_data)
            ecc_out_data_pre_correct /= data_decode.pre_correct
            ecc_out_data_post_correct /= data_decode.post_correct
            ecc_out_error /= data_decode.error()
            ecc_out_error_uncorrectable /= data_decode.uncorrectable
