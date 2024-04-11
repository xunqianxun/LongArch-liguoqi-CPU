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
    input       wire                                      In1Src1Ready     ,
    input       wire        [`ReNameRegBUs]               In1Src1Addr      ,
    input       wire                                      In1Src2Able      ,
    input       wire                                      In1Src2Ready     ,
    input       wire        [`ReNameRegBUs]               In1Src2Addr      ,
    input       wire                                      In1RdAble        ,
    input       wire        [`ReNameRegBUs]               In1RdAddr        ,
    input       wire                                      In2Src1Able      ,
    input       wire                                      In2Src1Ready     ,
    input       wire        [`ReNameRegBUs]               In2Src1Addr      ,
    input       wire                                      In2Src2Able      ,
    input       wire                                      In2Src2Ready     ,
    input       wire        [`ReNameRegBUs]               In2Src2Addr      ,
    input       wire                                      In2RdAble        ,
    input       wire        [`ReNameRegBUs]               In2RdAddr        ,
    input       wire                                      In3Src1Able      ,
    input       wire                                      In3Src1Ready     ,
    input       wire        [`ReNameRegBUs]               In3Src1Addr      ,
    input       wire                                      In3Src2Able      ,
    input       wire                                      In3Src2Ready     ,
    input       wire        [`ReNameRegBUs]               In3Src2Addr      ,
    input       wire                                      In3RdAble        ,
    input       wire        [`ReNameRegBUs]               In3RdAddr        ,
    input       wire                                      In4Src1Able      ,
    input       wire                                      In4Src1Ready     ,
    input       wire        [`ReNameRegBUs]               In4Src1Addr      ,
    input       wire                                      In4Src2Able      ,
    input       wire                                      In4Src2Ready     ,
    input       wire        [`ReNameRegBUs]               In4Src2Addr      ,
    input       wire                                      In4RdAble        ,
    input       wire        [`ReNameRegBUs]               In4RdAddr        ,
    //from decode delay 1 clcye
    input       wire                                      In1aAble         ,
    input       wire        [`MicOperateCode]             In1MicOpcode     ,
    input       wire                                      In1ImmAble       ,
    input       wire        [25:0]                        In1ImmDate       ,
    input       wire        [6:0]                         In1RobPtr        ,
    input       wire                                      In2aAble         ,
    input       wire        [`MicOperateCode]             In2MicOpcode     ,
    input       wire                                      In2ImmAble       ,
    input       wire        [25:0]                        In2ImmDate       ,
    input       wire        [6:0]                         In2RobPtr        ,
    input       wire                                      In3aAble         ,
    input       wire        [`MicOperateCode]             In3MicOpcode     ,
    input       wire                                      In3ImmAble       ,
    input       wire        [25:0]                        In3ImmDate       ,
    input       wire        [6:0]                         In3RobPtr        ,
    input       wire                                      In4aAble         ,
    input       wire        [`MicOperateCode]             In4MicOpcode     ,
    input       wire                                      In4ImmAble       ,
    input       wire        [25:0]                        In4ImmDate       ,
    input       wire        [6:0]                         In4RobPtr        ,
    //Weak-up sign
    input       wire                                      FromIsQBr        ,
    input       wire        [`ReNameRegBUs]               FromBrAddr       , 
    input       wire                                      FromIsQCsr       ,
    input       wire        [`ReNameRegBUs]               FromCsrAddr      ,//delay broadcast
    input       wire                                      ByPassDiv        ,
    input       wire        [`ReNameRegBUs]               ByPassDivAddr    ,
    input       wire                                      BypassSC         ,
    input       wire        [`ReNameRegBUs]               BypassSCAddr     ,
    input       wire                                      ByPassLoad       ,
    input       wire        [`ReNameRegBUs]               ByPassLoadAddr   ,//bypass
    //in Req
    input       wire                                      Alu1Req          ,
    input       wire                                      ALu2Req          ,
    input       wire                                      MulReq           ,
    input       wire                                      DivReq           ,
    //to delay bus
    output      wire                                      Alu1Inst         , //not only other issuequeue but also busytable
    output      wire        [`ReNameRegBUs]               Alu1InstAddr     ,
    output      wire                                      Alu2Inst         ,
    output      wire        [`ReNameRegBUs]               ALu2InstAddr     ,
    output      wire                                      MulInst          ,
    output      wire        [`ReNameRegBUs]               MulInstAddr      ,
    //select inst to Physical
    output      wire        [`MicOperateCode]             Inst1MicOperate  ,
    output      wire                                      Inst1Src1RAble   ,
    output      wire        [`ReNameRegBUs]               Inst1Src1RAddr   , 
    output      wire                                      Inst1Src2RAble   ,
    output      wire        [`ReNameRegBUs]               Inst1Src2RAddr   ,    
    output      wire                                      Inst1ImmAble     ,
    output      wire        [25:0]                        Inst1ImmDate     ,
    output      wire                                      Inst1RdAble      ,
    output      wire        [`ReNameRegBUs]               Inst1RdAddr      , 
    output      wire        [5:0]                         Inst1RoBptr      ,
    output      wire        [`MicOperateCode]             Inst2MicOperate  ,
    output      wire                                      Inst2Src1RAble   ,
    output      wire        [`ReNameRegBUs]               Inst2Src1RAddr   , 
    output      wire                                      Inst2Src2RAble   ,
    output      wire        [`ReNameRegBUs]               Inst2Src2RAddr   ,    
    output      wire                                      Inst2ImmAble     ,
    output      wire        [25:0]                        Inst2ImmDate     ,
    output      wire                                      Inst2RdAble      ,
    output      wire        [`ReNameRegBUs]               Inst2RdAddr      , 
    output      wire        [5:0]                         Inst2RoBptr      ,
    output      wire        [`MicOperateCode]             Inst3MicOperate  ,
    output      wire                                      Inst3Src1RAble   ,
    output      wire        [`ReNameRegBUs]               Inst3Src1RAddr   , 
    output      wire                                      Inst3Src2RAble   ,
    output      wire        [`ReNameRegBUs]               Inst3Src2RAddr   ,    
    output      wire                                      Inst3ImmAble     ,
    output      wire        [25:0]                        Inst3ImmDate     ,
    output      wire                                      Inst3RdAble      ,
    output      wire        [`ReNameRegBUs]               Inst3RdAddr      , 
    output      wire        [5:0]                         Inst3RoBptr      ,
    output      wire        [`MicOperateCode]             Inst4MicOperate  ,
    output      wire                                      Inst4Src1RAble   ,
    output      wire        [`ReNameRegBUs]               Inst4Src1RAddr   , 
    output      wire                                      Inst4Src2RAble   ,
    output      wire        [`ReNameRegBUs]               Inst4Src2RAddr   ,    
    output      wire                                      Inst4ImmAble     ,
    output      wire        [25:0]                        Inst4ImmDate     ,
    output      wire                                      Inst4RdAble      ,
    output      wire        [`ReNameRegBUs]               Inst4RdAddr      , 
    output      wire        [5:0]                         Inst4RoBptr      
);


    reg [68:0] INTISSUE [0:31] ; // (ROBptr and Age)7 | (valid2 + ready2 + sec2)9 | (valid1 + ready1 + sec1)9 | (validrd + rd)8 | MicOpcode 8 | (validimm1 + Imm 26)27 | ready | ;



    //criq use allocate enty
    reg [5:0]  ReadPtr  ;
    reg [5:0]  WritePtr ;

    reg [5:0]  ALLOCATE [0:32] ;

    wire       Inst1SelectAble ; //需要考虑stop时
    wire       Inst2SelectAble ;
    wire       Inst3SelectAble ;  
    wire       Inst4SelectAble ;
    wire [5:0] Inst1SelectPtr  ;
    wire [5:0] Inst2SelectPtr  ;
    wire [5:0] Inst3SelectPtr  ;
    wire [5:0] Inst4SelectPtr  ;

    wire [3:0]  WriteCriqNum   ; 
    wire [23:0] WriteBufferPtr ;

    assign  {WriteBufferPtr,WriteCriqNum}    =  (({Inst4SelectAble,Inst3SelectAble,Inst2SelectAble,Inst1SelectAble} == 4'b0) & {6'd0,6'd0,6'd0,6'd0,4'd0})                                        |
                                                (({Inst4SelectAble,Inst3SelectAble,Inst2SelectAble,Inst1SelectAble} == 4'b1) & {6'd0,6'd0,6'd0,Inst1SelectPtr,4'd1})                              |
                                                (({Inst4SelectAble,Inst3SelectAble,Inst2SelectAble,Inst1SelectAble} == 4'b2) & {6'd0,6'd0,6'd0,Inst2SelectPtr,4'd1})                              |
                                                (({Inst4SelectAble,Inst3SelectAble,Inst2SelectAble,Inst1SelectAble} == 4'b3) & {6'd0,6'd0,Inst2SelectPtr,Inst1SelectPtr,4'd2})                    |
                                                (({Inst4SelectAble,Inst3SelectAble,Inst2SelectAble,Inst1SelectAble} == 4'b4) & {6'd0,6'd0,6'd0,Inst3SelectPtr,4'd1})                              |
                                                (({Inst4SelectAble,Inst3SelectAble,Inst2SelectAble,Inst1SelectAble} == 4'b5) & {6'd0,6'd0,Inst3SelectPtr,Inst1SelectPtr,4'd2})                    |
                                                (({Inst4SelectAble,Inst3SelectAble,Inst2SelectAble,Inst1SelectAble} == 4'b6) & {6'd0,6'd0,Inst3SelectPtr,Inst2SelectPtr,4'd2})                    |
                                                (({Inst4SelectAble,Inst3SelectAble,Inst2SelectAble,Inst1SelectAble} == 4'b7) & {6'd0,Inst3SelectPtr,Inst2SelectPtr,Inst1SelectPtr,4'd3})          |
                                                (({Inst4SelectAble,Inst3SelectAble,Inst2SelectAble,Inst1SelectAble} == 4'b8) & {6'd0,6'd0,6'd0,Inst4SelectPtr,4'd1})                              |
                                                (({Inst4SelectAble,Inst3SelectAble,Inst2SelectAble,Inst1SelectAble} == 4'b9) & {6'd0,6'd0,Inst4SelectPtr,Inst1SelectPtr,4'd2})                    |
                                                (({Inst4SelectAble,Inst3SelectAble,Inst2SelectAble,Inst1SelectAble} == 4'b10) & {6'd0,6'd0,Inst4SelectPtr,Inst2SelectPtr,4'd2})                   |
                                                (({Inst4SelectAble,Inst3SelectAble,Inst2SelectAble,Inst1SelectAble} == 4'b11) & {6'd0,Inst4SelectPtr,Inst2SelectPtr,Inst1SelectPtr,4'd3})         |
                                                (({Inst4SelectAble,Inst3SelectAble,Inst2SelectAble,Inst1SelectAble} == 4'b12) & {6'd0,6'd0,Inst4SelectPtr,Inst3SelectPtr,4'd2})                   |
                                                (({Inst4SelectAble,Inst3SelectAble,Inst2SelectAble,Inst1SelectAble} == 4'b13) & {6'd0,Inst4SelectPtr,Inst3SelectPtr,Inst1SelectPtr,4'd3})         |
                                                (({Inst4SelectAble,Inst3SelectAble,Inst2SelectAble,Inst1SelectAble} == 4'b14) & {6'd0,Inst4SelectPtr,Inst3SelectPtr,Inst2SelectPtr,4'd3})         |
                                                (({Inst4SelectAble,Inst3SelectAble,Inst2SelectAble,Inst1SelectAble} == 4'b15) & {Inst4SelectPtr,Inst3SelectPtr,Inst2SelectPtr,Inst1SelectPtr,4'd4}); 

    integer i ;
    always @(posedge Clk) begin
        if(!Rest) begin
            for (i = 0;i<32 ;i=i+1 ) begin
                ALLOCATE[i] <= i ;
            end
            ALLOCATE[32] <= 6'd0 ; 
            WritePtr <= 6'd32 ;
        end
        else if(IsQuIntFlash) begin
            for (i = 0;i<32 ;i=i+1 ) begin
                ALLOCATE[i] <= i ;
            end
            ALLOCATE[32] <= 6'd0 ;
            WritePtr <= 6'd32 ;
        end
        else begin
            if(WriteCriqNum == 4'd1) begin
                ALLOCATE[WritePtr] <= WriteBufferPtr[5:0] ;
                WritePtr <= (WritePtr == 32) ? 0 : WritePtr + 1 ;
            end
            if(WriteCriqNum == 4'd2) begin
                ALLOCATE[WritePtr] <= WriteBufferPtr[5:0] ;
                if(WritePtr == 32)
                    ALLOCATE[0] <= WriteBufferPtr[11:6]       ;
                else 
                    ALLOCATE[WritePtr+1] <= WriteBufferPtr[11:6] ;
                WritePtr <= (WritePtr == 31) ? 0 :
                            (WritePtr == 32) ? 1 :
                             WritePtr + 2 ;
            end
            if(WriteCriqNum == 4'd3) begin
                ALLOCATE[WritePtr] <= WriteBufferPtr[5:0] ;
                if(WritePtr == 32) begin
                    ALLOCATE[0] <= WriteBufferPtr[11:6]       ;
                    ALLOCATE[1] <= WriteBufferPtr[17:12]      ;
                end

                else if(WritePtr == 31) begin
                    ALLOCATE[WritePtr+1] <= WriteBufferPtr[11:6] ;
                    ALLOCATE[0] <= WriteBufferPtr[17:12]         ;
                end
                else begin
                    ALLOCATE[WritePtr+1] <= WriteBufferPtr[11:6]  ;
                    ALLOCATE[WritePtr+2] <= WriteBufferPtr[17:12] ;
                end  
                WritePtr <= (WritePtr == 30) ? 0 :
                            (WritePtr == 31) ? 1 :
                            (WritePtr == 32) ? 2 :
                             WritePtr + 3 ;
            end 
            if(WriteCriqNum == 4'd4) begin
                ALLOCATE[WritePtr] <= WriteBufferPtr[5:0] ;
                if(WritePtr == 32) begin
                    ALLOCATE[0] <= WriteBufferPtr[11:6]       ;
                    ALLOCATE[1] <= WriteBufferPtr[17:12]      ;
                    ALLOCATE[2] <= WriteBufferPtr[23:18]      ;
                end

                else if(WritePtr == 31) begin
                    ALLOCATE[WritePtr+1] <= WriteBufferPtr[11:6] ;
                    ALLOCATE[0] <= WriteBufferPtr[17:12]         ;
                    ALLOCATE[1] <= WriteBufferPtr[23:18]         ;
                end
                else if(WritePtr == 30) begin
                    ALLOCATE[WritePtr+1] <= WriteBufferPtr[11:6]  ;
                    ALLOCATE[WritePtr+2] <= WriteBufferPtr[17:12] ;
                    ALLOCATE[0] <= WriteBufferPtr[23:18]          ;
                end
                else begin
                    ALLOCATE[WritePtr+1] <= WriteBufferPtr[11:6]  ;
                    ALLOCATE[WritePtr+2] <= WriteBufferPtr[17:12] ;
                    ALLOCATE[WritePtr+3] <= WriteBufferPtr[23:18] ; 
                end  
                WritePtr <= (WritePtr == 29) ? 0 :
                            (WritePtr == 30) ? 1 :
                            (WritePtr == 31) ? 2 :
                            (WritePtr == 32) ? 3 :
                             WritePtr + 4 ;
            end 
        end
    end

    wire [2:0] NeedAllocateNum = In1aAble & In2aAble & In3aAble & In4aAble ? 3'd4 :
                                 In1aAble & In2aAble & In3aAble & ~In4aAble ? 3'd3 :
                                 In1aAble & In2aAble & ~In3aAble & ~In4aAble ? 3'd2 :
                                 In1aAble & ~In2aAble & ~In3aAble & ~In4aAble ? 3'd1 : 3'd0 ;

    wire [5:0] Read1Ptr = ReadPtr ;
    wire [5:0] Read2Ptr = (ReadPtr==32) ? 0 : ReadPtr + 1;
    wire [5:0] Read3Ptr = (ReadPtr==31) ? 0 : 
                          (ReadPtr==32) ? 1 : ReadPtr + 2;
    wire [5:0] Read4Ptr = (ReadPtr==30) ? 0 : 
                          (ReadPtr==31) ? 1 :
                          (ReadPtr==32) ? 2 : ReadPtr + 3;

    always @(posedge Clk) begin
        if(!Rest) 
            ReadPtr <= 6'd0 ;
        else begin
            if(NeedAllocateNum == 3'd4)
                ReadPtr <= Read4Ptr + 1 ;
            if(NeedAllocateNum == 3'd3)
                ReadPtr <= Read3Ptr + 1 ;
            if(NeedAllocateNum == 3'd2)
                ReadPtr <= Read2Ptr + 1 ;
            if(NeedAllocateNum == 3'd1)
                ReadPtr <= Read1Ptr + 1 ; 
        end
    end

    wire Alu1BroadcastAble ;
    wire Alu1BroadcastAddr ;
    wire Alu2BroadcastAble ;
    wire Alu2BroadcastAddr ;
    wire MulBroadcastAble ;
    wire MulBroadcastAddr ;

    wire Inst1Src2Ready =  ((INTISSUE[0][59:53] == Alu1BroadcastAddr)&Alu1BroadcastAble) | 
                           ((INTISSUE[0][59:53] == Alu2BroadcastAddr)&Alu2BroadcastAble) | 
                           ((INTISSUE[0][59:53] == MulBroadcastAddr) &MulBroadcastAble)  | 
                           ((INTISSUE[0][59:53] == FromBrAddr      ) &FromIsQBr       )  | 
                           ((INTISSUE[0][59:53] == FromCsrAddr     ) &FromIsQCsr      )  | 
                           ((INTISSUE[0][59:53] == ByPassDiv       ) &ByPassDiv       )  | 
                           ((INTISSUE[0][59:53] == BypassSC        ) &BypassSCAddr    )  | 
                           ((INTISSUE[0][59:53] == ByPassLoad      ) &ByPassLoadAddr  )  ;


    integer i ;
    always @(posedge Clk) begin
        if(!Rest) begin
           for (i =0 ;i<33 ;i=i+1 ) begin
                INTISSUE[i] <= 69'd0 ;
           end 
        end
        else if(IsQuIntFlash) begin
            for (i =0 ;i<33 ;i=i+1 ) begin
                INTISSUE[i] <= 69'd0 ;
           end 
        end
        else begin
            INTISSUE[Read1Ptr] <= (In1aAble & ~ IsQuIntStop )? {In1RobPtr,In1Src2Able,In1Src2Ready,In1Src2Addr,In1Src1Able,In1Src1Ready,In1Src1Addr,In1RdAble,In1RdAddr,In1ImmAble,In1ImmDate,In1MicOpcode,`EnableValue} : INTISSUE[Read1Ptr] ;
            INTISSUE[Read2Ptr] <= (In2aAble & ~ IsQuIntStop )? {In2RobPtr,In2Src2Able,In2Src2Ready,In2Src2Addr,In2Src1Able,In2Src1Ready,In2Src1Addr,In2RdAble,In2RdAddr,In2ImmAble,In2ImmDate,In2MicOpcode,`EnableValue} : INTISSUE[Read2Ptr] ;
            INTISSUE[Read3Ptr] <= (In3aAble & ~ IsQuIntStop )? {In3RobPtr,In3Src2Able,In3Src2Ready,In3Src2Addr,In3Src1Able,In3Src1Ready,In3Src1Addr,In3RdAble,In3RdAddr,In3ImmAble,In3ImmDate,In3MicOpcode,`EnableValue} : INTISSUE[Read3Ptr] ;
            INTISSUE[Read4Ptr] <= (In4aAble & ~ IsQuIntStop )? {In4RobPtr,In4Src2Able,In4Src2Ready,In4Src2Addr,In4Src1Able,In4Src1Ready,In4Src1Addr,In4RdAble,In4RdAddr,In4ImmAble,In4ImmDate,In4MicOpcode,`EnableValue} : INTISSUE[Read4Ptr] ;
            INTISSUE[0][60] <= (~INTISSUE[0][61] | INTISSUE[0][60] | IsQuIntStop) ? INTISSUE[0][60] : Inst1Src2Ready ;

        end
    end
    
endmodule  