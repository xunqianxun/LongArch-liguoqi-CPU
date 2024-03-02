`timescale 1ps/1ps
`include "define.v"

module Tage (
    input          wire                                           Clk               ,
    input          wire                                           Rest              ,
    input          wire           [`InstAddrBus]                  Pc                ,

    output         wire                                           Fpredict          ,
    output         wire           [2:0]                           Fselect           ,
    output         wire           [`TageGHRBus]                   FGHR              ,
    output         wire           [`InstAddrBus]                  FPc               ,

    input          wire                                           UpdataPredict     ,
    input          wire           [2:0]                           UpdataSelect      ,
    input          wire           [`TageGHRBus]                   UpdataGHR         ,
    input          wire           [`InstAddrBus]                  UpdataPc                           
);

    

    //for Predict 


    
endmodule