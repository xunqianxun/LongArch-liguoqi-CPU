`timescale 1ps/1ps 
`include "IPsetting.v"

module Counter_256 (
    input        wire                                        Clk          ,
    input        wire                                        Rest         ,

    input        wire                                        Atten        ,
    input        wire       [7:0]                            Addr         ,
    output       wire       [2:0]                            Dout         ,
    input        wire                                        Wen          ,
    input        wire       [2:0]                            Din  
);

    reg [2:0] Counter[0:255] ;

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
                Counter[i+128] <= 3'd0 ;
                Counter[i+160] <= 3'd0 ;
                Counter[i+192] <= 3'd0 ;
                Counter[i+224] <= 3'd0 ;
            end
        end
        else if(Atten) begin
            for (i =0 ;i<32 ;i=i+1 ) begin
                Counter[i]     <= (Counter[i] > 0)    ? Counter[i]-1     : Counter[i]    ;
                Counter[i+32]  <= (Counter[i+32] > 0) ? Counter[i+32]-1  : Counter[i+32] ;
                Counter[i+64]  <= (Counter[i+64] > 0) ? Counter[i+64]-1  : Counter[i+64] ;
                Counter[i+96]  <= (Counter[i+96] > 0) ? Counter[i+96]-1  : Counter[i+96] ;
                Counter[i+128] <= (Counter[i+128]> 0) ? Counter[i+128]-1 : Counter[i+128];
                Counter[i+160] <= (Counter[i+160]> 0) ? Counter[i+160]-1 : Counter[i+160];
                Counter[i+192] <= (Counter[i+192]> 0) ? Counter[i+192]-1 : Counter[i+192];
                Counter[i+224] <= (Counter[i+224]> 0) ? Counter[i+224]-1 : Counter[i+224];
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
