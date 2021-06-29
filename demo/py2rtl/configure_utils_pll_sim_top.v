module utils_pll_sim_top(
    input  wire  clock, //@ phgl_generator.py:85
    input  wire  reset  //@ phgl_generator.py:85
);
    wire  pll0_io_clock_ref; //@ demo_utils_pll_sim.py:23
    wire  pll0_io_bypass; //@ demo_utils_pll_sim.py:23
    wire [7:0] pll0_io_mul; //@ demo_utils_pll_sim.py:23
    wire  pll0_io_clock_out; //@ demo_utils_pll_sim.py:23
    wire  pll0_io_lock; //@ demo_utils_pll_sim.py:23
    wire  md0_io_in0; //@ demo_utils_pll_sim.py:27
    wire  md0_io_out; //@ demo_utils_pll_sim.py:27
    wire  md0_clock; //@ demo_utils_pll_sim.py:27
    wire  md0_reset; //@ demo_utils_pll_sim.py:27
    wire  pll1_io_clock_ref; //@ demo_utils_pll_sim.py:31
    wire  pll1_io_bypass; //@ demo_utils_pll_sim.py:31
    wire [7:0] pll1_io_mul; //@ demo_utils_pll_sim.py:31
    wire  pll1_io_clock_out; //@ demo_utils_pll_sim.py:31
    wire  pll1_io_lock; //@ demo_utils_pll_sim.py:31
    wire  md1_io_in0; //@ demo_utils_pll_sim.py:35
    wire  md1_io_out; //@ demo_utils_pll_sim.py:35
    wire  md1_clock; //@ demo_utils_pll_sim.py:35
    wire  md1_reset; //@ demo_utils_pll_sim.py:35
    pll_sim #(
        .JITTER(0.0),
        .DUTY(0.5)
    ) pll0( //@ demo_utils_pll_sim.py:23
        .io_clock_ref(pll0_io_clock_ref),
        .io_bypass(pll0_io_bypass),
        .io_mul(pll0_io_mul),
        .io_clock_out(pll0_io_clock_out),
        .io_lock(pll0_io_lock)
    );
    assign pll0_io_clock_ref = clock; //@ demo_utils_pll_sim.py:24
    assign pll0_io_bypass = 1'h0; //@ demo_utils_pll_sim.py:25
    assign pll0_io_mul = 8'h2; //@ demo_utils_pll_sim.py:26
    sub_module md0( //@ demo_utils_pll_sim.py:27
        .io_in0(md0_io_in0),
        .io_out(md0_io_out),
        .clock(md0_clock),
        .reset(md0_reset)
    );
//    assign md0_clock = clock; //@ demo_utils_pll_sim.py:27
    assign md0_reset = reset; //@ demo_utils_pll_sim.py:27
    assign md0_clock = pll0_io_clock_out; //@ demo_utils_pll_sim.py:28
    pll_sim #(
        .JITTER(0.0),
        .DUTY(0.5)
    ) pll1( //@ demo_utils_pll_sim.py:31
        .io_clock_ref(pll1_io_clock_ref),
        .io_bypass(pll1_io_bypass),
        .io_mul(pll1_io_mul),
        .io_clock_out(pll1_io_clock_out),
        .io_lock(pll1_io_lock)
    );
    assign pll1_io_clock_ref = clock; //@ demo_utils_pll_sim.py:32
    assign pll1_io_bypass = 1'h0; //@ demo_utils_pll_sim.py:33
    assign pll1_io_mul = 8'h4; //@ demo_utils_pll_sim.py:34
    sub_module_1 md1( //@ demo_utils_pll_sim.py:35
        .io_in0(md1_io_in0),
        .io_out(md1_io_out),
        .clock(md1_clock),
        .reset(md1_reset)
    );
//    assign md1_clock = clock; //@ demo_utils_pll_sim.py:35
    assign md1_reset = reset; //@ demo_utils_pll_sim.py:35
    assign md1_clock = pll1_io_clock_out; //@ demo_utils_pll_sim.py:36
endmodule
`timescale 1ns / 1ps
module pll_sim #(
    parameter JITTER=0.0,
    parameter DUTY=0.5
)
(
    input io_clock_ref,
    input io_bypass,
    input [7:0] io_mul,
    output io_clock_out,
    output io_lock
);

    reg clock_mul = 0;
    reg [7:0] mul_pre = 1;
    reg lock = 0;

    real clock_t0 = 0;
    real clock_t1 = 0;
    real clock_cycle = 0;

    real clock_out_cycle = 0;
    real clock_out_cycle_jitter = 0;

    always @(posedge clock_mul or negedge clock_mul) begin
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
        clock_out_cycle = clock_cycle/io_mul;
    end

    always @(posedge io_clock_ref) begin
        mul_pre <= io_mul;
        if (io_mul != mul_pre) begin
            lock <= 0;
        end
    end

    initial begin
        while(1) begin
            @(posedge io_clock_ref);
            if (~lock) begin
                repeat(100) @(posedge io_clock_ref);
                lock = 1;
            end
        end
    end

    initial begin
        clock_mul = 0;
        lock = 0;
        repeat(10) @(posedge io_clock_ref);
        while(1) begin
            if (clock_mul) begin
                #((clock_out_cycle+clock_out_cycle_jitter) * DUTY);
            end
            else begin
                #((clock_out_cycle+clock_out_cycle_jitter) * (1.0 - DUTY));
            end
            clock_mul = ~clock_mul;
        end
    end

    assign io_lock = lock;
    assign io_clock_out = io_bypass ? io_clock_ref : clock_mul;
endmodule

module sub_module(
    input  wire  io_in0, //@ demo_utils_pll_sim.py:6
    output wire  io_out, //@ demo_utils_pll_sim.py:7
    input  wire  clock, //@ demo_utils_pll_sim.py:27
    input  wire  reset  //@ demo_utils_pll_sim.py:27
);
    wire  _T_0_i; //@ demo_utils_pll_sim.py:12
    reg   _T_0_o; //@ demo_utils_pll_sim.py:12
    always @(posedge clock) //@ demo_utils_pll_sim.py:12
        _T_0_o <= _T_0_i;
    assign _T_0_i = io_in0; //@ demo_utils_pll_sim.py:12
    assign io_out = _T_0_o; //@ demo_utils_pll_sim.py:12
endmodule
module sub_module_1(
    input  wire  io_in0, //@ demo_utils_pll_sim.py:6
    output wire  io_out, //@ demo_utils_pll_sim.py:7
    input  wire  clock, //@ demo_utils_pll_sim.py:35
    input  wire  reset  //@ demo_utils_pll_sim.py:35
);
    wire  _T_0_i; //@ demo_utils_pll_sim.py:12
    reg   _T_0_o; //@ demo_utils_pll_sim.py:12
    always @(posedge clock) //@ demo_utils_pll_sim.py:12
        _T_0_o <= _T_0_i;
    assign _T_0_i = io_in0; //@ demo_utils_pll_sim.py:12
    assign io_out = _T_0_o; //@ demo_utils_pll_sim.py:12
endmodule
