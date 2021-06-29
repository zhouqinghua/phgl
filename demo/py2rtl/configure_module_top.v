module module_top(
    input  wire  io_in0, //@ demo_module.py:42
    input  wire  io_in1, //@ demo_module.py:43
    output wire  io_out, //@ demo_module.py:44
    input  wire  clock, //@ phgl_generator.py:85
    input  wire  reset  //@ phgl_generator.py:85
);
    wire  _T_0; //@ demo_module.py:48
    wire [3:0] md_source_io_req_op; //@ demo_module.py:50
    wire [3:0] md_source_io_req_address; //@ demo_module.py:50
    wire [31:0] md_source_io_req_data; //@ demo_module.py:50
    wire  md_source_io_aaa; //@ demo_module.py:50
    wire  md_source_io_bbb; //@ demo_module.py:50
    wire  md_source_clock; //@ demo_module.py:50
    wire  md_source_reset; //@ demo_module.py:50
    wire [3:0] md_sink_io_req_op; //@ demo_module.py:51
    wire [3:0] md_sink_io_req_address; //@ demo_module.py:51
    wire [31:0] md_sink_io_req_data; //@ demo_module.py:51
    wire  md_sink_io_aaa; //@ demo_module.py:51
    wire  md_sink_io_bbb; //@ demo_module.py:51
    wire  md_sink_clock; //@ demo_module.py:51
    wire  md_sink_reset; //@ demo_module.py:51
    assign _T_0 = (io_in0 & io_in1); //@ demo_module.py:48
    assign io_out = _T_0; //@ demo_module.py:48
    sub_module_source md_source( //@ demo_module.py:50
        .io_req_op(md_source_io_req_op),
        .io_req_address(md_source_io_req_address),
        .io_req_data(md_source_io_req_data),
        .io_aaa(md_source_io_aaa),
        .io_bbb(md_source_io_bbb),
        .clock(md_source_clock),
        .reset(md_source_reset)
    );
    assign md_source_clock = clock; //@ demo_module.py:50
    assign md_source_reset = reset; //@ demo_module.py:50
    sub_module_sink md_sink( //@ demo_module.py:51
        .io_req_op(md_sink_io_req_op),
        .io_req_address(md_sink_io_req_address),
        .io_req_data(md_sink_io_req_data),
        .io_aaa(md_sink_io_aaa),
        .io_bbb(md_sink_io_bbb),
        .clock(md_sink_clock),
        .reset(md_sink_reset)
    );
    assign md_sink_clock = clock; //@ demo_module.py:51
    assign md_sink_reset = reset; //@ demo_module.py:51
    assign md_sink_io_req_data = md_source_io_req_data; //@ demo_module.py:52
    assign md_sink_io_req_address = md_source_io_req_address; //@ demo_module.py:52
    assign md_sink_io_req_op = md_source_io_req_op; //@ demo_module.py:52
    assign md_sink_io_aaa = md_source_io_aaa; //@ demo_module.py:53
    assign md_source_io_bbb = md_sink_io_bbb; //@ demo_module.py:54
endmodule
module sub_module_source(
    output wire [3:0] io_req_op, //@ demo_module.py:5
    output wire [3:0] io_req_address, //@ demo_module.py:6
    output wire [31:0] io_req_data, //@ demo_module.py:7
    output wire  io_aaa, //@ demo_module.py:14
    input  wire  io_bbb, //@ demo_module.py:15
    input  wire  clock, //@ demo_module.py:50
    input  wire  reset  //@ demo_module.py:50
);
    assign io_req_op = 4'h1; //@ demo_module.py:20
    assign io_req_address = 4'h5; //@ demo_module.py:21
    assign io_req_data = 32'h12345678; //@ demo_module.py:22
