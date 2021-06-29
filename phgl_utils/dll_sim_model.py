import os
from phgl_imp import *
from .fpga_cell import *

class dll_sim(module):
    def set_par(self):
        super(dll_sim, self).set_par()
        self.p.par('imp_mode', 'sim')
        self.p.par('num', 1)
        self.p.par('sp', 'DATA') #DATA or CLOCK
        self.pm.vlib = os.path.split(
            os.path.splitext(__file__)[0])[0]+'/../phgl_vlibs/%s.v' %(
                self.__class__.__name__)
        self.p.par('JITTER', 0.0, vinst = 1)
        self.p.par('DW', 1, vinst = 1)

    def check_par(self):
        super(dll_sim, self).check_par()
        if (self.p.imp_mode != 'sim'):
            self.pm.vlib = None

    def set_port(self):
        super(dll_sim, self).set_port()
        self.no_crg()
        self.io.var(inp('clock_ref'))
        self.io.var(inp('dll_reset'))
        self.io.var(inp('adj', w = 8))
        self.io.var(inp('madj', w = 8))
        self.io.var(inp('data_in', w = self.p.DW))
        self.io.var(outp('clock_out'))
        self.io.var(outp('lock'))
        self.io.var(outp('data_out', w = self.p.DW))

    def main(self):
        super(dll_sim, self).main()
        if (self.p.imp_mode == 'fpga'):
            out_last = []
            for t in range(self.p.num):
                dlys = list(map(lambda _: IDELAYE2('dlys_'+str(_)+'_t'+str(t), SIGNAL_PATTERN = "\"%s\"" % (self.p.sp)), range(self.p.DW)))
                outs = []
                for i in range(self.p.DW):
                    dlys[i].io.C /= self.io.clock_ref
                    dlys[i].io.REGRST /= self.io.dll_reset
                    dlys[i].io.CNTVALUEIN /= (self.io.adj >> 3) #max 32 in FPGA
                    if (t == 0):
                        dlys[i].io.DATAIN /= self.io.data_in[i]
                    else:
                        dlys[i].io.DATAIN /= out_last[t - 1][i]
                    outs.append(dlys[i].io.DATAOUT)

                    dlys[i].io.CE /= 0
                    dlys[i].io.CINVCTRL /= 0
                    dlys[i].io.INC /= 0
                    dlys[i].io.LD /= 1
                    dlys[i].io.LDPIPEEN /= 0
                    dlys[i].io.IDATAIN /= 0
                out_last.append(outs)
            
            self.io.data_out /= cat_rvs(out_last[-1])
