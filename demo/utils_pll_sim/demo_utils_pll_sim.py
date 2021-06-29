from phgl_imp import *

class sub_module(module):
    def set_port(self):
        super(sub_module, self).set_port()
        self.io.var(inp('in0'))
        self.io.var(outp('out'))

    def main(self):
        super(sub_module, self).main()

        self.io.out /= reg(next = self.io.in0)


class utils_pll_sim_top(module):
    def set_port(self):
        super(utils_pll_sim_top, self).set_port()

    def main(self):
        super(utils_pll_sim_top, self).main()

        #X2 clock
        pll0 = pll_sim('pll0')
        pll0.io.clock_ref /= self.io.clock
        pll0.io.bypass /= 0
        pll0.io.mul /= 2
        md0 = sub_module('md0')
        md0.io.clock /= pll0.io.clock_out

        #X4 clock
        pll1 = pll_sim('pll1')
        pll1.io.clock_ref /= self.io.clock
        pll1.io.bypass /= 0
        pll1.io.mul /= 4
        md1 = sub_module('md1')
        md1.io.clock /= pll1.io.clock_out
