module utils_async_ready_valid_top(
    input  wire  io_enq_clock, //@ demo_utils_async_ready_valid.py:13
    input  wire  io_enq_reset, //@ demo_utils_async_ready_valid.py:14
    input  wire  io_deq_clock, //@ demo_utils_async_ready_valid.py:15
    input  wire  io_deq_reset, //@ demo_utils_async_ready_valid.py:16
    input  wire  io_flush, //@ demo_utils_async_ready_valid.py:17
    input  wire  clock, //@ phgl_generator.py:85
    input  wire  reset  //@ phgl_generator.py:85
);
    wire [3:0] enq_address_i; //@ demo_utils_async_ready_valid.py:22
    reg  [3:0] enq_address_o; //@ demo_utils_async_ready_valid.py:22
    wire  deq_ready_i; //@ demo_utils_async_ready_valid.py:23
    reg   deq_ready_o; //@ demo_utils_async_ready_valid.py:23
    wire  handshake0_io_enq_ready; //@ demo_utils_async_ready_valid.py:25
    wire  handshake0_io_enq_valid; //@ demo_utils_async_ready_valid.py:25
    wire [3:0] handshake0_io_enq_bits_op; //@ demo_utils_async_ready_valid.py:25
    wire [3:0] handshake0_io_enq_bits_address; //@ demo_utils_async_ready_valid.py:25
    wire [31:0] handshake0_io_enq_bits_data; //@ demo_utils_async_ready_valid.py:25
    wire  handshake0_io_deq_ready; //@ demo_utils_async_ready_valid.py:25
    wire  handshake0_io_deq_valid; //@ demo_utils_async_ready_valid.py:25
    wire [3:0] handshake0_io_deq_bits_op; //@ demo_utils_async_ready_valid.py:25
    wire [3:0] handshake0_io_deq_bits_address; //@ demo_utils_async_ready_valid.py:25
    wire [31:0] handshake0_io_deq_bits_data; //@ demo_utils_async_ready_valid.py:25
    wire  handshake0_io_flush; //@ demo_utils_async_ready_valid.py:25
    wire  handshake0_io_enq_clock; //@ demo_utils_async_ready_valid.py:25
    wire  handshake0_io_enq_reset; //@ demo_utils_async_ready_valid.py:25
    wire  handshake0_io_deq_clock; //@ demo_utils_async_ready_valid.py:25
    wire  handshake0_io_deq_reset; //@ demo_utils_async_ready_valid.py:25
    wire  handshake0_clock; //@ demo_utils_async_ready_valid.py:25
    wire  handshake0_reset; //@ demo_utils_async_ready_valid.py:25
    wire  _T_0; //@ demo_utils_async_ready_valid.py:36
    wire [4:0] _T_1; //@ demo_utils_async_ready_valid.py:38
    wire [3:0] _T_2; //@ demo_utils_async_ready_valid.py:38
    wire [4:0] _T_3; //@ demo_utils_async_ready_valid.py:38
    wire [3:0] _T_4; //@ demo_utils_async_ready_valid.py:38
    wire [3:0] _T_5; //@ demo_utils_async_ready_valid.py:38
    always @(posedge io_enq_clock) //@ demo_utils_async_ready_valid.py:22
        if (io_enq_reset)
            enq_address_o <= 4'h0;
        else
            enq_address_o <= enq_address_i;
    always @(posedge io_deq_clock) //@ demo_utils_async_ready_valid.py:23
        if (io_deq_reset)
            deq_ready_o <= 1'h0;
        else
            deq_ready_o <= deq_ready_i;
    async_ready_valid handshake0( //@ demo_utils_async_ready_valid.py:25
        .io_enq_ready(handshake0_io_enq_ready),
        .io_enq_valid(handshake0_io_enq_valid),
        .io_enq_bits_op(handshake0_io_enq_bits_op),
        .io_enq_bits_address(handshake0_io_enq_bits_address),
        .io_enq_bits_data(handshake0_io_enq_bits_data),
        .io_deq_ready(handshake0_io_deq_ready),
        .io_deq_valid(handshake0_io_deq_valid),
        .io_deq_bits_op(handshake0_io_deq_bits_op),
        .io_deq_bits_address(handshake0_io_deq_bits_address),
        .io_deq_bits_data(handshake0_io_deq_bits_data),
        .io_flush(handshake0_io_flush),
        .io_enq_clock(handshake0_io_enq_clock),
        .io_enq_reset(handshake0_io_enq_reset),
        .io_deq_clock(handshake0_io_deq_clock),
        .io_deq_reset(handshake0_io_deq_reset),
        .clock(handshake0_clock),
        .reset(handshake0_reset)
    );
    assign handshake0_clock = clock; //@ demo_utils_async_ready_valid.py:25
    assign handshake0_reset = reset; //@ demo_utils_async_ready_valid.py:25
    assign handshake0_io_enq_clock = io_enq_clock; //@ demo_utils_async_ready_valid.py:26
    assign handshake0_io_enq_reset = io_enq_reset; //@ demo_utils_async_ready_valid.py:27
    assign handshake0_io_enq_valid = 1'h1; //@ demo_utils_async_ready_valid.py:28
    assign handshake0_io_enq_bits_address = enq_address_o; //@ demo_utils_async_ready_valid.py:29
    assign handshake0_io_enq_bits_data = 32'h0; //@ demo_utils_async_ready_valid.py:30
    assign handshake0_io_deq_clock = io_deq_clock; //@ demo_utils_async_ready_valid.py:31
    assign handshake0_io_deq_reset = io_deq_reset; //@ demo_utils_async_ready_valid.py:32
    assign handshake0_io_deq_ready = deq_ready_o; //@ demo_utils_async_ready_valid.py:33
    assign handshake0_io_flush = io_flush; //@ demo_utils_async_ready_valid.py:34
    assign _T_0 = (handshake0_io_enq_ready & handshake0_io_enq_valid); //@ demo_utils_async_ready_valid.py:36
    assign _T_1 = (enq_address_o + 4'h1); //@ demo_utils_async_ready_valid.py:38
    assign _T_3 = (_T_0 ? _T_1 : enq_address_o); //@ demo_utils_async_ready_valid.py:38
    assign _T_5 = _T_3[3:0]; //@ demo_utils_async_ready_valid.py:38
    assign _T_4 = _T_5; //@ demo_utils_async_ready_valid.py:38
    assign _T_2 = _T_4; //@ demo_utils_async_ready_valid.py:38
    assign enq_address_i = _T_2; //@ demo_utils_async_ready_valid.py:38
    assign deq_ready_i = 1'h1; //@ demo_utils_async_ready_valid.py:40
endmodule
module async_ready_valid(
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
    input  wire  io_flush, //@ fifo.py:26
    input  wire  io_enq_clock, //@ fifo.py:682
    input  wire  io_enq_reset, //@ fifo.py:683
    input  wire  io_deq_clock, //@ fifo.py:684
    input  wire  io_deq_reset, //@ fifo.py:685
    input  wire  clock, //@ demo_utils_async_ready_valid.py:25
    input  wire  reset  //@ demo_utils_async_ready_valid.py:25
);
    wire  _T_0_i; //@ fifo.py:701
    reg   _T_0_o; //@ fifo.py:701
    wire  _T_1_i; //@ fifo.py:701
    reg   _T_1_o; //@ fifo.py:701
    wire  _T_2_i; //@ fifo.py:701
    reg   _T_2_o; //@ fifo.py:701
    wire  _T_3_i; //@ fifo.py:706
    reg   _T_3_o; //@ fifo.py:706
    wire  _T_4_i; //@ fifo.py:706
    reg   _T_4_o; //@ fifo.py:706
    wire  _T_5_i; //@ fifo.py:706
    reg   _T_5_o; //@ fifo.py:706
    wire [3:0] entry_op_i; //@ fifo.py:710
    reg  [3:0] entry_op_o; //@ fifo.py:710
    wire [3:0] entry_address_i; //@ fifo.py:710
    reg  [3:0] entry_address_o; //@ fifo.py:710
    wire [31:0] entry_data_i; //@ fifo.py:710
    reg  [31:0] entry_data_o; //@ fifo.py:710
    wire  enq_valid_i; //@ fifo.py:715
    reg   enq_valid_o; //@ fifo.py:715
    wire  _T_6_i; //@ fifo.py:721
    reg   _T_6_o; //@ fifo.py:721
    wire  _T_7_i; //@ fifo.py:721
    reg   _T_7_o; //@ fifo.py:721
    wire  _T_8_i; //@ fifo.py:721
    reg   _T_8_o; //@ fifo.py:721
    wire  deq_valid_i; //@ fifo.py:726
    reg   deq_valid_o; //@ fifo.py:726
    wire  _T_9_i; //@ fifo.py:732
    reg   _T_9_o; //@ fifo.py:732
    wire  _T_10_i; //@ fifo.py:732
    reg   _T_10_o; //@ fifo.py:732
    wire  _T_11_i; //@ fifo.py:732
    reg   _T_11_o; //@ fifo.py:732
    wire  _T_12; //@ fifo.py:734
    wire  _T_13; //@ fifo.py:734
    wire  _T_14; //@ fifo.py:734
    wire  _T_15; //@ fifo.py:735
    wire  _T_16; //@ fifo.py:736
    wire  _T_17; //@ fifo.py:736
    wire [31:0] _T_18; //@ fifo.py:737
    wire [31:0] _T_19; //@ fifo.py:737
    wire [3:0] _T_20; //@ fifo.py:737
    wire [3:0] _T_21; //@ fifo.py:737
    wire [3:0] _T_22; //@ fifo.py:737
    wire [3:0] _T_23; //@ fifo.py:737
    wire  _T_24; //@ fifo.py:738
    wire  _T_25; //@ fifo.py:738
    wire  _T_26; //@ fifo.py:738
    wire  _T_27; //@ fifo.py:739
    wire  _T_28; //@ fifo.py:739
    wire  _T_29; //@ fifo.py:742
    wire  _T_30; //@ fifo.py:742
    wire  _T_31; //@ fifo.py:743
    wire  _T_32; //@ fifo.py:744
    wire  _T_33; //@ fifo.py:744
    wire  _T_34; //@ fifo.py:745
    wire  _T_35; //@ fifo.py:745
    wire  _T_36; //@ fifo.py:745
    wire  _T_37; //@ fifo.py:745
    wire  _T_38; //@ fifo.py:746
    wire  _T_39; //@ fifo.py:746
    wire [39:0] _T_40; //@ fifo.py:748
    wire [31:0] _T_41; //@ fifo.py:748
    wire [3:0] _T_42; //@ fifo.py:748
    wire [3:0] _T_43; //@ fifo.py:748
    wire [31:0] _T_44; //@ fifo.py:750
    wire [31:0] _T_45; //@ fifo.py:750
    wire [3:0] _T_46; //@ fifo.py:750
    wire [3:0] _T_47; //@ fifo.py:750
    wire [3:0] _T_48; //@ fifo.py:750
    wire [3:0] _T_49; //@ fifo.py:750
    wire  _T_50; //@ fifo.py:755
    wire  _T_51; //@ fifo.py:755
    wire  _T_52; //@ fifo.py:758
    wire  _T_53; //@ fifo.py:758
    always @(posedge io_enq_clock) //@ fifo.py:701
        _T_0_o <= _T_0_i;
    always @(posedge io_enq_clock) //@ fifo.py:701
        _T_1_o <= _T_1_i;
    always @(posedge io_enq_clock) //@ fifo.py:701
        _T_2_o <= _T_2_i;
    always @(posedge io_deq_clock) //@ fifo.py:706
        _T_3_o <= _T_3_i;
    always @(posedge io_deq_clock) //@ fifo.py:706
        _T_4_o <= _T_4_i;
    always @(posedge io_deq_clock) //@ fifo.py:706
        _T_5_o <= _T_5_i;
    always @(posedge io_enq_clock) //@ fifo.py:710
        entry_op_o <= entry_op_i;
    always @(posedge io_enq_clock) //@ fifo.py:710
        entry_address_o <= entry_address_i;
    always @(posedge io_enq_clock) //@ fifo.py:710
        entry_data_o <= entry_data_i;
    always @(posedge io_enq_clock) //@ fifo.py:715
        if (io_enq_reset)
            enq_valid_o <= 1'h0;
        else
            enq_valid_o <= enq_valid_i;
    always @(posedge io_deq_clock) //@ fifo.py:721
        _T_6_o <= _T_6_i;
    always @(posedge io_deq_clock) //@ fifo.py:721
        _T_7_o <= _T_7_i;
    always @(posedge io_deq_clock) //@ fifo.py:721
        _T_8_o <= _T_8_i;
    always @(posedge io_deq_clock) //@ fifo.py:726
        if (io_deq_reset)
            deq_valid_o <= 1'h0;
        else
            deq_valid_o <= deq_valid_i;
    always @(posedge io_enq_clock) //@ fifo.py:732
        _T_9_o <= _T_9_i;
    always @(posedge io_enq_clock) //@ fifo.py:732
        _T_10_o <= _T_10_i;
    always @(posedge io_enq_clock) //@ fifo.py:732
        _T_11_o <= _T_11_i;
    assign _T_0_i = io_flush; //@ fifo.py:701
    assign _T_1_i = _T_0_o; //@ fifo.py:701
    assign _T_2_i = _T_1_o; //@ fifo.py:701
    assign _T_3_i = io_flush; //@ fifo.py:706
    assign _T_4_i = _T_3_o; //@ fifo.py:706
    assign _T_5_i = _T_4_o; //@ fifo.py:706
    assign _T_6_i = enq_valid_o; //@ fifo.py:721
    assign _T_7_i = _T_6_o; //@ fifo.py:721
    assign _T_8_i = _T_7_o; //@ fifo.py:721
    assign _T_9_i = deq_valid_o; //@ fifo.py:732
    assign _T_10_i = _T_9_o; //@ fifo.py:732
    assign _T_11_i = _T_10_o; //@ fifo.py:732
    assign _T_12 = ~enq_valid_o; //@ fifo.py:734
    assign _T_13 = ~_T_11_o; //@ fifo.py:734
    assign _T_14 = (_T_12 & _T_13); //@ fifo.py:734
    assign io_enq_ready = _T_14; //@ fifo.py:734
    assign _T_15 = (io_enq_ready & io_enq_valid); //@ fifo.py:735
    assign _T_17 = (_T_15 ? 1'h1 : enq_valid_o); //@ fifo.py:736
    assign _T_16 = _T_17; //@ fifo.py:736
//    assign enq_valid_i = _T_16; //@ fifo.py:736
    assign _T_19 = (_T_15 ? io_enq_bits_data : entry_data_o); //@ fifo.py:737
    assign _T_18 = _T_19; //@ fifo.py:737
    assign entry_data_i = _T_18; //@ fifo.py:737
    assign _T_21 = (_T_15 ? io_enq_bits_address : entry_address_o); //@ fifo.py:737
    assign _T_20 = _T_21; //@ fifo.py:737
    assign entry_address_i = _T_20; //@ fifo.py:737
    assign _T_23 = (_T_15 ? io_enq_bits_op : entry_op_o); //@ fifo.py:737
    assign _T_22 = _T_23; //@ fifo.py:737
    assign entry_op_i = _T_22; //@ fifo.py:737
    assign _T_24 = (_T_15 | _T_11_o); //@ fifo.py:738
    assign _T_25 = (_T_15 == 1'h0); //@ fifo.py:738
    assign _T_26 = (_T_25 & _T_11_o); //@ fifo.py:738
    assign _T_28 = (_T_26 ? 1'h0 : _T_16); //@ fifo.py:739
    assign _T_27 = _T_28; //@ fifo.py:739
//    assign enq_valid_i = _T_27; //@ fifo.py:739
    assign _T_29 = ~deq_valid_o; //@ fifo.py:742
    assign _T_30 = (_T_8_o & _T_29); //@ fifo.py:742
    assign io_deq_valid = _T_30; //@ fifo.py:742
    assign _T_31 = (io_deq_ready & io_deq_valid); //@ fifo.py:743
    assign _T_33 = (_T_31 ? 1'h1 : deq_valid_o); //@ fifo.py:744
    assign _T_32 = _T_33; //@ fifo.py:744
//    assign deq_valid_i = _T_32; //@ fifo.py:744
    assign _T_34 = ~_T_8_o; //@ fifo.py:745
    assign _T_35 = (_T_31 | _T_34); //@ fifo.py:745
    assign _T_36 = (_T_31 == 1'h0); //@ fifo.py:745
    assign _T_37 = (_T_36 & _T_34); //@ fifo.py:745
    assign _T_39 = (_T_37 ? 1'h0 : _T_32); //@ fifo.py:746
    assign _T_38 = _T_39; //@ fifo.py:746
//    assign deq_valid_i = _T_38; //@ fifo.py:746
    assign _T_40 = 40'h0; //@ fifo.py:748
    assign _T_41 = _T_40[31:0]; //@ fifo.py:748
//    assign io_deq_bits_data = _T_41; //@ fifo.py:748
    assign _T_42 = _T_40[35:32]; //@ fifo.py:748
//    assign io_deq_bits_address = _T_42; //@ fifo.py:748
    assign _T_43 = _T_40[39:36]; //@ fifo.py:748
//    assign io_deq_bits_op = _T_43; //@ fifo.py:748
    assign _T_45 = (io_deq_valid ? entry_data_o : _T_41); //@ fifo.py:750
    assign _T_44 = _T_45; //@ fifo.py:750
    assign io_deq_bits_data = _T_44; //@ fifo.py:750
    assign _T_47 = (io_deq_valid ? entry_address_o : _T_42); //@ fifo.py:750
    assign _T_46 = _T_47; //@ fifo.py:750
    assign io_deq_bits_address = _T_46; //@ fifo.py:750
    assign _T_49 = (io_deq_valid ? entry_op_o : _T_43); //@ fifo.py:750
    assign _T_48 = _T_49; //@ fifo.py:750
    assign io_deq_bits_op = _T_48; //@ fifo.py:750
    assign _T_51 = (_T_2_o ? 1'h0 : _T_27); //@ fifo.py:755
    assign _T_50 = _T_51; //@ fifo.py:755
    assign enq_valid_i = _T_50; //@ fifo.py:755
    assign _T_53 = (_T_5_o ? 1'h0 : _T_38); //@ fifo.py:758
    assign _T_52 = _T_53; //@ fifo.py:758
    assign deq_valid_i = _T_52; //@ fifo.py:758
endmodule
