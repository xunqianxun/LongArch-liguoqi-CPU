`timescale 1ps/1ps
`include"define.v"

module Btb #(
    parameter BTB_LINE = 512 ,
    parameter BTB_WAYS = 4   
) (
    input        wire                                   Clk             ,
    input        wire                                   Rest            ,

    input        wire     [`InstAddrBus]                InstPc          ,

    //input from FTQ 的锻炼数据
    input        wire     [`BTBTageBus]                 InstTageData    ,
    input        wire     [2:0]                         InstJumpType    ,
    input        wire     [2:0]                         InstJumpPosi    ,
    input        wire     [`InstAddrBus]                InstJumpTarget  ,

    //input        wire                                   EnableValue     ,

    output       wire     [`InstAddrBus]                InstNextPc      ,
    output       wire     [2:0]                         InstNextType    ,
    output       wire     [2:0]                         InstNextPosi    
);
    //direct predict instraction eare
    reg   [57:0]  BtbRam1 [BTB_LINE];
    reg   [57:0]  BtbRam2 [BTB_LINE];
    reg   [57:0]  BtbRam3 [BTB_LINE];
    reg   [57:0]  BtbRam4 [BTB_LINE];

    // for read 
    wire                  Btb1Able;
    wire                  Btb2Able;
    wire                  Btb3Able;
    wire                  Btb4Able;
    assign Btb1Able = BtbRam1[InstPc[12:4]][57];
    assign Btb2Able = BtbRam2[InstPc[12:4]][57];
    assign Btb3Able = BtbRam3[InstPc[12:4]][57];
    assign Btb4Able = BtbRam4[InstPc[12:4]][57];
    wire  [`BTBTageBus]   Btb1Tage;
    wire  [`BTBTageBus]   Btb2Tage;
    wire  [`BTBTageBus]   Btb3Tage;
    wire  [`BTBTageBus]   Btb4Tage;
    assign Btb1Tage = BtbRam1[InstPc[12:4]][56:38];
    assign Btb2Tage = BtbRam2[InstPc[12:4]][56:38];
    assign Btb3Tage = BtbRam3[InstPc[12:4]][56:38];
    assign Btb4Tage = BtbRam4[InstPc[12:4]][56:38];
    wire  [2:0]           Btb1Type;
    wire  [2:0]           Btb2Type;
    wire  [2:0]           Btb3Type;
    wire  [2:0]           Btb4Type;
    assign Btb1Type = BtbRam1[InstPc[12:4]][37:35];
    assign Btb2Type = BtbRam2[InstPc[12:4]][37:35];
    assign Btb3Type = BtbRam3[InstPc[12:4]][37:35];
    assign Btb4Type = BtbRam4[InstPc[12:4]][37:35];
    wire  [2:0]           Btb1Posi;
    wire  [2:0]           Btb2Posi;
    wire  [2:0]           Btb3Posi;
    wire  [2:0]           Btb4Posi;
    assign Btb1Posi = BtbRam1[InstPc[12:4]][34:32];
    assign Btb2Posi = BtbRam2[InstPc[12:4]][34:32];
    assign Btb3Posi = BtbRam3[InstPc[12:4]][34:32];
    assign Btb4Posi = BtbRam4[InstPc[12:4]][34:32];
    wire  [`InstDateBus]  Btb1Data;
    wire  [`InstDateBus]  Btb2Data;
    wire  [`InstDateBus]  Btb3Data;
    wire  [`InstDateBus]  Btb4Data;   
    assign Btb1Data = BtbRam1[InstPc[12:4]][31:0 ];   
    assign Btb2Data = BtbRam2[InstPc[12:4]][31:0 ];
    assign Btb3Data = BtbRam3[InstPc[12:4]][31:0 ];
    assign Btb4Data = BtbRam4[InstPc[12:4]][31:0 ];

    //wire                   BtbOutValue;
    wire  [`BTBTageBus]    BtbOutTage ;
    assign BtbOutTage = InstPc[31:13] ;
    wire  [2:0]            BtbOutType ;
    wire  [2:0]            BtbOutPosi ;
    wire  [`InstDateBus]   BtbOutData ;

    assign {BtbOutType,BtbOutPosi,BtbOutData} =  (Btb1Able & (BtbOutTage == Btb1Tage)) ? {Btb1Type,Btb1Posi,Btb1Data}:
                                                 (Btb2Able & (BtbOutTage == Btb2Tage)) ? {Btb2Type,Btb2Posi,Btb2Data}:
                                                 (Btb3Able & (BtbOutTage == Btb3Tage)) ? {Btb3Type,Btb3Posi,Btb3Data}:
                                                 (Btb4Able & (BtbOutTage == Btb4Tage)) ? {Btb4Type,Btb4Posi,Btb4Data}: {3'b0,3'b0,`ZeorDate};
    reg   [2:0]            BtbRamType ;
    reg   [2:0]            BtbRamPosi ;
    reg   [31:0]           BtbRamData ;
    always @(posedge Clk) begin
        if(!Rest)begin
            BtbRamType <= 3'b0 ;
            BtbRamPosi <= 3'b0 ;
            BtbRamData <= `ZeorDate;
        end
        else begin
            BtbRamType <= BtbOutType ;
            BtbRamPosi <= BtbOutPosi ;
            BtbRamData <= BtbOutData ;
        end
    end
    assign InstNextType = BtbRamType;
    assign InstNextPosi = BtbRamPosi;
    assign InstNextPc   = BtbRamData;

    //for updata
    
    



endmodule
