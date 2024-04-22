`timescale 1ps/1ps
`include "../define.v"

module BpuGroup (
    input          wire                                      Clk          ,
    input          wire                                      Rest         ,
    //for ctrl 
    input          wire                                      FetchTQStop  ,
    input          wire                                      FetchTQFlash ,
    output         wire                                      FetchReq     ,
    //from ROB 
    input          wire                                      Inst1Commit  ,
    input          wire                                      Inst2Commit  ,
    input          wire                                      Inst3Commit  ,
    input          wire                                      Inst4Commit  ,
    //for BTB
    input          wire          [`InstAddrBus]              PredictPc    , //btb predict will delay 1 cycle
    input          wire          [2:0]                       PredictType  ,
    //for RAS
    input          wire          [`InstAddrBus]              RasStackPc   ,
    input          wire          [3:0]                       RasStackPtr  ,
    input          wire          [`InstAddrBus]              RasStack1    ,
    input          wire          [6:0]                       RsaSrackC1   ,
    input          wire          [`InstAddrBus]              RasStack2    ,
    input          wire          [6:0]                       RsaSrackC2   ,
    input          wire          [`InstAddrBus]              RasStack3    ,
    input          wire          [6:0]                       RsaSrackC3   ,
    //for Tage
    input          wire                                      TageMode     ,
    input          wire          [63:0]                      TageGHR
    //to BTB
    output         wire                                      UpBtbAble    ,
    output         wire          [`InstAddrBus]              UpBtbPc      ,
    output         wire          [2:0]                       UpBtbType    ,
    output         wire          [`InstAddrBus]              UpBtbTaget   ,
    //to RAS 
    output         wire                                      UpRasReLoad  ,
    output         wire                                      UpRasAble    ,
    output         wire          [3:0]                       UpRasPtr     ,
    output         wire          [`InstAddrBus]              UpRasStack1  ,
    output         wire          [6:0]                       UpRasStackC1 ,
    output         wire          [`InstAddrBus]              UpRasStack2  ,
    output         wire          [6:0]                       UpRasStackC2 ,
    output         wire          [`InstAddrBus]              UpRasStack3  ,
    output         wire          [6:0]                       UpRasStackC3 ,
    //to tage 
    output         wire                                      UpTageReLoad ,
    output         wire                                      UpTageAble   ,
    output         wire          [`InstAddrBus]              UpTagePc     ,
    output         wire          [63:0]                      UpTageGHR    ,
    output         wire                                      UpTageMode   ,
    //from predecode
    input          wire                                      InstPreDAble ,
    input          wire          [5:0]                       InstPreDPtr  ,
    input          wire          [2:0]                       InstPreDNum  ,
    input          wire          [2:0]                       InstPreDType ,
    input          wire          [`InstAddrBus]              InstPreDPc   
              
);

    reg   [260:0]  BPUQUEUELINR [0:64] ;

    wire  [6:0]  BGWritePtr ;
    wire  [6:0]  BGReadPtr  ;

    integer i ;
    integer a ;
    always @(posedge Clk) begin
        if(!Rest) begin
           for (i =0 ;i<=31 ;i=i+1 ) begin
                BPUQUEUELINR[i] <= 7'd0 ;
            end
            for (a =32 ;a<=64 ;a=a+1 ) begin
                BPUQUEUELINR[a] <= 7'd0 ;
            end 
        end 
        else if(FetchTQFlash) begin
            for (i =0 ;i<=31 ;i=i+1 ) begin
                BPUQUEUELINR[i] <= 7'd0 ;
            end
            for (a =32 ;a<=64 ;a=a+1 ) begin
                BPUQUEUELINR[a] <= 7'd0 ;
            end 
        end 
        else begin
           BPUQUEUELINR[BGWritePtr] <= 
        end
    end

    CRIQBPU#(
        .CRIQWIDE    ( 7 ),
        .CRIQDEEP    ( 64 )
    )u_CRIQBPU(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .Rable       ( Rable       ),
        .CriqPreOut  ( CriqPreOut  ),
        .Wable       ( Wable       ),
        .Din         ( Din         ),
        .CriqClean   ( CriqClean   ),
        .CriqFull    ( CriqFull    )
    );

    
endmodule