module method_pullup_pulldown_top(
    input  wire  clock, //@ phgl_generator.py:85
    input  wire  reset  //@ phgl_generator.py:85
);
    wire [7:0] md0_io_bus0; //@ demo_method_pullup_pulldown.py:19
    wire [7:0] md0_io_bus1; //@ demo_method_pullup_pulldown.py:19
    wire  md0_clock; //@ demo_method_pullup_pulldown.py:19
    wire  md0_reset; //@ demo_method_pullup_pulldown.py:19
    sub_module0 md0( //@ demo_method_pullup_pulldown.py:19
        .io_bus0(md0_io_bus0),
        .io_bus1(md0_io_bus1),
        .clock(md0_clock),
        .reset(md0_reset)
    );
    assign md0_clock = clock; //@ demo_method_pullup_pulldown.py:19
    assign md0_reset = reset; //@ demo_method_pullup_pulldown.py:19
    pullup (weak1) pu_md0_io_bus0_0_ (md0_io_bus0[0]); //@ demo_method_pullup_pulldown.py:20
    pullup (weak1) pu_md0_io_bus0_1_ (md0_io_bus0[1]); //@ demo_method_pullup_pulldown.py:20
    pullup (weak1) pu_md0_io_bus0_2_ (md0_io_bus0[2]); //@ demo_method_pullup_pulldown.py:20
    pullup (weak1) pu_md0_io_bus0_3_ (md0_io_bus0[3]); //@ demo_method_pullup_pulldown.py:20
    pullup (weak1) pu_md0_io_bus0_4_ (md0_io_bus0[4]); //@ demo_method_pullup_pulldown.py:20
    pullup (weak1) pu_md0_io_bus0_5_ (md0_io_bus0[5]); //@ demo_method_pullup_pulldown.py:20
    pullup (weak1) pu_md0_io_bus0_6_ (md0_io_bus0[6]); //@ demo_method_pullup_pulldown.py:20
    pullup (weak1) pu_md0_io_bus0_7_ (md0_io_bus0[7]); //@ demo_method_pullup_pulldown.py:20
    pulldown (weak0) pd_md0_io_bus1_0_ (md0_io_bus1[0]); //@ demo_method_pullup_pulldown.py:21
    pulldown (weak0) pd_md0_io_bus1_1_ (md0_io_bus1[1]); //@ demo_method_pullup_pulldown.py:21
    pulldown (weak0) pd_md0_io_bus1_2_ (md0_io_bus1[2]); //@ demo_method_pullup_pulldown.py:21
    pulldown (weak0) pd_md0_io_bus1_3_ (md0_io_bus1[3]); //@ demo_method_pullup_pulldown.py:21
    pulldown (weak0) pd_md0_io_bus1_4_ (md0_io_bus1[4]); //@ demo_method_pullup_pulldown.py:21
    pulldown (weak0) pd_md0_io_bus1_5_ (md0_io_bus1[5]); //@ demo_method_pullup_pulldown.py:21
    pulldown (weak0) pd_md0_io_bus1_6_ (md0_io_bus1[6]); //@ demo_method_pullup_pulldown.py:21
    pulldown (weak0) pd_md0_io_bus1_7_ (md0_io_bus1[7]); //@ demo_method_pullup_pulldown.py:21
endmodule
module sub_module0(
    inout wire [7:0] io_bus0, //@ demo_method_pullup_pulldown.py:6
    inout wire [7:0] io_bus1, //@ demo_method_pullup_pulldown.py:7
    input  wire  clock, //@ demo_method_pullup_pulldown.py:19
    input  wire  reset  //@ demo_method_pullup_pulldown.py:19
);
endmodule
