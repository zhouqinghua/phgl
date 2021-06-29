import os
from phgl_imp import *

class pll_sim(module):
    def set_par(self):
        super(pll_sim, self).set_par()
        self.pm.vlib = os.path.split(
            os.path.splitext(__file__)[0])[0]+'/../phgl_vlibs/%s.v' %(
                self.__class__.__name__)
        self.p.par('JITTER', 0.0, vinst = 1)
        self.p.par('DUTY', 0.5, vinst = 1)

    def set_port(self):
        super(pll_sim, self).set_port()
        self.no_crg()
        self.io.var(inp('clock_ref'))
        self.io.var(inp('bypass'))
        self.io.var(inp('mul', w = 8))
        self.io.var(outp('clock_out'))
        self.io.var(outp('lock'))
