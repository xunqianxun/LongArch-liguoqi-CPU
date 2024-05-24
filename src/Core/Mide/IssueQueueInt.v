`timescale 1ps/1ps
`include "../define.v"
`include "../../Lib/IntIQ1Criq8.v"
`include "../../Lib/IntIQ2Criq8.v"
`include "../../Lib/IntIQ3Criq8.v"
`include "../../Lib/IntIQ4Criq8.v"

module IssueQueueInt (
    input       wire                                      Clk              ,
    input       wire                                      Rest             ,
    //for ctrl    
    input       wire                                      IsQuIntStop      ,
    input       wire                                      IsQuIntFlash     ,
    output      wire                                      IsQuIntReq       ,
    //from RAT
    input       wire        [2:0]                         InIQInstNum      ,
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
    input       wire                                      Alu2Req          ,
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
    output      wire        [`MicOperateCode]             Inst1MicOperate  , //alu1
    output      wire                                      Inst1Src1RAble   ,
    output      wire        [`ReNameRegBUs]               Inst1Src1RAddr   , 
    output      wire                                      Inst1Src2RAble   ,
    output      wire        [`ReNameRegBUs]               Inst1Src2RAddr   ,    
    output      wire                                      Inst1ImmAble     ,
    output      wire        [25:0]                        Inst1ImmDate     ,
    output      wire                                      Inst1RdAble      ,
    output      wire        [`ReNameRegBUs]               Inst1RdAddr      , 
    output      wire        [5:0]                         Inst1RoBptr      ,
    output      wire        [`MicOperateCode]             Inst2MicOperate  , //alu2
    output      wire                                      Inst2Src1RAble   ,
    output      wire        [`ReNameRegBUs]               Inst2Src1RAddr   , 
    output      wire                                      Inst2Src2RAble   ,
    output      wire        [`ReNameRegBUs]               Inst2Src2RAddr   ,    
    output      wire                                      Inst2ImmAble     ,
    output      wire        [25:0]                        Inst2ImmDate     ,
    output      wire                                      Inst2RdAble      ,
    output      wire        [`ReNameRegBUs]               Inst2RdAddr      , 
    output      wire        [5:0]                         Inst2RoBptr      ,
    output      wire        [`MicOperateCode]             Inst3MicOperate  , //div
    output      wire                                      Inst3Src1RAble   ,
    output      wire        [`ReNameRegBUs]               Inst3Src1RAddr   , 
    output      wire                                      Inst3Src2RAble   ,
    output      wire        [`ReNameRegBUs]               Inst3Src2RAddr   ,    
    output      wire                                      Inst3ImmAble     ,
    output      wire        [25:0]                        Inst3ImmDate     ,
    output      wire                                      Inst3RdAble      ,
    output      wire        [`ReNameRegBUs]               Inst3RdAddr      , 
    output      wire        [5:0]                         Inst3RoBptr      ,
    output      wire        [`MicOperateCode]             Inst4MicOperate  , //mul
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

    reg               StopTemp  ;
    reg               FlashTemp ;

    always @(posedge Clk) begin
        if(!Rest) begin
            StopTemp   <= 1'b0  ;
            FlashTemp  <= 1'b0  ;
        end
        else begin
            StopTemp   <= IsQuIntStop  ;
            FlashTemp  <= IsQuIntFlash ;
        end
    end

    reg [68:0] INTISSUE [0:31] ; // (ROBptr and Age)7 | (valid2 + ready2 + sec2)9 | (valid1 + ready1 + sec1)9 | (validrd + rd)8 | MicOpcode 8 | (validimm1 + Imm 26)27 | {ready | 暂时不用} ;

    reg [2:0]  ReadPtr  ;
    reg [2:0]  WritePtr ;
                         

    always @(posedge Clk) begin
        if(!Rest) begin
            ReadPtr    <= 3'd0 ;
        end
        else begin
            ReadPtr    <= ReadPtr[1:0] + InIQInstNum ;
        end
    end

    wire  Read1Able    = (ReadPtr == 0) & (InIQInstNum !=0) | 
                         (ReadPtr == 1) & (InIQInstNum ==4) | 
                         (ReadPtr == 2) & ((InIQInstNum ==3) | (InIQInstNum ==4)) | 
                         (ReadPtr == 3) & ((InIQInstNum !=0) & (InIQInstNum !=1)) ; 

    wire  Read2Able    = (ReadPtr == 0) & ((InIQInstNum !=0) & (InIQInstNum !=1)) | 
                         (ReadPtr == 1) & (InIQInstNum !=0) | 
                         (ReadPtr == 2) & (InIQInstNum ==4) | 
                         (ReadPtr == 3) & ((InIQInstNum ==3) | (InIQInstNum ==4)) ; 

    wire  Read3Able    = (ReadPtr == 0) & ((InIQInstNum ==3) | (InIQInstNum ==4)) | 
                         (ReadPtr == 1) & ((InIQInstNum !=0) & (InIQInstNum !=1)) | 
                         (ReadPtr == 2) & (InIQInstNum !=0) | 
                         (ReadPtr == 3) & (InIQInstNum ==4) ;

    wire  Read4Able    = (ReadPtr == 0) & (InIQInstNum ==4)  | 
                         (ReadPtr == 1) & ((InIQInstNum ==3) | (InIQInstNum ==4)) | 
                         (ReadPtr == 2) & ((InIQInstNum !=0) & (InIQInstNum !=1)) | 
                         (ReadPtr == 3) & (InIQInstNum !=0) ; 

    wire  [4:0] ReadPtr1 ;
    wire  [4:0] ReadPtr2 ;
    wire  [4:0] ReadPtr3 ;
    wire  [4:0] ReadPtr4 ;

    wire  [4:0] WriteInPtr1 ;
    wire  [4:0] WriteInPtr2 ;
    wire  [4:0] WriteInPtr3 ;
    wire  [4:0] WriteInPtr4 ;

    assign {WriteInPtr1, WriteInPtr2, WriteInPtr3, WriteInPtr4} = {20{( In1aAble & ~In2aAble & ~In3aAble & ~In4aAble)}} & {ReadPtr1, 5'd0, 5'd0, 5'd0} | 
                                                                  {20{(~In1aAble &  In2aAble & ~In3aAble & ~In4aAble)}} & {5'd0, ReadPtr1, 5'd0, 5'd0} | 
                                                                  {20{(~In1aAble & ~In2aAble &  In3aAble & ~In4aAble)}} & {5'd0, 5'd0, ReadPtr1, 5'd0} | 
                                                                  {20{(~In1aAble & ~In2aAble & ~In3aAble &  In4aAble)}} & {5'd0, 5'd0, 5'd0, ReadPtr1} | 
                                                                  {20{( In1aAble &  In2aAble & ~In3aAble & ~In4aAble)}} & {ReadPtr1, ReadPtr2, 5'd0, 5'd0} | 
                                                                  {20{( In1aAble & ~In2aAble &  In3aAble & ~In4aAble)}} & {ReadPtr1, 5'd0, ReadPtr2, 5'd0} | 
                                                                  {20{(~In1aAble &  In2aAble &  In3aAble & ~In4aAble)}} & {5'd0, ReadPtr1, ReadPtr2, 5'd0} | 
                                                                  {20{( In1aAble &  In2aAble &  In3aAble & ~In4aAble)}} & {ReadPtr1, ReadPtr2, ReadPtr3, 5'd0} | 
                                                                  {20{( In1aAble & ~In2aAble & ~In3aAble &  In4aAble)}} & {ReadPtr1, 5'd0, 5'd0, ReadPtr2} | 
                                                                  {20{(~In1aAble &  In2aAble & ~In3aAble &  In4aAble)}} & {5'd0, ReadPtr1, 5'd0, ReadPtr2} | 
                                                                  {20{( In1aAble &  In2aAble & ~In3aAble &  In4aAble)}} & {ReadPtr1, ReadPtr2, 5'd0, ReadPtr3} | 
                                                                  {20{(~In1aAble & ~In2aAble &  In3aAble &  In4aAble)}} & {5'd0, 5'd0, ReadPtr1, ReadPtr2} | 
                                                                  {20{( In1aAble & ~In2aAble &  In3aAble &  In4aAble)}} & {ReadPtr1, 5'd0, ReadPtr2, ReadPtr3} | 
                                                                  {20{(~In1aAble &  In2aAble &  In3aAble &  In4aAble)}} & {5'd0, ReadPtr1, ReadPtr2, ReadPtr3} | 
                                                                  {20{( In1aAble &  In2aAble &  In3aAble &  In4aAble)}} & {ReadPtr1, ReadPtr2, ReadPtr3, ReadPtr4};

    wire  [2:0] WriteNumber ;
    //wire        WriteAble1  ;
    wire  [4:0] WriteDate1  ;
    //wire        WriteAble2  ;
    wire  [4:0] WriteDate2  ;
    //wire        WriteAble3  ;
    wire  [4:0] WriteDate3  ;
    //wire        WriteAble4  ;
    wire  [4:0] WriteDate4  ;

    assign {WriteNumber,WriteDate1,WriteDate2,WriteDate3,WriteDate4} = 
                                    {23{( Inst1SelectAble & ~Inst2SelectAble & ~Inst3SelectAble & ~Inst4SelectAble)}} & {3'd1, Inst1SelectPtr, 5'd0, 5'd0, 5'd0} |
                                    {23{(~Inst1SelectAble &  Inst2SelectAble & ~Inst3SelectAble & ~Inst4SelectAble)}} & {3'd1, Inst2SelectPtr, 5'd0, 5'd0, 5'd0} |
                                    {23{( Inst1SelectAble &  Inst2SelectAble & ~Inst3SelectAble & ~Inst4SelectAble)}} & {3'd2, Inst1SelectPtr, Inst2SelectPtr, 5'd0, 5'd0} |
                                    {23{(~Inst1SelectAble & ~Inst2SelectAble &  Inst3SelectAble & ~Inst4SelectAble)}} & {3'd1, Inst3SelectPtr, 5'd0, 5'd0, 5'd0} |
                                    {23{( Inst1SelectAble & ~Inst2SelectAble &  Inst3SelectAble & ~Inst4SelectAble)}} & {3'd2, Inst1SelectPtr, Inst3SelectPtr, 5'd0, 5'd0} |
                                    {23{(~Inst1SelectAble &  Inst2SelectAble &  Inst3SelectAble & ~Inst4SelectAble)}} & {3'd2, Inst2SelectPtr, Inst3SelectPtr, 5'd0, 5'd0} |
                                    {23{( Inst1SelectAble &  Inst2SelectAble &  Inst3SelectAble & ~Inst4SelectAble)}} & {3'd3, Inst1SelectPtr, Inst2SelectPtr, Inst3SelectPtr, 5'd0} |
                                    {23{(~Inst1SelectAble & ~Inst2SelectAble & ~Inst3SelectAble &  Inst4SelectAble)}} & {3'd1, Inst4SelectPtr, 5'd0, 5'd0, 5'd0} |
                                    {23{( Inst1SelectAble & ~Inst2SelectAble & ~Inst3SelectAble &  Inst4SelectAble)}} & {3'd2, Inst1SelectPtr, Inst4SelectPtr, 5'd0, 5'd0} |
                                    {23{(~Inst1SelectAble &  Inst2SelectAble & ~Inst3SelectAble &  Inst4SelectAble)}} & {3'd2, Inst2SelectPtr, Inst4SelectPtr, 5'd0, 5'd0} |
                                    {23{( Inst1SelectAble &  Inst2SelectAble & ~Inst3SelectAble &  Inst4SelectAble)}} & {3'd3, Inst1SelectPtr, Inst2SelectPtr, Inst4SelectPtr, 5'd0} |
                                    {23{(~Inst1SelectAble & ~Inst2SelectAble &  Inst3SelectAble &  Inst4SelectAble)}} & {3'd2, Inst3SelectPtr, Inst4SelectPtr, 5'd0, 5'd0} |
                                    {23{( Inst1SelectAble & ~Inst2SelectAble &  Inst3SelectAble &  Inst4SelectAble)}} & {3'd3, Inst1SelectPtr, Inst3SelectPtr, Inst4SelectPtr, 5'd0} |
                                    {23{(~Inst1SelectAble &  Inst2SelectAble &  Inst3SelectAble &  Inst4SelectAble)}} & {3'd3, Inst2SelectPtr, Inst3SelectPtr, Inst4SelectPtr, 5'd0} |
                                    {23{( Inst1SelectAble &  Inst2SelectAble &  Inst3SelectAble &  Inst4SelectAble)}} & {3'd4, Inst1SelectPtr, Inst2SelectPtr, Inst3SelectPtr, Inst4SelectPtr} ;

    always @ (posedge Clk) begin
        if (!Rest) begin
            WritePtr <= 3'd0 ;
        end
        else begin
            WritePtr <= WritePtr[1:0] + WriteNumber ;
        end
    end

    wire  Write1Able = (WritePtr == 0) & (WriteNumber != 0) |
                       (WritePtr == 1) & (WriteNumber == 4) |
                       (WritePtr == 2) & ((WriteNumber == 3) | (WriteNumber == 4)) |
                       (WritePtr == 3) & ((WriteNumber != 0) & (WriteNumber != 1));

    wire  Write2Able = (WritePtr == 0) & ((WriteNumber != 0) & (WriteNumber != 1)) |
                       (WritePtr == 1) & (WriteNumber != 0) |
                       (WritePtr == 2) & (WriteNumber == 4) |
                       (WritePtr == 3) & ((WriteNumber == 3) | (WriteNumber == 4));

    wire  Write3Able = (WritePtr == 0) & ((WriteNumber == 3) | (WriteNumber == 4)) |
                       (WritePtr == 1) & ((WriteNumber != 0) & (WriteNumber != 1)) |
                       (WritePtr == 2) & (WriteNumber != 0) |
                       (WritePtr == 3) & (WriteNumber == 4);

    wire  Write4Able = (WritePtr == 0) & (WriteNumber == 4) |
                       (WritePtr == 1) & ((WriteNumber == 3) | (WriteNumber == 4)) |
                       (WritePtr == 2) & ((WriteNumber != 0) & (WriteNumber != 1)) |
                       (WritePtr == 3) & (WriteNumber != 0) ;

    wire     Criq1Empty ;
    wire     Criq2Empty ;
    wire     Criq3Empty ;
    wire     Criq4Empty ;


    IntIQ1Criq8#(
        .CRIQWIDE    ( 5 ),
        .CRIQDEEP    ( 8 )
    )u1_IntIQ1Criq8(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .Rable       ( Read1Able & ~StopTemp ),
        //.Dout        ( Dout        ),
        .CriqPreOut  ( ReadPtr1    ),
        .Wable       ( Write1Able & ~StopTemp  ),
        .Din         ( WriteDate1  ),
        .CriqClean   ( FlashTemp   ),
        //.CriqFull    ( CriqFull    ),
        .CriqEmpty   ( Criq1Empty  )
    );
    IntIQ1Criq8#(
        .CRIQWIDE    ( 5 ),
        .CRIQDEEP    ( 8 )
    )u2_IntIQ1Criq8(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .Rable       ( Read2Able & ~StopTemp   ),
        //.Dout        ( Dout        ),
        .CriqPreOut  ( ReadPtr2    ),
        .Wable       ( Write2Able & ~StopTemp  ),
        .Din         ( WriteDate2  ),
        .CriqClean   ( FlashTemp   ),
        //.CriqFull    ( CriqFull    ),
        .CriqEmpty   ( Criq2Empty  )
    );
    IntIQ1Criq8#(
        .CRIQWIDE    ( 5 ),
        .CRIQDEEP    ( 8 )
    )u3_IntIQ1Criq8(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .Rable       ( Read3Able & ~StopTemp  ),
        //.Dout        ( Dout        ),
        .CriqPreOut  ( ReadPtr3    ),
        .Wable       ( Write3Able & ~StopTemp ),
        .Din         ( WriteDate3  ),
        .CriqClean   ( FlashTemp   ),
        //.CriqFull    ( CriqFull    ),
        .CriqEmpty   ( Criq3Empty  )
    );
    IntIQ1Criq8#(
        .CRIQWIDE    ( 5 ),
        .CRIQDEEP    ( 8 )
    )u4_IntIQ1Criq8(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .Rable       ( Read4Able & ~StopTemp  ),
        //.Dout        ( Dout        ),
        .CriqPreOut  ( ReadPtr4    ),
        .Wable       ( Write4Able & ~StopTemp ),
        .Din         ( WriteDate4  ),
        .CriqClean   ( FlashTemp   ),
        //.CriqFull    ( CriqFull    ),
        .CriqEmpty   ( Criq4Empty  )
    );

    assign IsQuIntReq = Criq1Empty & Criq2Empty & Criq3Empty & Criq4Empty ;

    wire Alu1BroadcastAble ;
    wire [`ReNameRegBUs] Alu1BroadcastAddr ;
    wire Alu2BroadcastAble ;
    wire [`ReNameRegBUs] Alu2BroadcastAddr ;
    wire MulBroadcastAble ;
    wire [`ReNameRegBUs] MulBroadcastAddr ;

    wire InIssue1Src2Ready =((In1Src2Addr == Alu1BroadcastAddr)&& Alu1BroadcastAble) ||
                            ((In1Src2Addr == Alu2BroadcastAddr)&& Alu2BroadcastAble) || 
                            ((In1Src2Addr == MulBroadcastAddr) && MulBroadcastAble)  || 
                            ((In1Src2Addr == FromBrAddr      ) && FromIsQBr       )  || 
                            ((In1Src2Addr == FromCsrAddr     ) && FromIsQCsr      )  || 
                            ((In1Src2Addr == ByPassDivAddr   ) && ByPassDiv       )  || 
                            ((In1Src2Addr == BypassSCAddr    ) && BypassSC        )  || 
                            ((In1Src2Addr == ByPassLoadAddr  ) && ByPassLoad      )  ;
                        
    wire InIssue2Src2Ready =((In2Src2Addr == Alu1BroadcastAddr)&& Alu1BroadcastAble) || 
                            ((In2Src2Addr == Alu2BroadcastAddr)&& Alu2BroadcastAble) || 
                            ((In2Src2Addr == MulBroadcastAddr) && MulBroadcastAble)  || 
                            ((In2Src2Addr == FromBrAddr      ) && FromIsQBr       )  || 
                            ((In2Src2Addr == FromCsrAddr     ) && FromIsQCsr      )  || 
                            ((In2Src2Addr == ByPassDivAddr   ) && ByPassDiv       )  || 
                            ((In2Src2Addr == BypassSCAddr    ) && BypassSC        )  || 
                            ((In2Src2Addr == ByPassLoadAddr  ) && ByPassLoad      )  ;

    wire InIssue3Src2Ready =((In3Src2Addr == Alu1BroadcastAddr)&& Alu1BroadcastAble) ||
                            ((In3Src2Addr == Alu2BroadcastAddr)&& Alu2BroadcastAble) || 
                            ((In3Src2Addr == MulBroadcastAddr) && MulBroadcastAble)  || 
                            ((In3Src2Addr == FromBrAddr      ) && FromIsQBr       )  || 
                            ((In3Src2Addr == FromCsrAddr     ) && FromIsQCsr      )  || 
                            ((In3Src2Addr == ByPassDivAddr   ) && ByPassDiv       )  || 
                            ((In3Src2Addr == BypassSCAddr    ) && BypassSC        )  || 
                            ((In3Src2Addr == ByPassLoadAddr  ) && ByPassLoad      )  ;
                        
    wire InIssue4Src2Ready =((In4Src2Addr == Alu1BroadcastAddr)&& Alu1BroadcastAble) || 
                            ((In4Src2Addr == Alu2BroadcastAddr)&& Alu2BroadcastAble) || 
                            ((In4Src2Addr == MulBroadcastAddr) && MulBroadcastAble)  || 
                            ((In4Src2Addr == FromBrAddr      ) && FromIsQBr       )  || 
                            ((In4Src2Addr == FromCsrAddr     ) && FromIsQCsr      )  || 
                            ((In4Src2Addr == ByPassDivAddr   ) && ByPassDiv       )  || 
                            ((In4Src2Addr == BypassSCAddr    ) && BypassSC        )  || 
                            ((In4Src2Addr == ByPassLoadAddr  ) && ByPassLoad      )  ;

    wire InIssue1Src1Ready =((In1Src1Addr == Alu1BroadcastAddr)&& Alu1BroadcastAble) ||
                            ((In1Src1Addr == Alu2BroadcastAddr)&& Alu2BroadcastAble) || 
                            ((In1Src1Addr == MulBroadcastAddr) && MulBroadcastAble)  || 
                            ((In1Src1Addr == FromBrAddr      ) && FromIsQBr       )  || 
                            ((In1Src1Addr == FromCsrAddr     ) && FromIsQCsr      )  || 
                            ((In1Src1Addr == ByPassDivAddr   ) && ByPassDiv       )  || 
                            ((In1Src1Addr == BypassSCAddr    ) && BypassSC        )  || 
                            ((In1Src1Addr == ByPassLoadAddr  ) && ByPassLoad      )  ;
                        
    wire InIssue2Src1Ready =((In2Src1Addr == Alu1BroadcastAddr)&& Alu1BroadcastAble) || 
                            ((In2Src1Addr == Alu2BroadcastAddr)&& Alu2BroadcastAble) || 
                            ((In2Src1Addr == MulBroadcastAddr) && MulBroadcastAble)  || 
                            ((In2Src1Addr == FromBrAddr      ) && FromIsQBr       )  || 
                            ((In2Src1Addr == FromCsrAddr     ) && FromIsQCsr      )  || 
                            ((In2Src1Addr == ByPassDivAddr   ) && ByPassDiv       )  || 
                            ((In2Src1Addr == BypassSCAddr    ) && BypassSC        )  || 
                            ((In2Src1Addr == ByPassLoadAddr  ) && ByPassLoad      )  ;

    wire InIssue3Src1Ready =((In3Src1Addr == Alu1BroadcastAddr)&& Alu1BroadcastAble) ||
                            ((In3Src1Addr == Alu2BroadcastAddr)&& Alu2BroadcastAble) || 
                            ((In3Src1Addr == MulBroadcastAddr) && MulBroadcastAble)  || 
                            ((In3Src1Addr == FromBrAddr      ) && FromIsQBr       )  || 
                            ((In3Src1Addr == FromCsrAddr     ) && FromIsQCsr      )  || 
                            ((In3Src1Addr == ByPassDivAddr   ) && ByPassDiv       )  || 
                            ((In3Src1Addr == BypassSCAddr    ) && BypassSC        )  || 
                            ((In3Src1Addr == ByPassLoadAddr  ) && ByPassLoad      )  ;
                        
    wire InIssue4Src1Ready =((In4Src1Addr == Alu1BroadcastAddr)&& Alu1BroadcastAble) || 
                            ((In4Src1Addr == Alu2BroadcastAddr)&& Alu2BroadcastAble) || 
                            ((In4Src1Addr == MulBroadcastAddr) && MulBroadcastAble)  || 
                            ((In4Src1Addr == FromBrAddr      ) && FromIsQBr       )  || 
                            ((In4Src1Addr == FromCsrAddr     ) && FromIsQCsr      )  || 
                            ((In4Src1Addr == ByPassDivAddr   ) && ByPassDiv       )  || 
                            ((In4Src1Addr == BypassSCAddr    ) && BypassSC        )  || 
                            ((In4Src1Addr == ByPassLoadAddr  ) && ByPassLoad      )  ;
    wire InstSrc2Ready[0:31] ;
    wire InstSrc1Ready[0:31] ;               
    genvar a ;
    generate
        for ( a=0 ;a<32 ;a=a+1 ) begin
            assign InstSrc2Ready[a]=((INTISSUE[a][59:53] == Alu1BroadcastAddr)&& Alu1BroadcastAble) ||
                                    ((INTISSUE[a][59:53] == Alu2BroadcastAddr)&& Alu2BroadcastAble) || 
                                    ((INTISSUE[a][59:53] == MulBroadcastAddr) && MulBroadcastAble)  || 
                                    ((INTISSUE[a][59:53] == FromBrAddr      ) && FromIsQBr       )  || 
                                    ((INTISSUE[a][59:53] == FromCsrAddr     ) && FromIsQCsr      )  || 
                                    ((INTISSUE[a][59:53] == ByPassDivAddr   ) && ByPassDiv       )  || 
                                    ((INTISSUE[a][59:53] == BypassSCAddr    ) && BypassSC        )  || 
                                    ((INTISSUE[a][59:53] == ByPassLoadAddr  ) && ByPassLoad      )  ;
            assign InstSrc1Ready[a]=((INTISSUE[a][50:44] == Alu1BroadcastAddr)&& Alu1BroadcastAble) ||
                                    ((INTISSUE[a][50:44] == Alu2BroadcastAddr)&& Alu2BroadcastAble) || 
                                    ((INTISSUE[a][50:44] == MulBroadcastAddr) && MulBroadcastAble)  ||
                                    ((INTISSUE[a][50:44] == FromBrAddr      ) && FromIsQBr       )  ||
                                    ((INTISSUE[a][50:44] == FromCsrAddr     ) && FromIsQCsr      )  || 
                                    ((INTISSUE[a][50:44] == ByPassDivAddr   ) && ByPassDiv       )  || 
                                    ((INTISSUE[a][50:44] == BypassSCAddr    ) && BypassSC        )  || 
                                    ((INTISSUE[a][50:44] == ByPassLoadAddr  ) && ByPassLoad      )  ;
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
        else if(IsQuIntStop) 
            AluAllocate <= AluAllocate ;
        else 
            AluAllocate <= AluInstHas  ? ~AluAllocate : AluAllocate ;


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
        else if(IsQuIntStop) begin
            for (j =0 ;j<33 ;j=j+1 ) begin
                INTISSUE[j] <= INTISSUE[j] ;
            end 
        end
        else begin
            INTISSUE[0][60] <= (~INTISSUE[0][61] | INTISSUE[0][60] ) ? INTISSUE[0][60] : InstSrc2Ready[0] ;
            INTISSUE[0][51] <= (~INTISSUE[0][52] | INTISSUE[0][51] ) ? INTISSUE[0][51] : InstSrc1Ready[0] ;
            INTISSUE[1][60] <= (~INTISSUE[1][61] | INTISSUE[1][60] ) ? INTISSUE[1][60] : InstSrc2Ready[1] ;
            INTISSUE[1][51] <= (~INTISSUE[1][52] | INTISSUE[1][51] ) ? INTISSUE[1][51] : InstSrc1Ready[1] ;
            INTISSUE[2][60] <= (~INTISSUE[2][61] | INTISSUE[2][60] ) ? INTISSUE[2][60] : InstSrc2Ready[2] ;
            INTISSUE[2][51] <= (~INTISSUE[2][52] | INTISSUE[2][51] ) ? INTISSUE[2][51] : InstSrc1Ready[2] ;
            INTISSUE[3][60] <= (~INTISSUE[3][61] | INTISSUE[3][60] ) ? INTISSUE[3][60] : InstSrc2Ready[3] ;
            INTISSUE[3][51] <= (~INTISSUE[3][52] | INTISSUE[3][51] ) ? INTISSUE[3][51] : InstSrc1Ready[3] ;
            INTISSUE[4][60] <= (~INTISSUE[4][61] | INTISSUE[4][60] ) ? INTISSUE[4][60] : InstSrc2Ready[4] ;
            INTISSUE[4][51] <= (~INTISSUE[4][52] | INTISSUE[4][51] ) ? INTISSUE[4][51] : InstSrc1Ready[4] ;
            INTISSUE[5][60] <= (~INTISSUE[5][61] | INTISSUE[5][60] ) ? INTISSUE[5][60] : InstSrc2Ready[5] ;
            INTISSUE[5][51] <= (~INTISSUE[5][52] | INTISSUE[5][51] ) ? INTISSUE[5][51] : InstSrc1Ready[5] ;
            INTISSUE[6][60] <= (~INTISSUE[6][61] | INTISSUE[6][60] ) ? INTISSUE[6][60] : InstSrc2Ready[6] ;
            INTISSUE[6][51] <= (~INTISSUE[6][52] | INTISSUE[6][51] ) ? INTISSUE[6][51] : InstSrc1Ready[6] ;
            INTISSUE[7][60] <= (~INTISSUE[7][61] | INTISSUE[7][60] ) ? INTISSUE[7][60] : InstSrc2Ready[7] ;
            INTISSUE[7][51] <= (~INTISSUE[7][52] | INTISSUE[7][51] ) ? INTISSUE[7][51] : InstSrc1Ready[7] ;
            INTISSUE[8][60] <= (~INTISSUE[8][61] | INTISSUE[8][60] ) ? INTISSUE[8][60] : InstSrc2Ready[8] ;
            INTISSUE[8][51] <= (~INTISSUE[8][52] | INTISSUE[8][51] ) ? INTISSUE[8][51] : InstSrc1Ready[8] ;
            INTISSUE[9][60] <= (~INTISSUE[9][61] | INTISSUE[9][60] ) ? INTISSUE[9][60] : InstSrc2Ready[9] ;
            INTISSUE[9][51] <= (~INTISSUE[9][52] | INTISSUE[9][51] ) ? INTISSUE[9][51] : InstSrc1Ready[9] ;
            INTISSUE[10][60] <= (~INTISSUE[10][61] | INTISSUE[10][60] ) ? INTISSUE[10][60] : InstSrc2Ready[10] ;
            INTISSUE[10][51] <= (~INTISSUE[10][52] | INTISSUE[10][51] ) ? INTISSUE[10][51] : InstSrc1Ready[10] ;
            INTISSUE[11][60] <= (~INTISSUE[11][61] | INTISSUE[11][60] ) ? INTISSUE[11][60] : InstSrc2Ready[11] ;
            INTISSUE[11][51] <= (~INTISSUE[11][52] | INTISSUE[11][51] ) ? INTISSUE[11][51] : InstSrc1Ready[11] ;
            INTISSUE[12][60] <= (~INTISSUE[12][61] | INTISSUE[12][60] ) ? INTISSUE[12][60] : InstSrc2Ready[12] ;
            INTISSUE[12][51] <= (~INTISSUE[12][52] | INTISSUE[12][51] ) ? INTISSUE[12][51] : InstSrc1Ready[12] ;
            INTISSUE[13][60] <= (~INTISSUE[13][61] | INTISSUE[13][60] ) ? INTISSUE[13][60] : InstSrc2Ready[13] ;
            INTISSUE[13][51] <= (~INTISSUE[13][52] | INTISSUE[13][51] ) ? INTISSUE[13][51] : InstSrc1Ready[13] ;
            INTISSUE[14][60] <= (~INTISSUE[14][61] | INTISSUE[14][60] ) ? INTISSUE[14][60] : InstSrc2Ready[14] ;
            INTISSUE[14][51] <= (~INTISSUE[14][52] | INTISSUE[14][51] ) ? INTISSUE[14][51] : InstSrc1Ready[14] ;
            INTISSUE[15][60] <= (~INTISSUE[15][61] | INTISSUE[15][60] ) ? INTISSUE[15][60] : InstSrc2Ready[15] ;
            INTISSUE[15][51] <= (~INTISSUE[15][52] | INTISSUE[15][51] ) ? INTISSUE[15][51] : InstSrc1Ready[15] ;
            INTISSUE[16][60] <= (~INTISSUE[16][61] | INTISSUE[16][60] ) ? INTISSUE[16][60] : InstSrc2Ready[16] ;
            INTISSUE[16][51] <= (~INTISSUE[16][52] | INTISSUE[16][51] ) ? INTISSUE[16][51] : InstSrc1Ready[16] ;
            INTISSUE[17][60] <= (~INTISSUE[17][61] | INTISSUE[17][60] ) ? INTISSUE[17][60] : InstSrc2Ready[17] ;
            INTISSUE[17][51] <= (~INTISSUE[17][52] | INTISSUE[17][51] ) ? INTISSUE[17][51] : InstSrc1Ready[17] ;
            INTISSUE[18][60] <= (~INTISSUE[18][61] | INTISSUE[18][60] ) ? INTISSUE[18][60] : InstSrc2Ready[18] ;
            INTISSUE[18][51] <= (~INTISSUE[18][52] | INTISSUE[18][51] ) ? INTISSUE[18][51] : InstSrc1Ready[18] ;
            INTISSUE[19][60] <= (~INTISSUE[19][61] | INTISSUE[19][60] ) ? INTISSUE[19][60] : InstSrc2Ready[19] ;
            INTISSUE[19][51] <= (~INTISSUE[19][52] | INTISSUE[19][51] ) ? INTISSUE[19][51] : InstSrc1Ready[19] ;
            INTISSUE[20][60] <= (~INTISSUE[20][61] | INTISSUE[20][60] ) ? INTISSUE[20][60] : InstSrc2Ready[20] ;
            INTISSUE[20][51] <= (~INTISSUE[20][52] | INTISSUE[20][51] ) ? INTISSUE[20][51] : InstSrc1Ready[20] ;
            INTISSUE[21][60] <= (~INTISSUE[21][61] | INTISSUE[21][60] ) ? INTISSUE[21][60] : InstSrc2Ready[21] ;
            INTISSUE[21][51] <= (~INTISSUE[21][52] | INTISSUE[21][51] ) ? INTISSUE[21][51] : InstSrc1Ready[21] ;
            INTISSUE[22][60] <= (~INTISSUE[22][61] | INTISSUE[22][60] ) ? INTISSUE[22][60] : InstSrc2Ready[22] ;
            INTISSUE[22][51] <= (~INTISSUE[22][52] | INTISSUE[22][51] ) ? INTISSUE[22][51] : InstSrc1Ready[22] ;
            INTISSUE[23][60] <= (~INTISSUE[23][61] | INTISSUE[23][60] ) ? INTISSUE[23][60] : InstSrc2Ready[23] ;
            INTISSUE[23][51] <= (~INTISSUE[23][52] | INTISSUE[23][51] ) ? INTISSUE[23][51] : InstSrc1Ready[23] ;
            INTISSUE[24][60] <= (~INTISSUE[24][61] | INTISSUE[24][60] ) ? INTISSUE[24][60] : InstSrc2Ready[24] ;
            INTISSUE[24][51] <= (~INTISSUE[24][52] | INTISSUE[24][51] ) ? INTISSUE[24][51] : InstSrc1Ready[24] ;
            INTISSUE[25][60] <= (~INTISSUE[25][61] | INTISSUE[25][60] ) ? INTISSUE[25][60] : InstSrc2Ready[25] ;
            INTISSUE[25][51] <= (~INTISSUE[25][52] | INTISSUE[25][51] ) ? INTISSUE[25][51] : InstSrc1Ready[25] ;
            INTISSUE[26][60] <= (~INTISSUE[26][61] | INTISSUE[26][60] ) ? INTISSUE[26][60] : InstSrc2Ready[26] ;
            INTISSUE[26][51] <= (~INTISSUE[26][52] | INTISSUE[26][51] ) ? INTISSUE[26][51] : InstSrc1Ready[26] ;
            INTISSUE[27][60] <= (~INTISSUE[27][61] | INTISSUE[27][60] ) ? INTISSUE[27][60] : InstSrc2Ready[27] ;
            INTISSUE[27][51] <= (~INTISSUE[27][52] | INTISSUE[27][51] ) ? INTISSUE[27][51] : InstSrc1Ready[27] ;
            INTISSUE[28][60] <= (~INTISSUE[28][61] | INTISSUE[28][60] ) ? INTISSUE[28][60] : InstSrc2Ready[28] ;
            INTISSUE[28][51] <= (~INTISSUE[28][52] | INTISSUE[28][51] ) ? INTISSUE[28][51] : InstSrc1Ready[28] ;
            INTISSUE[29][60] <= (~INTISSUE[29][61] | INTISSUE[29][60] ) ? INTISSUE[29][60] : InstSrc2Ready[29] ;
            INTISSUE[29][51] <= (~INTISSUE[29][52] | INTISSUE[29][51] ) ? INTISSUE[29][51] : InstSrc1Ready[29] ;
            INTISSUE[30][60] <= (~INTISSUE[30][61] | INTISSUE[30][60] ) ? INTISSUE[30][60] : InstSrc2Ready[30] ;
            INTISSUE[30][51] <= (~INTISSUE[30][52] | INTISSUE[30][51] ) ? INTISSUE[30][51] : InstSrc1Ready[30] ;
            INTISSUE[31][60] <= (~INTISSUE[31][61] | INTISSUE[31][60] ) ? INTISSUE[31][60] : InstSrc2Ready[31] ;
            INTISSUE[31][51] <= (~INTISSUE[31][52] | INTISSUE[31][51] ) ? INTISSUE[31][51] : InstSrc1Ready[31] ;
            INTISSUE[WriteInPtr1[4:0]] <= (In1aAble  )? {In1RobPtr,In1Src2Able,((~In1Src2Able | In1Src2Ready ) ? In1Src2Ready : InIssue1Src2Ready),
                                                               In1Src2Addr,In1Src1Able,((~In1Src1Able | In1Src1Ready ) ? In1Src1Ready : InIssue1Src1Ready),
                                                               In1Src1Addr,In1RdAble,In1RdAddr,In1ImmAble,In1ImmDate,In1MicOpcode,AluAllocate} : INTISSUE[WriteInPtr1[4:0]] ;
            INTISSUE[WriteInPtr2[4:0]] <= (In2aAble  )? {In2RobPtr,In2Src2Able,((~In2Src2Able | In2Src2Ready ) ? In2Src2Ready : InIssue2Src2Ready),
                                                               In2Src2Addr,In2Src1Able,((~In2Src1Able | In2Src1Ready ) ? In2Src1Ready : InIssue2Src1Ready),
                                                               In2Src1Addr,In2RdAble,In2RdAddr,In2ImmAble,In2ImmDate,In2MicOpcode,AluAllocate} : INTISSUE[WriteInPtr2[4:0]] ;
            INTISSUE[WriteInPtr3[4:0]] <= (In3aAble  )? {In3RobPtr,In3Src2Able,((~In3Src2Able | In3Src2Ready ) ? In3Src2Ready : InIssue3Src2Ready),
                                                               In3Src2Addr,In3Src1Able,((~In3Src1Able | In3Src1Ready ) ? In3Src1Ready : InIssue3Src1Ready),
                                                               In3Src1Addr,In3RdAble,In3RdAddr,In3ImmAble,In3ImmDate,In3MicOpcode,AluAllocate} : INTISSUE[WriteInPtr3[4:0]] ;
            INTISSUE[WriteInPtr4[4:0]] <= (In4aAble  )? {In4RobPtr,In4Src2Able,((~In4Src2Able | In4Src2Ready ) ? In4Src2Ready : InIssue4Src2Ready),
                                                               In4Src2Addr,In4Src1Able,((~In4Src1Able | In4Src1Ready ) ? In4Src1Ready : InIssue4Src1Ready),
                                                               In4Src1Addr,In4RdAble,In4RdAddr,In4ImmAble,In4ImmDate,In4MicOpcode,AluAllocate} : INTISSUE[WriteInPtr4[4:0]] ;
            INTISSUE[Alu1SelectPtrS5P] <=  Alu1SelectAblS5P  ? 69'd0 : INTISSUE[Alu1SelectPtrS5P] ;
            INTISSUE[Alu2SelectPtrS5P] <=  Alu2SelectAblS5P  ? 69'd0 : INTISSUE[Alu2SelectPtrS5P] ;
            INTISSUE[MulSelectPtrS5P]  <=  MulSelectAblS5P   ? 69'd0 : INTISSUE[MulSelectPtrS5P]  ;                                      
            INTISSUE[DivSelectPtrS5P]  <=  DivSelectAblS5P   ? 69'd0 : INTISSUE[DivSelectPtrS5P]  ;

        end
    end

   
    //for Alu1
    wire       Alu1SelectAblS1P [0:15] ;//for Alu1 INTISSUE[i][0] == `AbleValue 
    wire [4:0] Alu1SelectPtrS1P [0:15] ;
    wire       ALu1SelectOld    [0:15] ;
    //for Alu2
    wire       Alu2SelectAblS1P [0:15] ;//for Alu1 INTISSUE[i][0] == `EnableValue 
    wire [4:0] Alu2SelectPtrS1P [0:15] ;
    wire       ALu2SelectOld    [0:15] ;
    //for mul
    wire       MulSelectAblS1P [0:15] ;
    wire [4:0] MulSelectPtrS1P [0:15] ;
    wire       MulSelectOld    [0:15] ;
    //for Div
    wire       DivSelectAblS1P [0:15] ;
    wire [4:0] DivSelectPtrS1P [0:15] ;
    wire       DivSelectOld    [0:15] ;

    genvar b ;
    generate
        for ( b=0 ;b<32 ;b=b+2 ) begin
            assign ALu1SelectOld[b/2]  =  ((INTISSUE[b][68] == INTISSUE[b+1][68] & (INTISSUE[b][67:62] < INTISSUE[b+1][67:62]))) | 
                                          ((INTISSUE[b][68] != INTISSUE[b+1][68] & (INTISSUE[b][67:62] > INTISSUE[b+1][67:62]))) ;
            assign Alu1SelectPtrS1P[b/2]  = {5{(((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & INTISSUE[b][0] & (INTISSUE[b][35:33] == `ALUCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & INTISSUE[b+1][0] & (INTISSUE[b+1][35:33] == `ALUCODE)) & 
                                            (ALu1SelectOld[b/2]))}} & b  | 
                                            {5{(((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & INTISSUE[b][0] & (INTISSUE[b][35:33] == `ALUCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & INTISSUE[b+1][0] & (INTISSUE[b+1][35:33] == `ALUCODE)) & 
                                            (~ALu1SelectOld[b/2]))}} & b+1 | 
                                            {5{(((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & INTISSUE[b][0] & (INTISSUE[b][35:33] == `ALUCODE)) &
                                            ~((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & INTISSUE[b+1][0] & (INTISSUE[b+1][35:33] == `ALUCODE)))}} & b |
                                            {5{(~((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & INTISSUE[b][0] & (INTISSUE[b][35:33] == `ALUCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & INTISSUE[b+1][0] & (INTISSUE[b+1][35:33] == `ALUCODE)))}} & b+1 ;
            assign Alu1SelectAblS1P[b/2]  = (((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & INTISSUE[b][0] & (INTISSUE[b][35:33] == `ALUCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & INTISSUE[b+1][0] & (INTISSUE[b+1][35:33] == `ALUCODE)) & 
                                            (ALu1SelectOld[b/2])) & `AbleValue  | 
                                            (((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & INTISSUE[b][0] & (INTISSUE[b][35:33] == `ALUCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & INTISSUE[b+1][0] & (INTISSUE[b+1][35:33] == `ALUCODE)) & 
                                            (~ALu1SelectOld[b/2])) & `AbleValue | 
                                            (((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & INTISSUE[b][0] & (INTISSUE[b][35:33] == `ALUCODE)) &
                                            ~((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & INTISSUE[b+1][0] & (INTISSUE[b+1][35:33] == `ALUCODE))) & `AbleValue |
                                            (~((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & INTISSUE[b][0] & (INTISSUE[b][35:33] == `ALUCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & INTISSUE[b+1][0] & (INTISSUE[b+1][35:33] == `ALUCODE))) & `AbleValue ;

            assign ALu2SelectOld[b/2]  =  ((INTISSUE[b][68] == INTISSUE[b+1][68] & (INTISSUE[b][67:62] < INTISSUE[b+1][67:62]))) | 
                                          ((INTISSUE[b][68] != INTISSUE[b+1][68] & (INTISSUE[b][67:62] > INTISSUE[b+1][67:62]))) ;
            assign Alu2SelectPtrS1P[b/2]  = {5{(((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & ~INTISSUE[b][0] & (INTISSUE[b][35:33] == `ALUCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & ~INTISSUE[b+1][0] & (INTISSUE[b+1][35:33] == `ALUCODE)) & 
                                            (ALu2SelectOld[b/2]))}} & b  | 
                                            {5{(((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & ~INTISSUE[b][0] & (INTISSUE[b][35:33] == `ALUCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & ~INTISSUE[b+1][0] & (INTISSUE[b+1][35:33] == `ALUCODE)) & 
                                            (~ALu2SelectOld[b/2]))}} & b+1 | 
                                            {5{(((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & ~INTISSUE[b][0] & (INTISSUE[b][35:33] == `ALUCODE)) &
                                            ~((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & ~INTISSUE[b+1][0] & (INTISSUE[b+1][35:33] == `ALUCODE)))}} & b |
                                            {5{(~((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & ~INTISSUE[b][0] & (INTISSUE[b][35:33] == `ALUCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & ~INTISSUE[b+1][0] & (INTISSUE[b+1][35:33] == `ALUCODE)))}} & b+1 ;
            assign Alu2SelectAblS1P[b/2]  = (((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & ~INTISSUE[b][0] & (INTISSUE[b][35:33] == `ALUCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & ~INTISSUE[b+1][0] & (INTISSUE[b+1][35:33] == `ALUCODE)) & 
                                            (ALu2SelectOld[b/2])) & `AbleValue  | 
                                            (((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & ~INTISSUE[b][0] & (INTISSUE[b][35:33] == `ALUCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & ~INTISSUE[b+1][0] & (INTISSUE[b+1][35:33] == `ALUCODE)) & 
                                            (~ALu2SelectOld[b/2])) & `AbleValue | 
                                            (((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & ~INTISSUE[b][0] & (INTISSUE[b][35:33] == `ALUCODE)) &
                                            ~((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & ~INTISSUE[b+1][0] & (INTISSUE[b+1][35:33] == `ALUCODE))) & `AbleValue |
                                            (~((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & ~INTISSUE[b][0] & (INTISSUE[b][35:33] == `ALUCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & ~INTISSUE[b+1][0] & (INTISSUE[b+1][35:33] == `ALUCODE))) & `AbleValue ;
            
            assign MulSelectOld[b/2]  =   ((INTISSUE[b][68] == INTISSUE[b+1][68] & (INTISSUE[b][67:62] < INTISSUE[b+1][67:62]))) | 
                                          ((INTISSUE[b][68] != INTISSUE[b+1][68] & (INTISSUE[b][67:62] > INTISSUE[b+1][67:62]))) ;
            assign MulSelectPtrS1P[b/2]  = {5{(((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) &(INTISSUE[b][35:33] == `MULCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][35:33] == `MULCODE)) & 
                                            (MulSelectOld[b/2]))}} & b  | 
                                            {5{(((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & (INTISSUE[b][35:33] == `MULCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][35:33] == `MULCODE)) & 
                                            (~MulSelectOld[b/2]))}} & b+1 | 
                                            {5{(((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & (INTISSUE[b][35:33] == `MULCODE)) &
                                            ~((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][35:33] == `MULCODE)))}} & b |
                                            {5{(~((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & (INTISSUE[b][35:33] == `MULCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][35:33] == `MULCODE)))}} & b+1 ;
            assign MulSelectAblS1P[b/2]  =  (((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & (INTISSUE[b][35:33] == `MULCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][35:33] == `MULCODE)) & 
                                            (MulSelectOld[b/2])) & `AbleValue  | 
                                            (((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & (INTISSUE[b][35:33] == `MULCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][35:33] == `MULCODE)) & 
                                            (~MulSelectOld[b/2])) & `AbleValue | 
                                            (((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & (INTISSUE[b][35:33] == `MULCODE)) &
                                            ~((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52])  & (INTISSUE[b+1][35:33] == `MULCODE))) & `AbleValue |
                                            (~((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52])  & (INTISSUE[b][35:33] == `MULCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][35:33] == `MULCODE))) & `AbleValue ;

            assign DivSelectOld[b/2]  =   ((INTISSUE[b][68] == INTISSUE[b+1][68] & (INTISSUE[b][67:62] < INTISSUE[b+1][67:62]))) | 
                                          ((INTISSUE[b][68] != INTISSUE[b+1][68] & (INTISSUE[b][67:62] > INTISSUE[b+1][67:62]))) ;
            assign DivSelectPtrS1P[b/2]  = {5{(((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & (INTISSUE[b][35:33] == `DIVCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][35:33] == `DIVCODE)) & 
                                            (DivSelectOld[b/2]))}} & b  | 
                                            {5{(((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & (INTISSUE[b][35:33] == `DIVCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][35:33] == `DIVCODE)) & 
                                            (~DivSelectOld[b/2]))}} & b+1 | 
                                            {5{(((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & (INTISSUE[b][35:33] == `DIVCODE)) &
                                            ~((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][35:33] == `DIVCODE)))}} & b |
                                            {5{(~((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & (INTISSUE[b][35:33] == `DIVCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][35:33] == `DIVCODE)))}} & b+1 ;
            assign DivSelectAblS1P[b/2]  =  (((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & (INTISSUE[b][35:33] == `DIVCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][35:33] == `DIVCODE)) & 
                                            (DivSelectOld[b/2])) & `AbleValue  | 
                                            (((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & (INTISSUE[b][35:33] == `DIVCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][35:33] == `DIVCODE)) & 
                                            (~DivSelectOld[b/2])) & `AbleValue | 
                                            (((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & (INTISSUE[b][35:33] == `DIVCODE)) &
                                            ~((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][35:33] == `DIVCODE))) & `AbleValue |
                                            (~((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & (INTISSUE[b][35:33] == `DIVCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][35:33] == `DIVCODE))) & `AbleValue ;



        end
    endgenerate


    wire       Alu1SelectAblS2P [0:7] ;//for Alu1 INTISSUE[i][0] == `AbleValue 
    wire [4:0] Alu1SelectPtrS2P [0:7] ;
    wire       ALu1SelectOldS2P [0:7] ;     

    wire       Alu2SelectAblS2P [0:7] ; //for Alu2 INTISSUE[i][0] == `EnableValue
    wire [4:0] Alu2SelectPtrS2P [0:7] ;
    wire       Alu2SelectOldS2P [0:7] ;

    wire       MulSelectAblS2P [0:7] ; //for Alu2 INTISSUE[i][0] == `EnableValue
    wire [4:0] MulSelectPtrS2P [0:7] ;
    wire       MulSelectOldS2P [0:7] ;

    wire       DivSelectAblS2P [0:7] ; //for Alu2 INTISSUE[i][0] == `EnableValue
    wire [4:0] DivSelectPtrS2P [0:7] ;
    wire       DivSelectOldS2P [0:7] ;

    genvar c ;
    generate
        for (c =0 ;c<16 ;c=c+2 ) begin
            assign  ALu1SelectOldS2P[c/2] = ((INTISSUE[Alu1SelectPtrS1P[c]][68] == INTISSUE[Alu1SelectPtrS1P[c+1]][68]) & (INTISSUE[Alu1SelectPtrS1P[c]][67:62] < INTISSUE[Alu1SelectPtrS1P[c+1]][67:62])) |
                                            ((INTISSUE[Alu1SelectPtrS1P[c]][68] != INTISSUE[Alu1SelectPtrS1P[c+1]][68]) & (INTISSUE[Alu1SelectPtrS1P[c]][67:62] > INTISSUE[Alu1SelectPtrS1P[c+1]][67:62])) ;

            assign {Alu1SelectAblS2P[c/2],Alu1SelectPtrS2P[c/2]} = {6{(Alu1SelectAblS1P[c] & Alu1SelectAblS1P[c+1] & ALu1SelectOldS2P[c/2])}} & {`AbleValue,Alu1SelectPtrS1P[c]}    |
                                                                   {6{(Alu1SelectAblS1P[c] & Alu1SelectAblS1P[c+1] & ~ALu1SelectOldS2P[c/2])}} & {`AbleValue,Alu1SelectPtrS1P[c+1]} |
                                                                   {6{(Alu1SelectAblS1P[c] & ~Alu1SelectAblS1P[c+1])}} & {`AbleValue,Alu1SelectPtrS1P[c]}                        |
                                                                   {6{(~Alu1SelectAblS1P[c] & Alu1SelectAblS1P[c+1])}} & {`AbleValue,Alu1SelectPtrS1P[c+1]}                      ;

            assign  Alu2SelectOldS2P[c/2] = ((INTISSUE[Alu2SelectPtrS1P[c]][68] == INTISSUE[Alu2SelectPtrS1P[c+1]][68]) & (INTISSUE[Alu2SelectPtrS1P[c]][67:62] < INTISSUE[Alu2SelectPtrS1P[c+1]][67:62])) |
                                            ((INTISSUE[Alu2SelectPtrS1P[c]][68] != INTISSUE[Alu2SelectPtrS1P[c+1]][68]) & (INTISSUE[Alu2SelectPtrS1P[c]][67:62] > INTISSUE[Alu2SelectPtrS1P[c+1]][67:62])) ;

            assign {Alu2SelectAblS2P[c/2],Alu2SelectPtrS2P[c/2]} = {6{(Alu2SelectAblS1P[c] & Alu2SelectAblS1P[c+1] & Alu2SelectOldS2P[c/2])}} & {`AbleValue,Alu2SelectPtrS1P[c]}    |
                                                                   {6{(Alu2SelectAblS1P[c] & Alu2SelectAblS1P[c+1] & ~Alu2SelectOldS2P[c/2])}} & {`AbleValue,Alu2SelectPtrS1P[c+1]} |
                                                                   {6{(Alu2SelectAblS1P[c] & ~Alu2SelectAblS1P[c+1])}} & {`AbleValue,Alu2SelectPtrS1P[c]}                        |
                                                                   {6{(~Alu2SelectAblS1P[c] & Alu2SelectAblS1P[c+1])}} & {`AbleValue,Alu2SelectPtrS1P[c+1]}                      ;

            assign  MulSelectOldS2P[c/2] =  ((INTISSUE[MulSelectPtrS1P[c]][68] == INTISSUE[MulSelectPtrS1P[c+1]][68]) & (INTISSUE[MulSelectPtrS1P[c]][67:62] < INTISSUE[MulSelectPtrS1P[c+1]][67:62])) |
                                            ((INTISSUE[MulSelectPtrS1P[c]][68] != INTISSUE[MulSelectPtrS1P[c+1]][68]) & (INTISSUE[MulSelectPtrS1P[c]][67:62] > INTISSUE[MulSelectPtrS1P[c+1]][67:62])) ;

            assign {MulSelectAblS2P[c/2],MulSelectPtrS2P[c/2]} =   {6{(MulSelectAblS1P[c] & MulSelectAblS1P[c+1] & MulSelectOldS2P[c/2])}} & {`AbleValue,MulSelectPtrS1P[c]}    |
                                                                   {6{(MulSelectAblS1P[c] & MulSelectAblS1P[c+1] & ~MulSelectOldS2P[c/2])}} & {`AbleValue,MulSelectPtrS1P[c+1]} |
                                                                   {6{(MulSelectAblS1P[c] & ~MulSelectAblS1P[c+1])}} & {`AbleValue,MulSelectPtrS1P[c]}                        |
                                                                   {6{(~MulSelectAblS1P[c] & MulSelectAblS1P[c+1])}} & {`AbleValue,MulSelectPtrS1P[c+1]}                      ;

            assign  DivSelectOldS2P[c/2] =  ((INTISSUE[DivSelectPtrS1P[c]][68] == INTISSUE[DivSelectPtrS1P[c+1]][68]) & (INTISSUE[DivSelectPtrS1P[c]][67:62] < INTISSUE[DivSelectPtrS1P[c+1]][67:62])) |
                                            ((INTISSUE[DivSelectPtrS1P[c]][68] != INTISSUE[DivSelectPtrS1P[c+1]][68]) & (INTISSUE[DivSelectPtrS1P[c]][67:62] > INTISSUE[DivSelectPtrS1P[c+1]][67:62])) ;

            assign {DivSelectAblS2P[c/2],DivSelectPtrS2P[c/2]} = {6{(DivSelectAblS1P[c] & DivSelectAblS1P[c+1] & DivSelectOldS2P[c/2])}} & {`AbleValue,DivSelectPtrS1P[c]}    |
                                                                   {6{(DivSelectAblS1P[c] & DivSelectAblS1P[c+1] & ~DivSelectOldS2P[c/2])}} & {`AbleValue,DivSelectPtrS1P[c+1]} |
                                                                   {6{(DivSelectAblS1P[c] & ~DivSelectAblS1P[c+1])}} & {`AbleValue,DivSelectPtrS1P[c]}                        |
                                                                   {6{(~DivSelectAblS1P[c] & DivSelectAblS1P[c+1])}} & {`AbleValue,DivSelectPtrS1P[c+1]}                      ;
        end
    endgenerate

    wire       Alu1SelectAblS3P [0:3] ;//for Alu1 INTISSUE[i][0] == `AbleValue 
    wire [4:0] Alu1SelectPtrS3P [0:3] ;
    wire       ALu1SelectOldS3P [0:3] ;

    wire       Alu2SelectAblS3P [0:3] ;//for Alu1 INTISSUE[i][0] == `AbleValue 
    wire [4:0] Alu2SelectPtrS3P [0:3] ;
    wire       ALu2SelectOldS3P [0:3] ; 

    wire       MulSelectAblS3P [0:3] ;//for Alu1 INTISSUE[i][0] == `AbleValue 
    wire [4:0] MulSelectPtrS3P [0:3] ;
    wire       MulSelectOldS3P [0:3] ; 

    wire       DivSelectAblS3P [0:3] ;//for Alu1 INTISSUE[i][0] == `AbleValue 
    wire [4:0] DivSelectPtrS3P [0:3] ;
    wire       DivSelectOldS3P [0:3] ;      

    genvar d ;
    generate
        for (d =0 ;d<8 ;d=d+2 ) begin
            assign ALu1SelectOldS3P[d/2] = ((INTISSUE[Alu1SelectPtrS2P[d]][68] == INTISSUE[Alu1SelectPtrS2P[d+1]][68]) & (INTISSUE[Alu1SelectPtrS2P[d]][67:62] < INTISSUE[Alu1SelectPtrS2P[d+1]][67:62])) |
                                           ((INTISSUE[Alu1SelectPtrS2P[d]][68] != INTISSUE[Alu1SelectPtrS2P[d+1]][68]) & (INTISSUE[Alu1SelectPtrS2P[d]][67:62] > INTISSUE[Alu1SelectPtrS2P[d+1]][67:62])) ;

            assign {Alu1SelectAblS3P[d/2],Alu1SelectPtrS3P[d/2]} = {6{(Alu1SelectAblS2P[d] & Alu1SelectAblS2P[d+1] & ALu1SelectOldS3P[d/2])}} & {`AbleValue,Alu1SelectPtrS2P[d]} |
                                                                   {6{(Alu1SelectAblS2P[d] & Alu1SelectAblS2P[d+1] & ALu1SelectOldS3P[d/2])}} & {`AbleValue,Alu1SelectPtrS2P[d]} |
                                                                   {6{(Alu1SelectAblS2P[d] & ~Alu1SelectAblS2P[d+1])}} & {`AbleValue,Alu1SelectPtrS2P[d]} |
                                                                   {6{(~Alu1SelectAblS2P[d] & Alu1SelectAblS2P[d+1])}} & {`AbleValue,Alu1SelectPtrS2P[d+1]} ;

            assign ALu2SelectOldS3P[d/2] = ((INTISSUE[Alu2SelectPtrS2P[d]][68] == INTISSUE[Alu2SelectPtrS2P[d+1]][68]) & (INTISSUE[Alu2SelectPtrS2P[d]][67:62] < INTISSUE[Alu2SelectPtrS2P[d+1]][67:62])) |
                                           ((INTISSUE[Alu2SelectPtrS2P[d]][68] != INTISSUE[Alu2SelectPtrS2P[d+1]][68]) & (INTISSUE[Alu2SelectPtrS2P[d]][67:62] > INTISSUE[Alu2SelectPtrS2P[d+1]][67:62])) ;

            assign {Alu2SelectAblS3P[d/2],Alu2SelectPtrS3P[d/2]} = {6{(Alu2SelectAblS2P[d] & Alu2SelectAblS2P[d+1] & ALu2SelectOldS3P[d/2])}} & {`AbleValue,Alu2SelectPtrS2P[d]} |
                                                                   {6{(Alu2SelectAblS2P[d] & Alu2SelectAblS2P[d+1] & ALu2SelectOldS3P[d/2])}} & {`AbleValue,Alu2SelectPtrS2P[d]} |
                                                                   {6{(Alu2SelectAblS2P[d] & ~Alu2SelectAblS2P[d+1])}} & {`AbleValue,Alu2SelectPtrS2P[d]} |
                                                                   {6{(~Alu2SelectAblS2P[d] & Alu2SelectAblS2P[d+1])}} & {`AbleValue,Alu2SelectPtrS2P[d+1]} ;

            assign MulSelectOldS3P[d/2] =  ((INTISSUE[MulSelectPtrS2P[d]][68] == INTISSUE[MulSelectPtrS2P[d+1]][68]) & (INTISSUE[MulSelectPtrS2P[d]][67:62] < INTISSUE[MulSelectPtrS2P[d+1]][67:62])) |
                                           ((INTISSUE[MulSelectPtrS2P[d]][68] != INTISSUE[MulSelectPtrS2P[d+1]][68]) & (INTISSUE[MulSelectPtrS2P[d]][67:62] > INTISSUE[MulSelectPtrS2P[d+1]][67:62])) ;

            assign {MulSelectAblS3P[d/2],MulSelectPtrS3P[d/2]} =   {6{(MulSelectAblS2P[d] & MulSelectAblS2P[d+1] & MulSelectOldS3P[d/2])}} & {`AbleValue,MulSelectPtrS2P[d]} |
                                                                   {6{(MulSelectAblS2P[d] & MulSelectAblS2P[d+1] & MulSelectOldS3P[d/2])}} & {`AbleValue,MulSelectPtrS2P[d]} |
                                                                   {6{(MulSelectAblS2P[d] & ~MulSelectAblS2P[d+1])}} & {`AbleValue,MulSelectPtrS2P[d]} |
                                                                   {6{(~MulSelectAblS2P[d] & MulSelectAblS2P[d+1])}} & {`AbleValue,MulSelectPtrS2P[d+1]} ;

            assign DivSelectOldS3P[d/2] =  ((INTISSUE[DivSelectPtrS2P[d]][68] == INTISSUE[DivSelectPtrS2P[d+1]][68]) & (INTISSUE[DivSelectPtrS2P[d]][67:62] < INTISSUE[DivSelectPtrS2P[d+1]][67:62])) |
                                           ((INTISSUE[DivSelectPtrS2P[d]][68] != INTISSUE[DivSelectPtrS2P[d+1]][68]) & (INTISSUE[DivSelectPtrS2P[d]][67:62] > INTISSUE[DivSelectPtrS2P[d+1]][67:62])) ;

            assign {DivSelectAblS3P[d/2],DivSelectPtrS3P[d/2]} =   {6{(DivSelectAblS2P[d] & Alu1SelectAblS2P[d+1] & DivSelectOldS3P[d/2])}} & {`AbleValue,DivSelectPtrS2P[d]} |
                                                                   {6{(DivSelectAblS2P[d] & Alu1SelectAblS2P[d+1] & DivSelectOldS3P[d/2])}} & {`AbleValue,DivSelectPtrS2P[d]} |
                                                                   {6{(DivSelectAblS2P[d] & ~Alu1SelectAblS2P[d+1])}} & {`AbleValue,DivSelectPtrS2P[d]} |
                                                                   {6{(~DivSelectAblS2P[d] & Alu1SelectAblS2P[d+1])}} & {`AbleValue,DivSelectPtrS2P[d+1]} ;
        end
    endgenerate

    wire       Alu1SelectAblS4P [0:1] ;//for Alu1 INTISSUE[i][0] == `AbleValue 
    wire [4:0] Alu1SelectPtrS4P [0:1] ;
    wire       ALu1SelectOldS4P [0:1] ;

    wire       Alu2SelectAblS4P [0:1] ;//for Alu1 INTISSUE[i][0] == `AbleValue 
    wire [4:0] Alu2SelectPtrS4P [0:1] ;
    wire       ALu2SelectOldS4P [0:1] ;

    wire       MulSelectAblS4P [0:1] ;//for Alu1 INTISSUE[i][0] == `AbleValue 
    wire [4:0] MulSelectPtrS4P [0:1] ;
    wire       MulSelectOldS4P [0:1] ;

    wire       DivSelectAblS4P [0:1] ;//for Alu1 INTISSUE[i][0] == `AbleValue 
    wire [4:0] DivSelectPtrS4P [0:1] ;
    wire       DivSelectOldS4P [0:1] ;

    genvar e ;
    generate
        for (e =0 ;e<4 ;e=e+2 ) begin
            assign ALu1SelectOldS4P[e/2] = ((INTISSUE[Alu1SelectPtrS3P[e]][68] == INTISSUE[Alu1SelectPtrS3P[e+1]][68]) & (INTISSUE[Alu1SelectPtrS3P[e]][67:62] < INTISSUE[Alu1SelectPtrS3P[e+1]][67:62])) |
                                           ((INTISSUE[Alu1SelectPtrS3P[e]][68] != INTISSUE[Alu1SelectPtrS3P[e+1]][68]) & (INTISSUE[Alu1SelectPtrS3P[e]][67:62] > INTISSUE[Alu1SelectPtrS3P[e+1]][67:62])) ;
            assign {Alu1SelectAblS4P[e/2],Alu1SelectPtrS4P[e/2]} = {6{(Alu1SelectAblS3P[e] & Alu1SelectAblS3P[e+1] & ALu1SelectOldS4P[e/2])}} & {`AbleValue,Alu1SelectPtrS3P[e]} |
                                                                   {6{(Alu1SelectAblS3P[e] & Alu1SelectAblS3P[e+1] & ~ALu1SelectOldS4P[e/2])}} & {`AbleValue,Alu1SelectPtrS3P[e+1]} |
                                                                   {6{(Alu1SelectAblS3P[e] & ~Alu1SelectAblS3P[e+1])}} & {`AbleValue,Alu1SelectPtrS3P[e]} |
                                                                   {6{(~Alu1SelectAblS3P[e] & Alu1SelectAblS3P[e+1])}} & {`AbleValue,Alu1SelectPtrS3P[e+1]} ;
                                                            
            assign ALu2SelectOldS4P[e/2] = ((INTISSUE[Alu2SelectPtrS3P[e]][68] == INTISSUE[Alu2SelectPtrS3P[e+1]][68]) & (INTISSUE[Alu2SelectPtrS3P[e]][67:62] < INTISSUE[Alu2SelectPtrS3P[e+1]][67:62])) |
                                           ((INTISSUE[Alu2SelectPtrS3P[e]][68] != INTISSUE[Alu2SelectPtrS3P[e+1]][68]) & (INTISSUE[Alu2SelectPtrS3P[e]][67:62] > INTISSUE[Alu2SelectPtrS3P[e+1]][67:62])) ;
            assign {Alu2SelectAblS4P[e/2],Alu2SelectPtrS4P[e/2]} = {6{(Alu2SelectAblS3P[e] & Alu2SelectAblS3P[e+1] & ALu2SelectOldS4P[e/2])}} & {`AbleValue,Alu2SelectPtrS3P[e]} |
                                                                   {6{(Alu2SelectAblS3P[e] & Alu2SelectAblS3P[e+1] & ~ALu2SelectOldS4P[e/2])}} & {`AbleValue,Alu2SelectPtrS3P[e+1]} |
                                                                   {6{(Alu2SelectAblS3P[e] & ~Alu2SelectAblS3P[e+1])}} & {`AbleValue,Alu2SelectPtrS3P[e]} |
                                                                   {6{(~Alu2SelectAblS3P[e] & Alu2SelectAblS3P[e+1])}} & {`AbleValue,Alu2SelectPtrS3P[e+1]} ;

            assign MulSelectOldS4P[e/2] =  ((INTISSUE[MulSelectPtrS3P[e]][68] == INTISSUE[MulSelectPtrS3P[e+1]][68]) & (INTISSUE[MulSelectPtrS3P[e]][67:62] < INTISSUE[MulSelectPtrS3P[e+1]][67:62])) |
                                           ((INTISSUE[MulSelectPtrS3P[e]][68] != INTISSUE[MulSelectPtrS3P[e+1]][68]) & (INTISSUE[MulSelectPtrS3P[e]][67:62] > INTISSUE[MulSelectPtrS3P[e+1]][67:62])) ;
            assign {MulSelectAblS4P[e/2],MulSelectPtrS4P[e/2]} =   {6{(MulSelectAblS3P[e] & MulSelectAblS3P[e+1] & MulSelectOldS4P[e/2])}} & {`AbleValue,MulSelectPtrS3P[e]} |
                                                                   {6{(MulSelectAblS3P[e] & MulSelectAblS3P[e+1] & ~MulSelectOldS4P[e/2])}} & {`AbleValue,MulSelectPtrS3P[e+1]} |
                                                                   {6{(MulSelectAblS3P[e] & ~MulSelectAblS3P[e+1])}} & {`AbleValue,MulSelectPtrS3P[e]} |
                                                                   {6{(~MulSelectAblS3P[e] & MulSelectAblS3P[e+1])}} & {`AbleValue,MulSelectPtrS3P[e+1]} ;

            assign DivSelectOldS4P[e/2] =  ((INTISSUE[DivSelectPtrS3P[e]][68] == INTISSUE[DivSelectPtrS3P[e+1]][68]) & (INTISSUE[DivSelectPtrS3P[e]][67:62] < INTISSUE[DivSelectPtrS3P[e+1]][67:62])) |
                                           ((INTISSUE[DivSelectPtrS3P[e]][68] != INTISSUE[DivSelectPtrS3P[e+1]][68]) & (INTISSUE[DivSelectPtrS3P[e]][67:62] > INTISSUE[DivSelectPtrS3P[e+1]][67:62])) ;
            assign {DivSelectAblS4P[e/2],DivSelectPtrS4P[e/2]} =   {6{(DivSelectAblS3P[e] & DivSelectAblS3P[e+1] & DivSelectOldS4P[e/2])}} & {`AbleValue,DivSelectPtrS3P[e]} |
                                                                   {6{(DivSelectAblS3P[e] & DivSelectAblS3P[e+1] & ~DivSelectOldS4P[e/2])}} & {`AbleValue,DivSelectPtrS3P[e+1]} |
                                                                   {6{(DivSelectAblS3P[e] & ~DivSelectAblS3P[e+1])}} & {`AbleValue,DivSelectPtrS3P[e]} |
                                                                   {6{(~DivSelectAblS3P[e] & DivSelectAblS3P[e+1])}} & {`AbleValue,DivSelectPtrS3P[e+1]} ;
        end 
    endgenerate

    wire       Alu1SelectAblS5P  ;//for Alu1 INTISSUE[i][0] == `AbleValue 
    wire [4:0] Alu1SelectPtrS5P  ;
    wire       ALu1SelectOldS5P  ;

    wire       Alu2SelectAblS5P  ;//for Alu1 INTISSUE[i][0] == `AbleValue 
    wire [4:0] Alu2SelectPtrS5P  ;
    wire       ALu2SelectOldS5P  ;

    wire       MulSelectAblS5P  ;//for Alu1 INTISSUE[i][0] == `AbleValue 
    wire [4:0] MulSelectPtrS5P  ;
    wire       MulSelectOldS5P  ;

    wire       DivSelectAblS5P  ;//for Alu1 INTISSUE[i][0] == `AbleValue 
    wire [4:0] DivSelectPtrS5P  ;
    wire       DivSelectOldS5P  ;

    assign ALu1SelectOldS5P = ((INTISSUE[Alu1SelectPtrS4P[0]][68] == INTISSUE[Alu1SelectPtrS4P[1]][68]) & (INTISSUE[Alu1SelectPtrS4P[0]][67:62] < INTISSUE[Alu1SelectPtrS4P[1]][67:62])) |
                              ((INTISSUE[Alu1SelectPtrS4P[0]][68] != INTISSUE[Alu1SelectPtrS4P[1]][68]) & (INTISSUE[Alu1SelectPtrS4P[0]][67:62] > INTISSUE[Alu1SelectPtrS4P[1]][67:62])) ;

    assign {Alu1SelectAblS5P,Alu1SelectPtrS5P} = {6{(Alu1SelectAblS4P[0] & Alu1SelectAblS4P[1] & ALu1SelectOldS5P)}} & {`AbleValue,Alu1SelectPtrS4P[0]} |
                                                 {6{(Alu1SelectAblS4P[0] & Alu1SelectAblS4P[1] & ~ALu1SelectOldS5P)}} & {`AbleValue,Alu1SelectPtrS4P[1]} |
                                                 {6{(Alu1SelectAblS4P[0] & ~Alu1SelectAblS4P[1])}} & {`AbleValue,Alu1SelectPtrS4P[0]} |
                                                 {6{(~Alu1SelectAblS4P[0] & Alu1SelectAblS4P[1])}} & {`AbleValue,Alu1SelectPtrS4P[1]} ;

    assign ALu2SelectOldS5P = ((INTISSUE[Alu2SelectPtrS4P[0]][68] == INTISSUE[Alu2SelectPtrS4P[1]][68]) & (INTISSUE[Alu2SelectPtrS4P[0]][67:62] < INTISSUE[Alu2SelectPtrS4P[1]][67:62])) |
                              ((INTISSUE[Alu2SelectPtrS4P[0]][68] != INTISSUE[Alu2SelectPtrS4P[1]][68]) & (INTISSUE[Alu2SelectPtrS4P[0]][67:62] > INTISSUE[Alu2SelectPtrS4P[1]][67:62])) ;

    assign {Alu2SelectAblS5P,Alu2SelectPtrS5P} = {6{(Alu2SelectAblS4P[0] & Alu2SelectAblS4P[1] & ALu2SelectOldS5P)}} & {`AbleValue,Alu2SelectPtrS4P[0]} |
                                                 {6{(Alu2SelectAblS4P[0] & Alu2SelectAblS4P[1] & ~ALu2SelectOldS5P)}} & {`AbleValue,Alu2SelectPtrS4P[1]} |
                                                 {6{(Alu2SelectAblS4P[0] & ~Alu2SelectAblS4P[1])}} & {`AbleValue,Alu2SelectPtrS4P[0]} |
                                                 {6{(~Alu2SelectAblS4P[0] & Alu2SelectAblS4P[1])}} & {`AbleValue,Alu2SelectPtrS4P[1]} ;

    assign MulSelectOldS5P =  ((INTISSUE[MulSelectPtrS4P[0]][68] == INTISSUE[MulSelectPtrS4P[1]][68]) & (INTISSUE[MulSelectPtrS4P[0]][67:62] < INTISSUE[MulSelectPtrS4P[1]][67:62])) |
                              ((INTISSUE[MulSelectPtrS4P[0]][68] != INTISSUE[MulSelectPtrS4P[1]][68]) & (INTISSUE[MulSelectPtrS4P[0]][67:62] > INTISSUE[MulSelectPtrS4P[1]][67:62])) ;

    assign {MulSelectAblS5P,MulSelectPtrS5P} =   {6{(MulSelectAblS4P[0] & MulSelectAblS4P[1] & MulSelectOldS5P)}} & {`AbleValue,MulSelectPtrS4P[0]} |
                                                 {6{(MulSelectAblS4P[0] & MulSelectAblS4P[1] & ~MulSelectOldS5P)}} & {`AbleValue,MulSelectPtrS4P[1]} |
                                                 {6{(MulSelectAblS4P[0] & ~MulSelectAblS4P[1])}} & {`AbleValue,MulSelectPtrS4P[0]} |
                                                 {6{(~MulSelectAblS4P[0] & MulSelectAblS4P[1])}} & {`AbleValue,MulSelectPtrS4P[1]} ;

    assign DivSelectOldS5P =  ((INTISSUE[DivSelectPtrS4P[0]][68] == INTISSUE[DivSelectPtrS4P[1]][68]) & (INTISSUE[DivSelectPtrS4P[0]][67:62] < INTISSUE[DivSelectPtrS4P[1]][67:62])) |
                              ((INTISSUE[DivSelectPtrS4P[0]][68] != INTISSUE[DivSelectPtrS4P[1]][68]) & (INTISSUE[DivSelectPtrS4P[0]][67:62] > INTISSUE[DivSelectPtrS4P[1]][67:62])) ;

    assign {DivSelectAblS5P,DivSelectPtrS5P} =   {6{(DivSelectAblS4P[0] & DivSelectAblS4P[1] & DivSelectOldS5P)}} & {`AbleValue,DivSelectPtrS4P[0]} |
                                                 {6{(DivSelectAblS4P[0] & DivSelectAblS4P[1] & ~DivSelectOldS5P)}} & {`AbleValue,DivSelectPtrS4P[1]} |
                                                 {6{(DivSelectAblS4P[0] & ~DivSelectAblS4P[1])}} & {`AbleValue,DivSelectPtrS4P[0]} |
                                                 {6{(~DivSelectAblS4P[0] & DivSelectAblS4P[1])}} & {`AbleValue,DivSelectPtrS4P[1]} ;


   

    //boradcost

    //for delay
    reg [2:0]  MulShiftDelay ;
    reg [4:0]  MulDelayAddr  ;
    always @(posedge Clk) begin
        if(!Rest)begin
            MulShiftDelay <= 3'd0 ;
            MulDelayAddr  <= 5'd0 ;
        end
        else if(IsQuIntFlash) begin
            MulShiftDelay <= 3'd0 ;
            MulDelayAddr  <= 5'd0 ;
        end
        else if(IsQuIntStop) begin
            MulShiftDelay <= MulShiftDelay ;
            MulDelayAddr  <= MulDelayAddr ;
        end
        else begin
            if(MulSelectAblS5P) begin
                MulShiftDelay <= 3'b100 ;
                MulDelayAddr  <=  MulSelectPtrS5P ;
            end 
            else begin
                MulShiftDelay <= {1'b0,MulShiftDelay[1:0]} ;
                MulDelayAddr  <= MulDelayAddr ;
            end 
        end
    end

    assign Alu1BroadcastAble = Alu1SelectAblS5P & INTISSUE[Alu1SelectPtrS5P][43] & ~StopTemp            ;
    assign Alu1BroadcastAddr = INTISSUE[Alu1SelectPtrS5P][42:36] & {7{~StopTemp }}      ;
    assign Alu2BroadcastAble = Alu2SelectAblS5P & INTISSUE[Alu2SelectPtrS5P][43] & ~StopTemp            ;
    assign Alu2BroadcastAddr = INTISSUE[Alu2SelectPtrS5P][42:36] & {7{~StopTemp }}      ;
    assign MulBroadcastAble  = (MulShiftDelay == 3'b001) & INTISSUE[MulDelayAddr][43] & ~StopTemp       ;
    assign MulBroadcastAddr  = INTISSUE[MulDelayAddr][42:36]     & {7{~StopTemp }}      ;

    wire Inst1SelectAble   = Alu1SelectAblS5P & ~StopTemp ;
    wire [4:0] Inst1SelectPtr    = Alu1SelectPtrS5P & {5{~StopTemp}};
    wire Inst2SelectAble   = Alu2SelectAblS5P & ~StopTemp ;
    wire [4:0] Inst2SelectPtr    = Alu2SelectPtrS5P & {5{~StopTemp}};
    wire Inst3SelectAble   = MulSelectAblS5P & ~StopTemp ;
    wire [4:0] Inst3SelectPtr    = MulSelectPtrS5P & {5{~StopTemp}};
    wire Inst4SelectAble   = DivSelectAblS5P & ~StopTemp ;
    wire [4:0]Inst4SelectPtr    = DivSelectPtrS5P & {5{~StopTemp}};


    assign Alu1Inst          = Alu1BroadcastAble ;
    assign Alu1InstAddr      = Alu1BroadcastAddr ;
    assign Alu2Inst          = Alu2BroadcastAble ;
    assign ALu2InstAddr      = Alu2BroadcastAddr ;
    assign MulInst           = MulBroadcastAble  ;
    assign MulInstAddr       = MulBroadcastAddr  ;

    //to read physical

    assign Inst1MicOperate = Alu1Req ? INTISSUE[Alu1SelectPtrS5P][35:28] : 8'b0 ;
    assign Inst1Src1RAble  = Alu1Req ? INTISSUE[Alu1SelectPtrS5P][52]    : 1'b0 ;
    assign Inst1Src1RAddr  = Alu1Req ? INTISSUE[Alu1SelectPtrS5P][50:44] : 7'b0 ; 
    assign Inst1Src2RAble  = Alu1Req ? INTISSUE[Alu1SelectPtrS5P][61]    : 1'b0 ;
    assign Inst1Src2RAddr  = Alu1Req ? INTISSUE[Alu1SelectPtrS5P][59:53] : 7'b0 ;
    assign Inst1ImmAble    = Alu1Req ? INTISSUE[Alu1SelectPtrS5P][27]    : 1'b0 ;
    assign Inst1ImmDate    = Alu1Req ? INTISSUE[Alu1SelectPtrS5P][26:1]  : 26'b0;
    assign Inst1RdAble     = Alu1Req ? INTISSUE[Alu1SelectPtrS5P][43]    : 1'b0 ;
    assign Inst1RdAddr     = Alu1Req ? INTISSUE[Alu1SelectPtrS5P][42:36] : 7'b0 ;
    assign Inst1RoBptr     = Alu1Req ? INTISSUE[Alu1SelectPtrS5P][67:62] : 6'b0 ;

    assign Inst2MicOperate = Alu2Req ? INTISSUE[Alu2SelectPtrS5P][35:28] : 8'b0 ;
    assign Inst2Src1RAble  = Alu2Req ? INTISSUE[Alu2SelectPtrS5P][52]    : 1'b0 ;
    assign Inst2Src1RAddr  = Alu2Req ? INTISSUE[Alu2SelectPtrS5P][50:44] : 7'b0 ; 
    assign Inst2Src2RAble  = Alu2Req ? INTISSUE[Alu2SelectPtrS5P][61]    : 1'b0 ;
    assign Inst2Src2RAddr  = Alu2Req ? INTISSUE[Alu2SelectPtrS5P][59:53] : 7'b0 ;
    assign Inst2ImmAble    = Alu2Req ? INTISSUE[Alu2SelectPtrS5P][27]    : 1'b0 ;
    assign Inst2ImmDate    = Alu2Req ? INTISSUE[Alu2SelectPtrS5P][26:1]  : 26'b0;
    assign Inst2RdAble     = Alu2Req ? INTISSUE[Alu2SelectPtrS5P][43]    : 1'b0 ;
    assign Inst2RdAddr     = Alu2Req ? INTISSUE[Alu2SelectPtrS5P][42:36] : 7'b0 ;
    assign Inst2RoBptr     = Alu2Req ? INTISSUE[Alu2SelectPtrS5P][67:62] : 6'b0 ;

    assign Inst3MicOperate = MulReq ? INTISSUE[MulSelectPtrS5P][35:28] : 8'b0 ;
    assign Inst3Src1RAble  = MulReq ? INTISSUE[MulSelectPtrS5P][52]    : 1'b0 ;
    assign Inst3Src1RAddr  = MulReq ? INTISSUE[MulSelectPtrS5P][50:44] : 7'b0 ; 
    assign Inst3Src2RAble  = MulReq ? INTISSUE[MulSelectPtrS5P][61]    : 1'b0 ;
    assign Inst3Src2RAddr  = MulReq ? INTISSUE[MulSelectPtrS5P][59:53] : 7'b0 ;
    assign Inst3ImmAble    = MulReq ? INTISSUE[MulSelectPtrS5P][27]    : 1'b0 ;
    assign Inst3ImmDate    = MulReq ? INTISSUE[MulSelectPtrS5P][26:1]  : 26'b0;
    assign Inst3RdAble     = MulReq ? INTISSUE[MulSelectPtrS5P][43]    : 1'b0 ;
    assign Inst3RdAddr     = MulReq ? INTISSUE[MulSelectPtrS5P][42:36] : 7'b0 ;
    assign Inst3RoBptr     = MulReq ? INTISSUE[MulSelectPtrS5P][67:62] : 6'b0 ;

    assign Inst4MicOperate = DivReq ? INTISSUE[DivSelectPtrS5P][35:28] : 8'b0 ;
    assign Inst4Src1RAble  = DivReq ? INTISSUE[DivSelectPtrS5P][52]    : 1'b0 ;
    assign Inst4Src1RAddr  = DivReq ? INTISSUE[DivSelectPtrS5P][50:44] : 7'b0 ; 
    assign Inst4Src2RAble  = DivReq ? INTISSUE[DivSelectPtrS5P][61]    : 1'b0 ;
    assign Inst4Src2RAddr  = DivReq ? INTISSUE[DivSelectPtrS5P][59:53] : 7'b0 ;
    assign Inst4ImmAble    = DivReq ? INTISSUE[DivSelectPtrS5P][27]    : 1'b0 ;
    assign Inst4ImmDate    = DivReq ? INTISSUE[DivSelectPtrS5P][26:1]  : 26'b0;
    assign Inst4RdAble     = DivReq ? INTISSUE[DivSelectPtrS5P][43]    : 1'b0 ;
    assign Inst4RdAddr     = DivReq ? INTISSUE[DivSelectPtrS5P][42:36] : 7'b0 ;
    assign Inst4RoBptr     = DivReq ? INTISSUE[DivSelectPtrS5P][67:62] : 6'b0 ;

endmodule 
