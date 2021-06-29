module utils_async_queue_top(
    input  wire  io_enq_clock, //@ demo_utils_async_queue.py:13
    input  wire  io_enq_reset, //@ demo_utils_async_queue.py:14
    input  wire  io_deq_clock, //@ demo_utils_async_queue.py:15
    input  wire  io_deq_reset, //@ demo_utils_async_queue.py:16
    input  wire  io_flush, //@ demo_utils_async_queue.py:17
    input  wire  clock, //@ phgl_generator.py:85
    input  wire  reset  //@ phgl_generator.py:85
);
    wire [3:0] enq_address_i; //@ demo_utils_async_queue.py:22
    reg  [3:0] enq_address_o; //@ demo_utils_async_queue.py:22
    wire  deq_ready_i; //@ demo_utils_async_queue.py:23
    reg   deq_ready_o; //@ demo_utils_async_queue.py:23
    wire  fifo0_io_enq_ready; //@ demo_utils_async_queue.py:25
    wire  fifo0_io_enq_valid; //@ demo_utils_async_queue.py:25
    wire [3:0] fifo0_io_enq_bits_op; //@ demo_utils_async_queue.py:25
    wire [3:0] fifo0_io_enq_bits_address; //@ demo_utils_async_queue.py:25
    wire [31:0] fifo0_io_enq_bits_data; //@ demo_utils_async_queue.py:25
    wire  fifo0_io_deq_ready; //@ demo_utils_async_queue.py:25
    wire  fifo0_io_deq_valid; //@ demo_utils_async_queue.py:25
    wire [3:0] fifo0_io_deq_bits_op; //@ demo_utils_async_queue.py:25
    wire [3:0] fifo0_io_deq_bits_address; //@ demo_utils_async_queue.py:25
    wire [31:0] fifo0_io_deq_bits_data; //@ demo_utils_async_queue.py:25
    wire [3:0] fifo0_io_count; //@ demo_utils_async_queue.py:25
    wire  fifo0_io_flush; //@ demo_utils_async_queue.py:25
    wire  fifo0_io_enq_clock; //@ demo_utils_async_queue.py:25
    wire  fifo0_io_enq_reset; //@ demo_utils_async_queue.py:25
    wire  fifo0_io_deq_clock; //@ demo_utils_async_queue.py:25
    wire  fifo0_io_deq_reset; //@ demo_utils_async_queue.py:25
    wire  fifo0_clock; //@ demo_utils_async_queue.py:25
    wire  fifo0_reset; //@ demo_utils_async_queue.py:25
    wire  _T_0; //@ demo_utils_async_queue.py:36
    wire [4:0] _T_1; //@ demo_utils_async_queue.py:38
    wire [3:0] _T_2; //@ demo_utils_async_queue.py:38
    wire [4:0] _T_3; //@ demo_utils_async_queue.py:38
    wire [3:0] _T_4; //@ demo_utils_async_queue.py:38
    wire [3:0] _T_5; //@ demo_utils_async_queue.py:38
    always @(posedge io_enq_clock) //@ demo_utils_async_queue.py:22
        if (io_enq_reset)
            enq_address_o <= 4'h0;
        else
            enq_address_o <= enq_address_i;
    always @(posedge io_deq_clock) //@ demo_utils_async_queue.py:23
        if (io_deq_reset)
            deq_ready_o <= 1'h0;
        else
            deq_ready_o <= deq_ready_i;
    async_queue fifo0( //@ demo_utils_async_queue.py:25
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
        .io_flush(fifo0_io_flush),
        .io_enq_clock(fifo0_io_enq_clock),
        .io_enq_reset(fifo0_io_enq_reset),
        .io_deq_clock(fifo0_io_deq_clock),
        .io_deq_reset(fifo0_io_deq_reset),
        .clock(fifo0_clock),
        .reset(fifo0_reset)
    );
    assign fifo0_clock = clock; //@ demo_utils_async_queue.py:25
    assign fifo0_reset = reset; //@ demo_utils_async_queue.py:25
    assign fifo0_io_enq_clock = io_enq_clock; //@ demo_utils_async_queue.py:26
    assign fifo0_io_enq_reset = io_enq_reset; //@ demo_utils_async_queue.py:27
    assign fifo0_io_enq_valid = 1'h1; //@ demo_utils_async_queue.py:28
    assign fifo0_io_enq_bits_address = enq_address_o; //@ demo_utils_async_queue.py:29
    assign fifo0_io_enq_bits_data = 32'h0; //@ demo_utils_async_queue.py:30
    assign fifo0_io_deq_clock = io_deq_clock; //@ demo_utils_async_queue.py:31
    assign fifo0_io_deq_reset = io_deq_reset; //@ demo_utils_async_queue.py:32
    assign fifo0_io_deq_ready = deq_ready_o; //@ demo_utils_async_queue.py:33
    assign fifo0_io_flush = io_flush; //@ demo_utils_async_queue.py:34
    assign _T_0 = (fifo0_io_enq_ready & fifo0_io_enq_valid); //@ demo_utils_async_queue.py:36
    assign _T_1 = (enq_address_o + 4'h1); //@ demo_utils_async_queue.py:38
    assign _T_3 = (_T_0 ? _T_1 : enq_address_o); //@ demo_utils_async_queue.py:38
    assign _T_5 = _T_3[3:0]; //@ demo_utils_async_queue.py:38
    assign _T_4 = _T_5; //@ demo_utils_async_queue.py:38
    assign _T_2 = _T_4; //@ demo_utils_async_queue.py:38
    assign enq_address_i = _T_2; //@ demo_utils_async_queue.py:38
    assign deq_ready_i = 1'h1; //@ demo_utils_async_queue.py:40
endmodule
module async_queue(
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
    input  wire  io_flush, //@ fifo.py:26
    input  wire  io_enq_clock, //@ fifo.py:480
    input  wire  io_enq_reset, //@ fifo.py:481
    input  wire  io_deq_clock, //@ fifo.py:482
    input  wire  io_deq_reset, //@ fifo.py:483
    input  wire  clock, //@ demo_utils_async_queue.py:25
    input  wire  reset  //@ demo_utils_async_queue.py:25
);
    wire  _T_0_i; //@ fifo.py:506
    reg   _T_0_o; //@ fifo.py:506
    wire  _T_1_i; //@ fifo.py:506
    reg   _T_1_o; //@ fifo.py:506
    wire  _T_2_i; //@ fifo.py:506
    reg   _T_2_o; //@ fifo.py:506
    wire  _T_3_i; //@ fifo.py:511
    reg   _T_3_o; //@ fifo.py:511
    wire  _T_4_i; //@ fifo.py:511
    reg   _T_4_o; //@ fifo.py:511
    wire  _T_5_i; //@ fifo.py:511
    reg   _T_5_o; //@ fifo.py:511
    wire [3:0] ram_0_op_i; //@ fifo.py:519
    reg  [3:0] ram_0_op_o; //@ fifo.py:519
    wire [3:0] ram_0_address_i; //@ fifo.py:519
    reg  [3:0] ram_0_address_o; //@ fifo.py:519
    wire [31:0] ram_0_data_i; //@ fifo.py:519
    reg  [31:0] ram_0_data_o; //@ fifo.py:519
    wire [3:0] ram_1_op_i; //@ fifo.py:519
    reg  [3:0] ram_1_op_o; //@ fifo.py:519
    wire [3:0] ram_1_address_i; //@ fifo.py:519
    reg  [3:0] ram_1_address_o; //@ fifo.py:519
    wire [31:0] ram_1_data_i; //@ fifo.py:519
    reg  [31:0] ram_1_data_o; //@ fifo.py:519
    wire [3:0] ram_2_op_i; //@ fifo.py:519
    reg  [3:0] ram_2_op_o; //@ fifo.py:519
    wire [3:0] ram_2_address_i; //@ fifo.py:519
    reg  [3:0] ram_2_address_o; //@ fifo.py:519
    wire [31:0] ram_2_data_i; //@ fifo.py:519
    reg  [31:0] ram_2_data_o; //@ fifo.py:519
    wire [3:0] ram_3_op_i; //@ fifo.py:519
    reg  [3:0] ram_3_op_o; //@ fifo.py:519
    wire [3:0] ram_3_address_i; //@ fifo.py:519
    reg  [3:0] ram_3_address_o; //@ fifo.py:519
    wire [31:0] ram_3_data_i; //@ fifo.py:519
    reg  [31:0] ram_3_data_o; //@ fifo.py:519
    wire [3:0] ram_4_op_i; //@ fifo.py:519
    reg  [3:0] ram_4_op_o; //@ fifo.py:519
    wire [3:0] ram_4_address_i; //@ fifo.py:519
    reg  [3:0] ram_4_address_o; //@ fifo.py:519
    wire [31:0] ram_4_data_i; //@ fifo.py:519
    reg  [31:0] ram_4_data_o; //@ fifo.py:519
    wire [3:0] ram_5_op_i; //@ fifo.py:519
    reg  [3:0] ram_5_op_o; //@ fifo.py:519
    wire [3:0] ram_5_address_i; //@ fifo.py:519
    reg  [3:0] ram_5_address_o; //@ fifo.py:519
    wire [31:0] ram_5_data_i; //@ fifo.py:519
    reg  [31:0] ram_5_data_o; //@ fifo.py:519
    wire [3:0] ram_6_op_i; //@ fifo.py:519
    reg  [3:0] ram_6_op_o; //@ fifo.py:519
    wire [3:0] ram_6_address_i; //@ fifo.py:519
    reg  [3:0] ram_6_address_o; //@ fifo.py:519
    wire [31:0] ram_6_data_i; //@ fifo.py:519
    reg  [31:0] ram_6_data_o; //@ fifo.py:519
    wire [3:0] ram_7_op_i; //@ fifo.py:519
    reg  [3:0] ram_7_op_o; //@ fifo.py:519
    wire [3:0] ram_7_address_i; //@ fifo.py:519
    reg  [3:0] ram_7_address_o; //@ fifo.py:519
    wire [31:0] ram_7_data_i; //@ fifo.py:519
    reg  [31:0] ram_7_data_o; //@ fifo.py:519
    wire [2:0] rd_ptr_i; //@ fifo.py:524
    reg  [2:0] rd_ptr_o; //@ fifo.py:524
    wire [2:0] wr_ptr_i; //@ fifo.py:529
    reg  [2:0] wr_ptr_o; //@ fifo.py:529
    wire  empty; //@ fifo.py:530
    wire  full; //@ fifo.py:531
    wire [3:0] _T_6; //@ fifo.py:487
    wire [3:0] _T_7; //@ fifo.py:487
    wire [3:0] _T_8; //@ fifo.py:536
    wire  _T_9; //@ fifo.py:536
    wire  _T_10; //@ fifo.py:536
    wire  _T_11; //@ fifo.py:536
    wire  _T_12; //@ fifo.py:536
    wire  _T_13; //@ fifo.py:536
    wire  _T_14; //@ fifo.py:536
    wire  _T_15; //@ fifo.py:536
    wire  _T_16; //@ fifo.py:536
    wire  _T_17; //@ fifo.py:536
    wire [1:0] _T_18; //@ fifo.py:536
    wire [2:0] _T_19; //@ fifo.py:536
    wire [2:0] rd_ptr_gray_dly0_i; //@ fifo.py:542
    reg  [2:0] rd_ptr_gray_dly0_o; //@ fifo.py:542
    wire [2:0] _T_20_i; //@ fifo.py:548
    reg  [2:0] _T_20_o; //@ fifo.py:548
    wire [2:0] _T_21_i; //@ fifo.py:548
    reg  [2:0] _T_21_o; //@ fifo.py:548
    wire [2:0] _T_22_i; //@ fifo.py:548
    reg  [2:0] _T_22_o; //@ fifo.py:548
    wire [3:0] _T_23; //@ fifo.py:549
    wire  _T_24; //@ fifo.py:549
    wire  _T_25; //@ fifo.py:549
    wire  _T_26; //@ fifo.py:549
    wire  _T_27; //@ fifo.py:549
    wire  _T_28; //@ fifo.py:549
    wire  _T_29; //@ fifo.py:549
    wire  _T_30; //@ fifo.py:549
    wire  _T_31; //@ fifo.py:549
    wire  _T_32; //@ fifo.py:549
    wire  _T_33; //@ fifo.py:549
    wire [1:0] _T_34; //@ fifo.py:549
    wire [2:0] _T_35; //@ fifo.py:549
    wire [3:0] _T_36; //@ fifo.py:549
    wire [2:0] _T_37; //@ fifo.py:549
    wire [3:0] _T_38; //@ fifo.py:552
    wire  _T_39; //@ fifo.py:552
    wire  _T_40; //@ fifo.py:552
    wire  _T_41; //@ fifo.py:552
    wire  _T_42; //@ fifo.py:552
    wire  _T_43; //@ fifo.py:552
    wire  _T_44; //@ fifo.py:552
    wire  _T_45; //@ fifo.py:552
    wire  _T_46; //@ fifo.py:552
    wire  _T_47; //@ fifo.py:552
    wire [1:0] _T_48; //@ fifo.py:552
    wire [2:0] _T_49; //@ fifo.py:552
    wire [2:0] wr_ptr_gray_dly0_i; //@ fifo.py:558
    reg  [2:0] wr_ptr_gray_dly0_o; //@ fifo.py:558
    wire [2:0] _T_50_i; //@ fifo.py:564
    reg  [2:0] _T_50_o; //@ fifo.py:564
    wire [2:0] _T_51_i; //@ fifo.py:564
    reg  [2:0] _T_51_o; //@ fifo.py:564
    wire [2:0] _T_52_i; //@ fifo.py:564
    reg  [2:0] _T_52_o; //@ fifo.py:564
    wire [3:0] _T_53; //@ fifo.py:565
    wire  _T_54; //@ fifo.py:565
    wire  _T_55; //@ fifo.py:565
    wire  _T_56; //@ fifo.py:565
    wire  _T_57; //@ fifo.py:565
    wire  _T_58; //@ fifo.py:565
    wire  _T_59; //@ fifo.py:565
    wire  _T_60; //@ fifo.py:565
    wire  _T_61; //@ fifo.py:565
    wire  _T_62; //@ fifo.py:565
    wire  _T_63; //@ fifo.py:565
    wire [1:0] _T_64; //@ fifo.py:565
    wire [2:0] _T_65; //@ fifo.py:565
    wire [3:0] _T_66; //@ fifo.py:565
    wire [2:0] _T_67; //@ fifo.py:565
    wire [3:0] wr_word_count; //@ fifo.py:567
    wire [3:0] rd_word_count; //@ fifo.py:568
    wire  wr_direction_flagwr_i; //@ fifo.py:572
    reg   wr_direction_flagwr_o; //@ fifo.py:572
    wire  wr_direction_flagrd_i; //@ fifo.py:576
    reg   wr_direction_flagrd_o; //@ fifo.py:576
    wire  rd_direction_flagwr_i; //@ fifo.py:580
    reg   rd_direction_flagwr_o; //@ fifo.py:580
    wire  rd_direction_flagrd_i; //@ fifo.py:584
    reg   rd_direction_flagrd_o; //@ fifo.py:584
    wire  _T_68; //@ fifo.py:585
    wire  _T_69; //@ fifo.py:586
    wire  _T_70; //@ fifo.py:587
    wire  _T_71; //@ fifo.py:588
    wire [3:0] _T_72; //@ fifo.py:591
    wire [3:0] _T_73; //@ fifo.py:594
    wire [4:0] _T_74; //@ fifo.py:594
    wire [3:0] _T_75; //@ fifo.py:598
    wire [4:0] _T_76; //@ fifo.py:598
    wire [4:0] _T_77; //@ fifo.py:598
    wire [3:0] _T_78; //@ fifo.py:598
    wire [3:0] _T_79; //@ fifo.py:601
    wire [3:0] _T_80; //@ fifo.py:604
    wire [4:0] _T_81; //@ fifo.py:604
    wire [3:0] _T_82; //@ fifo.py:608
    wire [4:0] _T_83; //@ fifo.py:608
    wire [4:0] _T_84; //@ fifo.py:608
    wire [3:0] _T_85; //@ fifo.py:608
    wire  _T_86; //@ fifo.py:611
    wire  _T_87; //@ fifo.py:613
    wire  _T_88; //@ fifo.py:613
    wire  _T_89; //@ fifo.py:613
    wire  _T_90; //@ fifo.py:615
    wire  _T_91; //@ fifo.py:617
    wire  _T_92; //@ fifo.py:617
    wire  _T_93; //@ fifo.py:617
    wire  _T_94; //@ fifo.py:620
    wire  _T_95; //@ fifo.py:622
    wire  _T_96; //@ fifo.py:622
    wire  _T_97; //@ fifo.py:622
    wire  _T_98; //@ fifo.py:624
    wire  _T_99; //@ fifo.py:626
    wire  _T_100; //@ fifo.py:626
    wire  _T_101; //@ fifo.py:626
    wire  _T_102; //@ fifo.py:628
    wire  _T_103; //@ fifo.py:628
    wire  _T_104; //@ fifo.py:629
    wire  _T_105; //@ fifo.py:629
    wire  _T_106; //@ fifo.py:631
    wire  _T_107; //@ fifo.py:631
    wire  _T_108; //@ fifo.py:631
    wire  _T_109; //@ fifo.py:632
    wire  _T_110; //@ fifo.py:632
    wire  _T_111; //@ fifo.py:632
    wire [3:0] _T_112; //@ fifo.py:634
    wire [2:0] _T_113; //@ fifo.py:634
    wire [2:0] _T_114; //@ fifo.py:634
    wire [3:0] _T_115; //@ fifo.py:635
    wire [2:0] _T_116; //@ fifo.py:635
    wire [2:0] _T_117; //@ fifo.py:635
    wire  _T_118; //@ fifo.py:637
    wire  _T_119; //@ fifo.py:638
    wire  _T_120; //@ fifo.py:639
    wire  _T_121; //@ fifo.py:642
    wire [31:0] _T_122; //@ fifo.py:642
    wire  _T_123; //@ fifo.py:642
    wire [31:0] _T_124; //@ fifo.py:642
    wire [3:0] _T_125; //@ fifo.py:642
    wire  _T_126; //@ fifo.py:642
    wire [3:0] _T_127; //@ fifo.py:642
    wire [3:0] _T_128; //@ fifo.py:642
    wire  _T_129; //@ fifo.py:642
    wire [3:0] _T_130; //@ fifo.py:642
    wire  _T_131; //@ fifo.py:642
    wire [31:0] _T_132; //@ fifo.py:642
    wire  _T_133; //@ fifo.py:642
    wire [31:0] _T_134; //@ fifo.py:642
    wire [3:0] _T_135; //@ fifo.py:642
    wire  _T_136; //@ fifo.py:642
    wire [3:0] _T_137; //@ fifo.py:642
    wire [3:0] _T_138; //@ fifo.py:642
    wire  _T_139; //@ fifo.py:642
    wire [3:0] _T_140; //@ fifo.py:642
    wire  _T_141; //@ fifo.py:642
    wire [31:0] _T_142; //@ fifo.py:642
    wire  _T_143; //@ fifo.py:642
    wire [31:0] _T_144; //@ fifo.py:642
    wire [3:0] _T_145; //@ fifo.py:642
    wire  _T_146; //@ fifo.py:642
    wire [3:0] _T_147; //@ fifo.py:642
    wire [3:0] _T_148; //@ fifo.py:642
    wire  _T_149; //@ fifo.py:642
    wire [3:0] _T_150; //@ fifo.py:642
    wire  _T_151; //@ fifo.py:642
    wire [31:0] _T_152; //@ fifo.py:642
    wire  _T_153; //@ fifo.py:642
    wire [31:0] _T_154; //@ fifo.py:642
    wire [3:0] _T_155; //@ fifo.py:642
    wire  _T_156; //@ fifo.py:642
    wire [3:0] _T_157; //@ fifo.py:642
    wire [3:0] _T_158; //@ fifo.py:642
    wire  _T_159; //@ fifo.py:642
    wire [3:0] _T_160; //@ fifo.py:642
    wire  _T_161; //@ fifo.py:642
    wire [31:0] _T_162; //@ fifo.py:642
    wire  _T_163; //@ fifo.py:642
    wire [31:0] _T_164; //@ fifo.py:642
    wire [3:0] _T_165; //@ fifo.py:642
    wire  _T_166; //@ fifo.py:642
    wire [3:0] _T_167; //@ fifo.py:642
    wire [3:0] _T_168; //@ fifo.py:642
    wire  _T_169; //@ fifo.py:642
    wire [3:0] _T_170; //@ fifo.py:642
    wire  _T_171; //@ fifo.py:642
    wire [31:0] _T_172; //@ fifo.py:642
    wire  _T_173; //@ fifo.py:642
    wire [31:0] _T_174; //@ fifo.py:642
    wire [3:0] _T_175; //@ fifo.py:642
    wire  _T_176; //@ fifo.py:642
    wire [3:0] _T_177; //@ fifo.py:642
    wire [3:0] _T_178; //@ fifo.py:642
    wire  _T_179; //@ fifo.py:642
    wire [3:0] _T_180; //@ fifo.py:642
    wire  _T_181; //@ fifo.py:642
    wire [31:0] _T_182; //@ fifo.py:642
    wire  _T_183; //@ fifo.py:642
    wire [31:0] _T_184; //@ fifo.py:642
    wire [3:0] _T_185; //@ fifo.py:642
    wire  _T_186; //@ fifo.py:642
    wire [3:0] _T_187; //@ fifo.py:642
    wire [3:0] _T_188; //@ fifo.py:642
    wire  _T_189; //@ fifo.py:642
    wire [3:0] _T_190; //@ fifo.py:642
    wire  _T_191; //@ fifo.py:642
    wire [31:0] _T_192; //@ fifo.py:642
    wire  _T_193; //@ fifo.py:642
    wire [31:0] _T_194; //@ fifo.py:642
    wire [3:0] _T_195; //@ fifo.py:642
    wire  _T_196; //@ fifo.py:642
    wire [3:0] _T_197; //@ fifo.py:642
    wire [3:0] _T_198; //@ fifo.py:642
    wire  _T_199; //@ fifo.py:642
    wire [3:0] _T_200; //@ fifo.py:642
    wire [3:0] _T_201_op; //@ demo_utils_async_queue.py:6
    wire [3:0] _T_201_address; //@ demo_utils_async_queue.py:7
    wire [31:0] _T_201_data; //@ demo_utils_async_queue.py:8
    wire  _T_202; //@ fifo.py:644
    wire [3:0] _T_203; //@ fifo.py:644
    wire [3:0] _T_204; //@ fifo.py:644
    wire  _T_205; //@ fifo.py:644
    wire [3:0] _T_206; //@ fifo.py:644
    wire [3:0] _T_207; //@ fifo.py:644
    wire [3:0] _T_208; //@ fifo.py:644
    wire  _T_209; //@ fifo.py:644
    wire [3:0] _T_210; //@ fifo.py:644
    wire [3:0] _T_211; //@ fifo.py:644
    wire [3:0] _T_212; //@ fifo.py:644
    wire  _T_213; //@ fifo.py:644
    wire [3:0] _T_214; //@ fifo.py:644
    wire [3:0] _T_215; //@ fifo.py:644
    wire [3:0] _T_216; //@ fifo.py:644
    wire  _T_217; //@ fifo.py:644
    wire [3:0] _T_218; //@ fifo.py:644
    wire [3:0] _T_219; //@ fifo.py:644
    wire [3:0] _T_220; //@ fifo.py:644
    wire  _T_221; //@ fifo.py:644
    wire [3:0] _T_222; //@ fifo.py:644
    wire [3:0] _T_223; //@ fifo.py:644
    wire [3:0] _T_224; //@ fifo.py:644
    wire  _T_225; //@ fifo.py:644
    wire [3:0] _T_226; //@ fifo.py:644
    wire [3:0] _T_227; //@ fifo.py:644
    wire [3:0] _T_228; //@ fifo.py:644
    wire  _T_229; //@ fifo.py:644
    wire [3:0] _T_230; //@ fifo.py:644
    wire [3:0] _T_231; //@ fifo.py:644
    wire [3:0] _T_232; //@ fifo.py:644
    wire  _T_233; //@ fifo.py:644
    wire [3:0] _T_234; //@ fifo.py:644
    wire [3:0] _T_235; //@ fifo.py:644
    wire  _T_236; //@ fifo.py:644
    wire [3:0] _T_237; //@ fifo.py:644
    wire [3:0] _T_238; //@ fifo.py:644
    wire [3:0] _T_239; //@ fifo.py:644
    wire  _T_240; //@ fifo.py:644
    wire [3:0] _T_241; //@ fifo.py:644
    wire [3:0] _T_242; //@ fifo.py:644
    wire [3:0] _T_243; //@ fifo.py:644
    wire  _T_244; //@ fifo.py:644
    wire [3:0] _T_245; //@ fifo.py:644
    wire [3:0] _T_246; //@ fifo.py:644
    wire [3:0] _T_247; //@ fifo.py:644
    wire  _T_248; //@ fifo.py:644
    wire [3:0] _T_249; //@ fifo.py:644
    wire [3:0] _T_250; //@ fifo.py:644
    wire [3:0] _T_251; //@ fifo.py:644
    wire  _T_252; //@ fifo.py:644
    wire [3:0] _T_253; //@ fifo.py:644
    wire [3:0] _T_254; //@ fifo.py:644
    wire [3:0] _T_255; //@ fifo.py:644
    wire  _T_256; //@ fifo.py:644
    wire [3:0] _T_257; //@ fifo.py:644
    wire [3:0] _T_258; //@ fifo.py:644
    wire [3:0] _T_259; //@ fifo.py:644
    wire  _T_260; //@ fifo.py:644
    wire [3:0] _T_261; //@ fifo.py:644
    wire [3:0] _T_262; //@ fifo.py:644
    wire [3:0] _T_263; //@ fifo.py:644
    wire  _T_264; //@ fifo.py:644
    wire [31:0] _T_265; //@ fifo.py:644
    wire [31:0] _T_266; //@ fifo.py:644
    wire  _T_267; //@ fifo.py:644
    wire [31:0] _T_268; //@ fifo.py:644
    wire [31:0] _T_269; //@ fifo.py:644
    wire [31:0] _T_270; //@ fifo.py:644
    wire  _T_271; //@ fifo.py:644
    wire [31:0] _T_272; //@ fifo.py:644
    wire [31:0] _T_273; //@ fifo.py:644
    wire [31:0] _T_274; //@ fifo.py:644
    wire  _T_275; //@ fifo.py:644
    wire [31:0] _T_276; //@ fifo.py:644
    wire [31:0] _T_277; //@ fifo.py:644
    wire [31:0] _T_278; //@ fifo.py:644
    wire  _T_279; //@ fifo.py:644
    wire [31:0] _T_280; //@ fifo.py:644
    wire [31:0] _T_281; //@ fifo.py:644
    wire [31:0] _T_282; //@ fifo.py:644
    wire  _T_283; //@ fifo.py:644
    wire [31:0] _T_284; //@ fifo.py:644
    wire [31:0] _T_285; //@ fifo.py:644
    wire [31:0] _T_286; //@ fifo.py:644
    wire  _T_287; //@ fifo.py:644
    wire [31:0] _T_288; //@ fifo.py:644
    wire [31:0] _T_289; //@ fifo.py:644
    wire [31:0] _T_290; //@ fifo.py:644
    wire  _T_291; //@ fifo.py:644
    wire [31:0] _T_292; //@ fifo.py:644
    wire [31:0] _T_293; //@ fifo.py:644
    wire [31:0] _T_294; //@ fifo.py:644
    wire [2:0] _T_295; //@ fifo.py:651
    wire [2:0] _T_296; //@ fifo.py:651
    wire  _T_297; //@ fifo.py:652
    wire  _T_298; //@ fifo.py:652
    wire  _T_299; //@ fifo.py:653
    wire  _T_300; //@ fifo.py:653
    wire [2:0] _T_301; //@ fifo.py:656
    wire [2:0] _T_302; //@ fifo.py:656
    wire  _T_303; //@ fifo.py:657
    wire  _T_304; //@ fifo.py:657
    wire  _T_305; //@ fifo.py:658
    wire  _T_306; //@ fifo.py:658
    always @(posedge io_enq_clock) //@ fifo.py:506
        _T_0_o <= _T_0_i;
    always @(posedge io_enq_clock) //@ fifo.py:506
        _T_1_o <= _T_1_i;
    always @(posedge io_enq_clock) //@ fifo.py:506
        _T_2_o <= _T_2_i;
    always @(posedge io_deq_clock) //@ fifo.py:511
        _T_3_o <= _T_3_i;
    always @(posedge io_deq_clock) //@ fifo.py:511
        _T_4_o <= _T_4_i;
    always @(posedge io_deq_clock) //@ fifo.py:511
        _T_5_o <= _T_5_i;
    always @(posedge io_enq_clock) //@ fifo.py:519
        ram_0_op_o <= ram_0_op_i;
    always @(posedge io_enq_clock) //@ fifo.py:519
        ram_0_address_o <= ram_0_address_i;
    always @(posedge io_enq_clock) //@ fifo.py:519
        ram_0_data_o <= ram_0_data_i;
    always @(posedge io_enq_clock) //@ fifo.py:519
        ram_1_op_o <= ram_1_op_i;
    always @(posedge io_enq_clock) //@ fifo.py:519
        ram_1_address_o <= ram_1_address_i;
    always @(posedge io_enq_clock) //@ fifo.py:519
        ram_1_data_o <= ram_1_data_i;
    always @(posedge io_enq_clock) //@ fifo.py:519
        ram_2_op_o <= ram_2_op_i;
    always @(posedge io_enq_clock) //@ fifo.py:519
        ram_2_address_o <= ram_2_address_i;
    always @(posedge io_enq_clock) //@ fifo.py:519
        ram_2_data_o <= ram_2_data_i;
    always @(posedge io_enq_clock) //@ fifo.py:519
        ram_3_op_o <= ram_3_op_i;
    always @(posedge io_enq_clock) //@ fifo.py:519
        ram_3_address_o <= ram_3_address_i;
    always @(posedge io_enq_clock) //@ fifo.py:519
        ram_3_data_o <= ram_3_data_i;
    always @(posedge io_enq_clock) //@ fifo.py:519
        ram_4_op_o <= ram_4_op_i;
    always @(posedge io_enq_clock) //@ fifo.py:519
        ram_4_address_o <= ram_4_address_i;
    always @(posedge io_enq_clock) //@ fifo.py:519
        ram_4_data_o <= ram_4_data_i;
    always @(posedge io_enq_clock) //@ fifo.py:519
        ram_5_op_o <= ram_5_op_i;
    always @(posedge io_enq_clock) //@ fifo.py:519
        ram_5_address_o <= ram_5_address_i;
    always @(posedge io_enq_clock) //@ fifo.py:519
        ram_5_data_o <= ram_5_data_i;
    always @(posedge io_enq_clock) //@ fifo.py:519
        ram_6_op_o <= ram_6_op_i;
    always @(posedge io_enq_clock) //@ fifo.py:519
        ram_6_address_o <= ram_6_address_i;
    always @(posedge io_enq_clock) //@ fifo.py:519
        ram_6_data_o <= ram_6_data_i;
    always @(posedge io_enq_clock) //@ fifo.py:519
        ram_7_op_o <= ram_7_op_i;
    always @(posedge io_enq_clock) //@ fifo.py:519
        ram_7_address_o <= ram_7_address_i;
    always @(posedge io_enq_clock) //@ fifo.py:519
        ram_7_data_o <= ram_7_data_i;
    always @(posedge io_deq_clock or posedge io_deq_reset) //@ fifo.py:524
        if (io_deq_reset)
            rd_ptr_o <= 3'h0;
        else
            rd_ptr_o <= rd_ptr_i;
    always @(posedge io_enq_clock or posedge io_enq_reset) //@ fifo.py:529
        if (io_enq_reset)
            wr_ptr_o <= 3'h0;
        else
            wr_ptr_o <= wr_ptr_i;
    always @(posedge io_deq_clock) //@ fifo.py:542
        rd_ptr_gray_dly0_o <= rd_ptr_gray_dly0_i;
    always @(posedge io_enq_clock) //@ fifo.py:548
        _T_20_o <= _T_20_i;
    always @(posedge io_enq_clock) //@ fifo.py:548
        _T_21_o <= _T_21_i;
    always @(posedge io_enq_clock) //@ fifo.py:548
        _T_22_o <= _T_22_i;
    always @(posedge io_enq_clock) //@ fifo.py:558
        wr_ptr_gray_dly0_o <= wr_ptr_gray_dly0_i;
    always @(posedge io_deq_clock) //@ fifo.py:564
        _T_50_o <= _T_50_i;
    always @(posedge io_deq_clock) //@ fifo.py:564
        _T_51_o <= _T_51_i;
    always @(posedge io_deq_clock) //@ fifo.py:564
        _T_52_o <= _T_52_i;
    always @(posedge io_enq_clock or posedge io_enq_reset) //@ fifo.py:572
        if (io_enq_reset)
            wr_direction_flagwr_o <= 1'h0;
        else
            wr_direction_flagwr_o <= wr_direction_flagwr_i;
    always @(posedge io_enq_clock or posedge io_enq_reset) //@ fifo.py:576
        if (io_enq_reset)
            wr_direction_flagrd_o <= 1'h1;
        else
            wr_direction_flagrd_o <= wr_direction_flagrd_i;
    always @(posedge io_deq_clock or posedge io_deq_reset) //@ fifo.py:580
        if (io_deq_reset)
            rd_direction_flagwr_o <= 1'h0;
        else
            rd_direction_flagwr_o <= rd_direction_flagwr_i;
    always @(posedge io_deq_clock or posedge io_deq_reset) //@ fifo.py:584
        if (io_deq_reset)
            rd_direction_flagrd_o <= 1'h1;
        else
            rd_direction_flagrd_o <= rd_direction_flagrd_i;
    assign _T_0_i = io_flush; //@ fifo.py:506
    assign _T_1_i = _T_0_o; //@ fifo.py:506
    assign _T_2_i = _T_1_o; //@ fifo.py:506
    assign _T_3_i = io_flush; //@ fifo.py:511
    assign _T_4_i = _T_3_o; //@ fifo.py:511
    assign _T_5_i = _T_4_o; //@ fifo.py:511
    assign _T_6 = (rd_ptr_o + 3'h1); //@ fifo.py:487
    assign _T_7 = (wr_ptr_o + 3'h1); //@ fifo.py:487
    assign _T_8 = {1'h0, rd_ptr_o}; //@ fifo.py:536
    assign _T_9 = _T_8[0]; //@ fifo.py:536
    assign _T_10 = _T_8[1]; //@ fifo.py:536
    assign _T_11 = (_T_9 ^ _T_10); //@ fifo.py:536
    assign _T_12 = _T_8[1]; //@ fifo.py:536
    assign _T_13 = _T_8[2]; //@ fifo.py:536
    assign _T_14 = (_T_12 ^ _T_13); //@ fifo.py:536
    assign _T_15 = _T_8[2]; //@ fifo.py:536
    assign _T_16 = _T_8[3]; //@ fifo.py:536
    assign _T_17 = (_T_15 ^ _T_16); //@ fifo.py:536
    assign _T_18 = {_T_17, _T_14}; //@ fifo.py:536
    assign _T_19 = {_T_18, _T_11}; //@ fifo.py:536
    assign rd_ptr_gray_dly0_i = _T_19; //@ fifo.py:542
    assign _T_20_i = rd_ptr_gray_dly0_o; //@ fifo.py:548
    assign _T_21_i = _T_20_o; //@ fifo.py:548
    assign _T_22_i = _T_21_o; //@ fifo.py:548
    assign _T_23 = {1'h0, _T_22_o}; //@ fifo.py:549
//    assign _T_24 = _T_23[0]; //@ fifo.py:549
//    assign _T_25 = _T_23[1]; //@ fifo.py:549
//    assign _T_26 = _T_23[2]; //@ fifo.py:549
    assign _T_27 = _T_23[3]; //@ fifo.py:549
    assign _T_28 = _T_22_o[2]; //@ fifo.py:549
    assign _T_29 = (_T_28 ^ _T_27); //@ fifo.py:549
    assign _T_26 = _T_29; //@ fifo.py:549
    assign _T_30 = _T_22_o[1]; //@ fifo.py:549
    assign _T_31 = (_T_30 ^ _T_26); //@ fifo.py:549
    assign _T_25 = _T_31; //@ fifo.py:549
    assign _T_32 = _T_22_o[0]; //@ fifo.py:549
    assign _T_33 = (_T_32 ^ _T_25); //@ fifo.py:549
    assign _T_24 = _T_33; //@ fifo.py:549
    assign _T_34 = {_T_27, _T_26}; //@ fifo.py:549
    assign _T_35 = {_T_34, _T_25}; //@ fifo.py:549
    assign _T_36 = {_T_35, _T_24}; //@ fifo.py:549
    assign _T_37 = _T_36[2:0]; //@ fifo.py:549
    assign _T_38 = {1'h0, wr_ptr_o}; //@ fifo.py:552
    assign _T_39 = _T_38[0]; //@ fifo.py:552
    assign _T_40 = _T_38[1]; //@ fifo.py:552
    assign _T_41 = (_T_39 ^ _T_40); //@ fifo.py:552
    assign _T_42 = _T_38[1]; //@ fifo.py:552
    assign _T_43 = _T_38[2]; //@ fifo.py:552
    assign _T_44 = (_T_42 ^ _T_43); //@ fifo.py:552
    assign _T_45 = _T_38[2]; //@ fifo.py:552
    assign _T_46 = _T_38[3]; //@ fifo.py:552
    assign _T_47 = (_T_45 ^ _T_46); //@ fifo.py:552
    assign _T_48 = {_T_47, _T_44}; //@ fifo.py:552
    assign _T_49 = {_T_48, _T_41}; //@ fifo.py:552
    assign wr_ptr_gray_dly0_i = _T_49; //@ fifo.py:558
    assign _T_50_i = wr_ptr_gray_dly0_o; //@ fifo.py:564
    assign _T_51_i = _T_50_o; //@ fifo.py:564
    assign _T_52_i = _T_51_o; //@ fifo.py:564
    assign _T_53 = {1'h0, _T_52_o}; //@ fifo.py:565
//    assign _T_54 = _T_53[0]; //@ fifo.py:565
//    assign _T_55 = _T_53[1]; //@ fifo.py:565
//    assign _T_56 = _T_53[2]; //@ fifo.py:565
    assign _T_57 = _T_53[3]; //@ fifo.py:565
    assign _T_58 = _T_52_o[2]; //@ fifo.py:565
    assign _T_59 = (_T_58 ^ _T_57); //@ fifo.py:565
    assign _T_56 = _T_59; //@ fifo.py:565
    assign _T_60 = _T_52_o[1]; //@ fifo.py:565
    assign _T_61 = (_T_60 ^ _T_56); //@ fifo.py:565
    assign _T_55 = _T_61; //@ fifo.py:565
    assign _T_62 = _T_52_o[0]; //@ fifo.py:565
    assign _T_63 = (_T_62 ^ _T_55); //@ fifo.py:565
    assign _T_54 = _T_63; //@ fifo.py:565
    assign _T_64 = {_T_57, _T_56}; //@ fifo.py:565
    assign _T_65 = {_T_64, _T_55}; //@ fifo.py:565
    assign _T_66 = {_T_65, _T_54}; //@ fifo.py:565
    assign _T_67 = _T_66[2:0]; //@ fifo.py:565
    assign _T_68 = (wr_ptr_o > _T_37); //@ fifo.py:585
    assign _T_69 = (wr_ptr_o < _T_37); //@ fifo.py:586
    assign _T_70 = (rd_ptr_o < _T_67); //@ fifo.py:587
    assign _T_71 = (rd_ptr_o > _T_67); //@ fifo.py:588
    assign _T_72 = (wr_ptr_o - _T_37); //@ fifo.py:591
    assign _T_73 = (_T_37 - wr_ptr_o); //@ fifo.py:594
    assign _T_74 = (4'h8 - _T_73); //@ fifo.py:594
    assign _T_75 = (wr_direction_flagwr_o ? 4'h8 : 4'h0); //@ fifo.py:598
    assign _T_76 = (_T_69 ? _T_74 : _T_75); //@ fifo.py:598
    assign _T_77 = (_T_68 ? _T_72 : _T_76); //@ fifo.py:598
    assign _T_78 = _T_77[3:0]; //@ fifo.py:598
    assign wr_word_count = _T_78; //@ fifo.py:598
    assign _T_79 = (_T_67 - rd_ptr_o); //@ fifo.py:601
    assign _T_80 = (rd_ptr_o - _T_67); //@ fifo.py:604
    assign _T_81 = (4'h8 - _T_80); //@ fifo.py:604
    assign _T_82 = (rd_direction_flagwr_o ? 4'h8 : 4'h0); //@ fifo.py:608
    assign _T_83 = (_T_71 ? _T_81 : _T_82); //@ fifo.py:608
    assign _T_84 = (_T_70 ? _T_79 : _T_83); //@ fifo.py:608
    assign _T_85 = _T_84[3:0]; //@ fifo.py:608
    assign rd_word_count = _T_85; //@ fifo.py:608
    assign _T_86 = (wr_word_count >= 4'h7); //@ fifo.py:611
    assign _T_87 = (wr_word_count <= 4'h1); //@ fifo.py:613
    assign _T_88 = (_T_87 ? 1'h0 : wr_direction_flagwr_o); //@ fifo.py:613
    assign _T_89 = (_T_86 ? 1'h1 : _T_88); //@ fifo.py:613
//    assign wr_direction_flagwr_i = _T_89; //@ fifo.py:613
    assign _T_90 = (rd_word_count >= 4'h7); //@ fifo.py:615
    assign _T_91 = (rd_word_count <= 4'h1); //@ fifo.py:617
    assign _T_92 = (_T_91 ? 1'h0 : rd_direction_flagwr_o); //@ fifo.py:617
    assign _T_93 = (_T_90 ? 1'h1 : _T_92); //@ fifo.py:617
//    assign rd_direction_flagwr_i = _T_93; //@ fifo.py:617
    assign _T_94 = (wr_word_count >= 4'h7); //@ fifo.py:620
    assign _T_95 = (wr_word_count <= 4'h1); //@ fifo.py:622
    assign _T_96 = (_T_95 ? 1'h1 : wr_direction_flagrd_o); //@ fifo.py:622
    assign _T_97 = (_T_94 ? 1'h0 : _T_96); //@ fifo.py:622
//    assign wr_direction_flagrd_i = _T_97; //@ fifo.py:622
    assign _T_98 = (rd_word_count >= 4'h7); //@ fifo.py:624
    assign _T_99 = (rd_word_count <= 4'h1); //@ fifo.py:626
    assign _T_100 = (_T_99 ? 1'h1 : rd_direction_flagrd_o); //@ fifo.py:626
    assign _T_101 = (_T_98 ? 1'h0 : _T_100); //@ fifo.py:626
//    assign rd_direction_flagrd_i = _T_101; //@ fifo.py:626
    assign _T_102 = (wr_ptr_o == _T_37); //@ fifo.py:628
    assign _T_103 = (wr_direction_flagwr_o & _T_102); //@ fifo.py:628
    assign full = _T_103; //@ fifo.py:628
    assign _T_104 = (rd_ptr_o == _T_67); //@ fifo.py:629
    assign _T_105 = (rd_direction_flagrd_o & _T_104); //@ fifo.py:629
    assign empty = _T_105; //@ fifo.py:629
    assign _T_106 = ~empty; //@ fifo.py:631
    assign _T_107 = (io_deq_ready & io_deq_valid); //@ fifo.py:631
    assign _T_108 = (_T_106 & _T_107); //@ fifo.py:631
    assign _T_109 = ~full; //@ fifo.py:632
    assign _T_110 = (io_enq_ready & io_enq_valid); //@ fifo.py:632
    assign _T_111 = (_T_109 & _T_110); //@ fifo.py:632
    assign _T_112 = (_T_111 ? _T_7 : wr_ptr_o); //@ fifo.py:634
    assign _T_114 = _T_112[2:0]; //@ fifo.py:634
    assign _T_113 = _T_114; //@ fifo.py:634
//    assign wr_ptr_i = _T_113; //@ fifo.py:634
    assign _T_115 = (_T_108 ? _T_6 : rd_ptr_o); //@ fifo.py:635
    assign _T_117 = _T_115[2:0]; //@ fifo.py:635
    assign _T_116 = _T_117; //@ fifo.py:635
//    assign rd_ptr_i = _T_116; //@ fifo.py:635
    assign _T_118 = (wr_word_count >= 4'h6); //@ fifo.py:637
    assign _T_119 = ~_T_118; //@ fifo.py:638
    assign io_enq_ready = _T_119; //@ fifo.py:638
    assign _T_120 = ~empty; //@ fifo.py:639
    assign io_deq_valid = _T_120; //@ fifo.py:639
    assign _T_121 = (wr_ptr_o == 3'h0); //@ fifo.py:642
    assign _T_123 = (_T_111 & _T_121); //@ fifo.py:642
    assign _T_124 = (_T_123 ? io_enq_bits_data : ram_0_data_o); //@ fifo.py:642
    assign _T_122 = _T_124; //@ fifo.py:642
    assign ram_0_data_i = _T_122; //@ fifo.py:642
    assign _T_126 = (_T_111 & _T_121); //@ fifo.py:642
    assign _T_127 = (_T_126 ? io_enq_bits_address : ram_0_address_o); //@ fifo.py:642
    assign _T_125 = _T_127; //@ fifo.py:642
    assign ram_0_address_i = _T_125; //@ fifo.py:642
    assign _T_129 = (_T_111 & _T_121); //@ fifo.py:642
    assign _T_130 = (_T_129 ? io_enq_bits_op : ram_0_op_o); //@ fifo.py:642
    assign _T_128 = _T_130; //@ fifo.py:642
    assign ram_0_op_i = _T_128; //@ fifo.py:642
    assign _T_131 = (wr_ptr_o == 3'h1); //@ fifo.py:642
    assign _T_133 = (_T_111 & _T_131); //@ fifo.py:642
    assign _T_134 = (_T_133 ? io_enq_bits_data : ram_1_data_o); //@ fifo.py:642
    assign _T_132 = _T_134; //@ fifo.py:642
    assign ram_1_data_i = _T_132; //@ fifo.py:642
    assign _T_136 = (_T_111 & _T_131); //@ fifo.py:642
    assign _T_137 = (_T_136 ? io_enq_bits_address : ram_1_address_o); //@ fifo.py:642
    assign _T_135 = _T_137; //@ fifo.py:642
    assign ram_1_address_i = _T_135; //@ fifo.py:642
    assign _T_139 = (_T_111 & _T_131); //@ fifo.py:642
    assign _T_140 = (_T_139 ? io_enq_bits_op : ram_1_op_o); //@ fifo.py:642
    assign _T_138 = _T_140; //@ fifo.py:642
    assign ram_1_op_i = _T_138; //@ fifo.py:642
    assign _T_141 = (wr_ptr_o == 3'h2); //@ fifo.py:642
    assign _T_143 = (_T_111 & _T_141); //@ fifo.py:642
    assign _T_144 = (_T_143 ? io_enq_bits_data : ram_2_data_o); //@ fifo.py:642
    assign _T_142 = _T_144; //@ fifo.py:642
    assign ram_2_data_i = _T_142; //@ fifo.py:642
    assign _T_146 = (_T_111 & _T_141); //@ fifo.py:642
    assign _T_147 = (_T_146 ? io_enq_bits_address : ram_2_address_o); //@ fifo.py:642
    assign _T_145 = _T_147; //@ fifo.py:642
    assign ram_2_address_i = _T_145; //@ fifo.py:642
    assign _T_149 = (_T_111 & _T_141); //@ fifo.py:642
    assign _T_150 = (_T_149 ? io_enq_bits_op : ram_2_op_o); //@ fifo.py:642
    assign _T_148 = _T_150; //@ fifo.py:642
    assign ram_2_op_i = _T_148; //@ fifo.py:642
    assign _T_151 = (wr_ptr_o == 3'h3); //@ fifo.py:642
    assign _T_153 = (_T_111 & _T_151); //@ fifo.py:642
    assign _T_154 = (_T_153 ? io_enq_bits_data : ram_3_data_o); //@ fifo.py:642
    assign _T_152 = _T_154; //@ fifo.py:642
    assign ram_3_data_i = _T_152; //@ fifo.py:642
    assign _T_156 = (_T_111 & _T_151); //@ fifo.py:642
    assign _T_157 = (_T_156 ? io_enq_bits_address : ram_3_address_o); //@ fifo.py:642
    assign _T_155 = _T_157; //@ fifo.py:642
    assign ram_3_address_i = _T_155; //@ fifo.py:642
    assign _T_159 = (_T_111 & _T_151); //@ fifo.py:642
    assign _T_160 = (_T_159 ? io_enq_bits_op : ram_3_op_o); //@ fifo.py:642
    assign _T_158 = _T_160; //@ fifo.py:642
    assign ram_3_op_i = _T_158; //@ fifo.py:642
    assign _T_161 = (wr_ptr_o == 3'h4); //@ fifo.py:642
    assign _T_163 = (_T_111 & _T_161); //@ fifo.py:642
    assign _T_164 = (_T_163 ? io_enq_bits_data : ram_4_data_o); //@ fifo.py:642
    assign _T_162 = _T_164; //@ fifo.py:642
    assign ram_4_data_i = _T_162; //@ fifo.py:642
    assign _T_166 = (_T_111 & _T_161); //@ fifo.py:642
    assign _T_167 = (_T_166 ? io_enq_bits_address : ram_4_address_o); //@ fifo.py:642
    assign _T_165 = _T_167; //@ fifo.py:642
    assign ram_4_address_i = _T_165; //@ fifo.py:642
    assign _T_169 = (_T_111 & _T_161); //@ fifo.py:642
    assign _T_170 = (_T_169 ? io_enq_bits_op : ram_4_op_o); //@ fifo.py:642
    assign _T_168 = _T_170; //@ fifo.py:642
    assign ram_4_op_i = _T_168; //@ fifo.py:642
    assign _T_171 = (wr_ptr_o == 3'h5); //@ fifo.py:642
    assign _T_173 = (_T_111 & _T_171); //@ fifo.py:642
    assign _T_174 = (_T_173 ? io_enq_bits_data : ram_5_data_o); //@ fifo.py:642
    assign _T_172 = _T_174; //@ fifo.py:642
    assign ram_5_data_i = _T_172; //@ fifo.py:642
    assign _T_176 = (_T_111 & _T_171); //@ fifo.py:642
    assign _T_177 = (_T_176 ? io_enq_bits_address : ram_5_address_o); //@ fifo.py:642
    assign _T_175 = _T_177; //@ fifo.py:642
    assign ram_5_address_i = _T_175; //@ fifo.py:642
    assign _T_179 = (_T_111 & _T_171); //@ fifo.py:642
    assign _T_180 = (_T_179 ? io_enq_bits_op : ram_5_op_o); //@ fifo.py:642
    assign _T_178 = _T_180; //@ fifo.py:642
    assign ram_5_op_i = _T_178; //@ fifo.py:642
    assign _T_181 = (wr_ptr_o == 3'h6); //@ fifo.py:642
    assign _T_183 = (_T_111 & _T_181); //@ fifo.py:642
    assign _T_184 = (_T_183 ? io_enq_bits_data : ram_6_data_o); //@ fifo.py:642
    assign _T_182 = _T_184; //@ fifo.py:642
    assign ram_6_data_i = _T_182; //@ fifo.py:642
    assign _T_186 = (_T_111 & _T_181); //@ fifo.py:642
    assign _T_187 = (_T_186 ? io_enq_bits_address : ram_6_address_o); //@ fifo.py:642
    assign _T_185 = _T_187; //@ fifo.py:642
    assign ram_6_address_i = _T_185; //@ fifo.py:642
    assign _T_189 = (_T_111 & _T_181); //@ fifo.py:642
    assign _T_190 = (_T_189 ? io_enq_bits_op : ram_6_op_o); //@ fifo.py:642
    assign _T_188 = _T_190; //@ fifo.py:642
    assign ram_6_op_i = _T_188; //@ fifo.py:642
    assign _T_191 = (wr_ptr_o == 3'h7); //@ fifo.py:642
    assign _T_193 = (_T_111 & _T_191); //@ fifo.py:642
    assign _T_194 = (_T_193 ? io_enq_bits_data : ram_7_data_o); //@ fifo.py:642
    assign _T_192 = _T_194; //@ fifo.py:642
    assign ram_7_data_i = _T_192; //@ fifo.py:642
    assign _T_196 = (_T_111 & _T_191); //@ fifo.py:642
    assign _T_197 = (_T_196 ? io_enq_bits_address : ram_7_address_o); //@ fifo.py:642
    assign _T_195 = _T_197; //@ fifo.py:642
    assign ram_7_address_i = _T_195; //@ fifo.py:642
    assign _T_199 = (_T_111 & _T_191); //@ fifo.py:642
    assign _T_200 = (_T_199 ? io_enq_bits_op : ram_7_op_o); //@ fifo.py:642
    assign _T_198 = _T_200; //@ fifo.py:642
    assign ram_7_op_i = _T_198; //@ fifo.py:642
    assign _T_202 = (rd_ptr_o == 3'h0); //@ fifo.py:644
    assign _T_203 = {3'h4{_T_202}}; //@ fifo.py:644
    assign _T_204 = (_T_203 & ram_0_op_o); //@ fifo.py:644
    assign _T_205 = (rd_ptr_o == 3'h1); //@ fifo.py:644
    assign _T_206 = {3'h4{_T_205}}; //@ fifo.py:644
    assign _T_207 = (_T_206 & ram_1_op_o); //@ fifo.py:644
    assign _T_208 = (_T_204 | _T_207); //@ fifo.py:644
    assign _T_209 = (rd_ptr_o == 3'h2); //@ fifo.py:644
    assign _T_210 = {3'h4{_T_209}}; //@ fifo.py:644
    assign _T_211 = (_T_210 & ram_2_op_o); //@ fifo.py:644
    assign _T_212 = (_T_208 | _T_211); //@ fifo.py:644
    assign _T_213 = (rd_ptr_o == 3'h3); //@ fifo.py:644
    assign _T_214 = {3'h4{_T_213}}; //@ fifo.py:644
    assign _T_215 = (_T_214 & ram_3_op_o); //@ fifo.py:644
    assign _T_216 = (_T_212 | _T_215); //@ fifo.py:644
    assign _T_217 = (rd_ptr_o == 3'h4); //@ fifo.py:644
    assign _T_218 = {3'h4{_T_217}}; //@ fifo.py:644
    assign _T_219 = (_T_218 & ram_4_op_o); //@ fifo.py:644
    assign _T_220 = (_T_216 | _T_219); //@ fifo.py:644
    assign _T_221 = (rd_ptr_o == 3'h5); //@ fifo.py:644
    assign _T_222 = {3'h4{_T_221}}; //@ fifo.py:644
    assign _T_223 = (_T_222 & ram_5_op_o); //@ fifo.py:644
    assign _T_224 = (_T_220 | _T_223); //@ fifo.py:644
    assign _T_225 = (rd_ptr_o == 3'h6); //@ fifo.py:644
    assign _T_226 = {3'h4{_T_225}}; //@ fifo.py:644
    assign _T_227 = (_T_226 & ram_6_op_o); //@ fifo.py:644
    assign _T_228 = (_T_224 | _T_227); //@ fifo.py:644
    assign _T_229 = (rd_ptr_o == 3'h7); //@ fifo.py:644
    assign _T_230 = {3'h4{_T_229}}; //@ fifo.py:644
    assign _T_231 = (_T_230 & ram_7_op_o); //@ fifo.py:644
    assign _T_232 = (_T_228 | _T_231); //@ fifo.py:644
    assign _T_201_op = _T_232; //@ fifo.py:644
    assign _T_233 = (rd_ptr_o == 3'h0); //@ fifo.py:644
    assign _T_234 = {3'h4{_T_233}}; //@ fifo.py:644
    assign _T_235 = (_T_234 & ram_0_address_o); //@ fifo.py:644
    assign _T_236 = (rd_ptr_o == 3'h1); //@ fifo.py:644
    assign _T_237 = {3'h4{_T_236}}; //@ fifo.py:644
    assign _T_238 = (_T_237 & ram_1_address_o); //@ fifo.py:644
    assign _T_239 = (_T_235 | _T_238); //@ fifo.py:644
    assign _T_240 = (rd_ptr_o == 3'h2); //@ fifo.py:644
    assign _T_241 = {3'h4{_T_240}}; //@ fifo.py:644
    assign _T_242 = (_T_241 & ram_2_address_o); //@ fifo.py:644
    assign _T_243 = (_T_239 | _T_242); //@ fifo.py:644
    assign _T_244 = (rd_ptr_o == 3'h3); //@ fifo.py:644
    assign _T_245 = {3'h4{_T_244}}; //@ fifo.py:644
    assign _T_246 = (_T_245 & ram_3_address_o); //@ fifo.py:644
    assign _T_247 = (_T_243 | _T_246); //@ fifo.py:644
    assign _T_248 = (rd_ptr_o == 3'h4); //@ fifo.py:644
    assign _T_249 = {3'h4{_T_248}}; //@ fifo.py:644
    assign _T_250 = (_T_249 & ram_4_address_o); //@ fifo.py:644
    assign _T_251 = (_T_247 | _T_250); //@ fifo.py:644
    assign _T_252 = (rd_ptr_o == 3'h5); //@ fifo.py:644
    assign _T_253 = {3'h4{_T_252}}; //@ fifo.py:644
    assign _T_254 = (_T_253 & ram_5_address_o); //@ fifo.py:644
    assign _T_255 = (_T_251 | _T_254); //@ fifo.py:644
    assign _T_256 = (rd_ptr_o == 3'h6); //@ fifo.py:644
    assign _T_257 = {3'h4{_T_256}}; //@ fifo.py:644
    assign _T_258 = (_T_257 & ram_6_address_o); //@ fifo.py:644
    assign _T_259 = (_T_255 | _T_258); //@ fifo.py:644
    assign _T_260 = (rd_ptr_o == 3'h7); //@ fifo.py:644
    assign _T_261 = {3'h4{_T_260}}; //@ fifo.py:644
    assign _T_262 = (_T_261 & ram_7_address_o); //@ fifo.py:644
    assign _T_263 = (_T_259 | _T_262); //@ fifo.py:644
    assign _T_201_address = _T_263; //@ fifo.py:644
    assign _T_264 = (rd_ptr_o == 3'h0); //@ fifo.py:644
    assign _T_265 = {6'h20{_T_264}}; //@ fifo.py:644
    assign _T_266 = (_T_265 & ram_0_data_o); //@ fifo.py:644
    assign _T_267 = (rd_ptr_o == 3'h1); //@ fifo.py:644
    assign _T_268 = {6'h20{_T_267}}; //@ fifo.py:644
    assign _T_269 = (_T_268 & ram_1_data_o); //@ fifo.py:644
    assign _T_270 = (_T_266 | _T_269); //@ fifo.py:644
    assign _T_271 = (rd_ptr_o == 3'h2); //@ fifo.py:644
    assign _T_272 = {6'h20{_T_271}}; //@ fifo.py:644
    assign _T_273 = (_T_272 & ram_2_data_o); //@ fifo.py:644
    assign _T_274 = (_T_270 | _T_273); //@ fifo.py:644
    assign _T_275 = (rd_ptr_o == 3'h3); //@ fifo.py:644
    assign _T_276 = {6'h20{_T_275}}; //@ fifo.py:644
    assign _T_277 = (_T_276 & ram_3_data_o); //@ fifo.py:644
    assign _T_278 = (_T_274 | _T_277); //@ fifo.py:644
    assign _T_279 = (rd_ptr_o == 3'h4); //@ fifo.py:644
    assign _T_280 = {6'h20{_T_279}}; //@ fifo.py:644
    assign _T_281 = (_T_280 & ram_4_data_o); //@ fifo.py:644
    assign _T_282 = (_T_278 | _T_281); //@ fifo.py:644
    assign _T_283 = (rd_ptr_o == 3'h5); //@ fifo.py:644
    assign _T_284 = {6'h20{_T_283}}; //@ fifo.py:644
    assign _T_285 = (_T_284 & ram_5_data_o); //@ fifo.py:644
    assign _T_286 = (_T_282 | _T_285); //@ fifo.py:644
    assign _T_287 = (rd_ptr_o == 3'h6); //@ fifo.py:644
    assign _T_288 = {6'h20{_T_287}}; //@ fifo.py:644
    assign _T_289 = (_T_288 & ram_6_data_o); //@ fifo.py:644
    assign _T_290 = (_T_286 | _T_289); //@ fifo.py:644
    assign _T_291 = (rd_ptr_o == 3'h7); //@ fifo.py:644
    assign _T_292 = {6'h20{_T_291}}; //@ fifo.py:644
    assign _T_293 = (_T_292 & ram_7_data_o); //@ fifo.py:644
    assign _T_294 = (_T_290 | _T_293); //@ fifo.py:644
    assign _T_201_data = _T_294; //@ fifo.py:644
    assign io_deq_bits_data = _T_201_data; //@ fifo.py:644
    assign io_deq_bits_address = _T_201_address; //@ fifo.py:644
    assign io_deq_bits_op = _T_201_op; //@ fifo.py:644
    assign io_count = wr_word_count; //@ fifo.py:646
    assign _T_296 = (_T_2_o ? 3'h0 : _T_113); //@ fifo.py:651
    assign _T_295 = _T_296; //@ fifo.py:651
    assign wr_ptr_i = _T_295; //@ fifo.py:651
    assign _T_298 = (_T_2_o ? 1'h0 : _T_89); //@ fifo.py:652
    assign _T_297 = _T_298; //@ fifo.py:652
    assign wr_direction_flagwr_i = _T_297; //@ fifo.py:652
    assign _T_300 = (_T_2_o ? 1'h1 : _T_97); //@ fifo.py:653
    assign _T_299 = _T_300; //@ fifo.py:653
    assign wr_direction_flagrd_i = _T_299; //@ fifo.py:653
    assign _T_302 = (_T_5_o ? 3'h0 : _T_116); //@ fifo.py:656
    assign _T_301 = _T_302; //@ fifo.py:656
    assign rd_ptr_i = _T_301; //@ fifo.py:656
    assign _T_304 = (_T_5_o ? 1'h0 : _T_93); //@ fifo.py:657
    assign _T_303 = _T_304; //@ fifo.py:657
    assign rd_direction_flagwr_i = _T_303; //@ fifo.py:657
    assign _T_306 = (_T_5_o ? 1'h1 : _T_101); //@ fifo.py:658
    assign _T_305 = _T_306; //@ fifo.py:658
    assign rd_direction_flagrd_i = _T_305; //@ fifo.py:658
endmodule
