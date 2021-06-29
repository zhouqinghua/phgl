from phgl_imp import *
from .fpga_cell import *

#tmp class inout_pin_io(bundle):
#tmp     def set_par(self):
#tmp         super(inout_pin_io, self).set_par()
#tmp         self.p.par('w', 1)
#tmp 
#tmp     def set_var(self):
#tmp         super(inout_pin_io, self).set_var()
#tmp         self.var(inp('input', w = self.p.w))
#tmp         self.var(outp('output', w = self.p.w))
#tmp         self.var(outp('oe'))
#tmp 
#tmp class inout_pu_pin_io(inout_pin_io):
#tmp     def set_var(self):
#tmp         super(inout_pu_pin_io, self).set_var()
#tmp         self.var(outp('pue'))

class pad_sim_in(module):
    def set_par(self):
        super(pad_sim_in, self).set_par()
        self.p.par('w', 1)

    def set_port(self):
        super(pad_sim_in, self).set_port()
        self.io.var(outp('d', w = self.p.w))
        self.io.var(inp('pad', w = self.p.w))

    def main(self):
        super(pad_sim_in, self).main()
        self.io.d /= self.io.pad

class pad_sim_out(module):
    def set_par(self):
        super(pad_sim_out, self).set_par()
        self.p.par('w', 1)

    def set_port(self):
        super(pad_sim_out, self).set_port()
        self.io.var(inp('d', w = self.p.w))
        self.io.var(outp('pad', w = self.p.w))

    def main(self):
        super(pad_sim_out, self).main()
        self.io.pad /= self.io.d

class pad_sim_inout(module):
    def set_par(self):
        super(pad_sim_inout, self).set_par()
        self.p.par('w', 1)

    def set_port(self):
        super(pad_sim_inout, self).set_port()
        self.io.var(inp('od', w = self.p.w))
        self.io.var(inp('oe'))
        self.io.var(outp('id', w = self.p.w))
        self.io.var(inp('padi', w = self.p.w))
        self.io.var(outp('pado', w = self.p.w))

    def main(self):
        super(pad_sim_inout, self).main()
        self.io.pado /= "%s'hz" % (self.io.pado.get_w())
        with when(self.io.oe):
            self.io.pado /= self.io.od
        self.io.id /= self.io.padi

class pad_sim_pu_inout(pad_sim_inout):
    def set_port(self):
        super(pad_sim_pu_inout, self).set_port()
        self.io.var(inp('pue', w = self.p.w))

    def main(self):
        super(pad_sim_pu_inout, self).main()


class inp_diff_pair(bundle):
    def set_par(self):
        super(inp_diff_pair, self).set_par()
        self.p.par('w', 1)

    def set_var(self):
        super(inp_diff_pair, self).set_var()
        self.var(inp('sig_p', w = self.p.w))
        self.var(inp('sig_n', w = self.p.w))

class outp_diff_pair(bundle):
    def set_par(self):
        super(out_diff_pair, self).set_par()
        self.p.par('w', 1)

    def set_var(self):
        super(outp_diff_pair, self).set_var()
        self.var(outp('sig_p', w = self.p.w))
        self.var(outp('sig_n', w = self.p.w))

class inoutp_diff_pair(bundle):
    def set_par(self):
        super(inoutp_diff_pair, self).set_par()
        self.p.par('w', 1)

    def set_var(self):
        super(inoutp_diff_pair, self).set_var()
        self.var(inoutp('sig_p', w = self.p.w))
        self.var(inoutp('sig_n', w = self.p.w))

class pad_sim_in_diff(module):
    def set_par(self):
        super(pad_sim_in_diff, self).set_par()
        self.p.par('w', 1)

    def set_port(self):
        super(pad_sim_in_diff, self).set_port()
        self.io.var(outp('d', w = self.p.w))
        self.io.var(inp_diff_pair('pad', w = self.p.w))

    def main(self):
        super(pad_sim_in_diff, self).main()
        self.io.d /= self.io.pad.sig_p

class pad_sim_out_diff(module):
    def set_par(self):
        super(pad_sim_out_diff, self).set_par()
        self.p.par('w', 1)

    def set_port(self):
        super(pad_sim_out_diff, self).set_port()
        self.io.var(inp('d', w = self.p.w))
        self.io.var(outp_diff_pair('pad', w = self.p.w))

    def main(self):
        super(pad_sim_out_diff, self).main()
        self.io.pad.sig_p /= self.io.d
        self.io.pad.sig_n /= ~self.io.d

class pad_sim_inout_diff(module):
    def set_par(self):
        super(pad_sim_inout_diff, self).set_par()
        self.p.par('w', 1)

    def set_port(self):
        super(pad_sim_inout_diff, self).set_port()
        self.io.var(inp('od', w = self.p.w))
        self.io.var(inp('oe'))
        self.io.var(outp('id', w = self.p.w))
        self.io.var(inp_diff_pair('padi', w = self.p.w))
        self.io.var(outp_diff_pair('pado', w = self.p.w))

    def main(self):
        super(pad_sim_inout_diff, self).main()
        self.io.pado.sig_p /= "%s'hz" % (self.io.pado.sig_p.get_w())
        self.io.pado.sig_n /= "%s'hz" % (self.io.pado.sig_n.get_w())
        with when(self.io.oe):
            self.io.pado.sig_p /= self.io.od
            self.io.pado.sig_n /= ~self.io.od
        self.io.id /= self.io.padi.sig_p

