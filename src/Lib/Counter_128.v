`timescale 1ps/1ps 
`include "IPsetting.v"

module Counter_128 (
    input        wire                                        Clk          ,
    input        wire                                        Rest         ,

    input        wire       [6:0]                            Addr         ,
    output       wire       [2:0]                            Dout         ,
    input        wire                                        Wen          ,
    input        wire       [2:0]                            Din  
);

    reg [2:0] Counter[0:127] ;

    reg [2:0] RegDout ;
    integer i ;
    always @(posedge Clk) begin
        if(!Rest) begin
            RegDout <= 3'd0 ;
            for (i =0 ;i<32 ;i=i+1 ) begin
                Counter[i]    <= 3'd0 ;
                Counter[i+32] <= 3'd0 ;
                Counter[i+64] <= 3'd0 ;
                Counter[i+96] <= 3'd0 ;
            end
        end
        else begin
            RegDout <= Counter[Addr] ;
            if(Wen)
                Counter[Addr] <= Din ;
            else 
                Counter[Addr] <= Counter[Addr] ;
        end
    end

    assign Dout = RegDout ;

endmodule
