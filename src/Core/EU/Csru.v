`timescale 1ps/1ps
`include "../define.v"

module Csru (
    input        wire                                     Clk            ,
    input        wire                                     Rest           ,

    input        wire                                     CsruStop       ,
    input        wire                                     CsruFlash      ,

    //input from RS order
    input        wire                                     InInstAble     ,
    input        wire      [`InstAddrBus]                 InstVritualPc  ,
    input        wire      [`MicOperateCode]              CsrMicOpCOde   ,
    input        wire                                     ArchRegAble0   ,
    input        wire      [`ReNameRegBUs]                ArchRegNum0    ,
    input        wire      [`DataBus]                     ArchRegDate0   ,
    input        wire                                     ArchRegAble1   ,
    input        wire      [`ReNameRegBUs]                ArchRegNum1    ,
    input        wire                                     ArchRdAble     ,
    input        wire      [`ReNameRegBUs]                ArchRdAddr     ,
    input        wire      [`DataBus]                     ArchRegDate1   ,
    input        wire      [13:0]                         CsrNum         ,
    input        wire      [5:0]                          InstRobPtr     ,
    //to  CsrBrIQ
    output       wire                                     CsrReq         ,
    //write physical regfile
    output       wire                                     WriteBackAble  ,
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
    //from ROB
    input        wire                                     InstRetireAble  ,
    input        wire      [7:0]                          InstRetireCode  ,
    //csr
    input        wire      [`DataBus]                     CrmdData        ,
    input        wire      [`DataBus]                     EraDate         ,
    input        wire      [`DataBus]                     EstatDate       ,
    input        wire      [9:0]                          AsidDate        ,
    input        wire      [18:0]                         TlbEhiDate      ,
    input        wire      [5:0]                          TlbIndex        ,
    input        wire      [5:0]                          TlbEcode        ,
    input        wire                                     TlbNe           ,
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
    //bypass other eu
    input        wire                                     CsrSelfAble     ,
    input        wire      [`ReNameRegBUs]                CsrSelfAddr     ,
    input        wire      [`DataBus]                     CsrSelfDate     ,
    input        wire                                     CsrAlu1Able     ,
    input        wire      [`ReNameRegBUs]                CsrAlu1Addr     ,
    input        wire      [`DataBus]                     CsrAlu1Date     ,
    input        wire                                     CsrAlu2Able     ,
    input        wire      [`ReNameRegBUs]                CsrAlu2Addr     ,
    input        wire      [`DataBus]                     CsrAlu2Date     ,
    input        wire                                     CsrMulAble      ,
    input        wire      [`ReNameRegBUs]                CsrMulAddr      ,
    input        wire      [`DataBus]                     CsrMulDate      ,
    input        wire                                     CsrBruAble      ,
    input        wire      [`ReNameRegBUs]                CsrBruAddr      ,
    input        wire      [`DataBus]                     CsrBruDate     
);

    wire  [`DataBus] ASrc1Date   =  ((ArchRegNum0 == CsrSelfAddr) & CsrSelfAble & ArchRegAble0) ? CsrSelfDate :
                                    ((ArchRegNum0 == CsrBruAddr ) & CsrBruAble  & ArchRegAble0) ? CsrBruDate  :
                                    ((ArchRegNum0 == CsrAlu2Addr) & CsrAlu2Able & ArchRegAble0) ? CsrAlu2Date :
                                    ((ArchRegNum0 == CsrMulAddr ) & CsrMulAble  & ArchRegAble0) ? CsrMulDate  :
                                    ((ArchRegNum0 == CsrAlu1Addr) & CsrAlu1Able & ArchRegAble0) ? CsrAlu1Date : ArchRegDate0 ;
    
    wire  [`DataBus] ASrc2Date   =  ((ArchRegNum1 == CsrSelfAddr) & CsrSelfAble & ArchRegAble1) ? CsrSelfDate :
                                    ((ArchRegNum1 == CsrBruAddr ) & CsrBruAble  & ArchRegAble1) ? CsrBruDate  :
                                    ((ArchRegNum1 == CsrAlu2Addr) & CsrAlu2Able & ArchRegAble1) ? CsrAlu2Date :
                                    ((ArchRegNum1 == CsrMulAddr ) & CsrMulAble  & ArchRegAble1) ? CsrMulDate  :
                                    ((ArchRegNum1 == CsrAlu1Addr) & CsrAlu1Able & ArchRegAble1) ? CsrAlu1Date : ArchRegDate1 ;

    assign  CsrReq = (CSRUREGTEMP[92] == `AbleValue) | (InstRetireAble) ;

    reg   [100:0] CSRUREGTEMP ;
    reg   [5:0]    CstToRobPtr ;
    reg            CsruTrapAble;
    reg   [6:0]    CsruTrapCode;
    reg   [`InstAddrBus] CsruTrapAddr ;
    reg            CsruIdle    ;

    always @(posedge Clk) begin
        if(!Rest) begin
            CSRUREGTEMP <= 101'd0       ;
            CsruTrapAble<= `EnableValue;
            CstToRobPtr <= 6'd0        ;
            CsruTrapCode<= 7'b0        ;
            CsruIdle    <= 1'b0        ;
            CsruTrapAddr<= 32'd0       ;
        end
        else if(CsruStop)begin
            CSRUREGTEMP <= CSRUREGTEMP  ;
            CsruTrapAble<= CsruTrapAble ;
            CstToRobPtr <= CstToRobPtr  ;
            CsruTrapCode<= CsruTrapCode ;
            CsruIdle    <= CsruIdle     ;
            CsruTrapAddr<= CsruTrapAddr ;
        end
        else if(CsruFlash) begin
            CSRUREGTEMP <= 101'd0       ;
            CsruTrapAble<= `EnableValue;
            CstToRobPtr <= 6'd0        ;
            CsruTrapCode<= 7'b0        ;
            CsruIdle    <= 1'b0        ;
            CsruTrapAddr<= 32'd0       ;
        end 
        else if(InInstAble) begin
            CSRUREGTEMP <= {ArchRdAddr, ArchRdAddr, `AbleValue, CsrNum, InstRobPtr, CsrMicOpCOde, ASrc1Date, ASrc2Date} ;
            CstToRobPtr <= InstRobPtr   ;
            case (CsrMicOpCOde)
                `InstCsrrd, `InstCsrwr, `InstCsrxchg, `InstCacop, `InstTlbsrchr, `InstTlbsrchw, 
                `InstTlbrd, `InstTlbwr, `InstTlbfill,`InstInvtlb : begin     
                            CsruTrapAble <= (CrmdData[`PLV] == 2'd0 & CrmdData[`IE]) ? `AbleValue : `EnableValue; 
                            CsruTrapCode <= (CrmdData[`PLV] == 2'd3) ? 7'b0 : `PPI              ;   
                            CsruTrapAddr <= (CrmdData[`PLV] == 2'd3) ? `ZeorDate : InstVritualPc; 
                            CsruIdle     <= `EnableValue     ;
                        end 
                `InstEntry : begin
                            CsruTrapAble <= CrmdData[`IE] ? `AbleValue : `EnableValue           ;
                            CsruTrapCode <= (CrmdData[`PLV] == 2'd3) ? 7'b0 : `PPI              ;
                            CsruTrapAddr <= (CrmdData[`PLV] == 2'd3) ? EraDate : InstVritualPc  ;
                            CsruIdle     <= `EnableValue  ;
                        end 
                `InstIdle : begin
                            CsruTrapAble <= `AbleValue ; 
                            CsruTrapCode <= (CrmdData[`PLV] == 2'd3) ? 7'b0 : `PPI              ;   
                            CsruTrapAddr <= (CrmdData[`PLV] == 2'd3) ? `ZeorDate : InstVritualPc; 
                            CsruIdle     <= `AbleValue    ;
                        end 
                `InstSyscall : begin
                            CsruTrapAble <= CrmdData[`IE] ? `AbleValue : `EnableValue           ;
                            CsruTrapCode <= (CrmdData[`PLV] == 2'd3) ? `SYS : `PPI              ;   
                            CsruTrapAddr <= (CrmdData[`PLV] == 2'd3) ? EraDate : InstVritualPc  ; 
                            CsruIdle     <= `EnableValue  ;
                        end 
                `InstBreak
                        : begin
                            CsruTrapAble <= CrmdData[`IE] ? `AbleValue : `EnableValue           ;
                            CsruTrapCode <= (CrmdData[`PLV] == 2'd3) ? `BRK : `PPI              ;   
                            CsruTrapAddr <= (CrmdData[`PLV] == 2'd3) ? EraDate : InstVritualPc  ; 
                            CsruIdle     <= `EnableValue  ;
                        end         
                default: begin
                    CsruTrapAble <= `EnableValue           ;
                    CsruTrapCode <= 7'd0                   ;
                    CsruTrapAddr <= 32'd0                  ;
                    CsruIdle     <= `EnableValue           ;
                end
            endcase
        end
        else if(InstRetireAble &&  (InstRetireCode == CSRUREGTEMP[71:64])) begin
            CSRUREGTEMP <= 101'd0 ;
            CstToRobPtr <= 6'd0  ;
            CsruTrapAble <= `EnableValue           ;
            CsruTrapCode <= 7'd0                   ;
            CsruTrapAddr <= 32'd0                  ;
            CsruIdle     <= `EnableValue           ;
        end
    end

    //wire  sysOperate          since syscall and break no operate when after retire
    wire  CsrrdOperate    = (InstRetireAble & (CSRUREGTEMP[71:64] == `InstCsrrd))     ;
    wire  CsrwrOperate    = (InstRetireAble & (CSRUREGTEMP[71:64] == `InstCsrwr))     ;
    wire  CsrxchgOperate  = (InstRetireAble & (CSRUREGTEMP[71:64] == `InstCsrxchg))   ;
    wire  TlbsrchrOperate = (InstRetireAble & (CSRUREGTEMP[71:64] == `InstTlbsrchr))  ;
    wire  TlbsrchwOperate = (InstRetireAble & (CSRUREGTEMP[71:64] == `InstTlbsrchw))  ;
    wire  TlbrdOperate    = (InstRetireAble & (CSRUREGTEMP[71:64] == `InstTlbrd))     ;
    wire  TlbwrOperate    = (InstRetireAble & (CSRUREGTEMP[71:64] == `InstTlbwr))     ;
    wire  TlbfillOperate  = (InstRetireAble & (CSRUREGTEMP[71:64] == `InstTlbfill))   ;
    wire  InvtlbOperate   = (InstRetireAble & (CSRUREGTEMP[71:64] == `InstInvtlb))    ;
    wire  ErtnOperate     = (InstRetireAble & (CSRUREGTEMP[71:64] == `InstEntry))     ;

    //csr read 
    wire CsrReadAble = (CsrrdOperate | CsrwrOperate | CsrxchgOperate) & ~InstRetireAble  ;
    wire CsrReadAddr = CSRUREGTEMP[91:78] ;
    assign ReadCsrAble = CsrReadAble ;
    assign ReadCsrAddr = CsrReadAddr ;

    //csr witre 
    wire  CsrWriteAble = (CsrwrOperate | CsrxchgOperate | ErtnOperate | TlbsrchwOperate) & InstRetireAble ;
    wire  CsrWriteAddr = CSRUREGTEMP[91:78] ;
    wire  CsrWriteDate = CSRUREGTEMP[63:32] ; //sr2
    assign WriteCsrAble = CsrWriteAble ;
    assign WriteCsrAddr = CsrWriteAddr ;
    assign WriteCsrDate = CsrWriteDate ;

    //tlb read 
    wire TlbReadAble        = TlbrdOperate ;
    wire [5:0]  TlbReadaddr = TlbIndex     ;
    assign ReadMmuAble = TlbReadAble ;
    assign ReadMmuAddr = TlbReadaddr ;

    //tlb serch 
    wire TlbSerch              = TlbsrchrOperate ;
    wire [28:0] TlbSerchinform = {AsidDate, TlbEhiDate};
    assign SerchMmuAble = TlbSerch ;
    assign SerchMmuInfr = TlbSerchinform ;

    //tlb write 
    wire TlbWriteAble = (TlbwrOperate | TlbfillOperate) & InstRetireAble ;
    wire [5:0] tlbWriteAddr = TlbwrOperate ? TlbIndex : 6'd33 ;
    wire [] TlbWriteDate = (TlbEcode == 6'h3f) ? 
  
endmodule