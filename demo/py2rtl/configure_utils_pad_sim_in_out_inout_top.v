module utils_pad_sim_in_out_inout_top(
    inout wire  io_i2c_scl, //@ demo_utils_pad_sim_in_out_inout.py:12
    inout wire  io_i2c_sda, //@ demo_utils_pad_sim_in_out_inout.py:13
    output wire  io_uart_tx, //@ demo_utils_pad_sim_in_out_inout.py:24
    input  wire  io_uart_rx, //@ demo_utils_pad_sim_in_out_inout.py:25
    input  wire  clock, //@ phgl_generator.py:85
    input  wire  reset  //@ phgl_generator.py:85
);
    wire  core_io_i2c_scl_input; //@ demo_utils_pad_sim_in_out_inout.py:45
    wire  core_io_i2c_scl_output; //@ demo_utils_pad_sim_in_out_inout.py:45
    wire  core_io_i2c_scl_oe; //@ demo_utils_pad_sim_in_out_inout.py:45
    wire  core_io_i2c_sda_input; //@ demo_utils_pad_sim_in_out_inout.py:45
    wire  core_io_i2c_sda_output; //@ demo_utils_pad_sim_in_out_inout.py:45
    wire  core_io_i2c_sda_oe; //@ demo_utils_pad_sim_in_out_inout.py:45
    wire  core_io_uart_tx; //@ demo_utils_pad_sim_in_out_inout.py:45
    wire  core_io_uart_rx; //@ demo_utils_pad_sim_in_out_inout.py:45
    wire  core_clock; //@ demo_utils_pad_sim_in_out_inout.py:45
    wire  core_reset; //@ demo_utils_pad_sim_in_out_inout.py:45
    wire  io_uart_tx_pad_io_d; //@ pad_sim_model.py:184
    wire  io_uart_tx_pad_io_pad; //@ pad_sim_model.py:184
    wire  io_uart_tx_pad_clock; //@ pad_sim_model.py:184
    wire  io_uart_tx_pad_reset; //@ pad_sim_model.py:184
    wire  io_uart_rx_pad_io_d; //@ pad_sim_model.py:178
    wire  io_uart_rx_pad_io_pad; //@ pad_sim_model.py:178
    wire  io_uart_rx_pad_clock; //@ pad_sim_model.py:178
    wire  io_uart_rx_pad_reset; //@ pad_sim_model.py:178
    wire  io_i2c_scl_pad_io_od; //@ pad_sim_model.py:163
    wire  io_i2c_scl_pad_io_oe; //@ pad_sim_model.py:163
    wire  io_i2c_scl_pad_io_id; //@ pad_sim_model.py:163
    wire  io_i2c_scl_pad_io_padi; //@ pad_sim_model.py:163
    wire  io_i2c_scl_pad_io_pado; //@ pad_sim_model.py:163
    wire  io_i2c_scl_pad_clock; //@ pad_sim_model.py:163
    wire  io_i2c_scl_pad_reset; //@ pad_sim_model.py:163
    wire  io_i2c_sda_pad_io_od; //@ pad_sim_model.py:163
    wire  io_i2c_sda_pad_io_oe; //@ pad_sim_model.py:163
    wire  io_i2c_sda_pad_io_id; //@ pad_sim_model.py:163
    wire  io_i2c_sda_pad_io_padi; //@ pad_sim_model.py:163
    wire  io_i2c_sda_pad_io_pado; //@ pad_sim_model.py:163
    wire  io_i2c_sda_pad_clock; //@ pad_sim_model.py:163
    wire  io_i2c_sda_pad_reset; //@ pad_sim_model.py:163
    utils_pad_sim_core_module core( //@ demo_utils_pad_sim_in_out_inout.py:45
        .io_i2c_scl_input(core_io_i2c_scl_input),
        .io_i2c_scl_output(core_io_i2c_scl_output),
        .io_i2c_scl_oe(core_io_i2c_scl_oe),
        .io_i2c_sda_input(core_io_i2c_sda_input),
        .io_i2c_sda_output(core_io_i2c_sda_output),
        .io_i2c_sda_oe(core_io_i2c_sda_oe),
        .io_uart_tx(core_io_uart_tx),
        .io_uart_rx(core_io_uart_rx),
        .clock(core_clock),
        .reset(core_reset)
    );
    assign core_clock = clock; //@ demo_utils_pad_sim_in_out_inout.py:45
    assign core_reset = reset; //@ demo_utils_pad_sim_in_out_inout.py:45
    pad_sim_out io_uart_tx_pad( //@ pad_sim_model.py:184
        .io_d(io_uart_tx_pad_io_d),
        .io_pad(io_uart_tx_pad_io_pad),
        .clock(io_uart_tx_pad_clock),
        .reset(io_uart_tx_pad_reset)
    );
    assign io_uart_tx_pad_clock = clock; //@ pad_sim_model.py:184
    assign io_uart_tx_pad_reset = reset; //@ pad_sim_model.py:184
    assign io_uart_tx_pad_io_d = core_io_uart_tx; //@ pad_sim_model.py:185
    assign io_uart_tx = io_uart_tx_pad_io_pad; //@ pad_sim_model.py:186
    pad_sim_in io_uart_rx_pad( //@ pad_sim_model.py:178
        .io_d(io_uart_rx_pad_io_d),
        .io_pad(io_uart_rx_pad_io_pad),
        .clock(io_uart_rx_pad_clock),
        .reset(io_uart_rx_pad_reset)
    );
    assign io_uart_rx_pad_clock = clock; //@ pad_sim_model.py:178
    assign io_uart_rx_pad_reset = reset; //@ pad_sim_model.py:178
    assign io_uart_rx_pad_io_pad = io_uart_rx; //@ pad_sim_model.py:179
    assign core_io_uart_rx = io_uart_rx_pad_io_d; //@ pad_sim_model.py:180
    pad_sim_inout io_i2c_scl_pad( //@ pad_sim_model.py:163
        .io_od(io_i2c_scl_pad_io_od),
        .io_oe(io_i2c_scl_pad_io_oe),
        .io_id(io_i2c_scl_pad_io_id),
        .io_padi(io_i2c_scl_pad_io_padi),
        .io_pado(io_i2c_scl_pad_io_pado),
        .clock(io_i2c_scl_pad_clock),
        .reset(io_i2c_scl_pad_reset)
    );
    assign io_i2c_scl_pad_clock = clock; //@ pad_sim_model.py:163
    assign io_i2c_scl_pad_reset = reset; //@ pad_sim_model.py:163
    assign io_i2c_scl_pad_io_od = core_io_i2c_scl_output; //@ pad_sim_model.py:168
    assign io_i2c_scl_pad_io_oe = core_io_i2c_scl_oe; //@ pad_sim_model.py:169
    assign io_i2c_scl_pad_io_padi = io_i2c_scl; //@ pad_sim_model.py:172
    assign core_io_i2c_scl_input = io_i2c_scl_pad_io_id; //@ pad_sim_model.py:173
    assign io_i2c_scl = io_i2c_scl_pad_io_pado; //@ pad_sim_model.py:174
    pad_sim_inout_1 io_i2c_sda_pad( //@ pad_sim_model.py:163
        .io_od(io_i2c_sda_pad_io_od),
        .io_oe(io_i2c_sda_pad_io_oe),
        .io_id(io_i2c_sda_pad_io_id),
        .io_padi(io_i2c_sda_pad_io_padi),
        .io_pado(io_i2c_sda_pad_io_pado),
        .clock(io_i2c_sda_pad_clock),
        .reset(io_i2c_sda_pad_reset)
    );
    assign io_i2c_sda_pad_clock = clock; //@ pad_sim_model.py:163
    assign io_i2c_sda_pad_reset = reset; //@ pad_sim_model.py:163
    assign io_i2c_sda_pad_io_od = core_io_i2c_sda_output; //@ pad_sim_model.py:168
    assign io_i2c_sda_pad_io_oe = core_io_i2c_sda_oe; //@ pad_sim_model.py:169
    assign io_i2c_sda_pad_io_padi = io_i2c_sda; //@ pad_sim_model.py:172
    assign core_io_i2c_sda_input = io_i2c_sda_pad_io_id; //@ pad_sim_model.py:173
    assign io_i2c_sda = io_i2c_sda_pad_io_pado; //@ pad_sim_model.py:174
