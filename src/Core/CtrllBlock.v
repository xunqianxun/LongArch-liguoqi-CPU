`timescale 1ps/1ps
`include "define.v"

module CtrlBlock (
    input     wire                                          Clk               ,
    input     wire                                          Rest              ,

    //input from CSR
    input     wire                                          IdleFlashAble     ,
    input     wire                                          IDleStopAble      , 

);
    
endmodule