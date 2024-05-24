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

    //for reftable 
    wire                    PHYToRef1Sr1Able      ;
    wire  [`ReNameRegBUs]   PHYToRef1Sr1Num       ;
    wire                    PHYToRef1Sr2Able      ;
    wire  [`ReNameRegBUs]   PHYToRef1Sr2Num       ;
    wire                    PHYToRef2Sr1Able      ;
    wire  [`ReNameRegBUs]   PHYToRef2Sr1Num       ;
    wire                    PHYToRef2Sr2Able      ;
    wire  [`ReNameRegBUs]   PHYToRef2Sr2Num       ;
    wire                    PHYToRef3Sr1Able      ;
    wire  [`ReNameRegBUs]   PHYToRef3Sr1Num       ;
    wire                    PHYToRef3Sr2Able      ;
    wire  [`ReNameRegBUs]   PHYToRef3Sr2Num       ;
    wire                    PHYToRef4Sr1Able      ;
    wire  [`ReNameRegBUs]   PHYToRef4Sr1Num       ;
    wire                    PHYToRef4Sr2Able      ;
    wire  [`ReNameRegBUs]   PHYToRef4Sr2Num       ;

    wire                    PHYToRef1WAble        ;
    wire  [`ReNameRegBUs]   PHYToRef1Wnum         ;
    wire                    PHYToRef2WAble        ;
    wire  [`ReNameRegBUs]   PHYToRef2Wnum         ;
    wire                    PHYToRef3WAble        ;
    wire  [`ReNameRegBUs]   PHYToRef3Wnum         ;
    wire                    PHYToRef4WAble        ;
    wire  [`ReNameRegBUs]   PHYToRef4Wnum         ;
    wire                    PHYToRef5WAble        ;
    wire  [`ReNameRegBUs]   PHYToRef5Wnum         ;
    wire                    PHYToRef6WAble        ;
    wire  [`ReNameRegBUs]   PHYToRef6Wnum         ;
    wire                    PHYToRef7WAble        ;
    wire  [`ReNameRegBUs]   PHYToRef7Wnum         ;
    wire                    PHYToRef8WAble        ;
    wire  [`ReNameRegBUs]   PHYToRef8Wnum         ;

    //for brcsr 
    wire                    EXCsrToIQReq          ;
    wire                    EXBrToIQReq           ;
    wire                    IntToBrCsrWKAlu1      ;
    wire  [`ReNameRegBUs]   IntToBrCsrWKANum1     ;
    wire                    IntToBrCsrWKAlu2      ;
    wire  [`ReNameRegBUs]   IntToBrCsrWKANum2     ;
    wire                    IntToBrCsrWKMul       ;
    wire  [`ReNameRegBUs]   IntToBrCsrWKMNum      ;
    wire                    ByPassDivAble         ;
    wire  [`ReNameRegBUs]   ByPassDivNum          ;
    wire                    ByPassSCAble          ;
    wire  [`ReNameRegBUs]   ByPassSCNum           ;
    wire                    ByPassLoadAble        ;
    wire  [`ReNameRegBUs]   ByPassLoadNum         ;
    wire                    CsrToOtherAble        ;
    wire  [`ReNameRegBUs]   CsrToOtherAddr        ;
    wire                    BrToOtherAble         ;
    wire                    BrToOtherAddr         ;
    wire  [`MicOperateCode] BrCsrTo1EUMicop       ;
    wire                    BrCsrTo1EUSr1A        ;
    wire  [`ReNameRegBUs]   BrCsrTo1EUSr1Num      ;
    wire                    BrCsrTo1EUSr2A        ;
    wire  [`ReNameRegBUs]   BrCsrTo1EUSr2Num      ;
    wire                    BrCsrTo1EUImA         ;
    wire  [25:0]            BrCsrTO1EUImDate      ;
    wire                    BrCsrTo1EURdA         ;
    wire  [`ReNameRegBUs]   BRCsrTo1EURdNum       ;
    wire                    BrCsrTo1EUMode        ;
    wire  [`InstAddrBus]    BrCsrTo1EURAddr       ;
    wire                    BrCstTO1EURobPtr      ;
    wire  [`MicOperateCode] BrCsrTo2EUMicop       ;
    wire                    BrCsrTo2EUSr1A        ;
    wire  [`ReNameRegBUs]   BrCsrTo2EUSr1Num      ;
    wire                    BrCsrTo2EUSr2A        ;
    wire  [`ReNameRegBUs]   BrCsrTo2EUSr2Num      ;
    wire                    BrCsrTo2EUImA         ;
    wire  [25:0]            BrCsrTO2EUImDate      ;
    wire                    BrCsrTo2EURdA         ;
    wire  [`ReNameRegBUs]   BRCsrTo2EURdNum       ;
    wire                    BrCstTO2EURobPtr      ;

    //for IQInt 
    wire                    EXALU1ToIQReq        ;
    wire                    EXALU2ToIQReq        ;
    wire                    EXMulToIQReq         ;
    wire                    EXDivToIQReq         ;
    wire                    Alu1ToOtherAble      ;
    wire  [`ReNameRegBUs]   Alu1ToOtherNum       ;
    wire                    ALu2ToOtherAble      ;
    wire  [`ReNameRegBUs]   Alu2ToOtherNum       ;
    wire                    MulToOtherAble       ;
    wire  [`ReNameRegBUs]   MulToOtherNum        ;
    wire  [`MicOperateCode] IntToEX1MicOp        ;
    wire                    IntToEX1Sr1Able      ;
    wire  [`ReNameRegBUs]   IntToEX1Sr1Num       ;
    wire                    IntToEX1Sr2Able      ;
    wire  [`ReNameRegBUs]   IntToEX1Sr2Num       ;
    wire                    IntToEx1ImmAble      ;
    wire  [25:0]            IntToEx1ImmDate      ;
    wire                    IntToEX1RdAble       ;
    wire  [`ReNameRegBUs]   IntTOEx1RdNum        ;
    wire  [7:0]             IntToEX1RobPtr       ;
    wire  [`MicOperateCode] IntToEX2MicOp        ;
    wire                    IntToEX2Sr1Able      ;
    wire  [`ReNameRegBUs]   IntToEX2Sr1Num       ;
    wire                    IntToEX2Sr2Able      ;
    wire  [`ReNameRegBUs]   IntToEX2Sr2Num       ;
    wire                    IntToEx2ImmAble      ;
    wire  [25:0]            IntToEx2ImmDate      ;
    wire                    IntToEX2RdAble       ;
    wire  [`ReNameRegBUs]   IntTOEx2RdNum        ;
    wire  [7:0]             IntToEX2RobPtr       ;
    wire  [`MicOperateCode] IntToEX3MicOp        ;
    wire                    IntToEX3Sr1Able      ;
    wire  [`ReNameRegBUs]   IntToEX3Sr1Num       ;
    wire                    IntToEX3Sr2Able      ;
    wire  [`ReNameRegBUs]   IntToEX3Sr2Num       ;
    wire                    IntToEx3ImmAble      ;
    wire  [25:0]            IntToEx3ImmDate      ;
    wire                    IntToEX3RdAble       ;
    wire  [`ReNameRegBUs]   IntTOEx3RdNum        ;
    wire  [7:0]             IntToEX3RobPtr       ;
    wire  [`MicOperateCode] IntToEX4MicOp        ;
    wire                    IntToEX4Sr1Able      ;
    wire  [`ReNameRegBUs]   IntToEX4Sr1Num       ;
    wire                    IntToEX4Sr2Able      ;
    wire  [`ReNameRegBUs]   IntToEX4Sr2Num       ;
    wire                    IntToEx4ImmAble      ;
    wire  [25:0]            IntToEx4ImmDate      ;
    wire                    IntToEX4RdAble       ;
    wire  [`ReNameRegBUs]   IntTOEx4RdNum        ;
    wire  [7:0]             IntToEX4RobPtr       ;

    //for iQ mem
    wire                    LoadToIQReq         ;
    wire                    StoreTOIQReq        ;
    wire  [`MicOperateCode] MemToLS1MicOp       ;
    wire                    MemToLS1Sr1Able     ;
    wire  [`ReNameRegBUs]   MemToLS1Sr1Num      ;
    wire                    MemToLS1Sr2Able     ;
    wire  [`ReNameRegBUs]   MemToLS1Sr2Num      ;
    wire                    MemToLS1ImAble      ;
    wire  [25:0]            MemToLS1ImDate      ;
    wire                    MemToLS1RdAble      ;
    wire  [`ReNameRegBUs]   MemToLS1RdNum       ;
    wire  [7:0]             MemToLS1RobPtr      ;
    wire  [`MicOperateCode] MemToLS2MicOp       ;
    wire                    MemToLS2Sr1Able     ;
    wire  [`ReNameRegBUs]   MemToLS2Sr1Num      ;
    wire                    MemToLS2Sr2Able     ;
    wire  [`ReNameRegBUs]   MemToLS2Sr2Num      ;
    wire                    MemToLS2ImAble      ;
    wire  [25:0]            MemToLS2ImDate      ;
    wire                    MemToLS2RdAble      ;
    wire  [`ReNameRegBUs]   MemToLS2RdNum       ;
    wire  [7:0]             MemToLS2RobPtr      ;

    //for physical 
    wire                    ArchSToPhyReload    ;
    wire [`ReNameRegBUs]    ArchSToPhy1Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy2Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy3Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy4Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy5Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy6Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy7Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy8Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy9Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy10Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy11Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy12Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy13Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy14Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy15Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy16Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy17Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy18Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy19Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy20Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy21Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy22Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy23Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy24Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy25Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy26Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy27Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy28Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy29Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy30Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy31Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy32Num      ;

    wire                    Alu1ToPhyAble        ;
    wire [`ReNameRegBUs]    Alu1ToPhyAddr        ;
    wire [`DataBus]         Alu1ToPhyDate        ;
    wire                    Alu2ToPhyAble        ;
    wire [`ReNameRegBUs]    Alu2ToPhyAddr        ;
    wire [`DataBus]         Alu2ToPhyDate        ;
    wire                    DivToPhyAble         ;
    wire [`ReNameRegBUs]    DivToPhyAddr         ;
    wire [`DataBus]         DivToPhyDate         ;
    wire                    MulToPhyAble         ;
    wire [`ReNameRegBUs]    MulToPhyAddr         ;
    wire [`DataBus]         MulToPhyDate         ;
    wire                    CsruToPhyAble        ;
    wire [`ReNameRegBUs]    CsruToPhyAddr        ;
    wire [`DataBus]         CsruToPhyDate        ;
    wire                    BruToPhyAble         ;
    wire [`ReNameRegBUs]    BruToPhyAddr         ;
    wire [`DataBus]         BruToPhyDate         ;
    wire                    LsuToPhyAble         ;
    wire [`ReNameRegBUs]    LsuToPhyAddr         ;
    wire [`DataBus]         LsuToPhyDate         ;
    wire                    RobToPhyAble         ;
    wire [`ReNameRegBUs]    RobToPhyAddr         ;
    wire [`DataBus]         RobToPhyDate         ;

    wire [`DataBus]         PhyToEuDate11        ;
    wire [`DataBus]         PhyToEuDate12        ;
    wire [`DataBus]         PhyToEuDate21        ;
    wire [`DataBus]         PhyToEuDate22        ;
    wire [`DataBus]         PhyToEuDate31        ;
    wire [`DataBus]         PhyToEuDate32        ;
    wire [`DataBus]         PhyToEuDate41        ;
    wire [`DataBus]         PhyToEuDate42        ;
    wire [`DataBus]         PhyToEuDate51        ;
    wire [`DataBus]         PhyToEuDate52        ;
    wire [`DataBus]         PhyToEuDate61        ;
    wire [`DataBus]         PhyToEuDate62        ;
    wire [`DataBus]         PhyToEuDate71        ;
    wire [`DataBus]         PhyToEuDate72        ;
    wire [`DataBus]         PhyToEuDate81        ;
    wire [`DataBus]         PhyToEuDate82        ;

    //for mmu
    wire [9:0]              CstToMmuAsidDate    ;
    wire [`DataBus]         CsrToMmuDmw0Date    ;
    wire [`DataBus]         CsrToMmuDmw1Date    ;
    wire [`DataBus]         CsrToMmuCrmdDate    ;
    wire [5:0]              CsrToMmuRTAddr      ;
    wire [89-1:0]           MmuToCsrRTDate      ;
    wire                    CsrToMmuSTAble      ;
    wire [28:0]             CsrToMmuSTInfo      ;
    wire                    CsrToMmuSAble       ;
    wire [5:0]              CsrToMmuSIndex      ;
    wire                    CsrToMmuWTAble      ;
    wire [5:0]              CsrToMmuWTAddr      ;
    wire [88:0]             CsrToMmuWTDate      ;
    wire                    CsrToMmuInvEn       ;
    wire [4:0]              CsrToMmuInvOp       ;
    wire [9:0]              CsrToMmuInvAsid     ;
    wire [18:0]             CsrToMmuInvVppn     ;

    wire                    InstToMmuFetch      ;
    wire [31:0]             InstToMmuVA         ;
    wire [1:0]              MmuToInstOpType     ;
    wire                    MmuToInstTrap       ;
    wire [6:0]              MmuToInstTrapCode   ;
    wire [`InstAddrBus]     MmuToInstPA         ;

    wire                    LoadToMmuAccess     ;
    wire [31:0]             LoadToMmuVA         ;
    wire [1:0]              MmuToLoadOpType     ;
    wire                    MmuToLoadTrap       ;
    wire [6:0]              MmuToLoadTrapCode   ;
    wire [`InstAddrBus]     MmuToLoadPA         ;

    wire                    StoreToMmuAccess    ;
    wire [31:0]             StoreToMmuVA        ;
    wire [1:0]              MmuToStoreOpType    ;
    wire                    MmuToStoreTrap      ;
    wire [6:0]              MmuToStoreTrapCode  ;
    wire [`InstAddrBus]     MmuToStorePA        ;

    //for alu1 
    wire                    Alu1ToIQReq         ;
    wire                    Alu1ToPhyWBAble     ;
    wire [`ReNameRegBUs]    Alu1ToPhyWBNum      ;
    wire [`DataBus]         Alu1ToPhyWBDate     ;
    wire                    Alu1ToRobAble       ;
    wire [5:0]              Alu1ToRobPtr        ;
    wire [1:0]              Alu1ToRobType       ;
    //for alu2
    wire                    Alu2ToIQReq         ;
    wire                    Alu2ToPhyWBAble     ;
    wire [`ReNameRegBUs]    Alu2ToPhyWBNum      ;
    wire [`DataBus]         Alu2ToPhyWBDate     ;
    wire                    Alu2ToRobAble       ;
    wire [5:0]              Alu2ToRobPtr        ;
    wire [1:0]              Alu2ToRobType       ;

 
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
    .Inst1Src1Able   ( RATToRefUse1    ),
    .Inst1Src1Addr   ( RATToRefUse1Addr),
    .Inst1Src2Able   ( RATToRefUse2    ),
    .Inst1Src2Addr   ( RATToRefUse2Addr),
    .Inst1RdAble     ( RATToRefUse3    ),
    .Inst1RdAddr     ( RATToRefUse3Addr),
    .Inst2Src1Able   ( RATToRefUse4    ),
    .Inst2Src1Addr   ( RATToRefUse4Addr),
    .Inst2Src2Able   ( RATToRefUse5    ),
    .Inst2Src2Addr   ( RATToRefUse5Addr),
    .Inst2RdAble     ( RATToRefUse6    ),
    .Inst2RdAddr     ( RATToRefUse6Addr),
    .Inst3Src1Able   ( RATToRefUse7    ),
    .Inst3Src1Addr   ( RATToRefUse7Addr),
    .Inst3Src2Able   ( RATToRefUse8    ),
    .Inst3Src2Addr   ( RATToRefUse8Addr),
    .Inst3RdAble     ( RATToRefUse9    ),
    .Inst3RdAddr     ( RATToRefUse9Addr),
    .Inst4Src1Able   ( RATToRefUse10   ),
    .Inst4Src1Addr   ( RATToRefUse10Addr),
    .Inst4Src2Able   ( RATToRefUse11   ),
    .Inst4Src2Addr   ( RATToRefUse11Addr),
    .Inst4RdAble     ( RATToRefUse12   ),
    .Inst4RdAddr     ( RATToRefUse12Addr),
    .Lock1Able       ( RATToRefLock1   ),
    .Lock1Addr       ( RATToRefLock1Addr),
    .Lock2Able       ( RATToRefLock2   ),
    .Lock2Addr       ( RATToRefLock2Addr),
    .Lock3Able       ( RATToRefLock3   ),
    .Lock3Addr       ( RATToRefLock3Addr),
    .Lock4Able       ( RATToRefLock4   ),
    .Lock4Addr       ( RATToRefLock4Addr),
    .Inst1Read1Able  ( PHYToRef1Sr1Able),
    .Inst1Read1Addr  ( PHYToRef1Sr1Num ),
    .Inst1Read2Able  ( PHYToRef1Sr2Able),
    .Inst1Read2Addr  ( PHYToRef1Sr2Num ),
    .Inst2Read1Able  ( PHYToRef2Sr1Able),
    .Inst2Read1Addr  ( PHYToRef2Sr1Num ),
    .Inst2Read2Able  ( PHYToRef2Sr2Able),
    .Inst2Read2Addr  ( PHYToRef2Sr2Num ),
    .Inst3Read1Able  ( PHYToRef3Sr1Able),
    .Inst3Read1Addr  ( PHYToRef3Sr1Num ),
    .Inst3Read2Able  ( PHYToRef3Sr2Able),
    .Inst3Read2Addr  ( PHYToRef3Sr2Num ),
    .Inst4Read1Able  ( PHYToRef4Sr1Able),
    .Inst4Read1Addr  ( PHYToRef4Sr1Num ),
    .Inst4Read2Able  ( PHYToRef4Sr2Able),
    .Inst4Read2Addr  ( PHYToRef4Sr2Num ),
    .WritBack1Able   ( PHYToRef1WAble  ),
    .WritBack1Addr   ( PHYToRef1Wnum   ),
    .WritBack2Able   ( PHYToRef2WAble  ),
    .WritBack2Addr   ( PHYToRef2Wnum   ),
    .WritBack3Able   ( PHYToRef3WAble  ),
    .WritBack3Addr   ( PHYToRef3Wnum   ),
    .WritBack4Able   ( PHYToRef4WAble  ),
    .WritBack4Addr   ( PHYToRef4Wnum   ),
    .WritBack5Able   ( PHYToRef5WAble  ),
    .WritBack5Addr   ( PHYToRef5Wnum   ),
    .WritBack6Able   ( PHYToRef6WAble  ),
    .WritBack6Addr   ( PHYToRef6Wnum   ),
    .WritBack7Able   ( PHYToRef7WAble  ),
    .WritBack7Addr   ( PHYToRef7Wnum   ),
    .WritBack8Able   ( PHYToRef8WAble  ),
    .WritBack8Addr   ( PHYToRef8Wnum   ),
    .WriteNum1       ( RefToFLF1Addr   ),
    .WriteAble1      ( RefToFLF1Able   ),
    .WriteNum2       ( RefToFLF2Addr   ),
    .WriteAble2      ( RefToFLF2Able   ),
    .WriteNum3       ( RefToFLF3Addr   ),
    .WriteAble3      ( RefToFLF3Able   ),
    .WriteNum4       ( RefToFLF4Addr   ),
    .WriteAble4      ( RefToFLF4Able   )
    );

    reg                   StopTemp  ;
    reg                   FLashTemp ;

    always @(posedge Clk) begin
        if(!Rest) begin
            StopTemp   <= 1'b0 ;
            FLashTemp  <= 1'b0 ;
        end
        else begin
            StopTemp   <=      ;
            FLashTemp  <=      ;
        end
    end

    reg                   DcdToBrCsr1Able;
    reg                   DcdToInt1Able  ;
    reg                   DcdToMem1Able  ;
    reg                   DcdToBrCsr2Able;
    reg                   DcdToInt2Able  ;
    reg                   DcdToMem2Able  ;
    reg                   DcdToBrCsr3Able;
    reg                   DcdToInt3Able  ;
    reg                   DcdToMem3Able  ;
    reg                   DcdToBrCsr4Able;
    reg                   DcdToInt4Able  ;
    reg                   DcdToMem4Able  ;
    reg [`MicOperateCode] DcdToIQ1MicOp  ;    
    reg                   DcdToIQ1ImAble ;
    reg [25:0]            DcdToIQ1ImDate ;
    reg                   DcdToIQ1Mode   ;
    reg [`InstAddrBus]    DcdToIQ1RAddr  ;
    reg                   DcdToIQ2Able   ;
    reg [`MicOperateCode] DcdToIQ2MicOp  ;    
    reg                   DcdToIQ2ImAble ;
    reg [25:0]            DcdToIQ2ImDate ;
    reg                   DcdToIQ2Mode   ;
    reg [`InstAddrBus]    DcdToIQ2RAddr  ;
    reg                   DcdToIQ3Able   ;
    reg [`MicOperateCode] DcdToIQ3MicOp  ;    
    reg                   DcdToIQ3ImAble ;
    reg [25:0]            DcdToIQ3ImDate ;
    reg                   DcdToIQ3Mode   ;
    reg [`InstAddrBus]    DcdToIQ3RAddr  ;
    reg                   DcdToIQ4Able   ;
    reg [`MicOperateCode] DcdToIQ4MicOp  ;    
    reg                   DcdToIQ4ImAble ;
    reg [25:0]            DcdToIQ4ImDate ;
    reg                   DcdToIQ4Mode   ;
    reg [`InstAddrBus]    DcdToIQ4RAddr  ;
    reg [2:0]             DcdToCsrBruNum ;
    reg [2:0]             DcdToIntNum    ;
    reg [2:0]             DcdToMemNum    ;

    wire  BrCsr1Able  = (DcdToRnm1Opcode[7:5] == 4) | (DcdToRnm1Opcode[7:5] == 7) ;
    wire  Int1Able    = (DcdToRnm1Opcode[7:5] == 1) | (DcdToRnm1Opcode[7:5] == 2) | (DcdToRnm1Opcode[7:5] == 3) ;
    wire  Mem1Able    = (DcdToRnm1Opcode[7:5] == 0) | (DcdToRnm1Opcode[7:5] == 5) ;

    wire  BrCsr2Able  = (DcdToRnm2Opcode[7:5] == 4) | (DcdToRnm2Opcode[7:5] == 7) ;
    wire  Int2Able    = (DcdToRnm2Opcode[7:5] == 1) | (DcdToRnm2Opcode[7:5] == 2) | (DcdToRnm2Opcode[7:5] == 3) ;
    wire  Mem2Able    = (DcdToRnm2Opcode[7:5] == 0) | (DcdToRnm2Opcode[7:5] == 5) ;

    wire  BrCsr3Able  = (DcdToRnm3Opcode[7:5] == 4) | (DcdToRnm3Opcode[7:5] == 7) ;
    wire  Int3Able    = (DcdToRnm3Opcode[7:5] == 1) | (DcdToRnm3Opcode[7:5] == 2) | (DcdToRnm3Opcode[7:5] == 3) ;
    wire  Mem3Able    = (DcdToRnm3Opcode[7:5] == 0) | (DcdToRnm3Opcode[7:5] == 5) ;

    wire  BrCsr4Able  = (DcdToRnm4Opcode[7:5] == 4) | (DcdToRnm4Opcode[7:5] == 7) ;
    wire  Int4Able    = (DcdToRnm4Opcode[7:5] == 1) | (DcdToRnm4Opcode[7:5] == 2) | (DcdToRnm4Opcode[7:5] == 3) ;
    wire  Mem4Able    = (DcdToRnm4Opcode[7:5] == 0) | (DcdToRnm4Opcode[7:5] == 5) ;

    wire [2:0]  AddBrCsrNum =    BrCsr1Able + BrCsr2Able + BrCsr3Able + BrCsr4Able ; 
    wire [2:0]  AddIntNum   =    Int1Able   + Int2Able   + Int3Able   + Int4Able   ;
    wire [2:0]  AddMemNum   =    Mem1Able   + Mem2Able   + Mem3Able   + Mem4Able   ;

    always @(posedge Clk) begin
        if(!Rest) begin
            DcdToBrCsr1Able  <=  1'b0  ;
            DcdToInt1Able    <=  1'b0  ;
            DcdToMem1Able    <=  1'b0  ;
            DcdToIQ1MicOp    <=  8'b0  ;
            DcdToIQ1ImAble   <=  1'b0  ;
            DcdToIQ1ImDate   <=  26'd0 ;
            DcdToIQ1Mode     <=  1'b0  ;
            DcdToIQ1RAddr    <=  32'd0 ;
            DcdToBrCsr2Able  <=  1'b0  ;
            DcdToInt2Able    <=  1'b0  ;
            DcdToMem2Able    <=  1'b0  ;
            DcdToIQ2MicOp    <=  8'b0  ;
            DcdToIQ2ImAble   <=  1'b0  ;
            DcdToIQ2ImDate   <=  26'd0 ;
            DcdToIQ2Mode     <=  1'b0  ;
            DcdToIQ2RAddr    <=  32'd0 ;
            DcdToBrCsr3Able  <=  1'b0  ;
            DcdToInt3Able    <=  1'b0  ;
            DcdToMem3Able    <=  1'b0  ;
            DcdToIQ3MicOp    <=  8'b0  ;
            DcdToIQ3ImAble   <=  1'b0  ;
            DcdToIQ3ImDate   <=  26'd0 ;
            DcdToIQ3Mode     <=  1'b0  ;
            DcdToIQ3RAddr    <=  32'd0 ;
            DcdToBrCsr4Able  <=  1'b0  ;
            DcdToInt4Able    <=  1'b0  ;
            DcdToMem4Able    <=  1'b0  ;
            DcdToIQ4MicOp    <=  8'b0  ;
            DcdToIQ4ImAble   <=  1'b0  ;
            DcdToIQ4ImDate   <=  26'd0 ;
            DcdToIQ4Mode     <=  1'b0  ;
            DcdToIQ4RAddr    <=  32'd0 ;
            DcdToCsrBruNum   <=  3'd0  ;
            DcdToIntNum      <=  3'd0  ;
            DcdToMemNum      <=  3'd0  ;
        end 
        else if(StopTemp) begin
            DcdToBrCsr1Able  <=  DcdToBrCsr1Able   ;
            DcdToInt1Able    <=  DcdToInt1Able     ;
            DcdToMem1Able    <=  DcdToMem1Able     ;
            DcdToIQ1MicOp    <=  DcdToIQ1MicOp     ;
            DcdToIQ1ImAble   <=  DcdToIQ1ImAble    ;
            DcdToIQ1ImDate   <=  DcdToIQ1ImDate    ;
            DcdToIQ1Mode     <=  DcdToIQ1Mode      ;
            DcdToIQ1RAddr    <=  DcdToIQ1RAddr     ;
            DcdToBrCsr2Able  <=  DcdToBrCsr2Able   ;
            DcdToInt2Able    <=  DcdToInt2Able     ;
            DcdToMem2Able    <=  DcdToMem2Able     ;
            DcdToIQ2MicOp    <=  DcdToIQ2MicOp     ;
            DcdToIQ2ImAble   <=  DcdToIQ2ImAble    ;
            DcdToIQ2ImDate   <=  DcdToIQ2ImDate    ;
            DcdToIQ2Mode     <=  DcdToIQ2Mode      ;
            DcdToIQ2RAddr    <=  DcdToIQ2RAddr     ;
            DcdToBrCsr3Able  <=  DcdToBrCsr3Able   ;
            DcdToInt3Able    <=  DcdToInt3Able     ;
            DcdToMem3Able    <=  DcdToMem3Able     ;
            DcdToIQ3MicOp    <=  DcdToIQ3MicOp     ;
            DcdToIQ3ImAble   <=  DcdToIQ3ImAble    ;
            DcdToIQ3ImDate   <=  DcdToIQ3ImDate    ;
            DcdToIQ3Mode     <=  DcdToIQ3Mode      ;
            DcdToIQ3RAddr    <=  DcdToIQ3RAddr     ;
            DcdToBrCsr3Able  <=  DcdToBrCsr3Able   ;
            DcdToInt3Able    <=  DcdToInt3Able     ;
            DcdToMem3Able    <=  DcdToMem3Able     ;
            DcdToIQ4MicOp    <=  DcdToIQ4MicOp     ;
            DcdToIQ4ImAble   <=  DcdToIQ4ImAble    ;
            DcdToIQ4ImDate   <=  DcdToIQ4ImDate    ;
            DcdToIQ4Mode     <=  DcdToIQ4Mode      ;
            DcdToIQ4RAddr    <=  DcdToIQ4RAddr     ;
            DcdToCsrBruNum   <=  DcdToCsrBruNum    ;
            DcdToIntNum      <=  DcdToIntNum       ;
            DcdToMemNum      <=  DcdToMemNum       ;
        end
        else if(FlashTemp) begin
            DcdToBrCsr1Able  <=  1'b0  ;
            DcdToInt1Able    <=  1'b0  ;
            DcdToMem1Able    <=  1'b0  ;
            DcdToIQ1MicOp    <=  8'b0  ;
            DcdToIQ1ImAble   <=  1'b0  ;
            DcdToIQ1ImDate   <=  26'd0 ;
            DcdToIQ1Mode     <=  1'b0  ;
            DcdToIQ1RAddr    <=  32'd0 ;
            DcdToBrCsr2Able  <=  1'b0  ;
            DcdToInt2Able    <=  1'b0  ;
            DcdToMem2Able    <=  1'b0  ;
            DcdToIQ2MicOp    <=  8'b0  ;
            DcdToIQ2ImAble   <=  1'b0  ;
            DcdToIQ2ImDate   <=  26'd0 ;
            DcdToIQ2Mode     <=  1'b0  ;
            DcdToIQ2RAddr    <=  32'd0 ;
            DcdToBrCsr3Able  <=  1'b0  ;
            DcdToInt3Able    <=  1'b0  ;
            DcdToMem3Able    <=  1'b0  ;
            DcdToIQ3MicOp    <=  8'b0  ;
            DcdToIQ3ImAble   <=  1'b0  ;
            DcdToIQ3ImDate   <=  26'd0 ;
            DcdToIQ3Mode     <=  1'b0  ;
            DcdToIQ3RAddr    <=  32'd0 ;
            DcdToBrCsr4Able  <=  1'b0  ;
            DcdToInt4Able    <=  1'b0  ;
            DcdToMem4Able    <=  1'b0  ;
            DcdToIQ4MicOp    <=  8'b0  ;
            DcdToIQ4ImAble   <=  1'b0  ;
            DcdToIQ4ImDate   <=  26'd0 ;
            DcdToIQ4Mode     <=  1'b0  ;
            DcdToIQ4RAddr    <=  32'd0 ;
            DcdToCsrBruNum   <=  3'd0  ;
            DcdToIntNum      <=  3'd0  ;
            DcdToMemNum      <=  3'd0  ;
        end
        else begin
            DcdToBrCsr1Able  <=  BrCsr1Able       ;
            DcdToInt1Able    <=  Int1Able         ;
            DcdToMem1Able    <=  Mem1Able         ;
            DcdToIQ1MicOp    <=  DcdToRnm1Opcode  ;
            DcdToIQ1ImAble   <=  DcdToRnm1ImAble  ;
            DcdToIQ1ImDate   <=  DcdToRnm1ImDate  ;
            DcdToIQ1Mode     <=  DcdToRnm1Part    ;
            DcdToIQ1RAddr    <=  DcdToRnm1Naddr   ;
            DcdToBrCsr2Able  <=  BrCsr2Able       ;
            DcdToInt2Able    <=  Int2Able         ;
            DcdToMem2Able    <=  Mem2Able         ;
            DcdToIQ2MicOp    <=  DcdToRnm2Opcode  ;
            DcdToIQ2ImAble   <=  DcdToRnm2ImAble  ;
            DcdToIQ2ImDate   <=  DcdToRnm2ImDate  ;
            DcdToIQ2Mode     <=  DcdToRnm2Part    ;
            DcdToIQ2RAddr    <=  DcdToRnm2Naddr   ;
            DcdToBrCsr3Able  <=  BrCsr3Able       ;
            DcdToInt3Able    <=  Int3Able         ;
            DcdToMem3Able    <=  Mem3Able         ;
            DcdToIQ3MicOp    <=  DcdToRnm3Opcode  ;
            DcdToIQ3ImAble   <=  DcdToRnm3ImAble  ;
            DcdToIQ3ImDate   <=  DcdToRnm3ImDate  ;
            DcdToIQ3Mode     <=  DcdToRnm3Part    ;
            DcdToIQ3RAddr    <=  DcdToRnm3Naddr   ;
            DcdToBrCsr4Able  <=  BrCsr4Able       ;
            DcdToInt3Able    <=  Int4Able         ;
            DcdToMem3Able    <=  Mem4Able         ;
            DcdToIQ4MicOp    <=  DcdToRnm4Opcode  ;
            DcdToIQ4ImAble   <=  DcdToRnm4ImAble  ;
            DcdToIQ4ImDate   <=  DcdToRnm4ImDate  ;
            DcdToIQ4Mode     <=  DcdToRnm4Part    ;
            DcdToIQ4RAddr    <=  DcdToRnm4Naddr   ;
            DcdToCsrBruNum   <=  AddBrCsrNum      ;
            DcdToIntNum      <=  AddIntNum        ;
            DcdToMemNum      <=  AddMemNum        ;
        end
    end


    IssueQueueBrCsr u_IssueQueueBrCsr(
    .Clk               ( Clk               ),
    .Rest              ( Rest              ),
    .BrCsrStop         ( BrCsrStop         ),
    .BrCsrFlash        ( BrCsrFlash        ),
    .BrCsrReq          ( BrCsrReq          ),
    .BInIQInstNum      ( DcdToCsrBruNum    ),
    .BIn1Src1Able      ( BYTToIQ1Sr1Able   ),
    .BIn1Src1Ready     ( BYTToIQ1Sr1Ready  ),
    .BIn1Src1Addr      ( BYTToIQ1Sr1Num    ),
    .BIn1Src2Able      ( BYTToIQ1Sr2Able   ),
    .BIn1Src2Ready     ( BYTToIQ1Sr2Ready  ),
    .BIn1Src2Addr      ( BYTToIQ1Sr2Num    ),
    .BIn1RdAble        ( BYTToIQ1WAble     ),
    .BIn1RdAddr        ( BYTToIQ1WNum      ),
    .BIn2Src1Able      ( BYTToIQ2Sr1Able   ),
    .BIn2Src1Ready     ( BYTToIQ2Sr1Ready  ),
    .BIn2Src1Addr      ( BYTToIQ2Sr1Num    ),
    .BIn2Src2Able      ( BYTToIQ2Sr2Able   ),
    .BIn2Src2Ready     ( BYTToIQ2Sr2Ready  ),
    .BIn2Src2Addr      ( BYTToIQ2Sr2Num    ),
    .BIn2RdAble        ( BYTToIQ2WAble     ),
    .BIn2RdAddr        ( BYTToIQ2WNum      ),
    .BIn3Src1Able      ( BYTToIQ3Sr1Able   ),
    .BIn3Src1Ready     ( BYTToIQ3Sr1Ready  ),
    .BIn3Src1Addr      ( BYTToIQ3Sr1Num    ),
    .BIn3Src2Able      ( BYTToIQ3Sr2Able   ),
    .BIn3Src2Ready     ( BYTToIQ3Sr2Ready  ),
    .BIn3Src2Addr      ( BYTToIQ3Sr2Num    ),
    .BIn3RdAble        ( BYTToIQ3WAble     ),
    .BIn3RdAddr        ( BYTToIQ3WNum      ),
    .BIn4Src1Able      ( BYTToIQ4Sr1Able   ),
    .BIn4Src1Ready     ( BYTToIQ4Sr1Ready  ),
    .BIn4Src1Addr      ( BYTToIQ4Sr1Num    ),
    .BIn4Src2Able      ( BYTToIQ4Sr2Able   ),
    .BIn4Src2Ready     ( BYTToIQ4Sr2Ready  ),
    .BIn4Src2Addr      ( BYTToIQ4Sr2Num    ),
    .BIn4RdAble        ( BYTToIQ4WAble     ),
    .BIn4RdAddr        ( BYTToIQ4WNum      ),
    .BIn1aAble         ( DcdToBrCsr1Able   ),
    .BIn1MicOpcode     ( DcdToIQ1MicOp     ),
    .BIn1ImmAble       ( DcdToIQ1ImAble    ),
    .BIn1ImmDate       ( DcdToIQ1ImDate    ),
    .BIn1Mode          ( DcdToIQ1Mode      ),
    .BIn1ReDirAddr     ( DcdToIQ1RAddr     ),
    .BIn1RobPtr        ( BIn1RobPtr        ),
    .BIn2aAble         ( DcdToBrCsr2Able   ),
    .BIn2MicOpcode     ( DcdToIQ2MicOp     ),
    .BIn2ImmAble       ( DcdToIQ2ImAble    ),
    .BIn2ImmDate       ( DcdToIQ2ImDate    ),
    .BIn2Mode          ( DcdToIQ2Mode      ),
    .BIn2ReDirAddr     ( DcdToIQ2RAddr     ),
    .BIn2RobPtr        ( BIn2RobPtr        ),
    .BIn3aAble         ( DcdToBrCsr2Able   ),
    .BIn3MicOpcode     ( DcdToIQ2MicOp     ),
    .BIn3ImmAble       ( DcdToIQ2ImAble    ),
    .BIn3ImmDate       ( DcdToIQ2ImDate    ),
    .BIn3Mode          ( DcdToIQ2Mode      ),
    .BIn3ReDirAddr     ( DcdToIQ2RAddr     ),
    .BIn3RobPtr        ( BIn3RobPtr        ),
    .BIn4aAble         ( DcdToBrCsr4Able   ),
    .BIn4MicOpcode     ( DcdToIQ4MicOp     ),
    .BIn4ImmAble       ( DcdToIQ4ImAble    ),
    .BIn4ImmDate       ( DcdToIQ4ImDate    ),
    .BIn4Mode          ( DcdToIQ4Mode      ),
    .BIn4ReDirAddr     ( DcdToIQ4RAddr     ),
    .BIn4RobPtr        ( BIn4RobPtr        ),
    .CsrReq            ( EXCsrToIQReq      ),
    .BrReq             ( EXBrToIQReq       ),
    .FromIsQAlu1       ( IntToBrCsrWKAlu1  ),
    .FromAlu1Addr      ( IntToBrCsrWKANum1 ),
    .FromIsQAlu2       ( IntToBrCsrWKAlu2  ),
    .FromAlu2Addr      ( IntToBrCsrWKANum2 ),
    .FromIsQMul        ( IntToBrCsrWKMul   ),
    .FromMulAddr       ( IntToBrCsrWKMNum  ),
    .ByPassBDiv        ( ByPassDivAble     ),
    .ByPassBDivAddr    ( ByPassDivNum      ),
    .BypassBSC         ( ByPassSCAble      ),
    .BypassBSCAddr     ( ByPassSCNum       ),
    .ByPassBLoad       ( ByPassLoadAble    ),
    .ByPassBLoadAddr   ( ByPassLoadNum     ),
    .OutCsrAble        ( CsrToOtherAble    ),
    .OutCsrAddr        ( CsrToOtherAddr    ),
    .OutBruAble        ( BrToOtherAble     ),
    .OutBruAddr        ( BrToOtherAddr     ),
    .BInst1MicOperate  ( BrCsrTo1EUMicop   ),
    .BInst1Src1RAble   ( BrCsrTo1EUSr1A    ),
    .BInst1Src1RAddr   ( BrCsrTo1EUSr1Num  ),
    .BInst1Src2RAble   ( BrCsrTo1EUSr2A    ),
    .BInst1Src2RAddr   ( BrCsrTo1EUSr2Num  ),
    .BInst1ImmAble     ( BrCsrTo1EUImA     ),
    .BInst1ImmDate     ( BrCsrTO1EUImDate  ),
    .BInst1RdAble      ( BrCsrTo1EURdA     ),
    .BInst1RdAddr      ( BRCsrTo1EURdNum   ),
    .BInst1Mode        ( BrCsrTo1EUMode    ),
    .BInst1RedieAddr   ( BrCsrTo1EURAddr   ),
    .BInst1RoBptr      ( BrCstTO1EURobPtr  ),
    .BInst2MicOperate  ( BrCsrTo2EUMicop   ),
    .BInst2Src1RAble   ( BrCsrTo2EUSr1A    ),
    .BInst2Src1RAddr   ( BrCsrTo2EUSr1Num  ),
    .BInst2Src2RAble   ( BrCsrTo2EUSr2A    ),
    .BInst2Src2RAddr   ( BrCsrTo2EUSr2Num  ),
    .BInst2ImmAble     ( BrCsrTo2EUImA     ),
    .BInst2ImmDate     ( BrCsrTO2EUImDate  ),
    .BInst2RdAble      ( BrCsrTo2EURdA     ),
    .BInst2RdAddr      ( BRCsrTo2EURdNum   ),
    .BInst2RoBptr      ( BrCstTO2EURobPtr  )
    );

    IssueQueueInt u_IssueQueueInt(
    .Clk              ( Clk                 ),
    .Rest             ( Rest                ),
    .IsQuIntStop      ( IsQuIntStop         ),
    .IsQuIntFlash     ( IsQuIntFlash        ),
    .IsQuIntReq       ( IsQuIntReq          ),
    .InIQInstNum      ( DcdToIntNum         ),
    .In1Src1Able      ( BYTToIQ1Sr1Able     ),
    .In1Src1Ready     ( BYTToIQ1Sr1Ready    ),
    .In1Src1Addr      ( BYTToIQ1Sr1Num      ),
    .In1Src2Able      ( BYTToIQ1Sr2Able     ),
    .In1Src2Ready     ( BYTToIQ1Sr2Ready    ),
    .In1Src2Addr      ( BYTToIQ1Sr2Num      ),
    .In1RdAble        ( BYTToIQ1WAble       ),
    .In1RdAddr        ( BYTToIQ1WNum        ),
    .In2Src1Able      ( BYTToIQ2Sr1Able     ),
    .In2Src1Ready     ( BYTToIQ2Sr1Ready    ),
    .In2Src1Addr      ( BYTToIQ2Sr1Num      ),
    .In2Src2Able      ( BYTToIQ2Sr2Able     ),
    .In2Src2Ready     ( BYTToIQ2Sr2Ready    ),
    .In2Src2Addr      ( BYTToIQ2Sr2Num      ),
    .In2RdAble        ( BYTToIQ2WAble       ),
    .In2RdAddr        ( BYTToIQ2WNum        ),
    .In3Src1Able      ( BYTToIQ3Sr1Able     ),
    .In3Src1Ready     ( BYTToIQ3Sr1Ready    ),
    .In3Src1Addr      ( BYTToIQ3Sr1Num      ),
    .In3Src2Able      ( BYTToIQ3Sr2Able     ),
    .In3Src2Ready     ( BYTToIQ3Sr2Ready    ),
    .In3Src2Addr      ( BYTToIQ3Sr2Num      ),
    .In3RdAble        ( BYTToIQ3WAble       ),
    .In3RdAddr        ( BYTToIQ3WNum        ),
    .In4Src1Able      ( BYTToIQ4Sr1Able     ),
    .In4Src1Ready     ( BYTToIQ4Sr1Ready    ),
    .In4Src1Addr      ( BYTToIQ4Sr1Num      ),
    .In4Src2Able      ( BYTToIQ4Sr2Able     ),
    .In4Src2Ready     ( BYTToIQ4Sr2Ready    ),
    .In4Src2Addr      ( BYTToIQ4Sr2Num      ),
    .In4RdAble        ( BYTToIQ4WAble       ),
    .In4RdAddr        ( BYTToIQ4WNum        ),
    .In1aAble         ( DcdToInt1Able       ),
    .In1MicOpcode     ( DcdToIQ1MicOp       ),
    .In1ImmAble       ( DcdToIQ1ImAble      ),
    .In1ImmDate       ( DcdToIQ1ImDate      ),
    .In1RobPtr        ( In1RobPtr           ),
    .In2aAble         ( DcdToInt2Able       ),
    .In2MicOpcode     ( DcdToIQ2MicOp       ),
    .In2ImmAble       ( DcdToIQ2ImAble      ),
    .In2ImmDate       ( DcdToIQ2ImDate      ),
    .In2RobPtr        ( In2RobPtr           ),
    .In3aAble         ( DcdToInt3Able       ),
    .In3MicOpcode     ( DcdToIQ4MicOp       ),
    .In3ImmAble       ( DcdToIQ4ImAble      ),
    .In3ImmDate       ( DcdToIQ4ImDate      ),
    .In3RobPtr        ( In3RobPtr           ),
    .In4aAble         ( DcdToInt4Able       ),
    .In4MicOpcode     ( DcdToIQ4MicOp       ),
    .In4ImmAble       ( DcdToIQ4ImAble      ),
    .In4ImmDate       ( DcdToIQ4ImDate      ),
    .In4RobPtr        ( In4RobPtr           ),
    .FromIsQBr        ( BrToOtherAble       ),
    .FromBrAddr       ( BrToOtherAddr       ),
    .FromIsQCsr       ( CsrToOtherAble      ),
    .FromCsrAddr      ( CsrToOtherAddr      ),
    .ByPassDiv        ( ByPassDivAble       ),
    .ByPassDivAddr    ( ByPassDivNum        ),
    .BypassSC         ( ByPassSCAble        ),
    .BypassSCAddr     ( ByPassSCNum         ),
    .ByPassLoad       ( ByPassLoadAble      ),
    .ByPassLoadAddr   ( ByPassLoadNum       ),
    .Alu1Req          ( EXALU1ToIQReq       ),
    .Alu2Req          ( EXALU2ToIQReq       ),
    .MulReq           ( EXMulToIQReq        ),
    .DivReq           ( EXDivToIQReq        ),
    .Alu1Inst         ( Alu1ToOtherAble     ),
    .Alu1InstAddr     ( Alu1ToOtherNum      ),
    .Alu2Inst         ( ALu2ToOtherAble     ),
    .ALu2InstAddr     ( Alu2ToOtherNum      ),
    .MulInst          ( MulToOtherAble      ),
    .MulInstAddr      ( MulToOtherNum       ),
    .Inst1MicOperate  ( IntToEX1MicOp       ),
    .Inst1Src1RAble   ( IntToEX1Sr1Able     ),
    .Inst1Src1RAddr   ( IntToEX1Sr1Num      ),
    .Inst1Src2RAble   ( IntToEX1Sr2Able     ),
    .Inst1Src2RAddr   ( IntToEX1Sr2Num      ),
    .Inst1ImmAble     ( IntToEx1ImmAble     ),
    .Inst1ImmDate     ( IntToEx1ImmDate     ),
    .Inst1RdAble      ( IntToEX1RdAble      ),
    .Inst1RdAddr      ( IntTOEx1RdNum       ),
    .Inst1RoBptr      ( IntToEX1RobPtr      ),
    .Inst2MicOperate  ( IntToEX2MicOp       ),
    .Inst2Src1RAble   ( IntToEX2Sr1Able     ),
    .Inst2Src1RAddr   ( IntToEX2Sr1Num      ),
    .Inst2Src2RAble   ( IntToEX2Sr2Able     ),
    .Inst2Src2RAddr   ( IntToEX2Sr2Num      ),
    .Inst2ImmAble     ( IntToEx2ImmAble     ),
    .Inst2ImmDate     ( IntToEx2ImmDate     ),
    .Inst2RdAble      ( IntToEX2RdAble      ),
    .Inst2RdAddr      ( IntTOEx2RdNum       ),
    .Inst2RoBptr      ( IntToEX2RobPtr      ),
    .Inst3MicOperate  ( IntToEX3MicOp       ),
    .Inst3Src1RAble   ( IntToEX3Sr1Able     ),
    .Inst3Src1RAddr   ( IntToEX3Sr1Num      ),
    .Inst3Src2RAble   ( IntToEX3Sr2Able     ),
    .Inst3Src2RAddr   ( IntToEX3Sr2Num      ),
    .Inst3ImmAble     ( IntToEx3ImmAble     ),
    .Inst3ImmDate     ( IntToEx3ImmDate     ),
    .Inst3RdAble      ( IntToEX3RdAble      ),
    .Inst3RdAddr      ( IntTOEx3RdNum       ),
    .Inst3RoBptr      ( IntToEX3RobPtr      ),
    .Inst4MicOperate  ( IntToEX4MicOp       ),
    .Inst4Src1RAble   ( IntToEX4Sr1Able     ),
    .Inst4Src1RAddr   ( IntToEX4Sr1Num      ),
    .Inst4Src2RAble   ( IntToEX4Sr2Able     ),
    .Inst4Src2RAddr   ( IntToEX4Sr2Num      ),
    .Inst4ImmAble     ( IntToEx4ImmAble     ),
    .Inst4ImmDate     ( IntToEx4ImmDate     ),
    .Inst4RdAble      ( IntToEX4RdAble      ),
    .Inst4RdAddr      ( IntTOEx4RdNum       ),
    .Inst4RoBptr      ( IntToEX4RobPtr      )
    );

    IssueQueueMem u_IssueQueueMem(
    .Clk               ( Clk                  ),
    .Rest              ( Rest                 ),
    .MemQStop          ( MemQStop             ),
    .MemQFlash         ( MemQFlash            ),
    .MemReq            ( MemReq               ),
    .InIQInstNum       ( AddMemNum            ),
    .MIn1Src1Able      ( BYTToIQ1Sr1Able      ),
    .MIn1Src1Ready     ( BYTToIQ1Sr1Ready     ),
    .MIn1Src1Addr      ( BYTToIQ1Sr1Num       ),
    .MIn1Src2Able      ( BYTToIQ1Sr2Able      ),
    .MIn1Src2Ready     ( BYTToIQ1Sr2Ready     ),
    .MIn1Src2Addr      ( BYTToIQ1Sr2Num       ),
    .MIn1RdAble        ( BYTToIQ1WAble        ),
    .MIn1RdAddr        ( BYTToIQ1WNum         ),
    .MIn2Src1Able      ( BYTToIQ2Sr1Able      ),
    .MIn2Src1Ready     ( BYTToIQ2Sr1Ready     ),
    .MIn2Src1Addr      ( BYTToIQ2Sr1Num       ),
    .MIn2Src2Able      ( BYTToIQ2Sr2Able      ),
    .MIn2Src2Ready     ( BYTToIQ2Sr2Ready     ),
    .MIn2Src2Addr      ( BYTToIQ2Sr2Num       ),
    .MIn2RdAble        ( BYTToIQ2WAble        ),
    .MIn2RdAddr        ( BYTToIQ2WNum         ),
    .MIn3Src1Able      ( BYTToIQ3Sr1Able      ),
    .MIn3Src1Ready     ( BYTToIQ3Sr1Ready     ),
    .MIn3Src1Addr      ( BYTToIQ3Sr1Num       ),
    .MIn3Src2Able      ( BYTToIQ3Sr2Able      ),
    .MIn3Src2Ready     ( BYTToIQ3Sr2Ready     ),
    .MIn3Src2Addr      ( BYTToIQ3Sr2Num       ),
    .MIn3RdAble        ( BYTToIQ3WAble        ),
    .MIn3RdAddr        ( BYTToIQ3WNum         ),
    .MIn4Src1Able      ( BYTToIQ4Sr1Able      ),
    .MIn4Src1Ready     ( BYTToIQ4Sr1Ready     ),
    .MIn4Src1Addr      ( BYTToIQ4Sr1Num       ),
    .MIn4Src2Able      ( BYTToIQ4Sr2Able      ),
    .MIn4Src2Ready     ( BYTToIQ4Sr2Ready     ),
    .MIn4Src2Addr      ( BYTToIQ4Sr2Num       ),
    .MIn4RdAble        ( BYTToIQ4WAble        ),
    .MIn4RdAddr        ( BYTToIQ4WNum         ),
    .MIn1aAble         ( DcdToMem1Able        ),
    .MIn1MicOpcode     ( DcdToIQ1MicOp        ),
    .MIn1ImmAble       ( DcdToIQ1ImAble       ),
    .MIn1ImmDate       ( DcdToIQ1ImDate       ),
    .MIn1RobPtr        ( MIn1RobPtr           ),
    .MIn2aAble         ( DcdToMem2Able        ),
    .MIn2MicOpcode     ( DcdToIQ2MicOp        ),
    .MIn2ImmAble       ( DcdToIQ2ImAble       ),
    .MIn2ImmDate       ( DcdToIQ2ImDate       ),
    .MIn2RobPtr        ( MIn2RobPtr           ),
    .MIn3aAble         ( DcdToMem3Able        ),
    .MIn3MicOpcode     ( DcdToIQ4MicOp        ),
    .MIn3ImmAble       ( DcdToIQ4ImAble       ),
    .MIn3ImmDate       ( DcdToIQ4ImDate       ),
    .MIn3RobPtr        ( MIn3RobPtr           ),
    .MIn4aAble         ( DcdToMem4Able        ),
    .MIn4MicOpcode     ( DcdToIQ4MicOp        ),
    .MIn4ImmAble       ( DcdToIQ4ImAble       ),
    .MIn4ImmDate       ( DcdToIQ4ImDate       ),
    .MIn4RobPtr        ( MIn4RobPtr           ),
    .LoadReq           ( LoadToIQReq          ),
    .StoreReq          ( StoreTOIQReq         ),
    .FromBCQBru        ( BrToOtherAble        ),
    .FromBruAddr       ( BrToOtherAddr        ),
    .FromBCQCsr        ( CsrToOtherAble       ),
    .FromCsrAddr       ( CsrToOtherAddr       ),
    .FromIsQAlu1       ( Alu1ToOtherAble      ),
    .FromAlu1Addr      ( Alu1ToOtherNum       ),
    .FromIsQAlu2       ( Alu2ToOtherAble      ),
    .FromAlu2Addr      ( Alu2ToOtherNum       ),
    .FromIsQMul        ( MulToOtherAble       ),
    .FromMulAddr       ( MulToOtherNum        ),
    .ByPassMDiv        ( ByPassDivAble        ),
    .ByPassMDivAddr    ( ByPassDivAddr        ),
    .ByPassMLoad       ( ByPassLoadAble       ),
    .ByPassMLoadAddr   ( ByPassLoadNum        ),
    .ByPassMSC         ( ByPassSCAble         ),
    .ByPassMSCAddr     ( ByPassSCNum          ),
    .MInst1MicOperate  ( MemToLS1MicOp        ),
    .MInst1Src1RAble   ( MemToLS1Sr1Able      ),
    .MInst1Src1RAddr   ( MemToLS1Sr1Num       ),
    .MInst1Src2RAble   ( MemToLS1Sr2Able      ),
    .MInst1Src2RAddr   ( MemToLS1Sr2Num       ),
    .MInst1ImmAble     ( MemToLS1ImAble       ),
    .MInst1ImmDate     ( MemToLS1ImDate       ),
    .MInst1RdAble      ( MemToLS1RdAble       ),
    .MInst1RdAddr      ( MemToLS1RdNum        ),
    .MInst1RoBptr      ( MemToLS1RobPtr       ),
    .MInst2MicOperate  ( MemToLS2MicOp        ),
    .MInst2Src1RAble   ( MemToLS2Sr1Able      ),
    .MInst2Src1RAddr   ( MemToLS2Sr1Num       ),
    .MInst2Src2RAble   ( MemToLS2Sr2Able      ),
    .MInst2Src2RAddr   ( MemToLS2Sr2Num       ),
    .MInst2ImmAble     ( MemToLS2ImAble       ),
    .MInst2ImmDate     ( MemToLS2ImDate       ),
    .MInst2RdAble      ( MemToLS2RdAble       ),
    .MInst2RdAddr      ( MemToLS2RdNum        ),
    .MInst2RoBptr      ( MemToLS2RobPtr       )
    );

    PhysicalRegFile u_PhysicalRegFile(
    .Clk                ( Clk                ),
    .Rest               ( Rest               ),
    .PhysicalStop       ( PhysicalStop       ),
    .ReloadPhy          ( ArchSToPhyReload   ),
    .Are1MapPregNum     ( ArchSToPhy1Num     ),
    .Are2MapPregNum     ( ArchSToPhy2Num     ),
    .Are3MapPregNum     ( ArchSToPhy3Num     ),
    .Are4MapPregNum     ( ArchSToPhy4Num     ),
    .Are5MapPregNum     ( ArchSToPhy5Num     ),
    .Are6MapPregNum     ( ArchSToPhy6Num     ),
    .Are7MapPregNum     ( ArchSToPhy7Num     ),
    .Are8MapPregNum     ( ArchSToPhy8Num     ),
    .Are9MapPregNum     ( ArchSToPhy9Num     ),
    .Are10MapPregNum    ( ArchSToPhy10Num    ),
    .Are11MapPregNum    ( ArchSToPhy11Num    ),
    .Are12MapPregNum    ( ArchSToPhy12Num    ),
    .Are13MapPregNum    ( ArchSToPhy13Num    ),
    .Are14MapPregNum    ( ArchSToPhy14Num    ),
    .Are15MapPregNum    ( ArchSToPhy15Num    ),
    .Are16MapPregNum    ( ArchSToPhy16Num    ),
    .Are17MapPregNum    ( ArchSToPhy17Num    ),
    .Are18MapPregNum    ( ArchSToPhy18Num    ),
    .Are19MapPregNum    ( ArchSToPhy19Num    ),
    .Are20MapPregNum    ( ArchSToPhy20Num    ),
    .Are21MapPregNum    ( ArchSToPhy21Num    ),
    .Are22MapPregNum    ( ArchSToPhy22Num    ),
    .Are23MapPregNum    ( ArchSToPhy23Num    ),
    .Are24MapPregNum    ( ArchSToPhy24Num    ),
    .Are25MapPregNum    ( ArchSToPhy25Num    ),
    .Are26MapPregNum    ( ArchSToPhy26Num    ),
    .Are27MapPregNum    ( ArchSToPhy27Num    ),
    .Are28MapPregNum    ( ArchSToPhy28Num    ),
    .Are29MapPregNum    ( ArchSToPhy29Num    ),
    .Are30MapPregNum    ( ArchSToPhy30Num    ),
    .Are31MapPregNum    ( ArchSToPhy31Num    ),
    .Are32MapPregNum    ( ArchSToPhy32Num    ),
    .WriteBackAlu1      ( Alu1ToPhyAble      ),
    .WriteBackAlu1Addr  ( Alu1ToPhyAddr      ),
    .WriteBackAlu1Date  ( Alu1ToPhyDate      ),
    .WriteBackAlu2      ( Alu2ToPhyAble      ),
    .WriteBackAlu2Addr  ( Alu2ToPhyAddr      ),
    .WriteBackAlu2Date  ( Alu2ToPhyDate      ),
    .WriteBackDiv       ( DivToPhyAble       ),
    .WriteBackDivAddr   ( DivToPhyAddr       ),
    .WriteBackDivDate   ( DivToPhyDate       ),
    .WriteBackMul       ( MulToPhyAble       ),
    .WriteBackMulAddr   ( MulToPhyAddr       ),
    .WriteBackMulDate   ( MulToPhyDate       ),
    .WriteBackCsru      ( CsruToPhyAble      ),
    .WriteBackCsruAddr  ( CsruToPhyAddr      ),
    .WriteBackCsruDate  ( CsruToPhyDate      ),
    .WriteBackBru       ( BruToPhyAble       ),
    .WriteBackBruAddr   ( BruToPhyAddr       ),
    .WriteBackBruDate   ( BruToPhyDate       ),
    .WriteBackLsu       ( LsuToPhyAble       ),
    .WriteBackLsuAddr   ( LsuToPhyAddr       ),
    .WriteBackLsuDate   ( LsuToPhyDate       ),
    .WriteBackROB       ( RobToPhyAble       ),
    .WriteBackROBAddr   ( RobToPhyAddr       ),
    .WriteBackROBDate   ( RobToPhyDate       ),
    .Read11Able         ( IntToEX1Sr1Able    ),
    .Read11Addr         ( IntToEX1Sr1Num     ),
    .Read11Date         ( PhyToEuDate11      ),
    .Read12Able         ( IntToEX1Sr2Able    ),
    .Read12Addr         ( IntToEX1Sr2Num     ),
    .Read12Date         ( PhyToEuDate12      ),
    .Read21Able         ( IntToEX2Sr1Able    ),
    .Read21Addr         ( IntToEX2Sr1Num     ),
    .Read21Date         ( PhyToEuDate21      ),
    .Read22Able         ( IntToEX2Sr2Able    ),
    .Read22Addr         ( IntToEX2Sr2Num     ),
    .Read22Date         ( PhyToEuDate22      ),
    .Read31Able         ( IntToEX3Sr1Able    ),
    .Read31Addr         ( IntToEX3Sr1Num     ),
    .Read31Date         ( PhyToEuDate31      ),
    .Read32Able         ( IntToEX3Sr2Able    ),
    .Read32Addr         ( IntToEX3Sr2Num     ),
    .Read32Date         ( PhyToEuDate32      ),
    .Read41Able         ( IntToEX4Sr1Able    ),
    .Read41Addr         ( IntToEX4Sr1Num     ),
    .Read41Date         ( PhyToEuDate41      ),
    .Read42Able         ( IntToEX4Sr2Able    ),
    .Read42Addr         ( IntToEX4Sr2Num     ),
    .Read42Date         ( PhyToEuDate42      ),
    .Read51Able         ( BrCsrTo1EUSr1A     ),
    .Read51Addr         ( BrCsrTo1EUSr1Num   ),
    .Read51Date         ( PhyToEuDate51      ),
    .Read52Able         ( BrCsrTo1EUSr2A     ),
    .Read52Addr         ( BrCsrTo1EUSr2Num   ),
    .Read52Date         ( PhyToEuDate52      ),
    .Read61Able         ( BrCsrTo2EUSr1A     ),
    .Read61Addr         ( BrCsrTo2EUSr1Num   ),
    .Read61Date         ( PhyToEuDate61      ),
    .Read62Able         ( BrCsrTo2EUSr2A     ),
    .Read62Addr         ( BrCsrTo2EUSr2Num   ),
    .Read62Date         ( PhyToEuDate62      ),
    .Read71Able         ( MemToLS1Sr1Able    ),
    .Read71Addr         ( MemToLS1Sr1Num     ),
    .Read71Date         ( PhyToEuDate71      ),
    .Read72Able         ( MemToLS1Sr2Able    ),
    .Read72Addr         ( MemToLS1Sr2Num     ),
    .Read72Date         ( PhyToEuDate72      ),
    .Read81Able         ( MemToLS2Sr1Able    ),
    .Read81Addr         ( MemToLS2Sr1Num     ),
    .Read81Date         ( PhyToEuDate81      ),
    .Read82Able         ( MemToLS2Sr2Able    ),
    .Read82Addr         ( MemToLS2Sr2Num     ),
    .Read82Date         ( PhyToEuDate82      ),
    );

    Mmu u_Mmu(
    .Clk               ( Clk               ),
    .Rest              ( Rest              ),
    .MmuFlash          ( MmuFlash          ),
    .MmuStop           ( MmuStop           ),
    .Asid              ( CstToMmuAsidDate  ),
    .CsrDmw0Date       ( CsrToMmuDmw0Date  ),
    .CsrDmw1Date       ( CsrToMmuDmw1Date  ),
    .CsrCrmdDate       ( CsrToMmuCrmdDate  ),
    .CsrReadTlbAddr    ( CsrToMmuRTAddr    ),
    .CsrReadTlbDate    ( MmuToCsrRTDate    ),
    .CsrSerchTlbAble   ( CsrToMmuSTAble    ),
    .CsrSerchInfrom    ( CsrToMmuSTInfo    ),
    .CsrSerchAble      ( CsrToMmuSAble     ),
    .CsrSerchIdxDate   ( CsrToMmuSIndex    ),
    .CsrWriteTlbAble   ( CsrToMmuWTAble    ),
    .CsrWriteTlbAddr   ( CsrToMmuWTAddr    ),
    .CsrWriteTlbDate   ( CsrToMmuWTDate    ),
    .CsrInvEn          ( CsrToMmuInvEn     ),
    .CsrInvOp          ( CsrToMmuInvOp     ),
    .CsrInvAsid        ( CsrToMmuInvAsid   ),
    .CsrInvVppn        ( CsrToMmuInvVppn   ),
    .InstFetch         ( InstToMmuFetch    ),
    .InstVritualA      ( InstToMmuVA       ),
    .InstOperType      ( MmuToInstOpType   ),
    .InstTlbTrap       ( MmuToInstTrap     ),
    .InstTlbTrapType   ( MmuToInstTrapCode ),
    .InstPhysicalAddr  ( MmuToInstPA       ),
    .LoadAccess        ( LoadToMmuAccess   ),
    .LoadVritualA      ( LoadToMmuVA       ),
    .LoadOperType      ( MmuToLoadOpType   ),
    .LoadTlbTrap       ( MmuToLoadTrap     ),
    .LoadTlbTrapType   ( MmuToLoadTrapCode ),
    .LoadPhysicalAddr  ( MmuToLoadPA       ),
    .StoreAccess       ( StoreToMmuAccess  ),
    .StoreVritualA     ( StoreToMmuVA      ),
    .StoreOperType     ( MmuToStoreOpType  ),
    .StoreTlbTrap      ( MmuToStoreTrap    ),
    .StoreTlbTrapType  ( MmuToStoreTrapCode),
    .StorePhysicalAddr ( MmuToStorePA      )
    );




    Alu u_Alu1(
    .Clk            ( Clk            ),
    .Rest           ( Rest           ),
    .AluStop        ( AluStop        ),
    .AluFlash       ( AluFlash       ),
    .AluInstPc      ( AluInstPc      ),
    .AluMicOperate  ( IntToEX1MicOp  ),
    .AluSrc1Able    ( IntToEX1Sr1Able),
    .AluSrc1Addr    ( IntToEX1Sr1Num ),
    .AluSrc1Date    ( PhyToEuDate11  ),
    .AluSrc2Able    ( IntToEX1Sr2Able),
    .AluSrc2Addr    ( IntToEX1Sr2Num ),
    .AluSrc2Date    ( PhyToEuDate12  ),
    .AluImmDate     ( IntToEx1ImmDate),
    .AluRdAble      ( IntToEX1RdAble ),
    .AluRdAddr      ( IntTOEx1RdNum  ),
    .AluROBPtr      ( IntToEX1RobPtr      ),
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

    Alu u_Alu2(
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