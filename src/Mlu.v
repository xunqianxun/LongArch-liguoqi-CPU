`include "define.v"
module Mul (
    input         wire                                 Clk             ,
    input         wire                                 Rest            ,

    input         wire      [`MicOperateCode]          MultipMicOperate,
    input         wire                                 MultipAbleValue ,
    input         wire      [`DataBus]                 Multiplier      ,
    input         wire      [`DataBus]                 Multiplicand    ,
    output        wire      [`DataBus]                 ProductDate     ,
    output        wire                                 ProductAbleValue,
);
    
endmodule