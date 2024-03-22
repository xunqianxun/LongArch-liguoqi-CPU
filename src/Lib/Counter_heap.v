`timescale 1ps/1ps
`include "IPsetting.v"

module Counter_heap #(
    parameter COUNTERWIDE = 2 ,
    parameter COUNTERPW   = 6 ,
    parameter COUNTERDEEP = 64 
) (
    input      wire                                Clk             ,
    input      wire                                Rest            ,

    input      wire      [COUNTERPW-1:0]           UpAddr          , 
    input      wire      [COUNTERPW-1:0]           ReadAddr        ,
    input      wire                                Attenuation     ,//衰减需要在判断的周期i里面进行这样不会和update争抢端口
    input      wire                                UpdateAble      ,
    input      wire                                ReadAble        ,
    input      wire                                RightOrFault    ,
    output     wire      [COUNTERWIDE-1:0]         DoutCounter     
);

    reg [COUNTERWIDE-1:0] Counter [0:COUNTERDEEP-1];
    reg [COUNTERWIDE-1:0] RegDout ;
    integer i ;
    integer j ;
    always @(posedge Clk) begin
        if(!Rest)
            for (i=0 ;i < COUNTERDEEP ;i=i+1 ) begin
                Counter[i] <= {COUNTERWIDE{1'b0}};
            end
        else begin
            if(UpdateAble)
                Counter[UpAddr] <= (RightOrFault != 0) ? ((Counter[UpAddr] == 3) ? Counter[UpAddr] : Counter[UpAddr] +1) :((Counter[UpAddr] == 0) ? Counter[UpAddr] : Counter[UpAddr] -1) ;
            if(Attenuation)
                for (j =0 ;j< COUNTERDEEP ;j=j+1 ) begin
                    Counter[i] <= {1'b0,Counter[i][1]} ;
                end
        end
    end
    
    always @(posedge Clk) begin
        if(!Rest)
            RegDout <= {COUNTERWIDE{1'b0}}  ;
        else 
            if(ReadAble)
                RegDout <= Counter[ReadAddr]    ;
            else 
                RegDout <= {COUNTERWIDE{1'b0}}  ;  
    end
    assign DoutCounter = RegDout ;

    
endmodule
