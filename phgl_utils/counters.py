from phgl_main import *

#counter class is rewrite from chisel
#source code coming from: https://github.com/chipsalliance/rocket-chip/chisel3/src/main/scala/chisel3/util/Counter.scala
#re-write by python and do some modifications
class counter(bundle):
    def set_par(self):
        super(counter, self).set_par()
        self.p.par('n', None)
        self.p.par('cond', None)

    def set_var(self):
        super(counter, self).set_var()
        assert(self.p.n >= 0)
        self.var(reg_r(
            'value',
            w = log2_ceil(self.p.n)) if (self.p.n > 1) else bits('value', init = 0))
        self.var(bits('wrap'))
        
        if (self.p.cond is not None):
            with when (self.p.cond):
                wrap = self.inc()
            self.wrap /= self.p.cond & wrap

    def inc(self):
        if (self.p.n > 1):
            wrap = self.value == self.p.n-1
            self.value /= self.value + 1
            if (is_pow_of_2(self.p.n) == 0):
                with when (wrap):
                    self.value /= 0
            return wrap
        else:
            return value(1)

#wide_counter class is rewrite from chisel
#source code coming from: https://github.com/chipsalliance/rocket-chip/src/main/scala/util/Counters.scala
#re-write by python and do some modifications
class wide_counter(bundle):
    def set_par(self):
        self.p.par('width', None)
        self.p.par('reset', 1)

    def set_var(self):
        super(wide_counter, self).set_var()
        if (self.p.reset):
            self.var(reg_r('value', w = self.p.width))
        else:
            self.var(reg('value', w = self.p.width))

    def inc(self, a):
        if isinstance(a, (int, str)):
            inc_a = value(a).to_bits()
        elif isinstance(a, value):
            inc_a = a.to_bits()
        else:
            inc_a = a

        isWide = self.p.width > 2*inc_a.get_w()
        smallWidth = max(
            inc_a.get_w(),
            log2_up(self.p.width)) if (isWide) else self.p.width
        nextSmall = self.value[smallWidth - 1 : 0] + inc_a
        self.value[smallWidth - 1 : 0] /= nextSmall

        if (isWide):
            self.value[self.p.width - 1 : smallWidth] /= mux(
                nextSmall[smallWidth],
                self.value[self.p.width - 1 : smallWidth] + 1,
                self.value[self.p.width - 1 : smallWidth])

        return self
