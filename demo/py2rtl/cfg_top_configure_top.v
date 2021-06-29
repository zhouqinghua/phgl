module configure_top(
    input  wire  clock, //@ phgl_generator.py:85
    input  wire  reset  //@ phgl_generator.py:85
);
    wire  md0_0_io_wr_en; //@ demo_configure.py:59
    wire  md0_0_io_rd_en; //@ demo_configure.py:59
    wire [3:0] md0_0_io_address; //@ demo_configure.py:59
    wire [7:0] md0_0_io_write_data; //@ demo_configure.py:59
    wire [7:0] md0_0_io_read_data; //@ demo_configure.py:59
    wire  md0_0_clock; //@ demo_configure.py:59
    wire  md0_0_reset; //@ demo_configure.py:59
    wire  md0_1_io_wr_en; //@ demo_configure.py:59
    wire  md0_1_io_rd_en; //@ demo_configure.py:59
    wire [3:0] md0_1_io_address; //@ demo_configure.py:59
    wire [7:0] md0_1_io_write_data; //@ demo_configure.py:59
    wire [7:0] md0_1_io_read_data; //@ demo_configure.py:59
    wire  md0_1_clock; //@ demo_configure.py:59
    wire  md0_1_reset; //@ demo_configure.py:59
    wire  md0_2_io_wr_en; //@ demo_configure.py:59
    wire  md0_2_io_rd_en; //@ demo_configure.py:59
    wire [3:0] md0_2_io_address; //@ demo_configure.py:59
    wire [7:0] md0_2_io_write_data; //@ demo_configure.py:59
    wire [7:0] md0_2_io_read_data; //@ demo_configure.py:59
    wire  md0_2_clock; //@ demo_configure.py:59
    wire  md0_2_reset; //@ demo_configure.py:59
    wire  md0_3_io_wr_en; //@ demo_configure.py:59
    wire  md0_3_io_rd_en; //@ demo_configure.py:59
    wire [3:0] md0_3_io_address; //@ demo_configure.py:59
    wire [7:0] md0_3_io_write_data; //@ demo_configure.py:59
    wire [7:0] md0_3_io_read_data; //@ demo_configure.py:59
    wire  md0_3_clock; //@ demo_configure.py:59
    wire  md0_3_reset; //@ demo_configure.py:59
    wire  md1_0_io_wr_en; //@ demo_configure.py:62
    wire  md1_0_io_rd_en; //@ demo_configure.py:62
    wire [7:0] md1_0_io_address; //@ demo_configure.py:62
    wire [15:0] md1_0_io_write_data; //@ demo_configure.py:62
    wire [15:0] md1_0_io_read_data; //@ demo_configure.py:62
    wire  md1_0_clock; //@ demo_configure.py:62
    wire  md1_0_reset; //@ demo_configure.py:62
    wire  md1_1_io_wr_en; //@ demo_configure.py:62
    wire  md1_1_io_rd_en; //@ demo_configure.py:62
    wire [7:0] md1_1_io_address; //@ demo_configure.py:62
    wire [15:0] md1_1_io_write_data; //@ demo_configure.py:62
    wire [15:0] md1_1_io_read_data; //@ demo_configure.py:62
    wire  md1_1_clock; //@ demo_configure.py:62
    wire  md1_1_reset; //@ demo_configure.py:62
    wire  md1_2_io_wr_en; //@ demo_configure.py:62
    wire  md1_2_io_rd_en; //@ demo_configure.py:62
    wire [7:0] md1_2_io_address; //@ demo_configure.py:62
    wire [15:0] md1_2_io_write_data; //@ demo_configure.py:62
    wire [15:0] md1_2_io_read_data; //@ demo_configure.py:62
    wire  md1_2_clock; //@ demo_configure.py:62
    wire  md1_2_reset; //@ demo_configure.py:62
    wire  md1_3_io_wr_en; //@ demo_configure.py:62
    wire  md1_3_io_rd_en; //@ demo_configure.py:62
    wire [7:0] md1_3_io_address; //@ demo_configure.py:62
    wire [15:0] md1_3_io_write_data; //@ demo_configure.py:62
    wire [15:0] md1_3_io_read_data; //@ demo_configure.py:62
    wire  md1_3_clock; //@ demo_configure.py:62
    wire  md1_3_reset; //@ demo_configure.py:62
    wire  md1_4_io_wr_en; //@ demo_configure.py:62
    wire  md1_4_io_rd_en; //@ demo_configure.py:62
    wire [7:0] md1_4_io_address; //@ demo_configure.py:62
    wire [15:0] md1_4_io_write_data; //@ demo_configure.py:62
    wire [15:0] md1_4_io_read_data; //@ demo_configure.py:62
    wire  md1_4_clock; //@ demo_configure.py:62
    wire  md1_4_reset; //@ demo_configure.py:62
    sub_module0 md0_0( //@ demo_configure.py:59
        .io_wr_en(md0_0_io_wr_en),
        .io_rd_en(md0_0_io_rd_en),
        .io_address(md0_0_io_address),
        .io_write_data(md0_0_io_write_data),
        .io_read_data(md0_0_io_read_data),
        .clock(md0_0_clock),
        .reset(md0_0_reset)
    );
    assign md0_0_clock = clock; //@ demo_configure.py:59
    assign md0_0_reset = reset; //@ demo_configure.py:59
    sub_module0_1 md0_1( //@ demo_configure.py:59
        .io_wr_en(md0_1_io_wr_en),
        .io_rd_en(md0_1_io_rd_en),
        .io_address(md0_1_io_address),
        .io_write_data(md0_1_io_write_data),
        .io_read_data(md0_1_io_read_data),
        .clock(md0_1_clock),
        .reset(md0_1_reset)
    );
    assign md0_1_clock = clock; //@ demo_configure.py:59
    assign md0_1_reset = reset; //@ demo_configure.py:59
    sub_module0_2 md0_2( //@ demo_configure.py:59
        .io_wr_en(md0_2_io_wr_en),
        .io_rd_en(md0_2_io_rd_en),
        .io_address(md0_2_io_address),
        .io_write_data(md0_2_io_write_data),
        .io_read_data(md0_2_io_read_data),
        .clock(md0_2_clock),
        .reset(md0_2_reset)
    );
    assign md0_2_clock = clock; //@ demo_configure.py:59
    assign md0_2_reset = reset; //@ demo_configure.py:59
    sub_module0_3 md0_3( //@ demo_configure.py:59
        .io_wr_en(md0_3_io_wr_en),
        .io_rd_en(md0_3_io_rd_en),
        .io_address(md0_3_io_address),
        .io_write_data(md0_3_io_write_data),
        .io_read_data(md0_3_io_read_data),
        .clock(md0_3_clock),
        .reset(md0_3_reset)
    );
    assign md0_3_clock = clock; //@ demo_configure.py:59
    assign md0_3_reset = reset; //@ demo_configure.py:59
    sub_module1 md1_0( //@ demo_configure.py:62
        .io_wr_en(md1_0_io_wr_en),
        .io_rd_en(md1_0_io_rd_en),
        .io_address(md1_0_io_address),
        .io_write_data(md1_0_io_write_data),
        .io_read_data(md1_0_io_read_data),
        .clock(md1_0_clock),
        .reset(md1_0_reset)
    );
    assign md1_0_clock = clock; //@ demo_configure.py:62
    assign md1_0_reset = reset; //@ demo_configure.py:62
    sub_module1_1 md1_1( //@ demo_configure.py:62
        .io_wr_en(md1_1_io_wr_en),
        .io_rd_en(md1_1_io_rd_en),
        .io_address(md1_1_io_address),
        .io_write_data(md1_1_io_write_data),
        .io_read_data(md1_1_io_read_data),
        .clock(md1_1_clock),
        .reset(md1_1_reset)
    );
    assign md1_1_clock = clock; //@ demo_configure.py:62
    assign md1_1_reset = reset; //@ demo_configure.py:62
    sub_module1_2 md1_2( //@ demo_configure.py:62
        .io_wr_en(md1_2_io_wr_en),
        .io_rd_en(md1_2_io_rd_en),
        .io_address(md1_2_io_address),
        .io_write_data(md1_2_io_write_data),
        .io_read_data(md1_2_io_read_data),
        .clock(md1_2_clock),
        .reset(md1_2_reset)
    );
    assign md1_2_clock = clock; //@ demo_configure.py:62
    assign md1_2_reset = reset; //@ demo_configure.py:62
    sub_module1_3 md1_3( //@ demo_configure.py:62
        .io_wr_en(md1_3_io_wr_en),
        .io_rd_en(md1_3_io_rd_en),
        .io_address(md1_3_io_address),
        .io_write_data(md1_3_io_write_data),
        .io_read_data(md1_3_io_read_data),
        .clock(md1_3_clock),
        .reset(md1_3_reset)
    );
    assign md1_3_clock = clock; //@ demo_configure.py:62
    assign md1_3_reset = reset; //@ demo_configure.py:62
    sub_module1_4 md1_4( //@ demo_configure.py:62
        .io_wr_en(md1_4_io_wr_en),
        .io_rd_en(md1_4_io_rd_en),
        .io_address(md1_4_io_address),
        .io_write_data(md1_4_io_write_data),
        .io_read_data(md1_4_io_read_data),
        .clock(md1_4_clock),
        .reset(md1_4_reset)
    );
    assign md1_4_clock = clock; //@ demo_configure.py:62
    assign md1_4_reset = reset; //@ demo_configure.py:62
