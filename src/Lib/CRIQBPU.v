`timescale 1ps/1ps
`include "IPsetting.v"

module CRIQBPU #(
    parameter CRIQWIDE = 7 ,
    parameter CRIQDEEP = 64  
) (
    input         wire                            Clk           ,
    input         wire                            Rest          ,

    input         wire                            Rable         ,
   // output        wire       [CRIQWIDE-1:0]       Dout          , //23 wide

    output        wire       [CRIQWIDE-1:0]       CriqPreOut    ,

    input         wire                            Wable         ,
    input         wire       [CRIQWIDE-1:0]       Din           ,

    input         wire                            CriqClean     ,

    output        wire                            CriqFull      
   // output        wire                            CriqEmpty     
);

    reg   [CRIQWIDE-1:0] CRIQREG [0:CRIQDEEP]  ;
    reg   [6:0]     Criqfront                  ;
    reg   [6:0]     Criqtril                   ;

    integer i ;
    integer a ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Criqfront  <= 7'd0 ;
            for (i =0 ;i<=31 ;i=i+1 ) begin
                CRIQREG[i] <= 7'd0 ;
            end
            for (a =32 ;a<=64 ;a=a+1 ) begin
                CRIQREG[a] <= 7'd0 ;
            end
        end
        else begin
            if(Wable) begin
              Criqfront <= (Criqfront == CRIQDEEP) ? 0 : Criqfront + 1 ;
              CRIQREG[Criqfront] <= Din ;
            end 
            if(CriqClean) begin
                Criqfront  <= 7'd0 ;
                for (i =0 ;i<=31 ;i=i+1 ) begin
                    CRIQREG[i] <= 7'd0 ;
                end
                for (a =32 ;a<=64 ;a=a+1 ) begin
                    CRIQREG[a] <= 7'd0 ;
                end
            end
        end
    end

    //reg  [CRIQWIDE-1:0]  CriqOutReg  ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Criqtril   <= 7'd0 ;
            //CriqOutReg <= {CRIQWIDE{1'b0}};
        end 
        else begin
            if(Rable) begin
                //CriqOutReg <= CRIQREG[Criqtril] ;
                Criqtril <= (Criqtril == CRIQDEEP) ? 7'd0 : Criqtril + 1 ;
            end
            if(CriqClean)
                Criqtril <= 7'd0 ;
        end
    end

    //assign Dout       = CriqOutReg              ;
    assign CriqFull   = (((Criqfront - Criqtril) == 1) || ((Criqtril == 0) && (Criqfront == CRIQDEEP))) ;
    //assign CriqEmpty  = (Criqtril == Criqfront) ;
    assign CriqPreOut = CRIQREG[Criqtril]       ;  

endmodule
