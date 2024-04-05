`timescale 1ps/1ps
`include "../define"

module CriqFreelist2 #(
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
            CRIQREG[0] <= 33 ;
            CRIQREG[1] <= 37 ;
            CRIQREG[2] <= 41 ;
            CRIQREG[3] <= 45 ;
            CRIQREG[4] <= 49 ;
            CRIQREG[5] <= 53 ;
            CRIQREG[6] <= 57 ;
            CRIQREG[7] <= 61 ;
            CRIQREG[8] <= 65 ;
            CRIQREG[9] <= 69 ;
            CRIQREG[10] <= 73 ;
            CRIQREG[11] <= 77 ;
            CRIQREG[12] <= 81 ;
            CRIQREG[13] <= 85 ;
            CRIQREG[14] <= 89 ;
            CRIQREG[15] <= 93 ;
            CRIQREG[16] <= 97 ;
            CRIQREG[17] <= 101 ;
            CRIQREG[18] <= 105 ;
            CRIQREG[19] <= 109 ;
            CRIQREG[20] <= 113 ;
            CRIQREG[21] <= 117 ;
            CRIQREG[22] <= 121 ;
            CRIQREG[23] <= 125 ;
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
                CRIQREG[0] <= 33 ;
                CRIQREG[1] <= 37 ;
                CRIQREG[2] <= 41 ;
                CRIQREG[3] <= 45 ;
                CRIQREG[4] <= 49 ;
                CRIQREG[5] <= 53 ;
                CRIQREG[6] <= 57 ;
                CRIQREG[7] <= 61 ;
                CRIQREG[8] <= 65 ;
                CRIQREG[9] <= 69 ;
                CRIQREG[10] <= 73 ;
                CRIQREG[11] <= 77 ;
                CRIQREG[12] <= 81 ;
                CRIQREG[13] <= 85 ;
                CRIQREG[14] <= 89 ;
                CRIQREG[15] <= 93 ;
                CRIQREG[16] <= 97 ;
                CRIQREG[17] <= 101 ;
                CRIQREG[18] <= 105 ;
                CRIQREG[19] <= 109 ;
                CRIQREG[20] <= 113 ;
                CRIQREG[21] <= 117 ;
                CRIQREG[22] <= 121 ;
                CRIQREG[23] <= 125 ;
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
