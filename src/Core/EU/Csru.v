`timescale 1ps/1ps
`include "../define.v"

module Csru (
    input        wire                                     Clk            ,
    input        wire                                     Rest           ,
    //input from RS order
    input        wire                                     InInstAble     ,
    input        wire      [`InstAddrBus]                 InstVritualPc  ,
    input        wire      [`MicOperateCode]              CsrMicOpCOde   ,
    input        wire      [`DataBus]                     ArchRegDate0   ,
    input        wire      [`DataBus]                     ArchRegDate1   ,
    input        wire      [13:0]                         CsrNum         ,
    input        wire      [5:0]                          InstRobPtr     ,
    //to 
    output       wire                                     CsruFree       ,
    //write physical regfile
    output       wire      [`DataBus]                     WriteBackDate  ,
    output       wire      [`ReNameRegBUs]                WriteBackAddr  , 
    //to ROB
    output       wire                                     ToRobInterrupt  ,//中断选择指令赋予
    output       wire      [6:0]                          ToRobCode       ,
    output       wire                                     ToRobLlbetlKlo  ,

    output       wire                                     InstReadyAble   ,
    output       wire      [5:0]                          InstReadyPtr    ,
    output       wire                                     InstReDirectAble,//系统调用
    output       wire                                     InstReDriectEntry,
    output       wire                                     InstReDirectIdle,
    output       wire      [6:0]                          InstReDirectCode,
    output       wire      [`InstAddrBus]                 InstReDirectAddr,
    // from ROB
    input        wire                                     InstRetireAble  ,
    input        wire      [7:0]                          InstRetireCode  ,
    //csr
    input        wire      [`DataBus]                     CrmdData        ,
    input        wire      [`DataBus]                     EraDate         ,
    input        wire      [`DataBus]                     EstatDate       ,
    //read Csr
    output       wire                                     ReadCsrAble     ,
    output       wire      [13:0]                         ReadCsrAddr     ,
    input        wire      [`DataBus]                     ReadCsrDate     ,
    //write Csr
    output       wire                                     WriteCsrAble    ,
    output       wire      [13:0]                         WriteCsrAddr    ,
    output       wire      [`DataBus]                     WriteCsrDate    ,
    //direct use csr
    input        wire      [`DataBus]                     IndexDate       ,
    output       wire                                     WIndexAble      ,
    output       wire      [`DataBus]                     WIndexMask      ,
    output       wire      [`DataBus]                     WIndexDate      ,
    input        wire      [`DataBus]                     TlbehiDate      ,
    output       wire                                     WEhiTLBAble     ,
    output       wire      [`DataBus]                     WEhiTLBMask     ,
    output       wire      [`DataBus]                     WEhiTLBDate     ,
    input        wire      [`DataBus]                     Elo0TLBDate     ,
    output       wire                                     WElo0TLBAble    ,
    output       wire      [`DataBus]                     WElo0TLBMask    ,
    output       wire      [`DataBus]                     WElo0TLBDate    ,
    input        wire      [`DataBus]                     Elo1TLBDate     ,
    output       wire                                     WElo1TLBAble    ,
    output       wire      [`DataBus]                     WElo1TLBMask    ,
    output       wire      [`DataBus]                     WElo1TLBDate    ,
    input        wire      [`DataBus]                     AsidTLBDate     ,
    output       wire                                     WAsidTLBAble    ,
    output       wire      [`DataBus]                     WAsidTLBMask    ,
    output       wire      [`DataBus]                     WAsidTLBDate    ,
    //read MMU
    output       wire                                     ReadMmuAble     ,
    output       wire      [5:0]                          ReadMmuAddr     ,
    input        wire      [89-1:0]                       ReadMmuDate     ,
    //write MMU 
    output       wire                                     WriteMmuAble    ,
    output       wire      [5:0]                          WriteMmuAddr    ,
    output       wire      [89-1:0]                       WriteMmuDate    ,
    //serch MMU
    output       wire                                     SerchMmuAble    ,
    output       wire      [28:0]                         SerchMmuInfr    ,
    input        wire                                     SerchSuccess    ,
    input        wire      [13:0]                         SerchIndexDate  ,                                         
    //from ctrlblock
    input        wire                                     CsruStop        ,
    input        wire                                     CsruFlash       
    
);

    reg   [93-1:0] CSRUREGTEMP ;
    reg            CsruUnFree  ;
    reg            InstAbleReg ;
    reg   [5:0]    InstPtrReg  ;
    reg                  ReDirectAbleReg ;
    reg                  ReDriectEntryReg;
    reg                  ReDirectIdleReg ;
    reg   [6:0]          ReDirectCodeReg ;
    reg   [`InstAddrBus] ReDirectAddrReg ;

    //wire  [`DataBus]     CrmdData ; 
    //wire  [`DataBus]     EraDate  ;
    //wire  [`DataBus]     EstatDate;

    always @(posedge Clk) begin
        if(!Rest) begin
            CSRUREGTEMP <= 72'd0 ;
            CsruUnFree  <= `AbleValue  ;
            InstAbleReg <= `EnableValue;
            InstPtrReg  <= 6'b0  ;
            ReDirectAbleReg <= `EnableValue ;
            ReDriectEntryReg <= `EnableValue ;
            ReDirectIdleReg <= `EnableValue ;
            ReDirectCodeReg <= 7'b0  ;
            ReDirectAddrReg <= `ZeorDate ;
        end
        else if(CsruStop)begin
            CSRUREGTEMP <= CSRUREGTEMP ;
            CsruUnFree  <= `EnableValue ;
            InstAbleReg <= InstAbleReg ;
            InstPtrReg <= InstPtrReg ;
            ReDirectAbleReg <= ReDirectAbleReg ;
            ReDriectEntryReg <=ReDriectEntryReg;
            ReDirectIdleReg <= ReDirectIdleReg ;
            ReDirectCodeReg <= ReDirectCodeReg ;
            ReDirectAddrReg <= ReDirectAddrReg ;
        end
        else if(CsruFlash) begin
            CSRUREGTEMP <= 72'd0 ;
            CsruUnFree  <= `AbleValue  ;
            InstAbleReg <= `EnableValue;
            InstPtrReg  <= 6'b0  ;
            ReDirectAbleReg <= `EnableValue ;
            ReDriectEntryReg <= `EnableValue ;
            ReDirectIdleReg <= `EnableValue ;
            ReDirectCodeReg <= 7'b0  ;
            ReDirectAddrReg <= `ZeorDate ;
        end 
        else if(InInstAble) begin
            CSRUREGTEMP <= {CsrNum, InstRobPtr, CsrMicOpCOde, ArchRegDate0, ArchRegDate1} ;
            CsruUnFree  <= `EnableValue ;
            InstAbleReg <= `AbleValue   ;
            InstPtrReg  <= InstRobPtr   ;
            case (CsrMicOpCOde)
                `InstCsrrd, `InstCsrwr, `InstCsrxchg, `InstCacop, `InstTlbsrchr, `InstTlbsrchw, 
                `InstTlbrd, `InstTlbwr, `InstTlbfill,`InstInvtlb : begin     
                            ReDirectAbleReg <= (CrmdData[`PLV] == 2'd0 & CrmdData[`IE]) ? `AbleValue : `EnableValue; 
                            ReDirectCodeReg <= (CrmdData[`PLV] == 2'd3) ? 7'b0 : `PPI              ;   
                            ReDirectAddrReg <= (CrmdData[`PLV] == 2'd3) ? `ZeorDate : InstVritualPc; 
                            ReDriectEntryReg <= `EnableValue ;
                            ReDirectIdleReg <= `EnableValue  ;
                        end 
                `InstEntry : begin
                            ReDirectAbleReg <= CrmdData[`IE] ? `AbleValue : `EnableValue           ;
                            ReDirectCodeReg <= (CrmdData[`PLV] == 2'd3) ? 7'b0 : `PPI              ;
                            ReDirectAddrReg <= (CrmdData[`PLV] == 2'd3) ? EraDate : InstVritualPc  ;
                            ReDriectEntryReg <= CrmdData[`IE] ? `AbleValue : `EnableValue          ; 
                            ReDirectIdleReg <= `EnableValue  ;
                        end 
                `InstIdle : begin
                            ReDirectAbleReg <= `AbleValue ; 
                            ReDirectCodeReg <= (CrmdData[`PLV] == 2'd3) ? 7'b0 : `PPI              ;   
                            ReDirectAddrReg <= (CrmdData[`PLV] == 2'd3) ? `ZeorDate : InstVritualPc; 
                            ReDriectEntryReg <= `EnableValue ;
                            ReDirectIdleReg <= `AbleValue    ;
                        end 
                `InstSyscall : begin
                            ReDirectAbleReg <= CrmdData[`IE] ? `AbleValue : `EnableValue           ;
                            ReDirectCodeReg <= (CrmdData[`PLV] == 2'd3) ? `SYS : `PPI              ;   
                            ReDirectAddrReg <= (CrmdData[`PLV] == 2'd3) ? EraDate : InstVritualPc  ; 
                            ReDriectEntryReg <= `EnableValue ;
                            ReDirectIdleReg <= `EnableValue  ;
                        end 
                `InstBreak
                        : begin
                            ReDirectAbleReg <= CrmdData[`IE] ? `AbleValue : `EnableValue           ;
                            ReDirectCodeReg <= (CrmdData[`PLV] == 2'd3) ? `BRK : `PPI              ;   
                            ReDirectAddrReg <= (CrmdData[`PLV] == 2'd3) ? EraDate : InstVritualPc  ; 
                            ReDriectEntryReg <= `EnableValue ;
                            ReDirectIdleReg <= `EnableValue  ;
                        end         
                default: begin
                    CSRUREGTEMP <= 72'd0 ;
                    CsruUnFree  <= `AbleValue  ;
                    InstAbleReg <= `EnableValue;
                    InstPtrReg  <= 6'b0  ;
                    ReDirectAbleReg <= `EnableValue ;
                    ReDriectEntryReg <= `EnableValue ;
                    ReDirectIdleReg <= `EnableValue ;
                    ReDirectCodeReg <= 7'b0  ;
                    ReDirectAddrReg <= `ZeorDate ;
                end
            endcase
        end
        else if(InstRetireAble &&  (InstRetireCode == CSRUREGTEMP[71:64])) begin
            CSRUREGTEMP <= 72'd0 ;
            CsruUnFree  <= `AbleValue  ;
            InstAbleReg <= `EnableValue;
            InstPtrReg  <= 6'b0  ;
            ReDirectAbleReg <= `EnableValue ;
            ReDriectEntryReg <= `EnableValue ;
            ReDirectIdleReg <= `EnableValue ;
            ReDirectCodeReg <= 7'b0  ;
            ReDirectAddrReg <= `ZeorDate ;
        end
    end

    //wire  sysOperate          since syscall and break no operate when after retire
    wire  CsrrdOperate    = (InstRetireAble & (CSRUREGTEMP[71:64] == `InstCsrrd))     ;
    wire  CsrwrOperate   = (InstRetireAble & (CSRUREGTEMP[71:64] == `InstCsrwr))    ;
    //wire  CsrwrwOperate   = (InstRetireAble & (CSRUREGTEMP[71:64] == `InstCsrwrw))    ;
    wire  CsrxchgOperate = (InstRetireAble & (CSRUREGTEMP[71:64] == `InstCsrxchg))  ;
    //wire  CsrxchgwOperate = (InstRetireAble & (CSRUREGTEMP[71:64] == `InstCsrxchgw))  ;
    wire  CacopOperate    = (InstRetireAble & (CSRUREGTEMP[71:64] == `InstCacop))     ;
    wire  TlbsrchrOperate = (InstRetireAble & (CSRUREGTEMP[71:64] == `InstTlbsrchr))  ;
    wire  TlbsrchwOperate = (InstRetireAble & (CSRUREGTEMP[71:64] == `InstTlbsrchw))  ;
    wire  TlbrdOperate   = (InstRetireAble & (CSRUREGTEMP[71:64] == `InstTlbrd))    ;
    //wire  TlbrdwOperate   = (InstRetireAble & (CSRUREGTEMP[71:64] == `InstTlbrdw))    ;
    wire  TlbwrOperate    = (InstRetireAble & (CSRUREGTEMP[71:64] == `InstTlbwr))     ;
    wire  TlbfillOperate  = (InstRetireAble & (CSRUREGTEMP[71:64] == `InstTlbfill))   ;
    wire  InvtlbOperate   = (InstRetireAble & (CSRUREGTEMP[71:64] == `InstInvtlb))    ;
    wire  ErtnOperate     = (InstRetireAble & (CSRUREGTEMP[71:64] == `InstEntry))     ;
    //wire  Idle  Idle no operate

    wire [`DataBus] FromCsrIndex ;
    wire [`DataBus] FromCsrAsid  ;
    wire [`DataBus] FromCsrTlbehi;


    //csr or tlb read 
    wire CsrReadAble = CsrrdOperate | CsrwrOperate | CsrxchgOperate  ;
    wire TlbReadAble = TlbrdOperate ;
    wire TlbSerch    = TlbsrchrOperate ;
    wire [63:0] TlbSerchinform = {FromCsrAsid, FromCsrTlbehi};
    wire [5:0]  TlbReadaddr    = FromCsrIndex[5:0] ;
    wire [13:0] CsrReadAddr =   CsrrdOperate    ? CSRUREGTEMP[92:79]:
                                CsrwrOperate    ? CSRUREGTEMP[92:79]:
                                CsrxchgOperate  ? CSRUREGTEMP[92:79]: 14'd0;

    //csr or tlb write 
    wire CsrWriteAble = CsrwrOperate | CsrxchgOperate | ErtnOperate | TlbsrchwOperate ;
    wire TlbWriteAble = TlbwrOperate | TlbfillOperate ;

    wire CsrWriteAddr = CsrwrOperate       ? CSRUREGTEMP[92:79]: 
                        CsrxchgOperate     ? CSRUREGTEMP[92:79]:
                        ErtnOperate        ? 14'h60            :
                        TlbsrchwOperate    ? 14'h10            : 14'd0 ;

    wire TlbWriteAddr = TlbwrOperate       ? FromCsrIndex[5:0]  :
                        TlbfillOperate     ? CsrMicOpCOde[5:0]  : 6'd0 ; //伪随机
    
  
endmodule