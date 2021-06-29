module utils_clock_divider_sim_top(
    input  wire  clock, //@ phgl_generator.py:85
    input  wire  reset  //@ phgl_generator.py:85
);
    wire [7:0] md0_io_in0; //@ demo_utils_clock_divider_sim.py:32
    wire [7:0] md0_io_out; //@ demo_utils_clock_divider_sim.py:32
    wire  md0_clock; //@ demo_utils_clock_divider_sim.py:32
    wire  md0_reset; //@ demo_utils_clock_divider_sim.py:32
    wire  clk_div0_io_clock_ref; //@ demo_utils_clock_divider_sim.py:33
    wire [7:0] clk_div0_io_div; //@ demo_utils_clock_divider_sim.py:33
    wire  clk_div0_io_clock_out; //@ demo_utils_clock_divider_sim.py:33
    wire [7:0] md1_io_in0; //@ demo_utils_clock_divider_sim.py:38
    wire [7:0] md1_io_out; //@ demo_utils_clock_divider_sim.py:38
    wire  md1_clock; //@ demo_utils_clock_divider_sim.py:38
    wire  md1_reset; //@ demo_utils_clock_divider_sim.py:38
    wire  clk_div1_io_clock_ref; //@ demo_utils_clock_divider_sim.py:39
    wire [7:0] clk_div1_io_div; //@ demo_utils_clock_divider_sim.py:39
    wire  clk_div1_io_clock_out; //@ demo_utils_clock_divider_sim.py:39
    sub_module0 md0( //@ demo_utils_clock_divider_sim.py:32
        .io_in0(md0_io_in0),
        .io_out(md0_io_out),
        .clock(md0_clock),
        .reset(md0_reset)
    );
//    assign md0_clock = clock; //@ demo_utils_clock_divider_sim.py:32
    assign md0_reset = reset; //@ demo_utils_clock_divider_sim.py:32
    clock_divider_sim #(
        .JITTER(0.1),
        .DUTY(0.5)
    ) clk_div0( //@ demo_utils_clock_divider_sim.py:33
        .io_clock_ref(clk_div0_io_clock_ref),
        .io_div(clk_div0_io_div),
        .io_clock_out(clk_div0_io_clock_out)
    );
    assign clk_div0_io_clock_ref = clock; //@ demo_utils_clock_divider_sim.py:34
    assign clk_div0_io_div = 8'h2; //@ demo_utils_clock_divider_sim.py:35
    assign md0_clock = clk_div0_io_clock_out; //@ demo_utils_clock_divider_sim.py:36
    sub_module1 md1( //@ demo_utils_clock_divider_sim.py:38
        .io_in0(md1_io_in0),
        .io_out(md1_io_out),
        .clock(md1_clock),
        .reset(md1_reset)
    );
//    assign md1_clock = clock; //@ demo_utils_clock_divider_sim.py:38
    assign md1_reset = reset; //@ demo_utils_clock_divider_sim.py:38
    clock_divider_sim #(
        .JITTER(0.2),
        .DUTY(0.6)
    ) clk_div1( //@ demo_utils_clock_divider_sim.py:39
        .io_clock_ref(clk_div1_io_clock_ref),
        .io_div(clk_div1_io_div),
        .io_clock_out(clk_div1_io_clock_out)
    );
    assign clk_div1_io_clock_ref = clock; //@ demo_utils_clock_divider_sim.py:40
    assign clk_div1_io_div = 8'h4; //@ demo_utils_clock_divider_sim.py:41
    assign md1_clock = clk_div1_io_clock_out; //@ demo_utils_clock_divider_sim.py:42
endmodule
module sub_module0(
    input  wire [7:0] io_in0, //@ demo_utils_clock_divider_sim.py:6
    output wire [7:0] io_out, //@ demo_utils_clock_divider_sim.py:7
    input  wire  clock, //@ demo_utils_clock_divider_sim.py:32
    input  wire  reset  //@ demo_utils_clock_divider_sim.py:32
);
    wire [7:0] _T_0_i; //@ demo_utils_clock_divider_sim.py:12
    reg  [7:0] _T_0_o; //@ demo_utils_clock_divider_sim.py:12
    always @(posedge clock) //@ demo_utils_clock_divider_sim.py:12
        _T_0_o <= _T_0_i;
    assign _T_0_i = io_in0; //@ demo_utils_clock_divider_sim.py:12
    assign io_out = _T_0_o; //@ demo_utils_clock_divider_sim.py:12
endmodule
`timescale 1ns / 1ps
module clock_divider_sim #(
    parameter JITTER=0.0,
    parameter DUTY=0.5
)
(
    input io_clock_ref,
    input [7:0] io_div,
    output reg io_clock_out
);

    real clock_t0 = 0;
    real clock_t1 = 0;
    real clock_cycle = 0;

    real clock_out_cycle = 0;
    real clock_out_cycle_jitter = 0;

    always @(posedge io_clock_out or negedge io_clock_out) begin
        if ($urandom_range(0,1)) begin
            clock_out_cycle_jitter = clock_out_cycle * JITTER;
        end
        else begin
            clock_out_cycle_jitter = -(clock_out_cycle * JITTER);
        end
    end
    
    always @(posedge io_clock_ref) begin
        clock_t0 = clock_t1;
        clock_t1 = $realtime;
        clock_cycle = clock_t1 - clock_t0;
        clock_out_cycle = clock_cycle * io_div;
    end

    initial begin
        io_clock_out = 0;
        repeat(10) @(posedge io_clock_ref);
        while(1) begin
            if (io_clock_out) begin
                #((clock_out_cycle+clock_out_cycle_jitter) * DUTY);
            end
            else begin
                #((clock_out_cycle+clock_out_cycle_jitter) * (1.0 - DUTY));
            end
            io_clock_out = ~io_clock_out;
        end
    end
endmodule

module sub_module1(
    input  wire [7:0] io_in0, //@ demo_utils_clock_divider_sim.py:17
    output wire [7:0] io_out, //@ demo_utils_clock_divider_sim.py:18
    input  wire  clock, //@ demo_utils_clock_divider_sim.py:38
    input  wire  reset  //@ demo_utils_clock_divider_sim.py:38
);
    wire [7:0] _T_0_i; //@ demo_utils_clock_divider_sim.py:23
    reg  [7:0] _T_0_o; //@ demo_utils_clock_divider_sim.py:23
    always @(posedge clock) //@ demo_utils_clock_divider_sim.py:23
        _T_0_o <= _T_0_i;
    assign _T_0_i = io_in0; //@ demo_utils_clock_divider_sim.py:23
    assign io_out = _T_0_o; //@ demo_utils_clock_divider_sim.py:23
endmodule
