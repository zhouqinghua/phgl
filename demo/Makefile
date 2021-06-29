file_list = -f ./tb_all.f


cmp_macro = CLOCK_PERIOD=5.0 U_DLY_IN=0.1 U_DLY_OUT=0.1 VERBOSE
vprint = off
ifeq ($(vprint),on)
    cmp_macro += VPRINT_COND
endif
vassert = on
ifeq ($(vassert),on)
    cmp_macro += VASSERT_COND
endif
vcover = on
ifeq ($(vcover),on)
    cmp_macro += VCOVER_COND
endif
wave = fsdb
ifeq ($(wave),fsdb)
    cmp_macro += FSDB_ON
endif
ifeq ($(wave),vcd)
    cmp_macro += VCD_ON
endif


CMP_MACRO_VCS = $(addprefix +define+, $(cmp_macro))
CMP_MACRO_IVL = $(addprefix -D , $(cmp_macro))

incdir = 
CMP_INCDIR_VCS = $(addprefix +incdir+, $(incdir))
CMP_INCDIR_IVL = $(addprefix -I , $(incdir))

ts = 1ns/10ps
CMP_TS_VCS = -timescale=$(ts)
CMP_TS_IVL = +timescale+$(ts) -dname


cmp_log = ./log/cmp.log
simv_out = ./simv


PLI_OPTS = -P $(NOVAS_INST_DIR)/share/PLI/VCS/$(PLATFORM)/novas.tab \
            $(NOVAS_INST_DIR)/share/PLI/VCS/$(PLATFORM)/pli.a


CMP_OPTS_VCS = \
    -notice -line \
    +lint=all,noVCDE,noONGS,noUI,noNS,noVNGS,noIWU,noMSIVD,noZERO \
   	-error=noIOPCWM \
    +v2k +vcs+lic+wait \
    -sverilog \
    $(CMP_TS_VCS) \
    $(CMP_MACRO_VCS) \
    $(CMP_INCDIR_VCS) \
    $(file_list) \
    $(PLI_OPTS) \
    -l $(cmp_log)

CMP_OPTS_IVL = \
    -g2012 \
    $(CMP_TS_IVL) \
    $(CMP_MACRO_IVL) \
    $(CMP_INCDIR_IVL) \
    $(file_list)

seed = 1
test = zqh_riscv_sanity_test
wave_fn = ./wave/$(test)_$(sw_tc_elf)_$(seed).$(wave)
simv_log = ./log/$(test)_$(sw_tc_elf)_$(seed).log

wave_dump = 1
SIM_PLUS = \
    +ntb_random_seed=$(seed) \
    +wavefile=$(wave_fn) +wave_dump=$(wave_dump) \
    +zqh_test=$(test)
maxfail = 10
SIM_OPTS_VCS = -assert global_finish_maxfail=$(maxfail) -assert nopostproc 
SIM_OPTS_IVL =  


gen_rtl_bin = python3 /home/zqh/risc-v/phgl/phgl_generator.py

#demo_nm = module
#demo_nm = comb_logic
#demo_nm = seq_logic
#demo_nm = with_when
#demo_nm = basic_data_type_bits_reg_xx
#demo_nm = basic_data_type_io_port
#demo_nm = basic_data_type_operator
#demo_nm = complex_data_type_bundle
#demo_nm = complex_data_type_vec
#demo_nm = complex_data_type_operator
#demo_nm = parameter_bundle
#demo_nm = parameter_module
#demo_nm = configure
#demo_nm = method_valid
#demo_nm = method_ready_valid
#demo_nm = method_cat
#demo_nm = method_sel
#demo_nm = method_vassert
#demo_nm = method_vcover
#demo_nm = method_vhex_read
#demo_nm = method_pullup_pulldown
#demo_nm = method_tran
#demo_nm = utils_arbiter
#demo_nm = utils_crc
#demo_nm = utils_csr
#demo_nm = utils_ecc
#demo_nm = utils_async_queue
#demo_nm = utils_async_ready_valid
#demo_nm = utils_reg_array
#demo_nm = utils_clock_divider_sim
#demo_nm = utils_dll_sim
#demo_nm = utils_pad_sim_inout_pin_io
#demo_nm = utils_pad_sim_in_out_inout
demo_nm = utils_pll_sim

gen_m = $(demo_nm)_top
gen_py = ./$(demo_nm)/demo_$(demo_nm).py

gen_cfgfile =
#gen_cfgfile = ./configure/demo_cfgs.py
gen_cfg = cfg_top
#gen_cfg = cfg_sub_module
#gen_cfg = cfg_instance

cfg_opts = 
ifneq ($(gen_cfgfile),)
    cfg_opts = --cfgfile $(gen_cfgfile) --cfg $(gen_cfg)
endif

gen_dir = ./py2rtl

gen_rtl:
	$(gen_rtl_bin) -i $(gen_py) -o $(gen_dir) -m $(gen_m) $(cfg_opts)


cmp_cmd =
sim_cmd =

simulator = vcs#vcs/iverilog
ifeq ($(simulator),vcs)
    cmp_cmd += vcs -full64 $(CMP_OPTS_VCS) -o $(simv_out)_vcs -debug_pp
    sim_cmd += $(simv_out)_vcs +permissive -l $(simv_log) $(SIM_PLUS) $(SIM_OPTS_VCS) +permissive-off $(sw_elf_fn)
else
    ivl_cmp_cmd = iverilog $(CMP_OPTS_IVL) -o $(simv_out)_ivl 2>&1
    cmp_cmd += @echo $(ivl_cmp_cmd) > $(cmp_log); $(ivl_cmp_cmd) | tee -a $(cmp_log)
    sim_cmd += vvp -l $(simv_log) $(simv_out)_ivl +permissive $(SIM_PLUS) $(SIM_OPTS_IVL) +permissive-off $(sw_elf_fn)
endif

cmp:
	$(cmp_cmd)

sim:
	$(sim_cmd)

run: cmp sim

all: gen_rtl cmp sim

verdi:
	verdi -nologo $(CMP_OPTS_VCS) -debug_pp 

clean:
	rm -rf csrc simv* fesvr csrc ucli.key
