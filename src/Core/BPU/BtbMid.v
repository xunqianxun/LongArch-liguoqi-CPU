`timescale 1ps/1ps
`include "../define.v"

module BtbMid (
    input       wire                              Clk           ,
    input       wire                              Rest          ,
    //from Ctrl 
    input       wire                              BMstop        ,
    input       wire                              BMFLash       ,
    //from btb 
    input       wire                              InNextAble    ,
    input       wire     [1:0]                    InHitBanN     ,
    input       wire     [`InstAddrBus]           InNextPc      ,
    input       wire     [2:0]                    InNextType    ,
    output      wire                              OtNextAble    ,
    output      wire     [1:0]                    OtHitBanN     ,
    output      wire     [`InstAddrBus]           OtNextPc      ,
    output      wire     [2:0]                    OtNextType    
);

    reg                   RegNextAble ; 
    reg    [1:0]          RegHitBanN  ;
    reg    [`InstAddrBus] RegNextPc   ;
    reg    [2:0]          RegNextType ;

    always @(posedge Clk) begin
        if(!Rest) begin
            RegNextAble <= 1'b0 ;
            RegHitBanN  <= 2'b0 ;
            RegNextPc   <= 32'd0 ;
            RegNextType <= 3'd0 ;
        end
        else if(BMstop) begin
            RegNextAble <= RegNextAble ;
            RegHitBanN  <= RegHitBanN  ;
            RegNextPc   <= RegNextPc   ;
            RegNextType <= RegNextType ;
        end
        else if(BMFLash) begin
            RegNextAble <= 1'b0 ;
            RegHitBanN  <= 2'b0 ;
            RegNextPc   <= 32'd0 ;
            RegNextType <= 3'd0 ;
        end 
        else begin
            RegNextAble <= InNextAble ;
            RegHitBanN  <= InHitBanN  ;
            RegNextPc   <= InNextPc   ;
            RegNextType <= InNextType ;
        end
    end
    
    assign OtNextAble = RegNextAble ;
    assign OtHitBanN  = RegHitBanN  ;
    assign OtNextPc   = RegNextPc   ;
    assign OtNextType = RegNextType ;

endmodule
