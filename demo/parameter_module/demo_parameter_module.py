from phgl_imp import *

class sub_module0(module):
    def set_par(self):
        super(sub_module0, self).set_par()
        self.p.par('addr_w', 4)
        self.p.par('data_w', 8)

    def set_port(self):
        super(sub_module0, self).set_port()
        self.io.var(inp('wr_en'))
        self.io.var(inp('rd_en'))
        self.io.var(inp('address', w = self.p.addr_w))
        self.io.var(inp('write_data', w = self.p.data_w))
        self.io.var(outp('read_data', w = self.p.data_w))

    def main(self):
        super(sub_module0, self).main()

class sub_module1_parameters(parameter):
    def set_par(self):
        super(sub_module1_parameters, self).set_par()
        self.par('addr_w', 4)
        self.par('data_w', 8)

class sub_module1(module):
    def set_par(self):
        super(sub_module1, self).set_par()
        self.p = sub_module1_parameters()

    def set_port(self):
        super(sub_module1, self).set_port()
        self.io.var(inp('wr_en'))
        self.io.var(inp('rd_en'))
        self.io.var(inp('address', w = self.p.addr_w))
        self.io.var(inp('write_data', w = self.p.data_w))
        self.io.var(outp('read_data', w = self.p.data_w))

    def main(self):
        super(sub_module1, self).main()

class parameter_module_top(module):
    def set_port(self):
        super(parameter_module_top, self).set_port()

    def main(self):
        super(parameter_module_top, self).main()

        #sub_module0 instance
        md0 = sub_module0('md0', addr_w = 8, data_w = 32)

        #sub_module1 instance
        md1 = sub_module1('md0', addr_w = 10, data_w = 64)
