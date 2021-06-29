#!/usr/bin/python3
import os
import getopt
import sys
import profile
import importlib
import re
from phgl_verilog import *

def main():
    print(sys.argv)
    try:
        opts, args = getopt.getopt(
            sys.argv[1:],
            "hi:m:o:p:",
            [
                "help", "inputfile=", "module=", "outputpath",
                "project", "cfgfile=", "cfg=", "debug", "trace_limit"])
    except getopt.GetoptError:
        print("argv error,please input")

    project = ''
    outputpath = '.'
    cfg_name = 'configure'
    cfgfile = ''
    debug_info = 'all'
    trace_limit = 10
    for n,v in opts:
        if n in ("-p","--project"):
            project = v
        elif n in ("-i","--inputfile"):
            #print(n,v)
            inputfile = v
        elif n in ("-o","--outputpath"):
            #print(n,v)
            outputpath= v
        elif n in ("-m","--module"):
            #print(n,v)
            module_name = v
        elif n in ("--cfg"):
            print(n,v)
            cfg_name = v
        elif n in ("--cfgfile"):
            print(n,v)
            cfgfile = v
        elif n in ("--debug"):
            print(n,v)
            debug_info = v
        elif n in ("--trace_limit"):
            print(n,v)
            trace_limit = v
        else:
            assert(0), "illegal prameter name: %s" %(n)

    input_split = os.path.splitext(inputfile)
    input_split = os.path.split(input_split[0])
    sys.path.append(input_split[0])
    sys.path.append(input_split[0]+'/../')
    module_py = importlib.import_module(input_split[1])
    module_hdl = getattr(module_py,module_name)

    if (cfgfile != ''):
        cfgfile_split = os.path.splitext(cfgfile)
        cfgfile_split = os.path.split(cfgfile_split[0])
        sys.path.append(cfgfile_split[0])
        sys.path.append(cfgfile_split[0]+'/../')
        cfg_py = importlib.import_module(cfgfile_split[1])
        cfg_cls = getattr(cfg_py,cfg_name)
        cfg0 = cfg_cls(cfg_name)

    if (project != ''):
        prefix_proj = project + '_'
    else:
        prefix_proj = ''

    module_hdl.set_proj(project)

    log_fn = outputpath + '/' + prefix_proj + cfg_name + '_' + module_name + '_info.log'
    log_fh = open(log_fn, 'w')
    module_hdl.set_log_fh(log_fh)

    #module_hdl.set_debug_info(debug_info)
    module_hdl.set_debug_info(debug_info, trace_limit)

    module0 = module_hdl(module_name)
    #vcode = gen_vcode(debug = debug_info)
    vcode = gen_vcode(debug = '')
    (code_v, macro_v, csr_xls_book) = vcode.gen_top()
    log_fh.close()

    mfn = prefix_proj + cfg_name + '_' + module_name + '_def.v'
    outputfile = outputpath + '/' + mfn
    f = open(outputfile, 'w')
    f.write(macro_v)
    f.close()


    fn = prefix_proj + cfg_name + '_' + module_name + '.v'
    outputfile = outputpath + '/' + fn
    f = open(outputfile, 'w')
    f.write(code_v)
    f.close()

    xls_fn = prefix_proj + cfg_name + '_' + module_name + '_csr.xls'
    outputfile = outputpath + '/' + xls_fn
    if (csr_xls_book is not None):
        csr_xls_book.save(outputfile)

    outputfilelist = outputpath + '/' + 'dut.f'
    f = open(outputfilelist, 'w')
    f.write("%s/%s\n" % (outputpath, mfn))
    f.write("%s/%s\n" % (outputpath, fn))
    f.close()

if __name__ == "__main__":
    main()
    #profile.run("main()","testprof")
    #profile.run("main()","testprof_no_trace_back")
    #profile.run("main()","testprof_no_assert")
    #profile.run("main()","testprof_less_isinstance1")
    #profile.run("main()","testprof_less_isinstance2")
    #profile.run("main()","testprof_op_type_int")
