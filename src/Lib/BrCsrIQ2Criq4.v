`timescale 1ps/1ps
`include "IPsetting.v"

module BrCsrIQ2Criq4 #(
    parameter CRIQWIDE = 4 ,
    parameter CRIQDEEP = 4  
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
    reg   [2:0]     Criqfront                  ;
    reg   [2:0]     Criqtril                   ;

    always @(posedge Clk) begin
        if(!Rest) begin
            Criqfront  <= 3'd4 ;
            CRIQREG[0] <= 4'd1 ;
            CRIQREG[1] <= 4'd5 ;
            CRIQREG[2] <= 4'd9 ;
            CRIQREG[3] <= 4'd13 ;
            CRIQREG[4] <= 4'd0 ;
        end
        else begin
            if(Wable) begin
              Criqfront <= (Criqfront == CRIQDEEP) ? 0 : Criqfront + 1 ;
              CRIQREG[Criqfront] <= Din ;
            end 
            if(CriqClean) begin
                Criqfront  <= 3'd4 ;
                CRIQREG[0] <= 4'd1 ;
                CRIQREG[1] <= 4'd5 ;
                CRIQREG[2] <= 4'd9 ;
                CRIQREG[3] <= 4'd13 ;
                CRIQREG[4] <= 4'd0 ;
            end
        end
    end

    reg  [CRIQWIDE-1:0]  CriqOutReg  ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Criqtril   <= 3'd0 ;
            CriqOutReg <= {CRIQWIDE{1'b0}};
        end 
        else begin
            if(Rable) begin
                CriqOutReg <= CRIQREG[Criqtril] ;
                Criqtril <= (Criqtril == CRIQDEEP) ? 3'd0 : Criqtril + 1 ;
            end
            if(CriqClean)
                Criqtril <= 3'd0 ;
        end
    end

    assign Dout       = CriqOutReg              ;
    assign CriqFull   = (((Criqfront - Criqtril) == 1) || ((Criqtril == 0) && (Criqfront == CRIQDEEP))) ;
    assign CriqEmpty  = (Criqtril == Criqfront) ;
    assign CriqPreOut = CRIQREG[Criqtril]       ;  

endmodule

