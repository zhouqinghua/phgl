module complex_data_type_operator_top(
    input  wire  clock, //@ phgl_generator.py:85
    input  wire  reset  //@ phgl_generator.py:85
);
    wire [99:0] tmp0; //@ demo_complex_data_type_operator.py:18
    wire [99:0] tmp1; //@ demo_complex_data_type_operator.py:19
    wire [99:0] tmp2; //@ demo_complex_data_type_operator.py:20
    wire [3:0] bd0_op; //@ demo_complex_data_type_operator.py:6
    wire [31:0] bd0_oprand0; //@ demo_complex_data_type_operator.py:7
    wire [31:0] bd0_oprand1; //@ demo_complex_data_type_operator.py:8
    wire [31:0] bd0_resault; //@ demo_complex_data_type_operator.py:9
    wire [3:0] bd1_op; //@ demo_complex_data_type_operator.py:6
    wire [31:0] bd1_oprand0; //@ demo_complex_data_type_operator.py:7
    wire [31:0] bd1_oprand1; //@ demo_complex_data_type_operator.py:8
    wire [31:0] bd1_resault; //@ demo_complex_data_type_operator.py:9
    wire [3:0] vec0_0_op; //@ demo_complex_data_type_operator.py:6
    wire [31:0] vec0_0_oprand0; //@ demo_complex_data_type_operator.py:7
    wire [31:0] vec0_0_oprand1; //@ demo_complex_data_type_operator.py:8
    wire [31:0] vec0_0_resault; //@ demo_complex_data_type_operator.py:9
    wire [3:0] vec0_1_op; //@ demo_complex_data_type_operator.py:6
    wire [31:0] vec0_1_oprand0; //@ demo_complex_data_type_operator.py:7
    wire [31:0] vec0_1_oprand1; //@ demo_complex_data_type_operator.py:8
    wire [31:0] vec0_1_resault; //@ demo_complex_data_type_operator.py:9
    wire [3:0] vec0_2_op; //@ demo_complex_data_type_operator.py:6
    wire [31:0] vec0_2_oprand0; //@ demo_complex_data_type_operator.py:7
    wire [31:0] vec0_2_oprand1; //@ demo_complex_data_type_operator.py:8
    wire [31:0] vec0_2_resault; //@ demo_complex_data_type_operator.py:9
    wire [3:0] vec0_3_op; //@ demo_complex_data_type_operator.py:6
    wire [31:0] vec0_3_oprand0; //@ demo_complex_data_type_operator.py:7
    wire [31:0] vec0_3_oprand1; //@ demo_complex_data_type_operator.py:8
    wire [31:0] vec0_3_resault; //@ demo_complex_data_type_operator.py:9
    wire [1:0] vec0_idx; //@ demo_complex_data_type_operator.py:24
    wire [31:0] _T_0; //@ demo_complex_data_type_operator.py:28
    wire [31:0] _T_1; //@ demo_complex_data_type_operator.py:28
    wire [31:0] _T_2; //@ demo_complex_data_type_operator.py:28
    wire [3:0] _T_3; //@ demo_complex_data_type_operator.py:28
    wire [35:0] _T_4; //@ demo_complex_data_type_operator.py:31
    wire [67:0] _T_5; //@ demo_complex_data_type_operator.py:31
    wire [99:0] _T_6; //@ demo_complex_data_type_operator.py:31
    wire [35:0] _T_7; //@ demo_complex_data_type_operator.py:37
    wire [67:0] _T_8; //@ demo_complex_data_type_operator.py:37
    wire [99:0] _T_9; //@ demo_complex_data_type_operator.py:37
    wire [35:0] _T_10; //@ demo_complex_data_type_operator.py:37
    wire [67:0] _T_11; //@ demo_complex_data_type_operator.py:37
    wire [99:0] _T_12; //@ demo_complex_data_type_operator.py:37
    wire [99:0] _T_13; //@ demo_complex_data_type_operator.py:37
    wire [3:0] _T_14_op; //@ demo_complex_data_type_operator.py:6
    wire [31:0] _T_14_oprand0; //@ demo_complex_data_type_operator.py:7
    wire [31:0] _T_14_oprand1; //@ demo_complex_data_type_operator.py:8
    wire [31:0] _T_14_resault; //@ demo_complex_data_type_operator.py:9
    wire  _T_15; //@ demo_complex_data_type_operator.py:41
    wire [3:0] _T_16; //@ demo_complex_data_type_operator.py:41
    wire [3:0] _T_17; //@ demo_complex_data_type_operator.py:41
    wire  _T_18; //@ demo_complex_data_type_operator.py:41
    wire [3:0] _T_19; //@ demo_complex_data_type_operator.py:41
    wire [3:0] _T_20; //@ demo_complex_data_type_operator.py:41
    wire [3:0] _T_21; //@ demo_complex_data_type_operator.py:41
    wire  _T_22; //@ demo_complex_data_type_operator.py:41
    wire [3:0] _T_23; //@ demo_complex_data_type_operator.py:41
    wire [3:0] _T_24; //@ demo_complex_data_type_operator.py:41
    wire [3:0] _T_25; //@ demo_complex_data_type_operator.py:41
    wire  _T_26; //@ demo_complex_data_type_operator.py:41
    wire [3:0] _T_27; //@ demo_complex_data_type_operator.py:41
    wire [3:0] _T_28; //@ demo_complex_data_type_operator.py:41
    wire [3:0] _T_29; //@ demo_complex_data_type_operator.py:41
    wire  _T_30; //@ demo_complex_data_type_operator.py:41
    wire [31:0] _T_31; //@ demo_complex_data_type_operator.py:41
    wire [31:0] _T_32; //@ demo_complex_data_type_operator.py:41
    wire  _T_33; //@ demo_complex_data_type_operator.py:41
    wire [31:0] _T_34; //@ demo_complex_data_type_operator.py:41
    wire [31:0] _T_35; //@ demo_complex_data_type_operator.py:41
    wire [31:0] _T_36; //@ demo_complex_data_type_operator.py:41
    wire  _T_37; //@ demo_complex_data_type_operator.py:41
    wire [31:0] _T_38; //@ demo_complex_data_type_operator.py:41
    wire [31:0] _T_39; //@ demo_complex_data_type_operator.py:41
    wire [31:0] _T_40; //@ demo_complex_data_type_operator.py:41
    wire  _T_41; //@ demo_complex_data_type_operator.py:41
    wire [31:0] _T_42; //@ demo_complex_data_type_operator.py:41
    wire [31:0] _T_43; //@ demo_complex_data_type_operator.py:41
    wire [31:0] _T_44; //@ demo_complex_data_type_operator.py:41
    wire  _T_45; //@ demo_complex_data_type_operator.py:41
    wire [31:0] _T_46; //@ demo_complex_data_type_operator.py:41
    wire [31:0] _T_47; //@ demo_complex_data_type_operator.py:41
    wire  _T_48; //@ demo_complex_data_type_operator.py:41
    wire [31:0] _T_49; //@ demo_complex_data_type_operator.py:41
    wire [31:0] _T_50; //@ demo_complex_data_type_operator.py:41
    wire [31:0] _T_51; //@ demo_complex_data_type_operator.py:41
    wire  _T_52; //@ demo_complex_data_type_operator.py:41
    wire [31:0] _T_53; //@ demo_complex_data_type_operator.py:41
    wire [31:0] _T_54; //@ demo_complex_data_type_operator.py:41
    wire [31:0] _T_55; //@ demo_complex_data_type_operator.py:41
    wire  _T_56; //@ demo_complex_data_type_operator.py:41
    wire [31:0] _T_57; //@ demo_complex_data_type_operator.py:41
    wire [31:0] _T_58; //@ demo_complex_data_type_operator.py:41
    wire [31:0] _T_59; //@ demo_complex_data_type_operator.py:41
    wire  _T_60; //@ demo_complex_data_type_operator.py:41
    wire [31:0] _T_61; //@ demo_complex_data_type_operator.py:41
    wire [31:0] _T_62; //@ demo_complex_data_type_operator.py:41
    wire  _T_63; //@ demo_complex_data_type_operator.py:41
    wire [31:0] _T_64; //@ demo_complex_data_type_operator.py:41
    wire [31:0] _T_65; //@ demo_complex_data_type_operator.py:41
    wire [31:0] _T_66; //@ demo_complex_data_type_operator.py:41
    wire  _T_67; //@ demo_complex_data_type_operator.py:41
    wire [31:0] _T_68; //@ demo_complex_data_type_operator.py:41
    wire [31:0] _T_69; //@ demo_complex_data_type_operator.py:41
    wire [31:0] _T_70; //@ demo_complex_data_type_operator.py:41
    wire  _T_71; //@ demo_complex_data_type_operator.py:41
    wire [31:0] _T_72; //@ demo_complex_data_type_operator.py:41
    wire [31:0] _T_73; //@ demo_complex_data_type_operator.py:41
    wire [31:0] _T_74; //@ demo_complex_data_type_operator.py:41
    wire  _T_75; //@ demo_complex_data_type_operator.py:45
    wire [31:0] _T_76; //@ demo_complex_data_type_operator.py:45
    wire [31:0] _T_77; //@ demo_complex_data_type_operator.py:45
    wire [31:0] _T_78; //@ demo_complex_data_type_operator.py:45
    wire [31:0] _T_79; //@ demo_complex_data_type_operator.py:45
    wire [31:0] _T_80; //@ demo_complex_data_type_operator.py:45
    wire [31:0] _T_81; //@ demo_complex_data_type_operator.py:45
    wire [3:0] _T_82; //@ demo_complex_data_type_operator.py:45
    wire [3:0] _T_83; //@ demo_complex_data_type_operator.py:45
    wire  _T_84; //@ demo_complex_data_type_operator.py:45
    wire [31:0] _T_85; //@ demo_complex_data_type_operator.py:45
    wire [31:0] _T_86; //@ demo_complex_data_type_operator.py:45
    wire [31:0] _T_87; //@ demo_complex_data_type_operator.py:45
    wire [31:0] _T_88; //@ demo_complex_data_type_operator.py:45
    wire [31:0] _T_89; //@ demo_complex_data_type_operator.py:45
    wire [31:0] _T_90; //@ demo_complex_data_type_operator.py:45
    wire [3:0] _T_91; //@ demo_complex_data_type_operator.py:45
    wire [3:0] _T_92; //@ demo_complex_data_type_operator.py:45
    wire  _T_93; //@ demo_complex_data_type_operator.py:45
    wire [31:0] _T_94; //@ demo_complex_data_type_operator.py:45
    wire [31:0] _T_95; //@ demo_complex_data_type_operator.py:45
    wire [31:0] _T_96; //@ demo_complex_data_type_operator.py:45
    wire [31:0] _T_97; //@ demo_complex_data_type_operator.py:45
    wire [31:0] _T_98; //@ demo_complex_data_type_operator.py:45
    wire [31:0] _T_99; //@ demo_complex_data_type_operator.py:45
    wire [3:0] _T_100; //@ demo_complex_data_type_operator.py:45
    wire [3:0] _T_101; //@ demo_complex_data_type_operator.py:45
    wire  _T_102; //@ demo_complex_data_type_operator.py:45
    wire [31:0] _T_103; //@ demo_complex_data_type_operator.py:45
    wire [31:0] _T_104; //@ demo_complex_data_type_operator.py:45
    wire [31:0] _T_105; //@ demo_complex_data_type_operator.py:45
    wire [31:0] _T_106; //@ demo_complex_data_type_operator.py:45
    wire [31:0] _T_107; //@ demo_complex_data_type_operator.py:45
    wire [31:0] _T_108; //@ demo_complex_data_type_operator.py:45
    wire [3:0] _T_109; //@ demo_complex_data_type_operator.py:45
    wire [3:0] _T_110; //@ demo_complex_data_type_operator.py:45
    assign tmp0 = 100'h10000000055555555aaaaaaaa; //@ demo_complex_data_type_operator.py:18
    assign _T_0 = tmp0[31:0]; //@ demo_complex_data_type_operator.py:28
