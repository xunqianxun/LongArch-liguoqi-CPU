`timescale 1ps/1ps
`include"../define.v"

module Btb (
    input        wire                                   Clk             ,
    input        wire                                   Rest            ,
    // stop
    input        wire                                   BtbStop         ,
    input        wire                                   BtbFlash        ,
    //input from pc
    input        wire                                   InstPcAble      ,
    input        wire     [`InstAddrBus]                InstPc          , //bit [4:0] un use
    //input from predecode 
    input        wire                                   UpAble          ,
    input        wire     [1:0]                         UpAbleBank      ,
    input        wire     [`InstAddrBus]                UpPc            , //bit [4:0] un use
    input        wire                                   UpCntAble       ,
    input        wire     [3:0]                         UpCnt           ,
    input        wire                                   BtbUpTypeAble   ,
    input        wire     [2:0]                         BtbUpType       ,
    input        wire                                   BtbUpTagetAble  ,
    input        wire     [`InstAddrBus]                BtbUpTaget      ,
    //to tage and ras
    output       wire                                   InstNextAble    ,
    output       wire     [1:0]                         InstHitBanN     ,
    output       wire     [`InstAddrBus]                InstNextPc      ,
    output       wire     [4:0]                         InstNextOffset  ,
    output       wire                                   InstNextMode    ,
    output       wire     [2:0]                         InstNextType   
);

    reg           StopTemp  ;
    //reg           FLashTemp ;
    always @(posedge Clk) begin
        if(!Rest) begin
            StopTemp  <= 1'b0 ;
            //FLashTemp <= 1'b0 ;
        end
        else begin
            StopTemp  <= BtbStop  ;
            //FLashTemp <= BtbFlash ;
        end
    end

    reg   [58:0]  BtbRamBank0 [0:255];
    reg   [58:0]  BtbRamBank1 [0:255];

    reg   [3:0]   CountBan0   [0:255];
    reg   [3:0]   CountBan1   [0:255];
    // for read 
    wire  [58:0]  ReadBtb0Enty = BtbRamBank0[InstPc[12:5]] ;
    wire  [58:0]  ReadBtb1Enty = BtbRamBank1[InstPc[12:5]] ;

    wire  [18:0]  Ban0Tag = ReadBtb0Enty[57:39] ;
    wire  [18:0]  Ban1Tag = ReadBtb1Enty[57:39] ;
    wire          Ban0Valid = ReadBtb0Enty[58]  ;
    wire          Ban1Valid = ReadBtb1Enty[58]  ;
    wire  [18:0]  PcTag   = InstPc[31:13]       ;

    //wire          HitOrNo = ((Ban0Tag == PcTag) & Ban0Valid) | ((Ban1Tag == PcTag) & Ban1Valid) ;

    wire          HitBan0Able =  ((Ban0Tag == PcTag) & Ban0Valid) ;
    wire          HitBan1Able =  ((Ban1Tag == PcTag) & Ban1Valid) ;
    // wire          AllChiose0  =  ((HitBan0Able & HitBan1Able) & (CountBan0[InstPc[12:5]] >= CountBan1[InstPc[12:5]])) | HitBan0Able ;
    // wire          AllChiose1  =  ((HitBan0Able & HitBan1Able) & (CountBan0[InstPc[12:5]] <  CountBan1[InstPc[12:5]])) | HitBan1Able ;

    wire  [38:0]  HitDate = ((Ban0Tag == PcTag) & Ban0Valid) ? ReadBtb0Enty[38:0] :
                            ((Ban1Tag == PcTag) & Ban1Valid) ? ReadBtb1Enty[38:0] : {4'd0,`TypeFORMAL,({InstPc[31:5],5'd0} + 32'd32)} ;


    wire WriteBan0Able ;
    wire WriteBan1Able ;

    assign WriteBan0Able = UpDateChiose0 ;
    assign WriteBan1Able = UpDateChiose1 ;


    integer i ;

    always @(posedge Clk) begin
        if(!Rest) begin
            for (i =0 ;i<32 ;i=i+1 ) begin
                CountBan0[i] <= 4'd0 ;
                CountBan1[i] <= 4'd0 ;
                CountBan0[i+32] <= 4'd0 ;
                CountBan1[i+32] <= 4'd0 ;
                CountBan0[i+64] <= 4'd0 ;
                CountBan1[i+64] <= 4'd0 ;
                CountBan0[i+96] <= 4'd0 ;
                CountBan1[i+96] <= 4'd0 ;
                CountBan1[i+128] <= 4'd0 ;
                CountBan0[i+128] <= 4'd0 ;
                CountBan1[i+160] <= 4'd0 ;
                CountBan0[i+160] <= 4'd0 ;
                CountBan1[i+192] <= 4'd0 ;
                CountBan0[i+192] <= 4'd0 ;
                CountBan1[i+224] <= 4'd0 ;
                CountBan0[i+224] <= 4'd0 ;
            end
        end 
            else begin
                CountBan0[InstPc[12:5]] <= (HitBan0Able & ~StopTemp)  ? 4'd0 :
                                           (HitBan1Able & ~StopTemp)  ? CountBan0[InstPc[12:5]] + 1 : CountBan0[InstPc[12:5]] ;
                CountBan1[InstPc[12:5]] <= (HitBan1Able & ~StopTemp)  ? 4'd0 :
                                           (HitBan0Able & ~StopTemp)  ? CountBan1[InstPc[12:5]] + 1 : CountBan1[InstPc[12:5]] ;
                CountBan0[UpPc[12:5]]   <= (WriteBan0Able & ~StopTemp) ? 4'd0 : CountBan0[UpPc[12:5]] ;
                CountBan1[UpPc[12:5]]   <= (WriteBan1Able & ~StopTemp) ? 4'd0 : CountBan1[UpPc[12:5]] ;
            end
    end
    
    reg                  RegNextAble  ;
    reg  [`InstAddrBus]  RegNextPc    ;
    reg  [4:0]           RegNextOffset;
    reg  [2:0]           RegNextType  ;
    reg                  RegNextMode ;
    reg  [1:0]           RegNextHitBn ;
    always @(posedge Clk) begin
        if(!Rest) begin
            RegNextAble <= `EnableValue ;
            RegNextPc   <= `ZeorDate    ;
            RegNextOffset<= 5'd0        ;
            RegNextType <= 3'd0         ;
            RegNextMode <= 1'b0         ;
            RegNextHitBn<= 2'd0         ;
        end
        else if(BtbStop) begin
            RegNextAble <= RegNextAble ;
            RegNextPc   <= RegNextPc   ;
            RegNextOffset<= RegNextOffset;
            RegNextType <= RegNextType ;
            RegNextMode <= RegNextMode ;
            RegNextHitBn<= RegNextHitBn;
        end
        else if(BtbFlash) begin
            RegNextAble <= `EnableValue ;
            RegNextPc   <= `ZeorDate    ;
            RegNextOffset<= 5'd0        ;
            RegNextType <= 3'd0         ;
            RegNextMode <= 1'b0         ;
            RegNextHitBn<= 2'd0         ;
        end
        else if(InstPcAble) begin
            RegNextAble <= `AbleValue ;
            RegNextPc   <= (HitDate[34:32] == `TypeBRANCH) ? (((HitDate[38] + HitDate[37] + HitDate[36] + HitDate[35]) > 2) ? HitDate[31:0] : ({InstPc[31:5],5'd0} + 32'd32)) : HitDate[31:0] ;
            RegNextOffset<= InstPc[4:0]  ;
            RegNextType <= HitDate[34:32] ;
            RegNextMode <= (HitDate[34:32] == `TypeBRANCH) & ((HitDate[38] + HitDate[37] + HitDate[36] + HitDate[35]) > 2) ;
            RegNextHitBn<= HitBan0Able ? 2'b01 :
                           HitBan1Able ? 2'b10 : 2'b00 ;                   
        end
        else begin
            RegNextAble <= `EnableValue ;
            RegNextPc   <= `ZeorDate    ;
            RegNextOffset<= 5'd0        ;
            RegNextType <= 3'd0         ;
            RegNextMode <= 1'b0         ;
            RegNextHitBn<= 2'd0         ;
        end
    end

    assign InstNextAble = RegNextAble ;
    assign InstNextPc   = RegNextPc   ;
    assign InstNextOffset= RegNextOffset;
    assign InstNextType = RegNextType ;
    assign InstNextMode = RegNextMode ;
    assign InstHitBanN  = RegNextHitBn;


    //for write

    wire  UpDateChiose0 = (UpAbleBank == 2'b01) | ((UpAbleBank == 2'b00) & (CountBan0[UpPc[12:5]] >= CountBan1[UpPc[12:5]])) ;
    wire  UpDateChiose1 = (UpAbleBank == 2'b10) | ((UpAbleBank == 2'b00) & (CountBan0[UpPc[12:5]] <  CountBan1[UpPc[12:5]])) ;


    integer ii  ;
    always @(posedge Clk) begin
        if(!Rest) begin
            for (ii =0 ;ii<32 ;ii=ii+1 ) begin
                BtbRamBank0[ii] <= 59'd0 ;
                BtbRamBank1[ii] <= 59'd0 ;
                BtbRamBank0[ii+32] <= 59'd0 ;
                BtbRamBank1[ii+32] <= 59'd0 ;
                BtbRamBank0[ii+64] <= 59'd0 ;
                BtbRamBank1[ii+64] <= 59'd0 ;
                BtbRamBank0[ii+96] <= 59'd0 ;
                BtbRamBank1[ii+96] <= 59'd0 ;
                BtbRamBank0[ii+128] <= 59'd0 ;
                BtbRamBank1[ii+128] <= 59'd0 ;
                BtbRamBank0[ii+160] <= 59'd0 ;
                BtbRamBank1[ii+160] <= 59'd0 ;
                BtbRamBank0[ii+192] <= 59'd0 ;
                BtbRamBank1[ii+192] <= 59'd0 ;
                BtbRamBank0[ii+224] <= 59'd0 ;
                BtbRamBank1[ii+224] <= 59'd0 ;
            end
        end
        else begin
            BtbRamBank0[UpPc[12:5]] <= (UpDateChiose0 & UpAble & ~StopTemp) ? (~{1'b1,{19{1'b1}},{4{UpCntAble}},{3{BtbUpTypeAble}},{32{BtbUpTagetAble}}} & BtbRamBank0[UpPc[12:5]]) |
                                                       ({1'b1,{19{1'b1}},{4{UpCntAble}},{3{BtbUpTypeAble}},{32{BtbUpTagetAble}}} & {`AbleValue,UpPc[31:13],UpCnt,BtbUpType,BtbUpTaget}) : BtbRamBank0[UpPc[12:5]] ;
            BtbRamBank1[UpPc[12:5]] <= (UpDateChiose1 & UpAble & ~StopTemp) ? (~{1'b1,{19{1'b1}},{4{UpCntAble}},{3{BtbUpTypeAble}},{32{BtbUpTagetAble}}} & BtbRamBank1[UpPc[12:5]]) |
                                                       ({1'b1,{19{1'b1}},{4{UpCntAble}},{3{BtbUpTypeAble}},{32{BtbUpTagetAble}}} & {`AbleValue,UpPc[31:13],UpCnt,BtbUpType,BtbUpTaget}) : BtbRamBank1[UpPc[12:5]] ;
            BtbRamBank0[InstPc[12:5]][38:35] <= (HitBan0Able  & ~StopTemp) ?  {BtbRamBank0[InstPc[12:5]][37:35],((HitDate[38] + HitDate[37] + HitDate[36] + HitDate[35]) > 2)} : BtbRamBank0[InstPc[12:5]][38:35] ;
            BtbRamBank1[InstPc[12:5]][38:35] <= (HitBan1Able  & ~StopTemp) ?  {BtbRamBank1[InstPc[12:5]][37:35],((HitDate[38] + HitDate[37] + HitDate[36] + HitDate[35]) > 2)} : BtbRamBank1[InstPc[12:5]][38:35] ;
        end
    end


endmodule
