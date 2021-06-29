from phgl_imp import *

class seq_logic_top(module):
    def set_port(self):
        super(seq_logic_top, self).set_port()
        self.io.var(inp('in0', w = 8))
        self.io.var(inp('in1', w = 8))
        self.io.var(inp('op', w = 4))
        self.io.var(outp('out_reg', w = 8))
        self.io.var(outp('out_reg_reset', w = 8))
        self.io.var(outp('out_counter', w = 8))

    def main(self):
        super(seq_logic_top, self).main()

        #no reset reg
        tmp_reg = reg(w = 8, next = self.io.in0 & self.io.in1)
        self.io.out_reg /= tmp_reg

        #reset reg
        tmp_reg_reset = reg_r(w = 8, next = self.io.in0 | self.io.in1)
        self.io.out_reg_reset /= tmp_reg_reset

        #counter
        tmp_counter = reg_r(w = 8)
        with when(self.io.op == 1):
            tmp_counter /= tmp_counter + 1
        with elsewhen(self.io.op == 2):
            tmp_counter /= tmp_counter - 1
        with elsewhen(self.io.op == 3):
            tmp_counter /= 0
        self.io.out_counter /= tmp_counter
