`timescale 1ps/1ps
`include "../define.v"

module Pc (
    input          wire                                    Clk           ,
    input          wire                                    Rest          ,
    //from Ctrl
    input          wire                                    PcStop        ,
    input          wire                                    PcFlash       ,
    //from btb
    input          wire                                    BtbAble       ,
    input          wire          [2:0]                     BtbType       ,
    input          wire          [`InstAddrBus]            BtbPc         ,
    //from RAS 
    input          wire                                    RasAble       ,
    input          wire          [`InstAddrBus]            RasAddr       ,
    //from tage   
    input          wire                                    TageAble      ,
    input          wire                                    TageMode      ,
    //from FTQ 
    input          wire                                    ReDirectAble  ,
    input          wire          [`InstAddrBus]            ReDirEctPc    ,
    //from predecode 
    input          wire                                    PreNextAble   ,
    input          wire          [`InstAddrBus]            PreNextPc     ,
    //from ICache
    input          wire                                    IcacheStop    ,
    //to icache and bpu 
    output         wire          [`InstAddrBus]            OutPc         
);


    
endmodule