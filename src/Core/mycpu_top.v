`timescale 1ps/1ps
`include "define.v"

module mycpu_top (
    input      wire                         aclk       ,
    input      wire                         aresetn    ,
    input      wire    [ 7:0]               intrpt     , 
    //AXI interface 
    //read reqest
    output     wire    [ 3:0]               arid       ,
    output     wire    [31:0]               araddr     ,
    output     wire    [ 7:0]               arlen      ,
    output     wire    [ 2:0]               arsize     ,
    output     wire    [ 1:0]               arburst    ,
    output     wire    [ 1:0]               arlock     ,
    output     wire    [ 3:0]               arcache    ,
    output     wire    [ 2:0]               arprot     ,
    output     wire                         arvalid    ,
    input      wire                         arready    ,
    //read back
    input      wire    [ 3:0]               rid        ,
    input      wire    [31:0]               rdata      ,
    input      wire    [ 1:0]               rresp      ,
    input      wire                         rlast      ,
    input      wire                         rvalid     ,
    output     wire                         rready     , 
    //write request
    output     wire    [ 3:0]               awid       ,
    output     wire    [31:0]               awaddr     ,
    output     wire    [ 7:0]               awlen      ,
    output     wire    [ 2:0]               awsize     ,
    output     wire    [ 1:0]               awburst    ,
    output     wire    [ 1:0]               awlock     ,
    output     wire    [ 3:0]               awcache    ,
    output     wire    [ 2:0]               awprot     ,
    output     wire                         awvalid    ,
    input      wire                         awready    ,
    //write data
    output     wire    [ 3:0]               wid        ,
    output     wire    [31:0]               wdata      ,
    output     wire    [ 3:0]               wstrb      ,
    output     wire                         wlast      ,
    output     wire                         wvalid     ,
    input      wire                         wready     ,
    //write back
    input      wire    [ 3:0]               bid        ,
    input      wire    [ 1:0]               bresp      ,
    input      wire                         bvalid     , 
    output     wire                         bready     ,
    //debug
    input      wire                         break_point,
    input      wire                         infor_flag ,
    input      wire    [ 4:0]               reg_num    ,
    output     wire                         ws_valid   ,
    output     wire    [31:0]               rf_rdata   ,

    output     wire    [31:0]               debug0_wb_pc,
    output     wire    [ 3:0]               debug0_wb_rf_wen,
    output     wire    [ 4:0]               debug0_wb_rf_wnum,
    output     wire    [31:0]               debug0_wb_rf_wdata,
    output     wire    [31:0]               debug0_wb_inst

);
    wire Clk  = aclk    ;
    wire Rest = aresetn ;

    wire                    PcOutAble ;
    wire [`InstAddrBus]     PcOutPc   ;
    //for btb
    wire                    BtbPcAble ;
    wire [`InstAddrBus]     BtbPc     ;
    wire [2:0]              BtbType   ;
    wire [1:0]              BtbBanN   ;

    //for ctrl
    wire                    CtrlPreReq ;
    wire                    CtrlFTQReq ;
    wire                    CtrlIcReq  ;
    wire                    CtrlBpReq  ;

    wire                    CtrlToPcStop   ;
    wire                    CtrlToBtbStop  ;
    wire                    CtrlToBtbFlash ;
    wire                    CtrlToTageStop ;
    wire                    CtrlToTageFLash;
    wire                    CtrlTORasStop  ;
    wire                    CtrlToRasFlash ;
    wire                    CtrlToIcacStop ;
    wire                    CtrlToIcacFLash;
    wire                    CtrlToFTQStop  ;
    wire                    CtrlToFTQFlash ;
    wire                    CtrlTOPreStop  ;
    wire                    CtrlToPreFLash ;

    //for btb 
    wire                    BtbToMidAble  ;
    wire  [1:0]             BtbToMidBank  ;
    wire  [`InstAddrBus]    BtbToMidPc    ;
    wire  [4:0]             BtbToRasOfs   ;
    wire                    BtbToTageMode ;
    wire  [2:0]             BtbToMidType  ;
    wire                    PreToBtbAble  ;
    wire  [1:0]             PreToBtbBank  ;
    wire  [`InstAddrBus]    PreToBtbPc    ;
    wire                    PreToBtbCAble ;
    wire  [3:0]             PreToBtbCnt   ;
    wire                    PreToBtbTAble ;
    wire  [2:0]             PreToBtbType  ;
    wire                    PreToBtbGAble ;
    wire  [`InstAddrBus]    PreToBtbTargrt;
    //for mid 
    wire                    MidToPreAble  ;
    wire  [1:0]             MidToPreBank  ;
    wire  [`InstAddrBus]    MidToPrePc    ;
    wire  [2:0]             MidToPreType  ;

    // for pc 
    wire                    PreToPcAble   ;
    wire  [`InstAddrBus]    PreToPcPc     ;
    wire                    RobToPcAble   ;
    wire  [`InstAddrBus]    RobToPcPc     ;

    //for ftq 
    wire                    PredToFTQAble ;
    wire                    PredToFTQMode ;
    wire  [2:0]             PredToFTQJdate;
    wire  [2:0]             PredToFTQNum  ;
    wire  [2:0]             PredToFTQU1   ;
    wire  [2:0]             PredToFTQU2   ;
    wire  [2:0]             PredToFTQU3   ;
    wire  [2:0]             PredToFTQU4   ;
    wire  [2:0]             PredToFTQU5   ;
    wire  [2:0]             PredToFTQU6   ;

    wire                    FTQToTageAble ;
    wire  [`InstAddrBus]    FTQToTagePc   ;
    wire  [2:0]             FTQToTageDate ;
    wire  [2:0]             FTQToTageNum  ;
    wire  [2:0]             FTQToTageCnt  ;
    wire                    FTQToTageNable;
    wire  [2:0]             FTQToTageNDate;
    wire  [2:0]             FTQToTageNNum ;
    wire  [2:0]             FTQToTageNCnt ;
    wire                    FTQToTageNC1Able;
    wire  [2:0]             FTQTOTAgeNC1  ;
    wire                    FTQToTageNC2Able;
    wire  [2:0]             FTQTOTAgeNC2  ;
    wire                    FTQToTageNC3Able;
    wire  [2:0]             FTQTOTAgeNC3  ;
    wire                    FTQToTageNC4Able;
    wire  [2:0]             FTQTOTAgeNC4  ;
    wire                    FTQToTageNC5Able;
    wire  [2:0]             FTQTOTAgeNC5  ;
    wire                    FTQToTageNC6Able;
    wire  [2:0]             FTQTOTAgeNC6  ;
    
    //for RAS 

    wire                    PreTORasAble ;
    wire  [1:0]             PreToRasType ;
    wire  [`InstAddrBus]    PreToRasPc   ;
    wire                    RobToRasAble ;
    wire                    RobToRasRload;
    wire  [`InstAddrBus]    RobToRasDate ;
    wire                    RobToRasCall ;
    wire                    RobToRasRtrn ;
    wire                    RasToPreAble ;
    wire  [`InstAddrBus]    RasToPreAddr ;

    //for tage                   
    wire                    PreTOTageAble  ;
    wire  [`InstAddrBus]    PreToTageDate  ;
    wire                    RobToTageAtten ;
    wire                    RobToTggeGAble ;
    wire  [64:0]            RobToTageGHR   ;
    wire                    TageToPreAble  ;
    wire                    TageToPreMode  ;
    wire  [2:0]             TageToPreJdate ;
    wire  [2:0]             TageToPreNum   ;
    wire  [2:0]             TageToPreC1    ;
    wire  [2:0]             TageToPreC2    ;
    wire  [2:0]             TageToPreC3    ;
    wire  [2:0]             TageToPreC4    ;
    wire  [2:0]             TageToPreC5    ;
    wire  [2:0]             TageToPreC6    ;
    
    //for pre
    wire                    IcaToPreAble  ;
    wire  [255:0]           IcaToPrePcgrp ;
    wire  [7:0]             IcaToPreInvt  ;
    wire  [255:0]           IcaToPreIgrp  ;
    wire                    PredTo1ISAble ;
    wire                    PredTo1ISMode ;
    wire  [`InstAddrBus]    PredTo1ISPc   ;
    wire  [`InstAddrBus]    PredTo1ISRPc  ;
    wire  [`InstDateBus]    PredTo1ISInst ;
    wire                    PredTo2ISAble ;
    wire                    PredTo2ISMode ;
    wire  [`InstAddrBus]    PredTo2ISPc   ;
    wire  [`InstAddrBus]    PredTo2ISRPc  ;
    wire  [`InstDateBus]    PredTo2ISInst ;
    wire                    PredTo3ISAble ;
    wire                    PredTo3ISMode ;
    wire  [`InstAddrBus]    PredTo3ISPc   ;
    wire  [`InstAddrBus]    PredTo3ISRPc  ;
    wire  [`InstDateBus]    PredTo3ISInst ;
    wire                    PredTo4ISAble ;
    wire                    PredTo4ISMode ;
    wire  [`InstAddrBus]    PredTo4ISPc   ;
    wire  [`InstAddrBus]    PredTo4ISRPc  ;
    wire  [`InstDateBus]    PredTo4ISInst ;
    wire                    PredTo5ISAble ;
    wire                    PredTo5ISMode ;
    wire  [`InstAddrBus]    PredTo5ISPc   ;
    wire  [`InstAddrBus]    PredTo5ISRPc  ;
    wire  [`InstDateBus]    PredTo5ISInst ;
    wire                    PredTo6ISAble ;
    wire                    PredTo6ISMode ;
    wire  [`InstAddrBus]    PredTo6ISPc   ;
    wire  [`InstAddrBus]    PredTo6ISRPc  ;
    wire  [`InstDateBus]    PredTo6ISInst ;
    wire                    PredTo7ISAble ;
    wire                    PredTo7ISMode ;
    wire  [`InstAddrBus]    PredTo7ISPc   ;
    wire  [`InstAddrBus]    PredTo7ISRPc  ;
    wire  [`InstDateBus]    PredTo7ISInst ;
    wire                    PredTo8ISAble ;
    wire                    PredTo8ISMode ;
    wire  [`InstAddrBus]    PredTo8ISPc   ;
    wire  [`InstAddrBus]    PredTo8ISRPc  ;
    wire  [`InstDateBus]    PredTo8ISInst ;

    //for ICache 
    wire                    IcaToMmuAble  ;
    wire  [31:0]            IcaToMmuVPc   ;
    wire  [1:0]             MmuToIcaType  ;
    wire                    MmuToIcaTrap  ;
    wire  [`InstAddrBus]    MmuToIcaPPc   ;
    wire                    IcaToAXIAble  ;
    wire                    AXIToIcaSKH   ;
    wire                    UcaToAXIAble  ;
    wire  [`InstAddrBus]    IcaToAXIAddr  ;
    wire                    AXIToIcaAble  ;
    wire                    AXIToIcaReq   ;
    wire  [511:0]           AXIToIcaDate  ; 

    //fro InstQUeue 
    wire                    ISToDcodePort1  ;
    wire                    ISToDcodePort2  ;
    wire                    ISToDcodePort3  ;
    wire                    ISToDcodePort4  ;
    wire  [`InstAddrBus]    ISToDcodeAddr1  ;
    wire  [`InstDateBus]    ISToDcodeDate1  ; 
    wire                    ISToDcodePart1  ; 
    wire  [`InstAddrBus]    ISToDcodeRPc1   ; 
    wire  [`InstAddrBus]    ISToDcodeAddr2  ;
    wire  [`InstDateBus]    ISToDcodeDate2  ; 
    wire                    ISToDcodePart2  ; 
    wire  [`InstAddrBus]    ISToDcodeRPc2   ;   
    wire  [`InstAddrBus]    ISToDcodeAddr3  ;
    wire  [`InstDateBus]    ISToDcodeDate3  ; 
    wire                    ISToDcodePart3  ; 
    wire  [`InstAddrBus]    ISToDcodeRPc3   ; 
    wire  [`InstAddrBus]    ISToDcodeAddr4  ;
    wire  [`InstDateBus]    ISToDcodeDate4  ; 
    wire                    ISToDcodePart4  ; 
    wire  [`InstAddrBus]    ISToDcodeRPc4   ; 

    //for decode
    wire  [`InstAddrBus]    DcdToRnm1Pc      ;
    wire  [`MicOperateCode] DcdToRnm1Opcode  ;
    wire                    DcdToRnm1ImAble  ;
    wire  [25:0]            DcdToRnm1ImDate  ;
    wire                    DcdToRnm1Sr1Able ;
    wire  [`ArchRegBUs]     DcdToRnm1Sr1Num  ;
    wire                    DcdToRnm1Sr2Able ;
    wire  [`ArchRegBUs]     DcdToRnm1Sr2Num  ;
    wire                    DcdToRnm1WAble   ;
    wire                    DcdToRnm1Part    ;
    wire  [`InstAddrBus]    DcdToRnm1Naddr   ;
    wire  [`ArchRegBUs]     DcdToRnm1Wnum    ;
    wire  [`InstAddrBus]    DcdToRnm2Pc      ;
    wire  [`MicOperateCode] DcdToRnm2Opcode  ;
    wire                    DcdToRnm2ImAble  ;
    wire  [25:0]            DcdToRnm2ImDate  ;
    wire                    DcdToRnm2Sr1Able ;
    wire  [`ArchRegBUs]     DcdToRnm2Sr1Num  ;
    wire                    DcdToRnm2Sr2Able ;
    wire  [`ArchRegBUs]     DcdToRnm2Sr2Num  ;
    wire                    DcdToRnm2WAble   ;
    wire                    DcdToRnm2Part    ;
    wire  [`InstAddrBus]    DcdToRnm2Naddr   ;
    wire  [`ArchRegBUs]     DcdToRnm2Wnum    ;
    wire  [`InstAddrBus]    DcdToRnm3Pc      ;
    wire  [`MicOperateCode] DcdToRnm3Opcode  ;
    wire                    DcdToRnm3ImAble  ;
    wire  [25:0]            DcdToRnm3ImDate  ;
    wire                    DcdToRnm3Sr1Able ;
    wire  [`ArchRegBUs]     DcdToRnm3Sr1Num  ;
    wire                    DcdToRnm3Sr2Able ;
    wire  [`ArchRegBUs]     DcdToRnm3Sr2Num  ;
    wire                    DcdToRnm3WAble   ;
    wire                    DcdToRnm3Part    ;
    wire  [`InstAddrBus]    DcdToRnm3Naddr   ;
    wire  [`ArchRegBUs]     DcdToRnm3Wnum    ;
    wire  [`InstAddrBus]    DcdToRnm4Pc      ;
    wire  [`MicOperateCode] DcdToRnm4Opcode  ;
    wire                    DcdToRnm4ImAble  ;
    wire  [25:0]            DcdToRnm4ImDate  ;
    wire                    DcdToRnm4Sr1Able ;
    wire  [`ArchRegBUs]     DcdToRnm4Sr1Num  ;
    wire                    DcdToRnm4Sr2Able ;
    wire  [`ArchRegBUs]     DcdToRnm4Sr2Num  ;
    wire                    DcdToRnm4WAble   ;
    wire                    DcdToRnm4Part    ;
    wire  [`InstAddrBus]    DcdToRnm4Naddr   ;
    wire  [`ArchRegBUs]     DcdToRnm4Wnum    ;

    //for free list 
    wire                    FLToRAT1Able     ;
    wire  [`ArchRegBUs]     FLToRAT1Areg     ;
    wire  [`ReNameRegBUs]   FLToRAT1RReg     ;  
    wire                    FLToRAT2Able     ;
    wire  [`ArchRegBUs]     FLToRAT2Areg     ;
    wire  [`ReNameRegBUs]   FLToRAT2RReg     ;
    wire                    FLToRAT3Able     ;
    wire  [`ArchRegBUs]     FLToRAT3Areg     ;
    wire  [`ReNameRegBUs]   FLToRAT3RReg     ;
    wire                    FLToRAT4Able     ;
    wire  [`ArchRegBUs]     FLToRAT4Areg     ;
    wire  [`ReNameRegBUs]   FLToRAT4RReg     ;
    wire                    RobToFLRload     ;
    wire                    RefToFLF1Able    ;
    wire  [`ReNameRegBUs]   RefToFLF1Addr    ;
    wire                    RefToFLF2Able    ;
    wire  [`ReNameRegBUs]   RefToFLF2Addr    ;
    wire                    RefToFLF3Able    ;
    wire  [`ReNameRegBUs]   RefToFLF3Addr    ;
    wire                    RefToFLF4Able    ;
    wire  [`ReNameRegBUs]   RefToFLF4Addr    ;

    //for RAT 
    wire                    RATToBYT1Sr1Able   ;
    wire                    RATToBYT1Sr1ND     ;
    wire  [`ReNameRegBUs]   RATToBYT1Sr1Num    ;
    wire                    RATToBYT1Sr2Able   ;
    wire                    RATToBYT1Sr2ND     ;
    wire  [`ReNameRegBUs]   RATToBYT1Sr2Num    ;
    wire                    RATToBYT1WAble     ;
    wire  [`ReNameRegBUs]   RATToBYT1WNum      ;
    wire                    RATToBYT2Sr1Able   ;
    wire                    RATToBYT2Sr1ND     ;
    wire  [`ReNameRegBUs]   RATToBYT2Sr1Num    ;
    wire                    RATToBYT2Sr2Able   ;
    wire                    RATToBYT2Sr2ND     ;
    wire  [`ReNameRegBUs]   RATToBYT2Sr2Num    ;
    wire                    RATToBYT2WAble     ;
    wire  [`ReNameRegBUs]   RATToBYT2WNum      ;
    wire                    RATToBYT3Sr1Able   ;
    wire                    RATToBYT3Sr1ND     ;
    wire  [`ReNameRegBUs]   RATToBYT3Sr1Num    ;
    wire                    RATToBYT3Sr2Able   ;
    wire                    RATToBYT3Sr2ND     ;
    wire  [`ReNameRegBUs]   RATToBYT3Sr2Num    ;
    wire                    RATToBYT3WAble     ;
    wire  [`ReNameRegBUs]   RATToBYT3WNum      ;
    wire                    RATToBYT4Sr1Able   ;
    wire                    RATToBYT4Sr1ND     ;
    wire  [`ReNameRegBUs]   RATToBYT4Sr1Num    ;
    wire                    RATToBYT4Sr2Able   ;
    wire                    RATToBYT4Sr2ND     ;
    wire  [`ReNameRegBUs]   RATToBYT4Sr2Num    ;
    wire                    RATToBYT4WAble     ;
    wire  [`ReNameRegBUs]   RATToBYT4WNum      ;
    wire                    RATToRefLock1      ;
    wire  [`ReNameRegBUs]   RATToRefLock1Addr  ;
    wire                    RATToRefLock2      ;
    wire  [`ReNameRegBUs]   RATToRefLock2Addr  ;
    wire                    RATToRefLock3      ;
    wire  [`ReNameRegBUs]   RATToRefLock3Addr  ;
    wire                    RATToRefLock4      ;
    wire  [`ReNameRegBUs]   RATToRefLock4Addr  ;
    wire                    RATToRefUse1       ;
    wire  [`ReNameRegBUs]   RATToRefUse1Addr   ;
    wire                    RATToRefUse2       ;
    wire  [`ReNameRegBUs]   RATToRefUse2Addr   ;
    wire                    RATToRefUse3       ;
    wire  [`ReNameRegBUs]   RATToRefUse3Addr   ;
    wire                    RATToRefUse4       ;
    wire  [`ReNameRegBUs]   RATToRefUse4Addr   ;
    wire                    RATToRefUse5       ;
    wire  [`ReNameRegBUs]   RATToRefUse5Addr   ;
    wire                    RATToRefUse6       ;
    wire  [`ReNameRegBUs]   RATToRefUse6Addr   ;
    wire                    RATToRefUse7       ;
    wire  [`ReNameRegBUs]   RATToRefUse7Addr   ;
    wire                    RATToRefUse8       ;
    wire  [`ReNameRegBUs]   RATToRefUse8Addr   ;
    wire                    RATToRefUse9       ;
    wire  [`ReNameRegBUs]   RATToRefUse9Addr   ;
    wire                    RATToRefUse10      ;
    wire  [`ReNameRegBUs]   RATToRefUse10Addr  ;
    wire                    RATToRefUse11      ;
    wire  [`ReNameRegBUs]   RATToRefUse11Addr  ;
    wire                    RATToRefUse12      ;
    wire  [`ReNameRegBUs]   RATToRefUse12Addr  ;

    wire                    BYTToIQ1Sr1Able    ;
    wire                    BYTToIQ1Sr1Ready   ;
    wire  [`ReNameRegBUs]   BYTToIQ1Sr1Num     ;
    wire                    BYTToIQ1Sr2Able    ;
    wire                    BYTToIQ1Sr2Ready   ;
    wire  [`ReNameRegBUs]   BYTToIQ1Sr2Num     ;
    wire                    BYTToIQ1WAble      ;
    wire  [`ReNameRegBUs]   BYTToIQ1WNum       ;
    wire                    BYTToIQ2Sr1Able    ;
    wire                    BYTToIQ2Sr1Ready   ;
    wire  [`ReNameRegBUs]   BYTToIQ2Sr1Num     ;
    wire                    BYTToIQ2Sr2Able    ;
    wire                    BYTToIQ2Sr2Ready   ;
    wire  [`ReNameRegBUs]   BYTToIQ2Sr2Num     ;
    wire                    BYTToIQ2WAble      ;
    wire  [`ReNameRegBUs]   BYTToIQ2WNum       ;
    wire                    BYTToIQ3Sr1Able    ;
    wire                    BYTToIQ3Sr1Ready   ;
    wire  [`ReNameRegBUs]   BYTToIQ3Sr1Num     ;
    wire                    BYTToIQ3Sr2Able    ;
    wire                    BYTToIQ3Sr2Ready   ;
    wire  [`ReNameRegBUs]   BYTToIQ3Sr2Num     ;
    wire                    BYTToIQ3WAble      ;
    wire  [`ReNameRegBUs]   BYTToIQ3WNum       ;
    wire                    BYTToIQ4Sr1Able    ;
    wire                    BYTToIQ4Sr1Ready   ;
    wire  [`ReNameRegBUs]   BYTToIQ4Sr1Num     ;
    wire                    BYTToIQ4Sr2Able    ;
    wire                    BYTToIQ4Sr2Ready   ;
    wire  [`ReNameRegBUs]   BYTToIQ4Sr2Num     ;
    wire                    BYTToIQ4WAble      ;
    wire  [`ReNameRegBUs]   BYTToIQ4WNum       ;
    




    Ctrl u_Ctrl(
    .Clk           ( Clk               ),
    .Rest          ( Rest              ),
    .ROBredir      ( ROBredir          ),
    .StopToPc      ( CtrlToPcStop      ),
    .StopToBtb     ( CtrlToBtbStop     ),
    .StopMidFlash  ( CtrlToBtbFlash    ),
    .StopTage      ( CtrlToTageStop    ),
    .FLashTage     ( CtrlToTageFLash   ),
    .StopRas       ( CtrlTORasStop     ),
    .FLashRas      ( CtrlToRasFlash    ),
    .IcacheFLash   ( CtrlToIcacFLash   ),
    .IcacheStop    ( CtrlToIcacStop    ),
    .PredStop      ( CtrlTOPreStop     ),
    .PredFlash     ( CtrlToPreFLash    ),
    .FTQStop       ( CtrlToFTQStop     ),
    .FTQFlash      ( CtrlToFTQFlash    ),
    .IcReq         ( CtrlIcReq         ),
    .BpReq         ( CtrlBpReq         ),
    .PreReq        ( CtrlPreReq        ),
    .FTQReq        ( CtrlFTQReq        )
    );

    Pc u_Pc(
    .Clk             ( Clk             ),
    .Rest            ( Rest            ),
    .PcStop          ( CtrlToPcStop    ),
    .BtbPredictAble  ( BtbPcAble       ),
    .BtbPreDictPc    ( BtbPc           ),
    .PreReDirAble    ( PreToPcAble     ),
    .PreReDirPc      ( PreToPcPc       ),
    .RobReDirAble    ( RobToPcAble     ),
    .RobReDirPc      ( RobToPcPc       ),
    .PcAble          ( PcOutAble       ),
    .PcDate          ( PcOutPc         )
    );



    Btb u_Btb(
    .Clk             ( Clk             ),
    .Rest            ( Rest            ),
    .BtbStop         ( CtrlToBtbStop   ),
    .BtbFlash        ( CtrlToBtbFlash  ),
    .InstPcAble      ( PcOutAble       ),
    .InstPc          ( PcOutPc         ),
    .UpAble          ( PreToBtbAble    ),
    .UpAbleBank      ( PreToBtbBank    ),
    .UpPc            ( PreToBtbPc      ),
    .UpCntAble       ( PreToBtbCAble   ),
    .UpCnt           ( PreToBtbCnt     ),
    .BtbUpTypeAble   ( PreToBtbTAble   ),
    .BtbUpType       ( PreToBtbType    ),
    .BtbUpTagetAble  ( PreToBtbGAble   ),
    .BtbUpTaget      ( PreToBtbTargrt  ),
    .InstNextAble    ( BtbToMidAble    ),
    .InstHitBanN     ( BtbToMidBank    ),
    .InstNextPc      ( BtbToMidPc      ),
    .InstNextOffset  ( BtbToRasOfs     ),
    .InstNextMode    ( BtbToTageMode   ),
    .InstNextType    ( BtbToMidType    )
    );

    BtbMid u_BtbMid(
    .Clk         ( Clk         ),
    .Rest        ( Rest        ),
    .BMstop      ( CtrlToBtbStop ),
    .BMFLash     ( CtrlToBtbFlash),
    .InNextAble  ( BtbToMidAble),
    .InHitBanN   ( BtbToMidBank),
    .InNextPc    ( BtbToMidPc  ),
    .InNextType  ( BtbToMidType),
    .OtNextAble  ( MidToPreAble),
    .OtHitBanN   ( MidToPreBank),
    .OtNextPc    ( MidToPrePc  ),
    .OtNextType  ( MidToPreType)
    );


    FTQ u_FTQ(
    .Clk           ( Clk             ),
    .Rest          ( Rest            ),
    .FTQStop       ( CtrlToFTQStop   ),
    .FTQFlash      ( CtrlToFTQFlash  ),
    .FTQreq        ( CtrlFTQReq      ),
    .ROBBranch     ( ROBBranch       ),
    .ROBBranchYN   ( ROBBranchYN     ),
    .ROBBranchMo   ( ROBBranchMo     ),
    .ROBBranchPc   ( ROBBranchPc     ),
    .PredictAble   ( PredToFTQAble   ),
    .PredictJdate  ( PredToFTQJdate  ),
    .PredictNum    ( PredToFTQNum    ),
    .PredictInt1   ( PredToFTQU1     ),
    .PredictInt2   ( PredToFTQU2     ),
    .PredictInt3   ( PredToFTQU3     ),
    .PredictInt4   ( PredToFTQU4     ),
    .PredictInt5   ( PredToFTQU5     ),
    .PredictInt6   ( PredToFTQU6     ),
    .OutUpDatePc   ( FTQToTagePc     ),
    .OutDateAble   ( FTQToTageAble   ),
    .OutUpDate     ( FTQToTageDate   ),
    .OutUpNum      ( FTQToTageNum    ),
    .OutUpCnt      ( FTQToTageCnt    ),
    .NewDateAble   ( FTQToTageNable  ),
    .NewUpDate     ( FTQToTageNDate  ),
    .NewUpNum      ( FTQToTageNNum   ),
    .NewUpCnt      ( FTQToTageNCnt   ),
    .NewCnt1Able   ( FTQToTageNC1Able),
    .NewCnt1Date   ( FTQTOTAgeNC1    ),
    .NewCnt2Able   ( FTQToTageNC2Able),
    .NewCnt2Date   ( FTQTOTAgeNC2    ),
    .NewCnt3Able   ( FTQToTageNC3Able),
    .NewCnt3Date   ( FTQTOTAgeNC3    ),
    .NewCnt4Able   ( FTQToTageNC4Able),
    .NewCnt4Date   ( FTQTOTAgeNC4    ),
    .NewCnt5Able   ( FTQToTageNC5Able),
    .NewCnt5Date   ( FTQTOTAgeNC5    ),
    .NewCnt6Able   ( FTQToTageNC6Able),
    .NewCnt6Date   ( FTQTOTAgeNC6    )
    );

    Ras u_Ras(
    .Clk            ( Clk            ),
    .Rest           ( Rest           ),
    .RasStop        ( CtrlTORasStop  ),
    .RasFLash       ( CtrlToRasFlash ),
    .BtbAble        ( BtbToMidAble   ),
    .BtbPredictType ( BtbToMidType   ),
    .BtbPcDate      ( BtbToMidPc     ),
    .BtbPcOffset    ( BtbToRasOfs    ),
    .UpAble         ( PreTORasAble   ),
    .UpPtrType      ( PreToRasType   ),
    .UpAddrDate     ( PreToRasPc     ),
    .ToPreAble      ( RasToPreAble   ),
    .ToPreAddr      ( RasToPreAddr   ),
    .UpdateInAble   ( RobToRasAble   ),
    .UpdateReload   ( RobToRasRload  ),
    .UpdateInDate   ( RobToRasDate   ),
    .UpdateCall     ( RobToRasCall   ),
    .UpdateReturn   ( RobToRasRtrn   )
    );

    Tage u_Tage(
    .Clk            ( Clk               ),
    .Rest           ( Rest              ),
    .TageStop       ( CtrlToTageStop    ),
    .TageFlash      ( CtrlToTageFLash   ),
    .PcAble         ( PcOutAble         ),
    .PcDate         ( PcOutPc           ),
    .BtbAble        ( BtbToMidAble      ),
    .BtbType        ( BtbToMidType      ),
    .BtbMode        ( BtbToTageMode     ),
    .PreUpDable     ( PreTOTageAble     ),
    .PreUpDate      ( PreToTageDate     ),
    .Attenuate      ( RobToTageAtten    ),
    .GHRUpAble      ( RobToTggeGAble    ),
    .GHRDate        ( RobToTageGHR      ),
    .InALwDateAble  ( FTQToTageAble     ),
    .InALwUpDatePc  ( FTQToTagePc       ),
    .InALwUpDate    ( FTQToTageDate     ),
    .InALwUpNum     ( FTQToTageNum      ),
    .InALwUpCnt     ( FTQToTageCnt      ),
    .InNewDateAble  ( FTQToTageNable    ),
    .InNewUpDate    ( FTQToTageNDate    ),
    .InNewUpNum     ( FTQToTageNNum     ),
    .InNewUpCnt     ( FTQToTageNCnt     ),
    .InNewCnt1Able  ( FTQToTageNC1Able  ),
    .InNewCnt1Date  ( FTQTOTAgeNC1      ),
    .InNewCnt2Able  ( FTQToTageNC2Able  ),
    .InNewCnt2Date  ( FTQTOTAgeNC2      ),
    .InNewCnt3Able  ( FTQToTageNC3Able  ),
    .InNewCnt3Date  ( FTQTOTAgeNC3      ),
    .InNewCnt4Able  ( FTQToTageNC4Able  ),
    .InNewCnt4Date  ( FTQTOTAgeNC4      ),
    .InNewCnt5Able  ( FTQToTageNC5Able  ),
    .InNewCnt5Date  ( FTQTOTAgeNC5      ),
    .InNewCnt6Able  ( FTQToTageNC6Able  ),
    .InNewCnt6Date  ( FTQTOTAgeNC6      ),
    .PredictAble    ( TageToPreAble     ),
    .PredictMode    ( TageToPreMode     ),
    .PredictJdate   ( TageToPreJdate    ),
    .PredictNum     ( TageToPreNum      ),
    .PredictUset1   ( TageToPreC1       ),
    .PredictUset2   ( TageToPreC2       ),
    .PredictUset3   ( TageToPreC3       ),
    .PredictUset4   ( TageToPreC4       ),
    .PredictUset5   ( TageToPreC5       ),
    .PredictUset6   ( TageToPreC6       )
    );


    PreDecode u_PreDecode(
    .Clk              ( Clk              ),
    .Rest             ( Rest             ),
    .PreDecodeFlash   ( CtrlToPreFLash   ),
    .PreDecodeStop    ( CtrlTOPreStop    ),
    .BtbAble          ( MidToPreAble     ),
    .BtbBanKN         ( MidToPreBank     ),
    .BtbType          ( MidToPreType     ),
    .BtbPc            ( MidToPrePc       ),
    .RasAble          ( RasToPreAble     ),
    .RasPc            ( RasToPreAddr     ),
    .TageAble         ( TageToPreAble    ),
    .TageJdate        ( TageToPreJdate   ),
    .TageMode         ( TageToPreMode    ),
    .TageNum          ( TageToPreNum     ),
    .TageInt1         ( TageToPreC1      ),
    .TageInt2         ( TageToPreC2      ),
    .TageInt3         ( TageToPreC3      ),
    .TageInt4         ( TageToPreC4      ),
    .TageInt5         ( TageToPreC5      ),
    .TageInt6         ( TageToPreC6      ),
    .FetchAble        ( FetchAble        ),
    .FetchPcIvt       ( FetchPcIvt       ),
    .FetchInstIvt     ( FetchInstIvt     ),
    .FetchDate        ( FetchDate        ),
    .PreReDirectAble  ( PreToPcAble      ),
    .PreReDirectPc    ( PreToPcPc        ),
    .BtbUpPcAble      ( PreToBtbAble     ),
    .BtbUpPc          ( PreToBtbPc       ),
    .BtbUpBanKN       ( PreToBtbBank     ),
    .BtbUpTypeAble    ( PreToBtbTAble    ),
    .BtbUpType        ( PreToBtbType     ),
    .BtbUpTagetAble   ( PreToBtbGAble    ),
    .BtbUpTaget       ( PreToBtbTargrt   ),
    .RasUpAble        ( PreTORasAble     ),
    .RasPtrType       ( PreToRasType     ),
    .RasAddrDate      ( PreToRasPc       ),
    .TageUpAble       ( PreTOTageAble    ),
    .PredAble         ( PredToFTQAble    ),
    .PredJdate        ( PredToFTQJdate   ),
    .PredNum          ( PredToFTQNum     ),
    .PredInt1         ( PredToFTQU1      ),
    .PredInt2         ( PredToFTQU2      ),
    .PredInt3         ( PredToFTQU3      ),
    .PredInt4         ( PredToFTQU4      ),
    .PredInt5         ( PredToFTQU5      ),
    .PredInt6         ( PredToFTQU6      ),
    .ToIbInst1Able    ( PredTo1ISAble    ),
    .ToIbInst1Mode    ( PredTo1ISMode    ),
    .ToIbInst1Pc      ( PredTo1ISPc      ),
    .ToIbInst1Redir   ( PredTo1ISRPc     ),
    .ToIbInst1Date    ( PredTo1ISInst    ),
    .ToIbInst2Able    ( PredTo2ISAble    ),
    .ToIbInst2Mode    ( PredTo2ISMode    ),
    .ToIbInst2Pc      ( PredTo2ISPc      ),
    .ToIbInst2Redir   ( PredTo2ISRPc     ),
    .ToIbInst2Date    ( PredTo2ISInst    ),
    .ToIbInst3Able    ( PredTo3ISAble    ),
    .ToIbInst3Mode    ( PredTo3ISMode    ),
    .ToIbInst3Pc      ( PredTo3ISPc      ),
    .ToIbInst3Redir   ( PredTo3ISRPc     ),
    .ToIbInst3Date    ( PredTo3ISInst    ),
    .ToIbInst4Able    ( PredTo4ISAble    ),
    .ToIbInst4Mode    ( PredTo4ISMode    ),
    .ToIbInst4Pc      ( PredTo4ISPc      ),
    .ToIbInst4Redir   ( PredTo4ISRPc     ),
    .ToIbInst4Date    ( PredTo4ISInst    ),
    .ToIbInst5Able    ( PredTo5ISAble    ),
    .ToIbInst5Mode    ( PredTo5ISMode    ),
    .ToIbInst5Pc      ( PredTo5ISPc      ),
    .ToIbInst5Redir   ( PredTo5ISRPc     ),
    .ToIbInst5Date    ( PredTo5ISInst    ),
    .ToIbInst6Able    ( PredTo6ISAble    ),
    .ToIbInst6Mode    ( PredTo6ISMode    ),
    .ToIbInst6Pc      ( PredTo6ISPc      ),
    .ToIbInst6Redir   ( PredTo6ISRPc     ),
    .ToIbInst6Date    ( PredTo6ISInst    ),
    .ToIbInst7Able    ( PredTo7ISAble    ),
    .ToIbInst7Mode    ( PredTo7ISMode    ),
    .ToIbInst7Pc      ( PredTo7ISPc      ),
    .ToIbInst7Redir   ( PredTo7ISRPc     ),
    .ToIbInst7Date    ( PredTo7ISInst    ),
    .ToIbInst8Able    ( PredTo8ISAble    ),
    .ToIbInst8Mode    ( PredTo8ISMode    ),
    .ToIbInst8Pc      ( PredTo8ISPc      ),
    .ToIbInst8Redir   ( PredTo8ISRPc     ),
    .ToIbInst8Date    ( PredTo8ISInst    )
    );

    ICache u_ICache(
    .Clk             ( Clk             ),
    .Rest            ( Rest            ),
    .IcFLash         ( CtrlToIcacFLash ),
    .IcStop          ( CtrlToIcacStop  ),
    .IcReq           ( CtrlIcReq       ),
    .BpReq           ( CtrlBpReq       ),
    .ToMuFetch       ( IcaToMmuAble    ),
    .ToMuVritualA    ( IcaToMmuVPc     ),
    .InCOperType     ( MmuToIcaType    ),
    .InCTlbTrap      ( MmuToIcaTrap    ),
    .InCPhysicalAddr ( MmuToIcaPPc     ),
    .BpuReqAble      ( PcOutAble       ),
    .BpuReqPc        ( PcOutPc         ),
    .ToPreAble       ( IcaToPreAble    ),
    .ToPcIvt         ( IcaToPrePcgrp   ),
    .ToInstIvt       ( IcaToPreInvt    ),
    .ToDate          ( IcaToPreIgrp    ),
    .OutReadAble     ( IcaToAXIAble    ),
    .Inshankhand     ( AXIToIcaSKH     ),
    .OutUncacheRead  ( UcaToAXIAble    ),
    .OutReadAddr     ( IcaToAXIAddr    ),
    .InReadreq       ( AXIToIcaReq     ),
    .InReadBackAble  ( AXIToIcaAble    ),
    .InReadBackDate  ( AXIToIcaDate    )
    );



    InstIssueQue#(
    .INSTQUEUEDEEP ( 32 ),
    .INSTQUEUEWIDE ( 97 )
    )u_InstIssueQue(
    .Clk           ( Clk           ),
    .Rest          ( Rest          ),
    .InstQStop     ( InstQStop     ),
    .InstQFlash    ( InstQFlash    ),
    .InstQReqStop  ( InstQReqStop  ),
    .FromPre1Able  ( PredTo1ISAble ),
    .FromPre1Addr  ( PredTo1ISPc   ),
    .FromPre1Date  ( PredTo1ISInst ),
    .FromPre1Part  ( PredTo1ISMode ),
    .FromPre1NAdr  ( PredTo1ISRPc  ),
    .FromPre2Able  ( PredTo2ISAble ),
    .FromPre2Addr  ( PredTo2ISPc   ),
    .FromPre2Date  ( PredTo2ISInst ),
    .FromPre2Part  ( PredTo2ISMode ),
    .FromPre2NAdr  ( PredTo2ISRPc  ),
    .FromPre3Able  ( PredTo3ISAble ),
    .FromPre3Addr  ( PredTo3ISPc   ),
    .FromPre3Date  ( PredTo3ISInst ),
    .FromPre3Part  ( PredTo3ISMode ),
    .FromPre3NAdr  ( PredTo3ISRPc  ),
    .FromPre4Able  ( PredTo4ISAble ),
    .FromPre4Addr  ( PredTo4ISPc   ),
    .FromPre4Date  ( PredTo4ISRPc  ),
    .FromPre4Part  ( PredTo4ISMode ),
    .FromPre4NAdr  ( PredTo4ISRPc  ),
    .FromPre5Able  ( PredTo5ISAble ),
    .FromPre5Addr  ( PredTo5ISPc   ),
    .FromPre5Date  ( PredTo5ISInst ),
    .FromPre5Part  ( PredTo5ISMode ),
    .FromPre5NAdr  ( PredTo5ISRPc  ),
    .FromPre6Able  ( PredTo6ISAble ),
    .FromPre6Addr  ( PredTo6ISPc   ),
    .FromPre6Date  ( PredTo6ISInst ),
    .FromPre6Part  ( PredTo6ISMode ),
    .FromPre6NAdr  ( PredTo6ISRPc  ),
    .FromPre7Able  ( PredTo7ISAble ),
    .FromPre7Addr  ( PredTo7ISPc   ),
    .FromPre7Date  ( PredTo7ISInst ),
    .FromPre7Part  ( PredTo7ISMode ),
    .FromPre7NAdr  ( PredTo7ISRPc  ),
    .FromPre8Able  ( PredTo8ISAble ),
    .FromPre8Addr  ( PredTo8ISPc   ),
    .FromPre8Date  ( PredTo8ISInst ),
    .FromPre8Part  ( PredTo8ISMode ),
    .FromPre8NAdr  ( PredTo8ISRPc  ),
    .OutInstPort1  ( ISToDcodePort1),
    .OutInstPort2  ( ISToDcodePort2),
    .OutInstPort3  ( ISToDcodePort3),
    .OutInstPort4  ( ISToDcodePort4),
    .OutInstAddr1  ( ISToDcodeAddr1),
    .OutInstDate1  ( ISToDcodeDate1),
    .OutInstPart1  ( ISToDcodePart1),
    .OutInstNAdr1  ( ISToDcodeRPc1 ),
    .OutInstAddr2  ( ISToDcodeAddr2),
    .OutInstDate2  ( ISToDcodeDate2),
    .OutInstPart2  ( ISToDcodePart2),
    .OutInstNAdr2  ( ISToDcodeRPc2 ),
    .OutInstAddr3  ( ISToDcodeAddr3),
    .OutInstDate3  ( ISToDcodeDate3),
    .OutInstPart3  ( ISToDcodePart3),
    .OutInstNAdr3  ( ISToDcodeRPc3 ),
    .OutInstAddr4  ( ISToDcodeAddr4),
    .OutInstDate4  ( ISToDcodeDate4),
    .OutInstPart4  ( ISToDcodePart4),
    .OutInstNAdr4  ( ISToDcodeRPc4 )
    );



    Decode u_Decode(
    .Clk           ( Clk           ),
    .Rest          ( Rest          ),
    .DecodeStopS   ( DecodeStopS   ),
    .DecodeFlashS  ( DecodeFlashS  ),
    .InInstPort1   ( ISToDcodePort1   ),
    .InInstPort2   ( ISToDcodePort2   ),
    .InInstPort3   ( ISToDcodePort3   ),
    .InInstPort4   ( ISToDcodePort4   ),
    .InInstAddr1   ( ISToDcodeAddr1   ),
    .InInstDate1   ( ISToDcodeDate1   ),
    .InInstPart1   ( ISToDcodePart1   ),
    .InInstNAdr1   ( ISToDcodeRPc1   ),
    .InInstAddr2   ( ISToDcodeAddr2   ),
    .InInstDate2   ( ISToDcodeDate2   ),
    .InInstPart2   ( ISToDcodePart2   ),
    .InInstNAdr2   ( ISToDcodePart2   ),
    .InInstAddr3   ( ISToDcodeAddr3   ),
    .InInstDate3   ( ISToDcodeDate3   ),
    .InInstPart3   ( ISToDcodePart3   ),
    .InInstNAdr3   ( ISToDcodeRPc3    ),
    .InInstAddr4   ( ISToDcodeAddr4   ),
    .InInstDate4   ( ISToDcodeDate4   ),
    .InInstPart4   ( ISToDcodePart4   ),
    .InInstNAdr4   ( ISToDcodeRPc4    ),
    .Inst1Addr     ( DcdToRnm1Pc      ),
    .Inst1Opcode   ( DcdToRnm1Opcode  ),
    .Inst1SinumA   ( DcdToRnm1ImAble  ),
    .Inst1SiDate   ( DcdToRnm1ImDate  ),
    .Inst1Sr1Abl   ( DcdToRnm1Sr1Able ),
    .Inst1Sr1Num   ( DcdToRnm1Sr1Num  ),
    .Inst1Sr2Abl   ( DcdToRnm1Sr2Able ),
    .Inst1Sr2Num   ( DcdToRnm1Sr2Num  ),
    .Insr1WriteA   ( DcdToRnm1WAble   ),
    .Inst1Part     ( DcdToRnm1Part    ),
    .Inst1Nadr     ( DcdToRnm1Naddr   ),
    .Inst1WriteN   ( DcdToRnm1Wnum    ),
    .Inst2Addr     ( DcdToRnm2Pc      ),
    .Inst2Opcode   ( DcdToRnm2Opcode  ),
    .Inst2SinumA   ( DcdToRnm2ImAble  ),
    .Inst2SiDate   ( DcdToRnm2ImDate  ),
    .Inst2Sr1Abl   ( DcdToRnm2Sr1Able ),
    .Inst2Sr1Num   ( DcdToRnm2Sr1Num  ),
    .Inst2Sr2Abl   ( DcdToRnm2Sr2Able ),
    .Inst2Sr2Num   ( DcdToRnm2Sr2Num  ),
    .Insr2WriteA   ( DcdToRnm2WAble   ),
    .Inst2WriteN   ( DcdToRnm2Wnum    ),
    .Inst2Part     ( DcdToRnm2Part    ),
    .Inst2Nadr     ( DcdToRnm2Naddr   ),
    .Inst3Addr     ( DcdToRnm3Pc      ),
    .Inst3Opcode   ( DcdToRnm3Opcode  ),
    .Inst3SinumA   ( DcdToRnm3ImAble  ),
    .Inst3SiDate   ( DcdToRnm3ImDate  ),
    .Inst3Sr1Abl   ( DcdToRnm3Sr1Able ),
    .Inst3Sr1Num   ( DcdToRnm3Sr1Num  ),
    .Inst3Sr2Abl   ( DcdToRnm3Sr2Able ),
    .Inst3Sr2Num   ( DcdToRnm3Sr2Num  ),
    .Insr3WriteA   ( DcdToRnm3WAble   ),
    .Inst3WriteN   ( DcdToRnm3Wnum    ),
    .Inst3Part     ( DcdToRnm3Part    ),
    .Inst3Nadr     ( DcdToRnm3Naddr   ),
    .Inst4Addr     ( DcdToRnm4Pc      ),
    .Inst4Opcode   ( DcdToRnm4Opcode  ),
    .Inst4SinumA   ( DcdToRnm4ImAble  ),
    .Inst4SiDate   ( DcdToRnm4ImDate  ),
    .Inst4Sr1Abl   ( DcdToRnm4Sr1Able ),
    .Inst4Sr1Num   ( DcdToRnm4Sr1Num  ),
    .Inst4Sr2Abl   ( DcdToRnm4Sr2Able ),
    .Inst4Sr2Num   ( DcdToRnm4Sr2Num  ),
    .Insr4WriteA   ( DcdToRnm4WAble   ),
    .Inst4WriteN   ( DcdToRnm4Wnum    ),
    .Inst4Part     ( DcdToRnm4Part    ),
    .Inst4Nadr     ( DcdToRnm4Naddr   )
    );

        FreeList u_FreeList(
    .Clk           ( Clk           ),
    .Rest          ( Rest          ),
    .FreelistStop  ( FreelistStop  ),
    .FreeListFlash ( FreeListFlash ),
    .FreeListReq   ( FreeListReq   ),
    .InWay1Rename  ( DcdToRnm1WAble),
    .InWay1RegNum  ( DcdToRnm1Wnum ),
    .InWay2Rename  ( DcdToRnm2WAble),
    .InWay2RegNum  ( DcdToRnm2Wnum ),
    .InWay3Rename  ( DcdToRnm3WAble),
    .InWay3RegNum  ( DcdToRnm3Wnum ),
    .InWay4Rename  ( DcdToRnm4WAble),
    .InWay4RegNum  ( DcdToRnm4Wnum ),
    .OutWay1Rename ( FLToRAT1Able  ),
    .OutWay1Areg   ( FLToRAT1Areg  ),
    .OutWay1RegNum ( FLToRAT1RReg  ),
    .OutWay2Rename ( FLToRAT2Able  ),
    .OutWay2Areg   ( FLToRAT2Areg  ),
    .OutWay2RegNum ( FLToRAT2RReg  ),
    .OutWay3Rename ( FLToRAT3Able  ),
    .OutWay3Areg   ( FLToRAT2Areg  ),
    .OutWay3RegNum ( FLToRAT3RReg  ),
    .OutWay4Rename ( FLToRAT4Able  ),
    .OutWay4Areg   ( FLToRAT4Areg  ),
    .OutWay4RegNum ( FLToRAT4RReg  ),
    .ReloadAble    ( RobToFLRload  ),
    .FreeAble1     ( RefToFLF1Able ),
    .FreeAddr1     ( RefToFLF1Addr ),
    .FreeAble2     ( RefToFLF2Able ),
    .FreeAddr2     ( RefToFLF2Addr ),
    .FreeAble3     ( RefToFLF3Able ),
    .FreeAddr3     ( RefToFLF3Addr ),
    .FreeAble4     ( RefToFLF4Able ),
    .FreeAddr4     ( RefToFLF4Addr )
    );

    RenameArchTable u_RenameArchTable(
    .Clk             ( Clk             ),
    .Rest            ( Rest            ),
    .RATStop         ( RATStop         ),
    .RATFlash        ( RATFlash        ),
    .Way1RdAble      ( FLToRAT1Able    ),
    .Way1ArchAddr    ( FLToRAT1Areg    ),
    .Way1RdAddr      ( FLToRAT1RReg    ),
    .Way2RdAble      ( FLToRAT2Able    ),
    .Way2ArchAddr    ( FLToRAT2Areg    ),
    .Way2RdAddr      ( FLToRAT2RReg    ),
    .Way3RdAble      ( FLToRAT3Able    ),
    .Way3ArchAddr    ( FLToRAT3Areg    ),
    .Way3RdAddr      ( FLToRAT3RReg    ),
    .Way4RdAble      ( FLToRAT4Able    ),
    .Way4ArchAddr    ( FLToRAT4Areg    ),
    .Way4RdAddr      ( FLToRAT4RReg    ),
    .Way1Src1Able    ( DcdToRnm1Sr1Able   ),
    .Way1Src1Addr    ( DcdToRnm1Sr1Num    ),
    .Way1Src2Able    ( DcdToRnm1Sr2Able   ),
    .Way1Src2Addr    ( DcdToRnm1Sr2Num    ),
    .Way2Src1Able    ( DcdToRnm2Sr1Able   ),
    .Way2Src1Addr    ( DcdToRnm2Sr1Num    ),
    .Way2Src2Able    ( DcdToRnm2Sr2Able   ),
    .Way2Src2Addr    ( DcdToRnm2Sr2Num    ),
    .Way3Src1Able    ( DcdToRnm3Sr1Able   ),
    .Way3Src1Addr    ( DcdToRnm3Sr1Num    ),
    .Way3Src2Able    ( DcdToRnm3Sr2Able   ),
    .Way3Src2Addr    ( DcdToRnm3Sr2Num    ),
    .Way4Src1Able    ( DcdToRnm4Sr1Able   ),
    .Way4Src1Addr    ( DcdToRnm4Sr1Num    ),
    .Way4Src2Able    ( DcdToRnm4Sr2Able   ),
    .Way4Src2Addr    ( DcdToRnm4Sr2Num    ),
    .Out1Src1Able    ( RATToBYT1Sr1Able   ),
    .Out1Src1NoDate  ( RATToBYT1Sr1ND     ),
    .Out1Src1Addr    ( RATToBYT1Sr1Num    ),
    .Out1Src2Able    ( RATToBYT1Sr2Able   ),
    .Out1Src2NoDate  ( RATToBYT1Sr2ND     ),
    .Out1Src2Addr    ( RATToBYT1Sr2Num    ),
    .Out1RdAble      ( RATToBYT1WAble     ),
    .Out1RdAddr      ( RATToBYT1WNum      ),
    .Out2Src1Able    ( RATToBYT2Sr1Able   ),
    .Out2Src1NoDate  ( RATToBYT2Sr1ND     ),
    .Out2Src1Addr    ( RATToBYT2Sr1Num    ),
    .Out2Src2Able    ( RATToBYT2Sr2Able   ),
    .Out2Src2NoDate  ( RATToBYT2Sr2ND     ),
    .Out2Src2Addr    ( RATToBYT2Sr2Num    ),
    .Out2RdAble      ( RATToBYT2WAble     ),
    .Out2RdAddr      ( RATToBYT2WNum      ),
    .Out3Src1Able    ( RATToBYT3Sr1Able   ),
    .Out3Src1NoDate  ( RATToBYT3Sr1ND     ),
    .Out3Src1Addr    ( RATToBYT3Sr1Num    ),
    .Out3Src2Able    ( RATToBYT3Sr2Able   ),
    .Out3Src2NoDate  ( RATToBYT3Sr2ND     ),
    .Out3Src2Addr    ( RATToBYT3Sr2Num    ),
    .Out3RdAble      ( RATToBYT3WAble     ),
    .Out3RdAddr      ( RATToBYT3WNum      ),
    .Out4Src1Able    ( RATToBYT4Sr1Able   ),
    .Out4Src1NoDate  ( RATToBYT4Sr1ND     ),
    .Out4Src1Addr    ( RATToBYT4Sr1Num    ),
    .Out4Src2Able    ( RATToBYT4Sr2Able   ),
    .Out4Src2NoDate  ( RATToBYT4Sr2ND     ),
    .Out4Src2Addr    ( RATToBYT4Sr2Num    ),
    .Out4RdAble      ( RATToBYT4WAble     ),
    .Out4RdAddr      ( RATToBYT4WNum      ),
    .Lock1Able       ( RATToRefLock1      ),
    .Lock1Addr       ( RATToRefLock1Addr  ),
    .Lock2Able       ( RATToRefLock2      ),
    .Lock2Addr       ( RATToRefLock2Addr  ),
    .Lock3Able       ( RATToRefLock3      ),
    .Lock3Addr       ( RATToRefLock3Addr  ),
    .Lock4Able       ( RATToRefLock4      ),
    .Lock4Addr       ( RATToRefLock4Addr  ),
    .Use1Able        ( RATToRefUse1       ),
    .Use1Addr        ( RATToRefUse1Addr   ),
    .Use2Able        ( RATToRefUse2       ),
    .Use2Addr        ( RATToRefUse2Addr   ),
    .Use3Able        ( RATToRefUse3       ),
    .Use3Addr        ( RATToRefUse3Addr   ),
    .Use4Able        ( RATToRefUse4       ),
    .Use4Addr        ( RATToRefUse4Addr   ),
    .Use5Able        ( RATToRefUse5       ),
    .Use5Addr        ( RATToRefUse5Addr   ),
    .Use6Able        ( RATToRefUse6       ),
    .Use6Addr        ( RATToRefUse6Addr   ),
    .Use7Able        ( RATToRefUse7       ),
    .Use7Addr        ( RATToRefUse7Addr   ),
    .Use8Able        ( RATToRefUse8       ),
    .Use8Addr        ( RATToRefUse8Addr   ),
    .Use9Able        ( RATToRefUse9       ),
    .Use9Addr        ( RATToRefUse9Addr   ),
    .Use10Able       ( RATToRefUse10      ),
    .Use10Addr       ( RATToRefUse10Addr  ),
    .Use11Able       ( RATToRefUse11      ),
    .Use11Addr       ( RATToRefUse11Addr  ),
    .Use12Able       ( RATToRefUse12      ),
    .Use12Addr       ( RATToRefUse12Addr  )
    );

    BusyTable u_BusyTable(
    .Clk             ( Clk             ),
    .Rest            ( Rest            ),
    .BusyStop        ( BusyStop        ),
    .BusyFlash       ( BusyFlash       ),
    .UnBusyAble1     ( UnBusyAble1     ),
    .UnBusyAddr1     ( UnBusyAddr1     ),
    .UnBusyAble2     ( UnBusyAble2     ),
    .UnBusyAddr2     ( UnBusyAddr2     ),
    .UnBusyAble3     ( UnBusyAble3     ),
    .UnBusyAddr3     ( UnBusyAddr3     ),
    .UnBusyAble4     ( UnBusyAble4     ),
    .UnBusyAddr4     ( UnBusyAddr4     ),
    .UnBusyAble5     ( UnBusyAble5     ),
    .UnBusyAddr5     ( UnBusyAddr5     ),
    .UnBusyAble6     ( UnBusyAble6     ),
    .UnBusyAddr6     ( UnBusyAddr6     ),
    .UnBusyAble7     ( UnBusyAble7     ),
    .UnBusyAddr7     ( UnBusyAddr7     ),
    .BIn1Src1Able    ( RATToBYT1Sr1Able),
    .BIn1Src1NoDate  ( RATToBYT1Sr1ND  ),
    .BIn1Src1Addr    ( RATToBYT1Sr1Num ),
    .BIn1Src2Able    ( RATToBYT1Sr2Able),
    .BIn1Src2NoDate  ( RATToBYT1Sr2ND  ),
    .BIn1Src2Addr    ( RATToBYT1Sr2Num ),
    .BIn1RdAble      ( RATToBYT1WAble  ),
    .BIn1RdAddr      ( RATToBYT1WNum   ),
    .BIn2Src1Able    ( RATToBYT2Sr1Able),
    .BIn2Src1NoDate  ( RATToBYT2Sr1ND  ),
    .BIn2Src1Addr    ( RATToBYT2Sr1Num ),
    .BIn2Src2Able    ( RATToBYT2Sr2Able),
    .BIn2Src2NoDate  ( RATToBYT2Sr2ND  ),
    .BIn2Src2Addr    ( RATToBYT2Sr2Num ),
    .BIn2RdAble      ( RATToBYT2WAble  ),
    .BIn2RdAddr      ( RATToBYT2WNum   ),
    .BIn3Src1Able    ( RATToBYT3Sr1Able),
    .BIn3Src1NoDate  ( RATToBYT3Sr1ND  ),
    .BIn3Src1Addr    ( RATToBYT3Sr1Num ),
    .BIn3Src2Able    ( RATToBYT3Sr2Able),
    .BIn3Src2NoDate  ( RATToBYT3Sr2ND  ),
    .BIn3Src2Addr    ( RATToBYT3Sr2Num ),
    .BIn3RdAble      ( RATToBYT3WAble  ),
    .BIn3RdAddr      ( RATToBYT3WNum   ),
    .BIn4Src1Able    ( RATToBYT4Sr1Able),
    .BIn4Src1NoDate  ( RATToBYT4Sr1ND  ),
    .BIn4Src1Addr    ( RATToBYT4Sr1Num ),
    .BIn4Src2Able    ( RATToBYT4Sr2Able),
    .BIn4Src2NoDate  ( RATToBYT4Sr2ND  ),
    .BIn4Src2Addr    ( RATToBYT4Sr2Num ),
    .BIn4RdAble      ( RATToBYT4WAble  ),
    .BIn4RdAddr      ( RATToBYT4WNum   ),
    .BOut1Src1Able   ( BYTToIQ1Sr1Able ),
    .Bout1Src1Ready  ( BYTToIQ1Sr1Ready),
    .BOut1Src1Addr   ( BYTToIQ1Sr1Num  ),
    .BOut1Src2Able   ( BYTToIQ1Sr2Able ),
    .Bout1Src2Ready  ( BYTToIQ1Sr2Ready),
    .BOut1Src2Addr   ( BYTToIQ1Sr2Num  ),
    .BOut1RdAble     ( BYTToIQ1WAble   ),
    .BOut1RdAddr     ( BYTToIQ1WNum    ),
    .BOut2Src1Able   ( BYTToIQ2Sr1Able ),
    .Bout2Src1Ready  ( BYTToIQ2Sr1Ready),
    .BOut2Src1Addr   ( BYTToIQ2Sr1Num  ),
    .BOut2Src2Able   ( BYTToIQ2Sr2Able ),
    .Bout2Src2Ready  ( BYTToIQ2Sr2Ready),
    .BOut2Src2Addr   ( BYTToIQ2Sr2Num  ),
    .BOut2RdAble     ( BYTToIQ2WAble   ),
    .BOut2RdAddr     ( BYTToIQ2WNum    ),
    .BOut3Src1Able   ( BYTToIQ3Sr1Able ),
    .Bout3Src1Ready  ( BYTToIQ3Sr1Ready),
    .BOut3Src1Addr   ( BYTToIQ3Sr1Num  ),
    .BOut3Src2Able   ( BYTToIQ3Sr2Able ),
    .Bout3Src2Ready  ( BYTToIQ3Sr2Ready),
    .BOut3Src2Addr   ( BYTToIQ3Sr2Num  ),
    .BOut3RdAble     ( BYTToIQ3WAble   ),
    .BOut3RdAddr     ( BYTToIQ3WNum    ),
    .BOut4Src1Able   ( BYTToIQ4Sr1Able ),
    .Bout4Src1Ready  ( BYTToIQ4Sr1Ready),
    .BOut4Src1Addr   ( BYTToIQ4Sr1Num  ),
    .BOut4Src2Able   ( BYTToIQ4Sr2Able ),
    .Bout4Src2Ready  ( BYTToIQ4Sr2Ready),
    .BOut4Src2Addr   ( BYTToIQ4Sr2Num  ),
    .BOut4RdAble     ( BYTToIQ4WAble   ),
    .BOut4RdAddr     ( BYTToIQ4WNum    )
    );

    RefTable u_RefTable(
    .Clk             ( Clk             ),
    .Rest            ( Rest            ),
    .RefTableStop    ( RefTableStop    ),
    .RefTableFLash   ( RefTableFLash   ),
    .Inst1Src1Able   ( Inst1Src1Able   ),
    .Inst1Src1Addr   ( Inst1Src1Addr   ),
    .Inst1Src2Able   ( Inst1Src2Able   ),
    .Inst1Src2Addr   ( Inst1Src2Addr   ),
    .Inst1RdAble     ( Inst1RdAble     ),
    .Inst1RdAddr     ( Inst1RdAddr     ),
    .Inst2Src1Able   ( Inst2Src1Able   ),
    .Inst2Src1Addr   ( Inst2Src1Addr   ),
    .Inst2Src2Able   ( Inst2Src2Able   ),
    .Inst2Src2Addr   ( Inst2Src2Addr   ),
    .Inst2RdAble     ( Inst2RdAble     ),
    .Inst2RdAddr     ( Inst2RdAddr     ),
    .Inst3Src1Able   ( Inst3Src1Able   ),
    .Inst3Src1Addr   ( Inst3Src1Addr   ),
    .Inst3Src2Able   ( Inst3Src2Able   ),
    .Inst3Src2Addr   ( Inst3Src2Addr   ),
    .Inst3RdAble     ( Inst3RdAble     ),
    .Inst3RdAddr     ( Inst3RdAddr     ),
    .Inst4Src1Able   ( Inst4Src1Able   ),
    .Inst4Src1Addr   ( Inst4Src1Addr   ),
    .Inst4Src2Able   ( Inst4Src2Able   ),
    .Inst4Src2Addr   ( Inst4Src2Addr   ),
    .Inst4RdAble     ( Inst4RdAble     ),
    .Inst4RdAddr     ( Inst4RdAddr     ),
    .Lock1Able       ( Lock1Able       ),
    .Lock1Addr       ( Lock1Addr       ),
    .Lock2Able       ( Lock2Able       ),
    .Lock2Addr       ( Lock2Addr       ),
    .Lock3Able       ( Lock3Able       ),
    .Lock3Addr       ( Lock3Addr       ),
    .Lock4Able       ( Lock4Able       ),
    .Lock4Addr       ( Lock4Addr       ),
    .Inst1Read1Able  ( Inst1Read1Able  ),
    .Inst1Read1Addr  ( Inst1Read1Addr  ),
    .Inst1Read2Able  ( Inst1Read2Able  ),
    .Inst1Read2Addr  ( Inst1Read2Addr  ),
    .Inst2Read1Able  ( Inst2Read1Able  ),
    .Inst2Read1Addr  ( Inst2Read1Addr  ),
    .Inst2Read2Able  ( Inst2Read2Able  ),
    .Inst2Read2Addr  ( Inst2Read2Addr  ),
    .Inst3Read1Able  ( Inst3Read1Able  ),
    .Inst3Read1Addr  ( Inst3Read1Addr  ),
    .Inst3Read2Able  ( Inst3Read2Able  ),
    .Inst3Read2Addr  ( Inst3Read2Addr  ),
    .Inst4Read1Able  ( Inst4Read1Able  ),
    .Inst4Read1Addr  ( Inst4Read1Addr  ),
    .Inst4Read2Able  ( Inst4Read2Able  ),
    .Inst4Read2Addr  ( Inst4Read2Addr  ),
    .WritBack1Able   ( WritBack1Able   ),
    .WritBack1Addr   ( WritBack1Addr   ),
    .WritBack2Able   ( WritBack2Able   ),
    .WritBack2Addr   ( WritBack2Addr   ),
    .WritBack3Able   ( WritBack3Able   ),
    .WritBack3Addr   ( WritBack3Addr   ),
    .WritBack4Able   ( WritBack4Able   ),
    .WritBack4Addr   ( WritBack4Addr   ),
    .WritBack5Able   ( WritBack5Able   ),
    .WritBack5Addr   ( WritBack5Addr   ),
    .WritBack6Able   ( WritBack6Able   ),
    .WritBack6Addr   ( WritBack6Addr   ),
    .WritBack7Able   ( WritBack7Able   ),
    .WritBack7Addr   ( WritBack7Addr   ),
    .WritBack8Able   ( WritBack8Able   ),
    .WritBack8Addr   ( WritBack8Addr   ),
    .WriteNum1       ( WriteNum1       ),
    .WriteAble1      ( WriteAble1      ),
    .WriteNum2       ( WriteNum2       ),
    .WriteAble2      ( WriteAble2      ),
    .WriteNum3       ( WriteNum3       ),
    .WriteAble3      ( WriteAble3      ),
    .WriteNum4       ( WriteNum4       ),
    .WriteAble4      ( WriteAble4      )
    );


    IssueQueueBrCsr u_IssueQueueBrCsr(
        .Clk               ( Clk               ),
        .Rest              ( Rest              ),
        .BrCsrStop         ( BrCsrStop         ),
        .BrCsrFlash        ( BrCsrFlash        ),
        .BrCsrReq          ( BrCsrReq          ),
        .BIn1Src1Able      ( BIn1Src1Able      ),
        .BIn1Src1Ready     ( BIn1Src1Ready     ),
        .BIn1Src1Addr      ( BIn1Src1Addr      ),
        .BIn1Src2Able      ( BIn1Src2Able      ),
        .BIn1Src2Ready     ( BIn1Src2Ready     ),
        .BIn1Src2Addr      ( BIn1Src2Addr      ),
        .BIn1RdAble        ( BIn1RdAble        ),
        .BIn1RdAddr        ( BIn1RdAddr        ),
        .BIn2Src1Able      ( BIn2Src1Able      ),
        .BIn2Src1Ready     ( BIn2Src1Ready     ),
        .BIn2Src1Addr      ( BIn2Src1Addr      ),
        .BIn2Src2Able      ( BIn2Src2Able      ),
        .BIn2Src2Ready     ( BIn2Src2Ready     ),
        .BIn2Src2Addr      ( BIn2Src2Addr      ),
        .BIn2RdAble        ( BIn2RdAble        ),
        .BIn2RdAddr        ( BIn2RdAddr        ),
        .BIn3Src1Able      ( BIn3Src1Able      ),
        .BIn3Src1Ready     ( BIn3Src1Ready     ),
        .BIn3Src1Addr      ( BIn3Src1Addr      ),
        .BIn3Src2Able      ( BIn3Src2Able      ),
        .BIn3Src2Ready     ( BIn3Src2Ready     ),
        .BIn3Src2Addr      ( BIn3Src2Addr      ),
        .BIn3RdAble        ( BIn3RdAble        ),
        .BIn3RdAddr        ( BIn3RdAddr        ),
        .BIn4Src1Able      ( BIn4Src1Able      ),
        .BIn4Src1Ready     ( BIn4Src1Ready     ),
        .BIn4Src1Addr      ( BIn4Src1Addr      ),
        .BIn4Src2Able      ( BIn4Src2Able      ),
        .BIn4Src2Ready     ( BIn4Src2Ready     ),
        .BIn4Src2Addr      ( BIn4Src2Addr      ),
        .BIn4RdAble        ( BIn4RdAble        ),
        .BIn4RdAddr        ( BIn4RdAddr        ),
        .BIn1aAble         ( BIn1aAble         ),
        .BIn1MicOpcode     ( BIn1MicOpcode     ),
        .BIn1ImmAble       ( BIn1ImmAble       ),
        .BIn1ImmDate       ( BIn1ImmDate       ),
        .BIn1Mode          ( BIn1Mode          ),
        .BIn1ReDirAddr     ( BIn1ReDirAddr     ),
        .BIn1RobPtr        ( BIn1RobPtr        ),
        .BIn2aAble         ( BIn2aAble         ),
        .BIn2MicOpcode     ( BIn2MicOpcode     ),
        .BIn2ImmAble       ( BIn2ImmAble       ),
        .BIn2ImmDate       ( BIn2ImmDate       ),
        .BIn2Mode          ( BIn2Mode          ),
        .BIn2ReDirAddr     ( BIn2ReDirAddr     ),
        .BIn2RobPtr        ( BIn2RobPtr        ),
        .BIn3aAble         ( BIn3aAble         ),
        .BIn3MicOpcode     ( BIn3MicOpcode     ),
        .BIn3ImmAble       ( BIn3ImmAble       ),
        .BIn3ImmDate       ( BIn3ImmDate       ),
        .BIn3Mode          ( BIn3Mode          ),
        .BIn3ReDirAddr     ( BIn3ReDirAddr     ),
        .BIn3RobPtr        ( BIn3RobPtr        ),
        .BIn4aAble         ( BIn4aAble         ),
        .BIn4MicOpcode     ( BIn4MicOpcode     ),
        .BIn4ImmAble       ( BIn4ImmAble       ),
        .BIn4ImmDate       ( BIn4ImmDate       ),
        .BIn4Mode          ( BIn4Mode          ),
        .BIn4ReDirAddr     ( BIn4ReDirAddr     ),
        .BIn4RobPtr        ( BIn4RobPtr        ),
        .CsrReq            ( CsrReq            ),
        .BrReq             ( BrReq             ),
        .FromIsQAlu1       ( FromIsQAlu1       ),
        .FromAlu1Addr      ( FromAlu1Addr      ),
        .FromIsQAlu2       ( FromIsQAlu2       ),
        .FromAlu2Addr      ( FromAlu2Addr      ),
        .FromIsQMul        ( FromIsQMul        ),
        .FromMulAddr       ( FromMulAddr       ),
        .ByPassBDiv        ( ByPassBDiv        ),
        .ByPassBDivAddr    ( ByPassBDivAddr    ),
        .BypassBSC         ( BypassBSC         ),
        .BypassBSCAddr     ( BypassBSCAddr     ),
        .ByPassBLoad       ( ByPassBLoad       ),
        .ByPassBLoadAddr   ( ByPassBLoadAddr   ),
        .OutCsrAble        ( OutCsrAble        ),
        .OutCsrAddr        ( OutCsrAddr        ),
        .OutBruAble        ( OutBruAble        ),
        .OutBruAddr        ( OutBruAddr        ),
        .BInst1MicOperate  ( BInst1MicOperate  ),
        .BInst1Src1RAble   ( BInst1Src1RAble   ),
        .BInst1Src1RAddr   ( BInst1Src1RAddr   ),
        .BInst1Src2RAble   ( BInst1Src2RAble   ),
        .BInst1Src2RAddr   ( BInst1Src2RAddr   ),
        .BInst1ImmAble     ( BInst1ImmAble     ),
        .BInst1ImmDate     ( BInst1ImmDate     ),
        .BInst1RdAble      ( BInst1RdAble      ),
        .BInst1RdAddr      ( BInst1RdAddr      ),
        .BInst1Mode        ( BInst1Mode        ),
        .BInst1RedieAddr   ( BInst1RedieAddr   ),
        .BInst1RoBptr      ( BInst1RoBptr      ),
        .BInst2MicOperate  ( BInst2MicOperate  ),
        .BInst2Src1RAble   ( BInst2Src1RAble   ),
        .BInst2Src1RAddr   ( BInst2Src1RAddr   ),
        .BInst2Src2RAble   ( BInst2Src2RAble   ),
        .BInst2Src2RAddr   ( BInst2Src2RAddr   ),
        .BInst2ImmAble     ( BInst2ImmAble     ),
        .BInst2ImmDate     ( BInst2ImmDate     ),
        .BInst2RdAble      ( BInst2RdAble      ),
        .BInst2RdAddr      ( BInst2RdAddr      ),
        .BInst2RoBptr      ( BInst2RoBptr      )
    );

    IssueQueueInt u_IssueQueueInt(
        .Clk              ( Clk              ),
        .Rest             ( Rest             ),
        .IsQuIntStop      ( IsQuIntStop      ),
        .IsQuIntFlash     ( IsQuIntFlash     ),
        .IsQuIntReq       ( IsQuIntReq       ),
        .In1Src1Able      ( In1Src1Able      ),
        .In1Src1Ready     ( In1Src1Ready     ),
        .In1Src1Addr      ( In1Src1Addr      ),
        .In1Src2Able      ( In1Src2Able      ),
        .In1Src2Ready     ( In1Src2Ready     ),
        .In1Src2Addr      ( In1Src2Addr      ),
        .In1RdAble        ( In1RdAble        ),
        .In1RdAddr        ( In1RdAddr        ),
        .In2Src1Able      ( In2Src1Able      ),
        .In2Src1Ready     ( In2Src1Ready     ),
        .In2Src1Addr      ( In2Src1Addr      ),
        .In2Src2Able      ( In2Src2Able      ),
        .In2Src2Ready     ( In2Src2Ready     ),
        .In2Src2Addr      ( In2Src2Addr      ),
        .In2RdAble        ( In2RdAble        ),
        .In2RdAddr        ( In2RdAddr        ),
        .In3Src1Able      ( In3Src1Able      ),
        .In3Src1Ready     ( In3Src1Ready     ),
        .In3Src1Addr      ( In3Src1Addr      ),
        .In3Src2Able      ( In3Src2Able      ),
        .In3Src2Ready     ( In3Src2Ready     ),
        .In3Src2Addr      ( In3Src2Addr      ),
        .In3RdAble        ( In3RdAble        ),
        .In3RdAddr        ( In3RdAddr        ),
        .In4Src1Able      ( In4Src1Able      ),
        .In4Src1Ready     ( In4Src1Ready     ),
        .In4Src1Addr      ( In4Src1Addr      ),
        .In4Src2Able      ( In4Src2Able      ),
        .In4Src2Ready     ( In4Src2Ready     ),
        .In4Src2Addr      ( In4Src2Addr      ),
        .In4RdAble        ( In4RdAble        ),
        .In4RdAddr        ( In4RdAddr        ),
        .In1aAble         ( In1aAble         ),
        .In1MicOpcode     ( In1MicOpcode     ),
        .In1ImmAble       ( In1ImmAble       ),
        .In1ImmDate       ( In1ImmDate       ),
        .In1RobPtr        ( In1RobPtr        ),
        .In2aAble         ( In2aAble         ),
        .In2MicOpcode     ( In2MicOpcode     ),
        .In2ImmAble       ( In2ImmAble       ),
        .In2ImmDate       ( In2ImmDate       ),
        .In2RobPtr        ( In2RobPtr        ),
        .In3aAble         ( In3aAble         ),
        .In3MicOpcode     ( In3MicOpcode     ),
        .In3ImmAble       ( In3ImmAble       ),
        .In3ImmDate       ( In3ImmDate       ),
        .In3RobPtr        ( In3RobPtr        ),
        .In4aAble         ( In4aAble         ),
        .In4MicOpcode     ( In4MicOpcode     ),
        .In4ImmAble       ( In4ImmAble       ),
        .In4ImmDate       ( In4ImmDate       ),
        .In4RobPtr        ( In4RobPtr        ),
        .FromIsQBr        ( FromIsQBr        ),
        .FromBrAddr       ( FromBrAddr       ),
        .FromIsQCsr       ( FromIsQCsr       ),
        .FromCsrAddr      ( FromCsrAddr      ),
        .ByPassDiv        ( ByPassDiv        ),
        .ByPassDivAddr    ( ByPassDivAddr    ),
        .BypassSC         ( BypassSC         ),
        .BypassSCAddr     ( BypassSCAddr     ),
        .ByPassLoad       ( ByPassLoad       ),
        .ByPassLoadAddr   ( ByPassLoadAddr   ),
        .Alu1Req          ( Alu1Req          ),
        .Alu2Req          ( Alu2Req          ),
        .MulReq           ( MulReq           ),
        .DivReq           ( DivReq           ),
        .Alu1Inst         ( Alu1Inst         ),
        .Alu1InstAddr     ( Alu1InstAddr     ),
        .Alu2Inst         ( Alu2Inst         ),
        .ALu2InstAddr     ( ALu2InstAddr     ),
        .MulInst          ( MulInst          ),
        .MulInstAddr      ( MulInstAddr      ),
        .Inst1MicOperate  ( Inst1MicOperate  ),
        .Inst1Src1RAble   ( Inst1Src1RAble   ),
        .Inst1Src1RAddr   ( Inst1Src1RAddr   ),
        .Inst1Src2RAble   ( Inst1Src2RAble   ),
        .Inst1Src2RAddr   ( Inst1Src2RAddr   ),
        .Inst1ImmAble     ( Inst1ImmAble     ),
        .Inst1ImmDate     ( Inst1ImmDate     ),
        .Inst1RdAble      ( Inst1RdAble      ),
        .Inst1RdAddr      ( Inst1RdAddr      ),
        .Inst1RoBptr      ( Inst1RoBptr      ),
        .Inst2MicOperate  ( Inst2MicOperate  ),
        .Inst2Src1RAble   ( Inst2Src1RAble   ),
        .Inst2Src1RAddr   ( Inst2Src1RAddr   ),
        .Inst2Src2RAble   ( Inst2Src2RAble   ),
        .Inst2Src2RAddr   ( Inst2Src2RAddr   ),
        .Inst2ImmAble     ( Inst2ImmAble     ),
        .Inst2ImmDate     ( Inst2ImmDate     ),
        .Inst2RdAble      ( Inst2RdAble      ),
        .Inst2RdAddr      ( Inst2RdAddr      ),
        .Inst2RoBptr      ( Inst2RoBptr      ),
        .Inst3MicOperate  ( Inst3MicOperate  ),
        .Inst3Src1RAble   ( Inst3Src1RAble   ),
        .Inst3Src1RAddr   ( Inst3Src1RAddr   ),
        .Inst3Src2RAble   ( Inst3Src2RAble   ),
        .Inst3Src2RAddr   ( Inst3Src2RAddr   ),
        .Inst3ImmAble     ( Inst3ImmAble     ),
        .Inst3ImmDate     ( Inst3ImmDate     ),
        .Inst3RdAble      ( Inst3RdAble      ),
        .Inst3RdAddr      ( Inst3RdAddr      ),
        .Inst3RoBptr      ( Inst3RoBptr      ),
        .Inst4MicOperate  ( Inst4MicOperate  ),
        .Inst4Src1RAble   ( Inst4Src1RAble   ),
        .Inst4Src1RAddr   ( Inst4Src1RAddr   ),
        .Inst4Src2RAble   ( Inst4Src2RAble   ),
        .Inst4Src2RAddr   ( Inst4Src2RAddr   ),
        .Inst4ImmAble     ( Inst4ImmAble     ),
        .Inst4ImmDate     ( Inst4ImmDate     ),
        .Inst4RdAble      ( Inst4RdAble      ),
        .Inst4RdAddr      ( Inst4RdAddr      ),
        .Inst4RoBptr      ( Inst4RoBptr      )
    );

    IssueQueueMem u_IssueQueueMem(
        .Clk               ( Clk               ),
        .Rest              ( Rest              ),
        .MemQStop          ( MemQStop          ),
        .MemQFlash         ( MemQFlash         ),
        .MemReq            ( MemReq            ),
        .MIn1Src1Able      ( MIn1Src1Able      ),
        .MIn1Src1Ready     ( MIn1Src1Ready     ),
        .MIn1Src1Addr      ( MIn1Src1Addr      ),
        .MIn1Src2Able      ( MIn1Src2Able      ),
        .MIn1Src2Ready     ( MIn1Src2Ready     ),
        .MIn1Src2Addr      ( MIn1Src2Addr      ),
        .MIn1RdAble        ( MIn1RdAble        ),
        .MIn1RdAddr        ( MIn1RdAddr        ),
        .MIn2Src1Able      ( MIn2Src1Able      ),
        .MIn2Src1Ready     ( MIn2Src1Ready     ),
        .MIn2Src1Addr      ( MIn2Src1Addr      ),
        .MIn2Src2Able      ( MIn2Src2Able      ),
        .MIn2Src2Ready     ( MIn2Src2Ready     ),
        .MIn2Src2Addr      ( MIn2Src2Addr      ),
        .MIn2RdAble        ( MIn2RdAble        ),
        .MIn2RdAddr        ( MIn2RdAddr        ),
        .MIn3Src1Able      ( MIn3Src1Able      ),
        .MIn3Src1Ready     ( MIn3Src1Ready     ),
        .MIn3Src1Addr      ( MIn3Src1Addr      ),
        .MIn3Src2Able      ( MIn3Src2Able      ),
        .MIn3Src2Ready     ( MIn3Src2Ready     ),
        .MIn3Src2Addr      ( MIn3Src2Addr      ),
        .MIn3RdAble        ( MIn3RdAble        ),
        .MIn3RdAddr        ( MIn3RdAddr        ),
        .MIn4Src1Able      ( MIn4Src1Able      ),
        .MIn4Src1Ready     ( MIn4Src1Ready     ),
        .MIn4Src1Addr      ( MIn4Src1Addr      ),
        .MIn4Src2Able      ( MIn4Src2Able      ),
        .MIn4Src2Ready     ( MIn4Src2Ready     ),
        .MIn4Src2Addr      ( MIn4Src2Addr      ),
        .MIn4RdAble        ( MIn4RdAble        ),
        .MIn4RdAddr        ( MIn4RdAddr        ),
        .MIn1aAble         ( MIn1aAble         ),
        .MIn1MicOpcode     ( MIn1MicOpcode     ),
        .MIn1ImmAble       ( MIn1ImmAble       ),
        .MIn1ImmDate       ( MIn1ImmDate       ),
        .MIn1RobPtr        ( MIn1RobPtr        ),
        .MIn2aAble         ( MIn2aAble         ),
        .MIn2MicOpcode     ( MIn2MicOpcode     ),
        .MIn2ImmAble       ( MIn2ImmAble       ),
        .MIn2ImmDate       ( MIn2ImmDate       ),
        .MIn2RobPtr        ( MIn2RobPtr        ),
        .MIn3aAble         ( MIn3aAble         ),
        .MIn3MicOpcode     ( MIn3MicOpcode     ),
        .MIn3ImmAble       ( MIn3ImmAble       ),
        .MIn3ImmDate       ( MIn3ImmDate       ),
        .MIn3RobPtr        ( MIn3RobPtr        ),
        .MIn4aAble         ( MIn4aAble         ),
        .MIn4MicOpcode     ( MIn4MicOpcode     ),
        .MIn4ImmAble       ( MIn4ImmAble       ),
        .MIn4ImmDate       ( MIn4ImmDate       ),
        .MIn4RobPtr        ( MIn4RobPtr        ),
        .LoadReq           ( LoadReq           ),
        .StoreReq          ( StoreReq          ),
        .FromBCQBru        ( FromBCQBru        ),
        .FromBruAddr       ( FromBruAddr       ),
        .FromBCQCsr        ( FromBCQCsr        ),
        .FromCsrAddr       ( FromCsrAddr       ),
        .FromIsQAlu1       ( FromIsQAlu1       ),
        .FromAlu1Addr      ( FromAlu1Addr      ),
        .FromIsQAlu2       ( FromIsQAlu2       ),
        .FromAlu2Addr      ( FromAlu2Addr      ),
        .FromIsQMul        ( FromIsQMul        ),
        .FromMulAddr       ( FromMulAddr       ),
        .ByPassMDiv        ( ByPassMDiv        ),
        .ByPassMDivAddr    ( ByPassMDivAddr    ),
        .ByPassMLoad       ( ByPassMLoad       ),
        .ByPassMLoadAddr   ( ByPassMLoadAddr   ),
        .ByPassMSC         ( ByPassMSC         ),
        .ByPassMSCAddr     ( ByPassMSCAddr     ),
        .MInst1MicOperate  ( MInst1MicOperate  ),
        .MInst1Src1RAble   ( MInst1Src1RAble   ),
        .MInst1Src1RAddr   ( MInst1Src1RAddr   ),
        .MInst1Src2RAble   ( MInst1Src2RAble   ),
        .MInst1Src2RAddr   ( MInst1Src2RAddr   ),
        .MInst1ImmAble     ( MInst1ImmAble     ),
        .MInst1ImmDate     ( MInst1ImmDate     ),
        .MInst1RdAble      ( MInst1RdAble      ),
        .MInst1RdAddr      ( MInst1RdAddr      ),
        .MInst1RoBptr      ( MInst1RoBptr      ),
        .MInst2MicOperate  ( MInst2MicOperate  ),
        .MInst2Src1RAble   ( MInst2Src1RAble   ),
        .MInst2Src1RAddr   ( MInst2Src1RAddr   ),
        .MInst2Src2RAble   ( MInst2Src2RAble   ),
        .MInst2Src2RAddr   ( MInst2Src2RAddr   ),
        .MInst2ImmAble     ( MInst2ImmAble     ),
        .MInst2ImmDate     ( MInst2ImmDate     ),
        .MInst2RdAble      ( MInst2RdAble      ),
        .MInst2RdAddr      ( MInst2RdAddr      ),
        .MInst2RoBptr      ( MInst2RoBptr      )
    );

    PhysicalRegFile u_PhysicalRegFile(
        .Clk                ( Clk                ),
        .Rest               ( Rest               ),
        .PhysicalStop       ( PhysicalStop       ),
        .ReloadPhy          ( ReloadPhy          ),
        .Are1MapPregNum     ( Are1MapPregNum     ),
        .Are2MapPregNum     ( Are2MapPregNum     ),
        .Are3MapPregNum     ( Are3MapPregNum     ),
        .Are4MapPregNum     ( Are4MapPregNum     ),
        .Are5MapPregNum     ( Are5MapPregNum     ),
        .Are6MapPregNum     ( Are6MapPregNum     ),
        .Are7MapPregNum     ( Are7MapPregNum     ),
        .Are8MapPregNum     ( Are8MapPregNum     ),
        .Are9MapPregNum     ( Are9MapPregNum     ),
        .Are10MapPregNum    ( Are10MapPregNum    ),
        .Are11MapPregNum    ( Are11MapPregNum    ),
        .Are12MapPregNum    ( Are12MapPregNum    ),
        .Are13MapPregNum    ( Are13MapPregNum    ),
        .Are14MapPregNum    ( Are14MapPregNum    ),
        .Are15MapPregNum    ( Are15MapPregNum    ),
        .Are16MapPregNum    ( Are16MapPregNum    ),
        .Are17MapPregNum    ( Are17MapPregNum    ),
        .Are18MapPregNum    ( Are18MapPregNum    ),
        .Are19MapPregNum    ( Are19MapPregNum    ),
        .Are20MapPregNum    ( Are20MapPregNum    ),
        .Are21MapPregNum    ( Are21MapPregNum    ),
        .Are22MapPregNum    ( Are22MapPregNum    ),
        .Are23MapPregNum    ( Are23MapPregNum    ),
        .Are24MapPregNum    ( Are24MapPregNum    ),
        .Are25MapPregNum    ( Are25MapPregNum    ),
        .Are26MapPregNum    ( Are26MapPregNum    ),
        .Are27MapPregNum    ( Are27MapPregNum    ),
        .Are28MapPregNum    ( Are28MapPregNum    ),
        .Are29MapPregNum    ( Are29MapPregNum    ),
        .Are30MapPregNum    ( Are30MapPregNum    ),
        .Are31MapPregNum    ( Are31MapPregNum    ),
        .Are32MapPregNum    ( Are32MapPregNum    ),
        .WriteBackAlu1      ( WriteBackAlu1      ),
        .WriteBackAlu1Addr  ( WriteBackAlu1Addr  ),
        .WriteBackAlu1Date  ( WriteBackAlu1Date  ),
        .WriteBackAlu2      ( WriteBackAlu2      ),
        .WriteBackAlu2Addr  ( WriteBackAlu2Addr  ),
        .WriteBackAlu2Date  ( WriteBackAlu2Date  ),
        .WriteBackDiv       ( WriteBackDiv       ),
        .WriteBackDivAddr   ( WriteBackDivAddr   ),
        .WriteBackDivDate   ( WriteBackDivDate   ),
        .WriteBackMul       ( WriteBackMul       ),
        .WriteBackMulAddr   ( WriteBackMulAddr   ),
        .WriteBackMulDate   ( WriteBackMulDate   ),
        .WriteBackCsru      ( WriteBackCsru      ),
        .WriteBackCsruAddr  ( WriteBackCsruAddr  ),
        .WriteBackCsruDate  ( WriteBackCsruDate  ),
        .WriteBackBru       ( WriteBackBru       ),
        .WriteBackBruAddr   ( WriteBackBruAddr   ),
        .WriteBackBruDate   ( WriteBackBruDate   ),
        .WriteBackLsu       ( WriteBackLsu       ),
        .WriteBackLsuAddr   ( WriteBackLsuAddr   ),
        .WriteBackLsuDate   ( WriteBackLsuDate   ),
        .WriteBackROB       ( WriteBackROB       ),
        .WriteBackROBAddr   ( WriteBackROBAddr   ),
        .WriteBackROBDate   ( WriteBackROBDate   ),
        .Read11Able         ( Read11Able         ),
        .Read11Addr         ( Read11Addr         ),
        .Read11Date         ( Read11Date         ),
        .Read12Able         ( Read12Able         ),
        .Read12Addr         ( Read12Addr         ),
        .Read12Date         ( Read12Date         ),
        .Read21Able         ( Read21Able         ),
        .Read21Addr         ( Read21Addr         ),
        .Read21Date         ( Read21Date         ),
        .Read22Able         ( Read22Able         ),
        .Read22Addr         ( Read22Addr         ),
        .Read22Date         ( Read22Date         ),
        .Read31Able         ( Read31Able         ),
        .Read31Addr         ( Read31Addr         ),
        .Read31Date         ( Read31Date         ),
        .Read32Able         ( Read32Able         ),
        .Read32Addr         ( Read32Addr         ),
        .Read32Date         ( Read32Date         ),
        .Read41Able         ( Read41Able         ),
        .Read41Addr         ( Read41Addr         ),
        .Read41Date         ( Read41Date         ),
        .Read42Able         ( Read42Able         ),
        .Read42Addr         ( Read42Addr         ),
        .Read42Date         ( Read42Date         )
    );

    Mmu u_Mmu(
        .Clk              ( Clk              ),
        .Rest             ( Rest             ),
        .Asid             ( Asid             ),
        .CsrDmw0Date      ( CsrDmw0Date      ),
        .CsrDmw1Date      ( CsrDmw1Date      ),
        .CsrCrmdDate      ( CsrCrmdDate      ),
        .CsrReadTlbAddr   ( CsrReadTlbAddr   ),
        .CsrReadTlbDate   ( CsrReadTlbDate   ),
        .CsrSerchTlbAble  ( CsrSerchTlbAble  ),
        .CsrSerchInfrom   ( CsrSerchInfrom   ),
        .CsrSerchAble     ( CsrSerchAble     ),
        .CsrSerchIdxDate  ( CsrSerchIdxDate  ),
        .CsrWriteTlbAble  ( CsrWriteTlbAble  ),
        .CsrWriteTlbAddr  ( CsrWriteTlbAddr  ),
        .CsrWriteTlbDate  ( CsrWriteTlbDate  ),
        .CsrInvEn         ( CsrInvEn         ),
        .CsrInvOp         ( CsrInvOp         ),
        .CsrInvAsid       ( CsrInvAsid       ),
        .CsrInvVppn       ( CsrInvVppn       ),
        .InstFetch        ( InstFetch        ),
        .InstVritualA     ( InstVritualA     ),
        .InstOperType     ( InstOperType     ),
        .InstTlbTrap      ( InstTlbTrap      ),
        .InstTlbTrapType  ( InstTlbTrapType  ),
        .InstPhysicalAddr ( InstPhysicalAddr ),
        .MemAccess        ( MemAccess        ),
        .LoadOrStore      ( LoadOrStore      ),
        .MemVritualA      ( MemVritualA      ),
        .MemOperType      ( MemOperType      ),
        .MemTlbTrap       ( MemTlbTrap       ),
        .MemTlbTrapType   ( MemTlbTrapType   ),
        .MemPhysicalAddr  ( MemPhysicalAddr  ),
        .MmuFlash         ( MmuFlash         )
    );

    Alu u_Alu(
        .Clk            ( Clk            ),
        .Rest           ( Rest           ),
        .AluStop        ( AluStop        ),
        .AluFlash       ( AluFlash       ),
        .AluInstPc      ( AluInstPc      ),
        .AluMicOperate  ( AluMicOperate  ),
        .AluSrc1Able    ( AluSrc1Able    ),
        .AluSrc1Addr    ( AluSrc1Addr    ),
        .AluSrc1Date    ( AluSrc1Date    ),
        .AluSrc2Able    ( AluSrc2Able    ),
        .AluSrc2Addr    ( AluSrc2Addr    ),
        .AluSrc2Date    ( AluSrc2Date    ),
        .AluImmDate     ( AluImmDate     ),
        .AluRdAble      ( AluRdAble      ),
        .AluRdAddr      ( AluRdAddr      ),
        .AluROBPtr      ( AluROBPtr      ),
        .AluSelfAble    ( AluSelfAble    ),
        .AluSelfAddr    ( AluSelfAddr    ),
        .AluSelfDate    ( AluSelfDate    ),
        .AluBruAble     ( AluBruAble     ),
        .AluBruAddr     ( AluBruAddr     ),
        .AluBruDate     ( AluBruDate     ),
        .AluAlu2Able    ( AluAlu2Able    ),
        .AluAlu2Addr    ( AluAlu2Addr    ),
        .AluAlu2Date    ( AluAlu2Date    ),
        .AluMulAble     ( AluMulAble     ),
        .AluMulAddr     ( AluMulAddr     ),
        .AluMulDate     ( AluMulDate     ),
        .AluCsrAble     ( AluCsrAble     ),
        .AluCsrAddr     ( AluCsrAddr     ),
        .AluCsrDate     ( AluCsrDate     ),
        .AluReq         ( AluReq         ),
        .AluWBAble      ( AluWBAble      ),
        .AluWBAddr      ( AluWBAddr      ),
        .AluWBDate      ( AluWBDate      ),
        .AluCommitAble  ( AluCommitAble  ),
        .AluCommitPtr   ( AluCommitPtr   ),
        .AluCommitType  ( AluCommitType  )
    );

    Bru u_Bru(
        .Clk             ( Clk             ),
        .Rest            ( Rest            ),
        .BruStop         ( BruStop         ),
        .BruFlash        ( BruFlash        ),
        .BruInstPc       ( BruInstPc       ),
        .BruMicOperate   ( BruMicOperate   ),
        .BruSrc1Able     ( BruSrc1Able     ),
        .BruSrc1Addr     ( BruSrc1Addr     ),
        .BruSrc1Date     ( BruSrc1Date     ),
        .BruSrc2Able     ( BruSrc2Able     ),
        .BruSrc2Addr     ( BruSrc2Addr     ),
        .BruSrc2Date     ( BruSrc2Date     ),
        .BruImmDate      ( BruImmDate      ),
        .BruRdAble       ( BruRdAble       ),
        .BruRdAddr       ( BruRdAddr       ),
        .BruMode         ( BruMode         ),
        .BruReDirDate    ( BruReDirDate    ),
        .BruROBPtr       ( BruROBPtr       ),
        .BruSelfAble     ( BruSelfAble     ),
        .BruSelfADdr     ( BruSelfADdr     ),
        .BruSelfDate     ( BruSelfDate     ),
        .BruAlu1Able     ( BruAlu1Able     ),
        .BruALu1Addr     ( BruALu1Addr     ),
        .BruAlu1Date     ( BruAlu1Date     ),
        .BruAlu2Able     ( BruAlu2Able     ),
        .BruALu2Addr     ( BruALu2Addr     ),
        .BruAlu2Date     ( BruAlu2Date     ),
        .BruMulAble      ( BruMulAble      ),
        .BruMulAddr      ( BruMulAddr      ),
        .BruMulDate      ( BruMulDate      ),
        .BruCsrAble      ( BruCsrAble      ),
        .BruCsrAddr      ( BruCsrAddr      ),
        .BruCsrDate      ( BruCsrDate      ),
        .BWriteBackAble  ( BWriteBackAble  ),
        .BWriteBackAddr  ( BWriteBackAddr  ),
        .BWriteBackDate  ( BWriteBackDate  ),
        .BruReqInst      ( BruReqInst      ),
        .BruCommitAble   ( BruCommitAble   ),
        .BruCommitPtr    ( BruCommitPtr    ),
        .BruReDirType    ( BruReDirType    ),
        .BruReDirPc      ( BruReDirPc      )
    );

    Csru u_Csru(
        .Clk               ( Clk               ),
        .Rest              ( Rest              ),
        .InInstAble        ( InInstAble        ),
        .InstVritualPc     ( InstVritualPc     ),
        .CsrMicOpCOde      ( CsrMicOpCOde      ),
        .ArchRegDate0      ( ArchRegDate0      ),
        .ArchRegDate1      ( ArchRegDate1      ),
        .CsrNum            ( CsrNum            ),
        .InstRobPtr        ( InstRobPtr        ),
        .CsruFree          ( CsruFree          ),
        .WriteBackDate     ( WriteBackDate     ),
        .WriteBackAddr     ( WriteBackAddr     ),
        .ToRobInterrupt    ( ToRobInterrupt    ),
        .ToRobCode         ( ToRobCode         ),
        .ToRobLlbetlKlo    ( ToRobLlbetlKlo    ),
        .InstReadyAble     ( InstReadyAble     ),
        .InstReadyPtr      ( InstReadyPtr      ),
        .InstReDirectAble  ( InstReDirectAble  ),
        .InstReDriectEntry ( InstReDriectEntry ),
        .InstReDirectIdle  ( InstReDirectIdle  ),
        .InstReDirectCode  ( InstReDirectCode  ),
        .InstReDirectAddr  ( InstReDirectAddr  ),
        .InstRetireAble    ( InstRetireAble    ),
        .InstRetireCode    ( InstRetireCode    ),
        .CrmdData          ( CrmdData          ),
        .EraDate           ( EraDate           ),
        .EstatDate         ( EstatDate         ),
        .ReadCsrAble       ( ReadCsrAble       ),
        .ReadCsrAddr       ( ReadCsrAddr       ),
        .ReadCsrDate       ( ReadCsrDate       ),
        .WriteCsrAble      ( WriteCsrAble      ),
        .WriteCsrAddr      ( WriteCsrAddr      ),
        .WriteCsrDate      ( WriteCsrDate      ),
        .IndexDate         ( IndexDate         ),
        .WIndexAble        ( WIndexAble        ),
        .WIndexMask        ( WIndexMask        ),
        .WIndexDate        ( WIndexDate        ),
        .TlbehiDate        ( TlbehiDate        ),
        .WEhiTLBAble       ( WEhiTLBAble       ),
        .WEhiTLBMask       ( WEhiTLBMask       ),
        .WEhiTLBDate       ( WEhiTLBDate       ),
        .Elo0TLBDate       ( Elo0TLBDate       ),
        .WElo0TLBAble      ( WElo0TLBAble      ),
        .WElo0TLBMask      ( WElo0TLBMask      ),
        .WElo0TLBDate      ( WElo0TLBDate      ),
        .Elo1TLBDate       ( Elo1TLBDate       ),
        .WElo1TLBAble      ( WElo1TLBAble      ),
        .WElo1TLBMask      ( WElo1TLBMask      ),
        .WElo1TLBDate      ( WElo1TLBDate      ),
        .AsidTLBDate       ( AsidTLBDate       ),
        .WAsidTLBAble      ( WAsidTLBAble      ),
        .WAsidTLBMask      ( WAsidTLBMask      ),
        .WAsidTLBDate      ( WAsidTLBDate      ),
        .ReadMmuAble       ( ReadMmuAble       ),
        .ReadMmuAddr       ( ReadMmuAddr       ),
        .ReadMmuDate       ( ReadMmuDate       ),
        .WriteMmuAble      ( WriteMmuAble      ),
        .WriteMmuAddr      ( WriteMmuAddr      ),
        .WriteMmuDate      ( WriteMmuDate      ),
        .SerchMmuAble      ( SerchMmuAble      ),
        .SerchMmuInfr      ( SerchMmuInfr      ),
        .SerchSuccess      ( SerchSuccess      ),
        .SerchIndexDate    ( SerchIndexDate    ),
        .CsruStop          ( CsruStop          ),
        .CsruFlash         ( CsruFlash         )
    );


    AXIbus u_AXIbus(
        .Clk           ( Clk           ),
        .Rest          ( Rest          ),
        .CacReadfree   ( CacReadfree   ),
        .CacWritefree  ( CacWritefree  ),
        .ReadBackAble  ( ReadBackAble  ),
        .ReadBackDate  ( ReadBackDate  ),
        .WritBAckAble  ( WritBAckAble  ),
        .IcaReadAble   ( IcaReadAble   ),
        .IRshankhand   ( IRshankhand   ),
        .IUncacheRead  ( IUncacheRead  ),
        .IcaReadAddr   ( IcaReadAddr   ),
        .DcaWriteAble  ( DcaWriteAble  ),
        .DWshankhand   ( DWshankhand   ),
        .DWriteUncache ( DWriteUncache ),
        .UncacheStrb   ( UncacheStrb   ),
        .DcaWriteAddr  ( DcaWriteAddr  ),
        .DcaWDate      ( DcaWDate      ),
        .DcaReadAble   ( DcaReadAble   ),
        .DRshankhand   ( DRshankhand   ),
        .DUnacheRead   ( DUnacheRead   ),
        .DcaReadAddr   ( DcaReadAddr   ),
        .Arid          ( Arid          ),
        .Araddr        ( Araddr        ),
        .Arlen         ( Arlen         ),
        .Arsize        ( Arsize        ),
        .Arburst       ( Arburst       ),
        .Arlock        ( Arlock        ),
        .Arcache       ( Arcache       ),
        .Arprot        ( Arprot        ),
        .Arvalid       ( Arvalid       ),
        .Arready       ( Arready       ),
        .Rid           ( Rid           ),
        .Rdata         ( Rdata         ),
        .Rresp         ( Rresp         ),
        .Rlast         ( Rlast         ),
        .Rvalid        ( Rvalid        ),
        .Rready        ( Rready        ),
        .Awid          ( Awid          ),
        .Awaddr        ( Awaddr        ),
        .Awlen         ( Awlen         ),
        .Awsize        ( Awsize        ),
        .Awburst       ( Awburst       ),
        .Awlock        ( Awlock        ),
        .Awcache       ( Awcache       ),
        .Awprot        ( Awprot        ),
        .Awvalid       ( Awvalid       ),
        .Awready       ( Awready       ),
        .Wid           ( Wid           ),
        .Wdata         ( Wdata         ),
        .Wstrb         ( Wstrb         ),
        .Wlast         ( Wlast         ),
        .Wvalid        ( Wvalid        ),
        .Wready        ( Wready        ),
        .Bid           ( Bid           ),
        .Bresp         ( Bresp         ),
        .Bvalid        ( Bvalid        ),
        .Bready        ( Bready        )
    );



    ProfCtr u_ProfCtr(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .DcacheMiss  ( DcacheMiss  ),
        .IcacheMiss  ( IcacheMiss  ),
        .CommitInst  ( CommitInst  ),
        .BrInst      ( BrInst      ),
        .MemInst     ( MemInst     ),
        .BrPre       ( BrPre       ),
        .BrPreErrot  ( BrPreErrot  )
    );



`ifdef DIFFTEST_EN
// difftest
// from wb_stage
wire            ws_valid_diff       ;
wire            cnt_inst_diff       ;
wire    [63:0]  timer_64_diff       ;
wire    [ 7:0]  inst_ld_en_diff     ;
wire    [31:0]  ld_paddr_diff       ;
wire    [31:0]  ld_vaddr_diff       ;
wire    [ 7:0]  inst_st_en_diff     ;
wire    [31:0]  st_paddr_diff       ;
wire    [31:0]  st_vaddr_diff       ;
wire    [31:0]  st_data_diff        ;
wire            csr_rstat_en_diff   ;
wire    [31:0]  csr_data_diff       ;

wire inst_valid_diff = ws_valid_diff;
reg             cmt_valid           ;
reg             cmt_cnt_inst        ;
reg     [63:0]  cmt_timer_64        ;
reg     [ 7:0]  cmt_inst_ld_en      ;
reg     [31:0]  cmt_ld_paddr        ;
reg     [31:0]  cmt_ld_vaddr        ;
reg     [ 7:0]  cmt_inst_st_en      ;
reg     [31:0]  cmt_st_paddr        ;
reg     [31:0]  cmt_st_vaddr        ;
reg     [31:0]  cmt_st_data         ;
reg             cmt_csr_rstat_en    ;
reg     [31:0]  cmt_csr_data        ;

reg             cmt_wen             ;
reg     [ 7:0]  cmt_wdest           ;
reg     [31:0]  cmt_wdata           ;
reg     [31:0]  cmt_pc              ;
reg     [31:0]  cmt_inst            ;

reg             cmt_excp_flush      ;
reg             cmt_ertn            ;
reg     [5:0]   cmt_csr_ecode       ;
reg             cmt_tlbfill_en      ;
reg     [4:0]   cmt_rand_index      ;

// to difftest debug
reg             trap                ;
reg     [ 7:0]  trap_code           ;
reg     [63:0]  cycleCnt            ;
reg     [63:0]  instrCnt            ;

// from regfile
wire    [31:0]  regs[31:0]          ;

// from csr
wire    [31:0]  csr_crmd_diff_0     ;
wire    [31:0]  csr_prmd_diff_0     ;
wire    [31:0]  csr_ectl_diff_0     ;
wire    [31:0]  csr_estat_diff_0    ;
wire    [31:0]  csr_era_diff_0      ;
wire    [31:0]  csr_badv_diff_0     ;
wire	[31:0]  csr_eentry_diff_0   ;
wire 	[31:0]  csr_tlbidx_diff_0   ;
wire 	[31:0]  csr_tlbehi_diff_0   ;
wire 	[31:0]  csr_tlbelo0_diff_0  ;
wire 	[31:0]  csr_tlbelo1_diff_0  ;
wire 	[31:0]  csr_asid_diff_0     ;
wire 	[31:0]  csr_save0_diff_0    ;
wire 	[31:0]  csr_save1_diff_0    ;
wire 	[31:0]  csr_save2_diff_0    ;
wire 	[31:0]  csr_save3_diff_0    ;
wire 	[31:0]  csr_tid_diff_0      ;
wire 	[31:0]  csr_tcfg_diff_0     ;
wire 	[31:0]  csr_tval_diff_0     ;
wire 	[31:0]  csr_ticlr_diff_0    ;
wire 	[31:0]  csr_llbctl_diff_0   ;
wire 	[31:0]  csr_tlbrentry_diff_0;
wire 	[31:0]  csr_dmw0_diff_0     ;
wire 	[31:0]  csr_dmw1_diff_0     ;
wire 	[31:0]  csr_pgdl_diff_0     ;
wire 	[31:0]  csr_pgdh_diff_0     ;

always @(posedge aclk) begin
    if (reset) begin
        {cmt_valid, cmt_cnt_inst, cmt_timer_64, cmt_inst_ld_en, cmt_ld_paddr, cmt_ld_vaddr, cmt_inst_st_en, cmt_st_paddr, cmt_st_vaddr, cmt_st_data, cmt_csr_rstat_en, cmt_csr_data} <= 0;
        {cmt_wen, cmt_wdest, cmt_wdata, cmt_pc, cmt_inst} <= 0;
        {trap, trap_code, cycleCnt, instrCnt} <= 0;
    end else if (~trap) begin
        cmt_valid       <= inst_valid_diff          ;
        cmt_cnt_inst    <= cnt_inst_diff            ;
        cmt_timer_64    <= timer_64_diff            ;
        cmt_inst_ld_en  <= inst_ld_en_diff          ;
        cmt_ld_paddr    <= ld_paddr_diff            ;
        cmt_ld_vaddr    <= ld_vaddr_diff            ;
        cmt_inst_st_en  <= inst_st_en_diff          ;
        cmt_st_paddr    <= st_paddr_diff            ;
        cmt_st_vaddr    <= st_vaddr_diff            ;
        cmt_st_data     <= st_data_diff             ;
        cmt_csr_rstat_en<= csr_rstat_en_diff        ;
        cmt_csr_data    <= csr_data_diff            ;

        cmt_wen     <=  debug0_wb_rf_wen            ;
        cmt_wdest   <=  {3'd0, debug0_wb_rf_wnum}   ;
        cmt_wdata   <=  debug0_wb_rf_wdata          ;
        cmt_pc      <=  debug0_wb_pc                ;
        cmt_inst    <=  debug0_wb_inst              ;

        cmt_excp_flush  <= excp_flush               ;
        cmt_ertn        <= ertn_flush               ;
        cmt_csr_ecode   <= ws_csr_ecode             ;
        cmt_tlbfill_en  <= tlbfill_en               ;
        cmt_rand_index  <= rand_index               ;

        trap            <= 0                        ;
        trap_code       <= regs[10][7:0]            ;
        cycleCnt        <= cycleCnt + 1             ;
        instrCnt        <= instrCnt + inst_valid_diff;
    end
end

DifftestInstrCommit DifftestInstrCommit(
    .clock              (aclk           ),
    .coreid             (0              ),
    .index              (0              ),
    .valid              (cmt_valid      ),
    .pc                 (cmt_pc         ),
    .instr              (cmt_inst       ),
    .skip               (0              ),
    .is_TLBFILL         (cmt_tlbfill_en ),
    .TLBFILL_index      (cmt_rand_index ),
    .is_CNTinst         (cmt_cnt_inst   ),
    .timer_64_value     (cmt_timer_64   ),
    .wen                (cmt_wen        ),
    .wdest              (cmt_wdest      ),
    .wdata              (cmt_wdata      ),
    .csr_rstat          (cmt_csr_rstat_en),
    .csr_data           (cmt_csr_data   )
);

DifftestExcpEvent DifftestExcpEvent(
    .clock              (aclk           ),
    .coreid             (0              ),
    .excp_valid         (cmt_excp_flush ),
    .eret               (cmt_ertn       ),
    .intrNo             (csr_estat_diff_0[12:2]),
    .cause              (cmt_csr_ecode  ),
    .exceptionPC        (cmt_pc         ),
    .exceptionInst      (cmt_inst       )
);

DifftestTrapEvent DifftestTrapEvent(
    .clock              (aclk           ),
    .coreid             (0              ),
    .valid              (trap           ),
    .code               (trap_code      ),
    .pc                 (cmt_pc         ),
    .cycleCnt           (cycleCnt       ),
    .instrCnt           (instrCnt       )
);

DifftestStoreEvent DifftestStoreEvent(
    .clock              (aclk           ),
    .coreid             (0              ),
    .index              (0              ),
    .valid              (cmt_inst_st_en ),
    .storePAddr         (cmt_st_paddr   ),
    .storeVAddr         (cmt_st_vaddr   ),
    .storeData          (cmt_st_data    )
);

DifftestLoadEvent DifftestLoadEvent(
    .clock              (aclk           ),
    .coreid             (0              ),
    .index              (0              ),
    .valid              (cmt_inst_ld_en ),
    .paddr              (cmt_ld_paddr   ),
    .vaddr              (cmt_ld_vaddr   )
);

DifftestCSRRegState DifftestCSRRegState(
    .clock              (aclk               ),
    .coreid             (0                  ),
    .crmd               (csr_crmd_diff_0    ),
    .prmd               (csr_prmd_diff_0    ),
    .euen               (0                  ),
    .ecfg               (csr_ectl_diff_0    ),
    .estat              (csr_estat_diff_0   ),
    .era                (csr_era_diff_0     ),
    .badv               (csr_badv_diff_0    ),
    .eentry             (csr_eentry_diff_0  ),
    .tlbidx             (csr_tlbidx_diff_0  ),
    .tlbehi             (csr_tlbehi_diff_0  ),
    .tlbelo0            (csr_tlbelo0_diff_0 ),
    .tlbelo1            (csr_tlbelo1_diff_0 ),
    .asid               (csr_asid_diff_0    ),
    .pgdl               (csr_pgdl_diff_0    ),
    .pgdh               (csr_pgdh_diff_0    ),
    .save0              (csr_save0_diff_0   ),
    .save1              (csr_save1_diff_0   ),
    .save2              (csr_save2_diff_0   ),
    .save3              (csr_save3_diff_0   ),
    .tid                (csr_tid_diff_0     ),
    .tcfg               (csr_tcfg_diff_0    ),
    .tval               (csr_tval_diff_0    ),
    .ticlr              (csr_ticlr_diff_0   ),
    .llbctl             (csr_llbctl_diff_0  ),
    .tlbrentry          (csr_tlbrentry_diff_0),
    .dmw0               (csr_dmw0_diff_0    ),
    .dmw1               (csr_dmw1_diff_0    )
);

DifftestGRegState DifftestGRegState(
    .clock              (aclk       ),
    .coreid             (0          ),
    .gpr_0              (0          ),
    .gpr_1              (regs[1]    ),
    .gpr_2              (regs[2]    ),
    .gpr_3              (regs[3]    ),
    .gpr_4              (regs[4]    ),
    .gpr_5              (regs[5]    ),
    .gpr_6              (regs[6]    ),
    .gpr_7              (regs[7]    ),
    .gpr_8              (regs[8]    ),
    .gpr_9              (regs[9]    ),
    .gpr_10             (regs[10]   ),
    .gpr_11             (regs[11]   ),
    .gpr_12             (regs[12]   ),
    .gpr_13             (regs[13]   ),
    .gpr_14             (regs[14]   ),
    .gpr_15             (regs[15]   ),
    .gpr_16             (regs[16]   ),
    .gpr_17             (regs[17]   ),
    .gpr_18             (regs[18]   ),
    .gpr_19             (regs[19]   ),
    .gpr_20             (regs[20]   ),
    .gpr_21             (regs[21]   ),
    .gpr_22             (regs[22]   ),
    .gpr_23             (regs[23]   ),
    .gpr_24             (regs[24]   ),
    .gpr_25             (regs[25]   ),
    .gpr_26             (regs[26]   ),
    .gpr_27             (regs[27]   ),
    .gpr_28             (regs[28]   ),
    .gpr_29             (regs[29]   ),
    .gpr_30             (regs[30]   ),
    .gpr_31             (regs[31]   )
);
`endif
    
endmodule