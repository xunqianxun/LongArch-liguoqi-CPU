`timescale 1ps/1ps
`include "../define"

module CriqFreelist1 #(
    parameter CRIQWIDE = 7  ,
    parameter CRIQDEEP = 32 ,
    parameter PTRWIDE  = 6 
) (
    input         wire                            Clk           ,
    input         wire                            Rest          ,

    input         wire                            Rable         ,
    //output        wire       [CRIQWIDE-1:0]       Dout          , //23 wide

    output        wire       [CRIQWIDE-1:0]       CriqPreOut    ,

    input         wire                            Wable         ,
    input         wire       [CRIQWIDE-1:0]       Din           ,

    input         wire                            CriqClean     ,

    //output        wire                            CriqFull      ,
    output        wire                            CriqEmpty     
);

    reg   [CRIQWIDE-1:0] CRIQREG [0:CRIQDEEP]  ;
    reg   [PTRWIDE-1:0]     Criqfront          ;
    reg   [PTRWIDE-1:0]     Criqtril           ;

    always @(posedge Clk) begin
        if(!Rest) begin
            Criqfront <= 23;
            CRIQREG[0] <= 32 ;
            CRIQREG[1] <= 36 ;
            CRIQREG[2] <= 40 ;
            CRIQREG[3] <= 44 ;
            CRIQREG[4] <= 48 ;
            CRIQREG[5] <= 52 ;
            CRIQREG[6] <= 56 ;
            CRIQREG[7] <= 70 ;
            CRIQREG[8] <= 64 ;
            CRIQREG[9] <= 68 ;
            CRIQREG[10] <= 72 ;
            CRIQREG[11] <= 76 ;
            CRIQREG[12] <= 80 ;
            CRIQREG[13] <= 84 ;
            CRIQREG[14] <= 88 ;
            CRIQREG[15] <= 92 ;
            CRIQREG[16] <= 96 ;
            CRIQREG[17] <= 100 ;
            CRIQREG[18] <= 104 ;
            CRIQREG[19] <= 108 ;
            CRIQREG[20] <= 112 ;
            CRIQREG[21] <= 116 ;
            CRIQREG[22] <= 120 ;
            CRIQREG[23] <= 124 ;
            CRIQREG[24] <= 0 ;
            CRIQREG[25] <= 0 ;
            CRIQREG[26] <= 0 ;
            CRIQREG[27] <= 0 ;
            CRIQREG[28] <= 0 ;
            CRIQREG[29] <= 0 ;
            CRIQREG[30] <= 0 ;
            CRIQREG[31] <= 0 ;
        end
        else begin
            if(Wable) begin
                Criqfront <= (Criqfront == 32) ? 0 : Criqfront + 1 ;
                CRIQREG[Criqfront] <= Din ;
            end 
            if(CriqClean) begin
                Criqfront <= 23;
                CRIQREG[0] <= 32 ;
                CRIQREG[1] <= 36 ;
                CRIQREG[2] <= 40 ;
                CRIQREG[3] <= 44 ;
                CRIQREG[4] <= 48 ;
                CRIQREG[5] <= 52 ;
                CRIQREG[6] <= 56 ;
                CRIQREG[7] <= 70 ;
                CRIQREG[8] <= 64 ;
                CRIQREG[9] <= 68 ;
                CRIQREG[10] <= 72 ;
                CRIQREG[11] <= 76 ;
                CRIQREG[12] <= 80 ;
                CRIQREG[13] <= 84 ;
                CRIQREG[14] <= 88 ;
                CRIQREG[15] <= 92 ;
                CRIQREG[16] <= 96 ;
                CRIQREG[17] <= 100 ;
                CRIQREG[18] <= 104 ;
                CRIQREG[19] <= 108 ;
                CRIQREG[20] <= 112 ;
                CRIQREG[21] <= 116 ;
                CRIQREG[22] <= 120 ;
                CRIQREG[23] <= 124 ;
                CRIQREG[24] <= 0 ;
                CRIQREG[25] <= 0 ;
                CRIQREG[26] <= 0 ;
                CRIQREG[27] <= 0 ;
                CRIQREG[28] <= 0 ;
                CRIQREG[29] <= 0 ;
                CRIQREG[30] <= 0 ;
                CRIQREG[31] <= 0 ;
            end
        end
    end

    //reg  [CRIQWIDE-1:0]  CriqOutReg  ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Criqtril <= {PTRWIDE{1'b0}} ;
            //CriqOutReg <= {CRIQWIDE{1'b0}};
        end 
        else begin
            if(Rable) begin
                //CriqOutReg <= CRIQREG[Criqtril] ;
                Criqtril <= Criqtril - 1 ;
            end
            if(CriqClean)
                Criqtril <= 0 ;
        end
    end

    //assign Dout       = CriqOutReg              ;
    //assign CriqFull   = (((Criqtril - Criqfront) == 1) || ((Criqtril == 0) && (Criqfront == CRIQDEEP))) ;
    assign CriqEmpty  = (Criqtril == Criqfront) ;
    assign CriqPreOut = CRIQREG[Criqtril]       ; 

endmodule