def bind_pad(pad, d):
    assert(isinstance(pad, (inp, outp, inoutp, inp_diff_pair, outp_diff_pair, inoutp_diff_pair, bundle)))
    if (isinstance(pad, inoutp)):
        assert(isinstance(d, inout_pin_io))
        if (type(d) is inout_pin_io):
            pm = pad_sim_inout(pad.get_full_name()+'_pad', w = pad.get_w())
        elif (type(d) is inout_pu_pin_io):
            pm = pad_sim_pu_inout(pad.get_full_name()+'_pad', w = pad.get_w())
        else:
            assert(0)
        pm.io.od /= d.output
        pm.io.oe /= d.oe
        if (type(d) is inout_pu_pin_io):
            pm.io.pue /= d.pue
        pm.io.padi /= pad
        d.input /= pm.io.id
        pad /= pm.io.pado
    elif (
        (isinstance(pad, inp) and  pad.flipped == 0) or 
        (isinstance(pad, outp) and pad.flipped == 1)):
        pm = pad_sim_in(pad.get_full_name()+'_pad', w = pad.get_w())
        pm.io.pad /= pad
        d /= pm.io.d
    elif (
        (isinstance(pad, outp) and  pad.flipped == 0) or 
        (isinstance(pad, inp) and  pad.flipped == 1)):
        pm = pad_sim_out(pad.get_full_name()+'_pad', w = pad.get_w())
        pm.io.d /= d
        pad /= pm.io.pad
    elif (isinstance(pad, inoutp_diff_pair)):
        assert(isinstance(d, inout_pin_io))
        pm = pad_sim_inout_diff(pad.get_full_name()+'_pad', w = pad.sig_p.get_w())
        pm.io.od /= d.output
        pm.io.oe /= d.oe
        pm.io.padi /= pad
        d.input /= pm.io.id
        pad /= pm.io.pado
    elif (isinstance(pad, inp_diff_pair)):
        pm = pad_sim_in_diff(pad.get_full_name()+'_pad', w = pad.sig_p.get_w())
        pm.io.pad /= pad
        d /= pm.io.d
    elif (isinstance(pad, outp_diff_pair)):
        pm = pad_sim_out_diff(pad.get_full_name()+'_pad', w = pad.sig_p.get_w())
        pm.io.d /= d
        pad /= pm.io.pad
    elif (isinstance(pad, bundle)):
        pm = list(map(lambda _: bind_pad(_, d[_.name]), list(pad)))
    else:
        assert(0), "pad type error"

    return pm

def bind_port(a, b):
    if (isinstance(a, bundle) or isinstance(b, bundle)):
        assert(0)
    elif (isinstance(a, bits)):
        (new_a, a_slc) = a.get_post_slc()
        (new_b, b_slc) = b.get_post_slc()
        #tmp print(new_a.name)
        #tmp print(new_a.parent)
        #tmp print(new_b.name)
        #tmp print(new_b.parent)
        new_a.bio__ = (new_b, b_slc)
        for i in new_b.cmd_q:
            #only comments the same current context's post drive
            if (i.parent is global_sb.current):
                if (i.op != op_type.defi):
                    i.post_t = 1
    else:
        assert(0)

