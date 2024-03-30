`timescale 1ps/1ps
`include "IPsetting.v"

module FIFOstu #(
    parameter FIFOWIDE = 1 
) (
    input         wire                            Clk           ,
    input         wire                            Rest          ,

    input         wire                            Rable         ,
    output        wire       [FIFOWIDE-1:0]       Dout          , //23 wide

    output        wire       [FIFOWIDE-1:0]       FifoPreOut    ,

    input         wire                            Wable         ,
    input         wire       [FIFOWIDE-1:0]       Din           ,

    input         wire                            FifoClean     ,

    output        wire                            FifoFull      ,
    output        wire                            FifoEmpty     ,

    output        wire       [FIFOWIDE-1:0]       FIFOreg1      ,
    output        wire       [FIFOWIDE-1:0]       FIFOreg2      ,
    output        wire       [FIFOWIDE-1:0]       FIFOreg3      ,
    output        wire       [FIFOWIDE-1:0]       FIFOreg4      ,
    output        wire       [FIFOWIDE-1:0]       FIFOreg5      ,
    output        wire       [FIFOWIDE-1:0]       FIFOreg6      ,
    output        wire       [FIFOWIDE-1:0]       FIFOreg7      
);

    reg  [FIFOWIDE-1:0] FIFOREG [0:16] ;
    reg   [4:0]     Fifofront          ;
    reg   [4:0]     Fifotril           ;

    integer i ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Fifofront <= 5'd0 ;
            for (i =0 ;i < 17 ;i = i + 1 ) begin
                FIFOREG[i] <= {FIFOWIDE{1'b0}};
            end
        end
        else begin
            FIFOREG[Fifotril] <= Rable ? {FIFOWIDE{1'b0}} : FIFOREG[Fifotril];
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
    assign FifoFull = ((Fifotril - Fifofront) == 1) || ((Fifotril == 0) && (Fifofront == 6)) ;
    assign FifoEmpty = (Fifotril == Fifofront) ;
    assign FifoPreOut = FIFOREG[Fifotril] ;

    assign FIFOreg1 = FIFOREG[0] ;
    assign FIFOreg2 = FIFOREG[1] ;
    assign FIFOreg3 = FIFOREG[2] ;
    assign FIFOreg4 = FIFOREG[3] ;
    assign FIFOreg5 = FIFOREG[4] ;
    assign FIFOreg6 = FIFOREG[5] ;
    assign FIFOreg7 = FIFOREG[6] ;

endmodule
