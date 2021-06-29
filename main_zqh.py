import sys
import os
import copy
from phgl_imp import *
from itertools import groupby
import inspect
from collections import Iterable, Iterator

#tmp class com_ready_valid(bundle):
#tmp     def set_var(self):
#tmp         #self.inp("clk")
#tmp         #self.inp("rst_n")
#tmp         self.var(inp("ready"))
#tmp         self.var(outp("valid"))
#tmp 
#tmp class com_ready_valid_data(com_ready_valid):
#tmp     def set_var(self):
#tmp         super(com_ready_valid_data,self).set_var()
#tmp         self.var(outp("data"))

class module_sub0(module):
    def set_port(self):
        super(module_sub0, self).set_port()
        #self.io.inp("clk")
        #self.io.inp("rst_n")
        #self.io.var(com_ready_valid("READY_VALID"))
        #self.io.var(com_ready_valid_data("READY_VALID_DATA"))
        self.io.var(inp("in0",w = 8))
        self.io.var(outp("out0", w = 8))

        #self.inst_port(com_ready_valid("READY_VALID"))
        #self.io.port(com_ready_valid("READY_VALID"))
    def main(self):
        super(module_sub0, self).main()
        a = reg('a')
        b = reg('b')
        a /= self.io.in0[0]
        b /= self.io.in0[1]

class module_sub1(module):
    def set_port(self):
        super(module_sub1, self).set_port()

    def main(self):
        super(module_sub1, self).main()
        r0 = reg("r0", w = 8)
        r1 = reg("r1", w = 8)

class module_subp(module):
    def set_port(self):
        super(module_subp, self).set_port()

    def main(self):
        super(module_subp, self).main()

class unit_test0(unit_test):

    def main(self):
        super(unit_test0, self).main()
        dut = queue('dut', gen = lambda _: bits(_, w = 64), entries = 8)

        intf_in = ready_valid('intf_in', gen = lambda _: bits(_, w = 64)).as_bits()
        intf_out = ready_valid('intf_out', gen = lambda _: bits(_, w = 64)).as_bits()
        dut.io.enq /= intf_in
        intf_out /= dut.io.deq

        exp_q = vlist('exp_q', w = 64)

        #driver
        driver_pkt_cnt = bits('driver_pkt_cnt', w = 64)
        driver_finish = bits('driver_finish')
        with vinitial():
            driver_pkt_cnt /= 0
            driver_finish /= 0

            #initial input
            intf_in.valid /= 0
            intf_out.ready /= 0

            #wait reset done
            wait(~self.reset)
            step(5)

            intf_out.ready /= 1
            #driver to dut
            with vwhile(driver_pkt_cnt < self.p.pkt_num):
                intf_in.valid /= 1
                #intf_in.bits /= driver_pkt_cnt
                intf_in.bits /= urandom(w = 64)
                step(1)
                stall(~intf_in.fire())
                vprintln("dut in: %x", intf_in.bits)
                exp_q.append(intf_in.bits)
                intf_in.valid /= 0
                driver_pkt_cnt /= driver_pkt_cnt + 1

            driver_finish /= 1

        #monitor and checker
        monitor_pkt_cnt = bits('monitor_pkt_cnt', w = 64)
        monitor_finish = bits('monitor_finish')
        with vinitial():
            monitor_pkt_cnt /= 0
            monitor_finish /= 0

            wait(~self.reset)

            with vwhile(monitor_pkt_cnt < self.p.pkt_num):
                with vif(intf_out.fire()):
                    vassert(intf_out.bits == exp_q.pop(), name = 'queue_out_bits')
                    monitor_pkt_cnt /= monitor_pkt_cnt + 1
                step(1)

            monitor_finish /= 1

        #finish
        with vinitial():
            wait(~self.reset)

            wait(driver_finish & monitor_finish)
            step(10)
            finish()

class module_test(module):

    def set_port(self):
        super(module_test, self).set_port()
        #self.io.inp("clk")
        #self.io.inp("rst_n")
        self.io.var(inp("in0", w = 8))
        self.io.var(outp("out0",w = 8))
        #self.io.var(valid("out_test0", bits(w = 8)))
        #self.io.var(ready_valid("out_test1", bits(w = 8)))
        #self.io.var(valid("out_test2", lambda _: bits(_, w = 8)))
        #self.io.var(ready_valid("out_test3", bits, w = 8))

    def main(self):
        super(module_test, self).main()
####        w0 = bits("w0",7,0)
####        w1 = bits("w1",7,0)
####        w2 = bits("w2",7,0)
####        w3 = bits("w3",7,0)
####        wn0 = bits("wn0",7,0)
####        wn1 = bits("wn1",7,0)
####        wn2 = bits("wn2",7,0)
####
####        w0 /= 10 + wn0 + wn0
####        w1 /= 11 + wn0 + wn0
####        w2 /= 12 + wn0 + wn0
####        w3 /= 13 + wn0 + wn0

