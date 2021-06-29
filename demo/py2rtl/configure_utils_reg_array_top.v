module utils_reg_array_top(
    input  wire  clock, //@ phgl_generator.py:85
    input  wire  reset  //@ phgl_generator.py:85
);
    wire  sram0_io_en; //@ demo_utils_reg_array.py:10
    wire  sram0_io_wmode; //@ demo_utils_reg_array.py:10
    wire [7:0] sram0_io_addr; //@ demo_utils_reg_array.py:10
    wire [3:0] sram0_io_wmask; //@ demo_utils_reg_array.py:10
    wire [31:0] sram0_io_wdata; //@ demo_utils_reg_array.py:10
    wire [31:0] sram0_io_rdata; //@ demo_utils_reg_array.py:10
    wire  sram0_clock; //@ demo_utils_reg_array.py:10
    wire  sram0_reset; //@ demo_utils_reg_array.py:10
    wire [9:0] cnt_i; //@ demo_utils_reg_array.py:12
    reg  [9:0] cnt_o; //@ demo_utils_reg_array.py:12
    wire  wr_en; //@ demo_utils_reg_array.py:13
    wire  rd_en; //@ demo_utils_reg_array.py:14
    wire [31:0] rddata; //@ demo_utils_reg_array.py:15
    wire [10:0] _T_0; //@ demo_utils_reg_array.py:17
    wire [9:0] _T_1; //@ demo_utils_reg_array.py:17
    wire [9:0] _T_2; //@ demo_utils_reg_array.py:17
    wire [1:0] _T_3; //@ demo_utils_reg_array.py:18
    wire  _T_4; //@ demo_utils_reg_array.py:18
    wire [1:0] _T_5; //@ demo_utils_reg_array.py:19
    wire  _T_6; //@ demo_utils_reg_array.py:19
    wire  _T_7; //@ demo_utils_reg_array.py:20
    wire [7:0] _T_8; //@ demo_utils_reg_array.py:22
    wire [1:0] _T_9; //@ demo_utils_reg_array.py:23
    wire  _T_10; //@ demo_utils_reg_array.py:23
    wire  _T_11; //@ demo_utils_reg_array.py:23
    wire  _T_12; //@ demo_utils_reg_array.py:23
    wire  _T_13; //@ demo_utils_reg_array.py:23
    wire [1:0] _T_14; //@ demo_utils_reg_array.py:23
    wire [2:0] _T_15; //@ demo_utils_reg_array.py:23
    wire [3:0] _T_16; //@ demo_utils_reg_array.py:23
    wire [7:0] _T_17; //@ demo_utils_reg_array.py:24
    wire [31:0] _T_18; //@ demo_utils_reg_array.py:24
    always @(posedge clock) //@ demo_utils_reg_array.py:12
        if (reset)
            cnt_o <= 10'h0;
        else
            cnt_o <= cnt_i;
    reg_array sram0( //@ demo_utils_reg_array.py:10
        .io_en(sram0_io_en),
        .io_wmode(sram0_io_wmode),
        .io_addr(sram0_io_addr),
        .io_wmask(sram0_io_wmask),
        .io_wdata(sram0_io_wdata),
        .io_rdata(sram0_io_rdata),
        .clock(sram0_clock),
        .reset(sram0_reset)
    );
    assign sram0_clock = clock; //@ demo_utils_reg_array.py:10
    assign sram0_reset = reset; //@ demo_utils_reg_array.py:10
    assign _T_0 = (cnt_o + 10'h1); //@ demo_utils_reg_array.py:17
    assign _T_2 = _T_0[9:0]; //@ demo_utils_reg_array.py:17
    assign _T_1 = _T_2; //@ demo_utils_reg_array.py:17
    assign cnt_i = _T_1; //@ demo_utils_reg_array.py:17
    assign _T_3 = cnt_o[9:8]; //@ demo_utils_reg_array.py:18
    assign _T_4 = (_T_3 == 2'h0); //@ demo_utils_reg_array.py:18
    assign wr_en = _T_4; //@ demo_utils_reg_array.py:18
    assign _T_5 = cnt_o[9:8]; //@ demo_utils_reg_array.py:19
    assign _T_6 = (_T_5 == 2'h1); //@ demo_utils_reg_array.py:19
    assign rd_en = _T_6; //@ demo_utils_reg_array.py:19
    assign _T_7 = (wr_en | rd_en); //@ demo_utils_reg_array.py:20
    assign sram0_io_en = _T_7; //@ demo_utils_reg_array.py:20
    assign sram0_io_wmode = wr_en; //@ demo_utils_reg_array.py:21
    assign _T_8 = cnt_o[7:0]; //@ demo_utils_reg_array.py:22
    assign sram0_io_addr = _T_8; //@ demo_utils_reg_array.py:22
    assign _T_9 = cnt_o[1:0]; //@ demo_utils_reg_array.py:23
    assign _T_10 = (_T_9 == 2'h0); //@ demo_utils_reg_array.py:23
    assign _T_11 = (_T_9 == 2'h1); //@ demo_utils_reg_array.py:23
    assign _T_12 = (_T_9 == 2'h2); //@ demo_utils_reg_array.py:23
    assign _T_13 = (_T_9 == 2'h3); //@ demo_utils_reg_array.py:23
    assign _T_14 = {_T_13, _T_12}; //@ demo_utils_reg_array.py:23
    assign _T_15 = {_T_14, _T_11}; //@ demo_utils_reg_array.py:23
    assign _T_16 = {_T_15, _T_10}; //@ demo_utils_reg_array.py:23
    assign sram0_io_wmask = _T_16; //@ demo_utils_reg_array.py:23
    assign _T_17 = cnt_o[7:0]; //@ demo_utils_reg_array.py:24
    assign _T_18 = {3'h4{_T_17}}; //@ demo_utils_reg_array.py:24
    assign sram0_io_wdata = _T_18; //@ demo_utils_reg_array.py:24
    assign rddata = sram0_io_rdata; //@ demo_utils_reg_array.py:25
endmodule
module reg_array(
    input  wire  io_en, //@ reg_array.py:15
    input  wire  io_wmode, //@ reg_array.py:16
    input  wire [7:0] io_addr, //@ reg_array.py:17
    input  wire [3:0] io_wmask, //@ reg_array.py:18
    input  wire [31:0] io_wdata, //@ reg_array.py:19
    output wire [31:0] io_rdata, //@ reg_array.py:20
    input  wire  clock, //@ demo_utils_reg_array.py:10
    input  wire  reset  //@ demo_utils_reg_array.py:10
);
    reg  [31:0] m[255:0]; //@ reg_array.py:24
    wire [31:0] rd_out; //@ reg_array.py:27
    wire [7:0] rd_addr_i; //@ reg_array.py:28
    reg  [7:0] rd_addr_o; //@ reg_array.py:28
    wire [3:0] wen; //@ reg_array.py:36
    wire  _T_0; //@ reg_array.py:38
    wire  _T_1; //@ reg_array.py:38
    wire  _T_2; //@ reg_array.py:38
    wire  _T_3; //@ reg_array.py:38
    wire  _T_4; //@ reg_array.py:38
    wire [2:0] _T_5; //@ reg_array.py:38
    wire [3:0] _T_6; //@ reg_array.py:38
    wire  _T_7; //@ reg_array.py:38
    wire  _T_8; //@ reg_array.py:38
    wire  _T_9; //@ reg_array.py:38
    wire  _T_10; //@ reg_array.py:38
    wire [1:0] _T_11; //@ reg_array.py:38
    wire  _T_12; //@ reg_array.py:38
    wire [2:0] _T_13; //@ reg_array.py:38
    wire [3:0] _T_14; //@ reg_array.py:38
    wire  _T_15; //@ reg_array.py:38
    wire  _T_16; //@ reg_array.py:38
    wire  _T_17; //@ reg_array.py:38
    wire  _T_18; //@ reg_array.py:38
    wire  _T_19; //@ reg_array.py:38
    wire [1:0] _T_20; //@ reg_array.py:38
    wire [1:0] _T_21; //@ reg_array.py:38
    wire [3:0] _T_22; //@ reg_array.py:38
    wire  _T_23; //@ reg_array.py:38
    wire  _T_24; //@ reg_array.py:38
    wire  _T_25; //@ reg_array.py:38
    wire  _T_26; //@ reg_array.py:38
    wire [2:0] _T_27; //@ reg_array.py:38
    wire [3:0] _T_28; //@ reg_array.py:38
    wire  _T_29; //@ reg_array.py:45
    wire  _T_30; //@ reg_array.py:45
    wire [7:0] _T_31; //@ reg_array.py:46
    wire [7:0] _T_32; //@ reg_array.py:46
    wire [7:0] _T_33; //@ reg_array.py:46
    wire  _T_34; //@ reg_array.py:45
    wire  _T_35; //@ reg_array.py:45
    wire [7:0] _T_36; //@ reg_array.py:46
    wire [7:0] _T_37; //@ reg_array.py:46
    wire [7:0] _T_38; //@ reg_array.py:46
    wire  _T_39; //@ reg_array.py:45
    wire  _T_40; //@ reg_array.py:45
    wire [7:0] _T_41; //@ reg_array.py:46
    wire [7:0] _T_42; //@ reg_array.py:46
    wire [7:0] _T_43; //@ reg_array.py:46
    wire  _T_44; //@ reg_array.py:45
    wire  _T_45; //@ reg_array.py:45
    wire [7:0] _T_46; //@ reg_array.py:46
    wire [7:0] _T_47; //@ reg_array.py:46
    wire [7:0] _T_48; //@ reg_array.py:46
    wire [7:0] _T_49; //@ reg_array.py:47
    always @(posedge clock) //@ reg_array.py:28
        rd_addr_o <= rd_addr_i;
    assign _T_29 = wen[0]; //@ reg_array.py:45
    assign _T_30 = _T_29; //@ reg_array.py:45
    assign _T_31 = io_addr; //@ reg_array.py:46
    //                assign _T_32 = m[_T_31][7:0]; //@ reg_array.py:46
    assign _T_33 = io_wdata[7:0]; //@ reg_array.py:46
    assign _T_32 = _T_33; //@ reg_array.py:46
    assign _T_34 = wen[1]; //@ reg_array.py:45
    assign _T_35 = _T_34; //@ reg_array.py:45
    assign _T_36 = io_addr; //@ reg_array.py:46
    //                assign _T_37 = m[_T_36][15:8]; //@ reg_array.py:46
    assign _T_38 = io_wdata[15:8]; //@ reg_array.py:46
    assign _T_37 = _T_38; //@ reg_array.py:46
    assign _T_39 = wen[2]; //@ reg_array.py:45
    assign _T_40 = _T_39; //@ reg_array.py:45
    assign _T_41 = io_addr; //@ reg_array.py:46
    //                assign _T_42 = m[_T_41][23:16]; //@ reg_array.py:46
    assign _T_43 = io_wdata[23:16]; //@ reg_array.py:46
    assign _T_42 = _T_43; //@ reg_array.py:46
    assign _T_44 = wen[3]; //@ reg_array.py:45
    assign _T_45 = _T_44; //@ reg_array.py:45
    assign _T_46 = io_addr; //@ reg_array.py:46
    //                assign _T_47 = m[_T_46][31:24]; //@ reg_array.py:46
    assign _T_48 = io_wdata[31:24]; //@ reg_array.py:46
    assign _T_47 = _T_48; //@ reg_array.py:46
    assign rd_addr_i = io_addr; //@ reg_array.py:28
//    assign _T_0 = wen[0]; //@ reg_array.py:38
    assign _T_1 = (io_en & io_wmode); //@ reg_array.py:38
    assign _T_2 = io_wmask[0]; //@ reg_array.py:38
    assign _T_3 = (_T_1 & _T_2); //@ reg_array.py:38
    assign _T_0 = _T_3; //@ reg_array.py:38
    assign _T_5 = {2'h3{_T_4}}; //@ reg_array.py:38
    assign _T_6 = {_T_5, _T_0}; //@ reg_array.py:38
//    assign wen = _T_6; //@ reg_array.py:38
//    assign _T_7 = wen[1]; //@ reg_array.py:38
    assign _T_8 = (io_en & io_wmode); //@ reg_array.py:38
    assign _T_9 = io_wmask[1]; //@ reg_array.py:38
    assign _T_10 = (_T_8 & _T_9); //@ reg_array.py:38
    assign _T_7 = _T_10; //@ reg_array.py:38
    assign _T_11 = _T_6[3:2]; //@ reg_array.py:38
    assign _T_12 = _T_6[0]; //@ reg_array.py:38
    assign _T_13 = {_T_11, _T_7}; //@ reg_array.py:38
    assign _T_14 = {_T_13, _T_12}; //@ reg_array.py:38
//    assign wen = _T_14; //@ reg_array.py:38
//    assign _T_15 = wen[2]; //@ reg_array.py:38
    assign _T_16 = (io_en & io_wmode); //@ reg_array.py:38
    assign _T_17 = io_wmask[2]; //@ reg_array.py:38
    assign _T_18 = (_T_16 & _T_17); //@ reg_array.py:38
    assign _T_15 = _T_18; //@ reg_array.py:38
    assign _T_19 = _T_14[3]; //@ reg_array.py:38
    assign _T_20 = _T_14[1:0]; //@ reg_array.py:38
    assign _T_21 = {_T_19, _T_15}; //@ reg_array.py:38
    assign _T_22 = {_T_21, _T_20}; //@ reg_array.py:38
//    assign wen = _T_22; //@ reg_array.py:38
//    assign _T_23 = wen[3]; //@ reg_array.py:38
    assign _T_24 = (io_en & io_wmode); //@ reg_array.py:38
    assign _T_25 = io_wmask[3]; //@ reg_array.py:38
    assign _T_26 = (_T_24 & _T_25); //@ reg_array.py:38
    assign _T_23 = _T_26; //@ reg_array.py:38
    assign _T_27 = _T_22[2:0]; //@ reg_array.py:38
    assign _T_28 = {_T_23, _T_27}; //@ reg_array.py:38
    assign wen = _T_28; //@ reg_array.py:38
    always @(posedge clock) //@ reg_array.py:40
        begin
            if (_T_30) begin
                m[_T_31][7:0] <= _T_32; //@ reg_array.py:46
            end
            if (_T_35) begin
                m[_T_36][15:8] <= _T_37; //@ reg_array.py:46
            end
            if (_T_40) begin
                m[_T_41][23:16] <= _T_42; //@ reg_array.py:46
            end
            if (_T_45) begin
                m[_T_46][31:24] <= _T_47; //@ reg_array.py:46
            end
        end
    assign _T_49 = rd_addr_o; //@ reg_array.py:47
    assign rd_out = m[_T_49]; //@ reg_array.py:47
    assign io_rdata = rd_out; //@ reg_array.py:48
endmodule
