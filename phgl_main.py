from abc import ABCMeta, abstractmethod
import copy
from contextlib import contextmanager
import re
import string
import traceback
import os
import sys
import types
import math
from functools import reduce
from collections import Iterable, Iterator
import inspect

class op_type(object):
    (
        defi            , immd              , copy           , nop               ,
        add             , sub               , mul            , div               ,
        mod             , pow               , sl_l           , sr_l              ,
        sr_a            , and_t             , xor            , or_t              ,
        inv             , neg               , r_and          , r_or              ,
        r_xor           , rep               , cat            , eq                ,
        ne              , gt                , lt             , ge                ,
        le              , mux               , vwrite_begin   , vwrite            ,
        vwrite_end      , vassert_begin     , vassert        , vassert_end       ,
        vcover_begin    , vcover            , vcover_end     , vblk_if_begin     ,
        vblk_if_end     , vblk_else_begin   , vblk_else_end  , vblk_initial_begin,
        vblk_initial_end, vblk_always_begin , vblk_always_end, vblk_while_begin  ,
        vblk_while_end  , vstep             , vdelay         , vfinish           ,
        vwait           , vlist_defi        , vlist_append   , vlist_pop         ,
        vurandom        , vmacro            , vpullup        , vpulldown         ,
        vtran) = range(61)

class prime_cmd(object):
    def __init__(self, op, t = None, s0 = None, s1 = None, s2 = None, info = ""):
        self.op = op
        self.t = t
        self.post_t = 0
        self.parent = global_sb.current
        self.info = info
        self.if_cnt = global_sb.if_cnt
        self.else_cnt = global_sb.else_cnt
        self.vblk_cnt = global_sb.vblk_cnt

        if (
            op == op_type.vblk_if_begin      or op == op_type.vblk_if_end or 
            op == op_type.vblk_initial_begin or op == op_type.vblk_initial_end or 
            op == op_type.vblk_always_begin  or op == op_type.vblk_always_end or 
            op == op_type.vblk_while_begin   or op == op_type.vblk_while_end or 
            op == op_type.vblk_else_begin    or op == op_type.vblk_else_end):
            self.s0 = s0
            return
        elif (
            op == op_type.vwrite_begin  or op == op_type.vwrite_end  or op == op_type.vwrite or 
            op == op_type.vassert_begin or op == op_type.vassert_end or op == op_type.vassert or
            op == op_type.vcover_begin  or op == op_type.vcover_end  or op == op_type.vcover 
              ):
            self.s0 = s0
            self.s1 = s1
            self.s2 = s2
            return
        elif (op == op_type.vmacro):
            self.s0 = s0
            self.s1 = s1
            self.s2 = s2
            return
        elif (
            op == op_type.vstep   or op == op_type.vdelay or 
            op == op_type.vfinish or op == op_type.vwait or 
            op == op_type.vpullup or op == op_type.vpulldown):
            self.s0 = s0
            self.s1 = s1
            self.s2 = s2
            return
        elif (op == op_type.vtran):
            self.s0 = s0
            self.s1 = s1
            self.s2 = s2
            return
        elif (op == op_type.vlist_defi or op == op_type.vlist_append or op == op_type.vlist_pop):
            self.s0 = s0
            self.s1 = s1
            self.s2 = s2
            return
        elif (op == op_type.vurandom):
            self.s0 = s0
            self.s1 = s1
            self.s2 = s2
            return

        #cmd post process
        #set t's signed_flag__ according s0/s1/s2
        if (self.t.auto_gen == 1):
            if (op == op_type.copy):
                self.t.signed_flag__ = s0.signed_flag__
            elif (op == op_type.mux):
                self.t.signed_flag__ = s1.signed_flag__ & s2.signed_flag__
            elif (op in (
                op_type.add,
                op_type.sub,
                op_type.mul, 
                op_type.div,
                op_type.mod)):
                self.t.signed_flag__ = s0.signed_flag__ & s1.signed_flag__

        if (t.slc_get != []):
            self.t_slc = t.slc_get.pop()
        else:
            self.t_slc = None

        self.s0 = s0
        if (s0 is not None):
            if (s0.slc_get != []):
                self.s0_slc = s0.slc_get.pop(0)
            else:
                self.s0_slc = None
        else:
            self.s0_slc = None
        self.s1 = s1
        if (s1 is not None):
            if (s1.slc_get != []):
                self.s1_slc = s1.slc_get.pop(0)
            else:
                self.s1_slc = None
        else:
            self.s1_slc = None
        self.s2 = s2
        if (s2 is not None):
            if (s2.slc_get != []):
                self.s2_slc = s2.slc_get.pop(0)
            else:
                self.s2_slc = None
        else:
            self.s2_slc = None

        #remove multi-drive(multi assign)
        #merge slice assign
        if (t.defi_reg == 0):
            for i in reversed(range(len(t.cmd_q))):
                if (t.cmd_q[i].parent == self.parent):
                    pre_cmd = t.cmd_q[i]

                    #current slc select range out of last time's assign target range
                    #no need merge
                    if (self.t_slc is not None):
                        if (pre_cmd.t_slc is None):
                            pre_start = pre_cmd.t.get_w() - 1
                            pre_stop = 0
                        else:
                            pre_start = pre_cmd.t_slc.start
                            pre_stop = pre_cmd.t_slc.stop
                        if ((self.t_slc.start < pre_stop) or (self.t_slc.stop > pre_start)):
                            break;
                    if (self.t_slc == pre_cmd.t_slc):
                        if (pre_cmd.op != op_type.defi):
                            pre_cmd.post_t = 1
                    elif (self.t_slc is None):
                        if (pre_cmd.op != op_type.defi):
                            pre_cmd.post_t = 1
                    elif (self.t_slc is not None and pre_cmd.post_t == 0):
                        if (pre_cmd.op != op_type.defi):
                            pre_cmd.post_t = 1

                        if (pre_cmd.t_slc is None):
                            pre_t_slc = slice(pre_cmd.t.get_w() - 1, 0, None)
                        else:
                            pre_t_slc = pre_cmd.t_slc

                        #re assign all bits slc
                        if (self.t_slc.start == t.get_w() - 1):
                            slc_start = self.t_slc.stop - 1
                            slc_stop = 0
                            if ((pre_cmd.op == op_type.defi) and (t.type_reg == 0)):
                                s0_sel = bits().rep(slc_start - slc_stop + 1)
                            else:
                                s0_sel = pre_cmd.s0[slc_start: slc_stop]
                            self.s0 = cat([
                                s0[self.t_slc.start - self.t_slc.stop : 0],
                                s0_sel])
                            self.s0_slc = None
                            self.t_slc = None
                        elif (self.t_slc.stop == 0):
                            slc_start = t.get_w() - 1
                            slc_stop = self.t_slc.start + 1
                            if ((pre_cmd.op == op_type.defi) and (t.type_reg == 0)):
                                s0_sel = bits().rep(slc_start - slc_stop + 1)
                            else:
                                s0_sel = pre_cmd.s0[slc_start: slc_stop]
                            self.s0 = cat([
                                s0_sel,
                                s0[self.t_slc.start - self.t_slc.stop : 0]])
                            self.s0_slc = None
                            self.t_slc = None
                        else:
                            slc_start0 = t.get_w() - 1
                            slc_stop0 = self.t_slc.start + 1
                            if ((pre_cmd.op == op_type.defi) and (t.type_reg == 0)):
                                s0_sel0 = bits().rep(slc_start0 - slc_stop0 + 1)
                            else:
                                s0_sel0 = pre_cmd.s0[slc_start0: slc_stop0]
                            slc_start1 = self.t_slc.stop - 1
                            slc_stop1 = 0
                            if ((pre_cmd.op == op_type.defi) and (t.type_reg == 0)):
                                s0_sel1 = bits().rep(slc_start1 - slc_stop1 + 1)
                            else:
                                s0_sel1 = pre_cmd.s0[slc_start1: slc_stop1]
                            self.s0 = cat([
                                s0_sel0, 
                                s0[self.t_slc.start - self.t_slc.stop : 0], s0_sel1])
                            self.s0_slc = None
                            self.t_slc = None


class if_else(object):

    @contextmanager
    def if0(self, a, t = None, **args):
        info = global_sb.get_info()
        #in if else nest, copy t form last level's
        if (isinstance(global_sb.current, if_else_chain)):
            tmp_t = global_sb.current.t
        else:
            tmp_t = t

        #copy signal to avoid full name issue
        if (isinstance(a, bits)):
            cond = bits(w = a.get_w(), auto_gen = 1)
            cmd = prime_cmd(op_type.copy, cond, a, info = info)
            cond.cmd_q.append(cmd)
            global_sb.push_cmd(cmd)
        else:
            cond = a

        if_blk = if_else_chain(cond, "if", tmp_t, **args);

        #component.if_cnt += 1
        global_sb.if_cnt += 1
        yield self
        global_sb.if_cnt = global_sb.if_cnt - 1

        if_blk.pop_stack()
        global_sb.current.t_index = if_blk.t_index

    @contextmanager
    def else0(self, a = None):

        assert(len(global_sb.current.cmd_q) != 0), "else must folow if"
        pre_cmd = global_sb.current.cmd_q[-1]
        assert(type(pre_cmd) == if_else_chain), "else must folow if"
        assert(pre_cmd.flag == "if"), "else must not folow else"

        if_blk = if_else_chain(global_sb.last.cond, "else", global_sb.last.t);
        if_blk.parent = global_sb.last

        global_sb.else_cnt = global_sb.else_cnt + 1
        yield
        global_sb.else_cnt = global_sb.else_cnt - 1

        if_blk.pop_stack()
        global_sb.current.t_index = if_blk.t_index

    @contextmanager
    def blk(self, t = None, **args):
        info = global_sb.get_info()
        #in if else nest, copy t form last level's
        if (isinstance(global_sb.current, if_else_chain)):
            tmp_t = global_sb.current.t
        else:
            tmp_t = t

        cond = 1

        if_blk = if_else_chain(cond, "blk", tmp_t, **args);

        #component.if_cnt += 1
        global_sb.if_cnt += 1
        yield self
        global_sb.if_cnt = global_sb.if_cnt - 1

        if_blk.pop_stack()
        global_sb.current.t_index = if_blk.t_index

    @contextmanager
    def when(self, a):
        global_sb.when_cnt += 1
        global_sb.when_stack.append(a)
        yield self
        global_sb.when_cnt -= 1
        global_sb.pre_when_cond = global_sb.when_stack.pop()

    @contextmanager
    def elsewhen(self, a):
        pre_cond = global_sb.pre_when_cond
        next_pre_cond = pre_cond | a
        pre_a = pre_cond == 0
        global_sb.when_cnt += 1
        global_sb.when_stack.append(pre_a & a)
        yield self
        global_sb.when_cnt -= 1
        global_sb.when_stack.pop()
        global_sb.pre_when_cond = next_pre_cond

    @contextmanager
    def other(self):
        a = global_sb.pre_when_cond == 0
        global_sb.when_cnt += 1
        global_sb.when_stack.append(a)
        yield self
        global_sb.when_cnt -= 1
        global_sb.when_stack.pop()
        global_sb.pre_when_cond = None

    @contextmanager
    def vif(self, a):
        info = global_sb.get_info()

        #copy signal to avoid full name issue
        if (isinstance(a, (inp, outp, reg))):
            cond = bits(w = a.get_w(), init = a, auto_gen = 1) 
        elif (isinstance(a, (int))):
            cond = value(a)
        else:
            cond = a
        cmd = prime_cmd(op_type.vblk_if_begin, cond, cond, info = info)
        global_sb.push_cmd(cmd)
        global_sb.vblk_cnt += 1
        yield self
        global_sb.vblk_cnt -= 1
        cmd = prime_cmd(op_type.vblk_if_end, cond, cond, info = info)
        global_sb.push_cmd(cmd)

    @contextmanager
    def velse(self):
        info = global_sb.get_info()

        cmd = prime_cmd(op_type.vblk_else_begin, None, None, info = info)
        global_sb.push_cmd(cmd)
        global_sb.vblk_cnt += 1
        yield self
        global_sb.vblk_cnt -= 1
        cmd = prime_cmd(op_type.vblk_else_end, None, None, info = info)
        global_sb.push_cmd(cmd)

    @contextmanager
    def vinitial(self):
        info = global_sb.get_info()

        #copy signal to avoid full name issue
        cmd = prime_cmd(op_type.vblk_initial_begin, None, None, info = info)
        global_sb.push_cmd(cmd)
        global_sb.vblk_cnt += 1
        yield self
        global_sb.vblk_cnt -= 1
        cmd = prime_cmd(op_type.vblk_initial_end, None, None, info = info)
        global_sb.push_cmd(cmd)

    @contextmanager
    def valways(self, a = None):
        info = global_sb.get_info()

        cmd = prime_cmd(op_type.vblk_always_begin, None, None, info = info)
        global_sb.push_cmd(cmd)
        global_sb.vblk_cnt += 1
        yield self
        global_sb.vblk_cnt -= 1
        cmd = prime_cmd(op_type.vblk_always_end, None, None, info = info)
        global_sb.push_cmd(cmd)

    @contextmanager
    def vwhile(self, a):
        info = global_sb.get_info()

        #copy signal to avoid full name issue
        if (isinstance(a, (inp, outp, reg))):
            cond = bits(w = a.get_w(), init = a, auto_gen = 1) 
        elif (isinstance(a, (int))):
            cond = value(a)
        else:
            cond = a
        cmd = prime_cmd(op_type.vblk_while_begin, cond, cond, info = info)
        global_sb.push_cmd(cmd)
        global_sb.vblk_cnt += 1
        yield self
        global_sb.vblk_cnt -= 1
        cmd = prime_cmd(op_type.vblk_while_end, cond, cond, info = info)
        global_sb.push_cmd(cmd)

    @contextmanager
    def module_update(self, a):
        global_sb.module_stack.append(global_sb.current)
        global_sb.current = a
        yield self
        global_sb.last = global_sb.current
        global_sb.current = global_sb.module_stack.pop()


if_else0 = if_else()
if0 = if_else0.if0
else0 = if_else0.else0
blk = if_else0.blk
when = if_else0.when
elsewhen = if_else0.elsewhen
other = if_else0.other
vif = if_else0.vif
velse = if_else0.velse
vinitial = if_else0.vinitial
valways = if_else0.valways
vwhile = if_else0.vwhile
module_update = if_else0.module_update