####        sub0 = module_sub0("sub0")
####        wn1 /= sub0.io.out0 + 222
####        self.io.out0 /= sub0.io.out0 + 222
####        self.io.out0 /= self.io.in0 & 111
####        sub0.io.in0 /= sub0.io.out0
####        sub0.io.in0 /= sub0.io.out0 + wn0
####        sub0.io.in0 /= sub0.io.out0 + self.io.in0
####        self.io.out0 /= mux(w0 == 1, wn0, sub0.io.out0 == 1)
####        sub0.io.in0 /= mux(sub0.io.out0 == 1, w1, self.io.out0 == 1)
####        self.io.out0[7:0] /= w0[3:0] + sub0.io.out0[3:0]
####        with if0(w0 == w1):
####            self.io.out0 /= self.io.in0 + 222
####            self.io.out0 /= sub0.io.in0 + 222
####            self.io.out0[7:0] /= w0[3:0] + sub0.io.out0[3:0]
####        with else0():
####            self.io.out0 /= self.io.in0 + 333
####            self.io.out0 /= sub0.io.in0 + 222
####
####        sub1 = module_sub0("sub1")
####        self.io.out0 /= sub1.io.out0 + 333
####
####        sub0 = module_sub0("sub0")
####        self.io.out0 /= sub0.io.out0 + 0x333
####        sub0.io.in0 /= w0 + 1
####        sub0.io.READY_VALID.ready /= w1 + 1
####        sub0.io.READY_VALID_DATA.ready /= w1 + 1
####        self.io.out0 /= sub0.io.READY_VALID_DATA.valid + sub0.io.READY_VALID_DATA.data
####        #sub0.io.ready /= w1 + 1
####
####        sub1 = module_sub1("sub1", w = 8)
####        self.io.out0 /= sub1.io.z. & 0x111
####        sub1.io.x. /= w1 + 1

#        subpn = {}
#        for i in range(10):
#            subpn[i] = module_subp("subpn"+str(i), w = i)
#            self.io.out0 /= subpn[i].io.out0 & i

####        with if0((w1[3] & w2[7]) == (w1[1:0] == w2[3:2])):
####            wn0 /= w0 + 1
####            wn0[3:0] /= w0[7:0] & wn0[7:4]
####            #subp1.io.in0 /= w1 + 1
####            with if0(0):
####                wn0 /= w0 + 1
####            with else0():
####                wn1 /= w0 + 2
####                wn1[3:0] /= w0[7:0] & wn1[7:4]
####        with else0():
####            wn1 /= w0 + 2
####            wn1[3:0] /= w0[7:0] & wn1[7:4]
####
####        self.io.out0 /= w0 + w1



####        wn0 /= w0 + w1
####
####        #w0.v = 10
####        #w1.v = 11
####        #w2 = w2(0 + 1)
####        #wn0 /= w0 + w1 + w2
####        #wn1 /= w0 & w1 & w2
####        #wn1 /= w0 + (w1 & ~w2)
####        #wn0 /= w0 == w1
####        #if (w0 == w1):
####        #for cond in [(w0 == w1)]:
####        #    wn0 /= w0 + w1
####        #else:
####        #    wn0 /= w0 & w1
####        
####        #with when(w0 == w1):
####        #    with when(w1 == w2):
####        #        wn0 /= (w0 & w1)
####        #    with elsewhen():
####        #        wn0 /= 10
####        #    wn1 /= 0
####        #with elsewhen():
####        #    w0 /= 0
####        #    with when(w1 == w2):
####        #        wn1 /= (w0 & w1)
####        #    with elsewhen():
####        #        wn1 /= 11
####
####        with if0((w0 == 1) & (w0 == wn1)):
####            wn0 /= w0 + w1
####            with if0(w1 == 1):
####                wn0 /= w0 & w1
####                with if0(w1 == 2):
####                    wn0 /= w0 & w1
####                with else0():
####                    #wn0 /= w0 + w1
####                    wn0 /= mux(w1 == 3,w0,w1)
####            with else0():
####                wn0 /= w0 + w1
####            w2 /= w0 + w1
####        with else0():
####            wn0 /= 444
####            with if0(w1 == 2):
####                wn0 /= w0 & w1
####            with else0():
####                wn0 /= w0 + w1
####
####        wn2 /= wn1 + wn0 & wn1 + (wn0 == wn1) + ~(wn0 + 10)
####
####        r0 = reg("r0",7,0)
####        r1 = reg_r("r1",7,0)
####        r2 = reg_s("r2",7,0)
####        r3 = reg_rs("r3",0,7,0)
####        rn0 = reg("rn0",7,0)
####        rn1 = reg_r("rn1",7,0)
####        rn2 = reg_s("rn2",7,0)
####        rn3 = reg_rs("rn3",1,7,0)
####
####        r0 /= w0 + 1
####        r1 /= w0 + w1
####        r2 /= w0 & w1
####        r3 /= w0 & 13
####
####        tmp = r0 + r1 + r2 + r3
####        rn0 /= tmp + r1
####        rn1 /= tmp & r1
####        rn2 /= tmp + r1
####        rn3 /= tmp & r1
####
####        #rn0 /= r0 + r1
####        #rn1 /= r0
####        with if0(w0 == 0):
####            rn0 /= w1
####        with else0():
####            rn0 /= w1 + 1
####            rn1 /= mux(w0 == 1,w1,r1)
####            rn1 /= mux(r0 == 1,w1,r1)
####            rn1 /= mux(r0 == 1,r0,r1)
####            rn1 /= mux(r0 == 1,r0 + 1,r1 + 1)
####
####        m0 = bits("m0",7,0)
####        m1 = bits("m1",7,0)
####        m2 = bits("m2",7,0)
####        m3 = bits("m3",7,0)
####        m4 = bits("m4",7,0)
####        m5 = bits("m5",7,0)
####        m0 /= mux(w0, wn1, wn2)
####        m1 /= mux(w0, wn1, 1)
####        m2 /= mux(w0, 2, wn2)
####        m3 /= mux(w0, 2, 1)
####        m4 /= mux(1, wn1, wn2)
####        #m5 /= mux(w0 == 0, w1 + wn2, w2 + w3)
####        m5 /= mux(w0 == 0, w1 + w2, mux(w1 == 1, w1 & w2, ~w3))
####
####        self.io.out0 /= rn1 + self.io.in0
####        self.io.out0 /= rn2
####
####
####        wt0 = bits("wt0",7,0)
####        wt1 = bits("wt1",7,0)
####        wt0 /= 1111
####        #wt0[0]
####        #wt0[7]
####        #wt0[7:0:1]
####
####        wn1[7:4] /= w0 + w1
        #wn1 /= w1 + w2
        #wn1[7] /= w1 + w2

        #wn1 /= w0[7:0] + w1[3:0]
        #wn1 /= w0 + w2
        #wn1[3:0] /= wn1[1:0] + w0
        #wn1 /= wn1[1:0] + w1[7:0] + w1[0]
        #wn1[7:0] /= wn1[1:0] + wn1[2:1]
        #wn2 /= wn1[1:0] + wn1[2:1] + wn1[7]
        #wn2[7:0] /= wn2[1:0] + wn1[3:2] + wn2[2]
        #wn2 /= wn2[1:0] + wn1[3:2] + wn2[2]
        #wn2[7] /= wn2[0]
