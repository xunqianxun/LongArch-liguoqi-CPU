`timescale 1ps/1ps
`include "define.v"

module ArchState #(
    //parameter PHYREGDEEP = 128 , 
    parameter PHYRPTRW   = 7  
) (
    input       wire                                Clk           ,
    input       wire                                Rest          ,

    input       wire                                RetireReg1Able, //此处输入的数据需要为顺序，即r1就是此周期提交的几条指令中的第一条指令的寄存器映射
    input       wire         [`ArchRegBUs]          RetireAR1Addr ,
    input       wire         [PHYRPTRW-1:0]         RetirePR1Addr ,
    input       wire                                RetireReg2Able,
    input       wire         [`ArchRegBUs]          RetireAR2Addr ,
    input       wire         [PHYRPTRW-1:0]         RetirePR2Addr ,
    input       wire                                RetireReg3Able,
    input       wire         [`ArchRegBUs]          RetireAR3Addr ,
    input       wire         [PHYRPTRW-1:0]         RetirePR3Addr ,
    input       wire                                RetireReg4Able,
    input       wire         [`ArchRegBUs]          RetireAR4Addr ,
    input       wire         [PHYRPTRW-1:0]         RetirePR4Addr ,
    input       wire                                ReMapping     ,

    output      wire         [PHYRPTRW-1:0]         ReMappingAS1  , 
    output      wire         [PHYRPTRW-1:0]         ReMappingAS2  , 
    output      wire         [PHYRPTRW-1:0]         ReMappingAS3  ,               
    output      wire         [PHYRPTRW-1:0]         ReMappingAS4  , 
    output      wire         [PHYRPTRW-1:0]         ReMappingAS5  , 
    output      wire         [PHYRPTRW-1:0]         ReMappingAS6  , 
    output      wire         [PHYRPTRW-1:0]         ReMappingAS7  , 
    output      wire         [PHYRPTRW-1:0]         ReMappingAS8  , 
    output      wire         [PHYRPTRW-1:0]         ReMappingAS9  , 
    output      wire         [PHYRPTRW-1:0]         ReMappingAS10 , 
    output      wire         [PHYRPTRW-1:0]         ReMappingAS11 , 
    output      wire         [PHYRPTRW-1:0]         ReMappingAS12 , 
    output      wire         [PHYRPTRW-1:0]         ReMappingAS13 , 
    output      wire         [PHYRPTRW-1:0]         ReMappingAS14 , 
    output      wire         [PHYRPTRW-1:0]         ReMappingAS15 , 
    output      wire         [PHYRPTRW-1:0]         ReMappingAS16 , 
    output      wire         [PHYRPTRW-1:0]         ReMappingAS17 , 
    output      wire         [PHYRPTRW-1:0]         ReMappingAS18 , 
    output      wire         [PHYRPTRW-1:0]         ReMappingAS19 , 
    output      wire         [PHYRPTRW-1:0]         ReMappingAS20 , 
    output      wire         [PHYRPTRW-1:0]         ReMappingAS21 , 
    output      wire         [PHYRPTRW-1:0]         ReMappingAS22 , 
    output      wire         [PHYRPTRW-1:0]         ReMappingAS23 , 
    output      wire         [PHYRPTRW-1:0]         ReMappingAS24 , 
    output      wire         [PHYRPTRW-1:0]         ReMappingAS25 , 
    output      wire         [PHYRPTRW-1:0]         ReMappingAS26 , 
    output      wire         [PHYRPTRW-1:0]         ReMappingAS27 , 
    output      wire         [PHYRPTRW-1:0]         ReMappingAS28 , 
    output      wire         [PHYRPTRW-1:0]         ReMappingAS29 , 
    output      wire         [PHYRPTRW-1:0]         ReMappingAS30 , 
    output      wire         [PHYRPTRW-1:0]         ReMappingAS31 , 
    output      wire         [PHYRPTRW-1:0]         ReMappingAS32  
);

    reg [PHYRPTRW-1:0] ArchStateReg [0:31] ;
    integer j ;
    always @(posedge Clk) begin
        if(!Rest)
            for (j = 0;j < 32 ;j = j+1) begin
                ArchStateReg[j] <= {PHYRPTRW{1'b0}} ;
            end
        else begin
            ArchStateReg[RetireAR1Addr] <= RetireReg1Able ? RetirePR1Addr : ArchStateReg[RetireAR1Addr] ;
            ArchStateReg[RetireAR2Addr] <= RetireReg2Able ? RetirePR2Addr : ArchStateReg[RetireAR2Addr] ;
            ArchStateReg[RetireAR3Addr] <= RetireReg3Able ? RetirePR3Addr : ArchStateReg[RetireAR3Addr] ;
            ArchStateReg[RetireAR4Addr] <= RetireReg4Able ? RetirePR4Addr : ArchStateReg[RetireAR4Addr] ;
        end
    end

    assign ReMappingAS1 = ReMapping ? ArchStateReg[0] : {PHYRPTRW{1'b0}} ;
    assign ReMappingAS2 = ReMapping ? ArchStateReg[1] : {PHYRPTRW{1'b0}} ;
    assign ReMappingAS3 = ReMapping ? ArchStateReg[2] : {PHYRPTRW{1'b0}} ;
    assign ReMappingAS4 = ReMapping ? ArchStateReg[3] : {PHYRPTRW{1'b0}} ;
    assign ReMappingAS5 = ReMapping ? ArchStateReg[4] : {PHYRPTRW{1'b0}} ;
    assign ReMappingAS6 = ReMapping ? ArchStateReg[5] : {PHYRPTRW{1'b0}} ;
    assign ReMappingAS7 = ReMapping ? ArchStateReg[6] : {PHYRPTRW{1'b0}} ;
    assign ReMappingAS8 = ReMapping ? ArchStateReg[7] : {PHYRPTRW{1'b0}} ;
    assign ReMappingAS9 = ReMapping ? ArchStateReg[8] : {PHYRPTRW{1'b0}} ;
    assign ReMappingAS10= ReMapping ? ArchStateReg[9] : {PHYRPTRW{1'b0}} ;
    assign ReMappingAS11= ReMapping ? ArchStateReg[10] : {PHYRPTRW{1'b0}} ;
    assign ReMappingAS12= ReMapping ? ArchStateReg[11] : {PHYRPTRW{1'b0}} ;
    assign ReMappingAS13= ReMapping ? ArchStateReg[12] : {PHYRPTRW{1'b0}} ;
    assign ReMappingAS14= ReMapping ? ArchStateReg[13] : {PHYRPTRW{1'b0}} ;
    assign ReMappingAS15= ReMapping ? ArchStateReg[14] : {PHYRPTRW{1'b0}} ;
    assign ReMappingAS16= ReMapping ? ArchStateReg[15] : {PHYRPTRW{1'b0}} ;
    assign ReMappingAS17= ReMapping ? ArchStateReg[16] : {PHYRPTRW{1'b0}} ;
    assign ReMappingAS18= ReMapping ? ArchStateReg[17] : {PHYRPTRW{1'b0}} ;
    assign ReMappingAS19= ReMapping ? ArchStateReg[18] : {PHYRPTRW{1'b0}} ;
    assign ReMappingAS20= ReMapping ? ArchStateReg[19] : {PHYRPTRW{1'b0}} ;
    assign ReMappingAS21= ReMapping ? ArchStateReg[20] : {PHYRPTRW{1'b0}} ;
    assign ReMappingAS22= ReMapping ? ArchStateReg[21] : {PHYRPTRW{1'b0}} ;
    assign ReMappingAS23= ReMapping ? ArchStateReg[22] : {PHYRPTRW{1'b0}} ;
    assign ReMappingAS24= ReMapping ? ArchStateReg[23] : {PHYRPTRW{1'b0}} ;
    assign ReMappingAS25= ReMapping ? ArchStateReg[24] : {PHYRPTRW{1'b0}} ;
    assign ReMappingAS26= ReMapping ? ArchStateReg[25] : {PHYRPTRW{1'b0}} ;
    assign ReMappingAS27= ReMapping ? ArchStateReg[26] : {PHYRPTRW{1'b0}} ;
    assign ReMappingAS28= ReMapping ? ArchStateReg[27] : {PHYRPTRW{1'b0}} ;
    assign ReMappingAS29= ReMapping ? ArchStateReg[28] : {PHYRPTRW{1'b0}} ;
    assign ReMappingAS30= ReMapping ? ArchStateReg[29] : {PHYRPTRW{1'b0}} ;
    assign ReMappingAS31= ReMapping ? ArchStateReg[30] : {PHYRPTRW{1'b0}} ;
    assign ReMappingAS32= ReMapping ? ArchStateReg[31] : {PHYRPTRW{1'b0}} ;
endmodule