# bits, value, bit_pat and bundle_base's parent class
class data_base(object):
    def __init__(self, name = '', auto_gen = 0):
        assert(isinstance(name, (str, int)))
        if (name == ''):
            #tmp if (isinstance(self, bits)):
            #tmp     name = "_T_" + str(global_sb.current.t_index)
            #tmp     global_sb.current.t_index += 1
            #tmp elif (isinstance(self, bundle)):
            #tmp     name = "_TB_" + str(global_sb.current.t_index)
            #tmp     global_sb.current.t_index += 1
            #tmp elif (isinstance(self, vlist)):
            #tmp     name = "_TQ_" + str(global_sb.current.t_index)
            #tmp     global_sb.current.t_index += 1
            name = "_T_" + str(global_sb.current.t_index)
            global_sb.current.t_index += 1
        else:
            name = str(name)
        self.type_reg = 0
        self.type_ioport = 0
        self.name = name
        self.her_name = ""
        self.w__ = 0
        self.signed_flag__ = 0
        self.auto_gen = auto_gen
        self.cmd_q = []
        self.slc__ = None
        self.slc_get = []

    def gen_var_name(self):
        print(list(inspect.getframeinfo(inspect.currentframe().f_back.f_back)))

    def get_full_name(self):
        if (self.her_name != ""):
            return self.her_name + self.name
        else:
            return self.name

    def nop_cmd(self, a = None):
        cmd = prime_cmd(op_type.nop, self)
        global_sb.push_cmd(cmd)
        return cmd

    def get_fn(self):
        return self.parent.get_fn() + '.' + self.name

    def to_sint(self):
        self.signed_flag__ = 1
        return self

    def to_uint(self):
        self.signed_flag__ = 0
        return self

    def pack(self):
        return self

    def get_w(self):
        if (self.w__ == 0):
            return 1
        else:
            return self.w__

    def as_sint(self):
        info = global_sb.get_info()
        if isinstance(self, bits):
            if (self.signed_flag__ == 1):
                return self
            tmp = bits(w = self.get_w(), auto_gen = 1)
            cmd = prime_cmd(op_type.copy, tmp, self, info = info)
            tmp.signed_flag__ = 1
            tmp.cmd_q.append(cmd)
            global_sb.push_cmd(cmd)
            return tmp
        elif isinstance(self, value):
            self.signed_flag__ = 1
            return self
        else:
            assert(0)

    def as_uint(self):
        info = global_sb.get_info()
        if isinstance(self, bits):
            if (self.signed_flag__ == 0):
                return self
            tmp = bits(w = self.get_w(), auto_gen = 1)
            cmd = prime_cmd(op_type.copy, tmp, self, info = info)
            tmp.signed_flag__ = 0
            tmp.cmd_q.append(cmd)
            global_sb.push_cmd(cmd)
            return tmp
        elif isinstance(self, value):
            self.signed_flag__ = 0
            return self
        else:
            assert(0)

    def __idiv__(self, a):
        self.__itruediv__(a)

    def __itruediv__(self, a):
        return self

    def get_last_cmd(self):
        return self.cmd_q[-1]
    
    def clone(self, name = '', **args):
        if (isinstance(self, bits)):
            return type(self)(name, w = self.get_w(), **args)
        elif (isinstance(self, bundle_base)):
            assert(not isinstance(self, ready_valid_base))
            return type(self)(name, p = self.p, **args)
        else:
            assert(0)

class value(data_base):
    def __init__(self,a, w = 0):
        super(value, self).__init__('value')
        assert(isinstance(a, (int, str))), "type a is %s" % (type(a))
        assert(isinstance(w, (int))), "w must be int type"
        self.vl__ = a
        if (w == 0):
            if (isinstance(a, (int))):
                if (a < 2) and (a >= 0):
                    n = 1
                elif (a >= 2):
                    tmp_a = a >> 1
                    n = 1
                    while  (tmp_a != 0):
                        n += 1
                        tmp_a = tmp_a >> 1
                else:
                    n = 0
                self.w__ = n
            else:
                self.w__ = len(a)
        else:
            self.w__ = w
        self.gen_value_name()

    def gen_value_name(self):
        if (isinstance(self.vl__, (int))):
            tmp = "%x" % self.vl__
            if (self.vl__ < 0):
                flag_m = 1
                num_str = tmp[1:]
            else:
                flag_m = 0
                num_str = tmp

            if (self.w__ == 0):
                if (flag_m == 0):
                    self.name = "'h" + num_str
                else:
                    self.name = "(-" + "'h" + num_str + ")"
            else:
                if (flag_m == 0):
                    self.name = str(self.w__) + "'h" + num_str
                else:
                    self.name = "(-" + str(self.w__) + "'h" + num_str + ")"
        else:
            self.name = self.vl__

    def __invert__(self):
        info = global_sb.get_info()
        tmp = bits(w = self.get_w(), auto_gen = 1)
        cmd = prime_cmd(op_type.inv, tmp, self, info = info)
        tmp.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        return tmp

    def to_bits(self):
        tmp = bits(w = self.w__, init = self)
        tmp.signed_flag__ = self.signed_flag__
        return tmp

    def get_v(self):
        return self.vl__

    def __getitem__(self,index):
        return self.to_bits()[index]


class module_main(object):
    proj = ''
    debug_info = 'all'
    trace_limit = None
    log_fh = 0
    def __init__(self, name):
        self.name = name
        self.parent =  None
        self.static = None
        self.cmd_q = []
        self.type_if_else = 0

    @classmethod
    def set_proj(self,a):
        assert(isinstance(a, str))
        module_main.proj = a

    @classmethod
    def set_debug_info(self,a, b):
        assert(isinstance(a, str))
        module_main.debug_info = a
        module_main.trace_limit = b

    @classmethod
    def set_log_fh(self,a):
        module_main.log_fh = a

    def pc_name(self, a = ''):
        if (a is ''):
            suffix = ''
        else:
            suffix = '_' + a
        if (module_main.proj != ''):
            return module_main.proj + str('_') + self.__class__.__name__ + suffix
        else:
            return self.__class__.__name__ + suffix

    def get_fn(self, a = ''):
        assert(isinstance(a, str))
        fn = self.parent.name + '.' + (self.name if (a == '') else a)
        if (self.parent.name == 'main'):
            return fn
        else:
            return self.parent.get_fn(fn)

class configure(object):
    cfg_single_kv = {}
    cfg_all_kv = {}
    def __init__(self,name = ''):
        self.name = name
        self.set_cfg()

    def set_cfg(self):
        pass

    def cfg_all(self, path, k, v):
        assert(isinstance(path, str))
        assert(isinstance(k, str))
        if (path not in configure.cfg_all_kv.keys()):
            configure.cfg_all_kv[path] = {}
        configure.cfg_all_kv[path][k] = v

    #cfg_inst has higher priority than cfg_all
    def cfg_inst(self, path, k, v):
        assert(isinstance(path, str))
        assert(isinstance(k, str))
        if (path not in configure.cfg_single_kv.keys()):
            configure.cfg_single_kv[path] = {}
        configure.cfg_single_kv[path][k] = v

class global_sb(object):
    cfg = configure('cfg')
    childs = []
    if_cnt = 0
    else_cnt = 0
    module_stack = []
    current = module_main("main")
    last    = None
    module_inst_cnt = {}
    when_cnt = 0
    when_stack = []
    pre_when_cond = None
    vblk_cnt = 0

    @classmethod
    def push_cmd(self, cmd):
        global_sb.current.cmd_q.append(cmd)

    @classmethod
    def pop_cmd(self):
        return global_sb.current.cmd_q.pop()

        
    @classmethod
    def get_info(self, a = None):
        tmp_str = ""
        if (global_sb.current.debug_info == 'all'):
            info = traceback.extract_stack(limit = global_sb.current.trace_limit)
            for i in range(len(info) - 2, -1, -1):
                if (
                    (os.path.basename(info[i][0]) != 'phgl_main.py') and 
                    (os.path.basename(info[i][0]) != 'contextlib.py')):
                    tmp_str = " //@ " + os.path.basename(info[i][0]) + ":" + str(info[i][1])
                    break
        return tmp_str

class component(module_main):
    def __init__(self, name):
        super(component,self).__init__(name)
        self.info = global_sb.get_info()
        self.parent = global_sb.current
        self.t_index = 0
        self.module_register()
        global_sb.push_cmd(self)
        self.push_stack()

    def module_register(self):
        if (self.pc_name() not in global_sb.module_inst_cnt):
            global_sb.module_inst_cnt[self.pc_name()] = []

    def push_stack(self):
        global_sb.module_stack.append(global_sb.current)
        global_sb.current = self

    def pop_stack(self):
        global_sb.last = global_sb.current
        global_sb.current = global_sb.module_stack.pop()

class module(component):
    def __init__(self, name, p = None, static = None, **args):
        super(module,self).__init__(name)
        self.p = parameter('p')
        if (global_sb.module_inst_cnt[self.pc_name()] == []):
            self.static = None
        elif (self.parent.static is not None):
            self.static = self.parent.static
        else:
            self.static = static
        self.pm = module_parameter('pm')
        self.set_par()
        #for key in self.p.p__:
        #    print("%s set_par with p__[%s] = %s" % (self.name, key, self.p[key]))
        if (p is not None):
            self.p = p
        for key in args:
            if (key in self.pm.p__):
                self.pm.par(key,args[key])
                #print("%s overwrite with pm[%s] = %s" % (name, key,self.pm[key]))
            else:
                self.p.par(key,args[key])
                #print("%s overwrite with p[%s] = %s" % (name, key,self.p[key]))
        self.check_par()
        global_sb.childs.append(self)
        self.elaborate()
        self.params_cmp()
        self.pop_stack()
        self.default_crg_assign()

    def params_cmp(self):
        v = global_sb.module_inst_cnt[self.pc_name()]
        match_idx = 0
        if (v == []):
            v.append([self, self.p, self.pm])
        elif (
            (self.static is None) and 
            (self.pm.vlib is None) and 
            (self.pm.vuser is None)):
            find = 0
            v_idx = 0
            for i in v:
                #0 means equal
                if ((self.p == i[1]) and (self.pm == i[2])):
                    find = 1
                    match_idx = v_idx
                    break
                v_idx = v_idx + 1
            if (find == 0):
                match_idx = len(v)
                v.append((self, self.p, self.pm))
        self.suffix_cnt = match_idx

    def set_par(self):
        pass

    def check_par(self):
        pass

    def main(self):
        pass

    def set_port(self):
        pass

    def elaborate(self):
        self.io = bundle('io')
        self.init_io = self.io
        self.set_port()
        if (self.pm.has_clock == 1):
            self.io.add_default_clock(self.pm.clock_name)
        if (self.pm.has_reset == 1):
            self.io.add_default_reset(
                self.pm.reset_name,
                self.pm.reset_level,
                self.pm.reset_sync)
        self.main()
        self.post_main()
        self.last_do()
    
    def reset(self, a = None):
        return self.io.default_reset[-1]

    def no_clock(self):
        self.io.clock_remove()
        self.pm.has_clock = 0

    def no_reset(self):
        self.io.reset_remove()
        self.pm.has_reset = 0

    def no_crg(self):
        self.no_clock()
        self.no_reset()

    def reset_sync(self):
        self.pm.reset_sync = 1

    def reset_async(self):
        self.pm.reset_sync = 0

    def post_main(self):
        pass

    def last_do(self):
        for i in range(len(global_sb.current.cmd_q)):
            cur_cmd = global_sb.current.cmd_q[i]
            if not isinstance(cur_cmd, prime_cmd):
                continue
            if (cur_cmd.op == op_type.defi):
                if isinstance(cur_cmd.t, reg):
                    if (len(cur_cmd.t.cmd_q) == 1):
                        print(
                            "last_do: %s do not have drive, will do keep" % 
                            cur_cmd.t.name)
                        cur_cmd.t /= cur_cmd.t

        if (self.pm.vuser is not None):
            self.io.clean_her_name()

    def default_crg_assign(self):
        if (type(global_sb.current) != module_main):
            if (self.pm.has_clock and global_sb.current.pm.has_clock):
                self.io.default_clock[0] /= global_sb.current.io.default_clock[0]
            if (self.pm.has_reset and global_sb.current.pm.has_reset):
                self.io.default_reset[0] /= global_sb.current.io.default_reset[0]

class module_extern(module):
    pass

class unit_test(module):
    def set_par(self):
        super(unit_test, self).set_par()
        self.p = unit_test_parameter()

    def check_par(self):
        super(unit_test, self).check_par()
        assert(isinstance(self.p.clock_period, float))
        assert(isinstance(self.p.reset_delay, float))

    def main(self):
        super(unit_test, self).main()
        if (self.p.clock_gen):
            self.clock = self.clock_gen()
        if (self.p.reset_gen):
            self.reset = self.reset_gen()
        self.timeout_gen()

    def clock_gen(self):
        tmp = bits()
        with vinitial():
            tmp /= self.p.clock_init
            with vwhile(1):
                delay(self.p.clock_period/2)
                tmp /= ~tmp
        global_sb.current.io.default_clock[0] /= tmp
        return global_sb.current.io.default_clock[0]

    def reset_gen(self):
        if (global_sb.current.io.default_reset != []):
            tmp = bits()
            with vinitial():
                tmp /= 1 if (self.pm.reset_level == 1) else 0
                delay(self.p.reset_delay)
                tmp /= 0 if (self.pm.reset_level == 1) else 1
            global_sb.current.io.default_reset[0] /= tmp
            return global_sb.current.io.default_reset[0]
        else:
            return None

    def timeout_gen(self):
        if (self.p.timeout > 0):
            with vinitial():
                delay(self.p.timeout)
                finish()

class if_else_chain(component):

    def __init__(self, cond, flag = "if", t = None, **args ):
        if (isinstance(cond, (int, str))):
            self.cond = value(cond)
        else:
            self.cond = cond
        self.flag = flag
        self.t = t
        self.if_blk_parent = None
        if (isinstance(global_sb.current,module)):
            self.if_blk_parent = global_sb.current
        elif (isinstance(global_sb.current,if_else_chain)):
            self.if_blk_parent = global_sb.current.if_blk_parent
        super(if_else_chain,self).__init__("if_else_chain")
        self.type_if_else = 1
        if (self.if_blk_parent.io.default_clock != []):
            self.clock = self.if_blk_parent.io.default_clock[0]
        if (self.if_blk_parent.io.default_reset != []):
            self.reset = self.if_blk_parent.io.default_reset[0]
        for key in args:
            if (key == 'clock'):
                self.clock = args[key]
            if (key == 'reset'):
                if (self.if_blk_parent.io.default_reset != []):
                    self.reset = args[key]
        assert(isinstance(self.parent,module_main))
        self.t_index = self.parent.t_index

