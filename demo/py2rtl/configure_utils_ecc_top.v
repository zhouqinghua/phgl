module utils_ecc_top(
    input  wire  io_sram_ctrl_read_en, //@ demo_utils_ecc.py:6
    input  wire  io_sram_ctrl_write_en, //@ demo_utils_ecc.py:7
    input  wire [3:0] io_sram_ctrl_address, //@ demo_utils_ecc.py:8
    input  wire [63:0] io_sram_ctrl_write_data, //@ demo_utils_ecc.py:9
    output wire [63:0] io_sram_ctrl_read_data, //@ demo_utils_ecc.py:10
    input  wire  clock, //@ phgl_generator.py:85
    input  wire  reset  //@ phgl_generator.py:85
);
    wire [64:0] mem_parity_0_i; //@ demo_utils_ecc.py:24
    reg  [64:0] mem_parity_0_o; //@ demo_utils_ecc.py:24
    wire [64:0] mem_parity_1_i; //@ demo_utils_ecc.py:24
    reg  [64:0] mem_parity_1_o; //@ demo_utils_ecc.py:24
    wire [64:0] mem_parity_2_i; //@ demo_utils_ecc.py:24
    reg  [64:0] mem_parity_2_o; //@ demo_utils_ecc.py:24
    wire [64:0] mem_parity_3_i; //@ demo_utils_ecc.py:24
    reg  [64:0] mem_parity_3_o; //@ demo_utils_ecc.py:24
    wire [64:0] mem_parity_4_i; //@ demo_utils_ecc.py:24
    reg  [64:0] mem_parity_4_o; //@ demo_utils_ecc.py:24
    wire [64:0] mem_parity_5_i; //@ demo_utils_ecc.py:24
    reg  [64:0] mem_parity_5_o; //@ demo_utils_ecc.py:24
    wire [64:0] mem_parity_6_i; //@ demo_utils_ecc.py:24
    reg  [64:0] mem_parity_6_o; //@ demo_utils_ecc.py:24
    wire [64:0] mem_parity_7_i; //@ demo_utils_ecc.py:24
    reg  [64:0] mem_parity_7_o; //@ demo_utils_ecc.py:24
    wire [64:0] mem_parity_8_i; //@ demo_utils_ecc.py:24
    reg  [64:0] mem_parity_8_o; //@ demo_utils_ecc.py:24
    wire [64:0] mem_parity_9_i; //@ demo_utils_ecc.py:24
    reg  [64:0] mem_parity_9_o; //@ demo_utils_ecc.py:24
    wire [64:0] mem_parity_10_i; //@ demo_utils_ecc.py:24
    reg  [64:0] mem_parity_10_o; //@ demo_utils_ecc.py:24
    wire [64:0] mem_parity_11_i; //@ demo_utils_ecc.py:24
    reg  [64:0] mem_parity_11_o; //@ demo_utils_ecc.py:24
    wire [64:0] mem_parity_12_i; //@ demo_utils_ecc.py:24
    reg  [64:0] mem_parity_12_o; //@ demo_utils_ecc.py:24
    wire [64:0] mem_parity_13_i; //@ demo_utils_ecc.py:24
    reg  [64:0] mem_parity_13_o; //@ demo_utils_ecc.py:24
    wire [64:0] mem_parity_14_i; //@ demo_utils_ecc.py:24
    reg  [64:0] mem_parity_14_o; //@ demo_utils_ecc.py:24
    wire [64:0] mem_parity_15_i; //@ demo_utils_ecc.py:24
    reg  [64:0] mem_parity_15_o; //@ demo_utils_ecc.py:24
    wire [63:0] parity_out_data_pre_correct_i; //@ demo_utils_ecc.py:25
    reg  [63:0] parity_out_data_pre_correct_o; //@ demo_utils_ecc.py:25
    wire [63:0] parity_out_data_post_correct_i; //@ demo_utils_ecc.py:26
    reg  [63:0] parity_out_data_post_correct_o; //@ demo_utils_ecc.py:26
    wire  parity_out_error_i; //@ demo_utils_ecc.py:27
    reg   parity_out_error_o; //@ demo_utils_ecc.py:27
    wire  parity_out_error_uncorrectable_i; //@ demo_utils_ecc.py:28
    reg   parity_out_error_uncorrectable_o; //@ demo_utils_ecc.py:28
    wire  _T_1; //@ ecc.py:68
    wire  _T_2; //@ ecc.py:68
    wire [64:0] _T_3; //@ ecc.py:68
    wire  _T_4; //@ demo_utils_ecc.py:33
    wire [64:0] _T_5; //@ demo_utils_ecc.py:33
    wire  _T_6; //@ demo_utils_ecc.py:33
    wire [64:0] _T_7; //@ demo_utils_ecc.py:33
    wire  _T_8; //@ demo_utils_ecc.py:33
    wire [64:0] _T_9; //@ demo_utils_ecc.py:33
    wire  _T_10; //@ demo_utils_ecc.py:33
    wire [64:0] _T_11; //@ demo_utils_ecc.py:33
    wire  _T_12; //@ demo_utils_ecc.py:33
    wire [64:0] _T_13; //@ demo_utils_ecc.py:33
    wire  _T_14; //@ demo_utils_ecc.py:33
    wire [64:0] _T_15; //@ demo_utils_ecc.py:33
    wire  _T_16; //@ demo_utils_ecc.py:33
    wire [64:0] _T_17; //@ demo_utils_ecc.py:33
    wire  _T_18; //@ demo_utils_ecc.py:33
    wire [64:0] _T_19; //@ demo_utils_ecc.py:33
    wire  _T_20; //@ demo_utils_ecc.py:33
    wire [64:0] _T_21; //@ demo_utils_ecc.py:33
    wire  _T_22; //@ demo_utils_ecc.py:33
    wire [64:0] _T_23; //@ demo_utils_ecc.py:33
    wire  _T_24; //@ demo_utils_ecc.py:33
    wire [64:0] _T_25; //@ demo_utils_ecc.py:33
    wire  _T_26; //@ demo_utils_ecc.py:33
    wire [64:0] _T_27; //@ demo_utils_ecc.py:33
    wire  _T_28; //@ demo_utils_ecc.py:33
    wire [64:0] _T_29; //@ demo_utils_ecc.py:33
    wire  _T_30; //@ demo_utils_ecc.py:33
    wire [64:0] _T_31; //@ demo_utils_ecc.py:33
    wire  _T_32; //@ demo_utils_ecc.py:33
    wire [64:0] _T_33; //@ demo_utils_ecc.py:33
    wire  _T_34; //@ demo_utils_ecc.py:33
    wire [64:0] _T_35; //@ demo_utils_ecc.py:33
    wire  _T_36; //@ demo_utils_ecc.py:33
    wire [64:0] _T_37; //@ demo_utils_ecc.py:33
    wire  _T_38; //@ demo_utils_ecc.py:33
    wire [64:0] _T_39; //@ demo_utils_ecc.py:33
    wire  _T_40; //@ demo_utils_ecc.py:33
    wire [64:0] _T_41; //@ demo_utils_ecc.py:33
    wire  _T_42; //@ demo_utils_ecc.py:33
    wire [64:0] _T_43; //@ demo_utils_ecc.py:33
    wire  _T_44; //@ demo_utils_ecc.py:33
    wire [64:0] _T_45; //@ demo_utils_ecc.py:33
    wire  _T_46; //@ demo_utils_ecc.py:33
    wire [64:0] _T_47; //@ demo_utils_ecc.py:33
    wire  _T_48; //@ demo_utils_ecc.py:33
    wire [64:0] _T_49; //@ demo_utils_ecc.py:33
    wire  _T_50; //@ demo_utils_ecc.py:33
    wire [64:0] _T_51; //@ demo_utils_ecc.py:33
    wire  _T_52; //@ demo_utils_ecc.py:33
    wire [64:0] _T_53; //@ demo_utils_ecc.py:33
    wire  _T_54; //@ demo_utils_ecc.py:33
    wire [64:0] _T_55; //@ demo_utils_ecc.py:33
    wire  _T_56; //@ demo_utils_ecc.py:33
    wire [64:0] _T_57; //@ demo_utils_ecc.py:33
    wire  _T_58; //@ demo_utils_ecc.py:33
    wire [64:0] _T_59; //@ demo_utils_ecc.py:33
    wire  _T_60; //@ demo_utils_ecc.py:33
    wire [64:0] _T_61; //@ demo_utils_ecc.py:33
    wire  _T_62; //@ demo_utils_ecc.py:33
    wire [64:0] _T_63; //@ demo_utils_ecc.py:33
    wire  _T_64; //@ demo_utils_ecc.py:33
    wire [64:0] _T_65; //@ demo_utils_ecc.py:33
    wire  _T_66; //@ demo_utils_ecc.py:33
    wire [64:0] _T_67; //@ demo_utils_ecc.py:33
    wire  _T_68; //@ demo_utils_ecc.py:36
    wire [64:0] _T_69; //@ demo_utils_ecc.py:36
    wire [64:0] _T_70; //@ demo_utils_ecc.py:36
    wire  _T_71; //@ demo_utils_ecc.py:36
    wire [64:0] _T_72; //@ demo_utils_ecc.py:36
    wire [64:0] _T_73; //@ demo_utils_ecc.py:36
    wire [64:0] _T_74; //@ demo_utils_ecc.py:36
    wire  _T_75; //@ demo_utils_ecc.py:36
    wire [64:0] _T_76; //@ demo_utils_ecc.py:36
    wire [64:0] _T_77; //@ demo_utils_ecc.py:36
    wire [64:0] _T_78; //@ demo_utils_ecc.py:36
    wire  _T_79; //@ demo_utils_ecc.py:36
    wire [64:0] _T_80; //@ demo_utils_ecc.py:36
    wire [64:0] _T_81; //@ demo_utils_ecc.py:36
    wire [64:0] _T_82; //@ demo_utils_ecc.py:36
    wire  _T_83; //@ demo_utils_ecc.py:36
    wire [64:0] _T_84; //@ demo_utils_ecc.py:36
    wire [64:0] _T_85; //@ demo_utils_ecc.py:36
    wire [64:0] _T_86; //@ demo_utils_ecc.py:36
    wire  _T_87; //@ demo_utils_ecc.py:36
    wire [64:0] _T_88; //@ demo_utils_ecc.py:36
    wire [64:0] _T_89; //@ demo_utils_ecc.py:36
    wire [64:0] _T_90; //@ demo_utils_ecc.py:36
    wire  _T_91; //@ demo_utils_ecc.py:36
    wire [64:0] _T_92; //@ demo_utils_ecc.py:36
    wire [64:0] _T_93; //@ demo_utils_ecc.py:36
    wire [64:0] _T_94; //@ demo_utils_ecc.py:36
    wire  _T_95; //@ demo_utils_ecc.py:36
    wire [64:0] _T_96; //@ demo_utils_ecc.py:36
    wire [64:0] _T_97; //@ demo_utils_ecc.py:36
    wire [64:0] _T_98; //@ demo_utils_ecc.py:36
    wire  _T_99; //@ demo_utils_ecc.py:36
    wire [64:0] _T_100; //@ demo_utils_ecc.py:36
    wire [64:0] _T_101; //@ demo_utils_ecc.py:36
    wire [64:0] _T_102; //@ demo_utils_ecc.py:36
    wire  _T_103; //@ demo_utils_ecc.py:36
    wire [64:0] _T_104; //@ demo_utils_ecc.py:36
    wire [64:0] _T_105; //@ demo_utils_ecc.py:36
    wire [64:0] _T_106; //@ demo_utils_ecc.py:36
    wire  _T_107; //@ demo_utils_ecc.py:36
    wire [64:0] _T_108; //@ demo_utils_ecc.py:36
    wire [64:0] _T_109; //@ demo_utils_ecc.py:36
    wire [64:0] _T_110; //@ demo_utils_ecc.py:36
    wire  _T_111; //@ demo_utils_ecc.py:36
    wire [64:0] _T_112; //@ demo_utils_ecc.py:36
    wire [64:0] _T_113; //@ demo_utils_ecc.py:36
    wire [64:0] _T_114; //@ demo_utils_ecc.py:36
    wire  _T_115; //@ demo_utils_ecc.py:36
    wire [64:0] _T_116; //@ demo_utils_ecc.py:36
    wire [64:0] _T_117; //@ demo_utils_ecc.py:36
    wire [64:0] _T_118; //@ demo_utils_ecc.py:36
    wire  _T_119; //@ demo_utils_ecc.py:36
    wire [64:0] _T_120; //@ demo_utils_ecc.py:36
    wire [64:0] _T_121; //@ demo_utils_ecc.py:36
    wire [64:0] _T_122; //@ demo_utils_ecc.py:36
    wire  _T_123; //@ demo_utils_ecc.py:36
    wire [64:0] _T_124; //@ demo_utils_ecc.py:36
    wire [64:0] _T_125; //@ demo_utils_ecc.py:36
    wire [64:0] _T_126; //@ demo_utils_ecc.py:36
    wire  _T_127; //@ demo_utils_ecc.py:36
    wire [64:0] _T_128; //@ demo_utils_ecc.py:36
    wire [64:0] _T_129; //@ demo_utils_ecc.py:36
    wire [64:0] _T_130; //@ demo_utils_ecc.py:36
    wire [64:0] _T_131_pre_correct; //@ ecc.py:13
    wire [64:0] _T_131_post_correct; //@ ecc.py:14
    wire  _T_131_correctable; //@ ecc.py:15
    wire  _T_131_uncorrectable; //@ ecc.py:16
    wire [63:0] _T_132; //@ ecc.py:73
    wire  _T_133; //@ ecc.py:75
    wire  _T_134; //@ ecc.py:76
    wire [63:0] _T_135; //@ demo_utils_ecc.py:38
    wire [64:0] _T_136; //@ demo_utils_ecc.py:38
    wire [63:0] _T_137; //@ demo_utils_ecc.py:38
    wire [63:0] _T_138; //@ demo_utils_ecc.py:38
    wire [63:0] _T_139; //@ demo_utils_ecc.py:39
    wire [64:0] _T_140; //@ demo_utils_ecc.py:39
    wire [63:0] _T_141; //@ demo_utils_ecc.py:39
    wire [63:0] _T_142; //@ demo_utils_ecc.py:39
    wire  _T_143; //@ ecc.py:18
    wire  _T_144; //@ demo_utils_ecc.py:40
    wire  _T_145; //@ demo_utils_ecc.py:40
    wire  _T_146; //@ demo_utils_ecc.py:41
    wire  _T_147; //@ demo_utils_ecc.py:41
    wire [71:0] mem_ecc_0_i; //@ demo_utils_ecc.py:47
    reg  [71:0] mem_ecc_0_o; //@ demo_utils_ecc.py:47
    wire [71:0] mem_ecc_1_i; //@ demo_utils_ecc.py:47
    reg  [71:0] mem_ecc_1_o; //@ demo_utils_ecc.py:47
    wire [71:0] mem_ecc_2_i; //@ demo_utils_ecc.py:47
    reg  [71:0] mem_ecc_2_o; //@ demo_utils_ecc.py:47
    wire [71:0] mem_ecc_3_i; //@ demo_utils_ecc.py:47
    reg  [71:0] mem_ecc_3_o; //@ demo_utils_ecc.py:47
    wire [71:0] mem_ecc_4_i; //@ demo_utils_ecc.py:47
    reg  [71:0] mem_ecc_4_o; //@ demo_utils_ecc.py:47
    wire [71:0] mem_ecc_5_i; //@ demo_utils_ecc.py:47
    reg  [71:0] mem_ecc_5_o; //@ demo_utils_ecc.py:47
    wire [71:0] mem_ecc_6_i; //@ demo_utils_ecc.py:47
    reg  [71:0] mem_ecc_6_o; //@ demo_utils_ecc.py:47
    wire [71:0] mem_ecc_7_i; //@ demo_utils_ecc.py:47
    reg  [71:0] mem_ecc_7_o; //@ demo_utils_ecc.py:47
    wire [71:0] mem_ecc_8_i; //@ demo_utils_ecc.py:47
    reg  [71:0] mem_ecc_8_o; //@ demo_utils_ecc.py:47
    wire [71:0] mem_ecc_9_i; //@ demo_utils_ecc.py:47
    reg  [71:0] mem_ecc_9_o; //@ demo_utils_ecc.py:47
    wire [71:0] mem_ecc_10_i; //@ demo_utils_ecc.py:47
    reg  [71:0] mem_ecc_10_o; //@ demo_utils_ecc.py:47
    wire [71:0] mem_ecc_11_i; //@ demo_utils_ecc.py:47
    reg  [71:0] mem_ecc_11_o; //@ demo_utils_ecc.py:47
    wire [71:0] mem_ecc_12_i; //@ demo_utils_ecc.py:47
    reg  [71:0] mem_ecc_12_o; //@ demo_utils_ecc.py:47
    wire [71:0] mem_ecc_13_i; //@ demo_utils_ecc.py:47
    reg  [71:0] mem_ecc_13_o; //@ demo_utils_ecc.py:47
    wire [71:0] mem_ecc_14_i; //@ demo_utils_ecc.py:47
    reg  [71:0] mem_ecc_14_o; //@ demo_utils_ecc.py:47
    wire [71:0] mem_ecc_15_i; //@ demo_utils_ecc.py:47
    reg  [71:0] mem_ecc_15_o; //@ demo_utils_ecc.py:47
    wire [63:0] ecc_out_data_pre_correct_i; //@ demo_utils_ecc.py:48
    reg  [63:0] ecc_out_data_pre_correct_o; //@ demo_utils_ecc.py:48
    wire [63:0] ecc_out_data_post_correct_i; //@ demo_utils_ecc.py:49
    reg  [63:0] ecc_out_data_post_correct_o; //@ demo_utils_ecc.py:49
    wire  ecc_out_error_i; //@ demo_utils_ecc.py:50
    reg   ecc_out_error_o; //@ demo_utils_ecc.py:50
    wire  ecc_out_error_uncorrectable_i; //@ demo_utils_ecc.py:51
    reg   ecc_out_error_uncorrectable_o; //@ demo_utils_ecc.py:51
    wire [1:0] _T_149; //@ ecc.py:166
    wire [71:0] _T_150; //@ ecc.py:167
    wire [70:0] _T_151; //@ ecc.py:118
    wire [63:0] _T_152; //@ ecc.py:131
    wire [63:0] _T_153; //@ ecc.py:131
    wire  _T_154; //@ ecc.py:131
    wire  _T_155; //@ ecc.py:131
    wire [70:0] _T_156; //@ ecc.py:118
    wire [63:0] _T_157; //@ ecc.py:131
    wire [63:0] _T_158; //@ ecc.py:131
    wire  _T_159; //@ ecc.py:131
    wire  _T_160; //@ ecc.py:131
    wire [70:0] _T_161; //@ ecc.py:118
    wire [63:0] _T_162; //@ ecc.py:131
    wire [63:0] _T_163; //@ ecc.py:131
    wire  _T_164; //@ ecc.py:131
    wire  _T_165; //@ ecc.py:131
    wire [70:0] _T_166; //@ ecc.py:118
    wire [63:0] _T_167; //@ ecc.py:131
    wire [63:0] _T_168; //@ ecc.py:131
    wire  _T_169; //@ ecc.py:131
    wire  _T_170; //@ ecc.py:131
    wire [70:0] _T_171; //@ ecc.py:118
    wire [63:0] _T_172; //@ ecc.py:131
    wire [63:0] _T_173; //@ ecc.py:131
    wire  _T_174; //@ ecc.py:131
    wire  _T_175; //@ ecc.py:131
    wire [70:0] _T_176; //@ ecc.py:118
    wire [63:0] _T_177; //@ ecc.py:131
    wire [63:0] _T_178; //@ ecc.py:131
    wire  _T_179; //@ ecc.py:131
    wire  _T_180; //@ ecc.py:131
    wire [70:0] _T_181; //@ ecc.py:118
    wire [63:0] _T_182; //@ ecc.py:131
    wire [63:0] _T_183; //@ ecc.py:131
    wire  _T_184; //@ ecc.py:131
    wire  _T_185; //@ ecc.py:131
    wire [1:0] _T_186; //@ ecc.py:132
    wire [2:0] _T_187; //@ ecc.py:132
    wire [3:0] _T_188; //@ ecc.py:132
    wire [4:0] _T_189; //@ ecc.py:132
    wire [5:0] _T_190; //@ ecc.py:132
    wire [6:0] _T_191; //@ ecc.py:132
    wire [70:0] _T_192; //@ ecc.py:133
    wire  _T_193; //@ ecc.py:68
    wire  _T_194; //@ ecc.py:68
    wire [71:0] _T_195; //@ ecc.py:68
    wire [71:0] _T_196; //@ ecc.py:168
    wire  _T_197; //@ demo_utils_ecc.py:56
    wire [71:0] _T_198; //@ demo_utils_ecc.py:56
    wire  _T_199; //@ demo_utils_ecc.py:56
    wire [71:0] _T_200; //@ demo_utils_ecc.py:56
    wire  _T_201; //@ demo_utils_ecc.py:56
    wire [71:0] _T_202; //@ demo_utils_ecc.py:56
    wire  _T_203; //@ demo_utils_ecc.py:56
    wire [71:0] _T_204; //@ demo_utils_ecc.py:56
    wire  _T_205; //@ demo_utils_ecc.py:56
    wire [71:0] _T_206; //@ demo_utils_ecc.py:56
    wire  _T_207; //@ demo_utils_ecc.py:56
    wire [71:0] _T_208; //@ demo_utils_ecc.py:56
    wire  _T_209; //@ demo_utils_ecc.py:56
    wire [71:0] _T_210; //@ demo_utils_ecc.py:56
    wire  _T_211; //@ demo_utils_ecc.py:56
    wire [71:0] _T_212; //@ demo_utils_ecc.py:56
    wire  _T_213; //@ demo_utils_ecc.py:56
    wire [71:0] _T_214; //@ demo_utils_ecc.py:56
    wire  _T_215; //@ demo_utils_ecc.py:56
    wire [71:0] _T_216; //@ demo_utils_ecc.py:56
    wire  _T_217; //@ demo_utils_ecc.py:56
    wire [71:0] _T_218; //@ demo_utils_ecc.py:56
    wire  _T_219; //@ demo_utils_ecc.py:56
    wire [71:0] _T_220; //@ demo_utils_ecc.py:56
    wire  _T_221; //@ demo_utils_ecc.py:56
    wire [71:0] _T_222; //@ demo_utils_ecc.py:56
    wire  _T_223; //@ demo_utils_ecc.py:56
    wire [71:0] _T_224; //@ demo_utils_ecc.py:56
    wire  _T_225; //@ demo_utils_ecc.py:56
    wire [71:0] _T_226; //@ demo_utils_ecc.py:56
    wire  _T_227; //@ demo_utils_ecc.py:56
    wire [71:0] _T_228; //@ demo_utils_ecc.py:56
    wire  _T_229; //@ demo_utils_ecc.py:56
    wire [71:0] _T_230; //@ demo_utils_ecc.py:56
    wire  _T_231; //@ demo_utils_ecc.py:56
    wire [71:0] _T_232; //@ demo_utils_ecc.py:56
    wire  _T_233; //@ demo_utils_ecc.py:56
    wire [71:0] _T_234; //@ demo_utils_ecc.py:56
    wire  _T_235; //@ demo_utils_ecc.py:56
    wire [71:0] _T_236; //@ demo_utils_ecc.py:56
    wire  _T_237; //@ demo_utils_ecc.py:56
    wire [71:0] _T_238; //@ demo_utils_ecc.py:56
    wire  _T_239; //@ demo_utils_ecc.py:56
    wire [71:0] _T_240; //@ demo_utils_ecc.py:56
    wire  _T_241; //@ demo_utils_ecc.py:56
    wire [71:0] _T_242; //@ demo_utils_ecc.py:56
    wire  _T_243; //@ demo_utils_ecc.py:56
    wire [71:0] _T_244; //@ demo_utils_ecc.py:56
    wire  _T_245; //@ demo_utils_ecc.py:56
    wire [71:0] _T_246; //@ demo_utils_ecc.py:56
    wire  _T_247; //@ demo_utils_ecc.py:56
    wire [71:0] _T_248; //@ demo_utils_ecc.py:56
    wire  _T_249; //@ demo_utils_ecc.py:56
    wire [71:0] _T_250; //@ demo_utils_ecc.py:56
    wire  _T_251; //@ demo_utils_ecc.py:56
    wire [71:0] _T_252; //@ demo_utils_ecc.py:56
    wire  _T_253; //@ demo_utils_ecc.py:56
    wire [71:0] _T_254; //@ demo_utils_ecc.py:56
    wire  _T_255; //@ demo_utils_ecc.py:56
    wire [71:0] _T_256; //@ demo_utils_ecc.py:56
    wire  _T_257; //@ demo_utils_ecc.py:56
    wire [71:0] _T_258; //@ demo_utils_ecc.py:56
    wire  _T_259; //@ demo_utils_ecc.py:56
    wire [71:0] _T_260; //@ demo_utils_ecc.py:56
    wire  _T_261; //@ demo_utils_ecc.py:59
    wire [71:0] _T_262; //@ demo_utils_ecc.py:59
    wire [71:0] _T_263; //@ demo_utils_ecc.py:59
    wire  _T_264; //@ demo_utils_ecc.py:59
    wire [71:0] _T_265; //@ demo_utils_ecc.py:59
    wire [71:0] _T_266; //@ demo_utils_ecc.py:59
    wire [71:0] _T_267; //@ demo_utils_ecc.py:59
    wire  _T_268; //@ demo_utils_ecc.py:59
    wire [71:0] _T_269; //@ demo_utils_ecc.py:59
    wire [71:0] _T_270; //@ demo_utils_ecc.py:59
    wire [71:0] _T_271; //@ demo_utils_ecc.py:59
    wire  _T_272; //@ demo_utils_ecc.py:59
    wire [71:0] _T_273; //@ demo_utils_ecc.py:59
    wire [71:0] _T_274; //@ demo_utils_ecc.py:59
    wire [71:0] _T_275; //@ demo_utils_ecc.py:59
    wire  _T_276; //@ demo_utils_ecc.py:59
    wire [71:0] _T_277; //@ demo_utils_ecc.py:59
    wire [71:0] _T_278; //@ demo_utils_ecc.py:59
    wire [71:0] _T_279; //@ demo_utils_ecc.py:59
    wire  _T_280; //@ demo_utils_ecc.py:59
    wire [71:0] _T_281; //@ demo_utils_ecc.py:59
    wire [71:0] _T_282; //@ demo_utils_ecc.py:59
    wire [71:0] _T_283; //@ demo_utils_ecc.py:59
    wire  _T_284; //@ demo_utils_ecc.py:59
    wire [71:0] _T_285; //@ demo_utils_ecc.py:59
    wire [71:0] _T_286; //@ demo_utils_ecc.py:59
    wire [71:0] _T_287; //@ demo_utils_ecc.py:59
    wire  _T_288; //@ demo_utils_ecc.py:59
    wire [71:0] _T_289; //@ demo_utils_ecc.py:59
    wire [71:0] _T_290; //@ demo_utils_ecc.py:59
    wire [71:0] _T_291; //@ demo_utils_ecc.py:59
    wire  _T_292; //@ demo_utils_ecc.py:59
    wire [71:0] _T_293; //@ demo_utils_ecc.py:59
    wire [71:0] _T_294; //@ demo_utils_ecc.py:59
    wire [71:0] _T_295; //@ demo_utils_ecc.py:59
    wire  _T_296; //@ demo_utils_ecc.py:59
    wire [71:0] _T_297; //@ demo_utils_ecc.py:59
    wire [71:0] _T_298; //@ demo_utils_ecc.py:59
    wire [71:0] _T_299; //@ demo_utils_ecc.py:59
    wire  _T_300; //@ demo_utils_ecc.py:59
    wire [71:0] _T_301; //@ demo_utils_ecc.py:59
    wire [71:0] _T_302; //@ demo_utils_ecc.py:59
    wire [71:0] _T_303; //@ demo_utils_ecc.py:59
    wire  _T_304; //@ demo_utils_ecc.py:59
    wire [71:0] _T_305; //@ demo_utils_ecc.py:59
    wire [71:0] _T_306; //@ demo_utils_ecc.py:59
    wire [71:0] _T_307; //@ demo_utils_ecc.py:59
    wire  _T_308; //@ demo_utils_ecc.py:59
    wire [71:0] _T_309; //@ demo_utils_ecc.py:59
    wire [71:0] _T_310; //@ demo_utils_ecc.py:59
    wire [71:0] _T_311; //@ demo_utils_ecc.py:59
    wire  _T_312; //@ demo_utils_ecc.py:59
    wire [71:0] _T_313; //@ demo_utils_ecc.py:59
    wire [71:0] _T_314; //@ demo_utils_ecc.py:59
    wire [71:0] _T_315; //@ demo_utils_ecc.py:59
    wire  _T_316; //@ demo_utils_ecc.py:59
    wire [71:0] _T_317; //@ demo_utils_ecc.py:59
    wire [71:0] _T_318; //@ demo_utils_ecc.py:59
    wire [71:0] _T_319; //@ demo_utils_ecc.py:59
    wire  _T_320; //@ demo_utils_ecc.py:59
    wire [71:0] _T_321; //@ demo_utils_ecc.py:59
    wire [71:0] _T_322; //@ demo_utils_ecc.py:59
    wire [71:0] _T_323; //@ demo_utils_ecc.py:59
    wire [70:0] _T_324; //@ ecc.py:172
    wire [70:0] _T_325; //@ ecc.py:118
    wire [70:0] _T_326; //@ ecc.py:140
    wire  _T_327; //@ ecc.py:140
    wire [70:0] _T_328; //@ ecc.py:118
    wire [70:0] _T_329; //@ ecc.py:140
    wire  _T_330; //@ ecc.py:140
    wire [70:0] _T_331; //@ ecc.py:118
    wire [70:0] _T_332; //@ ecc.py:140
    wire  _T_333; //@ ecc.py:140
    wire [70:0] _T_334; //@ ecc.py:118
    wire [70:0] _T_335; //@ ecc.py:140
    wire  _T_336; //@ ecc.py:140
    wire [70:0] _T_337; //@ ecc.py:118
    wire [70:0] _T_338; //@ ecc.py:140
    wire  _T_339; //@ ecc.py:140
    wire [70:0] _T_340; //@ ecc.py:118
    wire [70:0] _T_341; //@ ecc.py:140
    wire  _T_342; //@ ecc.py:140
    wire [70:0] _T_343; //@ ecc.py:118
    wire [70:0] _T_344; //@ ecc.py:140
    wire  _T_345; //@ ecc.py:140
    wire [1:0] _T_346; //@ ecc.py:140
    wire [2:0] _T_347; //@ ecc.py:140
    wire [3:0] _T_348; //@ ecc.py:140
    wire [4:0] _T_349; //@ ecc.py:140
    wire [5:0] _T_350; //@ ecc.py:140
    wire [6:0] _T_351; //@ ecc.py:140
    wire  _T_352; //@ ecc.py:142
    wire  _T_353; //@ ecc.py:142
    wire  _T_354; //@ ecc.py:142
    wire  _T_355; //@ ecc.py:142
    wire  _T_356; //@ ecc.py:142
    wire  _T_357; //@ ecc.py:142
    wire  _T_358; //@ ecc.py:142
    wire  _T_359; //@ ecc.py:142
    wire  _T_360; //@ ecc.py:142
    wire  _T_361; //@ ecc.py:142
    wire  _T_362; //@ ecc.py:142
    wire  _T_363; //@ ecc.py:142
    wire  _T_364; //@ ecc.py:142
    wire  _T_365; //@ ecc.py:142
    wire  _T_366; //@ ecc.py:142
    wire  _T_367; //@ ecc.py:142
    wire  _T_368; //@ ecc.py:142
    wire  _T_369; //@ ecc.py:142
    wire  _T_370; //@ ecc.py:142
    wire  _T_371; //@ ecc.py:142
    wire  _T_372; //@ ecc.py:142
    wire  _T_373; //@ ecc.py:142
    wire  _T_374; //@ ecc.py:142
    wire  _T_375; //@ ecc.py:142
    wire  _T_376; //@ ecc.py:142
    wire  _T_377; //@ ecc.py:142
    wire  _T_378; //@ ecc.py:142
    wire  _T_379; //@ ecc.py:142
    wire  _T_380; //@ ecc.py:142
    wire  _T_381; //@ ecc.py:142
    wire  _T_382; //@ ecc.py:142
    wire  _T_383; //@ ecc.py:142
    wire  _T_384; //@ ecc.py:142
    wire  _T_385; //@ ecc.py:142
    wire  _T_386; //@ ecc.py:142
    wire  _T_387; //@ ecc.py:142
    wire  _T_388; //@ ecc.py:142
    wire  _T_389; //@ ecc.py:142
    wire  _T_390; //@ ecc.py:142
    wire  _T_391; //@ ecc.py:142
    wire  _T_392; //@ ecc.py:142
    wire  _T_393; //@ ecc.py:142
    wire  _T_394; //@ ecc.py:142
    wire  _T_395; //@ ecc.py:142
    wire  _T_396; //@ ecc.py:142
    wire  _T_397; //@ ecc.py:142
    wire  _T_398; //@ ecc.py:142
    wire  _T_399; //@ ecc.py:142
    wire  _T_400; //@ ecc.py:142
    wire  _T_401; //@ ecc.py:142
    wire  _T_402; //@ ecc.py:142
    wire  _T_403; //@ ecc.py:142
    wire  _T_404; //@ ecc.py:142
    wire  _T_405; //@ ecc.py:142
    wire  _T_406; //@ ecc.py:142
    wire  _T_407; //@ ecc.py:142
    wire  _T_408; //@ ecc.py:142
    wire  _T_409; //@ ecc.py:142
    wire  _T_410; //@ ecc.py:142
    wire  _T_411; //@ ecc.py:142
    wire  _T_412; //@ ecc.py:142
    wire  _T_413; //@ ecc.py:142
    wire  _T_414; //@ ecc.py:142
    wire  _T_415; //@ ecc.py:142
    wire  _T_416; //@ ecc.py:142
    wire  _T_417; //@ ecc.py:142
    wire  _T_418; //@ ecc.py:142
    wire  _T_419; //@ ecc.py:142
    wire  _T_420; //@ ecc.py:142
    wire  _T_421; //@ ecc.py:142
    wire  _T_422; //@ ecc.py:142
    wire  _T_423; //@ ecc.py:142
    wire [1:0] _T_424; //@ ecc.py:142
    wire [2:0] _T_425; //@ ecc.py:142
    wire [3:0] _T_426; //@ ecc.py:142
    wire [4:0] _T_427; //@ ecc.py:142
    wire [5:0] _T_428; //@ ecc.py:142
    wire [6:0] _T_429; //@ ecc.py:142
    wire [7:0] _T_430; //@ ecc.py:142
    wire [8:0] _T_431; //@ ecc.py:142
    wire [9:0] _T_432; //@ ecc.py:142
    wire [10:0] _T_433; //@ ecc.py:142
    wire [11:0] _T_434; //@ ecc.py:142
    wire [12:0] _T_435; //@ ecc.py:142
    wire [13:0] _T_436; //@ ecc.py:142
    wire [14:0] _T_437; //@ ecc.py:142
    wire [15:0] _T_438; //@ ecc.py:142
    wire [16:0] _T_439; //@ ecc.py:142
    wire [17:0] _T_440; //@ ecc.py:142
    wire [18:0] _T_441; //@ ecc.py:142
    wire [19:0] _T_442; //@ ecc.py:142
    wire [20:0] _T_443; //@ ecc.py:142
    wire [21:0] _T_444; //@ ecc.py:142
    wire [22:0] _T_445; //@ ecc.py:142
    wire [23:0] _T_446; //@ ecc.py:142
    wire [24:0] _T_447; //@ ecc.py:142
    wire [25:0] _T_448; //@ ecc.py:142
    wire [26:0] _T_449; //@ ecc.py:142
    wire [27:0] _T_450; //@ ecc.py:142
    wire [28:0] _T_451; //@ ecc.py:142
    wire [29:0] _T_452; //@ ecc.py:142
    wire [30:0] _T_453; //@ ecc.py:142
    wire [31:0] _T_454; //@ ecc.py:142
    wire [32:0] _T_455; //@ ecc.py:142
    wire [33:0] _T_456; //@ ecc.py:142
    wire [34:0] _T_457; //@ ecc.py:142
    wire [35:0] _T_458; //@ ecc.py:142
    wire [36:0] _T_459; //@ ecc.py:142
    wire [37:0] _T_460; //@ ecc.py:142
    wire [38:0] _T_461; //@ ecc.py:142
    wire [39:0] _T_462; //@ ecc.py:142
    wire [40:0] _T_463; //@ ecc.py:142
    wire [41:0] _T_464; //@ ecc.py:142
    wire [42:0] _T_465; //@ ecc.py:142
    wire [43:0] _T_466; //@ ecc.py:142
    wire [44:0] _T_467; //@ ecc.py:142
    wire [45:0] _T_468; //@ ecc.py:142
    wire [46:0] _T_469; //@ ecc.py:142
    wire [47:0] _T_470; //@ ecc.py:142
    wire [48:0] _T_471; //@ ecc.py:142
    wire [49:0] _T_472; //@ ecc.py:142
    wire [50:0] _T_473; //@ ecc.py:142
    wire [51:0] _T_474; //@ ecc.py:142
    wire [52:0] _T_475; //@ ecc.py:142
    wire [53:0] _T_476; //@ ecc.py:142
    wire [54:0] _T_477; //@ ecc.py:142
    wire [55:0] _T_478; //@ ecc.py:142
    wire [56:0] _T_479; //@ ecc.py:142
    wire [57:0] _T_480; //@ ecc.py:142
    wire [58:0] _T_481; //@ ecc.py:142
    wire [59:0] _T_482; //@ ecc.py:142
    wire [60:0] _T_483; //@ ecc.py:142
    wire [61:0] _T_484; //@ ecc.py:142
    wire [62:0] _T_485; //@ ecc.py:142
    wire [63:0] _T_486; //@ ecc.py:142
    wire [64:0] _T_487; //@ ecc.py:142
    wire [65:0] _T_488; //@ ecc.py:142
    wire [66:0] _T_489; //@ ecc.py:142
    wire [67:0] _T_490; //@ ecc.py:142
    wire [68:0] _T_491; //@ ecc.py:142
    wire [69:0] _T_492; //@ ecc.py:142
    wire [70:0] _T_493; //@ ecc.py:142
    wire [71:0] _T_494; //@ ecc.py:142
    wire  _T_495; //@ ecc.py:143
    wire  _T_496; //@ ecc.py:143
    wire  _T_497; //@ ecc.py:143
    wire  _T_498; //@ ecc.py:143
    wire  _T_499; //@ ecc.py:143
    wire  _T_500; //@ ecc.py:143
    wire  _T_501; //@ ecc.py:143
    wire  _T_502; //@ ecc.py:143
    wire  _T_503; //@ ecc.py:143
    wire  _T_504; //@ ecc.py:143
    wire  _T_505; //@ ecc.py:143
    wire  _T_506; //@ ecc.py:143
    wire  _T_507; //@ ecc.py:143
    wire  _T_508; //@ ecc.py:143
    wire  _T_509; //@ ecc.py:143
    wire  _T_510; //@ ecc.py:143
    wire  _T_511; //@ ecc.py:143
    wire  _T_512; //@ ecc.py:143
    wire  _T_513; //@ ecc.py:143
    wire  _T_514; //@ ecc.py:143
    wire  _T_515; //@ ecc.py:143
    wire  _T_516; //@ ecc.py:143
    wire  _T_517; //@ ecc.py:143
    wire  _T_518; //@ ecc.py:143
    wire  _T_519; //@ ecc.py:143
    wire  _T_520; //@ ecc.py:143
    wire  _T_521; //@ ecc.py:143
    wire  _T_522; //@ ecc.py:143
    wire  _T_523; //@ ecc.py:143
    wire  _T_524; //@ ecc.py:143
    wire  _T_525; //@ ecc.py:143
    wire  _T_526; //@ ecc.py:143
    wire  _T_527; //@ ecc.py:143
    wire  _T_528; //@ ecc.py:143
    wire  _T_529; //@ ecc.py:143
    wire  _T_530; //@ ecc.py:143
    wire  _T_531; //@ ecc.py:143
    wire  _T_532; //@ ecc.py:143
    wire  _T_533; //@ ecc.py:143
    wire  _T_534; //@ ecc.py:143
    wire  _T_535; //@ ecc.py:143
    wire  _T_536; //@ ecc.py:143
    wire  _T_537; //@ ecc.py:143
    wire  _T_538; //@ ecc.py:143
    wire  _T_539; //@ ecc.py:143
    wire  _T_540; //@ ecc.py:143
    wire  _T_541; //@ ecc.py:143
    wire  _T_542; //@ ecc.py:143
    wire  _T_543; //@ ecc.py:143
    wire  _T_544; //@ ecc.py:143
    wire  _T_545; //@ ecc.py:143
    wire  _T_546; //@ ecc.py:143
    wire  _T_547; //@ ecc.py:143
    wire  _T_548; //@ ecc.py:143
    wire  _T_549; //@ ecc.py:143
    wire  _T_550; //@ ecc.py:143
    wire  _T_551; //@ ecc.py:143
    wire  _T_552; //@ ecc.py:143
    wire  _T_553; //@ ecc.py:143
    wire  _T_554; //@ ecc.py:143
    wire  _T_555; //@ ecc.py:143
    wire  _T_556; //@ ecc.py:143
    wire  _T_557; //@ ecc.py:143
    wire  _T_558; //@ ecc.py:143
    wire [1:0] _T_559; //@ ecc.py:143
    wire [2:0] _T_560; //@ ecc.py:143
    wire [3:0] _T_561; //@ ecc.py:143
    wire [4:0] _T_562; //@ ecc.py:143
    wire [5:0] _T_563; //@ ecc.py:143
    wire [6:0] _T_564; //@ ecc.py:143
    wire [7:0] _T_565; //@ ecc.py:143
    wire [8:0] _T_566; //@ ecc.py:143
    wire [9:0] _T_567; //@ ecc.py:143
    wire [10:0] _T_568; //@ ecc.py:143
    wire [11:0] _T_569; //@ ecc.py:143
    wire [12:0] _T_570; //@ ecc.py:143
    wire [13:0] _T_571; //@ ecc.py:143
    wire [14:0] _T_572; //@ ecc.py:143
    wire [15:0] _T_573; //@ ecc.py:143
    wire [16:0] _T_574; //@ ecc.py:143
    wire [17:0] _T_575; //@ ecc.py:143
    wire [18:0] _T_576; //@ ecc.py:143
    wire [19:0] _T_577; //@ ecc.py:143
    wire [20:0] _T_578; //@ ecc.py:143
    wire [21:0] _T_579; //@ ecc.py:143
    wire [22:0] _T_580; //@ ecc.py:143
    wire [23:0] _T_581; //@ ecc.py:143
    wire [24:0] _T_582; //@ ecc.py:143
    wire [25:0] _T_583; //@ ecc.py:143
    wire [26:0] _T_584; //@ ecc.py:143
    wire [27:0] _T_585; //@ ecc.py:143
    wire [28:0] _T_586; //@ ecc.py:143
    wire [29:0] _T_587; //@ ecc.py:143
    wire [30:0] _T_588; //@ ecc.py:143
    wire [31:0] _T_589; //@ ecc.py:143
    wire [32:0] _T_590; //@ ecc.py:143
    wire [33:0] _T_591; //@ ecc.py:143
    wire [34:0] _T_592; //@ ecc.py:143
    wire [35:0] _T_593; //@ ecc.py:143
    wire [36:0] _T_594; //@ ecc.py:143
    wire [37:0] _T_595; //@ ecc.py:143
    wire [38:0] _T_596; //@ ecc.py:143
    wire [39:0] _T_597; //@ ecc.py:143
    wire [40:0] _T_598; //@ ecc.py:143
    wire [41:0] _T_599; //@ ecc.py:143
    wire [42:0] _T_600; //@ ecc.py:143
    wire [43:0] _T_601; //@ ecc.py:143
    wire [44:0] _T_602; //@ ecc.py:143
    wire [45:0] _T_603; //@ ecc.py:143
    wire [46:0] _T_604; //@ ecc.py:143
    wire [47:0] _T_605; //@ ecc.py:143
    wire [48:0] _T_606; //@ ecc.py:143
    wire [49:0] _T_607; //@ ecc.py:143
    wire [50:0] _T_608; //@ ecc.py:143
    wire [51:0] _T_609; //@ ecc.py:143
    wire [52:0] _T_610; //@ ecc.py:143
    wire [53:0] _T_611; //@ ecc.py:143
    wire [54:0] _T_612; //@ ecc.py:143
    wire [55:0] _T_613; //@ ecc.py:143
    wire [56:0] _T_614; //@ ecc.py:143
    wire [57:0] _T_615; //@ ecc.py:143
    wire [58:0] _T_616; //@ ecc.py:143
    wire [59:0] _T_617; //@ ecc.py:143
    wire [60:0] _T_618; //@ ecc.py:143
    wire [61:0] _T_619; //@ ecc.py:143
    wire [62:0] _T_620; //@ ecc.py:143
    wire [63:0] _T_621; //@ ecc.py:143
    wire [63:0] _T_622_pre_correct; //@ ecc.py:13
    wire [63:0] _T_622_post_correct; //@ ecc.py:14
    wire  _T_622_correctable; //@ ecc.py:15
    wire  _T_622_uncorrectable; //@ ecc.py:16
    wire [63:0] _T_623; //@ ecc.py:146
    wire [63:0] _T_624; //@ ecc.py:147
    wire  _T_625; //@ ecc.py:148
    wire  _T_626; //@ ecc.py:149
    wire [71:0] _T_627_pre_correct; //@ ecc.py:13
    wire [71:0] _T_627_post_correct; //@ ecc.py:14
    wire  _T_627_correctable; //@ ecc.py:15
    wire  _T_627_uncorrectable; //@ ecc.py:16
    wire [70:0] _T_628; //@ ecc.py:73
    wire  _T_629; //@ ecc.py:75
    wire  _T_630; //@ ecc.py:76
    wire [63:0] _T_631_pre_correct; //@ ecc.py:13
    wire [63:0] _T_631_post_correct; //@ ecc.py:14
    wire  _T_631_correctable; //@ ecc.py:15
    wire  _T_631_uncorrectable; //@ ecc.py:16
    wire  _T_632; //@ ecc.py:179
    wire  _T_633; //@ ecc.py:179
    wire [63:0] _T_634; //@ demo_utils_ecc.py:61
    wire [63:0] _T_635; //@ demo_utils_ecc.py:61
    wire [63:0] _T_636; //@ demo_utils_ecc.py:62
    wire [63:0] _T_637; //@ demo_utils_ecc.py:62
    wire  _T_638; //@ ecc.py:18
    wire  _T_639; //@ demo_utils_ecc.py:63
    wire  _T_640; //@ demo_utils_ecc.py:63
    wire  _T_641; //@ demo_utils_ecc.py:64
    wire  _T_642; //@ demo_utils_ecc.py:64
    always @(posedge clock) //@ demo_utils_ecc.py:24
        mem_parity_0_o <= mem_parity_0_i;
    always @(posedge clock) //@ demo_utils_ecc.py:24
        mem_parity_1_o <= mem_parity_1_i;
    always @(posedge clock) //@ demo_utils_ecc.py:24
        mem_parity_2_o <= mem_parity_2_i;
    always @(posedge clock) //@ demo_utils_ecc.py:24
        mem_parity_3_o <= mem_parity_3_i;
    always @(posedge clock) //@ demo_utils_ecc.py:24
        mem_parity_4_o <= mem_parity_4_i;
    always @(posedge clock) //@ demo_utils_ecc.py:24
        mem_parity_5_o <= mem_parity_5_i;
    always @(posedge clock) //@ demo_utils_ecc.py:24
        mem_parity_6_o <= mem_parity_6_i;
    always @(posedge clock) //@ demo_utils_ecc.py:24
        mem_parity_7_o <= mem_parity_7_i;
    always @(posedge clock) //@ demo_utils_ecc.py:24
        mem_parity_8_o <= mem_parity_8_i;
    always @(posedge clock) //@ demo_utils_ecc.py:24
        mem_parity_9_o <= mem_parity_9_i;
    always @(posedge clock) //@ demo_utils_ecc.py:24
        mem_parity_10_o <= mem_parity_10_i;
    always @(posedge clock) //@ demo_utils_ecc.py:24
        mem_parity_11_o <= mem_parity_11_i;
    always @(posedge clock) //@ demo_utils_ecc.py:24
        mem_parity_12_o <= mem_parity_12_i;
    always @(posedge clock) //@ demo_utils_ecc.py:24
        mem_parity_13_o <= mem_parity_13_i;
    always @(posedge clock) //@ demo_utils_ecc.py:24
        mem_parity_14_o <= mem_parity_14_i;
    always @(posedge clock) //@ demo_utils_ecc.py:24
        mem_parity_15_o <= mem_parity_15_i;
    always @(posedge clock) //@ demo_utils_ecc.py:25
        parity_out_data_pre_correct_o <= parity_out_data_pre_correct_i;
    always @(posedge clock) //@ demo_utils_ecc.py:26
        parity_out_data_post_correct_o <= parity_out_data_post_correct_i;
    always @(posedge clock) //@ demo_utils_ecc.py:27
        parity_out_error_o <= parity_out_error_i;
    always @(posedge clock) //@ demo_utils_ecc.py:28
        parity_out_error_uncorrectable_o <= parity_out_error_uncorrectable_i;
    always @(posedge clock) //@ demo_utils_ecc.py:47
        mem_ecc_0_o <= mem_ecc_0_i;
    always @(posedge clock) //@ demo_utils_ecc.py:47
        mem_ecc_1_o <= mem_ecc_1_i;
    always @(posedge clock) //@ demo_utils_ecc.py:47
        mem_ecc_2_o <= mem_ecc_2_i;
    always @(posedge clock) //@ demo_utils_ecc.py:47
        mem_ecc_3_o <= mem_ecc_3_i;
    always @(posedge clock) //@ demo_utils_ecc.py:47
        mem_ecc_4_o <= mem_ecc_4_i;
    always @(posedge clock) //@ demo_utils_ecc.py:47
        mem_ecc_5_o <= mem_ecc_5_i;
    always @(posedge clock) //@ demo_utils_ecc.py:47
        mem_ecc_6_o <= mem_ecc_6_i;
    always @(posedge clock) //@ demo_utils_ecc.py:47
        mem_ecc_7_o <= mem_ecc_7_i;
    always @(posedge clock) //@ demo_utils_ecc.py:47
        mem_ecc_8_o <= mem_ecc_8_i;
    always @(posedge clock) //@ demo_utils_ecc.py:47
        mem_ecc_9_o <= mem_ecc_9_i;
    always @(posedge clock) //@ demo_utils_ecc.py:47
        mem_ecc_10_o <= mem_ecc_10_i;
    always @(posedge clock) //@ demo_utils_ecc.py:47
        mem_ecc_11_o <= mem_ecc_11_i;
    always @(posedge clock) //@ demo_utils_ecc.py:47
        mem_ecc_12_o <= mem_ecc_12_i;
    always @(posedge clock) //@ demo_utils_ecc.py:47
        mem_ecc_13_o <= mem_ecc_13_i;
    always @(posedge clock) //@ demo_utils_ecc.py:47
        mem_ecc_14_o <= mem_ecc_14_i;
    always @(posedge clock) //@ demo_utils_ecc.py:47
        mem_ecc_15_o <= mem_ecc_15_i;
    always @(posedge clock) //@ demo_utils_ecc.py:48
        ecc_out_data_pre_correct_o <= ecc_out_data_pre_correct_i;
    always @(posedge clock) //@ demo_utils_ecc.py:49
        ecc_out_data_post_correct_o <= ecc_out_data_post_correct_i;
    always @(posedge clock) //@ demo_utils_ecc.py:50
        ecc_out_error_o <= ecc_out_error_i;
    always @(posedge clock) //@ demo_utils_ecc.py:51
        ecc_out_error_uncorrectable_o <= ecc_out_error_uncorrectable_i;
    assign _T_1 = ^io_sram_ctrl_write_data; //@ ecc.py:68
    assign _T_2 = (_T_1 ^ 1'h0); //@ ecc.py:68
    assign _T_3 = {_T_2, io_sram_ctrl_write_data}; //@ ecc.py:68
    assign _T_4 = (io_sram_ctrl_address == 4'h0); //@ demo_utils_ecc.py:33
    assign _T_6 = (io_sram_ctrl_write_en & _T_4); //@ demo_utils_ecc.py:33
    assign _T_7 = (_T_6 ? _T_3 : mem_parity_0_o); //@ demo_utils_ecc.py:33
    assign _T_5 = _T_7; //@ demo_utils_ecc.py:33
    assign mem_parity_0_i = _T_5; //@ demo_utils_ecc.py:33
    assign _T_8 = (io_sram_ctrl_address == 4'h1); //@ demo_utils_ecc.py:33
    assign _T_10 = (io_sram_ctrl_write_en & _T_8); //@ demo_utils_ecc.py:33
    assign _T_11 = (_T_10 ? _T_3 : mem_parity_1_o); //@ demo_utils_ecc.py:33
    assign _T_9 = _T_11; //@ demo_utils_ecc.py:33
    assign mem_parity_1_i = _T_9; //@ demo_utils_ecc.py:33
    assign _T_12 = (io_sram_ctrl_address == 4'h2); //@ demo_utils_ecc.py:33
    assign _T_14 = (io_sram_ctrl_write_en & _T_12); //@ demo_utils_ecc.py:33
    assign _T_15 = (_T_14 ? _T_3 : mem_parity_2_o); //@ demo_utils_ecc.py:33
    assign _T_13 = _T_15; //@ demo_utils_ecc.py:33
    assign mem_parity_2_i = _T_13; //@ demo_utils_ecc.py:33
    assign _T_16 = (io_sram_ctrl_address == 4'h3); //@ demo_utils_ecc.py:33
    assign _T_18 = (io_sram_ctrl_write_en & _T_16); //@ demo_utils_ecc.py:33
    assign _T_19 = (_T_18 ? _T_3 : mem_parity_3_o); //@ demo_utils_ecc.py:33
    assign _T_17 = _T_19; //@ demo_utils_ecc.py:33
    assign mem_parity_3_i = _T_17; //@ demo_utils_ecc.py:33
    assign _T_20 = (io_sram_ctrl_address == 4'h4); //@ demo_utils_ecc.py:33
    assign _T_22 = (io_sram_ctrl_write_en & _T_20); //@ demo_utils_ecc.py:33
    assign _T_23 = (_T_22 ? _T_3 : mem_parity_4_o); //@ demo_utils_ecc.py:33
    assign _T_21 = _T_23; //@ demo_utils_ecc.py:33
    assign mem_parity_4_i = _T_21; //@ demo_utils_ecc.py:33
    assign _T_24 = (io_sram_ctrl_address == 4'h5); //@ demo_utils_ecc.py:33
    assign _T_26 = (io_sram_ctrl_write_en & _T_24); //@ demo_utils_ecc.py:33
    assign _T_27 = (_T_26 ? _T_3 : mem_parity_5_o); //@ demo_utils_ecc.py:33
    assign _T_25 = _T_27; //@ demo_utils_ecc.py:33
    assign mem_parity_5_i = _T_25; //@ demo_utils_ecc.py:33
    assign _T_28 = (io_sram_ctrl_address == 4'h6); //@ demo_utils_ecc.py:33
    assign _T_30 = (io_sram_ctrl_write_en & _T_28); //@ demo_utils_ecc.py:33
    assign _T_31 = (_T_30 ? _T_3 : mem_parity_6_o); //@ demo_utils_ecc.py:33
    assign _T_29 = _T_31; //@ demo_utils_ecc.py:33
    assign mem_parity_6_i = _T_29; //@ demo_utils_ecc.py:33
    assign _T_32 = (io_sram_ctrl_address == 4'h7); //@ demo_utils_ecc.py:33
    assign _T_34 = (io_sram_ctrl_write_en & _T_32); //@ demo_utils_ecc.py:33
    assign _T_35 = (_T_34 ? _T_3 : mem_parity_7_o); //@ demo_utils_ecc.py:33
    assign _T_33 = _T_35; //@ demo_utils_ecc.py:33
    assign mem_parity_7_i = _T_33; //@ demo_utils_ecc.py:33
    assign _T_36 = (io_sram_ctrl_address == 4'h8); //@ demo_utils_ecc.py:33
    assign _T_38 = (io_sram_ctrl_write_en & _T_36); //@ demo_utils_ecc.py:33
    assign _T_39 = (_T_38 ? _T_3 : mem_parity_8_o); //@ demo_utils_ecc.py:33
    assign _T_37 = _T_39; //@ demo_utils_ecc.py:33
    assign mem_parity_8_i = _T_37; //@ demo_utils_ecc.py:33
    assign _T_40 = (io_sram_ctrl_address == 4'h9); //@ demo_utils_ecc.py:33
    assign _T_42 = (io_sram_ctrl_write_en & _T_40); //@ demo_utils_ecc.py:33
    assign _T_43 = (_T_42 ? _T_3 : mem_parity_9_o); //@ demo_utils_ecc.py:33
    assign _T_41 = _T_43; //@ demo_utils_ecc.py:33
    assign mem_parity_9_i = _T_41; //@ demo_utils_ecc.py:33
    assign _T_44 = (io_sram_ctrl_address == 4'ha); //@ demo_utils_ecc.py:33
    assign _T_46 = (io_sram_ctrl_write_en & _T_44); //@ demo_utils_ecc.py:33
    assign _T_47 = (_T_46 ? _T_3 : mem_parity_10_o); //@ demo_utils_ecc.py:33
    assign _T_45 = _T_47; //@ demo_utils_ecc.py:33
    assign mem_parity_10_i = _T_45; //@ demo_utils_ecc.py:33
    assign _T_48 = (io_sram_ctrl_address == 4'hb); //@ demo_utils_ecc.py:33
    assign _T_50 = (io_sram_ctrl_write_en & _T_48); //@ demo_utils_ecc.py:33
    assign _T_51 = (_T_50 ? _T_3 : mem_parity_11_o); //@ demo_utils_ecc.py:33
    assign _T_49 = _T_51; //@ demo_utils_ecc.py:33
    assign mem_parity_11_i = _T_49; //@ demo_utils_ecc.py:33
    assign _T_52 = (io_sram_ctrl_address == 4'hc); //@ demo_utils_ecc.py:33
    assign _T_54 = (io_sram_ctrl_write_en & _T_52); //@ demo_utils_ecc.py:33
    assign _T_55 = (_T_54 ? _T_3 : mem_parity_12_o); //@ demo_utils_ecc.py:33
    assign _T_53 = _T_55; //@ demo_utils_ecc.py:33
    assign mem_parity_12_i = _T_53; //@ demo_utils_ecc.py:33
    assign _T_56 = (io_sram_ctrl_address == 4'hd); //@ demo_utils_ecc.py:33
    assign _T_58 = (io_sram_ctrl_write_en & _T_56); //@ demo_utils_ecc.py:33
    assign _T_59 = (_T_58 ? _T_3 : mem_parity_13_o); //@ demo_utils_ecc.py:33
    assign _T_57 = _T_59; //@ demo_utils_ecc.py:33
    assign mem_parity_13_i = _T_57; //@ demo_utils_ecc.py:33
    assign _T_60 = (io_sram_ctrl_address == 4'he); //@ demo_utils_ecc.py:33
    assign _T_62 = (io_sram_ctrl_write_en & _T_60); //@ demo_utils_ecc.py:33
    assign _T_63 = (_T_62 ? _T_3 : mem_parity_14_o); //@ demo_utils_ecc.py:33
    assign _T_61 = _T_63; //@ demo_utils_ecc.py:33
    assign mem_parity_14_i = _T_61; //@ demo_utils_ecc.py:33
    assign _T_64 = (io_sram_ctrl_address == 4'hf); //@ demo_utils_ecc.py:33
    assign _T_66 = (io_sram_ctrl_write_en & _T_64); //@ demo_utils_ecc.py:33
    assign _T_67 = (_T_66 ? _T_3 : mem_parity_15_o); //@ demo_utils_ecc.py:33
    assign _T_65 = _T_67; //@ demo_utils_ecc.py:33
    assign mem_parity_15_i = _T_65; //@ demo_utils_ecc.py:33
    assign _T_68 = (io_sram_ctrl_address == 4'h0); //@ demo_utils_ecc.py:36
    assign _T_69 = {7'h41{_T_68}}; //@ demo_utils_ecc.py:36
    assign _T_70 = (_T_69 & mem_parity_0_o); //@ demo_utils_ecc.py:36
    assign _T_71 = (io_sram_ctrl_address == 4'h1); //@ demo_utils_ecc.py:36
    assign _T_72 = {7'h41{_T_71}}; //@ demo_utils_ecc.py:36
    assign _T_73 = (_T_72 & mem_parity_1_o); //@ demo_utils_ecc.py:36
    assign _T_74 = (_T_70 | _T_73); //@ demo_utils_ecc.py:36
    assign _T_75 = (io_sram_ctrl_address == 4'h2); //@ demo_utils_ecc.py:36
    assign _T_76 = {7'h41{_T_75}}; //@ demo_utils_ecc.py:36
    assign _T_77 = (_T_76 & mem_parity_2_o); //@ demo_utils_ecc.py:36
    assign _T_78 = (_T_74 | _T_77); //@ demo_utils_ecc.py:36
    assign _T_79 = (io_sram_ctrl_address == 4'h3); //@ demo_utils_ecc.py:36
    assign _T_80 = {7'h41{_T_79}}; //@ demo_utils_ecc.py:36
    assign _T_81 = (_T_80 & mem_parity_3_o); //@ demo_utils_ecc.py:36
    assign _T_82 = (_T_78 | _T_81); //@ demo_utils_ecc.py:36
    assign _T_83 = (io_sram_ctrl_address == 4'h4); //@ demo_utils_ecc.py:36
    assign _T_84 = {7'h41{_T_83}}; //@ demo_utils_ecc.py:36
    assign _T_85 = (_T_84 & mem_parity_4_o); //@ demo_utils_ecc.py:36
    assign _T_86 = (_T_82 | _T_85); //@ demo_utils_ecc.py:36
    assign _T_87 = (io_sram_ctrl_address == 4'h5); //@ demo_utils_ecc.py:36
    assign _T_88 = {7'h41{_T_87}}; //@ demo_utils_ecc.py:36
    assign _T_89 = (_T_88 & mem_parity_5_o); //@ demo_utils_ecc.py:36
    assign _T_90 = (_T_86 | _T_89); //@ demo_utils_ecc.py:36
    assign _T_91 = (io_sram_ctrl_address == 4'h6); //@ demo_utils_ecc.py:36
    assign _T_92 = {7'h41{_T_91}}; //@ demo_utils_ecc.py:36
    assign _T_93 = (_T_92 & mem_parity_6_o); //@ demo_utils_ecc.py:36
    assign _T_94 = (_T_90 | _T_93); //@ demo_utils_ecc.py:36
    assign _T_95 = (io_sram_ctrl_address == 4'h7); //@ demo_utils_ecc.py:36
    assign _T_96 = {7'h41{_T_95}}; //@ demo_utils_ecc.py:36
    assign _T_97 = (_T_96 & mem_parity_7_o); //@ demo_utils_ecc.py:36
    assign _T_98 = (_T_94 | _T_97); //@ demo_utils_ecc.py:36
    assign _T_99 = (io_sram_ctrl_address == 4'h8); //@ demo_utils_ecc.py:36
    assign _T_100 = {7'h41{_T_99}}; //@ demo_utils_ecc.py:36
    assign _T_101 = (_T_100 & mem_parity_8_o); //@ demo_utils_ecc.py:36
    assign _T_102 = (_T_98 | _T_101); //@ demo_utils_ecc.py:36
    assign _T_103 = (io_sram_ctrl_address == 4'h9); //@ demo_utils_ecc.py:36
    assign _T_104 = {7'h41{_T_103}}; //@ demo_utils_ecc.py:36
    assign _T_105 = (_T_104 & mem_parity_9_o); //@ demo_utils_ecc.py:36
    assign _T_106 = (_T_102 | _T_105); //@ demo_utils_ecc.py:36
    assign _T_107 = (io_sram_ctrl_address == 4'ha); //@ demo_utils_ecc.py:36
    assign _T_108 = {7'h41{_T_107}}; //@ demo_utils_ecc.py:36
    assign _T_109 = (_T_108 & mem_parity_10_o); //@ demo_utils_ecc.py:36
    assign _T_110 = (_T_106 | _T_109); //@ demo_utils_ecc.py:36
    assign _T_111 = (io_sram_ctrl_address == 4'hb); //@ demo_utils_ecc.py:36
    assign _T_112 = {7'h41{_T_111}}; //@ demo_utils_ecc.py:36
    assign _T_113 = (_T_112 & mem_parity_11_o); //@ demo_utils_ecc.py:36
    assign _T_114 = (_T_110 | _T_113); //@ demo_utils_ecc.py:36
    assign _T_115 = (io_sram_ctrl_address == 4'hc); //@ demo_utils_ecc.py:36
    assign _T_116 = {7'h41{_T_115}}; //@ demo_utils_ecc.py:36
    assign _T_117 = (_T_116 & mem_parity_12_o); //@ demo_utils_ecc.py:36
    assign _T_118 = (_T_114 | _T_117); //@ demo_utils_ecc.py:36
    assign _T_119 = (io_sram_ctrl_address == 4'hd); //@ demo_utils_ecc.py:36
    assign _T_120 = {7'h41{_T_119}}; //@ demo_utils_ecc.py:36
    assign _T_121 = (_T_120 & mem_parity_13_o); //@ demo_utils_ecc.py:36
    assign _T_122 = (_T_118 | _T_121); //@ demo_utils_ecc.py:36
    assign _T_123 = (io_sram_ctrl_address == 4'he); //@ demo_utils_ecc.py:36
    assign _T_124 = {7'h41{_T_123}}; //@ demo_utils_ecc.py:36
    assign _T_125 = (_T_124 & mem_parity_14_o); //@ demo_utils_ecc.py:36
    assign _T_126 = (_T_122 | _T_125); //@ demo_utils_ecc.py:36
    assign _T_127 = (io_sram_ctrl_address == 4'hf); //@ demo_utils_ecc.py:36
    assign _T_128 = {7'h41{_T_127}}; //@ demo_utils_ecc.py:36
    assign _T_129 = (_T_128 & mem_parity_15_o); //@ demo_utils_ecc.py:36
    assign _T_130 = (_T_126 | _T_129); //@ demo_utils_ecc.py:36
    assign _T_132 = _T_130[63:0]; //@ ecc.py:73
    assign _T_131_pre_correct = _T_132; //@ ecc.py:73
    assign _T_131_post_correct = _T_131_pre_correct; //@ ecc.py:74
    assign _T_133 = 1'h0; //@ ecc.py:75
    assign _T_131_correctable = _T_133; //@ ecc.py:75
    assign _T_134 = ^_T_130; //@ ecc.py:76
    assign _T_131_uncorrectable = _T_134; //@ ecc.py:76
    assign _T_136 = (io_sram_ctrl_read_en ? _T_131_pre_correct : parity_out_data_pre_correct_o); //@ demo_utils_ecc.py:38
    assign _T_138 = _T_136[63:0]; //@ demo_utils_ecc.py:38
    assign _T_137 = _T_138; //@ demo_utils_ecc.py:38
    assign _T_135 = _T_137; //@ demo_utils_ecc.py:38
    assign parity_out_data_pre_correct_i = _T_135; //@ demo_utils_ecc.py:38
    assign _T_140 = (io_sram_ctrl_read_en ? _T_131_post_correct : parity_out_data_post_correct_o); //@ demo_utils_ecc.py:39
    assign _T_142 = _T_140[63:0]; //@ demo_utils_ecc.py:39
    assign _T_141 = _T_142; //@ demo_utils_ecc.py:39
    assign _T_139 = _T_141; //@ demo_utils_ecc.py:39
    assign parity_out_data_post_correct_i = _T_139; //@ demo_utils_ecc.py:39
    assign _T_143 = (_T_131_correctable | _T_131_uncorrectable); //@ ecc.py:18
    assign _T_145 = (io_sram_ctrl_read_en ? _T_143 : parity_out_error_o); //@ demo_utils_ecc.py:40
    assign _T_144 = _T_145; //@ demo_utils_ecc.py:40
    assign parity_out_error_i = _T_144; //@ demo_utils_ecc.py:40
    assign _T_147 = (io_sram_ctrl_read_en ? _T_131_uncorrectable : parity_out_error_uncorrectable_o); //@ demo_utils_ecc.py:41
    assign _T_146 = _T_147; //@ demo_utils_ecc.py:41
    assign parity_out_error_uncorrectable_i = _T_146; //@ demo_utils_ecc.py:41
    assign _T_149 = {1'h0, 1'h0}; //@ ecc.py:166
    assign _T_150 = (_T_149 << 7'h46); //@ ecc.py:167
    assign _T_151 = 71'h1ab55555556aaad5b; //@ ecc.py:118
    assign _T_152 = _T_151[63:0]; //@ ecc.py:131
    assign _T_153 = (_T_152 & io_sram_ctrl_write_data); //@ ecc.py:131
    assign _T_154 = ^_T_153; //@ ecc.py:131
    assign _T_155 = (_T_154 ^ 1'h0); //@ ecc.py:131
    assign _T_156 = 71'h2cd9999999b33366d; //@ ecc.py:118
    assign _T_157 = _T_156[63:0]; //@ ecc.py:131
    assign _T_158 = (_T_157 & io_sram_ctrl_write_data); //@ ecc.py:131
    assign _T_159 = ^_T_158; //@ ecc.py:131
    assign _T_160 = (_T_159 ^ 1'h0); //@ ecc.py:131
    assign _T_161 = 71'h4f1e1e1e1e3c3c78e; //@ ecc.py:118
    assign _T_162 = _T_161[63:0]; //@ ecc.py:131
    assign _T_163 = (_T_162 & io_sram_ctrl_write_data); //@ ecc.py:131
    assign _T_164 = ^_T_163; //@ ecc.py:131
    assign _T_165 = (_T_164 ^ 1'h0); //@ ecc.py:131
    assign _T_166 = 71'h801fe01fe03fc07f0; //@ ecc.py:118
    assign _T_167 = _T_166[63:0]; //@ ecc.py:131
    assign _T_168 = (_T_167 & io_sram_ctrl_write_data); //@ ecc.py:131
    assign _T_169 = ^_T_168; //@ ecc.py:131
    assign _T_170 = (_T_169 ^ 1'h0); //@ ecc.py:131
    assign _T_171 = 71'h1001fffe0003fff800; //@ ecc.py:118
    assign _T_172 = _T_171[63:0]; //@ ecc.py:131
    assign _T_173 = (_T_172 & io_sram_ctrl_write_data); //@ ecc.py:131
    assign _T_174 = ^_T_173; //@ ecc.py:131
    assign _T_175 = (_T_174 ^ 1'h0); //@ ecc.py:131
    assign _T_176 = 71'h2001fffffffc000000; //@ ecc.py:118
    assign _T_177 = _T_176[63:0]; //@ ecc.py:131
    assign _T_178 = (_T_177 & io_sram_ctrl_write_data); //@ ecc.py:131
    assign _T_179 = ^_T_178; //@ ecc.py:131
    assign _T_180 = (_T_179 ^ 1'h0); //@ ecc.py:131
    assign _T_181 = 71'h40fe00000000000000; //@ ecc.py:118
    assign _T_182 = _T_181[63:0]; //@ ecc.py:131
    assign _T_183 = (_T_182 & io_sram_ctrl_write_data); //@ ecc.py:131
    assign _T_184 = ^_T_183; //@ ecc.py:131
    assign _T_185 = (_T_184 ^ 1'h0); //@ ecc.py:131
    assign _T_186 = {_T_185, _T_180}; //@ ecc.py:132
    assign _T_187 = {_T_186, _T_175}; //@ ecc.py:132
    assign _T_188 = {_T_187, _T_170}; //@ ecc.py:132
    assign _T_189 = {_T_188, _T_165}; //@ ecc.py:132
    assign _T_190 = {_T_189, _T_160}; //@ ecc.py:132
    assign _T_191 = {_T_190, _T_155}; //@ ecc.py:132
    assign _T_192 = {_T_191, io_sram_ctrl_write_data}; //@ ecc.py:133
    assign _T_193 = ^_T_192; //@ ecc.py:68
    assign _T_194 = (_T_193 ^ 1'h0); //@ ecc.py:68
    assign _T_195 = {_T_194, _T_192}; //@ ecc.py:68
    assign _T_196 = (_T_195 ^ _T_150); //@ ecc.py:168
    assign _T_197 = (io_sram_ctrl_address == 4'h0); //@ demo_utils_ecc.py:56
    assign _T_199 = (io_sram_ctrl_write_en & _T_197); //@ demo_utils_ecc.py:56
    assign _T_200 = (_T_199 ? _T_196 : mem_ecc_0_o); //@ demo_utils_ecc.py:56
    assign _T_198 = _T_200; //@ demo_utils_ecc.py:56
    assign mem_ecc_0_i = _T_198; //@ demo_utils_ecc.py:56
    assign _T_201 = (io_sram_ctrl_address == 4'h1); //@ demo_utils_ecc.py:56
    assign _T_203 = (io_sram_ctrl_write_en & _T_201); //@ demo_utils_ecc.py:56
    assign _T_204 = (_T_203 ? _T_196 : mem_ecc_1_o); //@ demo_utils_ecc.py:56
    assign _T_202 = _T_204; //@ demo_utils_ecc.py:56
    assign mem_ecc_1_i = _T_202; //@ demo_utils_ecc.py:56
    assign _T_205 = (io_sram_ctrl_address == 4'h2); //@ demo_utils_ecc.py:56
    assign _T_207 = (io_sram_ctrl_write_en & _T_205); //@ demo_utils_ecc.py:56
    assign _T_208 = (_T_207 ? _T_196 : mem_ecc_2_o); //@ demo_utils_ecc.py:56
    assign _T_206 = _T_208; //@ demo_utils_ecc.py:56
    assign mem_ecc_2_i = _T_206; //@ demo_utils_ecc.py:56
    assign _T_209 = (io_sram_ctrl_address == 4'h3); //@ demo_utils_ecc.py:56
    assign _T_211 = (io_sram_ctrl_write_en & _T_209); //@ demo_utils_ecc.py:56
    assign _T_212 = (_T_211 ? _T_196 : mem_ecc_3_o); //@ demo_utils_ecc.py:56
    assign _T_210 = _T_212; //@ demo_utils_ecc.py:56
    assign mem_ecc_3_i = _T_210; //@ demo_utils_ecc.py:56
    assign _T_213 = (io_sram_ctrl_address == 4'h4); //@ demo_utils_ecc.py:56
    assign _T_215 = (io_sram_ctrl_write_en & _T_213); //@ demo_utils_ecc.py:56
    assign _T_216 = (_T_215 ? _T_196 : mem_ecc_4_o); //@ demo_utils_ecc.py:56
    assign _T_214 = _T_216; //@ demo_utils_ecc.py:56
    assign mem_ecc_4_i = _T_214; //@ demo_utils_ecc.py:56
    assign _T_217 = (io_sram_ctrl_address == 4'h5); //@ demo_utils_ecc.py:56
    assign _T_219 = (io_sram_ctrl_write_en & _T_217); //@ demo_utils_ecc.py:56
    assign _T_220 = (_T_219 ? _T_196 : mem_ecc_5_o); //@ demo_utils_ecc.py:56
    assign _T_218 = _T_220; //@ demo_utils_ecc.py:56
    assign mem_ecc_5_i = _T_218; //@ demo_utils_ecc.py:56
    assign _T_221 = (io_sram_ctrl_address == 4'h6); //@ demo_utils_ecc.py:56
    assign _T_223 = (io_sram_ctrl_write_en & _T_221); //@ demo_utils_ecc.py:56
    assign _T_224 = (_T_223 ? _T_196 : mem_ecc_6_o); //@ demo_utils_ecc.py:56
    assign _T_222 = _T_224; //@ demo_utils_ecc.py:56
    assign mem_ecc_6_i = _T_222; //@ demo_utils_ecc.py:56
    assign _T_225 = (io_sram_ctrl_address == 4'h7); //@ demo_utils_ecc.py:56
    assign _T_227 = (io_sram_ctrl_write_en & _T_225); //@ demo_utils_ecc.py:56
    assign _T_228 = (_T_227 ? _T_196 : mem_ecc_7_o); //@ demo_utils_ecc.py:56
    assign _T_226 = _T_228; //@ demo_utils_ecc.py:56
    assign mem_ecc_7_i = _T_226; //@ demo_utils_ecc.py:56
    assign _T_229 = (io_sram_ctrl_address == 4'h8); //@ demo_utils_ecc.py:56
    assign _T_231 = (io_sram_ctrl_write_en & _T_229); //@ demo_utils_ecc.py:56
    assign _T_232 = (_T_231 ? _T_196 : mem_ecc_8_o); //@ demo_utils_ecc.py:56
    assign _T_230 = _T_232; //@ demo_utils_ecc.py:56
    assign mem_ecc_8_i = _T_230; //@ demo_utils_ecc.py:56
    assign _T_233 = (io_sram_ctrl_address == 4'h9); //@ demo_utils_ecc.py:56
    assign _T_235 = (io_sram_ctrl_write_en & _T_233); //@ demo_utils_ecc.py:56
    assign _T_236 = (_T_235 ? _T_196 : mem_ecc_9_o); //@ demo_utils_ecc.py:56
    assign _T_234 = _T_236; //@ demo_utils_ecc.py:56
    assign mem_ecc_9_i = _T_234; //@ demo_utils_ecc.py:56
    assign _T_237 = (io_sram_ctrl_address == 4'ha); //@ demo_utils_ecc.py:56
    assign _T_239 = (io_sram_ctrl_write_en & _T_237); //@ demo_utils_ecc.py:56
    assign _T_240 = (_T_239 ? _T_196 : mem_ecc_10_o); //@ demo_utils_ecc.py:56
    assign _T_238 = _T_240; //@ demo_utils_ecc.py:56
    assign mem_ecc_10_i = _T_238; //@ demo_utils_ecc.py:56
    assign _T_241 = (io_sram_ctrl_address == 4'hb); //@ demo_utils_ecc.py:56
    assign _T_243 = (io_sram_ctrl_write_en & _T_241); //@ demo_utils_ecc.py:56
    assign _T_244 = (_T_243 ? _T_196 : mem_ecc_11_o); //@ demo_utils_ecc.py:56
    assign _T_242 = _T_244; //@ demo_utils_ecc.py:56
    assign mem_ecc_11_i = _T_242; //@ demo_utils_ecc.py:56
    assign _T_245 = (io_sram_ctrl_address == 4'hc); //@ demo_utils_ecc.py:56
    assign _T_247 = (io_sram_ctrl_write_en & _T_245); //@ demo_utils_ecc.py:56
    assign _T_248 = (_T_247 ? _T_196 : mem_ecc_12_o); //@ demo_utils_ecc.py:56
    assign _T_246 = _T_248; //@ demo_utils_ecc.py:56
    assign mem_ecc_12_i = _T_246; //@ demo_utils_ecc.py:56
    assign _T_249 = (io_sram_ctrl_address == 4'hd); //@ demo_utils_ecc.py:56
    assign _T_251 = (io_sram_ctrl_write_en & _T_249); //@ demo_utils_ecc.py:56
    assign _T_252 = (_T_251 ? _T_196 : mem_ecc_13_o); //@ demo_utils_ecc.py:56
    assign _T_250 = _T_252; //@ demo_utils_ecc.py:56
    assign mem_ecc_13_i = _T_250; //@ demo_utils_ecc.py:56
    assign _T_253 = (io_sram_ctrl_address == 4'he); //@ demo_utils_ecc.py:56
    assign _T_255 = (io_sram_ctrl_write_en & _T_253); //@ demo_utils_ecc.py:56
    assign _T_256 = (_T_255 ? _T_196 : mem_ecc_14_o); //@ demo_utils_ecc.py:56
    assign _T_254 = _T_256; //@ demo_utils_ecc.py:56
    assign mem_ecc_14_i = _T_254; //@ demo_utils_ecc.py:56
    assign _T_257 = (io_sram_ctrl_address == 4'hf); //@ demo_utils_ecc.py:56
    assign _T_259 = (io_sram_ctrl_write_en & _T_257); //@ demo_utils_ecc.py:56
    assign _T_260 = (_T_259 ? _T_196 : mem_ecc_15_o); //@ demo_utils_ecc.py:56
    assign _T_258 = _T_260; //@ demo_utils_ecc.py:56
    assign mem_ecc_15_i = _T_258; //@ demo_utils_ecc.py:56
    assign _T_261 = (io_sram_ctrl_address == 4'h0); //@ demo_utils_ecc.py:59
    assign _T_262 = {7'h48{_T_261}}; //@ demo_utils_ecc.py:59
    assign _T_263 = (_T_262 & mem_ecc_0_o); //@ demo_utils_ecc.py:59
    assign _T_264 = (io_sram_ctrl_address == 4'h1); //@ demo_utils_ecc.py:59
    assign _T_265 = {7'h48{_T_264}}; //@ demo_utils_ecc.py:59
    assign _T_266 = (_T_265 & mem_ecc_1_o); //@ demo_utils_ecc.py:59
    assign _T_267 = (_T_263 | _T_266); //@ demo_utils_ecc.py:59
    assign _T_268 = (io_sram_ctrl_address == 4'h2); //@ demo_utils_ecc.py:59
    assign _T_269 = {7'h48{_T_268}}; //@ demo_utils_ecc.py:59
    assign _T_270 = (_T_269 & mem_ecc_2_o); //@ demo_utils_ecc.py:59
    assign _T_271 = (_T_267 | _T_270); //@ demo_utils_ecc.py:59
    assign _T_272 = (io_sram_ctrl_address == 4'h3); //@ demo_utils_ecc.py:59
    assign _T_273 = {7'h48{_T_272}}; //@ demo_utils_ecc.py:59
    assign _T_274 = (_T_273 & mem_ecc_3_o); //@ demo_utils_ecc.py:59
    assign _T_275 = (_T_271 | _T_274); //@ demo_utils_ecc.py:59
    assign _T_276 = (io_sram_ctrl_address == 4'h4); //@ demo_utils_ecc.py:59
    assign _T_277 = {7'h48{_T_276}}; //@ demo_utils_ecc.py:59
    assign _T_278 = (_T_277 & mem_ecc_4_o); //@ demo_utils_ecc.py:59
    assign _T_279 = (_T_275 | _T_278); //@ demo_utils_ecc.py:59
    assign _T_280 = (io_sram_ctrl_address == 4'h5); //@ demo_utils_ecc.py:59
    assign _T_281 = {7'h48{_T_280}}; //@ demo_utils_ecc.py:59
    assign _T_282 = (_T_281 & mem_ecc_5_o); //@ demo_utils_ecc.py:59
    assign _T_283 = (_T_279 | _T_282); //@ demo_utils_ecc.py:59
    assign _T_284 = (io_sram_ctrl_address == 4'h6); //@ demo_utils_ecc.py:59
    assign _T_285 = {7'h48{_T_284}}; //@ demo_utils_ecc.py:59
    assign _T_286 = (_T_285 & mem_ecc_6_o); //@ demo_utils_ecc.py:59
    assign _T_287 = (_T_283 | _T_286); //@ demo_utils_ecc.py:59
    assign _T_288 = (io_sram_ctrl_address == 4'h7); //@ demo_utils_ecc.py:59
    assign _T_289 = {7'h48{_T_288}}; //@ demo_utils_ecc.py:59
    assign _T_290 = (_T_289 & mem_ecc_7_o); //@ demo_utils_ecc.py:59
    assign _T_291 = (_T_287 | _T_290); //@ demo_utils_ecc.py:59
    assign _T_292 = (io_sram_ctrl_address == 4'h8); //@ demo_utils_ecc.py:59
    assign _T_293 = {7'h48{_T_292}}; //@ demo_utils_ecc.py:59
    assign _T_294 = (_T_293 & mem_ecc_8_o); //@ demo_utils_ecc.py:59
    assign _T_295 = (_T_291 | _T_294); //@ demo_utils_ecc.py:59
    assign _T_296 = (io_sram_ctrl_address == 4'h9); //@ demo_utils_ecc.py:59
    assign _T_297 = {7'h48{_T_296}}; //@ demo_utils_ecc.py:59
    assign _T_298 = (_T_297 & mem_ecc_9_o); //@ demo_utils_ecc.py:59
    assign _T_299 = (_T_295 | _T_298); //@ demo_utils_ecc.py:59
    assign _T_300 = (io_sram_ctrl_address == 4'ha); //@ demo_utils_ecc.py:59
    assign _T_301 = {7'h48{_T_300}}; //@ demo_utils_ecc.py:59
    assign _T_302 = (_T_301 & mem_ecc_10_o); //@ demo_utils_ecc.py:59
    assign _T_303 = (_T_299 | _T_302); //@ demo_utils_ecc.py:59
    assign _T_304 = (io_sram_ctrl_address == 4'hb); //@ demo_utils_ecc.py:59
    assign _T_305 = {7'h48{_T_304}}; //@ demo_utils_ecc.py:59
    assign _T_306 = (_T_305 & mem_ecc_11_o); //@ demo_utils_ecc.py:59
    assign _T_307 = (_T_303 | _T_306); //@ demo_utils_ecc.py:59
    assign _T_308 = (io_sram_ctrl_address == 4'hc); //@ demo_utils_ecc.py:59
    assign _T_309 = {7'h48{_T_308}}; //@ demo_utils_ecc.py:59
    assign _T_310 = (_T_309 & mem_ecc_12_o); //@ demo_utils_ecc.py:59
    assign _T_311 = (_T_307 | _T_310); //@ demo_utils_ecc.py:59
    assign _T_312 = (io_sram_ctrl_address == 4'hd); //@ demo_utils_ecc.py:59
    assign _T_313 = {7'h48{_T_312}}; //@ demo_utils_ecc.py:59
    assign _T_314 = (_T_313 & mem_ecc_13_o); //@ demo_utils_ecc.py:59
    assign _T_315 = (_T_311 | _T_314); //@ demo_utils_ecc.py:59
    assign _T_316 = (io_sram_ctrl_address == 4'he); //@ demo_utils_ecc.py:59
    assign _T_317 = {7'h48{_T_316}}; //@ demo_utils_ecc.py:59
    assign _T_318 = (_T_317 & mem_ecc_14_o); //@ demo_utils_ecc.py:59
    assign _T_319 = (_T_315 | _T_318); //@ demo_utils_ecc.py:59
    assign _T_320 = (io_sram_ctrl_address == 4'hf); //@ demo_utils_ecc.py:59
    assign _T_321 = {7'h48{_T_320}}; //@ demo_utils_ecc.py:59
    assign _T_322 = (_T_321 & mem_ecc_15_o); //@ demo_utils_ecc.py:59
    assign _T_323 = (_T_319 | _T_322); //@ demo_utils_ecc.py:59
    assign _T_324 = _T_323[70:0]; //@ ecc.py:172
    assign _T_325 = 71'h1ab55555556aaad5b; //@ ecc.py:118
    assign _T_326 = (_T_325 & _T_324); //@ ecc.py:140
    assign _T_327 = ^_T_326; //@ ecc.py:140
    assign _T_328 = 71'h2cd9999999b33366d; //@ ecc.py:118
    assign _T_329 = (_T_328 & _T_324); //@ ecc.py:140
    assign _T_330 = ^_T_329; //@ ecc.py:140
    assign _T_331 = 71'h4f1e1e1e1e3c3c78e; //@ ecc.py:118
    assign _T_332 = (_T_331 & _T_324); //@ ecc.py:140
    assign _T_333 = ^_T_332; //@ ecc.py:140
    assign _T_334 = 71'h801fe01fe03fc07f0; //@ ecc.py:118
    assign _T_335 = (_T_334 & _T_324); //@ ecc.py:140
    assign _T_336 = ^_T_335; //@ ecc.py:140
    assign _T_337 = 71'h1001fffe0003fff800; //@ ecc.py:118
    assign _T_338 = (_T_337 & _T_324); //@ ecc.py:140
    assign _T_339 = ^_T_338; //@ ecc.py:140
    assign _T_340 = 71'h2001fffffffc000000; //@ ecc.py:118
    assign _T_341 = (_T_340 & _T_324); //@ ecc.py:140
    assign _T_342 = ^_T_341; //@ ecc.py:140
    assign _T_343 = 71'h40fe00000000000000; //@ ecc.py:118
    assign _T_344 = (_T_343 & _T_324); //@ ecc.py:140
    assign _T_345 = ^_T_344; //@ ecc.py:140
    assign _T_346 = {_T_345, _T_342}; //@ ecc.py:140
    assign _T_347 = {_T_346, _T_339}; //@ ecc.py:140
    assign _T_348 = {_T_347, _T_336}; //@ ecc.py:140
    assign _T_349 = {_T_348, _T_333}; //@ ecc.py:140
    assign _T_350 = {_T_349, _T_330}; //@ ecc.py:140
    assign _T_351 = {_T_350, _T_327}; //@ ecc.py:140
    assign _T_352 = (_T_351 == 7'h0); //@ ecc.py:142
    assign _T_353 = (_T_351 == 7'h1); //@ ecc.py:142
    assign _T_354 = (_T_351 == 7'h2); //@ ecc.py:142
    assign _T_355 = (_T_351 == 7'h3); //@ ecc.py:142
    assign _T_356 = (_T_351 == 7'h4); //@ ecc.py:142
    assign _T_357 = (_T_351 == 7'h5); //@ ecc.py:142
    assign _T_358 = (_T_351 == 7'h6); //@ ecc.py:142
    assign _T_359 = (_T_351 == 7'h7); //@ ecc.py:142
    assign _T_360 = (_T_351 == 7'h8); //@ ecc.py:142
    assign _T_361 = (_T_351 == 7'h9); //@ ecc.py:142
    assign _T_362 = (_T_351 == 7'ha); //@ ecc.py:142
    assign _T_363 = (_T_351 == 7'hb); //@ ecc.py:142
    assign _T_364 = (_T_351 == 7'hc); //@ ecc.py:142
    assign _T_365 = (_T_351 == 7'hd); //@ ecc.py:142
    assign _T_366 = (_T_351 == 7'he); //@ ecc.py:142
    assign _T_367 = (_T_351 == 7'hf); //@ ecc.py:142
    assign _T_368 = (_T_351 == 7'h10); //@ ecc.py:142
    assign _T_369 = (_T_351 == 7'h11); //@ ecc.py:142
    assign _T_370 = (_T_351 == 7'h12); //@ ecc.py:142
    assign _T_371 = (_T_351 == 7'h13); //@ ecc.py:142
    assign _T_372 = (_T_351 == 7'h14); //@ ecc.py:142
    assign _T_373 = (_T_351 == 7'h15); //@ ecc.py:142
    assign _T_374 = (_T_351 == 7'h16); //@ ecc.py:142
    assign _T_375 = (_T_351 == 7'h17); //@ ecc.py:142
    assign _T_376 = (_T_351 == 7'h18); //@ ecc.py:142
    assign _T_377 = (_T_351 == 7'h19); //@ ecc.py:142
    assign _T_378 = (_T_351 == 7'h1a); //@ ecc.py:142
    assign _T_379 = (_T_351 == 7'h1b); //@ ecc.py:142
    assign _T_380 = (_T_351 == 7'h1c); //@ ecc.py:142
    assign _T_381 = (_T_351 == 7'h1d); //@ ecc.py:142
    assign _T_382 = (_T_351 == 7'h1e); //@ ecc.py:142
    assign _T_383 = (_T_351 == 7'h1f); //@ ecc.py:142
    assign _T_384 = (_T_351 == 7'h20); //@ ecc.py:142
    assign _T_385 = (_T_351 == 7'h21); //@ ecc.py:142
    assign _T_386 = (_T_351 == 7'h22); //@ ecc.py:142
    assign _T_387 = (_T_351 == 7'h23); //@ ecc.py:142
    assign _T_388 = (_T_351 == 7'h24); //@ ecc.py:142
    assign _T_389 = (_T_351 == 7'h25); //@ ecc.py:142
    assign _T_390 = (_T_351 == 7'h26); //@ ecc.py:142
    assign _T_391 = (_T_351 == 7'h27); //@ ecc.py:142
    assign _T_392 = (_T_351 == 7'h28); //@ ecc.py:142
    assign _T_393 = (_T_351 == 7'h29); //@ ecc.py:142
    assign _T_394 = (_T_351 == 7'h2a); //@ ecc.py:142
    assign _T_395 = (_T_351 == 7'h2b); //@ ecc.py:142
    assign _T_396 = (_T_351 == 7'h2c); //@ ecc.py:142
    assign _T_397 = (_T_351 == 7'h2d); //@ ecc.py:142
    assign _T_398 = (_T_351 == 7'h2e); //@ ecc.py:142
    assign _T_399 = (_T_351 == 7'h2f); //@ ecc.py:142
    assign _T_400 = (_T_351 == 7'h30); //@ ecc.py:142
    assign _T_401 = (_T_351 == 7'h31); //@ ecc.py:142
    assign _T_402 = (_T_351 == 7'h32); //@ ecc.py:142
    assign _T_403 = (_T_351 == 7'h33); //@ ecc.py:142
    assign _T_404 = (_T_351 == 7'h34); //@ ecc.py:142
    assign _T_405 = (_T_351 == 7'h35); //@ ecc.py:142
    assign _T_406 = (_T_351 == 7'h36); //@ ecc.py:142
    assign _T_407 = (_T_351 == 7'h37); //@ ecc.py:142
    assign _T_408 = (_T_351 == 7'h38); //@ ecc.py:142
    assign _T_409 = (_T_351 == 7'h39); //@ ecc.py:142
    assign _T_410 = (_T_351 == 7'h3a); //@ ecc.py:142
    assign _T_411 = (_T_351 == 7'h3b); //@ ecc.py:142
    assign _T_412 = (_T_351 == 7'h3c); //@ ecc.py:142
    assign _T_413 = (_T_351 == 7'h3d); //@ ecc.py:142
    assign _T_414 = (_T_351 == 7'h3e); //@ ecc.py:142
    assign _T_415 = (_T_351 == 7'h3f); //@ ecc.py:142
    assign _T_416 = (_T_351 == 7'h40); //@ ecc.py:142
    assign _T_417 = (_T_351 == 7'h41); //@ ecc.py:142
    assign _T_418 = (_T_351 == 7'h42); //@ ecc.py:142
    assign _T_419 = (_T_351 == 7'h43); //@ ecc.py:142
    assign _T_420 = (_T_351 == 7'h44); //@ ecc.py:142
    assign _T_421 = (_T_351 == 7'h45); //@ ecc.py:142
    assign _T_422 = (_T_351 == 7'h46); //@ ecc.py:142
    assign _T_423 = (_T_351 == 7'h47); //@ ecc.py:142
    assign _T_424 = {_T_423, _T_422}; //@ ecc.py:142
    assign _T_425 = {_T_424, _T_421}; //@ ecc.py:142
    assign _T_426 = {_T_425, _T_420}; //@ ecc.py:142
    assign _T_427 = {_T_426, _T_419}; //@ ecc.py:142
    assign _T_428 = {_T_427, _T_418}; //@ ecc.py:142
    assign _T_429 = {_T_428, _T_417}; //@ ecc.py:142
    assign _T_430 = {_T_429, _T_416}; //@ ecc.py:142
    assign _T_431 = {_T_430, _T_415}; //@ ecc.py:142
    assign _T_432 = {_T_431, _T_414}; //@ ecc.py:142
    assign _T_433 = {_T_432, _T_413}; //@ ecc.py:142
    assign _T_434 = {_T_433, _T_412}; //@ ecc.py:142
    assign _T_435 = {_T_434, _T_411}; //@ ecc.py:142
    assign _T_436 = {_T_435, _T_410}; //@ ecc.py:142
    assign _T_437 = {_T_436, _T_409}; //@ ecc.py:142
    assign _T_438 = {_T_437, _T_408}; //@ ecc.py:142
    assign _T_439 = {_T_438, _T_407}; //@ ecc.py:142
    assign _T_440 = {_T_439, _T_406}; //@ ecc.py:142
    assign _T_441 = {_T_440, _T_405}; //@ ecc.py:142
    assign _T_442 = {_T_441, _T_404}; //@ ecc.py:142
    assign _T_443 = {_T_442, _T_403}; //@ ecc.py:142
    assign _T_444 = {_T_443, _T_402}; //@ ecc.py:142
    assign _T_445 = {_T_444, _T_401}; //@ ecc.py:142
    assign _T_446 = {_T_445, _T_400}; //@ ecc.py:142
    assign _T_447 = {_T_446, _T_399}; //@ ecc.py:142
    assign _T_448 = {_T_447, _T_398}; //@ ecc.py:142
    assign _T_449 = {_T_448, _T_397}; //@ ecc.py:142
    assign _T_450 = {_T_449, _T_396}; //@ ecc.py:142
    assign _T_451 = {_T_450, _T_395}; //@ ecc.py:142
    assign _T_452 = {_T_451, _T_394}; //@ ecc.py:142
    assign _T_453 = {_T_452, _T_393}; //@ ecc.py:142
    assign _T_454 = {_T_453, _T_392}; //@ ecc.py:142
    assign _T_455 = {_T_454, _T_391}; //@ ecc.py:142
    assign _T_456 = {_T_455, _T_390}; //@ ecc.py:142
    assign _T_457 = {_T_456, _T_389}; //@ ecc.py:142
    assign _T_458 = {_T_457, _T_388}; //@ ecc.py:142
    assign _T_459 = {_T_458, _T_387}; //@ ecc.py:142
    assign _T_460 = {_T_459, _T_386}; //@ ecc.py:142
    assign _T_461 = {_T_460, _T_385}; //@ ecc.py:142
    assign _T_462 = {_T_461, _T_384}; //@ ecc.py:142
    assign _T_463 = {_T_462, _T_383}; //@ ecc.py:142
    assign _T_464 = {_T_463, _T_382}; //@ ecc.py:142
    assign _T_465 = {_T_464, _T_381}; //@ ecc.py:142
    assign _T_466 = {_T_465, _T_380}; //@ ecc.py:142
    assign _T_467 = {_T_466, _T_379}; //@ ecc.py:142
    assign _T_468 = {_T_467, _T_378}; //@ ecc.py:142
    assign _T_469 = {_T_468, _T_377}; //@ ecc.py:142
    assign _T_470 = {_T_469, _T_376}; //@ ecc.py:142
    assign _T_471 = {_T_470, _T_375}; //@ ecc.py:142
    assign _T_472 = {_T_471, _T_374}; //@ ecc.py:142
    assign _T_473 = {_T_472, _T_373}; //@ ecc.py:142
    assign _T_474 = {_T_473, _T_372}; //@ ecc.py:142
    assign _T_475 = {_T_474, _T_371}; //@ ecc.py:142
    assign _T_476 = {_T_475, _T_370}; //@ ecc.py:142
    assign _T_477 = {_T_476, _T_369}; //@ ecc.py:142
    assign _T_478 = {_T_477, _T_368}; //@ ecc.py:142
    assign _T_479 = {_T_478, _T_367}; //@ ecc.py:142
    assign _T_480 = {_T_479, _T_366}; //@ ecc.py:142
    assign _T_481 = {_T_480, _T_365}; //@ ecc.py:142
    assign _T_482 = {_T_481, _T_364}; //@ ecc.py:142
    assign _T_483 = {_T_482, _T_363}; //@ ecc.py:142
    assign _T_484 = {_T_483, _T_362}; //@ ecc.py:142
    assign _T_485 = {_T_484, _T_361}; //@ ecc.py:142
    assign _T_486 = {_T_485, _T_360}; //@ ecc.py:142
    assign _T_487 = {_T_486, _T_359}; //@ ecc.py:142
    assign _T_488 = {_T_487, _T_358}; //@ ecc.py:142
    assign _T_489 = {_T_488, _T_357}; //@ ecc.py:142
    assign _T_490 = {_T_489, _T_356}; //@ ecc.py:142
    assign _T_491 = {_T_490, _T_355}; //@ ecc.py:142
    assign _T_492 = {_T_491, _T_354}; //@ ecc.py:142
    assign _T_493 = {_T_492, _T_353}; //@ ecc.py:142
    assign _T_494 = {_T_493, _T_352}; //@ ecc.py:142
    assign _T_495 = _T_494[3]; //@ ecc.py:143
    assign _T_496 = _T_494[5]; //@ ecc.py:143
    assign _T_497 = _T_494[6]; //@ ecc.py:143
    assign _T_498 = _T_494[7]; //@ ecc.py:143
    assign _T_499 = _T_494[9]; //@ ecc.py:143
    assign _T_500 = _T_494[10]; //@ ecc.py:143
    assign _T_501 = _T_494[11]; //@ ecc.py:143
    assign _T_502 = _T_494[12]; //@ ecc.py:143
    assign _T_503 = _T_494[13]; //@ ecc.py:143
    assign _T_504 = _T_494[14]; //@ ecc.py:143
    assign _T_505 = _T_494[15]; //@ ecc.py:143
    assign _T_506 = _T_494[17]; //@ ecc.py:143
    assign _T_507 = _T_494[18]; //@ ecc.py:143
    assign _T_508 = _T_494[19]; //@ ecc.py:143
    assign _T_509 = _T_494[20]; //@ ecc.py:143
    assign _T_510 = _T_494[21]; //@ ecc.py:143
    assign _T_511 = _T_494[22]; //@ ecc.py:143
    assign _T_512 = _T_494[23]; //@ ecc.py:143
    assign _T_513 = _T_494[24]; //@ ecc.py:143
    assign _T_514 = _T_494[25]; //@ ecc.py:143
    assign _T_515 = _T_494[26]; //@ ecc.py:143
    assign _T_516 = _T_494[27]; //@ ecc.py:143
    assign _T_517 = _T_494[28]; //@ ecc.py:143
    assign _T_518 = _T_494[29]; //@ ecc.py:143
    assign _T_519 = _T_494[30]; //@ ecc.py:143
    assign _T_520 = _T_494[31]; //@ ecc.py:143
    assign _T_521 = _T_494[33]; //@ ecc.py:143
    assign _T_522 = _T_494[34]; //@ ecc.py:143
    assign _T_523 = _T_494[35]; //@ ecc.py:143
    assign _T_524 = _T_494[36]; //@ ecc.py:143
    assign _T_525 = _T_494[37]; //@ ecc.py:143
    assign _T_526 = _T_494[38]; //@ ecc.py:143
    assign _T_527 = _T_494[39]; //@ ecc.py:143
    assign _T_528 = _T_494[40]; //@ ecc.py:143
    assign _T_529 = _T_494[41]; //@ ecc.py:143
    assign _T_530 = _T_494[42]; //@ ecc.py:143
    assign _T_531 = _T_494[43]; //@ ecc.py:143
    assign _T_532 = _T_494[44]; //@ ecc.py:143
    assign _T_533 = _T_494[45]; //@ ecc.py:143
    assign _T_534 = _T_494[46]; //@ ecc.py:143
    assign _T_535 = _T_494[47]; //@ ecc.py:143
    assign _T_536 = _T_494[48]; //@ ecc.py:143
    assign _T_537 = _T_494[49]; //@ ecc.py:143
    assign _T_538 = _T_494[50]; //@ ecc.py:143
    assign _T_539 = _T_494[51]; //@ ecc.py:143
    assign _T_540 = _T_494[52]; //@ ecc.py:143
    assign _T_541 = _T_494[53]; //@ ecc.py:143
    assign _T_542 = _T_494[54]; //@ ecc.py:143
    assign _T_543 = _T_494[55]; //@ ecc.py:143
    assign _T_544 = _T_494[56]; //@ ecc.py:143
    assign _T_545 = _T_494[57]; //@ ecc.py:143
    assign _T_546 = _T_494[58]; //@ ecc.py:143
    assign _T_547 = _T_494[59]; //@ ecc.py:143
    assign _T_548 = _T_494[60]; //@ ecc.py:143
    assign _T_549 = _T_494[61]; //@ ecc.py:143
    assign _T_550 = _T_494[62]; //@ ecc.py:143
    assign _T_551 = _T_494[63]; //@ ecc.py:143
    assign _T_552 = _T_494[65]; //@ ecc.py:143
    assign _T_553 = _T_494[66]; //@ ecc.py:143
    assign _T_554 = _T_494[67]; //@ ecc.py:143
    assign _T_555 = _T_494[68]; //@ ecc.py:143
    assign _T_556 = _T_494[69]; //@ ecc.py:143
    assign _T_557 = _T_494[70]; //@ ecc.py:143
    assign _T_558 = _T_494[71]; //@ ecc.py:143
    assign _T_559 = {_T_558, _T_557}; //@ ecc.py:143
    assign _T_560 = {_T_559, _T_556}; //@ ecc.py:143
    assign _T_561 = {_T_560, _T_555}; //@ ecc.py:143
    assign _T_562 = {_T_561, _T_554}; //@ ecc.py:143
    assign _T_563 = {_T_562, _T_553}; //@ ecc.py:143
    assign _T_564 = {_T_563, _T_552}; //@ ecc.py:143
    assign _T_565 = {_T_564, _T_551}; //@ ecc.py:143
    assign _T_566 = {_T_565, _T_550}; //@ ecc.py:143
    assign _T_567 = {_T_566, _T_549}; //@ ecc.py:143
    assign _T_568 = {_T_567, _T_548}; //@ ecc.py:143
    assign _T_569 = {_T_568, _T_547}; //@ ecc.py:143
    assign _T_570 = {_T_569, _T_546}; //@ ecc.py:143
    assign _T_571 = {_T_570, _T_545}; //@ ecc.py:143
    assign _T_572 = {_T_571, _T_544}; //@ ecc.py:143
    assign _T_573 = {_T_572, _T_543}; //@ ecc.py:143
    assign _T_574 = {_T_573, _T_542}; //@ ecc.py:143
    assign _T_575 = {_T_574, _T_541}; //@ ecc.py:143
    assign _T_576 = {_T_575, _T_540}; //@ ecc.py:143
    assign _T_577 = {_T_576, _T_539}; //@ ecc.py:143
    assign _T_578 = {_T_577, _T_538}; //@ ecc.py:143
    assign _T_579 = {_T_578, _T_537}; //@ ecc.py:143
    assign _T_580 = {_T_579, _T_536}; //@ ecc.py:143
    assign _T_581 = {_T_580, _T_535}; //@ ecc.py:143
    assign _T_582 = {_T_581, _T_534}; //@ ecc.py:143
    assign _T_583 = {_T_582, _T_533}; //@ ecc.py:143
    assign _T_584 = {_T_583, _T_532}; //@ ecc.py:143
    assign _T_585 = {_T_584, _T_531}; //@ ecc.py:143
    assign _T_586 = {_T_585, _T_530}; //@ ecc.py:143
    assign _T_587 = {_T_586, _T_529}; //@ ecc.py:143
    assign _T_588 = {_T_587, _T_528}; //@ ecc.py:143
    assign _T_589 = {_T_588, _T_527}; //@ ecc.py:143
    assign _T_590 = {_T_589, _T_526}; //@ ecc.py:143
    assign _T_591 = {_T_590, _T_525}; //@ ecc.py:143
    assign _T_592 = {_T_591, _T_524}; //@ ecc.py:143
    assign _T_593 = {_T_592, _T_523}; //@ ecc.py:143
    assign _T_594 = {_T_593, _T_522}; //@ ecc.py:143
    assign _T_595 = {_T_594, _T_521}; //@ ecc.py:143
    assign _T_596 = {_T_595, _T_520}; //@ ecc.py:143
    assign _T_597 = {_T_596, _T_519}; //@ ecc.py:143
    assign _T_598 = {_T_597, _T_518}; //@ ecc.py:143
    assign _T_599 = {_T_598, _T_517}; //@ ecc.py:143
    assign _T_600 = {_T_599, _T_516}; //@ ecc.py:143
    assign _T_601 = {_T_600, _T_515}; //@ ecc.py:143
    assign _T_602 = {_T_601, _T_514}; //@ ecc.py:143
    assign _T_603 = {_T_602, _T_513}; //@ ecc.py:143
    assign _T_604 = {_T_603, _T_512}; //@ ecc.py:143
    assign _T_605 = {_T_604, _T_511}; //@ ecc.py:143
    assign _T_606 = {_T_605, _T_510}; //@ ecc.py:143
    assign _T_607 = {_T_606, _T_509}; //@ ecc.py:143
    assign _T_608 = {_T_607, _T_508}; //@ ecc.py:143
    assign _T_609 = {_T_608, _T_507}; //@ ecc.py:143
    assign _T_610 = {_T_609, _T_506}; //@ ecc.py:143
    assign _T_611 = {_T_610, _T_505}; //@ ecc.py:143
    assign _T_612 = {_T_611, _T_504}; //@ ecc.py:143
    assign _T_613 = {_T_612, _T_503}; //@ ecc.py:143
    assign _T_614 = {_T_613, _T_502}; //@ ecc.py:143
    assign _T_615 = {_T_614, _T_501}; //@ ecc.py:143
    assign _T_616 = {_T_615, _T_500}; //@ ecc.py:143
    assign _T_617 = {_T_616, _T_499}; //@ ecc.py:143
    assign _T_618 = {_T_617, _T_498}; //@ ecc.py:143
    assign _T_619 = {_T_618, _T_497}; //@ ecc.py:143
    assign _T_620 = {_T_619, _T_496}; //@ ecc.py:143
    assign _T_621 = {_T_620, _T_495}; //@ ecc.py:143
    assign _T_623 = _T_324[63:0]; //@ ecc.py:146
    assign _T_622_pre_correct = _T_623; //@ ecc.py:146
    assign _T_624 = (_T_622_pre_correct ^ _T_621); //@ ecc.py:147
    assign _T_622_post_correct = _T_624; //@ ecc.py:147
    assign _T_625 = |_T_351; //@ ecc.py:148
    assign _T_622_correctable = _T_625; //@ ecc.py:148
    assign _T_626 = (_T_351 > 7'h47); //@ ecc.py:149
    assign _T_622_uncorrectable = _T_626; //@ ecc.py:149
    assign _T_628 = _T_323[70:0]; //@ ecc.py:73
    assign _T_627_pre_correct = _T_628; //@ ecc.py:73
    assign _T_627_post_correct = _T_627_pre_correct; //@ ecc.py:74
    assign _T_629 = 1'h0; //@ ecc.py:75
    assign _T_627_correctable = _T_629; //@ ecc.py:75
    assign _T_630 = ^_T_323; //@ ecc.py:76
    assign _T_627_uncorrectable = _T_630; //@ ecc.py:76
    assign _T_631_pre_correct = _T_622_pre_correct; //@ ecc.py:176
    assign _T_631_post_correct = _T_622_post_correct; //@ ecc.py:177
    assign _T_631_correctable = _T_627_uncorrectable; //@ ecc.py:178
    assign _T_632 = ~_T_627_uncorrectable; //@ ecc.py:179
    assign _T_633 = (_T_632 & _T_622_correctable); //@ ecc.py:179
    assign _T_631_uncorrectable = _T_633; //@ ecc.py:179
    assign _T_635 = (io_sram_ctrl_read_en ? _T_631_pre_correct : ecc_out_data_pre_correct_o); //@ demo_utils_ecc.py:61
    assign _T_634 = _T_635; //@ demo_utils_ecc.py:61
    assign ecc_out_data_pre_correct_i = _T_634; //@ demo_utils_ecc.py:61
    assign _T_637 = (io_sram_ctrl_read_en ? _T_631_post_correct : ecc_out_data_post_correct_o); //@ demo_utils_ecc.py:62
    assign _T_636 = _T_637; //@ demo_utils_ecc.py:62
    assign ecc_out_data_post_correct_i = _T_636; //@ demo_utils_ecc.py:62
    assign _T_638 = (_T_631_correctable | _T_631_uncorrectable); //@ ecc.py:18
    assign _T_640 = (io_sram_ctrl_read_en ? _T_638 : ecc_out_error_o); //@ demo_utils_ecc.py:63
    assign _T_639 = _T_640; //@ demo_utils_ecc.py:63
    assign ecc_out_error_i = _T_639; //@ demo_utils_ecc.py:63
    assign _T_642 = (io_sram_ctrl_read_en ? _T_631_uncorrectable : ecc_out_error_uncorrectable_o); //@ demo_utils_ecc.py:64
    assign _T_641 = _T_642; //@ demo_utils_ecc.py:64
    assign ecc_out_error_uncorrectable_i = _T_641; //@ demo_utils_ecc.py:64
endmodule
