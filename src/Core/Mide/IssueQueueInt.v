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


    reg [68:0] INTISSUE [0:31] ; // (ROBptr and Age)7 | (valid2 + ready2 + sec2)9 | (valid1 + ready1 + sec1)9 | (validrd + rd)8 | MicOpcode 8 | (validimm1 + Imm 26)27 | {ready | 暂时不用} ;



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
                                                (({Inst4SelectAble,Inst3SelectAble,Inst2SelectAble,Inst1SelectAble} == 4'd2) & {6'd0,6'd0,6'd0,Inst2SelectPtr,4'd1})                              |
                                                (({Inst4SelectAble,Inst3SelectAble,Inst2SelectAble,Inst1SelectAble} == 4'd3) & {6'd0,6'd0,Inst2SelectPtr,Inst1SelectPtr,4'd2})                    |
                                                (({Inst4SelectAble,Inst3SelectAble,Inst2SelectAble,Inst1SelectAble} == 4'd4) & {6'd0,6'd0,6'd0,Inst3SelectPtr,4'd1})                              |
                                                (({Inst4SelectAble,Inst3SelectAble,Inst2SelectAble,Inst1SelectAble} == 4'd5) & {6'd0,6'd0,Inst3SelectPtr,Inst1SelectPtr,4'd2})                    |
                                                (({Inst4SelectAble,Inst3SelectAble,Inst2SelectAble,Inst1SelectAble} == 4'd6) & {6'd0,6'd0,Inst3SelectPtr,Inst2SelectPtr,4'd2})                    |
                                                (({Inst4SelectAble,Inst3SelectAble,Inst2SelectAble,Inst1SelectAble} == 4'd7) & {6'd0,Inst3SelectPtr,Inst2SelectPtr,Inst1SelectPtr,4'd3})          |
                                                (({Inst4SelectAble,Inst3SelectAble,Inst2SelectAble,Inst1SelectAble} == 4'd8) & {6'd0,6'd0,6'd0,Inst4SelectPtr,4'd1})                              |
                                                (({Inst4SelectAble,Inst3SelectAble,Inst2SelectAble,Inst1SelectAble} == 4'd9) & {6'd0,6'd0,Inst4SelectPtr,Inst1SelectPtr,4'd2})                    |
                                                (({Inst4SelectAble,Inst3SelectAble,Inst2SelectAble,Inst1SelectAble} == 4'd10) & {6'd0,6'd0,Inst4SelectPtr,Inst2SelectPtr,4'd2})                   |
                                                (({Inst4SelectAble,Inst3SelectAble,Inst2SelectAble,Inst1SelectAble} == 4'd11) & {6'd0,Inst4SelectPtr,Inst2SelectPtr,Inst1SelectPtr,4'd3})         |
                                                (({Inst4SelectAble,Inst3SelectAble,Inst2SelectAble,Inst1SelectAble} == 4'd12) & {6'd0,6'd0,Inst4SelectPtr,Inst3SelectPtr,4'd2})                   |
                                                (({Inst4SelectAble,Inst3SelectAble,Inst2SelectAble,Inst1SelectAble} == 4'd13) & {6'd0,Inst4SelectPtr,Inst3SelectPtr,Inst1SelectPtr,4'd3})         |
                                                (({Inst4SelectAble,Inst3SelectAble,Inst2SelectAble,Inst1SelectAble} == 4'd14) & {6'd0,Inst4SelectPtr,Inst3SelectPtr,Inst2SelectPtr,4'd3})         |
                                                (({Inst4SelectAble,Inst3SelectAble,Inst2SelectAble,Inst1SelectAble} == 4'd15) & {Inst4SelectPtr,Inst3SelectPtr,Inst2SelectPtr,Inst1SelectPtr,4'd4}); 

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

    wire InIssue1Src2Ready =((In1Src2Addr == Alu1BroadcastAddr)&Alu1BroadcastAble) | 
                            ((In1Src2Addr == Alu2BroadcastAddr)&Alu2BroadcastAble) | 
                            ((In1Src2Addr == MulBroadcastAddr) &MulBroadcastAble)  | 
                            ((In1Src2Addr == FromBrAddr      ) &FromIsQBr       )  | 
                            ((In1Src2Addr == FromCsrAddr     ) &FromIsQCsr      )  | 
                            ((In1Src2Addr == ByPassDiv       ) &ByPassDiv       )  | 
                            ((In1Src2Addr == BypassSC        ) &BypassSCAddr    )  | 
                            ((In1Src2Addr == ByPassLoad      ) &ByPassLoadAddr  )  ;
                        
    wire InIssue2Src2Ready =((In2Src2Addr == Alu1BroadcastAddr)&Alu1BroadcastAble) | 
                            ((In2Src2Addr == Alu2BroadcastAddr)&Alu2BroadcastAble) | 
                            ((In2Src2Addr == MulBroadcastAddr) &MulBroadcastAble)  | 
                            ((In2Src2Addr == FromBrAddr      ) &FromIsQBr       )  | 
                            ((In2Src2Addr == FromCsrAddr     ) &FromIsQCsr      )  | 
                            ((In2Src2Addr == ByPassDiv       ) &ByPassDiv       )  | 
                            ((In2Src2Addr == BypassSC        ) &BypassSCAddr    )  | 
                            ((In2Src2Addr == ByPassLoad      ) &ByPassLoadAddr  )  ;

    wire InIssue3Src2Ready =((In3Src2Addr == Alu1BroadcastAddr)&Alu1BroadcastAble) | 
                            ((In3Src2Addr == Alu2BroadcastAddr)&Alu2BroadcastAble) | 
                            ((In3Src2Addr == MulBroadcastAddr) &MulBroadcastAble)  | 
                            ((In3Src2Addr == FromBrAddr      ) &FromIsQBr       )  | 
                            ((In3Src2Addr == FromCsrAddr     ) &FromIsQCsr      )  | 
                            ((In3Src2Addr == ByPassDiv       ) &ByPassDiv       )  | 
                            ((In3Src2Addr == BypassSC        ) &BypassSCAddr    )  | 
                            ((In3Src2Addr == ByPassLoad      ) &ByPassLoadAddr  )  ;

    wire InIssue4Src2Ready =((In4Src2Addr == Alu1BroadcastAddr)&Alu1BroadcastAble) | 
                            ((In4Src2Addr == Alu2BroadcastAddr)&Alu2BroadcastAble) | 
                            ((In4Src2Addr == MulBroadcastAddr) &MulBroadcastAble)  | 
                            ((In4Src2Addr == FromBrAddr      ) &FromIsQBr       )  | 
                            ((In4Src2Addr == FromCsrAddr     ) &FromIsQCsr      )  | 
                            ((In4Src2Addr == ByPassDiv       ) &ByPassDiv       )  | 
                            ((In4Src2Addr == BypassSC        ) &BypassSCAddr    )  | 
                            ((In4Src2Addr == ByPassLoad      ) &ByPassLoadAddr  )  ;

    wire InIssue1Src1Ready =((In1Src1Addr == Alu1BroadcastAddr)&Alu1BroadcastAble) | 
                            ((In1Src1Addr == Alu2BroadcastAddr)&Alu2BroadcastAble) | 
                            ((In1Src1Addr == MulBroadcastAddr) &MulBroadcastAble)  | 
                            ((In1Src1Addr == FromBrAddr      ) &FromIsQBr       )  | 
                            ((In1Src1Addr == FromCsrAddr     ) &FromIsQCsr      )  | 
                            ((In1Src1Addr == ByPassDiv       ) &ByPassDiv       )  | 
                            ((In1Src1Addr == BypassSC        ) &BypassSCAddr    )  | 
                            ((In1Src1Addr == ByPassLoad      ) &ByPassLoadAddr  )  ;
                        
    wire InIssue2Src1Ready =((In2Src1Addr == Alu1BroadcastAddr)&Alu1BroadcastAble) | 
                            ((In2Src1Addr == Alu2BroadcastAddr)&Alu2BroadcastAble) | 
                            ((In2Src1Addr == MulBroadcastAddr) &MulBroadcastAble)  | 
                            ((In2Src1Addr == FromBrAddr      ) &FromIsQBr       )  | 
                            ((In2Src1Addr == FromCsrAddr     ) &FromIsQCsr      )  | 
                            ((In2Src1Addr == ByPassDiv       ) &ByPassDiv       )  | 
                            ((In2Src1Addr == BypassSC        ) &BypassSCAddr    )  | 
                            ((In2Src1Addr == ByPassLoad      ) &ByPassLoadAddr  )  ;

    wire InIssue3Src1Ready =((In3Src1Addr == Alu1BroadcastAddr)&Alu1BroadcastAble) | 
                            ((In3Src1Addr == Alu2BroadcastAddr)&Alu2BroadcastAble) | 
                            ((In3Src1Addr == MulBroadcastAddr) &MulBroadcastAble)  | 
                            ((In3Src1Addr == FromBrAddr      ) &FromIsQBr       )  | 
                            ((In3Src1Addr == FromCsrAddr     ) &FromIsQCsr      )  | 
                            ((In3Src1Addr == ByPassDiv       ) &ByPassDiv       )  | 
                            ((In3Src1Addr == BypassSC        ) &BypassSCAddr    )  | 
                            ((In3Src1Addr == ByPassLoad      ) &ByPassLoadAddr  )  ;

    wire InIssue4Src1Ready =((In4Src1Addr == Alu1BroadcastAddr)&Alu1BroadcastAble) | 
                            ((In4Src1Addr == Alu2BroadcastAddr)&Alu2BroadcastAble) | 
                            ((In4Src1Addr == MulBroadcastAddr) &MulBroadcastAble)  | 
                            ((In4Src1Addr == FromBrAddr      ) &FromIsQBr       )  | 
                            ((In4Src1Addr == FromCsrAddr     ) &FromIsQCsr      )  | 
                            ((In4Src1Addr == ByPassDiv       ) &ByPassDiv       )  | 
                            ((In4Src1Addr == BypassSC        ) &BypassSCAddr    )  | 
                            ((In4Src1Addr == ByPassLoad      ) &ByPassLoadAddr  )  ;

    wire InstSrc2Ready[0:31] ;
    wire InstSrc1Ready[0:31] ;               
    genvar a ;
    generate
        for ( a=0 ;a<32 ;a=a+1 ) begin
            assign InstSrc2Ready[a]=((INTISSUE[a][59:53] == Alu1BroadcastAddr)&Alu1BroadcastAble) | 
                                    ((INTISSUE[a][59:53] == Alu2BroadcastAddr)&Alu2BroadcastAble) | 
                                    ((INTISSUE[a][59:53] == MulBroadcastAddr) &MulBroadcastAble)  | 
                                    ((INTISSUE[a][59:53] == FromBrAddr      ) &FromIsQBr       )  | 
                                    ((INTISSUE[a][59:53] == FromCsrAddr     ) &FromIsQCsr      )  | 
                                    ((INTISSUE[a][59:53] == ByPassDiv       ) &ByPassDiv       )  | 
                                    ((INTISSUE[a][59:53] == BypassSC        ) &BypassSCAddr    )  | 
                                    ((INTISSUE[a][59:53] == ByPassLoad      ) &ByPassLoadAddr  )  ;
            assign InstSrc1Ready[a]=((INTISSUE[a][50:44] == Alu1BroadcastAddr)&Alu1BroadcastAble) | 
                                    ((INTISSUE[a][50:44] == Alu2BroadcastAddr)&Alu2BroadcastAble) | 
                                    ((INTISSUE[a][50:44] == MulBroadcastAddr) &MulBroadcastAble)  | 
                                    ((INTISSUE[a][50:44] == FromBrAddr      ) &FromIsQBr       )  | 
                                    ((INTISSUE[a][50:44] == FromCsrAddr     ) &FromIsQCsr      )  | 
                                    ((INTISSUE[a][50:44] == ByPassDiv       ) &ByPassDiv       )  | 
                                    ((INTISSUE[a][50:44] == BypassSC        ) &BypassSCAddr    )  | 
                                    ((INTISSUE[a][50:44] == ByPassLoad      ) &ByPassLoadAddr  )  ;
        end
    endgenerate
    

    reg     AluAllocate ;
    wire    AluInstHas  = ((In1aAble & (In1MicOpcode[7:5] == 3'b001)) |
                           (In2aAble & (In2MicOpcode[7:5] == 3'b001)) |
                           (In3aAble & (In3MicOpcode[7:5] == 3'b001)) |
                           (In4aAble & (In4MicOpcode[7:5] == 3'b001))) ? `AbleValue : `EnableValue ; 
    always @(posedge Clk) begin
        if(!Rest) 
            AluAllocate <= `EnableValue ;
        else if(IsQuIntFlash)
            AluAllocate <= `EnableValue ;
        else begin
            AluAllocate <= IsQuIntStop ? AluAllocate  : 
                           AluInstHas  ? ~AluAllocate : AluAllocate ;
        end


    end
    
    integer j ;
    always @(posedge Clk) begin
        if(!Rest) begin
           for (j =0 ;j<33 ;j=j+1 ) begin
                INTISSUE[j] <= 69'd0 ;
            end 
        end
        else if(IsQuIntFlash) begin
            for (j =0 ;j<33 ;j=j+1 ) begin
                INTISSUE[j] <= 69'd0 ;
            end 
        end
        else begin
            INTISSUE[0][60] <= (~INTISSUE[0][61] | INTISSUE[0][60] | IsQuIntStop) ? INTISSUE[0][60] : InstSrc2Ready[0] ;
            INTISSUE[0][51] <= (~INTISSUE[0][52] | INTISSUE[0][51] | IsQuIntStop) ? INTISSUE[0][51] : InstSrc1Ready[0] ;
            INTISSUE[1][60] <= (~INTISSUE[1][61] | INTISSUE[1][60] | IsQuIntStop) ? INTISSUE[1][60] : InstSrc2Ready[1] ;
            INTISSUE[1][51] <= (~INTISSUE[1][52] | INTISSUE[1][51] | IsQuIntStop) ? INTISSUE[1][51] : InstSrc1Ready[1] ;
            INTISSUE[2][60] <= (~INTISSUE[2][61] | INTISSUE[2][60] | IsQuIntStop) ? INTISSUE[2][60] : InstSrc2Ready[2] ;
            INTISSUE[2][51] <= (~INTISSUE[2][52] | INTISSUE[2][51] | IsQuIntStop) ? INTISSUE[2][51] : InstSrc1Ready[2] ;
            INTISSUE[3][60] <= (~INTISSUE[3][61] | INTISSUE[3][60] | IsQuIntStop) ? INTISSUE[3][60] : InstSrc2Ready[3] ;
            INTISSUE[3][51] <= (~INTISSUE[3][52] | INTISSUE[3][51] | IsQuIntStop) ? INTISSUE[3][51] : InstSrc1Ready[3] ;
            INTISSUE[4][60] <= (~INTISSUE[4][61] | INTISSUE[4][60] | IsQuIntStop) ? INTISSUE[4][60] : InstSrc2Ready[4] ;
            INTISSUE[4][51] <= (~INTISSUE[4][52] | INTISSUE[4][51] | IsQuIntStop) ? INTISSUE[4][51] : InstSrc1Ready[4] ;
            INTISSUE[5][60] <= (~INTISSUE[5][61] | INTISSUE[5][60] | IsQuIntStop) ? INTISSUE[5][60] : InstSrc2Ready[5] ;
            INTISSUE[5][51] <= (~INTISSUE[5][52] | INTISSUE[5][51] | IsQuIntStop) ? INTISSUE[5][51] : InstSrc1Ready[5] ;
            INTISSUE[6][60] <= (~INTISSUE[6][61] | INTISSUE[6][60] | IsQuIntStop) ? INTISSUE[6][60] : InstSrc2Ready[6] ;
            INTISSUE[6][51] <= (~INTISSUE[6][52] | INTISSUE[6][51] | IsQuIntStop) ? INTISSUE[6][51] : InstSrc1Ready[6] ;
            INTISSUE[7][60] <= (~INTISSUE[7][61] | INTISSUE[7][60] | IsQuIntStop) ? INTISSUE[7][60] : InstSrc2Ready[7] ;
            INTISSUE[7][51] <= (~INTISSUE[7][52] | INTISSUE[7][51] | IsQuIntStop) ? INTISSUE[7][51] : InstSrc1Ready[7] ;
            INTISSUE[8][60] <= (~INTISSUE[8][61] | INTISSUE[8][60] | IsQuIntStop) ? INTISSUE[8][60] : InstSrc2Ready[8] ;
            INTISSUE[8][51] <= (~INTISSUE[8][52] | INTISSUE[8][51] | IsQuIntStop) ? INTISSUE[8][51] : InstSrc1Ready[8] ;
            INTISSUE[9][60] <= (~INTISSUE[9][61] | INTISSUE[9][60] | IsQuIntStop) ? INTISSUE[9][60] : InstSrc2Ready[9] ;
            INTISSUE[9][51] <= (~INTISSUE[9][52] | INTISSUE[9][51] | IsQuIntStop) ? INTISSUE[9][51] : InstSrc1Ready[9] ;
            INTISSUE[10][60] <= (~INTISSUE[10][61] | INTISSUE[10][60] | IsQuIntStop) ? INTISSUE[10][60] : InstSrc2Ready[10] ;
            INTISSUE[10][51] <= (~INTISSUE[10][52] | INTISSUE[10][51] | IsQuIntStop) ? INTISSUE[10][51] : InstSrc1Ready[10] ;
            INTISSUE[11][60] <= (~INTISSUE[11][61] | INTISSUE[11][60] | IsQuIntStop) ? INTISSUE[11][60] : InstSrc2Ready[11] ;
            INTISSUE[11][51] <= (~INTISSUE[11][52] | INTISSUE[11][51] | IsQuIntStop) ? INTISSUE[11][51] : InstSrc1Ready[11] ;
            INTISSUE[12][60] <= (~INTISSUE[12][61] | INTISSUE[12][60] | IsQuIntStop) ? INTISSUE[12][60] : InstSrc2Ready[12] ;
            INTISSUE[12][51] <= (~INTISSUE[12][52] | INTISSUE[12][51] | IsQuIntStop) ? INTISSUE[12][51] : InstSrc1Ready[12] ;
            INTISSUE[13][60] <= (~INTISSUE[13][61] | INTISSUE[13][60] | IsQuIntStop) ? INTISSUE[13][60] : InstSrc2Ready[13] ;
            INTISSUE[13][51] <= (~INTISSUE[13][52] | INTISSUE[13][51] | IsQuIntStop) ? INTISSUE[13][51] : InstSrc1Ready[13] ;
            INTISSUE[14][60] <= (~INTISSUE[14][61] | INTISSUE[14][60] | IsQuIntStop) ? INTISSUE[14][60] : InstSrc2Ready[14] ;
            INTISSUE[14][51] <= (~INTISSUE[14][52] | INTISSUE[14][51] | IsQuIntStop) ? INTISSUE[14][51] : InstSrc1Ready[14] ;
            INTISSUE[15][60] <= (~INTISSUE[15][61] | INTISSUE[15][60] | IsQuIntStop) ? INTISSUE[15][60] : InstSrc2Ready[15] ;
            INTISSUE[15][51] <= (~INTISSUE[15][52] | INTISSUE[15][51] | IsQuIntStop) ? INTISSUE[15][51] : InstSrc1Ready[15] ;
            INTISSUE[16][60] <= (~INTISSUE[16][61] | INTISSUE[16][60] | IsQuIntStop) ? INTISSUE[16][60] : InstSrc2Ready[16] ;
            INTISSUE[16][51] <= (~INTISSUE[16][52] | INTISSUE[16][51] | IsQuIntStop) ? INTISSUE[16][51] : InstSrc1Ready[16] ;
            INTISSUE[17][60] <= (~INTISSUE[17][61] | INTISSUE[17][60] | IsQuIntStop) ? INTISSUE[17][60] : InstSrc2Ready[17] ;
            INTISSUE[17][51] <= (~INTISSUE[17][52] | INTISSUE[17][51] | IsQuIntStop) ? INTISSUE[17][51] : InstSrc1Ready[17] ;
            INTISSUE[18][60] <= (~INTISSUE[18][61] | INTISSUE[18][60] | IsQuIntStop) ? INTISSUE[18][60] : InstSrc2Ready[18] ;
            INTISSUE[18][51] <= (~INTISSUE[18][52] | INTISSUE[18][51] | IsQuIntStop) ? INTISSUE[18][51] : InstSrc1Ready[18] ;
            INTISSUE[19][60] <= (~INTISSUE[19][61] | INTISSUE[19][60] | IsQuIntStop) ? INTISSUE[19][60] : InstSrc2Ready[19] ;
            INTISSUE[19][51] <= (~INTISSUE[19][52] | INTISSUE[19][51] | IsQuIntStop) ? INTISSUE[19][51] : InstSrc1Ready[19] ;
            INTISSUE[20][60] <= (~INTISSUE[20][61] | INTISSUE[20][60] | IsQuIntStop) ? INTISSUE[20][60] : InstSrc2Ready[20] ;
            INTISSUE[20][51] <= (~INTISSUE[20][52] | INTISSUE[20][51] | IsQuIntStop) ? INTISSUE[20][51] : InstSrc1Ready[20] ;
            INTISSUE[21][60] <= (~INTISSUE[21][61] | INTISSUE[21][60] | IsQuIntStop) ? INTISSUE[21][60] : InstSrc2Ready[21] ;
            INTISSUE[21][51] <= (~INTISSUE[21][52] | INTISSUE[21][51] | IsQuIntStop) ? INTISSUE[21][51] : InstSrc1Ready[21] ;
            INTISSUE[22][60] <= (~INTISSUE[22][61] | INTISSUE[22][60] | IsQuIntStop) ? INTISSUE[22][60] : InstSrc2Ready[22] ;
            INTISSUE[22][51] <= (~INTISSUE[22][52] | INTISSUE[22][51] | IsQuIntStop) ? INTISSUE[22][51] : InstSrc1Ready[22] ;
            INTISSUE[23][60] <= (~INTISSUE[23][61] | INTISSUE[23][60] | IsQuIntStop) ? INTISSUE[23][60] : InstSrc2Ready[23] ;
            INTISSUE[23][51] <= (~INTISSUE[23][52] | INTISSUE[23][51] | IsQuIntStop) ? INTISSUE[23][51] : InstSrc1Ready[23] ;
            INTISSUE[24][60] <= (~INTISSUE[24][61] | INTISSUE[24][60] | IsQuIntStop) ? INTISSUE[24][60] : InstSrc2Ready[24] ;
            INTISSUE[24][51] <= (~INTISSUE[24][52] | INTISSUE[24][51] | IsQuIntStop) ? INTISSUE[24][51] : InstSrc1Ready[24] ;
            INTISSUE[25][60] <= (~INTISSUE[25][61] | INTISSUE[25][60] | IsQuIntStop) ? INTISSUE[25][60] : InstSrc2Ready[25] ;
            INTISSUE[25][51] <= (~INTISSUE[25][52] | INTISSUE[25][51] | IsQuIntStop) ? INTISSUE[25][51] : InstSrc1Ready[25] ;
            INTISSUE[26][60] <= (~INTISSUE[26][61] | INTISSUE[26][60] | IsQuIntStop) ? INTISSUE[26][60] : InstSrc2Ready[26] ;
            INTISSUE[26][51] <= (~INTISSUE[26][52] | INTISSUE[26][51] | IsQuIntStop) ? INTISSUE[26][51] : InstSrc1Ready[26] ;
            INTISSUE[27][60] <= (~INTISSUE[27][61] | INTISSUE[27][60] | IsQuIntStop) ? INTISSUE[27][60] : InstSrc2Ready[27] ;
            INTISSUE[27][51] <= (~INTISSUE[27][52] | INTISSUE[27][51] | IsQuIntStop) ? INTISSUE[27][51] : InstSrc1Ready[27] ;
            INTISSUE[28][60] <= (~INTISSUE[28][61] | INTISSUE[28][60] | IsQuIntStop) ? INTISSUE[28][60] : InstSrc2Ready[28] ;
            INTISSUE[28][51] <= (~INTISSUE[28][52] | INTISSUE[28][51] | IsQuIntStop) ? INTISSUE[28][51] : InstSrc1Ready[28] ;
            INTISSUE[29][60] <= (~INTISSUE[29][61] | INTISSUE[29][60] | IsQuIntStop) ? INTISSUE[29][60] : InstSrc2Ready[29] ;
            INTISSUE[29][51] <= (~INTISSUE[29][52] | INTISSUE[29][51] | IsQuIntStop) ? INTISSUE[29][51] : InstSrc1Ready[29] ;
            INTISSUE[30][60] <= (~INTISSUE[30][61] | INTISSUE[30][60] | IsQuIntStop) ? INTISSUE[30][60] : InstSrc2Ready[30] ;
            INTISSUE[30][51] <= (~INTISSUE[30][52] | INTISSUE[30][51] | IsQuIntStop) ? INTISSUE[30][51] : InstSrc1Ready[30] ;
            INTISSUE[31][60] <= (~INTISSUE[31][61] | INTISSUE[31][60] | IsQuIntStop) ? INTISSUE[31][60] : InstSrc2Ready[31] ;
            INTISSUE[31][51] <= (~INTISSUE[31][52] | INTISSUE[31][51] | IsQuIntStop) ? INTISSUE[31][51] : InstSrc1Ready[31] ;
            INTISSUE[Read1Ptr] <= (In1aAble & ~ IsQuIntStop )? {In1RobPtr,In1Src2Able,((~In1Src2Able | In1Src2Ready | IsQuIntStop) ? In1Src2Ready : InIssue1Src2Ready),
                                                               In1Src2Addr,In1Src1Able,((~In1Src1Able | In1Src1Ready | IsQuIntStop) ? In1Src1Ready : InIssue1Src1Ready),
                                                               In1Src1Addr,In1RdAble,In1RdAddr,In1ImmAble,In1ImmDate,In1MicOpcode,AluAllocate} : INTISSUE[Read1Ptr] ;
            INTISSUE[Read2Ptr] <= (In2aAble & ~ IsQuIntStop )? {In2RobPtr,In2Src2Able,((~In2Src2Able | In2Src2Ready | IsQuIntStop) ? In2Src2Ready : InIssue2Src2Ready),
                                                               In2Src2Addr,In2Src1Able,((~In2Src1Able | In2Src1Ready | IsQuIntStop) ? In2Src1Ready : InIssue2Src1Ready),
                                                               In2Src1Addr,In2RdAble,In2RdAddr,In2ImmAble,In2ImmDate,In2MicOpcode,AluAllocate} : INTISSUE[Read2Ptr] ;
            INTISSUE[Read3Ptr] <= (In3aAble & ~ IsQuIntStop )? {In3RobPtr,In3Src2Able,((~In3Src2Able | In3Src2Ready | IsQuIntStop) ? In3Src2Ready : InIssue3Src2Ready),
                                                               In3Src2Addr,In3Src1Able,((~In3Src1Able | In3Src1Ready | IsQuIntStop) ? In3Src1Ready : InIssue3Src1Ready),
                                                               In3Src1Addr,In3RdAble,In3RdAddr,In3ImmAble,In3ImmDate,In3MicOpcode,AluAllocate} : INTISSUE[Read3Ptr] ;
            INTISSUE[Read4Ptr] <= (In4aAble & ~ IsQuIntStop )? {In4RobPtr,In4Src2Able,((~In4Src2Able | In4Src2Ready | IsQuIntStop) ? In4Src2Ready : InIssue4Src2Ready),
                                                               In4Src2Addr,In4Src1Able,((~In4Src1Able | In4Src1Ready | IsQuIntStop) ? In4Src1Ready : InIssue4Src1Ready),
                                                               In4Src1Addr,In4RdAble,In4RdAddr,In4ImmAble,In4ImmDate,In4MicOpcode,AluAllocate} : INTISSUE[Read4Ptr] ;
                                                               

        end
    end

   

    wire       Alu1SelectAblS1P [0:16] ;//for Alu1 INTISSUE[i][0] == `AbleValue 
    wire [4:0] Alu1SelectPtrS1P [0:16] ;
    wire       ALu1SelectOld    [0:16] ;

    integer b ;
    generate
        for ( b=0 ;b<32 ;b=b+2 ) begin
            assign ALu1SelectOld[b/2]  =  (INTISSUE[b][68] == INTISSUE[b+1][68] & (INTISSUE[b][67:62] < INTISSUE[b+1][67:62])) | 
                                          (INTISSUE[b][68] != INTISSUE[b+1][68] & (INTISSUE[b][67:62] > INTISSUE[b+1][67:62])) ;
            assign {Alu1SelectAblS1P[b/2],Alu1SelectPtrS1P[b/2]}  = {6{(((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & INTISSUE[b][0] & (INTISSUE[b][35:33] == `ALUCODE)) &
                                                                    ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & INTISSUE[b+1][0] & (INTISSUE[b+1][35:33] == `ALUCODE)) & 
                                                                    (ALu1SelectOld[b/2]))}} & {`AbleValue,b[4:0]}  | 
                                                                    {6{(((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & INTISSUE[b][0] & (INTISSUE[b][35:33] == `ALUCODE)) &
                                                                    ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & INTISSUE[b+1][0] & (INTISSUE[b+1][35:33] == `ALUCODE)) & 
                                                                    (~ALu1SelectOld[b/2]))}} & {`AbleValue,b[4:0]+1} | 
                                                                    {6{(((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & INTISSUE[b][0] & (INTISSUE[b][35:33] == `ALUCODE)) &
                                                                    ~((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & INTISSUE[b+1][0] & (INTISSUE[b+1][35:33] == `ALUCODE)))}} & {`AbleValue,b[4:0]} |
                                                                    {6{(~((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & INTISSUE[b][0] & (INTISSUE[b][35:33] == `ALUCODE)) &
                                                                    ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & INTISSUE[b+1][0] & (INTISSUE[b+1][35:33] == `ALUCODE)))}} & {`AbleValue,b[4:0]+1} ;
        end
    endgenerate

    integer c ;
    generate
        for (c =0 ;c<16 ;c=c+2 ) begin
            
        end
    endgenerate









endmodule 
