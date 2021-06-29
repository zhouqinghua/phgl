module method_ready_valid_top(
    input  wire  clock, //@ phgl_generator.py:85
    input  wire  reset  //@ phgl_generator.py:85
);
    wire  md_source_io_req_ready; //@ demo_method_ready_valid.py:51
    wire  md_source_io_req_valid; //@ demo_method_ready_valid.py:51
    wire [3:0] md_source_io_req_bits_op; //@ demo_method_ready_valid.py:51
    wire [3:0] md_source_io_req_bits_address; //@ demo_method_ready_valid.py:51
    wire [31:0] md_source_io_req_bits_data; //@ demo_method_ready_valid.py:51
    wire  md_source_clock; //@ demo_method_ready_valid.py:51
    wire  md_source_reset; //@ demo_method_ready_valid.py:51
    wire  md_sink_io_req_ready; //@ demo_method_ready_valid.py:52
    wire  md_sink_io_req_valid; //@ demo_method_ready_valid.py:52
    wire [3:0] md_sink_io_req_bits_op; //@ demo_method_ready_valid.py:52
    wire [3:0] md_sink_io_req_bits_address; //@ demo_method_ready_valid.py:52
    wire [31:0] md_sink_io_req_bits_data; //@ demo_method_ready_valid.py:52
    wire  md_sink_clock; //@ demo_method_ready_valid.py:52
    wire  md_sink_reset; //@ demo_method_ready_valid.py:52
    sub_module_source md_source( //@ demo_method_ready_valid.py:51
        .io_req_ready(md_source_io_req_ready),
        .io_req_valid(md_source_io_req_valid),
        .io_req_bits_op(md_source_io_req_bits_op),
        .io_req_bits_address(md_source_io_req_bits_address),
        .io_req_bits_data(md_source_io_req_bits_data),
        .clock(md_source_clock),
        .reset(md_source_reset)
    );
    assign md_source_clock = clock; //@ demo_method_ready_valid.py:51
    assign md_source_reset = reset; //@ demo_method_ready_valid.py:51
    sub_module_sink md_sink( //@ demo_method_ready_valid.py:52
        .io_req_ready(md_sink_io_req_ready),
        .io_req_valid(md_sink_io_req_valid),
        .io_req_bits_op(md_sink_io_req_bits_op),
        .io_req_bits_address(md_sink_io_req_bits_address),
        .io_req_bits_data(md_sink_io_req_bits_data),
        .clock(md_sink_clock),
        .reset(md_sink_reset)
    );
    assign md_sink_clock = clock; //@ demo_method_ready_valid.py:52
    assign md_sink_reset = reset; //@ demo_method_ready_valid.py:52
    assign md_sink_io_req_bits_data = md_source_io_req_bits_data; //@ demo_method_ready_valid.py:53
    assign md_sink_io_req_bits_address = md_source_io_req_bits_address; //@ demo_method_ready_valid.py:53
    assign md_sink_io_req_bits_op = md_source_io_req_bits_op; //@ demo_method_ready_valid.py:53
    assign md_sink_io_req_valid = md_source_io_req_valid; //@ demo_method_ready_valid.py:53
    assign md_source_io_req_ready = md_sink_io_req_ready; //@ demo_method_ready_valid.py:53
