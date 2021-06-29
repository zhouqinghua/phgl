from phgl_imp import *

class sram_control_io(bundle):
    def set_var(self):
        super(sram_control_io, self).set_var()
        self.var(inp('read_en'))
        self.var(inp('write_en'))
        self.var(inp('address', w = 4))
        self.var(inp('write_data', w = 64))
        self.var(outp('read_data', w = 64))

#4 port sram model
class complex_data_type_vec_top(module):
    def set_port(self):
        super(complex_data_type_vec_top, self).set_port()
        self.io.var(vec('sram_ctrl', sram_control_io, 4))

    def main(self):
        super(complex_data_type_vec_top, self).main()

        mem = vec('mem', lambda _: reg(_, w = 64), 16)

        for i in range(len(self.io.sram_ctrl)):
            #write
            with when(self.io.sram_ctrl[i].write_en):
                mem.idx_write(self.io.sram_ctrl[i].address, self.io.sram_ctrl[i].write_data)

            #read
            with when(self.io.sram_ctrl[i].read_en):
                self.io.sram_ctrl[i].read_data /= mem[self.io.sram_ctrl[i].address]
            with other():
                self.io.sram_ctrl[i].read_data /= 0
