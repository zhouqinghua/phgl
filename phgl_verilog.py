import sys
import os
from abc import ABCMeta, abstractmethod
import re
#from phgl_main import *
from phgl_imp import *
import xlrd
import xlwt

class gen_vcode(object):
    def __init__(self, debug):
        self.vcode_print = debug

    def indent(self, n):
        tmp_str = ""
        for i in range(0,n):
            tmp_str += "    "
        return tmp_str
    
    def print0(self, a):
        if (self.vcode_print == 'all'):
            print(a, end='')
    
    def remove_multi_drive(self, cmd_q):
        pass
    
    def gen_s_signed(self, a):
        if (a is not None):
            if (a.signed_flag__ == 1):
                s = '$signed('
                e = ')'
            else:
                s = ''
                e = ''
        else:
            s = ''
            e = ''
        return (s, e)
    
    def gen_inst_port_list(self, seq, m):
        defi_str = ""
        for p in seq:
            #none accessed define
            if (isinstance(p, bits)):
                if (p.defi_reg == 1):
                    defi_type = "reg "
                else:
                    defi_type = "wire"
                p_name = self.gen_all_sig_name(p)
                defi_str += (
                    self.indent(1) + 
                    "%s %s %s_%s;%s\n" % (defi_type, self.gen_defi_bdr(p), m.name, p_name, m.info))
            elif (isinstance(p,bundle)):
                tmp = self.gen_inst_port_list(p.seq__, m)
                defi_str += tmp

        return defi_str
    
    def gen_inst_port_assign(self, seq, m):
        code = ""
        for p in seq:
            #none accessed define
            if (isinstance(p, bits)):
                p_name = self.gen_all_sig_name(p)
                if (p.bio__ is not None):
                    bio_nm = self.gen_slc_sig_name(p.bio__)
                    #tmp print(p.bio__)
                    #tmp print(p.bio__[0].name)
                    #tmp print(p.bio__[0].parent)
                    #tmp print(bio_nm)
                    code += "%s.%s(%s),\n" % (self.indent(2), p_name, bio_nm)
                else:
                    code += "%s.%s(%s_%s),\n" % (self.indent(2), p_name, m.name, p_name)
            elif (isinstance(p,bundle)):
                tmp = self.gen_inst_port_assign(p.seq__, m)
                code += tmp

        return code
    
    def gen_inst_module(self, m):
        defi_str = ""
        code_v = ""
    
        #define port's conection wire/reg
        defi_str = self.gen_inst_port_list(m.io.seq__,m)
        self.print0(defi_str)
    
        #module define first time: no need add suffix
        if (m.suffix_cnt == 0):
            suffix_str = ""
        else:
            suffix_str = "_" + str(m.suffix_cnt)
    
        params_str = ''
        if ((m.pm.vlib is not None) or (m.pm.vuser is not None)):
            params_str = '#(\n'
            vinst_p = list(filter(lambda _:_ in m.p.vinst, m.p))
            #params_list = list(map(lambda _: '.%s(%s)' %(_, str(m.p[_])), m.p))
            params_list = list(map(lambda _: '.%s(%s)' %(_, str(m.p[_])), vinst_p))
            for i in range(len(params_list)):
                params_str = (
                    params_str + 
                    self.indent(2) + 
                    params_list[i] + 
                    ('' if (i == (len(params_list) - 1)) else ',') + 
                    '\n')
            params_str = params_str + self.indent(1) + ') '
        else:
            params_str = ''
    
        code_v += (
            self.indent(1) + 
            m.pc_name() + 
            suffix_str + 
            " " + 
            params_str + 
            m.name + 
            "(%s\n" % m.info)
    
        #instance module
        code_v += self.gen_inst_port_assign(m.io.seq__, m)
        code_v = code_v.rstrip(",\n") + "\n"
        code_v += self.indent(1) + ");\n"
        self.print0(code_v)
        return [defi_str, code_v]
    
    def gen_defi_bdr(self, t):
        if (t.get_w() == 1):
            return ""
        else:
            return "[%s:%s]" % (t.get_w()-1, 0)
    def gen_bits_slc(self, start, stop, underscore = 0):
        if (isinstance(start,bits)):
            start_str = start.name
        else:
            start_str = str(start)
        if (isinstance(stop,bits)):
            stop_str = stop.name
        else:
            stop_str = str(stop)
        if (underscore):
            char_l = '_'
            char_r = '_'
            char_m = '_'
        else:
            char_l = '['
            char_r = ']'
            char_m = ':'
        if (start_str == stop_str):
            return char_l + str(start_str) + char_r
        else:
            return char_l + str(start_str) + char_m + str(stop_str) + char_r
    
    def gen_all_sig_name(self, a):
        if (a is not None):
            #tmp if (isinstance(a,bits)):
            #tmp     if (a.her_name != ""):
            #tmp         all_name = a.her_name + a.name
            #tmp     else:
            #tmp         all_name = a.name
            #tmp else:
            #tmp     all_name = a.name
            if (a.her_name != ""):
                all_name = a.her_name + a.name
            else:
                all_name = a.name
        else:
            all_name = None

        return all_name
    
    def gen_io_sig_name(self, p, current):
        p_name = self.gen_all_sig_name(p)
        if (p.parent is not current):
            return "%s_%s" % (p.parent.name, p_name)
        else:
            return p_name

    def gen_slc_sig_name(self, s):
        if (s[1] != None):
            s_slc = self.gen_bits_slc(s[1].start, s[1].stop)
        else:
            s_slc = ""
        
        s_nm = self.gen_all_sig_name(s[0])
        s_nm = s_nm + s_slc
        return s_nm
    
    def gen_rtl(self, cmd_q,n):
        cnt = n
        defi_port_str = ""
        defi_str = ""
        defi_dff_str = ""
        auto_gen_logic_str = ""
        normal_logic_str = ""
        printf_str = ""
        macro_str = ""
        for cmd in cmd_q:
            if (isinstance(cmd, prime_cmd)):
                if (cmd.op == op_type.defi):
                    bdr = self.gen_defi_bdr(cmd.t)
                    defi_type = "reg "
                    if (cmd.t.defi_reg == 1):
                        defi_type = "reg "
                    else:
                        defi_type = "wire"
                    all_t_name = self.gen_all_sig_name(cmd.t)
                    if (cmd.t.type_reg):
                        if (cmd.t.clock_edge == 'posedge'):
                            clock_edge = 'posedge'
                        elif (cmd.t.clock_edge == 'negedge'):
                            clock_edge = 'negedge'
                        else:
                            assert(0)
                        if (type(cmd.t) == reg):
                            line = self.indent(cnt) + "always @(%s %s)%s\n" % (clock_edge, self.gen_io_sig_name(cmd.t.clock, cmd.parent), cmd.info) + \
                            self.indent(cnt+1) + self.gen_all_sig_name(cmd.t.o) + " <= `U_REG_DLY " + self.gen_all_sig_name(cmd.t.i) + ";\n"
                            self.print0(line)
                            defi_dff_str += line
                        elif (type(cmd.t) == reg_en):
                            line = self.indent(cnt) + "always @(%s %s)%s\n" % (clock_edge, self.gen_io_sig_name(cmd.t.clock, cmd.parent), cmd.info) + \
                            self.indent(cnt+1) + "if (%s)\n" % self.gen_all_sig_name(cmd.t.en) + \
                            self.indent(cnt+2) + self.gen_all_sig_name(cmd.t.o) + " <= `U_REG_DLY " + self.gen_all_sig_name(cmd.t.i) + ";\n"
                            self.print0(line)
                            defi_dff_str += line
                        elif ((type(cmd.t) == reg_r) | (type(cmd.t) == reg_s) | (type(cmd.t) == reg_rs)):
                            if (cmd.t.reset.reset_level == 1):
                                reset_level = 'posedge'
                                reset_op = ''
                            else:
                                reset_level = 'negedge'
                                reset_op = '~'
                            if (cmd.t.reset.reset_sync == 1):
                                reset_sync = ""
                            else:
                                reset_sync = " or %s %s" % (reset_level, self.gen_io_sig_name(cmd.t.reset, cmd.parent))
                            line = self.indent(cnt) + "always @(%s %s%s)%s\n" % (clock_edge, self.gen_io_sig_name(cmd.t.clock, cmd.parent), reset_sync, cmd.info) + \
                            self.indent(cnt+1) + "if (%s%s)\n" % (reset_op, self.gen_all_sig_name(cmd.t.reset)) + \
                            self.indent(cnt+2) + self.gen_all_sig_name(cmd.t.o) + " <= `U_REG_DLY " + self.gen_all_sig_name(cmd.t.rs_vl) + ";\n" + \
                            self.indent(cnt+1) + "else\n" + \
                            self.indent(cnt+2) + self.gen_all_sig_name(cmd.t.o) + " <= `U_REG_DLY " + self.gen_all_sig_name(cmd.t.i) + ";\n"
                            self.print0(line)
                            defi_dff_str += line
                        elif ((type(cmd.t) == reg_en_r) | (type(cmd.t) == reg_en_s) | (type(cmd.t) == reg_en_rs)):
                            if (cmd.t.reset.reset_level == 1):
                                reset_level = 'posedge'
                                reset_op = ''
                            else:
                                reset_level = 'negedge'
                                reset_op = '~'
                            if (cmd.t.reset.reset_sync == 1):
                                reset_sync = ""
                            else:
                                reset_sync = " or %s %s" % (reset_level, self.gen_io_sig_name(cmd.t.reset, cmd.parent))
                            line = self.indent(cnt) + "always @(%s %s%s)%s\n" % (clock_edge, self.gen_io_sig_name(cmd.t.clock, cmd.parent), reset_sync, cmd.info) + \
                            self.indent(cnt+1) + "if (%s%s)\n" % (reset_op, self.gen_all_sig_name(cmd.t.reset)) + \
                            self.indent(cnt+2) + self.gen_all_sig_name(cmd.t.o) + " <= `U_REG_DLY " + cmd.t.rs_vl.name + ";\n" + \
                            self.indent(cnt+1) + "else if (%s)\n" % self.gen_all_sig_name(cmd.t.en) + \
                            self.indent(cnt+2) + self.gen_all_sig_name(cmd.t.o) + " <= `U_REG_DLY " + self.gen_all_sig_name(cmd.t.i) + ";\n"
                            self.print0(line)
                            defi_dff_str += line
                    elif (isinstance(cmd.t, inp)):
                        if (cmd.t.flipped == 0):
                            p_type = 'input '
                        else:
                            p_type = 'output'
                        if (cmd.t.inout == 1):
                            p_type = 'inout'
                        line = self.indent(cnt) + "%s wire %s %s,%s\n" % (p_type, bdr, all_t_name, cmd.info);
                        self.print0(line)
                        defi_port_str += self.indent(1) + line.lstrip()
                    elif (isinstance(cmd.t, outp)):
                        if (cmd.t.flipped == 0):
                            p_type = 'output'
                        else:
                            p_type = 'input '
                        if (cmd.t.inout == 1):
                            p_type = 'inout'
                        line = self.indent(cnt) + "%s %s %s %s,%s\n" % (p_type, defi_type, bdr, all_t_name, cmd.info)
                        self.print0(line)
                        defi_port_str += self.indent(1) + line.lstrip()
                    elif (isinstance(cmd.t, mem)):
                        line = self.indent(cnt) + "%s %s %s[%s:0];%s\n" % (defi_type, bdr, all_t_name, cmd.t.depth - 1, cmd.info)
                        self.print0(line)
                        defi_str += self.indent(1) + line.lstrip()
                    else:
                        line = self.indent(cnt) + "%s %s %s;%s\n" % (defi_type, bdr, all_t_name, cmd.info)
                        self.print0(line)
                        defi_str += self.indent(1) + line.lstrip()
                elif (cmd.op == op_type.vmacro):
                    line = "`define %s %s%s\n" %(cmd.t, cmd.s0, cmd.info)
                    self.print0(line)
                    macro_str += line
                elif (cmd.op == op_type.vblk_if_begin):
                    line = self.indent(cnt + cmd.vblk_cnt) + "if (%s) begin%s\n" %(self.gen_all_sig_name(cmd.s0), cmd.info)
                    self.print0(line)
                    normal_logic_str += line
                elif (cmd.op == op_type.vblk_if_end):
                    line = self.indent(cnt + cmd.vblk_cnt) + "end\n"
                    self.print0(line)
                    normal_logic_str += line
                elif (cmd.op == op_type.vblk_else_begin):
                    line = self.indent(cnt + cmd.vblk_cnt) + "else begin%s\n" %(cmd.info)
                    self.print0(line)
                    normal_logic_str += line
                elif (cmd.op == op_type.vblk_else_end):
                    line = self.indent(cnt + cmd.vblk_cnt) + "end\n"
                    self.print0(line)
                    normal_logic_str += line
                elif (cmd.op == op_type.vblk_initial_begin):
                    line = self.indent(cnt + cmd.vblk_cnt) + "initial begin%s\n" %(cmd.info)
                    self.print0(line)
                    normal_logic_str += line
                elif (cmd.op == op_type.vblk_initial_end):
                    line = self.indent(cnt + cmd.vblk_cnt) + "end\n"
                    self.print0(line)
                    normal_logic_str += line
                elif (cmd.op == op_type.vblk_always_begin):
                    line = self.indent(cnt + cmd.vblk_cnt) + "always @(*) begin%s\n" %(cmd.info)
                    self.print0(line)
                    normal_logic_str += line
                elif (cmd.op == op_type.vblk_always_end):
                    line = self.indent(cnt + cmd.vblk_cnt) + "end\n"
                    self.print0(line)
                    normal_logic_str += line
                elif (cmd.op == op_type.vblk_while_begin):
                    line = self.indent(cnt + cmd.vblk_cnt) + "while (%s) begin%s\n" %(self.gen_all_sig_name(cmd.s0), cmd.info)
                    self.print0(line)
                    normal_logic_str += line
                elif (cmd.op == op_type.vblk_while_end):
                    line = self.indent(cnt + cmd.vblk_cnt) + "end\n"
                    self.print0(line)
                    normal_logic_str += line
                elif (cmd.op == op_type.vwrite_begin or 
                      cmd.op == op_type.vassert_begin or 
                      cmd.op == op_type.vcover_begin
                     ):
                    if (cmd.op == op_type.vwrite_begin):
                        blk_nm = "prt_" + cmd.s1
                    elif (cmd.op == op_type.vassert_begin):
                        blk_nm = "ast_" + cmd.s1
                    elif (cmd.op == op_type.vcover_begin):
                        blk_nm = "cov_" + cmd.s1
    
                    if (cmd.t is 1):
                        if (cmd.op == op_type.vwrite_begin):
                            macro = 'VPRINT_COND'
                        elif (cmd.op == op_type.vassert_begin):
                            macro = 'VASSERT_COND'
                        elif (cmd.op == op_type.vcover_begin):
                            macro = 'VCOVER_COND'
                        else:
                            assert(0)
                        line = self.indent(cnt) + "`ifdef %s\n" %(macro) + \
                               self.indent(cnt) + "    always @(posedge %s) if (%s != %d) begin%s\n" %(self.gen_all_sig_name(cmd.s0[0]), self.gen_all_sig_name(cmd.s0[1]), cmd.s0[1].reset_level, cmd.info)
                    else:
                        line = self.indent(cnt) + "always @(posedge %s) if (%s != %d) begin%s\n" %(self.gen_all_sig_name(cmd.s0[0]), self.gen_all_sig_name(cmd.s0[1]), cmd.s0[1].reset_level, cmd.info)
                    self.print0(line)
                    normal_logic_str += line
                elif (cmd.op == op_type.vwrite):
                    if (cmd.vblk_cnt == 0):
                        offset_cnt = 2
                    else:
                        offset_cnt = 0
                    if (cmd.t is not None):
                        cond_pre_str = \
                            self.indent(cnt+cmd.vblk_cnt+offset_cnt) + "if (%s) begin \n" % (self.gen_all_sig_name(cmd.t))
                        cond_post_str = \
                            self.indent(cnt+cmd.vblk_cnt+offset_cnt) + "end\n"
                        cond_indent = 1
                    else:
                        cond_pre_str = ""
                        cond_post_str = ""
                        cond_indent = 0
                    line = cond_pre_str
                    if (cmd.s1 is None):
                        line += self.indent(cnt+cmd.vblk_cnt+offset_cnt+cond_indent) + "$write(\"%s\");\n" % (cmd.s0)
                    else:
                        tmp = reduce(lambda x,y: x + ', ' + y, map(lambda _: self.gen_all_sig_name(_), cmd.s1))
                        line += self.indent(cnt+cmd.vblk_cnt+offset_cnt+cond_indent) + "$write(\"%s\", %s);\n" % (cmd.s0, tmp)
                    line += cond_post_str
                    self.print0(line)
                    normal_logic_str += line
                elif (cmd.op == op_type.vassert or
                      cmd.op == op_type.vcover
                     ):
                    if (cmd.vblk_cnt == 0):
                        offset_cnt = 2
                    else:
                        offset_cnt = 0
    
    
                    if (cmd.t[0] is not None):
                        cond_pre_str = \
                            self.indent(cnt+cmd.vblk_cnt+offset_cnt) + "if (%s) begin \n" % (self.gen_all_sig_name(cmd.t[0]))
                        cond_post_str = \
                            self.indent(cnt+cmd.vblk_cnt+offset_cnt) + "end\n"
                        cond_indent = 1
                    else:
                        cond_pre_str = ""
                        cond_post_str = ""
                        cond_indent = 0
                    line = cond_pre_str
    
                    if (cmd.op == op_type.vassert):
                        #assert's name
                        ast_nm = "ast_" + cmd.t[1]
                        #no vwrite
                        if (cmd.parent.pm.has_assert_syntax):
                            if (cmd.s0 is None):
                                line += self.indent(cnt+cmd.vblk_cnt+offset_cnt+cond_indent) + "%s: assert(%s);\n" % (ast_nm, self.gen_all_sig_name(cmd.s2))
                            else:
                                line += self.indent(cnt+cmd.vblk_cnt+offset_cnt+cond_indent) + "%s: assert(%s) else\n" % (ast_nm, self.gen_all_sig_name(cmd.s2))
                        else:
                            if (cmd.s0 is None):
                                line += self.indent(cnt+cmd.vblk_cnt+offset_cnt+cond_indent) + \
                                "if(%s == 0) $write(\"%%s, %%0d: %%m: %s assert failed at %%t\\n\", `__FILE__,`__LINE__, $time);\n" %(self.gen_all_sig_name(cmd.s2), ast_nm)
                            else:
                                line += self.indent(cnt+cmd.vblk_cnt+offset_cnt+cond_indent) + \
                                "if(%s); else\n" %(self.gen_all_sig_name(cmd.s2))
                    elif (cmd.op == op_type.vcover):
                        #cover's name
                        cov_nm = "cov_" + cmd.t[1]
                        #no vwrite
                        if (cmd.parent.pm.has_assert_syntax):
                            if (cmd.s0 is None):
                                line += self.indent(cnt+cmd.vblk_cnt+offset_cnt+cond_indent) + "%s: cover(%s);\n" % (cov_nm, self.gen_all_sig_name(cmd.s2))
                            else:
                                line += self.indent(cnt+cmd.vblk_cnt+offset_cnt+cond_indent) + "%s: cover(%s) \n" % (cov_nm, self.gen_all_sig_name(cmd.s2))
                        else:
                            if (cmd.s0 is None):
                                line += self.indent(cnt+cmd.vblk_cnt+offset_cnt+cond_indent) + \
                                "if(%s);;\n" %(self.gen_all_sig_name(cmd.s2))
                            else:
                                line += self.indent(cnt+cmd.vblk_cnt+offset_cnt+cond_indent) + \
                                "if(%s)\n" %(self.gen_all_sig_name(cmd.s2))
    
                    if (cmd.parent.pm.has_assert_syntax):
                        if (cmd.s0 is not None):
                            if (cmd.s1 is None):
                                line += self.indent(cnt+cmd.vblk_cnt+offset_cnt+cond_indent) + "$write(\"%s\\n\");\n" % (cmd.s0)
                            else:
                                tmp = reduce(lambda x,y: x + ', ' + y, map(lambda _: self.gen_all_sig_name(_), cmd.s1))
                                line += self.indent(cnt+cmd.vblk_cnt+offset_cnt+cond_indent) + "$write(\"%s\\n\", %s);\n" % (cmd.s0, tmp)
                    else:
                        if (cmd.op == op_type.vassert):
                            pre_str = "%s assert failed" % (ast_nm)
                        else:
                            pre_str = "%s cover hit" % (cov_nm)
                        if (cmd.s0 is not None):
                            if (cmd.s1 is None):
                                line += self.indent(cnt+cmd.vblk_cnt+offset_cnt+cond_indent) + "$write(\"%%s, %%0d: %%m: %s at %%t: %s\\n\", `__FILE__, `__LINE__, $time);\n" % (pre_str, cmd.s0)
                            else:
                                tmp = reduce(lambda x,y: x + ', ' + y, map(lambda _: self.gen_all_sig_name(_), cmd.s1))
                                line += self.indent(cnt+cmd.vblk_cnt+offset_cnt+cond_indent) + "$write(\"%%s %%0d: %%m: %s at %%t: %s\\n\", `__FILE__,`__LINE__, $time, %s);\n" % (pre_str, cmd.s0, tmp)
    
                    line += cond_post_str
                    self.print0(line)
                    normal_logic_str += line
                elif (cmd.op == op_type.vwrite_end or
                      cmd.op == op_type.vassert_end or
                      cmd.op == op_type.vcover_end
                     ):
                    if (cmd.t is 1):
                        line = self.indent(cnt) + "    end\n" + \
                               self.indent(cnt) + "`endif\n"
                    else:
                        line = self.indent(cnt) + "end\n"
                    self.print0(line)
                    normal_logic_str += line
    
                elif (cmd.op == op_type.vstep):
                    line = self.indent(cnt + cmd.vblk_cnt) + "repeat(%s) @(%s %s);%s\n" %(self.gen_all_sig_name(cmd.s0), self.gen_all_sig_name(cmd.s1), cmd.s2.name, cmd.info)
                    self.print0(line)
                    normal_logic_str += line
                elif (cmd.op == op_type.vdelay):
                    line = self.indent(cnt + cmd.vblk_cnt) + "# (%s);%s\n" %(self.gen_all_sig_name(cmd.s0), cmd.info)
                    self.print0(line)
                    normal_logic_str += line
                elif (cmd.op == op_type.vfinish):
                    line = self.indent(cnt + cmd.vblk_cnt) + "$finish();%s\n" %(cmd.info)
                    self.print0(line)
                    normal_logic_str += line
                elif (cmd.op == op_type.vwait):
                    line = self.indent(cnt + cmd.vblk_cnt) + "wait(%s);%s\n" %(self.gen_all_sig_name(cmd.s0), cmd.info)
                    self.print0(line)
                    normal_logic_str += line
                elif ((cmd.op == op_type.vpullup) or (cmd.op == op_type.vpulldown)):
                    if (cmd.s1 != None):
                        t_slc = self.gen_bits_slc(cmd.s1.start, cmd.s1.stop)
                        p_slc = self.gen_bits_slc(cmd.s1.start, cmd.s1.stop, underscore = 1)
                    else:
                        t_slc = ""
                        p_slc = ""
                    t_nm = self.gen_io_sig_name(cmd.t, cmd.parent)+t_slc
                    p_nm = self.gen_io_sig_name(cmd.t, cmd.parent)+p_slc
                    pull_type = 'pullup' if (cmd.op == op_type.vpullup) else 'pulldown'
                    p_nm = ('pu_' if (cmd.op == op_type.vpullup) else 'pd_') + p_nm
                    line = self.indent(cnt + cmd.vblk_cnt) + "%s (%s) %s (%s);%s\n" %(pull_type, cmd.s0, p_nm, t_nm, cmd.info)
                    self.print0(line)
                    normal_logic_str += line
                elif (cmd.op == op_type.vtran):
                    if (cmd.s0[1] != None):
                        s0_t_slc = self.gen_bits_slc(cmd.s0[1].start, cmd.s0[1].stop)
                        s0_p_slc = self.gen_bits_slc(cmd.s0[1].start, cmd.s0[1].stop, underscore = 1)
                    else:
                        s0_t_slc = ""
                        s0_p_slc = ""
                    if (cmd.s1[1] != None):
                        s1_t_slc = self.gen_bits_slc(cmd.s1[1].start, cmd.s1[1].stop)
                        s1_p_slc = self.gen_bits_slc(cmd.s1[1].start, cmd.s1[1].stop, underscore = 1)
                    else:
                        s1_t_slc = ""
                        s1_p_slc = ""
                    
                    a_nm = self.gen_io_sig_name(cmd.s0[0], cmd.parent)
                    b_nm = self.gen_io_sig_name(cmd.s1[0], cmd.parent)
                    tr_nm = 'tr_%s_%s' %(a_nm+s0_p_slc, b_nm+s1_p_slc)
    
                    a_nm = a_nm + s0_t_slc
                    b_nm = b_nm + s1_t_slc
    
                    if (cmd.s2 is not None):
                        c_nm = self.gen_io_sig_name(cmd.s2, cmd.parent)
    
                    if (cmd.t in ('tran', 'rtran')):
                        line = self.indent(cnt + cmd.vblk_cnt) + "%s %s(%s, %s);%s\n" %(cmd.t, tr_nm, a_nm, b_nm, cmd.info)
                    else:
                        line = self.indent(cnt + cmd.vblk_cnt) + "%s %s(%s, %s, %s);%s\n" %(cmd.t, tr_nm, a_nm, b_nm, c_nm, cmd.info)
                    self.print0(line)
                    normal_logic_str += line
                elif (cmd.op == op_type.vlist_defi):
                    line = self.indent(cnt + cmd.vblk_cnt) + "reg[%s:0] %s[$];%s\n" %(cmd.t.get_w() - 1, cmd.t.name, cmd.info)
                    self.print0(line)
                    defi_str += self.indent(1) + line.lstrip()
                elif (cmd.op == op_type.vlist_append):
                    line = self.indent(cnt + cmd.vblk_cnt) + "%s.push_back(%s);%s\n" %(cmd.t.name, self.gen_all_sig_name(cmd.s0), cmd.info)
                    self.print0(line)
                    normal_logic_str += line
                elif (cmd.op == op_type.vlist_pop):
                    line = self.indent(cnt + cmd.vblk_cnt) + "%s = %s.pop_front();%s\n" %(self.gen_all_sig_name(cmd.t), cmd.s0.name, cmd.info)
                    self.print0(line)
                    normal_logic_str += line
                elif (cmd.op == op_type.vurandom):
                    if (cmd.s0 is not None):
                        max_min_str = "%s, %s" %(self.gen_all_sig_name(cmd.s0), self.gen_all_sig_name(cmd.s1))
                        kw = '$urandom_range'
                    else:
                        max_min_str = ""
                        kw = '$urandom'
                    rand_str = "{%s(%s)" % (kw, max_min_str)
                    for i in range(int(cmd.t.get_w()/32) - 1):
                        rand_str += ", %s(%s)" % (kw, max_min_str)
                    rand_str += "}"
                    line = self.indent(cnt + cmd.vblk_cnt) + "%s = %s;%s\n" %(self.gen_all_sig_name(cmd.t), rand_str, cmd.info)
                    self.print0(line)
                    normal_logic_str += line
                else:
                    eq_op = " = "
                    indent_incr = 0
                    t_prefix = ""
                    t_suffix = ""
                    s0_prefix = ""
                    s0_suffix = ""
                    s1_prefix = ""
                    s1_suffix = ""
                    s2_prefix = ""
                    s2_suffix = ""
    
                    new_cnt = cnt + cmd.vblk_cnt
    
                    if (cmd.parent.type_if_else):
                        if ((cmd.t.auto_gen == 0) & (cmd.parent.t != None)):
                            eq_op = " <= `U_REG_DLY "
    
                    if (cmd.t.defi_reg == 1):
                        pre_type = ""
                    elif ((cmd.if_cnt == 0) & (cmd.else_cnt == 0)):
                        pre_type = "assign "
                    elif (cmd.t.auto_gen == 1):
                        pre_type = "assign "
                    else:
                        pre_type = ""
    
                    if (cmd.t.type_reg):
                        t_suffix = "_i"
    
                    if ((cmd.s0 is not None) and cmd.s0.type_reg):
                        s0_suffix = "_o"
    
                    if ((cmd.s1 is not None) and cmd.s1.type_reg):
                        s1_suffix = "_o"
    
                    if ((cmd.s2 is not None) and cmd.s2.type_reg):
                        s2_suffix = "_o"
    
                    #check if_else block's parent
                    #replace with if_else block's module parent
                    cmd_parent = None
                    t_parent = None
                    s0_parent = None
                    s1_parent = None
                    s2_parent = None
                    if (cmd.parent.type_if_else):
                        cmd_parent = cmd.parent.if_blk_parent
                        if (isinstance(cmd.t,bits)):
                            if (cmd.t.parent.type_if_else):
                                t_parent = cmd.parent.if_blk_parent
                            else:
                                t_parent = cmd.t.parent
                        if (isinstance(cmd.s0,bits)):
                            if (cmd.s0.parent.type_if_else):
                                s0_parent = cmd.parent.if_blk_parent
                            else:
                                s0_parent = cmd.s0.parent
                        if (isinstance(cmd.s1,bits)):
                            if (cmd.s1.parent.type_if_else):
                                s1_parent = cmd.parent.if_blk_parent
                            else:
                                s1_parent = cmd.s1.parent
                        if (isinstance(cmd.s2,bits)):
                            if (cmd.s2.parent.type_if_else):
                                s2_parent = cmd.parent.if_blk_parent
                            else:
                                s2_parent = cmd.s2.parent
                    else:
                        cmd_parent = cmd.parent
    
                    #assign from submodule
                    if ((cmd.s0 is not None) and cmd.s0.type_ioport):
                        s0_parent = cmd.s0.parent
                        if (s0_parent != cmd_parent):
                            s0_prefix = "" + s0_parent.name + "_"
                    if ((cmd.s1 is not None) and cmd.s1.type_ioport):
                        s1_parent = cmd.s1.parent
                        if (s1_parent != cmd_parent):
                            s1_prefix = "" + s1_parent.name + "_"
                    if ((cmd.s2 is not None) and cmd.s2.type_ioport):
                        s2_parent = cmd.s2.parent
                        if (s2_parent != cmd_parent):
                            s2_prefix = "" + s2_parent.name + "_"
    
                    #assign to submodule
                    if ((cmd.t is not None) and cmd.t.type_ioport):
                        t_parent = cmd.t.parent
                        if (t_parent != cmd_parent):
                            t_prefix = "" + t_parent.name + "_"
    
                    if (cmd.t_slc != None):
                        t_slc = self.gen_bits_slc(cmd.t_slc.start, cmd.t_slc.stop)
                    else:
                        t_slc = ""
                    if (cmd.s0_slc != None):
                        s0_slc = self.gen_bits_slc(cmd.s0_slc.start, cmd.s0_slc.stop)
                    else:
                        s0_slc = ""
                    if (cmd.s1_slc != None):
                        s1_slc = self.gen_bits_slc(cmd.s1_slc.start, cmd.s1_slc.stop)
                    else:
                        s1_slc = ""
                    if (cmd.s2_slc != None):
                        s2_slc = self.gen_bits_slc(cmd.s2_slc.start, cmd.s2_slc.stop)
                    else:
                        s2_slc = ""
    
                    all_t_name = self.gen_all_sig_name(cmd.t)
                    all_s0_name = self.gen_all_sig_name(cmd.s0)
                    all_s1_name = self.gen_all_sig_name(cmd.s1)
                    all_s2_name = self.gen_all_sig_name(cmd.s2)
    
                    (s0_signed_s, s0_signed_e) = self.gen_s_signed(cmd.s0)
                    (s1_signed_s, s1_signed_e) = self.gen_s_signed(cmd.s1)
                    (s2_signed_s, s2_signed_e) = self.gen_s_signed(cmd.s2)
    
                    if (cmd.op == op_type.immd):
                        line = self.indent(new_cnt) + pre_type + t_prefix + all_t_name + t_suffix + t_slc + eq_op + s0_signed_s + s0_prefix + all_s0_name + s0_suffix + s0_slc + s0_signed_e + ";" + cmd.info + "\n"
                    elif (cmd.op == op_type.copy):
                        line = self.indent(new_cnt) + pre_type + t_prefix + all_t_name + t_suffix + t_slc + eq_op + s0_signed_s + s0_prefix + all_s0_name + s0_suffix + s0_slc + s0_signed_e +  ";" + cmd.info + "\n"
                    elif (cmd.op == op_type.add):
                        line = self.indent(new_cnt) + pre_type + t_prefix + all_t_name + t_suffix + t_slc + eq_op + "(" + s0_signed_s + s0_prefix + all_s0_name + s0_suffix + s0_slc + s0_signed_e +  " + " + s1_signed_s + s1_prefix + all_s1_name + s1_suffix + s1_slc + s1_signed_e + ");" + cmd.info + "\n"
                    elif (cmd.op == op_type.sub):
                        line = self.indent(new_cnt) + pre_type + t_prefix + all_t_name + t_suffix + t_slc + eq_op + "(" + s0_signed_s + s0_prefix + all_s0_name + s0_suffix + s0_slc + s0_signed_e +  " - " + s1_signed_s + s1_prefix + all_s1_name + s1_suffix + s1_slc + s1_signed_e + ");" + cmd.info + "\n"
                    elif (cmd.op == op_type.mul):
                        line = self.indent(new_cnt) + pre_type + t_prefix + all_t_name + t_suffix + t_slc + eq_op + "(" + s0_signed_s + s0_prefix + all_s0_name + s0_suffix + s0_slc + s0_signed_e +  " * " + s1_signed_s + s1_prefix + all_s1_name + s1_suffix + s1_slc + s1_signed_e + ");" + cmd.info + "\n"
                    elif (cmd.op == op_type.div):
                        line = self.indent(new_cnt) + pre_type + t_prefix + all_t_name + t_suffix + t_slc + eq_op + "(" + s0_signed_s + s0_prefix + all_s0_name + s0_suffix + s0_slc + s0_signed_e +  " / " + s1_signed_s + s1_prefix + all_s1_name + s1_suffix + s1_slc + s1_signed_e + ");" + cmd.info + "\n"
                    elif (cmd.op == op_type.mod):
                        line = self.indent(new_cnt) + pre_type + t_prefix + all_t_name + t_suffix + t_slc + eq_op + "(" + s0_signed_s + s0_prefix + all_s0_name + s0_suffix + s0_slc + s0_signed_e +  " % " + s1_signed_s + s1_prefix + all_s1_name + s1_suffix + s1_slc + s1_signed_e + ");" + cmd.info + "\n"
                    elif (cmd.op == op_type.pow):
                        line = self.indent(new_cnt) + pre_type + t_prefix + all_t_name + t_suffix + t_slc + eq_op + "(" + s0_signed_s + s0_prefix + all_s0_name + s0_suffix + s0_slc + s0_signed_e +  " ** " + s1_signed_s + s1_prefix + all_s1_name + s1_suffix + s1_slc + s1_signed_e + ");" + cmd.info + "\n"
                    elif (cmd.op == op_type.sl_l):
                        line = self.indent(new_cnt) + pre_type + t_prefix + all_t_name + t_suffix + t_slc + eq_op + "(" + s0_signed_s + s0_prefix + all_s0_name + s0_suffix + s0_slc + s0_signed_e +  " << " + s1_signed_s + s1_prefix + all_s1_name + s1_suffix + s1_slc + s1_signed_e + ");" + cmd.info + "\n"
                    elif (cmd.op == op_type.sr_l):
                        line = self.indent(new_cnt) + pre_type + t_prefix + all_t_name + t_suffix + t_slc + eq_op + "(" + s0_signed_s + s0_prefix + all_s0_name + s0_suffix + s0_slc + s0_signed_e +  " >> " + s1_signed_s + s1_prefix + all_s1_name + s1_suffix + s1_slc + s1_signed_e + ");" + cmd.info + "\n"
                    elif (cmd.op == op_type.sr_a):
                        line = self.indent(new_cnt) + pre_type + t_prefix + all_t_name + t_suffix + t_slc + eq_op + "(" + "$signed(" + s0_signed_s + s0_prefix + all_s0_name + s0_suffix + s0_slc + s0_signed_e + ")"+  " >>> " + s1_signed_s + s1_prefix + all_s1_name + s1_suffix + s1_slc + s1_signed_e + ");" + cmd.info + "\n"
                    elif (cmd.op == op_type.and_t):
                        line = self.indent(new_cnt) + pre_type + t_prefix + all_t_name + t_suffix + t_slc + eq_op + "(" + s0_signed_s + s0_prefix + all_s0_name + s0_suffix + s0_slc + s0_signed_e +  " & " + s1_signed_s + s1_prefix + all_s1_name + s1_suffix + s1_slc + s1_signed_e + ");" + cmd.info + "\n"
                    elif (cmd.op == op_type.xor):
                        line = self.indent(new_cnt) + pre_type + t_prefix + all_t_name + t_suffix + t_slc + eq_op + "(" + s0_signed_s + s0_prefix + all_s0_name + s0_suffix + s0_slc + s0_signed_e +  " ^ " + s1_signed_s + s1_prefix + all_s1_name + s1_suffix + s1_slc + s1_signed_e + ");" + cmd.info + "\n"
                    elif (cmd.op == op_type.or_t):
                        line = self.indent(new_cnt) + pre_type + t_prefix + all_t_name + t_suffix + t_slc + eq_op + "(" + s0_signed_s + s0_prefix + all_s0_name + s0_suffix + s0_slc + s0_signed_e +  " | " + s1_signed_s + s1_prefix + all_s1_name + s1_suffix + s1_slc + s1_signed_e + ");" + cmd.info + "\n"
                    elif (cmd.op == op_type.inv):
                        line = self.indent(new_cnt) + pre_type + t_prefix + all_t_name + t_suffix + t_slc + eq_op + "~" + s0_signed_s + s0_prefix + all_s0_name + s0_suffix + s0_slc + s0_signed_e +  ";" + cmd.info + "\n"
                    elif (cmd.op == op_type.neg):
                        line = self.indent(new_cnt) + pre_type + t_prefix + all_t_name + t_suffix + t_slc + eq_op + "(" + "-" + s0_signed_s + s0_prefix + all_s0_name + s0_suffix + s0_slc + s0_signed_e +  ")" + ";" + cmd.info + "\n"
                    elif (cmd.op == op_type.r_and):
                        line = self.indent(new_cnt) + pre_type + t_prefix + all_t_name + t_suffix + t_slc + eq_op + "&" + s0_signed_s + s0_prefix + all_s0_name + s0_suffix + s0_slc + s0_signed_e +  ";" + cmd.info + "\n"
                    elif (cmd.op == op_type.r_or):
                        line = self.indent(new_cnt) + pre_type + t_prefix + all_t_name + t_suffix + t_slc + eq_op + "|" + s0_signed_s + s0_prefix + all_s0_name + s0_suffix + s0_slc + s0_signed_e +  ";" + cmd.info + "\n"
                    elif (cmd.op == op_type.r_xor):
                        line = self.indent(new_cnt) + pre_type + t_prefix + all_t_name + t_suffix + t_slc + eq_op + "^" + s0_signed_s + s0_prefix + all_s0_name + s0_suffix + s0_slc + s0_signed_e +  ";" + cmd.info + "\n"
                    elif (cmd.op == op_type.eq):
                        line = self.indent(new_cnt) + pre_type + t_prefix + all_t_name + t_suffix + t_slc + eq_op + "(" + s0_signed_s + s0_prefix + all_s0_name + s0_suffix + s0_slc + s0_signed_e +  " == " + s1_signed_s + s1_prefix + all_s1_name + s1_suffix + s1_slc + s1_signed_e + ");" + cmd.info + "\n"
                    elif (cmd.op == op_type.ne):
                        line = self.indent(new_cnt) + pre_type + t_prefix + all_t_name + t_suffix + t_slc + eq_op + "(" + s0_signed_s + s0_prefix + all_s0_name + s0_suffix + s0_slc + s0_signed_e +  " != " + s1_signed_s + s1_prefix + all_s1_name + s1_suffix + s1_slc + s1_signed_e + ");" + cmd.info + "\n"
                    elif (cmd.op == op_type.gt):
                        line = self.indent(new_cnt) + pre_type + t_prefix + all_t_name + t_suffix + t_slc + eq_op + "(" + s0_signed_s + s0_prefix + all_s0_name + s0_suffix + s0_slc + s0_signed_e +  " > " + s1_signed_s + s1_prefix + all_s1_name + s1_suffix + s1_slc + s1_signed_e + ");" + cmd.info + "\n"
                    elif (cmd.op == op_type.lt):
                        line = self.indent(new_cnt) + pre_type + t_prefix + all_t_name + t_suffix + t_slc + eq_op + "(" + s0_signed_s + s0_prefix + all_s0_name + s0_suffix + s0_slc + s0_signed_e +  " < " + s1_signed_s + s1_prefix + all_s1_name + s1_suffix + s1_slc + s1_signed_e + ");" + cmd.info + "\n"
                    elif (cmd.op == op_type.ge):
                        line = self.indent(new_cnt) + pre_type + t_prefix + all_t_name + t_suffix + t_slc + eq_op + "(" + s0_signed_s + s0_prefix + all_s0_name + s0_suffix + s0_slc + s0_signed_e +  " >= " + s1_signed_s + s1_prefix + all_s1_name + s1_suffix + s1_slc + s1_signed_e + ");" + cmd.info + "\n"
                    elif (cmd.op == op_type.le):
                        line = self.indent(new_cnt) + pre_type + t_prefix + all_t_name + t_suffix + t_slc + eq_op + "(" + s0_signed_s + s0_prefix + all_s0_name + s0_suffix + s0_slc + s0_signed_e +  " <= " + s1_signed_s + s1_prefix + all_s1_name + s1_suffix + s1_slc + s1_signed_e + ");" + cmd.info + "\n"
                    elif (cmd.op == op_type.mux):
                        line = self.indent(new_cnt) + pre_type + t_prefix + all_t_name + t_suffix + t_slc + eq_op + "(" + s0_signed_s + s0_prefix + all_s0_name + s0_suffix + s0_slc + s0_signed_e +  " ? " + s1_signed_s + s1_prefix + all_s1_name + s1_suffix  + s1_slc + s1_signed_e + " : " + s2_signed_s + s2_prefix + all_s2_name + s2_suffix + s2_slc + s2_signed_e + ");" + cmd.info + "\n"
                    elif (cmd.op == op_type.rep):
                        line = self.indent(new_cnt) + pre_type + t_prefix + all_t_name + t_suffix + t_slc + eq_op + "{" + s0_signed_s + s0_prefix + all_s0_name + s0_suffix + s0_slc + s0_signed_e + "{" + s1_signed_s + s1_prefix + all_s1_name + s1_suffix + s1_slc + s1_signed_e + "}" + "};" + cmd.info + "\n"
                    elif (cmd.op == op_type.cat):
                        line = self.indent(new_cnt) + pre_type + t_prefix + all_t_name + t_suffix + t_slc + eq_op + "{" + s0_signed_s + s0_prefix + all_s0_name + s0_suffix + s0_slc + s0_signed_e +  ", " + s1_signed_s + s1_prefix + all_s1_name + s1_suffix + s1_slc + s1_signed_e + "};" + cmd.info + "\n"
                    else:
                        assert(0), "do not support op %s" % (cmd.op)
    
                    if (cmd.post_t != 0):
                        line = '//' + line
                    self.print0(line)
     
                    if (cmd.t.auto_gen == 1):
                        if (cmd.if_cnt != 0 or
                            cmd.else_cnt != 0 or
                            cmd.vblk_cnt != 0
                           ):
                            auto_gen_logic_str += self.indent(1) + line.lstrip()
                        else:
                            normal_logic_str += line
                    else:
                        normal_logic_str += line
            elif (isinstance(cmd,module)):
                tmp = self.gen_inst_module(cmd)
                defi_str += tmp[0]
                normal_logic_str += tmp[1]
            elif (isinstance(cmd,if_else_chain)):
                tmp_line = ""
                indent_incr = 0
                if (cnt == 1):
                    indent_incr = 1
    
                if (cmd.flag == "if" or cmd.flag == "blk"):
                    if (cnt == 1):
                        if (cmd.t == None): #always(*)
                            head_str = self.indent(cnt) + "always @(*)%s\n" % cmd.info
                        elif (cmd.t == 'posedge'): # always (posedge clk)
                            head_str = self.indent(cnt) + "always @(posedge %s)%s\n" % (self.gen_all_sig_name(cmd.clock), cmd.info)
                        elif (cmd.t == 'negedge'): # always (negedge clk)
                            head_str = self.indent(cnt) + "always @(negedge %s)%s\n" % (self.gen_all_sig_name(cmd.clock), cmd.info)
                        else:
                            assert(False), "cmd.t(%s) illegal" % cmd.t
                        if (cmd.flag == 'if'):
                            line = head_str + \
                            self.indent(cnt+indent_incr) + "if (" + cmd.cond.name + ") begin\n"
                        elif (cmd.flag == 'blk'):
                            line = head_str + \
                            self.indent(cnt+indent_incr) + "begin\n"
    
                    else:
                        line = self.indent(cnt+indent_incr) + "if (" + cmd.cond.name + ") begin\n"
                else:
                    line = self.indent(cnt+indent_incr) + "else begin%s\n" % cmd.info
                self.print0(line)
                normal_logic_str += line
    
                tmp = self.gen_rtl(cmd.cmd_q,cnt+1+indent_incr)
                defi_port_str += tmp[0]
                defi_str += tmp[1]
                defi_dff_str += tmp[2]
                auto_gen_logic_str += tmp[3]
                normal_logic_str += tmp[4]
                printf_str += tmp[5]
    
                line = self.indent(cnt+indent_incr) + "end\n"
                self.print0(line)
                normal_logic_str += line
            else:
                assert(0)
        
        return [
            defi_port_str, defi_str, defi_dff_str, auto_gen_logic_str, 
            normal_logic_str, printf_str, macro_str]
    
    def gen_module(self, m):
        out_v = ""
        macro_v = ""
        
        if (m.suffix_cnt == 0):
            suffix_str = ""
        else:
            suffix_str = "_" + str(m.suffix_cnt)
        def_type =  'module '
        param = ''
        md_name = m.pc_name() + suffix_str + param
        line = (
            self.indent(0) + 
            def_type + 
            md_name + 
            "(\n")
        self.print0(line)
        out_v += line
        
        tmp = self.gen_rtl(m.cmd_q,1)
        mobj = re.match(r'(.*),(.*)$', tmp[0], re.S)
        if (mobj != None):
            out_v += mobj.group(1) + " " + mobj.group(2)
        else:
            out_v += tmp[0]
        line = self.indent(0) + ");\n"
        out_v += line
        out_v += tmp[1] 
        out_v += tmp[2] 
        out_v += tmp[3] 
        out_v += tmp[4] 
        out_v += tmp[5] 
        macro_v += tmp[6]

        if (isinstance(m, csr_module)):
            regs = m.gen_xls()
            if (regs == []):
                reg_xls = []
            else:
                reg_xls = [md_name,regs]
        else:
            reg_xls = []
    
        line = self.indent(0) + "endmodule\n"
        self.print0(line)
        out_v += line
    
        if (m.pm.vlib is not None):
            v_fh = open(m.pm.vlib, 'r')
            v_text = v_fh.read()
            v_fh.close()
            out_v = v_text+'\n'
        elif (m.pm.vuser is not None):
            v_text = ''
            for i in m.pm.vuser:
                if (i[0] == 'inc'):
                    v_text += '`include "%s"\n' %(i[1])
                elif (i[0] == 'code'):
                    v_text += '%s\n' %(i[1])
                else:
                    assert(0)
            out_v = v_text
    
        return (out_v, macro_v, reg_xls)
    
    def gen_csr_xls_book(self, a):
        workbook = xlwt.Workbook(encoding = 'utf-8')

        font = xlwt.Font()
        font.name = 'Consolas'

        #comments col need wrap
        comments_alignment = xlwt.Alignment()
        comments_alignment.wrap = 1

        #cell borders line
        borders = xlwt.Borders()
        borders.left = 1
        borders.right = 1
        borders.top = 1
        borders.bottom = 1

        #title row color
        title_pattern = xlwt.Pattern()
        title_pattern.pattern = xlwt.Pattern.SOLID_PATTERN
        title_pattern.pattern_fore_colour = 50 #green

        #reg row color
        reg_pattern = xlwt.Pattern()
        reg_pattern.pattern = xlwt.Pattern.SOLID_PATTERN
        reg_pattern.pattern_fore_colour = 52

        #field row color
        field_pattern = xlwt.Pattern()
        field_pattern.pattern = xlwt.Pattern.SOLID_PATTERN
        field_pattern.pattern_fore_colour = 26


        title_style = xlwt.XFStyle()
        title_style.font = font
        title_style.borders = borders
        title_style.pattern = title_pattern
        title_comments_style = xlwt.XFStyle()
        title_comments_style.font = font
        title_comments_style.borders = borders
        title_comments_style.alignment = comments_alignment
        title_comments_style.pattern = title_pattern

        reg_style = xlwt.XFStyle()
        reg_style.font = font
        reg_style.borders = borders
        reg_style.pattern = reg_pattern
        reg_comments_style = xlwt.XFStyle()
        reg_comments_style.font = font
        reg_comments_style.borders = borders
        reg_comments_style.alignment = comments_alignment
        reg_comments_style.pattern = reg_pattern

        field_style = xlwt.XFStyle()
        field_style.font = font
        field_style.borders = borders
        field_style.pattern = field_pattern
        field_comments_style = xlwt.XFStyle()
        field_comments_style.font = font
        field_comments_style.borders = borders
        field_comments_style.alignment = comments_alignment
        field_comments_style.pattern = field_pattern

        no_csr = 1
        for md in a:
            if (md != []):
                no_csr = 0;
                worksheet = workbook.add_sheet(md[0])
                worksheet.write(0, 0, 'reg_name', title_style)
                worksheet.write(0, 1, 'offset',   title_style)
                worksheet.write(0, 2, 'size',     title_style)
                worksheet.write(0, 3, 'mem_size', title_style)

                worksheet.write(0, 4, 'field_name', title_style)
                worksheet.write(0, 5, 'access',     title_style)
                worksheet.write(0, 6, 'wr_action',  title_style)
                worksheet.write(0, 7, 'rd_action',  title_style)
                worksheet.write(0, 8, 'width',      title_style)
                worksheet.write(0, 9, 'bits_range', title_style)
                worksheet.write(0, 10, 'reset',     title_style)
                worksheet.write(0, 11, 'comments',  title_comments_style)

                row_num = 1;
                #initial col width
                str_width = [10,10,10,10,10,10,10,10,10,10,10,30]
                for r in md[1]:
                    worksheet.write(row_num, 0,  r[0],  reg_style)
                    worksheet.write(row_num, 1,  r[1],  reg_style)
                    worksheet.write(row_num, 2,  r[2],  reg_style)
                    worksheet.write(row_num, 3,  r[3],  reg_style)
                    worksheet.write(row_num, 4,  '',    reg_style)
                    worksheet.write(row_num, 5,  '',    reg_style)
                    worksheet.write(row_num, 6,  '',    reg_style)
                    worksheet.write(row_num, 7,  '',    reg_style)
                    worksheet.write(row_num, 8,  '',    reg_style)
                    worksheet.write(row_num, 9,  '',    reg_style)
                    worksheet.write(row_num, 10, '',    reg_style)
                    worksheet.write(row_num, 11, r[4],  reg_comments_style)
                    str_width[0] = max(str_width[0], len(r[0])) #reg_name
                    row_num += 1
                    for f in reversed(r[5]):
                        col_num = 4
                        str_width[4] = max(str_width[4], len(f[0])) #field_name
                        str_width[6] = max(str_width[6], len(f[2])) #write_action
                        str_width[7] = max(str_width[7], len(f[3])) #read_action
                        str_width[10] = max(str_width[10], len(f[6])) #reset
                        for term in f:
                            if (col_num == 11):
                                worksheet.write(row_num, col_num, term, field_comments_style)
                            else:
                                worksheet.write(row_num, col_num, term, field_style)
                            col_num += 1
                        row_num += 1

                #col width
                for col in range(len(str_width)):
                    worksheet.col(col).width = (str_width[col] + 1) * 256

                #frozen 1st row
                worksheet.set_panes_frozen('1')
                worksheet.set_horz_split_pos(1)
        if (no_csr):
            return None
        else:
            return workbook

    def gen_top(self):
        code = ""
        macro = ""
        name_map = {}
        reg_xls_all = []
        for m in global_sb.childs:
            if (m.suffix_cnt == 0):
                suffix_str = ""
            else:
                suffix_str = "_" + str(m.suffix_cnt)
            full_name = m.pc_name(
                ) + suffix_str
    
            if (full_name in name_map):
                print("module define code same, jump this module:%s" % full_name)
                continue
            else:
                tmp = self.gen_module(m)
                name_map[full_name] = m
            code += tmp[0]
            macro += tmp[1]
            reg_xls_all.append(tmp[2])
        return (code, macro, self.gen_csr_xls_book(reg_xls_all))
