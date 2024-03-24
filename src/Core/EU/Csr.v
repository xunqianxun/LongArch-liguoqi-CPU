`timescale 1ps/1ps
`include "../define.v"

module Csr (
    input        wire                                       Clk             ,
    input        wire                                       Rest            ,

    input        wire                                       WEn             ,
    input        wire      [13:0]                           WAddr           ,
    input        wire      [`DataBus]                       WDate           ,    
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
    // localparam BRK = 14'h100;
    // localparam DISABLE_CACHE = 14'h101;

    wire WriteCrmdEna      = ((WAddr == CRMD)      && (WEn)) ;
    wire WritePrmdEna      = ((WAddr == PRMD)      && (WEn)) ;
    wire WriteEctlEna      = ((WAddr == ECTL)      && (WEn)) ;
    wire WriteEstatEna     = ((WAddr == ESTAT)     && (WEn)) ;
    wire WriteEraEna       = ((WAddr == ERA)       && (WEn)) ;
    wire WriteBadvEna      = ((WAddr == BADV)      && (WEn)) ;
    wire WriteEentryEna    = ((WAddr == EENTRY)    && (WEn)) ;
    wire WriteTlbidxEna    = ((WAddr == TLBIDX)    && (WEn)) ;
    wire WriteTlbehiENa    = ((WAddr == TLBEHI)    && (WEn)) ;
    wire WriteTlbelo0Ena   = ((WAddr == TLBELO0)   && (WEn)) ;
    wire WriteTlbelo1Ena   = ((WAddr == TLBELO1)   && (WEn)) ;
    wire WriteAsidEna      = ((WAddr == ASID)      && (WEn)) ;
    wire WritePgdlEna      = ((WAddr == PGDL)      && (WEn)) ;
    wire WritePgdhEna      = ((WAddr == PGDH)      && (WEn)) ;
    wire WritePgdEna       = ((WAddr == PGD)       && (WEn)) ;
    wire WriteCpuidEna     = ((WAddr == CPUID)     && (WEn)) ;
    wire WriteSave0Ena     = ((WAddr == SAVE0)     && (WEn)) ;
    wire WriteSave1Ena     = ((WAddr == SAVE1)     && (WEn)) ;
    wire WriteSave2ENa     = ((WAddr == SAVE2)     && (WEn)) ;
    wire WriteSave30Ena    = ((WAddr == SAVE3)     && (WEn)) ;
    wire WriteTidEna       = ((WAddr == TID)       && (WEn)) ;
    wire WriteTcfgEna      = ((WAddr == TCFG)      && (WEn)) ;
    wire WriteTvalEna      = ((WAddr == TVAL)      && (WEn)) ;
    wire WriteCntcEna      = ((WAddr == CNTC)      && (WEn)) ;
    wire WriteTiclrEna     = ((WAddr == TICLR)     && (WEn)) ;
    wire WriteLlbctlEna    = ((WAddr == LLBCTL)    && (WEn)) ;
    wire WriteTlbrentryEna = ((WAddr == TLBRENTRY) && (WEn)) ;
    wire WriteDmw0Ena      = ((WAddr == DMW0)      && (WEn)) ;
    wire WriteDmw1ENa      = ((WAddr == DMW1)      && (WEn)) ;
    // wire WriteBpkEna       = ((WAddr == BRK)       && (WEn)) ; 
    // wire WriteTlbelo0Ena   = ((WAddr == DISABLE_CACHE)&& (WEn)) ; 
    
endmodule