from phgl_imp import *

class sub_module0_parameters(parameter):
    def set_par(self):
        super(sub_module0_parameters, self).set_par()
        self.par('addr0_w', 4)
        self.par('data0_w', 8)

class sub_module0(module):
    def set_par(self):
        super(sub_module0, self).set_par()
        self.p = sub_module0_parameters()

    def set_port(self):
        super(sub_module0, self).set_port()
        self.io.var(inp('wr_en'))
        self.io.var(inp('rd_en'))
        self.io.var(inp('address', w = self.p.addr0_w))
        self.io.var(inp('write_data', w = self.p.data0_w))
        self.io.var(outp('read_data', w = self.p.data0_w))

class sub_module1_parameters(parameter):
    def set_par(self):
        super(sub_module1_parameters, self).set_par()
        self.par('addr1_w', 8)
        self.par('data1_w', 16)

class sub_module1(module):
    def set_par(self):
        super(sub_module1, self).set_par()
        self.p = sub_module1_parameters()

    def set_port(self):
        super(sub_module1, self).set_port()
        self.io.var(inp('wr_en'))
        self.io.var(inp('rd_en'))
        self.io.var(inp('address', w = self.p.addr1_w))
        self.io.var(inp('write_data', w = self.p.data1_w))
        self.io.var(outp('read_data', w = self.p.data1_w))

class configure_top_parameters(parameter):
    def set_par(self):
        super(configure_top_parameters, self).set_par()
        self.par('subm0_num', 2)
        self.par('subm1_num', 3)

class configure_top(module):
    def set_par(self):
        super(configure_top, self).set_par()
        self.p = configure_top_parameters()

    def set_port(self):
        super(configure_top, self).set_port()

    def main(self):
        super(configure_top, self).main()

        #sub_module0 instance
        md0_array = list(map(lambda _: sub_module0('md0_'+str(_)), range(self.p.subm0_num)))

        #sub_module1 instance
        md1_array = list(map(lambda _: sub_module1('md1_'+str(_)), range(self.p.subm1_num)))
