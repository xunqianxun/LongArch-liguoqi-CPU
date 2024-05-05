`timescale 1ps/1ps
`include "../define.v"

module DCacheStage1 (
    input        wire                                 Clk          ,
    input        wire                                 Rest         ,
    // for ctrl 
    input        wire                                 DcacheStop   ,
    input        wire                                 DcacheFlash  ,
    output       wire                                 DcacheReq    ,
    //from AGU1
    input        wire                                 LoadAble     ,
    output       wire                                 LoadReq      ,
    input        wire     [`InstAddrBus]              LoadPhyAddr  ,
    //from AGU2
    input        wire                                 StoreAble    ,
    output       wire                                 StoreReq     ,
    input        wire     [`InstAddrBus]              StorePhyAddr ,
    
);
    
endmodule