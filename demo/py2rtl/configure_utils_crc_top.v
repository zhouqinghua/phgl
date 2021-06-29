module utils_crc_top(
    input  wire  io_req_valid, //@ demo_utils_crc.py:6
    input  wire [7:0] io_req_data, //@ demo_utils_crc.py:7
    output wire [31:0] io_crc32_out, //@ demo_utils_crc.py:8
    input  wire  clock, //@ phgl_generator.py:85
    input  wire  reset  //@ phgl_generator.py:85
);
    wire [31:0] crc_reg_i; //@ demo_utils_crc.py:16
    reg  [31:0] crc_reg_o; //@ demo_utils_crc.py:16
    wire  _T_0_i; //@ demo_utils_crc.py:17
    reg   _T_0_o; //@ demo_utils_crc.py:17
    wire  _T_1; //@ demo_utils_crc.py:17
    wire  _T_2; //@ demo_utils_crc.py:17
    wire [31:0] _T_3; //@ demo_utils_crc.py:17
    wire  _T_4; //@ crc.py:29
    wire  _T_5; //@ crc.py:29
    wire  _T_6; //@ crc.py:29
    wire  _T_7; //@ crc.py:29
    wire  _T_8; //@ crc.py:29
    wire  _T_9; //@ crc.py:29
    wire  _T_10; //@ crc.py:29
    wire  _T_11; //@ crc.py:29
    wire [1:0] _T_12; //@ crc.py:29
    wire [2:0] _T_13; //@ crc.py:29
    wire [3:0] _T_14; //@ crc.py:29
    wire [4:0] _T_15; //@ crc.py:29
    wire [5:0] _T_16; //@ crc.py:29
    wire [6:0] _T_17; //@ crc.py:29
    wire [7:0] _T_18; //@ crc.py:29
    wire [30:0] _T_19; //@ crc.py:10
    wire [31:0] _T_20; //@ crc.py:10
    wire  _T_21; //@ crc.py:12
    wire  _T_22; //@ crc.py:12
    wire  _T_23; //@ crc.py:12
    wire [31:0] _T_24; //@ crc.py:12
    wire [32:0] _T_25; //@ crc.py:13
    wire [31:0] _T_26; //@ crc.py:13
    wire [31:0] _T_27; //@ crc.py:13
    wire [31:0] _T_28; //@ crc.py:13
    wire [30:0] _T_29; //@ crc.py:10
    wire [31:0] _T_30; //@ crc.py:10
    wire  _T_31; //@ crc.py:12
    wire  _T_32; //@ crc.py:12
    wire  _T_33; //@ crc.py:12
    wire [31:0] _T_34; //@ crc.py:12
    wire [32:0] _T_35; //@ crc.py:13
    wire [31:0] _T_36; //@ crc.py:13
    wire [31:0] _T_37; //@ crc.py:13
    wire [31:0] _T_38; //@ crc.py:13
    wire [30:0] _T_39; //@ crc.py:10
    wire [31:0] _T_40; //@ crc.py:10
    wire  _T_41; //@ crc.py:12
    wire  _T_42; //@ crc.py:12
    wire  _T_43; //@ crc.py:12
    wire [31:0] _T_44; //@ crc.py:12
    wire [32:0] _T_45; //@ crc.py:13
    wire [31:0] _T_46; //@ crc.py:13
    wire [31:0] _T_47; //@ crc.py:13
    wire [31:0] _T_48; //@ crc.py:13
    wire [30:0] _T_49; //@ crc.py:10
    wire [31:0] _T_50; //@ crc.py:10
    wire  _T_51; //@ crc.py:12
    wire  _T_52; //@ crc.py:12
    wire  _T_53; //@ crc.py:12
    wire [31:0] _T_54; //@ crc.py:12
    wire [32:0] _T_55; //@ crc.py:13
    wire [31:0] _T_56; //@ crc.py:13
    wire [31:0] _T_57; //@ crc.py:13
    wire [31:0] _T_58; //@ crc.py:13
    wire [30:0] _T_59; //@ crc.py:10
    wire [31:0] _T_60; //@ crc.py:10
    wire  _T_61; //@ crc.py:12
    wire  _T_62; //@ crc.py:12
    wire  _T_63; //@ crc.py:12
    wire [31:0] _T_64; //@ crc.py:12
    wire [32:0] _T_65; //@ crc.py:13
    wire [31:0] _T_66; //@ crc.py:13
    wire [31:0] _T_67; //@ crc.py:13
    wire [31:0] _T_68; //@ crc.py:13
    wire [30:0] _T_69; //@ crc.py:10
    wire [31:0] _T_70; //@ crc.py:10
    wire  _T_71; //@ crc.py:12
    wire  _T_72; //@ crc.py:12
    wire  _T_73; //@ crc.py:12
    wire [31:0] _T_74; //@ crc.py:12
    wire [32:0] _T_75; //@ crc.py:13
    wire [31:0] _T_76; //@ crc.py:13
    wire [31:0] _T_77; //@ crc.py:13
    wire [31:0] _T_78; //@ crc.py:13
    wire [30:0] _T_79; //@ crc.py:10
    wire [31:0] _T_80; //@ crc.py:10
    wire  _T_81; //@ crc.py:12
    wire  _T_82; //@ crc.py:12
    wire  _T_83; //@ crc.py:12
    wire [31:0] _T_84; //@ crc.py:12
    wire [32:0] _T_85; //@ crc.py:13
    wire [31:0] _T_86; //@ crc.py:13
    wire [31:0] _T_87; //@ crc.py:13
    wire [31:0] _T_88; //@ crc.py:13
    wire [30:0] _T_89; //@ crc.py:10
    wire [31:0] _T_90; //@ crc.py:10
    wire  _T_91; //@ crc.py:12
    wire  _T_92; //@ crc.py:12
    wire  _T_93; //@ crc.py:12
    wire [31:0] _T_94; //@ crc.py:12
    wire [32:0] _T_95; //@ crc.py:13
    wire [31:0] _T_96; //@ crc.py:13
    wire [31:0] _T_97; //@ crc.py:13
    wire [31:0] _T_98; //@ crc.py:13
    wire [31:0] _T_99; //@ demo_utils_crc.py:19
    wire [31:0] _T_100; //@ demo_utils_crc.py:19
    always @(posedge clock) //@ demo_utils_crc.py:16
        crc_reg_o <= crc_reg_i;
    always @(posedge clock) //@ demo_utils_crc.py:17
        if (reset)
            _T_0_o <= 1'h0;
        else
            _T_0_o <= _T_0_i;
    assign _T_0_i = io_req_valid; //@ demo_utils_crc.py:17
    assign _T_1 = ~_T_0_o; //@ demo_utils_crc.py:17
    assign _T_2 = (io_req_valid & _T_1); //@ demo_utils_crc.py:17
    assign _T_3 = (_T_2 ? 32'hffffffff : crc_reg_o); //@ demo_utils_crc.py:17
    assign _T_4 = io_req_data[0]; //@ crc.py:29
    assign _T_5 = io_req_data[1]; //@ crc.py:29
    assign _T_6 = io_req_data[2]; //@ crc.py:29
    assign _T_7 = io_req_data[3]; //@ crc.py:29
    assign _T_8 = io_req_data[4]; //@ crc.py:29
    assign _T_9 = io_req_data[5]; //@ crc.py:29
    assign _T_10 = io_req_data[6]; //@ crc.py:29
    assign _T_11 = io_req_data[7]; //@ crc.py:29
    assign _T_12 = {_T_4, _T_5}; //@ crc.py:29
    assign _T_13 = {_T_12, _T_6}; //@ crc.py:29
    assign _T_14 = {_T_13, _T_7}; //@ crc.py:29
    assign _T_15 = {_T_14, _T_8}; //@ crc.py:29
    assign _T_16 = {_T_15, _T_9}; //@ crc.py:29
    assign _T_17 = {_T_16, _T_10}; //@ crc.py:29
    assign _T_18 = {_T_17, _T_11}; //@ crc.py:29
    assign _T_19 = _T_3[30:0]; //@ crc.py:10
    assign _T_20 = {_T_19, 1'h0}; //@ crc.py:10
    assign _T_21 = _T_3[31]; //@ crc.py:12
    assign _T_22 = _T_18[7]; //@ crc.py:12
    assign _T_23 = (_T_21 ^ _T_22); //@ crc.py:12
    assign _T_24 = {6'h20{_T_23}}; //@ crc.py:12
    assign _T_25 = 33'h104c11db7; //@ crc.py:13
    assign _T_26 = _T_25[31:0]; //@ crc.py:13
    assign _T_27 = (_T_24 & _T_26); //@ crc.py:13
    assign _T_28 = (_T_20 ^ _T_27); //@ crc.py:13
    assign _T_29 = _T_28[30:0]; //@ crc.py:10
    assign _T_30 = {_T_29, 1'h0}; //@ crc.py:10
    assign _T_31 = _T_28[31]; //@ crc.py:12
    assign _T_32 = _T_18[6]; //@ crc.py:12
    assign _T_33 = (_T_31 ^ _T_32); //@ crc.py:12
    assign _T_34 = {6'h20{_T_33}}; //@ crc.py:12
    assign _T_35 = 33'h104c11db7; //@ crc.py:13
    assign _T_36 = _T_35[31:0]; //@ crc.py:13
    assign _T_37 = (_T_34 & _T_36); //@ crc.py:13
    assign _T_38 = (_T_30 ^ _T_37); //@ crc.py:13
    assign _T_39 = _T_38[30:0]; //@ crc.py:10
    assign _T_40 = {_T_39, 1'h0}; //@ crc.py:10
    assign _T_41 = _T_38[31]; //@ crc.py:12
    assign _T_42 = _T_18[5]; //@ crc.py:12
    assign _T_43 = (_T_41 ^ _T_42); //@ crc.py:12
    assign _T_44 = {6'h20{_T_43}}; //@ crc.py:12
    assign _T_45 = 33'h104c11db7; //@ crc.py:13
    assign _T_46 = _T_45[31:0]; //@ crc.py:13
    assign _T_47 = (_T_44 & _T_46); //@ crc.py:13
    assign _T_48 = (_T_40 ^ _T_47); //@ crc.py:13
    assign _T_49 = _T_48[30:0]; //@ crc.py:10
    assign _T_50 = {_T_49, 1'h0}; //@ crc.py:10
    assign _T_51 = _T_48[31]; //@ crc.py:12
    assign _T_52 = _T_18[4]; //@ crc.py:12
    assign _T_53 = (_T_51 ^ _T_52); //@ crc.py:12
    assign _T_54 = {6'h20{_T_53}}; //@ crc.py:12
    assign _T_55 = 33'h104c11db7; //@ crc.py:13
    assign _T_56 = _T_55[31:0]; //@ crc.py:13
    assign _T_57 = (_T_54 & _T_56); //@ crc.py:13
    assign _T_58 = (_T_50 ^ _T_57); //@ crc.py:13
    assign _T_59 = _T_58[30:0]; //@ crc.py:10
    assign _T_60 = {_T_59, 1'h0}; //@ crc.py:10
    assign _T_61 = _T_58[31]; //@ crc.py:12
    assign _T_62 = _T_18[3]; //@ crc.py:12
    assign _T_63 = (_T_61 ^ _T_62); //@ crc.py:12
    assign _T_64 = {6'h20{_T_63}}; //@ crc.py:12
    assign _T_65 = 33'h104c11db7; //@ crc.py:13
    assign _T_66 = _T_65[31:0]; //@ crc.py:13
    assign _T_67 = (_T_64 & _T_66); //@ crc.py:13
    assign _T_68 = (_T_60 ^ _T_67); //@ crc.py:13
    assign _T_69 = _T_68[30:0]; //@ crc.py:10
    assign _T_70 = {_T_69, 1'h0}; //@ crc.py:10
    assign _T_71 = _T_68[31]; //@ crc.py:12
    assign _T_72 = _T_18[2]; //@ crc.py:12
    assign _T_73 = (_T_71 ^ _T_72); //@ crc.py:12
    assign _T_74 = {6'h20{_T_73}}; //@ crc.py:12
    assign _T_75 = 33'h104c11db7; //@ crc.py:13
    assign _T_76 = _T_75[31:0]; //@ crc.py:13
    assign _T_77 = (_T_74 & _T_76); //@ crc.py:13
    assign _T_78 = (_T_70 ^ _T_77); //@ crc.py:13
    assign _T_79 = _T_78[30:0]; //@ crc.py:10
    assign _T_80 = {_T_79, 1'h0}; //@ crc.py:10
    assign _T_81 = _T_78[31]; //@ crc.py:12
    assign _T_82 = _T_18[1]; //@ crc.py:12
    assign _T_83 = (_T_81 ^ _T_82); //@ crc.py:12
    assign _T_84 = {6'h20{_T_83}}; //@ crc.py:12
    assign _T_85 = 33'h104c11db7; //@ crc.py:13
    assign _T_86 = _T_85[31:0]; //@ crc.py:13
    assign _T_87 = (_T_84 & _T_86); //@ crc.py:13
    assign _T_88 = (_T_80 ^ _T_87); //@ crc.py:13
    assign _T_89 = _T_88[30:0]; //@ crc.py:10
    assign _T_90 = {_T_89, 1'h0}; //@ crc.py:10
    assign _T_91 = _T_88[31]; //@ crc.py:12
    assign _T_92 = _T_18[0]; //@ crc.py:12
    assign _T_93 = (_T_91 ^ _T_92); //@ crc.py:12
    assign _T_94 = {6'h20{_T_93}}; //@ crc.py:12
    assign _T_95 = 33'h104c11db7; //@ crc.py:13
    assign _T_96 = _T_95[31:0]; //@ crc.py:13
    assign _T_97 = (_T_94 & _T_96); //@ crc.py:13
    assign _T_98 = (_T_90 ^ _T_97); //@ crc.py:13
    assign _T_100 = (io_req_valid ? _T_98 : crc_reg_o); //@ demo_utils_crc.py:19
    assign _T_99 = _T_100; //@ demo_utils_crc.py:19
    assign crc_reg_i = _T_99; //@ demo_utils_crc.py:19
endmodule
