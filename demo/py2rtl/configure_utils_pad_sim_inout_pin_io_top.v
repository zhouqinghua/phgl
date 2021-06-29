module utils_pad_sim_inout_pin_io_top(
    input  wire  io_i2c_scl_input, //@ pad_sim_model.py:11
    output wire  io_i2c_scl_output, //@ pad_sim_model.py:12
    output wire  io_i2c_scl_oe, //@ pad_sim_model.py:13
    input  wire  io_i2c_sda_input, //@ pad_sim_model.py:11
    output wire  io_i2c_sda_output, //@ pad_sim_model.py:12
    output wire  io_i2c_sda_oe, //@ pad_sim_model.py:13
    input  wire  clock, //@ phgl_generator.py:85
    input  wire  reset  //@ phgl_generator.py:85
);
    wire [3:0] cnt_i; //@ demo_utils_pad_sim_inout_pin_io.py:17
    reg  [3:0] cnt_o; //@ demo_utils_pad_sim_inout_pin_io.py:17
    wire [4:0] _T_0; //@ demo_utils_pad_sim_inout_pin_io.py:18
    wire [3:0] _T_1; //@ demo_utils_pad_sim_inout_pin_io.py:18
    wire [3:0] _T_2; //@ demo_utils_pad_sim_inout_pin_io.py:18
    wire  sda_in_data_i; //@ demo_utils_pad_sim_inout_pin_io.py:19
    reg   sda_in_data_o; //@ demo_utils_pad_sim_inout_pin_io.py:19
    wire  _T_3; //@ demo_utils_pad_sim_inout_pin_io.py:22
    wire  _T_4; //@ demo_utils_pad_sim_inout_pin_io.py:23
    wire  _T_5; //@ demo_utils_pad_sim_inout_pin_io.py:23
    wire  _T_6; //@ demo_utils_pad_sim_inout_pin_io.py:24
    wire  _T_7; //@ demo_utils_pad_sim_inout_pin_io.py:24
    wire  _T_8; //@ demo_utils_pad_sim_inout_pin_io.py:25
    wire  _T_9; //@ demo_utils_pad_sim_inout_pin_io.py:25
    wire  _T_10; //@ demo_utils_pad_sim_inout_pin_io.py:25
    wire  _T_11; //@ demo_utils_pad_sim_inout_pin_io.py:26
    wire  _T_12; //@ demo_utils_pad_sim_inout_pin_io.py:27
    wire  _T_13; //@ demo_utils_pad_sim_inout_pin_io.py:27
    wire  _T_14; //@ demo_utils_pad_sim_inout_pin_io.py:28
    wire  _T_15; //@ demo_utils_pad_sim_inout_pin_io.py:28
    wire  _T_16; //@ demo_utils_pad_sim_inout_pin_io.py:29
    wire  _T_17; //@ demo_utils_pad_sim_inout_pin_io.py:29
    always @(posedge clock) //@ demo_utils_pad_sim_inout_pin_io.py:17
        if (reset)
            cnt_o <= 4'h0;
        else
            cnt_o <= cnt_i;
    always @(posedge clock) //@ demo_utils_pad_sim_inout_pin_io.py:19
        sda_in_data_o <= sda_in_data_i;
    assign _T_0 = (cnt_o + 4'h1); //@ demo_utils_pad_sim_inout_pin_io.py:18
    assign _T_2 = _T_0[3:0]; //@ demo_utils_pad_sim_inout_pin_io.py:18
    assign _T_1 = _T_2; //@ demo_utils_pad_sim_inout_pin_io.py:18
    assign cnt_i = _T_1; //@ demo_utils_pad_sim_inout_pin_io.py:18
//    assign io_i2c_scl_oe = 1'h1; //@ demo_utils_pad_sim_inout_pin_io.py:20
//    assign io_i2c_sda_oe = 1'h1; //@ demo_utils_pad_sim_inout_pin_io.py:21
    assign _T_3 = (cnt_o < 4'h8); //@ demo_utils_pad_sim_inout_pin_io.py:22
    assign _T_5 = (_T_3 ? 1'h1 : 1'h1); //@ demo_utils_pad_sim_inout_pin_io.py:23
    assign _T_4 = _T_5; //@ demo_utils_pad_sim_inout_pin_io.py:23
//    assign io_i2c_scl_oe = _T_4; //@ demo_utils_pad_sim_inout_pin_io.py:23
    assign _T_7 = (_T_3 ? 1'h1 : 1'h1); //@ demo_utils_pad_sim_inout_pin_io.py:24
    assign _T_6 = _T_7; //@ demo_utils_pad_sim_inout_pin_io.py:24
//    assign io_i2c_sda_oe = _T_6; //@ demo_utils_pad_sim_inout_pin_io.py:24
    assign _T_8 = cnt_o[0]; //@ demo_utils_pad_sim_inout_pin_io.py:25
    assign _T_10 = (_T_3 ? _T_8 : _T_8); //@ demo_utils_pad_sim_inout_pin_io.py:25
    assign _T_9 = _T_10; //@ demo_utils_pad_sim_inout_pin_io.py:25
    assign io_i2c_sda_output = _T_9; //@ demo_utils_pad_sim_inout_pin_io.py:25
    assign _T_11 = (_T_3 == 1'h0); //@ demo_utils_pad_sim_inout_pin_io.py:26
    assign _T_13 = (_T_11 ? 1'h1 : _T_4); //@ demo_utils_pad_sim_inout_pin_io.py:27
    assign _T_12 = _T_13; //@ demo_utils_pad_sim_inout_pin_io.py:27
    assign io_i2c_scl_oe = _T_12; //@ demo_utils_pad_sim_inout_pin_io.py:27
    assign _T_15 = (_T_11 ? 1'h0 : _T_6); //@ demo_utils_pad_sim_inout_pin_io.py:28
    assign _T_14 = _T_15; //@ demo_utils_pad_sim_inout_pin_io.py:28
    assign io_i2c_sda_oe = _T_14; //@ demo_utils_pad_sim_inout_pin_io.py:28
    assign _T_17 = (_T_11 ? io_i2c_sda_input : sda_in_data_o); //@ demo_utils_pad_sim_inout_pin_io.py:29
    assign _T_16 = _T_17; //@ demo_utils_pad_sim_inout_pin_io.py:29
    assign sda_in_data_i = _T_16; //@ demo_utils_pad_sim_inout_pin_io.py:29
endmodule