####        wn2[7:0] /= mux(wn2[3:0] == 0, wn1[3:0], mux(wn2[3:0],wn1[3:1],wn1[3:2]))

####        www0 = bits('www0',7,0)
####        www1 = bits('www1',7,0)
####        www2 = bits('www2',7,0)
####
####        ##www2 /= www0 + www1
####        ##www2 /= www0 - www1
####        ##www2 /= www0 * www1
####        ##www2 /= www0 / www1
####        ##www2 /= www0 % www1
####        ##www2 /= www0 ** www1
####        ##www2 /= www0 << www1
####        ##www2 /= www0 >> www1
####        ##www2 /= www0 & www1
####        ##www2 /= www0 ^ www1
####        ##www2 /= www0 | www1
####        ##www2 /= www0 == www1
####        ##www2 /= www0 != www1
####        ##www2 /= www0 > www1
####        ##www2 /= www0 < www1
####        ##www2 /= www0 >= www1
####        ##www2 /= www0 <= www1
####        ##www2 /= ~www0
####
####        ##www2 /= www0 + 1
####        ##www2 /= www0 - 1
####        ##www2 /= www0 * 1
####        ##www2 /= www0 / 1
####        ##www2 /= www0 % 1
####        ##www2 /= www0 ** 1
####        ##www2 /= www0 << 1
####        ##www2 /= www0 >> 1
####        ##www2 /= www0 & 1
####        ##www2 /= www0 ^ 1
####        ##www2 /= www0 | 1
####        ##www2 /= www0 == 1
####        ##www2 /= www0 != 1
####        ##www2 /= www0 > 1
####        ##www2 /= www0 < 1
####        ##www2 /= www0 >= 1
####        ##www2 /= www0 <= 1
####
####        www2 /= 1 +  www0
####        www2 /= 1 -  www0
####        www2 /= 1 *  www0
####        www2 /= 1 /  www0
####        www2 /= 1 %  www0
####        www2 /= 1 ** www0
####        www2 /= 1 << www0
####        www2 /= 1 >> www0
####        www2 /= 1 &  www0
####        www2 /= 1 ^  www0
####        www2 /= 1 |  www0
####        www2 /= 1 == www0
####        www2 /= 1 != www0
####        www2 /= 1 >  www0
####        www2 /= 1 <  www0
####        www2 /= 1 >= www0
####        www2 /= 1 <= www0
####
####        www2 /= mux(www0 == 0xff,0,1,w = www2.get_w())
####        www2 /= www0.rshift_a(5)
####
####        rrr0 = reg("rrr0",7,0)
####        rrr1 = reg_r("rrr1",7,0)
####        rrr2 = reg_s("rrr2",7,0)
####        rrr3 = reg_rs("rrr3",0x55,7,0)
####
####        ren0 = reg_en("ren0",7,0)
####        ren1 = reg_en_r("ren1",7,0)
####        ren2 = reg_en_s("ren2",7,0)
####        ren3 = reg_en_rs("ren3",7,0)
####
####        ren0 /= w0 + w1
####        ren1 /= w0 - w1
####        ren2 /= w0 * w1
####        ren3 /= w0 / w1
####
####        ren0.en /= wn0[0];
####        ren1.en /= wn0[1];
####        ren2.en /= wn0[2];
####        ren3.en /= wn0[3];
####
####        ram0 = mem('ram0', 8, 4)
####        wn0 /= ram0[w0] + ram0[w1]
####        wn1 /= ram0[w0] - ram0[w1]
####
####        with if0(1, 'posedge'):
####            ram0[sub0.io.in0[3:0]] /= ram0[w0[7:4]] + w1
####            wn2 /= ram0[w0[7:4]] + w1
####            with if0(1):
####                wn2 /= 1
####            with else0():
####                wn2 /= 2
####        with else0():
####            ram0[sub0.io.in0[3:0]] /= ram0[w0[7:4]] - w1
####            wn2 /= ram0[w0[7:4]] - w1
####
####        fifo0 = sfifo_regs('fifo0', w = 8, depth = 4)
####
####        mux0 = priority_muxn('mux0',w = 8, n = 4, msb = 0)
####        mux1 = muxn('mux1',w = 8, n = 4)

