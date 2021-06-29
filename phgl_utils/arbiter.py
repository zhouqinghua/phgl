from phgl_main import *

#folowing classes are rewrite from chisel
#source code coming from: https://github.com/chipsalliance/rocket-chip/chisel3/src/main/scala/chisel3/util/Arbiter.scala
#re-write by python and do some modifications

class arbiter_io(bundle):
    def set_par(self):
        super(arbiter_io, self).set_par()
        self.p.par('gen', None)
        self.p.par('n', None)
        self.p.par('gen_p', None)
    
    def set_var(self):
        super(arbiter_io, self).set_var()
        if (self.p.gen_p is not None):
            self.var(vec(
                'input', 
                gen = lambda _: ready_valid(_, gen = self.p.gen, p = self.p.gen_p).flip(),
                n = self.p.n))
        else:
            self.var(vec(
                'input',
                gen = lambda _: ready_valid(_, gen = self.p.gen).flip(),
                n = self.p.n))
        if (self.p.gen_p is not None):
            self.var(ready_valid('out', gen = self.p.gen, p = self.p.gen_p))
        else:
            self.var(ready_valid('out', gen = self.p.gen))
        self.var(outp('chosen', w = log2_ceil(self.p.n)))

class arbiter_ctrl(object):

    @classmethod
    def apply(self, request):
        assert(isinstance(request, list))
        req_len = len(request)
        if (req_len == 0):
            return []
        elif (req_len == 1):
            return [value(1).to_bits()]
        else:
            tmp_q = [value(1).to_bits(), ~request[0]]
            res = request[0]
            for i in request[1:-1]:
                res = res | i
                tmp_q.append(~res)
            return tmp_q

class locking_arbiter_like(module):
    def set_par(self):
        super(locking_arbiter_like, self).set_par()
        self.p.par('gen', None)
        self.p.par('n', None)
        self.p.par('count', 1)
        self.p.par('needsLock', None)

    def grant(self):
        pass
  
    def set_port(self):
        super(locking_arbiter_like, self).set_port()
        self.io = arbiter_io('io', gen = self.p.gen, n = self.p.n)
    
    def main(self):
        super(locking_arbiter_like, self).main()
        self.choice = bits('choice', w = log2_ceil(self.p.n), init = self.p.n-1)
        self.io.chosen /= self.choice
        self.io.out.valid /= self.io.input[self.io.chosen].valid
        self.io.out.bits /= self.io.input[self.io.chosen].bits
  
        if (self.p.count > 1):
            lockCount = counter('lockCount', n = self.p.count)
            lockIdx = reg('lockIdx', w = log2_ceil(self.p.n))
            locked = lockCount.value != 0
            wantsLock = (
                self.p.needsLock(self.io.out.bits) if (self.p.needsLock is not None) else
                value(1).to_bits())
  
            with when (self.io.out.fire() & wantsLock):
                lockIdx /= self.io.chosen
                lockCount.inc()
  
            with when (locked):
                self.io.chosen /= lockIdx 
            for (in_, (g, i)) in list(zip(
                self.io.input,
                list(zip(self.grant(), range(self.p.n))))):
                in_.ready /= mux(locked, lockIdx == i, g) & self.io.out.ready
        else:
            for (in_, g) in list(zip(self.io.input, self.grant())):
                in_.ready /= g & self.io.out.ready

class locking_rr_arbiter(locking_arbiter_like):
    def main(self):
        lastGrant = reg_en('lastGrant', next = self.io.chosen, en = self.io.out.fire())
        self.grantMask = list(map(
            lambda _: _ > lastGrant,
            range(self.p.n)))
        self.validMask = list(map(
            lambda _: _[0].valid & _[1],
            list(zip(self.io.input, self.grantMask))))
        super(locking_rr_arbiter, self).main()
      
        for i in range(self.p.n-2, -1, -1):
            with when (self.io.input[i].valid):
                self.choice /= i 
        for i in range(self.p.n-1, 0, -1):
            with when (self.validMask[i]):
                self.choice /= i

    def grant(self):
      ctrl = arbiter_ctrl.apply(
            list(map(
                lambda i: self.validMask[i],
                range(self.p.n))) + list(map(
                    lambda _: _.valid,
                    self.io.input)))
      return list(map(
          lambda i: (ctrl[i] & self.grantMask[i]) | ctrl[i + self.p.n],
          range(self.p.n)))
      
class rr_arbiter(locking_rr_arbiter):
    pass

class sp_arbiter(module):
    def set_par(self):
        super(sp_arbiter, self).set_par()
        self.p.par('gen', bits)
        self.p.par('n', 2)
        self.p.par('gen_p', None)

    def set_port(self):
        super(sp_arbiter, self).set_port()
        self.io = arbiter_io('io', gen = self.p.gen, n = self.p.n, gen_p = self.p.gen_p)

    def main(self):
        super(sp_arbiter, self).main()
        self.io.chosen /= self.p.n-1
        self.io.out.bits /= self.io.input[self.p.n-1].bits
        for i in range(self.p.n-2, -1, -1):
            with when (self.io.input[i].valid):
                self.io.chosen /= i
                self.io.out.bits /= self.io.input[i].bits

        grant = arbiter_ctrl.apply(list(map(lambda _: _.valid, self.io.input)))
        for (in_, g) in list(zip(list(self.io.input), grant)):
            in_.ready /= g & self.io.out.ready
        self.io.out.valid /= ~grant[-1] | self.io.input[-1].valid
