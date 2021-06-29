from phgl_imp import *

class bundle0(bundle):
    def set_var(self):
        super(bundle0, self).set_var()
        self.var(bits('op', w = 4))
        self.var(bits('address', w = 4))
        self.var(bits('data', w = 32))

class utils_async_queue_top(module):
    def set_port(self):
        super(utils_async_queue_top, self).set_port()
        self.io.var(inp('enq_clock'))
        self.io.var(inp('enq_reset'))
        self.io.var(inp('deq_clock'))
        self.io.var(inp('deq_reset'))
        self.io.var(inp('flush'))

    def main(self):
        super(utils_async_queue_top, self).main()

        enq_address = reg_r('enq_address', w = 4, clock = self.io.enq_clock, reset = self.io.enq_reset)
        deq_ready = reg_r('deq_ready', clock = self.io.deq_clock, reset = self.io.deq_reset)

        fifo0 = async_queue('fifo0', gen = bundle0, entries = 8, flush_en = 1)
        fifo0.io.enq_clock /= self.io.enq_clock
        fifo0.io.enq_reset /= self.io.enq_reset
        fifo0.io.enq.valid /= 1
        fifo0.io.enq.bits.address /= enq_address
        fifo0.io.enq.bits.data /= 0
        fifo0.io.deq_clock /= self.io.deq_clock
        fifo0.io.deq_reset /= self.io.deq_reset
        fifo0.io.deq.ready /= deq_ready
        fifo0.io.flush /= self.io.flush

        with when(fifo0.io.enq.fire()):
            #prepare next enqueue request
            enq_address /= enq_address + 1

        deq_ready /= 1
