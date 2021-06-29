from phgl_imp import *

class bundle0(bundle):
    def set_var(self):
        super(bundle0, self).set_var()
        self.var(bits('op', w = 4))
        self.var(bits('address', w = 4))
        self.var(bits('data', w = 32))

class method_sel_top(module):
    def set_port(self):
        super(method_sel_top, self).set_port()

    def main(self):
        super(method_sel_top, self).main()

        s = bits('s', w = 2)
        a = bits('a', w = 8)
        b = bits('b', w = 8)
        c = bits('c', w = 8)
        d = bits('d', w = 8)

        resault0 = bits('resault0', w = 8)
        #bin select from independent bits
        resault0 /= sel_bin(s, [a,b,c,d])

        array0 = list(map(lambda _: bits('array0_'+str(_)), range(4)))
        resault1 = bits('resault1', w = 8)
        #bin select from array
        resault1 /= sel_bin(s, list(array0))

        vec0 = vec('vec0', bits, n = 4, w = 8)
        resault2 = bits('resault2', w = 8)
        #bin select from vec
        resault2 /= sel_bin(s, list(vec0))

        bd_array0 = list(map(lambda _: bundle0('bd_array0_'+str(_)), range(4)))
        resault3 = bundle0('resault3')
        #bin select from bundle array
        resault3 /= sel_bin(s, list(bd_array0))

        #onehot select
        s_oh = bin2oh(s)
        resault4 = bits('resault4', w = 8)
        resault4 /= sel_oh(s_oh, [a,b,c,d])

        #sel_map
        s_key = bits('s_key', w = 10)
        map_tab = [(0, a), (2, b), (3, c), (5, d)]
        resault5 = bits('resault5', w = 8)
        resault5 /= sel_map(s_key, map_tab, 0)
