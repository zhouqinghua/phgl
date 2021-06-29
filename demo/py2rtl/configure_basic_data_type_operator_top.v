module basic_data_type_operator_top(
    input  wire [7:0] io_in0, //@ demo_basic_data_type_operator.py:6
    input  wire [7:0] io_in1, //@ demo_basic_data_type_operator.py:7
    input  wire [3:0] io_op, //@ demo_basic_data_type_operator.py:8
    output wire [7:0] io_out, //@ demo_basic_data_type_operator.py:9
    input  wire  clock, //@ phgl_generator.py:85
    input  wire  reset  //@ phgl_generator.py:85
);
    wire [7:0] resaults; //@ demo_basic_data_type_operator.py:14
    wire [3:0] _T_0; //@ demo_basic_data_type_operator.py:19
    wire [7:0] _T_1; //@ demo_basic_data_type_operator.py:19
    wire [3:0] _T_2; //@ demo_basic_data_type_operator.py:19
    wire [7:0] _T_3; //@ demo_basic_data_type_operator.py:19
    wire [7:0] _T_4; //@ demo_basic_data_type_operator.py:23
    wire [7:0] _T_5; //@ demo_basic_data_type_operator.py:25
    wire [3:0] _T_6; //@ demo_basic_data_type_operator.py:27
    wire  _T_7; //@ demo_basic_data_type_operator.py:29
    wire  _T_8; //@ demo_basic_data_type_operator.py:31
    wire  _T_9; //@ demo_basic_data_type_operator.py:33
    wire [8:0] _T_10; //@ demo_basic_data_type_operator.py:37
    wire [7:0] _T_11; //@ demo_basic_data_type_operator.py:37
    wire [7:0] _T_12; //@ demo_basic_data_type_operator.py:37
    wire [8:0] _T_13; //@ demo_basic_data_type_operator.py:39
    wire [7:0] _T_14; //@ demo_basic_data_type_operator.py:39
    wire [7:0] _T_15; //@ demo_basic_data_type_operator.py:39
    wire [15:0] _T_16; //@ demo_basic_data_type_operator.py:41
    wire [7:0] _T_17; //@ demo_basic_data_type_operator.py:41
    wire [7:0] _T_18; //@ demo_basic_data_type_operator.py:41
    wire [7:0] _T_19; //@ demo_basic_data_type_operator.py:43
    wire [7:0] _T_20; //@ demo_basic_data_type_operator.py:45
    wire [7:0] _T_21; //@ demo_basic_data_type_operator.py:47
    wire [7:0] _T_22; //@ demo_basic_data_type_operator.py:49
    wire [7:0] _T_23; //@ demo_basic_data_type_operator.py:51
    wire [262:0] _T_24; //@ demo_basic_data_type_operator.py:53
    wire [7:0] _T_25; //@ demo_basic_data_type_operator.py:53
    wire [7:0] _T_26; //@ demo_basic_data_type_operator.py:53
    wire [7:0] _T_27; //@ demo_basic_data_type_operator.py:55
    wire [7:0] _T_28; //@ demo_basic_data_type_operator.py:57
    wire [7:0] _T_29; //@ demo_basic_data_type_operator.py:57
    wire [7:0] _T_30; //@ demo_basic_data_type_operator.py:59
    wire  _T_31; //@ demo_basic_data_type_operator.py:63
    wire [7:0] _T_32; //@ demo_basic_data_type_operator.py:63
    wire  _T_33; //@ demo_basic_data_type_operator.py:67
    wire  _T_34; //@ demo_basic_data_type_operator.py:69
    wire  _T_35; //@ demo_basic_data_type_operator.py:71
    wire  _T_36; //@ demo_basic_data_type_operator.py:73
    wire  _T_37; //@ demo_basic_data_type_operator.py:75
    wire  _T_38; //@ demo_basic_data_type_operator.py:77
//    assign resaults = 8'h55; //@ demo_basic_data_type_operator.py:17
//    assign _T_0 = resaults[3:0]; //@ demo_basic_data_type_operator.py:19
    assign _T_0 = 4'ha; //@ demo_basic_data_type_operator.py:19
    assign _T_1 = 8'h55;
    assign _T_2 = _T_1[7:4]; //@ demo_basic_data_type_operator.py:19
    assign _T_3 = {_T_2, _T_0}; //@ demo_basic_data_type_operator.py:19
//    assign resaults = _T_3; //@ demo_basic_data_type_operator.py:19
    assign _T_4 = ~io_in0; //@ demo_basic_data_type_operator.py:23
//    assign resaults = _T_4; //@ demo_basic_data_type_operator.py:23
    assign _T_5 = (-io_in0); //@ demo_basic_data_type_operator.py:25
//    assign resaults = _T_5; //@ demo_basic_data_type_operator.py:25
    assign _T_6 = io_in0[3:0]; //@ demo_basic_data_type_operator.py:27
//    assign resaults = _T_6; //@ demo_basic_data_type_operator.py:27
    assign _T_7 = &io_in0; //@ demo_basic_data_type_operator.py:29