####        ohot0 = bits("ohot0",7,0)
####        ohot1 = bits("ohot1",7,0)
####        data = bits("data",2,0)
####        #data /= oh2bin(ohot)
####        #data /= pri_enc(ohot)
####        #ohot /= bin2oh(data)
####        ohot0 /= self.io.in0
####        ohot1 /= pri_enc_oh(ohot0, msb = 0)
####        self.io.out0 /= ohot1

####        arbiter0 = rr_arbiter('arbiter0',n = 8)
####        d_bin = bits('d_bin', 3, 0)
####        d_gray = bits('d_gray', 3, 0)
####        d_bin /= self.io.in0
####        d_gray /= bin2gray(d_bin,6)
####
####        d_bin1 = bits('d_bin0', 3, 0)
####        d_bin1 /= gray2bin(d_gray,6)
####        clk_a = bits('clk_a')
####        clk_b = bits('clk_b')
####        clk_a /= self.io.clk
####        clk_b /= ~self.io.clk
####        fifo0 = afifo_regs_vijay1('fifo0')
####        fifo0.io.clk_w.name = clk_a.name
####        fifo0.io.clk_r.name = clk_b.name
        ##fifo0.io.clk_w.is_clock = 0
        ##fifo0.io.clk_r.is_clock = 0
        ##fifo0.io.clk_w /= clk_a
        ##fifo0.io.clk_r /= clk_b
##
##        wn0 = bits('wn0', 7, 0)
##
##        #wn0 /= self.io.in0
##        #self.io.out0 /= wn0 + 1
##
##        wn0 /= self.io.in0
##        self.io.out0 /= wn0 + 1
##
##        wn0 /= self.testa()[4:0]
##
##        def func0():
##            wn111 = wn0
##            wn111 /= 0x1111
##
##        func0()


##        wn0 = bits('wn0',3,0)
##        wn1 = bits('wn1',3,0)

#        wn0 /= 0
#        wn0 /= 1
#        wn0 /= 2
#        wn0 /= wn1 + 1

