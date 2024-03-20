`timescale 1ps/1ps
`include "define.v"

module CtrlBlock (
    input        wire                                      Clk              ,
    input        wire                                      Rest             ,

    //from ROB
    input        wire                                      ROBReload        ,
    //to FTQ
    output       wire                                      FTQFlash         ,
    //to BPCheck 
    output       wire                                      BPCheckFlash     ,
    //to InstQueue
    output       wire                                      InstQueFlash     ,
    //to Decode
    output       wire                                      DecodeFlash      ,
    //to Dispath 
    output       wire                                      DispathFlash     ,
    //to AllRS    
    output       wire                                      AllRSFlash       ,
    //to EU
    output       wire                                      EUFlash          ,
    //to ROB(aRAT) anf RAT
    output       wire                                      aRATRemapping    
);

    reg ReMap ;
    always @(posedge Clk ) begin
        if(!Rest)
            ReMap <= `EnableValue ;
        else 
            ReMap <= ROBReload ;
    end

    assign {FTQFlash, BPCheckFlash, InstQueFlash, InstQueFlash, DecodeFlash, DispathFlash, AllRSFlash, EUFlash} =
            ROBReload ? {`AbleValue, `AbleValue, `AbleValue, `AbleValue, `AbleValue, `AbleValue, `AbleValue, `AbleValue} : 
                        {`EnableValue, `EnableValue, `EnableValue, `EnableValue, `EnableValue, `EnableValue, `EnableValue, `EnableValue} ;
    assign aRATRemapping = ReMap ? `AbleValue : `EnableValue ;
    
endmodule
