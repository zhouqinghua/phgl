from phgl_imp import *

class bundle0(bundle):
    def set_var(self):
        super(bundle0, self).set_var()
        self.var(bits('op', w = 4))
        self.var(bits('address', w = 4))
        self.var(bits('data', w = 32))

class utils_queue_top(module):
    def set_port(self):
        super(utils_queue_top, self).set_port()

    def main(self):
        super(utils_queue_top, self).main()

        enq_address = reg_r('enq_address', w = 4)
        deq_ready = reg_r('deq_ready')

        fifo0 = queue('fifo0', gen = bundle0, entries = 8)
        fifo0.io.enq.valid /= 1
        fifo0.io.enq.bits.address /= enq_address
        fifo0.io.enq.bits.data /= 0
        fifo0.io.deq.ready /= deq_ready

        with when(fifo0.io.enq.fire()):
            #prepare next enqueue request
            enq_address /= enq_address + 1

        with when(fifo0.io.count > 4):
            deq_ready /= 1
        with other():
            deq_ready /= 0
