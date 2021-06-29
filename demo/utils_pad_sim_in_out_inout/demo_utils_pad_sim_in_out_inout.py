from phgl_imp import *

class utils_pad_sim_i2c_io(bundle):
    def set_var(self):
        super(utils_pad_sim_i2c_io, self).set_var()
        self.var(inout_pin_io('scl'))
        self.var(inout_pin_io('sda'))

class utils_pad_sim_i2c_pad(bundle):
    def set_var(self):
        super(utils_pad_sim_i2c_pad, self).set_var()
        self.var(inoutp('scl'))
        self.var(inoutp('sda'))

class utils_pad_sim_uart_io(bundle):
    def set_var(self):
        super(utils_pad_sim_uart_io, self).set_var()
        self.var(outp('tx'))
        self.var(inp('rx'))

class utils_pad_sim_uart_pad(bundle):
    def set_var(self):
        super(utils_pad_sim_uart_pad, self).set_var()
        self.var(outp('tx'))
        self.var(inp('rx'))

class utils_pad_sim_core_module(module):
    def set_port(self):
        super(utils_pad_sim_core_module, self).set_port()
        self.io.var(utils_pad_sim_i2c_io('i2c'))
        self.io.var(utils_pad_sim_uart_io('uart'))

    def main(self):
        super(utils_pad_sim_core_module, self).main()

class utils_pad_sim_in_out_inout_top(module):
    def set_port(self):
        super(utils_pad_sim_in_out_inout_top, self).set_port()
        self.io.var(utils_pad_sim_i2c_pad('i2c'))
        self.io.var(utils_pad_sim_uart_pad('uart'))

    def main(self):
        super(utils_pad_sim_in_out_inout_top, self).main()

        core = utils_pad_sim_core_module('core')

        bind_pad(self.io.uart, core.io.uart)
        bind_pad(self.io.i2c, core.io.i2c)
