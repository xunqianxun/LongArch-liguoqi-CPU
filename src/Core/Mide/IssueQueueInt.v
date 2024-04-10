`timescale 1ps/1ps
`include "../define.v"

module IssueQueueInt (
    input       wire                                      Clk              ,
    input       wire                                      Rest             ,
    //for ctrl    
    input       wire                                      IsQuIntStop      ,
    input       wire                                      IsQuIntFlash     ,
    output      wire                                      IsQuIntReq       ,
    //from RAT
    input       wire                                      In1Src1Able      ,
    input       wire        [`ReNameRegBUs]               In1Src1Addr      ,
    input       wire                                      In1Src2Able      ,
    input       wire        [`ReNameRegBUs]               In1Src2Addr      ,
    input       wire                                      In1RdAble        ,
    input       wire        [`ReNameRegBUs]               In1RdAddr        ,
    input       wire                                      In2Src1Able      ,
    input       wire        [`ReNameRegBUs]               In2Src1Addr      ,
    input       wire                                      In2Src2Able      ,
    input       wire        [`ReNameRegBUs]               In2Src2Addr      ,
    input       wire                                      In2RdAble        ,
    input       wire        [`ReNameRegBUs]               In2RdAddr        ,
    input       wire                                      In3Src1Able      ,
    input       wire        [`ReNameRegBUs]               In3Src1Addr      ,
    input       wire                                      In3Src2Able      ,
    input       wire        [`ReNameRegBUs]               In3Src2Addr      ,
    input       wire                                      In3RdAble        ,
    input       wire        [`ReNameRegBUs]               In3RdAddr        ,
    input       wire                                      In4Src1Able      ,
    input       wire        [`ReNameRegBUs]               In4Src1Addr      ,
    input       wire                                      In4Src2Able      ,
    input       wire        [`ReNameRegBUs]               In4Src2Addr      ,
    input       wire                                      In4RdAble        ,
    input       wire        [`ReNameRegBUs]               In4RdAddr        ,
    //from decode delay 1 clcye
    input       wire                                      In1aAble         ,
    input       wire        [`MicOperateCode]             In1MicOpcode     ,
    input       wire                                      In1ImmAble       ,
    input       wire        [25:0]                        In1ImmDate       ,
    input       wire                                      In2aAble         ,
    input       wire        [`MicOperateCode]             In2MicOpcode     ,
    input       wire                                      In2ImmAble       ,
    input       wire        [25:0]                        In2ImmDate       ,
    input       wire                                      In3aAble         ,
    input       wire        [`MicOperateCode]             In3MicOpcode     ,
    input       wire                                      In3ImmAble       ,
    input       wire        [25:0]                        In3ImmDate       ,
    input       wire                                      In4aAble         ,
    input       wire        [`MicOperateCode]             In4MicOpcode     ,
    input       wire                                      In4ImmAble       ,
    input       wire        [25:0]                        In4ImmDate       ,
    //Weak-up sign
    input       wire                                      FromIsQBrJum     ,
    input       wire        [`ReNameRegBUs]               FromBrJumAddr    , //delay weakup
    input       wire                                      ByPassDiv        ,
    input       wire        [`ReNameRegBUs]               ByPassDivAddr    ,
    input       wire                                      ByPassCsr        ,
    input       wire        [`ReNameRegBUs]               ByPassCsrrAddr   ,
    input       wire                                      ByPassLoad       ,
    input       wire        [`ReNameRegBUs]               ByPassLoadAddr   ,
    //to delay bus
    output      wire                                      Alu1Inst         ,
    output      wire        [`ReNameRegBUs]               Alu1InstAddr     ,
    output      wire                                      Alu2Inst         ,
    output      wire        [`ReNameRegBUs]               ALu2InstAddr     ,
    output      wire                                      MulInst          ,
    output      wire        [`ReNameRegBUs]               MulInstAddr      ,
    //select inst to Physical
    output      wire        [`MicOperateCode]             Inst1MicOperate  ,
    output      wire                                                          
);

    reg [60:0] INTISSUE [0:32] ; // (valid2 + ready2 + sec2)9 | (valid1 + ready1 + sec1)9 | (validrd + rd)8 | MicOpcode 8 | (validimm1 + Imm 26)27 ;

    integer i ;
    always @(posedge Clk) begin
        if(!Rest) begin
           for (i =0 ;i<33 ;i=i+1 ) begin
                INTISSUE[i] <= 61'd0 ;
           end 
        end
        else if(IsQuIntFlash) begin
            for (i =0 ;i<33 ;i=i+1 ) begin
                INTISSUE[i] <= 61'd0 ;
           end 
        end
        else begin
            
        end
    end

    
endmodule  