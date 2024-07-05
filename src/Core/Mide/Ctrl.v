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
    output       wire                                      IsQStop          ,
    output       wire                                      IsQFlash         ,
    output       wire                                      DecodeStop       ,
    output       wire                                      DecodeFlash      ,
    output       wire                                      FlStop           ,
    output       wire                                      FlFlash          ,
    output       wire                                      RATStop          ,
    output       wire                                      RATFlash         ,
    output       wire                                      REFStop          ,
    output       wire                                      REFFlash         ,
    output       wire                                      BYTStop          ,
    output       wire                                      BYTFlash         ,
    output       wire                                      MmuStop          ,
    output       wire                                      MmuFlash         ,
    output       wire                                      IntStop          ,
    output       wire                                      IntFlash         ,
    output       wire                                      BrCsrStop        ,
    output       wire                                      BtCsrFlash       ,
    output       wire                                      MemStop          ,
    output       wire                                      MemFlash         ,
    output       wire                                      PhyStop          ,
    output       wire                                      PhyFlash         ,
    output       wire                                      ROBStop          ,
    output       wire                                      ROBFlash         ,
    output       wire                                      Alu1Stop         , 
    output       wire                                      Alu1Flash        ,
    output       wire                                      Alu2Stop         , 
    output       wire                                      Alu2Flash        ,
    output       wire                                      MluStop          ,
    output       wire                                      MluFlash         ,
    output       wire                                      DivStop          ,
    output       wire                                      DivFlash         ,
    output       wire                                      BruStop          ,
    output       wire                                      BruFlash         ,
    output       wire                                      CsruStop         ,
    output       wire                                      CsruFlash        ,
    output       wire                                      AguLoadStop      ,
    output       wire                                      AguLoadFlash     ,
    output       wire                                      AguStoreStop     ,
    output       wire                                      AguStoreFlash    ,
    output       wire                                      LoadBufferStop   ,
    output       wire                                      LoadBufferFlash  ,
    output       wire                                      StoreBUfferStop  ,
    output       wire                                      StoreBufferFlash ,

    input        wire                                      IcReq            , //只stop stage2 和PC
    input        wire                                      BpReq            , //stop BPU 不需要管Pc暂存数据因为是有Icache缺页所致会造成trap
    input        wire                                      PreReq           , //需要将icache状态和MSHR刷新
    input        wire                                      FTQReq           ,  //FTQ满了需要把前面全暂停
    input        wire                                      ISReq            ,
    input        wire                                      FLReq            ,
    input        wire                                      IsIntReq         ,
    input        wire                                      IsBrReq          ,
    input        wire                                      IsMemReq         ,
    input        wire                                      ROBSReq          ,
    input        wire                                      ROBFReq          ,
    input        wire                                      StoreSReq        ,
    input        wire                                      StoreFReq        

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
    assign IsQStop      = FLReq    ;
    assign IsQFlash     =          ;
    assign DecodeStop   = FLReq    ;
    assign DecodeFlash  =          ;
    assign FlStop       =          ;
    assign FlFalsh      =          ;
    assign RATStop      =          ;
    assign RATFlash     =          ;
    assign REFStop      =          ;
    assign REFFlash     =          ;
    assign BYTStop      =          ;
    assign BYTFlash     =          ;
    assign MmuStop      =          ;
    assign MmuFlash     =          ;




endmodule
