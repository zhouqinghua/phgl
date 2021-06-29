from phgl_imp import *

class comb_logic_top(module):
    def set_port(self):
        super(comb_logic_top, self).set_port()
        self.io.var(inp('in0', w = 8))
        self.io.var(inp('in1', w = 8))
        self.io.var(inp('op', w = 4))
        self.io.var(outp('out_and', w = 8))
        self.io.var(outp('out_or', w = 8))
        self.io.var(outp('out_add', w = 8))
        self.io.var(outp('out_shift', w = 8))
        self.io.var(outp('out_mul_div', w = 8))
        self.io.var(outp('out_mux', w = 8))
        self.io.var(outp('out_complex', w = 8))

    def main(self):
        super(comb_logic_top, self).main()

        #logic and
        self.io.out_and /= self.io.in0 & self.io.in1

        #logic or
        self.io.out_or /= self.io.in0 | self.io.in1

        #add, sub
        self.io.out_add /= self.io.in0 + self.io.in1

        #shift left/right
        self.io.out_shift /= (self.io.in0[3:0] << self.io.in1[1:0]) | (self.io.in1 >> 4)

        #mul/div
        self.io.out_mul_div /= (self.io.in0 * self.io.in1) + (self.io.in0 // self.io.in1[3:0])

        #mux
        self.io.out_mux /= mux(self.io.op[0], self.io.in0, self.io.in1)

        #complex
        tmp_and = self.io.in0 & self.io.in1
        tmp_add = self.io.in0 + self.io.in1
        tmp_shift = self.io.in0[3:0] << 4
        tmp_mul = self.io.in0 * self.io.in1
        self.io.out_complex /= mux(
            self.io.op == 0,
            tmp_and,
            mux(
                self.io.op == 1,
                tmp_add,
                mux(
                    self.io.op == 2,
                    tmp_shift,
                    tmp_mul)))
