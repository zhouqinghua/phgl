module utils_csr_top(
    output wire  io_reg_req_ready, //@ csr.py:216
    input  wire  io_reg_req_valid, //@ csr.py:216
    input  wire  io_reg_req_bits_write, //@ csr.py:216
    input  wire [11:0] io_reg_req_bits_addr, //@ csr.py:216
    input  wire [31:0] io_reg_req_bits_data, //@ csr.py:216
    input  wire [3:0] io_reg_req_bits_be, //@ csr.py:216
    input  wire  io_reg_resp_ready, //@ csr.py:217
    output wire  io_reg_resp_valid, //@ csr.py:217
    output wire [31:0] io_reg_resp_bits_data, //@ csr.py:217
    input  wire [3:0] io_op, //@ demo_utils_csr.py:13
    input  wire [7:0] io_in0, //@ demo_utils_csr.py:14
    input  wire [7:0] io_in1, //@ demo_utils_csr.py:15
    input  wire [7:0] io_out, //@ demo_utils_csr.py:16
    input  wire  clock, //@ phgl_generator.py:85
    input  wire  reset  //@ phgl_generator.py:85
);
    wire [7:0] cfg_regs_rw_field_rw3_i; //@ csr.py:34
    reg  [7:0] cfg_regs_rw_field_rw3_o; //@ csr.py:34
    wire [3:0] cfg_regs_rw_field_rw2_i; //@ csr.py:34
    reg  [3:0] cfg_regs_rw_field_rw2_o; //@ csr.py:34
    wire [2:0] cfg_regs_rw_field_rw1_i; //@ csr.py:31
    reg  [2:0] cfg_regs_rw_field_rw1_o; //@ csr.py:31
    wire  cfg_regs_rw_field_rw0_i; //@ csr.py:34
    reg   cfg_regs_rw_field_rw0_o; //@ csr.py:34
    wire [7:0] cfg_res_rw_ro_field_ro3_i; //@ csr.py:34
    reg  [7:0] cfg_res_rw_ro_field_ro3_o; //@ csr.py:34
    wire [3:0] cfg_res_rw_ro_field_rw2_i; //@ csr.py:34
    reg  [3:0] cfg_res_rw_ro_field_rw2_o; //@ csr.py:34
    wire [2:0] cfg_res_rw_ro_field_ro1_i; //@ csr.py:34
    reg  [2:0] cfg_res_rw_ro_field_ro1_o; //@ csr.py:34
    wire  cfg_res_rw_ro_field_rw0_i; //@ csr.py:34
    reg   cfg_res_rw_ro_field_rw0_o; //@ csr.py:34
    wire  _T_0; //@ demo_utils_csr.py:41
    wire [2:0] _T_1; //@ demo_utils_csr.py:42
    wire [7:0] _T_2; //@ demo_utils_csr.py:42
    wire [2:0] _T_3; //@ demo_utils_csr.py:42
    wire [2:0] _T_4; //@ demo_utils_csr.py:42
    wire  _T_5; //@ demo_utils_csr.py:43
    wire [7:0] _T_6; //@ demo_utils_csr.py:44
    wire [7:0] _T_7; //@ demo_utils_csr.py:44
    wire [3:0] rw_reg_v_i; //@ demo_utils_csr.py:45
    reg  [3:0] rw_reg_v_o; //@ demo_utils_csr.py:45
    wire [7:0] cfg_res_zc_oc_zs_os_field_os3_i; //@ csr.py:34
    reg  [7:0] cfg_res_zc_oc_zs_os_field_os3_o; //@ csr.py:34
    wire [3:0] cfg_res_zc_oc_zs_os_field_zs2_i; //@ csr.py:34
    reg  [3:0] cfg_res_zc_oc_zs_os_field_zs2_o; //@ csr.py:34
    wire [2:0] cfg_res_zc_oc_zs_os_field_oc1_i; //@ csr.py:34
    reg  [2:0] cfg_res_zc_oc_zs_os_field_oc1_o; //@ csr.py:34
    wire  cfg_res_zc_oc_zs_os_field_zc0_i; //@ csr.py:34
    reg   cfg_res_zc_oc_zs_os_field_zc0_o; //@ csr.py:34
    wire [7:0] cfg_res_rw_vol_field_vol3; //@ csr.py:28
    wire [3:0] cfg_res_rw_vol_field_rw2_i; //@ csr.py:34
    reg  [3:0] cfg_res_rw_vol_field_rw2_o; //@ csr.py:34
    wire [2:0] cfg_res_rw_vol_field_vol1; //@ csr.py:28
    wire  cfg_res_rw_vol_field_rw0_i; //@ csr.py:34
    reg   cfg_res_rw_vol_field_rw0_o; //@ csr.py:34
    wire  write_flag_reg_i; //@ demo_utils_csr.py:68
    reg   write_flag_reg_o; //@ demo_utils_csr.py:68
    wire [7:0] write_data_reg_i; //@ demo_utils_csr.py:69
    reg  [7:0] write_data_reg_o; //@ demo_utils_csr.py:69
    wire [7:0] cfg_res_write_action_field_rw3_i; //@ csr.py:34
    reg  [7:0] cfg_res_write_action_field_rw3_o; //@ csr.py:34
    wire [3:0] cfg_res_write_action_field_rw2_i; //@ csr.py:34
    reg  [3:0] cfg_res_write_action_field_rw2_o; //@ csr.py:34
    wire [2:0] cfg_res_write_action_field_rw1_i; //@ csr.py:34
    reg  [2:0] cfg_res_write_action_field_rw1_o; //@ csr.py:34
    wire  cfg_res_write_action_field_rw0_i; //@ csr.py:34
    reg   cfg_res_write_action_field_rw0_o; //@ csr.py:34
    wire  read_flag; //@ demo_utils_csr.py:93
    wire [7:0] read_data_i; //@ demo_utils_csr.py:94
    reg  [7:0] read_data_o; //@ demo_utils_csr.py:94
    wire [7:0] cfg_res_read_action_field_rw3_i; //@ csr.py:34
    reg  [7:0] cfg_res_read_action_field_rw3_o; //@ csr.py:34
    wire [3:0] cfg_res_read_action_field_rw2_i; //@ csr.py:34
    reg  [3:0] cfg_res_read_action_field_rw2_o; //@ csr.py:34
    wire [2:0] cfg_res_read_action_field_rw1_i; //@ csr.py:34
    reg  [2:0] cfg_res_read_action_field_rw1_o; //@ csr.py:34
    wire  cfg_res_read_action_field_rw0_i; //@ csr.py:34
    reg   cfg_res_read_action_field_rw0_o; //@ csr.py:34
    wire [31:0] dumy_mapped_space_data; //@ csr.py:28
    wire  _T_8_i; //@ csr.py:286
    reg   _T_8_o; //@ csr.py:286
    wire  _T_9_write_i; //@ csr.py:287
    reg   _T_9_write_o; //@ csr.py:287
    wire [11:0] _T_9_addr_i; //@ csr.py:287
    reg  [11:0] _T_9_addr_o; //@ csr.py:287
    wire [31:0] _T_9_data_i; //@ csr.py:287
    reg  [31:0] _T_9_data_o; //@ csr.py:287
    wire [3:0] _T_9_be_i; //@ csr.py:287
    reg  [3:0] _T_9_be_o; //@ csr.py:287
    wire  _T_10; //@ csr.py:288
    wire  _T_11_write; //@ csr.py:191
    wire [11:0] _T_11_addr; //@ csr.py:192
    wire [31:0] _T_11_data; //@ csr.py:193
    wire [3:0] _T_11_be; //@ csr.py:194
    wire  _T_12; //@ csr.py:289
    wire [11:0] _T_13; //@ csr.py:289
    wire [31:0] _T_14; //@ csr.py:289
    wire [3:0] _T_15; //@ csr.py:289
    wire  _T_16; //@ csr.py:247
    wire  _T_17; //@ csr.py:296
    wire  _T_18; //@ csr.py:296
    wire  _T_19; //@ csr.py:296
    wire  _T_20; //@ csr.py:296
    wire [7:0] _T_21; //@ csr.py:295
    wire [7:0] _T_22; //@ csr.py:295
    wire [7:0] _T_23; //@ csr.py:295
    wire [7:0] _T_24; //@ csr.py:295
    wire [15:0] _T_25; //@ csr.py:296
    wire [23:0] _T_26; //@ csr.py:296
    wire [31:0] _T_27; //@ csr.py:296
    wire  reg_resp_buf_io_enq_ready; //@ csr.py:303
    wire  reg_resp_buf_io_enq_valid; //@ csr.py:303
    wire [31:0] reg_resp_buf_io_enq_bits_data; //@ csr.py:303
    wire  reg_resp_buf_io_deq_ready; //@ csr.py:303
    wire  reg_resp_buf_io_deq_valid; //@ csr.py:303
    wire [31:0] reg_resp_buf_io_deq_bits_data; //@ csr.py:303
    wire [1:0] reg_resp_buf_io_count; //@ csr.py:303
    wire  reg_resp_buf_clock; //@ csr.py:303
    wire  reg_resp_buf_reset; //@ csr.py:303
    wire [11:0] _T_28; //@ csr.py:232
    wire [9:0] _T_29; //@ csr.py:232
    wire [9:0] _T_30; //@ csr.py:232
    wire [9:0] _T_31; //@ csr.py:232
    wire [11:0] _T_32; //@ csr.py:232
    wire [11:0] _T_33; //@ csr.py:232
    wire [11:0] _T_34; //@ csr.py:232
    wire [11:0] _T_35; //@ csr.py:232
    wire  _T_36; //@ csr.py:321
    wire  _T_37; //@ csr.py:322
    wire  _T_38; //@ csr.py:325
    wire  _T_39; //@ csr.py:325
    wire  _T_40; //@ csr.py:112
    wire  _T_41; //@ csr.py:113
    wire  _T_42; //@ csr.py:114
    wire [31:0] _T_43; //@ csr.py:40
    wire [31:0] _T_44; //@ csr.py:41
    wire [31:0] _T_45; //@ csr.py:41
    wire [31:0] _T_46; //@ csr.py:65
    wire [31:0] _T_47; //@ csr.py:65
    wire [31:0] _T_48; //@ csr.py:65
    wire  _T_49; //@ csr.py:65
    wire [31:0] _T_50; //@ csr.py:65
    wire  _T_51; //@ csr.py:65
    wire  _T_52; //@ csr.py:65
    wire [31:0] _T_53; //@ csr.py:132
    wire [30:0] _T_54; //@ csr.py:132
    wire [30:0] _T_55; //@ csr.py:132
    wire [30:0] _T_56; //@ csr.py:132
    wire [31:0] _T_57; //@ csr.py:133
    wire [30:0] _T_58; //@ csr.py:133
    wire [30:0] _T_59; //@ csr.py:133
    wire [30:0] _T_60; //@ csr.py:133
    wire [30:0] _T_61; //@ csr.py:40
    wire [30:0] _T_62; //@ csr.py:41
    wire [30:0] _T_63; //@ csr.py:41
    wire [30:0] _T_64; //@ csr.py:65
    wire [30:0] _T_65; //@ csr.py:65
    wire [30:0] _T_66; //@ csr.py:65
    wire [2:0] _T_67; //@ csr.py:65
    wire [30:0] _T_68; //@ csr.py:65
    wire [2:0] _T_69; //@ csr.py:65
    wire [2:0] _T_70; //@ csr.py:65
    wire [30:0] _T_71; //@ csr.py:132
    wire [27:0] _T_72; //@ csr.py:132
    wire [27:0] _T_73; //@ csr.py:132
    wire [27:0] _T_74; //@ csr.py:132
    wire [30:0] _T_75; //@ csr.py:133
    wire [27:0] _T_76; //@ csr.py:133
    wire [27:0] _T_77; //@ csr.py:133
    wire [27:0] _T_78; //@ csr.py:133
    wire [27:0] _T_79; //@ csr.py:40
    wire [27:0] _T_80; //@ csr.py:41
    wire [27:0] _T_81; //@ csr.py:41
    wire [27:0] _T_82; //@ csr.py:65
    wire [27:0] _T_83; //@ csr.py:65
    wire [27:0] _T_84; //@ csr.py:65
    wire [3:0] _T_85; //@ csr.py:65
    wire [27:0] _T_86; //@ csr.py:65
    wire [3:0] _T_87; //@ csr.py:65
    wire [3:0] _T_88; //@ csr.py:65
    wire [27:0] _T_89; //@ csr.py:132
    wire [23:0] _T_90; //@ csr.py:132
    wire [23:0] _T_91; //@ csr.py:132
    wire [23:0] _T_92; //@ csr.py:132
    wire [27:0] _T_93; //@ csr.py:133
    wire [23:0] _T_94; //@ csr.py:133
    wire [23:0] _T_95; //@ csr.py:133
    wire [23:0] _T_96; //@ csr.py:133
    wire [23:0] _T_97; //@ csr.py:40
    wire [23:0] _T_98; //@ csr.py:41
    wire [23:0] _T_99; //@ csr.py:41
    wire [23:0] _T_100; //@ csr.py:65
    wire [23:0] _T_101; //@ csr.py:65
    wire [23:0] _T_102; //@ csr.py:65
    wire [7:0] _T_103; //@ csr.py:65
    wire [23:0] _T_104; //@ csr.py:65
    wire [7:0] _T_105; //@ csr.py:65
    wire [7:0] _T_106; //@ csr.py:65
    wire [23:0] _T_107; //@ csr.py:132
    wire [15:0] _T_108; //@ csr.py:132
    wire [15:0] _T_109; //@ csr.py:132
    wire [15:0] _T_110; //@ csr.py:132
    wire [23:0] _T_111; //@ csr.py:133
    wire [15:0] _T_112; //@ csr.py:133
    wire [15:0] _T_113; //@ csr.py:133
    wire [15:0] _T_114; //@ csr.py:133
    wire  _T_115; //@ csr.py:331
    wire  _T_116; //@ csr.py:331
    wire  _T_117; //@ csr.py:142
    wire  _T_118; //@ csr.py:143
    wire  _T_119; //@ csr.py:160
    wire [31:0] _T_120; //@ csr.py:162
    wire [30:0] _T_121; //@ csr.py:162
    wire [30:0] _T_122; //@ csr.py:162
    wire [30:0] _T_123; //@ csr.py:162
    wire [2:0] _T_124; //@ csr.py:160
    wire [30:0] _T_125; //@ csr.py:162
    wire [27:0] _T_126; //@ csr.py:162
    wire [27:0] _T_127; //@ csr.py:162
    wire [27:0] _T_128; //@ csr.py:162
    wire [3:0] _T_129; //@ csr.py:160
    wire [27:0] _T_130; //@ csr.py:162
    wire [23:0] _T_131; //@ csr.py:162
    wire [23:0] _T_132; //@ csr.py:162
    wire [23:0] _T_133; //@ csr.py:162
    wire [7:0] _T_134; //@ csr.py:160
    wire [23:0] _T_135; //@ csr.py:162
    wire [15:0] _T_136; //@ csr.py:162
    wire [15:0] _T_137; //@ csr.py:162
    wire [15:0] _T_138; //@ csr.py:162
    wire [11:0] _T_139; //@ csr.py:169
    wire [14:0] _T_140; //@ csr.py:169
    wire [15:0] _T_141; //@ csr.py:169
    wire [31:0] _T_142; //@ csr.py:169
    wire [31:0] _T_143; //@ csr.py:174
    wire  _T_144; //@ csr.py:336
    wire  _T_145; //@ csr.py:337
    wire  _T_146; //@ csr.py:337
    wire  _T_147; //@ csr.py:339
    wire  _T_148; //@ csr.py:340
    wire  _T_149; //@ csr.py:340
    wire [31:0] _T_150; //@ csr.py:342
    wire [31:0] _T_151; //@ csr.py:343
    wire [31:0] _T_152; //@ csr.py:343
    wire [11:0] _T_153; //@ csr.py:232
    wire [9:0] _T_154; //@ csr.py:232
    wire [9:0] _T_155; //@ csr.py:232
    wire [9:0] _T_156; //@ csr.py:232
    wire [11:0] _T_157; //@ csr.py:232
    wire [11:0] _T_158; //@ csr.py:232
    wire [11:0] _T_159; //@ csr.py:232
    wire [11:0] _T_160; //@ csr.py:232
    wire  _T_161; //@ csr.py:321
    wire  _T_162; //@ csr.py:322
    wire  _T_163; //@ csr.py:325
    wire  _T_164; //@ csr.py:325
    wire  _T_165; //@ csr.py:112
    wire  _T_166; //@ csr.py:113
    wire  _T_167; //@ csr.py:114
    wire [31:0] _T_168; //@ csr.py:40
    wire [31:0] _T_169; //@ csr.py:41
    wire [31:0] _T_170; //@ csr.py:41
    wire [31:0] _T_171; //@ csr.py:65
    wire [31:0] _T_172; //@ csr.py:65
    wire [31:0] _T_173; //@ csr.py:65
    wire  _T_174; //@ csr.py:65
    wire [31:0] _T_175; //@ csr.py:65
    wire  _T_176; //@ csr.py:65
    wire  _T_177; //@ csr.py:65
    wire [31:0] _T_178; //@ csr.py:132
    wire [30:0] _T_179; //@ csr.py:132
    wire [30:0] _T_180; //@ csr.py:132
    wire [30:0] _T_181; //@ csr.py:132
    wire [31:0] _T_182; //@ csr.py:133
    wire [30:0] _T_183; //@ csr.py:133
    wire [30:0] _T_184; //@ csr.py:133
    wire [30:0] _T_185; //@ csr.py:133
    wire [30:0] _T_186; //@ csr.py:40
    wire [30:0] _T_187; //@ csr.py:41
    wire [30:0] _T_188; //@ csr.py:41
    wire [30:0] _T_189; //@ csr.py:132
    wire [27:0] _T_190; //@ csr.py:132
    wire [27:0] _T_191; //@ csr.py:132
    wire [27:0] _T_192; //@ csr.py:132
    wire [30:0] _T_193; //@ csr.py:133
    wire [27:0] _T_194; //@ csr.py:133
    wire [27:0] _T_195; //@ csr.py:133
    wire [27:0] _T_196; //@ csr.py:133
    wire [27:0] _T_197; //@ csr.py:40
    wire [27:0] _T_198; //@ csr.py:41
    wire [27:0] _T_199; //@ csr.py:41
    wire [27:0] _T_200; //@ csr.py:65
    wire [27:0] _T_201; //@ csr.py:65
    wire [27:0] _T_202; //@ csr.py:65
    wire [3:0] _T_203; //@ csr.py:65
    wire [27:0] _T_204; //@ csr.py:65
    wire [3:0] _T_205; //@ csr.py:65
    wire [3:0] _T_206; //@ csr.py:65
    wire [27:0] _T_207; //@ csr.py:132
    wire [23:0] _T_208; //@ csr.py:132
    wire [23:0] _T_209; //@ csr.py:132
    wire [23:0] _T_210; //@ csr.py:132
    wire [27:0] _T_211; //@ csr.py:133
    wire [23:0] _T_212; //@ csr.py:133
    wire [23:0] _T_213; //@ csr.py:133
    wire [23:0] _T_214; //@ csr.py:133
    wire [23:0] _T_215; //@ csr.py:40
    wire [23:0] _T_216; //@ csr.py:41
    wire [23:0] _T_217; //@ csr.py:41
    wire [23:0] _T_218; //@ csr.py:132
    wire [15:0] _T_219; //@ csr.py:132
    wire [15:0] _T_220; //@ csr.py:132
    wire [15:0] _T_221; //@ csr.py:132
    wire [23:0] _T_222; //@ csr.py:133
    wire [15:0] _T_223; //@ csr.py:133
    wire [15:0] _T_224; //@ csr.py:133
    wire [15:0] _T_225; //@ csr.py:133
    wire  _T_226; //@ csr.py:331
    wire  _T_227; //@ csr.py:331
    wire  _T_228; //@ csr.py:142
    wire  _T_229; //@ csr.py:143
    wire  _T_230; //@ csr.py:160
    wire [31:0] _T_231; //@ csr.py:162
    wire [30:0] _T_232; //@ csr.py:162
    wire [30:0] _T_233; //@ csr.py:162
    wire [30:0] _T_234; //@ csr.py:162
    wire [2:0] _T_235; //@ csr.py:160
    wire [30:0] _T_236; //@ csr.py:162
    wire [27:0] _T_237; //@ csr.py:162
    wire [27:0] _T_238; //@ csr.py:162
    wire [27:0] _T_239; //@ csr.py:162
    wire [3:0] _T_240; //@ csr.py:160
    wire [27:0] _T_241; //@ csr.py:162
    wire [23:0] _T_242; //@ csr.py:162
    wire [23:0] _T_243; //@ csr.py:162
    wire [23:0] _T_244; //@ csr.py:162
    wire [7:0] _T_245; //@ csr.py:160
    wire [23:0] _T_246; //@ csr.py:162
    wire [15:0] _T_247; //@ csr.py:162
    wire [15:0] _T_248; //@ csr.py:162
    wire [15:0] _T_249; //@ csr.py:162
    wire [11:0] _T_250; //@ csr.py:169
    wire [14:0] _T_251; //@ csr.py:169
    wire [15:0] _T_252; //@ csr.py:169
    wire [31:0] _T_253; //@ csr.py:169
    wire [31:0] _T_254; //@ csr.py:174
    wire  _T_255; //@ csr.py:336
    wire  _T_256; //@ csr.py:337
    wire  _T_257; //@ csr.py:337
    wire  _T_258; //@ csr.py:339
    wire  _T_259; //@ csr.py:340
    wire  _T_260; //@ csr.py:340
    wire [31:0] _T_261; //@ csr.py:342
    wire [31:0] _T_262; //@ csr.py:343
    wire [31:0] _T_263; //@ csr.py:343
    wire [11:0] _T_264; //@ csr.py:232
    wire [9:0] _T_265; //@ csr.py:232
    wire [9:0] _T_266; //@ csr.py:232
    wire [9:0] _T_267; //@ csr.py:232
    wire [11:0] _T_268; //@ csr.py:232
    wire [11:0] _T_269; //@ csr.py:232
    wire [11:0] _T_270; //@ csr.py:232
    wire [11:0] _T_271; //@ csr.py:232
    wire  _T_272; //@ csr.py:321
    wire  _T_273; //@ csr.py:322
    wire  _T_274; //@ csr.py:325
    wire  _T_275; //@ csr.py:325
    wire  _T_276; //@ csr.py:112
    wire  _T_277; //@ csr.py:113
    wire  _T_278; //@ csr.py:114
    wire [31:0] _T_279; //@ csr.py:40
    wire [31:0] _T_280; //@ csr.py:41
    wire [31:0] _T_281; //@ csr.py:41
    wire [31:0] _T_282; //@ csr.py:55
    wire  _T_283; //@ csr.py:55
    wire [31:0] _T_284; //@ csr.py:55
    wire  _T_285; //@ csr.py:55
    wire  _T_286; //@ csr.py:55
    wire [31:0] _T_287; //@ csr.py:132
    wire [30:0] _T_288; //@ csr.py:132
    wire [30:0] _T_289; //@ csr.py:132
    wire [30:0] _T_290; //@ csr.py:132
    wire [31:0] _T_291; //@ csr.py:133
    wire [30:0] _T_292; //@ csr.py:133
    wire [30:0] _T_293; //@ csr.py:133
    wire [30:0] _T_294; //@ csr.py:133
    wire [30:0] _T_295; //@ csr.py:40
    wire [30:0] _T_296; //@ csr.py:41
    wire [30:0] _T_297; //@ csr.py:41
    wire [30:0] _T_298; //@ csr.py:49
    wire [30:0] _T_299; //@ csr.py:49
    wire [2:0] _T_300; //@ csr.py:49
    wire [30:0] _T_301; //@ csr.py:49
    wire [2:0] _T_302; //@ csr.py:49
    wire [2:0] _T_303; //@ csr.py:49
    wire [30:0] _T_304; //@ csr.py:132
    wire [27:0] _T_305; //@ csr.py:132
    wire [27:0] _T_306; //@ csr.py:132
    wire [27:0] _T_307; //@ csr.py:132
    wire [30:0] _T_308; //@ csr.py:133
    wire [27:0] _T_309; //@ csr.py:133
    wire [27:0] _T_310; //@ csr.py:133
    wire [27:0] _T_311; //@ csr.py:133
    wire [27:0] _T_312; //@ csr.py:40
    wire [27:0] _T_313; //@ csr.py:41
    wire [27:0] _T_314; //@ csr.py:41
    wire [27:0] _T_315; //@ csr.py:57
    wire [27:0] _T_316; //@ csr.py:57
    wire [3:0] _T_317; //@ csr.py:57
    wire [27:0] _T_318; //@ csr.py:57
    wire [3:0] _T_319; //@ csr.py:57
    wire [3:0] _T_320; //@ csr.py:57
    wire [27:0] _T_321; //@ csr.py:132
    wire [23:0] _T_322; //@ csr.py:132
    wire [23:0] _T_323; //@ csr.py:132
    wire [23:0] _T_324; //@ csr.py:132
    wire [27:0] _T_325; //@ csr.py:133
    wire [23:0] _T_326; //@ csr.py:133
    wire [23:0] _T_327; //@ csr.py:133
    wire [23:0] _T_328; //@ csr.py:133
    wire [23:0] _T_329; //@ csr.py:40
    wire [23:0] _T_330; //@ csr.py:41
    wire [23:0] _T_331; //@ csr.py:41
    wire [23:0] _T_332; //@ csr.py:51
    wire [7:0] _T_333; //@ csr.py:51
    wire [23:0] _T_334; //@ csr.py:51
    wire [7:0] _T_335; //@ csr.py:51
    wire [7:0] _T_336; //@ csr.py:51
    wire [23:0] _T_337; //@ csr.py:132
    wire [15:0] _T_338; //@ csr.py:132
    wire [15:0] _T_339; //@ csr.py:132
    wire [15:0] _T_340; //@ csr.py:132
    wire [23:0] _T_341; //@ csr.py:133
    wire [15:0] _T_342; //@ csr.py:133
    wire [15:0] _T_343; //@ csr.py:133
    wire [15:0] _T_344; //@ csr.py:133
    wire  _T_345; //@ csr.py:331
    wire  _T_346; //@ csr.py:331
    wire  _T_347; //@ csr.py:142
    wire  _T_348; //@ csr.py:143
    wire  _T_349; //@ csr.py:160
    wire [31:0] _T_350; //@ csr.py:162
    wire [30:0] _T_351; //@ csr.py:162
    wire [30:0] _T_352; //@ csr.py:162
    wire [30:0] _T_353; //@ csr.py:162
    wire [2:0] _T_354; //@ csr.py:160
    wire [30:0] _T_355; //@ csr.py:162
    wire [27:0] _T_356; //@ csr.py:162
    wire [27:0] _T_357; //@ csr.py:162
    wire [27:0] _T_358; //@ csr.py:162
    wire [3:0] _T_359; //@ csr.py:160
    wire [27:0] _T_360; //@ csr.py:162
    wire [23:0] _T_361; //@ csr.py:162
    wire [23:0] _T_362; //@ csr.py:162
    wire [23:0] _T_363; //@ csr.py:162
    wire [7:0] _T_364; //@ csr.py:160
    wire [23:0] _T_365; //@ csr.py:162
    wire [15:0] _T_366; //@ csr.py:162
    wire [15:0] _T_367; //@ csr.py:162
    wire [15:0] _T_368; //@ csr.py:162
    wire [11:0] _T_369; //@ csr.py:169
    wire [14:0] _T_370; //@ csr.py:169
    wire [15:0] _T_371; //@ csr.py:169
    wire [31:0] _T_372; //@ csr.py:169
    wire [31:0] _T_373; //@ csr.py:174
    wire  _T_374; //@ csr.py:336
    wire  _T_375; //@ csr.py:337
    wire  _T_376; //@ csr.py:337
    wire  _T_377; //@ csr.py:339
    wire  _T_378; //@ csr.py:340
    wire  _T_379; //@ csr.py:340
    wire [31:0] _T_380; //@ csr.py:342
    wire [31:0] _T_381; //@ csr.py:343
    wire [31:0] _T_382; //@ csr.py:343
    wire [11:0] _T_383; //@ csr.py:232
    wire [9:0] _T_384; //@ csr.py:232
    wire [9:0] _T_385; //@ csr.py:232
    wire [9:0] _T_386; //@ csr.py:232
    wire [11:0] _T_387; //@ csr.py:232
    wire [11:0] _T_388; //@ csr.py:232
    wire [11:0] _T_389; //@ csr.py:232
    wire [11:0] _T_390; //@ csr.py:232
    wire  _T_391; //@ csr.py:321
    wire  _T_392; //@ csr.py:322
    wire  _T_393; //@ csr.py:325
    wire  _T_394; //@ csr.py:325
    wire  _T_395; //@ csr.py:112
    wire  _T_396; //@ csr.py:113
    wire  _T_397; //@ csr.py:114
    wire [31:0] _T_398; //@ csr.py:40
    wire [31:0] _T_399; //@ csr.py:41
    wire [31:0] _T_400; //@ csr.py:41
    wire [31:0] _T_401; //@ csr.py:65
    wire [31:0] _T_402; //@ csr.py:65
    wire [31:0] _T_403; //@ csr.py:65
    wire  _T_404; //@ csr.py:65
    wire [31:0] _T_405; //@ csr.py:65
    wire  _T_406; //@ csr.py:65
    wire  _T_407; //@ csr.py:65
    wire [31:0] _T_408; //@ csr.py:132
    wire [30:0] _T_409; //@ csr.py:132
    wire [30:0] _T_410; //@ csr.py:132
    wire [30:0] _T_411; //@ csr.py:132
    wire [31:0] _T_412; //@ csr.py:133
    wire [30:0] _T_413; //@ csr.py:133
    wire [30:0] _T_414; //@ csr.py:133
    wire [30:0] _T_415; //@ csr.py:133
    wire [30:0] _T_416; //@ csr.py:40
    wire [30:0] _T_417; //@ csr.py:41
    wire [30:0] _T_418; //@ csr.py:41
    wire [30:0] _T_419; //@ csr.py:132
    wire [27:0] _T_420; //@ csr.py:132
    wire [27:0] _T_421; //@ csr.py:132
    wire [27:0] _T_422; //@ csr.py:132
    wire [30:0] _T_423; //@ csr.py:133
    wire [27:0] _T_424; //@ csr.py:133
    wire [27:0] _T_425; //@ csr.py:133
    wire [27:0] _T_426; //@ csr.py:133
    wire [27:0] _T_427; //@ csr.py:40
    wire [27:0] _T_428; //@ csr.py:41
    wire [27:0] _T_429; //@ csr.py:41
    wire [27:0] _T_430; //@ csr.py:65
    wire [27:0] _T_431; //@ csr.py:65
    wire [27:0] _T_432; //@ csr.py:65
    wire [3:0] _T_433; //@ csr.py:65
    wire [27:0] _T_434; //@ csr.py:65
    wire [3:0] _T_435; //@ csr.py:65
    wire [3:0] _T_436; //@ csr.py:65
    wire [27:0] _T_437; //@ csr.py:132
    wire [23:0] _T_438; //@ csr.py:132
    wire [23:0] _T_439; //@ csr.py:132
    wire [23:0] _T_440; //@ csr.py:132
    wire [27:0] _T_441; //@ csr.py:133
    wire [23:0] _T_442; //@ csr.py:133
    wire [23:0] _T_443; //@ csr.py:133
    wire [23:0] _T_444; //@ csr.py:133
    wire [23:0] _T_445; //@ csr.py:40
    wire [23:0] _T_446; //@ csr.py:41
    wire [23:0] _T_447; //@ csr.py:41
    wire [23:0] _T_448; //@ csr.py:132
    wire [15:0] _T_449; //@ csr.py:132
    wire [15:0] _T_450; //@ csr.py:132
    wire [15:0] _T_451; //@ csr.py:132
    wire [23:0] _T_452; //@ csr.py:133
    wire [15:0] _T_453; //@ csr.py:133
    wire [15:0] _T_454; //@ csr.py:133
    wire [15:0] _T_455; //@ csr.py:133
    wire  _T_456; //@ csr.py:331
    wire  _T_457; //@ csr.py:331
    wire  _T_458; //@ csr.py:142
    wire  _T_459; //@ csr.py:143
    wire  _T_460; //@ csr.py:160
    wire [31:0] _T_461; //@ csr.py:162
    wire [30:0] _T_462; //@ csr.py:162
    wire [30:0] _T_463; //@ csr.py:162
    wire [30:0] _T_464; //@ csr.py:162
    wire [2:0] _T_465; //@ csr.py:160
    wire [30:0] _T_466; //@ csr.py:162
    wire [27:0] _T_467; //@ csr.py:162
    wire [27:0] _T_468; //@ csr.py:162
    wire [27:0] _T_469; //@ csr.py:162
    wire [3:0] _T_470; //@ csr.py:160
    wire [27:0] _T_471; //@ csr.py:162
    wire [23:0] _T_472; //@ csr.py:162
    wire [23:0] _T_473; //@ csr.py:162
    wire [23:0] _T_474; //@ csr.py:162
    wire [7:0] _T_475; //@ csr.py:160
    wire [23:0] _T_476; //@ csr.py:162
    wire [15:0] _T_477; //@ csr.py:162
    wire [15:0] _T_478; //@ csr.py:162
    wire [15:0] _T_479; //@ csr.py:162
    wire [11:0] _T_480; //@ csr.py:169
    wire [14:0] _T_481; //@ csr.py:169
    wire [15:0] _T_482; //@ csr.py:169
    wire [31:0] _T_483; //@ csr.py:169
    wire [31:0] _T_484; //@ csr.py:174
    wire  _T_485; //@ csr.py:336
    wire  _T_486; //@ csr.py:337
    wire  _T_487; //@ csr.py:337
    wire  _T_488; //@ csr.py:339
    wire  _T_489; //@ csr.py:340
    wire  _T_490; //@ csr.py:340
    wire [31:0] _T_491; //@ csr.py:342
    wire [31:0] _T_492; //@ csr.py:343
    wire [31:0] _T_493; //@ csr.py:343
    wire [11:0] _T_494; //@ csr.py:232
    wire [9:0] _T_495; //@ csr.py:232
    wire [9:0] _T_496; //@ csr.py:232
    wire [9:0] _T_497; //@ csr.py:232
    wire [11:0] _T_498; //@ csr.py:232
    wire [11:0] _T_499; //@ csr.py:232
    wire [11:0] _T_500; //@ csr.py:232
    wire [11:0] _T_501; //@ csr.py:232
    wire  _T_502; //@ csr.py:321
    wire  _T_503; //@ csr.py:322
    wire  _T_504; //@ csr.py:325
    wire  _T_505; //@ csr.py:325
    wire  _T_506; //@ csr.py:112
    wire  _T_507; //@ csr.py:113
    wire  _T_508; //@ csr.py:114
    wire [31:0] _T_509; //@ csr.py:40
    wire [31:0] _T_510; //@ csr.py:41
    wire [31:0] _T_511; //@ csr.py:41
    wire [31:0] _T_512; //@ csr.py:65
    wire [31:0] _T_513; //@ csr.py:65
    wire [31:0] _T_514; //@ csr.py:65
    wire  _T_515; //@ csr.py:65
    wire [31:0] _T_516; //@ csr.py:65
    wire  _T_517; //@ csr.py:65
    wire  _T_518; //@ csr.py:65
    wire [31:0] _T_519; //@ csr.py:132
    wire [30:0] _T_520; //@ csr.py:132
    wire [30:0] _T_521; //@ csr.py:132
    wire [30:0] _T_522; //@ csr.py:132
    wire [31:0] _T_523; //@ csr.py:133
    wire [30:0] _T_524; //@ csr.py:133
    wire [30:0] _T_525; //@ csr.py:133
    wire [30:0] _T_526; //@ csr.py:133
    wire [30:0] _T_527; //@ csr.py:40
    wire [30:0] _T_528; //@ csr.py:41
    wire [30:0] _T_529; //@ csr.py:41
    wire [30:0] _T_530; //@ csr.py:65
    wire [30:0] _T_531; //@ csr.py:65
    wire [30:0] _T_532; //@ csr.py:65
    wire [2:0] _T_533; //@ csr.py:65
    wire [30:0] _T_534; //@ csr.py:65
    wire [2:0] _T_535; //@ csr.py:65
    wire [2:0] _T_536; //@ csr.py:65
    wire [30:0] _T_537; //@ csr.py:132
    wire [27:0] _T_538; //@ csr.py:132
    wire [27:0] _T_539; //@ csr.py:132
    wire [27:0] _T_540; //@ csr.py:132
    wire [30:0] _T_541; //@ csr.py:133
    wire [27:0] _T_542; //@ csr.py:133
    wire [27:0] _T_543; //@ csr.py:133
    wire [27:0] _T_544; //@ csr.py:133
    wire [27:0] _T_545; //@ csr.py:40
    wire [27:0] _T_546; //@ csr.py:41
    wire [27:0] _T_547; //@ csr.py:41
    wire [27:0] _T_548; //@ csr.py:65
    wire [27:0] _T_549; //@ csr.py:65
    wire [27:0] _T_550; //@ csr.py:65
    wire [3:0] _T_551; //@ csr.py:65
    wire [27:0] _T_552; //@ csr.py:65
    wire [3:0] _T_553; //@ csr.py:65
    wire [3:0] _T_554; //@ csr.py:65
    wire [27:0] _T_555; //@ csr.py:132
    wire [23:0] _T_556; //@ csr.py:132
    wire [23:0] _T_557; //@ csr.py:132
    wire [23:0] _T_558; //@ csr.py:132
    wire [27:0] _T_559; //@ csr.py:133
    wire [23:0] _T_560; //@ csr.py:133
    wire [23:0] _T_561; //@ csr.py:133
    wire [23:0] _T_562; //@ csr.py:133
    wire  _T_563; //@ demo_utils_csr.py:74
    wire  _T_564; //@ demo_utils_csr.py:74
    wire [7:0] _T_565; //@ demo_utils_csr.py:78
    wire [7:0] _T_566; //@ demo_utils_csr.py:78
    wire [7:0] _T_567; //@ demo_utils_csr.py:78
    wire [7:0] _T_568; //@ demo_utils_csr.py:81
    wire [7:0] _T_569; //@ demo_utils_csr.py:81
    wire [7:0] _T_570; //@ demo_utils_csr.py:81
    wire [23:0] _T_571; //@ csr.py:132
    wire [15:0] _T_572; //@ csr.py:132
    wire [15:0] _T_573; //@ csr.py:132
    wire [15:0] _T_574; //@ csr.py:132
    wire [23:0] _T_575; //@ csr.py:133
    wire [15:0] _T_576; //@ csr.py:133
    wire [15:0] _T_577; //@ csr.py:133
    wire [15:0] _T_578; //@ csr.py:133
    wire  _T_579; //@ csr.py:331
    wire  _T_580; //@ csr.py:331
    wire  _T_581; //@ csr.py:142
    wire  _T_582; //@ csr.py:143
    wire  _T_583; //@ csr.py:160
    wire [31:0] _T_584; //@ csr.py:162
    wire [30:0] _T_585; //@ csr.py:162
    wire [30:0] _T_586; //@ csr.py:162
    wire [30:0] _T_587; //@ csr.py:162
    wire [2:0] _T_588; //@ csr.py:160
    wire [30:0] _T_589; //@ csr.py:162
    wire [27:0] _T_590; //@ csr.py:162
    wire [27:0] _T_591; //@ csr.py:162
    wire [27:0] _T_592; //@ csr.py:162
    wire [3:0] _T_593; //@ csr.py:160
    wire [27:0] _T_594; //@ csr.py:162
    wire [23:0] _T_595; //@ csr.py:162
    wire [23:0] _T_596; //@ csr.py:162
    wire [23:0] _T_597; //@ csr.py:162
    wire [7:0] _T_598; //@ csr.py:160
    wire [23:0] _T_599; //@ csr.py:162
    wire [15:0] _T_600; //@ csr.py:162
    wire [15:0] _T_601; //@ csr.py:162
    wire [15:0] _T_602; //@ csr.py:162
    wire [11:0] _T_603; //@ csr.py:169
    wire [14:0] _T_604; //@ csr.py:169
    wire [15:0] _T_605; //@ csr.py:169
    wire [31:0] _T_606; //@ csr.py:169
    wire [31:0] _T_607; //@ csr.py:174
    wire  _T_608; //@ csr.py:336
    wire  _T_609; //@ csr.py:337
    wire  _T_610; //@ csr.py:337
    wire  _T_611; //@ csr.py:339
    wire  _T_612; //@ csr.py:340
    wire  _T_613; //@ csr.py:340
    wire [31:0] _T_614; //@ csr.py:342
    wire [31:0] _T_615; //@ csr.py:343
    wire [31:0] _T_616; //@ csr.py:343
    wire [11:0] _T_617; //@ csr.py:232
    wire [9:0] _T_618; //@ csr.py:232
    wire [9:0] _T_619; //@ csr.py:232
    wire [9:0] _T_620; //@ csr.py:232
    wire [11:0] _T_621; //@ csr.py:232
    wire [11:0] _T_622; //@ csr.py:232
    wire [11:0] _T_623; //@ csr.py:232
    wire [11:0] _T_624; //@ csr.py:232
    wire  _T_625; //@ csr.py:321
    wire  _T_626; //@ csr.py:322
    wire  _T_627; //@ csr.py:325
    wire  _T_628; //@ csr.py:325
    wire  _T_629; //@ csr.py:112
    wire  _T_630; //@ csr.py:113
    wire  _T_631; //@ csr.py:114
    wire [31:0] _T_632; //@ csr.py:40
    wire [31:0] _T_633; //@ csr.py:41
    wire [31:0] _T_634; //@ csr.py:41
    wire [31:0] _T_635; //@ csr.py:65
    wire [31:0] _T_636; //@ csr.py:65
    wire [31:0] _T_637; //@ csr.py:65
    wire  _T_638; //@ csr.py:65
    wire [31:0] _T_639; //@ csr.py:65
    wire  _T_640; //@ csr.py:65
    wire  _T_641; //@ csr.py:65
    wire [31:0] _T_642; //@ csr.py:132
    wire [30:0] _T_643; //@ csr.py:132
    wire [30:0] _T_644; //@ csr.py:132
    wire [30:0] _T_645; //@ csr.py:132
    wire [31:0] _T_646; //@ csr.py:133
    wire [30:0] _T_647; //@ csr.py:133
    wire [30:0] _T_648; //@ csr.py:133
    wire [30:0] _T_649; //@ csr.py:133
    wire [30:0] _T_650; //@ csr.py:40
    wire [30:0] _T_651; //@ csr.py:41
    wire [30:0] _T_652; //@ csr.py:41
    wire [30:0] _T_653; //@ csr.py:65
    wire [30:0] _T_654; //@ csr.py:65
    wire [30:0] _T_655; //@ csr.py:65
    wire [2:0] _T_656; //@ csr.py:65
    wire [30:0] _T_657; //@ csr.py:65
    wire [2:0] _T_658; //@ csr.py:65
    wire [2:0] _T_659; //@ csr.py:65
    wire [30:0] _T_660; //@ csr.py:132
    wire [27:0] _T_661; //@ csr.py:132
    wire [27:0] _T_662; //@ csr.py:132
    wire [27:0] _T_663; //@ csr.py:132
    wire [30:0] _T_664; //@ csr.py:133
    wire [27:0] _T_665; //@ csr.py:133
    wire [27:0] _T_666; //@ csr.py:133
    wire [27:0] _T_667; //@ csr.py:133
    wire [27:0] _T_668; //@ csr.py:40
    wire [27:0] _T_669; //@ csr.py:41
    wire [27:0] _T_670; //@ csr.py:41
    wire [27:0] _T_671; //@ csr.py:65
    wire [27:0] _T_672; //@ csr.py:65
    wire [27:0] _T_673; //@ csr.py:65
    wire [3:0] _T_674; //@ csr.py:65
    wire [27:0] _T_675; //@ csr.py:65
    wire [3:0] _T_676; //@ csr.py:65
    wire [3:0] _T_677; //@ csr.py:65
    wire [27:0] _T_678; //@ csr.py:132
    wire [23:0] _T_679; //@ csr.py:132
    wire [23:0] _T_680; //@ csr.py:132
    wire [23:0] _T_681; //@ csr.py:132
    wire [27:0] _T_682; //@ csr.py:133
    wire [23:0] _T_683; //@ csr.py:133
    wire [23:0] _T_684; //@ csr.py:133
    wire [23:0] _T_685; //@ csr.py:133
    wire [23:0] _T_686; //@ csr.py:40
    wire [23:0] _T_687; //@ csr.py:41
    wire [23:0] _T_688; //@ csr.py:41
    wire [23:0] _T_689; //@ csr.py:65
    wire [23:0] _T_690; //@ csr.py:65
    wire [23:0] _T_691; //@ csr.py:65
    wire [7:0] _T_692; //@ csr.py:65
    wire [23:0] _T_693; //@ csr.py:65
    wire [7:0] _T_694; //@ csr.py:65
    wire [7:0] _T_695; //@ csr.py:65
    wire [23:0] _T_696; //@ csr.py:132
    wire [15:0] _T_697; //@ csr.py:132
    wire [15:0] _T_698; //@ csr.py:132
    wire [15:0] _T_699; //@ csr.py:132
    wire [23:0] _T_700; //@ csr.py:133
    wire [15:0] _T_701; //@ csr.py:133
    wire [15:0] _T_702; //@ csr.py:133
    wire [15:0] _T_703; //@ csr.py:133
    wire  _T_704; //@ csr.py:331
    wire  _T_705; //@ csr.py:331
    wire  _T_706; //@ csr.py:142
    wire  _T_707; //@ csr.py:143
    wire  _T_708; //@ csr.py:160
    wire [31:0] _T_709; //@ csr.py:162
    wire [30:0] _T_710; //@ csr.py:162
    wire [30:0] _T_711; //@ csr.py:162
    wire [30:0] _T_712; //@ csr.py:162
    wire [2:0] _T_713; //@ csr.py:160
    wire [30:0] _T_714; //@ csr.py:162
    wire [27:0] _T_715; //@ csr.py:162
    wire [27:0] _T_716; //@ csr.py:162
    wire [27:0] _T_717; //@ csr.py:162
    wire [3:0] _T_718; //@ csr.py:160
    wire [27:0] _T_719; //@ csr.py:162
    wire [23:0] _T_720; //@ csr.py:162
    wire [23:0] _T_721; //@ csr.py:162
    wire [23:0] _T_722; //@ csr.py:162
    wire  _T_723; //@ demo_utils_csr.py:98
    wire  _T_724; //@ demo_utils_csr.py:98
    wire [7:0] _T_725; //@ csr.py:160
    wire [23:0] _T_726; //@ csr.py:162
    wire [15:0] _T_727; //@ csr.py:162
    wire [15:0] _T_728; //@ csr.py:162
    wire [15:0] _T_729; //@ csr.py:162
    wire [11:0] _T_730; //@ csr.py:169
    wire [14:0] _T_731; //@ csr.py:169
    wire [15:0] _T_732; //@ csr.py:169
    wire [31:0] _T_733; //@ csr.py:169
    wire [31:0] _T_734; //@ csr.py:174
    wire  _T_735; //@ csr.py:336
    wire  _T_736; //@ csr.py:337
    wire  _T_737; //@ csr.py:337
    wire  _T_738; //@ csr.py:339
    wire  _T_739; //@ csr.py:340
    wire  _T_740; //@ csr.py:340
    wire [31:0] _T_741; //@ csr.py:342
    wire [31:0] _T_742; //@ csr.py:343
    wire [31:0] _T_743; //@ csr.py:343
    wire [11:0] _T_744; //@ csr.py:232
    wire [9:0] _T_745; //@ csr.py:232
    wire [9:0] _T_746; //@ csr.py:232
    wire [9:0] _T_747; //@ csr.py:232
    wire [11:0] _T_748; //@ csr.py:232
    wire [11:0] _T_749; //@ csr.py:232
    wire [11:0] _T_750; //@ csr.py:232
    wire [11:0] _T_751; //@ csr.py:232
    wire  _T_752; //@ csr.py:319
    wire  _T_753; //@ csr.py:322
    wire  _T_754; //@ csr.py:325
    wire  _T_755; //@ csr.py:325
    wire  _T_756; //@ csr.py:112
    wire  _T_757; //@ csr.py:113
    wire  _T_758; //@ csr.py:114
    wire [31:0] _T_759; //@ csr.py:40
    wire [31:0] _T_760; //@ csr.py:41
    wire [31:0] _T_761; //@ csr.py:41
    wire [31:0] _T_762; //@ csr.py:132
    wire  _T_763; //@ csr.py:132
    wire  _T_764; //@ csr.py:132
    wire  _T_765; //@ csr.py:132
    wire [31:0] _T_766; //@ csr.py:133
    wire  _T_767; //@ csr.py:133
    wire  _T_768; //@ csr.py:133
    wire  _T_769; //@ csr.py:133
    wire  _T_770; //@ csr.py:331
    wire  _T_771; //@ csr.py:331
    wire  _T_772; //@ csr.py:142
    wire  _T_773; //@ csr.py:143
    wire [31:0] _T_774; //@ csr.py:160
    wire [31:0] _T_775; //@ csr.py:162
    wire  _T_776; //@ csr.py:162
    wire  _T_777; //@ csr.py:162
    wire  _T_778; //@ csr.py:162
    wire [31:0] _T_779; //@ csr.py:174
    wire  _T_780; //@ csr.py:336
    wire  _T_781; //@ csr.py:337
    wire  _T_782; //@ csr.py:337
    wire  _T_783; //@ csr.py:339
    wire  _T_784; //@ csr.py:340
    wire  _T_785; //@ csr.py:340
    wire [31:0] _T_786; //@ csr.py:342
    wire [31:0] _T_787; //@ csr.py:343
    wire [31:0] _T_788; //@ csr.py:343
    wire  _T_789; //@ csr.py:345
    wire  _T_790; //@ csr.py:345
    wire [31:0] _T_791_data; //@ csr.py:265
    wire  _T_792; //@ csr.py:349
    wire  _T_793; //@ csr.py:349
    wire  _T_794; //@ csr.py:350
    wire  _T_795; //@ csr.py:354
    wire  _T_796; //@ csr.py:354
    wire  _T_797; //@ csr.py:354
    wire  _T_798; //@ csr.py:355
    wire  _T_799; //@ csr.py:355
    wire [3:0] _T_800; //@ csr.py:356
    wire [3:0] _T_801; //@ csr.py:356
    wire [31:0] _T_802; //@ csr.py:356
    wire [31:0] _T_803; //@ csr.py:356
    wire [11:0] _T_804; //@ csr.py:356
    wire [11:0] _T_805; //@ csr.py:356
    wire  _T_806; //@ csr.py:356
    wire  _T_807; //@ csr.py:356
    wire  _T_808; //@ csr.py:357
    wire  _T_809; //@ csr.py:357
    wire  _T_810; //@ csr.py:357
    wire  _T_811; //@ csr.py:357
    wire  _T_812; //@ csr.py:357
    wire  _T_813; //@ csr.py:358
    wire  _T_814; //@ csr.py:358
    always @(posedge clock) //@ csr.py:34
        if (reset)
            cfg_regs_rw_field_rw3_o <= 8'h0;
        else
            cfg_regs_rw_field_rw3_o <= cfg_regs_rw_field_rw3_i;
    always @(posedge clock) //@ csr.py:34
        if (reset)
            cfg_regs_rw_field_rw2_o <= 4'h5;
        else
            cfg_regs_rw_field_rw2_o <= cfg_regs_rw_field_rw2_i;
    always @(posedge clock) //@ csr.py:31
        cfg_regs_rw_field_rw1_o <= cfg_regs_rw_field_rw1_i;
    always @(posedge clock) //@ csr.py:34
        if (reset)
            cfg_regs_rw_field_rw0_o <= 1'h0;
        else
            cfg_regs_rw_field_rw0_o <= cfg_regs_rw_field_rw0_i;
    always @(posedge clock) //@ csr.py:34
        if (reset)
            cfg_res_rw_ro_field_ro3_o <= 8'h0;
        else
            cfg_res_rw_ro_field_ro3_o <= cfg_res_rw_ro_field_ro3_i;
    always @(posedge clock) //@ csr.py:34
        if (reset)
            cfg_res_rw_ro_field_rw2_o <= 4'h0;
        else
            cfg_res_rw_ro_field_rw2_o <= cfg_res_rw_ro_field_rw2_i;
    always @(posedge clock) //@ csr.py:34
        if (reset)
            cfg_res_rw_ro_field_ro1_o <= 3'h0;
        else
            cfg_res_rw_ro_field_ro1_o <= cfg_res_rw_ro_field_ro1_i;
    always @(posedge clock) //@ csr.py:34
        if (reset)
            cfg_res_rw_ro_field_rw0_o <= 1'h0;
        else
            cfg_res_rw_ro_field_rw0_o <= cfg_res_rw_ro_field_rw0_i;
    always @(posedge clock) //@ demo_utils_csr.py:45
        if (reset)
            rw_reg_v_o <= 4'h0;
        else
            rw_reg_v_o <= rw_reg_v_i;
    always @(posedge clock) //@ csr.py:34
        if (reset)
            cfg_res_zc_oc_zs_os_field_os3_o <= 8'h0;
        else
            cfg_res_zc_oc_zs_os_field_os3_o <= cfg_res_zc_oc_zs_os_field_os3_i;
    always @(posedge clock) //@ csr.py:34
        if (reset)
            cfg_res_zc_oc_zs_os_field_zs2_o <= 4'h0;
        else
            cfg_res_zc_oc_zs_os_field_zs2_o <= cfg_res_zc_oc_zs_os_field_zs2_i;
    always @(posedge clock) //@ csr.py:34
        if (reset)
            cfg_res_zc_oc_zs_os_field_oc1_o <= 3'h0;
        else
            cfg_res_zc_oc_zs_os_field_oc1_o <= cfg_res_zc_oc_zs_os_field_oc1_i;
    always @(posedge clock) //@ csr.py:34
        if (reset)
            cfg_res_zc_oc_zs_os_field_zc0_o <= 1'h0;
        else
            cfg_res_zc_oc_zs_os_field_zc0_o <= cfg_res_zc_oc_zs_os_field_zc0_i;
    always @(posedge clock) //@ csr.py:34
        if (reset)
            cfg_res_rw_vol_field_rw2_o <= 4'h0;
        else
            cfg_res_rw_vol_field_rw2_o <= cfg_res_rw_vol_field_rw2_i;
    always @(posedge clock) //@ csr.py:34
        if (reset)
            cfg_res_rw_vol_field_rw0_o <= 1'h0;
        else
            cfg_res_rw_vol_field_rw0_o <= cfg_res_rw_vol_field_rw0_i;
    always @(posedge clock) //@ demo_utils_csr.py:68
        if (reset)
            write_flag_reg_o <= 1'h0;
        else
            write_flag_reg_o <= write_flag_reg_i;
    always @(posedge clock) //@ demo_utils_csr.py:69
        write_data_reg_o <= write_data_reg_i;
    always @(posedge clock) //@ csr.py:34
        if (reset)
            cfg_res_write_action_field_rw3_o <= 8'h0;
        else
            cfg_res_write_action_field_rw3_o <= cfg_res_write_action_field_rw3_i;
    always @(posedge clock) //@ csr.py:34
        if (reset)
            cfg_res_write_action_field_rw2_o <= 4'h0;
        else
            cfg_res_write_action_field_rw2_o <= cfg_res_write_action_field_rw2_i;
    always @(posedge clock) //@ csr.py:34
        if (reset)
            cfg_res_write_action_field_rw1_o <= 3'h0;
        else
            cfg_res_write_action_field_rw1_o <= cfg_res_write_action_field_rw1_i;
    always @(posedge clock) //@ csr.py:34
        if (reset)
            cfg_res_write_action_field_rw0_o <= 1'h0;
        else
            cfg_res_write_action_field_rw0_o <= cfg_res_write_action_field_rw0_i;
    always @(posedge clock) //@ demo_utils_csr.py:94
        if (reset)
            read_data_o <= 8'h0;
        else
            read_data_o <= read_data_i;
    always @(posedge clock) //@ csr.py:34
        if (reset)
            cfg_res_read_action_field_rw3_o <= 8'h0;
        else
            cfg_res_read_action_field_rw3_o <= cfg_res_read_action_field_rw3_i;
    always @(posedge clock) //@ csr.py:34
        if (reset)
            cfg_res_read_action_field_rw2_o <= 4'h0;
        else
            cfg_res_read_action_field_rw2_o <= cfg_res_read_action_field_rw2_i;
    always @(posedge clock) //@ csr.py:34
        if (reset)
            cfg_res_read_action_field_rw1_o <= 3'h0;
        else
            cfg_res_read_action_field_rw1_o <= cfg_res_read_action_field_rw1_i;
    always @(posedge clock) //@ csr.py:34
        if (reset)
            cfg_res_read_action_field_rw0_o <= 1'h0;
        else
            cfg_res_read_action_field_rw0_o <= cfg_res_read_action_field_rw0_i;
    always @(posedge clock) //@ csr.py:286
        if (reset)
            _T_8_o <= 1'h0;
        else
            _T_8_o <= _T_8_i;
    always @(posedge clock) //@ csr.py:287
        _T_9_write_o <= _T_9_write_i;
    always @(posedge clock) //@ csr.py:287
        _T_9_addr_o <= _T_9_addr_i;
    always @(posedge clock) //@ csr.py:287
        _T_9_data_o <= _T_9_data_i;
    always @(posedge clock) //@ csr.py:287
        _T_9_be_o <= _T_9_be_i;
    assign _T_0 = (io_op == 4'h1); //@ demo_utils_csr.py:41
    assign _T_2 = (_T_0 ? io_in0 : cfg_res_rw_ro_field_ro1_o); //@ demo_utils_csr.py:42
    assign _T_4 = _T_2[2:0]; //@ demo_utils_csr.py:42
    assign _T_3 = _T_4; //@ demo_utils_csr.py:42
    assign _T_1 = _T_3; //@ demo_utils_csr.py:42
    assign cfg_res_rw_ro_field_ro1_i = _T_1; //@ demo_utils_csr.py:42
    assign _T_5 = (io_op == 4'h1); //@ demo_utils_csr.py:43
    assign _T_7 = (_T_5 ? io_in1 : cfg_res_rw_ro_field_ro3_o); //@ demo_utils_csr.py:44
    assign _T_6 = _T_7; //@ demo_utils_csr.py:44
    assign cfg_res_rw_ro_field_ro3_i = _T_6; //@ demo_utils_csr.py:44
    assign rw_reg_v_i = cfg_res_rw_ro_field_rw2_o; //@ demo_utils_csr.py:46
    assign cfg_res_rw_vol_field_vol3 = 8'h0; //@ csr.py:28
    assign cfg_res_rw_vol_field_vol1 = 3'h0; //@ csr.py:28
//    assign read_flag = 1'h0; //@ demo_utils_csr.py:93
    assign read_data_i = io_in1; //@ demo_utils_csr.py:94
    assign dumy_mapped_space_data = 32'h0; //@ csr.py:28
    assign _T_10 = (io_reg_req_ready & io_reg_req_valid); //@ csr.py:288
    assign _T_12 = (_T_8_o ? _T_9_write_o : io_reg_req_bits_write); //@ csr.py:289
    assign _T_11_write = _T_12; //@ csr.py:289
    assign _T_13 = (_T_8_o ? _T_9_addr_o : io_reg_req_bits_addr); //@ csr.py:289
    assign _T_11_addr = _T_13; //@ csr.py:289
    assign _T_14 = (_T_8_o ? _T_9_data_o : io_reg_req_bits_data); //@ csr.py:289
    assign _T_11_data = _T_14; //@ csr.py:289
    assign _T_15 = (_T_8_o ? _T_9_be_o : io_reg_req_bits_be); //@ csr.py:289
    assign _T_11_be = _T_15; //@ csr.py:289
    assign _T_16 = ~_T_11_write; //@ csr.py:247
    assign _T_17 = _T_11_be[0]; //@ csr.py:296
    assign _T_18 = _T_11_be[1]; //@ csr.py:296
    assign _T_19 = _T_11_be[2]; //@ csr.py:296
    assign _T_20 = _T_11_be[3]; //@ csr.py:296
    assign _T_21 = {4'h8{_T_17}}; //@ csr.py:295
    assign _T_22 = {4'h8{_T_18}}; //@ csr.py:295
    assign _T_23 = {4'h8{_T_19}}; //@ csr.py:295
    assign _T_24 = {4'h8{_T_20}}; //@ csr.py:295
    assign _T_25 = {_T_24, _T_23}; //@ csr.py:296
    assign _T_26 = {_T_25, _T_22}; //@ csr.py:296
    assign _T_27 = {_T_26, _T_21}; //@ csr.py:296
    queue reg_resp_buf( //@ csr.py:303
        .io_enq_ready(reg_resp_buf_io_enq_ready),
        .io_enq_valid(reg_resp_buf_io_enq_valid),
        .io_enq_bits_data(reg_resp_buf_io_enq_bits_data),
        .io_deq_ready(reg_resp_buf_io_deq_ready),
        .io_deq_valid(reg_resp_buf_io_deq_valid),
        .io_deq_bits_data(reg_resp_buf_io_deq_bits_data),
        .io_count(reg_resp_buf_io_count),
        .clock(reg_resp_buf_clock),
        .reset(reg_resp_buf_reset)
    );
    assign reg_resp_buf_clock = clock; //@ csr.py:303
    assign reg_resp_buf_reset = reset; //@ csr.py:303
//    assign reg_resp_buf_io_enq_valid = 1'h0; //@ csr.py:304
    assign _T_28 = (_T_11_addr >> 2'h2); //@ csr.py:232
    assign _T_31 = _T_28[9:0]; //@ csr.py:232
    assign _T_30 = _T_31; //@ csr.py:232
    assign _T_29 = _T_30; //@ csr.py:232
    assign _T_32 = (_T_29 << 2'h2); //@ csr.py:232
    assign _T_33 = 12'h0; //@ csr.py:232
    assign _T_34 = ~_T_33; //@ csr.py:232
    assign _T_35 = (_T_32 & _T_34); //@ csr.py:232
    assign _T_36 = (_T_35 == 12'h0); //@ csr.py:321
    assign _T_37 = (1'h0 | _T_36); //@ csr.py:322
    assign _T_38 = (_T_10 & _T_11_write); //@ csr.py:325
    assign _T_39 = (_T_38 & _T_36); //@ csr.py:325
    assign _T_40 = 1'h0; //@ csr.py:112
    assign _T_41 = (_T_40 == 1'h0); //@ csr.py:113
    assign _T_42 = (_T_40 == 1'h0); //@ csr.py:114
    assign _T_43 = (_T_11_data & _T_27); //@ csr.py:40
    assign _T_44 = ~_T_27; //@ csr.py:41
    assign _T_45 = (_T_11_data | _T_44); //@ csr.py:41
    assign _T_46 = ~_T_27; //@ csr.py:65
    assign _T_47 = (cfg_regs_rw_field_rw0_o & _T_46); //@ csr.py:65
    assign _T_48 = (_T_47 | _T_43); //@ csr.py:65
    assign _T_50 = (_T_39 ? _T_48 : cfg_regs_rw_field_rw0_o); //@ csr.py:65
    assign _T_52 = _T_50[0]; //@ csr.py:65
    assign _T_51 = _T_52; //@ csr.py:65
    assign _T_49 = _T_51; //@ csr.py:65
    assign cfg_regs_rw_field_rw0_i = _T_49; //@ csr.py:65
    assign _T_53 = (_T_27 >> 1'h1); //@ csr.py:132
    assign _T_56 = _T_53[30:0]; //@ csr.py:132
    assign _T_55 = _T_56; //@ csr.py:132
    assign _T_54 = _T_55; //@ csr.py:132
    assign _T_57 = (_T_11_data >> 1'h1); //@ csr.py:133
    assign _T_60 = _T_57[30:0]; //@ csr.py:133
    assign _T_59 = _T_60; //@ csr.py:133
    assign _T_58 = _T_59; //@ csr.py:133
    assign _T_61 = (_T_58 & _T_54); //@ csr.py:40
    assign _T_62 = ~_T_54; //@ csr.py:41
    assign _T_63 = (_T_58 | _T_62); //@ csr.py:41
    assign _T_64 = ~_T_54; //@ csr.py:65
    assign _T_65 = (cfg_regs_rw_field_rw1_o & _T_64); //@ csr.py:65
    assign _T_66 = (_T_65 | _T_61); //@ csr.py:65
    assign _T_68 = (_T_39 ? _T_66 : cfg_regs_rw_field_rw1_o); //@ csr.py:65
    assign _T_70 = _T_68[2:0]; //@ csr.py:65
    assign _T_69 = _T_70; //@ csr.py:65
    assign _T_67 = _T_69; //@ csr.py:65
    assign cfg_regs_rw_field_rw1_i = _T_67; //@ csr.py:65
    assign _T_71 = (_T_54 >> 2'h3); //@ csr.py:132
    assign _T_74 = _T_71[27:0]; //@ csr.py:132
    assign _T_73 = _T_74; //@ csr.py:132
    assign _T_72 = _T_73; //@ csr.py:132
    assign _T_75 = (_T_58 >> 2'h3); //@ csr.py:133
    assign _T_78 = _T_75[27:0]; //@ csr.py:133
    assign _T_77 = _T_78; //@ csr.py:133
    assign _T_76 = _T_77; //@ csr.py:133
    assign _T_79 = (_T_76 & _T_72); //@ csr.py:40
    assign _T_80 = ~_T_72; //@ csr.py:41
    assign _T_81 = (_T_76 | _T_80); //@ csr.py:41
    assign _T_82 = ~_T_72; //@ csr.py:65
    assign _T_83 = (cfg_regs_rw_field_rw2_o & _T_82); //@ csr.py:65
    assign _T_84 = (_T_83 | _T_79); //@ csr.py:65
    assign _T_86 = (_T_39 ? _T_84 : cfg_regs_rw_field_rw2_o); //@ csr.py:65
    assign _T_88 = _T_86[3:0]; //@ csr.py:65
    assign _T_87 = _T_88; //@ csr.py:65
    assign _T_85 = _T_87; //@ csr.py:65
    assign cfg_regs_rw_field_rw2_i = _T_85; //@ csr.py:65
    assign _T_89 = (_T_72 >> 3'h4); //@ csr.py:132
    assign _T_92 = _T_89[23:0]; //@ csr.py:132
    assign _T_91 = _T_92; //@ csr.py:132
    assign _T_90 = _T_91; //@ csr.py:132
    assign _T_93 = (_T_76 >> 3'h4); //@ csr.py:133
    assign _T_96 = _T_93[23:0]; //@ csr.py:133
    assign _T_95 = _T_96; //@ csr.py:133
    assign _T_94 = _T_95; //@ csr.py:133
    assign _T_97 = (_T_94 & _T_90); //@ csr.py:40
    assign _T_98 = ~_T_90; //@ csr.py:41
    assign _T_99 = (_T_94 | _T_98); //@ csr.py:41
    assign _T_100 = ~_T_90; //@ csr.py:65
    assign _T_101 = (cfg_regs_rw_field_rw3_o & _T_100); //@ csr.py:65
    assign _T_102 = (_T_101 | _T_97); //@ csr.py:65
    assign _T_104 = (_T_39 ? _T_102 : cfg_regs_rw_field_rw3_o); //@ csr.py:65
    assign _T_106 = _T_104[7:0]; //@ csr.py:65
    assign _T_105 = _T_106; //@ csr.py:65
    assign _T_103 = _T_105; //@ csr.py:65
    assign cfg_regs_rw_field_rw3_i = _T_103; //@ csr.py:65
    assign _T_107 = (_T_90 >> 4'h8); //@ csr.py:132
    assign _T_110 = _T_107[15:0]; //@ csr.py:132
    assign _T_109 = _T_110; //@ csr.py:132
    assign _T_108 = _T_109; //@ csr.py:132
    assign _T_111 = (_T_94 >> 4'h8); //@ csr.py:133
    assign _T_114 = _T_111[15:0]; //@ csr.py:133
    assign _T_113 = _T_114; //@ csr.py:133
    assign _T_112 = _T_113; //@ csr.py:133
    assign _T_115 = (_T_10 & _T_16); //@ csr.py:331
    assign _T_116 = (_T_115 & _T_36); //@ csr.py:331
    assign _T_117 = 1'h0; //@ csr.py:142
    assign _T_118 = (_T_117 == 1'h0); //@ csr.py:143
    assign _T_119 = cfg_regs_rw_field_rw0_o; //@ csr.py:160
    assign _T_120 = (_T_27 >> 1'h1); //@ csr.py:162
    assign _T_123 = _T_120[30:0]; //@ csr.py:162
    assign _T_122 = _T_123; //@ csr.py:162
    assign _T_121 = _T_122; //@ csr.py:162
    assign _T_124 = cfg_regs_rw_field_rw1_o; //@ csr.py:160
    assign _T_125 = (_T_121 >> 2'h3); //@ csr.py:162
    assign _T_128 = _T_125[27:0]; //@ csr.py:162
    assign _T_127 = _T_128; //@ csr.py:162
    assign _T_126 = _T_127; //@ csr.py:162
    assign _T_129 = cfg_regs_rw_field_rw2_o; //@ csr.py:160
    assign _T_130 = (_T_126 >> 3'h4); //@ csr.py:162
    assign _T_133 = _T_130[23:0]; //@ csr.py:162
    assign _T_132 = _T_133; //@ csr.py:162
    assign _T_131 = _T_132; //@ csr.py:162
    assign _T_134 = cfg_regs_rw_field_rw3_o; //@ csr.py:160
    assign _T_135 = (_T_131 >> 4'h8); //@ csr.py:162
    assign _T_138 = _T_135[15:0]; //@ csr.py:162
    assign _T_137 = _T_138; //@ csr.py:162
    assign _T_136 = _T_137; //@ csr.py:162
    assign _T_139 = {_T_134, _T_129}; //@ csr.py:169
    assign _T_140 = {_T_139, _T_124}; //@ csr.py:169
    assign _T_141 = {_T_140, _T_119}; //@ csr.py:169
    assign _T_142 = {16'h0, _T_141}; //@ csr.py:169
    assign _T_143 = {1'h1{_T_142}}; //@ csr.py:174
    assign _T_144 = (_T_11_write ? 1'h1 : 1'h1); //@ csr.py:336
    assign _T_145 = (_T_144 & _T_36); //@ csr.py:337
    assign _T_146 = (1'h0 | _T_145); //@ csr.py:337
    assign _T_147 = (_T_11_write ? 1'h1 : 1'h1); //@ csr.py:339
    assign _T_148 = (_T_147 & _T_36); //@ csr.py:340
    assign _T_149 = (1'h0 | _T_148); //@ csr.py:340
    assign _T_150 = {6'h20{_T_36}}; //@ csr.py:342
    assign _T_151 = (_T_150 & _T_143); //@ csr.py:343
    assign _T_152 = (32'h0 | _T_151); //@ csr.py:343
    assign _T_153 = (_T_11_addr >> 2'h2); //@ csr.py:232
    assign _T_156 = _T_153[9:0]; //@ csr.py:232
    assign _T_155 = _T_156; //@ csr.py:232
    assign _T_154 = _T_155; //@ csr.py:232
    assign _T_157 = (_T_154 << 2'h2); //@ csr.py:232
    assign _T_158 = 12'h0; //@ csr.py:232
    assign _T_159 = ~_T_158; //@ csr.py:232
    assign _T_160 = (_T_157 & _T_159); //@ csr.py:232
    assign _T_161 = (_T_160 == 12'h4); //@ csr.py:321
    assign _T_162 = (_T_37 | _T_161); //@ csr.py:322
    assign _T_163 = (_T_10 & _T_11_write); //@ csr.py:325
    assign _T_164 = (_T_163 & _T_161); //@ csr.py:325
    assign _T_165 = 1'h0; //@ csr.py:112
    assign _T_166 = (_T_165 == 1'h0); //@ csr.py:113
    assign _T_167 = (_T_165 == 1'h0); //@ csr.py:114
    assign _T_168 = (_T_11_data & _T_27); //@ csr.py:40
    assign _T_169 = ~_T_27; //@ csr.py:41
    assign _T_170 = (_T_11_data | _T_169); //@ csr.py:41
    assign _T_171 = ~_T_27; //@ csr.py:65
    assign _T_172 = (cfg_res_rw_ro_field_rw0_o & _T_171); //@ csr.py:65
    assign _T_173 = (_T_172 | _T_168); //@ csr.py:65
    assign _T_175 = (_T_164 ? _T_173 : cfg_res_rw_ro_field_rw0_o); //@ csr.py:65
    assign _T_177 = _T_175[0]; //@ csr.py:65
    assign _T_176 = _T_177; //@ csr.py:65
    assign _T_174 = _T_176; //@ csr.py:65
    assign cfg_res_rw_ro_field_rw0_i = _T_174; //@ csr.py:65
    assign _T_178 = (_T_27 >> 1'h1); //@ csr.py:132
    assign _T_181 = _T_178[30:0]; //@ csr.py:132
    assign _T_180 = _T_181; //@ csr.py:132
    assign _T_179 = _T_180; //@ csr.py:132
    assign _T_182 = (_T_11_data >> 1'h1); //@ csr.py:133
    assign _T_185 = _T_182[30:0]; //@ csr.py:133
    assign _T_184 = _T_185; //@ csr.py:133
    assign _T_183 = _T_184; //@ csr.py:133
    assign _T_186 = (_T_183 & _T_179); //@ csr.py:40
    assign _T_187 = ~_T_179; //@ csr.py:41
    assign _T_188 = (_T_183 | _T_187); //@ csr.py:41
    assign _T_189 = (_T_179 >> 2'h3); //@ csr.py:132
    assign _T_192 = _T_189[27:0]; //@ csr.py:132
    assign _T_191 = _T_192; //@ csr.py:132
    assign _T_190 = _T_191; //@ csr.py:132
    assign _T_193 = (_T_183 >> 2'h3); //@ csr.py:133
    assign _T_196 = _T_193[27:0]; //@ csr.py:133
    assign _T_195 = _T_196; //@ csr.py:133
    assign _T_194 = _T_195; //@ csr.py:133
    assign _T_197 = (_T_194 & _T_190); //@ csr.py:40
    assign _T_198 = ~_T_190; //@ csr.py:41
    assign _T_199 = (_T_194 | _T_198); //@ csr.py:41
    assign _T_200 = ~_T_190; //@ csr.py:65
    assign _T_201 = (cfg_res_rw_ro_field_rw2_o & _T_200); //@ csr.py:65
    assign _T_202 = (_T_201 | _T_197); //@ csr.py:65
    assign _T_204 = (_T_164 ? _T_202 : cfg_res_rw_ro_field_rw2_o); //@ csr.py:65
    assign _T_206 = _T_204[3:0]; //@ csr.py:65
    assign _T_205 = _T_206; //@ csr.py:65
    assign _T_203 = _T_205; //@ csr.py:65
    assign cfg_res_rw_ro_field_rw2_i = _T_203; //@ csr.py:65
    assign _T_207 = (_T_190 >> 3'h4); //@ csr.py:132
    assign _T_210 = _T_207[23:0]; //@ csr.py:132
    assign _T_209 = _T_210; //@ csr.py:132
    assign _T_208 = _T_209; //@ csr.py:132
    assign _T_211 = (_T_194 >> 3'h4); //@ csr.py:133
    assign _T_214 = _T_211[23:0]; //@ csr.py:133
    assign _T_213 = _T_214; //@ csr.py:133
    assign _T_212 = _T_213; //@ csr.py:133
    assign _T_215 = (_T_212 & _T_208); //@ csr.py:40
    assign _T_216 = ~_T_208; //@ csr.py:41
    assign _T_217 = (_T_212 | _T_216); //@ csr.py:41
    assign _T_218 = (_T_208 >> 4'h8); //@ csr.py:132
    assign _T_221 = _T_218[15:0]; //@ csr.py:132
    assign _T_220 = _T_221; //@ csr.py:132
    assign _T_219 = _T_220; //@ csr.py:132
    assign _T_222 = (_T_212 >> 4'h8); //@ csr.py:133
    assign _T_225 = _T_222[15:0]; //@ csr.py:133
    assign _T_224 = _T_225; //@ csr.py:133
    assign _T_223 = _T_224; //@ csr.py:133
    assign _T_226 = (_T_10 & _T_16); //@ csr.py:331
    assign _T_227 = (_T_226 & _T_161); //@ csr.py:331
    assign _T_228 = 1'h0; //@ csr.py:142
    assign _T_229 = (_T_228 == 1'h0); //@ csr.py:143
    assign _T_230 = cfg_res_rw_ro_field_rw0_o; //@ csr.py:160
    assign _T_231 = (_T_27 >> 1'h1); //@ csr.py:162
    assign _T_234 = _T_231[30:0]; //@ csr.py:162
    assign _T_233 = _T_234; //@ csr.py:162
    assign _T_232 = _T_233; //@ csr.py:162
    assign _T_235 = cfg_res_rw_ro_field_ro1_o; //@ csr.py:160
    assign _T_236 = (_T_232 >> 2'h3); //@ csr.py:162
    assign _T_239 = _T_236[27:0]; //@ csr.py:162
    assign _T_238 = _T_239; //@ csr.py:162
    assign _T_237 = _T_238; //@ csr.py:162
    assign _T_240 = cfg_res_rw_ro_field_rw2_o; //@ csr.py:160
    assign _T_241 = (_T_237 >> 3'h4); //@ csr.py:162
    assign _T_244 = _T_241[23:0]; //@ csr.py:162
    assign _T_243 = _T_244; //@ csr.py:162
    assign _T_242 = _T_243; //@ csr.py:162
    assign _T_245 = cfg_res_rw_ro_field_ro3_o; //@ csr.py:160
    assign _T_246 = (_T_242 >> 4'h8); //@ csr.py:162
    assign _T_249 = _T_246[15:0]; //@ csr.py:162
    assign _T_248 = _T_249; //@ csr.py:162
    assign _T_247 = _T_248; //@ csr.py:162
    assign _T_250 = {_T_245, _T_240}; //@ csr.py:169
    assign _T_251 = {_T_250, _T_235}; //@ csr.py:169
    assign _T_252 = {_T_251, _T_230}; //@ csr.py:169
    assign _T_253 = {16'h0, _T_252}; //@ csr.py:169
    assign _T_254 = {1'h1{_T_253}}; //@ csr.py:174
    assign _T_255 = (_T_11_write ? 1'h1 : 1'h1); //@ csr.py:336
    assign _T_256 = (_T_255 & _T_161); //@ csr.py:337
    assign _T_257 = (_T_146 | _T_256); //@ csr.py:337
    assign _T_258 = (_T_11_write ? 1'h1 : 1'h1); //@ csr.py:339
    assign _T_259 = (_T_258 & _T_161); //@ csr.py:340
    assign _T_260 = (_T_149 | _T_259); //@ csr.py:340
    assign _T_261 = {6'h20{_T_161}}; //@ csr.py:342
    assign _T_262 = (_T_261 & _T_254); //@ csr.py:343
    assign _T_263 = (_T_152 | _T_262); //@ csr.py:343
    assign _T_264 = (_T_11_addr >> 2'h2); //@ csr.py:232
    assign _T_267 = _T_264[9:0]; //@ csr.py:232
    assign _T_266 = _T_267; //@ csr.py:232
    assign _T_265 = _T_266; //@ csr.py:232
    assign _T_268 = (_T_265 << 2'h2); //@ csr.py:232
    assign _T_269 = 12'h0; //@ csr.py:232
    assign _T_270 = ~_T_269; //@ csr.py:232
    assign _T_271 = (_T_268 & _T_270); //@ csr.py:232
    assign _T_272 = (_T_271 == 12'h8); //@ csr.py:321
    assign _T_273 = (_T_162 | _T_272); //@ csr.py:322
    assign _T_274 = (_T_10 & _T_11_write); //@ csr.py:325
    assign _T_275 = (_T_274 & _T_272); //@ csr.py:325
    assign _T_276 = 1'h0; //@ csr.py:112
    assign _T_277 = (_T_276 == 1'h0); //@ csr.py:113
    assign _T_278 = (_T_276 == 1'h0); //@ csr.py:114
    assign _T_279 = (_T_11_data & _T_27); //@ csr.py:40
    assign _T_280 = ~_T_27; //@ csr.py:41
    assign _T_281 = (_T_11_data | _T_280); //@ csr.py:41
    assign _T_282 = (cfg_res_zc_oc_zs_os_field_zc0_o & _T_281); //@ csr.py:55
    assign _T_284 = (_T_275 ? _T_282 : cfg_res_zc_oc_zs_os_field_zc0_o); //@ csr.py:55
    assign _T_286 = _T_284[0]; //@ csr.py:55
    assign _T_285 = _T_286; //@ csr.py:55
    assign _T_283 = _T_285; //@ csr.py:55
    assign cfg_res_zc_oc_zs_os_field_zc0_i = _T_283; //@ csr.py:55
    assign _T_287 = (_T_27 >> 1'h1); //@ csr.py:132
    assign _T_290 = _T_287[30:0]; //@ csr.py:132
    assign _T_289 = _T_290; //@ csr.py:132
    assign _T_288 = _T_289; //@ csr.py:132
    assign _T_291 = (_T_11_data >> 1'h1); //@ csr.py:133
    assign _T_294 = _T_291[30:0]; //@ csr.py:133
    assign _T_293 = _T_294; //@ csr.py:133
    assign _T_292 = _T_293; //@ csr.py:133
    assign _T_295 = (_T_292 & _T_288); //@ csr.py:40
    assign _T_296 = ~_T_288; //@ csr.py:41
    assign _T_297 = (_T_292 | _T_296); //@ csr.py:41
    assign _T_298 = ~_T_295; //@ csr.py:49
    assign _T_299 = (cfg_res_zc_oc_zs_os_field_oc1_o & _T_298); //@ csr.py:49
    assign _T_301 = (_T_275 ? _T_299 : cfg_res_zc_oc_zs_os_field_oc1_o); //@ csr.py:49
    assign _T_303 = _T_301[2:0]; //@ csr.py:49
    assign _T_302 = _T_303; //@ csr.py:49
    assign _T_300 = _T_302; //@ csr.py:49
    assign cfg_res_zc_oc_zs_os_field_oc1_i = _T_300; //@ csr.py:49
    assign _T_304 = (_T_288 >> 2'h3); //@ csr.py:132
    assign _T_307 = _T_304[27:0]; //@ csr.py:132
    assign _T_306 = _T_307; //@ csr.py:132
    assign _T_305 = _T_306; //@ csr.py:132
    assign _T_308 = (_T_292 >> 2'h3); //@ csr.py:133
    assign _T_311 = _T_308[27:0]; //@ csr.py:133
    assign _T_310 = _T_311; //@ csr.py:133
    assign _T_309 = _T_310; //@ csr.py:133
    assign _T_312 = (_T_309 & _T_305); //@ csr.py:40
    assign _T_313 = ~_T_305; //@ csr.py:41
    assign _T_314 = (_T_309 | _T_313); //@ csr.py:41
    assign _T_315 = ~_T_314; //@ csr.py:57
    assign _T_316 = (cfg_res_zc_oc_zs_os_field_zs2_o | _T_315); //@ csr.py:57
    assign _T_318 = (_T_275 ? _T_316 : cfg_res_zc_oc_zs_os_field_zs2_o); //@ csr.py:57
    assign _T_320 = _T_318[3:0]; //@ csr.py:57
    assign _T_319 = _T_320; //@ csr.py:57
    assign _T_317 = _T_319; //@ csr.py:57
    assign cfg_res_zc_oc_zs_os_field_zs2_i = _T_317; //@ csr.py:57
    assign _T_321 = (_T_305 >> 3'h4); //@ csr.py:132
    assign _T_324 = _T_321[23:0]; //@ csr.py:132
    assign _T_323 = _T_324; //@ csr.py:132
    assign _T_322 = _T_323; //@ csr.py:132
    assign _T_325 = (_T_309 >> 3'h4); //@ csr.py:133
    assign _T_328 = _T_325[23:0]; //@ csr.py:133
    assign _T_327 = _T_328; //@ csr.py:133
    assign _T_326 = _T_327; //@ csr.py:133
    assign _T_329 = (_T_326 & _T_322); //@ csr.py:40
    assign _T_330 = ~_T_322; //@ csr.py:41
    assign _T_331 = (_T_326 | _T_330); //@ csr.py:41
    assign _T_332 = (cfg_res_zc_oc_zs_os_field_os3_o | _T_329); //@ csr.py:51
    assign _T_334 = (_T_275 ? _T_332 : cfg_res_zc_oc_zs_os_field_os3_o); //@ csr.py:51
    assign _T_336 = _T_334[7:0]; //@ csr.py:51
    assign _T_335 = _T_336; //@ csr.py:51
    assign _T_333 = _T_335; //@ csr.py:51
    assign cfg_res_zc_oc_zs_os_field_os3_i = _T_333; //@ csr.py:51
    assign _T_337 = (_T_322 >> 4'h8); //@ csr.py:132
    assign _T_340 = _T_337[15:0]; //@ csr.py:132
    assign _T_339 = _T_340; //@ csr.py:132
    assign _T_338 = _T_339; //@ csr.py:132
    assign _T_341 = (_T_326 >> 4'h8); //@ csr.py:133
    assign _T_344 = _T_341[15:0]; //@ csr.py:133
    assign _T_343 = _T_344; //@ csr.py:133
    assign _T_342 = _T_343; //@ csr.py:133
    assign _T_345 = (_T_10 & _T_16); //@ csr.py:331
    assign _T_346 = (_T_345 & _T_272); //@ csr.py:331
    assign _T_347 = 1'h0; //@ csr.py:142
    assign _T_348 = (_T_347 == 1'h0); //@ csr.py:143
    assign _T_349 = cfg_res_zc_oc_zs_os_field_zc0_o; //@ csr.py:160
    assign _T_350 = (_T_27 >> 1'h1); //@ csr.py:162
    assign _T_353 = _T_350[30:0]; //@ csr.py:162
    assign _T_352 = _T_353; //@ csr.py:162
    assign _T_351 = _T_352; //@ csr.py:162
    assign _T_354 = cfg_res_zc_oc_zs_os_field_oc1_o; //@ csr.py:160
    assign _T_355 = (_T_351 >> 2'h3); //@ csr.py:162
    assign _T_358 = _T_355[27:0]; //@ csr.py:162
    assign _T_357 = _T_358; //@ csr.py:162
    assign _T_356 = _T_357; //@ csr.py:162
    assign _T_359 = cfg_res_zc_oc_zs_os_field_zs2_o; //@ csr.py:160
    assign _T_360 = (_T_356 >> 3'h4); //@ csr.py:162
    assign _T_363 = _T_360[23:0]; //@ csr.py:162
    assign _T_362 = _T_363; //@ csr.py:162
    assign _T_361 = _T_362; //@ csr.py:162
    assign _T_364 = cfg_res_zc_oc_zs_os_field_os3_o; //@ csr.py:160
    assign _T_365 = (_T_361 >> 4'h8); //@ csr.py:162
    assign _T_368 = _T_365[15:0]; //@ csr.py:162
    assign _T_367 = _T_368; //@ csr.py:162
    assign _T_366 = _T_367; //@ csr.py:162
    assign _T_369 = {_T_364, _T_359}; //@ csr.py:169
    assign _T_370 = {_T_369, _T_354}; //@ csr.py:169
    assign _T_371 = {_T_370, _T_349}; //@ csr.py:169
    assign _T_372 = {16'h0, _T_371}; //@ csr.py:169
    assign _T_373 = {1'h1{_T_372}}; //@ csr.py:174
    assign _T_374 = (_T_11_write ? 1'h1 : 1'h1); //@ csr.py:336
    assign _T_375 = (_T_374 & _T_272); //@ csr.py:337
    assign _T_376 = (_T_257 | _T_375); //@ csr.py:337
    assign _T_377 = (_T_11_write ? 1'h1 : 1'h1); //@ csr.py:339
    assign _T_378 = (_T_377 & _T_272); //@ csr.py:340
    assign _T_379 = (_T_260 | _T_378); //@ csr.py:340
    assign _T_380 = {6'h20{_T_272}}; //@ csr.py:342
    assign _T_381 = (_T_380 & _T_373); //@ csr.py:343
    assign _T_382 = (_T_263 | _T_381); //@ csr.py:343
    assign _T_383 = (_T_11_addr >> 2'h2); //@ csr.py:232
    assign _T_386 = _T_383[9:0]; //@ csr.py:232
    assign _T_385 = _T_386; //@ csr.py:232
    assign _T_384 = _T_385; //@ csr.py:232
    assign _T_387 = (_T_384 << 2'h2); //@ csr.py:232
    assign _T_388 = 12'h0; //@ csr.py:232
    assign _T_389 = ~_T_388; //@ csr.py:232
    assign _T_390 = (_T_387 & _T_389); //@ csr.py:232
    assign _T_391 = (_T_390 == 12'hc); //@ csr.py:321
    assign _T_392 = (_T_273 | _T_391); //@ csr.py:322
    assign _T_393 = (_T_10 & _T_11_write); //@ csr.py:325
    assign _T_394 = (_T_393 & _T_391); //@ csr.py:325
    assign _T_395 = 1'h0; //@ csr.py:112
    assign _T_396 = (_T_395 == 1'h0); //@ csr.py:113
    assign _T_397 = (_T_395 == 1'h0); //@ csr.py:114
    assign _T_398 = (_T_11_data & _T_27); //@ csr.py:40
    assign _T_399 = ~_T_27; //@ csr.py:41
    assign _T_400 = (_T_11_data | _T_399); //@ csr.py:41
    assign _T_401 = ~_T_27; //@ csr.py:65
    assign _T_402 = (cfg_res_rw_vol_field_rw0_o & _T_401); //@ csr.py:65
    assign _T_403 = (_T_402 | _T_398); //@ csr.py:65
    assign _T_405 = (_T_394 ? _T_403 : cfg_res_rw_vol_field_rw0_o); //@ csr.py:65
    assign _T_407 = _T_405[0]; //@ csr.py:65
    assign _T_406 = _T_407; //@ csr.py:65
    assign _T_404 = _T_406; //@ csr.py:65
    assign cfg_res_rw_vol_field_rw0_i = _T_404; //@ csr.py:65
    assign _T_408 = (_T_27 >> 1'h1); //@ csr.py:132
    assign _T_411 = _T_408[30:0]; //@ csr.py:132
    assign _T_410 = _T_411; //@ csr.py:132
    assign _T_409 = _T_410; //@ csr.py:132
    assign _T_412 = (_T_11_data >> 1'h1); //@ csr.py:133
    assign _T_415 = _T_412[30:0]; //@ csr.py:133
    assign _T_414 = _T_415; //@ csr.py:133
    assign _T_413 = _T_414; //@ csr.py:133
    assign _T_416 = (_T_413 & _T_409); //@ csr.py:40
    assign _T_417 = ~_T_409; //@ csr.py:41
    assign _T_418 = (_T_413 | _T_417); //@ csr.py:41
    assign _T_419 = (_T_409 >> 2'h3); //@ csr.py:132
    assign _T_422 = _T_419[27:0]; //@ csr.py:132
    assign _T_421 = _T_422; //@ csr.py:132
    assign _T_420 = _T_421; //@ csr.py:132
    assign _T_423 = (_T_413 >> 2'h3); //@ csr.py:133
    assign _T_426 = _T_423[27:0]; //@ csr.py:133
    assign _T_425 = _T_426; //@ csr.py:133
    assign _T_424 = _T_425; //@ csr.py:133
    assign _T_427 = (_T_424 & _T_420); //@ csr.py:40
    assign _T_428 = ~_T_420; //@ csr.py:41
    assign _T_429 = (_T_424 | _T_428); //@ csr.py:41
    assign _T_430 = ~_T_420; //@ csr.py:65
    assign _T_431 = (cfg_res_rw_vol_field_rw2_o & _T_430); //@ csr.py:65
    assign _T_432 = (_T_431 | _T_427); //@ csr.py:65
    assign _T_434 = (_T_394 ? _T_432 : cfg_res_rw_vol_field_rw2_o); //@ csr.py:65
    assign _T_436 = _T_434[3:0]; //@ csr.py:65
    assign _T_435 = _T_436; //@ csr.py:65
    assign _T_433 = _T_435; //@ csr.py:65
    assign cfg_res_rw_vol_field_rw2_i = _T_433; //@ csr.py:65
    assign _T_437 = (_T_420 >> 3'h4); //@ csr.py:132
    assign _T_440 = _T_437[23:0]; //@ csr.py:132
    assign _T_439 = _T_440; //@ csr.py:132
    assign _T_438 = _T_439; //@ csr.py:132
    assign _T_441 = (_T_424 >> 3'h4); //@ csr.py:133
    assign _T_444 = _T_441[23:0]; //@ csr.py:133
    assign _T_443 = _T_444; //@ csr.py:133
    assign _T_442 = _T_443; //@ csr.py:133
    assign _T_445 = (_T_442 & _T_438); //@ csr.py:40
    assign _T_446 = ~_T_438; //@ csr.py:41
    assign _T_447 = (_T_442 | _T_446); //@ csr.py:41
    assign _T_448 = (_T_438 >> 4'h8); //@ csr.py:132
    assign _T_451 = _T_448[15:0]; //@ csr.py:132
    assign _T_450 = _T_451; //@ csr.py:132
    assign _T_449 = _T_450; //@ csr.py:132
    assign _T_452 = (_T_442 >> 4'h8); //@ csr.py:133
    assign _T_455 = _T_452[15:0]; //@ csr.py:133
    assign _T_454 = _T_455; //@ csr.py:133
    assign _T_453 = _T_454; //@ csr.py:133
    assign _T_456 = (_T_10 & _T_16); //@ csr.py:331
    assign _T_457 = (_T_456 & _T_391); //@ csr.py:331
    assign _T_458 = 1'h0; //@ csr.py:142
    assign _T_459 = (_T_458 == 1'h0); //@ csr.py:143
    assign _T_460 = cfg_res_rw_vol_field_rw0_o; //@ csr.py:160
    assign _T_461 = (_T_27 >> 1'h1); //@ csr.py:162
    assign _T_464 = _T_461[30:0]; //@ csr.py:162
    assign _T_463 = _T_464; //@ csr.py:162
    assign _T_462 = _T_463; //@ csr.py:162
    assign _T_465 = cfg_res_rw_vol_field_vol1; //@ csr.py:160
    assign _T_466 = (_T_462 >> 2'h3); //@ csr.py:162
    assign _T_469 = _T_466[27:0]; //@ csr.py:162
    assign _T_468 = _T_469; //@ csr.py:162
    assign _T_467 = _T_468; //@ csr.py:162
    assign _T_470 = cfg_res_rw_vol_field_rw2_o; //@ csr.py:160
    assign _T_471 = (_T_467 >> 3'h4); //@ csr.py:162
    assign _T_474 = _T_471[23:0]; //@ csr.py:162
    assign _T_473 = _T_474; //@ csr.py:162
    assign _T_472 = _T_473; //@ csr.py:162
    assign _T_475 = cfg_res_rw_vol_field_vol3; //@ csr.py:160
    assign _T_476 = (_T_472 >> 4'h8); //@ csr.py:162
    assign _T_479 = _T_476[15:0]; //@ csr.py:162
    assign _T_478 = _T_479; //@ csr.py:162
    assign _T_477 = _T_478; //@ csr.py:162
    assign _T_480 = {_T_475, _T_470}; //@ csr.py:169
    assign _T_481 = {_T_480, _T_465}; //@ csr.py:169
    assign _T_482 = {_T_481, _T_460}; //@ csr.py:169
    assign _T_483 = {16'h0, _T_482}; //@ csr.py:169
    assign _T_484 = {1'h1{_T_483}}; //@ csr.py:174
    assign _T_485 = (_T_11_write ? 1'h1 : 1'h1); //@ csr.py:336
    assign _T_486 = (_T_485 & _T_391); //@ csr.py:337
    assign _T_487 = (_T_376 | _T_486); //@ csr.py:337
    assign _T_488 = (_T_11_write ? 1'h1 : 1'h1); //@ csr.py:339
    assign _T_489 = (_T_488 & _T_391); //@ csr.py:340
    assign _T_490 = (_T_379 | _T_489); //@ csr.py:340
    assign _T_491 = {6'h20{_T_391}}; //@ csr.py:342
    assign _T_492 = (_T_491 & _T_484); //@ csr.py:343
    assign _T_493 = (_T_382 | _T_492); //@ csr.py:343
    assign _T_494 = (_T_11_addr >> 2'h2); //@ csr.py:232
    assign _T_497 = _T_494[9:0]; //@ csr.py:232
    assign _T_496 = _T_497; //@ csr.py:232
    assign _T_495 = _T_496; //@ csr.py:232
    assign _T_498 = (_T_495 << 2'h2); //@ csr.py:232
    assign _T_499 = 12'h0; //@ csr.py:232
    assign _T_500 = ~_T_499; //@ csr.py:232
    assign _T_501 = (_T_498 & _T_500); //@ csr.py:232
    assign _T_502 = (_T_501 == 12'h10); //@ csr.py:321
    assign _T_503 = (_T_392 | _T_502); //@ csr.py:322
    assign _T_504 = (_T_10 & _T_11_write); //@ csr.py:325
    assign _T_505 = (_T_504 & _T_502); //@ csr.py:325
    assign _T_506 = 1'h0; //@ csr.py:112
    assign _T_507 = (_T_506 == 1'h0); //@ csr.py:113
    assign _T_508 = (_T_506 == 1'h0); //@ csr.py:114
    assign _T_509 = (_T_11_data & _T_27); //@ csr.py:40
    assign _T_510 = ~_T_27; //@ csr.py:41
    assign _T_511 = (_T_11_data | _T_510); //@ csr.py:41
    assign _T_512 = ~_T_27; //@ csr.py:65
    assign _T_513 = (cfg_res_write_action_field_rw0_o & _T_512); //@ csr.py:65
    assign _T_514 = (_T_513 | _T_509); //@ csr.py:65
    assign _T_516 = (_T_505 ? _T_514 : cfg_res_write_action_field_rw0_o); //@ csr.py:65
    assign _T_518 = _T_516[0]; //@ csr.py:65
    assign _T_517 = _T_518; //@ csr.py:65
    assign _T_515 = _T_517; //@ csr.py:65
    assign cfg_res_write_action_field_rw0_i = _T_515; //@ csr.py:65
    assign _T_519 = (_T_27 >> 1'h1); //@ csr.py:132
    assign _T_522 = _T_519[30:0]; //@ csr.py:132
    assign _T_521 = _T_522; //@ csr.py:132
    assign _T_520 = _T_521; //@ csr.py:132
    assign _T_523 = (_T_11_data >> 1'h1); //@ csr.py:133
    assign _T_526 = _T_523[30:0]; //@ csr.py:133
    assign _T_525 = _T_526; //@ csr.py:133
    assign _T_524 = _T_525; //@ csr.py:133
    assign _T_527 = (_T_524 & _T_520); //@ csr.py:40
    assign _T_528 = ~_T_520; //@ csr.py:41
    assign _T_529 = (_T_524 | _T_528); //@ csr.py:41
    assign _T_530 = ~_T_520; //@ csr.py:65
    assign _T_531 = (cfg_res_write_action_field_rw1_o & _T_530); //@ csr.py:65
    assign _T_532 = (_T_531 | _T_527); //@ csr.py:65
    assign _T_534 = (_T_505 ? _T_532 : cfg_res_write_action_field_rw1_o); //@ csr.py:65
    assign _T_536 = _T_534[2:0]; //@ csr.py:65
    assign _T_535 = _T_536; //@ csr.py:65
    assign _T_533 = _T_535; //@ csr.py:65
    assign cfg_res_write_action_field_rw1_i = _T_533; //@ csr.py:65
    assign _T_537 = (_T_520 >> 2'h3); //@ csr.py:132
    assign _T_540 = _T_537[27:0]; //@ csr.py:132
    assign _T_539 = _T_540; //@ csr.py:132
    assign _T_538 = _T_539; //@ csr.py:132
    assign _T_541 = (_T_524 >> 2'h3); //@ csr.py:133
    assign _T_544 = _T_541[27:0]; //@ csr.py:133
    assign _T_543 = _T_544; //@ csr.py:133
    assign _T_542 = _T_543; //@ csr.py:133
    assign _T_545 = (_T_542 & _T_538); //@ csr.py:40
    assign _T_546 = ~_T_538; //@ csr.py:41
    assign _T_547 = (_T_542 | _T_546); //@ csr.py:41
    assign _T_548 = ~_T_538; //@ csr.py:65
    assign _T_549 = (cfg_res_write_action_field_rw2_o & _T_548); //@ csr.py:65
    assign _T_550 = (_T_549 | _T_545); //@ csr.py:65
    assign _T_552 = (_T_505 ? _T_550 : cfg_res_write_action_field_rw2_o); //@ csr.py:65
    assign _T_554 = _T_552[3:0]; //@ csr.py:65
    assign _T_553 = _T_554; //@ csr.py:65
    assign _T_551 = _T_553; //@ csr.py:65
    assign cfg_res_write_action_field_rw2_i = _T_551; //@ csr.py:65
    assign _T_555 = (_T_538 >> 3'h4); //@ csr.py:132
    assign _T_558 = _T_555[23:0]; //@ csr.py:132
    assign _T_557 = _T_558; //@ csr.py:132
    assign _T_556 = _T_557; //@ csr.py:132
    assign _T_559 = (_T_542 >> 3'h4); //@ csr.py:133
    assign _T_562 = _T_559[23:0]; //@ csr.py:133
    assign _T_561 = _T_562; //@ csr.py:133
    assign _T_560 = _T_561; //@ csr.py:133
    assign _T_564 = (_T_505 ? 1'h1 : write_flag_reg_o); //@ demo_utils_csr.py:74
    assign _T_563 = _T_564; //@ demo_utils_csr.py:74
    assign write_flag_reg_i = _T_563; //@ demo_utils_csr.py:74
    assign _T_565 = _T_560[7:0]; //@ demo_utils_csr.py:78
    assign _T_567 = (_T_505 ? _T_565 : write_data_reg_o); //@ demo_utils_csr.py:78
    assign _T_566 = _T_567; //@ demo_utils_csr.py:78
    assign write_data_reg_i = _T_566; //@ demo_utils_csr.py:78
    assign _T_568 = _T_560[7:0]; //@ demo_utils_csr.py:81
    assign _T_570 = (_T_505 ? _T_568 : cfg_res_write_action_field_rw3_o); //@ demo_utils_csr.py:81
    assign _T_569 = _T_570; //@ demo_utils_csr.py:81
    assign cfg_res_write_action_field_rw3_i = _T_569; //@ demo_utils_csr.py:81
    assign _T_571 = (_T_556 >> 4'h8); //@ csr.py:132
    assign _T_574 = _T_571[15:0]; //@ csr.py:132
    assign _T_573 = _T_574; //@ csr.py:132
    assign _T_572 = _T_573; //@ csr.py:132
    assign _T_575 = (_T_560 >> 4'h8); //@ csr.py:133
    assign _T_578 = _T_575[15:0]; //@ csr.py:133
    assign _T_577 = _T_578; //@ csr.py:133
    assign _T_576 = _T_577; //@ csr.py:133
    assign _T_579 = (_T_10 & _T_16); //@ csr.py:331
    assign _T_580 = (_T_579 & _T_502); //@ csr.py:331
    assign _T_581 = 1'h0; //@ csr.py:142
    assign _T_582 = (_T_581 == 1'h0); //@ csr.py:143
    assign _T_583 = cfg_res_write_action_field_rw0_o; //@ csr.py:160
    assign _T_584 = (_T_27 >> 1'h1); //@ csr.py:162
    assign _T_587 = _T_584[30:0]; //@ csr.py:162
    assign _T_586 = _T_587; //@ csr.py:162
    assign _T_585 = _T_586; //@ csr.py:162
    assign _T_588 = cfg_res_write_action_field_rw1_o; //@ csr.py:160
    assign _T_589 = (_T_585 >> 2'h3); //@ csr.py:162
    assign _T_592 = _T_589[27:0]; //@ csr.py:162
    assign _T_591 = _T_592; //@ csr.py:162
    assign _T_590 = _T_591; //@ csr.py:162
    assign _T_593 = cfg_res_write_action_field_rw2_o; //@ csr.py:160
    assign _T_594 = (_T_590 >> 3'h4); //@ csr.py:162
    assign _T_597 = _T_594[23:0]; //@ csr.py:162
    assign _T_596 = _T_597; //@ csr.py:162
    assign _T_595 = _T_596; //@ csr.py:162
    assign _T_598 = cfg_res_write_action_field_rw3_o; //@ csr.py:160
    assign _T_599 = (_T_595 >> 4'h8); //@ csr.py:162
    assign _T_602 = _T_599[15:0]; //@ csr.py:162
    assign _T_601 = _T_602; //@ csr.py:162
    assign _T_600 = _T_601; //@ csr.py:162
    assign _T_603 = {_T_598, _T_593}; //@ csr.py:169
    assign _T_604 = {_T_603, _T_588}; //@ csr.py:169
    assign _T_605 = {_T_604, _T_583}; //@ csr.py:169
    assign _T_606 = {16'h0, _T_605}; //@ csr.py:169
    assign _T_607 = {1'h1{_T_606}}; //@ csr.py:174
    assign _T_608 = (_T_11_write ? 1'h1 : 1'h1); //@ csr.py:336
    assign _T_609 = (_T_608 & _T_502); //@ csr.py:337
    assign _T_610 = (_T_487 | _T_609); //@ csr.py:337
    assign _T_611 = (_T_11_write ? 1'h1 : 1'h1); //@ csr.py:339
    assign _T_612 = (_T_611 & _T_502); //@ csr.py:340
    assign _T_613 = (_T_490 | _T_612); //@ csr.py:340
    assign _T_614 = {6'h20{_T_502}}; //@ csr.py:342
    assign _T_615 = (_T_614 & _T_607); //@ csr.py:343
    assign _T_616 = (_T_493 | _T_615); //@ csr.py:343
    assign _T_617 = (_T_11_addr >> 2'h2); //@ csr.py:232
    assign _T_620 = _T_617[9:0]; //@ csr.py:232
    assign _T_619 = _T_620; //@ csr.py:232
    assign _T_618 = _T_619; //@ csr.py:232
    assign _T_621 = (_T_618 << 2'h2); //@ csr.py:232
    assign _T_622 = 12'h0; //@ csr.py:232
    assign _T_623 = ~_T_622; //@ csr.py:232
    assign _T_624 = (_T_621 & _T_623); //@ csr.py:232
    assign _T_625 = (_T_624 == 12'h14); //@ csr.py:321
    assign _T_626 = (_T_503 | _T_625); //@ csr.py:322
    assign _T_627 = (_T_10 & _T_11_write); //@ csr.py:325
    assign _T_628 = (_T_627 & _T_625); //@ csr.py:325
    assign _T_629 = 1'h0; //@ csr.py:112
    assign _T_630 = (_T_629 == 1'h0); //@ csr.py:113
    assign _T_631 = (_T_629 == 1'h0); //@ csr.py:114
    assign _T_632 = (_T_11_data & _T_27); //@ csr.py:40
    assign _T_633 = ~_T_27; //@ csr.py:41
    assign _T_634 = (_T_11_data | _T_633); //@ csr.py:41
    assign _T_635 = ~_T_27; //@ csr.py:65
    assign _T_636 = (cfg_res_read_action_field_rw0_o & _T_635); //@ csr.py:65
    assign _T_637 = (_T_636 | _T_632); //@ csr.py:65
    assign _T_639 = (_T_628 ? _T_637 : cfg_res_read_action_field_rw0_o); //@ csr.py:65
    assign _T_641 = _T_639[0]; //@ csr.py:65
    assign _T_640 = _T_641; //@ csr.py:65
    assign _T_638 = _T_640; //@ csr.py:65
    assign cfg_res_read_action_field_rw0_i = _T_638; //@ csr.py:65
    assign _T_642 = (_T_27 >> 1'h1); //@ csr.py:132
    assign _T_645 = _T_642[30:0]; //@ csr.py:132
    assign _T_644 = _T_645; //@ csr.py:132
    assign _T_643 = _T_644; //@ csr.py:132
    assign _T_646 = (_T_11_data >> 1'h1); //@ csr.py:133
    assign _T_649 = _T_646[30:0]; //@ csr.py:133
    assign _T_648 = _T_649; //@ csr.py:133
    assign _T_647 = _T_648; //@ csr.py:133
    assign _T_650 = (_T_647 & _T_643); //@ csr.py:40
    assign _T_651 = ~_T_643; //@ csr.py:41
    assign _T_652 = (_T_647 | _T_651); //@ csr.py:41
    assign _T_653 = ~_T_643; //@ csr.py:65
    assign _T_654 = (cfg_res_read_action_field_rw1_o & _T_653); //@ csr.py:65
    assign _T_655 = (_T_654 | _T_650); //@ csr.py:65
    assign _T_657 = (_T_628 ? _T_655 : cfg_res_read_action_field_rw1_o); //@ csr.py:65
    assign _T_659 = _T_657[2:0]; //@ csr.py:65
    assign _T_658 = _T_659; //@ csr.py:65
    assign _T_656 = _T_658; //@ csr.py:65
    assign cfg_res_read_action_field_rw1_i = _T_656; //@ csr.py:65
    assign _T_660 = (_T_643 >> 2'h3); //@ csr.py:132
    assign _T_663 = _T_660[27:0]; //@ csr.py:132
    assign _T_662 = _T_663; //@ csr.py:132
    assign _T_661 = _T_662; //@ csr.py:132
    assign _T_664 = (_T_647 >> 2'h3); //@ csr.py:133
    assign _T_667 = _T_664[27:0]; //@ csr.py:133
    assign _T_666 = _T_667; //@ csr.py:133
    assign _T_665 = _T_666; //@ csr.py:133
    assign _T_668 = (_T_665 & _T_661); //@ csr.py:40
    assign _T_669 = ~_T_661; //@ csr.py:41
    assign _T_670 = (_T_665 | _T_669); //@ csr.py:41
    assign _T_671 = ~_T_661; //@ csr.py:65
    assign _T_672 = (cfg_res_read_action_field_rw2_o & _T_671); //@ csr.py:65
    assign _T_673 = (_T_672 | _T_668); //@ csr.py:65
    assign _T_675 = (_T_628 ? _T_673 : cfg_res_read_action_field_rw2_o); //@ csr.py:65
    assign _T_677 = _T_675[3:0]; //@ csr.py:65
    assign _T_676 = _T_677; //@ csr.py:65
    assign _T_674 = _T_676; //@ csr.py:65
    assign cfg_res_read_action_field_rw2_i = _T_674; //@ csr.py:65
    assign _T_678 = (_T_661 >> 3'h4); //@ csr.py:132
    assign _T_681 = _T_678[23:0]; //@ csr.py:132
    assign _T_680 = _T_681; //@ csr.py:132
    assign _T_679 = _T_680; //@ csr.py:132
    assign _T_682 = (_T_665 >> 3'h4); //@ csr.py:133
    assign _T_685 = _T_682[23:0]; //@ csr.py:133
    assign _T_684 = _T_685; //@ csr.py:133
    assign _T_683 = _T_684; //@ csr.py:133
    assign _T_686 = (_T_683 & _T_679); //@ csr.py:40
    assign _T_687 = ~_T_679; //@ csr.py:41
    assign _T_688 = (_T_683 | _T_687); //@ csr.py:41
    assign _T_689 = ~_T_679; //@ csr.py:65
    assign _T_690 = (cfg_res_read_action_field_rw3_o & _T_689); //@ csr.py:65
    assign _T_691 = (_T_690 | _T_686); //@ csr.py:65
    assign _T_693 = (_T_628 ? _T_691 : cfg_res_read_action_field_rw3_o); //@ csr.py:65
    assign _T_695 = _T_693[7:0]; //@ csr.py:65
    assign _T_694 = _T_695; //@ csr.py:65
    assign _T_692 = _T_694; //@ csr.py:65
    assign cfg_res_read_action_field_rw3_i = _T_692; //@ csr.py:65
    assign _T_696 = (_T_679 >> 4'h8); //@ csr.py:132
    assign _T_699 = _T_696[15:0]; //@ csr.py:132
    assign _T_698 = _T_699; //@ csr.py:132
    assign _T_697 = _T_698; //@ csr.py:132
    assign _T_700 = (_T_683 >> 4'h8); //@ csr.py:133
    assign _T_703 = _T_700[15:0]; //@ csr.py:133
    assign _T_702 = _T_703; //@ csr.py:133
    assign _T_701 = _T_702; //@ csr.py:133
    assign _T_704 = (_T_10 & _T_16); //@ csr.py:331
    assign _T_705 = (_T_704 & _T_625); //@ csr.py:331
    assign _T_706 = 1'h0; //@ csr.py:142
    assign _T_707 = (_T_706 == 1'h0); //@ csr.py:143
    assign _T_708 = cfg_res_read_action_field_rw0_o; //@ csr.py:160
    assign _T_709 = (_T_27 >> 1'h1); //@ csr.py:162
    assign _T_712 = _T_709[30:0]; //@ csr.py:162
    assign _T_711 = _T_712; //@ csr.py:162
    assign _T_710 = _T_711; //@ csr.py:162
    assign _T_713 = cfg_res_read_action_field_rw1_o; //@ csr.py:160
    assign _T_714 = (_T_710 >> 2'h3); //@ csr.py:162
    assign _T_717 = _T_714[27:0]; //@ csr.py:162
    assign _T_716 = _T_717; //@ csr.py:162
    assign _T_715 = _T_716; //@ csr.py:162
    assign _T_718 = cfg_res_read_action_field_rw2_o; //@ csr.py:160
    assign _T_719 = (_T_715 >> 3'h4); //@ csr.py:162
    assign _T_722 = _T_719[23:0]; //@ csr.py:162
    assign _T_721 = _T_722; //@ csr.py:162
    assign _T_720 = _T_721; //@ csr.py:162
    assign _T_724 = (_T_705 ? 1'h1 : 1'h0); //@ demo_utils_csr.py:98
    assign _T_723 = _T_724; //@ demo_utils_csr.py:98
    assign read_flag = _T_723; //@ demo_utils_csr.py:98
    assign _T_725 = read_data_o; //@ csr.py:160
    assign _T_726 = (_T_720 >> 4'h8); //@ csr.py:162
    assign _T_729 = _T_726[15:0]; //@ csr.py:162
    assign _T_728 = _T_729; //@ csr.py:162
    assign _T_727 = _T_728; //@ csr.py:162
    assign _T_730 = {_T_725, _T_718}; //@ csr.py:169
    assign _T_731 = {_T_730, _T_713}; //@ csr.py:169
    assign _T_732 = {_T_731, _T_708}; //@ csr.py:169
    assign _T_733 = {16'h0, _T_732}; //@ csr.py:169
    assign _T_734 = {1'h1{_T_733}}; //@ csr.py:174
    assign _T_735 = (_T_11_write ? 1'h1 : 1'h1); //@ csr.py:336
    assign _T_736 = (_T_735 & _T_625); //@ csr.py:337
    assign _T_737 = (_T_610 | _T_736); //@ csr.py:337
    assign _T_738 = (_T_11_write ? 1'h1 : 1'h1); //@ csr.py:339
    assign _T_739 = (_T_738 & _T_625); //@ csr.py:340
    assign _T_740 = (_T_613 | _T_739); //@ csr.py:340
    assign _T_741 = {6'h20{_T_625}}; //@ csr.py:342
    assign _T_742 = (_T_741 & _T_734); //@ csr.py:343
    assign _T_743 = (_T_616 | _T_742); //@ csr.py:343
    assign _T_744 = (_T_11_addr >> 2'h2); //@ csr.py:232
    assign _T_747 = _T_744[9:0]; //@ csr.py:232
    assign _T_746 = _T_747; //@ csr.py:232
    assign _T_745 = _T_746; //@ csr.py:232
    assign _T_748 = (_T_745 << 2'h2); //@ csr.py:232
    assign _T_749 = 12'hfff; //@ csr.py:232
    assign _T_750 = ~_T_749; //@ csr.py:232
    assign _T_751 = (_T_748 & _T_750); //@ csr.py:232
    assign _T_752 = ~_T_626; //@ csr.py:319
    assign _T_753 = (_T_626 | _T_752); //@ csr.py:322
    assign _T_754 = (_T_10 & _T_11_write); //@ csr.py:325
    assign _T_755 = (_T_754 & _T_752); //@ csr.py:325
    assign _T_756 = 1'h0; //@ csr.py:112
    assign _T_757 = (_T_756 == 1'h0); //@ csr.py:113
    assign _T_758 = (_T_756 == 1'h0); //@ csr.py:114
    assign _T_759 = (_T_11_data & _T_27); //@ csr.py:40
    assign _T_760 = ~_T_27; //@ csr.py:41
    assign _T_761 = (_T_11_data | _T_760); //@ csr.py:41
    assign _T_762 = (_T_27 >> 6'h20); //@ csr.py:132
    assign _T_765 = _T_762[0]; //@ csr.py:132
    assign _T_764 = _T_765; //@ csr.py:132
    assign _T_763 = _T_764; //@ csr.py:132
    assign _T_766 = (_T_11_data >> 6'h20); //@ csr.py:133
    assign _T_769 = _T_766[0]; //@ csr.py:133
    assign _T_768 = _T_769; //@ csr.py:133
    assign _T_767 = _T_768; //@ csr.py:133
    assign _T_770 = (_T_10 & _T_16); //@ csr.py:331
    assign _T_771 = (_T_770 & _T_752); //@ csr.py:331
    assign _T_772 = 1'h0; //@ csr.py:142
    assign _T_773 = (_T_772 == 1'h0); //@ csr.py:143
    assign _T_774 = dumy_mapped_space_data; //@ csr.py:160
    assign _T_775 = (_T_27 >> 6'h20); //@ csr.py:162
    assign _T_778 = _T_775[0]; //@ csr.py:162
    assign _T_777 = _T_778; //@ csr.py:162
    assign _T_776 = _T_777; //@ csr.py:162
    assign _T_779 = {1'h1{_T_774}}; //@ csr.py:174
    assign _T_780 = (_T_11_write ? 1'h1 : 1'h1); //@ csr.py:336
    assign _T_781 = (_T_780 & _T_752); //@ csr.py:337
    assign _T_782 = (_T_737 | _T_781); //@ csr.py:337
    assign _T_783 = (_T_11_write ? 1'h1 : 1'h1); //@ csr.py:339
    assign _T_784 = (_T_783 & _T_752); //@ csr.py:340
    assign _T_785 = (_T_740 | _T_784); //@ csr.py:340
    assign _T_786 = {6'h20{_T_752}}; //@ csr.py:342
    assign _T_787 = (_T_786 & _T_779); //@ csr.py:343
    assign _T_788 = (_T_743 | _T_787); //@ csr.py:343
    assign _T_789 = (_T_10 | _T_8_o); //@ csr.py:345
    assign _T_790 = (_T_782 & _T_789); //@ csr.py:345
    assign reg_resp_buf_io_enq_valid = _T_790; //@ csr.py:345
    assign _T_791_data = _T_788; //@ csr.py:266
    assign reg_resp_buf_io_enq_bits_data = _T_791_data; //@ csr.py:346
    assign _T_792 = ~_T_8_o; //@ csr.py:349
    assign _T_793 = (reg_resp_buf_io_enq_ready & _T_792); //@ csr.py:349
    assign _T_794 = (_T_793 & _T_785); //@ csr.py:350
    assign io_reg_req_ready = _T_794; //@ csr.py:350
    assign io_reg_resp_bits_data = reg_resp_buf_io_deq_bits_data; //@ csr.py:352
    assign io_reg_resp_valid = reg_resp_buf_io_deq_valid; //@ csr.py:352
    assign reg_resp_buf_io_deq_ready = io_reg_resp_ready; //@ csr.py:352
    assign _T_795 = (reg_resp_buf_io_enq_ready & reg_resp_buf_io_enq_valid); //@ csr.py:354
    assign _T_796 = ~_T_795; //@ csr.py:354
    assign _T_797 = (_T_10 & _T_796); //@ csr.py:354
    assign _T_799 = (_T_797 ? 1'h1 : _T_8_o); //@ csr.py:355
    assign _T_798 = _T_799; //@ csr.py:355
//    assign _T_8_i = _T_798; //@ csr.py:355
    assign _T_801 = (_T_797 ? io_reg_req_bits_be : _T_9_be_o); //@ csr.py:356
    assign _T_800 = _T_801; //@ csr.py:356
    assign _T_9_be_i = _T_800; //@ csr.py:356
    assign _T_803 = (_T_797 ? io_reg_req_bits_data : _T_9_data_o); //@ csr.py:356
    assign _T_802 = _T_803; //@ csr.py:356
    assign _T_9_data_i = _T_802; //@ csr.py:356
    assign _T_805 = (_T_797 ? io_reg_req_bits_addr : _T_9_addr_o); //@ csr.py:356
    assign _T_804 = _T_805; //@ csr.py:356
    assign _T_9_addr_i = _T_804; //@ csr.py:356
    assign _T_807 = (_T_797 ? io_reg_req_bits_write : _T_9_write_o); //@ csr.py:356
    assign _T_806 = _T_807; //@ csr.py:356
    assign _T_9_write_i = _T_806; //@ csr.py:356
    assign _T_808 = (reg_resp_buf_io_enq_ready & reg_resp_buf_io_enq_valid); //@ csr.py:357
    assign _T_809 = (_T_8_o & _T_808); //@ csr.py:357
    assign _T_810 = (_T_797 | _T_809); //@ csr.py:357
    assign _T_811 = (_T_797 == 1'h0); //@ csr.py:357
    assign _T_812 = (_T_811 & _T_809); //@ csr.py:357
    assign _T_814 = (_T_812 ? 1'h0 : _T_798); //@ csr.py:358
    assign _T_813 = _T_814; //@ csr.py:358
    assign _T_8_i = _T_813; //@ csr.py:358
endmodule
module queue(
    output wire  io_enq_ready, //@ fifo.py:21
    input  wire  io_enq_valid, //@ fifo.py:21
    input  wire [31:0] io_enq_bits_data, //@ fifo.py:21
    input  wire  io_deq_ready, //@ fifo.py:22
    output wire  io_deq_valid, //@ fifo.py:22
    output wire [31:0] io_deq_bits_data, //@ fifo.py:22
    output wire [1:0] io_count, //@ fifo.py:24
    input  wire  clock, //@ csr.py:303
    input  wire  reset  //@ csr.py:303
);
    wire [31:0] ram_0_data_i; //@ fifo.py:60
    reg  [31:0] ram_0_data_o; //@ fifo.py:60
    wire [31:0] ram_1_data_i; //@ fifo.py:60
    reg  [31:0] ram_1_data_o; //@ fifo.py:60
    wire  enq_ptr_value_i; //@ counters.py:17
    reg   enq_ptr_value_o; //@ counters.py:17
    wire  enq_ptr_wrap; //@ counters.py:18
    wire  deq_ptr_value_i; //@ counters.py:17
    reg   deq_ptr_value_o; //@ counters.py:17
    wire  deq_ptr_wrap; //@ counters.py:18
    wire  maybe_full_i; //@ fifo.py:63
    reg   maybe_full_o; //@ fifo.py:63
    wire  _T_0; //@ fifo.py:65
    wire  _T_1; //@ fifo.py:66
    wire  _T_2; //@ fifo.py:66
    wire  _T_3; //@ fifo.py:67
    wire  _T_4; //@ fifo.py:68
    wire  do_enq; //@ fifo.py:68
    wire  _T_5; //@ fifo.py:69
    wire  do_deq; //@ fifo.py:69
    wire  _T_6; //@ fifo.py:72
    wire [31:0] _T_7; //@ fifo.py:72
    wire  _T_8; //@ fifo.py:72
    wire [31:0] _T_9; //@ fifo.py:72
    wire  _T_10; //@ fifo.py:72
    wire [31:0] _T_11; //@ fifo.py:72
    wire  _T_12; //@ fifo.py:72
    wire [31:0] _T_13; //@ fifo.py:72
    wire  _T_14; //@ counters.py:27
    wire [1:0] _T_15; //@ counters.py:28
    wire  _T_16; //@ counters.py:28
    wire [1:0] _T_17; //@ counters.py:28
    wire  _T_18; //@ counters.py:28
    wire  _T_19; //@ counters.py:28
    wire  _T_20; //@ counters.py:27
    wire [1:0] _T_21; //@ counters.py:28
    wire  _T_22; //@ counters.py:28
    wire [1:0] _T_23; //@ counters.py:28
    wire  _T_24; //@ counters.py:28
    wire  _T_25; //@ counters.py:28
    wire  _T_26; //@ fifo.py:76
    wire  _T_27; //@ fifo.py:77
    wire  _T_28; //@ fifo.py:77
    wire  _T_29; //@ fifo.py:79
    wire  _T_30; //@ fifo.py:80
    wire [31:0] _T_31_data; //@ csr.py:202
    wire  _T_32; //@ fifo.py:81
    wire [31:0] _T_33; //@ fifo.py:81
    wire [31:0] _T_34; //@ fifo.py:81
    wire  _T_35; //@ fifo.py:81
    wire [31:0] _T_36; //@ fifo.py:81
    wire [31:0] _T_37; //@ fifo.py:81
    wire [31:0] _T_38; //@ fifo.py:81
    wire [1:0] _T_39; //@ fifo.py:96
    wire  _T_40; //@ fifo.py:99
    wire  _T_41; //@ fifo.py:100
    wire [1:0] _T_42; //@ fifo.py:100
    always @(posedge clock) //@ fifo.py:60
        ram_0_data_o <= ram_0_data_i;
    always @(posedge clock) //@ fifo.py:60
        ram_1_data_o <= ram_1_data_i;
    always @(posedge clock) //@ counters.py:17
        if (reset)
            enq_ptr_value_o <= 1'h0;
        else
            enq_ptr_value_o <= enq_ptr_value_i;
    always @(posedge clock) //@ counters.py:17
        if (reset)
            deq_ptr_value_o <= 1'h0;
        else
            deq_ptr_value_o <= deq_ptr_value_i;
    always @(posedge clock) //@ fifo.py:63
        if (reset)
            maybe_full_o <= 1'h0;
        else
            maybe_full_o <= maybe_full_i;
    assign _T_0 = (enq_ptr_value_o == deq_ptr_value_o); //@ fifo.py:65
    assign _T_1 = ~maybe_full_o; //@ fifo.py:66
    assign _T_2 = (_T_0 & _T_1); //@ fifo.py:66
    assign _T_3 = (_T_0 & maybe_full_o); //@ fifo.py:67
    assign _T_4 = (io_enq_ready & io_enq_valid); //@ fifo.py:68
    assign do_enq = _T_4; //@ fifo.py:68
    assign _T_5 = (io_deq_ready & io_deq_valid); //@ fifo.py:69
    assign do_deq = _T_5; //@ fifo.py:69
    assign _T_6 = (enq_ptr_value_o == 1'h0); //@ fifo.py:72
    assign _T_8 = (do_enq & _T_6); //@ fifo.py:72
    assign _T_9 = (_T_8 ? io_enq_bits_data : ram_0_data_o); //@ fifo.py:72
    assign _T_7 = _T_9; //@ fifo.py:72
    assign ram_0_data_i = _T_7; //@ fifo.py:72
    assign _T_10 = (enq_ptr_value_o == 1'h1); //@ fifo.py:72
    assign _T_12 = (do_enq & _T_10); //@ fifo.py:72
    assign _T_13 = (_T_12 ? io_enq_bits_data : ram_1_data_o); //@ fifo.py:72
    assign _T_11 = _T_13; //@ fifo.py:72
    assign ram_1_data_i = _T_11; //@ fifo.py:72
    assign _T_14 = (enq_ptr_value_o == 1'h1); //@ counters.py:27
    assign _T_15 = (enq_ptr_value_o + 1'h1); //@ counters.py:28
    assign _T_17 = (do_enq ? _T_15 : enq_ptr_value_o); //@ counters.py:28
    assign _T_19 = _T_17[0]; //@ counters.py:28
    assign _T_18 = _T_19; //@ counters.py:28
    assign _T_16 = _T_18; //@ counters.py:28
    assign enq_ptr_value_i = _T_16; //@ counters.py:28
    assign _T_20 = (deq_ptr_value_o == 1'h1); //@ counters.py:27
    assign _T_21 = (deq_ptr_value_o + 1'h1); //@ counters.py:28
    assign _T_23 = (do_deq ? _T_21 : deq_ptr_value_o); //@ counters.py:28
    assign _T_25 = _T_23[0]; //@ counters.py:28
    assign _T_24 = _T_25; //@ counters.py:28
    assign _T_22 = _T_24; //@ counters.py:28
    assign deq_ptr_value_i = _T_22; //@ counters.py:28
    assign _T_26 = (do_enq != do_deq); //@ fifo.py:76
    assign _T_28 = (_T_26 ? do_enq : maybe_full_o); //@ fifo.py:77
    assign _T_27 = _T_28; //@ fifo.py:77
    assign maybe_full_i = _T_27; //@ fifo.py:77
    assign _T_29 = ~_T_2; //@ fifo.py:79
    assign io_deq_valid = _T_29; //@ fifo.py:79
    assign _T_30 = ~_T_3; //@ fifo.py:80
    assign io_enq_ready = _T_30; //@ fifo.py:80
    assign _T_32 = (deq_ptr_value_o == 1'h0); //@ fifo.py:81
    assign _T_33 = {6'h20{_T_32}}; //@ fifo.py:81
    assign _T_34 = (_T_33 & ram_0_data_o); //@ fifo.py:81
    assign _T_35 = (deq_ptr_value_o == 1'h1); //@ fifo.py:81
    assign _T_36 = {6'h20{_T_35}}; //@ fifo.py:81
    assign _T_37 = (_T_36 & ram_1_data_o); //@ fifo.py:81
    assign _T_38 = (_T_34 | _T_37); //@ fifo.py:81
    assign _T_31_data = _T_38; //@ fifo.py:81
    assign io_deq_bits_data = _T_31_data; //@ fifo.py:81
    assign _T_39 = (enq_ptr_value_o - deq_ptr_value_o); //@ fifo.py:96
    assign _T_40 = (maybe_full_o & _T_0); //@ fifo.py:99
    assign _T_41 = _T_39[0]; //@ fifo.py:100
    assign _T_42 = {_T_40, _T_41}; //@ fifo.py:100
    assign io_count = _T_42; //@ fifo.py:100
endmodule
