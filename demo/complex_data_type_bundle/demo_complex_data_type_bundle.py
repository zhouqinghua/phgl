from phgl_imp import *

class sram_control_io(bundle):
    def set_var(self):
        super(sram_control_io, self).set_var()
        self.var(inp('read_en'))
        self.var(inp('write_en'))
        self.var(inp('address', w = 4))
        self.var(inp('write_data', w = 64))
        self.var(outp('read_data', w = 64))

#simple sram model
class complex_data_type_bundle_top(module):
    def set_port(self):
        super(complex_data_type_bundle_top, self).set_port()
        self.io.var(sram_control_io('sram_ctrl'))

    def main(self):
        super(complex_data_type_bundle_top, self).main()

        mem = list(map(lambda _: reg('mem_'+str(_), w = 64), range(2**4)))

        for i in range(len(mem)):
            #address decode
            with when(self.io.sram_ctrl.address == i):
                #write
                with when(self.io.sram_ctrl.write_en):
                    mem[i] /= self.io.sram_ctrl.write_data
                #read
                with elsewhen(self.io.sram_ctrl.read_en):
                    self.io.sram_ctrl.read_data /= mem[i]
                #no read, no write
                with other():
                    self.io.sram_ctrl.read_data /= 0
