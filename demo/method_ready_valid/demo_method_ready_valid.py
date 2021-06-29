from phgl_imp import *

class bundle0(bundle):
    def set_var(self):
        super(bundle0, self).set_var()
        self.var(bits('op', w = 4))
        self.var(bits('address', w = 4))
        self.var(bits('data', w = 32))

#request source
class sub_module_source(module):
    def set_port(self):
        super(sub_module_source, self).set_port()
        self.io.var(ready_valid('req', bundle0))

    def main(self):
        super(sub_module_source, self).main()

        addr_cnt = reg_r('addr_reg', w = 4)
        self.io.req.valid /= 1
        self.io.req.bits.op /= 0x1
        self.io.req.bits.address /= addr_cnt
        self.io.req.bits.data/= 0x12345678

        with when(self.io.req.fire()):
            addr_cnt /= addr_cnt + 1

#request sink
class sub_module_sink(module):
    def set_port(self):
        super(sub_module_sink, self).set_port()
        self.io.var(ready_valid('req', bundle0).flip())

    def main(self):
        super(sub_module_sink, self).main()

        mem = vec('mem', reg, n = 16, w = 32)
        with when(self.io.req.fire()):
            with when(self.io.req.bits.op == 0x1):
                mem.idx_write(self.io.req.bits.address, self.io.req.bits.data)
        self.io.req.ready /= reg_r(next = self.io.req.valid)


class method_ready_valid_top(module):
    def set_port(self):
        super(method_ready_valid_top, self).set_port()

    def main(self):
        super(method_ready_valid_top, self).main()

        md_source = sub_module_source('md_source')
        md_sink = sub_module_sink('md_sink')
        md_sink.io.req /= md_source.io.req
