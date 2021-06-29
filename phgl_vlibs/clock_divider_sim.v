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
