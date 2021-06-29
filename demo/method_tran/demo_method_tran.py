from phgl_imp import *

class sub_module0(module):
    def set_port(self):
        super(sub_module0, self).set_port()
        self.io.var(inoutp('bus0', w = 8))
        self.io.var(inoutp('bus1', w = 8))

    def main(self):
        super(sub_module0, self).main()

class sub_module1(module):
    def set_port(self):
        super(sub_module1, self).set_port()
        self.io.var(inoutp('bus0', w = 8))
        self.io.var(inoutp('bus1', w = 8))

    def main(self):
        super(sub_module1, self).main()

class method_tran_top(module):
    def set_port(self):
        super(method_tran_top, self).set_port()

    def main(self):
        super(method_tran_top, self).main()

        md0 = sub_module0('md0')
        md1 = sub_module1('md1')
        #pull up bus0
        pullup(md0.io.bus0)
        pullup(md1.io.bus0)
        #pull down bus1
        pulldown(md0.io.bus1)
        pulldown(md1.io.bus1)
        #connect md0 and md1's 3 state bus
        tran(md0.io.bus0, md1.io.bus0)
        tran(md0.io.bus1, md1.io.bus1)
