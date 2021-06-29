from phgl_imp import *

class basic_data_type_operator_top(module):
    def set_port(self):
        super(basic_data_type_operator_top, self).set_port()
        self.io.var(inp('in0', w = 8))
        self.io.var(inp('in1', w = 8))
        self.io.var(inp('op', w = 4))
        self.io.var(outp('out', w = 8))

    def main(self):
        super(basic_data_type_operator_top, self).main()

        resaults = bits('resaults', w = 8)

        #assign
        resaults /= 0x55
        #slice assign
        resaults[3:0] /= 0xa

        #1 operand operator
        #invert
        resaults /= ~self.io.in0
        #negtive
        resaults /= -self.io.in0
        #slice get
        resaults /= self.io.in0[3:0]
        #reduction and
        resaults /= self.io.in0.r_and()
        #reduction or
        resaults /= self.io.in0.r_or()
        #reduction xor
        resaults /= self.io.in0.r_xor()

        #2 operand operator
        #add
        resaults /= self.io.in0 + self.io.in1
        #sub
        resaults /= self.io.in0 - self.io.in1
        #multiply
        resaults /= self.io.in0 * self.io.in1
        #divide
        resaults /= self.io.in0 // self.io.in1
        #mode
        resaults /= self.io.in0 % self.io.in1
        #bits and
        resaults /= self.io.in0 & self.io.in1
        #bits or
        resaults /= self.io.in0 | self.io.in1
        #xor
        resaults /= self.io.in0 ^ self.io.in1
        #left shift
        resaults /= self.io.in0 << self.io.in1
        #logic right shift
        resaults /= self.io.in0 >> self.io.in1
        #arithmetic right shift
        resaults /= self.io.in0.as_sint().rshift_a(self.io.in1)
        #power
        resaults /= self.io.in0 ** self.io.in1

        #3 operand operator
        #mux
        resaults /= mux(self.io.op[0], self.io.in0, self.io.in1)

        #logic compare operator
        #equal
        resaults /= self.io.in0 == self.io.in1
        #not equal
        resaults /= self.io.in0 != self.io.in1
        #large
        resaults /= self.io.in0 > self.io.in1
        #little
        resaults /= self.io.in0 < self.io.in1
        #large or equal
        resaults /= self.io.in0 >= self.io.in1
        #little or equal
        resaults /= self.io.in0 <= self.io.in1

