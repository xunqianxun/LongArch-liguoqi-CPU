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

    // wire unsigned [7:0]   F32ExponentR1 ;
    // wire unsigned [7:0]   F32ExponentR2 ;
    // assign F32ExponentR1 = FArchRegister1[30:23]     ;
    // assign F32ExponentR2 = FArchRegister2[30:23]     ;
    // //select operate number
    // wire          [WIDTH_FALU*2-1:0]    OperateNumbA ;
    // wire          [WIDTH_FALU*2-1:0]    OperateNumbB ;
    // assign OperateNumbA = (F32ExponentR1>F32ExponentR2)? FArchRegister1:FArchRegister2;
    // assign OperateNumbB = (F32ExponentR1>F32ExponentR2)? FArchRegister2:FArchRegister1;
    // // wire signed   [22:0]  signedEnumbA;
    // // wire signed   [22:0]  signedEnumbB;
    // // assign signedEnumbA = OperateNumbA[22:0];
    // // assign signedEnumbB = OperateNumbB[22:0];

    // wire          [7:0]   DistanceOp                 ;
    // assign DistanceOp   = F32ExponentR1-F32ExponentR2;
    // //corresponding order
    // wire          [31:0]  FractionCor  ;
    // wire          [31:0]  FractionSor  ;
    // assign FractionCor  = {1'b0,OperateNumbB[22:0],8'b0} >> DistanceOp;
    // assign FractionSor  = {1'b0,OperateNumbA[22:0],8'b0}              ;
    // //for adder
    // wire          [31:0]  FlotAdder    ;
    // assign FlotAdder    = FractionCor + FractionSor;
    // wire          [7:0]   LeftShiftExp ;
    // assign LeftShiftExp = FlotAdder[31]?DistanceOp-1:DistanceOp;
    // wire          [31:0]  LeftShiftFra ;
    // assign LeftShiftFra = FlotAdder[31]?FlotAdder   :FlotAdder<<1'b1;
    // wire          [22:0]  RoundoffFra  ;
    // assign RoundoffFra  = (FCSR0[9:8] == `FlotRNE)?((LeftShiftFra[8])?LeftShiftFra[31:9]+1:LeftShiftFra[31:9]):
    //                       (FCSR0[9:8] == `FlotRP) ?((~(OperateNumbA[31])&(LeftShiftFra[8:0] != 9'b0))?LeftShiftFra[31:9]+1:LeftShiftFra[31:9]):
    //                       (FCSR0[9:8] == `FlotRM) ?(( (OperateNumbA[31])&(LeftShiftFra[8:0] != 9'b0))?LeftShiftFra[31:9]+1:LeftShiftFra[31:9]):
    //                       (FCSR0[9:8] == `FLotRZ) ?LeftShiftFra[31:9] :23'b0;
    
    // //for subber
    // wire          [31:0]  FractionCon  ;
    // wire          [31:0]  FractionSon  ;
    // assign FractionCon  = {OperateNumbB[22:0],9'b0} >> DistanceOp;
    // assign FractionSon  = {OperateNumbA[22:0],9'b0}              ;
    // wire          [31:0]  FlotSubber  ;
    // assign FlotSubber   = FractionCon - FractionSon;
    // wire          [7:0]   LeftShiftExp ;
    // assign LeftShiftExp = FlotAdder[31]?DistanceOp-1:DistanceOp;
    // wire          [31:0]  LeftShiftFra ;
    // assign LeftShiftFra = FlotAdder[31]?FlotAdder   :FlotAdder<<1'b1;
    // wire          [22:0]  RoundoffFra  ;
    // assign RoundoffFra  = (FCSR0[9:8] == `FlotRNE)?((LeftShiftFra[8])?LeftShiftFra[31:9]+1:LeftShiftFra[31:9]):
    //                       (FCSR0[9:8] == `FlotRP) ?((~(OperateNumbA[31])&(LeftShiftFra[8:0] != 9'b0))?LeftShiftFra[31:9]+1:LeftShiftFra[31:9]):
    //                       (FCSR0[9:8] == `FlotRM) ?(( (OperateNumbA[31])&(LeftShiftFra[8:0] != 9'b0))?LeftShiftFra[31:9]+1:LeftShiftFra[31:9]):
    //                       (FCSR0[9:8] == `FLotRZ) ?LeftShiftFra[31:9] :23'b0;


    wire unsigned [7:0]   F32ExponentR1 ;
    wire unsigned [7:0]   F32ExponentR2 ;
    wire signed   [7:0]   F32ExponentTp ;
    wire signed   [7:0]   F32ExponentSh ;
    assign F32ExponentR1 = FArchRegister1[30:23]     ;
    assign F32ExponentR2 = FArchRegister2[30:23]     ;
    assign F32ExponentTp = F32ExponentR1 - F32ExponentR2 ;
    assign F32ExponentSh = (F32ExponentTp[7] == `AbleValue)? -F32ExponentTp : F32ExponentTp ;

    //for adder

    wire          [31:0]  FractionCor  ;
    wire          [31:0]  FractionSor  ;
    assign FractionCor  = FArchRegister1[31]?{2'b11,~{1'b1,FArchRegister1[22:0]}+1,6'b0}:{2'b00,1'b1,FArchRegister1[22:0],6'b0};
    assign FractionSor  = FArchRegister2[31]?{2'b11,~{1'b1,FArchRegister2[22:0]}+1,6'b0}:{2'b00,1'b1,FArchRegister2[22:0],6'b0};
    wire          [31:0]  FractionSh1  ;
    wire          [31:0]  FractionSh2  ;
    assign FractionSh1  = (F32ExponentR1 > F32ExponentR2)?FractionCor:(FractionCor>>F32ExponentTp)|({32{FractionCor[31]}}<<32-F32ExponentTp);
    assign FractionSh2  = (F32ExponentR2 > F32ExponentR1)?FractionSor:(FractionSor>>F32ExponentTp)|({32{FractionSor[31]}}<<32-F32ExponentTp);
    wire          [31:0]  FlotPointAdde;
    assign FlotPointAdde= FractionSh1 + FractionSh2 ;
    wire          [31:0]  Normalize    ;
    wire          [4 :0]  LzaNumber    ;
    wire          [7 :0]  F32ExponentNb;
    // TODO list
    // 1:leading zero prodict
    assign {F32ExponentNb,Normalize}    = (FlotPointAdde[31 != FlotPointAdde[30]])? {(F32ExponentSh+1),(FlotPointAdde>>1)|{FlotPointAdde[31],31'b0}}: 
                                          (FlotPointAdde[31 == FlotPointAdde[30]])? {(F32ExponentSh-LzaNumber),(FlotPointAdde<<LzaNumber)}          ;
    
    wire          [26:0]  RoundoffFra  ;
    assign RoundoffFra  = (FCSR0[9:8] == `FlotRNE)?((Normalize[5])?LeftShiftFra[31:5]+1:LeftShiftFra[31:5]):
                          (FCSR0[9:8] == `FlotRP) ?((~(Normalize[31])&(Normalize[5:0] != 6'b0))?LeftShiftFra[31:5]+1:LeftShiftFra[31:5]):
                          (FCSR0[9:8] == `FlotRM) ?(( (Normalize[31])&(Normalize[5:0] != 6'b0))?LeftShiftFra[31:5]+1:LeftShiftFra[31:5]):
                          (FCSR0[9:8] == `FLotRZ) ?LeftShiftFra[31:5] :26'b0;
    wire          [WIDTH_FALU-1:0] AdderNumber;
    //TODO list
    //1: 四种例外判断并结合FSCR判断是否陷入还是flage
    assign AdderNumber  = {RoundoffFra[26],F32ExponentNb,RoundoffFra[23:0]};


    reg           [WIDTH_FALU*2-1:0]  FaluReg      ;
    reg                               TrapSign     ;
    reg                               FaluWriteAble;

    always @(posedge Clk) begin
        if(!Rest)begin
            FaluReg      <= `FzeroDate;
            TrapSign     <= `EnableValue;
            FaluInstAddr <= `EnableValue;
        end 
        else begin
            case (FAluMicOperate)
                : 
                default: 
            endcase
        end
    end


    
endmodule