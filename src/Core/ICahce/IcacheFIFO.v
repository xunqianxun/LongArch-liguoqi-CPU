`timescale 1ps/1ps
//`include "IPsetting.v"

module IcacheFIFO #(
    parameter FIFOWIDE = 68
) (
    input         wire                            Clk           ,
    input         wire                            Rest          ,

    input         wire                            Rable         ,

    output        wire       [FIFOWIDE-1:0]       FifoPreOut    ,
    output        wire       [2:0]                FifoPrePtr    ,

    input         wire                            Wable         ,
    input         wire       [FIFOWIDE-1:0]       Din           ,

    input         wire                            StateWAble    ,
    input         wire       [2:0]                StatePtr      ,
    input         wire       [1:0]                StateDate     ,

    input         wire                            FifoClean     ,
    output        wire                            FifoEmpty     ,
    output        wire                            FifoFull  
);

    reg  [FIFOWIDE-1:0] FIFOREG [0:7] ;
    reg   [2:0]     Fifofront          ;
    reg   [2:0]     Fifotril           ;

    integer i ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Fifofront <= 3'd0 ;
            for (i =0 ;i < 8 ;i = i + 1 ) begin
                FIFOREG[i] <= {FIFOWIDE{1'b0}};
            end
        end
        else begin
            FIFOREG[StatePtr][3:2] <= StateWAble ? StateDate : FIFOREG[StatePtr][3:2] ;
            if(Wable) begin
              Fifofront <=(Fifofront == 7) ? 0 : Fifofront + 1 ;
              FIFOREG[Fifofront] <= Din ;
            end 
            if(FifoClean)
              Fifofront <= 0 ;
        end
    end

    //reg  [FIFOWIDE-1:0]  FifoOutReg  ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Fifotril <= 3'd0 ;
            //FifoOutReg <= {FIFOWIDE{1'b0}};
        end 
        else begin
            if(Rable) begin
                //FifoOutReg <= FIFOREG[Fifotril] ;
                Fifotril <= (Fifotril == 7) ? 0 : Fifotril+1 ;
            end
            if(FifoClean)
                Fifotril <= 0 ;
        end
    end

    //assign Dout = FifoOutReg ;
    assign FifoFull = (((Fifotril - Fifofront) == 1) || ((Fifotril == 0) && (Fifofront == 7))) ;
    assign FifoEmpty = (Fifotril == Fifofront) ;
    assign FifoPreOut = FIFOREG[Fifotril] ;
    assign FifoPrePtr = Fifotril ;
    

    
endmodule 
