from phgl_imp import *

class method_vassert_top(module):
    def set_port(self):
        super(method_vassert_top, self).set_port()
        self.io.var(inp('in0'))
        self.io.var(inp('in1'))
        self.io.var(outp('out'))

    def main(self):
        super(method_vassert_top, self).main()

        cnt = reg_r('cnt', w = 8)
        cnt /= cnt + 1
        vassert(self.io.in0 != 0, 'input in0 should not be zero(in0 = %h)', (self.io.in0), 'assert_in0')
        vassert(self.io.out != 0xff, 'input out should not be ff(out = %h)', (self.io.out), 'assert_out')
        vassert(cnt != 0xff, 'cnt should not be ff') #auto generate assert name
