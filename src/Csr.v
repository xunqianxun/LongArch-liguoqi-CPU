`timescale 1ps/1ps
`include "define.v"

module Csr (
    input       wire                                      Clk                ,
    input       wire                                      Rest               ,

    //ROB

    //wirte Csr

);

    localparam CRMD  = 14'h0;
    localparam PRMD  = 14'h1;
    localparam ECTL  = 14'h4;
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

    wire CrmdWenTemp   = CsrWAble & (wr_addr == CRMD);
    wire prmd_wen   = csr_wr_en & (wr_addr == PRMD);
    wire ectl_wen   = csr_wr_en & (wr_addr == ECTL);
    wire estat_wen  = csr_wr_en & (wr_addr == ESTAT);
    wire era_wen    = csr_wr_en & (wr_addr == ERA);
    wire badv_wen   = csr_wr_en & (wr_addr == BADV);
    wire eentry_wen = csr_wr_en & (wr_addr == EENTRY);
    wire tlbidx_wen = csr_wr_en & (wr_addr == TLBIDX);
    wire tlbehi_wen = csr_wr_en & (wr_addr == TLBEHI);
    wire tlbelo0_wen= csr_wr_en & (wr_addr == TLBELO0);
    wire tlbelo1_wen= csr_wr_en & (wr_addr == TLBELO1);
    wire asid_wen   = csr_wr_en & (wr_addr == ASID);
    wire pgdl_wen   = csr_wr_en & (wr_addr == PGDL);
    wire pgdh_wen   = csr_wr_en & (wr_addr == PGDH);
    wire pgd_wen    = csr_wr_en & (wr_addr == PGD);
    wire cpuid_wen  = csr_wr_en & (wr_addr == CPUID);
    wire save0_wen  = csr_wr_en & (wr_addr == SAVE0);
    wire save1_wen  = csr_wr_en & (wr_addr == SAVE1);
    wire save2_wen  = csr_wr_en & (wr_addr == SAVE2);
    wire save3_wen  = csr_wr_en & (wr_addr == SAVE3);
    wire tid_wen    = csr_wr_en & (wr_addr == TID);
    wire tcfg_wen   = csr_wr_en & (wr_addr == TCFG);
    wire tval_wen   = csr_wr_en & (wr_addr == TVAL);
    wire cntc_wen   = csr_wr_en & (wr_addr == CNTC);
    wire ticlr_wen  = csr_wr_en & (wr_addr == TICLR);
    wire llbctl_wen = csr_wr_en & (wr_addr == LLBCTL);
    wire tlbrentry_wen = csr_wr_en & (wr_addr == TLBRENTRY);
    wire DMW0_wen   = csr_wr_en & (wr_addr == DMW0);
    wire DMW1_wen   = csr_wr_en & (wr_addr == DMW1);
    wire BRK_wen    = csr_wr_en & (wr_addr == BRK);
    wire disable_cache_wen = csr_wr_en & (wr_addr == DISABLE_CACHE);

    wire CrmdWenCommit   = CsrWAble & (wr_addr == CRMD);

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