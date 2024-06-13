`timescale 1ps/1ps
`include "../define.v"

module ReOrderBuffer (
    input         wire                               Clk            ,
    input         wire                               Rest           ,
    //for ctrl 
    input         wire                               ROBStop        ,
    input         wire                               ROBFlash       ,
    //for Icache 异常
    input         wire                               IcacheYc       ,
    input         wire       [6:0]                   IcacheYcCode   ,
    input         wire       [`InstAddrBus]          IcacheYcVPc    ,
    //from rename 为了简化，此处decode写入的一定的是四条指令
    input         wire                               InInst1Able    ,
    input         wire       [`InstAddrBus]          InInsr1Pc      ,
    input         wire       [`MicOperateCode]       InInst1MicOp   ,
    input         wire                               InInst1RdAble  ,
    input         wire       [`ArchRegBUs]           InInst1RdAnum  ,
    input         wire       [`ReNameRegBUs]         InInst1RdRnum  ,
    input         wire                               InInst2Able    ,
    input         wire       [`InstAddrBus]          InInsr2Pc      ,
    input         wire       [`MicOperateCode]       InInst2MicOp   ,
    input         wire                               InInst2RdAble  ,
    input         wire       [`ArchRegBUs]           InInst2RdAnum  ,
    input         wire       [`ReNameRegBUs]         InInst2RdRnum  ,  
    input         wire                               InInst3Able    ,
    input         wire       [`InstAddrBus]          InInsr3Pc      ,
    input         wire       [`MicOperateCode]       InInst3MicOp   ,
    input         wire                               InInst3RdAble  ,
    input         wire       [`ArchRegBUs]           InInst3RdAnum  ,
    input         wire       [`ReNameRegBUs]         InInst3RdRnum  ,  
    input         wire                               InInst4Able    ,
    input         wire       [`InstAddrBus]          InInsr4Pc      ,
    input         wire       [`MicOperateCode]       InInst4MicOp   ,
    input         wire                               InInst4RdAble  ,
    input         wire       [`ArchRegBUs]           InInst4RdAnum  ,
    input         wire       [`ReNameRegBUs]         InInst4RdRnum  ,                                                       
    //to rename 
    output        wire       [5:0]                   RobPtr1Alloc   ,
    output        wire       [5:0]                   RobPtr2Alloc   ,
    output        wire       [5:0]                   RobPtr3Alloc   ,
    output        wire       [5:0]                   RobPtr4Alloc   ,
    //from csr 
    input         wire                               ExtInterrupt   ,
    input         wire       [6:0]                   ExtCode        ,
    input         wire                               LlCtrlBit      ,
    input         wire       [25:0]                  InTlbEntryDate ,
    input         wire       [25:0]                  InEntryDate    ,
    output        wire                               Interrupt      , //此处中断包括所有例外包括entry返回
    output        wire       [`InstAddrBus]          InterruptPc    ,
    output        wire       [`InstAddrBus]          InterruptAddr  , //例如一条访存指令发生重填，pc就是这条指令地址addr就是他访存的虚地址
    output        wire       [6:0]                   InterruptType  ,   
    output        wire                               TrapEntry      ,
    //from eu
    //alu1
    input         wire                               Alu1ReadPcAble ,
    input         wire       [5:0]                   Alu1ReadPcPtr  ,
    output        wire       [`InstAddrBus]          Alu1ReadPcDate ,
    input         wire                               Alu1ComeAble   ,
    input         wire       [5:0]                   Alu1CoomePtr   ,
    //input         wire       [1:0]                   Alu1ComeType   ,
    //alu2
    input         wire                               Alu2ReadPcAble ,
    input         wire       [5:0]                   Alu2ReadPcPtr  ,
    output        wire       [`InstAddrBus]          Alu2ReadPcDate ,
    input         wire                               Alu2ComeAble   ,
    input         wire       [5:0]                   Alu2CoomePtr   ,
    //input         wire       [1:0]                   Alu2ComeType   ,
    //bru
    input         wire                               BruReadPcAble  ,
    input         wire       [5:0]                   BruReadPcPtr   ,
    output        wire       [`InstAddrBus]          BruReadPcDate  ,
    input         wire                               BruComeAble    ,
    input         wire       [5:0]                   BruCoomePtr    ,
    input         wire                               BruComeYN      ,
    input         wire       [1:0]                   BruCReDirType  ,
    input         wire       [`InstAddrBus]          BruCReDirPc    ,
    //div
    input         wire                               DivComeAble    ,
    input         wire       [5:0]                   DivCoomePtr    ,
    input         wire       [1:0]                   DivComeType    ,
    //mul 
    input         wire                               MulComeAble    ,
    input         wire       [5:0]                   MulCoomePtr    ,
    input         wire       [1:0]                   MulComeType    , 
    //csru 
    input         wire                               CsrReadPcAble  ,
    input         wire       [5:0]                   CsrReadPcPtr   ,
    output        wire       [`InstAddrBus]          CsrReadPcDate  ,
    input         wire                               CsrInterrupt   ,
    input         wire       [6:0]                   CsrCRobCode    ,
    input         wire       [`InstAddrBus]          CsrCRobAddr    ,
    input         wire                               CsrCRobReady   ,
    input         wire       [5:0]                   CsrCRobPtr     ,
    //input         wire                               CsrCRobIdle    ,  
    output        wire                               CsrRetirAble   ,
    output        wire       [`MicOperateCode]       CsrRetirMicOp  , 
    //AGUload
    input         wire                               LbReadPcAble   ,
    input         wire       [5:0]                   LbReadPcPtr    ,
    output        wire       [`InstAddrBus]          LbReadPcDate   ,
    //Load buffer
    input         wire                               LbComeAble     ,
    input         wire       [5:0]                   LbComeRobPtr   ,
    input         wire                               LbComeTrap     ,
    input         wire       [6:0]                   LbComeTrapCode ,
    input         wire       [`InstAddrBus]          LbComeTrapAddr ,
    input         wire       [2:0]                   LbComeBPtr     ,
    output        wire                               RetirLAble1    ,
    output        wire       [2:0]                   ReTirLPtr1     ,
    output        wire                               RetirLAble2    ,
    output        wire       [2:0]                   ReTirLPtr2     ,
    output        wire                               RetirLAble3    ,
    output        wire       [2:0]                   ReTirLPtr3     ,
    output        wire                               RetirLAble4    ,
    output        wire       [2:0]                   ReTirLPtr4     ,
    //store buffer
    input         wire                               StComeAble     ,
    input         wire       [5:0]                   StComeRobPtr   ,
    input         wire                               StComeTrap     ,
    input         wire       [6:0]                   StComeTrapCode ,
    input         wire       [`InstAddrBus]          StComeTrapAddr ,
    input         wire       [2:0]                   StComeBPtr     ,
    output        wire                               RetirSAble1    ,
    output        wire       [2:0]                   ReTirSPtr1     ,
    output        wire                               RetirSAble2    ,
    output        wire       [2:0]                   ReTirSPtr2     ,
    output        wire                               RetirSAble3    ,
    output        wire       [2:0]                   ReTirSPtr3     ,
    output        wire                               RetirSAble4    ,
    output        wire       [2:0]                   ReTirSPtr4     ,
    //to FTQ 
    output        wire                               RobToFTQAble   ,//是否branch指令
    output        wire                               RobToFTQYN     ,//预测的对不对 
    output        wire       [`InstAddrBus]          RobToFTQPc     ,//指令的pc （branch指令的instpc不是nextpc）    
    //to PC
    output        wire                               RobReDirectAble,
    output        wire       [`InstAddrBus]          RobReDirectAddr,
    //to aRAT
    output        wire                               aRATRelaod     ,
    output        wire                               Inst1Map       ,
    output        wire       [`ArchRegBUs]           Inst1ArchReg   ,
    output        wire       [`ReNameRegBUs]         Inst1RenameReg ,
    output        wire                               Inst2Map       ,
    output        wire       [`ArchRegBUs]           Inst2ArchReg   ,
    output        wire       [`ReNameRegBUs]         Inst2RenameReg ,
    output        wire                               Inst3Map       ,
    output        wire       [`ArchRegBUs]           Inst3ArchReg   ,
    output        wire       [`ReNameRegBUs]         Inst3RenameReg ,
    output        wire                               Inst4Map       ,
    output        wire       [`ArchRegBUs]           Inst4ArchReg   ,
    output        wire       [`ReNameRegBUs]         Inst4RenameReg 
        
);
    reg          StopTemp  ;
    reg          FlashTemp ;
    always @(posedge Clk) begin
        if(!Rest) begin
            StopTemp  <= `EnableValue  ;
            FlashTemp <= `EnableValue  ; 
        end
        else begin
            StopTemp  <= ROBStop  ;
            FlashTemp <= ROBFlash ;
        end
    end

    reg    [102:0]  ROBENTY [0:63] ;

    assign Alu1ReadPcDate = Alu1ReadPcAble ? ROBENTY[Alu1ReadPcPtr][76:45] : 32'd0 ;
    assign Alu2ReadPcDate = Alu2ReadPcAble ? ROBENTY[Alu2ReadPcPtr][76:45] : 32'd0 ;
    assign BruReadPcDate  = BruReadPcAble  ? ROBENTY[BruReadPcPtr ][76:45] : 32'd0 ;
    assign CsrReadPcDate  = CsrReadPcAble  ? ROBENTY[CsrReadPcPtr ][76:45] : 32'd0 ;
    assign LbReadPcDate   = LbReadPcAble   ? ROBENTY[LbReadPcPtr  ][76:45] : 32'd0 ;

    wire                   ROBEmpty       ;
    reg    [7:0]           IcacheYCTemp   ;
    reg    [`InstAddrBus]  IcacheYcVPcTemp;
    always @(posedge Clk) begin
        if(!Rest) begin
            IcacheYCTemp <= 8'b0 ;
            IcacheYcVPcTemp <= 32'd0 ;
        end
        else if(ROBStop) begin
            IcacheYCTemp <= IcacheYCTemp ;
            IcacheYcVPcTemp <= IcacheYcVPcTemp ;
        end
        else if(ROBFlash) begin
            IcacheYCTemp <= 8'b0     ;
            IcacheYcVPcTemp <= 32'd0 ;
        end
        else if(IcacheYc) begin
            IcacheYCTemp <= {`AbleValue,IcacheYcCode} ;
            IcacheYcVPcTemp <= IcacheYcVPc            ;
        end
    end

    assign RobPtr1Alloc = Din1 ;
    assign RobPtr2Alloc = Din2 ;
    assign RobPtr3Alloc = Din3 ;
    assign RobPtr4Alloc = Din4 ;

    reg  [2:0] RobReadPtr ;
    wire [2:0] RobReadNum ;

    always @(posedge Clk) begin
        if(!Rest) begin
            RobReadPtr  <= 3'b0 ;
        end
        else begin
            RobReadPtr <= RobReadPtr[1:0] + RobReadNum ;
        end
    end

    wire [5:0] CheckInst1Ptr ; 
    wire [5:0] CheckInst2Ptr ; 
    wire [5:0] CheckInst3Ptr ; 
    wire [5:0] CheckInst4Ptr ; 

    assign {CheckInst1Ptr,CheckInst2Ptr,CheckInst3Ptr,CheckInst4Ptr} = (RobReadPtr == 0) ? {CriqPreOut1,CriqPreOut2,CriqPreOut3,CriqPreOut4} :
                                                                       (RobReadPtr == 1) ? {CriqPreOut2,CriqPreOut3,CriqPreOut4,CriqPreOut1} :
                                                                       (RobReadPtr == 2) ? {CriqPreOut3,CriqPreOut4,CriqPreOut1,CriqPreOut2} :
                                                                       (RobReadPtr == 3) ? {CriqPreOut3,CriqPreOut1,CriqPreOut2,CriqPreOut3} : 24'd0 ;

    wire Inst1CanRetir = ROBENTY[CheckInst1Ptr][44] ;
    wire Inst2CanRetir = ROBENTY[CheckInst2Ptr][44] ;
    wire Inst3CanRetir = ROBENTY[CheckInst3Ptr][44] ;
    wire Inst4CanRetir = ROBENTY[CheckInst4Ptr][44] ;

    wire Inst1KernalYN = (ROBENTY[CheckInst1Ptr][101:99] == 3'b100);
    wire Inst2KernalYN = (ROBENTY[CheckInst2Ptr][101:99] == 3'b100);
    wire Inst3KernalYN = (ROBENTY[CheckInst3Ptr][101:99] == 3'b100);
    wire Inst4KernalYN = (ROBENTY[CheckInst4Ptr][101:99] == 3'b100);

    // wire Inst1IsIdle   = (ROBENTY[CheckInst1Ptr][101:93] == `InstIdle) ;
    // wire Inst2IsIdle   = (ROBENTY[CheckInst2Ptr][101:93] == `InstIdle) ;
    // wire Inst3IsIdle   = (ROBENTY[CheckInst3Ptr][101:93] == `InstIdle) ;
    // wire Inst4IsIdle   = (ROBENTY[CheckInst4Ptr][101:93] == `InstIdle) ;

    wire Inst1IsSysCall   = (ROBENTY[CheckInst1Ptr][101:93] == `InstSyscall) ;
    wire Inst2IsSysCall   = (ROBENTY[CheckInst2Ptr][101:93] == `InstSyscall) ;
    wire Inst3IsSysCall   = (ROBENTY[CheckInst3Ptr][101:93] == `InstSyscall) ;
    wire Inst4IsSysCall   = (ROBENTY[CheckInst4Ptr][101:93] == `InstSyscall) ;

    wire Inst1Redirect = ROBENTY[CheckInst1Ptr][43] ;
    wire Inst2Redirect = ROBENTY[CheckInst2Ptr][43] ;
    wire Inst3Redirect = ROBENTY[CheckInst3Ptr][43] ;
    wire Inst4Redirect = ROBENTY[CheckInst4Ptr][43] ;

    wire Inst1Trap     = ROBENTY[CheckInst1Ptr][10] ;
    wire Inst2Trap     = ROBENTY[CheckInst2Ptr][10] ;
    wire Inst3Trap     = ROBENTY[CheckInst3Ptr][10] ;
    wire Inst4Trap     = ROBENTY[CheckInst4Ptr][10] ;
    
    wire FinalRetir1 = ~ExtInterrupt & Inst1CanRetir  ;
    wire FInalRetir2 = FinalRetir1 & ~Inst1KernalYN & ~Inst1Redirect ;
    wire FInalRetir3 = FInalRetir2 & ~Inst2KernalYN & ~Inst2Redirect ;
    wire FInalRetir4 = FInalRetir3 & ~Inst3KernalYN & ~Inst3Redirect ;

    wire LastComit1  = FinalRetir1 & ~FinalRetir2 & ~FinalRetir3 & ~FinalRetir4 ;
    wire LastComit2  = FinalRetir1 &  FinalRetir2 & ~FinalRetir3 & ~FinalRetir4 ;
    wire LastComit3  = FinalRetir1 &  FinalRetir2 &  FinalRetir3 & ~FinalRetir4 ;
    wire LastComit4  = FinalRetir1 &  FinalRetir2 &  FinalRetir3 &  FinalRetir4 ;

    assign RobReadNum = {3{(LastComit1)}} & 3'd1 |
                        {3{(LastComit2)}} & 3'd2 |
                        {3{(LastComit3)}} & 3'd3 |
                        {3{(LastComit4)}} & 3'd4 ;

    wire   CommitIdle =  LastComit1 & (ROBENTY[CheckInst1Ptr][101:93] == `InstIdle) |   
                         LastComit2 & (ROBENTY[CheckInst2Ptr][101:93] == `InstIdle) |    
                         LastComit3 & (ROBENTY[CheckInst3Ptr][101:93] == `InstIdle) |     
                         LastComit4 & (ROBENTY[CheckInst4Ptr][101:93] == `InstIdle) ;

    wire   CommitSysCall = LastComit1 & (ROBENTY[CheckInst1Ptr][101:93] == `InstSyscall) |    
                           LastComit2 & (ROBENTY[CheckInst2Ptr][101:93] == `InstSyscall) | 
                           LastComit3 & (ROBENTY[CheckInst3Ptr][101:93] == `InstSyscall) | 
                           LastComit4 & (ROBENTY[CheckInst4Ptr][101:93] == `InstSyscall) ;
 
    wire   U1ReadAble  ;
    wire   U2ReadAble  ;
    wire   U3ReadAble  ;
    wire   U4ReadAble  ;

    assign {U1ReadAble, U2ReadAble, U3ReadAble, U4ReadAble} = (RobReadPtr == 0) ? {FinalRetir1,FinalRetir2,FinalRetir3,FinalRetir4} :
                                                              (RobReadPtr == 1) ? {FinalRetir4,FinalRetir1,FinalRetir2,FinalRetir3} :
                                                              (RobReadPtr == 2) ? {FinalRetir3,FinalRetir4,FinalRetir1,FinalRetir2} :
                                                              (RobReadPtr == 3) ? {FinalRetir2,FinalRetir3,FinalRetir4,FinalRetir1} : 4'd0 ;

    assign ROBEmpty =  U1Emptysign | U2Emptysign | U3Emptysign | U4Emptysign ;

    assign Interrupt = (FinalRetir1 & (Inst1Trap | Inst1IsSysCall | (ROBEmpty&IcacheYCTemp[7]))) | 
                       (FinalRetir2 & (Inst2Trap | Inst2IsSysCall | (ROBEmpty&IcacheYCTemp[7]))) | 
                       (FinalRetir3 & (Inst3Trap | Inst3IsSysCall | (ROBEmpty&IcacheYCTemp[7]))) | 
                       (FinalRetir4 & (Inst4Trap | Inst4IsSysCall | (ROBEmpty&IcacheYCTemp[7]))) ;

    assign InterruptPc = {32{(FinalRetir1 & (Inst1Trap | Inst1IsSysCall | (ROBEmpty&IcacheYCTemp[7])))}} & ROBENTY[CheckInst1Ptr][76:45] |
                         {32{(FinalRetir2 & (Inst2Trap | Inst2IsSysCall | (ROBEmpty&IcacheYCTemp[7])))}} & ROBENTY[CheckInst2Ptr][76:45] |
                         {32{(FinalRetir3 & (Inst3Trap | Inst3IsSysCall | (ROBEmpty&IcacheYCTemp[7])))}} & ROBENTY[CheckInst3Ptr][76:45] |
                         {32{(FinalRetir4 & (Inst4Trap | Inst4IsSysCall | (ROBEmpty&IcacheYCTemp[7])))}} & ROBENTY[CheckInst4Ptr][76:45] ;

    assign InterruptAddr = 

    wire Wu1_CRIQable = InInst1Able ;
    wire [5:0] CriqPreOut1          ;
    wire [5:0] Frontd1              ;
    wire [5:0] Din1   = Frontd1+4   ;
    wire       U1FUllSIgn           ;
    wire       U1Emptysign          ;

    CRIQ#(
        .CRIQWIDE    ( 6  ),
        .CRIQDEEP    ( 16 ),
        .PTRWIDE     ( 4  )
    )u1_CRIQ(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .Rable       ( U1ReadAble  ),
        .CriqPreOut  ( CriqPreOut1 ),
        .Frontd      ( Frontd1     ),
        .Wable       ( Wu1_CRIQable),
        .Din         ( Din1        ),
        .CriqClean   ( FlashTemp   ),
        .CriqFull    ( U1FUllSIgn  ),
        .CriqEmpty   ( U1Emptysign )
    );

    wire Wu2_CRIQable = InInst1Able ;
    wire [5:0] CriqPreOut2          ;
    wire [5:0] Frontd2              ;
    wire [5:0] Din2   = Frontd2+4   ;
    wire       U2FUllSIgn           ;
    wire       U2Emptysign          ;

     CRIQ#(
        .CRIQWIDE    ( 6  ),
        .CRIQDEEP    ( 16 ),
        .PTRWIDE     ( 4  )
    )u2_CRIQ(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .Rable       ( Rable1      ),
        .CriqPreOut  ( CriqPreOut1 ),
        .Frontd      ( Frontd2     ),
        .Wable       ( Wu2_CRIQable),
        .Din         ( Din2        ),
        .CriqClean   ( FlashTemp   ),
        .CriqFull    ( U2FUllSIgn  ),
        .CriqEmpty   ( U2Emptysign )
    );

    wire Wu3_CRIQable = InInst1Able ;
    wire [5:0] CriqPreOut3          ;
    wire [5:0] Frontd3              ;
    wire [5:0] Din3   = Frontd3+4   ;
    wire       U3FUllSIgn           ;
    wire       U3Emptysign          ;

     CRIQ#(
        .CRIQWIDE    ( 6  ),
        .CRIQDEEP    ( 16 ),
        .PTRWIDE     ( 4  )
    )u3_CRIQ(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .Rable       ( Rable1      ),
        .CriqPreOut  ( CriqPreOut1 ),
        .Frontd      ( Frontd3     ),
        .Wable       ( Wu3_CRIQable),
        .Din         ( Din3        ),
        .CriqClean   ( FlashTemp   ),
        .CriqFull    ( U3FUllSIgn  ),
        .CriqEmpty   ( U3Emptysign )
    );

    wire Wu4_CRIQable = InInst1Able ;
    wire [5:0] CriqPreOut4          ;
    wire [5:0] Frontd4              ;
    wire [5:0] Din4   = Frontd4+4   ;
    wire       U4FUllSIgn           ;
    wire       U4Emptysign          ;

     CRIQ#(
        .CRIQWIDE    ( 6  ),
        .CRIQDEEP    ( 16 ),
        .PTRWIDE     ( 4  )
    )u4_CRIQ(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .Rable       ( Rable1      ),
        .CriqPreOut  ( CriqPreOut1 ),
        .Frontd      ( Frontd4     ),
        .Wable       ( Wu4_CRIQable),
        .Din         ( Din4        ),
        .CriqClean   ( FlashTemp   ),
        .CriqFull    ( U4FUllSIgn  ),
        .CriqEmpty   ( U4Emptysign )
    );
    
    integer i ;
    always @(posedge Clk) begin
        if(!Rest) begin
            for (i =0 ;i<32 ;i=i+1) begin
                ROBENTY[i]    <= 103'd0 ;
                ROBENTY[i+32] <= 103'd0 ;
            end
        end
        else if(ROBStop)begin
            for (i =0 ;i<32 ;i=i+1) begin
                ROBENTY[i]    <= ROBENTY[i]   ;
                ROBENTY[i+32] <= ROBENTY[i+32];
            end
        end 
        else if(ROBFlash)begin
            for (i =0 ;i<32 ;i=i+1) begin
                ROBENTY[i]    <= 103'd0 ;
                ROBENTY[i+32] <= 103'd0 ;
            end
        end
        else begin
            ROBENTY[Din1] <= InInst1Able ? {`AbleValue,InInst1MicOp,InInst1RdAble,InInst1RdAnum,InInst1RdRnum,InInsr1Pc,45'd0} : ROBENTY[Din1] ;
            ROBENTY[Din2] <= InInst2Able ? {`AbleValue,InInst2MicOp,InInst2RdAble,InInst2RdAnum,InInst2RdRnum,InInsr2Pc,45'd0} : ROBENTY[Din2] ;
            ROBENTY[Din3] <= InInst3Able ? {`AbleValue,InInst3MicOp,InInst3RdAble,InInst3RdAnum,InInst3RdRnum,InInsr3Pc,45'd0} : ROBENTY[Din3] ;
            ROBENTY[Din4] <= InInst4Able ? {`AbleValue,InInst4MicOp,InInst4RdAble,InInst4RdAnum,InInst4RdRnum,InInsr4Pc,45'd0} : ROBENTY[Din4] ;
            ROBENTY[Alu1CoomePtr][44] <=    Alu1ComeAble ? Alu1ComeAble : ROBENTY[Alu1CoomePtr][44] ;
            ROBENTY[Alu2CoomePtr][44] <=    Alu2ComeAble ? Alu2ComeAble : ROBENTY[Alu2CoomePtr][44] ;
            ROBENTY[BruCoomePtr ][44:11] <= BruComeAble  ? {BruComeAble,BruCReDirType,BruCReDirPc} : ROBENTY[BruCoomePtr ][44:11] ;
            ROBENTY[CsrCRobPtr  ][45:3]  <= CsrCRobReady ? {CsrCRobReady,1'b0,CsrCRobAddr,CsrInterrupt,CsrCRobCode} : ROBENTY[CsrCRobPtr  ][45:3] ;
            ROBENTY[LbComeRobPtr][44:0]  <= LbComeAble   ? {LbComeAble,1'b0,LbComeTrapAddr,LbComeTrap,LbComeTrapCode,LbComeBPtr} : ROBENTY[LbComeRobPtr][44:0] ; //在load和store指令中存放中断的addr的地址空间将会存放load和store的访存虚拟地址
            ROBENTY[StComeRobPtr][44:0]  <= StComeAble   ? {StComeAble,1'b0,StComeTrapAddr,StComeTrap,StComeTrapCode,StComeBPtr} : ROBENTY[StComeRobPtr][44:0] ;
        end
    end

    
endmodule