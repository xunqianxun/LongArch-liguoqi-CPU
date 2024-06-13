`timescale 1ps/1ps
`include "../define.v"
`include "../../Lib/FIFO_ftq.v"

module FTQ (
    input       wire                           Clk          ,
    input       wire                           Rest         ,
    //from ctrl 
    input       wire                           FTQStop      ,
    input       wire                           FTQFlash     ,
    input       wire                           FTQreq       ,
    //from ROB 
    input       wire                           ROBBranch    ,
    input       wire                           ROBBranchYN  ,//right = 1 fault = 0 
    input       wire       [`InstAddrBus]      ROBBranchPc  ,
    //from PreDecode  
    input       wire                           PredictAble  ,
    input       wire       [2:0]               PredictJdate ,
    input       wire       [2:0]               PredictNum   ,
    input       wire       [2:0]               PredictInt1  ,
    input       wire       [2:0]               PredictInt2  ,
    input       wire       [2:0]               PredictInt3  ,
    input       wire       [2:0]               PredictInt4  ,
    input       wire       [2:0]               PredictInt5  ,
    input       wire       [2:0]               PredictInt6  ,
    //to tage 
    output      wire       [`InstAddrBus]      OutUpDatePc  ,
    output      wire                           OutDateAble  ,
    output      wire       [2:0]               OutUpDate    ,
    output      wire       [2:0]               OutUpNum     ,
    output      wire       [2:0]               OutUpCnt     ,
    output      wire                           NewDateAble  ,
    output      wire       [2:0]               NewUpDate    ,
    output      wire       [2:0]               NewUpNum     ,
    output      wire       [2:0]               NewUpCnt     ,
    output      wire                           NewCnt1Able  ,
    output      wire       [2:0]               NewCnt1Date  ,
    output      wire                           NewCnt2Able  ,
    output      wire       [2:0]               NewCnt2Date  ,  
    output      wire                           NewCnt3Able  ,
    output      wire       [2:0]               NewCnt3Date  ,  
    output      wire                           NewCnt4Able  ,
    output      wire       [2:0]               NewCnt4Date  , 
    output      wire                           NewCnt5Able  ,
    output      wire       [2:0]               NewCnt5Date  ,  
    output      wire                           NewCnt6Able  ,
    output      wire       [2:0]               NewCnt6Date  

);
    
    wire        WriteAble = ~FTQStop & PredictAble ;
                            //|23  21|20  18|17  15|14 12|11  9|8  6|5  3|2  0|
    wire [23:0] WriteDate = {PredictNum,PredictJdate,PredictInt6,PredictInt5,PredictInt4,PredictInt3,PredictInt2,PredictInt1} ;

    wire [23:0] reOutDate ;

    FIFO_ftq#(
        .FIFOWIDE    ( 24 )
    )u_FIFO_ftq(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .Rable       ( ROBBranch   ),
        .FifoPreOut  ( reOutDate  ),
        .Wable       ( WriteAble   ),
        .Din         ( WriteDate   ),
        .FifoClean   ( FTQFlash    ),
        .FifoFull    ( FTQreq      )
    );

    wire [2:0] PredictUset1 = reOutDate[2:0]   ;
    wire [2:0] PredictUset2 = reOutDate[5:3]   ;
    wire [2:0] PredictUset3 = reOutDate[8:6]   ;
    wire [2:0] PredictUset4 = reOutDate[11:9]  ;
    wire [2:0] PredictUset5 = reOutDate[14:12] ;
    wire [2:0] PredictUset6 = reOutDate[17:15] ;

    wire [2:0] PreDictCnt  =  {3{(reOutDate[23:21] == 0)}} & 3'd0         |
                              {3{(reOutDate[23:21] == 1)}} & PredictUset1 |
                              {3{(reOutDate[23:21] == 2)}} & PredictUset2 |
                              {3{(reOutDate[23:21] == 3)}} & PredictUset3 |
                              {3{(reOutDate[23:21] == 4)}} & PredictUset4 |
                              {3{(reOutDate[23:21] == 5)}} & PredictUset5 |
                              {3{(reOutDate[23:21] == 6)}} & PredictUset6 ;

    wire Cnt0Able = ~ROBBranchYN & (reOutDate[23:21] == 0) & (PredictUset1 != 0) & (PredictUset2 != 0) & (PredictUset3 != 0) & (PredictUset4 != 0) & (PredictUset5 != 0) & (PredictUset6 != 0) ;
    wire Cnt1Able = ~ROBBranchYN & (reOutDate[23:21] == 1) & (PredictUset2 != 0) & (PredictUset3 != 0) & (PredictUset4 != 0) & (PredictUset5 != 0) & (PredictUset6 != 0) ;
    wire Cnt2Able = ~ROBBranchYN & (reOutDate[23:21] == 2) & (PredictUset3 != 0) & (PredictUset4 != 0) & (PredictUset5 != 0) & (PredictUset6 != 0) ;
    wire Cnt3Able = ~ROBBranchYN & (reOutDate[23:21] == 3) & (PredictUset4 != 0) & (PredictUset5 != 0) & (PredictUset6 != 0) ;
    wire Cnt4Able = ~ROBBranchYN & (reOutDate[23:21] == 4) & (PredictUset5 != 0) & (PredictUset6 != 0) ;
    wire Cnt5Able = ~ROBBranchYN & (reOutDate[23:21] == 5) & (PredictUset6 != 0) ;

    wire Num1CntAble = ~ROBBranchYN & (PredictUset1 == 0) ;
    wire Num2CntAble = ~ROBBranchYN & (PredictUset2 == 0) ;
    wire Num3CntAble = ~ROBBranchYN & (PredictUset3 == 0) ;
    wire Num4CntAble = ~ROBBranchYN & (PredictUset4 == 0) ;
    wire Num5CntAble = ~ROBBranchYN & (PredictUset5 == 0) ;
    wire Num6CntAble = ~ROBBranchYN & (PredictUset6 == 0) ;

    assign NewCnt1Able = Cnt0Able ;
    assign NewCnt1Date = PredictUset1-1 ;
    assign NewCnt2Able = Cnt0Able | Cnt1Able ;
    assign NewCnt2Date = PredictUset2-1 ;
    assign NewCnt3Able = Cnt0Able | Cnt1Able | Cnt2Able ;
    assign NewCnt3Date = PredictUset3-1 ;
    assign NewCnt4Able = Cnt0Able | Cnt1Able | Cnt2Able | Cnt3Able ;
    assign NewCnt4Date = PredictUset4-1 ;
    assign NewCnt5Able = Cnt0Able | Cnt1Able | Cnt2Able | Cnt3Able | Cnt4Able ;
    assign NewCnt5Date = PredictUset5-1 ;
    assign NewCnt6Able = Cnt0Able | Cnt1Able | Cnt2Able | Cnt3Able | Cnt4Able | Cnt5Able ;
    assign NewCnt6Date = PredictUset6-1 ;
    

    wire [2:0] NewNum  ;
    wire [2:0] NewDate ;
    wire       NewAble ;
    assign {NewAble,NewNum,NewDate}= {7{(reOutDate[23:21] == 0)}} & ({7{Num1CntAble}}&{1'b1,3'd1,((reOutDate[20:18] < 3'b100) ? 3'b100 : 3'b000)} | 
                                                                     {7{Num2CntAble}}&{1'b1,3'd2,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} | 
                                                                     {7{Num3CntAble}}&{1'b1,3'd3,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} | 
                                                                     {7{Num4CntAble}}&{1'b1,3'd4,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} | 
                                                                     {7{Num5CntAble}}&{1'b1,3'd5,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} | 
                                                                     {7{Num6CntAble}}&{1'b1,3'd6,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} ) | 
                                     {7{(reOutDate[23:21] == 1)}} & ({7{Num2CntAble}}&{1'b1,3'd2,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} | 
                                                                     {7{Num3CntAble}}&{1'b1,3'd3,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} | 
                                                                     {7{Num4CntAble}}&{1'b1,3'd4,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} | 
                                                                     {7{Num5CntAble}}&{1'b1,3'd5,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} | 
                                                                     {7{Num6CntAble}}&{1'b1,3'd6,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} ) | 
                                     {7{(reOutDate[23:21] == 2)}} & ({7{Num3CntAble}}&{1'b1,3'd3,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} | 
                                                                     {7{Num4CntAble}}&{1'b1,3'd4,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} | 
                                                                     {7{Num5CntAble}}&{1'b1,3'd5,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} | 
                                                                     {7{Num6CntAble}}&{1'b1,3'd6,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} ) | 
                                     {7{(reOutDate[23:21] == 3)}} & ({7{Num4CntAble}}&{1'b1,3'd4,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} | 
                                                                     {7{Num5CntAble}}&{1'b1,3'd5,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} | 
                                                                     {7{Num6CntAble}}&{1'b1,3'd6,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} ) | 
                                     {7{(reOutDate[23:21] == 4)}} & ({7{Num5CntAble}}&{1'b1,3'd5,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} | 
                                                                     {7{Num6CntAble}}&{1'b1,3'd6,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} ) | 
                                     {7{(reOutDate[23:21] == 5)}} & ({7{Num6CntAble}}&{1'b1,3'd6,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} ) ;

    assign OutDateAble = ROBBranch   ;
    assign OutUpDatePc = ROBBranchPc ;
    assign OutUpNum    = reOutDate[23:21] ;
    assign OutUpDate   = ROBBranchMo ? ((reOutDate[20:18] == 0) ? reOutDate[20:18] : reOutDate[20:18] + 1) : 
                                       ((reOutDate[20:18] == 0) ? reOutDate[20:18] : reOutDate[20:18] - 1) ;
    assign OutUpCnt    = ROBBranchYN ? ((PreDictCnt == 0) ? PreDictCnt : PreDictCnt + 1) :
                                       ((PreDictCnt == 0) ? PreDictCnt : PreDictCnt - 1) ;
    assign NewDateAble = NewAble ;
    assign NewUpDate   = NewDate ;
    assign NewUpCnt    = 3'd0    ;
    assign NewUpNum    = NewNum  ;


endmodule