class oddr_sim(module):
    def set_par(self):
        super(oddr_sim, self).set_par()
        self.p.par('w', 1)
        self.p.par('imp_mode', 'sim')
        self.p.par('DDR_CLK_EDGE', "OPPOSITE_EDGE") ## "OPPOSITE_EDGE" or "SAME_EDGE" 
        self.p.par('INIT', 0)    ## Initial value of Q: 1'b0 or 1'b1
        self.p.par('SRTYPE', "SYNC") ## Set/Reset type: "SYNC" or "ASYNC" 

    def set_port(self):
        super(oddr_sim, self).set_port()
        self.io.var(outp('Q', w = self.p.w))  ## 1-bit DDR output
        self.io.var(inp('C'))  ## 1-bit clock input
        self.io.var(inp('CE')) ## 1-bit clock enable input
        self.io.var(inp('D1', w = self.p.w)) ## 1-bit data input (positive edge)
        self.io.var(inp('D2', w = self.p.w)) ## 1-bit data input (negative edge)
        self.io.var(inp('R'))  ## 1-bit reset
        self.io.var(inp('S'))  ## 1-bit set

    def main(self):
        super(oddr_sim, self).main()

        if (self.p.imp_mode == 'fpga'):
            q_array = []
            for i in range(self.p.w):
                oddr = ODDR(
                    'oddr_'+str(i),
                    DDR_CLK_EDGE = "\"%s\"" % (self.p.DDR_CLK_EDGE),
                    INIT = self.p.INIT,
                    SRTYPE = "\"%s\"" %(self.p.SRTYPE))
                oddr.io.C /= self.io.C
                oddr.io.CE /= self.io.CE
                oddr.io.D1 /= self.io.D1[i]
                oddr.io.D2 /= self.io.D2[i]
                oddr.io.R /= self.io.R
                oddr.io.S /= self.io.S
                q_array.append(oddr.io.Q)
            self.io.Q /= cat_rvs(q_array)
        else:
            self.io.Q /= bits(init = self.p.INIT).rep(self.p.w)

            reg_hold = reg(
                'reg_hold',
                w = self.p.w,
                clock = self.io.C,
                clock_edge = 'negedge',
                next = self.io.D1)
            reg_d1 = reg(
                'reg_d1',
                w = self.p.w,
                clock = self.io.C,
                clock_edge = 'posedge',
                next = reg_hold)
            reg_d2 = reg(
                'reg_d2',
                w = self.p.w,
                clock = self.io.C,
                clock_edge = 'negedge' if (self.p.DDR_CLK_EDGE == 'OPPOSITE_EDGE') else 'posedge',
                next = self.io.D2)

            with when(self.io.R):
                reg_d1 /= 0
                reg_d2 /= 0
            with elsewhen(self.io.S):
                reg_d1 /= 2**self.p.w - 1
                reg_d2 /= 2**self.p.w - 1
            with other():
                with when(self.io.CE):
                    self.io.Q /= mux(self.io.C, reg_d1 , reg_d2)

class iddr_sim(module):
    def set_par(self):
        super(iddr_sim, self).set_par()
        self.p.par('w', 1)
        self.p.par('imp_mode', 'sim')
        self.p.par('DDR_CLK_EDGE', "OPPOSITE_EDGE") ## "OPPOSITE_EDGE", "SAME_EDGE" or "SAME_EDGE_PIPELINED"
        self.p.par('INIT_Q1', 0)    ## Initial value of Q1: 1'b0 or 1'b1
        self.p.par('INIT_Q2', 0)    ## Initial value of Q2: 1'b0 or 1'b1
        self.p.par('SRTYPE', "SYNC") ## Set/Reset type: "SYNC" or "ASYNC" 

    def set_port(self):
        super(iddr_sim, self).set_port()
        self.io.var(outp('Q1', w = self.p.w)) ## 1-bit output for positive edge of clock
        self.io.var(outp('Q2', w = self.p.w)) ## 1-bit output for negative edge of clock
        self.io.var(inp('C'))  ## 1-bit clock input
        self.io.var(inp('CE')) ## 1-bit clock enable input
        self.io.var(inp('D', w = self.p.w))  ## 1-bit DDR data input
        self.io.var(inp('R'))  ## 1-bit reset
        self.io.var(inp('S'))  ## 1-bit set


    def main(self):
        super(iddr_sim, self).main()
        if (self.p.imp_mode == 'fpga'):
            q1_array = []
            q2_array = []
            for i in range(self.p.w):
                iddr = IDDR(
                    'iddr_'+str(i),
                    DDR_CLK_EDGE = "\"%s\"" % (self.p.DDR_CLK_EDGE),
                    INITQ1 = self.p.INIT_Q1,
                    INITQ2 = self.p.INIT_Q2,
                    SRTYPE = "\"%s\"" %(self.p.SRTYPE))
                iddr.io.C /= self.io.C
                iddr.io.CE /= self.io.CE
                iddr.io.D /= self.io.D[i]
                iddr.io.R /= self.io.R
                iddr.io.S /= self.io.S
                q1_array.append(iddr.io.Q1)
                q2_array.append(iddr.io.Q2)
            self.io.Q1 /= cat_rvs(q1_array)
            self.io.Q2 /= cat_rvs(q2_array)
        else:
            reg_d_p = reg(
                'reg_d_p',
                w = self.p.w,
                clock = self.io.C,
                clock_edge = 'posedge',
                next = self.io.D)
            reg_d_n = reg(
                'reg_d_n',
                w = self.p.w,
                clock = self.io.C,
                clock_edge = 'negedge',
                next = self.io.D)

            if (self.p.DDR_CLK_EDGE == "OPPOSITE_EDGE"):
                self.io.Q1 /= reg_d_p
                self.io.Q2 /= reg_d_n
            else:
                if (self.p.DDR_CLK_EDGE == "SAME_EDGE"):
                    self.io.Q1 /= reg_d_p
                elif (self.p.DDR_CLK_EDGE == "SAME_EDGE_PIPELINED"):
                    self.io.Q1 /= reg(
                        w = self.p.w,
                        clock = self.io.C,
                        clock_edge = 'posedge',
                        next = reg_d_p)
                else:
                    assert(0)

                self.io.Q2 /= reg(
                    w = self.p.w,
                    clock = self.io.C,
                    clock_edge = 'posedge',
                    next = reg_d_n)