##        with when(wn1[0] == 1):
##            wn0 /= wn1 + 2
##            #with when(wn1[1] == 1):
##            #    wn0 /= wn1 + 2
##            #with when(wn1[2] == 1):
##            #    wn0 /= wn1 + 3
##        with other():
##            wn0 /= wn1 + 3
##            #with when(wn1[1] == 1):
##            #    wn0 /= wn1 + 4
##            #with other():
##            #    wn0 /= wn1 + 5

        #aaaa = [0,1,2,3]
        #aaaa = bits('aaaa', w = 8).as_reg(tp = 'reg_rs', rs = 0x5a)
        #aaaa /= aaaa + 1

        #aaaa = 'abcd'
        #print(aaaa[1:])
        #print(len(aaaa[1:]))

        #aaaa = test_bundle('aaaa')
        #for i in aaaa.abcd:
        #    print("abcd:%s" % i)
        #print("abcd[%d]:%s" % (0,aaaa.abcd[0]))
        #print("abcd[%d]:%s" % (1,aaaa.abcd[1]))
        #print("abcd[%d]:%s" % (2,aaaa.abcd[2]))
        #print("abcd[%d]:%s" % (3,aaaa.abcd[3]))
        #aaaa = bits('aaaa',w = 8)
        #bbbb = bits('bbbb',w = 8)
        #aaaa[0] /= bbbb
        #aaaa[3:0] /= bbbb
        #aaaa[bbbb[2:0]] /= bbbb



        #aaaa = bits('aaaa', w = 8)
        #bbbb = bits('bbbb', w = 8)
        #bbbb /= -aaaa

        #aaaa /= bbbb & 0x8000000000000000L
        #aaaa /= bbbb[5:3]
        #aaaa /= bbbb[aaaa]
        
        #aaaa = bits('aaaa', w = 8)
        #aaaa /= 0
        #aaaa /= 1
        #aaaa /= -1
        #aaaa /= "5'hab"

        #bbbb = bits('bbbb', w = 8)
        #aaaa /= mux(aaaa[0], bbbb,1)

        #aaaa = test_bundle1('aaaa')
        #bbbb = test_bundle1('bbbb')
        #s = bits('s')
        #cccc = mux(s, aaaa, bbbb)
        #dddd = sel(s, [bbbb, aaaa])

        #aaaa = bits('aaaa', w = 8)
        #bbbb = bits('bbbb', w = 8)
        #aaaa /= 1
        #bbbb /= 2

        #sram0 = sram('sram0', size = 8, data_width = 128, mask_width = 1)

        #aaaa = zip(range(9), range(10))
        #print(aaaa)
        #sys.exit(0)

        #aaaa = [0,1,2,3,4,5,6,7]
        #print(aaaa)
        #print(aaaa[0:3])
        #print(aaaa[3:6])
        #print(aaaa[6:9])
        #print(grouped_list(aaaa,3))
        #print(aaaa)
        #sys.exit(0)
        #aaaa = [('a',0),('b',1),('c',2),('d',3)]
        #print(aaaa)
        #bbbb = groupby(aaaa, lambda _ :_[0])
        #print(bbbb)
        #for i in bbbb:
        #    print(i[0])
        #    print(i[1][])
        #sys.exit(0)

        #aaaa = bits('aaaa', w = 8)
        #ren0 = reg_en("ren0", w = 8, en = aaaa[0], next = aaaa)
        #ren1 = reg_en_r("ren1", w = 8, en = aaaa[1], next = aaaa)
        #ren2 = reg_en_s("ren2", w = 8, en = aaaa[2], next = aaaa)
        #ren3 = reg_en_rs("ren3", w = 8, en = aaaa[3], rs = 0x55, next = aaaa)

        #ren0 /= 1
        #ren1 /= 2
        #ren2 /= 3
        #ren3 /= 4

        #a = 1 << 64
        #b = -a
        #print("%x" % a)
        #print("%x" % b)
        #print("%s" % bin(a))
        #print("%s" % bin(b))

        #aaaa = [('a', 0),('b', 1),('c', 2),('d', 3)]
        #print(aaaa)
        #[a,b] = zip(*aaaa)
        #print(a)
        #print(b)
        #c = map(lambda _: _, a)
        #d = map(lambda _: _, b)
        #print(c)
        #print(d)

        #bbb = 0
        #aaa = 11 if (bbb == 0) else 22 + 1
        #print(aaa)
        #sys.exit(0)

        #s = bits('s', w = 2)
        #a = bits('a', w = 8, init = 0)
        #b = bits('b', w = 8, init = 0)
        #c = bits('c', w = 8, init = 0)
        #d = bits('d', w = 8, init = 0)
        #o = bits('o', w = 8)
        #
        #with when(s == 0):
        #    o /= a
        #with when(s == 1):
        #    o /= b

        #s = parameter('s', a = 1, b = 2)
        #d = parameter('d', a = 3, b = 4)
        #q = [s,d]
        #c = d
        #print("cmp: %d" %(cmp(c,s)))
        #print("eq: %d" %(c == s))
        #print("cmp: %d" %(cmp(c,d)))
        #print("eq: %d" %(c == d))
        #print("index: %d" %(q.index(c)))
        #sys.exit(0)

        #a = bits('a', w = 8)
        #b = bits('b', w = 8)
        #c = bits('c', w = 8)
        #d = bits('d', w = 8)
        #with if0 (a == 0):
        #    c /= a + b
        #    with if0 (b == 0):
        #        d /= a & b
        #    with else0():
        #        d /= a | b
        #with else0():
        #    c /= a - b
        #    d /= a ^ b

        #mem0 = vec('mem0', bits, 4)
        #a = bits('a')
        #b = bits('b')
        #s = bits('s', w = 2)
        #a /= mem0[0]
        #b /= mem0[1]
        #a /= mem0[s]
        #b /= mem0[s]
        #mem0.idx_write(s,a)
        #mem0[s] /= a
        #mem0(0, a)
        #mem0(s, b)

        #a = reg_r('a', w = 4)
        #b = bits_vec('b', w = 8, init = 0x11)
        #c = bits('c', w = 8)
        #s = bits('s', w = 8)


        #print(b)
        #c[3:0] /= b[3:0]
        #b[0] /= 1
        #b[1:0] /= s[1:0]
        #s /= b[0] + c[0]
        #b /= 0x11

        #self.io.var(inp("new_in",w = 8))
        #self.io.var(outp("new_out",w = 8))
        #b /= self.io.new_in
        #self.io.new_out /= b + s

        #def func0(a,b):
        #    tmp = bits('tmp')
        #    #tmp = reg('tmp')
        #    with when(b):
        #        tmp /= 1
        #    #with other():
        #    #    tmp[0] /= 0
        #    a /= tmp
        #    return a

        #a = bits('a', init = 0)
        #b = bits('b', init = 0)
        #c = bits('c', init = 0)
        #s = bits('s', init = 0)

        #with when(s):
        #    c /= func0(a,b)

        #b = bits('b', init = 1)
        #a = WideCounter('a', width = 64).inc(b)

        #a = reg('a', w = 8, next = 0)
        #b = bits('b', w = 8, init = 0)

        #a[3:0] /= 1
        #a[7:4] /= 1
        #a[5:2] /= 1
        #a /= 1
        #nValid = bits('nValid', w = 2, init = 0)
        ##valid = (bin2oh(nValid) - 1)[2-1: 0]
        #tmp = bits('tmp', w = 2**nValid.get_w())
        #for i in range(tmp.get_w()):
        #    tmp[i] /= nValid == i

        #a = reg('a', w = 8)
        #s = reg('s', w = 8)

        ##for i in range(a.get_w()):
        ##    a[i] /= a[i:0].r_or()
        #
        #vprint("a: %h", a)
        #vprint("s: %h", s)
        #vprint("a: %h, %h", (a, s))
        #vprint("a: %h, %h", (self.io.in0, self.io.out0))
        #with when(a[0]):
        #    vprint("a: %h, %h", (self.io.in0, self.io.out0))
        #with other():
        #    vprint("a: %h, %h", (self.io.in0, self.io.out0))

        #vassert(a[0], "vassert: %h", a[0])

        #class bundle0(bundle):
        #    def set_var(self):
        #        self.var(bits('a0'))
        #        self.var(bits('a1'))
        #        self.var(bits('a2'))
        #        self.var(bits('a3'))

        #a = bits('a')
        #b = bits('b')
        #def gen_func(a):
        #    return bundle0(a).as_input()
        #if0 = vinterface('if0', gen = gen_func)
        #if1 = vinterface('if1', gen = gen_func)
        #if0.io.a0 /= a
        #if1.io.a0 /= b

        #a = bits('a', w = 8)
        #b = bits('b', w = 8)
        #op = bits('op', w = 4)
        #c = bits('c', w = 8)
        #cnt = 0


        ##with vinitial():
        #with valways():
        #    cnt = 1
        #    #with vif(c == 0):
        #    #    c[3:0] /= a + b
        #    #with velse():
        #    #    c[7:4] /= a - b

        #    with when(c == 0):
        #        c[3:0] /= a + b
        #    with other():
        #        c[7:4] /= a - b

        #    step(1)
        #    c /= a & b

        #    step(1)
        #    c /= a | b

        #    cnt = 8
        #    step(cnt)
        #    c /= a ^ b

        #test0 = unit_test0('test0', pkt_num = 10)