class bits(data_base):
    def __init__(self, name = '', w = 1, init = None, auto_gen = 0):
        super(bits, self).__init__(name, auto_gen = auto_gen)
        assert(isinstance(w, (int))), "w should be int type"
        assert(w > 0), "w = %d" % w
        info = global_sb.get_info()
        self.parent = global_sb.current
        self.defi_reg = 0
        if (global_sb.vblk_cnt > 0 and self.auto_gen == 0):
            self.defi_reg = 1
        else:
            self.defi_reg = 0
        self.getitem_cmd = None
        self.is_clock = 0
        self.is_reset = 0
        self.reset_level = 1
        self.reset_sync = 1
        self.bio__= None
        self.when_cnt = global_sb.when_cnt
        self.w__ = w
        self.vl = value(0)
        cmd = prime_cmd(op_type.defi, self, self, info = info)
        self.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        if (init is not None):
            self.__itruediv__(init)

    def remove_cmd(self,cmd):
        return global_sb.current.cmd_q.remove(cmd)

    def delete_cmd(self):
        for i in self.cmd_q:
            self.remove_cmd(i)

    def get_post_slc(self):
        if (self.slc__ is not None):
            assert(isinstance(self.slc__.start, int))
            assert(isinstance(self.slc__.stop, int))
            new_a = self.cmd_q[-1].s0
            self.delete_cmd()
            slc = self.slc__
            if (self.slc_get != []):
                self.slc_get.pop(0)
            if (new_a.slc_get != []):
                new_a.slc_get.pop(0)
        else:
            new_a = self
            slc = slice(new_a.get_w() - 1,0,None)
        return (new_a, slc)

    def max_w(self, a):
        if (isinstance(a, data_base)):
            tmp_a = a
        else:
            tmp_a = value(a)
        return max(self.get_w(),tmp_a.get_w())

    def change_name(self,name):
        self.name = name

    def set_her_name(self,name):
        if (name != '' and self.is_clock == 0 and self.is_reset == 0):
            self.her_name = name + '_' + self.her_name

    def clean_her_name(self):
        self.her_name = ''

    def reset_her_name(self, name):
        self.clean_her_name()

    def as_bits(self):
        tmp = bits(self.name, w = self.get_w())
        tmp.signed_flag__ = self.signed_flag__
        tmp.set_her_name(self.her_name[:-1])
        self.delete_cmd()
        return tmp

    def as_reg(self, tp = 'reg', rs = 0, next = None, en = None, **args):
        assert(tp in ['reg', 'reg_r', 'reg_s', 'reg_rs', 'reg_en'])
        if (tp == 'reg'):
            tmp = reg(self.name, w = self.get_w(), next = next, **args)
        elif (tp == 'reg_r'):
            tmp = reg_r(self.name, w = self.get_w(), next = next, **args)
        elif (tp == 'reg_s'):
            tmp = reg_s(self.name, w = self.get_w(), next = next, **args)
        elif (tp == 'reg_rs'):
            tmp = reg_rs(self.name, rs = rs, w = self.get_w(), next = next, **args)
        elif (tp == 'reg_en'):
            tmp = reg_en(self.name, w = self.get_w(), next = next, en = en, **args)
        tmp.set_her_name(self.her_name[:-1])
        tmp.signed_flag__ = self.signed_flag__
        self.delete_cmd()
        return tmp

    def as_input(self):
        tmp = inp(self.name, w = self.get_w())
        tmp.set_her_name(self.her_name[:-1])
        tmp.signed_flag__ = self.signed_flag__
        self.delete_cmd()
        return tmp

    def to_inout(self):
        self.inout = 1
        return self

    def as_output(self):
        tmp = outp(self.name, w = self.get_w())
        tmp.set_her_name(self.her_name[:-1])
        tmp.signed_flag__ = self.signed_flag__
        self.delete_cmd()
        return tmp

    def idx_mask(self, off,dat):
        assert(dat.get_w() == 1)
        off_oh = bin2oh(off, w = self.get_w())
        return mux(dat, off_oh | self, ~off_oh & self)
    
    def grouped(self, width = 1):
        return list(map(
            lambda base: self[base + width - 1 : base], range(0, self.get_w(), width)))

    def order_invert(self):
        return cat(self.grouped())

    def split(self, n):
        assert(isinstance(n, (int)))
        return (self[a.get_w() - 1 : n], self[n - 1 : 0])

    #get n bits from msb
    def msb(self, n = 1):
        assert(n > 0 and n < self.get_w())
        return self[self.get_w() - 1 : self.get_w() - n]

    #get n bits from lsb
    def lsb(self, n = 1):
        assert(n > 0 and n < self.get_w())
        return self[n - 1 : 0]

    def s_ext(self, n):
        assert(self.get_w() <= n)
        if (self.get_w() == n):
            return self
        else:
            return cat2(self.__getitem__(self.get_w()-1).rep(n - self.get_w()), self)

    def u_ext(self, n):
        assert(self.get_w() <= n)
        if (self.get_w() == n):
            return self
        else:
            return cat2(value(0, w = n - self.get_w()), self)

    def z_ext(self):
        return self.u_ext(self.get_w() + 1).to_sint()

    def match_any(self,a):
        a = get_list(a)
        assert(isinstance(a, list))
        assert(len(a) >= 1)
        return reduce(lambda x, y: x.__or__(y), map(lambda i: self.__eq__(i), a))

    def gen_value_w(self, a):
        if isinstance(a, str):
            return self.get_w()
        v_w = value(a).get_w()
        if (v_w >= self.get_w()):
            return v_w
        else:
            return self.get_w()

    def __add__(self, a):
        info = global_sb.get_info()
        tmp = bits(w = self.max_w(a) + 1, auto_gen = 1)
        assert(isinstance(a, (int, str, data_base)))
        if (isinstance(a, (int, str))):
            tmp_a_vl = value(a, w = self.gen_value_w(a))
            cmd = prime_cmd(op_type.add, tmp, self, tmp_a_vl, info = info)
        else:
            cmd = prime_cmd(op_type.add, tmp, self, a.pack(), info = info)
        tmp.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        return tmp

    def __sub__(self, a):
        info = global_sb.get_info()
        assert(isinstance(a, (int, str, data_base)))
        tmp = bits(w = self.max_w(a) + 1, auto_gen = 1)
        if (isinstance(a, (int, str))):
            tmp_a_vl = value(a, w = self.gen_value_w(a))
            cmd = prime_cmd(op_type.sub, tmp, self, tmp_a_vl, info = info)
        else:
            cmd = prime_cmd(op_type.sub, tmp, self, a.pack(), info = info)
        tmp.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        return tmp

    def __mul__(self, a):
        info = global_sb.get_info()
        assert(isinstance(a, (int, str, data_base)))
        if (isinstance(a, (int, str))):
            tmp_a_vl = value(a)
            tmp = bits(w = self.get_w() + tmp_a_vl.get_w(), auto_gen = 1)
            cmd = prime_cmd(op_type.mul, tmp, self, tmp_a_vl, info = info)
        else:
            tmp = bits(w = self.get_w() + a.get_w(), auto_gen = 1)
            cmd = prime_cmd(op_type.mul, tmp, self, a.pack(), info = info)
        tmp.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        return tmp

    def __floordiv__(self, a):
        info = global_sb.get_info()
        assert(isinstance(a, (int, str, data_base)))
        tmp = bits(w = self.max_w(a), auto_gen = 1)
        if (isinstance(a, (int, str))):
            tmp_a_vl = value(a)
            cmd = prime_cmd(op_type.div, tmp, self, tmp_a_vl, info = info)
        else:
            cmd = prime_cmd(op_type.div, tmp, self, a.pack(), info = info)
        tmp.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        return tmp
    
    def __truediv__(self, a):
        return self.__floordiv__(a)

    def __mod__(self, a):
        info = global_sb.get_info()
        assert(isinstance(a, (int, str, data_base)))
        tmp = bits(w = self.max_w(a), auto_gen = 1)
        if (isinstance(a, (int, str))):
            tmp_a_vl = value(a)
            cmd = prime_cmd(op_type.mod, tmp, self, tmp_a_vl, info = info)
        else:
            cmd = prime_cmd(op_type.mod, tmp, self, a.pack(), info = info)
        tmp.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        return tmp

    def __pow__(self, a):
        info = global_sb.get_info()
        assert(isinstance(a, (int, str, data_base)))
        tmp = bits(w = self.max_w(a), auto_gen = 1)
        if (isinstance(a, (int, str))):
            tmp_a_vl = value(a)
            cmd = prime_cmd(op_type.pow, tmp, self, tmp_a_vl, info = info)
        else:
            cmd = prime_cmd(op_type.pow, tmp, self, a.pack(), info = info)
        tmp.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        return tmp

    def __lshift__(self, a):
        info = global_sb.get_info()
        assert(isinstance(a, (int, str, data_base)))
        if isinstance(a, (int)):
            add_w = a
        elif isinstance(a, value):
            add_w = a.vl__
        else:
            add_w = 2**a.get_w() - 1
        tmp = bits(w = self.get_w() + add_w, auto_gen = 1)
        if (isinstance(a, (int, str))):
            tmp_a_vl = value(a)
            cmd = prime_cmd(op_type.sl_l, tmp, self, tmp_a_vl, info = info)
        else:
            cmd = prime_cmd(op_type.sl_l, tmp, self, a.pack(), info = info)
        tmp.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        return tmp

    def __rshift__(self, a):
        info = global_sb.get_info()
        assert(isinstance(a, (int, str, data_base)))
        if (self.signed_flag__ == 1):
            return self.rshift_a(a)

        op = op_type.sr_l
        if (isinstance(a, (int, str))):
            tmp0 = bits(w = self.get_w(), auto_gen = 1)
            tmp_a_vl = value(a)
            cmd = prime_cmd(op, tmp0, self, tmp_a_vl, info = info)
            tmp0.cmd_q.append(cmd)
            global_sb.push_cmd(cmd)
            #zero extend msb will be removed
            res_w = max(self.get_w() - tmp_a_vl.get_v(), 1)
            if (res_w < tmp0.get_w()):
                tmp = bits(w = res_w, auto_gen = 1)
                tmp /= tmp0
            else:
                tmp = tmp0
        else:
            tmp = bits(w = self.get_w(), auto_gen = 1)
            cmd = prime_cmd(op, tmp, self, a.pack(), info = info)
            tmp.cmd_q.append(cmd)
            global_sb.push_cmd(cmd)
        return tmp

    def __radd__(self, a):
        info = global_sb.get_info()
        assert(isinstance(a, (int, str, data_base)))
        tmp = bits(w = self.max_w(a) + 1, auto_gen = 1)
        if (isinstance(a, (int, str))):
            tmp_a_vl = value(a, w = self.gen_value_w(a))
            cmd = prime_cmd(op_type.add, tmp, tmp_a_vl, self, info = info)
        else:
            cmd = prime_cmd(op_type.add, tmp, a.pack(), self, info = info)
        tmp.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        return tmp

    def __rsub__(self, a):
        info = global_sb.get_info()
        assert(isinstance(a, (int, str, data_base)))
        tmp = bits(w = self.max_w(a) + 1, auto_gen = 1)
        if (isinstance(a, (int, str))):
            tmp_a_vl = value(a, w = self.gen_value_w(a))
            cmd = prime_cmd(op_type.sub, tmp, tmp_a_vl, self, info = info)
        else:
            cmd = prime_cmd(op_type.sub, tmp, a.pack(), self, info = info)
        tmp.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        return tmp

    def __rmul__(self, a):
        info = global_sb.get_info()
        assert(isinstance(a, (int, str, data_base)))
        if (isinstance(a, (int, str))):
            tmp_a_vl = value(a)
            tmp = bits(w = self.get_w() + tmp_a_vl.get_w(), auto_gen = 1)
            cmd = prime_cmd(op_type.mul, tmp, tmp_a_vl, self, info = info)
        else:
            tmp = bits(w = self.get_w() + a.get_w(), auto_gen = 1)
            cmd = prime_cmd(op_type.mul, tmp, a.pack(), self, info = info)
        tmp.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        return tmp

    def __rdiv__(self, a):
        info = global_sb.get_info()
        assert(isinstance(a, (int, str, data_base)))
        tmp = bits(w = self.max_w(a), auto_gen = 1)
        if (isinstance(a, (int, str))):
            tmp_a_vl = value(a)
            cmd = prime_cmd(op_type.div, tmp, tmp_a_vl, self, info = info)
        else:
            cmd = prime_cmd(op_type.div, tmp, a.pack(), self, info = info)
        tmp.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        return tmp

    def __rmod__(self, a):
        info = global_sb.get_info()
        assert(isinstance(a, (int, str, data_base)))
        tmp = bits(w = self.max_w(a), auto_gen = 1)
        if (isinstance(a, (int, str))):
            tmp_a_vl = value(a)
            cmd = prime_cmd(op_type.mod, tmp, tmp_a_vl, self, info = info)
        else:
            cmd = prime_cmd(op_type.mod, tmp, a.pack(), self, info = info)
        tmp.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        return tmp

    def __rpow__(self, a):
        info = global_sb.get_info()
        assert(isinstance(a, (int, str, data_base)))
        tmp = bits(w = self.max_w(a), auto_gen = 1)
        if (isinstance(a, (int, str))):
            tmp_a_vl = value(a)
            cmd = prime_cmd(op_type.pow, tmp, tmp_a_vl, self, info = info)
        else:
            cmd = prime_cmd(op_type.pow, tmp, a.pack(), self, info = info)
        tmp.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        return tmp

    def __rlshift__(self, a):
        info = global_sb.get_info()
        assert(isinstance(a, (int, str, data_base)))
        if isinstance(a, (int)):
            new_w = value(a).get_w() + 2**self.get_w()
        else:
            new_w = a.get_w() + 2**self.get_w()
        tmp = bits(w = new_w, auto_gen = 1)
        if (isinstance(a, (int, str))):
            tmp_a_vl = value(a)
            cmd = prime_cmd(op_type.sl_l, tmp, tmp_a_vl, self, info = info)
        else:
            cmd = prime_cmd(op_type.sl_l, tmp, a.pack(), self, info = info)
        tmp.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        return tmp

    def __rrshift__(self, a):
        info = global_sb.get_info()
        assert(isinstance(a, (int, str, data_base)))
        if isinstance(a, (int)):
            new_w = value(a).get_w()
        else:
            new_w = a.get_w()
        tmp = bits(w = new_w, auto_gen = 1)
        if (isinstance(a, (int, str))):
            tmp_a_vl = value(a)
            cmd = prime_cmd(op_type.sr_l, tmp, tmp_a_vl, self, info = info)
        else:
            cmd = prime_cmd(op_type.sr_l, tmp, a.pack(), self, info = info)
        tmp.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        return tmp

    def __call__(self, a):
        assert(0), "should not call"
        return self

    def __idiv__(self, a):
        self.__itruediv__(a)

    def __itruediv__(self, a):
        super(bits, self).__itruediv__(a)
        info = global_sb.get_info()
        assert(isinstance(a, (int, str, data_base)))
        #in if_else block, should define bits var into reg type
        if (global_sb.current.type_if_else):
            assert(not isinstance(self, (inp, outp)))
            if (self.auto_gen == 0):
                self.defi_reg = 1
                if (self.type_reg):
                    self.i.defi_reg = 1
        elif (global_sb.vblk_cnt > 0):
            assert(not isinstance(self, (inp, outp))), "should not assign to input/output in vblk context"
            if (self.auto_gen == 0):
                self.defi_reg = 1
                if (self.type_reg):
                    self.i.defi_reg = 1

        #process when
        if (global_sb.when_cnt > self.when_cnt):
            tmp_a = bits(w = self.get_w())
            cmd_last = self.cmd_q[-1]
            t_last = self.get_last_cmd().s0 #last time's assign value
            if (cmd_last.op == op_type.defi):
                if (cmd_last.t.type_reg):
                    t_last = cmd_last.t
                else:
                    t_last = a
            tmp_c = reduce(lambda x,y: x & y, global_sb.when_stack[self.when_cnt:])
            if (self.slc_get == []):
                tmp_a.assign(mux(tmp_c, a, t_last))
            else:
                tmp_a.assign(mux(tmp_c, a, t_last[self.slc_get[-1]]))
            a = tmp_a

        return self.assign(a)

    def assign(self, a):
        info = global_sb.get_info()
        assert(isinstance(a, (int, str, data_base)))
        if (isinstance(a, (int, str))):
            self.vl = value(a, w = self.gen_value_w(a));
            cmd = prime_cmd(op_type.immd, self, self.vl, info = info)
            self.cmd_q.append(cmd)
            global_sb.push_cmd(cmd)
        elif (isinstance(a, list)):
            tmp = reduce(cat2,a)
            if (tmp.get_w() > self.get_w()):
                tmp_fix = bits(w = self.get_w(), auto_gen = 1)
                tmp_fix /= tmp[self.get_w() - 1 : 0]
            else:
                tmp_fix = tmp
            cmd = prime_cmd(op_type.copy, self, tmp_fix, info = info)
            self.cmd_q.append(cmd)
            global_sb.push_cmd(cmd)
        else:
            if isinstance(a, bundle):
                new_a = a.pack()
            else:
                new_a = a
            if (new_a.get_w() > self.get_w()):
                new_a_fix = bits(w = self.get_w(), auto_gen = 1)
                new_a_fix /= new_a[self.get_w() - 1 : 0]
            else:
                new_a_fix = new_a
            cmd = prime_cmd(op_type.copy, self, new_a_fix, info = info)
            self.cmd_q.append(cmd)
            global_sb.push_cmd(cmd)
        return self

    def __and__(self, a):
        info = global_sb.get_info()
        assert(isinstance(a, (int, str, data_base)))
        tmp = bits(w = self.max_w(a), auto_gen = 1)
        if (isinstance(a, (int, str))):
            tmp_a_vl = value(a, w = self.gen_value_w(a))
            cmd = prime_cmd(op_type.and_t, tmp, self, tmp_a_vl, info = info)
        else:
            cmd = prime_cmd(op_type.and_t, tmp, self, a.pack(), info = info)
        tmp.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        return tmp

    def __xor__(self, a):
        info = global_sb.get_info()
        assert(isinstance(a, (int, str, data_base)))
        tmp = bits(w = self.max_w(a), auto_gen = 1)
        if (isinstance(a, (int, str))):
            tmp_a_vl = value(a, w = self.gen_value_w(a))
            cmd = prime_cmd(op_type.xor, tmp, self, tmp_a_vl, info = info)
        else:
            cmd = prime_cmd(op_type.xor, tmp, self, a.pack(), info = info)
        tmp.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        return tmp

    def __or__(self, a):
        info = global_sb.get_info()
        assert(isinstance(a, (int, str, data_base)))
        tmp = bits(w = self.max_w(a), auto_gen = 1)
        if (isinstance(a, (int, str))):
            tmp_a_vl = value(a, w = self.gen_value_w(a))
            cmd = prime_cmd(op_type.or_t, tmp, self, tmp_a_vl, info = info)
        else:
            cmd = prime_cmd(op_type.or_t, tmp, self, a.pack(), info = info)
        tmp.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        return tmp

    def __rand__(self, a):
        info = global_sb.get_info()
        assert(isinstance(a, (int, str, data_base)))
        tmp = bits(w = self.max_w(a), auto_gen = 1)
        if (isinstance(a, (int, str))):
            tmp_a_vl = value(a, w = self.gen_value_w(a))
            cmd = prime_cmd(op_type.and_t, tmp, tmp_a_vl, self, info = info)
        else:
            cmd = prime_cmd(op_type.and_t, tmp, a.pack(), self, info = info)
        tmp.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        return tmp

    def __rxor__(self, a):
        info = global_sb.get_info()
        assert(isinstance(a, (int, str, data_base)))
        tmp = bits(w = self.max_w(a), auto_gen = 1)
        if (isinstance(a, (int, str))):
            tmp_a_vl = value(a, w = self.gen_value_w(a))
            cmd = prime_cmd(op_type.xor, tmp, tmp_a_vl, self, info = info)
        else:
            cmd = prime_cmd(op_type.xor, tmp, a.pack(), self, info = info)
        tmp.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        return tmp

    def __ror__(self, a):
        info = global_sb.get_info()
        assert(isinstance(a, (int, str, data_base)))
        tmp = bits(w = self.max_w(a), auto_gen = 1)
        if (isinstance(a, (int, str))):
            tmp_a_vl = value(a, w = self.gen_value_w(a))
            cmd = prime_cmd(op_type.or_t, tmp, tmp_a_vl, self, info = info)
        else:
            cmd = prime_cmd(op_type.or_t, tmp, a.pack(), self, info = info)
        tmp.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        return tmp

    def __rfloordiv__(self, a):
        info = global_sb.get_info()
        assert(isinstance(a, (int, str, data_base)))
        tmp = bits(w = self.max_w(a), auto_gen = 1)
        if (isinstance(a, (int, str))):
            tmp_a_vl = value(a)
            cmd = prime_cmd(op_type.div, tmp, tmp_a_vl, self, info = info)
        else:
            cmd = prime_cmd(op_type.div, tmp, a.pack(), self, info = info)
        tmp.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        return tmp

    def __rtruediv__(self, a):
        return self.__rfloordiv__(a)

    def __invert__(self):
        info = global_sb.get_info()
        tmp = bits(w = self.get_w(), auto_gen = 1)
        cmd = prime_cmd(op_type.inv, tmp, self, info = info)
        tmp.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        return tmp

    def __neg__(self):
        info = global_sb.get_info()
        tmp = bits(w = self.get_w(), auto_gen = 1)
        cmd = prime_cmd(op_type.neg, tmp, self, info = info)
        tmp.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        return tmp

    def __eq__(self, a):
        assert(isinstance(a, (int, str, data_base)))
        if isinstance(a, bit_pat):
            return a == self

        info = global_sb.get_info()
        tmp = bits(w = 1, auto_gen = 1)
        if (isinstance(a, (int, str))):
            tmp_a_vl = value(a, w = self.gen_value_w(a))
            cmd = prime_cmd(op_type.eq, tmp, self, tmp_a_vl, info = info)
        else:
            cmd = prime_cmd(op_type.eq, tmp, self, a.pack(), info = info)
        tmp.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        return tmp

    def __ne__(self, a):
        assert(isinstance(a, (int, str, data_base)))
        if isinstance(a, bit_pat):
            return a != self
        info = global_sb.get_info()
        tmp = bits(w = 1, auto_gen = 1)
        if (isinstance(a, (int, str)) ):
            tmp_a_vl = value(a, w = self.gen_value_w(a))
            cmd = prime_cmd(op_type.ne, tmp, self, tmp_a_vl, info = info)
        else:
            cmd = prime_cmd(op_type.ne, tmp, self, a.pack(), info = info)
        tmp.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        return tmp

    def __gt__(self, a):
        info = global_sb.get_info()
        assert(isinstance(a, (int, str, data_base)))
        tmp = bits(w = 1, auto_gen = 1)
        if (isinstance(a, (int, str))):
            tmp_a_vl = value(a, w = self.gen_value_w(a))
            cmd = prime_cmd(op_type.gt, tmp, self, tmp_a_vl, info = info)
        else:
            cmd = prime_cmd(op_type.gt, tmp, self, a.pack(), info = info)
        tmp.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        return tmp

    def __lt__(self, a):
        info = global_sb.get_info()
        assert(isinstance(a, (int, str, data_base)))
        tmp = bits(w = 1, auto_gen = 1)
        if (isinstance(a, (int, str))):
            tmp_a_vl = value(a, w = self.gen_value_w(a))
            cmd = prime_cmd(op_type.lt, tmp, self, tmp_a_vl, info = info)
        else:
            cmd = prime_cmd(op_type.lt, tmp, self, a.pack(), info = info)
        tmp.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        return tmp

    def __ge__(self, a):
        info = global_sb.get_info()
        assert(isinstance(a, (int, str, data_base)))
        tmp = bits(w = 1, auto_gen = 1)
        if (isinstance(a, (int, str))):
            tmp_a_vl = value(a, w = self.gen_value_w(a))
            cmd = prime_cmd(op_type.ge, tmp, self, tmp_a_vl, info = info)
        else:
            cmd = prime_cmd(op_type.ge, tmp, self, a.pack(), info = info)
        tmp.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        return tmp

    def __le__(self, a):
        info = global_sb.get_info()
        assert(isinstance(a, (int, str, data_base)))
        tmp = bits(w = 1, auto_gen = 1)
        if (isinstance(a, (int, str))):
            tmp_a_vl = value(a, w = self.gen_value_w(a))
            cmd = prime_cmd(op_type.le, tmp, self, tmp_a_vl, info = info)
        else:
            cmd = prime_cmd(op_type.le, tmp, self, a.pack(), info = info)
        tmp.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        return tmp

    def __getitem__(self,index):
        info = global_sb.get_info()
        if (isinstance(index,slice)):
            slc = index
        else:
            slc = slice(index,index,None)

        if isinstance(slc.start, (int)):
            if (slc.start == slc.stop - 1): #same as chisel
                return value(0).to_bits()

        if (isinstance(slc.start,(int)) and isinstance(slc.stop,(int))):
            if ((slc.start == self.get_w() - 1) and slc.stop == 0):
                return self

        if (isinstance(index,bits)):
            tmp = bits(w = index.get_w(), auto_gen = 1)
            cmd = prime_cmd(op_type.copy, tmp, index, info = info)
            tmp.cmd_q.append(cmd)
            global_sb.push_cmd(cmd)
            slc = slice(tmp,tmp,None)
        else: #check width
            assert(slc.start >= 0)
            assert(slc.start < self.get_w())
            assert(slc.stop >= 0)
            assert(slc.stop < self.get_w())

        self.slc_get.append(slc)

        if isinstance(slc.start, bits):
            tmp = bits(w = 1, auto_gen = 1)
            if (self.get_w() < 2**slc.start.get_w()):
                self.slc_get.pop(0)
                tmp_s = bits(w = 2**slc.start.get_w())
                tmp_s.__itruediv__(cat2(
                    value(0, w = 2**slc.start.get_w() - self.get_w()),
                    self))
                tmp_s.slc_get.append(slc)
            else:
                tmp_s = self
            cmd = prime_cmd(op_type.copy, tmp, tmp_s, info = info)
        else:
            tmp = bits(w = abs(slc.start - slc.stop) + 1, auto_gen = 1)
            cmd = prime_cmd(op_type.copy, tmp, self, info = info)

        tmp.slc__ = slc
        tmp.getitem_cmd = cmd
        tmp.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        return tmp

    def __setitem__(self,k,v):
        assert(isinstance(v, (int, str, data_base)))
        info = global_sb.get_info()
        if (isinstance(k,slice)):
            slc = k
        else:
            slc = slice(k,k,None)

        if (isinstance(slc.start,(int)) and isinstance(slc.stop,(int))):
            if ((slc.start == self.get_w() - 1) and slc.stop == 0):
                return self

        if (isinstance(k,bits)):
            tmp = bits(w = k.get_w(), auto_gen = 1)
            tmp /= k
            slc = slice(tmp,tmp,None)
        else: #check width
            assert(slc.start >= 0)
            assert(slc.start < self.get_w())
            assert(slc.stop >= 0)
            assert(slc.stop < self.get_w())

        self.slc_get.append(slc)

        self /= v
        return self

    def rshift_a(self, a):
        info = global_sb.get_info()
        assert(isinstance(a, (int, str, data_base)))
        assert(self.signed_flag__ == 1)
        tmp = bits(w = self.get_w(), auto_gen = 1)
        if (isinstance(a, (int, str))):
            tmp_a_vl = value(a)
            cmd = prime_cmd(op_type.sr_a, tmp, self, tmp_a_vl, info = info)
        else:
            cmd = prime_cmd(op_type.sr_a, tmp, self, a.pack(), info = info)
        tmp.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        return tmp

    def rep(self, n):
        assert(isinstance(n, int))
        info = global_sb.get_info()
        tmp = bits(w = self.get_w() * n, auto_gen = 1)
        tmp_n_vl = value(n)
        cmd = prime_cmd(op_type.rep, tmp, tmp_n_vl, self, info = info)
        tmp.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        return tmp

    def rep_each_bit(self, n):
        return cat_rvs(map(lambda _: self[_].rep(n), range(self.get_w())))

    def r_and(self):
        info = global_sb.get_info()
        tmp = bits(w = 1, auto_gen = 1)
        cmd = prime_cmd(op_type.r_and, tmp, self, info = info)
        tmp.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        return tmp

    def r_or(self):
        info = global_sb.get_info()
        tmp = bits(w = 1, auto_gen = 1)
        cmd = prime_cmd(op_type.r_or, tmp, self, info = info)
        tmp.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        return tmp

    def r_xor(self):
        info = global_sb.get_info()
        tmp = bits(w = 1, auto_gen = 1)
        cmd = prime_cmd(op_type.r_xor, tmp, self, info = info)
        tmp.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        return tmp

    ## Fill 1s from low bits to high bits
    #rewrite from chisel
    def lsb_or(self, cap = None):
        width = self.get_w()
        if (cap is None):
            stop = width
        else:
            stop = min(width, cap)
        def helper(s, x):
            return x if (s >= stop) else helper(s+s, x | (x << s)[width-1:0])
        return helper(1, self)[width-1: 0]
    
    ## Fill 1s form high bits to low bits
    #rewrite from chisel
    def msb_or(self, cap = None):
        width = self.get_w()
        if (cap is None):
            stop = width
        else:
            stop = min(width, cap)
        def helper(s, x):
            return x if (s >= stop) else helper(s+s, x | (x >> s))
        return helper(1, self)[width-1: 0]

    def is_log2(self, width = 0):
        if (width == 0):
            width = self.get_w()
        def divideAndConquerThreshold():
            return 4
        if (width < 2):
            return 0
        elif (width == 2):
            return self[1]
        elif (width <= divideAndConquerThreshold()):
            return mux(self[width-1], width-1, self.is_log2(width-1))
        else:
            mid = 1 << (log2_ceil(width) - 1)
            hi = self[width-1: mid]
            lo = self[mid-1: 0]
            useHi = hi.r_or()
            return cat([useHi, mux(useHi, hi.is_log2(width - mid), lo.is_log2(mid))])

