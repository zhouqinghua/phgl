from phgl_imp import *

class bundle0(bundle):
    def set_var(self):
        super(bundle0, self).set_var()
        self.var(bits('op', w = 4))
        self.var(bits('address', w = 4))
        self.var(bits('data', w = 32))

class utils_arbiter_top(module):
    def set_port(self):
        super(utils_arbiter_top, self).set_port()

    def main(self):
        super(utils_arbiter_top, self).main()

        reqs0_valid = list(map(lambda _: reg_r('reqs0_valid_'+str(_)), range(4)))
        reqs0_data = list(map(lambda _: bundle0('reqs0_data_'+str(_)).as_reg(), range(4)))
        arb0_out_valid = reg_r('arb0_out_valid')
        arb0_out_data = bundle0('arb0_out_data').as_reg()

        #instance sp_arbiter and connect it's input/output
        arbiter0 = sp_arbiter('arbiter0', gen = bundle0, n = len(reqs0_valid))
        for i in range(len(reqs0_valid)):
            arbiter0.io.input[i].valid /= reqs0_valid[i]
            arbiter0.io.input[i].bits /= reqs0_data[i]
        arb0_out_valid /= arbiter0.io.out.valid
        arb0_out_data /= arbiter0.io.out.bits
        arbiter0.io.out.ready /= 1 #always accept

        #scan each requset
        for i in range(len(reqs0_valid)):
            with when(arbiter0.io.input[i].fire()):
                reqs0_data[i].address /= reqs0_data[i].address + 1



        reqs1_valid = list(map(lambda _: reg_r('reqs1_valid_'+str(_)), range(4)))
        reqs1_data = list(map(lambda _: bundle0('reqs1_data_'+str(_)).as_reg(), range(4)))
        arb1_out_valid = reg_r('arb1_out_valid')
        arb1_out_data = bundle0('arb1_out_data').as_reg()

        #instance rr_arbiter and connect it's input/output
        arbiter1 = sp_arbiter('arbiter1', gen = bundle0, n = len(reqs1_valid))
        for i in range(len(reqs1_valid)):
            arbiter1.io.input[i].valid /= reqs1_valid[i]
            arbiter1.io.input[i].bits /= reqs1_data[i]
        arb1_out_valid /= arbiter1.io.out.valid
        arb1_out_data /= arbiter1.io.out.bits
        arbiter1.io.out.ready /= 1 #always accept

        #scan each requset
        for i in range(len(reqs1_valid)):
            with when(arbiter1.io.input[i].fire()):
                reqs1_data[i].address /= reqs1_data[i].address + 1
