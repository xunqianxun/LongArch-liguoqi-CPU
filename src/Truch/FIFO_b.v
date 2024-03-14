`timescale 1ps/1ps
`include "IPsetting.v"

module FIFO_b #( //支持写指针回滚的FIFO 
    parameter FIFOWIDE = 1 ,
    parameter MARKWIDE = 1 
) (
    input         wire                            Clk           ,
    input         wire                            Rest          ,

    input         wire                            Mable         ,
    input         wire       [MARKWIDE-1:0]       Mark          ,

    input         wire                            Rable         ,
    output        wire       [FIFOWIDE-1:0]       Dout          , //23 wide

    output        wire       [FIFOWIDE-1:0]       FifoPreOut    ,

    input         wire                            Wable         ,
    input         wire       [FIFOWIDE-1:0]       Din           ,

    input         wire                            FifoClean     ,

    output        wire                            FifoFull      ,
    output        wire                            FifoEmpty     
);

    reg  [FIFOWIDE-1:0] FIFOREG [0:16] ;
    reg   [4:0]     Fifofront          ;
    reg   [4:0]     Fifotril           ;

    wire [3:0] Counter ;
    

    integer i ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Fifofront <= 5'd0 ;
            for (i =0 ;i < 17 ;i = i + 1 ) begin
                FIFOREG[i] <= {FIFOWIDE{1'b0}};
            end
        end
        else begin
            if(Mable)
              Fifofront <= 
            if(Wable) begin
              Fifofront <= Fifofront + 1 ;
              FIFOREG[Fifofront] <= Din ;
            end 
            if(FifoClean)
              Fifofront <= 0 ;
        end
    end

    reg  [FIFOWIDE-1:0]  FifoOutReg  ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Fifotril <= 5'd0 ;
            FifoOutReg <= {FIFOWIDE{1'b0}};
        end 
        else begin
            if(Rable) begin
                FifoOutReg <= FIFOREG[Fifotril] ;
                Fifotril <= Fifotril - 1 ;
            end
            if(FifoClean)
                Fifotril <= 0 ;
        end
    end

    assign Dout = FifoOutReg ;
    assign FifoFull = (((Fifotril - Fifofront) == 2) || ((Fifotril == 0) && (Fifofront == 15))) && Wable ;
    assign FifoEmpty = (Fifotril == Fifofront) ;
    assign FifoPreOut = FIFOREG[Fifotril] ;
    

    
endmodule 