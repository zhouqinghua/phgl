module method_tran_top(
    input  wire  clock, //@ phgl_generator.py:85
    input  wire  reset  //@ phgl_generator.py:85
);
    wire [7:0] md0_io_bus0; //@ demo_method_tran.py:28
    wire [7:0] md0_io_bus1; //@ demo_method_tran.py:28
    wire  md0_clock; //@ demo_method_tran.py:28
    wire  md0_reset; //@ demo_method_tran.py:28
    wire [7:0] md1_io_bus0; //@ demo_method_tran.py:29
    wire [7:0] md1_io_bus1; //@ demo_method_tran.py:29
    wire  md1_clock; //@ demo_method_tran.py:29
    wire  md1_reset; //@ demo_method_tran.py:29
    sub_module0 md0( //@ demo_method_tran.py:28
        .io_bus0(md0_io_bus0),
        .io_bus1(md0_io_bus1),
        .clock(md0_clock),
        .reset(md0_reset)
    );
    assign md0_clock = clock; //@ demo_method_tran.py:28
    assign md0_reset = reset; //@ demo_method_tran.py:28
    sub_module1 md1( //@ demo_method_tran.py:29
        .io_bus0(md1_io_bus0),
        .io_bus1(md1_io_bus1),
        .clock(md1_clock),
        .reset(md1_reset)
    );
    assign md1_clock = clock; //@ demo_method_tran.py:29
    assign md1_reset = reset; //@ demo_method_tran.py:29
    pullup (weak1) pu_md0_io_bus0_0_ (md0_io_bus0[0]); //@ demo_method_tran.py:31
    pullup (weak1) pu_md0_io_bus0_1_ (md0_io_bus0[1]); //@ demo_method_tran.py:31
    pullup (weak1) pu_md0_io_bus0_2_ (md0_io_bus0[2]); //@ demo_method_tran.py:31
    pullup (weak1) pu_md0_io_bus0_3_ (md0_io_bus0[3]); //@ demo_method_tran.py:31
    pullup (weak1) pu_md0_io_bus0_4_ (md0_io_bus0[4]); //@ demo_method_tran.py:31
    pullup (weak1) pu_md0_io_bus0_5_ (md0_io_bus0[5]); //@ demo_method_tran.py:31
    pullup (weak1) pu_md0_io_bus0_6_ (md0_io_bus0[6]); //@ demo_method_tran.py:31
    pullup (weak1) pu_md0_io_bus0_7_ (md0_io_bus0[7]); //@ demo_method_tran.py:31
    pullup (weak1) pu_md1_io_bus0_0_ (md1_io_bus0[0]); //@ demo_method_tran.py:32
    pullup (weak1) pu_md1_io_bus0_1_ (md1_io_bus0[1]); //@ demo_method_tran.py:32
    pullup (weak1) pu_md1_io_bus0_2_ (md1_io_bus0[2]); //@ demo_method_tran.py:32
    pullup (weak1) pu_md1_io_bus0_3_ (md1_io_bus0[3]); //@ demo_method_tran.py:32
    pullup (weak1) pu_md1_io_bus0_4_ (md1_io_bus0[4]); //@ demo_method_tran.py:32
    pullup (weak1) pu_md1_io_bus0_5_ (md1_io_bus0[5]); //@ demo_method_tran.py:32
    pullup (weak1) pu_md1_io_bus0_6_ (md1_io_bus0[6]); //@ demo_method_tran.py:32
    pullup (weak1) pu_md1_io_bus0_7_ (md1_io_bus0[7]); //@ demo_method_tran.py:32
    pulldown (weak0) pd_md0_io_bus1_0_ (md0_io_bus1[0]); //@ demo_method_tran.py:34
    pulldown (weak0) pd_md0_io_bus1_1_ (md0_io_bus1[1]); //@ demo_method_tran.py:34
    pulldown (weak0) pd_md0_io_bus1_2_ (md0_io_bus1[2]); //@ demo_method_tran.py:34
    pulldown (weak0) pd_md0_io_bus1_3_ (md0_io_bus1[3]); //@ demo_method_tran.py:34
    pulldown (weak0) pd_md0_io_bus1_4_ (md0_io_bus1[4]); //@ demo_method_tran.py:34
    pulldown (weak0) pd_md0_io_bus1_5_ (md0_io_bus1[5]); //@ demo_method_tran.py:34
    pulldown (weak0) pd_md0_io_bus1_6_ (md0_io_bus1[6]); //@ demo_method_tran.py:34
    pulldown (weak0) pd_md0_io_bus1_7_ (md0_io_bus1[7]); //@ demo_method_tran.py:34
    pulldown (weak0) pd_md1_io_bus1_0_ (md1_io_bus1[0]); //@ demo_method_tran.py:35
    pulldown (weak0) pd_md1_io_bus1_1_ (md1_io_bus1[1]); //@ demo_method_tran.py:35
    pulldown (weak0) pd_md1_io_bus1_2_ (md1_io_bus1[2]); //@ demo_method_tran.py:35
    pulldown (weak0) pd_md1_io_bus1_3_ (md1_io_bus1[3]); //@ demo_method_tran.py:35
    pulldown (weak0) pd_md1_io_bus1_4_ (md1_io_bus1[4]); //@ demo_method_tran.py:35
    pulldown (weak0) pd_md1_io_bus1_5_ (md1_io_bus1[5]); //@ demo_method_tran.py:35
    pulldown (weak0) pd_md1_io_bus1_6_ (md1_io_bus1[6]); //@ demo_method_tran.py:35
    pulldown (weak0) pd_md1_io_bus1_7_ (md1_io_bus1[7]); //@ demo_method_tran.py:35
    tran tr_md0_io_bus0_0__md1_io_bus0_0_(md0_io_bus0[0], md1_io_bus0[0]); //@ demo_method_tran.py:37
    tran tr_md0_io_bus0_1__md1_io_bus0_1_(md0_io_bus0[1], md1_io_bus0[1]); //@ demo_method_tran.py:37
    tran tr_md0_io_bus0_2__md1_io_bus0_2_(md0_io_bus0[2], md1_io_bus0[2]); //@ demo_method_tran.py:37
    tran tr_md0_io_bus0_3__md1_io_bus0_3_(md0_io_bus0[3], md1_io_bus0[3]); //@ demo_method_tran.py:37
    tran tr_md0_io_bus0_4__md1_io_bus0_4_(md0_io_bus0[4], md1_io_bus0[4]); //@ demo_method_tran.py:37
    tran tr_md0_io_bus0_5__md1_io_bus0_5_(md0_io_bus0[5], md1_io_bus0[5]); //@ demo_method_tran.py:37
    tran tr_md0_io_bus0_6__md1_io_bus0_6_(md0_io_bus0[6], md1_io_bus0[6]); //@ demo_method_tran.py:37
    tran tr_md0_io_bus0_7__md1_io_bus0_7_(md0_io_bus0[7], md1_io_bus0[7]); //@ demo_method_tran.py:37
    tran tr_md0_io_bus1_0__md1_io_bus1_0_(md0_io_bus1[0], md1_io_bus1[0]); //@ demo_method_tran.py:38
    tran tr_md0_io_bus1_1__md1_io_bus1_1_(md0_io_bus1[1], md1_io_bus1[1]); //@ demo_method_tran.py:38
    tran tr_md0_io_bus1_2__md1_io_bus1_2_(md0_io_bus1[2], md1_io_bus1[2]); //@ demo_method_tran.py:38
    tran tr_md0_io_bus1_3__md1_io_bus1_3_(md0_io_bus1[3], md1_io_bus1[3]); //@ demo_method_tran.py:38
    tran tr_md0_io_bus1_4__md1_io_bus1_4_(md0_io_bus1[4], md1_io_bus1[4]); //@ demo_method_tran.py:38
    tran tr_md0_io_bus1_5__md1_io_bus1_5_(md0_io_bus1[5], md1_io_bus1[5]); //@ demo_method_tran.py:38
    tran tr_md0_io_bus1_6__md1_io_bus1_6_(md0_io_bus1[6], md1_io_bus1[6]); //@ demo_method_tran.py:38
    tran tr_md0_io_bus1_7__md1_io_bus1_7_(md0_io_bus1[7], md1_io_bus1[7]); //@ demo_method_tran.py:38
endmodule
module sub_module0(
    inout wire [7:0] io_bus0, //@ demo_method_tran.py:6
    inout wire [7:0] io_bus1, //@ demo_method_tran.py:7
    input  wire  clock, //@ demo_method_tran.py:28
    input  wire  reset  //@ demo_method_tran.py:28
);
endmodule
module sub_module1(
    inout wire [7:0] io_bus0, //@ demo_method_tran.py:15
    inout wire [7:0] io_bus1, //@ demo_method_tran.py:16
    input  wire  clock, //@ demo_method_tran.py:29
    input  wire  reset  //@ demo_method_tran.py:29
);
endmodule