//    assign bd0_resault = _T_0; //@ demo_complex_data_type_operator.py:28
    assign _T_1 = tmp0[63:32]; //@ demo_complex_data_type_operator.py:28
//    assign bd0_oprand1 = _T_1; //@ demo_complex_data_type_operator.py:28
    assign _T_2 = tmp0[95:64]; //@ demo_complex_data_type_operator.py:28
//    assign bd0_oprand0 = _T_2; //@ demo_complex_data_type_operator.py:28
    assign _T_3 = tmp0[99:96]; //@ demo_complex_data_type_operator.py:28
//    assign bd0_op = _T_3; //@ demo_complex_data_type_operator.py:28
    assign _T_4 = {bd0_op, bd0_oprand0}; //@ demo_complex_data_type_operator.py:31
    assign _T_5 = {_T_4, bd0_oprand1}; //@ demo_complex_data_type_operator.py:31
    assign _T_6 = {_T_5, bd0_resault}; //@ demo_complex_data_type_operator.py:31
    assign tmp1 = _T_6; //@ demo_complex_data_type_operator.py:31
//    assign bd0_resault = bd1_resault; //@ demo_complex_data_type_operator.py:34
//    assign bd0_oprand1 = bd1_oprand1; //@ demo_complex_data_type_operator.py:34
//    assign bd0_oprand0 = bd1_oprand0; //@ demo_complex_data_type_operator.py:34
//    assign bd0_op = bd1_op; //@ demo_complex_data_type_operator.py:34
    assign _T_7 = {bd0_op, bd0_oprand0}; //@ demo_complex_data_type_operator.py:37
    assign _T_8 = {_T_7, bd0_oprand1}; //@ demo_complex_data_type_operator.py:37
    assign _T_9 = {_T_8, bd0_resault}; //@ demo_complex_data_type_operator.py:37
    assign _T_10 = {bd1_op, bd1_oprand0}; //@ demo_complex_data_type_operator.py:37
    assign _T_11 = {_T_10, bd1_oprand1}; //@ demo_complex_data_type_operator.py:37
    assign _T_12 = {_T_11, bd1_resault}; //@ demo_complex_data_type_operator.py:37
    assign _T_13 = (_T_9 & _T_12); //@ demo_complex_data_type_operator.py:37
    assign tmp2 = _T_13; //@ demo_complex_data_type_operator.py:37
    assign bd0_resault = vec0_0_resault; //@ demo_complex_data_type_operator.py:40
    assign bd0_oprand1 = vec0_0_oprand1; //@ demo_complex_data_type_operator.py:40
    assign bd0_oprand0 = vec0_0_oprand0; //@ demo_complex_data_type_operator.py:40
    assign bd0_op = vec0_0_op; //@ demo_complex_data_type_operator.py:40
    assign _T_15 = (vec0_idx == 2'h0); //@ demo_complex_data_type_operator.py:41
    assign _T_16 = {3'h4{_T_15}}; //@ demo_complex_data_type_operator.py:41
    assign _T_17 = (_T_16 & vec0_0_op); //@ demo_complex_data_type_operator.py:41
    assign _T_18 = (vec0_idx == 2'h1); //@ demo_complex_data_type_operator.py:41
    assign _T_19 = {3'h4{_T_18}}; //@ demo_complex_data_type_operator.py:41
    assign _T_20 = (_T_19 & vec0_1_op); //@ demo_complex_data_type_operator.py:41
    assign _T_21 = (_T_17 | _T_20); //@ demo_complex_data_type_operator.py:41
    assign _T_22 = (vec0_idx == 2'h2); //@ demo_complex_data_type_operator.py:41
    assign _T_23 = {3'h4{_T_22}}; //@ demo_complex_data_type_operator.py:41
    assign _T_24 = (_T_23 & vec0_2_op); //@ demo_complex_data_type_operator.py:41
    assign _T_25 = (_T_21 | _T_24); //@ demo_complex_data_type_operator.py:41
    assign _T_26 = (vec0_idx == 2'h3); //@ demo_complex_data_type_operator.py:41
    assign _T_27 = {3'h4{_T_26}}; //@ demo_complex_data_type_operator.py:41
    assign _T_28 = (_T_27 & vec0_3_op); //@ demo_complex_data_type_operator.py:41
    assign _T_29 = (_T_25 | _T_28); //@ demo_complex_data_type_operator.py:41
    assign _T_14_op = _T_29; //@ demo_complex_data_type_operator.py:41
    assign _T_30 = (vec0_idx == 2'h0); //@ demo_complex_data_type_operator.py:41
    assign _T_31 = {6'h20{_T_30}}; //@ demo_complex_data_type_operator.py:41
    assign _T_32 = (_T_31 & vec0_0_oprand0); //@ demo_complex_data_type_operator.py:41
    assign _T_33 = (vec0_idx == 2'h1); //@ demo_complex_data_type_operator.py:41
    assign _T_34 = {6'h20{_T_33}}; //@ demo_complex_data_type_operator.py:41
    assign _T_35 = (_T_34 & vec0_1_oprand0); //@ demo_complex_data_type_operator.py:41
    assign _T_36 = (_T_32 | _T_35); //@ demo_complex_data_type_operator.py:41
    assign _T_37 = (vec0_idx == 2'h2); //@ demo_complex_data_type_operator.py:41
    assign _T_38 = {6'h20{_T_37}}; //@ demo_complex_data_type_operator.py:41
    assign _T_39 = (_T_38 & vec0_2_oprand0); //@ demo_complex_data_type_operator.py:41
    assign _T_40 = (_T_36 | _T_39); //@ demo_complex_data_type_operator.py:41
    assign _T_41 = (vec0_idx == 2'h3); //@ demo_complex_data_type_operator.py:41
    assign _T_42 = {6'h20{_T_41}}; //@ demo_complex_data_type_operator.py:41
    assign _T_43 = (_T_42 & vec0_3_oprand0); //@ demo_complex_data_type_operator.py:41
    assign _T_44 = (_T_40 | _T_43); //@ demo_complex_data_type_operator.py:41
    assign _T_14_oprand0 = _T_44; //@ demo_complex_data_type_operator.py:41
    assign _T_45 = (vec0_idx == 2'h0); //@ demo_complex_data_type_operator.py:41
    assign _T_46 = {6'h20{_T_45}}; //@ demo_complex_data_type_operator.py:41
    assign _T_47 = (_T_46 & vec0_0_oprand1); //@ demo_complex_data_type_operator.py:41
    assign _T_48 = (vec0_idx == 2'h1); //@ demo_complex_data_type_operator.py:41
    assign _T_49 = {6'h20{_T_48}}; //@ demo_complex_data_type_operator.py:41
    assign _T_50 = (_T_49 & vec0_1_oprand1); //@ demo_complex_data_type_operator.py:41
    assign _T_51 = (_T_47 | _T_50); //@ demo_complex_data_type_operator.py:41
    assign _T_52 = (vec0_idx == 2'h2); //@ demo_complex_data_type_operator.py:41
    assign _T_53 = {6'h20{_T_52}}; //@ demo_complex_data_type_operator.py:41
    assign _T_54 = (_T_53 & vec0_2_oprand1); //@ demo_complex_data_type_operator.py:41
    assign _T_55 = (_T_51 | _T_54); //@ demo_complex_data_type_operator.py:41
    assign _T_56 = (vec0_idx == 2'h3); //@ demo_complex_data_type_operator.py:41
    assign _T_57 = {6'h20{_T_56}}; //@ demo_complex_data_type_operator.py:41
    assign _T_58 = (_T_57 & vec0_3_oprand1); //@ demo_complex_data_type_operator.py:41
    assign _T_59 = (_T_55 | _T_58); //@ demo_complex_data_type_operator.py:41
    assign _T_14_oprand1 = _T_59; //@ demo_complex_data_type_operator.py:41
    assign _T_60 = (vec0_idx == 2'h0); //@ demo_complex_data_type_operator.py:41
    assign _T_61 = {6'h20{_T_60}}; //@ demo_complex_data_type_operator.py:41
    assign _T_62 = (_T_61 & vec0_0_resault); //@ demo_complex_data_type_operator.py:41
    assign _T_63 = (vec0_idx == 2'h1); //@ demo_complex_data_type_operator.py:41
    assign _T_64 = {6'h20{_T_63}}; //@ demo_complex_data_type_operator.py:41
    assign _T_65 = (_T_64 & vec0_1_resault); //@ demo_complex_data_type_operator.py:41
    assign _T_66 = (_T_62 | _T_65); //@ demo_complex_data_type_operator.py:41
    assign _T_67 = (vec0_idx == 2'h2); //@ demo_complex_data_type_operator.py:41
    assign _T_68 = {6'h20{_T_67}}; //@ demo_complex_data_type_operator.py:41
    assign _T_69 = (_T_68 & vec0_2_resault); //@ demo_complex_data_type_operator.py:41
    assign _T_70 = (_T_66 | _T_69); //@ demo_complex_data_type_operator.py:41
    assign _T_71 = (vec0_idx == 2'h3); //@ demo_complex_data_type_operator.py:41
    assign _T_72 = {6'h20{_T_71}}; //@ demo_complex_data_type_operator.py:41
    assign _T_73 = (_T_72 & vec0_3_resault); //@ demo_complex_data_type_operator.py:41
    assign _T_74 = (_T_70 | _T_73); //@ demo_complex_data_type_operator.py:41
    assign _T_14_resault = _T_74; //@ demo_complex_data_type_operator.py:41
    assign bd1_resault = _T_14_resault; //@ demo_complex_data_type_operator.py:41
    assign bd1_oprand1 = _T_14_oprand1; //@ demo_complex_data_type_operator.py:41
    assign bd1_oprand0 = _T_14_oprand0; //@ demo_complex_data_type_operator.py:41
    assign bd1_op = _T_14_op; //@ demo_complex_data_type_operator.py:41
//    assign vec0_0_resault = bd0_resault; //@ demo_complex_data_type_operator.py:44
//    assign vec0_0_oprand1 = bd0_oprand1; //@ demo_complex_data_type_operator.py:44
//    assign vec0_0_oprand0 = bd0_oprand0; //@ demo_complex_data_type_operator.py:44
//    assign vec0_0_op = bd0_op; //@ demo_complex_data_type_operator.py:44
    assign _T_75 = (vec0_idx == 2'h0); //@ demo_complex_data_type_operator.py:45
    assign _T_77 = (_T_75 ? bd1_resault : bd0_resault); //@ demo_complex_data_type_operator.py:45
    assign _T_76 = _T_77; //@ demo_complex_data_type_operator.py:45
    assign vec0_0_resault = _T_76; //@ demo_complex_data_type_operator.py:45
    assign _T_79 = (_T_75 ? bd1_oprand1 : bd0_oprand1); //@ demo_complex_data_type_operator.py:45
    assign _T_78 = _T_79; //@ demo_complex_data_type_operator.py:45
    assign vec0_0_oprand1 = _T_78; //@ demo_complex_data_type_operator.py:45
    assign _T_81 = (_T_75 ? bd1_oprand0 : bd0_oprand0); //@ demo_complex_data_type_operator.py:45
    assign _T_80 = _T_81; //@ demo_complex_data_type_operator.py:45
    assign vec0_0_oprand0 = _T_80; //@ demo_complex_data_type_operator.py:45
    assign _T_83 = (_T_75 ? bd1_op : bd0_op); //@ demo_complex_data_type_operator.py:45
    assign _T_82 = _T_83; //@ demo_complex_data_type_operator.py:45
    assign vec0_0_op = _T_82; //@ demo_complex_data_type_operator.py:45
    assign _T_84 = (vec0_idx == 2'h1); //@ demo_complex_data_type_operator.py:45
    assign _T_86 = (_T_84 ? bd1_resault : bd1_resault); //@ demo_complex_data_type_operator.py:45
    assign _T_85 = _T_86; //@ demo_complex_data_type_operator.py:45
    assign vec0_1_resault = _T_85; //@ demo_complex_data_type_operator.py:45
    assign _T_88 = (_T_84 ? bd1_oprand1 : bd1_oprand1); //@ demo_complex_data_type_operator.py:45
    assign _T_87 = _T_88; //@ demo_complex_data_type_operator.py:45
    assign vec0_1_oprand1 = _T_87; //@ demo_complex_data_type_operator.py:45
    assign _T_90 = (_T_84 ? bd1_oprand0 : bd1_oprand0); //@ demo_complex_data_type_operator.py:45
    assign _T_89 = _T_90; //@ demo_complex_data_type_operator.py:45
    assign vec0_1_oprand0 = _T_89; //@ demo_complex_data_type_operator.py:45
    assign _T_92 = (_T_84 ? bd1_op : bd1_op); //@ demo_complex_data_type_operator.py:45
    assign _T_91 = _T_92; //@ demo_complex_data_type_operator.py:45
    assign vec0_1_op = _T_91; //@ demo_complex_data_type_operator.py:45
    assign _T_93 = (vec0_idx == 2'h2); //@ demo_complex_data_type_operator.py:45
    assign _T_95 = (_T_93 ? bd1_resault : bd1_resault); //@ demo_complex_data_type_operator.py:45
    assign _T_94 = _T_95; //@ demo_complex_data_type_operator.py:45
    assign vec0_2_resault = _T_94; //@ demo_complex_data_type_operator.py:45
    assign _T_97 = (_T_93 ? bd1_oprand1 : bd1_oprand1); //@ demo_complex_data_type_operator.py:45
    assign _T_96 = _T_97; //@ demo_complex_data_type_operator.py:45
    assign vec0_2_oprand1 = _T_96; //@ demo_complex_data_type_operator.py:45
    assign _T_99 = (_T_93 ? bd1_oprand0 : bd1_oprand0); //@ demo_complex_data_type_operator.py:45
    assign _T_98 = _T_99; //@ demo_complex_data_type_operator.py:45
    assign vec0_2_oprand0 = _T_98; //@ demo_complex_data_type_operator.py:45
    assign _T_101 = (_T_93 ? bd1_op : bd1_op); //@ demo_complex_data_type_operator.py:45
    assign _T_100 = _T_101; //@ demo_complex_data_type_operator.py:45
    assign vec0_2_op = _T_100; //@ demo_complex_data_type_operator.py:45
    assign _T_102 = (vec0_idx == 2'h3); //@ demo_complex_data_type_operator.py:45
    assign _T_104 = (_T_102 ? bd1_resault : bd1_resault); //@ demo_complex_data_type_operator.py:45
    assign _T_103 = _T_104; //@ demo_complex_data_type_operator.py:45
    assign vec0_3_resault = _T_103; //@ demo_complex_data_type_operator.py:45
    assign _T_106 = (_T_102 ? bd1_oprand1 : bd1_oprand1); //@ demo_complex_data_type_operator.py:45
    assign _T_105 = _T_106; //@ demo_complex_data_type_operator.py:45
    assign vec0_3_oprand1 = _T_105; //@ demo_complex_data_type_operator.py:45
    assign _T_108 = (_T_102 ? bd1_oprand0 : bd1_oprand0); //@ demo_complex_data_type_operator.py:45
    assign _T_107 = _T_108; //@ demo_complex_data_type_operator.py:45
    assign vec0_3_oprand0 = _T_107; //@ demo_complex_data_type_operator.py:45
    assign _T_110 = (_T_102 ? bd1_op : bd1_op); //@ demo_complex_data_type_operator.py:45
    assign _T_109 = _T_110; //@ demo_complex_data_type_operator.py:45
    assign vec0_3_op = _T_109; //@ demo_complex_data_type_operator.py:45
endmodule
