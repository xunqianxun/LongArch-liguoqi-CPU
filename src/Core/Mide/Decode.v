`timescale 1ps/1ps
`include "define.v"

module Decode (
    input     wire                             Clk          ,
    input     wire                             Rest          ,

    //input from Inst queue
    input     wire     [`InstAddrBus]          InDecodePc    ,
    input     wire     [`InstDateBus]          InDecodeInst1 ,
    input     wire     [`InstDateBus]          InDecodeInst2 ,
    input     wire     [`InstDateBus]          InDecodeInst3 ,
    input     wire     [`InstDateBus]          InDecodeInst4 ,

    //input from Rename  map free reg tabe
    

    

);
    
endmodule