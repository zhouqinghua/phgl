from phgl_imp import *

class method_cat_top(module):
    def set_port(self):
        super(method_cat_top, self).set_port()

    def main(self):
        super(method_cat_top, self).main()

        a = bits('a', w = 4)
        b = bits('b', w = 4)
        c0 = bits('c0', w = 8)
        c1 = bits('c1', w = 8)
        c2 = bits('c2', w = 8)
        c3 = bits('c3', w = 8)
        c4 = bits('c4', w = 8)
        c5 = bits('c5', w = 8)
        array0 = list(map(lambda _: bits('array0_'+str(_)), range(8)))
        array1 = vec('array1', bits, 8)

        #cat usage
        c0 /= cat([a,b]) #a in msb, b in lsb
        c1 /= cat(list(array0)) #array0[0] in msb, array0[7] in lsb
        c2 /= cat(list(array1)) #array1[0] in msb, array1[7] in lsb

        #cat_rvs usage
        c3 /= cat_rvs([a,b]) #a in lsb, b in msb
        c4 /= cat_rvs(list(array0)) #array0[0] in lsb, array0[7] in msb
        c5 /= cat_rvs(list(array1)) #array1[0] in lsb, array1[7] in msb
