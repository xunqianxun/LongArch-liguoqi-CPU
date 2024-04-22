`timescale 1ps/1ps
`include"../define.v"

module Btb (
    input        wire                                   Clk             ,
    input        wire                                   Rest            ,
    //input from pc
    input        wire                                   InstPcAble      ,
    input        wire     [`InstAddrBus]                InstPc          ,
    //input from predecode 
    input        wire                                   UpPcAble        ,
    input        wire     [`InstAddrBus]                UpPc            ,
    input        wire                                   UpCntAble       ,
    input        wire     [3:0]                         UpCnt           ,
    input        wire                                   BtbUpTypeAble   ,
    input        wire     [2:0]                         BtbUpType       ,
    input        wire                                   BtbUpTagetAble  ,
    input        wire     [`InstAddrBus]                BtbUpTaget      ,
    //to tage and ras
    output       wire                                   InstNextAble    ,
    output       wire     [`InstAddrBus]                InstNextPc      ,
    output       wire     [2:0]                         InstNextType   
);


    reg   [56:0]  BtbRamBank0 [0:255];
    reg   [56:0]  BtbRamBank1 [0:255];

    reg   [3:0]   CountBan0   [0:255];
    reg   [3:0]   CountBan1   [0:255];
    // for read 
    wire  [56:0]  ReadBtb0Enty = BtbRamBank0[InstPc[12:5]] ;
    wire  [56:0]  ReadBtb1Enty = BtbRamBank1[InstPc[12:5]] ;

    wire  [17:0]  Ban0Tag = ReadBtb0Enty[56:39] ;
    wire  [17:0]  Ban1Tag = ReadBtb1Enty[56:39] ;
    wire          Ban0Valid = ReadBtb0Enty[57]  ;
    wire          Ban1Valid = ReadBtb1Enty[57]  ;
    wire  [17:0]  PcTag   = InstPc[31:13]       ;

    //wire          HitOrNo = ((Ban0Tag == PcTag) & Ban0Valid) | ((Ban1Tag == PcTag) & Ban1Valid) ;

    wire  [38:0]  HitDate = ((Ban0Tag == PcTag) & Ban0Valid) ? ReadBtb0Enty[38:0] :
                            ((Ban1Tag == PcTag) & Ban1Valid )? ReadBtb1Enty[38:0] : {4'd0,`TypeFORMAL,({InstPc[31:5],5'd0} + 32'd32)} ;
    
    reg                  RegNextAble  ;
    reg  [`InstAddrBus]  RegNextPc    ;
    reg  [2:0]           RegNextType  ;
    always @(posedge Clk) begin
        if(!Rest) begin
            RegNextAble <= `EnableValue ;
            RegNextPc   <= `ZeorDate    ;
            RegNextType <= 3'd0         ;
        end
        else if(InstPcAble) begin
            RegNextAble <= `AbleValue ;
            RegNextPc   <= (HitDate[34:32] == `TypeBRANCH) ? (((HitDate[38] + HitDate[37] + HitDate[36] + HitDate[35]) > 2) ? HitDate[31:0] : ({InstPc[31:5],5'd0} + 32'd32)) : HitDate[31:0] ;
            RegNextType <= HitDate[34:32] ;
        end
        else begin
            RegNextAble <= `EnableValue ;
            RegNextPc   <= `ZeorDate    ;
            RegNextType <= 3'd0         ;
        end
    end

    always @(posedge Clk) begin
        if(!Rest) begin
            
        end
    end


endmodule
