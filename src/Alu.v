`timescale 1ps/1ps
`include "define.v"

module Alu #(
    parameter WIDTH_ALU = 32
) (
    input        wire                           Clk           ,
    input        wire                           Rest          ,
    
    input        wire      [`MicOperateCode]    AluMicOperate ,
    input        wire      [WIDTH_ALU-1:0]      ArchRegister1 ,
    input        wire      [WIDTH_ALU-1:0]      ArchRegister2 ,
    input        wire      [`ArchRegBUs]        ReDataAddr    ,

    output       wire      [WIDTH_ALU-1:0]      OutReData     ,
    output       wire      [WIDTH_ALU-1:0]      OutReDataAddr ,
    output       wire                           OutDataAble   , 
    output       wire                           ReqIsQInst   
);
    reg  [WIDTH_ALU-1:0] AluData           ;
    wire signed [WIDTH_ALU-1:0] SignedReg1 ;
    wire signed [WIDTH_ALU-1:0] SignedReg2 ;
    wire [WIDTH_ALU-1:0]        SluExtend  ;
    wire [WIDTH_ALU-1:0]        SluExtendU ;
    assign SignedReg1 = ArchRegister1      ;
    assign SignedReg2 = ArchRegister2      ;

    assign SluExtend   = (SignedReg1 < SignedReg2)?{{31{1'b0}},1'b1}:`ZeorDate       ; 
    assign SluExtendU  = (ArchRegister1 < ArchRegister2)?{{31{1'b0}},1'b1}:`ZeorDate ;

    always @(posedge Clk) begin
        if(!Rest)begin
            AluData <= `ZeorDate  ;
        end 
        else begin
            case (AluMicOperate)
                `InstAddw    ,`InstAddiw   : AluData <= ArchRegister1 + ArchRegister2 ;
                `InstSubw                  : AluData <= ArchRegister1 - ArchRegister2 ;
                `InstLu12iw                : AluData <= ArchRegister1                 ;
                `InstSlt     ,`InstSlti    : AluData <= SluExtend                     ;
                `InstSltu    ,`instsltui   : AluData <= SluExtendU                    ;
                `
                default:   AluData <= `ZeorDate                     ;
            endcase
        end
    end

endmodule