endmodule
module utils_pad_sim_core_module(
    input  wire  io_i2c_scl_input, //@ pad_sim_model.py:11
    output wire  io_i2c_scl_output, //@ pad_sim_model.py:12
    output wire  io_i2c_scl_oe, //@ pad_sim_model.py:13
    input  wire  io_i2c_sda_input, //@ pad_sim_model.py:11
    output wire  io_i2c_sda_output, //@ pad_sim_model.py:12
    output wire  io_i2c_sda_oe, //@ pad_sim_model.py:13
    output wire  io_uart_tx, //@ demo_utils_pad_sim_in_out_inout.py:18
    input  wire  io_uart_rx, //@ demo_utils_pad_sim_in_out_inout.py:19
    input  wire  clock, //@ demo_utils_pad_sim_in_out_inout.py:45
    input  wire  reset  //@ demo_utils_pad_sim_in_out_inout.py:45
);
endmodule
module pad_sim_out(
    input  wire  io_d, //@ pad_sim_model.py:41
    output wire  io_pad, //@ pad_sim_model.py:42
    input  wire  clock, //@ pad_sim_model.py:184
    input  wire  reset  //@ pad_sim_model.py:184
);
    assign io_pad = io_d; //@ pad_sim_model.py:46
endmodule
module pad_sim_in(
    output wire  io_d, //@ pad_sim_model.py:27
    input  wire  io_pad, //@ pad_sim_model.py:28
    input  wire  clock, //@ pad_sim_model.py:178
    input  wire  reset  //@ pad_sim_model.py:178
);
    assign io_d = io_pad; //@ pad_sim_model.py:32
