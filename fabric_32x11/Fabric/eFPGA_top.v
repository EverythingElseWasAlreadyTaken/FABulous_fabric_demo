module eFPGA_top
    #(
        parameter include_eFPGA=1,
        parameter NumberOfRows=10,
        parameter NumberOfCols=32,
        parameter FrameBitsPerRow=32,
        parameter MaxFramesPerCol=20,
        parameter desync_flag=20,
        parameter FrameSelectWidth=5,
        parameter RowSelectWidth=5
    )
    (
        //External IO port
        output  [27:0] NIO_I_top,
        input  [27:0] NIO_O_top,
        //Config related ports
        input  CLK,
        input  resetn,
        input  SelfWriteStrobe,
        input  [31:0] SelfWriteData,
        input  Rx,
        output  ComActive,
        output  ReceiveLED,
        input  s_clk,
        input  s_data
);

 //Signal declarations
wire[(NumberOfRows*FrameBitsPerRow)-1:0] FrameRegister;
wire[(MaxFramesPerCol*NumberOfCols)-1:0] FrameSelect;
wire[(FrameBitsPerRow*(NumberOfRows+2))-1:0] FrameData;
wire[FrameBitsPerRow-1:0] FrameAddressRegister;
wire LongFrameStrobe;
wire[31:0] LocalWriteData;
wire LocalWriteStrobe;
wire[RowSelectWidth-1:0] RowSelect;
`ifndef EMULATION

eFPGA_Config
    #(
    .RowSelectWidth(RowSelectWidth),
    .NumberOfRows(NumberOfRows),
    .desync_flag(desync_flag),
    .FrameBitsPerRow(FrameBitsPerRow)
    )
    eFPGA_Config_inst
    (
    .CLK(CLK),
    .resetn(resetn),
    .Rx(Rx),
    .ComActive(ComActive),
    .ReceiveLED(ReceiveLED),
    .s_clk(s_clk),
    .s_data(s_data),
    .SelfWriteData(SelfWriteData),
    .SelfWriteStrobe(SelfWriteStrobe),
    .ConfigWriteData(LocalWriteData),
    .ConfigWriteStrobe(LocalWriteStrobe),
    .FrameAddressRegister(FrameAddressRegister),
    .LongFrameStrobe(LongFrameStrobe),
    .RowSelect(RowSelect)
);


Frame_Data_Reg
    #(
    .FrameBitsPerRow(FrameBitsPerRow),
    .RowSelectWidth(RowSelectWidth),
    .Row(1)
    )
    inst_Frame_Data_Reg_0
    (
    .FrameData_I(LocalWriteData),
    .FrameData_O(FrameRegister[0*FrameBitsPerRow+FrameBitsPerRow-1:0*FrameBitsPerRow]),
    .RowSelect(RowSelect),
    .CLK(CLK)
);

Frame_Data_Reg
    #(
    .FrameBitsPerRow(FrameBitsPerRow),
    .RowSelectWidth(RowSelectWidth),
    .Row(2)
    )
    inst_Frame_Data_Reg_1
    (
    .FrameData_I(LocalWriteData),
    .FrameData_O(FrameRegister[1*FrameBitsPerRow+FrameBitsPerRow-1:1*FrameBitsPerRow]),
    .RowSelect(RowSelect),
    .CLK(CLK)
);

Frame_Data_Reg
    #(
    .FrameBitsPerRow(FrameBitsPerRow),
    .RowSelectWidth(RowSelectWidth),
    .Row(3)
    )
    inst_Frame_Data_Reg_2
    (
    .FrameData_I(LocalWriteData),
    .FrameData_O(FrameRegister[2*FrameBitsPerRow+FrameBitsPerRow-1:2*FrameBitsPerRow]),
    .RowSelect(RowSelect),
    .CLK(CLK)
);

Frame_Data_Reg
    #(
    .FrameBitsPerRow(FrameBitsPerRow),
    .RowSelectWidth(RowSelectWidth),
    .Row(4)
    )
    inst_Frame_Data_Reg_3
    (
    .FrameData_I(LocalWriteData),
    .FrameData_O(FrameRegister[3*FrameBitsPerRow+FrameBitsPerRow-1:3*FrameBitsPerRow]),
    .RowSelect(RowSelect),
    .CLK(CLK)
);

Frame_Data_Reg
    #(
    .FrameBitsPerRow(FrameBitsPerRow),
    .RowSelectWidth(RowSelectWidth),
    .Row(5)
    )
    inst_Frame_Data_Reg_4
    (
    .FrameData_I(LocalWriteData),
    .FrameData_O(FrameRegister[4*FrameBitsPerRow+FrameBitsPerRow-1:4*FrameBitsPerRow]),
    .RowSelect(RowSelect),
    .CLK(CLK)
);

Frame_Data_Reg
    #(
    .FrameBitsPerRow(FrameBitsPerRow),
    .RowSelectWidth(RowSelectWidth),
    .Row(6)
    )
    inst_Frame_Data_Reg_5
    (
    .FrameData_I(LocalWriteData),
    .FrameData_O(FrameRegister[5*FrameBitsPerRow+FrameBitsPerRow-1:5*FrameBitsPerRow]),
    .RowSelect(RowSelect),
    .CLK(CLK)
);

Frame_Data_Reg
    #(
    .FrameBitsPerRow(FrameBitsPerRow),
    .RowSelectWidth(RowSelectWidth),
    .Row(7)
    )
    inst_Frame_Data_Reg_6
    (
    .FrameData_I(LocalWriteData),
    .FrameData_O(FrameRegister[6*FrameBitsPerRow+FrameBitsPerRow-1:6*FrameBitsPerRow]),
    .RowSelect(RowSelect),
    .CLK(CLK)
);

Frame_Data_Reg
    #(
    .FrameBitsPerRow(FrameBitsPerRow),
    .RowSelectWidth(RowSelectWidth),
    .Row(8)
    )
    inst_Frame_Data_Reg_7
    (
    .FrameData_I(LocalWriteData),
    .FrameData_O(FrameRegister[7*FrameBitsPerRow+FrameBitsPerRow-1:7*FrameBitsPerRow]),
    .RowSelect(RowSelect),
    .CLK(CLK)
);

Frame_Data_Reg
    #(
    .FrameBitsPerRow(FrameBitsPerRow),
    .RowSelectWidth(RowSelectWidth),
    .Row(9)
    )
    inst_Frame_Data_Reg_8
    (
    .FrameData_I(LocalWriteData),
    .FrameData_O(FrameRegister[8*FrameBitsPerRow+FrameBitsPerRow-1:8*FrameBitsPerRow]),
    .RowSelect(RowSelect),
    .CLK(CLK)
);

Frame_Data_Reg
    #(
    .FrameBitsPerRow(FrameBitsPerRow),
    .RowSelectWidth(RowSelectWidth),
    .Row(10)
    )
    inst_Frame_Data_Reg_9
    (
    .FrameData_I(LocalWriteData),
    .FrameData_O(FrameRegister[9*FrameBitsPerRow+FrameBitsPerRow-1:9*FrameBitsPerRow]),
    .RowSelect(RowSelect),
    .CLK(CLK)
);


Frame_Select
    #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameSelectWidth(FrameSelectWidth),
    .Col(0)
    )
    inst_Frame_Select_0
    (
    .FrameStrobe_I(FrameAddressRegister[MaxFramesPerCol-1:0]),
    .FrameStrobe_O(FrameSelect[0*MaxFramesPerCol+MaxFramesPerCol-1:0*MaxFramesPerCol]),
    .FrameSelect(FrameAddressRegister[FrameBitsPerRow-1:FrameBitsPerRow-FrameSelectWidth]),
    .FrameStrobe(LongFrameStrobe)
);

Frame_Select
    #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameSelectWidth(FrameSelectWidth),
    .Col(1)
    )
    inst_Frame_Select_1
    (
    .FrameStrobe_I(FrameAddressRegister[MaxFramesPerCol-1:0]),
    .FrameStrobe_O(FrameSelect[1*MaxFramesPerCol+MaxFramesPerCol-1:1*MaxFramesPerCol]),
    .FrameSelect(FrameAddressRegister[FrameBitsPerRow-1:FrameBitsPerRow-FrameSelectWidth]),
    .FrameStrobe(LongFrameStrobe)
);

Frame_Select
    #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameSelectWidth(FrameSelectWidth),
    .Col(2)
    )
    inst_Frame_Select_2
    (
    .FrameStrobe_I(FrameAddressRegister[MaxFramesPerCol-1:0]),
    .FrameStrobe_O(FrameSelect[2*MaxFramesPerCol+MaxFramesPerCol-1:2*MaxFramesPerCol]),
    .FrameSelect(FrameAddressRegister[FrameBitsPerRow-1:FrameBitsPerRow-FrameSelectWidth]),
    .FrameStrobe(LongFrameStrobe)
);

Frame_Select
    #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameSelectWidth(FrameSelectWidth),
    .Col(3)
    )
    inst_Frame_Select_3
    (
    .FrameStrobe_I(FrameAddressRegister[MaxFramesPerCol-1:0]),
    .FrameStrobe_O(FrameSelect[3*MaxFramesPerCol+MaxFramesPerCol-1:3*MaxFramesPerCol]),
    .FrameSelect(FrameAddressRegister[FrameBitsPerRow-1:FrameBitsPerRow-FrameSelectWidth]),
    .FrameStrobe(LongFrameStrobe)
);

Frame_Select
    #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameSelectWidth(FrameSelectWidth),
    .Col(4)
    )
    inst_Frame_Select_4
    (
    .FrameStrobe_I(FrameAddressRegister[MaxFramesPerCol-1:0]),
    .FrameStrobe_O(FrameSelect[4*MaxFramesPerCol+MaxFramesPerCol-1:4*MaxFramesPerCol]),
    .FrameSelect(FrameAddressRegister[FrameBitsPerRow-1:FrameBitsPerRow-FrameSelectWidth]),
    .FrameStrobe(LongFrameStrobe)
);

Frame_Select
    #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameSelectWidth(FrameSelectWidth),
    .Col(5)
    )
    inst_Frame_Select_5
    (
    .FrameStrobe_I(FrameAddressRegister[MaxFramesPerCol-1:0]),
    .FrameStrobe_O(FrameSelect[5*MaxFramesPerCol+MaxFramesPerCol-1:5*MaxFramesPerCol]),
    .FrameSelect(FrameAddressRegister[FrameBitsPerRow-1:FrameBitsPerRow-FrameSelectWidth]),
    .FrameStrobe(LongFrameStrobe)
);

Frame_Select
    #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameSelectWidth(FrameSelectWidth),
    .Col(6)
    )
    inst_Frame_Select_6
    (
    .FrameStrobe_I(FrameAddressRegister[MaxFramesPerCol-1:0]),
    .FrameStrobe_O(FrameSelect[6*MaxFramesPerCol+MaxFramesPerCol-1:6*MaxFramesPerCol]),
    .FrameSelect(FrameAddressRegister[FrameBitsPerRow-1:FrameBitsPerRow-FrameSelectWidth]),
    .FrameStrobe(LongFrameStrobe)
);

Frame_Select
    #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameSelectWidth(FrameSelectWidth),
    .Col(7)
    )
    inst_Frame_Select_7
    (
    .FrameStrobe_I(FrameAddressRegister[MaxFramesPerCol-1:0]),
    .FrameStrobe_O(FrameSelect[7*MaxFramesPerCol+MaxFramesPerCol-1:7*MaxFramesPerCol]),
    .FrameSelect(FrameAddressRegister[FrameBitsPerRow-1:FrameBitsPerRow-FrameSelectWidth]),
    .FrameStrobe(LongFrameStrobe)
);

Frame_Select
    #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameSelectWidth(FrameSelectWidth),
    .Col(8)
    )
    inst_Frame_Select_8
    (
    .FrameStrobe_I(FrameAddressRegister[MaxFramesPerCol-1:0]),
    .FrameStrobe_O(FrameSelect[8*MaxFramesPerCol+MaxFramesPerCol-1:8*MaxFramesPerCol]),
    .FrameSelect(FrameAddressRegister[FrameBitsPerRow-1:FrameBitsPerRow-FrameSelectWidth]),
    .FrameStrobe(LongFrameStrobe)
);

Frame_Select
    #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameSelectWidth(FrameSelectWidth),
    .Col(9)
    )
    inst_Frame_Select_9
    (
    .FrameStrobe_I(FrameAddressRegister[MaxFramesPerCol-1:0]),
    .FrameStrobe_O(FrameSelect[9*MaxFramesPerCol+MaxFramesPerCol-1:9*MaxFramesPerCol]),
    .FrameSelect(FrameAddressRegister[FrameBitsPerRow-1:FrameBitsPerRow-FrameSelectWidth]),
    .FrameStrobe(LongFrameStrobe)
);

Frame_Select
    #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameSelectWidth(FrameSelectWidth),
    .Col(10)
    )
    inst_Frame_Select_10
    (
    .FrameStrobe_I(FrameAddressRegister[MaxFramesPerCol-1:0]),
    .FrameStrobe_O(FrameSelect[10*MaxFramesPerCol+MaxFramesPerCol-1:10*MaxFramesPerCol]),
    .FrameSelect(FrameAddressRegister[FrameBitsPerRow-1:FrameBitsPerRow-FrameSelectWidth]),
    .FrameStrobe(LongFrameStrobe)
);

Frame_Select
    #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameSelectWidth(FrameSelectWidth),
    .Col(11)
    )
    inst_Frame_Select_11
    (
    .FrameStrobe_I(FrameAddressRegister[MaxFramesPerCol-1:0]),
    .FrameStrobe_O(FrameSelect[11*MaxFramesPerCol+MaxFramesPerCol-1:11*MaxFramesPerCol]),
    .FrameSelect(FrameAddressRegister[FrameBitsPerRow-1:FrameBitsPerRow-FrameSelectWidth]),
    .FrameStrobe(LongFrameStrobe)
);

Frame_Select
    #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameSelectWidth(FrameSelectWidth),
    .Col(12)
    )
    inst_Frame_Select_12
    (
    .FrameStrobe_I(FrameAddressRegister[MaxFramesPerCol-1:0]),
    .FrameStrobe_O(FrameSelect[12*MaxFramesPerCol+MaxFramesPerCol-1:12*MaxFramesPerCol]),
    .FrameSelect(FrameAddressRegister[FrameBitsPerRow-1:FrameBitsPerRow-FrameSelectWidth]),
    .FrameStrobe(LongFrameStrobe)
);

Frame_Select
    #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameSelectWidth(FrameSelectWidth),
    .Col(13)
    )
    inst_Frame_Select_13
    (
    .FrameStrobe_I(FrameAddressRegister[MaxFramesPerCol-1:0]),
    .FrameStrobe_O(FrameSelect[13*MaxFramesPerCol+MaxFramesPerCol-1:13*MaxFramesPerCol]),
    .FrameSelect(FrameAddressRegister[FrameBitsPerRow-1:FrameBitsPerRow-FrameSelectWidth]),
    .FrameStrobe(LongFrameStrobe)
);

Frame_Select
    #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameSelectWidth(FrameSelectWidth),
    .Col(14)
    )
    inst_Frame_Select_14
    (
    .FrameStrobe_I(FrameAddressRegister[MaxFramesPerCol-1:0]),
    .FrameStrobe_O(FrameSelect[14*MaxFramesPerCol+MaxFramesPerCol-1:14*MaxFramesPerCol]),
    .FrameSelect(FrameAddressRegister[FrameBitsPerRow-1:FrameBitsPerRow-FrameSelectWidth]),
    .FrameStrobe(LongFrameStrobe)
);

Frame_Select
    #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameSelectWidth(FrameSelectWidth),
    .Col(15)
    )
    inst_Frame_Select_15
    (
    .FrameStrobe_I(FrameAddressRegister[MaxFramesPerCol-1:0]),
    .FrameStrobe_O(FrameSelect[15*MaxFramesPerCol+MaxFramesPerCol-1:15*MaxFramesPerCol]),
    .FrameSelect(FrameAddressRegister[FrameBitsPerRow-1:FrameBitsPerRow-FrameSelectWidth]),
    .FrameStrobe(LongFrameStrobe)
);

Frame_Select
    #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameSelectWidth(FrameSelectWidth),
    .Col(16)
    )
    inst_Frame_Select_16
    (
    .FrameStrobe_I(FrameAddressRegister[MaxFramesPerCol-1:0]),
    .FrameStrobe_O(FrameSelect[16*MaxFramesPerCol+MaxFramesPerCol-1:16*MaxFramesPerCol]),
    .FrameSelect(FrameAddressRegister[FrameBitsPerRow-1:FrameBitsPerRow-FrameSelectWidth]),
    .FrameStrobe(LongFrameStrobe)
);

Frame_Select
    #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameSelectWidth(FrameSelectWidth),
    .Col(17)
    )
    inst_Frame_Select_17
    (
    .FrameStrobe_I(FrameAddressRegister[MaxFramesPerCol-1:0]),
    .FrameStrobe_O(FrameSelect[17*MaxFramesPerCol+MaxFramesPerCol-1:17*MaxFramesPerCol]),
    .FrameSelect(FrameAddressRegister[FrameBitsPerRow-1:FrameBitsPerRow-FrameSelectWidth]),
    .FrameStrobe(LongFrameStrobe)
);

Frame_Select
    #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameSelectWidth(FrameSelectWidth),
    .Col(18)
    )
    inst_Frame_Select_18
    (
    .FrameStrobe_I(FrameAddressRegister[MaxFramesPerCol-1:0]),
    .FrameStrobe_O(FrameSelect[18*MaxFramesPerCol+MaxFramesPerCol-1:18*MaxFramesPerCol]),
    .FrameSelect(FrameAddressRegister[FrameBitsPerRow-1:FrameBitsPerRow-FrameSelectWidth]),
    .FrameStrobe(LongFrameStrobe)
);

Frame_Select
    #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameSelectWidth(FrameSelectWidth),
    .Col(19)
    )
    inst_Frame_Select_19
    (
    .FrameStrobe_I(FrameAddressRegister[MaxFramesPerCol-1:0]),
    .FrameStrobe_O(FrameSelect[19*MaxFramesPerCol+MaxFramesPerCol-1:19*MaxFramesPerCol]),
    .FrameSelect(FrameAddressRegister[FrameBitsPerRow-1:FrameBitsPerRow-FrameSelectWidth]),
    .FrameStrobe(LongFrameStrobe)
);

Frame_Select
    #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameSelectWidth(FrameSelectWidth),
    .Col(20)
    )
    inst_Frame_Select_20
    (
    .FrameStrobe_I(FrameAddressRegister[MaxFramesPerCol-1:0]),
    .FrameStrobe_O(FrameSelect[20*MaxFramesPerCol+MaxFramesPerCol-1:20*MaxFramesPerCol]),
    .FrameSelect(FrameAddressRegister[FrameBitsPerRow-1:FrameBitsPerRow-FrameSelectWidth]),
    .FrameStrobe(LongFrameStrobe)
);

Frame_Select
    #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameSelectWidth(FrameSelectWidth),
    .Col(21)
    )
    inst_Frame_Select_21
    (
    .FrameStrobe_I(FrameAddressRegister[MaxFramesPerCol-1:0]),
    .FrameStrobe_O(FrameSelect[21*MaxFramesPerCol+MaxFramesPerCol-1:21*MaxFramesPerCol]),
    .FrameSelect(FrameAddressRegister[FrameBitsPerRow-1:FrameBitsPerRow-FrameSelectWidth]),
    .FrameStrobe(LongFrameStrobe)
);

Frame_Select
    #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameSelectWidth(FrameSelectWidth),
    .Col(22)
    )
    inst_Frame_Select_22
    (
    .FrameStrobe_I(FrameAddressRegister[MaxFramesPerCol-1:0]),
    .FrameStrobe_O(FrameSelect[22*MaxFramesPerCol+MaxFramesPerCol-1:22*MaxFramesPerCol]),
    .FrameSelect(FrameAddressRegister[FrameBitsPerRow-1:FrameBitsPerRow-FrameSelectWidth]),
    .FrameStrobe(LongFrameStrobe)
);

Frame_Select
    #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameSelectWidth(FrameSelectWidth),
    .Col(23)
    )
    inst_Frame_Select_23
    (
    .FrameStrobe_I(FrameAddressRegister[MaxFramesPerCol-1:0]),
    .FrameStrobe_O(FrameSelect[23*MaxFramesPerCol+MaxFramesPerCol-1:23*MaxFramesPerCol]),
    .FrameSelect(FrameAddressRegister[FrameBitsPerRow-1:FrameBitsPerRow-FrameSelectWidth]),
    .FrameStrobe(LongFrameStrobe)
);

Frame_Select
    #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameSelectWidth(FrameSelectWidth),
    .Col(24)
    )
    inst_Frame_Select_24
    (
    .FrameStrobe_I(FrameAddressRegister[MaxFramesPerCol-1:0]),
    .FrameStrobe_O(FrameSelect[24*MaxFramesPerCol+MaxFramesPerCol-1:24*MaxFramesPerCol]),
    .FrameSelect(FrameAddressRegister[FrameBitsPerRow-1:FrameBitsPerRow-FrameSelectWidth]),
    .FrameStrobe(LongFrameStrobe)
);

Frame_Select
    #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameSelectWidth(FrameSelectWidth),
    .Col(25)
    )
    inst_Frame_Select_25
    (
    .FrameStrobe_I(FrameAddressRegister[MaxFramesPerCol-1:0]),
    .FrameStrobe_O(FrameSelect[25*MaxFramesPerCol+MaxFramesPerCol-1:25*MaxFramesPerCol]),
    .FrameSelect(FrameAddressRegister[FrameBitsPerRow-1:FrameBitsPerRow-FrameSelectWidth]),
    .FrameStrobe(LongFrameStrobe)
);

Frame_Select
    #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameSelectWidth(FrameSelectWidth),
    .Col(26)
    )
    inst_Frame_Select_26
    (
    .FrameStrobe_I(FrameAddressRegister[MaxFramesPerCol-1:0]),
    .FrameStrobe_O(FrameSelect[26*MaxFramesPerCol+MaxFramesPerCol-1:26*MaxFramesPerCol]),
    .FrameSelect(FrameAddressRegister[FrameBitsPerRow-1:FrameBitsPerRow-FrameSelectWidth]),
    .FrameStrobe(LongFrameStrobe)
);

Frame_Select
    #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameSelectWidth(FrameSelectWidth),
    .Col(27)
    )
    inst_Frame_Select_27
    (
    .FrameStrobe_I(FrameAddressRegister[MaxFramesPerCol-1:0]),
    .FrameStrobe_O(FrameSelect[27*MaxFramesPerCol+MaxFramesPerCol-1:27*MaxFramesPerCol]),
    .FrameSelect(FrameAddressRegister[FrameBitsPerRow-1:FrameBitsPerRow-FrameSelectWidth]),
    .FrameStrobe(LongFrameStrobe)
);

Frame_Select
    #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameSelectWidth(FrameSelectWidth),
    .Col(28)
    )
    inst_Frame_Select_28
    (
    .FrameStrobe_I(FrameAddressRegister[MaxFramesPerCol-1:0]),
    .FrameStrobe_O(FrameSelect[28*MaxFramesPerCol+MaxFramesPerCol-1:28*MaxFramesPerCol]),
    .FrameSelect(FrameAddressRegister[FrameBitsPerRow-1:FrameBitsPerRow-FrameSelectWidth]),
    .FrameStrobe(LongFrameStrobe)
);

Frame_Select
    #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameSelectWidth(FrameSelectWidth),
    .Col(29)
    )
    inst_Frame_Select_29
    (
    .FrameStrobe_I(FrameAddressRegister[MaxFramesPerCol-1:0]),
    .FrameStrobe_O(FrameSelect[29*MaxFramesPerCol+MaxFramesPerCol-1:29*MaxFramesPerCol]),
    .FrameSelect(FrameAddressRegister[FrameBitsPerRow-1:FrameBitsPerRow-FrameSelectWidth]),
    .FrameStrobe(LongFrameStrobe)
);

Frame_Select
    #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameSelectWidth(FrameSelectWidth),
    .Col(30)
    )
    inst_Frame_Select_30
    (
    .FrameStrobe_I(FrameAddressRegister[MaxFramesPerCol-1:0]),
    .FrameStrobe_O(FrameSelect[30*MaxFramesPerCol+MaxFramesPerCol-1:30*MaxFramesPerCol]),
    .FrameSelect(FrameAddressRegister[FrameBitsPerRow-1:FrameBitsPerRow-FrameSelectWidth]),
    .FrameStrobe(LongFrameStrobe)
);

Frame_Select
    #(
    .MaxFramesPerCol(MaxFramesPerCol),
    .FrameSelectWidth(FrameSelectWidth),
    .Col(31)
    )
    inst_Frame_Select_31
    (
    .FrameStrobe_I(FrameAddressRegister[MaxFramesPerCol-1:0]),
    .FrameStrobe_O(FrameSelect[31*MaxFramesPerCol+MaxFramesPerCol-1:31*MaxFramesPerCol]),
    .FrameSelect(FrameAddressRegister[FrameBitsPerRow-1:FrameBitsPerRow-FrameSelectWidth]),
    .FrameStrobe(LongFrameStrobe)
);


`endif
eFPGA eFPGA_inst (
    .Tile_X2Y0_NIO_I_top(NIO_I_top[0]),
    .Tile_X3Y0_NIO_I_top(NIO_I_top[1]),
    .Tile_X4Y0_NIO_I_top(NIO_I_top[2]),
    .Tile_X5Y0_NIO_I_top(NIO_I_top[3]),
    .Tile_X6Y0_NIO_I_top(NIO_I_top[4]),
    .Tile_X7Y0_NIO_I_top(NIO_I_top[5]),
    .Tile_X8Y0_NIO_I_top(NIO_I_top[6]),
    .Tile_X9Y0_NIO_I_top(NIO_I_top[7]),
    .Tile_X10Y0_NIO_I_top(NIO_I_top[8]),
    .Tile_X11Y0_NIO_I_top(NIO_I_top[9]),
    .Tile_X12Y0_NIO_I_top(NIO_I_top[10]),
    .Tile_X13Y0_NIO_I_top(NIO_I_top[11]),
    .Tile_X14Y0_NIO_I_top(NIO_I_top[12]),
    .Tile_X15Y0_NIO_I_top(NIO_I_top[13]),
    .Tile_X16Y0_NIO_I_top(NIO_I_top[14]),
    .Tile_X17Y0_NIO_I_top(NIO_I_top[15]),
    .Tile_X18Y0_NIO_I_top(NIO_I_top[16]),
    .Tile_X19Y0_NIO_I_top(NIO_I_top[17]),
    .Tile_X20Y0_NIO_I_top(NIO_I_top[18]),
    .Tile_X21Y0_NIO_I_top(NIO_I_top[19]),
    .Tile_X22Y0_NIO_I_top(NIO_I_top[20]),
    .Tile_X23Y0_NIO_I_top(NIO_I_top[21]),
    .Tile_X24Y0_NIO_I_top(NIO_I_top[22]),
    .Tile_X25Y0_NIO_I_top(NIO_I_top[23]),
    .Tile_X26Y0_NIO_I_top(NIO_I_top[24]),
    .Tile_X27Y0_NIO_I_top(NIO_I_top[25]),
    .Tile_X28Y0_NIO_I_top(NIO_I_top[26]),
    .Tile_X29Y0_NIO_I_top(NIO_I_top[27]),
    .Tile_X2Y0_NIO_O_top(NIO_O_top[0]),
    .Tile_X3Y0_NIO_O_top(NIO_O_top[1]),
    .Tile_X4Y0_NIO_O_top(NIO_O_top[2]),
    .Tile_X5Y0_NIO_O_top(NIO_O_top[3]),
    .Tile_X6Y0_NIO_O_top(NIO_O_top[4]),
    .Tile_X7Y0_NIO_O_top(NIO_O_top[5]),
    .Tile_X8Y0_NIO_O_top(NIO_O_top[6]),
    .Tile_X9Y0_NIO_O_top(NIO_O_top[7]),
    .Tile_X10Y0_NIO_O_top(NIO_O_top[8]),
    .Tile_X11Y0_NIO_O_top(NIO_O_top[9]),
    .Tile_X12Y0_NIO_O_top(NIO_O_top[10]),
    .Tile_X13Y0_NIO_O_top(NIO_O_top[11]),
    .Tile_X14Y0_NIO_O_top(NIO_O_top[12]),
    .Tile_X15Y0_NIO_O_top(NIO_O_top[13]),
    .Tile_X16Y0_NIO_O_top(NIO_O_top[14]),
    .Tile_X17Y0_NIO_O_top(NIO_O_top[15]),
    .Tile_X18Y0_NIO_O_top(NIO_O_top[16]),
    .Tile_X19Y0_NIO_O_top(NIO_O_top[17]),
    .Tile_X20Y0_NIO_O_top(NIO_O_top[18]),
    .Tile_X21Y0_NIO_O_top(NIO_O_top[19]),
    .Tile_X22Y0_NIO_O_top(NIO_O_top[20]),
    .Tile_X23Y0_NIO_O_top(NIO_O_top[21]),
    .Tile_X24Y0_NIO_O_top(NIO_O_top[22]),
    .Tile_X25Y0_NIO_O_top(NIO_O_top[23]),
    .Tile_X26Y0_NIO_O_top(NIO_O_top[24]),
    .Tile_X27Y0_NIO_O_top(NIO_O_top[25]),
    .Tile_X28Y0_NIO_O_top(NIO_O_top[26]),
    .Tile_X29Y0_NIO_O_top(NIO_O_top[27]),
    .UserCLK(CLK),
    .FrameData(FrameData),
    .FrameStrobe(FrameSelect)
);


assign FrameData = {32'h12345678,FrameRegister,32'h12345678};
endmodule