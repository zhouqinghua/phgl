from phgl_imp import *

class sub_module0(module):
    def set_port(self):
        super(sub_module0, self).set_port()
        self.io.var(inp('in0', w = 8))
        self.io.var(outp('out', w = 8))

    def main(self):
        super(sub_module0, self).main()

        self.io.out /= reg(w = 8, next = self.io.in0)

class sub_module1(module):
    def set_port(self):
        super(sub_module1, self).set_port()
        self.io.var(inp('in0', w = 8))
        self.io.var(outp('out', w = 8))

    def main(self):
        super(sub_module1, self).main()

        self.io.out /= reg(w = 8, next = self.io.in0)

class utils_clock_divider_sim_top(module):
    def set_port(self):
        super(utils_clock_divider_sim_top, self).set_port()

    def main(self):
        super(utils_clock_divider_sim_top, self).main()

        md0 = sub_module0('md0')
        clk_div0 = clock_divider_sim('clk_div0', JITTER = 0.1)
        clk_div0.io.clock_ref /= self.io.clock
        clk_div0.io.div /= 2
        md0.io.clock /= clk_div0.io.clock_out

        md1 = sub_module1('md1')
        clk_div1 = clock_divider_sim('clk_div1', JITTER = 0.2, DUTY = 0.6)
        clk_div1.io.clock_ref /= self.io.clock
        clk_div1.io.div /= 4
        md1.io.clock /= clk_div1.io.clock_out
