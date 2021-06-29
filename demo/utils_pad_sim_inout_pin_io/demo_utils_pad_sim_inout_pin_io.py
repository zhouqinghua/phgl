from phgl_imp import *

class utils_pad_sim_i2c_io(bundle):
    def set_var(self):
        super(utils_pad_sim_i2c_io, self).set_var()
        self.var(inout_pin_io('scl'))
        self.var(inout_pin_io('sda'))

class utils_pad_sim_inout_pin_io_top(module):
    def set_port(self):
        super(utils_pad_sim_inout_pin_io_top, self).set_port()
        self.io.var(utils_pad_sim_i2c_io('i2c'))

    def main(self):
        super(utils_pad_sim_inout_pin_io_top, self).main()

        cnt = reg_r('cnt', w = 4)
        cnt /= cnt + 1
        sda_in_data = reg('sda_in_data')
        self.io.i2c.scl.oe /= 1
        self.io.i2c.sda.oe /= 1
        with when(cnt < 8):
            self.io.i2c.scl.oe /= 1
            self.io.i2c.sda.oe /= 1
            self.io.i2c.sda.output /= cnt[0]
        with other():
            self.io.i2c.scl.oe /= 1
            self.io.i2c.sda.oe /= 0
            sda_in_data /= self.io.i2c.sda.input
