from phgl_imp import *

class parameter_sram_control_io(bundle):
    def set_par(self):
        super(parameter_sram_control_io)
        self.p.par('address_w', 4)
        self.p.par('data_w', 8)

    def set_var(self):
        super(parameter_sram_control_io, self).set_var()
        self.var(inp('read_en'))
        self.var(inp('write_en'))
        self.var(inp('address', w = self.p.address_w))
        self.var(inp('write_data', w = self.p.data_w))
        self.var(outp('read_data', w = self.p.data_w))

class sram_control_parameters(parameter):
    def set_par(self):
        super(sram_control_parameters, self).set_par()
        self.par('address_w', 4)
        self.par('data_w', 8)

class parameter_sram_control_io_type1(bundle):
    def set_par(self):
        super(parameter_sram_control_io_type1)
        self.p = sram_control_parameters()

    def set_var(self):
        super(parameter_sram_control_io_type1, self).set_var()
        self.var(inp('read_en'))
        self.var(inp('write_en'))
        self.var(inp('address', w = self.p.address_w))
        self.var(inp('write_data', w = self.p.data_w))
        self.var(outp('read_data', w = self.p.data_w))

class parameter_bundle_top(module):
    def set_port(self):
        super(parameter_bundle_top, self).set_port()
        self.io.var(parameter_sram_control_io('sram_ctrl0'))
        self.io.var(parameter_sram_control_io('sram_ctrl1', address_w = 8, data_w = 64))
        self.io.var(parameter_sram_control_io_type1('sram_ctrl2', address_w = 10, data_w = 32))

    def main(self):
        super(parameter_bundle_top, self).main()