class reg(bits):
    def __init__(self, name = '', w = 1, next = None, clock_edge = 'posedge', **args):
        super(reg,self).__init__(name, w, next)
        self.type_reg = 1
        if (global_sb.current.io.default_clock != []):
            self.clock = global_sb.current.io.default_clock[0]
        if (global_sb.current.io.default_reset != []):
            self.reset = global_sb.current.io.default_reset[0]
        for key in args:
            if (key == 'clock'):
                self.clock = args[key]
            elif (key == 'reset'):
                if (global_sb.current.io.default_reset != []):
                    self.reset = args[key]
            else:
                assert(0), "illegal args %s" % key
        self.reset_level = global_sb.current.pm.reset_level
        self.reset_sync = global_sb.current.pm.reset_sync
        self.reset.reset_level = global_sb.current.pm.reset_level
        self.reset.reset_sync = global_sb.current.pm.reset_sync
        self.clock_edge = clock_edge
        self.i = bits(self.name+'_i', w = w)
        self.o = bits(self.name+'_o', w = w)
        self.o.defi_reg = 1

    def set_her_name(self,name):
        super(reg, self).set_her_name(name)
        self.i.set_her_name(name)
        self.o.set_her_name(name)

class reg_r(reg):
    def __init__(self, name = '', w = 1, next = None, **args):
        super(reg_r,self).__init__(name, w, next, **args)
        self.rs_vl = value(0, w = self.get_w())

