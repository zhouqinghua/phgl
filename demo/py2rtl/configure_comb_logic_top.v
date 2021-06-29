module comb_logic_top(
    input  wire [7:0] io_in0, //@ demo_comb_logic.py:6
    input  wire [7:0] io_in1, //@ demo_comb_logic.py:7
    input  wire [3:0] io_op, //@ demo_comb_logic.py:8
    output wire [7:0] io_out_and, //@ demo_comb_logic.py:9
    output wire [7:0] io_out_or, //@ demo_comb_logic.py:10
    output wire [7:0] io_out_add, //@ demo_comb_logic.py:11
    output wire [7:0] io_out_shift, //@ demo_comb_logic.py:12
    output wire [7:0] io_out_mul_div, //@ demo_comb_logic.py:13
    output wire [7:0] io_out_mux, //@ demo_comb_logic.py:14
    output wire [7:0] io_out_complex, //@ demo_comb_logic.py:15
    input  wire  clock, //@ phgl_generator.py:85
    input  wire  reset  //@ phgl_generator.py:85
);
    wire [7:0] _T_0; //@ demo_comb_logic.py:21
    wire [7:0] _T_1; //@ demo_comb_logic.py:24
    wire [8:0] _T_2; //@ demo_comb_logic.py:27
    wire [7:0] _T_3; //@ demo_comb_logic.py:27
    wire [7:0] _T_4; //@ demo_comb_logic.py:27
    wire [3:0] _T_5; //@ demo_comb_logic.py:30
    wire [1:0] _T_6; //@ demo_comb_logic.py:30
    wire [6:0] _T_7; //@ demo_comb_logic.py:30
    wire [7:0] _T_8; //@ demo_comb_logic.py:30
    wire [3:0] _T_9; //@ demo_comb_logic.py:30
    wire [3:0] _T_10; //@ demo_comb_logic.py:30
    wire [3:0] _T_11; //@ demo_comb_logic.py:30
    wire [6:0] _T_12; //@ demo_comb_logic.py:30
    wire [15:0] _T_13; //@ demo_comb_logic.py:33
    wire [3:0] _T_14; //@ demo_comb_logic.py:33
    wire [7:0] _T_15; //@ demo_comb_logic.py:33
    wire [16:0] _T_16; //@ demo_comb_logic.py:33
    wire [7:0] _T_17; //@ demo_comb_logic.py:33
    wire [7:0] _T_18; //@ demo_comb_logic.py:33
    wire  _T_19; //@ demo_comb_logic.py:36
    wire [7:0] _T_20; //@ demo_comb_logic.py:36
    wire [7:0] _T_21; //@ demo_comb_logic.py:39
    wire [8:0] _T_22; //@ demo_comb_logic.py:40
    wire [3:0] _T_23; //@ demo_comb_logic.py:41
    wire [7:0] _T_24; //@ demo_comb_logic.py:41
    wire [15:0] _T_25; //@ demo_comb_logic.py:42
    wire  _T_26; //@ demo_comb_logic.py:44
    wire  _T_27; //@ demo_comb_logic.py:47
    wire  _T_28; //@ demo_comb_logic.py:50
    wire [15:0] _T_29; //@ demo_comb_logic.py:52
    wire [15:0] _T_30; //@ demo_comb_logic.py:52
    wire [15:0] _T_31; //@ demo_comb_logic.py:52
    wire [7:0] _T_32; //@ demo_comb_logic.py:52
    wire [7:0] _T_33; //@ demo_comb_logic.py:52
    assign _T_0 = (io_in0 & io_in1); //@ demo_comb_logic.py:21
    assign io_out_and = _T_0; //@ demo_comb_logic.py:21
    assign _T_1 = (io_in0 | io_in1); //@ demo_comb_logic.py:24
    assign io_out_or = _T_1; //@ demo_comb_logic.py:24
    assign _T_2 = (io_in0 + io_in1); //@ demo_comb_logic.py:27
    assign _T_4 = _T_2[7:0]; //@ demo_comb_logic.py:27
    assign _T_3 = _T_4; //@ demo_comb_logic.py:27
    assign io_out_add = _T_3; //@ demo_comb_logic.py:27
    assign _T_5 = io_in0[3:0]; //@ demo_comb_logic.py:30
    assign _T_6 = io_in1[1:0]; //@ demo_comb_logic.py:30
    assign _T_7 = (_T_5 << _T_6); //@ demo_comb_logic.py:30
    assign _T_8 = (io_in1 >> 3'h4); //@ demo_comb_logic.py:30
    assign _T_11 = _T_8[3:0]; //@ demo_comb_logic.py:30
    assign _T_10 = _T_11; //@ demo_comb_logic.py:30
    assign _T_9 = _T_10; //@ demo_comb_logic.py:30
    assign _T_12 = (_T_7 | _T_9); //@ demo_comb_logic.py:30
    assign io_out_shift = _T_12; //@ demo_comb_logic.py:30
    assign _T_13 = (io_in0 * io_in1); //@ demo_comb_logic.py:33
    assign _T_14 = io_in1[3:0]; //@ demo_comb_logic.py:33
    assign _T_15 = (io_in0 / _T_14); //@ demo_comb_logic.py:33
    assign _T_16 = (_T_13 + _T_15); //@ demo_comb_logic.py:33
    assign _T_18 = _T_16[7:0]; //@ demo_comb_logic.py:33
    assign _T_17 = _T_18; //@ demo_comb_logic.py:33
    assign io_out_mul_div = _T_17; //@ demo_comb_logic.py:33
    assign _T_19 = io_op[0]; //@ demo_comb_logic.py:36
    assign _T_20 = (_T_19 ? io_in0 : io_in1); //@ demo_comb_logic.py:36
    assign io_out_mux = _T_20; //@ demo_comb_logic.py:36
    assign _T_21 = (io_in0 & io_in1); //@ demo_comb_logic.py:39
    assign _T_22 = (io_in0 + io_in1); //@ demo_comb_logic.py:40
    assign _T_23 = io_in0[3:0]; //@ demo_comb_logic.py:41
    assign _T_24 = (_T_23 << 3'h4); //@ demo_comb_logic.py:41
    assign _T_25 = (io_in0 * io_in1); //@ demo_comb_logic.py:42
    assign _T_26 = (io_op == 4'h0); //@ demo_comb_logic.py:44
    assign _T_27 = (io_op == 4'h1); //@ demo_comb_logic.py:47
    assign _T_28 = (io_op == 4'h2); //@ demo_comb_logic.py:50
    assign _T_29 = (_T_28 ? _T_24 : _T_25); //@ demo_comb_logic.py:52
    assign _T_30 = (_T_27 ? _T_22 : _T_29); //@ demo_comb_logic.py:52
    assign _T_31 = (_T_26 ? _T_21 : _T_30); //@ demo_comb_logic.py:52
    assign _T_33 = _T_31[7:0]; //@ demo_comb_logic.py:52
    assign _T_32 = _T_33; //@ demo_comb_logic.py:52
    assign io_out_complex = _T_32; //@ demo_comb_logic.py:52
endmodule
