`timescale 1ps/1ps
`include "../define.v"

module Csr (
    input        wire                                     Clk             ,
    input        wire                                     Rest            ,

    //interrupt from ROB
    input        wire                                     Interrupt       , //此处中断包括所有例外包括entry返回
    input        wire      [`InstAddrBus]                 InterruptPc     ,
    input        wire      [`InstAddrBus]                 InterruptAddr   , //例如一条访存指令发生重填，pc就是这条指令地址addr就是他访存的虚地址
    input        wire      [6:0]                          InterruptType   ,   
    input        wire                                     TrapEntry       ,
    //from soc
    input        wire      [7:0]                          SocInterrupt    ,
    //to ROB                                
    output       wire                                     EndowInterrupt  ,
    output       wire      [6:0]                          EndowCode       ,
    output       wire                                     LlbetlKlo       ,
    output       wire      [25:0]                         CsrTlbEntryDate ,
    output       wire      [25:0]                         CsrEntryDate    ,
    //to mmu   
    output       wire      [9:0]                          CsrAsidDate     ,
    output       wire      [`DataBus]                     CsrDmw0Date     ,
    output       wire      [`DataBus]                     CsrDmw1Date     ,
    //write csr
    input        wire                                     WEn             ,
    input        wire      [13:0]                         WAddr           ,
    input        wire      [`DataBus]                     WDate           ,  
    //read csr 
    input        wire                                     REn             ,
    input        wire      [13:0]                         RAddr           ,
    output       wire      [`DataBus]                     RDate           ,
    //direct write
    input        wire                                     InTlbIndexWAble ,
    input        wire      [`DataBus]                     InTlbIndexWMask ,
    input        wire      [`DataBus]                     InTlbIndexWDate ,
    input        wire                                     InTlbEhiWAble   ,
    input        wire      [`DataBus]                     InTlbEhiWDate   ,
    input        wire                                     InTlbElo0WAble  ,
    input        wire      [`DataBus]                     InTlbElo0WDate  ,
    input        wire                                     InTlbElo1WAble  ,
    input        wire      [`DataBus]                     InTlbElo1WDate  ,
    input        wire                                     InCrmdWAble     ,
    input        wire      [`DataBus]                     InCrmdWMask     ,
    input        wire      [`DataBus]                     InCrmdWDate     ,
    input        wire                                     InLlCtrlAble    ,
    //csr date to csru 
    output       wire      [2:0]                          OutCrmdData     ,
    output       wire      [2:0]                          OutPrmdDate     ,
    output       wire      [`DataBus]                     OutEraDate      ,
    output       wire      [9:0]                          OutAsidDate     ,
    output       wire      [18:0]                         OutTlbEhiDate   ,
    output       wire      [5:0]                          OutTlbIndex     ,
    output       wire      [5:0]                          OutTlbPs        ,
    output       wire      [`DataBus]                     OutTlbElo0      ,
    output       wire      [`DataBus]                     OutTlbElo1      ,
    output       wire      [5:0]                          OutTlbEcode     ,
    output       wire                                     OutTlbNe        ,
    output       wire                                     OutLlbCtlDate 
);

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
    //localparam CNTC  = 14'h43;
    localparam TICLR = 14'h44;
    localparam LLBCTL= 14'h60;
    localparam TLBRENTRY = 14'h88;
    localparam DMW0  = 14'h180;
    localparam DMW1  = 14'h181;
    // localparam BRK = 14'h100;
    // localparam DISABLE_CACHE = 14'h101;

    wire WriteCrmdEna      = ((WAddr == CRMD)      && (WEn)) ;
    wire WritePrmdEna      = ((WAddr == PRMD)      && (WEn)) ;
    wire WriteEcfgEna      = ((WAddr == ECFG)      && (WEn)) ;
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
    //wire WritePgdEna       = ((WAddr == PGD)       && (WEn)) ;
    wire WriteCpuidEna     = ((WAddr == CPUID)     && (WEn)) ;
    wire WriteSave0Ena     = ((WAddr == SAVE0)     && (WEn)) ;
    wire WriteSave1Ena     = ((WAddr == SAVE1)     && (WEn)) ;
    wire WriteSave2Ena     = ((WAddr == SAVE2)     && (WEn)) ;
    wire WriteSave3Ena     = ((WAddr == SAVE3)     && (WEn)) ;
    wire WriteTidEna       = ((WAddr == TID)       && (WEn)) ;
    wire WriteTcfgEna      = ((WAddr == TCFG)      && (WEn)) ;
    wire WriteTvalEna      = ((WAddr == TVAL)      && (WEn)) ;
    //wire WriteCntcEna      = ((WAddr == CNTC)      && (WEn)) ;
    wire WriteTiclrEna     = ((WAddr == TICLR)     && (WEn)) ;
    wire WriteLlbctlEna    = ((WAddr == LLBCTL)    && (WEn)) ;
    wire WriteTlbrentryEna = ((WAddr == TLBRENTRY) && (WEn)) ;
    wire WriteDmw0Ena      = ((WAddr == DMW0)      && (WEn)) ;
    wire WriteDmw1ENa      = ((WAddr == DMW1)      && (WEn)) ;
    // wire WriteBpkEna       = ((WAddr == BRK)       && (WEn)) ; 
    // wire WriteTlbelo0Ena   = ((WAddr == DISABLE_CACHE)&& (WEn)) ; 

    reg [`DataBus] CsrCrmd ;
    reg [`DataBus] CsrPrmd ;
    reg [`DataBus] CsrEcfg ;
    reg [`DataBus] CsrEstat;
    reg [`DataBus] CsrEra  ;
    reg [`DataBus] CsrBadv ;
    reg [`DataBus] CsrEentry;
    reg [`DataBus] CsrTlbidx;
    reg [`DataBus] CsrTlbehi;
    reg [`DataBus] CsrTlbelo0;
    reg [`DataBus] CsrTlbelo1;
    reg [`DataBus] CsrAsid ;
    reg [`DataBus] CsrPgdl ;
    reg [`DataBus] CsrPgdh ;
    //reg [`DataBus] CsrPgd  ;
    reg [`DataBus] CsrCpuid;
    reg [`DataBus] CsrSave0;
    reg [`DataBus] CsrSave1;
    reg [`DataBus] CsrSave2;
    reg [`DataBus] CsrSave3;
    reg [`DataBus] CsrTid  ;
    reg [`DataBus] CsrTcfg ;
    reg [`DataBus] CsrTval ;
    //reg [`DataBus] CsrCntc ;
    reg [`DataBus] CsrTiclr;
    reg [`DataBus] CsrLlbctl;
    reg [`DataBus] CsrTlbrentry;
    reg [`DataBus] CsrDmw0 ;
    reg [`DataBus] CsrDmw1 ;


    always @(posedge Clk) begin
        if(!Rest) begin
            CsrCrmd[`PLV]  <= 2'd0 ;
            CsrCrmd[`IE]   <= 1'b0 ;
            CsrCrmd[`DA]   <= 1'b1 ;
            CsrCrmd[`PG]   <= 1'b0 ;
            CsrCrmd[`DATF] <= 2'b0 ;
            CsrCrmd[`DATM] <= 2'd0 ;
            CsrCrmd[`SAVE] <= 23'd0 ;  
        end
        else if(Interrupt)begin
            CsrCrmd[`PLV]  <= TrapEntry ? CsrPrmd[`PPLV] : 0 ;
            CsrCrmd[`IE]   <= TrapEntry ? CsrPrmd[`PIE]  : 0 ;
            CsrCrmd[`DA]   <= (InterruptType == `TLBR)                    ? 1'b1 : 
                              (TrapEntry && (CsrEstat[`ECODE] == 6'h3f))  ? 1'b0 : CsrCrmd[`DA] ;
            CsrCrmd[`PG]   <= (InterruptType == `TLBR)                    ? 1'b0 : 
                              (TrapEntry && (CsrEstat[`ECODE] == 6'h3f))  ? 1'b1 : CsrCrmd[`PG] ;
            CsrCrmd[`DATF] <= CsrCrmd[`DATF] ;
            CsrCrmd[`DATM] <= CsrCrmd[`DATM] ;
            CsrCrmd[`SAVE] <= CsrCrmd[`SAVE] ;
        end
        else if(WriteCrmdEna) begin
            CsrCrmd[`PLV]  <= WDate[`PLV] ;
            CsrCrmd[`IE]   <= WDate[`IE]  ;
            CsrCrmd[`DA]   <= WDate[`DA]  ;
            CsrCrmd[`PG]   <= WDate[`PG]  ;
            CsrCrmd[`DATF] <= WDate[`DATF];
            CsrCrmd[`DATM] <= WDate[`DATM];
            CsrCrmd[`SAVE] <= WDate[`SAVE];
        end
        else if(InCrmdWAble) begin
            CsrCrmd <= (InCrmdWMask & InCrmdWDate) | (~InCrmdWMask & CsrCrmd) ;
        end
    end 

    always @(posedge Clk) begin
        if(!Rest) begin
            CsrPrmd[`PPLV] <= 2'b0 ;
            CsrPrmd[`PIE]  <= 1'b0 ;
            CsrPrmd[31:3]  <= 29'b0;
        end
        else if(Interrupt && ~TrapEntry)begin
            CsrPrmd[`PPLV] <= CsrCrmd[`PLV] ;
            CsrPrmd[`PIE]  <= CsrCrmd[`IE]  ;
            CsrPrmd[31:3]  <= CsrPrmd[31:3] ;
        end
        else if(WritePrmdEna) begin
            CsrPrmd[`PPLV] <= WDate[`PLV] ;
            CsrPrmd[`PIE]  <= WDate[`IE]  ;
            CsrPrmd[31:3]  <= WDate[31:3] ;
        end
    end


    always @(posedge Clk) begin
        if(!Rest)begin
            CsrEcfg <= `ZeorDate ;
        end
        else if(WriteEcfgEna)begin
            CsrEcfg <= WDate ;
        end
    end

    always @(posedge Clk) begin
        if(!Rest) begin
            CsrEstat[`IS1_0] <= 2'b0 ;
            CsrEstat[`IS9_2] <= 8'b0 ;
            CsrEstat[10]     <= 1'b0 ;
            CsrEstat[`IS11]  <= 1'b0 ;
            CsrEstat[`IS12]  <= 1'b0 ;
            CsrEstat[`ECODE] <= 6'b0 ;
            CsrEstat[`ESUBCODE] <= 9'd0 ;
            CsrEstat[31]     <= 1'b0 ;
            CsrEstat[15:13]  <= 3'd0 ;
        end
        else begin
            CsrEstat[`IS9_2] <= SocInterrupt ;
            if(WriteEstatEna)begin
                CsrEstat[`IS1_0] <= WDate[`IS1_0];
            end
            if((WriteTiclrEna) && (WDate[`CLR] == 1))
                CsrEstat[`IS11] <= 1'b0 ;
            if((CsrTcfg[`EN] == 1) && (CsrTval == 0))
                CsrEstat[`IS11] <= 1'b1 ;
            if(Interrupt && ~TrapEntry)begin
                CsrEstat[`ECODE] <= InterruptType[5:0] ;
                CsrEstat[`ESUBCODE] <= {8'd0, InterruptType[6]} ;
            end
        end
    end
    

    always @(posedge Clk) begin
        if(!Rest) begin
            CsrEra <= `ZeorDate ;
        end
        else begin
            if(Interrupt && ~TrapEntry)
                CsrEra <= InterruptPc ;
            if(WriteEraEna)
                CsrEra <= WDate ;   
        end
    end

    always @(posedge Clk) begin
        if(!Rest) begin
            CsrBadv <= `ZeorDate ;
        end
        else begin
            if(WriteBadvEna)
                CsrBadv <= WDate ;
            if(InterruptType == `ADEF)
                CsrBadv <= InterruptPc ;
            if((InterruptType == `TLBR)|| 
              (InterruptType == `ALE)  ||
              (InterruptType == `PIL)  ||
              (InterruptType == `PIS)  ||
              (InterruptType == `PME)  ||
              (InterruptType == `PPI   )) 
                CsrBadv <= InterruptAddr;
        end 
    end

    always @(posedge Clk) begin
        if(!Rest) 
            CsrEentry <= `ZeorDate ;
        else if(WriteEentryEna)
            CsrEentry <= WDate ;
    end

    assign CsrEntryDate = CsrEentry[31:6] ;

    always @(posedge Clk) begin
        if(!Rest)
            CsrCpuid <= `ZeorDate ;
        else if(WriteCpuidEna)
            CsrCpuid <= WDate ;
    end

    always @(posedge Clk) begin
        if(!Rest)
            CsrSave0 <= `ZeorDate ;
        else if(WriteSave0Ena)
            CsrSave0 <= WDate ;
    end

    always @(posedge Clk) begin
        if(!Rest)
            CsrSave1 <= `ZeorDate ;
        else if(WriteSave1Ena)
            CsrSave1 <= WDate ;
    end

    always @(posedge Clk) begin
        if(!Rest)
            CsrSave2 <= `ZeorDate ;
        else if(WriteSave2Ena)
            CsrSave2 <= WDate ;
    end

    always @(posedge Clk) begin
        if(!Rest)
            CsrSave3 <= `ZeorDate ;
        else if(WriteSave3Ena)
            CsrSave3 <= WDate ;
    end

    // TODO TODO TODO TODO 原子操作
    always @(posedge Clk) begin
        if(!Rest) begin
            CsrLlbctl[`ROLLB] <= 1'b0  ;
            CsrLlbctl[`WCLLB] <= 1'b0  ;
            CsrLlbctl[`KLO]   <= 1'b0  ;
            CsrLlbctl[31:3]   <= 29'b0 ;
        end 
        else begin
            if(WriteLlbctlEna)
                CsrLlbctl <= WDate ;
            if((WriteLlbctlEna) && (WDate[1] ==1))
                CsrLlbctl <= `ZeorDate ;
            if(InLlCtrlAble)
                CsrLlbctl[2] <= 1'b0 ;
        end
    end

    assign LlbetlKlo = CsrLlbctl[`KLO]  ; 

    always @(posedge Clk) begin
        if(!Rest) begin
            CsrTlbidx[`INDEX] <= 6'd0 ;
            CsrTlbidx[15:6]   <= 10'd0;
            CsrTlbidx[23:16]  <= 8'd0 ;
            CsrTlbidx[`PS]    <= 6'd0 ;
            CsrTlbidx[30]     <= 1'b0 ;
            CsrTlbidx[`NE]    <= 1'b0 ; 
        end
        else begin
            if(WriteTlbidxEna) begin
                CsrTlbidx[`INDEX] <= WDate[`INDEX];
                CsrTlbidx[15:6]   <= WDate[15:6]  ;
                CsrTlbidx[23:16]  <= WDate[23:16] ;
                CsrTlbidx[`PS]    <= WDate[`PS]   ;
                CsrTlbidx[30]     <= WDate[30]    ;
                CsrTlbidx[`NE]    <= WDate[`NE]   ;
            end 
            if(InTlbIndexWAble) 
                CsrTlbidx <= (InTlbIndexWMask &  InTlbIndexWDate) | (~InTlbIndexWMask & CsrTlbidx) ;
        end
    end

    always @(posedge Clk) begin
        if(!Rest) 
            CsrTlbehi <= `ZeorDate ;
        else begin
            if(WriteTlbehiENa) 
                CsrTlbehi <= WDate ;
            if(InTlbEhiWAble)
                CsrTlbehi <= InTlbEhiWDate;
            if((InterruptType == `TLBR) || 
              (InterruptType == `PIL)   ||
              (InterruptType == `PIS)   ||
              (InterruptType == `PIF)   || 
              (InterruptType == `PME)   || 
              (InterruptType == `PPI    ))
                CsrTlbehi <= {InterruptAddr[31:13], 13'd0};
        end
    end

    always @(posedge Clk) begin
        if(!Rest) 
            CsrTlbelo0 <= `ZeorDate ;
        else begin
            if(WriteTlbelo0Ena)
                CsrTlbelo0 <= WDate ;
            if(InTlbElo0WAble)
                CsrTlbelo0 <= InTlbElo0WDate ;
        end
    end

    always @(posedge Clk) begin
        if(!Rest) 
            CsrTlbelo1 <= `ZeorDate ;
        else begin
            if(WriteTlbelo1Ena)
                CsrTlbelo1 <= WDate ;
            if(InTlbElo1WAble)
                CsrTlbelo1 <= InTlbElo1WDate ;
        end
    end

    always @(posedge Clk) begin
        if(!Rest)
            CsrAsid <= `ZeorDate ;
        else begin
            if(WriteAsidEna) 
                CsrAsid <= WDate ;
        end
    end

    always @(posedge Clk) begin
        if(!Rest) 
            CsrPgdl <= `ZeorDate ;
        else if(WritePgdlEna)
            CsrPgdl <= {WDate[31:12],12'd0};
    end

    always @(posedge Clk) begin
        if(!Rest)
            CsrPgdh <= `ZeorDate ;
        else if(WritePgdhEna)
            CsrPgdh <= {WDate[31:12], 12'd0};
    end

    always @(posedge Clk) begin
        if(!Rest)
            CsrTlbrentry <= `ZeorDate ;
        else if(WriteTlbrentryEna)
            CsrTlbrentry <= {WDate[31:6],6'd0} ;
    end

    assign CsrTlbEntryDate = CsrTlbrentry[31:6] ;
        
    always @(posedge Clk) begin
        if(!Rest) 
            CsrDmw0 <= `ZeorDate ;
        else if(WriteDmw0Ena)
            CsrDmw0 <= WDate ;
    end

    always @(posedge Clk) begin
        if(!Rest) 
            CsrDmw1 <= `ZeorDate ;
        else if(WriteDmw1ENa)
            CsrDmw1 <= WDate ;
    end


    always @(posedge Clk) begin
        if(!Rest)
            CsrTid <= `ZeorDate ;
        else if(WriteTidEna) 
            CsrTid <= WDate ;
    end

    always @(posedge Clk) begin
        if(!Rest) begin
            CsrTcfg[`EN] <= 1'b0 ;
            CsrTcfg[`PERIODIC] <= 1'b0 ;
            CsrTcfg[`INITVAL]  <= 30'b0;
        end 
        else if(WriteTcfgEna) begin
            CsrTcfg[`EN] <= WDate[`EN] ;
            CsrTcfg[`PERIODIC] <= WDate[`PERIODIC] ;
            CsrTcfg[`INITVAL]  <= WDate[`INITVAL]  ;
        end
    end

    always @(posedge Clk) begin
        if(!Rest)
            CsrTval <= `ZeorDate ;
        else begin
            if(WriteTvalEna)
                CsrTval <= WDate ;
            if(CsrTval != 0)
                CsrTval <= CsrTval - 32'b1 ;
            if(CsrTval == 0)
                CsrTval <= CsrTcfg[`PERIODIC] ? {CsrTcfg[ `INITVAL],2'b0} : 32'hffffffff ;
        end
    end

    always @(posedge Clk) begin
        if(!Rest)
            CsrTiclr <= `ZeorDate ;
        else 
            CsrTiclr <= `ZeorDate ;
    end

    wire ReadCrmdEna      = ((RAddr == CRMD)     && REn);
    wire ReadPrmdEna      = ((RAddr == PRMD)     && REn);
    wire ReadEcfgEna      = ((RAddr == ECFG)     && REn);
    wire ReadEstatEna     = ((RAddr == ESTAT)    && REn);
    wire ReadEraEna       = ((RAddr == ERA)      && REn);
    wire ReadBadvEna      = ((RAddr == BADV)     && REn);
    wire ReadEentryEna    = ((RAddr == EENTRY)   && REn);
    wire ReadTlbidxEna    = ((RAddr == TLBIDX)   && REn);
    wire ReadTlbehiEna    = ((RAddr == TLBEHI)   && REn);
    wire ReadTlbelo0Ena   = ((RAddr == TLBELO0)  && REn);
    wire ReadTlbelo1Ena   = ((RAddr == TLBELO1)  && REn);
    wire ReadAsidEna      = ((RAddr == ASID)     && REn);
    wire ReadPgdlEna      = ((RAddr == PGDL)     && REn);
    wire ReadPgdhEna      = ((RAddr == PGDH)     && REn);
    wire ReadPgdEna       = ((RAddr == PGD)      && REn);
    wire ReadCpuidEna     = ((RAddr == CPUID)    && REn);
    wire ReadSave0Ena     = ((RAddr == SAVE0)    && REn);
    wire ReadSave1Ena     = ((RAddr == SAVE1)    && REn);
    wire ReadSave2Ena     = ((RAddr == SAVE2)    && REn);
    wire ReadSave3Ena     = ((RAddr == SAVE3)    && REn);
    wire ReadTidEna       = ((RAddr == TID)      && REn);
    wire ReadTcfgEna      = ((RAddr == TCFG)     && REn);
    wire ReadTvalEna      = ((RAddr == TVAL)     && REn);
    //wire ReadCntcEna      = ((RAddr == CNTC)     && REn);
    wire ReadTiclrEna     = ((RAddr == TICLR)    && REn);
    wire ReadLlbctlEna    = ((RAddr == LLBCTL)   && REn);
    wire ReadTlbrentryEna = ((RAddr == TLBRENTRY)&& REn);
    wire ReadDmw0Ena      = ((RAddr == DMW0)     && REn);
    wire ReadDmw1Ena      = ((RAddr == DMW1)     && REn);

    assign RDate = {32{ReadCrmdEna}}      & CsrCrmd      |
                   {32{ReadPrmdEna}}      & CsrPrmd      |
                   {32{ReadEcfgEna}}      & CsrEcfg      |
                   {32{ReadEstatEna}}     & CsrEstat     |
                   {32{ReadEraEna}}       & CsrEra       |
                   {32{ReadBadvEna}}      & CsrBadv      |
                   {32{ReadEentryEna}}    & CsrEentry    |
                   {32{ReadTlbidxEna}}    & CsrTlbidx    |
                   {32{ReadTlbehiEna}}    & CsrTlbehi    |
                   {32{ReadTlbelo0Ena}}   & CsrTlbelo0   |
                   {32{ReadTlbelo1Ena}}   & CsrTlbelo1   |
                   {32{ReadAsidEna}}      & CsrAsid      |
                   {32{ReadPgdlEna}}      & CsrPgdl      |
                   {32{ReadPgdhEna}}      & CsrPgdh      |
                   {32{ReadPgdEna}}       & (({32{CsrBadv[31]}} & CsrPgdh) | (~{32{CsrBadv[31]}} & CsrPgdl)) |
                   {32{ReadCpuidEna}}     & CsrCpuid     |
                   {32{ReadSave0Ena}}     & CsrSave0     |
                   {32{ReadSave1Ena}}     & CsrSave1     |
                   {32{ReadSave2Ena}}     & CsrSave2     |
                   {32{ReadSave3Ena}}     & CsrSave3     |
                   {32{ReadTidEna}}       & CsrTid       |
                   {32{ReadTcfgEna}}      & CsrTcfg      |
                   {32{ReadTvalEna}}      & CsrTval      |
                   //{32{ReadCntcEna}}      & CsrCntc      |
                   {32{ReadTiclrEna}}     & CsrTiclr     |
                   {32{ReadLlbctlEna}}    & CsrLlbctl    |
                   {32{ReadTlbrentryEna}} & CsrTlbrentry |
                   {32{ReadDmw0Ena}}      & CsrDmw0      |
                   {32{ReadDmw1Ena}}      & CsrDmw1      ;
                   

    assign EndowInterrupt = ((({CsrEcfg[12:11], CsrEcfg[9:0]} & {CsrEstat[`IS12], CsrEstat[`IS11], CsrEstat[`IS9_2], CsrEstat[`IS1_0]}) != 0) && CsrCrmd[`IE]) ;
    assign EndowCode      = `INT ;

    assign CsrAsidDate = CsrAsid[9:0] ;
    assign CsrDmw0Date = CsrDmw0 ;
    assign CsrDmw1Date = CsrDmw1 ;

    assign OutCrmdData  = CsrCrmd[2:0] ;
    assign OutPrmdDate  = CsrPrmd[2:0] ;
    assign OutEraDate   = CsrEra       ;
    assign OutAsidDate  = CsrAsid[9:0] ;
    assign OutTlbEhiDate= CsrTlbehi[31:13];
    assign OutTlbIndex  = CsrTlbidx[5:0] ;
    assign OutTlbPs     = CsrTlbidx[29:24];
    assign OutTlbElo0   = CsrTlbelo0     ;
    assign OutTlbElo1   = CsrTlbelo1     ;
    assign OutTlbEcode  = CsrEstat[21:16];
    assign OutTlbNe     = CsrTlbidx[31]  ;
    assign OutLlbCtlDate= CsrLlbctl[3]   ;


endmodule
