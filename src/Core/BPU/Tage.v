`timescale 1ps/1ps
`include "define.v"
`include "Tagedefine.vh"
`include "../IP/Bram_SIM.v"
`include "../IP/Tage_base_128.xcix"
`include "../IP/Tage_T1_128.xcix"

module Tage #(
    parameter BASEDEEP       = 128  ,
    parameter BASEPW         = 7    ,
    parameter T1DEEP         = 128  ,
    parameter T1PW           = 7    ,
    parameter T1GHR          = 2    ,
    parameter T1TGE          = 7    ,
    parameter T2DEEP         = 128  ,
    parameter T2PW           = 7    ,
    parameter T2GHR          = 4    ,
    parameter T2TGE          = 7    ,
    parameter T3DEEP         = 256  ,
    parameter T3PW           = 8    ,
    parameter T3GHR          = 8    ,
    parameter T3TGE          = 8    ,
    parameter T4DEEP         = 256  ,
    parameter T4PW           = 8    ,
    parameter T4GHR          = 16   ,
    parameter T4TGE          = 8    ,
    parameter T5DEEP         = 128  ,
    parameter T5PW           = 7    ,
    parameter T5GHR          = 32   ,
    parameter T5TGE          = 9    ,
    parameter T6DEEP         = 128  ,
    parameter T6PW           = 7    ,
    parameter T6GHR          = 64   ,
    parameter T6TGE          = 9    ,
    parameter TAGEBANK       = 7    ,
    parameter TAGEPRW        = 2    ,
    parameter GHRWIDE        = 64  
) (
    input          wire                                           Clk               ,
    input          wire                                           Rest              ,
    //from FTQ start sign 
    input          wire                                           ForceAble         ,
    input          wire           [`InstAddrBus]                  Pc                ,
    //from BTB about This block  inst type
    input          wire           [2:0]                           PredictType       ,

    //out to FTQ predict outcome
    output         wire                                           FoutAble          ,
    output         wire                                           Fpredict          ,
    output         wire           [TAGEBANK-1:0]                  FinaSelectBank    ,
    output         wire           [GHRWIDE-1:0]                   FGHR              ,
    output         wire           [`InstAddrBus]                  FPc               ,

    //from FTQ upfate sugn 
    input          wire                                           UpDateAble        ,
    input          wire                                           UpDatePredict     ,
    input          wire           [`TAGEBANNUMBANK-1:0]           UpDateSelectB     ,
    input          wire           [`GHRWIDE-1:0]                  UpdateGHR         ,
    input          wire           [`InstAddrBus]                  UpdatePc                           
);
    
    //*********************************ABOUT TAGE**********************************//
    //       T NUMBER------------DEEP------------GHR WIDE---------TAG WIDE         //
    //         BASE              128             0                0                //
    //         T1                128             2                7                //
    //         T2                128             4                7                //
    //         T3                256             8                8                //
    //         T4                256             16               8                //
    //         T5                128             32               9                //
    //         T6                128             64               9                //
    //*****************************************************************************//

    //this design mand copy from BOOM hhhh
 
    // attenuation counter
    reg [17:0] AttenuationCounter ;
    always @(posedge Clk) begin
        if(!Rest)
            AttenuationCounter <= 18'd0 ;
        else begin
            if(UpDateAble) 
                AttenuationCounter <= AttenuationCounter + 1 ;
            if(AttenuationCounter == 18'b111111111111111111)
                AttenuationCounter <= 18'd0                  ;
        end 

    end

    wire AttenuationAble = (AttenuationCounter == 18'b111111111111111111);

    reg                 TageReady ;
    reg [`InstAddrBus]  PcReg     ;
    always @(posedge Clk) begin
        if(!Rest) begin
            TageReady <= `EnableValue ;
            PcReg     <= `ZeorDate    ;
        end 
        else begin 
            TageReady <= ForceAble ; 
            PcReg     <= Pc        ;
        end 
    end  

    reg [GHRWIDE-1:0] GHR  ; // oldest---------->> new
    always @(posedge Clk) begin
        if(!Rest) 
            GHR <= {GHRWIDE{1'b0}};
        else begin
            if(UpDateAble)
                GHR <= UpdateGHR ;
            if(FoutAble)
                GHR <= TageReady & (PredictType == `TypeBRANCH) ? {GHR[GHRWIDE-1-1:0],Fpredict} : GHR ;
        end
    end

    //pc 折叠 for 7
    wire  [6:0]   Part1PcFor7 = Pc[3+7-1:3]                       ;
    wire  [6:0]   Part2PcFor7 = Pc[3+7+7-1:3+7]                   ;
    wire  [6:0]   Part3PcFor7 = Pc[3+7+7+7-1:3+7+7]               ;
    wire  [6:0]   Part4PcFor7 = Pc[3+7+7+7+7-1:3+7+7+7]           ;
    wire  [6:0]   Part5PcFor7 = {{(7-1){1'b0}},Pc[3+7+7+7+7]}     ;
    //pc 折叠 for 8
    wire  [7:0]   Part1PcFor8 = Pc[3+8-1:3]                       ;
    wire  [7:0]   Part2PcFor8 = Pc[3+8+8-1:3+8]                   ;
    wire  [7:0]   Part3PcFor8 = Pc[3+8+8+8-1:3+8+8]               ;
    wire  [7:0]   Part4PcFor8 = {3'b0, Pc[31:3+8+8+8]}            ;
    //pc 折叠 for 9
    wire  [8:0]   Part1PcFor9 = Pc[3+9-1:3]                       ;
    wire  [8:0]   Part2PcFor9 = Pc[3+9+9-1:3+9]                   ;
    wire  [8:0]   Part3PcFor9 = Pc[3+9+9+9-1:3+9+9]               ;
    wire  [8:0]   Part4PcFor9 = {{(9-2){1'b0}}, Pc[31:3+9+9+9]}   ;


    //for base INDEX: XOR PC
    wire  [BASEPW-1:0]   BaseIndex ;
    assign BaseIndex = Part1PcFor7 ^ Part2PcFor7 ^ Part3PcFor7 ^ Part4PcFor7 ^ Part5PcFor7 ;
    wire  [1:0]          PHTregBase ;    
    Tage_T1_128 base (
    .clka     (Clk),    // input wire clka
    .ena      (`AbleValue),      // input wire ena
    .wea(wea),      // input wire [0 : 0] wea
    .addra(addra),  // input wire [6 : 0] addra
    .dina(dina),    // input wire [8 : 0] dina
    .clkb    (Clk),    // input wire clkb
    .enb     (`AbleValue ),      // input wire enb
    .addrb   (BaseIndex),  // input wire [6 : 0] addrb
    .doutb   (PHTregBase)  // output wire [8 : 0] doutb
    );

    wire  [T1PW-1:0]   T1Index ;
    wire  [T1TGE-1:0]  T1Tag   ;  
    wire  [T1PW-1:0]   GHRT1     = {{(T1PW-T1GHR){1'b0}},GHR[T1GHR-1:0]} ;
    wire  [T1TGE-1:0]  BNUMT1    = {{(T1TGE-3){1'b0}},3'd1} ;
    assign T1Index   = GHRT1 ^ Part1PcFor7 ^ Part2PcFor7 ^ Part3PcFor7 ^ Part4PcFor7 ^ Part5PcFor7   ;
    assign T1Tag     = BNUMT1 ^ Part1PcFor7 ^ Part2PcFor7 ^ Part3PcFor7 ^ Part4PcFor7 ^ Part5PcFor7  ;
    wire  [T1TGE+2-1:0]    BankDateT1 ; 
    wire  [1:0]            CounterT1;

    reg   [T1TGE-1:0]   T1TagReg ;
    always @(posedge Clk) begin
        if(!Rest) 
            T1TagReg <= {T1TGE{1'b0}};
        else 
            T1TagReg <= T1Tag ;
    end


    Tage_T1_128 T1 (
        .clka     (Clk),    // input wire clka
        .ena      (`AbleValue),      // input wire ena
        .wea(wea),      // input wire [0 : 0] wea
        .addra(addra),  // input wire [6 : 0] addra
        .dina(dina),    // input wire [8 : 0] dina
        .clkb    (Clk),    // input wire clkb
        .enb     (`AbleValue),      // input wire enb
        .addrb   (T1Index),  // input wire [6 : 0] addrb
        .doutb   (BankDateT1)  // output wire [8 : 0] doutb
    );

    Use_counter_128 u1_Use_counter_128(
        .Clk    ( Clk    ),
        .Rest   ( Rest   ),
        .Waddr  ( Waddr  ),
        .Raddr  ( T1Index          ),
        .Atten  ( AttenuationAble  ),
        .Wable  ( Wable  ),
        .Rable  ( ForceAble        ),
        .Wdate  ( Wdate  ),
        .Rdate  ( CounterT1        )
    );

    wire  [T2PW-1:0]   T2Index ;
    wire  [T2TGE-1:0]  T2Tag   ;  
    wire  [T2PW-1:0]   GHRT2     = {{(T2PW-T2GHR){1'b0}},GHR[T2GHR-1:0]} ;
    wire  [T2TGE-1:0]  BNUMT2    = {{(T2TGE-3){1'b0}},3'd2} ;
    assign T2Index   = GHRT2 ^ Part1PcFor7 ^ Part2PcFor7 ^ Part3PcFor7 ^ Part4PcFor7 ^ Part5PcFor7       ;
    assign T2Tag     = BNUMT2 ^ Part1PcFor7 ^ Part2PcFor7 ^ Part3PcFor7 ^ Part4PcFor7 ^ Part5PcFor7      ;
    wire  [T2TGE+2-1:0]    BankDateT2 ; 
    wire  [1:0]            CounterT2  ;

    reg   [T2TGE-1:0]  T2TagReg ;
    always @(posedge Clk) begin
        if(!Rest) 
            T2TagReg <= {T2TGE{1'b0}} ;
        else 
            T2TagReg <= T2Tag ;
    end

    Tage_T2_128 T2 (
        .clka     (Clk),    // input wire clka
        .ena      (`AbleValue),      // input wire ena
        .wea(wea),      // input wire [0 : 0] wea
        .addra(addra),  // input wire [6 : 0] addra
        .dina(dina),    // input wire [8 : 0] dina
        .clkb    (Clk),    // input wire clkb
        .enb     (`AbleValue),      // input wire enb
        .addrb   (T2Index),  // input wire [6 : 0] addrb
        .doutb   (BankDateT2)  // output wire [8 : 0] doutb
    );

    Use_counter_128 u2_Use_counter_128(
        .Clk    ( Clk    ),
        .Rest   ( Rest   ),
        .Waddr  ( Waddr  ),
        .Raddr  ( T2Index          ),
        .Atten  ( AttenuationAble  ),
        .Wable  ( Wable  ),
        .Rable  ( ForceAble        ),
        .Wdate  ( Wdate  ),
        .Rdate  ( CounterT2        )
    );


    wire  [T3PW-1:0]   T3Index ;
    wire  [T3TGE-1:0]  T3Tag   ;  
    wire  [T3PW-1:0]   GHRT3     = GHR[T3GHR-1:0] ;
    wire  [T3TGE-1:0]  BNUMT3    = {{(T3TGE-3){1'b0}},3'd3} ;
    assign T3Index   = GHRT3 ^ Part1PcFor8 ^ Part2PcFor8 ^ Part3PcFor8 ^ Part4PcFor8     ;
    assign T3Tag     = BNUMT3 ^ Part1PcFor8 ^ Part2PcFor8 ^ Part3PcFor8 ^ Part4PcFor8    ;
    wire  [T3TGE+2-1:0]    BankDateT3 ; 
    wire  [1:0]            CounterT3  ;

    reg   [T3TGE-1:0]  T3TagReg ;
    always @(posedge Clk) begin
        if(!Rest) 
            T3TagReg <= {T3TGE{1'b0}} ;
        else 
            T3TagReg <= T3Tag ;
    end

    Tage_T3_256 T3 (
        .clka     (Clk),    // input wire clka
        .ena      (`AbleValue),      // input wire ena
        .wea(wea),      // input wire [0 : 0] wea
        .addra(addra),  // input wire [6 : 0] addra
        .dina(dina),    // input wire [8 : 0] dina
        .clkb    (Clk),    // input wire clkb
        .enb     (`AbleValue),      // input wire enb
        .addrb   (T3Index),  // input wire [6 : 0] addrb
        .doutb   (BankDateT3)  // output wire [8 : 0] doutb
    );

    Use_counter_256 u1_Use_counter_256(
        .Clk    ( Clk    ),
        .Rest   ( Rest   ),
        .Waddr  ( Waddr  ),
        .Raddr  ( T3Index          ),
        .Atten  ( AttenuationAble  ),
        .Wable  ( Wable  ),
        .Rable  ( ForceAble        ),
        .Wdate  ( Wdate  ),
        .Rdate  ( CounterT3        )
    );
    

    wire  [T4PW-1:0]   T4Index ;
    wire  [T4TGE-1:0]  T4Tag   ;  
    wire  [T4PW-1:0]   GHRT4Par1 = GHR[T4GHR-8-1:0] ;
    wire  [T4PW-1:0]   GHRT4Par2 = GHR[T4GHR:T4GHR-8] ;
    wire  [T4TGE-1:0]  BNUMT4    = {{(T4TGE-3){1'b0}},3'd4} ;
    assign T4Index   = GHRT4Par1 ^ GHRT4Par2 ^ Part1PcFor8 ^ Part2PcFor8 ^ Part3PcFor8 ^ Part4PcFor8     ;
    assign T4Tag     = BNUMT4 ^ Part1PcFor8 ^ Part2PcFor8 ^ Part3PcFor8 ^ Part4PcFor8                    ;
    wire  [T4TGE+2-1:0]    BankDateT4 ; 
    wire  [1:0]            CounterT4  ;

    reg   [T4TGE-1:0]  T4TagReg ;
    always @(posedge Clk) begin
        if(!Rest) 
            T4TagReg <= {T4TGE{1'b0}} ;
        else 
            T4TagReg <= T4Tag ;
    end

    Tage_T4_256 T4 (
        .clka     (Clk),    // input wire clka
        .ena      (`AbleValue),      // input wire ena
        .wea(wea),      // input wire [0 : 0] wea
        .addra(addra),  // input wire [6 : 0] addra
        .dina(dina),    // input wire [8 : 0] dina
        .clkb    (Clk),    // input wire clkb
        .enb     (`AbleValue),      // input wire enb
        .addrb   (T4Index),  // input wire [6 : 0] addrb
        .doutb   (BankDateT4)  // output wire [8 : 0] doutb
    );

    Use_counter_256 u2_Use_counter_256(
        .Clk    ( Clk    ),
        .Rest   ( Rest   ),
        .Waddr  ( Waddr  ),
        .Raddr  ( T4Index          ),
        .Atten  ( AttenuationAble  ),
        .Wable  ( Wable  ),
        .Rable  ( ForceAble        ),
        .Wdate  ( Wdate  ),
        .Rdate  ( CounterT4        )
    );

    wire  [T5PW-1:0]   T5Index ;
    wire  [T5TGE-1:0]  T5Tag   ;  
    wire  [T5PW-1:0]   GHRT5par1 = GHR[T5PW-1:0] ;
    wire  [T5PW-1:0]   GHRT5par2 = GHR[T5PW+T5PW-1:T5PW] ;
    wire  [T5PW-1:0]   GHRT5par3 = GHR[T5PW+T5PW+T5PW-1:T5PW+T5PW] ;
    wire  [T5PW-1:0]   GHRT5par4 = GHR[T5PW+T5PW+T5PW+T5PW-1:T5PW+T5PW+T5PW] ;
    wire  [T5PW-1:0]   GHRT5par5 = {3'b0, GHR[T5GHR-1:T5PW+T5PW+T5PW+T5PW]}  ;
    wire  [T5TGE-1:0]  BNUMT5   = {{(T5TGE-3){1'b0}},3'd5} ;
    assign T5Index   = GHRT5par1 ^ GHRT5par2 ^ GHRT5par3 ^ GHRT5par4 ^ GHRT5par5 ^ Part1PcFor7 ^ Part2PcFor7 ^ Part3PcFor7 ^ Part4PcFor7 ^ Part5PcFor7  ;
    assign T5Tag     = BNUMT5 ^ Part1PcFor7 ^ Part2PcFor7 ^ Part3PcFor7 ^ Part4PcFor7 ^ Part5PcFor7    ;
    wire  [T5TGE+2-1:0]    BankDateT5 ; 
    wire  [1:0]            CounterT5  ;

    reg   [T5TGE-1:0]  T5TagReg ;
    always @(posedge Clk) begin
        if(!Rest) 
            T5TagReg <= {T5TGE{1'b0}} ;
        else 
            T5TagReg <= T5Tag ;
    end

    Tage_T5_128 T5 (
        .clka     (Clk),    // input wire clka
        .ena      (`AbleValue),      // input wire ena
        .wea(wea),      // input wire [0 : 0] wea
        .addra(addra),  // input wire [6 : 0] addra
        .dina(dina),    // input wire [8 : 0] dina
        .clkb    (Clk),    // input wire clkb
        .enb     (`AbleValue),      // input wire enb
        .addrb   (T5Index),  // input wire [6 : 0] addrb
        .doutb   (BankDateT5)  // output wire [8 : 0] doutb
    );

    Use_counter_128 u3_Use_counter_128(
        .Clk    ( Clk    ),
        .Rest   ( Rest   ),
        .Waddr  ( Waddr  ),
        .Raddr  ( T5Index          ),
        .Atten  ( AttenuationAble  ),
        .Wable  ( Wable  ),
        .Rable  ( ForceAble        ),
        .Wdate  ( Wdate  ),
        .Rdate  ( CounterT5        )
    );

    wire  [T6PW-1:0]   T6Index ;
    wire  [T6TGE-1:0]  T6Tag   ;  
    wire  [T6PW-1:0]   GHRT6par1 = GHR[T6PW-1:0] ;
    wire  [T6PW-1:0]   GHRT6par2 = GHR[T6PW+T6PW-1:T6PW] ;
    wire  [T6PW-1:0]   GHRT6par3 = GHR[T6PW+T6PW+T6PW-1:T6PW+T6PW] ;
    wire  [T6PW-1:0]   GHRT6par4 = GHR[T6PW+T6PW+T6PW+T6PW-1:T6PW+T6PW+T6PW] ;
    wire  [T6PW-1:0]   GHRT6par5 = GHR[T6PW+T6PW+T6PW+T6PW+T6PW-1:T6PW+T6PW+T6PW+T6PW]  ;
    wire  [T6PW-1:0]   GHRT6par6 = GHR[T6PW+T6PW+T6PW+T6PW+T6PW+T6PW-1:T6PW+T6PW+T6PW+T6PW+T6PW] ;
    wire  [T6PW-1:0]   GHRT6par7 = GHR[T6PW+T6PW+T6PW+T6PW+T6PW+T6PW+T6PW-1:T6PW+T6PW+T6PW+T6PW+T6PW+T6PW] ;
    wire  [T6PW-1:0]   GHRT6par8 = GHR[T6PW+T6PW+T6PW+T6PW+T6PW+T6PW+T6PW+T6PW-1:T6PW+T6PW+T6PW+T6PW+T6PW+T6PW+T6PW] ;
    wire  [T6PW-1:0]   GHRT6par9 = GHR[T6PW+T6PW+T6PW+T6PW+T6PW+T6PW+T6PW+T6PW+T6PW-1:T6PW+T6PW+T6PW+T6PW+T6PW+T6PW+T6PW+T6PW] ;
    wire  [T6PW-1:0]   GHRT6par10= {7'd0, GHR[GHRWIDE-1:T6PW+T6PW+T6PW+T6PW+T6PW+T6PW+T6PW+T6PW+T6PW]} ;
    wire  [T6TGE-1:0]  BNUMT6   = {{(T5TGE-3){1'b0}},3'd6} ;
    assign T6Index   = GHRT6par1 ^ GHRT6par2 ^ GHRT6par3 ^ GHRT6par4 ^ GHRT6par5 ^ GHRT6par6 ^ GHRT6par7 ^ GHRT6par8 ^ GHRT6par9 ^ GHRT6par10 ^
                       Part1PcFor7 ^ Part2PcFor7 ^ Part3PcFor7 ^ Part4PcFor7 ^ Part5PcFor7  ;
    assign T6Tag     = BNUMT6 ^ Part1PcFor7 ^ Part2PcFor7 ^ Part3PcFor7 ^ Part4PcFor7 ^ Part5PcFor7    ;
    wire  [T6TGE+2-1:0]    BankDateT6 ; 
    wire  [1:0]            CounterT6  ;

    reg   [T6TGE-1:0]  T6TagReg ;
    always @(posedge Clk) begin
        if(!Rest) 
            T6TagReg <= {T6TGE{1'b0}} ;
        else 
            T6TagReg <= T6Tag ;
    end
    
    Tage_T6_128 T6 (
        .clka     (Clk),    // input wire clka
        .ena      (`AbleValue),      // input wire ena
        .wea(wea),      // input wire [0 : 0] wea
        .addra(addra),  // input wire [6 : 0] addra
        .dina(dina),    // input wire [8 : 0] dina
        .clkb    (Clk),    // input wire clkb
        .enb     (`AbleValue),      // input wire enb
        .addrb   (T6Index),  // input wire [6 : 0] addrb
        .doutb   (BankDateT6)  // output wire [8 : 0] doutb
    );

    Use_counter_128 u4_Use_counter_128(
        .Clk    ( Clk    ),
        .Rest   ( Rest   ),
        .Waddr  ( Waddr  ),
        .Raddr  ( T6Index          ),
        .Atten  ( AttenuationAble  ),
        .Wable  ( Wable  ),
        .Rable  ( ForceAble        ),
        .Wdate  ( Wdate  ),
        .Rdate  ( CounterT6        )
    );

    //wire       BaseHit   ;
    wire [1:0] BaseJumpSign;
    wire       T1Hit     ;
    wire [1:0] T1UseFul  ;
    wire [1:0] T1JumpSign;
    wire       T2Hit     ;
    wire [1:0] T2UseFul  ;
    wire [1:0] T2JumpSign;
    wire       T3Hit     ;
    wire [1:0] T3UseFul  ;
    wire [1:0] T3JumpSign;
    wire       T4Hit     ;
    wire [1:0] T4UseFul  ;
    wire [1:0] T4JumpSign;
    wire       T5Hit     ;
    wire [1:0] T5UseFul  ;
    wire [1:0] T5JumpSign;
    wire       T6Hit     ;
    wire [1:0] T6UseFul  ;
    wire [1:0] T6JumpSign;

    assign BaseJumpSign = PHTregBase ;
    assign T1Hit        = (T1TagReg == BankDateT1[T1TGE+2-1:2]) ;
    assign T1JumpSign   = BankDateT1[1:0] ;
    assign T1UseFul     = CounterT1       ;     
    assign T2Hit        = (T2TagReg == BankDateT2[T2TGE+2-1:2]) ;
    assign T2JumpSign   = BankDateT2[1:0] ;
    assign T2UseFul     = CounterT2       ;
    assign T3Hit        = (T3TagReg == BankDateT3[T3TGE+2-1:2]) ;
    assign T3JumpSign   = BankDateT3[1:0] ;
    assign T3UseFul     = CounterT3       ;
    assign T4Hit        = (T4TagReg == BankDateT4[T4TGE+2-1:2]) ;
    assign T4JumpSign   = BankDateT4[1:0] ;
    assign T4UseFul     = CounterT4       ;
    assign T5Hit        = (T5TagReg == BankDateT5[T5TGE+2-1:2]) ;
    assign T5JumpSign   = BankDateT5[1:0] ;
    assign T5UseFul     = CounterT5       ;
    assign T6Hit        = (T6TagReg == BankDateT6[T6TGE+2-1:2]) ;
    assign T6JumpSign   = BankDateT6[1:0] ;
    assign T6UseFul     = CounterT6       ;

    wire FristSelect = T6Hit ? 


    reg                    FoutAbleReg ;
    reg                    FpredictReg ;
    reg   [TAGEBANK-1:0]   FinaSelectBank ;
    reg   [GHRWIDE-1:0]    FGHRReg        ;
    reg   [`InstAddrBus]   FPcReg         ;

    always @(posedge Clk) begin
        if(!Rest) begin
            FoutAbleReg     <= `EnableValue;
            FpredictReg     <= `EnableValue;
            FinaSelectBank  <= {TAGEBANK{1'b0}};
            FGHRReg         <= {GHRWIDE{1'b0}} ;
            FPcReg          <= `ZeorDate; 
        end
        else begin
            FoutAbleReg     <= TageReady   ;
            FpredictReg     <= `EnableValue;
            FinaSelectBank  <= {TAGEBANK{1'b0}};
            FGHRReg         <= {GHRWIDE{1'b0}} ;
            FPcReg          <= PcReg       ; 
        end
    end
 

endmodule
