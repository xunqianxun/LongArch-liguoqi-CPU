`timescale 1ps/1ps
`include "IPsetting.v"

module CompressCriq #(
    parameter  WIDE = 61 
) (
    input        wire                                       Clk            ,
    input        wire                                       Rest           ,
    
    input        wire                                       InInst1Able    ,
    input        wire          [WIDE-1:0]                   InInst1Infor   ,
    input        wire                                       InInst2Able    ,
    input        wire          [WIDE-1:0]                   InInst2Infor   ,
    input        wire                                       InInst3Able    ,
    input        wire          [WIDE-1:0]                   InInst3Infor   ,
    input        wire                                       InInst4Able    ,
    input        wire          [WIDE-1:0]                   InInst4Infor   ,

    
);
    
endmodule