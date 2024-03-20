`timescale 1ps/1ps
`include "IPsetting.v"

module CRIQ #(
    parameter CRIQWIDE = 1 ,
    parameter CRIQDEEP = 1 ,
    parameter PTRWIDE  = 1 
) (
    input         wire                            Clk           ,
    input         wire                            Rest          ,

    input         wire                            Rable         ,
    output        wire       [CRIQWIDE-1:0]       Dout          , //23 wide

    output        wire       [CRIQWIDE-1:0]       CriqPreOut    ,

    output        wire       [CRIQWIDE-1:0]       Frontd        ,

    input         wire                            Wable         ,
    input         wire       [CRIQWIDE-1:0]       Din           ,

    input         wire                            CriqClean     ,

    output        wire                            CriqFull      ,
    output        wire                            CriqEmpty     
);

    reg   [CRIQWIDE-1:0] CRIQREG [0:CRIQDEEP]  ;
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
              Criqfront <= Criqfront + 1 ;
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
    assign CriqFull   = (((Criqtril - Criqfront) == 1) || ((Criqtril == 0) && (Criqfront == CRIQDEEP))) ;
    assign CriqEmpty  = (Criqtril == Criqfront) ;
    assign CriqPreOut = CRIQREG[Criqtril]       ; 
    assign Frontd     = CriqEmpty ? {CRIQWIDE{1'b0}} : CRIQREG[Criqfront-1]    ; 

endmodule
