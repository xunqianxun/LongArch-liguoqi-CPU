`timescale 1ps/1ps
`include "../define.v"

module Pc (
    input          wire                                    Clk            ,
    input          wire                                    Rest           ,
    //from ctrl
    input          wire                                    PcStop         , //stop also include icache req stop
    input          wire                                    PcFlash        ,
    //from predecode 
    input          wire                                    PreReDirAble   ,
    input          wire          [`InstAddrBus]            PreReDirOldPc  ,
    input          wire          [`InstAddrBus]            PreReDIrPc     ,
    //from ROb
    input          wire                                    RobReDirAble   ,
    input          wire          [`InstAddrBus]            RobReDirPc     ,
    //to ICache
    output         wire                                    IcacheFlash    ,
    output         wire                                    IcacheFlashAll ,
    output         wire          [`InstAddrBus]            IcacheFlashEnty,
    //to icache and bpu 
    output         wire          [`InstAddrBus]            PcDate                   
);

    reg [`InstAddrBus] RegPc              ;
    reg                RegIcacheFlash     ;
    reg [`InstAddrBus] RegIcacheFlashEnty ;
    reg                RegIcacheFlashAll  ;

    always @(posedge Clk) begin
        if(!Rest) begin
            RegPc              <= `_Entry      ;
            RegIcacheFlash     <= `EnableValue ;
            RegIcacheFlashAll  <= `EnableValue ;
            RegIcacheFlashEnty <= `ZeorDate    ;
        end
        else if(PcFlash)begin
            RegPc              <= `_Entry      ;
            RegIcacheFlash     <= `EnableValue ;
            RegIcacheFlashAll  <= `EnableValue ;
            RegIcacheFlashEnty <= `ZeorDate    ;
        end 
        else if(PcStop) begin
            RegPc              <= RegPc             ;
            RegIcacheFlash     <= RegIcacheFlash    ;
            RegIcacheFlashAll  <= RegIcacheFlashAll ;
            RegIcacheFlashEnty <= RegIcacheFlashEnty;
        end
        else begin
            if(PreReDirAble) begin
                RegPc              <= PreReDIrPc    ;
                RegIcacheFlash     <= `AbleValue    ;
                RegIcacheFlashAll  <= `EnableValue  ;
                RegIcacheFlashEnty <= PreReDirOldPc ; 
            end
            if(RobReDirAble) begin
                RegPc              <= RobReDirPc   ;
                RegIcacheFlash     <= `EnableValue ;
                RegIcacheFlashAll  <= `AbleValue   ;
                RegIcacheFlashEnty <= `ZeorDate    ; 
            end
        end
    end

    assign PcDate          = RegPc              ;
    assign IcacheFlash     = RegIcacheFlash     ;
    assign IcacheFlashAll  = RegIcacheFlashAll  ;
    assign IcacheFlashEnty = RegIcacheFlashEnty ;

    
endmodule  