class reg_s(reg):
    def __init__(self, name = '', w = 1, next = None, **args):
        super(reg_s,self).__init__(name, w, next, **args)
        tmp_str = "0b"
        for i in range(self.get_w()):
            tmp_str += '1'
        self.rs_vl = value(int(tmp_str,2))

class reg_rs(reg):
    def __init__(self, name = '', rs = 0, w = 1, next = None, **args):
        super(reg_rs,self).__init__(name, w, next, **args)
        if (isinstance(rs, (int, str))):
            self.rs_vl = value(rs, w = self.get_w())
        else:
            self.rs_vl = rs

class reg_en(reg):
    def __init__(self, name = '', w = 1, next = None, en = None, **args):
        super(reg_en,self).__init__(name, w, next, **args)
        self.en = bits(self.name+'_en')
        if (en is not None):
            self.en /= en

    def set_her_name(self,name):
        super(reg_en, self).set_her_name(name)
        self.en.set_her_name(name)

class reg_en_r(reg_en):
    def __init__(self, name = '', w = 1, next = None, en = None, **args):
        super(reg_en_r,self).__init__(name, w, next, en, **args)
        self.rs_vl = value(0)

class reg_en_s(reg_en):
    def __init__(self, name = '', w = 1, next = None, en = None, **args):
        super(reg_en_s,self).__init__(name, w, next, en, **args)
        tmp_str = "0b"
        for i in range(self.get_w()):
            tmp_str += '1'
        self.rs_vl = value(int(tmp_str,2))

class reg_en_rs(reg_en):
    def __init__(self, name = '', rs = 0, w = 1, next = None, en = None, **args):
        super(reg_en_rs,self).__init__(name, w, next, en, **args)
        if (isinstance(rs, (int, str))):
            self.rs_vl = value(rs, w = self.get_w())
        else:
            self.rs_vl = rs

class inp(bits):
    def __init__(self, name, w = 1):
        super(inp,self).__init__(name, w)
        self.type_ioport = 1
        self.is_clock = 0
        self.is_reset = 0
        self.flipped = 0
        self.inout = 0

    def flip(self):
        self.flipped = 1
        return self

class outp(bits):
    def __init__(self, name, w = 1):
        super(outp,self).__init__(name, w)
        self.type_ioport = 1
        self.is_clock = 0
        self.is_reset = 0
        self.flipped = 0
        self.inout = 0

    def flip(self):
        self.flipped = 1
        return self

class inoutp(outp):
    def __init__(self, name, w = 1):
        super(inoutp,self).__init__(name, w)
        self.is_clock = 0
        self.is_reset = 0
        self.flipped = 0
        self.inout = 1


class vlist(data_base):
    def __init__(self, name = '', w = 1):
        super(vlist, self).__init__(name)
        info = global_sb.get_info()

        self.w__ = w
        cmd = prime_cmd(op_type.vlist_defi, self, None, None, None, info)
        self.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)

    def append(self, a):
        info = global_sb.get_info()
        if (isinstance(a, (inp, outp, reg))):
            new_a = bits(w = a.get_w(), init = a, auto_gen = 1) 
        elif (isinstance(a, (int))):
            new_a = value(a)
        else:
            new_a = a

        cmd = prime_cmd(op_type.vlist_append, self, new_a, None, None, info)
        self.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)

    def pop(self):
        info = global_sb.get_info()

        tmp = bits(w = self.get_w())
        cmd = prime_cmd(op_type.vlist_pop, tmp, self, None, None, info)
        self.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)
        return tmp

class bundle_base(data_base):
    def __init__(self,name = '', init = None, p = None, **args):
        super(bundle_base, self).__init__(name)
        self.her_name = ''
        self.parent = global_sb.current
        self.p = parameter('p')
        self.v__ = {}
        self.seq__ = []
        self.set_var_done = 0
        self.set_par()
        #for key in self.p.p__:
        #    print("%s set_par with p__[%s] = %s" % (self.name, key, self.p[key]))
        for key in args:
            self.p.par(key, args[key])
            #print("%s overwrite with p[%s] = %s" % (name, key,self.p[key]))
        if (p is not None):
            self.p = p
        self.check_par()
        self.set_var()
        self.set_var_done = 1
        self.set_her_name(self.name)

        if (init is not None):
            self.__itruediv__(init)

        self.default_clock = []
        self.default_reset = []

    def check_par(self):
        pass

    def delete_cmd(self):
        for i in self.seq__:
            i.delete_cmd()

    def change_name(self,name):
        self.name = name
        return self

    def get_w(self):
        tmp = 0
        for i in self.seq__:
            if isinstance(i, data_base):
                tmp = tmp + i.get_w()
        return tmp

    def set_var(self):
        pass

    def set_par(self):
        pass

    def var_append(self,a):
        assert(
            a.name not in self.v__.keys()), "name %s conflict %s" % (a.name, self.v__.keys())
        self.v__[a.name] = a
        self.seq__.append(a)
        return a

    def var_her_name(self,a):
        if (self.set_var_done):
            self.v__[a.name].set_her_name(self.name)

    def var(self, a):
        self.var_append(a)
        self.var_her_name(a)
        return a

    def set_her_name(self,name):
        for i in self.v__:
            if (isinstance(self.v__[i], bits)):
                self.v__[i].set_her_name(name)
            elif (isinstance(self.v__[i], bundle_base)):
                self.v__[i].set_her_name(name)

    def reset_her_name(self, name):
        self.clean_her_name()
        for i in self.v__:
            if (isinstance(self.v__[i], bits)):
                self.v__[i].set_her_name(name)
            elif (isinstance(self.v__[i], bundle_base)):
                self.v__[i].reset_her_name(name + '_' + self.v__[i].name)

    def clean_her_name(self):
        self.her_name = ''
        for i in self.v__.values():
            i.clean_her_name()

    def __getitem__(self,index):
        assert(
            isinstance(index,(int, str))), "index must be string or int"
        if isinstance(index,(int)):
            return self.seq__[index]
        else:
            assert(index in self.v__)
            return self.v__[index]

    def __setitem__(self,k,v):
        return self

    def __getattr__(self,attr):
        if (attr in self.v__):
            return self.v__[attr]
        else:
            return self.__dict__[attr]

    def __idiv__(self, a):
        self.__itruediv__(a)

    def __itruediv__(self, a):
        super(bundle_base, self).__itruediv__(a)
        if (isinstance(a, (int,str))):
            new_a = bits(w = self.get_w())
            new_a /= value(a, w = self.get_w())
        elif isinstance(a, value):
            new_a = bits(w = self.get_w())
            new_a /= a
        else:
            new_a = a
        self_w = self.get_w()
        cur_msb = self.get_w()
        cur_lsb = 0
        a_w = new_a.get_w()
        if (len(self) == 0):
            pass
        if isinstance(self, vec_base):
            seq_new = self.seq__
        else:
            seq_new = list(reversed(self.seq__))
        for i in seq_new:
            if not isinstance(i, data_base):
                continue
            if (i.get_w() == 0):
                continue
            if isinstance(new_a, bits):
                if (cur_lsb >= a_w):
                    break
                if (new_a.get_w() == 1):
                    tmp = new_a
                else:
                    tmp = new_a[i.get_w() - 1 + cur_lsb: cur_lsb]
                cur_lsb = cur_lsb + i.get_w()
            else:
                #only connect share var
                if (i.name in new_a.v__.keys()):
                    tmp = new_a.v__[i.name]
                else:
                    continue
            if isinstance(i, bits):
                #self input port
                if (
                    (isinstance(i,inp) and i.flipped == 0) or 
                    (isinstance(i,outp) and i.flipped == 1)):
                    # assign to current module's port
                    if (i.parent == global_sb.current):
                        tmp.__itruediv__(i)
                    else:
                        i.__itruediv__(tmp)
                #self output port
                elif (
                    (isinstance(i,outp) and i.flipped == 0) or 
                    (isinstance(i,inp) and i.flipped == 1)):
                    # assign to current module's port
                    if (i.parent == global_sb.current):
                        i.__itruediv__(tmp)
                    else:
                        tmp.__itruediv__(i)
                #target input port
                elif (
                    (isinstance(tmp,inp) and tmp.flipped == 0) or 
                    (isinstance(tmp,outp) and tmp.flipped == 1)):
                    # assign to current module's port
                    if (tmp.parent != global_sb.current):
                        tmp.__itruediv__(i)
                    else:
                        i.__itruediv__(tmp)
                #target output port
                elif (
                    (isinstance(tmp,outp) and tmp.flipped == 0) or 
                    (isinstance(tmp,inp) and tmp.flipped == 1)):
                    # assign to current module's port
                    if (tmp.parent != global_sb.current):
                        i.__itruediv__(tmp)
                    else:
                        tmp.__itruediv__(i)
                else:
                    i.__itruediv__(tmp)
            elif isinstance(i, bundle):
                i.__itruediv__(tmp)
        return self

    def seq_filter(self):
        return list(filter(
            lambda _: _ is not None, 
            list(map(
                lambda _: _.pack(),
                list(filter(
                    lambda _: isinstance(_, data_base),
                    self.seq__))))))
    def pack(self):
        tmp_q = self.seq_filter()
        if isinstance(self, vec_base):
            tmp_q = list(reversed(tmp_q))
        if (len(tmp_q) == 0):
            return None
        else:
            return reduce(cat2,tmp_q)

    def pack_next(self):
        tmp_q = self.seq_filter()
        if isinstance(self, vec_base):
            tmp_q = list(reversed(tmp_q))
        if (len(tmp_q) == 0):
            return None
        else:
            return reduce(cat2,list(map(lambda _:_.i, tmp_q)))

    def __iter__(self):
        return iter(self.seq__)

    def __len__(self):
        return len(self.seq__)


class bundle(bundle_base):
    def as_bits(self):
        old_vars = self.seq__
        self.v__ = {}
        self.seq__ = []
        for i in old_vars:
            tmp_var = i.as_bits()
            #no need set new her_name in self.var(), should call self.var_append()
            self.var_append(tmp_var)
        return self

    def as_input(self):
        old_vars = self.seq__
        self.v__ = {}
        self.seq__ = []
        for i in old_vars:
            tmp_var = i.as_input()
            #no need set new her_name in self.var(), should call self.var_append()
            self.var_append(tmp_var)
        return self

    def as_output(self):
        old_vars = self.seq__
        self.v__ = {}
        self.seq__ = []
        for i in old_vars:
            tmp_var = i.as_output()
            #no need set new her_name in self.var(), should call self.var_append()
            self.var_append(tmp_var)
        return self

    def to_inout(self):
        for i in self.seq__:
            i.to_inout()
        return self

    def as_reg(self, tp = 'reg', rs = 0, en = None, next = None, **args):
        old_vars = self.seq__
        self.v__ = {}
        self.seq__ = []
        for i in old_vars:
            if isinstance(rs, bundle):
                tmp_var = i.as_reg(tp, rs = rs[i.name], en = en, **args)
            else:
                tmp_var = i.as_reg(tp, rs = rs, en = en, **args)

            #no need set new her_name in self.var(), should call self.var_append()
            self.var_append(tmp_var)
        if (next is not None):
            self.__itruediv__(next)
        return self

    def add_default_clock(self, a = None):
        if (a is None):
            clk_name = 'clock'
        else:
            assert(isinstance(a, str)), "a must be str type"
            clk_name = a
        self.var(inp(clk_name))
        self[clk_name].is_clock = 1
        self[clk_name].clean_her_name()
        self.default_clock.append(self[clk_name])
        return self.default_clock[-1]
    
    def clock_remove(self):
        for i in range(len(self.default_clock)):
            self.default_clock[i].delete_cmd()
            self.v__.pop(self.default_clock[i].name)
            self.seq__.remove(self.default_clock[i])

    def clock_rebind(self, a):
        self.clock_remove()
        a.is_clock = 1
        self.default_clock.append(a)

    def add_default_reset(self, a = None, reset_level = 1, reset_sync = 0):
        if (a is None):
            reset_name = 'reset'
        else:
            assert(isinstance(a, str)), "a must be str type"
            reset_name = a
        self.var(inp(reset_name))
        self[reset_name].is_reset = 1
        self[reset_name].reset_level = reset_level
        self[reset_name].reset_sync = reset_sync
        self[reset_name].clean_her_name()
        self.default_reset.append(self[reset_name])
        return self.default_reset[-1]

    def reset_remove(self):
        for i in range(len(self.default_reset)):
            self.default_reset[i].delete_cmd()
            self.v__.pop(self.default_reset[i].name)
            self.seq__.remove(self.default_reset[i])

    def reset_rebind(self, a, reset_level = 1, reset_sync = 0):
        self.reset_remove()
        a.is_reset = 1
        a.reset_level = reset_level
        a.reset_sync = reset_sync
        self.default_reset.append(a)
    
    def flip(self):
        for i in self.v__:
            if (isinstance(self.v__[i], bundle)):
                self.v__[i].flip()
            #exclude clock and reset
            elif (
                (self.v__[i] not in self.default_clock) and 
                (self.v__[i] not in self.default_reset)):
                self.v__[i].flipped = not self.v__[i].flipped
        return self

    def has_reg(self):
        flag = False
        for i in self.seq__:
            if (isinstance(i, bundle)):
                flag = flag or i.has_reg()
            elif (isinstance(i, reg)):
                flag = flag or True
            if (flag == True):
                break

        return flag
    
    def get_all_inp(self):
        tmp_q = []
        for i in self.seq__:
            if (isinstance(i, bundle) and (not isinstance(i, inout_pin_io))):
                tmp_q.extend(i.get_all_inp())
            elif (
                (isinstance(i,inp) and i.flipped == 0) or 
                (isinstance(i,outp) and i.flipped == 1)):
                tmp_q.append(i)
        return tmp_q

    def get_all_outp(self):
        tmp_q = []
        for i in self.seq__:
            if (isinstance(i, bundle) and (not isinstance(i, inout_pin_io))):
                tmp_q.extend(i.get_all_outp())
            elif (
                (isinstance(i,outp) and i.flipped == 0) or 
                (isinstance(i,inp) and i.flipped == 1)):
                tmp_q.append(i)
        return tmp_q

