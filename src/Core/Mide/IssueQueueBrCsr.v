`timescale 1ps/1ps
`include "../define.v"
`include "../../Lib/BrCsrIQ1Criq4.v"
`include "../../Lib/BrCsrIQ2Criq4.v"
`include "../../Lib/BrCsrIQ3Criq4.v"
`include "../../Lib/BrCsrIQ4Criq4.v"

module IssueQueueBrCsr (
    input       wire                                      Clk               ,
    input       wire                                      Rest              ,
    //for ctrl
    input       wire                                      BrCsrStop         ,
    input       wire                                      BrCsrFlash        ,
    output      wire                                      BrCsrReq          ,
    //from RAT
    input       wire        [2:0]                         BInIQInstNum      ,
    input       wire                                      BIn1Src1Able      ,
    input       wire                                      BIn1Src1Ready     ,
    input       wire        [`ReNameRegBUs]               BIn1Src1Addr      ,
    input       wire                                      BIn1Src2Able      ,
    input       wire                                      BIn1Src2Ready     ,
    input       wire        [`ReNameRegBUs]               BIn1Src2Addr      ,
    input       wire                                      BIn1RdAble        ,
    input       wire        [`ReNameRegBUs]               BIn1RdAddr        ,
    input       wire                                      BIn2Src1Able      ,
    input       wire                                      BIn2Src1Ready     ,
    input       wire        [`ReNameRegBUs]               BIn2Src1Addr      ,
    input       wire                                      BIn2Src2Able      ,
    input       wire                                      BIn2Src2Ready     ,
    input       wire        [`ReNameRegBUs]               BIn2Src2Addr      ,
    input       wire                                      BIn2RdAble        ,
    input       wire        [`ReNameRegBUs]               BIn2RdAddr        ,
    input       wire                                      BIn3Src1Able      ,
    input       wire                                      BIn3Src1Ready     ,
    input       wire        [`ReNameRegBUs]               BIn3Src1Addr      ,
    input       wire                                      BIn3Src2Able      ,
    input       wire                                      BIn3Src2Ready     ,
    input       wire        [`ReNameRegBUs]               BIn3Src2Addr      ,
    input       wire                                      BIn3RdAble        ,
    input       wire        [`ReNameRegBUs]               BIn3RdAddr        ,
    input       wire                                      BIn4Src1Able      ,
    input       wire                                      BIn4Src1Ready     ,
    input       wire        [`ReNameRegBUs]               BIn4Src1Addr      ,
    input       wire                                      BIn4Src2Able      ,
    input       wire                                      BIn4Src2Ready     ,
    input       wire        [`ReNameRegBUs]               BIn4Src2Addr      ,
    input       wire                                      BIn4RdAble        ,
    input       wire        [`ReNameRegBUs]               BIn4RdAddr        ,
    //from decode delay 1 clcye
    input       wire                                      BIn1aAble         ,
    input       wire        [`MicOperateCode]             BIn1MicOpcode     ,
    input       wire                                      BIn1ImmAble       ,
    input       wire        [25:0]                        BIn1ImmDate       ,
    input       wire                                      BIn1Mode          ,
    input       wire        [`InstAddrBus]                BIn1ReDirAddr     ,
    input       wire        [6:0]                         BIn1RobPtr        ,
    input       wire                                      BIn2aAble         ,
    input       wire        [`MicOperateCode]             BIn2MicOpcode     ,
    input       wire                                      BIn2ImmAble       ,
    input       wire        [25:0]                        BIn2ImmDate       ,
    input       wire                                      BIn2Mode          ,
    input       wire        [`InstAddrBus]                BIn2ReDirAddr     ,
    input       wire        [6:0]                         BIn2RobPtr        ,
    input       wire                                      BIn3aAble         ,
    input       wire        [`MicOperateCode]             BIn3MicOpcode     ,
    input       wire                                      BIn3ImmAble       ,
    input       wire        [25:0]                        BIn3ImmDate       ,
    input       wire                                      BIn3Mode          ,
    input       wire        [`InstAddrBus]                BIn3ReDirAddr     ,
    input       wire        [6:0]                         BIn3RobPtr        ,
    input       wire                                      BIn4aAble         ,
    input       wire        [`MicOperateCode]             BIn4MicOpcode     ,
    input       wire                                      BIn4ImmAble       ,
    input       wire        [25:0]                        BIn4ImmDate       ,
    input       wire                                      BIn4Mode          ,
    input       wire        [`InstAddrBus]                BIn4ReDirAddr     ,
    input       wire        [6:0]                         BIn4RobPtr        ,
    //for req
    input       wire                                      CsrReq            ,
    input       wire                                      BrReq             ,
    //weak-up
    input       wire                                      FromIsQAlu1       ,
    input       wire        [`ReNameRegBUs]               FromAlu1Addr      , 
    input       wire                                      FromIsQAlu2       ,
    input       wire        [`ReNameRegBUs]               FromAlu2Addr      ,//delay broadcast
    input       wire                                      FromIsQMul        ,
    input       wire        [`ReNameRegBUs]               FromMulAddr       ,
    input       wire                                      ByPassBDiv        ,
    input       wire        [`ReNameRegBUs]               ByPassBDivAddr    ,
    input       wire                                      BypassBSC         ,
    input       wire        [`ReNameRegBUs]               BypassBSCAddr     ,
    input       wire                                      ByPassBLoad       ,
    input       wire        [`ReNameRegBUs]               ByPassBLoadAddr   ,//bypass
    //delay bus
    output      wire                                      OutCsrAble        ,
    output      wire        [`ReNameRegBUs]               OutCsrAddr        ,
    output      wire                                      OutBruAble        ,
    output      wire        [`ReNameRegBUs]               OutBruAddr        ,
    //to Eu
    output      wire        [`MicOperateCode]             BInst1MicOperate  , 
    output      wire                                      BInst1Src1RAble   ,
    output      wire        [`ReNameRegBUs]               BInst1Src1RAddr   , 
    output      wire                                      BInst1Src2RAble   ,
    output      wire        [`ReNameRegBUs]               BInst1Src2RAddr   ,    
    output      wire                                      BInst1ImmAble     ,
    output      wire        [25:0]                        BInst1ImmDate     ,
    output      wire                                      BInst1RdAble      ,
    output      wire        [`ReNameRegBUs]               BInst1RdAddr      , 
    output      wire                                      BInst1Mode        ,
    output      wire        [`InstAddrBus]                BInst1RedieAddr   ,
    output      wire        [5:0]                         BInst1RoBptr      ,
    output      wire        [`MicOperateCode]             BInst2MicOperate  , 
    output      wire                                      BInst2Src1RAble   ,
    output      wire        [`ReNameRegBUs]               BInst2Src1RAddr   , 
    output      wire                                      BInst2Src2RAble   ,
    output      wire        [`ReNameRegBUs]               BInst2Src2RAddr   ,    
    output      wire                                      BInst2ImmAble     ,
    output      wire        [25:0]                        BInst2ImmDate     ,
    output      wire                                      BInst2RdAble      ,
    output      wire        [`ReNameRegBUs]               BInst2RdAddr      , 
    output      wire        [5:0]                         BInst2RoBptr                                           
);

    reg StopTemp  ;
    reg FlashTemp ;

    always @(posedge Clk) begin
        if(!Rest) begin
            StopTemp    <= 1'b0 ;
            FlashTemp   <= 1'b0 ;
        end
        else begin
            StopTemp    <= BrCsrStop ;
            FlashTemp   <= BrCsrFlash;
        end
    end

    reg  [100:0] CBISSUE [0:15] ;

    reg  [2:0]  CBWritePtr ;
    reg  [2:0]  CBReadPtr  ;

    // wire [2:0]  ReadNum = BIn1aAble & BIn2aAble & BIn3aAble & BIn4aAble ? 3'd4 :
    //                       BIn1aAble & BIn2aAble & BIn3aAble & ~BIn4aAble ? 3'd3 :
    //                       BIn1aAble & BIn2aAble & ~BIn3aAble & ~BIn4aAble ? 3'd2 :
    //                       BIn1aAble & ~BIn2aAble & ~BIn3aAble & ~BIn4aAble ? 3'd1 : 3'd0 ;
                                                
    always @(posedge Clk) begin
        if(!Rest) begin
            CBReadPtr <= 3'd0 ;
        end        
        else begin
            CBReadPtr <= CBReadPtr[1:0] + BInIQInstNum ;
        end 
    end 

    wire                   BCsrIssueAble  ;
    wire  [`ReNameRegBUs]  BCsrIssueAddr  ; 
    wire                   BBrIssueAble   ;
    wire  [`ReNameRegBUs]  BBrIssueAddr   ; 

    wire         BInst1Src1Ready = ((BIn1Src1Addr == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                   ((BIn1Src1Addr == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                   ((BIn1Src1Addr == FromMulAddr    ) && (FromIsQMul )) ||
                                   ((BIn1Src1Addr == ByPassBDivAddr ) && (ByPassBDiv )) ||
                                   ((BIn1Src1Addr == BypassBSCAddr  ) && (BypassBSC  )) ||
                                   ((BIn1Src1Addr == ByPassBLoadAddr) && (ByPassBLoad)) ||
                                   ((BIn1Src1Addr == BCsrIssueAddr  ) && (BCsrIssueAble))||
                                   ((BIn1Src1Addr == BBrIssueAddr   ) && (BBrIssueAble)) ;

    wire         BInst2Src1Ready = ((BIn2Src1Addr == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                   ((BIn2Src1Addr == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                   ((BIn2Src1Addr == FromMulAddr    ) && (FromIsQMul )) ||
                                   ((BIn2Src1Addr == ByPassBDivAddr ) && (ByPassBDiv )) ||
                                   ((BIn2Src1Addr == BypassBSCAddr  ) && (BypassBSC  )) ||
                                   ((BIn2Src1Addr == ByPassBLoadAddr) && (ByPassBLoad)) ||
                                   ((BIn2Src1Addr == BCsrIssueAddr  ) && (BCsrIssueAble))||
                                   ((BIn2Src1Addr == BBrIssueAddr   ) && (BBrIssueAble)) ;

    wire         BInst3Src1Ready = ((BIn3Src1Addr == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                   ((BIn3Src1Addr == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                   ((BIn3Src1Addr == FromMulAddr    ) && (FromIsQMul )) ||
                                   ((BIn3Src1Addr == ByPassBDivAddr ) && (ByPassBDiv )) ||
                                   ((BIn3Src1Addr == BypassBSCAddr  ) && (BypassBSC  )) ||
                                   ((BIn3Src1Addr == ByPassBLoadAddr) && (ByPassBLoad)) ||
                                   ((BIn3Src1Addr == BCsrIssueAddr  ) && (BCsrIssueAble))||
                                   ((BIn3Src1Addr == BBrIssueAddr   ) && (BBrIssueAble)) ;

    wire         BInst4Src1Ready = ((BIn4Src1Addr == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                   ((BIn4Src1Addr == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                   ((BIn4Src1Addr == FromMulAddr    ) && (FromIsQMul )) ||
                                   ((BIn4Src1Addr == ByPassBDivAddr ) && (ByPassBDiv )) ||
                                   ((BIn4Src1Addr == BypassBSCAddr  ) && (BypassBSC  )) ||
                                   ((BIn4Src1Addr == ByPassBLoadAddr) && (ByPassBLoad)) ||
                                   ((BIn4Src1Addr == BCsrIssueAddr  ) && (BCsrIssueAble))||
                                   ((BIn4Src1Addr == BBrIssueAddr   ) && (BBrIssueAble)) ;

    wire         BInst1Src2Ready = ((BIn1Src2Addr == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                   ((BIn1Src2Addr == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                   ((BIn1Src2Addr == FromMulAddr    ) && (FromIsQMul )) ||
                                   ((BIn1Src2Addr == ByPassBDivAddr ) && (ByPassBDiv )) ||
                                   ((BIn1Src2Addr == BypassBSCAddr  ) && (BypassBSC  )) ||
                                   ((BIn1Src2Addr == ByPassBLoadAddr) && (ByPassBLoad)) ||
                                   ((BIn1Src2Addr == BCsrIssueAddr  ) && (BCsrIssueAble))||
                                   ((BIn1Src2Addr == BBrIssueAddr   ) && (BBrIssueAble)) ;

    wire         BInst2Src2Ready = ((BIn2Src2Addr == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                   ((BIn2Src2Addr == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                   ((BIn2Src2Addr == FromMulAddr    ) && (FromIsQMul )) ||
                                   ((BIn2Src2Addr == ByPassBDivAddr ) && (ByPassBDiv )) ||
                                   ((BIn2Src2Addr == BypassBSCAddr  ) && (BypassBSC  )) ||
                                   ((BIn2Src2Addr == ByPassBLoadAddr) && (ByPassBLoad)) ||
                                   ((BIn2Src2Addr == BCsrIssueAddr  ) && (BCsrIssueAble))||
                                   ((BIn2Src2Addr == BBrIssueAddr   ) && (BBrIssueAble)) ;

    wire         BInst3Src2Ready = ((BIn3Src2Addr == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                   ((BIn3Src2Addr == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                   ((BIn3Src2Addr == FromMulAddr    ) && (FromIsQMul )) ||
                                   ((BIn3Src2Addr == ByPassBDivAddr ) && (ByPassBDiv )) ||
                                   ((BIn3Src2Addr == BypassBSCAddr  ) && (BypassBSC  )) ||
                                   ((BIn3Src2Addr == ByPassBLoadAddr) && (ByPassBLoad)) ||
                                   ((BIn3Src2Addr == BCsrIssueAddr  ) && (BCsrIssueAble))||
                                   ((BIn3Src2Addr == BBrIssueAddr   ) && (BBrIssueAble)) ;

    wire         BInst4Src2Ready = ((BIn4Src2Addr == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                   ((BIn4Src2Addr == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                   ((BIn4Src2Addr == FromMulAddr    ) && (FromIsQMul )) ||
                                   ((BIn4Src2Addr == ByPassBDivAddr ) && (ByPassBDiv )) ||
                                   ((BIn4Src2Addr == BypassBSCAddr  ) && (BypassBSC  )) ||
                                   ((BIn4Src2Addr == ByPassBLoadAddr) && (ByPassBLoad)) ||
                                   ((BIn4Src2Addr == BCsrIssueAddr  ) && (BCsrIssueAble))||
                                   ((BIn4Src2Addr == BBrIssueAddr   ) && (BBrIssueAble)) ;

    wire [100:0] Write1Issue = {BIn1ReDirAddr,BIn1RobPtr,BIn1Src2Able,((StopTemp | BIn1Src2Ready | ~BIn1Src2Able) ? BIn1Src2Ready : BInst1Src2Ready),BIn1Src2Addr,
                                                         BIn1Src1Able,((StopTemp | BIn1Src1Ready | ~BIn1Src1Able) ? BIn1Src1Ready : BInst1Src1Ready),BIn1Src1Addr,
                                                         BIn1RdAble,BIn1RdAddr,BIn1MicOpcode,BIn1ImmAble,BIn1ImmDate,BIn1Mode} ; 
    wire [100:0] Write2Issue = {BIn2ReDirAddr,BIn2RobPtr,BIn2Src2Able,((StopTemp | BIn2Src2Ready | ~BIn2Src2Able) ? BIn2Src2Ready : BInst2Src2Ready),BIn2Src2Addr,
                                                         BIn2Src1Able,((StopTemp | BIn2Src1Ready | ~BIn2Src1Able) ? BIn2Src1Ready : BInst2Src1Ready),BIn2Src1Addr,
                                                         BIn2RdAble,BIn2RdAddr,BIn2MicOpcode,BIn2ImmAble,BIn2ImmDate,BIn2Mode} ;  
    wire [100:0] Write3Issue = {BIn3ReDirAddr,BIn3RobPtr,BIn3Src2Able,((StopTemp | BIn3Src2Ready | ~BIn3Src2Able) ? BIn3Src2Ready : BInst3Src2Ready),BIn3Src2Addr,
                                                         BIn3Src1Able,((StopTemp | BIn3Src1Ready | ~BIn3Src1Able) ? BIn3Src1Ready : BInst3Src1Ready),BIn3Src1Addr,
                                                         BIn3RdAble,BIn3RdAddr,BIn3MicOpcode,BIn3ImmAble,BIn3ImmDate,BIn3Mode} ;
    wire [100:0] Write4Issue = {BIn4ReDirAddr,BIn4RobPtr,BIn4Src2Able,((StopTemp | BIn4Src2Ready | ~BIn4Src2Able) ? BIn4Src2Ready : BInst4Src2Ready),BIn4Src2Addr,
                                                         BIn4Src1Able,((StopTemp | BIn4Src1Ready | ~BIn4Src1Able) ? BIn4Src1Ready : BInst4Src1Ready),BIn4Src1Addr,
                                                         BIn4RdAble,BIn4RdAddr,BIn4MicOpcode,BIn4ImmAble,BIn4ImmDate,BIn4Mode} ;

    wire          U1ReadAble  ;
    wire          U2ReadAble  ;
    wire          U3ReadAble  ;
    wire          U4ReadAble  ;
    wire  [100:0] WriteDate1  ;
    wire  [100:0] WriteDate2  ;
    wire  [100:0] WriteDate3  ;
    wire  [100:0] WriteDate4  ;

    assign {WriteDate1,U1ReadAble}   =  (CBReadPtr[1:0] == 0) ? {Write1Issue,BIn1aAble} : 
                                        (CBReadPtr[1:0] == 1) ? {Write4Issue,BIn4aAble} :
                                        (CBReadPtr[1:0] == 2) ? {Write3Issue,BIn3aAble} :
                                        (CBReadPtr[1:0] == 3) ? {Write2Issue,BIn2aAble} : {101'd0,`EnableValue} ;

    assign {WriteDate2,U2ReadAble}   =  (CBReadPtr[1:0] == 0) ? {Write2Issue,BIn2aAble} :
                                        (CBReadPtr[1:0] == 1) ? {Write1Issue,BIn1aAble} :
                                        (CBReadPtr[1:0] == 2) ? {Write4Issue,BIn4aAble} :
                                        (CBReadPtr[1:0] == 3) ? {Write3Issue,BIn3aAble} : {101'd0,`EnableValue} ;

    assign {WriteDate3,U3ReadAble}   =  (CBReadPtr[1:0] == 0) ? {Write3Issue,BIn3aAble} :
                                        (CBReadPtr[1:0] == 1) ? {Write2Issue,BIn2aAble} :
                                        (CBReadPtr[1:0] == 2) ? {Write1Issue,BIn1aAble} :
                                        (CBReadPtr[1:0] == 3) ? {Write4Issue,BIn4aAble} : {101'd0,`EnableValue} ;

    assign {WriteDate4,U4ReadAble}   =  (CBReadPtr[1:0] == 0) ? {Write4Issue,BIn4aAble} :
                                        (CBReadPtr[1:0] == 1) ? {Write3Issue,BIn3aAble} :
                                        (CBReadPtr[1:0] == 2) ? {Write2Issue,BIn2aAble} :
                                        (CBReadPtr[1:0] == 3) ? {Write1Issue,BIn1aAble} : {101'd0,`EnableValue} ;

    wire [3:0] CriqPreOut1 ;
    wire [3:0] CriqPreOut2 ;
    wire [3:0] CriqPreOut3 ;
    wire [3:0] CriqPreOut4 ;

    wire [7:0] CBQWritePtr ;
    wire       CBQWrite1   ;
    wire       CBQWrite2   ;

    assign {CBQWritePtr,CBQWrite1,CBQWrite2} = {10{({BCsrIssueAble,BBrIssueAble} == 2'b11)}} & {BCsrIssueAddr,BBrIssueAddr,2'b11} |
                                               {10{({BCsrIssueAble,BBrIssueAble} == 2'b10)}} & {4'b0,BCsrIssueAddr,2'b01} |   
                                               {10{({BCsrIssueAble,BBrIssueAble} == 2'b01)}} & {4'b0,BBrIssueAddr,2'b01} ;   

    wire [1:0] CBQWriteNum = (CBQWrite1 & CBQWrite2)  & 2'b10 |
                             (CBQWrite1 & ~CBQWrite2) & 2'b01 ;

    always @(posedge Clk) begin
        if(!Rest) begin
            CBWritePtr <= 3'b0 ;
        end
        else if(BrCsrFlash) begin
            CBWritePtr <= 3'b0 ; 
        end
        else begin
            CBWritePtr <= CBWritePtr[1:0] + CBQWriteNum ;
        end
    end

    wire        WriteCriq1Able = (CBWritePtr[1:0] == 0) ? CBQWrite1    : 
                                 (CBWritePtr[1:0] == 1) ? `EnableValue : 
                                 (CBWritePtr[1:0] == 2) ? `EnableValue : 
                                 (CBWritePtr[1:0] == 3) ? CBQWrite2    : `EnableValue ;
    wire        WriteCriq2Able = (CBWritePtr[1:0] == 0) ? CBQWrite2    : 
                                 (CBWritePtr[1:0] == 1) ? CBQWrite1    : 
                                 (CBWritePtr[1:0] == 2) ? `EnableValue : 
                                 (CBWritePtr[1:0] == 3) ? `EnableValue : `EnableValue ;
    wire        WriteCriq3Able = (CBWritePtr[1:0] == 0) ? `EnableValue : 
                                 (CBWritePtr[1:0] == 1) ? CBQWrite2    : 
                                 (CBWritePtr[1:0] == 2) ? CBQWrite1    : 
                                 (CBWritePtr[1:0] == 3) ? `EnableValue : `EnableValue ;
    wire        WriteCriq4Able = (CBWritePtr[1:0] == 0) ? `EnableValue : 
                                 (CBWritePtr[1:0] == 1) ? `EnableValue : 
                                 (CBWritePtr[1:0] == 2) ? CBQWrite2    : 
                                 (CBWritePtr[1:0] == 3) ? CBQWrite1    : `EnableValue ;
    
    wire  [3:0] WriteCriq1Addr = (CBWritePtr[1:0] == 0) ? CBQWritePtr[3:0]     : 
                                 (CBWritePtr[1:0] == 1) ? 4'b0 : 
                                 (CBWritePtr[1:0] == 2) ? 4'b0 : 
                                 (CBWritePtr[1:0] == 3) ? CBQWritePtr[7:4]     : 4'b0 ;
    wire  [3:0] WriteCriq2Addr = (CBWritePtr[1:0] == 0) ? CBQWritePtr[7:4]     :  
                                 (CBWritePtr[1:0] == 1) ? CBQWritePtr[3:0]     : 
                                 (CBWritePtr[1:0] == 2) ? 4'b0 : 
                                 (CBWritePtr[1:0] == 3) ? 4'b0 : 4'b0 ;
    wire  [3:0] WriteCriq3Addr = (CBWritePtr[1:0] == 0) ? 4'b0: 
                                 (CBWritePtr[1:0] == 1) ? CBQWritePtr[7:4]     : 
                                 (CBWritePtr[1:0] == 2) ? CBQWritePtr[3:0]     : 
                                 (CBWritePtr[1:0] == 3) ? 4'b0 : 4'b0 ;
    wire  [3:0] WriteCriq4Addr = (CBWritePtr[1:0] == 0) ? 4'b0 : 
                                 (CBWritePtr[1:0] == 1) ? 4'b0 : 
                                 (CBWritePtr[1:0] == 2) ? CBQWritePtr[7:4]     : 
                                 (CBWritePtr[1:0] == 3) ? CBQWritePtr[3:0]     : 4'b0 ;


    wire  CriqEmpty1 ;
    wire  CriqEmpty2 ;
    wire  CriqEmpty3 ;
    wire  CriqEmpty4 ;

    assign BrCsrReq = CriqEmpty1 | CriqEmpty2 | CriqEmpty3 | CriqEmpty4 ;

    BrCsrIQ1Criq4#(
        .CRIQWIDE    ( 4 ),
        .CRIQDEEP    ( 4 )
    )u_BrCsrIQ1Criq4(
        .Clk         ( Clk             ),
        .Rest        ( Rest            ),
        .Rable       ( U1ReadAble & ~StopTemp ),
        .CriqPreOut  ( CriqPreOut1     ),
        .Wable       ( WriteCriq1Able & ~StopTemp  ),
        .Din         ( WriteCriq1Addr  ),
        .CriqClean   ( FLashTemp      ),
        .CriqEmpty   ( CriqEmpty1      )
    );

    BrCsrIQ2Criq4#(
        .CRIQWIDE    ( 4 ),
        .CRIQDEEP    ( 4 )
    )u_BrCsrIQ2Criq4(
        .Clk         ( Clk             ),
        .Rest        ( Rest            ),
        .Rable       ( U2ReadAble & ~StopTemp      ),
        .CriqPreOut  ( CriqPreOut2     ),
        .Wable       ( WriteCriq2Able & ~StopTemp  ),
        .Din         ( WriteCriq2Addr  ),
        .CriqClean   ( FLashTemp      ),
        .CriqEmpty   ( CriqEmpty2      )
    );

    BrCsrIQ3Criq4#(
        .CRIQWIDE    ( 4 ),
        .CRIQDEEP    ( 4 )
    )u_BrCsrIQ3Criq4(
        .Clk         ( Clk            ),
        .Rest        ( Rest           ),
        .Rable       ( U3ReadAble & ~StopTemp     ),
        .CriqPreOut  ( CriqPreOut3    ),
        .Wable       ( WriteCriq3Able & ~StopTemp ),
        .Din         ( WriteCriq3Addr ),
        .CriqClean   ( FLashTemp     ),
        .CriqEmpty   ( CriqEmpty3     )
    );

    BrCsrIQ4Criq4#(
        .CRIQWIDE    ( 4 ),
        .CRIQDEEP    ( 4 )
    )u_BrCsrIQ4Criq4(
        .Clk         ( Clk            ),
        .Rest        ( Rest           ),
        .Rable       ( U4ReadAble & ~StopTemp     ),
        .CriqPreOut  ( CriqPreOut4    ),
        .Wable       ( WriteCriq4Able & ~StopTemp ),
        .Din         ( WriteCriq4Addr ),
        .CriqClean   ( FLashTemp     ),
        .CriqEmpty   ( CriqEmpty4     )
    );

    wire [3:0] BrSelectOldS1 [0:7] ;
    wire       BrSelectAblS1 [0:7] ;
    wire [3:0] CsSelectOldS1 [0:7] ;
    wire       CsSelectAblS1 [0:7] ;

    genvar a ;
    generate
        for (i =0 ;i<16 ;i=i+2) begin
            assign BrSelectOldS1[a/2] = {4{((CBISSUE[i][68] == CBISSUE[i+1][68]) & (CBISSUE[i][67:62] < CBISSUE[i+1][67:62]) & (CBISSUE[i][35:28] == `BRCODE) & (CBISSUE[i+1][35:28] == `BRCODE))}} & i |
                                        {4{((CBISSUE[i][68] != CBISSUE[i+1][68]) & (CBISSUE[i][67:62] > CBISSUE[i+1][67:62]) & (CBISSUE[i][35:28] == `BRCODE) & (CBISSUE[i+1][35:28] == `BRCODE))}} & i |
                                        {4{(CBISSUE[i][35:28] == `BRCODE) & ~(CBISSUE[i+1][35:28] == `BRCODE)}} & i |
                                        {4{~(CBISSUE[i][35:28] == `BRCODE) & (CBISSUE[i+1][35:28] == `BRCODE)}} & i+1 | 
                                        {4{((CBISSUE[i][68] == CBISSUE[i+1][68]) & (CBISSUE[i][67:62] > CBISSUE[i+1][67:62]) & (CBISSUE[i][35:28] == `BRCODE) & (CBISSUE[i+1][35:28] == `BRCODE))}} & i+1 |
                                        {4{((CBISSUE[i][68] != CBISSUE[i+1][68]) & (CBISSUE[i][67:62] < CBISSUE[i+1][67:62]) & (CBISSUE[i][35:28] == `BRCODE) & (CBISSUE[i+1][35:28] == `BRCODE))}} & i+1 ;
            assign BrSelectAblS1[a/2] = ~((~CBISSUE[i][35:28] == `BRCODE) & ~(CBISSUE[i+1][35:28] == `BRCODE)) | `AbleValue ;
            assign CsSelectOldS1[a/2] = {4{((CBISSUE[i][68] == CBISSUE[i+1][68]) & (CBISSUE[i][67:62] < CBISSUE[i+1][67:62]) & (CBISSUE[i][35:28] == `CSRCODE) & (CBISSUE[i+1][35:28] == `CSRCODE))}} & i |
                                        {4{((CBISSUE[i][68] != CBISSUE[i+1][68]) & (CBISSUE[i][67:62] > CBISSUE[i+1][67:62]) & (CBISSUE[i][35:28] == `CSRCODE) & (CBISSUE[i+1][35:28] == `CSRCODE))}} & i |
                                        {4{(CBISSUE[i][35:28] == `CSRCODE) & ~(CBISSUE[i+1][35:28] == `CSRCODE)}} & i |
                                        {4{~(CBISSUE[i][35:28] == `CSRCODE) & (CBISSUE[i+1][35:28] == `CSRCODE)}} & i+1 | 
                                        {4{((CBISSUE[i][68] == CBISSUE[i+1][68]) & (CBISSUE[i][67:62] > CBISSUE[i+1][67:62]) & (CBISSUE[i][35:28] == `CSRCODE) & (CBISSUE[i+1][35:28] == `CSRCODE))}} & i+1 |
                                        {4{((CBISSUE[i][68] != CBISSUE[i+1][68]) & (CBISSUE[i][67:62] < CBISSUE[i+1][67:62]) & (CBISSUE[i][35:28] == `CSRCODE) & (CBISSUE[i+1][35:28] == `CSRCODE))}} & i+1 ;
            assign CsSelectAblS1[a/2] = ~((~CBISSUE[i][35:28] == `CSRCODE) & ~(CBISSUE[i+1][35:28] == `CSRCODE)) | `AbleValue ;
        end   
    endgenerate


    wire [3:0] BrSelectOldS2 [0:3] ;
    wire       BrSelectAblS2 [0:3] ;
    wire [3:0] CsSelectOldS2 [0:3] ;
    wire       CsSelectAblS2 [0:3] ;

    genvar b ;
    generate
        for (b =0 ;b<8 ; b=b+2) begin
            assign BrSelectOldS2[b/2] = {4{(BrSelectAblS1[b] & BrSelectAblS1[b+1]) & (CBISSUE[BrSelectOldS1[b]][68] == CBISSUE[BrSelectOldS1[b+1]][68]) & (CBISSUE[BrSelectOldS1[b]][67:62] < CBISSUE[BrSelectOldS1[b+1]][67:62])}} & BrSelectOldS1[b] |
                                        {4{(BrSelectAblS1[b] & BrSelectAblS1[b+1]) & (CBISSUE[BrSelectOldS1[b]][68] != CBISSUE[BrSelectOldS1[b+1]][68]) & (CBISSUE[BrSelectOldS1[b]][67:62] > CBISSUE[BrSelectOldS1[b+1]][67:62])}} & BrSelectOldS1[b] |
                                        {4{(BrSelectAblS1[b] & ~BrSelectAblS1[b+1])}} & BrSelectOldS1[b] |
                                        {4{(~BrSelectAblS1[b] & BrSelectAblS1[b+1])}} & BrSelectOldS1[b+1] |
                                        {4{(BrSelectAblS1[b] & BrSelectAblS1[b+1]) & (CBISSUE[BrSelectOldS1[b]][68] == CBISSUE[BrSelectOldS1[b+1]][68]) & (CBISSUE[BrSelectOldS1[b]][67:62] > CBISSUE[BrSelectOldS1[b+1]][67:62])}} & BrSelectOldS1[b+1] |
                                        {4{(BrSelectAblS1[b] & BrSelectAblS1[b+1]) & (CBISSUE[BrSelectOldS1[b]][68] != CBISSUE[BrSelectOldS1[b+1]][68]) & (CBISSUE[BrSelectOldS1[b]][67:62] < CBISSUE[BrSelectOldS1[b+1]][67:62])}} & BrSelectOldS1[b+1] ;
            assign BrSelectAblS2[b/2] = ~(~BrSelectAblS1[b] & ~BrSelectAblS1[b+1]) & `AbleValue ;
            assign CsSelectOldS2[b/2] = {4{(CsSelectAblS1[b] & CsSelectAblS1[b+1]) & (CBISSUE[CsSelectOldS1[b]][68] == CBISSUE[CsSelectOldS1[b+1]][68]) & (CBISSUE[CsSelectOldS1[b]][67:62] < CBISSUE[CsSelectOldS1[b+1]][67:62])}} & CsSelectOldS1[b] |
                                        {4{(CsSelectAblS1[b] & CsSelectAblS1[b+1]) & (CBISSUE[CsSelectOldS1[b]][68] != CBISSUE[CsSelectOldS1[b+1]][68]) & (CBISSUE[CsSelectOldS1[b]][67:62] > CBISSUE[CsSelectOldS1[b+1]][67:62])}} & CsSelectOldS1[b] |
                                        {4{(CsSelectAblS1[b] & ~CsSelectAblS1[b+1])}} & CsSelectOldS1[b] |
                                        {4{(~CsSelectAblS1[b] & CsSelectAblS1[b+1])}} & CsSelectOldS1[b+1] |
                                        {4{(CsSelectAblS1[b] & CsSelectAblS1[b+1]) & (CBISSUE[CsSelectOldS1[b]][68] == CBISSUE[CsSelectOldS1[b+1]][68]) & (CBISSUE[CsSelectOldS1[b]][67:62] > CBISSUE[CsSelectOldS1[b+1]][67:62])}} & CsSelectOldS1[b+1] |
                                        {4{(CsSelectAblS1[b] & CsSelectAblS1[b+1]) & (CBISSUE[CsSelectOldS1[b]][68] != CBISSUE[CsSelectOldS1[b+1]][68]) & (CBISSUE[CsSelectOldS1[b]][67:62] < CBISSUE[CsSelectOldS1[b+1]][67:62])}} & CsSelectOldS1[b+1] ;
            assign CsSelectAblS2[b/2] = ~(~CsSelectAblS1[b] & ~CsSelectAblS1[b+1]) & `AbleValue ;
        end
    endgenerate

    wire [3:0] BrSelectOldS3 [0:1] ;
    wire       BrSelectAblS3 [0:1] ;
    wire [3:0] CsSelectOldS3 [0:1] ;
    wire       CsSelectAblS3 [0:1] ;

    genvar c ;
    generate
        for (c =0 ;c<4 ;c=c+2 ) begin
            assign BrSelectOldS3[c/2] = {4{(BrSelectAblS2[c] & BrSelectAblS2[c+1]) & (CBISSUE[BrSelectOldS2[c]][68] == CBISSUE[BrSelectOldS2[c+1]][68]) & (CBISSUE[BrSelectOldS2[c]][67:62] < CBISSUE[BrSelectOldS2[c+1]][67:62])}} &  BrSelectOldS2[c] |
                                        {4{(BrSelectAblS2[c] & BrSelectAblS2[c+1]) & (CBISSUE[BrSelectOldS2[c]][68] != CBISSUE[BrSelectOldS2[c+1]][68]) & (CBISSUE[BrSelectOldS2[c]][67:62] > CBISSUE[BrSelectOldS2[c+1]][67:62])}} &  BrSelectOldS2[c] |
                                        {4{(BrSelectAblS2[c] & ~BrSelectAblS2[c+1])}} & BrSelectOldS2[c] |
                                        {4{(~BrSelectAblS2[c] & BrSelectAblS2[c+1])}} & BrSelectOldS2[c+1] |  
                                        {4{(BrSelectAblS2[c] & BrSelectAblS2[c+1]) & (CBISSUE[BrSelectOldS2[c]][68] == CBISSUE[BrSelectOldS2[c+1]][68]) & (CBISSUE[BrSelectOldS2[c]][67:62] > CBISSUE[BrSelectOldS2[c+1]][67:62])}} &  BrSelectOldS2[c+1] |
                                        {4{(BrSelectAblS2[c] & BrSelectAblS2[c+1]) & (CBISSUE[BrSelectOldS2[c]][68] != CBISSUE[BrSelectOldS2[c+1]][68]) & (CBISSUE[BrSelectOldS2[c]][67:62] < CBISSUE[BrSelectOldS2[c+1]][67:62])}} &  BrSelectOldS2[c+1] ;
            assign BrSelectAblS3[c/2] = ~(~BrSelectAblS2[c] & ~BrSelectAblS2[c+1]) & `AbleValue ;
            assign CsSelectOldS3[c/2] = {4{(CsSelectAblS2[c] & CsSelectAblS2[c+1]) & (CBISSUE[CsSelectOldS2[c]][68] == CBISSUE[CsSelectOldS2[c+1]][68]) & (CBISSUE[CsSelectOldS2[c]][67:62] < CBISSUE[CsSelectOldS2[c+1]][67:62])}} &  CsSelectOldS2[c] |
                                        {4{(CsSelectAblS2[c] & CsSelectAblS2[c+1]) & (CBISSUE[CsSelectOldS2[c]][68] != CBISSUE[CsSelectOldS2[c+1]][68]) & (CBISSUE[CsSelectOldS2[c]][67:62] > CBISSUE[CsSelectOldS2[c+1]][67:62])}} &  CsSelectOldS2[c] |
                                        {4{(CsSelectAblS2[c] & ~CsSelectAblS2[c+1])}} & CsSelectOldS2[c] |
                                        {4{(~CsSelectAblS2[c] & CsSelectAblS2[c+1])}} & CsSelectOldS2[c+1] |  
                                        {4{(CsSelectAblS2[c] & CsSelectAblS2[c+1]) & (CBISSUE[CsSelectOldS2[c]][68] == CBISSUE[CsSelectOldS2[c+1]][68]) & (CBISSUE[CsSelectOldS2[c]][67:62] > CBISSUE[CsSelectOldS2[c+1]][67:62])}} &  CsSelectOldS2[c+1] |
                                        {4{(CsSelectAblS2[c] & CsSelectAblS2[c+1]) & (CBISSUE[CsSelectOldS2[c]][68] != CBISSUE[CsSelectOldS2[c+1]][68]) & (CBISSUE[CsSelectOldS2[c]][67:62] < CBISSUE[CsSelectOldS2[c+1]][67:62])}} &  CsSelectOldS2[c+1] ;
            assign CsSelectAblS3[c/2] = ~(~CsSelectAblS2[c] & ~CsSelectAblS2[c+1]) | `AbleValue ;
        end
    endgenerate

    wire [3:0] BrSelectOldS4 ;
    wire       BrSelectAblS4 ;
    wire [3:0] CsSelectOldS4 ;
    wire       CsSelectAblS4 ;

    assign BrSelectOldS4  = {4{(BrSelectAblS3[0] & BrSelectAblS3[1]) & (CBISSUE[BrSelectOldS3[0]][68] == CBISSUE[BrSelectOldS3[1]][68]) & (CBISSUE[BrSelectOldS3[0]][67:62] < CBISSUE[BrSelectOldS3[1]][67:62])}} &  BrSelectOldS3[0] |
                            {4{(BrSelectAblS3[0] & BrSelectAblS3[1]) & (CBISSUE[BrSelectOldS3[0]][68] != CBISSUE[BrSelectOldS3[1]][68]) & (CBISSUE[BrSelectOldS3[0]][67:62] > CBISSUE[BrSelectOldS3[1]][67:62])}} &  BrSelectOldS3[0] |
                            {4{(BrSelectAblS3[0] & ~BrSelectAblS3[1])}} & BrSelectOldS3[0] |
                            {4{(~BrSelectAblS3[0] & BrSelectAblS3[1])}} & BrSelectOldS3[1] |  
                            {4{(BrSelectAblS3[0] & BrSelectAblS3[1]) & (CBISSUE[BrSelectOldS3[0]][68] == CBISSUE[BrSelectOldS3[1]][68]) & (CBISSUE[BrSelectOldS3[0]][67:62] > CBISSUE[BrSelectOldS3[1]][67:62])}} &  BrSelectOldS3[1] |
                            {4{(BrSelectAblS3[0] & BrSelectAblS3[1]) & (CBISSUE[BrSelectOldS3[0]][68] != CBISSUE[BrSelectOldS3[1]][68]) & (CBISSUE[BrSelectOldS3[0]][67:62] < CBISSUE[BrSelectOldS3[1]][67:62])}} &  BrSelectOldS3[1] ;
    assign BrSelectAblS4  = ~(BrSelectAblS3[0] & ~BrSelectAblS3[1]) & `AbleValue ;
    assign CsSelectOldS4  = {4{(CsSelectAblS3[0] & CsSelectAblS3[1]) & (CBISSUE[CsSelectOldS3[0]][68] == CBISSUE[CsSelectOldS3[1]][68]) & (CBISSUE[CsSelectOldS3[0]][67:62] < CBISSUE[CsSelectOldS3[1]][67:62])}} &  CsSelectOldS3[0] |
                            {4{(CsSelectAblS3[0] & CsSelectAblS3[1]) & (CBISSUE[CsSelectOldS3[0]][68] != CBISSUE[CsSelectOldS3[1]][68]) & (CBISSUE[CsSelectOldS3[0]][67:62] > CBISSUE[CsSelectOldS3[1]][67:62])}} &  CsSelectOldS3[0] |
                            {4{(CsSelectAblS3[0] & ~CsSelectAblS3[1])}} & CsSelectOldS3[0] |
                            {4{(~CsSelectAblS3[0] & CsSelectAblS3[1])}} & CsSelectOldS3[1] |  
                            {4{(CsSelectAblS3[0] & CsSelectAblS3[1]) & (CBISSUE[CsSelectOldS3[0]][68] == CBISSUE[CsSelectOldS3[1]][68]) & (CBISSUE[CsSelectOldS3[0]][67:62] > CBISSUE[CsSelectOldS3[1]][67:62])}} &  CsSelectOldS3[1] |
                            {4{(CsSelectAblS3[0] & CsSelectAblS3[1]) & (CBISSUE[CsSelectOldS3[0]][68] != CBISSUE[CsSelectOldS3[1]][68]) & (CBISSUE[CsSelectOldS3[0]][67:62] < CBISSUE[CsSelectOldS3[1]][67:62])}} &  CsSelectOldS3[1] ;
    assign CsSelectAblS4  = ~(CsSelectAblS3[0] & ~CsSelectAblS3[1]) & `AbleValue ;

    wire                 FinalBrSendAble = BrReq  & BrSelectAblS4 & (~CBISSUE[BrSelectOldS4][61] | CBISSUE[BrSelectOldS4][60]) & (~CBISSUE[BrSelectOldS4][52] | CBISSUE[BrSelectOldS4][51]) ;
    wire                 FinalCsSendAble = CsrReq & CsSelectAblS4 & (~CBISSUE[CsSelectOldS4][61] | CBISSUE[CsSelectOldS4][60]) & (~CBISSUE[CsSelectOldS4][52] | CBISSUE[CsSelectOldS4][51]) ;


    reg  [`MicOperateCode]    RegBInst1MicOperate  ;
    reg                       RegBInst1Src1RAble   ;
    reg  [`ReNameRegBUs]      RegBInst1Src1RAddr   ; 
    reg                       RegBInst1Src2RAble   ;
    reg  [`ReNameRegBUs]      RegBInst1Src2RAddr   ;    
    reg                       RegBInst1ImmAble     ;
    reg  [25:0]               RegBInst1ImmDate     ;
    reg                       RegBInst1RdAble      ;
    reg  [`ReNameRegBUs]      RegBInst1RdAddr      ; 
    reg                       RegBInst1Mode        ;
    reg  [`InstAddrBus]       RegBInst1RedieAddr   ;
    reg  [5:0]                RegBInst1RoBptr      ;

    reg  [`MicOperateCode]    RegBInst2MicOperate  ;
    reg                       RegBInst2Src1RAble   ;
    reg  [`ReNameRegBUs]      RegBInst2Src1RAddr   ; 
    reg                       RegBInst2Src2RAble   ;
    reg  [`ReNameRegBUs]      RegBInst2Src2RAddr   ;    
    reg                       RegBInst2ImmAble     ;
    reg  [25:0]               RegBInst2ImmDate     ;
    reg                       RegBInst2RdAble      ;
    reg  [`ReNameRegBUs]      RegBInst2RdAddr      ; 
    reg  [5:0]                RegBInst2RoBptr      ;

    always @(posedge Clk) begin
        if(!Rest) begin
            RegBInst1MicOperate <=  8'b0;
            RegBInst1Src1RAble  <=  `EnableValue;
            RegBInst1Src1RAddr  <=  7'b0; 
            RegBInst1Src2RAble  <=  `EnableValue; 
            RegBInst1Src2RAddr  <=  7'b0;   
            RegBInst1ImmAble    <=  `EnableValue; 
            RegBInst1ImmDate    <=  26'b0; 
            RegBInst1RdAble     <=  `EnableValue; 
            RegBInst1RdAddr     <=  7'b0;  
            RegBInst1Mode       <=  `EnableValue; 
            RegBInst1RedieAddr  <=  32'b0; 
            RegBInst1RoBptr     <=  6'b0; 

            RegBInst2MicOperate <=  8'b0;
            RegBInst2Src1RAble  <=  `EnableValue;
            RegBInst2Src1RAddr  <=  7'b0; 
            RegBInst2Src2RAble  <=  `EnableValue; 
            RegBInst2Src2RAddr  <=  7'b0;   
            RegBInst2ImmAble    <=  `EnableValue; 
            RegBInst2ImmDate    <=  26'b0; 
            RegBInst2RdAble     <=  `EnableValue; 
            RegBInst2RdAddr     <=  7'b0;   
            RegBInst2RoBptr     <=  6'b0; 
        end
        else if(BrCsrFlash) begin
            RegBInst1MicOperate <=  8'b0;
            RegBInst1Src1RAble  <=  `EnableValue;
            RegBInst1Src1RAddr  <=  7'b0; 
            RegBInst1Src2RAble  <=  `EnableValue; 
            RegBInst1Src2RAddr  <=  7'b0;   
            RegBInst1ImmAble    <=  `EnableValue; 
            RegBInst1ImmDate    <=  26'b0; 
            RegBInst1RdAble     <=  `EnableValue; 
            RegBInst1RdAddr     <=  7'b0;  
            RegBInst1Mode       <=  `EnableValue; 
            RegBInst1RedieAddr  <=  32'b0; 
            RegBInst1RoBptr     <=  6'b0; 

            RegBInst2MicOperate <=  8'b0;
            RegBInst2Src1RAble  <=  `EnableValue;
            RegBInst2Src1RAddr  <=  7'b0; 
            RegBInst2Src2RAble  <=  `EnableValue; 
            RegBInst2Src2RAddr  <=  7'b0;   
            RegBInst2ImmAble    <=  `EnableValue; 
            RegBInst2ImmDate    <=  26'b0; 
            RegBInst2RdAble     <=  `EnableValue; 
            RegBInst2RdAddr     <=  7'b0;   
            RegBInst2RoBptr     <=  6'b0;
        end
        else if(FinalBrSendAble) begin
            RegBInst1MicOperate <=  CBISSUE[BrSelectOldS4][35:28];
            RegBInst1Src1RAble  <=  CBISSUE[BrSelectOldS4][52];
            RegBInst1Src1RAddr  <=  CBISSUE[BrSelectOldS4][50:44]; 
            RegBInst1Src2RAble  <=  CBISSUE[BrSelectOldS4][61]; 
            RegBInst1Src2RAddr  <=  CBISSUE[BrSelectOldS4][59:53];   
            RegBInst1ImmAble    <=  CBISSUE[BrSelectOldS4][27]; 
            RegBInst1ImmDate    <=  CBISSUE[BrSelectOldS4][26:1]; 
            RegBInst1RdAble     <=  CBISSUE[BrSelectOldS4][43]; 
            RegBInst1RdAddr     <=  CBISSUE[BrSelectOldS4][42:36];  
            RegBInst1Mode       <=  CBISSUE[BrSelectOldS4][0]; 
            RegBInst1RedieAddr  <=  CBISSUE[BrSelectOldS4][100:69]; 
            RegBInst1RoBptr     <=  CBISSUE[BrSelectOldS4][67:62]; 

            RegBInst2MicOperate <=  CBISSUE[CsSelectOldS4][35:28];
            RegBInst2Src1RAble  <=  CBISSUE[CsSelectOldS4][52];
            RegBInst2Src1RAddr  <=  CBISSUE[CsSelectOldS4][50:44]; 
            RegBInst2Src2RAble  <=  CBISSUE[CsSelectOldS4][61]; 
            RegBInst2Src2RAddr  <=  CBISSUE[CsSelectOldS4][59:53];   
            RegBInst2ImmAble    <=  CBISSUE[CsSelectOldS4][27]; 
            RegBInst2ImmDate    <=  CBISSUE[CsSelectOldS4][26:1]; 
            RegBInst2RdAble     <=  CBISSUE[CsSelectOldS4][43]; 
            RegBInst2RdAddr     <=  CBISSUE[CsSelectOldS4][42:36];   
            RegBInst2RoBptr     <=  CBISSUE[CsSelectOldS4][67:62]; 
        end
    end


    assign BInst1MicOperate = ~StopTemp ? RegBInst1MicOperate : 8'b0 ;
    assign BInst1Src1RAble  = ~StopTemp ? RegBInst1Src1RAble  : `EnableValue ;
    assign BInst1Src1RAddr  = ~StopTemp ? RegBInst1Src1RAddr  : 7'b0 ;
    assign BInst1Src2RAble  = ~StopTemp ? RegBInst1Src2RAble  : `EnableValue ;
    assign BInst1Src2RAddr  = ~StopTemp ? RegBInst1Src2RAddr  : 7'b0 ;
    assign BInst1ImmAble    = ~StopTemp ? RegBInst1ImmAble    : `EnableValue ;
    assign BInst1ImmDate    = ~StopTemp ? RegBInst1ImmDate    : 26'b0 ;
    assign BInst1RdAble     = ~StopTemp ? RegBInst1RdAble     : `EnableValue ;
    assign BInst1RdAddr     = ~StopTemp ? RegBInst1RdAddr     : 7'b0 ;
    assign BInst1Mode       = ~StopTemp ? RegBInst1Mode       : `EnableValue ;
    assign BInst1RedieAddr  = ~StopTemp ? RegBInst1RedieAddr  : 32'b0 ;
    assign BInst1RoBptr     = ~StopTemp ? RegBInst1RoBptr     : 6'b0 ;

    assign BInst2MicOperate = ~StopTemp ? RegBInst2MicOperate : 8'b0 ;
    assign BInst2Src1RAble  = ~StopTemp ? RegBInst2Src1RAble  : `EnableValue ;
    assign BInst2Src1RAddr  = ~StopTemp ? RegBInst2Src1RAddr  : 7'b0 ;
    assign BInst2Src2RAble  = ~StopTemp ? RegBInst2Src2RAble  : `EnableValue ;
    assign BInst2Src2RAddr  = ~StopTemp ? RegBInst2Src2RAddr  : 7'b0 ;
    assign BInst2ImmAble    = ~StopTemp ? RegBInst2ImmAble    : `EnableValue ;
    assign BInst2ImmDate    = ~StopTemp ? RegBInst2ImmDate    : 26'b0 ;
    assign BInst2RdAble     = ~StopTemp ? RegBInst2RdAble     : `EnableValue ;
    assign BInst2RdAddr     = ~StopTemp ? RegBInst2RdAddr     : 7'b0 ;
    assign BInst2RoBptr     = ~StopTemp ? RegBInst2RoBptr     : 6'b0 ;
  

    genvar i ;

    wire        InstSrc1Ready [0:15] ;
    wire        InstSrc2Ready [0:15] ;

    generate
        for (i =0 ;i<16 ;i=i+1 ) begin
            assign InstSrc1Ready[i]  =  ((CBISSUE[i][50:44] == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                        ((CBISSUE[i][50:44] == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                        ((CBISSUE[i][50:44] == FromMulAddr    ) && (FromIsQMul )) ||
                                        ((CBISSUE[i][50:44] == ByPassBDivAddr ) && (ByPassBDiv )) ||
                                        ((CBISSUE[i][50:44] == BypassBSCAddr  ) && (BypassBSC  )) ||
                                        ((CBISSUE[i][50:44] == ByPassBLoadAddr) && (ByPassBLoad)) ||
                                        ((CBISSUE[i][50:44] == BCsrIssueAddr  ) && (BCsrIssueAble))||
                                        ((CBISSUE[i][50:44] == BBrIssueAddr   ) && (BBrIssueAble)) ;
            assign InstSrc2Ready[i]  =  ((CBISSUE[i][59:53] == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                        ((CBISSUE[i][59:53] == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                        ((CBISSUE[i][59:53] == FromMulAddr    ) && (FromIsQMul )) ||
                                        ((CBISSUE[i][59:53] == ByPassBDivAddr ) && (ByPassBDiv )) ||
                                        ((CBISSUE[i][59:53] == BypassBSCAddr  ) && (BypassBSC  )) ||
                                        ((CBISSUE[i][59:53] == ByPassBLoadAddr) && (ByPassBLoad)) ||
                                        ((CBISSUE[i][59:53] == BCsrIssueAddr  ) && (BCsrIssueAble))||
                                        ((CBISSUE[i][59:53] == BBrIssueAddr   ) && (BBrIssueAble)) ;
        end
    endgenerate


    //tag broadcast
    assign                 BBrIssueAble   = FinalBrSendAble & CBISSUE[BrSelectOldS4][43] ; 
    assign                 BBrIssueAddr   = CBISSUE[BrSelectOldS4][42:36] ;
    assign                 BCsrIssueAble  = FinalCsSendAble & CBISSUE[CsSelectOldS4][43] ;
    assign                 BCsrIssueAddr  = CBISSUE[CsSelectOldS4][42:36] ;

    assign OutCsrAble = BCsrIssueAble ;
    assign OutCsrAddr = BCsrIssueAddr ;
    assign OutBruAble = BBrIssueAble  ; 
    assign OutBruAble = BBrIssueAddr  ;

    integer ii ;
    always @(posedge Clk) begin
        if(!Rest) begin
            for (ii =0 ;ii<32 ;ii=ii+1 ) begin
                CBISSUE[ii] <= 101'd0 ;
            end
        end 
        else if(BrCsrFlash) begin
            for (ii =0 ;ii<32 ;ii=ii+1 ) begin
                CBISSUE[ii] <= 101'd0 ;
            end
        end
        else if(BrCsrStop) begin
            for (ii =0 ;ii<32 ;ii=ii+1 ) begin
                CBISSUE[ii] <= CBISSUE[ii] ;
            end 
        end
        else begin
            CBISSUE[0][60] <= (~CBISSUE[0][61] | CBISSUE[0][60]) ? CBISSUE[0][60] : InstSrc1Ready[0] ;
            CBISSUE[0][51] <= (~CBISSUE[0][52] | CBISSUE[0][51]) ? CBISSUE[0][51] : InstSrc2Ready[0] ;
            CBISSUE[1][60] <= (~CBISSUE[1][61] | CBISSUE[1][60]) ? CBISSUE[1][60] : InstSrc1Ready[1] ;
            CBISSUE[1][51] <= (~CBISSUE[1][52] | CBISSUE[1][51]) ? CBISSUE[1][51] : InstSrc2Ready[1] ;
            CBISSUE[2][60] <= (~CBISSUE[2][61] | CBISSUE[2][60]) ? CBISSUE[2][60] : InstSrc1Ready[2] ;
            CBISSUE[2][51] <= (~CBISSUE[2][52] | CBISSUE[2][51]) ? CBISSUE[2][51] : InstSrc2Ready[2] ;
            CBISSUE[3][60] <= (~CBISSUE[3][61] | CBISSUE[3][60]) ? CBISSUE[3][60] : InstSrc1Ready[3] ;
            CBISSUE[3][51] <= (~CBISSUE[3][52] | CBISSUE[3][51]) ? CBISSUE[3][51] : InstSrc2Ready[3] ;
            CBISSUE[4][60] <= (~CBISSUE[4][61] | CBISSUE[4][60]) ? CBISSUE[4][60] : InstSrc1Ready[4] ;
            CBISSUE[4][51] <= (~CBISSUE[4][52] | CBISSUE[4][51]) ? CBISSUE[4][51] : InstSrc2Ready[4] ;
            CBISSUE[5][60] <= (~CBISSUE[5][61] | CBISSUE[5][60]) ? CBISSUE[5][60] : InstSrc1Ready[5] ;
            CBISSUE[5][51] <= (~CBISSUE[5][52] | CBISSUE[5][51]) ? CBISSUE[5][51] : InstSrc2Ready[5] ;
            CBISSUE[6][60] <= (~CBISSUE[6][61] | CBISSUE[6][60]) ? CBISSUE[6][60] : InstSrc1Ready[6] ;
            CBISSUE[6][51] <= (~CBISSUE[6][52] | CBISSUE[6][51]) ? CBISSUE[6][51] : InstSrc2Ready[6] ;
            CBISSUE[7][60] <= (~CBISSUE[7][61] | CBISSUE[7][60]) ? CBISSUE[7][60] : InstSrc1Ready[7] ;
            CBISSUE[7][51] <= (~CBISSUE[7][52] | CBISSUE[7][51]) ? CBISSUE[7][51] : InstSrc2Ready[7] ;
            CBISSUE[8][60] <= (~CBISSUE[8][61] | CBISSUE[8][60]) ? CBISSUE[8][60] : InstSrc1Ready[8] ;
            CBISSUE[8][51] <= (~CBISSUE[8][52] | CBISSUE[8][51]) ? CBISSUE[8][51] : InstSrc2Ready[8] ;
            CBISSUE[9][60] <= (~CBISSUE[9][61] | CBISSUE[9][60]) ? CBISSUE[9][60] : InstSrc1Ready[9] ;
            CBISSUE[9][51] <= (~CBISSUE[9][52] | CBISSUE[9][51]) ? CBISSUE[9][51] : InstSrc2Ready[9] ;
            CBISSUE[10][60] <= (~CBISSUE[10][61] | CBISSUE[10][60]) ? CBISSUE[10][60] : InstSrc1Ready[10] ;
            CBISSUE[10][51] <= (~CBISSUE[10][52] | CBISSUE[10][51]) ? CBISSUE[10][51] : InstSrc2Ready[10] ;
            CBISSUE[11][60] <= (~CBISSUE[11][61] | CBISSUE[11][60]) ? CBISSUE[11][60] : InstSrc1Ready[11] ;
            CBISSUE[11][51] <= (~CBISSUE[11][52] | CBISSUE[11][51]) ? CBISSUE[11][51] : InstSrc2Ready[11] ;
            CBISSUE[12][60] <= (~CBISSUE[12][61] | CBISSUE[12][60]) ? CBISSUE[12][60] : InstSrc1Ready[12] ;
            CBISSUE[12][51] <= (~CBISSUE[12][52] | CBISSUE[12][51]) ? CBISSUE[12][51] : InstSrc2Ready[12] ;
            CBISSUE[13][60] <= (~CBISSUE[13][61] | CBISSUE[13][60]) ? CBISSUE[13][60] : InstSrc1Ready[13] ;
            CBISSUE[13][51] <= (~CBISSUE[13][52] | CBISSUE[13][51]) ? CBISSUE[13][51] : InstSrc2Ready[13] ;
            CBISSUE[14][60] <= (~CBISSUE[14][61] | CBISSUE[14][60]) ? CBISSUE[14][60] : InstSrc1Ready[14] ;
            CBISSUE[14][51] <= (~CBISSUE[14][52] | CBISSUE[14][51]) ? CBISSUE[14][51] : InstSrc2Ready[14] ;
            CBISSUE[15][60] <= (~CBISSUE[15][61] | CBISSUE[15][60]) ? CBISSUE[15][60] : InstSrc1Ready[15] ;
            CBISSUE[15][51] <= (~CBISSUE[15][52] | CBISSUE[15][51]) ? CBISSUE[15][51] : InstSrc2Ready[15] ;
            CBISSUE[CriqPreOut1] <= U1ReadAble ? WriteDate1 : 101'd0 ;
            CBISSUE[CriqPreOut2] <= U2ReadAble ? WriteDate2 : 101'd0 ;
            CBISSUE[CriqPreOut3] <= U3ReadAble ? WriteDate3 : 101'd0 ;
            CBISSUE[CriqPreOut4] <= U3ReadAble ? WriteDate4 : 101'd0 ;
            CBISSUE[BrSelectOldS4] <= FinalBrSendAble ? 101'd0 : CBISSUE[BrSelectOldS4] ;
            CBISSUE[CsSelectOldS4] <= FinalCsSendAble ? 101'd0 : CBISSUE[CsSelectOldS4] ;
        end
    end

    
endmodule
