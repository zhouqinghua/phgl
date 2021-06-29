from phgl_imp import *

class with_when_top(module):
    def set_port(self):
        super(with_when_top, self).set_port()
        self.io.var(inp('in0', w = 8))
        self.io.var(inp('in1', w = 8))
        self.io.var(inp('op', w = 4))
        self.io.var(outp('out_comb0', w = 8))
        self.io.var(outp('out_comb1', w = 8))
        self.io.var(outp('out_comb2', w = 8))
        self.io.var(outp('out_comb3', w = 8))
        self.io.var(outp('out_comb4', w = 8))
        self.io.var(outp('out_seq0', w = 8))

    def main(self):
        super(with_when_top, self).main()

        #when usage0
        self.io.out_comb0 /= 0
        with when(self.io.op == 1):
            self.io.out_comb0 /= self.io.in0

        #when usage1
        self.io.out_comb1 /= 0
        with when(self.io.op == 1):
            self.io.out_comb1 /= self.io.in0
        with elsewhen(self.io.op == 2):
            self.io.out_comb1 /= self.io.in1

        #when usage2
        self.io.out_comb2 /= 0
        with when(self.io.op == 1):
            self.io.out_comb2 /= self.io.in0
        with elsewhen(self.io.op == 2):
            self.io.out_comb2 /= self.io.in1
        with other():
            self.io.out_comb2 /= 0xff

        #when usage3
        self.io.out_comb3 /= 0
        with when(self.io.op != 0):
            self.io.out_comb3 /= 1
            with when(self.io.op > 4):
                self.io.out_comb3 /= 2
            with elsewhen(self.io.op > 8):
                self.io.out_comb3 /= 3

        #when usage4
        self.io.out_comb4 /= 0
        with when(self.io.op > 0):
            self.io.out_comb4 /= 1
        with when(self.io.op > 8):
            self.io.out_comb4 /= 2

        #when usage5
        tmp_reg = reg(w = 8)
        with when(self.io.op == 1):
            tmp_reg /= self.io.in0
        with elsewhen(self.io.op == 2):
            tmp_reg /= self.io.in1
        self.io.out_seq0 /= tmp_reg
