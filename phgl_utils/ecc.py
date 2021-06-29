from phgl_imp import *

#following classes are rewrite from chisel
#source code coming from: https://github.com/chipsalliance/rocket-chip/src/main/scala/util/ECC.scala
#re-write by python and do some modifications
class decoding_bundle(bundle):
    def set_par(self):
        super(decoding_bundle, self).set_par()
        self.p.par('dw', None)

    def set_var(self):
        super(decoding_bundle, self).set_var()
        self.var(bits('pre_correct', w = self.p.dw))
        self.var(bits('post_correct', w = self.p.dw))
        self.var(bits('correctable'))
        self.var(bits('uncorrectable'))
    def error(self):
        return self.correctable | self.uncorrectable

class code_common(bundle):
    def canDetect(self):
        return None
    def canCorrect(self):
        return None

    def width(self, w0):
        return None

    def encode(self, x, poison = 0):
        return None
    def decode(self, x):
        return None

    def swizzle(self, x):
        return None

class identity_code(code_common):
    def canDetect(self):
        return 0
    def canCorrect(self):
        return 0

    def width(self, w0):
        return w0
    def encode(self, x, poison = 0):
        assert(poison == 0), "identity_code can not be poisoned"
        return x
    def swizzle(self, x):
        return x
    def decode(self, y):
        tmp = decoding_bundle(dw = y.get_w())
        tmp.pre_correct /= y
        tmp.post_correct /= y
        tmp.correctable /= 0
        tmp.uncorrectable /= 0
        return tmp

class parity_code(code_common):
    def canDetect(self):
        return True
    def canCorrect(self):
        return False

    def width(self, w0):
        assert(isinstance(w0, int))
        return w0+1
    def encode(self, x, poison = 0):
        return cat([x.r_xor() ^ poison, x])
    def swizzle(self, x):
        return cat([value(0), x])
    def decode(self, y):
        tmp = decoding_bundle(dw = y.get_w())
        tmp.pre_correct /= y[y.get_w()-2:0]
        tmp.post_correct /= tmp.pre_correct
        tmp.correctable /= value(0).to_bits()
        tmp.uncorrectable /= y.r_xor()
        return tmp

class sec_code(code_common):
    def canDetect(self):
        return True
    def canCorrect(self):
        return True

    def poisonous(self, n):
        return not is_pow_of_2(n+1)

    def width(self, k):
        m = log2_floor(k) + 1
        if ((1 << m) < m+k+1):
            return k + m + 1
        else:
            return k + m + 0
    def swizzle(self, x):
        k = x.get_w()
        n = self.width(k)
        return cat([value(0, w = n-k), x])

    def impl(self, n, k):
        assert(n >= 3 and k >= 1 and not is_pow_of_2(n))
        hamm2sys = []
        for i in range(n+1):
            if (i == 0):
                hamm2sys.append(n) #/* undefined */
            elif (is_pow_of_2(i)):
                hamm2sys.append(k + log2_ceil(i))
            else:
                hamm2sys.append(i - 1 - log2_ceil(i))
        sys2hamm = list(map(
            lambda _ : _[1],
            sorted(zip(hamm2sys, range(len(hamm2sys))), key = lambda _: _[0])))
        def syndrome(j):
            bit = 1 << j
            tmp_q = list(map(lambda i : 1 if ((sys2hamm[i] & bit) != 0) else 0, range(n)))
            res = 0
            for i in range(len(tmp_q)):
                res = res + (tmp_q[i] << i)
            return value(res, w = len(tmp_q)).to_bits()
        return (hamm2sys, sys2hamm, syndrome)

    def encode(self, x, poison = 0):
        assert(isinstance(poison, int))
        poison = int(poison)
        k = x.get_w()
        n = self.width(k)
        (_, _, syndrome) = self.impl(n, k)

        assert((isinstance(poison, int) and poison == 0) or self.poisonous(n)), "SEC code of length %d cannot be poisoned" % (n)

        syndromeUInt = cat_rvs(list(map(
            lambda j : (syndrome(j)[k-1: 0] & x).r_xor() ^ poison,
            range(n-k))))
        return cat([syndromeUInt, x])

    def decode(self, y):
        n = y.get_w()
        k = n - log2_ceil(n)
        (_, sys2hamm, syndrome) = self.impl(n, k)

        syndromeUInt = cat_rvs(list(map(lambda j : (syndrome(j) & y).r_xor(), range(n-k))))

        hammBadBitOH = bin2oh(syndromeUInt, n+1)
        sysBadBitOH = cat_rvs(list(map(lambda i : hammBadBitOH[sys2hamm[i]], range(k))))

        tmp = decoding_bundle(dw = k)
        tmp.pre_correct /= y[k-1: 0]
        tmp.post_correct /= tmp.pre_correct ^ sysBadBitOH
        tmp.correctable /= syndromeUInt.r_or()
        tmp.uncorrectable /= (syndromeUInt > n) if (self.poisonous(n)) else value(0).to_bits
        return tmp

class secded_code(code_common):
    def set_var(self):
        super(secded_code, self).set_var()
        self.var(sec_code('sec'))
        self.var(parity_code('par'))

    def canDetect(self):
        return True
    def canCorrect(self):
        return True
  
    def width(self, k):
        return self.sec.width(k)+1
    def encode(self, x, poison = value(0)):
        toggle_lo = cat([poison, poison])
        toggle_hi = toggle_lo << (self.sec.width(x.get_w())-1)
        return self.par.encode(self.sec.encode(x)) ^ toggle_hi
    def swizzle(self, x):
        return self.par.swizzle(self.sec.swizzle(x))
    def decode(self, x):
        secdec = self.sec.decode(x[x.get_w()-2:0])
        pardec = self.par.decode(x)
  
        tmp = decoding_bundle(dw = secdec.pre_correct.get_w())
        tmp.pre_correct /= secdec.pre_correct
        tmp.post_correct /= secdec.post_correct
        tmp.correctable /= pardec.uncorrectable
        tmp.uncorrectable /= ~pardec.uncorrectable & secdec.correctable
        return tmp

def ecc_code(a = 'identity'):
    assert(isinstance('a', str))
    s = a.lower()
    if (s == "identity"):
        return identity_code()
    elif (s == "parity"):
        return parity_code()
    elif (s == "sec"):
        return sec_code()
    elif (s == "secded"):
        return secded_code()
    else:
        assert(0), "Unknown ECC type"
