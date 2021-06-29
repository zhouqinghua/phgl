from phgl_imp import *

class basic_data_type_io_port_top(module):
    def set_port(self):
        super(basic_data_type_io_port_top, self).set_port()
        self.io.var(inp('in0', w = 8))
        self.io.var(inp('in1', w = 8))
        self.io.var(inp('op', w = 4))
        self.io.var(outp('out0', w = 8))
        self.io.var(inoutp('inout0', w = 8))

    def main(self):
        super(basic_data_type_io_port_top, self).main()

        #output port
        self.io.out0 /= reg(w = 8, next = self.io.in0)

        #inout port
        self.io.inout0 /= "8'hz"
        with when(self.io.op == 0):
            #inout0 as input port
            self.io.out0 /= self.io.inout0
        with other():
            #inout0 as output port
            self.io.inout0 /= self.io.in1
