module module_test(
    input  wire [7:0] io_in0, //@ main_zqh.py:89
    output wire [7:0] io_out0, //@ main_zqh.py:90
    input  wire  clock, //@ phgl_generator.py:40
    input  wire  reset  //@ phgl_generator.py:40
);
    wire [7:0] a; //@ main_zqh.py:585
    wire [7:0] b; //@ main_zqh.py:586
    reg  [7:0] c; //@ main_zqh.py:587
    reg  [7:0] d; //@ main_zqh.py:588
    wire  _T_0; //@ main_zqh.py:589
    wire  _T_1; //@ contextlib.py:17
    wire [8:0] _T_2; //@ main_zqh.py:590
    wire [7:0] _T_3; //@ main_zqh.py:590
    wire [7:0] _T_4; //@ main_zqh.py:590
    wire  _T_5; //@ main_zqh.py:591
    wire  _T_6; //@ contextlib.py:17
    wire [7:0] _T_7; //@ main_zqh.py:592
    wire [7:0] _T_8; //@ main_zqh.py:594
    wire [8:0] _T_9; //@ main_zqh.py:596
    wire [7:0] _T_10; //@ main_zqh.py:596
    wire [7:0] _T_11; //@ main_zqh.py:596
    wire [7:0] _T_12; //@ main_zqh.py:597
    assign _T_2 = (a + b); //@ main_zqh.py:590
    assign _T_4 = _T_2[7:0]; //@ main_zqh.py:590
    assign _T_3 = _T_4; //@ main_zqh.py:590
    assign _T_5 = (b == 8'h0); //@ main_zqh.py:591
    assign _T_6 = _T_5; //@ contextlib.py:17
    assign _T_7 = (a & b); //@ main_zqh.py:592
    assign _T_8 = (a | b); //@ main_zqh.py:594
    assign _T_9 = (a - b); //@ main_zqh.py:596
    assign _T_11 = _T_9[7:0]; //@ main_zqh.py:596
    assign _T_10 = _T_11; //@ main_zqh.py:596
    assign _T_12 = (a ^ b); //@ main_zqh.py:597
    assign _T_0 = (a == 8'h0); //@ main_zqh.py:589
    assign _T_1 = _T_0; //@ contextlib.py:17
    always @(*) //@ contextlib.py:17
        if (_T_1) begin
            c = _T_3; //@ main_zqh.py:590
            if (_T_6) begin
                d = _T_7; //@ main_zqh.py:592
            end
            else begin //@ contextlib.py:17
                d = _T_8; //@ main_zqh.py:594
            end
        end
        else begin //@ contextlib.py:17
            c = _T_10; //@ main_zqh.py:596
            d = _T_12; //@ main_zqh.py:597
        end
endmodule
