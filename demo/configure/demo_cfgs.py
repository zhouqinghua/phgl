from phgl_imp import *

class cfg_top(configure):
    def set_cfg(self):
        super(cfg_top, self).set_cfg()
        self.cfg_all('configure_top_parameters', 'subm0_num', 4)
        self.cfg_all('configure_top_parameters', 'subm1_num', 5)

class cfg_sub_module(configure):
    def set_cfg(self):
        super(cfg_sub_module, self).set_cfg()
        self.cfg_all('sub_module0_parameters', 'data0_w', 32)
        self.cfg_all('sub_module1_parameters', 'data1_w', 64)

class cfg_instance(configure):
    def set_cfg(self):
        super(cfg_instance, self).set_cfg()
        self.cfg_inst('main.configure_top.md0_0.p', 'data0_w', 32)
        self.cfg_inst('main.configure_top.md1_0.p', 'data1_w', 64)
