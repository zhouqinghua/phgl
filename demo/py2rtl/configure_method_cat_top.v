module method_cat_top(
    input  wire  clock, //@ phgl_generator.py:85
    input  wire  reset  //@ phgl_generator.py:85
);
    wire [3:0] a; //@ demo_method_cat.py:10
    wire [3:0] b; //@ demo_method_cat.py:11
    wire [7:0] c0; //@ demo_method_cat.py:12
    wire [7:0] c1; //@ demo_method_cat.py:13
    wire [7:0] c2; //@ demo_method_cat.py:14
    wire [7:0] c3; //@ demo_method_cat.py:15
    wire [7:0] c4; //@ demo_method_cat.py:16
    wire [7:0] c5; //@ demo_method_cat.py:17
    wire  array0_0; //@ demo_method_cat.py:18
    wire  array0_1; //@ demo_method_cat.py:18
    wire  array0_2; //@ demo_method_cat.py:18
    wire  array0_3; //@ demo_method_cat.py:18
    wire  array0_4; //@ demo_method_cat.py:18
    wire  array0_5; //@ demo_method_cat.py:18
    wire  array0_6; //@ demo_method_cat.py:18
    wire  array0_7; //@ demo_method_cat.py:18
    wire  array1_0; //@ demo_method_cat.py:19
    wire  array1_1; //@ demo_method_cat.py:19
    wire  array1_2; //@ demo_method_cat.py:19
    wire  array1_3; //@ demo_method_cat.py:19
    wire  array1_4; //@ demo_method_cat.py:19
    wire  array1_5; //@ demo_method_cat.py:19
    wire  array1_6; //@ demo_method_cat.py:19
    wire  array1_7; //@ demo_method_cat.py:19
    wire [7:0] _T_0; //@ demo_method_cat.py:22
    wire [1:0] _T_1; //@ demo_method_cat.py:23
    wire [2:0] _T_2; //@ demo_method_cat.py:23
    wire [3:0] _T_3; //@ demo_method_cat.py:23
    wire [4:0] _T_4; //@ demo_method_cat.py:23
    wire [5:0] _T_5; //@ demo_method_cat.py:23
    wire [6:0] _T_6; //@ demo_method_cat.py:23
    wire [7:0] _T_7; //@ demo_method_cat.py:23
    wire [1:0] _T_8; //@ demo_method_cat.py:24
    wire [2:0] _T_9; //@ demo_method_cat.py:24
    wire [3:0] _T_10; //@ demo_method_cat.py:24
    wire [4:0] _T_11; //@ demo_method_cat.py:24
    wire [5:0] _T_12; //@ demo_method_cat.py:24
    wire [6:0] _T_13; //@ demo_method_cat.py:24
    wire [7:0] _T_14; //@ demo_method_cat.py:24
    wire [7:0] _T_15; //@ demo_method_cat.py:27
    wire [1:0] _T_16; //@ demo_method_cat.py:28
    wire [2:0] _T_17; //@ demo_method_cat.py:28
    wire [3:0] _T_18; //@ demo_method_cat.py:28
    wire [4:0] _T_19; //@ demo_method_cat.py:28
    wire [5:0] _T_20; //@ demo_method_cat.py:28
    wire [6:0] _T_21; //@ demo_method_cat.py:28
    wire [7:0] _T_22; //@ demo_method_cat.py:28
    wire [1:0] _T_23; //@ demo_method_cat.py:29
    wire [2:0] _T_24; //@ demo_method_cat.py:29
    wire [3:0] _T_25; //@ demo_method_cat.py:29
    wire [4:0] _T_26; //@ demo_method_cat.py:29
    wire [5:0] _T_27; //@ demo_method_cat.py:29
    wire [6:0] _T_28; //@ demo_method_cat.py:29
    wire [7:0] _T_29; //@ demo_method_cat.py:29
    assign _T_0 = {a, b}; //@ demo_method_cat.py:22
    assign c0 = _T_0; //@ demo_method_cat.py:22
    assign _T_1 = {array0_0, array0_1}; //@ demo_method_cat.py:23
    assign _T_2 = {_T_1, array0_2}; //@ demo_method_cat.py:23
    assign _T_3 = {_T_2, array0_3}; //@ demo_method_cat.py:23
    assign _T_4 = {_T_3, array0_4}; //@ demo_method_cat.py:23
    assign _T_5 = {_T_4, array0_5}; //@ demo_method_cat.py:23
    assign _T_6 = {_T_5, array0_6}; //@ demo_method_cat.py:23
    assign _T_7 = {_T_6, array0_7}; //@ demo_method_cat.py:23
    assign c1 = _T_7; //@ demo_method_cat.py:23
    assign _T_8 = {array1_0, array1_1}; //@ demo_method_cat.py:24
    assign _T_9 = {_T_8, array1_2}; //@ demo_method_cat.py:24
    assign _T_10 = {_T_9, array1_3}; //@ demo_method_cat.py:24
    assign _T_11 = {_T_10, array1_4}; //@ demo_method_cat.py:24
    assign _T_12 = {_T_11, array1_5}; //@ demo_method_cat.py:24
    assign _T_13 = {_T_12, array1_6}; //@ demo_method_cat.py:24
    assign _T_14 = {_T_13, array1_7}; //@ demo_method_cat.py:24
    assign c2 = _T_14; //@ demo_method_cat.py:24
    assign _T_15 = {b, a}; //@ demo_method_cat.py:27
    assign c3 = _T_15; //@ demo_method_cat.py:27
    assign _T_16 = {array0_7, array0_6}; //@ demo_method_cat.py:28
    assign _T_17 = {_T_16, array0_5}; //@ demo_method_cat.py:28
    assign _T_18 = {_T_17, array0_4}; //@ demo_method_cat.py:28
    assign _T_19 = {_T_18, array0_3}; //@ demo_method_cat.py:28
    assign _T_20 = {_T_19, array0_2}; //@ demo_method_cat.py:28
    assign _T_21 = {_T_20, array0_1}; //@ demo_method_cat.py:28
    assign _T_22 = {_T_21, array0_0}; //@ demo_method_cat.py:28
    assign c4 = _T_22; //@ demo_method_cat.py:28
    assign _T_23 = {array1_7, array1_6}; //@ demo_method_cat.py:29
    assign _T_24 = {_T_23, array1_5}; //@ demo_method_cat.py:29
    assign _T_25 = {_T_24, array1_4}; //@ demo_method_cat.py:29
    assign _T_26 = {_T_25, array1_3}; //@ demo_method_cat.py:29
    assign _T_27 = {_T_26, array1_2}; //@ demo_method_cat.py:29
    assign _T_28 = {_T_27, array1_1}; //@ demo_method_cat.py:29
    assign _T_29 = {_T_28, array1_0}; //@ demo_method_cat.py:29
    assign c5 = _T_29; //@ demo_method_cat.py:29
endmodule
