`timescale 1ps/1ps

module Bram_SIM #( //Simple dual port RAM
    parameter BRAMWIDE  =  32 ,
    //parameter BRAMPTRW  =  5  ,
    parameter BRAMDEPW  =  5  ,
    parameter BRAMDEEP  =  32  
) (
    input       wire                                 Clk        ,
    input       wire                                 Rest       , //sim use only, for bram no this pin

    input       wire                                 REN        ,
    input       wire                                 WEN        ,
    input       wire      [BRAMDEPW-1:0]             RADDR      ,
    input       wire      [BRAMDEPW-1:0]             WADDR      ,
    input       wire      [BRAMWIDE-1:0]             DIN        ,
    output      wire      [BRAMWIDE-1:0]             DOUT     
);

    reg [BRAMWIDE-1:0] BRAMSIM [0:BRAMDEEP-1] ;

    integer i ;
    always @(posedge Clk) begin
        if(!Rest) begin
            for (i = 0;i < BRAMDEEP;i=i+1 ) begin
                BRAMSIM[i] <= {BRAMWIDE{1'b0}};
            end
        end
        else begin
            if(WEN) begin
                BRAMSIM[WADDR] <= DIN ;
            end
        end
    end

    reg [BRAMWIDE-1:0] REGDOUT   ;
    always @(posedge Clk) begin
        if(!Rest) begin
            REGDOUT <= {BRAMWIDE{1'b0}} ;
        end 
        else begin
            if(REN)begin
                REGDOUT <= BRAMSIM[RADDR] ;
            end
        end
    end


    assign DOUT = REGDOUT ;

    
endmodule
