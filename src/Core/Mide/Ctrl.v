`timescale 1ps/1ps
`include "../define.v"

module Ctrl (
    input        wire                                      Clk              ,
    input        wire                                      Rest             ,

    input        wire                                      ROBredir         ,
    //for bpu
    output       wire                                      StopToPc         ,
    output       wire                                      StopToBtb        ,
    output       wire                                      StopMidFlash     ,
    output       wire                                      StopTage         ,
    output       wire                                      FLashTage        ,
    output       wire                                      StopRas          ,
    output       wire                                      FLashRas         ,
    output       wire                                      IcacheFLash      ,
    output       wire                                      IcacheStop       ,
    output       wire                                      PredStop         ,
    output       wire                                      PredFlash        ,
    output       wire                                      FTQStop          ,
    output       wire                                      FTQFlash         ,
    
    input        wire                                      IcReq            , //只stop stage2 和PC
    input        wire                                      BpReq            , //stop BPU 不需要管Pc暂存数据因为是有Icache缺页所致会造成trap
    input        wire                                      PreReq           , //需要将icache状态和MSHR刷新
    input        wire                                      FTQReq           ,  //FTQ满了需要把前面全暂停
    input        wire                                      ISReq            

);

    reg   ICacheTrapReq ;
    always @(posedge Clk) begin
        if(!Rest)          ICacheTrapReq <= 1'b0    ;
        else if(BpReq)     ICacheTrapReq <= BpReq   ;
        else if(ROBredir)  ICacheTrapReq <= ROBredir; 
    end

    assign StopToPc     = IcReq | (BpReq | (ICacheTrapReq & ~ROBredir)) | FTQReq | ISReq ;
    assign StopToBtb    = IcReq | (BpReq | (ICacheTrapReq & ~ROBredir)) | FTQReq | ISReq ; 
    assign StopMidFlash = PreReq | ROBredir ;
    assign StopTage     = IcReq | (BpReq | (ICacheTrapReq & ~ROBredir)) | FTQReq | ISReq ;
    assign FLashTage    = PreReq | ROBredir ;
    assign StopRas      = IcReq | (BpReq | (ICacheTrapReq & ~ROBredir)) | FTQReq | ISReq ; 
    assign FLashRas     = PreReq | ROBredir ;
    assign IcacheStop   = IcReq | (BpReq | (ICacheTrapReq & ~ROBredir)) | FTQReq | ISReq ;
    assign IcacheFLash  = PreReq | ROBredir ;
    assign PredStop     = IcReq | (BpReq | (ICacheTrapReq & ~ROBredir)) | FTQReq | ISReq ;
    assign PredFlash    = ROBredir ;
    assign FTQStop      = IcReq | (BpReq | (ICacheTrapReq & ~ROBredir)) | FTQReq | ISReq ;
    assign FTQFlash     = ROBredir ;


endmodule
