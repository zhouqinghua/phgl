from phgl_imp import *

class bundle0(bundle):
    def set_var(self):
        super(bundle0, self).set_var()
        self.var(outp('op', w = 4))
        self.var(outp('address', w = 4))
        self.var(outp('data', w = 32))

#request source
class sub_module_source(module):
    def set_port(self):
        super(sub_module_source, self).set_port()
        self.io.var(bundle0('req'))
        self.io.var(outp('aaa'))
        self.io.var(inp('bbb'))

    def main(self):
        super(sub_module_source, self).main()

        self.io.req.op /= 0x1
        self.io.req.address /= 0x5
        self.io.req.data/= 0x12345678

#request sink
class sub_module_sink(module):
    def set_port(self):
        super(sub_module_sink, self).set_port()
        self.io.var(bundle0('req').flip())
        self.io.var(inp('aaa'))
        self.io.var(outp('bbb'))

    def main(self):
        super(sub_module_sink, self).main()

        mem = vec('mem', reg, n = 16, w = 32)
        with when(self.io.req.op == 0x1):
            mem.idx_write(self.io.req.address, self.io.req.data)

class module_top(module):
    def set_port(self):
        super(module_top, self).set_port()
        self.io.var(inp('in0'))
        self.io.var(inp('in1'))
        self.io.var(outp('out'))

    def main(self):
        super(module_top, self).main()
        self.io.out /= self.io.in0 & self.io.in1

        md_source = sub_module_source('md_source')
        md_sink = sub_module_sink('md_sink')
        md_sink.io.req /= md_source.io.req
        md_sink.io.aaa /= md_source.io.aaa
        md_source.io.bbb /= md_sink.io.bbb