class vec_base(bundle):
    def idx_write(self, addr, dat):
        assert(isinstance(addr, bits))
        for i in range(len(self)):
            with when(addr == i):
                self.seq__[i] /= dat
        return self

    def oh_write(self, addr_map, dat):
        for i in range(len(self)):
            with when(addr_map[i]):
                self.seq__[i] /= dat
        return self

    def idx_read(self, addr):
        assert(isinstance(addr, bits))
        return sel(addr,self.seq__)

    def oh_read(self, addr_map):
        return sel_oh(addr, self.seq__)

    def __getitem__(self,index):
        if isinstance(index, bits):
            tmp = self.idx_read(index)
            return tmp
        else:
            return super(vec_base, self).__getitem__(index)

    def __setitem__(self,k,v):
        if isinstance(k, (str, int)):
            return super(vec_base, self).__setitem__(k,v)
        else:
            assert(0), "index should not be var, please use __call__"
    
    def __call__(self, addr, data):
        if isinstance(addr, (str, int)):
            e = self.__getitem__(addr)
            e /= data
        else:
            self.idx_write(addr, data)
        return self

class valid_base(bundle):
    def fire(self):
        return self.valid

class ready_valid_base(bundle):
    def fire(self):
        return self.ready & self.valid

class mem(data_base):
    def __init__(self, name, depth, w):
        super(mem, self).__init__(name)
        info = global_sb.get_info()
        self.depth = depth
        self.w__ = w
        self.cmd_q = []
        self.parent = global_sb.current
        self.defi_reg = 1
        self.auto_gen = 0

        cmd = prime_cmd(op_type.defi, self, self, info = info)
        self.cmd_q.append(cmd)
        global_sb.push_cmd(cmd)

    def __getitem__(self,index):
        assert(isinstance(index,slice) == False), "index must be int or signal"
        info = global_sb.get_info()
        if (isinstance(index,slice)):
            slc = index
        else:
            slc = slice(index,index,None)

        if (isinstance(index,bits)):
            tmp = bits(w = index.get_w(), auto_gen = 1)
            cmd = prime_cmd(op_type.copy, tmp, index, info = info)
            tmp.cmd_q.append(cmd)
            global_sb.push_cmd(cmd)
            slc = slice(tmp,tmp,None)
            tmp_str = tmp.name
        else:
            tmp_str = str(index)

        entry = bits(self.name + '[' + tmp_str + ']', w = self.get_w())
        #no need define new wire/reg
        entry.cmd_q.pop()
        global_sb.pop_cmd()
        return entry

    def __setitem__(self,k,v):
        assert(isinstance(k,slice) == False), "k must be int or signal"
        if (global_sb.current.type_if_else):
            self.defi_reg = 1

class inout_pin_io(bundle):
    def set_par(self):
        super(inout_pin_io, self).set_par()
        self.p.par('w', 1)

    def set_var(self):
        super(inout_pin_io, self).set_var()
        self.var(inp('input', w = self.p.w))
        self.var(outp('output', w = self.p.w))
        self.var(outp('oe'))

class inout_pu_pin_io(inout_pin_io):
    def set_var(self):
        super(inout_pu_pin_io, self).set_var()
        self.var(outp('pue'))


class parameter(object):
    def __init__(self,name = 'p', **args):
        self.name = name
        self.parent = global_sb.current
        self.p__ = {}
        self.pseq__ = []
        self.no_cmp__ = {}
        self.vinst = {}
        self.set_par()
        for key in args:
            self.p__[key] = 1
            self.__dict__[key] = args[key]
        self.check_par()

    def all_bases(self, a = None):
        bases = list(type(self).__bases__ if (a is None) else a.__bases__)
        q = list(filter(lambda _: _.__name__ is not 'parameter', bases))
        for i in bases:
            if (i.__name__ is not 'parameter'):
                q.extend(self.all_bases(i))
        return q


    def get_fn(self):
        return self.parent.get_fn() + '.' + self.name

    def set_par(self):
        pass

    def par(self, name, a, no_cmp = 0, vinst = 0):
        self.p__[name] = 1
        self.pseq__.append(name)
        if (no_cmp):
            self.no_cmp__[name] = 1
        if (vinst):
            self.vinst[name] = 1
        self.__dict__[name] = a
        bases = list([self.__class__]) + self.all_bases()
        cfg_all_kv_keys = global_sb.cfg.cfg_all_kv.keys()
        for i in bases:
            if (i.__name__ in cfg_all_kv_keys):
                match_kv = global_sb.cfg.cfg_all_kv[i.__name__]
                match_kv_keys = match_kv.keys()
                if (name in match_kv_keys):
                    #print(
                    #    "cfg_all %s.%s = %s" %(
                    #        self.__class__.__name__, 
                    #        name, global_sb.cfg.cfg_all_kv[i.__name__][name]))
                    self.p__[name] = 1
                    if (not (name in self.p__.keys())):
                        self.pseq__.append(name)
                    self.__dict__[name] = global_sb.cfg.cfg_all_kv[i.__name__][name]
                    break
                
        fn = self.get_fn()
        if (fn in global_sb.cfg.cfg_single_kv.keys()):
            match_kv = global_sb.cfg.cfg_single_kv[fn]
            match_kv_keys = match_kv.keys()
            if (name in match_kv_keys):
                #print(
                #    "cfg_inst %s.%s = %s" %(
                #        fn, name, global_sb.cfg.cfg_single_kv[fn][name]))
                self.p__[name] = 1
                if (not (name in self.p__.keys())):
                    self.pseq__.append(name)
                self.__dict__[name] = global_sb.cfg.cfg_single_kv[fn][name]
        return a

    def merge(self, a):
        assert(isinstance(a, parameter))
        for i in a.p__:
            self.p__[i] = 1
            if (not (i in self.p__.keys())):
                self.pseq__.append(i)
            self.__dict__[i] = a[i]

    def check_par(self):
        pass

    def __getitem__(self,index):
        assert(isinstance(index,str)), "index must be string"
        assert(index in self.p__)
        return self.__dict__[index]

    def __setitem__(self,k,v):
        assert(isinstance(k,str)), "index must be string"
        assert(0)
        self.p__[k] = 1
        if (not (k in self.p__.keys())):
            self.pseq__.append(k)
        self.__dict__[k] = v

    def __getattr__(self,attr):
        return self.__dict__[attr]

    def __eq__(self, a):
        assert(isinstance(a, (
            int,
            str,
            float,
            list,
            parameter)) or a is None), "type a is %s" %(type(a))
        res = True
        if (a is None):
            res = False
        elif (self is a):
            res = True
        elif ((len(self.p__) - len(self.no_cmp__)) != (len(a.p__) - len(a.no_cmp__))):
            res = False
        else:
            for i in self.p__:
                if (i in self.no_cmp__):
                    res = False
                    break
                if (i not in a.p__):
                    res = False
                    break
                if (not isinstance(self.__dict__[i], (int, str, float, list, tuple, dict, parameter))):
                    res = False
                    break
                if (not isinstance(a.__dict__[i], (int, str, float, list, tuple, dict, parameter))):
                    res = False
                    break
                else:
                    if (isinstance(self.__dict__[i], (list, tuple, dict))):
                        res = self.cmp_list(self.__dict__[i], a.__dict__[i])
                        if (res == False):
                            break
                    else:
                        if (self.__dict__[i] != a.__dict__[i]):
                            res = False
                            break
        return res

    def __ne__(self, a):
        return not self.__eq__(a)

    def cmp_list(self, a, b):
        res = True
        if (a is b):
            res = True
        elif (type(a) != type(b)):
            res = False
        elif (len(a) != len(b)):
            res = False
        else:
            if (isinstance(a, dict)):
                loop_range = a.keys()
            else:
                loop_range = range(len(a))
            for i in loop_range:
                if (isinstance(a[i], (list, tuple, dict))):
                    res = self.cmp_list(a[i], b[i])
                    if (res == False):
                        break
                else:
                    if (not isinstance(a[i], (int, str, float, parameter))):
                        res = False
                        break
                    if (isinstance(b, dict) and (i not in b)):
                        res = False
                        break
                    if (not isinstance(b[i], (int, str, float, parameter))):
                        res = False
                        break
                    if (a[i] != b[i]):
                        res = False
                        break
        return res

    def cmp_module(self, a, b):
        return type(a) == type(b) and a.p == b.p and a.pm == b.pm

    def __iter__(self):
        #return iter(self.p__.keys())
        return iter(self.pseq__)

    def __len__(self):
        return len(self.p__)

class module_parameter(parameter):
    def set_par(self):
        super(module_parameter, self).set_par()
        self.par('has_clock', 1)
        self.par('has_reset', 1)
        self.par('clock_name', 'clock')
        self.par('reset_name', 'reset')
        self.par('reset_level', 1)
        self.par('reset_sync', 1)
        self.par('has_assert_syntax', 0)
        self.par('vlib', None)
        self.par('vuser', None)

class unit_test_parameter(parameter):
    def set_par(self):
        super(unit_test_parameter, self).set_par()
        self.par('timeout', 10000)
        self.par('pkt_num', 1)
        self.par('clock_period', 1.0)
        self.par('clock_init', 0)
        self.par('reset_delay', 10.0)
        self.par('clock_gen', 1)
        self.par('reset_gen', 1)

#bit_pat class is rewrite from chisel
#source code coming from: https://github.com/chipsalliance/rocket-chip/chisel3/src/main/scala/chisel3/util/BitPat.scala
#re-write by python and do some modifications
class bit_pat(data_base):
    def __init__(self, a, w = 0):
        super(bit_pat, self).__init__('bit_pat')
        self.value = None
        self.mask = None
        self.w__ = w
        if (isinstance(a, str)):
            self.apply0(a)
        else:
            self.apply1(a)

    def parse(self, x):
        assert(isinstance(x, str) and x[0] == 'b'), "bit_pat must be in binary and be prefixed with 'b'"
        bits = 0
        mask = 0
        for d in x[1:]:
            if (d != '_'):
                assert(d in "01?"), "Literal: %s contains illegal character: %s" % (x, d)
                mask = (mask << 1) + (0 if (d == '?') else 1)
                bits = (bits << 1) + (1 if (d == '1') else 0)
        return (bits, mask, len(x) - 1)

    def apply0(self, n, w = 0):
        assert(isinstance(n, str))
        (bits, mask, width) = self.parse(n)
        self.value = bits
        self.mask = mask
        if (w != 0):
            self.w__ = w
        else:
            self.w__ = width

    @classmethod
    def dont_care(self, width):
        return bit_pat("b" + ("?" * width))

    def dc(self, width):
        return dont_care(width)  ## scalastyle:ignore method.name

    def bit_pat_to_value(self, x):
        assert(x.mask == (1 << x.get_w()) - 1)
        return value(x.value, w = x.get_w())

    def apply1(self, x):
        assert(isinstance(x, data_base))
        l = x.get_w()
        mat = "{:0%db}" % l
        tmp = 'b' + mat.format(x.vl__)
        self.apply0(tmp)

    def __eq__ (self, that):
        assert(isinstance(that, (int, str, data_base)))
        return (self.value == (that & self.mask))
  
    def __ne__ (self, that):
        assert(isinstance(that, (int, str, data_base)))
        return (self.value != (that & self.mask))

    def __hash__(self):
        return 1

##common functions
def mux(cond, a, b, w = 0):
    info = global_sb.get_info()
    def gen_value_w():
        if (w > 0):
            return w

        if isinstance(a, (int)):
            a_w = value(a).get_w()
        elif isinstance(a, str):
            a_w = 0
        else:
            a_w = a.get_w()

        if isinstance(b, (int)):
            b_w = value(b).get_w()
        elif isinstance(b, str):
            b_w = 0
        else:
            b_w = b.get_w()

        return max(a_w, b_w)

    if (isinstance(a, bundle) or isinstance(b, bundle)):
        if (isinstance(a, bundle) and isinstance(b, bundle)):
            assert(len(a.seq__) == len(b.seq__)), "a(%s) %d, b(%s) %d" % (type(a), len(a), type(b), len(b))
            ret_bundle = type(a)(name = '', p = a.p)
            for i in range(len(a.v__)):
                if isinstance(a.seq__[i],data_base):
                    var_name = a.seq__[i].name
                    tmp_a = a.v__[var_name]
                    tmp_b = b.v__[var_name]
                    ret_bundle.v__[var_name] /= mux(cond, tmp_a, tmp_b)
            return ret_bundle
        else:
            return mux(cond, a.pack(), b.pack())

    t_w = gen_value_w()
    tmp = bits(w = t_w, auto_gen = 1)
    if (isinstance(cond, (int, str))):
        tmp_cond = value(cond)
    else:
        tmp_cond = cond
    if (isinstance(a, (int, str))):
        tmp_a = value(a, w = gen_value_w())
    else:
        tmp_a = a
    if (isinstance(b, (int, str))):
        tmp_b = value(b, w = gen_value_w())
    else:
        tmp_b = b
    cmd = prime_cmd(op_type.mux, tmp, tmp_cond, tmp_a, tmp_b, info = info)
    tmp.cmd_q.append(cmd)
    global_sb.push_cmd(cmd)
    return tmp

def is_pow_of_2(a):
    assert(isinstance(a, int))
    if (a > 0 and (a & (a - 1)) == 0):
        return True
    else:
        return False

def get_list(a):
    if (isinstance(a, Iterable)):
        return list(a)
    else:
        return a

def log2_ceil(a):
    assert(isinstance(a, int))
    return int(math.ceil(math.log(a,2)))

def log2_up(a):
    assert(isinstance(a, int))
    if (a <= 1):
        return 1
    else:
        return int(math.ceil(math.log(a,2)))

def log2_floor(a):
    assert(isinstance(a, int))
    return log2_ceil(a) - (0 if (is_pow_of_2(a)) else 1)

def oh2bin(a):
    assert(isinstance(a, (bits, bundle))), "a must be bits type/bundle"
    if isinstance(a, bits):
        a_new = a
    else:
        a_new = a.pack()
    w = a_new.get_w()
    if (w == 2):
        return a_new[w - 1]
    elif (w <= 1):
        return value(0)
    mid = 1 << (log2_ceil(w) - 1)
    hi = a_new[a_new.get_w() - 1 : mid]
    lo = a_new[mid - 1 : 0]
    tmp = cat2(hi.r_or(),oh2bin(hi | lo))
    return tmp

def pri_enc(a, msb = 0):
    assert(isinstance(a, (bits, list)))
    if isinstance(a, bits):
        width = a.get_w()
    elif isinstance(a, list):
        width = len(a)
    if (msb == 1):
        start = 0
        stop = width
        step = 1
    else:
        start = width - 1
        stop = -1
        step = -1

    w = log2_ceil(width)
    out = start
    for i in range(start, stop, step):
        si = a[i]
        d  = i
        out = mux(si,d,out, w = w)
    return out

