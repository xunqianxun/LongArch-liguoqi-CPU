`timescale 1ps/1ps
`include "define.v"

module moduleName #(
    parameter FTQDEEP = 4 //since rename table chackpoint has four 
) (
    input          wire                                      Clk          ,
    input          wire                                      Rest         ,

    input          wire          [`InstAddrBus]              PredictPc    ,
    input          wire          [2:0]                       PredictType  ,
    input          wire          [2:0]                       PredictPosi  ,
    input          wire                                      PredictDirct ,
    input          wire          [`InstAddrBus]              PredictRas   ,
                        
);
    
endmodule