`timescale 1ps/1ps
`include "../define.v"
`include "../../Lib/BrCsrIQ1Criq4.v"
`include "../../Lib/BrCsrIQ2Criq4.v"
`include "../../Lib/BrCsrIQ3Criq4.v"
`include "../../Lib/BrCsrIQ4Criq4.v"

module IssueQueueMem ( 
    input        wire                                     Clk               ,
    input        wire                                     Rest              ,
    //for ctrl
    input        wire                                     MemQStop          ,
    input        wire                                     MemQFlash         ,
    output       wire                                     MemReq            ,
    //from RAT
    input       wire                                      InIQMemNum        ,
    input       wire                                      MIn1Src1Able      ,
    input       wire                                      MIn1Src1Ready     ,
    input       wire        [`ReNameRegBUs]               MIn1Src1Addr      ,
    input       wire                                      MIn1Src2Able      ,
    input       wire                                      MIn1Src2Ready     ,
    input       wire        [`ReNameRegBUs]               MIn1Src2Addr      ,
    input       wire                                      MIn1RdAble        ,
    input       wire        [`ReNameRegBUs]               MIn1RdAddr        ,
    input       wire                                      MIn2Src1Able      ,
    input       wire                                      MIn2Src1Ready     ,
    input       wire        [`ReNameRegBUs]               MIn2Src1Addr      ,
    input       wire                                      MIn2Src2Able      ,
    input       wire                                      MIn2Src2Ready     ,
    input       wire        [`ReNameRegBUs]               MIn2Src2Addr      ,
    input       wire                                      MIn2RdAble        ,
    input       wire        [`ReNameRegBUs]               MIn2RdAddr        ,
    input       wire                                      MIn3Src1Able      ,
    input       wire                                      MIn3Src1Ready     ,
    input       wire        [`ReNameRegBUs]               MIn3Src1Addr      ,
    input       wire                                      MIn3Src2Able      ,
    input       wire                                      MIn3Src2Ready     ,
    input       wire        [`ReNameRegBUs]               MIn3Src2Addr      ,
    input       wire                                      MIn3RdAble        ,
    input       wire        [`ReNameRegBUs]               MIn3RdAddr        ,
    input       wire                                      MIn4Src1Able      ,
    input       wire                                      MIn4Src1Ready     ,
    input       wire        [`ReNameRegBUs]               MIn4Src1Addr      ,
    input       wire                                      MIn4Src2Able      ,
    input       wire                                      MIn4Src2Ready     ,
    input       wire        [`ReNameRegBUs]               MIn4Src2Addr      ,
    input       wire                                      MIn4RdAble        ,
    input       wire        [`ReNameRegBUs]               MIn4RdAddr        ,
    //from decode delay 1 clcye
    input       wire                                      MIn1aAble         ,
    input       wire        [`MicOperateCode]             MIn1MicOpcode     ,
    input       wire                                      MIn1ImmAble       ,
    input       wire        [25:0]                        MIn1ImmDate       ,
    input       wire        [6:0]                         MIn1RobPtr        ,
    input       wire                                      MIn2aAble         ,
    input       wire        [`MicOperateCode]             MIn2MicOpcode     ,
    input       wire                                      MIn2ImmAble       ,
    input       wire        [25:0]                        MIn2ImmDate       ,
    input       wire        [6:0]                         MIn2RobPtr        ,
    input       wire                                      MIn3aAble         ,
    input       wire        [`MicOperateCode]             MIn3MicOpcode     ,
    input       wire                                      MIn3ImmAble       ,
    input       wire        [25:0]                        MIn3ImmDate       ,
    input       wire        [6:0]                         MIn3RobPtr        ,
    input       wire                                      MIn4aAble         ,
    input       wire        [`MicOperateCode]             MIn4MicOpcode     ,
    input       wire                                      MIn4ImmAble       ,
    input       wire        [25:0]                        MIn4ImmDate       ,
    input       wire        [6:0]                         MIn4RobPtr        ,
    //eu req 
    input       wire                                      LoadReq           ,
    input       wire                                      StoreReq          ,
    // weak up bus
    input       wire                                      FromBCQBru        ,
    input       wire        [`ReNameRegBUs]               FromBruAddr       ,
    input       wire                                      FromBCQCsr        ,
    input       wire        [`ReNameRegBUs]               FromCsrAddr       ,
    input       wire                                      FromIsQAlu1       ,
    input       wire        [`ReNameRegBUs]               FromAlu1Addr      , 
    input       wire                                      FromIsQAlu2       ,
    input       wire        [`ReNameRegBUs]               FromAlu2Addr      ,//delay broadcast
    input       wire                                      FromIsQMul        ,
    input       wire        [`ReNameRegBUs]               FromMulAddr       ,
    input       wire                                      ByPassMDiv        ,
    input       wire        [`ReNameRegBUs]               ByPassMDivAddr    ,//bypass
    input       wire                                      ByPassMLoad       ,
    input       wire        [`ReNameRegBUs]               ByPassMLoadAddr   ,
    input       wire                                      ByPassMSC         ,
    input       wire        [`ReNameRegBUs]               ByPassMSCAddr     ,
    //to eu 
    output      wire        [`MicOperateCode]             MInst1MicOperate  ,  //load
    output      wire                                      MInst1Src1RAble   ,
    output      wire        [`ReNameRegBUs]               MInst1Src1RAddr   , 
    output      wire                                      MInst1Src2RAble   ,
    output      wire        [`ReNameRegBUs]               MInst1Src2RAddr   ,    
    output      wire                                      MInst1ImmAble     ,
    output      wire        [25:0]                        MInst1ImmDate     ,
    output      wire                                      MInst1RdAble      ,
    output      wire        [`ReNameRegBUs]               MInst1RdAddr      , 
    output      wire        [5:0]                         MInst1RoBptr      ,
    output      wire        [`MicOperateCode]             MInst2MicOperate  ,  //store
    output      wire                                      MInst2Src1RAble   ,
    output      wire        [`ReNameRegBUs]               MInst2Src1RAddr   , 
    output      wire                                      MInst2Src2RAble   ,
    output      wire        [`ReNameRegBUs]               MInst2Src2RAddr   ,    
    output      wire                                      MInst2ImmAble     ,
    output      wire        [25:0]                        MInst2ImmDate     ,
    output      wire                                      MInst2RdAble      ,
    output      wire        [`ReNameRegBUs]               MInst2RdAddr      , 
    output      wire        [5:0]                         MInst2RoBptr      
);

    reg  [68:0] MEMISSUE [0:15] ;
    reg  [2:0]  MWritePtr ;
    reg  [2:0]  MReadPtr  ;


    wire         MInst1Src1Ready = ((MIn1Src1Addr == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                   ((MIn1Src1Addr == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                   ((MIn1Src1Addr == FromMulAddr    ) && (FromIsQMul )) ||
                                   ((MIn1Src1Addr == ByPassMDivAddr ) && (ByPassMDiv )) ||
                                   ((MIn1Src1Addr == ByPassMSCAddr  ) && (ByPassMSC  )) ||
                                   ((MIn1Src1Addr == ByPassMLoadAddr) && (ByPassMLoad)) ||
                                   ((MIn1Src1Addr == FromBruAddr    ) && (FromBCQBru )) ||
                                   ((MIn1Src1Addr == FromCsrAddr    ) && (FromBCQCsr )) ; 

    wire         MInst2Src1Ready = ((MIn2Src1Addr == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                   ((MIn2Src1Addr == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                   ((MIn2Src1Addr == FromMulAddr    ) && (FromIsQMul )) ||
                                   ((MIn2Src1Addr == ByPassMDivAddr ) && (ByPassMDiv )) ||
                                   ((MIn2Src1Addr == ByPassMSCAddr  ) && (ByPassMSC  )) ||
                                   ((MIn2Src1Addr == ByPassMLoadAddr) && (ByPassMLoad)) ||
                                   ((MIn2Src1Addr == FromBruAddr    ) && (FromBCQBru )) ||
                                   ((MIn2Src1Addr == FromCsrAddr    ) && (FromBCQCsr )) ; 

    wire         MInst3Src1Ready = ((MIn3Src1Addr == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                   ((MIn3Src1Addr == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                   ((MIn3Src1Addr == FromMulAddr    ) && (FromIsQMul )) ||
                                   ((MIn3Src1Addr == ByPassMDivAddr ) && (ByPassMDiv )) ||
                                   ((MIn3Src1Addr == ByPassMSCAddr  ) && (ByPassMSC  )) ||
                                   ((MIn3Src1Addr == ByPassMLoadAddr) && (ByPassMLoad)) ||
                                   ((MIn3Src1Addr == FromBruAddr    ) && (FromBCQBru )) ||
                                   ((MIn3Src1Addr == FromCsrAddr    ) && (FromBCQCsr )) ; 

    wire         MInst4Src1Ready = ((MIn4Src1Addr == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                   ((MIn4Src1Addr == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                   ((MIn4Src1Addr == FromMulAddr    ) && (FromIsQMul )) ||
                                   ((MIn4Src1Addr == ByPassMDivAddr ) && (ByPassMDiv )) ||
                                   ((MIn4Src1Addr == ByPassMSCAddr  ) && (ByPassMSC  )) ||
                                   ((MIn4Src1Addr == ByPassMLoadAddr) && (ByPassMLoad)) ||
                                   ((MIn4Src1Addr == FromBruAddr    ) && (FromBCQBru )) ||
                                   ((MIn4Src1Addr == FromCsrAddr    ) && (FromBCQCsr )) ; 

    wire         MInst1Src2Ready = ((MIn1Src2Addr == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                   ((MIn1Src2Addr == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                   ((MIn1Src2Addr == FromMulAddr    ) && (FromIsQMul )) ||
                                   ((MIn1Src2Addr == ByPassMDivAddr ) && (ByPassMDiv )) ||
                                   ((MIn1Src2Addr == ByPassMSCAddr  ) && (ByPassMSC  )) ||
                                   ((MIn1Src2Addr == ByPassMLoadAddr) && (ByPassMLoad)) ||
                                   ((MIn1Src2Addr == FromBruAddr    ) && (FromBCQBru )) ||
                                   ((MIn1Src2Addr == FromCsrAddr    ) && (FromBCQCsr )) ; 

    wire         MInst2Src2Ready = ((MIn2Src2Addr == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                   ((MIn2Src2Addr == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                   ((MIn2Src2Addr == FromMulAddr    ) && (FromIsQMul )) ||
                                   ((MIn2Src2Addr == ByPassMDivAddr ) && (ByPassMDiv )) ||
                                   ((MIn2Src2Addr == ByPassMSCAddr  ) && (ByPassMSC  )) ||
                                   ((MIn2Src2Addr == ByPassMLoadAddr) && (ByPassMLoad)) ||
                                   ((MIn2Src2Addr == FromBruAddr    ) && (FromBCQBru )) ||
                                   ((MIn2Src2Addr == FromCsrAddr    ) && (FromBCQCsr )) ; 

    wire         MInst3Src2Ready = ((MIn3Src2Addr == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                   ((MIn3Src2Addr == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                   ((MIn3Src2Addr == FromMulAddr    ) && (FromIsQMul )) ||
                                   ((MIn3Src2Addr == ByPassMDivAddr ) && (ByPassMDiv )) ||
                                   ((MIn3Src2Addr == ByPassMSCAddr  ) && (ByPassMSC  )) ||
                                   ((MIn3Src2Addr == ByPassMLoadAddr) && (ByPassMLoad)) ||
                                   ((MIn3Src2Addr == FromBruAddr    ) && (FromBCQBru )) ||
                                   ((MIn3Src2Addr == FromCsrAddr    ) && (FromBCQCsr )) ; 

    wire         MInst4Src2Ready = ((MIn4Src2Addr == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                   ((MIn4Src2Addr == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                   ((MIn4Src2Addr == FromMulAddr    ) && (FromIsQMul )) ||
                                   ((MIn4Src2Addr == ByPassMDivAddr ) && (ByPassMDiv )) ||
                                   ((MIn4Src2Addr == ByPassMSCAddr  ) && (ByPassMSC  )) ||
                                   ((MIn4Src2Addr == ByPassMLoadAddr) && (ByPassMLoad)) ||
                                   ((MIn4Src2Addr == FromBruAddr    ) && (FromBCQBru )) ||
                                   ((MIn4Src2Addr == FromCsrAddr    ) && (FromBCQCsr )) ; 


    wire        MInstSrc1Ready [0:15];
    wire        MInstSrc2Ready [0:15];
    genvar ii ;
    generate
        for (ii =0 ;ii<16 ;ii=ii+1 ) begin
            assign MInstSrc1Ready =((MEMISSUE[ii][50:44]  == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                   ((MEMISSUE[ii][50:44]  == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                   ((MEMISSUE[ii][50:44]  == FromMulAddr    ) && (FromIsQMul )) ||
                                   ((MEMISSUE[ii][50:44]  == ByPassMDivAddr ) && (ByPassMDiv )) ||
                                   ((MEMISSUE[ii][50:44]  == ByPassMSCAddr  ) && (ByPassMSC  )) ||
                                   ((MEMISSUE[ii][50:44]  == ByPassMLoadAddr) && (ByPassMLoad)) ||
                                   ((MEMISSUE[ii][50:44]  == FromBruAddr    ) && (FromBCQBru )) ||
                                   ((MEMISSUE[ii][50:44]  == FromCsrAddr    ) && (FromBCQCsr )) ; 

            assign MInstSrc2Ready =((MEMISSUE[ii][59:53]  == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                   ((MEMISSUE[ii][59:53]  == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                   ((MEMISSUE[ii][59:53]  == FromMulAddr    ) && (FromIsQMul )) ||
                                   ((MEMISSUE[ii][59:53]  == ByPassMDivAddr ) && (ByPassMDiv )) ||
                                   ((MEMISSUE[ii][59:53]  == ByPassMSCAddr  ) && (ByPassMSC  )) ||
                                   ((MEMISSUE[ii][59:53]  == ByPassMLoadAddr) && (ByPassMLoad)) ||
                                   ((MEMISSUE[ii][59:53]  == FromBruAddr    ) && (FromBCQBru )) ||
                                   ((MEMISSUE[ii][59:53]  == FromCsrAddr    ) && (FromBCQCsr )) ;
        end
    endgenerate

    wire  [68:0]  WriteMIQ1  = {MIn1RobPtr,MIn1Src2Able, ((MemQStop | ~MIn1Src2Able | MIn1Src2Ready) ? MIn1Src2Ready :MInst1Src2Ready), MIn1Src2Addr, 
                                           MIn1Src1Able, ((MemQStop | ~MIn1Src1Able | MIn1Src1Ready) ? MIn1Src1Ready :MInst1Src1Ready), MIn1Src1Addr,
                                           MIn1RdAble, MIn1RdAddr, MIn1ImmAble, MIn1ImmDate,MIn1MicOpcode, `EnableValue} ;

    wire  [68:0]  WriteMIQ2  = {MIn2RobPtr,MIn2Src2Able, ((MemQStop | ~MIn2Src2Able | MIn2Src2Ready) ? MIn2Src2Ready :MInst2Src2Ready), MIn2Src2Addr, 
                                           MIn2Src1Able, ((MemQStop | ~MIn2Src1Able | MIn2Src1Ready) ? MIn2Src1Ready :MInst2Src1Ready), MIn2Src1Addr,
                                           MIn2RdAble, MIn2RdAddr, MIn2ImmAble, MIn2ImmDate,MIn2MicOpcode, `EnableValue} ;

    wire  [68:0]  WriteMIQ3  = {MIn3RobPtr,MIn3Src2Able, ((MemQStop | ~MIn3Src2Able | MIn3Src2Ready) ? MIn3Src2Ready :MInst3Src2Ready), MIn3Src2Addr, 
                                           MIn3Src1Able, ((MemQStop | ~MIn3Src1Able | MIn3Src1Ready) ? MIn3Src1Ready :MInst3Src1Ready), MIn3Src1Addr,
                                           MIn3RdAble, MIn3RdAddr, MIn3ImmAble, MIn3ImmDate,MIn3MicOpcode, `EnableValue} ;

    wire  [68:0]  WriteMIQ4  = {MIn4RobPtr,MIn4Src2Able, ((MemQStop | ~MIn4Src2Able | MIn4Src2Ready) ? MIn4Src2Ready :MInst4Src2Ready), MIn4Src2Addr, 
                                           MIn4Src1Able, ((MemQStop | ~MIn4Src1Able | MIn4Src1Ready) ? MIn4Src1Ready :MInst4Src1Ready), MIn4Src1Addr,
                                           MIn4RdAble, MIn4RdAddr, MIn4ImmAble, MIn4ImmDate,MIn4MicOpcode, `EnableValue} ;   
                                        

    wire [2:0]  MWriteNum  = (MIn1aAble & MIn2aAble & MIn3aAble & MIn4aAble) ? 3'd4 :
                             (MIn1aAble & MIn2aAble & MIn3aAble & ~MIn4aAble) ? 3'd3 :
                             (MIn1aAble & MIn2aAble & ~MIn3aAble & ~MIn4aAble) ? 3'd2 :
                             (MIn1aAble & ~MIn2aAble & ~MIn3aAble & ~MIn4aAble) ? 3'd1 : 3'd0 ;

    always @(posedge Clk) begin
        if(!Rest) begin
            MReadPtr <= 3'd0 ;
        end
        else if(MemQFlash) begin
            MReadPtr <= 3'd0 ;
        end
        else begin
            MReadPtr <= MReadPtr[1:0] + MWriteNum ;
        end
    end

    

    wire  ReadM1Able = (MReadPtr[1:0] == 0) ? MIn1aAble :
                       (MReadPtr[1:0] == 1) ? MIn4aAble : 
                       (MReadPtr[1:0] == 2) ? MIn3aAble : 
                       (MReadPtr[1:0] == 3) ? MIn2aAble : `EnableValue ;

    wire  ReadM2Able = (MReadPtr[1:0] == 0) ? MIn2aAble :
                       (MReadPtr[1:0] == 1) ? MIn1aAble : 
                       (MReadPtr[1:0] == 2) ? MIn4aAble : 
                       (MReadPtr[1:0] == 3) ? MIn3aAble : `EnableValue ;

    wire  ReadM3Able = (MReadPtr[1:0] == 0) ? MIn3aAble :
                       (MReadPtr[1:0] == 1) ? MIn2aAble : 
                       (MReadPtr[1:0] == 2) ? MIn1aAble : 
                       (MReadPtr[1:0] == 3) ? MIn4aAble : `EnableValue ;

    wire  ReadM4Able = (MReadPtr[1:0] == 0) ? MIn4aAble :
                       (MReadPtr[1:0] == 1) ? MIn3aAble : 
                       (MReadPtr[1:0] == 2) ? MIn2aAble : 
                       (MReadPtr[1:0] == 3) ? MIn1aAble : `EnableValue ;

    wire [3:0] PrePutPtr1 ;
    wire [3:0] PrePutPtr2 ;
    wire [3:0] PrePutPtr3 ;
    wire [3:0] PrePutPtr4 ;

    BrCsrIQ1Criq4#(
        .CRIQWIDE    ( 4 ),
        .CRIQDEEP    ( 4 )
    )u_BrCsrIQ1Criq4(
        .Clk         ( Clk             ),
        .Rest        ( Rest            ),
        .Rable       ( ReadM1Able      ),
        .CriqPreOut  ( PrePutPtr1      ),
        .Wable       ( WriteCriq1Able  ),
        .Din         ( WriteCriq1Addr  ),
        .CriqClean   ( BrCsrFlash      ),
        .CriqEmpty   ( CriqEmpty1      )
    );

    BrCsrIQ2Criq4#(
        .CRIQWIDE    ( 4 ),
        .CRIQDEEP    ( 4 )
    )u_BrCsrIQ2Criq4(
        .Clk         ( Clk             ),
        .Rest        ( Rest            ),
        .Rable       ( ReadM2Able      ),
        .CriqPreOut  ( PrePutPtr2      ),
        .Wable       ( WriteCriq2Able  ),
        .Din         ( WriteCriq2Addr  ),
        .CriqClean   ( BrCsrFlash      ),
        .CriqEmpty   ( CriqEmpty2      )
    );

    BrCsrIQ3Criq4#(
        .CRIQWIDE    ( 4 ),
        .CRIQDEEP    ( 4 )
    )u_BrCsrIQ3Criq4(
        .Clk         ( Clk            ),
        .Rest        ( Rest           ),
        .Rable       ( ReadM3Able     ),
        .CriqPreOut  ( PrePutPtr3     ),
        .Wable       ( WriteCriq3Able ),
        .Din         ( WriteCriq3Addr ),
        .CriqClean   ( BrCsrFlash     ),
        .CriqEmpty   ( CriqEmpty3     )
    );

    BrCsrIQ4Criq4#(
        .CRIQWIDE    ( 4 ),
        .CRIQDEEP    ( 4 )
    )u_BrCsrIQ4Criq4(
        .Clk         ( Clk            ),
        .Rest        ( Rest           ),
        .Rable       ( ReadM4Able     ),
        .CriqPreOut  ( PrePutPtr4     ),
        .Wable       ( WriteCriq4Able ),
        .Din         ( WriteCriq4Addr ),
        .CriqClean   ( BrCsrFlash     ),
        .CriqEmpty   ( CriqEmpty4     )
    );


    genvar a ;

    wire        LodSelect1S1   [0:7] ;
    wire [3:0]  LodSelectOldS1 [0:7] ;
    wire        LodSelectAblS1 [0:7] ;

    wire        StoSelect1S1   [0:7] ;
    wire [3:0]  StoSelectOldS1 [0:7] ;
    wire        StoSelectAblS1 [0:7] ;

    generate
        for (a =0 ;a<16 ;a=a+2 ) begin
            assign LodSelect1S1[a/2]    =   (MEMISSUE[a][68] == MEMISSUE[a+1][68]) & (MEMISSUE[a][67:62] < MEMISSUE[a+1][67:62]) | 
                                            (MEMISSUE[a][68] != MEMISSUE[a+1][68]) & (MEMISSUE[a][67:62] > MEMISSUE[a+1][67:62]) ;
            assign LodSelectOldS1[a/2]  =   {4{(((MEMISSUE[a][60] | ~MEMISSUE[a][61]) & (MEMISSUE[a][51] | ~MEMISSUE[a][52])) & (MEMISSUE[a][35:33] == `LSUCODE ) & MEMISSUE[a][32]) & 
                                               (((MEMISSUE[a+1][60] | ~MEMISSUE[a+1][61]) & (MEMISSUE[a+1][51] | ~MEMISSUE[a+1][52])) & (MEMISSUE[a+1][35:33] == `LSUCODE ) & MEMISSUE[a+1][32]) & 
                                                LodSelect1S1[a/2]}} & a |
                                            {4{(((MEMISSUE[a][60] | ~MEMISSUE[a][61]) & (MEMISSUE[a][51] | ~MEMISSUE[a][52])) & (MEMISSUE[a][35:33] == `LSUCODE ) & MEMISSUE[a][32]) & 
                                               (((MEMISSUE[a+1][60] | ~MEMISSUE[a+1][61]) & (MEMISSUE[a+1][51] | ~MEMISSUE[a+1][52])) & (MEMISSUE[a+1][35:33] == `LSUCODE ) & MEMISSUE[a+1][32]) & 
                                                ~LodSelect1S1[a/2]}} & a+1 |
                                            {4{(((MEMISSUE[a][60] | ~MEMISSUE[a][61]) & (MEMISSUE[a][51] | ~MEMISSUE[a][52])) & (MEMISSUE[a][35:33] == `LSUCODE ) & MEMISSUE[a][32]) & 
                                               ~(((MEMISSUE[a+1][60] | ~MEMISSUE[a+1][61]) & (MEMISSUE[a+1][51] | ~MEMISSUE[a+1][52])) & (MEMISSUE[a+1][35:33] == `LSUCODE ) & MEMISSUE[a+1][32])}} & a |
                                            {4{~(((MEMISSUE[a][60] | ~MEMISSUE[a][61]) & (MEMISSUE[a][51] | ~MEMISSUE[a][52])) & (MEMISSUE[a][35:33] == `LSUCODE ) & MEMISSUE[a][32]) & 
                                               (((MEMISSUE[a+1][60] | ~MEMISSUE[a+1][61]) & (MEMISSUE[a+1][51] | ~MEMISSUE[a+1][52])) & (MEMISSUE[a+1][35:33] == `LSUCODE ) & MEMISSUE[a+1][32])}} & a+1 ;
            assign LodSelectAblS1[a/2]  =     ~(~(((MEMISSUE[a][60] | ~MEMISSUE[a][61]) & (MEMISSUE[a][51] | ~MEMISSUE[a][52])) & (MEMISSUE[a][35:33] == `LSUCODE ) & MEMISSUE[a][32]) & 
                                              ~(((MEMISSUE[a+1][60] | ~MEMISSUE[a+1][61]) & (MEMISSUE[a+1][51] | ~MEMISSUE[a+1][52])) & (MEMISSUE[a+1][35:33] == `LSUCODE ) & MEMISSUE[a+1][32])) ;
        
            assign StoSelect1S1[a/2]    =   (MEMISSUE[a][68] == MEMISSUE[a+1][68]) & (MEMISSUE[a][67:62] < MEMISSUE[a+1][67:62]) | 
                                            (MEMISSUE[a][68] != MEMISSUE[a+1][68]) & (MEMISSUE[a][67:62] > MEMISSUE[a+1][67:62]) ;
            assign StoSelectOldS1[a/2]  =   {4{(((MEMISSUE[a][60] | ~MEMISSUE[a][61]) & (MEMISSUE[a][51] | ~MEMISSUE[a][52])) & (MEMISSUE[a][35:33] == `LSUCODE ) & ~MEMISSUE[a][32]) & 
                                               (((MEMISSUE[a+1][60] | ~MEMISSUE[a+1][61]) & (MEMISSUE[a+1][51] | ~MEMISSUE[a+1][52])) & (MEMISSUE[a+1][35:33] == `LSUCODE ) & ~MEMISSUE[a+1][32]) & 
                                                StoSelect1S1[a/2]}} & a |
                                            {4{(((MEMISSUE[a][60] | ~MEMISSUE[a][61]) & (MEMISSUE[a][51] | ~MEMISSUE[a][52])) & (MEMISSUE[a][35:33] == `LSUCODE ) & ~MEMISSUE[a][32]) & 
                                               (((MEMISSUE[a+1][60] | ~MEMISSUE[a+1][61]) & (MEMISSUE[a+1][51] | ~MEMISSUE[a+1][52])) & (MEMISSUE[a+1][35:33] == `LSUCODE ) & ~MEMISSUE[a+1][32]) & 
                                                ~StoSelect1S1[a/2]}} & a+1 |
                                            {4{(((MEMISSUE[a][60] | ~MEMISSUE[a][61]) & (MEMISSUE[a][51] | ~MEMISSUE[a][52])) & (MEMISSUE[a][35:33] == `LSUCODE ) & ~MEMISSUE[a][32]) & 
                                               ~(((MEMISSUE[a+1][60] | ~MEMISSUE[a+1][61]) & (MEMISSUE[a+1][51] | ~MEMISSUE[a+1][52])) & (MEMISSUE[a+1][35:33] == `LSUCODE ) & ~MEMISSUE[a+1][32])}} & a |
                                            {4{~(((MEMISSUE[a][60] | ~MEMISSUE[a][61]) & (MEMISSUE[a][51] | ~MEMISSUE[a][52])) & (MEMISSUE[a][35:33] == `LSUCODE ) & ~MEMISSUE[a][32]) & 
                                               (((MEMISSUE[a+1][60] | ~MEMISSUE[a+1][61]) & (MEMISSUE[a+1][51] | ~MEMISSUE[a+1][52])) & (MEMISSUE[a+1][35:33] == `LSUCODE ) & ~MEMISSUE[a+1][32])}} & a+1 ;
            assign StoSelectAblS1[a/2]  =     ~(~(((MEMISSUE[a][60] | ~MEMISSUE[a][61]) & (MEMISSUE[a][51] | ~MEMISSUE[a][52])) & (MEMISSUE[a][35:33] == `LSUCODE ) & ~MEMISSUE[a][32]) & 
                                              ~(((MEMISSUE[a+1][60] | ~MEMISSUE[a+1][61]) & (MEMISSUE[a+1][51] | ~MEMISSUE[a+1][52])) & (MEMISSUE[a+1][35:33] == `LSUCODE ) & ~MEMISSUE[a+1][32])) ;
            
        end
    endgenerate


    wire        LodSelect1S2   [0:3] ;
    wire [3:0]  LodSelectOldS2 [0:3] ;
    wire        LodSelectAblS2 [0:3] ;

    wire        StoSelect1S2   [0:3] ;
    wire [3:0]  StoSelectOldS2 [0:3] ;
    wire        StoSelectAblS2 [0:3] ;

    genvar b ;
    generate
        for (b =0 ;b<8 ;b=b+2 ) begin
            assign LodSelect1S2[b/2] =   (MEMISSUE[LodSelectOldS1[b]][68] == MEMISSUE[LodSelectOldS1[b+1]][68]) & (MEMISSUE[LodSelectOldS1[b]][67:62] < MEMISSUE[LodSelectOldS1[b+1]][67:62]) | 
                                         (MEMISSUE[LodSelectOldS1[b]][68] != MEMISSUE[LodSelectOldS1[b+1]][68]) & (MEMISSUE[LodSelectOldS1[b]][67:62] > MEMISSUE[LodSelectOldS1[b+1]][67:62]) ;
            assign LodSelectOldS2[b/2]= {4{(LodSelectAblS1[b] & LodSelectAblS1[b+1] & LodSelect1S2[b/2])}} &  LodSelectOldS1[b] | 
                                        {4{(LodSelectAblS1[b] & LodSelectAblS1[b+1] & ~LodSelect1S2[b/2])}} &  LodSelectOldS1[b+1] | 
                                        {4{(LodSelectAblS1[b] & ~LodSelectAblS1[b+1])}} &  LodSelectOldS1[b] | 
                                        {4{(~LodSelectAblS1[b] & LodSelectAblS1[b+1])}} &  LodSelectOldS1[b+1] ;
            assign LodSelectAblS2[b/2]= ~(~LodSelectAblS1[b] & ~LodSelectAblS1[b+1]) ;

            assign StoSelect1S2[b/2] =   (MEMISSUE[StoSelectOldS1[b]][68] == MEMISSUE[StoSelectOldS1[b+1]][68]) & (MEMISSUE[StoSelectOldS1[b]][67:62] < MEMISSUE[StoSelectOldS1[b+1]][67:62]) | 
                                         (MEMISSUE[StoSelectOldS1[b]][68] != MEMISSUE[StoSelectOldS1[b+1]][68]) & (MEMISSUE[StoSelectOldS1[b]][67:62] > MEMISSUE[StoSelectOldS1[b+1]][67:62]) ;
            assign StoSelectOldS2[b/2]= {4{(StoSelectAblS1[b] & StoSelectAblS1[b+1] & StoSelect1S2[b/2])}} &  StoSelectOldS1[b] | 
                                        {4{(StoSelectAblS1[b] & StoSelectAblS1[b+1] & ~StoSelect1S2[b/2])}} &  StoSelectOldS1[b+1] | 
                                        {4{(StoSelectAblS1[b] & ~StoSelectAblS1[b+1])}} &  StoSelectOldS1[b] | 
                                        {4{(~StoSelectAblS1[b] & StoSelectAblS1[b+1])}} &  StoSelectOldS1[b+1] ;      
            assign StoSelectAblS2[b/2]= ~(~StoSelectAblS1[b] & ~StoSelectAblS1[b+1]) ;
        end
    endgenerate

    wire        LodSelect1S3   [0:1] ;
    wire [3:0]  LodSelectOldS3 [0:1] ;
    wire        LodSelectAblS3 [0:1] ;

    wire        StoSelect1S3   [0:1] ;
    wire [3:0]  StoSelectOldS3 [0:1] ;
    wire        StoSelectAblS3 [0:1] ;

    genvar c ;
    generate
        for (c =0 ;c<4 ;c=c+2 ) begin
            assign LodSelect1S3[c/2] =   (MEMISSUE[LodSelectOldS2[c]][68] == MEMISSUE[LodSelectOldS2[c+1]][68]) & (MEMISSUE[LodSelectOldS2[c]][67:62] < MEMISSUE[LodSelectOldS2[c+1]][67:62]) | 
                                         (MEMISSUE[LodSelectOldS2[c]][68] != MEMISSUE[LodSelectOldS2[c+1]][68]) & (MEMISSUE[LodSelectOldS2[c]][67:62] > MEMISSUE[LodSelectOldS2[c+1]][67:62]) ;
            assign LodSelectOldS3[c/2]= {4{(LodSelectAblS2[c] & LodSelectAblS2[c+1] & LodSelect1S3[c/2])}} &  LodSelectOldS2[c] | 
                                        {4{(LodSelectAblS2[c] & LodSelectAblS2[c+1] & ~LodSelect1S3[c/2])}} &  LodSelectOldS2[c+1] | 
                                        {4{(LodSelectAblS2[c] & ~LodSelectAblS2[c+1])}} &  LodSelectOldS2[c] | 
                                        {4{(~LodSelectAblS2[c] & LodSelectAblS2[c+1])}} &  LodSelectOldS2[c+1] ; 
            assign LodSelectAblS3[c/2]= ~(~LodSelectAblS2[c] & ~LodSelectAblS2[c+1]) ;

            assign StoSelect1S3[c/2] =   (MEMISSUE[StoSelectOldS2[c]][68] == MEMISSUE[StoSelectOldS2[c+1]][68]) & (MEMISSUE[StoSelectOldS2[c]][67:62] < MEMISSUE[StoSelectOldS2[c+1]][67:62]) | 
                                         (MEMISSUE[StoSelectOldS2[c]][68] != MEMISSUE[StoSelectOldS2[c+1]][68]) & (MEMISSUE[StoSelectOldS2[c]][67:62] > MEMISSUE[StoSelectOldS2[c+1]][67:62]) ;
            assign StoSelectOldS3[c/2]= {4{(StoSelectAblS2[c] & StoSelectAblS2[c+1] & StoSelect1S3[c/2])}} &  StoSelectOldS2[c] | 
                                        {4{(StoSelectAblS2[c] & StoSelectAblS2[c+1] & ~StoSelect1S3[c/2])}} &  StoSelectOldS2[c+1] | 
                                        {4{(StoSelectAblS2[c] & ~StoSelectAblS2[c+1])}} &  StoSelectOldS2[c] | 
                                        {4{(~StoSelectAblS2[c] & StoSelectAblS2[c+1])}} &  StoSelectOldS2[c+1] ; 
            assign StoSelectAblS3[c/2] = ~(~StoSelectAblS2[c] & ~StoSelectAblS2[c+1]) ;
        end
    endgenerate

    wire        LodSelect1S4    ;
    wire [3:0]  LodSelectOldS4  ;
    wire        LodSelectAblS4  ;

    wire        StoSelect1S4    ;
    wire [3:0]  StoSelectOldS4  ;
    wire        StoSelectAblS4  ;

    assign  LodSelect1S4 =  (MEMISSUE[LodSelectOldS3[0]][68] == MEMISSUE[LodSelectOldS3[1]][68]) & (MEMISSUE[LodSelectOldS3[0]][67:62] < MEMISSUE[LodSelectOldS3[1]][67:62]) | 
                            (MEMISSUE[LodSelectOldS3[0]][68] != MEMISSUE[LodSelectOldS3[1]][68]) & (MEMISSUE[LodSelectOldS3[0]][67:62] > MEMISSUE[LodSelectOldS3[1]][67:62]) ;
    assign LodSelectOldS4 = {4{(LodSelectAblS3[0] & LodSelectAblS3[1] & LodSelect1S4)}} &  LodSelectOldS3[0] | 
                            {4{(LodSelectAblS3[0] & LodSelectAblS3[1] & ~LodSelect1S4)}} &  LodSelectOldS3[1] | 
                            {4{(LodSelectAblS3[0] & ~LodSelectAblS3[1])}} &  LodSelectOldS3[0] | 
                            {4{(~LodSelectAblS3[0] & LodSelectAblS3[1])}} &  LodSelectOldS3[1] ; 
    assign LodSelectAblS4 = ~((~LodSelectAblS3[0] & ~LodSelectAblS3[1])) ;
    
    assign StoSelect1S4 =   (MEMISSUE[StoSelectOldS3[0]][68] == MEMISSUE[StoSelectOldS3[1]][68]) & (MEMISSUE[StoSelectOldS3[0]][67:62] < MEMISSUE[StoSelectOldS3[1]][67:62]) | 
                            (MEMISSUE[StoSelectOldS3[0]][68] != MEMISSUE[StoSelectOldS3[1]][68]) & (MEMISSUE[StoSelectOldS3[0]][67:62] > MEMISSUE[StoSelectOldS3[1]][67:62]) ;
    assign StoSelectOldS4 = {4{(StoSelectAblS3[0] & StoSelectAblS3[1] & StoSelect1S4)}} &  StoSelectOldS3[0] | 
                            {4{(StoSelectAblS3[0] & StoSelectAblS3[1] & ~StoSelect1S4)}} &  StoSelectOldS3[1] | 
                            {4{(StoSelectAblS3[0] & ~StoSelectAblS3[1])}} &  StoSelectOldS3[0] | 
                            {4{(~StoSelectAblS3[0] & StoSelectAblS3[1])}} &  StoSelectOldS3[1] ; 
    assign StoSelectAblS4 = ~(~StoSelectAblS3[0] & ~StoSelectAblS3[1]) ;


    wire CanIssueLoad  = LodSelectAblS4 & LoadReq & ~MemQStop ;
    wire CanIssueStore = StoSelectAblS4 & StoreReq & ~MemQStop ;




    integer i ;
    always @(posedge Clk) begin
        if(!Rest) begin
            for (i =0 ;i<16 ;i=i+2 ) begin
                MEMISSUE[i] <= 69'd0 ;
            end
        end
        else if(MemQFlash) begin
            for (i =0 ;i<16 ;i=i+2 ) begin
                MEMISSUE[i] <= 69'd0 ;
            end
        end 
        else begin
            MEMISSUE[0][60] <= (MemQStop | MEMISSUE[0][60] | ~MEMISSUE[0][61]) ? MEMISSUE[0][60] : MInstSrc2Ready[0] ;
            MEMISSUE[0][51] <= (MemQStop | MEMISSUE[0][51] | ~MEMISSUE[0][52]) ? MEMISSUE[0][51] : MInstSrc1Ready[0] ;
            MEMISSUE[1][60] <= (MemQStop | MEMISSUE[1][60] | ~MEMISSUE[1][61]) ? MEMISSUE[1][60] : MInstSrc2Ready[1] ;
            MEMISSUE[1][51] <= (MemQStop | MEMISSUE[1][51] | ~MEMISSUE[1][52]) ? MEMISSUE[1][51] : MInstSrc1Ready[1] ;
            MEMISSUE[2][60] <= (MemQStop | MEMISSUE[2][60] | ~MEMISSUE[2][61]) ? MEMISSUE[2][60] : MInstSrc2Ready[2] ;
            MEMISSUE[2][51] <= (MemQStop | MEMISSUE[2][51] | ~MEMISSUE[2][52]) ? MEMISSUE[2][51] : MInstSrc1Ready[2] ;
            MEMISSUE[3][60] <= (MemQStop | MEMISSUE[3][60] | ~MEMISSUE[3][61]) ? MEMISSUE[3][60] : MInstSrc2Ready[3] ;
            MEMISSUE[3][51] <= (MemQStop | MEMISSUE[3][51] | ~MEMISSUE[3][52]) ? MEMISSUE[3][51] : MInstSrc1Ready[3] ;
            MEMISSUE[4][60] <= (MemQStop | MEMISSUE[4][60] | ~MEMISSUE[4][61]) ? MEMISSUE[4][60] : MInstSrc2Ready[4] ;
            MEMISSUE[4][51] <= (MemQStop | MEMISSUE[4][51] | ~MEMISSUE[4][52]) ? MEMISSUE[4][51] : MInstSrc1Ready[4] ;
            MEMISSUE[5][60] <= (MemQStop | MEMISSUE[5][60] | ~MEMISSUE[5][61]) ? MEMISSUE[5][60] : MInstSrc2Ready[5] ;
            MEMISSUE[5][51] <= (MemQStop | MEMISSUE[5][51] | ~MEMISSUE[5][52]) ? MEMISSUE[5][51] : MInstSrc1Ready[5] ;
            MEMISSUE[6][60] <= (MemQStop | MEMISSUE[6][60] | ~MEMISSUE[6][61]) ? MEMISSUE[6][60] : MInstSrc2Ready[6] ;
            MEMISSUE[6][51] <= (MemQStop | MEMISSUE[6][51] | ~MEMISSUE[6][52]) ? MEMISSUE[6][51] : MInstSrc1Ready[6] ;
            MEMISSUE[7][60] <= (MemQStop | MEMISSUE[7][60] | ~MEMISSUE[7][61]) ? MEMISSUE[7][60] : MInstSrc2Ready[7] ;
            MEMISSUE[7][51] <= (MemQStop | MEMISSUE[7][51] | ~MEMISSUE[7][52]) ? MEMISSUE[7][51] : MInstSrc1Ready[7] ;
            MEMISSUE[8][60] <= (MemQStop | MEMISSUE[8][60] | ~MEMISSUE[8][61]) ? MEMISSUE[8][60] : MInstSrc2Ready[8] ;
            MEMISSUE[8][51] <= (MemQStop | MEMISSUE[8][51] | ~MEMISSUE[8][52]) ? MEMISSUE[8][51] : MInstSrc1Ready[8] ;
            MEMISSUE[9][60] <= (MemQStop | MEMISSUE[9][60] | ~MEMISSUE[9][61]) ? MEMISSUE[9][60] : MInstSrc2Ready[9] ;
            MEMISSUE[9][51] <= (MemQStop | MEMISSUE[9][51] | ~MEMISSUE[9][52]) ? MEMISSUE[9][51] : MInstSrc1Ready[9] ;
            MEMISSUE[10][60] <= (MemQStop | MEMISSUE[10][60] | ~MEMISSUE[10][61]) ? MEMISSUE[10][60] : MInstSrc2Ready[10] ;
            MEMISSUE[10][51] <= (MemQStop | MEMISSUE[10][51] | ~MEMISSUE[10][52]) ? MEMISSUE[10][51] : MInstSrc1Ready[10] ;
            MEMISSUE[11][60] <= (MemQStop | MEMISSUE[11][60] | ~MEMISSUE[11][61]) ? MEMISSUE[11][60] : MInstSrc2Ready[11] ;
            MEMISSUE[11][51] <= (MemQStop | MEMISSUE[11][51] | ~MEMISSUE[11][52]) ? MEMISSUE[11][51] : MInstSrc1Ready[11] ;
            MEMISSUE[12][60] <= (MemQStop | MEMISSUE[12][60] | ~MEMISSUE[12][61]) ? MEMISSUE[12][60] : MInstSrc2Ready[12] ;
            MEMISSUE[12][51] <= (MemQStop | MEMISSUE[12][51] | ~MEMISSUE[12][52]) ? MEMISSUE[12][51] : MInstSrc1Ready[12] ;
            MEMISSUE[13][60] <= (MemQStop | MEMISSUE[13][60] | ~MEMISSUE[13][61]) ? MEMISSUE[13][60] : MInstSrc2Ready[13] ;
            MEMISSUE[13][51] <= (MemQStop | MEMISSUE[13][51] | ~MEMISSUE[13][52]) ? MEMISSUE[13][51] : MInstSrc1Ready[13] ;
            MEMISSUE[14][60] <= (MemQStop | MEMISSUE[14][60] | ~MEMISSUE[14][61]) ? MEMISSUE[14][60] : MInstSrc2Ready[14] ;
            MEMISSUE[14][51] <= (MemQStop | MEMISSUE[14][51] | ~MEMISSUE[14][52]) ? MEMISSUE[14][51] : MInstSrc1Ready[14] ;
            MEMISSUE[15][60] <= (MemQStop | MEMISSUE[15][60] | ~MEMISSUE[15][61]) ? MEMISSUE[15][60] : MInstSrc2Ready[15] ;
            MEMISSUE[15][51] <= (MemQStop | MEMISSUE[15][51] | ~MEMISSUE[15][52]) ? MEMISSUE[15][51] : MInstSrc1Ready[15] ;
            MEMISSUE[PrePutPtr1] <= ReadM1Able ? WriteMIQ1 : MEMISSUE[PrePutPtr1] ;
            MEMISSUE[PrePutPtr2] <= ReadM2Able ? WriteMIQ2 : MEMISSUE[PrePutPtr2] ;
            MEMISSUE[PrePutPtr3] <= ReadM3Able ? WriteMIQ3 : MEMISSUE[PrePutPtr3] ;
            MEMISSUE[PrePutPtr4] <= ReadM4Able ? WriteMIQ4 : MEMISSUE[PrePutPtr4] ;
            MEMISSUE[LodSelectOldS4] <= CanIssueLoad  ? 69'd0 : MEMISSUE[LodSelectOldS4] ;
            MEMISSUE[StoSelectOldS4] <= CanIssueStore ? 69'd0 : MEMISSUE[StoSelectOldS4] ;
        end
    end

    
endmodule