//    assign resaults = _T_7; //@ demo_basic_data_type_operator.py:29
    assign _T_8 = |io_in0; //@ demo_basic_data_type_operator.py:31
//    assign resaults = _T_8; //@ demo_basic_data_type_operator.py:31
    assign _T_9 = ^io_in0; //@ demo_basic_data_type_operator.py:33
//    assign resaults = _T_9; //@ demo_basic_data_type_operator.py:33
    assign _T_10 = (io_in0 + io_in1); //@ demo_basic_data_type_operator.py:37
    assign _T_12 = _T_10[7:0]; //@ demo_basic_data_type_operator.py:37
    assign _T_11 = _T_12; //@ demo_basic_data_type_operator.py:37
//    assign resaults = _T_11; //@ demo_basic_data_type_operator.py:37
    assign _T_13 = (io_in0 - io_in1); //@ demo_basic_data_type_operator.py:39
    assign _T_15 = _T_13[7:0]; //@ demo_basic_data_type_operator.py:39
    assign _T_14 = _T_15; //@ demo_basic_data_type_operator.py:39
//    assign resaults = _T_14; //@ demo_basic_data_type_operator.py:39
    assign _T_16 = (io_in0 * io_in1); //@ demo_basic_data_type_operator.py:41
    assign _T_18 = _T_16[7:0]; //@ demo_basic_data_type_operator.py:41
    assign _T_17 = _T_18; //@ demo_basic_data_type_operator.py:41
//    assign resaults = _T_17; //@ demo_basic_data_type_operator.py:41
    assign _T_19 = (io_in0 / io_in1); //@ demo_basic_data_type_operator.py:43
//    assign resaults = _T_19; //@ demo_basic_data_type_operator.py:43
    assign _T_20 = (io_in0 % io_in1); //@ demo_basic_data_type_operator.py:45
//    assign resaults = _T_20; //@ demo_basic_data_type_operator.py:45
    assign _T_21 = (io_in0 & io_in1); //@ demo_basic_data_type_operator.py:47
//    assign resaults = _T_21; //@ demo_basic_data_type_operator.py:47
    assign _T_22 = (io_in0 | io_in1); //@ demo_basic_data_type_operator.py:49
//    assign resaults = _T_22; //@ demo_basic_data_type_operator.py:49
    assign _T_23 = (io_in0 ^ io_in1); //@ demo_basic_data_type_operator.py:51
//    assign resaults = _T_23; //@ demo_basic_data_type_operator.py:51
    assign _T_24 = (io_in0 << io_in1); //@ demo_basic_data_type_operator.py:53
    assign _T_26 = _T_24[7:0]; //@ demo_basic_data_type_operator.py:53
    assign _T_25 = _T_26; //@ demo_basic_data_type_operator.py:53
//    assign resaults = _T_25; //@ demo_basic_data_type_operator.py:53
    assign _T_27 = (io_in0 >> io_in1); //@ demo_basic_data_type_operator.py:55
//    assign resaults = _T_27; //@ demo_basic_data_type_operator.py:55
    assign _T_28 = io_in0; //@ demo_basic_data_type_operator.py:57
    assign _T_29 = ($signed($signed(_T_28)) >>> io_in1); //@ demo_basic_data_type_operator.py:57
//    assign resaults = _T_29; //@ demo_basic_data_type_operator.py:57
    assign _T_30 = (io_in0 ** io_in1); //@ demo_basic_data_type_operator.py:59
//    assign resaults = _T_30; //@ demo_basic_data_type_operator.py:59
    assign _T_31 = io_op[0]; //@ demo_basic_data_type_operator.py:63
    assign _T_32 = (_T_31 ? io_in0 : io_in1); //@ demo_basic_data_type_operator.py:63
//    assign resaults = _T_32; //@ demo_basic_data_type_operator.py:63
    assign _T_33 = (io_in0 == io_in1); //@ demo_basic_data_type_operator.py:67
//    assign resaults = _T_33; //@ demo_basic_data_type_operator.py:67
    assign _T_34 = (io_in0 != io_in1); //@ demo_basic_data_type_operator.py:69
//    assign resaults = _T_34; //@ demo_basic_data_type_operator.py:69
    assign _T_35 = (io_in0 > io_in1); //@ demo_basic_data_type_operator.py:71
//    assign resaults = _T_35; //@ demo_basic_data_type_operator.py:71
    assign _T_36 = (io_in0 < io_in1); //@ demo_basic_data_type_operator.py:73
//    assign resaults = _T_36; //@ demo_basic_data_type_operator.py:73
    assign _T_37 = (io_in0 >= io_in1); //@ demo_basic_data_type_operator.py:75
//    assign resaults = _T_37; //@ demo_basic_data_type_operator.py:75
    assign _T_38 = (io_in0 <= io_in1); //@ demo_basic_data_type_operator.py:77
    assign resaults = _T_38; //@ demo_basic_data_type_operator.py:77
endmodule
