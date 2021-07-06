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
        if ($isunknown(io_mul)) begin
            clock_out_cycle = clock_cycle;
        end
        else begin
            clock_out_cycle = clock_cycle/io_mul;
        end
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
