`timescale 1ps/1ps
`include "../define.v"

module CtrlBlock (
    input        wire                                      Clk              ,
    input        wire                                      Rest             ,

    //for bpu
    output       wire                                      StopToPc         ,
    output       wire                                      StopToBtb        ,
    output       wire                                      StopToTag        ,
    output       wire                                      IcacheFLash      ,

    output       wire                                      PredStop         ,
    output       wire                                      PredFlash        ,
    output       wire                                      FTQStop          ,
    output       wire                                      FTQFlash         ,
    
    input        wire                                      IcReq            ,
    input        wire                                      BrReq            ,
    input        wire                                      PreReq           ,
    input        wire                                      FTQReq           ,


);

endmodule
