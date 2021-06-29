module utils_arbiter_top(
    input  wire  clock, //@ phgl_generator.py:85
    input  wire  reset  //@ phgl_generator.py:85
);
    wire  reqs0_valid_0_i; //@ demo_utils_arbiter.py:17
    reg   reqs0_valid_0_o; //@ demo_utils_arbiter.py:17
    wire  reqs0_valid_1_i; //@ demo_utils_arbiter.py:17
    reg   reqs0_valid_1_o; //@ demo_utils_arbiter.py:17
    wire  reqs0_valid_2_i; //@ demo_utils_arbiter.py:17
    reg   reqs0_valid_2_o; //@ demo_utils_arbiter.py:17
    wire  reqs0_valid_3_i; //@ demo_utils_arbiter.py:17
    reg   reqs0_valid_3_o; //@ demo_utils_arbiter.py:17
    wire [3:0] reqs0_data_0_op_i; //@ demo_utils_arbiter.py:18
    reg  [3:0] reqs0_data_0_op_o; //@ demo_utils_arbiter.py:18
    wire [3:0] reqs0_data_0_address_i; //@ demo_utils_arbiter.py:18
    reg  [3:0] reqs0_data_0_address_o; //@ demo_utils_arbiter.py:18
    wire [31:0] reqs0_data_0_data_i; //@ demo_utils_arbiter.py:18
    reg  [31:0] reqs0_data_0_data_o; //@ demo_utils_arbiter.py:18
    wire [3:0] reqs0_data_1_op_i; //@ demo_utils_arbiter.py:18
    reg  [3:0] reqs0_data_1_op_o; //@ demo_utils_arbiter.py:18
    wire [3:0] reqs0_data_1_address_i; //@ demo_utils_arbiter.py:18
    reg  [3:0] reqs0_data_1_address_o; //@ demo_utils_arbiter.py:18
    wire [31:0] reqs0_data_1_data_i; //@ demo_utils_arbiter.py:18
    reg  [31:0] reqs0_data_1_data_o; //@ demo_utils_arbiter.py:18
    wire [3:0] reqs0_data_2_op_i; //@ demo_utils_arbiter.py:18
    reg  [3:0] reqs0_data_2_op_o; //@ demo_utils_arbiter.py:18
    wire [3:0] reqs0_data_2_address_i; //@ demo_utils_arbiter.py:18
    reg  [3:0] reqs0_data_2_address_o; //@ demo_utils_arbiter.py:18
    wire [31:0] reqs0_data_2_data_i; //@ demo_utils_arbiter.py:18
    reg  [31:0] reqs0_data_2_data_o; //@ demo_utils_arbiter.py:18
    wire [3:0] reqs0_data_3_op_i; //@ demo_utils_arbiter.py:18
    reg  [3:0] reqs0_data_3_op_o; //@ demo_utils_arbiter.py:18
    wire [3:0] reqs0_data_3_address_i; //@ demo_utils_arbiter.py:18
    reg  [3:0] reqs0_data_3_address_o; //@ demo_utils_arbiter.py:18
    wire [31:0] reqs0_data_3_data_i; //@ demo_utils_arbiter.py:18
    reg  [31:0] reqs0_data_3_data_o; //@ demo_utils_arbiter.py:18
    wire  arb0_out_valid_i; //@ demo_utils_arbiter.py:19
    reg   arb0_out_valid_o; //@ demo_utils_arbiter.py:19
    wire [3:0] arb0_out_data_op_i; //@ demo_utils_arbiter.py:20
    reg  [3:0] arb0_out_data_op_o; //@ demo_utils_arbiter.py:20
    wire [3:0] arb0_out_data_address_i; //@ demo_utils_arbiter.py:20
    reg  [3:0] arb0_out_data_address_o; //@ demo_utils_arbiter.py:20
    wire [31:0] arb0_out_data_data_i; //@ demo_utils_arbiter.py:20
    reg  [31:0] arb0_out_data_data_o; //@ demo_utils_arbiter.py:20
    wire  arbiter0_io_input_0_ready; //@ demo_utils_arbiter.py:23
    wire  arbiter0_io_input_0_valid; //@ demo_utils_arbiter.py:23
    wire [3:0] arbiter0_io_input_0_bits_op; //@ demo_utils_arbiter.py:23
    wire [3:0] arbiter0_io_input_0_bits_address; //@ demo_utils_arbiter.py:23
    wire [31:0] arbiter0_io_input_0_bits_data; //@ demo_utils_arbiter.py:23
    wire  arbiter0_io_input_1_ready; //@ demo_utils_arbiter.py:23
    wire  arbiter0_io_input_1_valid; //@ demo_utils_arbiter.py:23
    wire [3:0] arbiter0_io_input_1_bits_op; //@ demo_utils_arbiter.py:23
    wire [3:0] arbiter0_io_input_1_bits_address; //@ demo_utils_arbiter.py:23
    wire [31:0] arbiter0_io_input_1_bits_data; //@ demo_utils_arbiter.py:23
    wire  arbiter0_io_input_2_ready; //@ demo_utils_arbiter.py:23
    wire  arbiter0_io_input_2_valid; //@ demo_utils_arbiter.py:23
    wire [3:0] arbiter0_io_input_2_bits_op; //@ demo_utils_arbiter.py:23
    wire [3:0] arbiter0_io_input_2_bits_address; //@ demo_utils_arbiter.py:23
    wire [31:0] arbiter0_io_input_2_bits_data; //@ demo_utils_arbiter.py:23
    wire  arbiter0_io_input_3_ready; //@ demo_utils_arbiter.py:23
    wire  arbiter0_io_input_3_valid; //@ demo_utils_arbiter.py:23
    wire [3:0] arbiter0_io_input_3_bits_op; //@ demo_utils_arbiter.py:23
    wire [3:0] arbiter0_io_input_3_bits_address; //@ demo_utils_arbiter.py:23
    wire [31:0] arbiter0_io_input_3_bits_data; //@ demo_utils_arbiter.py:23
    wire  arbiter0_io_out_ready; //@ demo_utils_arbiter.py:23
    wire  arbiter0_io_out_valid; //@ demo_utils_arbiter.py:23
    wire [3:0] arbiter0_io_out_bits_op; //@ demo_utils_arbiter.py:23
    wire [3:0] arbiter0_io_out_bits_address; //@ demo_utils_arbiter.py:23
    wire [31:0] arbiter0_io_out_bits_data; //@ demo_utils_arbiter.py:23
    wire [1:0] arbiter0_io_chosen; //@ demo_utils_arbiter.py:23
    wire  arbiter0_clock; //@ demo_utils_arbiter.py:23
    wire  arbiter0_reset; //@ demo_utils_arbiter.py:23
    wire  _T_0; //@ demo_utils_arbiter.py:33
    wire [4:0] _T_1; //@ demo_utils_arbiter.py:34
    wire [3:0] _T_2; //@ demo_utils_arbiter.py:34
    wire [4:0] _T_3; //@ demo_utils_arbiter.py:34
    wire [3:0] _T_4; //@ demo_utils_arbiter.py:34
    wire [3:0] _T_5; //@ demo_utils_arbiter.py:34
    wire  _T_6; //@ demo_utils_arbiter.py:33
    wire [4:0] _T_7; //@ demo_utils_arbiter.py:34
    wire [3:0] _T_8; //@ demo_utils_arbiter.py:34
    wire [4:0] _T_9; //@ demo_utils_arbiter.py:34
    wire [3:0] _T_10; //@ demo_utils_arbiter.py:34
    wire [3:0] _T_11; //@ demo_utils_arbiter.py:34
    wire  _T_12; //@ demo_utils_arbiter.py:33
    wire [4:0] _T_13; //@ demo_utils_arbiter.py:34
    wire [3:0] _T_14; //@ demo_utils_arbiter.py:34
    wire [4:0] _T_15; //@ demo_utils_arbiter.py:34
    wire [3:0] _T_16; //@ demo_utils_arbiter.py:34
    wire [3:0] _T_17; //@ demo_utils_arbiter.py:34
    wire  _T_18; //@ demo_utils_arbiter.py:33
    wire [4:0] _T_19; //@ demo_utils_arbiter.py:34
    wire [3:0] _T_20; //@ demo_utils_arbiter.py:34
    wire [4:0] _T_21; //@ demo_utils_arbiter.py:34
    wire [3:0] _T_22; //@ demo_utils_arbiter.py:34
    wire [3:0] _T_23; //@ demo_utils_arbiter.py:34
    wire  reqs1_valid_0_i; //@ demo_utils_arbiter.py:38
    reg   reqs1_valid_0_o; //@ demo_utils_arbiter.py:38
    wire  reqs1_valid_1_i; //@ demo_utils_arbiter.py:38
    reg   reqs1_valid_1_o; //@ demo_utils_arbiter.py:38
    wire  reqs1_valid_2_i; //@ demo_utils_arbiter.py:38
    reg   reqs1_valid_2_o; //@ demo_utils_arbiter.py:38
    wire  reqs1_valid_3_i; //@ demo_utils_arbiter.py:38
    reg   reqs1_valid_3_o; //@ demo_utils_arbiter.py:38
    wire [3:0] reqs1_data_0_op_i; //@ demo_utils_arbiter.py:39
    reg  [3:0] reqs1_data_0_op_o; //@ demo_utils_arbiter.py:39
    wire [3:0] reqs1_data_0_address_i; //@ demo_utils_arbiter.py:39
    reg  [3:0] reqs1_data_0_address_o; //@ demo_utils_arbiter.py:39
    wire [31:0] reqs1_data_0_data_i; //@ demo_utils_arbiter.py:39
    reg  [31:0] reqs1_data_0_data_o; //@ demo_utils_arbiter.py:39
    wire [3:0] reqs1_data_1_op_i; //@ demo_utils_arbiter.py:39
    reg  [3:0] reqs1_data_1_op_o; //@ demo_utils_arbiter.py:39
    wire [3:0] reqs1_data_1_address_i; //@ demo_utils_arbiter.py:39
    reg  [3:0] reqs1_data_1_address_o; //@ demo_utils_arbiter.py:39
    wire [31:0] reqs1_data_1_data_i; //@ demo_utils_arbiter.py:39
    reg  [31:0] reqs1_data_1_data_o; //@ demo_utils_arbiter.py:39
    wire [3:0] reqs1_data_2_op_i; //@ demo_utils_arbiter.py:39
    reg  [3:0] reqs1_data_2_op_o; //@ demo_utils_arbiter.py:39
    wire [3:0] reqs1_data_2_address_i; //@ demo_utils_arbiter.py:39
    reg  [3:0] reqs1_data_2_address_o; //@ demo_utils_arbiter.py:39
    wire [31:0] reqs1_data_2_data_i; //@ demo_utils_arbiter.py:39
    reg  [31:0] reqs1_data_2_data_o; //@ demo_utils_arbiter.py:39
    wire [3:0] reqs1_data_3_op_i; //@ demo_utils_arbiter.py:39
    reg  [3:0] reqs1_data_3_op_o; //@ demo_utils_arbiter.py:39
    wire [3:0] reqs1_data_3_address_i; //@ demo_utils_arbiter.py:39
    reg  [3:0] reqs1_data_3_address_o; //@ demo_utils_arbiter.py:39
    wire [31:0] reqs1_data_3_data_i; //@ demo_utils_arbiter.py:39
    reg  [31:0] reqs1_data_3_data_o; //@ demo_utils_arbiter.py:39
    wire  arb1_out_valid_i; //@ demo_utils_arbiter.py:40
    reg   arb1_out_valid_o; //@ demo_utils_arbiter.py:40
    wire [3:0] arb1_out_data_op_i; //@ demo_utils_arbiter.py:41
    reg  [3:0] arb1_out_data_op_o; //@ demo_utils_arbiter.py:41
    wire [3:0] arb1_out_data_address_i; //@ demo_utils_arbiter.py:41
    reg  [3:0] arb1_out_data_address_o; //@ demo_utils_arbiter.py:41
    wire [31:0] arb1_out_data_data_i; //@ demo_utils_arbiter.py:41
    reg  [31:0] arb1_out_data_data_o; //@ demo_utils_arbiter.py:41
    wire  arbiter1_io_input_0_ready; //@ demo_utils_arbiter.py:44
    wire  arbiter1_io_input_0_valid; //@ demo_utils_arbiter.py:44
    wire [3:0] arbiter1_io_input_0_bits_op; //@ demo_utils_arbiter.py:44
    wire [3:0] arbiter1_io_input_0_bits_address; //@ demo_utils_arbiter.py:44
    wire [31:0] arbiter1_io_input_0_bits_data; //@ demo_utils_arbiter.py:44
    wire  arbiter1_io_input_1_ready; //@ demo_utils_arbiter.py:44
    wire  arbiter1_io_input_1_valid; //@ demo_utils_arbiter.py:44
    wire [3:0] arbiter1_io_input_1_bits_op; //@ demo_utils_arbiter.py:44
    wire [3:0] arbiter1_io_input_1_bits_address; //@ demo_utils_arbiter.py:44
    wire [31:0] arbiter1_io_input_1_bits_data; //@ demo_utils_arbiter.py:44
    wire  arbiter1_io_input_2_ready; //@ demo_utils_arbiter.py:44
    wire  arbiter1_io_input_2_valid; //@ demo_utils_arbiter.py:44
    wire [3:0] arbiter1_io_input_2_bits_op; //@ demo_utils_arbiter.py:44
    wire [3:0] arbiter1_io_input_2_bits_address; //@ demo_utils_arbiter.py:44
    wire [31:0] arbiter1_io_input_2_bits_data; //@ demo_utils_arbiter.py:44
    wire  arbiter1_io_input_3_ready; //@ demo_utils_arbiter.py:44
    wire  arbiter1_io_input_3_valid; //@ demo_utils_arbiter.py:44
    wire [3:0] arbiter1_io_input_3_bits_op; //@ demo_utils_arbiter.py:44
    wire [3:0] arbiter1_io_input_3_bits_address; //@ demo_utils_arbiter.py:44
    wire [31:0] arbiter1_io_input_3_bits_data; //@ demo_utils_arbiter.py:44
    wire  arbiter1_io_out_ready; //@ demo_utils_arbiter.py:44
    wire  arbiter1_io_out_valid; //@ demo_utils_arbiter.py:44
    wire [3:0] arbiter1_io_out_bits_op; //@ demo_utils_arbiter.py:44
    wire [3:0] arbiter1_io_out_bits_address; //@ demo_utils_arbiter.py:44
    wire [31:0] arbiter1_io_out_bits_data; //@ demo_utils_arbiter.py:44
    wire [1:0] arbiter1_io_chosen; //@ demo_utils_arbiter.py:44
    wire  arbiter1_clock; //@ demo_utils_arbiter.py:44
    wire  arbiter1_reset; //@ demo_utils_arbiter.py:44
    wire  _T_24; //@ demo_utils_arbiter.py:54
    wire [4:0] _T_25; //@ demo_utils_arbiter.py:55
    wire [3:0] _T_26; //@ demo_utils_arbiter.py:55
    wire [4:0] _T_27; //@ demo_utils_arbiter.py:55
    wire [3:0] _T_28; //@ demo_utils_arbiter.py:55
    wire [3:0] _T_29; //@ demo_utils_arbiter.py:55
    wire  _T_30; //@ demo_utils_arbiter.py:54
    wire [4:0] _T_31; //@ demo_utils_arbiter.py:55
    wire [3:0] _T_32; //@ demo_utils_arbiter.py:55
    wire [4:0] _T_33; //@ demo_utils_arbiter.py:55
    wire [3:0] _T_34; //@ demo_utils_arbiter.py:55
    wire [3:0] _T_35; //@ demo_utils_arbiter.py:55
    wire  _T_36; //@ demo_utils_arbiter.py:54
    wire [4:0] _T_37; //@ demo_utils_arbiter.py:55
    wire [3:0] _T_38; //@ demo_utils_arbiter.py:55
    wire [4:0] _T_39; //@ demo_utils_arbiter.py:55
    wire [3:0] _T_40; //@ demo_utils_arbiter.py:55
    wire [3:0] _T_41; //@ demo_utils_arbiter.py:55
    wire  _T_42; //@ demo_utils_arbiter.py:54
    wire [4:0] _T_43; //@ demo_utils_arbiter.py:55
    wire [3:0] _T_44; //@ demo_utils_arbiter.py:55
    wire [4:0] _T_45; //@ demo_utils_arbiter.py:55
    wire [3:0] _T_46; //@ demo_utils_arbiter.py:55
    wire [3:0] _T_47; //@ demo_utils_arbiter.py:55
    always @(posedge clock) //@ demo_utils_arbiter.py:17
        if (reset)
            reqs0_valid_0_o <= 1'h0;
        else
            reqs0_valid_0_o <= reqs0_valid_0_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:17
        if (reset)
            reqs0_valid_1_o <= 1'h0;
        else
            reqs0_valid_1_o <= reqs0_valid_1_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:17
        if (reset)
            reqs0_valid_2_o <= 1'h0;
        else
            reqs0_valid_2_o <= reqs0_valid_2_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:17
        if (reset)
            reqs0_valid_3_o <= 1'h0;
        else
            reqs0_valid_3_o <= reqs0_valid_3_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:18
        reqs0_data_0_op_o <= reqs0_data_0_op_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:18
        reqs0_data_0_address_o <= reqs0_data_0_address_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:18
        reqs0_data_0_data_o <= reqs0_data_0_data_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:18
        reqs0_data_1_op_o <= reqs0_data_1_op_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:18
        reqs0_data_1_address_o <= reqs0_data_1_address_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:18
        reqs0_data_1_data_o <= reqs0_data_1_data_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:18
        reqs0_data_2_op_o <= reqs0_data_2_op_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:18
        reqs0_data_2_address_o <= reqs0_data_2_address_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:18
        reqs0_data_2_data_o <= reqs0_data_2_data_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:18
        reqs0_data_3_op_o <= reqs0_data_3_op_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:18
        reqs0_data_3_address_o <= reqs0_data_3_address_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:18
        reqs0_data_3_data_o <= reqs0_data_3_data_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:19
        if (reset)
            arb0_out_valid_o <= 1'h0;
        else
            arb0_out_valid_o <= arb0_out_valid_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:20
        arb0_out_data_op_o <= arb0_out_data_op_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:20
        arb0_out_data_address_o <= arb0_out_data_address_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:20
        arb0_out_data_data_o <= arb0_out_data_data_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:38
        if (reset)
            reqs1_valid_0_o <= 1'h0;
        else
            reqs1_valid_0_o <= reqs1_valid_0_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:38
        if (reset)
            reqs1_valid_1_o <= 1'h0;
        else
            reqs1_valid_1_o <= reqs1_valid_1_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:38
        if (reset)
            reqs1_valid_2_o <= 1'h0;
        else
            reqs1_valid_2_o <= reqs1_valid_2_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:38
        if (reset)
            reqs1_valid_3_o <= 1'h0;
        else
            reqs1_valid_3_o <= reqs1_valid_3_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:39
        reqs1_data_0_op_o <= reqs1_data_0_op_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:39
        reqs1_data_0_address_o <= reqs1_data_0_address_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:39
        reqs1_data_0_data_o <= reqs1_data_0_data_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:39
        reqs1_data_1_op_o <= reqs1_data_1_op_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:39
        reqs1_data_1_address_o <= reqs1_data_1_address_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:39
        reqs1_data_1_data_o <= reqs1_data_1_data_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:39
        reqs1_data_2_op_o <= reqs1_data_2_op_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:39
        reqs1_data_2_address_o <= reqs1_data_2_address_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:39
        reqs1_data_2_data_o <= reqs1_data_2_data_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:39
        reqs1_data_3_op_o <= reqs1_data_3_op_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:39
        reqs1_data_3_address_o <= reqs1_data_3_address_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:39
        reqs1_data_3_data_o <= reqs1_data_3_data_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:40
        if (reset)
            arb1_out_valid_o <= 1'h0;
        else
            arb1_out_valid_o <= arb1_out_valid_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:41
        arb1_out_data_op_o <= arb1_out_data_op_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:41
        arb1_out_data_address_o <= arb1_out_data_address_i;
    always @(posedge clock) //@ demo_utils_arbiter.py:41
        arb1_out_data_data_o <= arb1_out_data_data_i;
    sp_arbiter arbiter0( //@ demo_utils_arbiter.py:23
        .io_input_0_ready(arbiter0_io_input_0_ready),
        .io_input_0_valid(arbiter0_io_input_0_valid),
        .io_input_0_bits_op(arbiter0_io_input_0_bits_op),
        .io_input_0_bits_address(arbiter0_io_input_0_bits_address),
        .io_input_0_bits_data(arbiter0_io_input_0_bits_data),
        .io_input_1_ready(arbiter0_io_input_1_ready),
        .io_input_1_valid(arbiter0_io_input_1_valid),
        .io_input_1_bits_op(arbiter0_io_input_1_bits_op),
        .io_input_1_bits_address(arbiter0_io_input_1_bits_address),
        .io_input_1_bits_data(arbiter0_io_input_1_bits_data),
        .io_input_2_ready(arbiter0_io_input_2_ready),
        .io_input_2_valid(arbiter0_io_input_2_valid),
        .io_input_2_bits_op(arbiter0_io_input_2_bits_op),
        .io_input_2_bits_address(arbiter0_io_input_2_bits_address),
        .io_input_2_bits_data(arbiter0_io_input_2_bits_data),
        .io_input_3_ready(arbiter0_io_input_3_ready),
        .io_input_3_valid(arbiter0_io_input_3_valid),
        .io_input_3_bits_op(arbiter0_io_input_3_bits_op),
        .io_input_3_bits_address(arbiter0_io_input_3_bits_address),
        .io_input_3_bits_data(arbiter0_io_input_3_bits_data),
        .io_out_ready(arbiter0_io_out_ready),
        .io_out_valid(arbiter0_io_out_valid),
        .io_out_bits_op(arbiter0_io_out_bits_op),
        .io_out_bits_address(arbiter0_io_out_bits_address),
        .io_out_bits_data(arbiter0_io_out_bits_data),
        .io_chosen(arbiter0_io_chosen),
        .clock(arbiter0_clock),
        .reset(arbiter0_reset)
    );
    assign arbiter0_clock = clock; //@ demo_utils_arbiter.py:23
    assign arbiter0_reset = reset; //@ demo_utils_arbiter.py:23
    assign arbiter0_io_input_0_valid = reqs0_valid_0_o; //@ demo_utils_arbiter.py:25
    assign arbiter0_io_input_0_bits_data = reqs0_data_0_data_o; //@ demo_utils_arbiter.py:26
    assign arbiter0_io_input_0_bits_address = reqs0_data_0_address_o; //@ demo_utils_arbiter.py:26
    assign arbiter0_io_input_0_bits_op = reqs0_data_0_op_o; //@ demo_utils_arbiter.py:26
    assign arbiter0_io_input_1_valid = reqs0_valid_1_o; //@ demo_utils_arbiter.py:25
    assign arbiter0_io_input_1_bits_data = reqs0_data_1_data_o; //@ demo_utils_arbiter.py:26
    assign arbiter0_io_input_1_bits_address = reqs0_data_1_address_o; //@ demo_utils_arbiter.py:26
    assign arbiter0_io_input_1_bits_op = reqs0_data_1_op_o; //@ demo_utils_arbiter.py:26
    assign arbiter0_io_input_2_valid = reqs0_valid_2_o; //@ demo_utils_arbiter.py:25
    assign arbiter0_io_input_2_bits_data = reqs0_data_2_data_o; //@ demo_utils_arbiter.py:26
    assign arbiter0_io_input_2_bits_address = reqs0_data_2_address_o; //@ demo_utils_arbiter.py:26
    assign arbiter0_io_input_2_bits_op = reqs0_data_2_op_o; //@ demo_utils_arbiter.py:26
    assign arbiter0_io_input_3_valid = reqs0_valid_3_o; //@ demo_utils_arbiter.py:25
    assign arbiter0_io_input_3_bits_data = reqs0_data_3_data_o; //@ demo_utils_arbiter.py:26
    assign arbiter0_io_input_3_bits_address = reqs0_data_3_address_o; //@ demo_utils_arbiter.py:26
    assign arbiter0_io_input_3_bits_op = reqs0_data_3_op_o; //@ demo_utils_arbiter.py:26
    assign arb0_out_valid_i = arbiter0_io_out_valid; //@ demo_utils_arbiter.py:27
    assign arb0_out_data_data_i = arbiter0_io_out_bits_data; //@ demo_utils_arbiter.py:28
    assign arb0_out_data_address_i = arbiter0_io_out_bits_address; //@ demo_utils_arbiter.py:28
    assign arb0_out_data_op_i = arbiter0_io_out_bits_op; //@ demo_utils_arbiter.py:28
    assign arbiter0_io_out_ready = 1'h1; //@ demo_utils_arbiter.py:29
    assign _T_0 = (arbiter0_io_input_0_ready & arbiter0_io_input_0_valid); //@ demo_utils_arbiter.py:33
    assign _T_1 = (reqs0_data_0_address_o + 4'h1); //@ demo_utils_arbiter.py:34
    assign _T_3 = (_T_0 ? _T_1 : reqs0_data_0_address_o); //@ demo_utils_arbiter.py:34
    assign _T_5 = _T_3[3:0]; //@ demo_utils_arbiter.py:34
    assign _T_4 = _T_5; //@ demo_utils_arbiter.py:34
    assign _T_2 = _T_4; //@ demo_utils_arbiter.py:34
    assign reqs0_data_0_address_i = _T_2; //@ demo_utils_arbiter.py:34
    assign _T_6 = (arbiter0_io_input_1_ready & arbiter0_io_input_1_valid); //@ demo_utils_arbiter.py:33
    assign _T_7 = (reqs0_data_1_address_o + 4'h1); //@ demo_utils_arbiter.py:34
    assign _T_9 = (_T_6 ? _T_7 : reqs0_data_1_address_o); //@ demo_utils_arbiter.py:34
    assign _T_11 = _T_9[3:0]; //@ demo_utils_arbiter.py:34
    assign _T_10 = _T_11; //@ demo_utils_arbiter.py:34
    assign _T_8 = _T_10; //@ demo_utils_arbiter.py:34
    assign reqs0_data_1_address_i = _T_8; //@ demo_utils_arbiter.py:34
    assign _T_12 = (arbiter0_io_input_2_ready & arbiter0_io_input_2_valid); //@ demo_utils_arbiter.py:33
    assign _T_13 = (reqs0_data_2_address_o + 4'h1); //@ demo_utils_arbiter.py:34
    assign _T_15 = (_T_12 ? _T_13 : reqs0_data_2_address_o); //@ demo_utils_arbiter.py:34
    assign _T_17 = _T_15[3:0]; //@ demo_utils_arbiter.py:34
    assign _T_16 = _T_17; //@ demo_utils_arbiter.py:34
    assign _T_14 = _T_16; //@ demo_utils_arbiter.py:34
    assign reqs0_data_2_address_i = _T_14; //@ demo_utils_arbiter.py:34
    assign _T_18 = (arbiter0_io_input_3_ready & arbiter0_io_input_3_valid); //@ demo_utils_arbiter.py:33
    assign _T_19 = (reqs0_data_3_address_o + 4'h1); //@ demo_utils_arbiter.py:34
    assign _T_21 = (_T_18 ? _T_19 : reqs0_data_3_address_o); //@ demo_utils_arbiter.py:34
    assign _T_23 = _T_21[3:0]; //@ demo_utils_arbiter.py:34
    assign _T_22 = _T_23; //@ demo_utils_arbiter.py:34
    assign _T_20 = _T_22; //@ demo_utils_arbiter.py:34
    assign reqs0_data_3_address_i = _T_20; //@ demo_utils_arbiter.py:34
    sp_arbiter_1 arbiter1( //@ demo_utils_arbiter.py:44
        .io_input_0_ready(arbiter1_io_input_0_ready),
        .io_input_0_valid(arbiter1_io_input_0_valid),
        .io_input_0_bits_op(arbiter1_io_input_0_bits_op),
        .io_input_0_bits_address(arbiter1_io_input_0_bits_address),
        .io_input_0_bits_data(arbiter1_io_input_0_bits_data),
        .io_input_1_ready(arbiter1_io_input_1_ready),
        .io_input_1_valid(arbiter1_io_input_1_valid),
        .io_input_1_bits_op(arbiter1_io_input_1_bits_op),
        .io_input_1_bits_address(arbiter1_io_input_1_bits_address),
        .io_input_1_bits_data(arbiter1_io_input_1_bits_data),
        .io_input_2_ready(arbiter1_io_input_2_ready),
        .io_input_2_valid(arbiter1_io_input_2_valid),
        .io_input_2_bits_op(arbiter1_io_input_2_bits_op),
        .io_input_2_bits_address(arbiter1_io_input_2_bits_address),
        .io_input_2_bits_data(arbiter1_io_input_2_bits_data),
        .io_input_3_ready(arbiter1_io_input_3_ready),
        .io_input_3_valid(arbiter1_io_input_3_valid),
        .io_input_3_bits_op(arbiter1_io_input_3_bits_op),
        .io_input_3_bits_address(arbiter1_io_input_3_bits_address),
        .io_input_3_bits_data(arbiter1_io_input_3_bits_data),
        .io_out_ready(arbiter1_io_out_ready),
        .io_out_valid(arbiter1_io_out_valid),
        .io_out_bits_op(arbiter1_io_out_bits_op),
        .io_out_bits_address(arbiter1_io_out_bits_address),
        .io_out_bits_data(arbiter1_io_out_bits_data),
        .io_chosen(arbiter1_io_chosen),
        .clock(arbiter1_clock),
        .reset(arbiter1_reset)
    );
    assign arbiter1_clock = clock; //@ demo_utils_arbiter.py:44
    assign arbiter1_reset = reset; //@ demo_utils_arbiter.py:44
    assign arbiter1_io_input_0_valid = reqs1_valid_0_o; //@ demo_utils_arbiter.py:46
    assign arbiter1_io_input_0_bits_data = reqs1_data_0_data_o; //@ demo_utils_arbiter.py:47
    assign arbiter1_io_input_0_bits_address = reqs1_data_0_address_o; //@ demo_utils_arbiter.py:47
    assign arbiter1_io_input_0_bits_op = reqs1_data_0_op_o; //@ demo_utils_arbiter.py:47
    assign arbiter1_io_input_1_valid = reqs1_valid_1_o; //@ demo_utils_arbiter.py:46
    assign arbiter1_io_input_1_bits_data = reqs1_data_1_data_o; //@ demo_utils_arbiter.py:47
    assign arbiter1_io_input_1_bits_address = reqs1_data_1_address_o; //@ demo_utils_arbiter.py:47
    assign arbiter1_io_input_1_bits_op = reqs1_data_1_op_o; //@ demo_utils_arbiter.py:47
    assign arbiter1_io_input_2_valid = reqs1_valid_2_o; //@ demo_utils_arbiter.py:46
    assign arbiter1_io_input_2_bits_data = reqs1_data_2_data_o; //@ demo_utils_arbiter.py:47
    assign arbiter1_io_input_2_bits_address = reqs1_data_2_address_o; //@ demo_utils_arbiter.py:47
    assign arbiter1_io_input_2_bits_op = reqs1_data_2_op_o; //@ demo_utils_arbiter.py:47
    assign arbiter1_io_input_3_valid = reqs1_valid_3_o; //@ demo_utils_arbiter.py:46
    assign arbiter1_io_input_3_bits_data = reqs1_data_3_data_o; //@ demo_utils_arbiter.py:47
    assign arbiter1_io_input_3_bits_address = reqs1_data_3_address_o; //@ demo_utils_arbiter.py:47
    assign arbiter1_io_input_3_bits_op = reqs1_data_3_op_o; //@ demo_utils_arbiter.py:47
    assign arb1_out_valid_i = arbiter1_io_out_valid; //@ demo_utils_arbiter.py:48
    assign arb1_out_data_data_i = arbiter1_io_out_bits_data; //@ demo_utils_arbiter.py:49
    assign arb1_out_data_address_i = arbiter1_io_out_bits_address; //@ demo_utils_arbiter.py:49
    assign arb1_out_data_op_i = arbiter1_io_out_bits_op; //@ demo_utils_arbiter.py:49
    assign arbiter1_io_out_ready = 1'h1; //@ demo_utils_arbiter.py:50
    assign _T_24 = (arbiter1_io_input_0_ready & arbiter1_io_input_0_valid); //@ demo_utils_arbiter.py:54
    assign _T_25 = (reqs1_data_0_address_o + 4'h1); //@ demo_utils_arbiter.py:55
    assign _T_27 = (_T_24 ? _T_25 : reqs1_data_0_address_o); //@ demo_utils_arbiter.py:55
    assign _T_29 = _T_27[3:0]; //@ demo_utils_arbiter.py:55
    assign _T_28 = _T_29; //@ demo_utils_arbiter.py:55
    assign _T_26 = _T_28; //@ demo_utils_arbiter.py:55
    assign reqs1_data_0_address_i = _T_26; //@ demo_utils_arbiter.py:55
    assign _T_30 = (arbiter1_io_input_1_ready & arbiter1_io_input_1_valid); //@ demo_utils_arbiter.py:54
    assign _T_31 = (reqs1_data_1_address_o + 4'h1); //@ demo_utils_arbiter.py:55
    assign _T_33 = (_T_30 ? _T_31 : reqs1_data_1_address_o); //@ demo_utils_arbiter.py:55
    assign _T_35 = _T_33[3:0]; //@ demo_utils_arbiter.py:55
    assign _T_34 = _T_35; //@ demo_utils_arbiter.py:55
    assign _T_32 = _T_34; //@ demo_utils_arbiter.py:55
    assign reqs1_data_1_address_i = _T_32; //@ demo_utils_arbiter.py:55
    assign _T_36 = (arbiter1_io_input_2_ready & arbiter1_io_input_2_valid); //@ demo_utils_arbiter.py:54
    assign _T_37 = (reqs1_data_2_address_o + 4'h1); //@ demo_utils_arbiter.py:55
    assign _T_39 = (_T_36 ? _T_37 : reqs1_data_2_address_o); //@ demo_utils_arbiter.py:55
    assign _T_41 = _T_39[3:0]; //@ demo_utils_arbiter.py:55
    assign _T_40 = _T_41; //@ demo_utils_arbiter.py:55
    assign _T_38 = _T_40; //@ demo_utils_arbiter.py:55
    assign reqs1_data_2_address_i = _T_38; //@ demo_utils_arbiter.py:55
    assign _T_42 = (arbiter1_io_input_3_ready & arbiter1_io_input_3_valid); //@ demo_utils_arbiter.py:54
    assign _T_43 = (reqs1_data_3_address_o + 4'h1); //@ demo_utils_arbiter.py:55
    assign _T_45 = (_T_42 ? _T_43 : reqs1_data_3_address_o); //@ demo_utils_arbiter.py:55
    assign _T_47 = _T_45[3:0]; //@ demo_utils_arbiter.py:55
    assign _T_46 = _T_47; //@ demo_utils_arbiter.py:55
    assign _T_44 = _T_46; //@ demo_utils_arbiter.py:55
    assign reqs1_data_3_address_i = _T_44; //@ demo_utils_arbiter.py:55
    assign reqs0_valid_0_i = reqs0_valid_0_o; //@ phgl_generator.py:85
    assign reqs0_valid_1_i = reqs0_valid_1_o; //@ phgl_generator.py:85
    assign reqs0_valid_2_i = reqs0_valid_2_o; //@ phgl_generator.py:85
    assign reqs0_valid_3_i = reqs0_valid_3_o; //@ phgl_generator.py:85
    assign reqs0_data_0_op_i = reqs0_data_0_op_o; //@ phgl_generator.py:85
    assign reqs0_data_0_data_i = reqs0_data_0_data_o; //@ phgl_generator.py:85
    assign reqs0_data_1_op_i = reqs0_data_1_op_o; //@ phgl_generator.py:85
    assign reqs0_data_1_data_i = reqs0_data_1_data_o; //@ phgl_generator.py:85
    assign reqs0_data_2_op_i = reqs0_data_2_op_o; //@ phgl_generator.py:85
    assign reqs0_data_2_data_i = reqs0_data_2_data_o; //@ phgl_generator.py:85
    assign reqs0_data_3_op_i = reqs0_data_3_op_o; //@ phgl_generator.py:85
    assign reqs0_data_3_data_i = reqs0_data_3_data_o; //@ phgl_generator.py:85
    assign reqs1_valid_0_i = reqs1_valid_0_o; //@ phgl_generator.py:85
    assign reqs1_valid_1_i = reqs1_valid_1_o; //@ phgl_generator.py:85
    assign reqs1_valid_2_i = reqs1_valid_2_o; //@ phgl_generator.py:85
    assign reqs1_valid_3_i = reqs1_valid_3_o; //@ phgl_generator.py:85
    assign reqs1_data_0_op_i = reqs1_data_0_op_o; //@ phgl_generator.py:85
    assign reqs1_data_0_data_i = reqs1_data_0_data_o; //@ phgl_generator.py:85
    assign reqs1_data_1_op_i = reqs1_data_1_op_o; //@ phgl_generator.py:85
    assign reqs1_data_1_data_i = reqs1_data_1_data_o; //@ phgl_generator.py:85
    assign reqs1_data_2_op_i = reqs1_data_2_op_o; //@ phgl_generator.py:85
    assign reqs1_data_2_data_i = reqs1_data_2_data_o; //@ phgl_generator.py:85
    assign reqs1_data_3_op_i = reqs1_data_3_op_o; //@ phgl_generator.py:85
    assign reqs1_data_3_data_i = reqs1_data_3_data_o; //@ phgl_generator.py:85
endmodule
module sp_arbiter(
    output wire  io_input_0_ready, //@ arbiter.py:24
    input  wire  io_input_0_valid, //@ arbiter.py:24
    input  wire [3:0] io_input_0_bits_op, //@ arbiter.py:24
    input  wire [3:0] io_input_0_bits_address, //@ arbiter.py:24
    input  wire [31:0] io_input_0_bits_data, //@ arbiter.py:24
    output wire  io_input_1_ready, //@ arbiter.py:24
    input  wire  io_input_1_valid, //@ arbiter.py:24
    input  wire [3:0] io_input_1_bits_op, //@ arbiter.py:24
    input  wire [3:0] io_input_1_bits_address, //@ arbiter.py:24
    input  wire [31:0] io_input_1_bits_data, //@ arbiter.py:24
    output wire  io_input_2_ready, //@ arbiter.py:24
    input  wire  io_input_2_valid, //@ arbiter.py:24
    input  wire [3:0] io_input_2_bits_op, //@ arbiter.py:24
    input  wire [3:0] io_input_2_bits_address, //@ arbiter.py:24
    input  wire [31:0] io_input_2_bits_data, //@ arbiter.py:24
    output wire  io_input_3_ready, //@ arbiter.py:24
    input  wire  io_input_3_valid, //@ arbiter.py:24
    input  wire [3:0] io_input_3_bits_op, //@ arbiter.py:24
    input  wire [3:0] io_input_3_bits_address, //@ arbiter.py:24
    input  wire [31:0] io_input_3_bits_data, //@ arbiter.py:24
    input  wire  io_out_ready, //@ arbiter.py:29
    output wire  io_out_valid, //@ arbiter.py:29
    output wire [3:0] io_out_bits_op, //@ arbiter.py:29
    output wire [3:0] io_out_bits_address, //@ arbiter.py:29
    output wire [31:0] io_out_bits_data, //@ arbiter.py:29
    output wire [1:0] io_chosen, //@ arbiter.py:30
    input  wire  clock, //@ demo_utils_arbiter.py:23
    input  wire  reset  //@ demo_utils_arbiter.py:23
);
    wire [1:0] _T_0; //@ arbiter.py:143
    wire [1:0] _T_1; //@ arbiter.py:143
    wire [31:0] _T_2; //@ arbiter.py:144
    wire [31:0] _T_3; //@ arbiter.py:144
    wire [3:0] _T_4; //@ arbiter.py:144
    wire [3:0] _T_5; //@ arbiter.py:144
    wire [3:0] _T_6; //@ arbiter.py:144
    wire [3:0] _T_7; //@ arbiter.py:144
    wire [1:0] _T_8; //@ arbiter.py:143
    wire [1:0] _T_9; //@ arbiter.py:143
    wire [31:0] _T_10; //@ arbiter.py:144
    wire [31:0] _T_11; //@ arbiter.py:144
    wire [3:0] _T_12; //@ arbiter.py:144
    wire [3:0] _T_13; //@ arbiter.py:144
    wire [3:0] _T_14; //@ arbiter.py:144
    wire [3:0] _T_15; //@ arbiter.py:144
    wire [1:0] _T_16; //@ arbiter.py:143
    wire [1:0] _T_17; //@ arbiter.py:143
    wire [31:0] _T_18; //@ arbiter.py:144
    wire [31:0] _T_19; //@ arbiter.py:144
    wire [3:0] _T_20; //@ arbiter.py:144
    wire [3:0] _T_21; //@ arbiter.py:144
    wire [3:0] _T_22; //@ arbiter.py:144
    wire [3:0] _T_23; //@ arbiter.py:144
    wire  _T_24; //@ arbiter.py:43
    wire  _T_25; //@ arbiter.py:43
    wire  _T_26; //@ arbiter.py:46
    wire  _T_27; //@ arbiter.py:47
    wire  _T_28; //@ arbiter.py:46
    wire  _T_29; //@ arbiter.py:47
    wire  _T_30; //@ arbiter.py:148
    wire  _T_31; //@ arbiter.py:148
    wire  _T_32; //@ arbiter.py:148
    wire  _T_33; //@ arbiter.py:148
    wire  _T_34; //@ arbiter.py:149
    wire  _T_35; //@ arbiter.py:149
//    assign io_chosen = 2'h3; //@ arbiter.py:139
//    assign io_out_bits_data = io_input_3_bits_data; //@ arbiter.py:140
//    assign io_out_bits_address = io_input_3_bits_address; //@ arbiter.py:140
//    assign io_out_bits_op = io_input_3_bits_op; //@ arbiter.py:140
    assign _T_1 = (io_input_2_valid ? 2'h2 : 2'h3); //@ arbiter.py:143
    assign _T_0 = _T_1; //@ arbiter.py:143
//    assign io_chosen = _T_0; //@ arbiter.py:143
    assign _T_3 = (io_input_2_valid ? io_input_2_bits_data : io_input_3_bits_data); //@ arbiter.py:144
    assign _T_2 = _T_3; //@ arbiter.py:144
//    assign io_out_bits_data = _T_2; //@ arbiter.py:144
    assign _T_5 = (io_input_2_valid ? io_input_2_bits_address : io_input_3_bits_address); //@ arbiter.py:144
    assign _T_4 = _T_5; //@ arbiter.py:144
//    assign io_out_bits_address = _T_4; //@ arbiter.py:144
    assign _T_7 = (io_input_2_valid ? io_input_2_bits_op : io_input_3_bits_op); //@ arbiter.py:144
    assign _T_6 = _T_7; //@ arbiter.py:144
//    assign io_out_bits_op = _T_6; //@ arbiter.py:144
    assign _T_9 = (io_input_1_valid ? 2'h1 : _T_0); //@ arbiter.py:143
    assign _T_8 = _T_9; //@ arbiter.py:143
//    assign io_chosen = _T_8; //@ arbiter.py:143
    assign _T_11 = (io_input_1_valid ? io_input_1_bits_data : _T_2); //@ arbiter.py:144
    assign _T_10 = _T_11; //@ arbiter.py:144
//    assign io_out_bits_data = _T_10; //@ arbiter.py:144
    assign _T_13 = (io_input_1_valid ? io_input_1_bits_address : _T_4); //@ arbiter.py:144
    assign _T_12 = _T_13; //@ arbiter.py:144
//    assign io_out_bits_address = _T_12; //@ arbiter.py:144
    assign _T_15 = (io_input_1_valid ? io_input_1_bits_op : _T_6); //@ arbiter.py:144
    assign _T_14 = _T_15; //@ arbiter.py:144
//    assign io_out_bits_op = _T_14; //@ arbiter.py:144
    assign _T_17 = (io_input_0_valid ? 2'h0 : _T_8); //@ arbiter.py:143
    assign _T_16 = _T_17; //@ arbiter.py:143
    assign io_chosen = _T_16; //@ arbiter.py:143
    assign _T_19 = (io_input_0_valid ? io_input_0_bits_data : _T_10); //@ arbiter.py:144
    assign _T_18 = _T_19; //@ arbiter.py:144
    assign io_out_bits_data = _T_18; //@ arbiter.py:144
    assign _T_21 = (io_input_0_valid ? io_input_0_bits_address : _T_12); //@ arbiter.py:144
    assign _T_20 = _T_21; //@ arbiter.py:144
    assign io_out_bits_address = _T_20; //@ arbiter.py:144
    assign _T_23 = (io_input_0_valid ? io_input_0_bits_op : _T_14); //@ arbiter.py:144
    assign _T_22 = _T_23; //@ arbiter.py:144
    assign io_out_bits_op = _T_22; //@ arbiter.py:144
    assign _T_24 = 1'h1; //@ arbiter.py:43
    assign _T_25 = ~io_input_0_valid; //@ arbiter.py:43
    assign _T_26 = (io_input_0_valid | io_input_1_valid); //@ arbiter.py:46
    assign _T_27 = ~_T_26; //@ arbiter.py:47
    assign _T_28 = (_T_26 | io_input_2_valid); //@ arbiter.py:46
    assign _T_29 = ~_T_28; //@ arbiter.py:47
    assign _T_30 = (_T_24 & io_out_ready); //@ arbiter.py:148
    assign io_input_0_ready = _T_30; //@ arbiter.py:148
    assign _T_31 = (_T_25 & io_out_ready); //@ arbiter.py:148
    assign io_input_1_ready = _T_31; //@ arbiter.py:148
    assign _T_32 = (_T_27 & io_out_ready); //@ arbiter.py:148
    assign io_input_2_ready = _T_32; //@ arbiter.py:148
    assign _T_33 = (_T_29 & io_out_ready); //@ arbiter.py:148
    assign io_input_3_ready = _T_33; //@ arbiter.py:148
    assign _T_34 = ~_T_29; //@ arbiter.py:149
    assign _T_35 = (_T_34 | io_input_3_valid); //@ arbiter.py:149
    assign io_out_valid = _T_35; //@ arbiter.py:149
endmodule
module sp_arbiter_1(
    output wire  io_input_0_ready, //@ arbiter.py:24
    input  wire  io_input_0_valid, //@ arbiter.py:24
    input  wire [3:0] io_input_0_bits_op, //@ arbiter.py:24
    input  wire [3:0] io_input_0_bits_address, //@ arbiter.py:24
    input  wire [31:0] io_input_0_bits_data, //@ arbiter.py:24
    output wire  io_input_1_ready, //@ arbiter.py:24
    input  wire  io_input_1_valid, //@ arbiter.py:24
    input  wire [3:0] io_input_1_bits_op, //@ arbiter.py:24
    input  wire [3:0] io_input_1_bits_address, //@ arbiter.py:24
    input  wire [31:0] io_input_1_bits_data, //@ arbiter.py:24
    output wire  io_input_2_ready, //@ arbiter.py:24
    input  wire  io_input_2_valid, //@ arbiter.py:24
    input  wire [3:0] io_input_2_bits_op, //@ arbiter.py:24
    input  wire [3:0] io_input_2_bits_address, //@ arbiter.py:24
    input  wire [31:0] io_input_2_bits_data, //@ arbiter.py:24
    output wire  io_input_3_ready, //@ arbiter.py:24
    input  wire  io_input_3_valid, //@ arbiter.py:24
    input  wire [3:0] io_input_3_bits_op, //@ arbiter.py:24
    input  wire [3:0] io_input_3_bits_address, //@ arbiter.py:24
    input  wire [31:0] io_input_3_bits_data, //@ arbiter.py:24
    input  wire  io_out_ready, //@ arbiter.py:29
    output wire  io_out_valid, //@ arbiter.py:29
    output wire [3:0] io_out_bits_op, //@ arbiter.py:29
    output wire [3:0] io_out_bits_address, //@ arbiter.py:29
    output wire [31:0] io_out_bits_data, //@ arbiter.py:29
    output wire [1:0] io_chosen, //@ arbiter.py:30
    input  wire  clock, //@ demo_utils_arbiter.py:44
    input  wire  reset  //@ demo_utils_arbiter.py:44
);
    wire [1:0] _T_0; //@ arbiter.py:143
    wire [1:0] _T_1; //@ arbiter.py:143
    wire [31:0] _T_2; //@ arbiter.py:144
    wire [31:0] _T_3; //@ arbiter.py:144
    wire [3:0] _T_4; //@ arbiter.py:144
    wire [3:0] _T_5; //@ arbiter.py:144
    wire [3:0] _T_6; //@ arbiter.py:144
    wire [3:0] _T_7; //@ arbiter.py:144
    wire [1:0] _T_8; //@ arbiter.py:143
    wire [1:0] _T_9; //@ arbiter.py:143
    wire [31:0] _T_10; //@ arbiter.py:144
    wire [31:0] _T_11; //@ arbiter.py:144
    wire [3:0] _T_12; //@ arbiter.py:144
    wire [3:0] _T_13; //@ arbiter.py:144
    wire [3:0] _T_14; //@ arbiter.py:144
    wire [3:0] _T_15; //@ arbiter.py:144
    wire [1:0] _T_16; //@ arbiter.py:143
    wire [1:0] _T_17; //@ arbiter.py:143
    wire [31:0] _T_18; //@ arbiter.py:144
    wire [31:0] _T_19; //@ arbiter.py:144
    wire [3:0] _T_20; //@ arbiter.py:144
    wire [3:0] _T_21; //@ arbiter.py:144
    wire [3:0] _T_22; //@ arbiter.py:144
    wire [3:0] _T_23; //@ arbiter.py:144
    wire  _T_24; //@ arbiter.py:43
    wire  _T_25; //@ arbiter.py:43
    wire  _T_26; //@ arbiter.py:46
    wire  _T_27; //@ arbiter.py:47
    wire  _T_28; //@ arbiter.py:46
    wire  _T_29; //@ arbiter.py:47
    wire  _T_30; //@ arbiter.py:148
    wire  _T_31; //@ arbiter.py:148
    wire  _T_32; //@ arbiter.py:148
    wire  _T_33; //@ arbiter.py:148
    wire  _T_34; //@ arbiter.py:149
    wire  _T_35; //@ arbiter.py:149
//    assign io_chosen = 2'h3; //@ arbiter.py:139
//    assign io_out_bits_data = io_input_3_bits_data; //@ arbiter.py:140
//    assign io_out_bits_address = io_input_3_bits_address; //@ arbiter.py:140
//    assign io_out_bits_op = io_input_3_bits_op; //@ arbiter.py:140
    assign _T_1 = (io_input_2_valid ? 2'h2 : 2'h3); //@ arbiter.py:143
    assign _T_0 = _T_1; //@ arbiter.py:143
//    assign io_chosen = _T_0; //@ arbiter.py:143
    assign _T_3 = (io_input_2_valid ? io_input_2_bits_data : io_input_3_bits_data); //@ arbiter.py:144
    assign _T_2 = _T_3; //@ arbiter.py:144
//    assign io_out_bits_data = _T_2; //@ arbiter.py:144
    assign _T_5 = (io_input_2_valid ? io_input_2_bits_address : io_input_3_bits_address); //@ arbiter.py:144
    assign _T_4 = _T_5; //@ arbiter.py:144
//    assign io_out_bits_address = _T_4; //@ arbiter.py:144
    assign _T_7 = (io_input_2_valid ? io_input_2_bits_op : io_input_3_bits_op); //@ arbiter.py:144
    assign _T_6 = _T_7; //@ arbiter.py:144
//    assign io_out_bits_op = _T_6; //@ arbiter.py:144
    assign _T_9 = (io_input_1_valid ? 2'h1 : _T_0); //@ arbiter.py:143
    assign _T_8 = _T_9; //@ arbiter.py:143
//    assign io_chosen = _T_8; //@ arbiter.py:143
    assign _T_11 = (io_input_1_valid ? io_input_1_bits_data : _T_2); //@ arbiter.py:144
    assign _T_10 = _T_11; //@ arbiter.py:144
//    assign io_out_bits_data = _T_10; //@ arbiter.py:144
    assign _T_13 = (io_input_1_valid ? io_input_1_bits_address : _T_4); //@ arbiter.py:144
    assign _T_12 = _T_13; //@ arbiter.py:144
//    assign io_out_bits_address = _T_12; //@ arbiter.py:144
    assign _T_15 = (io_input_1_valid ? io_input_1_bits_op : _T_6); //@ arbiter.py:144
    assign _T_14 = _T_15; //@ arbiter.py:144
//    assign io_out_bits_op = _T_14; //@ arbiter.py:144
    assign _T_17 = (io_input_0_valid ? 2'h0 : _T_8); //@ arbiter.py:143
    assign _T_16 = _T_17; //@ arbiter.py:143
    assign io_chosen = _T_16; //@ arbiter.py:143
    assign _T_19 = (io_input_0_valid ? io_input_0_bits_data : _T_10); //@ arbiter.py:144
    assign _T_18 = _T_19; //@ arbiter.py:144
    assign io_out_bits_data = _T_18; //@ arbiter.py:144
    assign _T_21 = (io_input_0_valid ? io_input_0_bits_address : _T_12); //@ arbiter.py:144
    assign _T_20 = _T_21; //@ arbiter.py:144
    assign io_out_bits_address = _T_20; //@ arbiter.py:144
    assign _T_23 = (io_input_0_valid ? io_input_0_bits_op : _T_14); //@ arbiter.py:144
    assign _T_22 = _T_23; //@ arbiter.py:144
    assign io_out_bits_op = _T_22; //@ arbiter.py:144
    assign _T_24 = 1'h1; //@ arbiter.py:43
    assign _T_25 = ~io_input_0_valid; //@ arbiter.py:43
    assign _T_26 = (io_input_0_valid | io_input_1_valid); //@ arbiter.py:46
    assign _T_27 = ~_T_26; //@ arbiter.py:47
    assign _T_28 = (_T_26 | io_input_2_valid); //@ arbiter.py:46
    assign _T_29 = ~_T_28; //@ arbiter.py:47
    assign _T_30 = (_T_24 & io_out_ready); //@ arbiter.py:148
    assign io_input_0_ready = _T_30; //@ arbiter.py:148
    assign _T_31 = (_T_25 & io_out_ready); //@ arbiter.py:148
    assign io_input_1_ready = _T_31; //@ arbiter.py:148
    assign _T_32 = (_T_27 & io_out_ready); //@ arbiter.py:148
    assign io_input_2_ready = _T_32; //@ arbiter.py:148
    assign _T_33 = (_T_29 & io_out_ready); //@ arbiter.py:148
    assign io_input_3_ready = _T_33; //@ arbiter.py:148
    assign _T_34 = ~_T_29; //@ arbiter.py:149
    assign _T_35 = (_T_34 | io_input_3_valid); //@ arbiter.py:149
    assign io_out_valid = _T_35; //@ arbiter.py:149
endmodule
