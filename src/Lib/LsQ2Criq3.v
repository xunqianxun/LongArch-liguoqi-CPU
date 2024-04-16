`timescale 1ps/1ps
`include "IPsetting.v"

module LsQ2Criq3 #(
    parameter CRIQWIDE = 4 ,
    parameter CRIQDEEP = 3  
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
    output        wire                            CriqEmpty     
);

    reg   [CRIQWIDE-1:0] CRIQREG [0:CRIQDEEP]  ;
    reg   [1:0]     Criqfront                  ;
    reg   [1:0]     Criqtril                   ;

    always @(posedge Clk) begin
        if(!Rest) begin
            Criqfront  <= 2'd3 ;
            CRIQREG[0] <= 4'd0 ;
            CRIQREG[1] <= 4'd4 ;
            CRIQREG[2] <= 4'd8 ;
            CRIQREG[3] <= 4'd0 ;
        end
        else begin
            if(Wable) begin
              Criqfront <= (Criqfront == CRIQDEEP) ? 0 : Criqfront + 1 ;
              CRIQREG[Criqfront] <= Din ;
            end 
            if(CriqClean) begin
                Criqfront  <= 2'd3 ;
                CRIQREG[0] <= 4'd0 ;
                CRIQREG[1] <= 4'd4 ;
                CRIQREG[2] <= 4'd8 ;
                CRIQREG[3] <= 4'd0 ;
            end
        end
    end

    reg  [CRIQWIDE-1:0]  CriqOutReg  ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Criqtril   <= 2'd0 ;
            CriqOutReg <= {CRIQWIDE{1'b0}};
        end 
        else begin
            if(Rable) begin
                CriqOutReg <= CRIQREG[Criqtril] ;
                Criqtril <= (Criqtril == CRIQDEEP) ? 2'd0 : Criqtril + 1 ;
            end
            if(CriqClean)
                Criqtril <= 2'd0 ;
        end
    end

    assign Dout       = CriqOutReg              ;
    assign CriqFull   = (((Criqfront - Criqtril) == 1) || ((Criqtril == 0) && (Criqfront == CRIQDEEP))) ;
    assign CriqEmpty  = (Criqtril == Criqfront) ;
    assign CriqPreOut = CRIQREG[Criqtril]       ;  

endmodule

