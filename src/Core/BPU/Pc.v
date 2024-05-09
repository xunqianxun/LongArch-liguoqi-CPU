`timescale 1ps/1ps
`include "../define.v"

module Pc (
    input          wire                                    Clk            ,
    input          wire                                    Rest           ,
    //from ctrl
    input          wire                                    PcStop         , //stop also include icache req stop
    //from btb
    input          wire                                    BtbPredictAble ,
    input          wire          [`InstAddrBus]            BtbPreDictPc   ,
    //from predecode 
    input          wire                                    PreReDirAble   ,
    input          wire          [`InstAddrBus]            PreReDirPc     ,
    //from ROb
    input          wire                                    RobReDirAble   ,
    input          wire          [`InstAddrBus]            RobReDirPc     ,
    //to ICache and bpu
    output         wire                                    PcAble         ,
    output         wire          [`InstAddrBus]            PcDate                        
);

    reg [`InstAddrBus] RegPc      ;
    reg                RegAble    ;

    always @(posedge Clk) begin
        if(!Rest) begin
            RegPc   <= `_Entry      ;
            RegAble <= `EnableValue ;
        end
        else begin
            if(BtbPredictAble) begin
                RegPc   <= BtbPreDictPc  ;
                RegAble <= `AbleValue    ;
            end
            if(PcStop) begin
                RegPc   <= RegPc        ;
                RegAble <= RegAble      ;
            end
            if(PreReDirAble) begin
                RegPc   <= PreReDirPc    ; 
                RegAble <= `AbleValue    ;
            end
            if(RobReDirAble) begin
                RegPc   <= RobReDirPc    ;
                RegAble <= `AbleValue    ;
            end
        end
    end

    assign PcDate          = RegPc      ;
    assign PcAble          = RegAble    ;

    
endmodule  