endmodule
module sub_module0(
    input  wire  io_wr_en, //@ demo_configure.py:16
    input  wire  io_rd_en, //@ demo_configure.py:17
    input  wire [3:0] io_address, //@ demo_configure.py:18
    input  wire [7:0] io_write_data, //@ demo_configure.py:19
    output wire [7:0] io_read_data, //@ demo_configure.py:20
    input  wire  clock, //@ demo_configure.py:59
    input  wire  reset  //@ demo_configure.py:59
);
endmodule
module sub_module0_1(
    input  wire  io_wr_en, //@ demo_configure.py:16
    input  wire  io_rd_en, //@ demo_configure.py:17
    input  wire [3:0] io_address, //@ demo_configure.py:18
    input  wire [7:0] io_write_data, //@ demo_configure.py:19
    output wire [7:0] io_read_data, //@ demo_configure.py:20
    input  wire  clock, //@ demo_configure.py:59
    input  wire  reset  //@ demo_configure.py:59
);
endmodule
module sub_module0_2(
    input  wire  io_wr_en, //@ demo_configure.py:16
    input  wire  io_rd_en, //@ demo_configure.py:17
    input  wire [3:0] io_address, //@ demo_configure.py:18
    input  wire [7:0] io_write_data, //@ demo_configure.py:19
    output wire [7:0] io_read_data, //@ demo_configure.py:20
    input  wire  clock, //@ demo_configure.py:59
    input  wire  reset  //@ demo_configure.py:59
);
endmodule
module sub_module0_3(
    input  wire  io_wr_en, //@ demo_configure.py:16
    input  wire  io_rd_en, //@ demo_configure.py:17
    input  wire [3:0] io_address, //@ demo_configure.py:18
    input  wire [7:0] io_write_data, //@ demo_configure.py:19
    output wire [7:0] io_read_data, //@ demo_configure.py:20
    input  wire  clock, //@ demo_configure.py:59
    input  wire  reset  //@ demo_configure.py:59
);
endmodule
module sub_module1(
    input  wire  io_wr_en, //@ demo_configure.py:35
    input  wire  io_rd_en, //@ demo_configure.py:36
    input  wire [7:0] io_address, //@ demo_configure.py:37
    input  wire [15:0] io_write_data, //@ demo_configure.py:38
    output wire [15:0] io_read_data, //@ demo_configure.py:39
    input  wire  clock, //@ demo_configure.py:62
    input  wire  reset  //@ demo_configure.py:62
);
endmodule
module sub_module1_1(
    input  wire  io_wr_en, //@ demo_configure.py:35
    input  wire  io_rd_en, //@ demo_configure.py:36
    input  wire [7:0] io_address, //@ demo_configure.py:37
    input  wire [15:0] io_write_data, //@ demo_configure.py:38
    output wire [15:0] io_read_data, //@ demo_configure.py:39
    input  wire  clock, //@ demo_configure.py:62
    input  wire  reset  //@ demo_configure.py:62
);
endmodule
module sub_module1_2(
    input  wire  io_wr_en, //@ demo_configure.py:35
    input  wire  io_rd_en, //@ demo_configure.py:36
    input  wire [7:0] io_address, //@ demo_configure.py:37
    input  wire [15:0] io_write_data, //@ demo_configure.py:38
    output wire [15:0] io_read_data, //@ demo_configure.py:39
    input  wire  clock, //@ demo_configure.py:62
    input  wire  reset  //@ demo_configure.py:62
);
endmodule
module sub_module1_3(
    input  wire  io_wr_en, //@ demo_configure.py:35
    input  wire  io_rd_en, //@ demo_configure.py:36
    input  wire [7:0] io_address, //@ demo_configure.py:37
    input  wire [15:0] io_write_data, //@ demo_configure.py:38
    output wire [15:0] io_read_data, //@ demo_configure.py:39
    input  wire  clock, //@ demo_configure.py:62
    input  wire  reset  //@ demo_configure.py:62
);
endmodule
module sub_module1_4(
    input  wire  io_wr_en, //@ demo_configure.py:35
    input  wire  io_rd_en, //@ demo_configure.py:36
    input  wire [7:0] io_address, //@ demo_configure.py:37
    input  wire [15:0] io_write_data, //@ demo_configure.py:38
    output wire [15:0] io_read_data, //@ demo_configure.py:39
    input  wire  clock, //@ demo_configure.py:62
    input  wire  reset  //@ demo_configure.py:62
);
endmodule
