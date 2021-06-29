from phgl_imp import *

class utils_dll_sim_top(module):
    def set_port(self):
        super(utils_dll_sim_top, self).set_port()
        self.io.var(inp('in0', w = 8))
        self.io.var(inp('out', w = 8))

    def main(self):
        super(utils_dll_sim_top, self).main()

        clock_delay0 = bits('clock_delay0')
        delay0 = dll_sim('delay0', DW = 8)
        delay0.io.clock_ref /= self.io.clock
        delay0.io.dll_reset /= self.io.reset
        delay0.io.adj /= 64
        delay0.io.data_in /= self.io.in0
        clock_delay0 /= delay0.io.clock_out
        self.io.out /= delay0.io.data_out