endmodule
module pad_sim_inout(
    input  wire  io_od, //@ pad_sim_model.py:55
    input  wire  io_oe, //@ pad_sim_model.py:56
    output wire  io_id, //@ pad_sim_model.py:57
    input  wire  io_padi, //@ pad_sim_model.py:58
    output wire  io_pado, //@ pad_sim_model.py:59
    input  wire  clock, //@ pad_sim_model.py:163
    input  wire  reset  //@ pad_sim_model.py:163
);
    wire  _T_0; //@ pad_sim_model.py:65
    wire  _T_1; //@ pad_sim_model.py:65
//    assign io_pado = 1'hz; //@ pad_sim_model.py:63
    assign _T_1 = (io_oe ? io_od : 1'hz); //@ pad_sim_model.py:65
    assign _T_0 = _T_1; //@ pad_sim_model.py:65
    assign io_pado = _T_0; //@ pad_sim_model.py:65
    assign io_id = io_padi; //@ pad_sim_model.py:66
endmodule
module pad_sim_inout_1(
    input  wire  io_od, //@ pad_sim_model.py:55
    input  wire  io_oe, //@ pad_sim_model.py:56
    output wire  io_id, //@ pad_sim_model.py:57
    input  wire  io_padi, //@ pad_sim_model.py:58
    output wire  io_pado, //@ pad_sim_model.py:59
    input  wire  clock, //@ pad_sim_model.py:163
    input  wire  reset  //@ pad_sim_model.py:163
);
    wire  _T_0; //@ pad_sim_model.py:65
    wire  _T_1; //@ pad_sim_model.py:65
//    assign io_pado = 1'hz; //@ pad_sim_model.py:63
    assign _T_1 = (io_oe ? io_od : 1'hz); //@ pad_sim_model.py:65
    assign _T_0 = _T_1; //@ pad_sim_model.py:65
    assign io_pado = _T_0; //@ pad_sim_model.py:65
    assign io_id = io_padi; //@ pad_sim_model.py:66
endmodule