def pri_lsb_enc(a):
    return pri_enc(a, msb = 0)

def pri_msb_enc(a):
    return pri_enc(a, msb = 1)

def pri_enc_oh(a, msb = 0):
    if (msb == 0):
        start = 0
        stop = a.get_w()
        step = 1
    else:
        start = a.get_w() - 1
        stop = -1
        step = -1

    tmp = []
    msk = value(0).to_bits()
    for i in range(start, stop, step):
        si = a[i]
        tmp.append(mux(si,si & ~msk,0))
        msk = msk | si
    return cat_rvs(tmp)

def pri_lsb_enc_oh(a):
    return pri_enc_oh(a, msb = 0)

def pri_msb_enc_oh(a):
    return pri_enc_oh(a, msb = 1)

def bin2oh(a, w = 0):
    if (w == 0):
        width = 2**a.get_w()
    else:
        width = w
    return cat_rvs(map(lambda _: a == _, range(width)))

def bin2lsb1(a, w = 0):
    if (w == 0):
        width = 2**a.get_w()
    else:
        width = w
    return ~(value(2**width - 1, w = width).to_bits() << a)[width - 1 : 0]

def gray_start(a, n = 0):
    assert(n%2 == 0), "n must be even"
    if (n == 0):
        tmp = 0
    else:
        if (is_pow_of_2(n)):
            tmp = 0
        else:
            tmp = (2**a.get_w() - n) // 2
    return tmp

