`timescale 1ps/1ps
`include "IPsetting.v"

module Cache_counter #(
    parameter COUNTERWIDE = 2 ,
    parameter COUNTERPW   = 6 ,
    parameter COUNTERDEEP = 64 
) (
    input      wire                                Clk             ,
    input      wire                                Rest            ,

    input      wire                                RABLE           ,
    input      wire                                WABLE           ,
    input      wire      [COUNTERPW-1:0]           RADDR           , 
    input      wire      [COUNTERPW-1:0]           WADDR           ,
    input      wire                                CLEAN           ,
    output     wire      [COUNTERWIDE-1:0]         RDATE     
);

    reg [COUNTERWIDE-1:0] Counter [0:COUNTERDEEP-1];
    reg [COUNTERWIDE-1:0] RegDout ;
    integer i ;
    always @(posedge Clk) begin
        if(!Rest)
            for (i=0 ;i < COUNTERDEEP ;i=i+1 ) begin
                Counter[i] <= {COUNTERWIDE{1'b0}};
            end
        else begin
            if(WABLE)
                Counter[WADDR] <= (Counter[WADDR] == 3) ? Counter[WADDR] : Counter[WADDR] + 1 ;
            if(CLEAN)
                Counter[WADDR] <= {COUNTERWIDE{1'b0}} ;
        end
    end
    
    always @(posedge Clk) begin
        if(!Rest)
            RegDout <= {COUNTERWIDE{1'b0}}  ;
        else 
            if(RABLE)
                RegDout <= Counter[RADDR]    ;
            else 
                RegDout <= {COUNTERWIDE{1'b0}}  ;  
    end
    assign RDATE = RegDout ;

    
endmodule