#        a = bits('a', w = 8, init = 0)
#        b = bits('b', w = 8, init = 0)
#        #tmp with when(a == 0):
#        #tmp     b /= 0
#        #tmp with other():
#        #tmp     with when(a == 1):
#        #tmp         b /= 1
#        #tmp     with other():
#        #tmp         b /= 2
#
#        with when(a == 0):
#            b /= 0
#        with elsewhen(a == 1):
#            b /= 1
#        with elsewhen(a == 2):
#            b /= 2
#        with other():
#            b /= 3
#
#        aaa = map(lambda _: _, range(10))
#        print(list(aaa))
#        print(list(aaa))
#        assert(0)

        #ecc8 = module_ecc('ecc8', ecc_type = 'secded', width = 8)
        #ecc16 = module_ecc('ecc16', ecc_type = 'secded', width = 16)
        #ecc32 = module_ecc('ecc32', ecc_type = 'secded', width = 32)
        #ecc64 = module_ecc('ecc64', ecc_type = 'secded', width = 64)

        #crc_reg = reg_rs('crc_reg', w = 32, rs = 0xffffffff)
        #data_new = bits('data_new', w = 8, init = 0x12)
        #crc_new = bits('crc_new', w = 32)
        #crc_new /= crc(32, 0x104c11db7, crc_reg, data_new)

        #aaa = list(reversed([0, 1, 2, 3, 4, 5, 6, 1, 3, 5, 5]))
        #print(aaa)
        #print(sorted(set(aaa), key = aaa.index))
        #assert(0)

        #print(inspect.getframeinfo(inspect.currentframe()))
        
#        aaa = vec('aaa', bits, 8)
#        bbb = vec('bbb', reg, 8)
#        ccc = vec('ccc', lambda _: bits(_).as_reg(), 8)
#        class tmp_ddd(bundle):
#            def set_var(self):
#                super(tmp_ddd, self).set_var()
#                self.var(bits('pc', w = 32))
#
#        eee = tmp_ddd('eee').as_reg()
#        #eee = tmp_ddd('eee')
#        print(eee.name)
#        print(eee.her_name)
#        print(eee.pc.name)
#        print(eee.pc.her_name)
#        #assert(0)
#
#        a = [0, 1, 2, 3]
#        b = [4, 5, 6, 7]
#        c = [8, 9, 10, 11]
#        print(list(zip(a, b)))
#        print(list(zip(a, b, c)))
#        assert(0)

