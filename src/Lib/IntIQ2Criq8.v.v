`timescale 1ps/1ps
`include "IPsetting.v"

module IntIQ2Criq8 #(
    parameter CRIQWIDE = 5 ,
    parameter CRIQDEEP = 8  
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
    reg   [3:0]     Criqfront                  ;
    reg   [3:0]     Criqtril                   ;

    always @(posedge Clk) begin
        if(!Rest) begin
            Criqfront  <= 4'd8 ;
            CRIQREG[0] <= 5'd1 ;
            CRIQREG[1] <= 5'd5 ;
            CRIQREG[2] <= 5'd9 ;
            CRIQREG[3] <= 5'd13 ;
            CRIQREG[4] <= 5'd17 ;
            CRIQREG[5] <= 5'd21 ;
            CRIQREG[6] <= 5'd25 ;
            CRIQREG[7] <= 5'd29 ;
            CRIQREG[8] <= 5'd0 ;
        end
        else begin
            if(Wable) begin
              Criqfront <= (Criqfront == CRIQDEEP) ? 0 : Criqfront + 1 ;
              CRIQREG[Criqfront] <= Din ;
            end 
            if(CriqClean) begin
                Criqfront  <= 4'd8 ;
                CRIQREG[0] <= 5'd1 ;
                CRIQREG[1] <= 5'd5 ;
                CRIQREG[2] <= 5'd9 ;
                CRIQREG[3] <= 5'd13 ;
                CRIQREG[4] <= 5'd17 ;
                CRIQREG[5] <= 5'd21 ;
                CRIQREG[6] <= 5'd25 ;
                CRIQREG[7] <= 5'd29 ;
                CRIQREG[8] <= 5'd0 ;
            end
        end
    end

    reg  [CRIQWIDE-1:0]  CriqOutReg  ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Criqtril   <= 4'd0 ;
            CriqOutReg <= {CRIQWIDE{1'b0}};
        end 
        else begin
            if(Rable) begin
                CriqOutReg <= CRIQREG[Criqtril] ;
                Criqtril <= (Criqtril == CRIQDEEP) ? 4'd0 : Criqtril + 1 ;
            end
            if(CriqClean)
                Criqtril <= 4'd0 ;
        end
    end

    assign Dout       = CriqOutReg              ;
    assign CriqFull   = (((Criqfront - Criqtril) == 1) || ((Criqtril == 0) && (Criqfront == CRIQDEEP))) ;
    assign CriqEmpty  = (Criqtril == Criqfront) ;
    assign CriqPreOut = CRIQREG[Criqtril]       ;  

endmodule

