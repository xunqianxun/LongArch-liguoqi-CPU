`timescale 1ps/1ps
`include "IPsetting.v"

module CRIQ_csr #(
    parameter CRIQWIDE = 3 ,
    parameter CRIQDEEP = 8 ,
    parameter PTRWIDE  = 3 
) (
    input         wire                            Clk           ,
    input         wire                            Rest          ,

    input         wire                            Rable         ,
    output        wire       [CRIQWIDE-1:0]       Dout          , //23 wide

    output        wire       [CRIQWIDE-1:0]       CriqPreOut    ,

    input         wire                            Wable         ,
    input         wire       [CRIQWIDE-1:0]       Din           ,

    input         wire                            CriqClean     ,

    output        wire                            CriqFull      ,
    output        wire                            CriqEmpty     ,

    output        wire       [PTRWIDE-1:0]        CriqFrontPtr  ,
    output        wire       [PTRWIDE-1:0]        CriqTrilPtr   ,
    output        wire       [CRIQWIDE-1:0]       TopSub1Date   ,
    output        wire       [CRIQWIDE-1:0]       TopSub2Date   ,
    output        wire       [CRIQWIDE-1:0]       TopSub3Date   ,
    output        wire       [CRIQWIDE-1:0]       TopSub4Date   ,
    output        wire       [CRIQWIDE-1:0]       TopSub5Date   ,
    output        wire       [CRIQWIDE-1:0]       TopSub6Date   
);

    reg   [CRIQWIDE-1:0] CRIQREG [0:CRIQDEEP-1]  ;
    reg   [PTRWIDE-1:0]     Criqfront          ;
    reg   [PTRWIDE-1:0]     Criqtril           ;

    integer i ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Criqfront <= {PTRWIDE{1'b0}};
            for (i =0 ;i <= CRIQDEEP ;i = i + 1 ) begin
                CRIQREG[i] <= {CRIQWIDE{1'b0}};
            end
        end
        else begin
            if(Wable) begin
              Criqfront <= (Criqfront == 7) ? 0 : Criqfront + 1 ;
              CRIQREG[Criqfront] <= Din ;
            end 
            if(CriqClean)
              Criqfront <= 0 ;
        end
    end

    reg  [CRIQWIDE-1:0]  CriqOutReg  ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Criqtril <= {PTRWIDE{1'b0}} ;
            CriqOutReg <= {CRIQWIDE{1'b0}};
        end 
        else begin
            if(Rable) begin
                CriqOutReg <= CRIQREG[Criqtril] ;
                Criqtril <= Criqtril - 1 ;
            end
            if(CriqClean)
                Criqtril <= 0 ;
        end
    end

    assign Dout       = CriqOutReg              ;
    assign CriqFull   = (((Criqtril - Criqfront) == 1) || ((Criqtril == 0) && (Criqfront == 7))) ;
    assign CriqEmpty  = (Criqtril == Criqfront) ;
    assign CriqPreOut = CRIQREG[Criqtril]       ; 
    assign CriqFrontPtr = Criqfront             ;
    assign CriqTrilPtr  = Criqtril              ;
    assign TopSub1Date  = CRIQREG[Criqtril-1]      ;
    assign TopSub2Date  = CRIQREG[Criqtril-2]      ;
    assign TopSub3Date  = CRIQREG[Criqtril-3]      ;
    assign TopSub4Date  = CRIQREG[Criqtril-4]      ;
    assign TopSub5Date  = CRIQREG[Criqtril-5]      ;
    assign TopSub6Date  = CRIQREG[Criqtril-6]      ;


endmodule