#        BEQ   = bit_pat("b?????????????????000?????1100011")
#        BNE   = bit_pat("b?????????????????001?????1100011")
#        BLT   = bit_pat("b?????????????????100?????1100011")
#        BGE   = bit_pat("b?????????????????101?????1100011")
#        BLTU  = bit_pat("b?????????????????110?????1100011")
#        BGEU  = bit_pat("b?????????????????111?????1100011")
#        JAL   = bit_pat("b?????????????????????????1101111")
#        JALR  = bit_pat("b?????????????????000?????1100111")
#        LUI   = bit_pat("b?????????????????????????0110111")
#        AUIPC = bit_pat("b?????????????????????????0010111")
#
#
#        x = 'b?'
#        dec_table = [
#            (BEQ  , [value(0), value(0), value(1), value(1), value(0), value(x), value(1), value(x), value(x), value(0)]),
#            (BNE  , [value(0), value(0), value(1), value(1), value(0), value(x), value(1), value(x), value(x), value(0)]),
#            (BLT  , [value(0), value(0), value(1), value(1), value(0), value(x), value(1), value(x), value(x), value(0)]),
#            (BGE  , [value(0), value(0), value(1), value(1), value(0), value(x), value(1), value(x), value(x), value(1)]),
#            (BLTU , [value(0), value(0), value(1), value(1), value(0), value(x), value(1), value(x), value(x), value(1)]),
#            (BGEU , [value(0), value(1), value(0), value(1), value(x), value(0), value(x), value(1), value(x), value(1)]),
#            (JAL  , [value(0), value(1), value(0), value(1), value(x), value(0), value(x), value(1), value(x), value(x)]),
#            (JALR , [value(0), value(1), value(0), value(1), value(x), value(0), value(x), value(1), value(x), value(x)]),
#            (LUI  , [value(0), value(1), value(0), value(1), value(x), value(0), value(x), value(1), value(x), value(x)]),
#            (AUIPC, [value(0), value(1), value(0), value(1), value(x), value(0), value(x), value(1), value(x), value(x)])]
#
#        class inst_ctrl_sigs(bundle):
#            def set_var(self):
#                super(inst_ctrl_sigs, self).set_var()
#                self.var(bits('legal'))
#                self.var(bits('fp'))
#                self.var(bits('rocc'))
#                self.var(bits('branch'))
#                self.var(bits('jal'))
#                self.var(bits('jalr'))
#                self.var(bits('rxs2'))
#                self.var(bits('rxs1'))
#                self.var(bits('sel_alu2'))
#                self.var(bits('sel_alu1'))
#
#        inst = bits('inst', w = 32)
#        
#        def decode(inst, table):
#            #for i in table:
#            #    print('value: %s' % '{:032b}'.format(i[0].value))
#            #    print('mask : %s' % '{:032b}'.format(i[0].mask))
#            #    print('w__  : %d' % i[0].w__)
#            sigs_len_map = list(map(lambda _: len(_[1]), table))
#            sigs_len_same_map = list(map(lambda _: _ == sigs_len_map[0], sigs_len_map))
#            sigs_len_check = reduce(lambda a,b: a & b, sigs_len_same_map)
#            sigs_len = sigs_len_map[0]
#            #print(sigs_len_map)
#            #print(sigs_len_same_map)
#            #print(sigs_len_check)
#            assert(sigs_len_check)
#
#            table_len = len(table)
#
#            table_v = list(map(lambda _: _[1], table))
#            sigs_table_v = list(map(lambda i: list(map(lambda _: _[i],table_v)), range(sigs_len)))
#            sigs_table_v_set = list(map(lambda _: list(set(_)), sigs_table_v))
#            sigs_table_v_set_no_x = list(map(lambda _: list(filter(lambda _:not _.is_xz() , _)), sigs_table_v_set))
#            #sigs_table_v_one = list(map(lambda i: list(filter(lambda _: _[1][i] == 1, table)), range(sigs_len)))
#            sigs_table_v_set_no_x_each = list(map(lambda _: list(map(lambda i: list(filter(lambda j: j[1][_] == i, table)), sigs_table_v_set_no_x[_])), range(sigs_len)))
#
#            #sigs_logic = list(map(lambda _: 0 if (_ is None) else (1 if (len(_) == table_len) else reduce(lambda a,b: a | ((inst & b[0].mask) == b[0].value), _, 0)), sigs_table_v_one))
#            sigs_logic_sel = list(map(lambda i: list(map(lambda j: reduce(lambda a,b: a | ((inst & b[0].mask) == b[0].value), j, 0), i)), sigs_table_v_set_no_x_each))
#            sigs_logic_v = list(map(lambda i:sel_oh(sigs_logic_sel[i], sigs_table_v_set_no_x[i]) if (len(sigs_logic_sel[i]) != 0) else 0, range(sigs_len)))
#            print(table_v)
#            print(sigs_table_v)
#            print(sigs_table_v_set)
#            print(sigs_table_v_set_no_x)
#            print(sigs_logic_sel)
#            print(sigs_logic_v)
#            #print(len(sigs_table_v_each[0]))
#            #print(len(sigs_table_v_each[1]))
#            #print(len(sigs_table_v_each[2]))
#            #print(len(sigs_table_v_each[3]))
#            #print(len(sigs_table_v_each[4]))
#            #print(len(sigs_table_v_each[5]))
#            #print(len(sigs_table_v_each[6]))
#            #print(len(sigs_table_v_each[7]))
#            #print(sigs_table_v[3])
#            #print(sigs_table_v_one[0])
#            #print(sigs_table_v_one[1])
#            #print(sigs_table_v_one[2])
#            #print(sigs_table_v_one[3])
#            #print(sigs_logic)
#            return sigs_logic_v
#
#        dec_logic = decode(inst, dec_table)
#        sigs = inst_ctrl_sigs('sigs')
#        for i in range(len(sigs)):
#            sigs[i] /= dec_logic[i]

        #print(hex(ord('a')))
        #print(hex(ord('A')))
        #print(hex(ord('\n')))
        #assert(0)

        #vmacro('CORE_NUM', 2)
        #vmacro('CORE_NUM')
        
        #print(os.listdir('./'))
        #aaa = bits(init = 0)
        #vassert(aaa, 'aaa %h check failed', (aaa))

        #fn = './bootrom.hex.fix'
        #array = vhex_read(fn)
        #for i in array:
        #    print('vhex[%x] = %0x' %(i[0], i[1]))

        #array = vhex_read(fn, fill = 1)
        #for i in array:
        #    print('vhex_fill[%x] = %0x' %(i[0], i[1]))
        #aaa = [0,1,2,3]
        #print(aaa)
        #print(reversed(aaa))
        #assert(0)

        #sub0 = module_sub0('sub0')
        #with module_update(sub0):
        #    sub0.io.var(inp('in_post', w = 8))
        #    sub0.io.var(outp('out_post', w = 8))
        #    c = reg('c')
        #    c /= sub0.io.in0[2]

        #aaa = reg('aaa')
        #bbb = reg('bbb')
        #aaa /= self.io.in0[0]
        #bbb /= self.io.in0[1]
        #self.io.out0 /= 0

        #sub0 = module_sub0('sub0')
        #aaa = bits('aaa', w = 8)
        #bbb = bits('bbb')
        #pullup(aaa)
        #pullup(bbb)
        #pulldown(aaa)
        #pulldown(bbb)
        #pullup(aaa[0])
        #tmp pullup(self.io.in0)
        #tmp pullup(sub0.io.in0)
        #tmp pullup(aaa[0])
        #tmp 

        #tmp pulldown(bbb)
        #tmp pulldown(self.io.in0)
        #tmp pulldown(sub0.io.in0)
        #tmp pulldown(bbb[0])

        #info_log('zqh test: %s, %x' %(aaa.name, 0x12345))

        #aaa = bits('aaa', w = 8)
        #bbb = bits('bbb', w = 8)
        #tran(aaa[0],bbb[0])

        #aaa = bits('aaa', w = 8)
        #bbb = reg('bbb', w = 8)

        #aaa /= 0
        #bbb /= 0

        #aaa[0] /= 1
        #bbb[0] /= 1

        #tmp class queue_bundle(bundle):
        #tmp     def set_var(self):
        #tmp         super(queue_bundle, self).set_var()
        #tmp         self.var(bits('bank', w = 3))
        #tmp         self.var(bits('data', w = 64))

        #tmp ll_q = queue_ll2(
        #tmp     'll_q',
        #tmp     gen = queue_bundle,
        #tmp     entries = 64,
        #tmp     get_tag = lambda _: _.bank,
        #tmp     ll_num = 8)
        #tmp ll_q.io.enq.valid /= 0
        #tmp ll_q.io.enq.bits.bank /= 0
        #tmp ll_q.io.enq.bits.data /= 0

        #tmp for i in range(len(ll_q.io.deq)):
        #tmp     ll_q.io.deq[i].ready /= 1
        
        bbb = [bits('bbb0'), bits('bbb1'),bits('bbb2'),bits('bbb3'),bits('bbb4'),bits('bbb5'),bits('bbb6'),bits('bbb7')]
        for i in range(self.io.in0.get_w()):
            print('assign idx %d' % (i))
            self.io.in0[i] /= bits()


        


    def testa(self):
        return cat([bits.gen_t(w = 8), bits.gen_t(w = 8), bits.gen_t(w = 8)])

class test_bundle0(bundle):
    def set_var(self):
        self.var(bits('aa0'))
        self.var(bits('aa1'))
        self.var(bits('aa2'))
        self.var(bits('aa3'))

class test_bundle1(bundle):
    def set_var(self):
        self.var(bits('bb0'))
        self.var(test_bundle0('bundle0'))

class module_ecc(module):
    def set_par(self):
        super(module_ecc, self).set_par()
        self.p.par('ecc_type', 'secded')
        self.p.par('width', 8)

    def main(self):
        super(module_ecc, self).main()

        data_ecc_code = ecc_code(self.p.ecc_type)
        a = bits('a', w = self.p.width)
        b = bits('b', w = data_ecc_code.width(self.p.width))

        b /= data_ecc_code.encode(a)
