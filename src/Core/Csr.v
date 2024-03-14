`timescale 1ps/1ps
`include "define.v"

module Csr (
    input       wire                                      Clk                ,
    input       wire                                      Rest               ,

    // In From ROB
    input       wire                                      CsrCommitValue     ,

    //wirte Csr
    input       wire      [`MicOperateCode]               CsrMicOperate      ,
    input       wire      [`DataBus]                      ArchRegister1      , //rj
    input       wire      [`DataBus]                      ArchRegister2      , //si12
    input       wire      [13:0]                          CsrNumAddr         ,//CsrNum
    input       wire      [`ReNameRegBUs]                 ReDataAddr         ,
    input       wire                                      KernalInstAble     ,
    // input       wire                                      CsrWAble           ,
    // input       wire        [13:0]                        CsrWAddr           ,
    // input       wire        [31:0]                        CsrWMask           ,  

    //For Instraction Cache
    output      wire                                      CsrICacheAble      ,
    output      wire      [1:0]                           CsrIcacheCode      ,
    output      wire      [`InstAddrBus]                  CsrIcacheVirtuAddr , //direct map
    //For Date Cache                           
    output      wire                                      CsrDCacheAble      ,
    output      wire      [1:0]                           CsrDcacheCode      ,
    output      wire      [`InstAddrBus]                  CsrDcacheVirtuAddr , //direct map
    // For Mmu
    output      wire                                      MmuDCacheAble      ,
    output      wire                                      MmuICacheAble      ,
    output      wire      [`InstAddrBus]                  MmucacheVirtuAddr  ,   
);

    //Csr Operate Queue
    reg  [3:0] CsrQueueFrontPtr ;
    reg  [3:0] CsrQueueEndPtr   ;

    reg  [`MicOperateCode] OperateCode      [0:15];
    //reg  []                CsrOpcode        [0:15];
    reg  [63:0]            ExtendInformation[0:15]; //select max situation

    //about CSR module extend from Load and store alogrim but have some change this place use buffer not queue union buffer
    //for csr wirte 
    reg   [2:0] CsrReadQueuePtr ;
    reg   [2:0] CsrWriteQUeueEnd;


    // //Special Operate Temp
    // localparam NONOP    = 3'b000;
    // localparam TLBSERCH = 3'b001;
    // localparam TLBBRD   = 3'b010;
    // localparam TLBBWR   = 3'b011;
    // localparam TLBFILL  = 3'b100;
    // localparam INVTLB   = 3'b101;
    // localparam ENTRY    = 3'b110;
    // localparam IDLE     = 3'b111;

    // reg   [13:0]            CsrRWAddr;
    // reg   [31:0]            CsrWMask ;
    // reg   [`DataBus]        CsrWData ;
    // reg                     CsrWAble ;
    // reg                     CsrRAble ;
    // reg                     CsrWBAble;
    // reg   [`ReNameRegBUs]   CsrWBAddr;
    // reg   [2:0]             TlbCode  ;
    // // reg   [`DataBus]        CsrWBDate;
    // // reg   [`ReNameRegBUs]   CsrWBAddr;
    // always @(posedge Clk) begin
    //     if(!Rest)begin
    //                 CsrRAble  <= `EnableValue        ;
    //                 CsrWMask  <= `CsrWMaskAll        ;
    //                 CsrRWAddr <= 14'd0               ;
    //                 CsrWBAble <= `EnableValue        ;
    //                 CsrWBAddr <= 8'b00000000         ;
    //                 CsrWAble  <= `EnableValue        ;
    //                 CsrWData  <= `ZeorDate           ;
    //                 TlbCode   <= NONOP               ;
    //                 OperateCode[CsrQueueFrontPtr] <= 8'b00000000      ;
    //                 ExtendInformation[CsrQueueFrontPtr]<= 64'd0       ; 
    //                 CsrQueueFrontPtr <= CsrQueueFrontPtr; 
    //     end
    //     else begin
    //         if (KernalInstAble && (CsrCrmdTemp[1:0] == 2'd3))begin
                
    //         end
    //         case (CsrMicOperate) //此处关于读取CSR的问题这里使用顺序发放入，解析之后存入CSR Queue
    //             `InstCsrrd : begin
    //                 CsrRAble  <= `AbleValue          ;
    //                 CsrWMask  <= ArchRegister2       ;
    //                 CsrRWAddr <= CsrNum              ;
    //                 CsrWBAble <= `AbleValue          ;
    //                 CsrWBAddr <= ReDataAddr          ;
    //                 CsrWAble  <= `EnableValue        ;
    //                 CsrWData  <= `ZeorDate           ;
    //                 TlbCode   <= NONOP               ;
    //                 OperateCode[CsrQueueFrontPtr] <= `InstCsrrd  ;
    //                 ExtendInformation[CsrQueueFrontPtr]<= 64'h0  ;
    //                 if(CsrQueueFrontPtr == 4'd15)
    //                     CsrQueueFrontPtr <= 4'd0     ;
    //                 else 
    //                     CsrQueueFrontPtr <= CsrQueueFrontPtr + 1 ;
    //             end
    //             `InstCsrwr : begin
    //                 CsrRAble  <= `EnableValue        ;
    //                 CsrWMask  <= `CsrWMaskAll        ;
    //                 CsrRWAddr <= CsrNum              ;
    //                 CsrWBAble <= `EnableValue        ;
    //                 CsrWBAddr <= 8'b00000000         ;
    //                 CsrWAble  <= `AbleValue          ;
    //                 CsrWData  <= ArchRegister1       ;
    //                 TlbCode   <= NONOP               ;
    //                 OperateCode[CsrQueueFrontPtr] <= `InstCsrwr        ;
    //                 ExtendInformation[CsrQueueFrontPtr]<= 64'h0        ;
    //                 if(CsrQueueFrontPtr == 4'd15)
    //                     CsrQueueFrontPtr <= 4'd0     ;
    //                 else 
    //                     CsrQueueFrontPtr <= CsrQueueFrontPtr + 1 ;
    //             end
    //             `InstCsrxchg : begin
    //                 CsrRAble  <= `EnableValue        ;
    //                 CsrWMask  <= ArchRegister2       ;
    //                 CsrRWAddr <= CsrNum              ;
    //                 CsrWBAble <= `EnableValue        ;
    //                 CsrWBAddr <= 8'b00000000         ;
    //                 CsrWAble  <= `AbleValue          ;
    //                 CsrWData  <= ArchRegister1       ;
    //                 TlbCode   <= NONOP               ;
    //                 OperateCode[CsrQueueFrontPtr] <= `InstCsrxchg      ;
    //                 ExtendInformation[CsrQueueFrontPtr]<= 64'h0        ;
    //                 if(CsrQueueFrontPtr == 4'd15)
    //                     CsrQueueFrontPtr <= 4'd0     ;
    //                 else 
    //                     CsrQueueFrontPtr <= CsrQueueFrontPtr + 1 ; 
    //             end
    //             `InstCacop : begin
    //                 CsrRAble  <= `EnableValue        ;
    //                 CsrWMask  <= `CsrWMaskAll        ;
    //                 CsrRWAddr <= 13'd0               ;
    //                 CsrWBAble <= `EnableValue        ;
    //                 CsrWBAddr <= 8'b00000000         ;
    //                 CsrWAble  <= `EnableValue        ;
    //                 CsrWData  <= `ZeorDate           ;
    //                 TlbCode   <= NONOP               ;
    //                 OperateCode[CsrQueueFrontPtr] <= `InstCacop        ;
    //                 ExtendInformation[CsrQueueFrontPtr]<= ArchRegister1+ArchRegister2; //[31:0] = va
    //                 if(CsrQueueFrontPtr == 4'd15)
    //                     CsrQueueFrontPtr <= 4'd0     ;
    //                 else 
    //                     CsrQueueFrontPtr <= CsrQueueFrontPtr + 1 ; 
    //             end
    //             `InstTlbsrch : begin
    //                 CsrRAble  <= `EnableValue        ;
    //                 CsrWMask  <= `CsrWMaskAll        ;
    //                 CsrRWAddr <= 14'd0               ;
    //                 CsrWBAble <= `EnableValue        ;
    //                 CsrWBAddr <= 8'b00000000         ;
    //                 CsrWAble  <= `EnableValue        ;
    //                 CsrWData  <= `ZeorDate           ;
    //                 TlbCode   <= TLBSERCH            ;
    //                 OperateCode[CsrQueueFrontPtr] <= `InstTlbsrch      ;
    //                 ExtendInformation[CsrQueueFrontPtr]<= 64'd0        ;
    //                 if(CsrQueueFrontPtr == 4'd15)
    //                     CsrQueueFrontPtr <= 4'd0     ;
    //                 else 
    //                     CsrQueueFrontPtr <= CsrQueueFrontPtr + 1 ; 
    //             end
    //             `InstTlbrd : begin
    //                 CsrRAble  <= `EnableValue        ;
    //                 CsrWMask  <= `CsrWMaskAll        ;
    //                 CsrRWAddr <= 14'd0               ;
    //                 CsrWBAble <= `EnableValue        ;
    //                 CsrWBAddr <= 8'b00000000         ;
    //                 CsrWAble  <= `EnableValue        ;
    //                 CsrWData  <= `ZeorDate           ;
    //                 TlbCode   <= TLBBRD              ;
    //                 OperateCode[CsrQueueFrontPtr] <= `InstTlbrd        ;
    //                 ExtendInformation[CsrQueueFrontPtr]<= 64'd0        ;
    //                 if(CsrQueueFrontPtr == 4'd15)
    //                     CsrQueueFrontPtr <= 4'd0     ;
    //                 else 
    //                     CsrQueueFrontPtr <= CsrQueueFrontPtr + 1 ;
    //             end
    //             `InstTlbwr : begin
    //                 CsrRAble  <= `EnableValue        ;
    //                 CsrWMask  <= `CsrWMaskAll        ;
    //                 CsrRWAddr <= 14'd0               ;
    //                 CsrWBAble <= `EnableValue        ;
    //                 CsrWAble  <= `EnableValue        ;
    //                 CsrWBAddr <= 8'b00000000         ;
    //                 CsrWData  <= `ZeorDate           ;
    //                 TlbCode   <= TLBBWR              ;
    //                 OperateCode[CsrQueueFrontPtr] <= `InstTlbwr        ;
    //                 ExtendInformation[CsrQueueFrontPtr]<= 64'd0        ;
    //                 if(CsrQueueFrontPtr == 4'd15)
    //                     CsrQueueFrontPtr <= 4'd0     ;
    //                 else 
    //                     CsrQueueFrontPtr <= CsrQueueFrontPtr + 1 ;
    //             end
    //             `InstTlbfill : begin
    //                 CsrRAble  <= `EnableValue        ;
    //                 CsrWMask  <= `CsrWMaskAll        ;
    //                 CsrRWAddr <= 14'd0               ;
    //                 CsrWBAble <= `EnableValue        ;
    //                 CsrWBAddr <= 8'b00000000         ;
    //                 CsrWAble  <= `EnableValue        ;
    //                 CsrWData  <= `ZeorDate           ;
    //                 TlbCode   <= TLBFILL             ;
    //                 OperateCode[CsrQueueFrontPtr] <= `InstTlbfill      ;
    //                 ExtendInformation[CsrQueueFrontPtr]<= 64'd0        ;
    //                 if(CsrQueueFrontPtr == 4'd15)
    //                     CsrQueueFrontPtr <= 4'd0     ;
    //                 else 
    //                     CsrQueueFrontPtr <= CsrQueueFrontPtr + 1 ;
    //             end
    //             `InstInvtlb : begin //reg1 is ASID and reg2 is Vritue address
    //                 CsrRAble  <= `EnableValue        ;
    //                 CsrWMask  <= `CsrWMaskAll        ;
    //                 CsrRWAddr <= 14'd0               ;
    //                 CsrWBAble <= `EnableValue        ;
    //                 CsrWBAddr <= 8'b00000000         ;
    //                 CsrWAble  <= `EnableValue        ;
    //                 CsrWData  <= `ZeorDate           ;
    //                 TlbCode   <= INVTLB              ;
    //                 OperateCode[CsrQueueFrontPtr] <= `InstInvtlb      ;
    //                 ExtendInformation[CsrQueueFrontPtr]<= {18'b0, ArchRegister1[8:0], ArchRegister2} ; //opcode five bit + asid nine bit + VA threety two bit 
    //                 if(CsrQueueFrontPtr == 4'd15)
    //                     CsrQueueFrontPtr <= 4'd0     ;
    //                 else 
    //                     CsrQueueFrontPtr <= CsrQueueFrontPtr + 1 ;
    //             end
    //             `InstEntry : begin
    //                 CsrRAble  <= `EnableValue        ;
    //                 CsrWMask  <= `CsrWMaskAll        ;
    //                 CsrRWAddr <= 14'd0               ;
    //                 CsrWBAble <= `EnableValue        ;
    //                 CsrWBAddr <= 8'b00000000         ;
    //                 CsrWAble  <= `EnableValue        ;
    //                 CsrWData  <= `ZeorDate           ;
    //                 TlbCode   <= ENTRY               ;
    //                 OperateCode[CsrQueueFrontPtr] <= `InstEntry        ;
    //                 ExtendInformation[CsrQueueFrontPtr]<= EraWenTemp ? EraWDateTemp : EraTemp ; 
    //                 if(CsrQueueFrontPtr == 4'd15)
    //                     CsrQueueFrontPtr <= 4'd0     ;
    //                 else 
    //                     CsrQueueFrontPtr <= CsrQueueFrontPtr + 1 ;
    //             end
    //             `InstIdle : begin
    //                 CsrRAble  <= `EnableValue        ;
    //                 CsrWMask  <= `CsrWMaskAll        ;
    //                 CsrRWAddr <= 14'd0               ;
    //                 CsrWBAble <= `EnableValue        ;
    //                 CsrWBAddr <= 8'b00000000         ;
    //                 CsrWAble  <= `EnableValue        ;
    //                 CsrWData  <= `ZeorDate           ;
    //                 TlbCode   <= IDLE                ;
    //                 OperateCode[CsrQueueFrontPtr] <= `InstIdle        ;
    //                 ExtendInformation[CsrQueueFrontPtr]<= 64'd0       ; 
    //                 if(CsrQueueFrontPtr == 4'd15)
    //                     CsrQueueFrontPtr <= 4'd0     ;
    //                 else 
    //                     CsrQueueFrontPtr <= CsrQueueFrontPtr + 1 ; 
    //             end
    //             default: begin
    //                 CsrRAble  <= `EnableValue        ;
    //                 CsrWMask  <= `CsrWMaskAll        ;
    //                 CsrRWAddr <= CsrNum              ;
    //                 CsrWBAble <= `EnableValue        ;
    //                 CsrWAble  <= `EnableValue        ;
    //                 CsrWData  <= `ZeorDate           ;
    //                 TlbCode   <= IDLE                ;
    //                 OperateCode[CsrQueueFrontPtr] <= 8'b00000000      ;
    //                 ExtendInformation[CsrQueueFrontPtr]<= 64'd0       ; 
    //                 CsrQueueFrontPtr <= CsrQueueFrontPtr ; 
    //             end
    //         endcase
    //     end
    // end

    localparam CRMD  = 14'h0;
    localparam PRMD  = 14'h1;
    localparam ECFG  = 14'h4;
    localparam ESTAT = 14'h5;
    localparam ERA   = 14'h6;
    localparam BADV  = 14'h7;
    localparam EENTRY = 14'hc;
    localparam TLBIDX= 14'h10;
    localparam TLBEHI= 14'h11;
    localparam TLBELO0=14'h12;
    localparam TLBELO1=14'h13;
    localparam ASID  = 14'h18;
    localparam PGDL  = 14'h19;
    localparam PGDH  = 14'h1a;
    localparam PGD   = 14'h1b;
    localparam CPUID = 14'h20;
    localparam SAVE0 = 14'h30;
    localparam SAVE1 = 14'h31;
    localparam SAVE2 = 14'h32;
    localparam SAVE3 = 14'h33;
    localparam TID   = 14'h40;
    localparam TCFG  = 14'h41;
    localparam TVAL  = 14'h42;
    localparam CNTC  = 14'h43;
    localparam TICLR = 14'h44;
    localparam LLBCTL= 14'h60;
    localparam TLBRENTRY = 14'h88;
    localparam DMW0  = 14'h180;
    localparam DMW1  = 14'h181;
    localparam BRK = 14'h100;
    localparam DISABLE_CACHE = 14'h101;

    wire CrmdWenTemp   = CsrWAble & (CsrWAddr == CRMD);
    wire PrmdWenTemp   = CsrWAble & (CsrWAddr == PRMD);
    wire EcfgWenTemp   = CsrWAble & (CsrWAddr == ECFG);
    wire EstatWenTemp  = CsrWAble & (CsrWAddr == ESTAT);
    wire EraWenTemp    = CsrWAble & (CsrWAddr == ERA);
    wire BadvWenTemp   = CsrWAble & (CsrWAddr == BADV);
    wire EentryWenTemp = CsrWAble & (CsrWAddr == EENTRY);
    wire TlbidcWenTemp = CsrWAble & (CsrWAddr == TLBIDX);
    wire TlbehiWenTemp = CsrWAble & (CsrWAddr == TLBEHI);
    wire Tlbelo0WenTemp= CsrWAble & (CsrWAddr == TLBELO0);
    wire Tlbelo1WenTemp= CsrWAble & (CsrWAddr == TLBELO1);
    wire AsidWenTemp   = CsrWAble & (CsrWAddr == ASID);
    wire PgdlWenTemp   = CsrWAble & (CsrWAddr == PGDL);
    wire PgdhWenTemp   = CsrWAble & (CsrWAddr == PGDH);
    wire PgdWenTemp    = CsrWAble & (CsrWAddr == PGD);
    wire CpuidWenTemp  = CsrWAble & (CsrWAddr == CPUID);
    wire Save0WenTemp  = CsrWAble & (CsrWAddr == SAVE0);
    wire Save1WenTemp  = CsrWAble & (CsrWAddr == SAVE1);
    wire Save2WenTemp  = CsrWAble & (CsrWAddr == SAVE2);
    wire Save3WenTemp  = CsrWAble & (CsrWAddr == SAVE3);
    wire TidWenTemp    = CsrWAble & (CsrWAddr == TID);
    wire TcfgWenTemp   = CsrWAble & (CsrWAddr == TCFG);
    wire TvalWenTemp   = CsrWAble & (CsrWAddr == TVAL);
    wire CntcWenTemp   = CsrWAble & (CsrWAddr == CNTC);
    wire TiclrWenTemp  = CsrWAble & (CsrWAddr == TICLR);
    wire LlbctlWenTemp = CsrWAble & (CsrWAddr == LLBCTL);
    wire TlbrentryWenTemp = CsrWAble & (CsrWAddr == TLBRENTRY);
    wire Dmw0WenTemp   = CsrWAble & (CsrWAddr == DMW0);
    wire Dmw1WenTemp   = CsrWAble & (CsrWAddr == DMW1);
    wire BrkWenTemp    = CsrWAble & (CsrWAddr == BRK);
    wire DisAbleCacheTemp = CsrWAble & (CsrWAddr == DISABLE_CACHE);

    wire CrmdWenCommit   = CsrWAble & (CsrWAddr == CRMD);

    reg [31:0] csr_crmd;
    reg [31:0] csr_prmd;
    reg [31:0] csr_ectl;
    reg [31:0] csr_estat;
    reg [31:0] csr_era;
    reg [31:0] csr_badv;
    reg [31:0] csr_eentry;
    reg [31:0] csr_tlbidx;
    reg [31:0] csr_tlbehi;
    reg [31:0] csr_tlbelo0;
    reg [31:0] csr_tlbelo1;
    reg [31:0] csr_asid;
    reg [31:0] csr_cpuid;
    reg [31:0] csr_save0;
    reg [31:0] csr_save1;
    reg [31:0] csr_save2;
    reg [31:0] csr_save3;
    reg [31:0] csr_tid;
    reg [31:0] csr_tcfg;
    reg [31:0] csr_tval;
    reg [31:0] csr_cntc;
    reg [31:0] csr_ticlr;
    reg [31:0] csr_llbctl;
    reg [31:0] csr_tlbrentry;
    reg [31:0] csr_dmw0;
    reg [31:0] csr_dmw1;
    reg [31:0] csr_pgdl;
    reg [31:0] csr_pgdh;
    reg [31:0] csr_brk;
    reg [31:0] csr_disable_cache;
    //TEMP Csr and Signal  before Re-order Buffer inst commit


    //Operate about Cache   ||| extend information allocit  [31:5]=0 ,[4:3]=opercode , [2:0]=cache chiose code
    wire  ChioseCacop          = ((OperateCode[CsrQueueEndPtr] == `InstCacop) && (CsrCommitValue));
    wire  CacopInstCacheAble   = ((ExtendInformation[CsrQueueEndPtr][2:0] == 0) && ChioseCacop)   ;
    wire  CacopDataCacheAble   = ((ExtendInformation[CsrQueueEndPtr][2:0] == 1) && ChioseCacop)   ;
    wire  [1:0] CacopCacheOpcodeCode = ExtendInformation[4:3]  ;
    wire  CacopMmuICache       =( CacopInstCacheAble &&(ExtendInformation[4:3] == 2)) ;
    wire  CacopMmuDCache       =( CacopDataCacheAble &&(ExtendInformation[4:3] == 2)) ;


    //
    
endmodule