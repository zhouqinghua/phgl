`timescale 1ns / 1ps
module dll_sim #(
    parameter JITTER=0.0,
    parameter DW=1
)
(
    input io_clock_ref,
    input io_dll_reset,
    input [7:0] io_adj,
    input [7:0] io_madj,
    input [DW - 1 :0] io_data_in,
    output io_clock_out,
    output io_lock,
    output [DW - 1 :0] io_data_out
);

    reg clock_delay = 0;
    reg[DW - 1 : 0] data_delay = 0;
    reg [7:0] adj_pre = 1;
    reg lock = 0;

    real clock_t0 = 0;
    real clock_t1 = 0;
    real clock_cycle = 0;

    real clock_out_cycle_jitter = 0;


    always @(posedge clock_delay or negedge clock_delay) begin
        if ($urandom_range(0,1)) begin
            clock_out_cycle_jitter = clock_cycle * JITTER;
        end
        else begin
            clock_out_cycle_jitter = -(clock_cycle * JITTER);
        end
    end
    
    always @(posedge io_clock_ref) begin
        clock_t0 = clock_t1;
        clock_t1 = $realtime;
        clock_cycle = clock_t1 - clock_t0;
    end

    always @(posedge io_clock_ref) begin
        adj_pre <= io_adj;
        if (io_dll_reset) begin
            lock <= 0;
        end
        else if (io_adj != adj_pre) begin
            lock <= 0;
        end
    end

    initial begin
        while(1) begin
            @(posedge io_clock_ref);
            if (~lock & ~io_dll_reset) begin
                repeat(100) @(posedge io_clock_ref);
                lock = 1;
            end
        end
    end

    initial begin
        clock_delay = 0;
        lock = 0;
    end

    function int check_is_xz(reg[7:0] data, reg[7:0] size);
        int rslt = 0;
        for (int i = 0; i < size; i++) begin
            if ((data[i] === 'z) || (data[i] === 'x)) begin
                rslt = 1;
            end
        end
        return rslt;
    endfunction
    
    real delay_cycles;
    always @(*) begin
        if (check_is_xz(io_adj, $size(io_adj)) || check_is_xz(io_madj, $size(io_madj))) begin
            delay_cycles = 0.0;
        end
        else begin
            delay_cycles = real'(io_adj)/real'(io_madj);
        end
    end
    always @(*) begin
        clock_delay <= #(delay_cycles * clock_cycle) io_clock_ref;
        data_delay <= #(delay_cycles * clock_cycle) io_data_in;
    end

    assign io_lock = lock;
    assign io_clock_out = io_dll_reset ? io_clock_ref : clock_delay;
    assign io_data_out = io_dll_reset ? io_data_in: data_delay;
endmodule
