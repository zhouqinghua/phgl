from phgl_imp import *

class sub_module0(module):
    def set_port(self):
        super(sub_module0, self).set_port()
        self.io.var(inoutp('bus0', w = 8))
        self.io.var(inoutp('bus1', w = 8))

    def main(self):
        super(sub_module0, self).main()

class method_pullup_pulldown_top(module):
    def set_port(self):
        super(method_pullup_pulldown_top, self).set_port()

    def main(self):
        super(method_pullup_pulldown_top, self).main()

        md0 = sub_module0('md0')
        pullup(md0.io.bus0)
        pulldown(md0.io.bus1)
