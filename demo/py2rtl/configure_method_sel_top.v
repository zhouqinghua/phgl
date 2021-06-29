module method_sel_top(
    input  wire  clock, //@ phgl_generator.py:85
    input  wire  reset  //@ phgl_generator.py:85
);
    wire [1:0] s; //@ demo_method_sel.py:17
    wire [7:0] a; //@ demo_method_sel.py:18
    wire [7:0] b; //@ demo_method_sel.py:19
    wire [7:0] c; //@ demo_method_sel.py:20
    wire [7:0] d; //@ demo_method_sel.py:21
    wire [7:0] resault0; //@ demo_method_sel.py:23
    wire  _T_0; //@ demo_method_sel.py:25
    wire [7:0] _T_1; //@ demo_method_sel.py:25
    wire [7:0] _T_2; //@ demo_method_sel.py:25
    wire  _T_3; //@ demo_method_sel.py:25
    wire [7:0] _T_4; //@ demo_method_sel.py:25
    wire [7:0] _T_5; //@ demo_method_sel.py:25
    wire [7:0] _T_6; //@ demo_method_sel.py:25
    wire  _T_7; //@ demo_method_sel.py:25
    wire [7:0] _T_8; //@ demo_method_sel.py:25
    wire [7:0] _T_9; //@ demo_method_sel.py:25
    wire [7:0] _T_10; //@ demo_method_sel.py:25
    wire  _T_11; //@ demo_method_sel.py:25
    wire [7:0] _T_12; //@ demo_method_sel.py:25
    wire [7:0] _T_13; //@ demo_method_sel.py:25
    wire [7:0] _T_14; //@ demo_method_sel.py:25
    wire  array0_0; //@ demo_method_sel.py:27
    wire  array0_1; //@ demo_method_sel.py:27
    wire  array0_2; //@ demo_method_sel.py:27
    wire  array0_3; //@ demo_method_sel.py:27
    wire [7:0] resault1; //@ demo_method_sel.py:28
    wire  _T_15; //@ demo_method_sel.py:30
    wire  _T_16; //@ demo_method_sel.py:30
    wire  _T_17; //@ demo_method_sel.py:30
    wire  _T_18; //@ demo_method_sel.py:30
    wire  _T_19; //@ demo_method_sel.py:30
    wire  _T_20; //@ demo_method_sel.py:30
    wire  _T_21; //@ demo_method_sel.py:30
    wire  _T_22; //@ demo_method_sel.py:30
    wire  _T_23; //@ demo_method_sel.py:30
    wire  _T_24; //@ demo_method_sel.py:30
    wire  _T_25; //@ demo_method_sel.py:30
    wire  _T_26; //@ demo_method_sel.py:30
    wire  _T_27; //@ demo_method_sel.py:30
    wire  _T_28; //@ demo_method_sel.py:30
    wire  _T_29; //@ demo_method_sel.py:30
    wire [7:0] vec0_0; //@ demo_method_sel.py:32
    wire [7:0] vec0_1; //@ demo_method_sel.py:32
    wire [7:0] vec0_2; //@ demo_method_sel.py:32
    wire [7:0] vec0_3; //@ demo_method_sel.py:32
    wire [7:0] resault2; //@ demo_method_sel.py:33
    wire  _T_30; //@ demo_method_sel.py:35
    wire [7:0] _T_31; //@ demo_method_sel.py:35
    wire [7:0] _T_32; //@ demo_method_sel.py:35
    wire  _T_33; //@ demo_method_sel.py:35
    wire [7:0] _T_34; //@ demo_method_sel.py:35
    wire [7:0] _T_35; //@ demo_method_sel.py:35
    wire [7:0] _T_36; //@ demo_method_sel.py:35
    wire  _T_37; //@ demo_method_sel.py:35
    wire [7:0] _T_38; //@ demo_method_sel.py:35
    wire [7:0] _T_39; //@ demo_method_sel.py:35
    wire [7:0] _T_40; //@ demo_method_sel.py:35
    wire  _T_41; //@ demo_method_sel.py:35
    wire [7:0] _T_42; //@ demo_method_sel.py:35
    wire [7:0] _T_43; //@ demo_method_sel.py:35
    wire [7:0] _T_44; //@ demo_method_sel.py:35
    wire [3:0] bd_array0_0_op; //@ demo_method_sel.py:6
    wire [3:0] bd_array0_0_address; //@ demo_method_sel.py:7
    wire [31:0] bd_array0_0_data; //@ demo_method_sel.py:8
    wire [3:0] bd_array0_1_op; //@ demo_method_sel.py:6
    wire [3:0] bd_array0_1_address; //@ demo_method_sel.py:7
    wire [31:0] bd_array0_1_data; //@ demo_method_sel.py:8
    wire [3:0] bd_array0_2_op; //@ demo_method_sel.py:6
    wire [3:0] bd_array0_2_address; //@ demo_method_sel.py:7
    wire [31:0] bd_array0_2_data; //@ demo_method_sel.py:8
    wire [3:0] bd_array0_3_op; //@ demo_method_sel.py:6
    wire [3:0] bd_array0_3_address; //@ demo_method_sel.py:7
    wire [31:0] bd_array0_3_data; //@ demo_method_sel.py:8
    wire [3:0] resault3_op; //@ demo_method_sel.py:6
    wire [3:0] resault3_address; //@ demo_method_sel.py:7
    wire [31:0] resault3_data; //@ demo_method_sel.py:8
    wire [3:0] _T_45_op; //@ demo_method_sel.py:6
    wire [3:0] _T_45_address; //@ demo_method_sel.py:7
    wire [31:0] _T_45_data; //@ demo_method_sel.py:8
    wire  _T_46; //@ demo_method_sel.py:40
    wire [3:0] _T_47; //@ demo_method_sel.py:40
    wire [3:0] _T_48; //@ demo_method_sel.py:40
    wire  _T_49; //@ demo_method_sel.py:40
    wire [3:0] _T_50; //@ demo_method_sel.py:40
    wire [3:0] _T_51; //@ demo_method_sel.py:40
    wire [3:0] _T_52; //@ demo_method_sel.py:40
    wire  _T_53; //@ demo_method_sel.py:40
    wire [3:0] _T_54; //@ demo_method_sel.py:40
    wire [3:0] _T_55; //@ demo_method_sel.py:40
    wire [3:0] _T_56; //@ demo_method_sel.py:40
    wire  _T_57; //@ demo_method_sel.py:40
    wire [3:0] _T_58; //@ demo_method_sel.py:40
    wire [3:0] _T_59; //@ demo_method_sel.py:40
    wire [3:0] _T_60; //@ demo_method_sel.py:40
    wire  _T_61; //@ demo_method_sel.py:40
    wire [3:0] _T_62; //@ demo_method_sel.py:40
    wire [3:0] _T_63; //@ demo_method_sel.py:40
    wire  _T_64; //@ demo_method_sel.py:40
    wire [3:0] _T_65; //@ demo_method_sel.py:40
    wire [3:0] _T_66; //@ demo_method_sel.py:40
    wire [3:0] _T_67; //@ demo_method_sel.py:40
    wire  _T_68; //@ demo_method_sel.py:40
    wire [3:0] _T_69; //@ demo_method_sel.py:40
    wire [3:0] _T_70; //@ demo_method_sel.py:40
    wire [3:0] _T_71; //@ demo_method_sel.py:40
    wire  _T_72; //@ demo_method_sel.py:40
    wire [3:0] _T_73; //@ demo_method_sel.py:40
    wire [3:0] _T_74; //@ demo_method_sel.py:40
    wire [3:0] _T_75; //@ demo_method_sel.py:40
    wire  _T_76; //@ demo_method_sel.py:40
    wire [31:0] _T_77; //@ demo_method_sel.py:40
    wire [31:0] _T_78; //@ demo_method_sel.py:40
    wire  _T_79; //@ demo_method_sel.py:40
    wire [31:0] _T_80; //@ demo_method_sel.py:40
    wire [31:0] _T_81; //@ demo_method_sel.py:40
    wire [31:0] _T_82; //@ demo_method_sel.py:40
    wire  _T_83; //@ demo_method_sel.py:40
    wire [31:0] _T_84; //@ demo_method_sel.py:40
    wire [31:0] _T_85; //@ demo_method_sel.py:40
    wire [31:0] _T_86; //@ demo_method_sel.py:40
    wire  _T_87; //@ demo_method_sel.py:40
    wire [31:0] _T_88; //@ demo_method_sel.py:40
    wire [31:0] _T_89; //@ demo_method_sel.py:40
    wire [31:0] _T_90; //@ demo_method_sel.py:40
    wire  _T_91; //@ demo_method_sel.py:43
    wire  _T_92; //@ demo_method_sel.py:43
    wire  _T_93; //@ demo_method_sel.py:43
    wire  _T_94; //@ demo_method_sel.py:43
    wire [1:0] _T_95; //@ demo_method_sel.py:43
    wire [2:0] _T_96; //@ demo_method_sel.py:43
    wire [3:0] _T_97; //@ demo_method_sel.py:43
    wire [7:0] resault4; //@ demo_method_sel.py:44
    wire  _T_98; //@ demo_method_sel.py:45
    wire [7:0] _T_99; //@ demo_method_sel.py:45
    wire [7:0] _T_100; //@ demo_method_sel.py:45
    wire  _T_101; //@ demo_method_sel.py:45
    wire [7:0] _T_102; //@ demo_method_sel.py:45
    wire [7:0] _T_103; //@ demo_method_sel.py:45
    wire [7:0] _T_104; //@ demo_method_sel.py:45
    wire  _T_105; //@ demo_method_sel.py:45
    wire [7:0] _T_106; //@ demo_method_sel.py:45
    wire [7:0] _T_107; //@ demo_method_sel.py:45
    wire [7:0] _T_108; //@ demo_method_sel.py:45
    wire  _T_109; //@ demo_method_sel.py:45
    wire [7:0] _T_110; //@ demo_method_sel.py:45
    wire [7:0] _T_111; //@ demo_method_sel.py:45
    wire [7:0] _T_112; //@ demo_method_sel.py:45
    wire [9:0] s_key; //@ demo_method_sel.py:48
    wire [7:0] resault5; //@ demo_method_sel.py:50
    wire  _T_113; //@ demo_method_sel.py:51
    wire  _T_114; //@ demo_method_sel.py:51
    wire  _T_115; //@ demo_method_sel.py:51
    wire  _T_116; //@ demo_method_sel.py:51
    wire [7:0] _T_117; //@ demo_method_sel.py:51
    wire [7:0] _T_118; //@ demo_method_sel.py:51
    wire [7:0] _T_119; //@ demo_method_sel.py:51
    wire [7:0] _T_120; //@ demo_method_sel.py:51
    assign _T_0 = (s == 2'h0); //@ demo_method_sel.py:25
    assign _T_1 = {4'h8{_T_0}}; //@ demo_method_sel.py:25
    assign _T_2 = (_T_1 & a); //@ demo_method_sel.py:25
    assign _T_3 = (s == 2'h1); //@ demo_method_sel.py:25
    assign _T_4 = {4'h8{_T_3}}; //@ demo_method_sel.py:25
    assign _T_5 = (_T_4 & b); //@ demo_method_sel.py:25
    assign _T_6 = (_T_2 | _T_5); //@ demo_method_sel.py:25
    assign _T_7 = (s == 2'h2); //@ demo_method_sel.py:25
    assign _T_8 = {4'h8{_T_7}}; //@ demo_method_sel.py:25
    assign _T_9 = (_T_8 & c); //@ demo_method_sel.py:25
    assign _T_10 = (_T_6 | _T_9); //@ demo_method_sel.py:25
    assign _T_11 = (s == 2'h3); //@ demo_method_sel.py:25
    assign _T_12 = {4'h8{_T_11}}; //@ demo_method_sel.py:25
    assign _T_13 = (_T_12 & d); //@ demo_method_sel.py:25
    assign _T_14 = (_T_10 | _T_13); //@ demo_method_sel.py:25
    assign resault0 = _T_14; //@ demo_method_sel.py:25
    assign _T_15 = (s == 2'h0); //@ demo_method_sel.py:30
    assign _T_16 = {1'h1{_T_15}}; //@ demo_method_sel.py:30
    assign _T_17 = (_T_16 & array0_0); //@ demo_method_sel.py:30
    assign _T_18 = (s == 2'h1); //@ demo_method_sel.py:30
    assign _T_19 = {1'h1{_T_18}}; //@ demo_method_sel.py:30
    assign _T_20 = (_T_19 & array0_1); //@ demo_method_sel.py:30
    assign _T_21 = (_T_17 | _T_20); //@ demo_method_sel.py:30
    assign _T_22 = (s == 2'h2); //@ demo_method_sel.py:30
    assign _T_23 = {1'h1{_T_22}}; //@ demo_method_sel.py:30
    assign _T_24 = (_T_23 & array0_2); //@ demo_method_sel.py:30
    assign _T_25 = (_T_21 | _T_24); //@ demo_method_sel.py:30
    assign _T_26 = (s == 2'h3); //@ demo_method_sel.py:30
    assign _T_27 = {1'h1{_T_26}}; //@ demo_method_sel.py:30
    assign _T_28 = (_T_27 & array0_3); //@ demo_method_sel.py:30
    assign _T_29 = (_T_25 | _T_28); //@ demo_method_sel.py:30
    assign resault1 = _T_29; //@ demo_method_sel.py:30
    assign _T_30 = (s == 2'h0); //@ demo_method_sel.py:35
    assign _T_31 = {4'h8{_T_30}}; //@ demo_method_sel.py:35
    assign _T_32 = (_T_31 & vec0_0); //@ demo_method_sel.py:35
    assign _T_33 = (s == 2'h1); //@ demo_method_sel.py:35
    assign _T_34 = {4'h8{_T_33}}; //@ demo_method_sel.py:35
    assign _T_35 = (_T_34 & vec0_1); //@ demo_method_sel.py:35
    assign _T_36 = (_T_32 | _T_35); //@ demo_method_sel.py:35
    assign _T_37 = (s == 2'h2); //@ demo_method_sel.py:35
    assign _T_38 = {4'h8{_T_37}}; //@ demo_method_sel.py:35
    assign _T_39 = (_T_38 & vec0_2); //@ demo_method_sel.py:35
    assign _T_40 = (_T_36 | _T_39); //@ demo_method_sel.py:35
    assign _T_41 = (s == 2'h3); //@ demo_method_sel.py:35
    assign _T_42 = {4'h8{_T_41}}; //@ demo_method_sel.py:35
    assign _T_43 = (_T_42 & vec0_3); //@ demo_method_sel.py:35
    assign _T_44 = (_T_40 | _T_43); //@ demo_method_sel.py:35
    assign resault2 = _T_44; //@ demo_method_sel.py:35
    assign _T_46 = (s == 2'h0); //@ demo_method_sel.py:40
    assign _T_47 = {3'h4{_T_46}}; //@ demo_method_sel.py:40
    assign _T_48 = (_T_47 & bd_array0_0_op); //@ demo_method_sel.py:40
    assign _T_49 = (s == 2'h1); //@ demo_method_sel.py:40
    assign _T_50 = {3'h4{_T_49}}; //@ demo_method_sel.py:40
    assign _T_51 = (_T_50 & bd_array0_1_op); //@ demo_method_sel.py:40
    assign _T_52 = (_T_48 | _T_51); //@ demo_method_sel.py:40
    assign _T_53 = (s == 2'h2); //@ demo_method_sel.py:40
    assign _T_54 = {3'h4{_T_53}}; //@ demo_method_sel.py:40
    assign _T_55 = (_T_54 & bd_array0_2_op); //@ demo_method_sel.py:40
    assign _T_56 = (_T_52 | _T_55); //@ demo_method_sel.py:40
    assign _T_57 = (s == 2'h3); //@ demo_method_sel.py:40
    assign _T_58 = {3'h4{_T_57}}; //@ demo_method_sel.py:40
    assign _T_59 = (_T_58 & bd_array0_3_op); //@ demo_method_sel.py:40
    assign _T_60 = (_T_56 | _T_59); //@ demo_method_sel.py:40
    assign _T_45_op = _T_60; //@ demo_method_sel.py:40
    assign _T_61 = (s == 2'h0); //@ demo_method_sel.py:40
    assign _T_62 = {3'h4{_T_61}}; //@ demo_method_sel.py:40
    assign _T_63 = (_T_62 & bd_array0_0_address); //@ demo_method_sel.py:40
    assign _T_64 = (s == 2'h1); //@ demo_method_sel.py:40
    assign _T_65 = {3'h4{_T_64}}; //@ demo_method_sel.py:40
    assign _T_66 = (_T_65 & bd_array0_1_address); //@ demo_method_sel.py:40
    assign _T_67 = (_T_63 | _T_66); //@ demo_method_sel.py:40
    assign _T_68 = (s == 2'h2); //@ demo_method_sel.py:40
    assign _T_69 = {3'h4{_T_68}}; //@ demo_method_sel.py:40
    assign _T_70 = (_T_69 & bd_array0_2_address); //@ demo_method_sel.py:40
    assign _T_71 = (_T_67 | _T_70); //@ demo_method_sel.py:40
    assign _T_72 = (s == 2'h3); //@ demo_method_sel.py:40
    assign _T_73 = {3'h4{_T_72}}; //@ demo_method_sel.py:40
    assign _T_74 = (_T_73 & bd_array0_3_address); //@ demo_method_sel.py:40
    assign _T_75 = (_T_71 | _T_74); //@ demo_method_sel.py:40
    assign _T_45_address = _T_75; //@ demo_method_sel.py:40
    assign _T_76 = (s == 2'h0); //@ demo_method_sel.py:40
    assign _T_77 = {6'h20{_T_76}}; //@ demo_method_sel.py:40
    assign _T_78 = (_T_77 & bd_array0_0_data); //@ demo_method_sel.py:40
    assign _T_79 = (s == 2'h1); //@ demo_method_sel.py:40
    assign _T_80 = {6'h20{_T_79}}; //@ demo_method_sel.py:40
    assign _T_81 = (_T_80 & bd_array0_1_data); //@ demo_method_sel.py:40
    assign _T_82 = (_T_78 | _T_81); //@ demo_method_sel.py:40
    assign _T_83 = (s == 2'h2); //@ demo_method_sel.py:40
    assign _T_84 = {6'h20{_T_83}}; //@ demo_method_sel.py:40
    assign _T_85 = (_T_84 & bd_array0_2_data); //@ demo_method_sel.py:40
    assign _T_86 = (_T_82 | _T_85); //@ demo_method_sel.py:40
    assign _T_87 = (s == 2'h3); //@ demo_method_sel.py:40
    assign _T_88 = {6'h20{_T_87}}; //@ demo_method_sel.py:40
    assign _T_89 = (_T_88 & bd_array0_3_data); //@ demo_method_sel.py:40
    assign _T_90 = (_T_86 | _T_89); //@ demo_method_sel.py:40
    assign _T_45_data = _T_90; //@ demo_method_sel.py:40
    assign resault3_data = _T_45_data; //@ demo_method_sel.py:40
    assign resault3_address = _T_45_address; //@ demo_method_sel.py:40
    assign resault3_op = _T_45_op; //@ demo_method_sel.py:40
    assign _T_91 = (s == 2'h0); //@ demo_method_sel.py:43
    assign _T_92 = (s == 2'h1); //@ demo_method_sel.py:43
    assign _T_93 = (s == 2'h2); //@ demo_method_sel.py:43
    assign _T_94 = (s == 2'h3); //@ demo_method_sel.py:43
    assign _T_95 = {_T_94, _T_93}; //@ demo_method_sel.py:43
    assign _T_96 = {_T_95, _T_92}; //@ demo_method_sel.py:43
    assign _T_97 = {_T_96, _T_91}; //@ demo_method_sel.py:43
    assign _T_98 = _T_97[0]; //@ demo_method_sel.py:45
    assign _T_99 = {4'h8{_T_98}}; //@ demo_method_sel.py:45
    assign _T_100 = (_T_99 & a); //@ demo_method_sel.py:45
    assign _T_101 = _T_97[1]; //@ demo_method_sel.py:45
    assign _T_102 = {4'h8{_T_101}}; //@ demo_method_sel.py:45
    assign _T_103 = (_T_102 & b); //@ demo_method_sel.py:45
    assign _T_104 = (_T_100 | _T_103); //@ demo_method_sel.py:45
    assign _T_105 = _T_97[2]; //@ demo_method_sel.py:45
    assign _T_106 = {4'h8{_T_105}}; //@ demo_method_sel.py:45
    assign _T_107 = (_T_106 & c); //@ demo_method_sel.py:45
    assign _T_108 = (_T_104 | _T_107); //@ demo_method_sel.py:45
    assign _T_109 = _T_97[3]; //@ demo_method_sel.py:45
    assign _T_110 = {4'h8{_T_109}}; //@ demo_method_sel.py:45
    assign _T_111 = (_T_110 & d); //@ demo_method_sel.py:45
    assign _T_112 = (_T_108 | _T_111); //@ demo_method_sel.py:45
    assign resault4 = _T_112; //@ demo_method_sel.py:45
    assign _T_113 = (s_key == 10'h0); //@ demo_method_sel.py:51
    assign _T_114 = (s_key == 10'h2); //@ demo_method_sel.py:51
    assign _T_115 = (s_key == 10'h3); //@ demo_method_sel.py:51
    assign _T_116 = (s_key == 10'h5); //@ demo_method_sel.py:51
    assign _T_117 = (_T_116 ? d : 8'h0); //@ demo_method_sel.py:51
    assign _T_118 = (_T_115 ? c : _T_117); //@ demo_method_sel.py:51
    assign _T_119 = (_T_114 ? b : _T_118); //@ demo_method_sel.py:51
    assign _T_120 = (_T_113 ? a : _T_119); //@ demo_method_sel.py:51
    assign resault5 = _T_120; //@ demo_method_sel.py:51
endmodule
