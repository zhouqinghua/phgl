from phgl_imp import *

class method_vcover_top(module):
    def set_port(self):
        super(method_vcover_top, self).set_port()
        self.io.var(inp('in0'))
        self.io.var(inp('in1'))
        self.io.var(outp('out'))

    def main(self):
        super(method_vcover_top, self).main()

        cnt = reg_r('cnt', w = 8)
        cnt /= cnt + 1
        for i in range(4):
            vcover(self.io.in0 == i, 'input in0 in0 = %h', (self.io.in0), 'cover_in0_is_%d' % (i))
        for i in range(4):
            vcover(cnt == i, 'cnt covered') #auto generate cover name
