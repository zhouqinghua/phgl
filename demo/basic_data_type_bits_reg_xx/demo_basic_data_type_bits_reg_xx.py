from phgl_imp import *

class basic_data_type_bits_reg_xx_top(module):
    def set_port(self):
        super(basic_data_type_bits_reg_xx_top, self).set_port()
        self.io.var(inp('in0', w = 8))
        self.io.var(inp('in1', w = 8))
        self.io.var(inp('op', w = 4))
        self.io.var(outp('out0', w = 8))
        self.io.var(outp('out1', w = 8))
        self.io.var(outp('out2', w = 8))
        self.io.var(outp('out3', w = 8))

    def main(self):
        super(basic_data_type_bits_reg_xx_top, self).main()

        #constant assign direct
        self.io.out0 /= 0x11

        #constant in value
        self.io.out1 /= value(0x11, w = 5)

        #bits
        tmp_bits0 = bits()
        tmp_bits1 = bits(w = 8)
        tmp_bits2 = bits('aaa', w = 8, init = 0xff)
        tmp_bits3 = bits('bbb', w = 8, init = self.io.in0)

        #reg_xx
        tmp_reg       = reg('tmp_reg', w = 8)
        tmp_reg_r     = reg_r('tmp_reg_r', w = 8)
        tmp_reg_s     = reg_s('tmp_reg_s', w = 8)
        tmp_reg_rs    = reg_rs('tmp_reg_s', w = 8, rs = 0x55)
        tmp_reg_en    = reg_en('tmp_reg_en', w = 8, en = self.io.op[0])
        tmp_reg_en_r  = reg_en_r('tmp_reg_en_r', w = 8, en = self.io.op[1])
        tmp_reg_en_s  = reg_en_s('tmp_reg_en_s', w = 8, en = self.io.op[2])
        tmp_reg_en_rs = reg_en_rs('tmp_reg_en_rs', w = 8, rs = 0xaa, en = self.io.op[3])
        with when(self.io.in1 == 1):
            tmp_reg       /= self.io.in0
            tmp_reg_r     /= self.io.in0
            tmp_reg_s     /= self.io.in0
            tmp_reg_rs    /= self.io.in0
            tmp_reg_en    /= self.io.in0
            tmp_reg_en_r  /= self.io.in0
            tmp_reg_en_s  /= self.io.in0
            tmp_reg_en_rs /= self.io.in0
