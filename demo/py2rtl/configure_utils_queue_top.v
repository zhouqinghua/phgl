module utils_queue_top(
    input  wire  clock, //@ phgl_generator.py:85
    input  wire  reset  //@ phgl_generator.py:85
);
    wire [3:0] enq_address_i; //@ demo_utils_queue.py:17
    reg  [3:0] enq_address_o; //@ demo_utils_queue.py:17
    wire  deq_ready_i; //@ demo_utils_queue.py:18
    reg   deq_ready_o; //@ demo_utils_queue.py:18
    wire  fifo0_io_enq_ready; //@ demo_utils_queue.py:20
    wire  fifo0_io_enq_valid; //@ demo_utils_queue.py:20
    wire [3:0] fifo0_io_enq_bits_op; //@ demo_utils_queue.py:20
    wire [3:0] fifo0_io_enq_bits_address; //@ demo_utils_queue.py:20
    wire [31:0] fifo0_io_enq_bits_data; //@ demo_utils_queue.py:20
    wire  fifo0_io_deq_ready; //@ demo_utils_queue.py:20
    wire  fifo0_io_deq_valid; //@ demo_utils_queue.py:20
    wire [3:0] fifo0_io_deq_bits_op; //@ demo_utils_queue.py:20
    wire [3:0] fifo0_io_deq_bits_address; //@ demo_utils_queue.py:20
    wire [31:0] fifo0_io_deq_bits_data; //@ demo_utils_queue.py:20
    wire [3:0] fifo0_io_count; //@ demo_utils_queue.py:20
    wire  fifo0_clock; //@ demo_utils_queue.py:20
    wire  fifo0_reset; //@ demo_utils_queue.py:20
    wire  _T_0; //@ demo_utils_queue.py:26
    wire [4:0] _T_1; //@ demo_utils_queue.py:28
    wire [3:0] _T_2; //@ demo_utils_queue.py:28
    wire [4:0] _T_3; //@ demo_utils_queue.py:28
    wire [3:0] _T_4; //@ demo_utils_queue.py:28
    wire [3:0] _T_5; //@ demo_utils_queue.py:28
    wire  _T_6; //@ demo_utils_queue.py:30
    wire  _T_7; //@ demo_utils_queue.py:31
    wire  _T_8; //@ demo_utils_queue.py:31
    wire  _T_9; //@ demo_utils_queue.py:32
    wire  _T_10; //@ demo_utils_queue.py:33
    wire  _T_11; //@ demo_utils_queue.py:33
    always @(posedge clock) //@ demo_utils_queue.py:17
        if (reset)
            enq_address_o <= 4'h0;
        else
            enq_address_o <= enq_address_i;
    always @(posedge clock) //@ demo_utils_queue.py:18
        if (reset)
            deq_ready_o <= 1'h0;
        else
            deq_ready_o <= deq_ready_i;
    queue fifo0( //@ demo_utils_queue.py:20
        .io_enq_ready(fifo0_io_enq_ready),
        .io_enq_valid(fifo0_io_enq_valid),
        .io_enq_bits_op(fifo0_io_enq_bits_op),
        .io_enq_bits_address(fifo0_io_enq_bits_address),
        .io_enq_bits_data(fifo0_io_enq_bits_data),
        .io_deq_ready(fifo0_io_deq_ready),
        .io_deq_valid(fifo0_io_deq_valid),
        .io_deq_bits_op(fifo0_io_deq_bits_op),
        .io_deq_bits_address(fifo0_io_deq_bits_address),
        .io_deq_bits_data(fifo0_io_deq_bits_data),
        .io_count(fifo0_io_count),
        .clock(fifo0_clock),
        .reset(fifo0_reset)
    );
    assign fifo0_clock = clock; //@ demo_utils_queue.py:20
    assign fifo0_reset = reset; //@ demo_utils_queue.py:20
    assign fifo0_io_enq_valid = 1'h1; //@ demo_utils_queue.py:21
    assign fifo0_io_enq_bits_address = enq_address_o; //@ demo_utils_queue.py:22
    assign fifo0_io_enq_bits_data = 32'h0; //@ demo_utils_queue.py:23
    assign fifo0_io_deq_ready = deq_ready_o; //@ demo_utils_queue.py:24
    assign _T_0 = (fifo0_io_enq_ready & fifo0_io_enq_valid); //@ demo_utils_queue.py:26
    assign _T_1 = (enq_address_o + 4'h1); //@ demo_utils_queue.py:28
    assign _T_3 = (_T_0 ? _T_1 : enq_address_o); //@ demo_utils_queue.py:28
    assign _T_5 = _T_3[3:0]; //@ demo_utils_queue.py:28
    assign _T_4 = _T_5; //@ demo_utils_queue.py:28
    assign _T_2 = _T_4; //@ demo_utils_queue.py:28
    assign enq_address_i = _T_2; //@ demo_utils_queue.py:28
    assign _T_6 = (fifo0_io_count > 4'h4); //@ demo_utils_queue.py:30
    assign _T_8 = (_T_6 ? 1'h1 : deq_ready_o); //@ demo_utils_queue.py:31
    assign _T_7 = _T_8; //@ demo_utils_queue.py:31
//    assign deq_ready_i = _T_7; //@ demo_utils_queue.py:31
    assign _T_9 = (_T_6 == 1'h0); //@ demo_utils_queue.py:32
    assign _T_11 = (_T_9 ? 1'h0 : _T_7); //@ demo_utils_queue.py:33
    assign _T_10 = _T_11; //@ demo_utils_queue.py:33
    assign deq_ready_i = _T_10; //@ demo_utils_queue.py:33
endmodule
module queue(
    output wire  io_enq_ready, //@ fifo.py:18
    input  wire  io_enq_valid, //@ fifo.py:18
    input  wire [3:0] io_enq_bits_op, //@ fifo.py:18
    input  wire [3:0] io_enq_bits_address, //@ fifo.py:18
    input  wire [31:0] io_enq_bits_data, //@ fifo.py:18
    input  wire  io_deq_ready, //@ fifo.py:19
    output wire  io_deq_valid, //@ fifo.py:19
    output wire [3:0] io_deq_bits_op, //@ fifo.py:19
    output wire [3:0] io_deq_bits_address, //@ fifo.py:19
    output wire [31:0] io_deq_bits_data, //@ fifo.py:19
    output wire [3:0] io_count, //@ fifo.py:24
    input  wire  clock, //@ demo_utils_queue.py:20
    input  wire  reset  //@ demo_utils_queue.py:20
);
    wire [3:0] ram_0_op_i; //@ fifo.py:60
    reg  [3:0] ram_0_op_o; //@ fifo.py:60
    wire [3:0] ram_0_address_i; //@ fifo.py:60
    reg  [3:0] ram_0_address_o; //@ fifo.py:60
    wire [31:0] ram_0_data_i; //@ fifo.py:60
    reg  [31:0] ram_0_data_o; //@ fifo.py:60
    wire [3:0] ram_1_op_i; //@ fifo.py:60
    reg  [3:0] ram_1_op_o; //@ fifo.py:60
    wire [3:0] ram_1_address_i; //@ fifo.py:60
    reg  [3:0] ram_1_address_o; //@ fifo.py:60
    wire [31:0] ram_1_data_i; //@ fifo.py:60
    reg  [31:0] ram_1_data_o; //@ fifo.py:60
    wire [3:0] ram_2_op_i; //@ fifo.py:60
    reg  [3:0] ram_2_op_o; //@ fifo.py:60
    wire [3:0] ram_2_address_i; //@ fifo.py:60
    reg  [3:0] ram_2_address_o; //@ fifo.py:60
    wire [31:0] ram_2_data_i; //@ fifo.py:60
    reg  [31:0] ram_2_data_o; //@ fifo.py:60
    wire [3:0] ram_3_op_i; //@ fifo.py:60
    reg  [3:0] ram_3_op_o; //@ fifo.py:60
    wire [3:0] ram_3_address_i; //@ fifo.py:60
    reg  [3:0] ram_3_address_o; //@ fifo.py:60
    wire [31:0] ram_3_data_i; //@ fifo.py:60
    reg  [31:0] ram_3_data_o; //@ fifo.py:60
    wire [3:0] ram_4_op_i; //@ fifo.py:60
    reg  [3:0] ram_4_op_o; //@ fifo.py:60
    wire [3:0] ram_4_address_i; //@ fifo.py:60
    reg  [3:0] ram_4_address_o; //@ fifo.py:60
    wire [31:0] ram_4_data_i; //@ fifo.py:60
    reg  [31:0] ram_4_data_o; //@ fifo.py:60
    wire [3:0] ram_5_op_i; //@ fifo.py:60
    reg  [3:0] ram_5_op_o; //@ fifo.py:60
    wire [3:0] ram_5_address_i; //@ fifo.py:60
    reg  [3:0] ram_5_address_o; //@ fifo.py:60
    wire [31:0] ram_5_data_i; //@ fifo.py:60
    reg  [31:0] ram_5_data_o; //@ fifo.py:60
    wire [3:0] ram_6_op_i; //@ fifo.py:60
    reg  [3:0] ram_6_op_o; //@ fifo.py:60
    wire [3:0] ram_6_address_i; //@ fifo.py:60
    reg  [3:0] ram_6_address_o; //@ fifo.py:60
    wire [31:0] ram_6_data_i; //@ fifo.py:60
    reg  [31:0] ram_6_data_o; //@ fifo.py:60
    wire [3:0] ram_7_op_i; //@ fifo.py:60
    reg  [3:0] ram_7_op_o; //@ fifo.py:60
    wire [3:0] ram_7_address_i; //@ fifo.py:60
    reg  [3:0] ram_7_address_o; //@ fifo.py:60
    wire [31:0] ram_7_data_i; //@ fifo.py:60
    reg  [31:0] ram_7_data_o; //@ fifo.py:60
    wire [2:0] enq_ptr_value_i; //@ counters.py:17
    reg  [2:0] enq_ptr_value_o; //@ counters.py:17
    wire  enq_ptr_wrap; //@ counters.py:18
    wire [2:0] deq_ptr_value_i; //@ counters.py:17
    reg  [2:0] deq_ptr_value_o; //@ counters.py:17
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
    wire [3:0] _T_10; //@ fifo.py:72
    wire  _T_11; //@ fifo.py:72
    wire [3:0] _T_12; //@ fifo.py:72
    wire [3:0] _T_13; //@ fifo.py:72
    wire  _T_14; //@ fifo.py:72
    wire [3:0] _T_15; //@ fifo.py:72
    wire  _T_16; //@ fifo.py:72
    wire [31:0] _T_17; //@ fifo.py:72
    wire  _T_18; //@ fifo.py:72
    wire [31:0] _T_19; //@ fifo.py:72
    wire [3:0] _T_20; //@ fifo.py:72
    wire  _T_21; //@ fifo.py:72
    wire [3:0] _T_22; //@ fifo.py:72
    wire [3:0] _T_23; //@ fifo.py:72
    wire  _T_24; //@ fifo.py:72
    wire [3:0] _T_25; //@ fifo.py:72
    wire  _T_26; //@ fifo.py:72
    wire [31:0] _T_27; //@ fifo.py:72
    wire  _T_28; //@ fifo.py:72
    wire [31:0] _T_29; //@ fifo.py:72
    wire [3:0] _T_30; //@ fifo.py:72
    wire  _T_31; //@ fifo.py:72
    wire [3:0] _T_32; //@ fifo.py:72
    wire [3:0] _T_33; //@ fifo.py:72
    wire  _T_34; //@ fifo.py:72
    wire [3:0] _T_35; //@ fifo.py:72
    wire  _T_36; //@ fifo.py:72
    wire [31:0] _T_37; //@ fifo.py:72
    wire  _T_38; //@ fifo.py:72
    wire [31:0] _T_39; //@ fifo.py:72
    wire [3:0] _T_40; //@ fifo.py:72
    wire  _T_41; //@ fifo.py:72
    wire [3:0] _T_42; //@ fifo.py:72
    wire [3:0] _T_43; //@ fifo.py:72
    wire  _T_44; //@ fifo.py:72
    wire [3:0] _T_45; //@ fifo.py:72
    wire  _T_46; //@ fifo.py:72
    wire [31:0] _T_47; //@ fifo.py:72
    wire  _T_48; //@ fifo.py:72
    wire [31:0] _T_49; //@ fifo.py:72
    wire [3:0] _T_50; //@ fifo.py:72
    wire  _T_51; //@ fifo.py:72
    wire [3:0] _T_52; //@ fifo.py:72
    wire [3:0] _T_53; //@ fifo.py:72
    wire  _T_54; //@ fifo.py:72
    wire [3:0] _T_55; //@ fifo.py:72
    wire  _T_56; //@ fifo.py:72
    wire [31:0] _T_57; //@ fifo.py:72
    wire  _T_58; //@ fifo.py:72
    wire [31:0] _T_59; //@ fifo.py:72
    wire [3:0] _T_60; //@ fifo.py:72
    wire  _T_61; //@ fifo.py:72
    wire [3:0] _T_62; //@ fifo.py:72
    wire [3:0] _T_63; //@ fifo.py:72
    wire  _T_64; //@ fifo.py:72
    wire [3:0] _T_65; //@ fifo.py:72
    wire  _T_66; //@ fifo.py:72
    wire [31:0] _T_67; //@ fifo.py:72
    wire  _T_68; //@ fifo.py:72
    wire [31:0] _T_69; //@ fifo.py:72
    wire [3:0] _T_70; //@ fifo.py:72
    wire  _T_71; //@ fifo.py:72
    wire [3:0] _T_72; //@ fifo.py:72
    wire [3:0] _T_73; //@ fifo.py:72
    wire  _T_74; //@ fifo.py:72
    wire [3:0] _T_75; //@ fifo.py:72
    wire  _T_76; //@ fifo.py:72
    wire [31:0] _T_77; //@ fifo.py:72
    wire  _T_78; //@ fifo.py:72
    wire [31:0] _T_79; //@ fifo.py:72
    wire [3:0] _T_80; //@ fifo.py:72
    wire  _T_81; //@ fifo.py:72
    wire [3:0] _T_82; //@ fifo.py:72
    wire [3:0] _T_83; //@ fifo.py:72
    wire  _T_84; //@ fifo.py:72
    wire [3:0] _T_85; //@ fifo.py:72
    wire  _T_86; //@ counters.py:27
    wire [3:0] _T_87; //@ counters.py:28
    wire [2:0] _T_88; //@ counters.py:28
    wire [3:0] _T_89; //@ counters.py:28
    wire [2:0] _T_90; //@ counters.py:28
    wire [2:0] _T_91; //@ counters.py:28
    wire  _T_92; //@ counters.py:27
    wire [3:0] _T_93; //@ counters.py:28
    wire [2:0] _T_94; //@ counters.py:28
    wire [3:0] _T_95; //@ counters.py:28
    wire [2:0] _T_96; //@ counters.py:28
    wire [2:0] _T_97; //@ counters.py:28
    wire  _T_98; //@ fifo.py:76
    wire  _T_99; //@ fifo.py:77
    wire  _T_100; //@ fifo.py:77
    wire  _T_101; //@ fifo.py:79
    wire  _T_102; //@ fifo.py:80
    wire [3:0] _T_103_op; //@ demo_utils_queue.py:6
    wire [3:0] _T_103_address; //@ demo_utils_queue.py:7
    wire [31:0] _T_103_data; //@ demo_utils_queue.py:8
    wire  _T_104; //@ fifo.py:81
    wire [3:0] _T_105; //@ fifo.py:81
    wire [3:0] _T_106; //@ fifo.py:81
    wire  _T_107; //@ fifo.py:81
    wire [3:0] _T_108; //@ fifo.py:81
    wire [3:0] _T_109; //@ fifo.py:81
    wire [3:0] _T_110; //@ fifo.py:81
    wire  _T_111; //@ fifo.py:81
    wire [3:0] _T_112; //@ fifo.py:81
    wire [3:0] _T_113; //@ fifo.py:81
    wire [3:0] _T_114; //@ fifo.py:81
    wire  _T_115; //@ fifo.py:81
    wire [3:0] _T_116; //@ fifo.py:81
    wire [3:0] _T_117; //@ fifo.py:81
    wire [3:0] _T_118; //@ fifo.py:81
    wire  _T_119; //@ fifo.py:81
    wire [3:0] _T_120; //@ fifo.py:81
    wire [3:0] _T_121; //@ fifo.py:81
    wire [3:0] _T_122; //@ fifo.py:81
    wire  _T_123; //@ fifo.py:81
    wire [3:0] _T_124; //@ fifo.py:81
    wire [3:0] _T_125; //@ fifo.py:81
    wire [3:0] _T_126; //@ fifo.py:81
    wire  _T_127; //@ fifo.py:81
    wire [3:0] _T_128; //@ fifo.py:81
    wire [3:0] _T_129; //@ fifo.py:81
    wire [3:0] _T_130; //@ fifo.py:81
    wire  _T_131; //@ fifo.py:81
    wire [3:0] _T_132; //@ fifo.py:81
    wire [3:0] _T_133; //@ fifo.py:81
    wire [3:0] _T_134; //@ fifo.py:81
    wire  _T_135; //@ fifo.py:81
    wire [3:0] _T_136; //@ fifo.py:81
    wire [3:0] _T_137; //@ fifo.py:81
    wire  _T_138; //@ fifo.py:81
    wire [3:0] _T_139; //@ fifo.py:81
    wire [3:0] _T_140; //@ fifo.py:81
    wire [3:0] _T_141; //@ fifo.py:81
    wire  _T_142; //@ fifo.py:81
    wire [3:0] _T_143; //@ fifo.py:81
    wire [3:0] _T_144; //@ fifo.py:81
    wire [3:0] _T_145; //@ fifo.py:81
    wire  _T_146; //@ fifo.py:81
    wire [3:0] _T_147; //@ fifo.py:81
    wire [3:0] _T_148; //@ fifo.py:81
    wire [3:0] _T_149; //@ fifo.py:81
    wire  _T_150; //@ fifo.py:81
    wire [3:0] _T_151; //@ fifo.py:81
    wire [3:0] _T_152; //@ fifo.py:81
    wire [3:0] _T_153; //@ fifo.py:81
    wire  _T_154; //@ fifo.py:81
    wire [3:0] _T_155; //@ fifo.py:81
    wire [3:0] _T_156; //@ fifo.py:81
    wire [3:0] _T_157; //@ fifo.py:81
    wire  _T_158; //@ fifo.py:81
    wire [3:0] _T_159; //@ fifo.py:81
    wire [3:0] _T_160; //@ fifo.py:81
    wire [3:0] _T_161; //@ fifo.py:81
    wire  _T_162; //@ fifo.py:81
    wire [3:0] _T_163; //@ fifo.py:81
    wire [3:0] _T_164; //@ fifo.py:81
    wire [3:0] _T_165; //@ fifo.py:81
    wire  _T_166; //@ fifo.py:81
    wire [31:0] _T_167; //@ fifo.py:81
    wire [31:0] _T_168; //@ fifo.py:81
    wire  _T_169; //@ fifo.py:81
    wire [31:0] _T_170; //@ fifo.py:81
    wire [31:0] _T_171; //@ fifo.py:81
    wire [31:0] _T_172; //@ fifo.py:81
    wire  _T_173; //@ fifo.py:81
    wire [31:0] _T_174; //@ fifo.py:81
    wire [31:0] _T_175; //@ fifo.py:81
    wire [31:0] _T_176; //@ fifo.py:81
    wire  _T_177; //@ fifo.py:81
    wire [31:0] _T_178; //@ fifo.py:81
    wire [31:0] _T_179; //@ fifo.py:81
    wire [31:0] _T_180; //@ fifo.py:81
    wire  _T_181; //@ fifo.py:81
    wire [31:0] _T_182; //@ fifo.py:81
    wire [31:0] _T_183; //@ fifo.py:81
    wire [31:0] _T_184; //@ fifo.py:81
    wire  _T_185; //@ fifo.py:81
    wire [31:0] _T_186; //@ fifo.py:81
    wire [31:0] _T_187; //@ fifo.py:81
    wire [31:0] _T_188; //@ fifo.py:81
    wire  _T_189; //@ fifo.py:81
    wire [31:0] _T_190; //@ fifo.py:81
    wire [31:0] _T_191; //@ fifo.py:81
    wire [31:0] _T_192; //@ fifo.py:81
    wire  _T_193; //@ fifo.py:81
    wire [31:0] _T_194; //@ fifo.py:81
    wire [31:0] _T_195; //@ fifo.py:81
    wire [31:0] _T_196; //@ fifo.py:81
    wire [3:0] _T_197; //@ fifo.py:96
    wire  _T_198; //@ fifo.py:99
    wire [2:0] _T_199; //@ fifo.py:100
    wire [3:0] _T_200; //@ fifo.py:100
    always @(posedge clock) //@ fifo.py:60
        ram_0_op_o <= ram_0_op_i;
    always @(posedge clock) //@ fifo.py:60
        ram_0_address_o <= ram_0_address_i;
    always @(posedge clock) //@ fifo.py:60
        ram_0_data_o <= ram_0_data_i;
    always @(posedge clock) //@ fifo.py:60
        ram_1_op_o <= ram_1_op_i;
    always @(posedge clock) //@ fifo.py:60
        ram_1_address_o <= ram_1_address_i;
    always @(posedge clock) //@ fifo.py:60
        ram_1_data_o <= ram_1_data_i;
    always @(posedge clock) //@ fifo.py:60
        ram_2_op_o <= ram_2_op_i;
    always @(posedge clock) //@ fifo.py:60
        ram_2_address_o <= ram_2_address_i;
    always @(posedge clock) //@ fifo.py:60
        ram_2_data_o <= ram_2_data_i;
    always @(posedge clock) //@ fifo.py:60
        ram_3_op_o <= ram_3_op_i;
    always @(posedge clock) //@ fifo.py:60
        ram_3_address_o <= ram_3_address_i;
    always @(posedge clock) //@ fifo.py:60
        ram_3_data_o <= ram_3_data_i;
    always @(posedge clock) //@ fifo.py:60
        ram_4_op_o <= ram_4_op_i;
    always @(posedge clock) //@ fifo.py:60
        ram_4_address_o <= ram_4_address_i;
    always @(posedge clock) //@ fifo.py:60
        ram_4_data_o <= ram_4_data_i;
    always @(posedge clock) //@ fifo.py:60
        ram_5_op_o <= ram_5_op_i;
    always @(posedge clock) //@ fifo.py:60
        ram_5_address_o <= ram_5_address_i;
    always @(posedge clock) //@ fifo.py:60
        ram_5_data_o <= ram_5_data_i;
    always @(posedge clock) //@ fifo.py:60
        ram_6_op_o <= ram_6_op_i;
    always @(posedge clock) //@ fifo.py:60
        ram_6_address_o <= ram_6_address_i;
    always @(posedge clock) //@ fifo.py:60
        ram_6_data_o <= ram_6_data_i;
    always @(posedge clock) //@ fifo.py:60
        ram_7_op_o <= ram_7_op_i;
    always @(posedge clock) //@ fifo.py:60
        ram_7_address_o <= ram_7_address_i;
    always @(posedge clock) //@ fifo.py:60
        ram_7_data_o <= ram_7_data_i;
    always @(posedge clock) //@ counters.py:17
        if (reset)
            enq_ptr_value_o <= 3'h0;
        else
            enq_ptr_value_o <= enq_ptr_value_i;
    always @(posedge clock) //@ counters.py:17
        if (reset)
            deq_ptr_value_o <= 3'h0;
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
    assign _T_6 = (enq_ptr_value_o == 3'h0); //@ fifo.py:72
    assign _T_8 = (do_enq & _T_6); //@ fifo.py:72
    assign _T_9 = (_T_8 ? io_enq_bits_data : ram_0_data_o); //@ fifo.py:72
    assign _T_7 = _T_9; //@ fifo.py:72
    assign ram_0_data_i = _T_7; //@ fifo.py:72
    assign _T_11 = (do_enq & _T_6); //@ fifo.py:72
    assign _T_12 = (_T_11 ? io_enq_bits_address : ram_0_address_o); //@ fifo.py:72
    assign _T_10 = _T_12; //@ fifo.py:72
    assign ram_0_address_i = _T_10; //@ fifo.py:72
    assign _T_14 = (do_enq & _T_6); //@ fifo.py:72
    assign _T_15 = (_T_14 ? io_enq_bits_op : ram_0_op_o); //@ fifo.py:72
    assign _T_13 = _T_15; //@ fifo.py:72
    assign ram_0_op_i = _T_13; //@ fifo.py:72
    assign _T_16 = (enq_ptr_value_o == 3'h1); //@ fifo.py:72
    assign _T_18 = (do_enq & _T_16); //@ fifo.py:72
    assign _T_19 = (_T_18 ? io_enq_bits_data : ram_1_data_o); //@ fifo.py:72
    assign _T_17 = _T_19; //@ fifo.py:72
    assign ram_1_data_i = _T_17; //@ fifo.py:72
    assign _T_21 = (do_enq & _T_16); //@ fifo.py:72
    assign _T_22 = (_T_21 ? io_enq_bits_address : ram_1_address_o); //@ fifo.py:72
    assign _T_20 = _T_22; //@ fifo.py:72
    assign ram_1_address_i = _T_20; //@ fifo.py:72
    assign _T_24 = (do_enq & _T_16); //@ fifo.py:72
    assign _T_25 = (_T_24 ? io_enq_bits_op : ram_1_op_o); //@ fifo.py:72
    assign _T_23 = _T_25; //@ fifo.py:72
    assign ram_1_op_i = _T_23; //@ fifo.py:72
    assign _T_26 = (enq_ptr_value_o == 3'h2); //@ fifo.py:72
    assign _T_28 = (do_enq & _T_26); //@ fifo.py:72
    assign _T_29 = (_T_28 ? io_enq_bits_data : ram_2_data_o); //@ fifo.py:72
    assign _T_27 = _T_29; //@ fifo.py:72
    assign ram_2_data_i = _T_27; //@ fifo.py:72
    assign _T_31 = (do_enq & _T_26); //@ fifo.py:72
    assign _T_32 = (_T_31 ? io_enq_bits_address : ram_2_address_o); //@ fifo.py:72
    assign _T_30 = _T_32; //@ fifo.py:72
    assign ram_2_address_i = _T_30; //@ fifo.py:72
    assign _T_34 = (do_enq & _T_26); //@ fifo.py:72
    assign _T_35 = (_T_34 ? io_enq_bits_op : ram_2_op_o); //@ fifo.py:72
    assign _T_33 = _T_35; //@ fifo.py:72
    assign ram_2_op_i = _T_33; //@ fifo.py:72
    assign _T_36 = (enq_ptr_value_o == 3'h3); //@ fifo.py:72
    assign _T_38 = (do_enq & _T_36); //@ fifo.py:72
    assign _T_39 = (_T_38 ? io_enq_bits_data : ram_3_data_o); //@ fifo.py:72
    assign _T_37 = _T_39; //@ fifo.py:72
    assign ram_3_data_i = _T_37; //@ fifo.py:72
    assign _T_41 = (do_enq & _T_36); //@ fifo.py:72
    assign _T_42 = (_T_41 ? io_enq_bits_address : ram_3_address_o); //@ fifo.py:72
    assign _T_40 = _T_42; //@ fifo.py:72
    assign ram_3_address_i = _T_40; //@ fifo.py:72
    assign _T_44 = (do_enq & _T_36); //@ fifo.py:72
    assign _T_45 = (_T_44 ? io_enq_bits_op : ram_3_op_o); //@ fifo.py:72
    assign _T_43 = _T_45; //@ fifo.py:72
    assign ram_3_op_i = _T_43; //@ fifo.py:72
    assign _T_46 = (enq_ptr_value_o == 3'h4); //@ fifo.py:72
    assign _T_48 = (do_enq & _T_46); //@ fifo.py:72
    assign _T_49 = (_T_48 ? io_enq_bits_data : ram_4_data_o); //@ fifo.py:72
    assign _T_47 = _T_49; //@ fifo.py:72
    assign ram_4_data_i = _T_47; //@ fifo.py:72
    assign _T_51 = (do_enq & _T_46); //@ fifo.py:72
    assign _T_52 = (_T_51 ? io_enq_bits_address : ram_4_address_o); //@ fifo.py:72
    assign _T_50 = _T_52; //@ fifo.py:72
    assign ram_4_address_i = _T_50; //@ fifo.py:72
    assign _T_54 = (do_enq & _T_46); //@ fifo.py:72
    assign _T_55 = (_T_54 ? io_enq_bits_op : ram_4_op_o); //@ fifo.py:72
    assign _T_53 = _T_55; //@ fifo.py:72
    assign ram_4_op_i = _T_53; //@ fifo.py:72
    assign _T_56 = (enq_ptr_value_o == 3'h5); //@ fifo.py:72
    assign _T_58 = (do_enq & _T_56); //@ fifo.py:72
    assign _T_59 = (_T_58 ? io_enq_bits_data : ram_5_data_o); //@ fifo.py:72
    assign _T_57 = _T_59; //@ fifo.py:72
    assign ram_5_data_i = _T_57; //@ fifo.py:72
    assign _T_61 = (do_enq & _T_56); //@ fifo.py:72
    assign _T_62 = (_T_61 ? io_enq_bits_address : ram_5_address_o); //@ fifo.py:72
    assign _T_60 = _T_62; //@ fifo.py:72
    assign ram_5_address_i = _T_60; //@ fifo.py:72
    assign _T_64 = (do_enq & _T_56); //@ fifo.py:72
    assign _T_65 = (_T_64 ? io_enq_bits_op : ram_5_op_o); //@ fifo.py:72
    assign _T_63 = _T_65; //@ fifo.py:72
    assign ram_5_op_i = _T_63; //@ fifo.py:72
    assign _T_66 = (enq_ptr_value_o == 3'h6); //@ fifo.py:72
    assign _T_68 = (do_enq & _T_66); //@ fifo.py:72
    assign _T_69 = (_T_68 ? io_enq_bits_data : ram_6_data_o); //@ fifo.py:72
    assign _T_67 = _T_69; //@ fifo.py:72
    assign ram_6_data_i = _T_67; //@ fifo.py:72
    assign _T_71 = (do_enq & _T_66); //@ fifo.py:72
    assign _T_72 = (_T_71 ? io_enq_bits_address : ram_6_address_o); //@ fifo.py:72
    assign _T_70 = _T_72; //@ fifo.py:72
    assign ram_6_address_i = _T_70; //@ fifo.py:72
    assign _T_74 = (do_enq & _T_66); //@ fifo.py:72
    assign _T_75 = (_T_74 ? io_enq_bits_op : ram_6_op_o); //@ fifo.py:72
    assign _T_73 = _T_75; //@ fifo.py:72
    assign ram_6_op_i = _T_73; //@ fifo.py:72
    assign _T_76 = (enq_ptr_value_o == 3'h7); //@ fifo.py:72
    assign _T_78 = (do_enq & _T_76); //@ fifo.py:72
    assign _T_79 = (_T_78 ? io_enq_bits_data : ram_7_data_o); //@ fifo.py:72
    assign _T_77 = _T_79; //@ fifo.py:72
    assign ram_7_data_i = _T_77; //@ fifo.py:72
    assign _T_81 = (do_enq & _T_76); //@ fifo.py:72
    assign _T_82 = (_T_81 ? io_enq_bits_address : ram_7_address_o); //@ fifo.py:72
    assign _T_80 = _T_82; //@ fifo.py:72
    assign ram_7_address_i = _T_80; //@ fifo.py:72
    assign _T_84 = (do_enq & _T_76); //@ fifo.py:72
    assign _T_85 = (_T_84 ? io_enq_bits_op : ram_7_op_o); //@ fifo.py:72
    assign _T_83 = _T_85; //@ fifo.py:72
    assign ram_7_op_i = _T_83; //@ fifo.py:72
    assign _T_86 = (enq_ptr_value_o == 3'h7); //@ counters.py:27
    assign _T_87 = (enq_ptr_value_o + 3'h1); //@ counters.py:28
    assign _T_89 = (do_enq ? _T_87 : enq_ptr_value_o); //@ counters.py:28
    assign _T_91 = _T_89[2:0]; //@ counters.py:28
    assign _T_90 = _T_91; //@ counters.py:28
    assign _T_88 = _T_90; //@ counters.py:28
    assign enq_ptr_value_i = _T_88; //@ counters.py:28
    assign _T_92 = (deq_ptr_value_o == 3'h7); //@ counters.py:27
    assign _T_93 = (deq_ptr_value_o + 3'h1); //@ counters.py:28
    assign _T_95 = (do_deq ? _T_93 : deq_ptr_value_o); //@ counters.py:28
    assign _T_97 = _T_95[2:0]; //@ counters.py:28
    assign _T_96 = _T_97; //@ counters.py:28
    assign _T_94 = _T_96; //@ counters.py:28
    assign deq_ptr_value_i = _T_94; //@ counters.py:28
    assign _T_98 = (do_enq != do_deq); //@ fifo.py:76
    assign _T_100 = (_T_98 ? do_enq : maybe_full_o); //@ fifo.py:77
    assign _T_99 = _T_100; //@ fifo.py:77
    assign maybe_full_i = _T_99; //@ fifo.py:77
    assign _T_101 = ~_T_2; //@ fifo.py:79
    assign io_deq_valid = _T_101; //@ fifo.py:79
    assign _T_102 = ~_T_3; //@ fifo.py:80
    assign io_enq_ready = _T_102; //@ fifo.py:80
    assign _T_104 = (deq_ptr_value_o == 3'h0); //@ fifo.py:81
    assign _T_105 = {3'h4{_T_104}}; //@ fifo.py:81
    assign _T_106 = (_T_105 & ram_0_op_o); //@ fifo.py:81
    assign _T_107 = (deq_ptr_value_o == 3'h1); //@ fifo.py:81
    assign _T_108 = {3'h4{_T_107}}; //@ fifo.py:81
    assign _T_109 = (_T_108 & ram_1_op_o); //@ fifo.py:81
    assign _T_110 = (_T_106 | _T_109); //@ fifo.py:81
    assign _T_111 = (deq_ptr_value_o == 3'h2); //@ fifo.py:81
    assign _T_112 = {3'h4{_T_111}}; //@ fifo.py:81
    assign _T_113 = (_T_112 & ram_2_op_o); //@ fifo.py:81
    assign _T_114 = (_T_110 | _T_113); //@ fifo.py:81
    assign _T_115 = (deq_ptr_value_o == 3'h3); //@ fifo.py:81
    assign _T_116 = {3'h4{_T_115}}; //@ fifo.py:81
    assign _T_117 = (_T_116 & ram_3_op_o); //@ fifo.py:81
    assign _T_118 = (_T_114 | _T_117); //@ fifo.py:81
    assign _T_119 = (deq_ptr_value_o == 3'h4); //@ fifo.py:81
    assign _T_120 = {3'h4{_T_119}}; //@ fifo.py:81
    assign _T_121 = (_T_120 & ram_4_op_o); //@ fifo.py:81
    assign _T_122 = (_T_118 | _T_121); //@ fifo.py:81
    assign _T_123 = (deq_ptr_value_o == 3'h5); //@ fifo.py:81
    assign _T_124 = {3'h4{_T_123}}; //@ fifo.py:81
    assign _T_125 = (_T_124 & ram_5_op_o); //@ fifo.py:81
    assign _T_126 = (_T_122 | _T_125); //@ fifo.py:81
    assign _T_127 = (deq_ptr_value_o == 3'h6); //@ fifo.py:81
    assign _T_128 = {3'h4{_T_127}}; //@ fifo.py:81
    assign _T_129 = (_T_128 & ram_6_op_o); //@ fifo.py:81
    assign _T_130 = (_T_126 | _T_129); //@ fifo.py:81
    assign _T_131 = (deq_ptr_value_o == 3'h7); //@ fifo.py:81
    assign _T_132 = {3'h4{_T_131}}; //@ fifo.py:81
    assign _T_133 = (_T_132 & ram_7_op_o); //@ fifo.py:81
    assign _T_134 = (_T_130 | _T_133); //@ fifo.py:81
    assign _T_103_op = _T_134; //@ fifo.py:81
    assign _T_135 = (deq_ptr_value_o == 3'h0); //@ fifo.py:81
    assign _T_136 = {3'h4{_T_135}}; //@ fifo.py:81
    assign _T_137 = (_T_136 & ram_0_address_o); //@ fifo.py:81
    assign _T_138 = (deq_ptr_value_o == 3'h1); //@ fifo.py:81
    assign _T_139 = {3'h4{_T_138}}; //@ fifo.py:81
    assign _T_140 = (_T_139 & ram_1_address_o); //@ fifo.py:81
    assign _T_141 = (_T_137 | _T_140); //@ fifo.py:81
    assign _T_142 = (deq_ptr_value_o == 3'h2); //@ fifo.py:81
    assign _T_143 = {3'h4{_T_142}}; //@ fifo.py:81
    assign _T_144 = (_T_143 & ram_2_address_o); //@ fifo.py:81
    assign _T_145 = (_T_141 | _T_144); //@ fifo.py:81
    assign _T_146 = (deq_ptr_value_o == 3'h3); //@ fifo.py:81
    assign _T_147 = {3'h4{_T_146}}; //@ fifo.py:81
    assign _T_148 = (_T_147 & ram_3_address_o); //@ fifo.py:81
    assign _T_149 = (_T_145 | _T_148); //@ fifo.py:81
    assign _T_150 = (deq_ptr_value_o == 3'h4); //@ fifo.py:81
    assign _T_151 = {3'h4{_T_150}}; //@ fifo.py:81
    assign _T_152 = (_T_151 & ram_4_address_o); //@ fifo.py:81
    assign _T_153 = (_T_149 | _T_152); //@ fifo.py:81
    assign _T_154 = (deq_ptr_value_o == 3'h5); //@ fifo.py:81
    assign _T_155 = {3'h4{_T_154}}; //@ fifo.py:81
    assign _T_156 = (_T_155 & ram_5_address_o); //@ fifo.py:81
    assign _T_157 = (_T_153 | _T_156); //@ fifo.py:81
    assign _T_158 = (deq_ptr_value_o == 3'h6); //@ fifo.py:81
    assign _T_159 = {3'h4{_T_158}}; //@ fifo.py:81
    assign _T_160 = (_T_159 & ram_6_address_o); //@ fifo.py:81
    assign _T_161 = (_T_157 | _T_160); //@ fifo.py:81
    assign _T_162 = (deq_ptr_value_o == 3'h7); //@ fifo.py:81
    assign _T_163 = {3'h4{_T_162}}; //@ fifo.py:81
    assign _T_164 = (_T_163 & ram_7_address_o); //@ fifo.py:81
    assign _T_165 = (_T_161 | _T_164); //@ fifo.py:81
    assign _T_103_address = _T_165; //@ fifo.py:81
    assign _T_166 = (deq_ptr_value_o == 3'h0); //@ fifo.py:81
    assign _T_167 = {6'h20{_T_166}}; //@ fifo.py:81
    assign _T_168 = (_T_167 & ram_0_data_o); //@ fifo.py:81
    assign _T_169 = (deq_ptr_value_o == 3'h1); //@ fifo.py:81
    assign _T_170 = {6'h20{_T_169}}; //@ fifo.py:81
    assign _T_171 = (_T_170 & ram_1_data_o); //@ fifo.py:81
    assign _T_172 = (_T_168 | _T_171); //@ fifo.py:81
    assign _T_173 = (deq_ptr_value_o == 3'h2); //@ fifo.py:81
    assign _T_174 = {6'h20{_T_173}}; //@ fifo.py:81
    assign _T_175 = (_T_174 & ram_2_data_o); //@ fifo.py:81
    assign _T_176 = (_T_172 | _T_175); //@ fifo.py:81
    assign _T_177 = (deq_ptr_value_o == 3'h3); //@ fifo.py:81
    assign _T_178 = {6'h20{_T_177}}; //@ fifo.py:81
    assign _T_179 = (_T_178 & ram_3_data_o); //@ fifo.py:81
    assign _T_180 = (_T_176 | _T_179); //@ fifo.py:81
    assign _T_181 = (deq_ptr_value_o == 3'h4); //@ fifo.py:81
    assign _T_182 = {6'h20{_T_181}}; //@ fifo.py:81
    assign _T_183 = (_T_182 & ram_4_data_o); //@ fifo.py:81
    assign _T_184 = (_T_180 | _T_183); //@ fifo.py:81
    assign _T_185 = (deq_ptr_value_o == 3'h5); //@ fifo.py:81
    assign _T_186 = {6'h20{_T_185}}; //@ fifo.py:81
    assign _T_187 = (_T_186 & ram_5_data_o); //@ fifo.py:81
    assign _T_188 = (_T_184 | _T_187); //@ fifo.py:81
    assign _T_189 = (deq_ptr_value_o == 3'h6); //@ fifo.py:81
    assign _T_190 = {6'h20{_T_189}}; //@ fifo.py:81
    assign _T_191 = (_T_190 & ram_6_data_o); //@ fifo.py:81
    assign _T_192 = (_T_188 | _T_191); //@ fifo.py:81
    assign _T_193 = (deq_ptr_value_o == 3'h7); //@ fifo.py:81
    assign _T_194 = {6'h20{_T_193}}; //@ fifo.py:81
    assign _T_195 = (_T_194 & ram_7_data_o); //@ fifo.py:81
    assign _T_196 = (_T_192 | _T_195); //@ fifo.py:81
    assign _T_103_data = _T_196; //@ fifo.py:81
    assign io_deq_bits_data = _T_103_data; //@ fifo.py:81
    assign io_deq_bits_address = _T_103_address; //@ fifo.py:81
    assign io_deq_bits_op = _T_103_op; //@ fifo.py:81
    assign _T_197 = (enq_ptr_value_o - deq_ptr_value_o); //@ fifo.py:96
    assign _T_198 = (maybe_full_o & _T_0); //@ fifo.py:99
    assign _T_199 = _T_197[2:0]; //@ fifo.py:100
    assign _T_200 = {_T_198, _T_199}; //@ fifo.py:100
    assign io_count = _T_200; //@ fifo.py:100
endmodule