endmodule
module sub_module_sink(
    input  wire [3:0] io_req_op, //@ demo_module.py:5
    input  wire [3:0] io_req_address, //@ demo_module.py:6
    input  wire [31:0] io_req_data, //@ demo_module.py:7
    input  wire  io_aaa, //@ demo_module.py:29
    output wire  io_bbb, //@ demo_module.py:30
    input  wire  clock, //@ demo_module.py:51
    input  wire  reset  //@ demo_module.py:51
);
    wire [31:0] mem_0_i; //@ demo_module.py:35
    reg  [31:0] mem_0_o; //@ demo_module.py:35
    wire [31:0] mem_1_i; //@ demo_module.py:35
    reg  [31:0] mem_1_o; //@ demo_module.py:35
    wire [31:0] mem_2_i; //@ demo_module.py:35
    reg  [31:0] mem_2_o; //@ demo_module.py:35
    wire [31:0] mem_3_i; //@ demo_module.py:35
    reg  [31:0] mem_3_o; //@ demo_module.py:35
    wire [31:0] mem_4_i; //@ demo_module.py:35
    reg  [31:0] mem_4_o; //@ demo_module.py:35
    wire [31:0] mem_5_i; //@ demo_module.py:35
    reg  [31:0] mem_5_o; //@ demo_module.py:35
    wire [31:0] mem_6_i; //@ demo_module.py:35
    reg  [31:0] mem_6_o; //@ demo_module.py:35
    wire [31:0] mem_7_i; //@ demo_module.py:35
    reg  [31:0] mem_7_o; //@ demo_module.py:35
    wire [31:0] mem_8_i; //@ demo_module.py:35
    reg  [31:0] mem_8_o; //@ demo_module.py:35
    wire [31:0] mem_9_i; //@ demo_module.py:35
    reg  [31:0] mem_9_o; //@ demo_module.py:35
    wire [31:0] mem_10_i; //@ demo_module.py:35
    reg  [31:0] mem_10_o; //@ demo_module.py:35
    wire [31:0] mem_11_i; //@ demo_module.py:35
    reg  [31:0] mem_11_o; //@ demo_module.py:35
    wire [31:0] mem_12_i; //@ demo_module.py:35
    reg  [31:0] mem_12_o; //@ demo_module.py:35
    wire [31:0] mem_13_i; //@ demo_module.py:35
    reg  [31:0] mem_13_o; //@ demo_module.py:35
    wire [31:0] mem_14_i; //@ demo_module.py:35
    reg  [31:0] mem_14_o; //@ demo_module.py:35
    wire [31:0] mem_15_i; //@ demo_module.py:35
    reg  [31:0] mem_15_o; //@ demo_module.py:35
    wire  _T_0; //@ demo_module.py:36
    wire  _T_1; //@ demo_module.py:37
    wire [31:0] _T_2; //@ demo_module.py:37
    wire  _T_3; //@ demo_module.py:37
    wire [31:0] _T_4; //@ demo_module.py:37
    wire  _T_5; //@ demo_module.py:37
    wire [31:0] _T_6; //@ demo_module.py:37
    wire  _T_7; //@ demo_module.py:37
    wire [31:0] _T_8; //@ demo_module.py:37
    wire  _T_9; //@ demo_module.py:37
    wire [31:0] _T_10; //@ demo_module.py:37
    wire  _T_11; //@ demo_module.py:37
    wire [31:0] _T_12; //@ demo_module.py:37
    wire  _T_13; //@ demo_module.py:37
    wire [31:0] _T_14; //@ demo_module.py:37
    wire  _T_15; //@ demo_module.py:37
    wire [31:0] _T_16; //@ demo_module.py:37
    wire  _T_17; //@ demo_module.py:37
    wire [31:0] _T_18; //@ demo_module.py:37
    wire  _T_19; //@ demo_module.py:37
    wire [31:0] _T_20; //@ demo_module.py:37
    wire  _T_21; //@ demo_module.py:37
    wire [31:0] _T_22; //@ demo_module.py:37
    wire  _T_23; //@ demo_module.py:37
    wire [31:0] _T_24; //@ demo_module.py:37
    wire  _T_25; //@ demo_module.py:37
    wire [31:0] _T_26; //@ demo_module.py:37
    wire  _T_27; //@ demo_module.py:37
    wire [31:0] _T_28; //@ demo_module.py:37
    wire  _T_29; //@ demo_module.py:37
    wire [31:0] _T_30; //@ demo_module.py:37
    wire  _T_31; //@ demo_module.py:37
    wire [31:0] _T_32; //@ demo_module.py:37
    wire  _T_33; //@ demo_module.py:37
    wire [31:0] _T_34; //@ demo_module.py:37
    wire  _T_35; //@ demo_module.py:37
    wire [31:0] _T_36; //@ demo_module.py:37
    wire  _T_37; //@ demo_module.py:37
    wire [31:0] _T_38; //@ demo_module.py:37
    wire  _T_39; //@ demo_module.py:37
    wire [31:0] _T_40; //@ demo_module.py:37
    wire  _T_41; //@ demo_module.py:37
    wire [31:0] _T_42; //@ demo_module.py:37
    wire  _T_43; //@ demo_module.py:37
    wire [31:0] _T_44; //@ demo_module.py:37
    wire  _T_45; //@ demo_module.py:37
    wire [31:0] _T_46; //@ demo_module.py:37
    wire  _T_47; //@ demo_module.py:37
    wire [31:0] _T_48; //@ demo_module.py:37
    wire  _T_49; //@ demo_module.py:37
    wire [31:0] _T_50; //@ demo_module.py:37
    wire  _T_51; //@ demo_module.py:37
    wire [31:0] _T_52; //@ demo_module.py:37
    wire  _T_53; //@ demo_module.py:37
    wire [31:0] _T_54; //@ demo_module.py:37
    wire  _T_55; //@ demo_module.py:37
    wire [31:0] _T_56; //@ demo_module.py:37
    wire  _T_57; //@ demo_module.py:37
    wire [31:0] _T_58; //@ demo_module.py:37
    wire  _T_59; //@ demo_module.py:37
    wire [31:0] _T_60; //@ demo_module.py:37
    wire  _T_61; //@ demo_module.py:37
    wire [31:0] _T_62; //@ demo_module.py:37
    wire  _T_63; //@ demo_module.py:37
    wire [31:0] _T_64; //@ demo_module.py:37
    always @(posedge clock) //@ demo_module.py:35
        mem_0_o <= mem_0_i;
    always @(posedge clock) //@ demo_module.py:35
        mem_1_o <= mem_1_i;
    always @(posedge clock) //@ demo_module.py:35
        mem_2_o <= mem_2_i;
    always @(posedge clock) //@ demo_module.py:35
        mem_3_o <= mem_3_i;
    always @(posedge clock) //@ demo_module.py:35
        mem_4_o <= mem_4_i;
    always @(posedge clock) //@ demo_module.py:35
        mem_5_o <= mem_5_i;
    always @(posedge clock) //@ demo_module.py:35
        mem_6_o <= mem_6_i;
    always @(posedge clock) //@ demo_module.py:35
        mem_7_o <= mem_7_i;
    always @(posedge clock) //@ demo_module.py:35
        mem_8_o <= mem_8_i;
    always @(posedge clock) //@ demo_module.py:35
        mem_9_o <= mem_9_i;
    always @(posedge clock) //@ demo_module.py:35
        mem_10_o <= mem_10_i;
    always @(posedge clock) //@ demo_module.py:35
        mem_11_o <= mem_11_i;
    always @(posedge clock) //@ demo_module.py:35
        mem_12_o <= mem_12_i;
    always @(posedge clock) //@ demo_module.py:35
        mem_13_o <= mem_13_i;
    always @(posedge clock) //@ demo_module.py:35
        mem_14_o <= mem_14_i;
    always @(posedge clock) //@ demo_module.py:35
        mem_15_o <= mem_15_i;
    assign _T_0 = (io_req_op == 4'h1); //@ demo_module.py:36
    assign _T_1 = (io_req_address == 4'h0); //@ demo_module.py:37
    assign _T_3 = (_T_0 & _T_1); //@ demo_module.py:37
    assign _T_4 = (_T_3 ? io_req_data : mem_0_o); //@ demo_module.py:37
    assign _T_2 = _T_4; //@ demo_module.py:37
    assign mem_0_i = _T_2; //@ demo_module.py:37
    assign _T_5 = (io_req_address == 4'h1); //@ demo_module.py:37
    assign _T_7 = (_T_0 & _T_5); //@ demo_module.py:37
    assign _T_8 = (_T_7 ? io_req_data : mem_1_o); //@ demo_module.py:37
    assign _T_6 = _T_8; //@ demo_module.py:37
    assign mem_1_i = _T_6; //@ demo_module.py:37
    assign _T_9 = (io_req_address == 4'h2); //@ demo_module.py:37
    assign _T_11 = (_T_0 & _T_9); //@ demo_module.py:37
    assign _T_12 = (_T_11 ? io_req_data : mem_2_o); //@ demo_module.py:37
    assign _T_10 = _T_12; //@ demo_module.py:37
    assign mem_2_i = _T_10; //@ demo_module.py:37
    assign _T_13 = (io_req_address == 4'h3); //@ demo_module.py:37
    assign _T_15 = (_T_0 & _T_13); //@ demo_module.py:37
    assign _T_16 = (_T_15 ? io_req_data : mem_3_o); //@ demo_module.py:37
    assign _T_14 = _T_16; //@ demo_module.py:37
    assign mem_3_i = _T_14; //@ demo_module.py:37
    assign _T_17 = (io_req_address == 4'h4); //@ demo_module.py:37
    assign _T_19 = (_T_0 & _T_17); //@ demo_module.py:37
    assign _T_20 = (_T_19 ? io_req_data : mem_4_o); //@ demo_module.py:37
    assign _T_18 = _T_20; //@ demo_module.py:37
    assign mem_4_i = _T_18; //@ demo_module.py:37
    assign _T_21 = (io_req_address == 4'h5); //@ demo_module.py:37
    assign _T_23 = (_T_0 & _T_21); //@ demo_module.py:37
    assign _T_24 = (_T_23 ? io_req_data : mem_5_o); //@ demo_module.py:37
    assign _T_22 = _T_24; //@ demo_module.py:37
    assign mem_5_i = _T_22; //@ demo_module.py:37
    assign _T_25 = (io_req_address == 4'h6); //@ demo_module.py:37
    assign _T_27 = (_T_0 & _T_25); //@ demo_module.py:37
    assign _T_28 = (_T_27 ? io_req_data : mem_6_o); //@ demo_module.py:37
    assign _T_26 = _T_28; //@ demo_module.py:37
    assign mem_6_i = _T_26; //@ demo_module.py:37
    assign _T_29 = (io_req_address == 4'h7); //@ demo_module.py:37
    assign _T_31 = (_T_0 & _T_29); //@ demo_module.py:37
    assign _T_32 = (_T_31 ? io_req_data : mem_7_o); //@ demo_module.py:37
    assign _T_30 = _T_32; //@ demo_module.py:37
    assign mem_7_i = _T_30; //@ demo_module.py:37
    assign _T_33 = (io_req_address == 4'h8); //@ demo_module.py:37
    assign _T_35 = (_T_0 & _T_33); //@ demo_module.py:37
    assign _T_36 = (_T_35 ? io_req_data : mem_8_o); //@ demo_module.py:37
    assign _T_34 = _T_36; //@ demo_module.py:37
    assign mem_8_i = _T_34; //@ demo_module.py:37
    assign _T_37 = (io_req_address == 4'h9); //@ demo_module.py:37
    assign _T_39 = (_T_0 & _T_37); //@ demo_module.py:37
    assign _T_40 = (_T_39 ? io_req_data : mem_9_o); //@ demo_module.py:37
    assign _T_38 = _T_40; //@ demo_module.py:37
    assign mem_9_i = _T_38; //@ demo_module.py:37
    assign _T_41 = (io_req_address == 4'ha); //@ demo_module.py:37
    assign _T_43 = (_T_0 & _T_41); //@ demo_module.py:37
    assign _T_44 = (_T_43 ? io_req_data : mem_10_o); //@ demo_module.py:37
    assign _T_42 = _T_44; //@ demo_module.py:37
    assign mem_10_i = _T_42; //@ demo_module.py:37
    assign _T_45 = (io_req_address == 4'hb); //@ demo_module.py:37
    assign _T_47 = (_T_0 & _T_45); //@ demo_module.py:37
    assign _T_48 = (_T_47 ? io_req_data : mem_11_o); //@ demo_module.py:37
    assign _T_46 = _T_48; //@ demo_module.py:37
    assign mem_11_i = _T_46; //@ demo_module.py:37
    assign _T_49 = (io_req_address == 4'hc); //@ demo_module.py:37
    assign _T_51 = (_T_0 & _T_49); //@ demo_module.py:37
    assign _T_52 = (_T_51 ? io_req_data : mem_12_o); //@ demo_module.py:37
    assign _T_50 = _T_52; //@ demo_module.py:37
    assign mem_12_i = _T_50; //@ demo_module.py:37
    assign _T_53 = (io_req_address == 4'hd); //@ demo_module.py:37
    assign _T_55 = (_T_0 & _T_53); //@ demo_module.py:37
    assign _T_56 = (_T_55 ? io_req_data : mem_13_o); //@ demo_module.py:37
    assign _T_54 = _T_56; //@ demo_module.py:37
    assign mem_13_i = _T_54; //@ demo_module.py:37
    assign _T_57 = (io_req_address == 4'he); //@ demo_module.py:37
    assign _T_59 = (_T_0 & _T_57); //@ demo_module.py:37
    assign _T_60 = (_T_59 ? io_req_data : mem_14_o); //@ demo_module.py:37
    assign _T_58 = _T_60; //@ demo_module.py:37
    assign mem_14_i = _T_58; //@ demo_module.py:37
    assign _T_61 = (io_req_address == 4'hf); //@ demo_module.py:37
    assign _T_63 = (_T_0 & _T_61); //@ demo_module.py:37
    assign _T_64 = (_T_63 ? io_req_data : mem_15_o); //@ demo_module.py:37
    assign _T_62 = _T_64; //@ demo_module.py:37
    assign mem_15_i = _T_62; //@ demo_module.py:37
endmodule
