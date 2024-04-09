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
    //input       wire        [`InstAddrBus]                Inst1PcDate      ,  //will write to rob this module un use
    // input       wire                                      In1Parten        ,
    // input       wire        [`InstAddrBus]                In1PredictAddr   ,
    input       wire                                      In1ImmAble       ,
    input       wire        [25:0]                        In1ImmDate       ,
    input       wire                                      In2aAble         ,
    input       wire        [`MicOperateCode]             In2MicOpcode     ,
    // input       wire                                      In2Parten        ,
    // input       wire        [`InstAddrBus]                In2PredictAddr   ,
    input       wire                                      In2ImmAble       ,
    input       wire        [25:0]                        In2ImmDate       ,
    input       wire                                      In3aAble         ,
    input       wire        [`MicOperateCode]             In3MicOpcode     ,
    // input       wire                                      In3Parten        ,
    // input       wire        [`InstAddrBus]                In3PredictAddr   ,
    input       wire                                      In3ImmAble       ,
    input       wire        [25:0]                        In3ImmDate       ,
    input       wire                                      In4aAble         ,
    input       wire        [`MicOperateCode]             In4MicOpcode     ,
    // input       wire                                      In4Parten        ,
    // input       wire        [`InstAddrBus]                In4PredictAddr   ,
    input       wire                                      In4ImmAble       ,
    input       wire        [25:0]                        In4ImmDate       ,
    //from Issue 
    input       wire                                      WillAble1        ,
    input       wire        [`ReNameRegBUs]               WillAble1Addr    ,
    input       wire                                      WillAble2        ,
    input       wire        [`ReNameRegBUs]               WillAble2Addr    ,
    input       wire                                      WillAble3        ,
    input       wire        [`ReNameRegBUs]               WillAble3Addr    ,
    input       wire                                      WillAble4        ,
    input       wire        [`ReNameRegBUs]               WillAble4Addr    ,
    input       wire                                      WillAble5        ,
    input       wire        [`ReNameRegBUs]               WillAble5Addr    ,
    input       wire                                      WillAble6        ,
    input       wire        [`ReNameRegBUs]               WillAble6Addr    ,
    input       wire                                      WillAble7        ,
    input       wire        [`ReNameRegBUs]               WillAble7Addr    ,
    input       wire                                      WillAble8        ,
    input       wire        [`ReNameRegBUs]               WillAble8Addr    ,
    //to issue
    output      wire                                      Inst1CanIssue    ,
    output      wire        []
);

    reg [58:0] INTISSUE [0:32] ; // (valid2 + sec2)8 | (valid1 + sec1)8 | (validrd + rd)8 | MicOpcode 8 | (validimm1 + Imm 26)27 ;

    //four write four read criq
    reg [5:0]  ReadPtr ;
    reg [5:0]  WritePtr ;

    wire [2:0] InstNumber = (In1aAble & ~In2aAble & ~In3aAble & ~In4aAble) ? 4'd1 :
                            (In1aAble &  In2aAble & ~In3aAble & ~In4aAble) ? 4'd2 :
                            (In1aAble &  In2aAble &  In3aAble & ~In4aAble) ? 4'd3 :
                            (In1aAble &  In2aAble &  In3aAble &  In4aAble) ? 4'd4 : 4'd0 ;

    always @(posedge Clk) begin
        if(!Rest) begin
            WritePtr <= 6'd0 ;
        end
        else if(IsQuIntFlash) begin
            WritePtr <= 6'd0 ;
        end
        else begin
            WritePtr <= ~IsQuIntStop ? WritePtr + InstNumber : WritePtr ;
        end
    end

    wire [5:0] Inst1BufferPtr = WritePtr ;
    wire [5:0] Inst2BufferPtr = (WritePtr == 32) ? 0 : WritePtr + 1 ;
    wire [5:0] Inst3BufferPtr = (WritePtr == 31) ? 0 : 
                                (WritePtr == 32) ? 1 : WritePtr + 2 ;
    wire [5:0] Inst4BufferPtr = (WritePtr != 30) ? 0 :
                                (WritePtr != 31) ? 1 :
                                (WritePtr != 32) ? 2 : WritePtr + 3 ;

    integer i ;
    always @(posedge Clk) begin
        if(!Rest) begin
            for (i = 0;i < 32 ;i=i+1 ) begin
                INTISSUE <= 59'd0 ; 
            end
        end
        else if(IsQuIntFlash) begin
            for (i = 0;i < 32 ;i=i+1 ) begin
                INTISSUE <= 59'd0 ; 
            end
        end
        else begin
            INTISSUE[Inst1BufferPtr] <= In1aAble ? {In1Src2Able,In1Src2Addr,In1Src1Able,In1Src1Addr,In1RdAble,In1RdAddr,In1MicOpcode,In1ImmAble,In1ImmDate};
            INTISSUE[Inst2BufferPtr] <= In2aAble ? {In2Src2Able,In2Src2Addr,In2Src1Able,In2Src1Addr,In2RdAble,In2RdAddr,In2MicOpcode,In2ImmAble,In2ImmDate};
            INTISSUE[Inst3BufferPtr] <= In3aAble ? {In3Src2Able,In3Src2Addr,In3Src1Able,In3Src1Addr,In3RdAble,In3RdAddr,In3MicOpcode,In3ImmAble,In3ImmDate};
            INTISSUE[Inst4BufferPtr] <= In4aAble ? {In4Src2Able,In4Src2Addr,In4Src1Able,In4Src1Addr,In4RdAble,In4RdAddr,In4MicOpcode,In4ImmAble,In4ImmDate};
        end
    end

    always @(posedge Clk) begin
        if(!Rest) begin
            ReadPtr <= 6'd0 ;
        end
        else if(IsQuIntFlash) begin
            ReadPtr <= 6'd0 ;
        end
        else begin
            
        end
    end


    //压缩队列


    
endmodule 