`timescale 1ps/1ps
`include "IPsetting.v"

module FIFO_ftq #(
    parameter FIFOWIDE = 24
) (
    input         wire                            Clk           ,
    input         wire                            Rest          ,

    input         wire                            Rable         ,
    //output        wire       [FIFOWIDE-1:0]       Dout          , //23 wide

    output        wire       [FIFOWIDE-1:0]       FifoPreOut    ,

    input         wire                            Wable         ,
    input         wire       [FIFOWIDE-1:0]       Din           ,

    input         wire                            FifoClean     ,

    output        wire                            FifoFull      
    //output        wire                            FifoEmpty     
);

    reg  [FIFOWIDE-1:0] FIFOREG [0:64] ;
    reg   [6:0]     Fifofront          ;
    reg   [6:0]     Fifotril           ;

    integer i ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Fifofront <= 7'd0 ;
            for (i =0 ;i < 32 ;i = i + 1 ) begin
                FIFOREG[i] <= {FIFOWIDE{1'b0}};
                FIFOREG[1+32] <= {FIFOWIDE{1'b0}};
            end
            FIFOREG[64] <= {FIFOWIDE{1'b0}}; 
        end
        else begin
            if(Wable) begin
              Fifofront <=(Fifofront == 64) ? 0 : Fifofront + 1 ;
              FIFOREG[Fifofront] <= Din ;
            end 
            if(FifoClean)
              Fifofront <= 0 ;
        end
    end

    //reg  [FIFOWIDE-1:0]  FifoOutReg  ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Fifotril <= 7'd0 ;
            //FifoOutReg <= {FIFOWIDE{1'b0}};
        end 
        else begin
            if(Rable) begin
                //FifoOutReg <= FIFOREG[Fifotril] ;
                Fifotril <= (Fifotril == 64) ? 0 : Fifotril+1 ;
            end
            if(FifoClean)
                Fifotril <= 0 ;
        end
    end

    //assign Dout = FifoOutReg ;
    assign FifoFull = (((Fifotril - Fifofront) == 1) || ((Fifotril == 0) && (Fifofront == 64))) ;
    //assign FifoEmpty = (Fifotril == Fifofront) ;
    assign FifoPreOut = FIFOREG[Fifotril] ;
    

    
endmodule 
