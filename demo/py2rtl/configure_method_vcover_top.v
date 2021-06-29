module method_vcover_top(
    input  wire  io_in0, //@ demo_method_vcover.py:6
    input  wire  io_in1, //@ demo_method_vcover.py:7
    output wire  io_out, //@ demo_method_vcover.py:8
    input  wire  clock, //@ phgl_generator.py:85
    input  wire  reset  //@ phgl_generator.py:85
);
    wire [7:0] cnt_i; //@ demo_method_vcover.py:13
    reg  [7:0] cnt_o; //@ demo_method_vcover.py:13
    wire [8:0] _T_0; //@ demo_method_vcover.py:14
    wire [7:0] _T_1; //@ demo_method_vcover.py:14
    wire [7:0] _T_2; //@ demo_method_vcover.py:14
    wire  _T_3; //@ demo_method_vcover.py:16
    wire  _T_4; //@ demo_method_vcover.py:16
    wire  cov_cover_in0_is_0; //@ demo_method_vcover.py:16
    wire  _T_5; //@ demo_method_vcover.py:16
    wire  _T_6; //@ demo_method_vcover.py:16
    wire  cov_cover_in0_is_1; //@ demo_method_vcover.py:16
    wire  _T_7; //@ demo_method_vcover.py:16
    wire  _T_8; //@ demo_method_vcover.py:16
    wire  cov_cover_in0_is_2; //@ demo_method_vcover.py:16
    wire  _T_9; //@ demo_method_vcover.py:16
    wire  _T_10; //@ demo_method_vcover.py:16
    wire  cov_cover_in0_is_3; //@ demo_method_vcover.py:16
    wire  _T_11; //@ demo_method_vcover.py:18
    wire  cov_TC_12; //@ demo_method_vcover.py:18
    wire  _T_13; //@ demo_method_vcover.py:18
    wire  cov_TC_14; //@ demo_method_vcover.py:18
    wire  _T_15; //@ demo_method_vcover.py:18
    wire  cov_TC_16; //@ demo_method_vcover.py:18
    wire  _T_17; //@ demo_method_vcover.py:18
    wire  cov_TC_18; //@ demo_method_vcover.py:18
    always @(posedge clock) //@ demo_method_vcover.py:13
        if (reset)
            cnt_o <= 8'h0;
        else
            cnt_o <= cnt_i;
    assign _T_0 = (cnt_o + 8'h1); //@ demo_method_vcover.py:14
    assign _T_2 = _T_0[7:0]; //@ demo_method_vcover.py:14
    assign _T_1 = _T_2; //@ demo_method_vcover.py:14
    assign cnt_i = _T_1; //@ demo_method_vcover.py:14
    assign _T_3 = (io_in0 == 1'h0); //@ demo_method_vcover.py:16
    assign _T_4 = io_in0; //@ demo_method_vcover.py:16
    assign cov_cover_in0_is_0 = _T_3; //@ demo_method_vcover.py:16
    `ifdef VCOVER_COND
        always @(posedge clock) if (reset != 1) begin //@ demo_method_vcover.py:16
            cov_cover_in0_is_0: cover(cov_cover_in0_is_0) 
            $write("input in0 in0 = %h\n", _T_4);
        end
    `endif
    assign _T_5 = (io_in0 == 1'h1); //@ demo_method_vcover.py:16
    assign _T_6 = io_in0; //@ demo_method_vcover.py:16
    assign cov_cover_in0_is_1 = _T_5; //@ demo_method_vcover.py:16
    `ifdef VCOVER_COND
        always @(posedge clock) if (reset != 1) begin //@ demo_method_vcover.py:16
            cov_cover_in0_is_1: cover(cov_cover_in0_is_1) 
            $write("input in0 in0 = %h\n", _T_6);
        end
    `endif
    assign _T_7 = (io_in0 == 2'h2); //@ demo_method_vcover.py:16
    assign _T_8 = io_in0; //@ demo_method_vcover.py:16
    assign cov_cover_in0_is_2 = _T_7; //@ demo_method_vcover.py:16
    `ifdef VCOVER_COND
        always @(posedge clock) if (reset != 1) begin //@ demo_method_vcover.py:16
            cov_cover_in0_is_2: cover(cov_cover_in0_is_2) 
            $write("input in0 in0 = %h\n", _T_8);
        end
    `endif
    assign _T_9 = (io_in0 == 2'h3); //@ demo_method_vcover.py:16
    assign _T_10 = io_in0; //@ demo_method_vcover.py:16
    assign cov_cover_in0_is_3 = _T_9; //@ demo_method_vcover.py:16
    `ifdef VCOVER_COND
        always @(posedge clock) if (reset != 1) begin //@ demo_method_vcover.py:16
            cov_cover_in0_is_3: cover(cov_cover_in0_is_3) 
            $write("input in0 in0 = %h\n", _T_10);
        end
    `endif
    assign _T_11 = (cnt_o == 8'h0); //@ demo_method_vcover.py:18
    assign cov_TC_12 = _T_11; //@ demo_method_vcover.py:18
    `ifdef VCOVER_COND
        always @(posedge clock) if (reset != 1) begin //@ demo_method_vcover.py:18
            cov_TC_12: cover(cov_TC_12) 
            $write("cnt covered\n");
        end
    `endif
    assign _T_13 = (cnt_o == 8'h1); //@ demo_method_vcover.py:18
    assign cov_TC_14 = _T_13; //@ demo_method_vcover.py:18
    `ifdef VCOVER_COND
        always @(posedge clock) if (reset != 1) begin //@ demo_method_vcover.py:18
            cov_TC_14: cover(cov_TC_14) 
            $write("cnt covered\n");
        end
    `endif
    assign _T_15 = (cnt_o == 8'h2); //@ demo_method_vcover.py:18
    assign cov_TC_16 = _T_15; //@ demo_method_vcover.py:18
    `ifdef VCOVER_COND
        always @(posedge clock) if (reset != 1) begin //@ demo_method_vcover.py:18
            cov_TC_16: cover(cov_TC_16) 
            $write("cnt covered\n");
        end
    `endif
    assign _T_17 = (cnt_o == 8'h3); //@ demo_method_vcover.py:18
    assign cov_TC_18 = _T_17; //@ demo_method_vcover.py:18
    `ifdef VCOVER_COND
        always @(posedge clock) if (reset != 1) begin //@ demo_method_vcover.py:18
            cov_TC_18: cover(cov_TC_18) 
            $write("cnt covered\n");
        end
    `endif
endmodule
