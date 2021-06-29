from phgl_imp import *

class bundle0(bundle):
    def set_var(self):
        super(bundle0, self).set_var()
        self.var(bits('op', w = 4))
        self.var(bits('oprand0', w = 32))
        self.var(bits('oprand1', w = 32))
        self.var(bits('resault', w = 32))

class complex_data_type_operator_top(module):
    def set_port(self):
        super(complex_data_type_operator_top, self).set_port()

    def main(self):
        super(complex_data_type_operator_top, self).main()

        tmp0 = bits('tmp0', w = 100, init = 0x10000000055555555aaaaaaaa)
        tmp1 = bits('tmp1', w = 100)
        tmp2 = bits('tmp2', w = 100)
        bd0 = bundle0('bd0')
        bd1 = bundle0('bd1')
        vec0 = vec('vec0', bundle0, 4)
        vec0_idx = bits('vec0_idx', w = 2)


        #bits assign to bundle
        bd0 /= tmp0

        #bits assign from bundle
        tmp1 /= bd0

        #bundle assign from bundle
        bd0 /= bd1

        #bundle pack
        tmp2 /= bd0.pack() & bd1.pack()

        #vec index get
        bd0 /= vec0[0]
        bd1 /= vec0[vec0_idx]

        #vec index set
        vec0[0] /= bd0
        vec0.idx_write(vec0_idx, bd1) #vec0[vec0_idx] /= bd1
