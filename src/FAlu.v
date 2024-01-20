`timescale 1ps/1ps 
`include "define.v" 

module FAlu #(
    parameter WIDTH_FALU = 32
) (
    input       wire                                           Clk               ,
    input       wire                                           Rest              ,
    
    input       wire       [`MicOperateCode]                   FAluMicOperate    ,
    input       wire       [`InstAddrBus]                      FaluInstAddr      ,
    input       wire                                           FpredictValue     ,
    input       wire       [WIDTH_FALU-1:0]                    FJumpOffset       ,
    input       wire       [WIDTH_FALU*2-1:0]                  FArchRegister1    ,
    input       wire       [WIDTH_FALU*2-1:0]                  FArchRegister2    ,
    input       wire       [WIDTH_FALU-1:0]                    Fcsr0Data         ,
    input       wire       [`ArchRegBUs]                       InRdaddr          ,
    
    output      wire       [`ArchRegBUs]                       OutRdAddr         ,
    output      wire       [WIDTH_FALU*2-1:0]                  OutRddata         ,
    output      wire                                           OutDataAble       ,
    output      wire       [`InstAddrBus]                      JumpFaluPc        ,
    output      wire                                           JumpFaluvalue     ,
    output      wire                                           ReqIsQInst        ,
    output      wire       [WIDTH_FALU-1:0]                    OutFcsr0          
);

    reg           [WIDTH_FALU-1:0]      FCSR0;
    reg                                 CFR  ;

    wire unsigned [7:0]   F32ExponentR1 ;
    wire unsigned [7:0]   F32ExponentR2 ;
    assign F32ExponentR1 = FArchRegister1[30:23]     ;
    assign F32ExponentR2 = FArchRegister2[30:23]     ;
    //select operate number
    wire          [WIDTH_FALU*2-1:0]    OperateNumbA ;
    wire          [WIDTH_FALU*2-1:0]    OperateNumbB ;
    assign OperateNumbA = (F32ExponentR1>F32ExponentR2)? FArchRegister1:FArchRegister2;
    assign OperateNumbB = (F32ExponentR1>F32ExponentR2)? FArchRegister2:FArchRegister1;
    // wire signed   [22:0]  signedEnumbA;
    // wire signed   [22:0]  signedEnumbB;
    // assign signedEnumbA = OperateNumbA[22:0];
    // assign signedEnumbB = OperateNumbB[22:0];

    wire          [7:0]   DistanceOp                 ;
    assign DistanceOp   = F32ExponentR1-F32ExponentR2;
    //corresponding order
    wire          [31:0]  FractionCor  ;
    wire          [31:0]  FractionSor  ;
    assign FractionCor  = {1'b0,OperateNumbB[22:0],8'b0} >> DistanceOp;
    assign FractionSor  = {1'b0,OperateNumbA[22:0],8'b0}              ;
    //for adder
    wire          [31:0]  FlotAdder    ;
    assign FlotAdder    = FractionCor + FractionSor;
    wire          [7:0]   LeftShiftExp ;
    assign LeftShiftExp = FlotAdder[31]?DistanceOp-1:DistanceOp;
    wire          [31:0]  LeftShiftFra ;
    assign LeftShiftFra = FlotAdder[31]?FlotAdder   :FlotAdder<<1'b1;
    wire          [22:0]  RoundoffFra  ;
    assign RoundoffFra  = (FCSR0[9:8] == `FlotRNE)?((LeftShiftFra[8])?LeftShiftFra[31:9]+1:LeftShiftFra[31:9]):
                          (FCSR0[9:8] == `FlotRP) ?((~(OperateNumbA[31])&(LeftShiftFra[8:0] != 9'b0))?LeftShiftFra[31:9]+1:LeftShiftFra[31:9]):
                          (FCSR0[9:8] == `FlotRM) ?(( (OperateNumbA[31])&(LeftShiftFra[8:0] != 9'b0))?LeftShiftFra[31:9]+1:LeftShiftFra[31:9]):
                          (FCSR0[9:8] == `FLotRZ) ?LeftShiftFra[31:9] :23'b0;
    




    
endmodule