endmodule
module sub_module_source(
    input  wire  io_req_ready, //@ demo_method_ready_valid.py:14
    output wire  io_req_valid, //@ demo_method_ready_valid.py:14
    output wire [3:0] io_req_bits_op, //@ demo_method_ready_valid.py:14
    output wire [3:0] io_req_bits_address, //@ demo_method_ready_valid.py:14
    output wire [31:0] io_req_bits_data, //@ demo_method_ready_valid.py:14
    input  wire  clock, //@ demo_method_ready_valid.py:51
    input  wire  reset  //@ demo_method_ready_valid.py:51
);
    wire [3:0] addr_reg_i; //@ demo_method_ready_valid.py:19
    reg  [3:0] addr_reg_o; //@ demo_method_ready_valid.py:19
    wire  _T_0; //@ demo_method_ready_valid.py:25
    wire [4:0] _T_1; //@ demo_method_ready_valid.py:26
    wire [3:0] _T_2; //@ demo_method_ready_valid.py:26
    wire [4:0] _T_3; //@ demo_method_ready_valid.py:26
    wire [3:0] _T_4; //@ demo_method_ready_valid.py:26
    wire [3:0] _T_5; //@ demo_method_ready_valid.py:26
    always @(posedge clock) //@ demo_method_ready_valid.py:19
        if (reset)
            addr_reg_o <= 4'h0;
        else
            addr_reg_o <= addr_reg_i;
    assign io_req_valid = 1'h1; //@ demo_method_ready_valid.py:20
    assign io_req_bits_op = 4'h1; //@ demo_method_ready_valid.py:21
    assign io_req_bits_address = addr_reg_o; //@ demo_method_ready_valid.py:22
    assign io_req_bits_data = 32'h12345678; //@ demo_method_ready_valid.py:23
    assign _T_0 = (io_req_ready & io_req_valid); //@ demo_method_ready_valid.py:25
    assign _T_1 = (addr_reg_o + 4'h1); //@ demo_method_ready_valid.py:26
    assign _T_3 = (_T_0 ? _T_1 : addr_reg_o); //@ demo_method_ready_valid.py:26
    assign _T_5 = _T_3[3:0]; //@ demo_method_ready_valid.py:26
    assign _T_4 = _T_5; //@ demo_method_ready_valid.py:26
    assign _T_2 = _T_4; //@ demo_method_ready_valid.py:26
    assign addr_reg_i = _T_2; //@ demo_method_ready_valid.py:26
endmodule
module sub_module_sink(
    output wire  io_req_ready, //@ demo_method_ready_valid.py:32
    input  wire  io_req_valid, //@ demo_method_ready_valid.py:32
    input  wire [3:0] io_req_bits_op, //@ demo_method_ready_valid.py:32
    input  wire [3:0] io_req_bits_address, //@ demo_method_ready_valid.py:32
    input  wire [31:0] io_req_bits_data, //@ demo_method_ready_valid.py:32
    input  wire  clock, //@ demo_method_ready_valid.py:52
    input  wire  reset  //@ demo_method_ready_valid.py:52
);
    wire [31:0] mem_0_i; //@ demo_method_ready_valid.py:37
    reg  [31:0] mem_0_o; //@ demo_method_ready_valid.py:37
    wire [31:0] mem_1_i; //@ demo_method_ready_valid.py:37
    reg  [31:0] mem_1_o; //@ demo_method_ready_valid.py:37
    wire [31:0] mem_2_i; //@ demo_method_ready_valid.py:37
    reg  [31:0] mem_2_o; //@ demo_method_ready_valid.py:37
    wire [31:0] mem_3_i; //@ demo_method_ready_valid.py:37
    reg  [31:0] mem_3_o; //@ demo_method_ready_valid.py:37
    wire [31:0] mem_4_i; //@ demo_method_ready_valid.py:37
    reg  [31:0] mem_4_o; //@ demo_method_ready_valid.py:37
    wire [31:0] mem_5_i; //@ demo_method_ready_valid.py:37
    reg  [31:0] mem_5_o; //@ demo_method_ready_valid.py:37
    wire [31:0] mem_6_i; //@ demo_method_ready_valid.py:37
    reg  [31:0] mem_6_o; //@ demo_method_ready_valid.py:37
    wire [31:0] mem_7_i; //@ demo_method_ready_valid.py:37
    reg  [31:0] mem_7_o; //@ demo_method_ready_valid.py:37
    wire [31:0] mem_8_i; //@ demo_method_ready_valid.py:37
    reg  [31:0] mem_8_o; //@ demo_method_ready_valid.py:37
    wire [31:0] mem_9_i; //@ demo_method_ready_valid.py:37
    reg  [31:0] mem_9_o; //@ demo_method_ready_valid.py:37
    wire [31:0] mem_10_i; //@ demo_method_ready_valid.py:37
    reg  [31:0] mem_10_o; //@ demo_method_ready_valid.py:37
    wire [31:0] mem_11_i; //@ demo_method_ready_valid.py:37
    reg  [31:0] mem_11_o; //@ demo_method_ready_valid.py:37
    wire [31:0] mem_12_i; //@ demo_method_ready_valid.py:37
    reg  [31:0] mem_12_o; //@ demo_method_ready_valid.py:37
    wire [31:0] mem_13_i; //@ demo_method_ready_valid.py:37
    reg  [31:0] mem_13_o; //@ demo_method_ready_valid.py:37
    wire [31:0] mem_14_i; //@ demo_method_ready_valid.py:37
    reg  [31:0] mem_14_o; //@ demo_method_ready_valid.py:37
    wire [31:0] mem_15_i; //@ demo_method_ready_valid.py:37
    reg  [31:0] mem_15_o; //@ demo_method_ready_valid.py:37
    wire  _T_0; //@ demo_method_ready_valid.py:38
    wire  _T_1; //@ demo_method_ready_valid.py:39
    wire  _T_2; //@ demo_method_ready_valid.py:40
    wire [31:0] _T_3; //@ demo_method_ready_valid.py:40
    wire  _T_4; //@ demo_method_ready_valid.py:40
    wire  _T_5; //@ demo_method_ready_valid.py:40
    wire [31:0] _T_6; //@ demo_method_ready_valid.py:40
    wire  _T_7; //@ demo_method_ready_valid.py:40
    wire [31:0] _T_8; //@ demo_method_ready_valid.py:40
    wire  _T_9; //@ demo_method_ready_valid.py:40
    wire  _T_10; //@ demo_method_ready_valid.py:40
    wire [31:0] _T_11; //@ demo_method_ready_valid.py:40
    wire  _T_12; //@ demo_method_ready_valid.py:40
    wire [31:0] _T_13; //@ demo_method_ready_valid.py:40
    wire  _T_14; //@ demo_method_ready_valid.py:40
    wire  _T_15; //@ demo_method_ready_valid.py:40
    wire [31:0] _T_16; //@ demo_method_ready_valid.py:40
    wire  _T_17; //@ demo_method_ready_valid.py:40
    wire [31:0] _T_18; //@ demo_method_ready_valid.py:40
    wire  _T_19; //@ demo_method_ready_valid.py:40
    wire  _T_20; //@ demo_method_ready_valid.py:40
    wire [31:0] _T_21; //@ demo_method_ready_valid.py:40
    wire  _T_22; //@ demo_method_ready_valid.py:40
    wire [31:0] _T_23; //@ demo_method_ready_valid.py:40
    wire  _T_24; //@ demo_method_ready_valid.py:40
    wire  _T_25; //@ demo_method_ready_valid.py:40
    wire [31:0] _T_26; //@ demo_method_ready_valid.py:40
    wire  _T_27; //@ demo_method_ready_valid.py:40
    wire [31:0] _T_28; //@ demo_method_ready_valid.py:40
    wire  _T_29; //@ demo_method_ready_valid.py:40
    wire  _T_30; //@ demo_method_ready_valid.py:40
    wire [31:0] _T_31; //@ demo_method_ready_valid.py:40
    wire  _T_32; //@ demo_method_ready_valid.py:40
    wire [31:0] _T_33; //@ demo_method_ready_valid.py:40
    wire  _T_34; //@ demo_method_ready_valid.py:40
    wire  _T_35; //@ demo_method_ready_valid.py:40
    wire [31:0] _T_36; //@ demo_method_ready_valid.py:40
    wire  _T_37; //@ demo_method_ready_valid.py:40
    wire [31:0] _T_38; //@ demo_method_ready_valid.py:40
    wire  _T_39; //@ demo_method_ready_valid.py:40
    wire  _T_40; //@ demo_method_ready_valid.py:40
    wire [31:0] _T_41; //@ demo_method_ready_valid.py:40
    wire  _T_42; //@ demo_method_ready_valid.py:40
    wire [31:0] _T_43; //@ demo_method_ready_valid.py:40
    wire  _T_44; //@ demo_method_ready_valid.py:40
    wire  _T_45; //@ demo_method_ready_valid.py:40
    wire [31:0] _T_46; //@ demo_method_ready_valid.py:40
    wire  _T_47; //@ demo_method_ready_valid.py:40
    wire [31:0] _T_48; //@ demo_method_ready_valid.py:40
    wire  _T_49; //@ demo_method_ready_valid.py:40
    wire  _T_50; //@ demo_method_ready_valid.py:40
    wire [31:0] _T_51; //@ demo_method_ready_valid.py:40
    wire  _T_52; //@ demo_method_ready_valid.py:40
    wire [31:0] _T_53; //@ demo_method_ready_valid.py:40
    wire  _T_54; //@ demo_method_ready_valid.py:40
    wire  _T_55; //@ demo_method_ready_valid.py:40
    wire [31:0] _T_56; //@ demo_method_ready_valid.py:40
    wire  _T_57; //@ demo_method_ready_valid.py:40
    wire [31:0] _T_58; //@ demo_method_ready_valid.py:40
    wire  _T_59; //@ demo_method_ready_valid.py:40
    wire  _T_60; //@ demo_method_ready_valid.py:40
    wire [31:0] _T_61; //@ demo_method_ready_valid.py:40
    wire  _T_62; //@ demo_method_ready_valid.py:40
    wire [31:0] _T_63; //@ demo_method_ready_valid.py:40
    wire  _T_64; //@ demo_method_ready_valid.py:40
    wire  _T_65; //@ demo_method_ready_valid.py:40
    wire [31:0] _T_66; //@ demo_method_ready_valid.py:40
    wire  _T_67; //@ demo_method_ready_valid.py:40
    wire [31:0] _T_68; //@ demo_method_ready_valid.py:40
    wire  _T_69; //@ demo_method_ready_valid.py:40
    wire  _T_70; //@ demo_method_ready_valid.py:40
    wire [31:0] _T_71; //@ demo_method_ready_valid.py:40
    wire  _T_72; //@ demo_method_ready_valid.py:40
    wire [31:0] _T_73; //@ demo_method_ready_valid.py:40
    wire  _T_74; //@ demo_method_ready_valid.py:40
    wire  _T_75; //@ demo_method_ready_valid.py:40
    wire [31:0] _T_76; //@ demo_method_ready_valid.py:40
    wire  _T_77; //@ demo_method_ready_valid.py:40
    wire [31:0] _T_78; //@ demo_method_ready_valid.py:40
    wire  _T_79; //@ demo_method_ready_valid.py:40
    wire  _T_80; //@ demo_method_ready_valid.py:40
    wire [31:0] _T_81; //@ demo_method_ready_valid.py:40
    wire  _T_82_i; //@ demo_method_ready_valid.py:41
    reg   _T_82_o; //@ demo_method_ready_valid.py:41
    always @(posedge clock) //@ demo_method_ready_valid.py:37
        mem_0_o <= mem_0_i;
    always @(posedge clock) //@ demo_method_ready_valid.py:37
        mem_1_o <= mem_1_i;
    always @(posedge clock) //@ demo_method_ready_valid.py:37
        mem_2_o <= mem_2_i;
    always @(posedge clock) //@ demo_method_ready_valid.py:37
        mem_3_o <= mem_3_i;
    always @(posedge clock) //@ demo_method_ready_valid.py:37
        mem_4_o <= mem_4_i;
    always @(posedge clock) //@ demo_method_ready_valid.py:37
        mem_5_o <= mem_5_i;
    always @(posedge clock) //@ demo_method_ready_valid.py:37
        mem_6_o <= mem_6_i;
    always @(posedge clock) //@ demo_method_ready_valid.py:37
        mem_7_o <= mem_7_i;
    always @(posedge clock) //@ demo_method_ready_valid.py:37
        mem_8_o <= mem_8_i;
    always @(posedge clock) //@ demo_method_ready_valid.py:37
        mem_9_o <= mem_9_i;
    always @(posedge clock) //@ demo_method_ready_valid.py:37
        mem_10_o <= mem_10_i;
    always @(posedge clock) //@ demo_method_ready_valid.py:37
        mem_11_o <= mem_11_i;
    always @(posedge clock) //@ demo_method_ready_valid.py:37
        mem_12_o <= mem_12_i;
    always @(posedge clock) //@ demo_method_ready_valid.py:37
        mem_13_o <= mem_13_i;
    always @(posedge clock) //@ demo_method_ready_valid.py:37
        mem_14_o <= mem_14_i;
    always @(posedge clock) //@ demo_method_ready_valid.py:37
        mem_15_o <= mem_15_i;
    always @(posedge clock) //@ demo_method_ready_valid.py:41
        if (reset)
            _T_82_o <= 1'h0;
        else
            _T_82_o <= _T_82_i;
    assign _T_0 = (io_req_ready & io_req_valid); //@ demo_method_ready_valid.py:38
    assign _T_1 = (io_req_bits_op == 4'h1); //@ demo_method_ready_valid.py:39
    assign _T_2 = (io_req_bits_address == 4'h0); //@ demo_method_ready_valid.py:40
    assign _T_4 = (_T_0 & _T_1); //@ demo_method_ready_valid.py:40
    assign _T_5 = (_T_4 & _T_2); //@ demo_method_ready_valid.py:40
    assign _T_6 = (_T_5 ? io_req_bits_data : mem_0_o); //@ demo_method_ready_valid.py:40
    assign _T_3 = _T_6; //@ demo_method_ready_valid.py:40
    assign mem_0_i = _T_3; //@ demo_method_ready_valid.py:40
    assign _T_7 = (io_req_bits_address == 4'h1); //@ demo_method_ready_valid.py:40
    assign _T_9 = (_T_0 & _T_1); //@ demo_method_ready_valid.py:40
    assign _T_10 = (_T_9 & _T_7); //@ demo_method_ready_valid.py:40
    assign _T_11 = (_T_10 ? io_req_bits_data : mem_1_o); //@ demo_method_ready_valid.py:40
    assign _T_8 = _T_11; //@ demo_method_ready_valid.py:40
    assign mem_1_i = _T_8; //@ demo_method_ready_valid.py:40
    assign _T_12 = (io_req_bits_address == 4'h2); //@ demo_method_ready_valid.py:40
    assign _T_14 = (_T_0 & _T_1); //@ demo_method_ready_valid.py:40
    assign _T_15 = (_T_14 & _T_12); //@ demo_method_ready_valid.py:40
    assign _T_16 = (_T_15 ? io_req_bits_data : mem_2_o); //@ demo_method_ready_valid.py:40
    assign _T_13 = _T_16; //@ demo_method_ready_valid.py:40
    assign mem_2_i = _T_13; //@ demo_method_ready_valid.py:40
    assign _T_17 = (io_req_bits_address == 4'h3); //@ demo_method_ready_valid.py:40
    assign _T_19 = (_T_0 & _T_1); //@ demo_method_ready_valid.py:40
    assign _T_20 = (_T_19 & _T_17); //@ demo_method_ready_valid.py:40
    assign _T_21 = (_T_20 ? io_req_bits_data : mem_3_o); //@ demo_method_ready_valid.py:40
    assign _T_18 = _T_21; //@ demo_method_ready_valid.py:40
    assign mem_3_i = _T_18; //@ demo_method_ready_valid.py:40
    assign _T_22 = (io_req_bits_address == 4'h4); //@ demo_method_ready_valid.py:40
    assign _T_24 = (_T_0 & _T_1); //@ demo_method_ready_valid.py:40
    assign _T_25 = (_T_24 & _T_22); //@ demo_method_ready_valid.py:40
    assign _T_26 = (_T_25 ? io_req_bits_data : mem_4_o); //@ demo_method_ready_valid.py:40
    assign _T_23 = _T_26; //@ demo_method_ready_valid.py:40
    assign mem_4_i = _T_23; //@ demo_method_ready_valid.py:40
    assign _T_27 = (io_req_bits_address == 4'h5); //@ demo_method_ready_valid.py:40
    assign _T_29 = (_T_0 & _T_1); //@ demo_method_ready_valid.py:40
    assign _T_30 = (_T_29 & _T_27); //@ demo_method_ready_valid.py:40
    assign _T_31 = (_T_30 ? io_req_bits_data : mem_5_o); //@ demo_method_ready_valid.py:40
    assign _T_28 = _T_31; //@ demo_method_ready_valid.py:40
    assign mem_5_i = _T_28; //@ demo_method_ready_valid.py:40
    assign _T_32 = (io_req_bits_address == 4'h6); //@ demo_method_ready_valid.py:40
    assign _T_34 = (_T_0 & _T_1); //@ demo_method_ready_valid.py:40
    assign _T_35 = (_T_34 & _T_32); //@ demo_method_ready_valid.py:40
    assign _T_36 = (_T_35 ? io_req_bits_data : mem_6_o); //@ demo_method_ready_valid.py:40
    assign _T_33 = _T_36; //@ demo_method_ready_valid.py:40
    assign mem_6_i = _T_33; //@ demo_method_ready_valid.py:40
    assign _T_37 = (io_req_bits_address == 4'h7); //@ demo_method_ready_valid.py:40
    assign _T_39 = (_T_0 & _T_1); //@ demo_method_ready_valid.py:40
    assign _T_40 = (_T_39 & _T_37); //@ demo_method_ready_valid.py:40
    assign _T_41 = (_T_40 ? io_req_bits_data : mem_7_o); //@ demo_method_ready_valid.py:40
    assign _T_38 = _T_41; //@ demo_method_ready_valid.py:40
    assign mem_7_i = _T_38; //@ demo_method_ready_valid.py:40
    assign _T_42 = (io_req_bits_address == 4'h8); //@ demo_method_ready_valid.py:40
    assign _T_44 = (_T_0 & _T_1); //@ demo_method_ready_valid.py:40
    assign _T_45 = (_T_44 & _T_42); //@ demo_method_ready_valid.py:40
    assign _T_46 = (_T_45 ? io_req_bits_data : mem_8_o); //@ demo_method_ready_valid.py:40
    assign _T_43 = _T_46; //@ demo_method_ready_valid.py:40
    assign mem_8_i = _T_43; //@ demo_method_ready_valid.py:40
    assign _T_47 = (io_req_bits_address == 4'h9); //@ demo_method_ready_valid.py:40
    assign _T_49 = (_T_0 & _T_1); //@ demo_method_ready_valid.py:40
    assign _T_50 = (_T_49 & _T_47); //@ demo_method_ready_valid.py:40
    assign _T_51 = (_T_50 ? io_req_bits_data : mem_9_o); //@ demo_method_ready_valid.py:40
    assign _T_48 = _T_51; //@ demo_method_ready_valid.py:40
    assign mem_9_i = _T_48; //@ demo_method_ready_valid.py:40
    assign _T_52 = (io_req_bits_address == 4'ha); //@ demo_method_ready_valid.py:40
    assign _T_54 = (_T_0 & _T_1); //@ demo_method_ready_valid.py:40
    assign _T_55 = (_T_54 & _T_52); //@ demo_method_ready_valid.py:40
    assign _T_56 = (_T_55 ? io_req_bits_data : mem_10_o); //@ demo_method_ready_valid.py:40
    assign _T_53 = _T_56; //@ demo_method_ready_valid.py:40
    assign mem_10_i = _T_53; //@ demo_method_ready_valid.py:40
    assign _T_57 = (io_req_bits_address == 4'hb); //@ demo_method_ready_valid.py:40
    assign _T_59 = (_T_0 & _T_1); //@ demo_method_ready_valid.py:40
    assign _T_60 = (_T_59 & _T_57); //@ demo_method_ready_valid.py:40
    assign _T_61 = (_T_60 ? io_req_bits_data : mem_11_o); //@ demo_method_ready_valid.py:40
    assign _T_58 = _T_61; //@ demo_method_ready_valid.py:40
    assign mem_11_i = _T_58; //@ demo_method_ready_valid.py:40
    assign _T_62 = (io_req_bits_address == 4'hc); //@ demo_method_ready_valid.py:40
    assign _T_64 = (_T_0 & _T_1); //@ demo_method_ready_valid.py:40
    assign _T_65 = (_T_64 & _T_62); //@ demo_method_ready_valid.py:40
    assign _T_66 = (_T_65 ? io_req_bits_data : mem_12_o); //@ demo_method_ready_valid.py:40
    assign _T_63 = _T_66; //@ demo_method_ready_valid.py:40
    assign mem_12_i = _T_63; //@ demo_method_ready_valid.py:40
    assign _T_67 = (io_req_bits_address == 4'hd); //@ demo_method_ready_valid.py:40
    assign _T_69 = (_T_0 & _T_1); //@ demo_method_ready_valid.py:40
    assign _T_70 = (_T_69 & _T_67); //@ demo_method_ready_valid.py:40
    assign _T_71 = (_T_70 ? io_req_bits_data : mem_13_o); //@ demo_method_ready_valid.py:40
    assign _T_68 = _T_71; //@ demo_method_ready_valid.py:40
    assign mem_13_i = _T_68; //@ demo_method_ready_valid.py:40
    assign _T_72 = (io_req_bits_address == 4'he); //@ demo_method_ready_valid.py:40
    assign _T_74 = (_T_0 & _T_1); //@ demo_method_ready_valid.py:40
    assign _T_75 = (_T_74 & _T_72); //@ demo_method_ready_valid.py:40
    assign _T_76 = (_T_75 ? io_req_bits_data : mem_14_o); //@ demo_method_ready_valid.py:40
    assign _T_73 = _T_76; //@ demo_method_ready_valid.py:40
    assign mem_14_i = _T_73; //@ demo_method_ready_valid.py:40
    assign _T_77 = (io_req_bits_address == 4'hf); //@ demo_method_ready_valid.py:40
    assign _T_79 = (_T_0 & _T_1); //@ demo_method_ready_valid.py:40
    assign _T_80 = (_T_79 & _T_77); //@ demo_method_ready_valid.py:40
    assign _T_81 = (_T_80 ? io_req_bits_data : mem_15_o); //@ demo_method_ready_valid.py:40
    assign _T_78 = _T_81; //@ demo_method_ready_valid.py:40
    assign mem_15_i = _T_78; //@ demo_method_ready_valid.py:40
    assign _T_82_i = io_req_valid; //@ demo_method_ready_valid.py:41
    assign io_req_ready = _T_82_o; //@ demo_method_ready_valid.py:41
endmodule
