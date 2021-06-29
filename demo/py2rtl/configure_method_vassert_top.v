module method_vassert_top(
    input  wire  io_in0, //@ demo_method_vassert.py:6
    input  wire  io_in1, //@ demo_method_vassert.py:7
    output wire  io_out, //@ demo_method_vassert.py:8
    input  wire  clock, //@ phgl_generator.py:85
    input  wire  reset  //@ phgl_generator.py:85
);
    wire [7:0] cnt_i; //@ demo_method_vassert.py:13
    reg  [7:0] cnt_o; //@ demo_method_vassert.py:13
    wire [8:0] _T_0; //@ demo_method_vassert.py:14
    wire [7:0] _T_1; //@ demo_method_vassert.py:14
    wire [7:0] _T_2; //@ demo_method_vassert.py:14
    wire  _T_3; //@ demo_method_vassert.py:15
    wire  _T_4; //@ demo_method_vassert.py:15
    wire  ast_assert_in0; //@ demo_method_vassert.py:15
    wire  _T_5; //@ demo_method_vassert.py:16
    wire  _T_6; //@ demo_method_vassert.py:16
    wire  ast_assert_out; //@ demo_method_vassert.py:16
    wire  _T_7; //@ demo_method_vassert.py:17
    wire  ast_TA_8; //@ demo_method_vassert.py:17
    always @(posedge clock) //@ demo_method_vassert.py:13
        if (reset)
            cnt_o <= 8'h0;
        else
            cnt_o <= cnt_i;
    assign _T_0 = (cnt_o + 8'h1); //@ demo_method_vassert.py:14
    assign _T_2 = _T_0[7:0]; //@ demo_method_vassert.py:14
    assign _T_1 = _T_2; //@ demo_method_vassert.py:14
    assign cnt_i = _T_1; //@ demo_method_vassert.py:14
    assign _T_3 = (io_in0 != 1'h0); //@ demo_method_vassert.py:15
    assign _T_4 = io_in0; //@ demo_method_vassert.py:15
    assign ast_assert_in0 = _T_3; //@ demo_method_vassert.py:15
    `ifdef VASSERT_COND
        always @(posedge clock) if (reset != 1) begin //@ demo_method_vassert.py:15
            ast_assert_in0: assert(ast_assert_in0) else
            $write("input in0 should not be zero(in0 = %h)\n", _T_4);
        end
    `endif
    assign _T_5 = (io_out != 8'hff); //@ demo_method_vassert.py:16
    assign _T_6 = io_out; //@ demo_method_vassert.py:16
    assign ast_assert_out = _T_5; //@ demo_method_vassert.py:16
    `ifdef VASSERT_COND
        always @(posedge clock) if (reset != 1) begin //@ demo_method_vassert.py:16
            ast_assert_out: assert(ast_assert_out) else
            $write("input out should not be ff(out = %h)\n", _T_6);
        end
    `endif
    assign _T_7 = (cnt_o != 8'hff); //@ demo_method_vassert.py:17
    assign ast_TA_8 = _T_7; //@ demo_method_vassert.py:17
    `ifdef VASSERT_COND
        always @(posedge clock) if (reset != 1) begin //@ demo_method_vassert.py:17
            ast_TA_8: assert(ast_TA_8) else
            $write("cnt should not be ff\n");
        end
    `endif
endmodule
