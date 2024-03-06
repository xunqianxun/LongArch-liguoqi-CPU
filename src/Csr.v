`timescale 1ps/1ps
`include "define.v"

module Csr (
    input       wire                                      Clk                ,
    input       wire                                      Rest               ,

    //ROB

    //wirte Csr
    input       wire      [`MicOperateCode]               CsrMicOperate      ,
    input       wire      [`DataBus]                      ArchRegister1      ,
    input       wire      [`DataBus]                      ArchRegister2      ,
    input       wire      [`ArchRegBUs]                   ReDataAddr         ,
    // input       wire                                      CsrWAble           ,
    // input       wire        [13:0]                        CsrWAddr           ,
    // input       wire        [31:0]                        CsrWMask           ,                             

);

    reg   [13:0]     CsrWAddr ;
    reg   [31:0]     CsrWMask ;
    reg              CsrWAble ;
    reg              CsrRAble ;
    always @(posedge Clk) begin
        if(!Rest)begin
            CsrWAddr <= 14'd0 ;
            CsrWMask <= 32'd0 ;
            CsrWAble <= `EnableValue;
            CsrRAble <= `EnableValue;
        end
        else begin
            case (CsrMicOperate)
                : 
                default: 
            endcase
        end
    end

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

    
endmodule