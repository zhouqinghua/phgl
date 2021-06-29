module method_vhex_read_top(
    input  wire  io_in0, //@ demo_method_vhex_read.py:6
    input  wire  io_in1, //@ demo_method_vhex_read.py:7
    output wire  io_out, //@ demo_method_vhex_read.py:8
    input  wire  clock, //@ phgl_generator.py:85
    input  wire  reset  //@ phgl_generator.py:85
);
    wire [31:0] rom0_0; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_1; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_2; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_3; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_4; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_5; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_6; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_7; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_8; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_9; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_10; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_11; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_12; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_13; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_14; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_15; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_16; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_17; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_18; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_19; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_20; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_21; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_22; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_23; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_24; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_25; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_26; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_27; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_28; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_29; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_30; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_31; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_32; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_33; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_34; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_35; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_36; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_37; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_38; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_39; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_40; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_41; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_42; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_43; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_44; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_45; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_46; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_47; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_48; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_49; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_50; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_51; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_52; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_53; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_54; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_55; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_56; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_57; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_58; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_59; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_60; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_61; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_62; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_63; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_64; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_65; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_66; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_67; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_68; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_69; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_70; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_71; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_72; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_73; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_74; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_75; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_76; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_77; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_78; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_79; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_80; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_81; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_82; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_83; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_84; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_85; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_86; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_87; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_88; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_89; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_90; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_91; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_92; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_93; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_94; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_95; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_96; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_97; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_98; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_99; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_100; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_101; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_102; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_103; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_104; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_105; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_106; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_107; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_108; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_109; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_110; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_111; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_112; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_113; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_114; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_115; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_116; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_117; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_118; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_119; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_120; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_121; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_122; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_123; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_124; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_125; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_126; //@ demo_method_vhex_read.py:13
    wire [31:0] rom0_127; //@ demo_method_vhex_read.py:13
    assign rom0_0 = 32'h5a5a0000; //@ demo_method_vhex_read.py:21
    assign rom0_1 = 32'h5a5a0001; //@ demo_method_vhex_read.py:21
    assign rom0_2 = 32'h5a5a0002; //@ demo_method_vhex_read.py:21
    assign rom0_3 = 32'h5a5a0003; //@ demo_method_vhex_read.py:21
    assign rom0_4 = 32'h5a5a0004; //@ demo_method_vhex_read.py:21
    assign rom0_5 = 32'h5a5a0005; //@ demo_method_vhex_read.py:21
    assign rom0_6 = 32'h5a5a0006; //@ demo_method_vhex_read.py:21
    assign rom0_7 = 32'h5a5a0007; //@ demo_method_vhex_read.py:21
    assign rom0_16 = 32'h5a5a0010; //@ demo_method_vhex_read.py:25
    assign rom0_17 = 32'h5a5a0011; //@ demo_method_vhex_read.py:25
    assign rom0_18 = 32'h5a5a0012; //@ demo_method_vhex_read.py:25
    assign rom0_19 = 32'h5a5a0013; //@ demo_method_vhex_read.py:25
    assign rom0_32 = 32'h5a5a0020; //@ demo_method_vhex_read.py:25
    assign rom0_33 = 32'h5a5a0021; //@ demo_method_vhex_read.py:25
    assign rom0_34 = 32'h5a5a0022; //@ demo_method_vhex_read.py:25
    assign rom0_35 = 32'h5a5a0023; //@ demo_method_vhex_read.py:25
    assign rom0_48 = 32'h5a5a0030; //@ demo_method_vhex_read.py:29
    assign rom0_49 = 32'h5a5a0031; //@ demo_method_vhex_read.py:29
    assign rom0_50 = 32'h5a5a0032; //@ demo_method_vhex_read.py:29
    assign rom0_51 = 32'h5a5a0033; //@ demo_method_vhex_read.py:29
    assign rom0_52 = 32'h0; //@ demo_method_vhex_read.py:29
    assign rom0_53 = 32'h0; //@ demo_method_vhex_read.py:29
    assign rom0_54 = 32'h0; //@ demo_method_vhex_read.py:29
    assign rom0_55 = 32'h0; //@ demo_method_vhex_read.py:29
    assign rom0_56 = 32'h0; //@ demo_method_vhex_read.py:29
    assign rom0_57 = 32'h0; //@ demo_method_vhex_read.py:29
    assign rom0_58 = 32'h0; //@ demo_method_vhex_read.py:29
    assign rom0_59 = 32'h0; //@ demo_method_vhex_read.py:29
    assign rom0_60 = 32'h0; //@ demo_method_vhex_read.py:29
    assign rom0_61 = 32'h0; //@ demo_method_vhex_read.py:29
    assign rom0_62 = 32'h0; //@ demo_method_vhex_read.py:29
    assign rom0_63 = 32'h0; //@ demo_method_vhex_read.py:29
    assign rom0_64 = 32'h5a5a0040; //@ demo_method_vhex_read.py:29
    assign rom0_65 = 32'h5a5a0041; //@ demo_method_vhex_read.py:29
    assign rom0_66 = 32'h5a5a0042; //@ demo_method_vhex_read.py:29
    assign rom0_67 = 32'h5a5a0043; //@ demo_method_vhex_read.py:29
endmodule
