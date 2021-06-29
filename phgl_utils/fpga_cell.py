from phgl_imp import *

class IBUFDS(module):
    def set_par(self):
        super(IBUFDS, self).set_par()
        self.pm.vuser  = [
            ('code', '//fpga IBUFDS')]

    def set_port(self):
        super(IBUFDS, self).set_port()
        self.no_crg()

        self.io.var(inp('I'))
        self.io.var(inp('IB'))
        self.io.var(outp('O'))

class OBUFDS(module):
    def set_par(self):
        super(OBUFDS, self).set_par()
        self.pm.vuser  = [
            ('code', '//fpga OBUFDS')]

    def set_port(self):
        super(OBUFDS, self).set_port()
        self.no_crg()

        self.io.var(inp('I'))
        self.io.var(outp('O'))
        self.io.var(outp('OB'))

class IOBUFDS(module):
    def set_par(self):
        super(IOBUFDS, self).set_par()
        self.pm.vuser  = [
            ('code', '//fpga IOBUFDS')]

    def set_port(self):
        super(IOBUFDS, self).set_port()
        self.no_crg()

        self.io.var(outp('O'))
        self.io.var(inoutp('IO'))
        self.io.var(inoutp('IOB'))
        self.io.var(inp('I'))
        self.io.var(inp('T'))

class IDELAYCTRL(module):
    def set_par(self):
        super(IDELAYCTRL, self).set_par()
        self.pm.vuser  = [
            ('code', '//fpga IDELAYCTRL')]

    def set_port(self):
        super(IDELAYCTRL, self).set_port()
        self.no_crg()
        self.io.var(outp('RDY'))    ## 1-bit output: Ready output
        self.io.var(inp('REFCLK'))  ## 1-bit input: Reference clock input
        self.io.var(inp('RST'))     ## 1-bit input: Active high reset input


class IDELAYE2(module):
    def set_par(self):
        super(IDELAYE2, self).set_par()
        self.pm.vuser  = [
            ('code', '//fpga IDELAYE2')]
        self.p.par('CINVCTRL_SEL',"\"FALSE\"",vinst = 1)         ## Enable dynamic clock inversion (FALSE, TRUE)
        self.p.par('DELAY_SRC',"\"DATAIN\"",vinst = 1)           ## Delay input (IDATAIN, DATAIN)
        self.p.par('HIGH_PERFORMANCE_MODE',"\"TRUE\"",vinst = 1) ## Reduced jitter ("TRUE"), Reduced power ("FALSE")
        self.p.par('IDELAY_TYPE',"\"VAR_LOAD\"",vinst = 1)       ## FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
        self.p.par('IDELAY_VALUE',0,vinst = 1)                   ## Input delay tap setting (0-31)
        self.p.par('PIPE_SEL',"\"FALSE\"",vinst = 1)             ## Select pipelined mode, FALSE, TRUE
        self.p.par('REFCLK_FREQUENCY',200.0,vinst = 1)           ## IDELAYCTRL clock input frequency in MHz (190.0-210.0, 290.0-310.0).
        self.p.par('SIGNAL_PATTERN',"\"DATA\"",vinst = 1)        ## DATA, CLOCK input signal

    def set_port(self):
        super(IDELAYE2, self).set_port()
        self.no_crg()

        self.io.var(outp('CNTVALUEOUT', w = 5)) ## 5-bit output: Counter value output
        self.io.var(outp('DATAOUT'))            ## 1-bit output: Delayed data output
        self.io.var(inp('C'))                   ## 1-bit input: Clock input
        self.io.var(inp('CE'))                  ## 1-bit input: Active high enable increment/decrement input
        self.io.var(inp('CINVCTRL'))            ## 1-bit input: Dynamic clock inversion input
        self.io.var(inp('CNTVALUEIN', w = 5))   ## 5-bit input: Counter value input
        self.io.var(inp('DATAIN'))              ## 1-bit input: Internal delay data input
        self.io.var(inp('IDATAIN'))             ## 1-bit input: Data input from the I/O
        self.io.var(inp('INC'))                 ## 1-bit input: Increment / Decrement tap delay input
        self.io.var(inp('LD'))                  ## 1-bit input: Load IDELAY_VALUE input
        self.io.var(inp('LDPIPEEN'))            ## 1-bit input: Enable PIPELINE register to load data input
        self.io.var(inp('REGRST'))              ## 1-bit input: Active-high reset tap-delay input



class ODDR(module):
    def set_par(self):
        super(ODDR, self).set_par()
        self.pm.vuser  = [
            ('code', '//fpga ODDR')]
        self.p.par('DDR_CLK_EDGE', "\"OPPOSITE_EDGE\"", vinst = 1) ## "OPPOSITE_EDGE" or "SAME_EDGE" 
        self.p.par('INIT', 0, vinst = 1)    ## Initial value of Q: 1'b0 or 1'b1
        self.p.par('SRTYPE', "\"SYNC\"", vinst = 1) ## Set/Reset type: "SYNC" or "ASYNC" 

    def set_port(self):
        super(ODDR, self).set_port()
        self.no_crg()

        self.io.var(outp('Q'))  ## 1-bit DDR output
        self.io.var(inp('C'))  ## 1-bit clock input
        self.io.var(inp('CE')) ## 1-bit clock enable input
        self.io.var(inp('D1')) ## 1-bit data input (positive edge)
        self.io.var(inp('D2')) ## 1-bit data input (negative edge)
        self.io.var(inp('R'))  ## 1-bit reset
        self.io.var(inp('S'))  ## 1-bit set

class IDDR(module):
    def set_par(self):
        super(IDDR, self).set_par()
        self.pm.vuser  = [
            ('code', '//fpga IDDR')]
        self.p.par('DDR_CLK_EDGE', "\"OPPOSITE_EDGE\"", vinst = 1) ## "OPPOSITE_EDGE", "SAME_EDGE" or "SAME_EDGE_PIPELINED" 
        self.p.par('INIT_Q1', 0, vinst = 1)    ## Initial value of Q1: 1'b0 or 1'b1
        self.p.par('INIT_Q2', 0, vinst = 1)    ## Initial value of Q2: 1'b0 or 1'b1
        self.p.par('SRTYPE', "\"SYNC\"", vinst = 1) ## Set/Reset type: "SYNC" or "ASYNC" 

    def set_port(self):
        super(IDDR, self).set_port()
        self.no_crg()

        self.io.var(outp('Q1')) ## 1-bit output for positive edge of clock
        self.io.var(outp('Q2')) ## 1-bit output for negative edge of clock
        self.io.var(inp('C'))  ## 1-bit clock input
        self.io.var(inp('CE')) ## 1-bit clock enable input
        self.io.var(inp('D'))  ## 1-bit DDR data input
        self.io.var(inp('R'))  ## 1-bit reset
        self.io.var(inp('S'))  ## 1-bit set