def bin2gray(a, n = 0):
    assert(n%2 == 0), "n must be even"
    #extend one msb with 0
    if (n == 0):
        tmp = cat([value(0,1), a])
    else:
        if (is_pow_of_2(n)):
            tmp = cat([value(0,1), a])
        else:
            tmp = cat([value(0,1), a + ((2**a.get_w() - n) // 2)])
    return cat_rvs(map(lambda _: tmp[_] ^ tmp[_+1], range(a.get_w())))

def gray2bin(a, n = 0):
    assert(n%2 == 0), "n must be even"
    tmp_b = cat([value(0), a]).grouped()

    for i in range(a.get_w() - 1, - 1, -1):
        tmp_b[i] /= a[i] ^ tmp_b[i+1]

    if (n == 0):
        b = cat_rvs(tmp_b)[a.get_w() - 1 : 0]
    else:
        if (is_pow_of_2(n)):
            b = cat_rvs(tmp_b)[a.get_w() - 1 : 0]
        else:
            b = cat_rvs(tmp_b)[a.get_w() - 1 : 0] - (((2**a.get_w() - n) // 2))
    return b

def valid(name = '', gen = None, **args):
    assert(isinstance(gen, (type, types.MethodType, types.FunctionType)))
    gen_obj = gen('bits', **args)
    class valid_bundle(valid_base):
        def set_var(self):
            self.var(bits('valid'))
            self.var(gen_obj)
    tmp = valid_bundle(name)
    return tmp.as_output()

def ready_valid(name = '', gen = None, **args):
    assert(isinstance(gen, (type, types.MethodType, types.FunctionType)))
    gen_obj = gen('bits', **args)
    class ready_valid_bundle(ready_valid_base):
        def set_var(self):
            self.var(bits('ready'))
            self.var(bits('valid'))
            self.var(gen_obj)
    tmp = ready_valid_bundle(name)
    io = tmp.as_output()
    #ready port flip
    io.v__['ready'].flipped = not io.v__['ready'].flipped
    return io

def cat2(a,b):
    assert(isinstance(a, (int, str, data_base)))
    assert(isinstance(b, (int, str, data_base)))
    info = global_sb.get_info()
    if isinstance(a, (int, str)):
        a = value(a)
    if isinstance(b, (int, str)):
        b = value(b)
    tmp = bits(w = a.get_w() + b.get_w(), auto_gen = 1)
    cmd = prime_cmd(op_type.cat, tmp, a , b, info = info)
    tmp.cmd_q.append(cmd)
    global_sb.push_cmd(cmd)
    return tmp

def cat(a):
    a = get_list(a)
    assert(isinstance(a, list))
    #remove None element
    new_a = list(filter(lambda _: _ is not None, a))

    for i in new_a:
        assert(isinstance(i, (data_base, int, str))), "%s" % type(i)
    new_a = list(map(lambda _: value(_) if (isinstance(_, (int, str))) else _, new_a))
    if (len(new_a) == 0):
        return None
    elif (len(new_a) == 1):
        return new_a[0]
    else:
        return reduce(cat2,new_a)

def cat_rvs(a):
    a = get_list(a)
    return cat(reversed(a))

def sel(s, a, tp = 'bin', default = None):
    assert(tp in ['bin', '1hot', 'p_msb', 'p_lsb']), "tp illegal"
    s = get_list(s)
    a = get_list(a)
    #check a's type
    a_bits_value_num = len(
        list(filter(lambda i: isinstance(i, (bits, value, int, str)), a)))
    a_bundle_num = len(list(filter(lambda i: isinstance(i, bundle), a)))
    assert(
        (a_bits_value_num == 0 and a_bundle_num == len(a)) or 
        (a_bits_value_num == len(a) and a_bundle_num == 0))
    if (tp == 'bin'):
        assert(2**s.get_w() >= len(a)), "select bin signal width is not enough"
    elif (tp == '1hot') or (tp == 'p_msb') or (tp == 'p_lsb'):
        if isinstance(s, (list, vec_base)):
            s_w = len(s)
        elif isinstance(s, bits):
            s_w = s.get_w()
        else:
            assert(0)
        assert(s_w >= len(a)), "select vector signal width is not enough"

    if (isinstance(a[0], bundle)):
        if (default is not None):
            assert(isinstance(default, bundle)), "default should be bundle type"
        #all elements should be bundle type
        for i in a:
            assert(isinstance(i, bundle))
            assert(len(i) == len(a[0]))
        if (a[0].__class__.__name__ == 'ready_valid_bundle'):
            ret_bundle = ready_valid('', gen = type(a[0].bits), p = a[0].bits.p).as_bits()
        elif (a[0].__class__.__name__ == 'valid_bundle'):
            ret_bundle = valid(gen = type(a[0].bits), p = a[0].bits.p).as_bits()
        else:
            ret_bundle = type(a[0])(name = '', p = a[0].p)
            if(ret_bundle.has_reg()):
                ret_bundle = ret_bundle.as_bits()
        for i in range(len(a[0].v__)):
            if isinstance(a[0].seq__[i],data_base):
                var_name = a[0].seq__[i].name
                tmp_a = list(map(
                    lambda x:x.v__[var_name] if isinstance(x, data_base) else None, a))
                ret_bundle.v__[var_name] /= sel(
                    s,
                    tmp_a,
                    tp = tp,
                    default = None if (default is None) else default.v__[var_name])
        return ret_bundle
    else:
        n = len(a)
        w = max(
            list(map(
                lambda x: x.get_w() if (isinstance(x,data_base)) else value(x).get_w(),
                a)))
        if (tp in ['bin', '1hot']):
            for i in range(n):
                if (tp == 'bin'):
                    assert(isinstance(s, (value, bits)))
                    bits_s = s.to_bits() if (isinstance(s, value)) else s
                    si = bits_s == i
                elif (tp == '1hot'):
                    si = s[i]
                if (i == 0):
                    if (n == 1):
                        tmp = a[i]
                    else:
                        tmp = si.rep(w) & a[i]
                else:
                    tmp = tmp | (si.rep(w) & a[i])
        else: # priority mux(x ? y : z)
            tmp = 0 if (default is None) else default
            if (tp == 'p_msb'):
                start = 0
                stop = n
                step = 1
            elif (tp == 'p_lsb'):
                start = n - 1
                stop = -1
                step = -1
            for i in range(start, stop, step):
                si = s[i]
                d  = a[i]
                tmp = mux(si,d,tmp)
        return tmp

def sel_bin(s, a):
    return sel(s, a, tp = 'bin', default = None)

def sel_oh(s, a = None):
    if (a is None):
        assert(isinstance(s, Iterable)), "s must be Iterable"
        for i in s:
            assert(isinstance(i, (list, tuple)))
            assert(len(i) == 2)
        return sel(
            map(lambda _: _[0], s),
            map(lambda _: _[1], s), 
            tp = '1hot',
            default = None)
    else:
        return sel(s, a, tp = '1hot', default = None)

def sel_p_lsb(s, a = None, default = None):
    if (a is None):
        assert(isinstance(s, Iterable)), "s must be Iterable"
        for i in s:
            assert(isinstance(i, (list, tuple)))
            assert(len(i) == 2)
        return sel(
            map(lambda _: _[0], s), map(lambda _: _[1], s), tp = 'p_lsb', default = None)
    else:
        return sel(s, a, tp = 'p_lsb', default = default)

def sel_p_msb(s, a = None, default = None):
    if (a is None):
        assert(isinstance(s, Iterable)), "s must be Iterable"
        for i in s:
            assert(isinstance(i, (list, tuple)))
            assert(len(i) == 2)
        return sel(
            map(lambda _: _[0], s),
            map(lambda _: _[1], s),
            tp = 'p_msb',
            default = None)
    else:
        return sel(s, a, tp = 'p_msb', default = default)

def sel_map(key, mapping, default = None):
    return sel(
        map(
            lambda _:key.match_any(get_list(_[0])) if (
                isinstance(get_list(_[0]), (list, tuple))) else (key == _[0]),
            mapping),
        map(lambda _:_[1], mapping),
        tp = 'p_lsb',
        default = default)


def flatten(a):
    a = get_list(a)
    tmp = []
    for i in a:
        if (isinstance(i, Iterable)):
            tmp.extend(list(i))
        else:
            tmp.append(i)
    return tmp

def flatten_all(a):
    a = get_list(a)
    tmp = []
    for i in a:
        if (isinstance(i, (list, tuple))):
            for j in flatten_all(i):
                tmp.append(j)
        else:
            tmp.append(i)
    return tmp

def pad_to(a, n, e):
    a = get_list(a)
    assert(isinstance(a, list))
    if (len(a) >= n):
        return a
    tmp = [];
    for i in range(n - len(a)):
        tmp.append(e)
    return a + tmp

def pipe(a, latency = 1):
    if (latency == 0):
        return a
    if isinstance(a, bits):
        out = a
        for i in range(latency):
            tmp = reg(w = a.get_w())
            tmp /= out
            out = tmp
        return out
    elif isinstance(a, bundle):
        out_valid = a.valid
        out_bits = a.bits
        for i in range(latency):
            tmp_valid = reg_r()
            tmp_valid /= out_valid
            tmp_bits = type(a.bits)(p = a.bits.p).as_reg()
            tmp_bits /= out_bits
            out_valid = tmp_valid
            out_bits = tmp_bits
        out = valid(gen = type(a.bits), p = a.bits.p).as_bits()
        out.valid /= out_valid
        out.bits /= out_bits
        return out

def pipe_valid(vld, a, latency = 1):
    if (latency == 0):
        def gen(name):
            if (isinstance(a, bundle)):
                return type(a)(name, p = a.p)
            else:
                return type(a)(name, w = a.get_w())
        out = valid(gen = gen).as_bits()
        out.valid /= vld
        out.bits /= a
        return out
    else :
        v = reg_r(next = vld)
        if (isinstance(a, bundle)):
            b = type(a)(p = a.p).as_reg(tp = 'reg_en', next = a, en = vld)
        else:
            b = reg_en(w = a.get_w(), next = a, en = vld)
        return pipe_valid(v, b, latency - 1)

def vec(name = '', gen = None, n = None, **args):
    assert(isinstance(gen, (type, types.MethodType, types.FunctionType)))
    assert(isinstance(n, (int)))
    class vec_bundle(vec_base):
        def set_var(self):
            super(vec_bundle, self).set_var()
            for i in range(n):
                self.var(gen(i, **args))
    tmp = vec_bundle(name)
    return tmp

def vwrite(fmt, a = None, macro = 1):
    info = global_sb.get_info()
    if (a is None):
        new_a = None
    else:
        if (isinstance(a, (list, tuple))):
            new_a = a
        else:
            new_a = [a]
        #assign inp/out to avoid naming isssue
        new_a = list(map(
            lambda _: bits(
                w = _.get_w(),
                init = _,
                auto_gen = 1) if (isinstance(_, (inp, outp, reg))) else _,
            new_a))
    clock = global_sb.current.io.default_clock[0]
    reset = global_sb.current.io.default_reset[0]

    if (global_sb.when_cnt > 0):
        tmp = reduce(lambda x,y: x & y, global_sb.when_stack)
        cond = bits(
            w = tmp.get_w(), 
            init = tmp, 
            auto_gen = 1) if (isinstance(tmp, (inp, outp, reg))) else tmp
    else:
        cond = None

    name = "TP_" + str(global_sb.current.t_index)
    global_sb.current.t_index += 1
    if (global_sb.vblk_cnt == 0):
        cmd = prime_cmd(
            op_type.vwrite_begin, macro, (clock, reset), name, None, info = info)
        global_sb.push_cmd(cmd)

    cmd = prime_cmd(op_type.vwrite, cond, fmt, new_a, info = info)
    global_sb.push_cmd(cmd)

    if (global_sb.vblk_cnt == 0):
        cmd = prime_cmd(op_type.vwrite_end, macro, None, None, None, info = info)
        global_sb.push_cmd(cmd)

def vprint(fmt, a = None, macro = 1):
    vwrite(fmt, a, macro)

def vprintln(fmt, a = None, macro = 1):
    vwrite(fmt+str("\\n"), a, macro)

#for assert, cover
def vproperty(v, fmt = None, a = None, name = None):
    new_v = bits(
        w = v.get_w(),
        init = v,
        auto_gen = 1) if (isinstance(v, (inp, outp, reg, int))) else v
    if (a is None):
        new_a = None
    else:
        if (isinstance(a, (list, tuple))):
            new_a = a
        else:
            new_a = [a]
        #assign inp/out to avoid naming isssue
        new_a = list(map(
            lambda _: bits(
                w = _.get_w(),
                init = _,
                auto_gen = 1) if (isinstance(_, (inp, outp, reg))) else _,
            new_a))
    clock = global_sb.current.io.default_clock[0]
    reset = global_sb.current.io.default_reset[0]

    if (global_sb.when_cnt > 0):
        tmp = reduce(lambda x,y: x & y, global_sb.when_stack)
        cond = bits(
            w = tmp.get_w(),
            init = tmp,
            auto_gen = 1) if (isinstance(tmp, (inp, outp, reg))) else tmp
    else:
        cond = None

    return (clock, reset, cond, new_a, new_v)

def vassert(v, fmt = None, a = None, name = None):
    info = global_sb.get_info()
    if (name is None):
        name = "TA_" + str(global_sb.current.t_index)
        global_sb.current.t_index += 1
    
    (clock, reset, cond, new_a, new_v) = vproperty(v, fmt, a, name)
    new_v_ast = bits('ast_'+name, init = new_v)

    if (global_sb.vblk_cnt == 0):
        cmd = prime_cmd(op_type.vassert_begin, 1, (clock, reset), name, None, info = info)
        global_sb.push_cmd(cmd)

    cmd = prime_cmd(op_type.vassert, (cond, name), fmt, new_a, new_v_ast, info = info)
    global_sb.push_cmd(cmd)

    if (global_sb.vblk_cnt == 0):
        cmd = prime_cmd(op_type.vassert_end, 1, None, None, None, info = info)
        global_sb.push_cmd(cmd)

def vcover(v, fmt = None, a = None, name = None):
    info = global_sb.get_info()
    if (name is None):
        name = "TC_" + str(global_sb.current.t_index)
        global_sb.current.t_index += 1

    (clock, reset, cond, new_a, new_v) = vproperty(v, fmt, a, name)
    new_v_cov = bits('cov_'+name, init = new_v)

    if (global_sb.vblk_cnt == 0):
        cmd = prime_cmd(op_type.vcover_begin, 1, (clock, reset), name, None, info = info)
        global_sb.push_cmd(cmd)

    cmd = prime_cmd(op_type.vcover, (cond, name), fmt, new_a, new_v_cov, info = info)
    global_sb.push_cmd(cmd)

    if (global_sb.vblk_cnt == 0):
        cmd = prime_cmd(op_type.vcover_end, 1, None, None, None, info = info)
        global_sb.push_cmd(cmd)

#lfsr16 methord is rewrite from chisel
#source code coming from: https://github.com/chipsalliance/rocket-chip/chisel3/src/main/scala/chisel3/util/LFSR.scala
#re-write by python and do some modifications
def lfsr16(increment = 1):
    width = 16
    lfsr = reg_rs(rs = 1, w = width)
    with when (increment):
        lfsr /= cat([lfsr[0]^lfsr[2]^lfsr[3]^lfsr[5], lfsr[width-1:1]])
    return lfsr

#mask_gen methord is rewrite from chisel
#source code coming from: https://github.com/chipsalliance/rocket-chip/src/main/scala/util/Misc.scala
#re-write by python and do some modifications
def mask_gen(addr_lo, lgSize, beatBytes, groupBy = 1):
    assert(groupBy >= 1 and beatBytes >= groupBy)
    assert(is_pow_of_2(beatBytes) and is_pow_of_2(groupBy))
    if (isinstance(lgSize, int)):
        lgSize_bits = value(lgSize).to_bits()
    elif (isinstance(lgSize, value)):
        lgSize_bits = lgSize.to_bits()
    else:
        lgSize_bits = lgSize
    lgBytes = log2_ceil(beatBytes)
    sizeOH = bin2oh(
        lgSize_bits | value(0, w = value(log2_up(beatBytes)).get_w()).to_bits(),
        log2_up(beatBytes)) | value(groupBy*2 - 1)

    def helper(i):
        if (i == 0):
            return [(lgSize_bits >= lgBytes, 1)]
        else:
            sub = helper(i-1)
            size = sizeOH[lgBytes - i]
            bit = addr_lo[lgBytes - i]
            nbit = ~bit
            def tmp_f(j):
                (sub_acc, sub_eq) = sub[j//2]
                eq = sub_eq & (bit if (j % 2 == 1) else nbit)
                acc = sub_acc | (size & eq)
                return (acc, eq)
            return list(map(tmp_f, range(1 << i)))

    if (groupBy == beatBytes):
        return 1
    else:
        return cat_rvs(map(lambda _: _[0], helper(lgBytes-log2_ceil(groupBy))))

def count_ones(a):
    if (isinstance(a, int)):
        return bin(a).count('1')
    elif (isinstance(a, value)):
        return bin(a.v__).count('1')
    else:
        assert(isinstance(a, (list, tuple, bits)))
        if (isinstance(a, bits)):
            a = a.grouped()
        in_size = len(a)
        if (in_size == 0):
            return 0
        elif (in_size == 1):
            return a[0]
        else:
            return count_ones(a[0: in_size//2]) + count_ones(a[in_size//2:])

def count_ones_cmp(x, n):
    assert(isinstance(x, bits))
    assert(isinstance(n, (int)))
    def two(a):
        if (a.get_w() == 1):
            return (a, 0)
        else:
          half = a.get_w() // 2
          (leftOne, leftTwo) = two(a[half - 1: 0])
          (rightOne, rightTwo) = two(a[a.get_w() - 1: half])
          return (leftOne | rightOne, leftTwo | rightTwo | (leftOne & rightOne))
    if (n == 0):
        return 1
    elif (n == 1):
        return x.r_or()
    elif (n == 2):
        return two(x)[1]
    else:
        return count_ones(x) >= n

def split_list(a, n):
    a = get_list(a)
    assert(isinstance(a,list))
    assert(isinstance(n,(int)))
    new_n = len(a)//n if (len(a)%n == 0) else (len(a)//n + 1)
    new_a = []
    for i in range(new_n):
        st = i*n
        ed = (i+1)*n if ((i+1) <= len(a)) else len(a)
        new_a.append(a[st:ed])
    return new_a

def index_is(a, b):
    a = get_list(a)
    assert(isinstance(a, (list, tuple)))
    for i in range(len(a)):
        if (a[i] is b):
            return i
    return None

def rr_arbiter_ctrl(a, sch_en = 1):
    a = get_list(a)
    assert(isinstance(a, (list, tuple, bits))), "a must be list/tuple/bits"
    if (isinstance(sch_en, (int))):
        sch_en = value(sch_en, w = 1)
    if (isinstance(a, bits)):
        a_array = a.grouped()
    else:
        a_array = a
    reqs = bits(w = len(a_array))
    sel = bits(w = len(a_array))
    for i in range(len(a_array)):
        reqs[i] /= a_array[i]

    next_ptr = reg_rs(rs = 1, w = len(a_array))
    msk = bits(w = len(a_array))
    tmp1 = 0
    for i in range(len(a_array)):
        tmp1 = next_ptr[i] | tmp1
        msk[i] /= tmp1
    valid_msk_h = reqs & msk
    valid_msk_l = reqs & ~msk
    valid_msk = mux(valid_msk_h == 0, valid_msk_l, valid_msk_h)
    grant = pri_lsb_enc_oh(valid_msk)
    for i in range(len(a_array)):
        sel[i] /= grant[i]
    with when(reqs.r_or() & sch_en):
        next_ptr /= mux(grant[len(a_array) - 1], 1, grant << 1)
    return sel

def scan_left(func, a, init):
    a = get_list(a)
    assert(isinstance(func, (types.MethodType, types.FunctionType)))
    assert(isinstance(a, (list, tuple)))
    tmp = []
    cur = init
    tmp.append(cur)
    for i in range(len(a)):
        cur = func(cur, a[i])
        tmp.append(cur)
    return tmp

def step(a, clock = None, edge = 'posedge'):
    info = global_sb.get_info()
    assert(edge in ('posedge', 'negedge'))
    if (isinstance(a, (inp, outp, reg))):
        cnt = bits(w = a.get_w(), init = a, auto_gen = 1) 
    elif (isinstance(a, (int))):
        cnt = value(a)
    else:
        cnt = a
    if (clock is None):
        clock = global_sb.current.io.default_clock[0]
    cmd = prime_cmd(op_type.vstep, None, cnt, value(edge, w = 1), clock, info = info)
    global_sb.push_cmd(cmd)

def delay(a):
    info = global_sb.get_info()
    cmd = prime_cmd(
        op_type.vdelay,
        None,
        value(a) if (isinstance(a, (int))) else value(str(a), w = 2),
        None,
        None,
        info = info)
    global_sb.push_cmd(cmd)

def wait(a):
    info = global_sb.get_info()
    if (isinstance(a, (inp, outp, reg))):
        new_a = bits(w = a.get_w(), init = a, auto_gen = 1) 
    elif (isinstance(a, (int))):
        new_a = value(a)
    else:
        new_a = a
    cmd = prime_cmd(op_type.vwait, None, new_a, None, None, info = info)
    global_sb.push_cmd(cmd)

def finish():
    info = global_sb.get_info()
    cmd = prime_cmd(op_type.vfinish, None, None, None, None, info = info)
    global_sb.push_cmd(cmd)

#clock must be ok
def stall(a):
    with vwhile(a):
        step(1)

def urandom(max_v = None, min_v = 0, w = 32):
    info = global_sb.get_info()
    if (max_v is not None):
        new_max_v = value(max_v)
    else:
        new_max_v = None
    if (min_v is not None):
        new_min_v = value(min_v)
    else:
        new_min_v = None

    tmp = bits(w = 32 if (w < 32) else w)
    cmd = prime_cmd(op_type.vurandom, tmp, new_max_v, new_min_v, None, info = info)
    global_sb.push_cmd(cmd)
    return tmp

def async_dff(a, n = 2, **args):
    assert(n >= 2)
    ret = a
    for i in range(n):
        ret = reg(w = a.get_w(), next = ret, **args)
    return ret

def async_dff_rs(a, n = 2, rs = 0, **args):
    assert(n >= 2)
    ret = a
    for i in range(n):
        ret = reg_rs(w = a.get_w(), rs = rs, next = ret, **args)
    return ret

def async_dff_r(a, n = 2, **args):
    assert(n >= 2)
    ret = a
    for i in range(n):
        ret = reg_r(w = a.get_w(), next = ret, **args)
    return ret

def async_dff_s(a, n = 2, **args):
    assert(n >= 2)
    ret = a
    for i in range(n):
        ret = reg_s(w = a.get_w(), next = ret, **args)
    return ret

def vmacro(a, v = ''):
    info = global_sb.get_info()
    cmd = prime_cmd(op_type.vmacro, a, v, info = info)
    global_sb.push_cmd(cmd)

def def_u_reg_dly(v = '#0'):
    vmacro('U_REG_DLY', v)

def vhex_read(fn, fill = 0):
    fd = open(fn, 'r')
    a = fd.readlines()
    addr = 0
    array = []
    for i in a:
       matchObj = re.match(r'^@(\w+)',i)

       #address match
       if (matchObj is not None):
           addr = int(matchObj.group(1), 16)
       #data match
       else:
           data = list(map(lambda _: int(_, 16),i.split()))
           for j in data:
               array.append((addr, j))
               addr = addr + 1

    if (fill):
        fill_array = []
        pre_addr = array[0][0] - 1
        for i in array:
            (cur_addr, cur_data) = i
            if (cur_addr == (pre_addr + 1)):
                fill_array.append((cur_addr, cur_data))
            else:
                for j in range(pre_addr + 1, cur_addr):
                    fill_array.append((j, 0))
                fill_array.append((cur_addr, cur_data))
            pre_addr = cur_addr
        return fill_array
    else:
        return array

def pull_pad(a, ds):
    assert(ds in ('weak0', 'strong0', 'weak1', 'strong1'))

    if (ds in ('weak1', 'strong1')):
        pull_type = op_type.vpullup
    else:
        pull_type = op_type.vpulldown

    if (isinstance(a, bundle)):
        for i in a:
            pull_pad(i, ds)
    elif (isinstance(a, bits)):
        (new_a, slc) = a.get_post_slc()
        lsb = min(slc.start, slc.stop)
        msb = max(slc.start, slc.stop)
        for i in range(lsb, msb+1):
            info = global_sb.get_info()
            cmd = prime_cmd(
                pull_type, 
                new_a,
                ds, 
                None if (new_a.get_w() == 1) else slice(i,i,None),
                None,
                info = info)
            global_sb.push_cmd(cmd)
    else:
        assert(0)

def pullup(a, ds = 'weak1'):
    assert(ds in ('weak1, strong1'))
    pull_pad(a, ds)

def pulldown(a, ds = 'weak0'):
    assert(ds in ('weak0, strong0'))
    pull_pad(a, ds)

def tran_common(a, b, c = None, tp = ''):
    assert(tp in ('tran', 'tranif0', 'tranif1', 'rtran', 'rtranif0', 'rtranif1'))

    if (isinstance(c, data_base)):
        assert(c.get_w() == 1)

    cmd_type = op_type.vtran

    if (isinstance(a, bundle) or isinstance(b, bundle)):
        assert(a.get_w() == b.get_w())
        for i in zip(a.pack(),b.pack()):
            tran_common(i[0],i[1],c,tp)
    elif (isinstance(a, bits)):
        (new_a, a_slc) = a.get_post_slc()
        a_lsb = min(a_slc.start, a_slc.stop)
        a_msb = max(a_slc.start, a_slc.stop)

        (new_b, b_slc) = b.get_post_slc()
        b_lsb = min(b_slc.start, b_slc.stop)
        b_msb = max(b_slc.start, b_slc.stop)

        assert((a_msb + 1 - a_lsb) == (b_msb + 1 - b_lsb))

        b_min_a = b_lsb - a_lsb
        for i in range(a_lsb, a_msb+1):
            info = global_sb.get_info()
            new_a_bit_slice = None if (new_a.get_w() == 1) else slice(i, i, None)
            new_b_bit_slice = None if (new_b.get_w() == 1) else slice(b_min_a + i, b_min_a + i, None)
            cmd = prime_cmd(
                cmd_type,
                tp, 
                (new_a, new_a_bit_slice),
                (new_b, new_b_bit_slice),
                c, info = info)
            global_sb.push_cmd(cmd)
    else:
        assert(0)

def tran(a, b, c = None, tp = 'tran'):
    tran_common(a, b, c, tp)

def info_log(a, log = 0):
    info = global_sb.get_info()
    assert(isinstance(a, str))
    print(a)
    if (log is not None):
        global_sb.current.log_fh.write(a+info+'\n')

#extend high pulse signal and reg out
def pulse_ext_h(a, n):
    reg_o = reg_r()
    if (n < 2):
        reg_o /= a
    else:
        a_dlys = list(map(lambda _: reg_r(), range(n - 1)))
        for i in range(n - 1):
            if (i == 0):
                a_dlys[i] /= a
            else:
                a_dlys[i] /= a_dlys[i-1]
        reg_o /= reduce(lambda x,y: x|y, a_dlys, a)
    return reg_o

#extend low pulse signal and reg out
def pulse_ext_l(a, n):
    reg_o = reg_s()
    if (n < 2):
        reg_o /= a
    else:
        a_dlys = list(map(lambda _: reg_s(), range(n - 1)))
        for i in range(n - 1):
            if (i == 0):
                a_dlys[i] /= a
            else:
                a_dlys[i] /= a_dlys[i-1]
        reg_o /= reduce(lambda x,y: x&y, a_dlys, a)
    return reg_o

#signal 0 -> 1, posedge check
def l2h(a):
    assert(a.get_w() == 1)
    a_dly = reg_r(next = a)
    return a & ~a_dly

#signal 1 -> 0, negedge check
def h2l(a):
    assert(a.get_w() == 1)
    a_dly = reg_s(next = a)
    return ~a & a_dly
