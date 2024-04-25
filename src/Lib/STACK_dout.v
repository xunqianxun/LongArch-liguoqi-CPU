`timescale 1ps/1ps
`include "IPsetting.v"
`include "../Core/define.v"

module STACK_dout #(
    parameter STACKDEEP  = 16 ,
    parameter STACKPTRW  = 4  ,
    parameter STACKWIDE  = 32 ,
    parameter RECURCOUNT = 7
) (
    input         wire                            Clk           ,
    input         wire                            Rest          ,

    input         wire                            RABLE         ,
    //output        wire       [STACKWIDE-1:0]      DOUT          , //23 wide


    input         wire                            WABLE         ,
    input         wire       [STACKWIDE-1:0]      DIN           ,

    // output        wire                            STACKFULL     ,
    // output        wire                            STACKEMPTY    ,
    //from FTQ
    input         wire                            REDIRCT       ,

    //output        wire                            OUTDATE       ,
    output        wire [STACKPTRW-1:0]            OUTDATEPTR    ,
    output        wire [STACKWIDE+RECURCOUNT-1:0] OUTDATELINE1  ,
    output        wire [STACKWIDE+RECURCOUNT-1:0] OUTDATELINE2  ,     
    output        wire [STACKWIDE+RECURCOUNT-1:0] OUTDATELINE3  ,
    output        wire [STACKWIDE+RECURCOUNT-1:0] OUTDATELINE4  ,
    output        wire [STACKWIDE+RECURCOUNT-1:0] OUTDATELINE5  ,
    output        wire [STACKWIDE+RECURCOUNT-1:0] OUTDATELINE6  ,
    output        wire [STACKWIDE+RECURCOUNT-1:0] OUTDATELINE7  ,
    output        wire [STACKWIDE+RECURCOUNT-1:0] OUTDATELINE8  ,
    output        wire [STACKWIDE+RECURCOUNT-1:0] OUTDATELINE9  ,
    output        wire [STACKWIDE+RECURCOUNT-1:0] OUTDATELINE10 ,
    output        wire [STACKWIDE+RECURCOUNT-1:0] OUTDATELINE11 ,
    output        wire [STACKWIDE+RECURCOUNT-1:0] OUTDATELINE12 ,
    output        wire [STACKWIDE+RECURCOUNT-1:0] OUTDATELINE13 ,
    output        wire [STACKWIDE+RECURCOUNT-1:0] OUTDATELINE14 ,
    output        wire [STACKWIDE+RECURCOUNT-1:0] OUTDATELINE15  
);

    reg [STACKWIDE+RECURCOUNT-1:0] STACKREG [0:STACKDEEP-1] ;
    integer i ;

    reg [STACKPTRW-1:0] StackPtr  ;
    //reg [STACKWIDE-1:0] RegDout   ;

    reg [STACKPTRW-1:0]            REGOUTDATEPTR   ;
    reg [STACKWIDE+RECURCOUNT-1:0] REGOUTDATELINE1 ;
    reg [STACKWIDE+RECURCOUNT-1:0] REGOUTDATELINE2 ;
    reg [STACKWIDE+RECURCOUNT-1:0] REGOUTDATELINE3 ;
    reg [STACKWIDE+RECURCOUNT-1:0] REGOUTDATELINE4 ;
    reg [STACKWIDE+RECURCOUNT-1:0] REGOUTDATELINE5 ;
    reg [STACKWIDE+RECURCOUNT-1:0] REGOUTDATELINE6 ;
    reg [STACKWIDE+RECURCOUNT-1:0] REGOUTDATELINE7 ;
    reg [STACKWIDE+RECURCOUNT-1:0] REGOUTDATELINE8 ;
    reg [STACKWIDE+RECURCOUNT-1:0] REGOUTDATELINE9 ;
    reg [STACKWIDE+RECURCOUNT-1:0] REGOUTDATELINE10;
    reg [STACKWIDE+RECURCOUNT-1:0] REGOUTDATELINE11;
    reg [STACKWIDE+RECURCOUNT-1:0] REGOUTDATELINE12;
    reg [STACKWIDE+RECURCOUNT-1:0] REGOUTDATELINE13;
    reg [STACKWIDE+RECURCOUNT-1:0] REGOUTDATELINE14;
    reg [STACKWIDE+RECURCOUNT-1:0] REGOUTDATELINE15;
    always @(posedge Clk) begin
        if(!Rest) begin  
            StackPtr <= {STACKPTRW{1'b0}} ;
            for (i =0 ;i < STACKDEEP ;i = i + 1 ) begin
                STACKREG[i] <= {STACKWIDE+RECURCOUNT{1'b0}};
            end
        end
        else begin
            if(WABLE) begin
                if(STACKREG[StackPtr-1][STACKWIDE-1:0] == DIN) begin
                    StackPtr <= StackPtr ;
                    STACKREG[StackPtr][STACKWIDE+RECURCOUNT-1:STACKWIDE] <= STACKREG[StackPtr][STACKWIDE+RECURCOUNT-1:STACKWIDE] + 1 ; 
                end
                else begin 
                    StackPtr <= StackPtr + 1 ;
                    STACKREG[StackPtr] <= {{(RECURCOUNT-1){1'b0}},1'b1,DIN} ;
                end 
            end
            if(RABLE) begin
                if(STACKREG[StackPtr-1][STACKWIDE+RECURCOUNT-1:STACKWIDE] > 1)begin
                    StackPtr <= StackPtr         ;
                    //RegDout  <= STACKREG[StackPtr-1][STACKWIDE-1:0] ;
                    STACKREG[StackPtr-1][STACKWIDE+RECURCOUNT-1:STACKWIDE] <= STACKREG[StackPtr-1][STACKWIDE+RECURCOUNT-1:STACKWIDE] - 1 ;
                end
                else begin 
                    StackPtr <= StackPtr - 1                        ;
                    //RegDout  <= STACKREG[StackPtr-1][STACKWIDE-1:0] ;
                    STACKREG[StackPtr-1] <= {STACKWIDE+RECURCOUNT{1'b0}}       ;  
                end 
            end
            if(REDIRCT)begin
                REGOUTDATEPTR <= StackPtr ;
                REGOUTDATELINE1 <= STACKREG[0] ;
                REGOUTDATELINE2 <= STACKREG[1] ;
                REGOUTDATELINE3 <= STACKREG[2] ;
                REGOUTDATELINE4 <= STACKREG[3] ;
                REGOUTDATELINE5 <= STACKREG[4] ;
                REGOUTDATELINE6 <= STACKREG[5] ;
                REGOUTDATELINE7 <= STACKREG[6] ;
                REGOUTDATELINE8 <= STACKREG[7] ;
                REGOUTDATELINE9 <= STACKREG[8] ;
                REGOUTDATELINE10<= STACKREG[9]  ; 
                REGOUTDATELINE11<= STACKREG[10] ;
                REGOUTDATELINE12<= STACKREG[11] ;
                REGOUTDATELINE13<= STACKREG[12] ;
                REGOUTDATELINE14<= STACKREG[13] ;
                REGOUTDATELINE15<= STACKREG[14] ;
            end 
        end
    end

    // assign STACKFULL    = (StackPtr == 15) ; //虽设计有第16项但设计的基本没有使用即可用15項
    // assign STACKEMPTY   = (StackPtr == 0)  ;
    //assign DOUT         = RegDout          ;

    assign OUTDATEPTR   = REGOUTDATEPTR    ;
    assign OUTDATELINE1 = REGOUTDATELINE1  ;
    assign OUTDATELINE2 = REGOUTDATELINE2  ;
    assign OUTDATELINE3 = REGOUTDATELINE3  ;
    assign OUTDATELINE4 = REGOUTDATELINE4  ;
    assign OUTDATELINE5 = REGOUTDATELINE5  ;
    assign OUTDATELINE6 = REGOUTDATELINE6  ;
    assign OUTDATELINE7 = REGOUTDATELINE7  ;
    assign OUTDATELINE8 = REGOUTDATELINE8  ;
    assign OUTDATELINE9 = REGOUTDATELINE9  ;
    assign OUTDATELINE10= REGOUTDATELINE10 ;
    assign OUTDATELINE11= REGOUTDATELINE11 ;
    assign OUTDATELINE12= REGOUTDATELINE12 ;
    assign OUTDATELINE13= REGOUTDATELINE13 ;
    assign OUTDATELINE14= REGOUTDATELINE14 ;
    assign OUTDATELINE15= REGOUTDATELINE15 ;

endmodule

