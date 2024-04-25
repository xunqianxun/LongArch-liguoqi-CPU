`timescale 1ps/1ps
`include "IPsetting.v"
`include "../Core/define.v"

module STACK_reload #(
    parameter STACKDEEP  = 16 ,
    parameter STACKPTRW  = 4  ,
    parameter STACKWIDE  = 32 ,
    parameter RECURCOUNT = 7
) (
    input         wire                            Clk           ,
    input         wire                            Rest          ,

    input         wire                            RABLE         ,
    output        wire       [STACKWIDE-1:0]      DOUT          , 

    input         wire                            WABLE         ,
    input         wire       [STACKWIDE-1:0]      DIN           ,

    // output        wire                            STACKFULL     ,
    // output        wire                            STACKEMPTY    ,

    input         wire                            RELOAD        ,
    input         wire [STACKPTRW-1:0]            RELOADPTR     ,
    input         wire [STACKWIDE+RECURCOUNT-1:0] RELOADLINE1   ,
    input         wire [STACKWIDE+RECURCOUNT-1:0] RELOADLINE2   ,     
    input         wire [STACKWIDE+RECURCOUNT-1:0] RELOADLINE3   ,
    input         wire [STACKWIDE+RECURCOUNT-1:0] RELOADLINE4   ,
    input         wire [STACKWIDE+RECURCOUNT-1:0] RELOADLINE5   ,
    input         wire [STACKWIDE+RECURCOUNT-1:0] RELOADLINE6   ,
    input         wire [STACKWIDE+RECURCOUNT-1:0] RELOADLINE7   ,
    input         wire [STACKWIDE+RECURCOUNT-1:0] RELOADLINE8   ,
    input         wire [STACKWIDE+RECURCOUNT-1:0] RELOADLINE9   ,
    input         wire [STACKWIDE+RECURCOUNT-1:0] RELOADLINE10  ,
    input         wire [STACKWIDE+RECURCOUNT-1:0] RELOADLINE11  ,
    input         wire [STACKWIDE+RECURCOUNT-1:0] RELOADLINE12  ,
    input         wire [STACKWIDE+RECURCOUNT-1:0] RELOADLINE13  ,
    input         wire [STACKWIDE+RECURCOUNT-1:0] RELOADLINE14  ,
    input         wire [STACKWIDE+RECURCOUNT-1:0] RELOADLINE15  
);

    reg [STACKWIDE+RECURCOUNT-1:0] STACKREG [0:STACKDEEP-1] ;
    integer i ;

    reg [STACKPTRW-1:0] StackPtr  ;
    //reg [STACKWIDE-1:0] RegDout   ;
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
            if(RELOAD)begin
                StackPtr     <= RELOADPTR   ;
                STACKREG[0]  <= RELOADLINE1 ;
                STACKREG[1]  <= RELOADLINE2 ;
                STACKREG[2]  <= RELOADLINE3 ;
                STACKREG[3]  <= RELOADLINE4 ;
                STACKREG[4]  <= RELOADLINE5 ;
                STACKREG[5]  <= RELOADLINE6 ;
                STACKREG[6]  <= RELOADLINE7 ;
                STACKREG[7]  <= RELOADLINE8 ;
                STACKREG[8]  <= RELOADLINE9 ;
                STACKREG[9]  <= RELOADLINE10;
                STACKREG[10] <= RELOADLINE11;
                STACKREG[11] <= RELOADLINE12;
                STACKREG[12] <= RELOADLINE13;
                STACKREG[13] <= RELOADLINE14;
                STACKREG[14] <= RELOADLINE15;
                //STACKREG[15] <= RELOADLINE16;
            end
        end
    end

    // assign STACKFULL   = (StackPtr == 15) ; //虽设计有第16项但设计的基本没有使用即可用15項
    // assign STACKEMPTY  = (StackPtr == 0)  ;
    assign DOUT        = RABLE ?  STACKREG[StackPtr-1][STACKWIDE-1:0] : 32'd0 ;
endmodule
