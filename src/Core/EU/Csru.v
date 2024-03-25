`timescale 1ps/1ps
`include "../define.v"

module Csru (
    input        wire                                     Clk            ,
    input        wire                                     Rest           ,
    //input from RS order
    input        wire      [`MicOperateCode]              CsrMicOpCOde   ,
    input        wire      [`DataBus]                     ArchRegDate0   ,
    input        wire      [`DataBus]                     ArchRegDate1   ,
    //write physical regfile
    output       wire      [`DataBus]                     WriteBackDate  ,
    output       wire      [`ReNameRegBUs]                WriteBackAddr  , 
    //to ROB
    output       wire                                     ToRobInterrupt  ,
    output       wire      [6:0]                          ToRobCode       ,
    output       wire                                     ToRobLlbetlKlo  ,
    //to 


);

    
    
endmodule