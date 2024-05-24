`timescale 1ps/1ps
`include "../define.v"

module ArchState (
    input       wire                                Clk           ,
    input       wire                                Rest          ,

    input       wire                                ArchSStop     ,
    
    input       wire                                RetireReg1Able, //此处输入的数据需要为顺序，即r1就是此周期提交的几条指令中的第一条指令的寄存器映射
    input       wire         [`ArchRegBUs]          RetireAR1Addr ,
    input       wire         [`ReNameRegBUs]        RetirePR1Addr ,
    input       wire                                RetireReg2Able,
    input       wire         [`ArchRegBUs]          RetireAR2Addr ,
    input       wire         [`ReNameRegBUs]        RetirePR2Addr ,
    input       wire                                RetireReg3Able,
    input       wire         [`ArchRegBUs]          RetireAR3Addr ,
    input       wire         [`ReNameRegBUs]        RetirePR3Addr ,
    input       wire                                RetireReg4Able,
    input       wire         [`ArchRegBUs]          RetireAR4Addr ,
    input       wire         [`ReNameRegBUs]        RetirePR4Addr ,
    input       wire                                ReMapping     ,

    output      wire         [`ReNameRegBUs]        ReMappingAS1  , 
    output      wire         [`ReNameRegBUs]        ReMappingAS2  , 
    output      wire         [`ReNameRegBUs]        ReMappingAS3  ,               
    output      wire         [`ReNameRegBUs]        ReMappingAS4  , 
    output      wire         [`ReNameRegBUs]        ReMappingAS5  , 
    output      wire         [`ReNameRegBUs]        ReMappingAS6  , 
    output      wire         [`ReNameRegBUs]        ReMappingAS7  , 
    output      wire         [`ReNameRegBUs]        ReMappingAS8  , 
    output      wire         [`ReNameRegBUs]        ReMappingAS9  , 
    output      wire         [`ReNameRegBUs]        ReMappingAS10 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS11 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS12 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS13 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS14 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS15 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS16 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS17 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS18 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS19 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS20 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS21 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS22 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS23 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS24 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS25 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS26 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS27 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS28 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS29 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS30 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS31 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS32  
);

    reg [`ReNameRegBUs] ArchStateReg [0:31] ;
    integer j ;
    always @(posedge Clk) begin
        if(!Rest)
            for (j = 0;j < 32 ;j = j+1) begin
                ArchStateReg[j] <= j[6:0] ;
            end
        else if(ArchSStop) begin
            for (j = 0;j < 32 ;j = j+1) begin
                ArchStateReg[j] <= ArchStateReg[j] ;
            end
        end 
        else begin
            ArchStateReg[RetireAR1Addr] <= RetireReg1Able ? RetirePR1Addr : ArchStateReg[RetireAR1Addr] ;
            ArchStateReg[RetireAR2Addr] <= RetireReg2Able ? RetirePR2Addr : ArchStateReg[RetireAR2Addr] ;
            ArchStateReg[RetireAR3Addr] <= RetireReg3Able ? RetirePR3Addr : ArchStateReg[RetireAR3Addr] ;
            ArchStateReg[RetireAR4Addr] <= RetireReg4Able ? RetirePR4Addr : ArchStateReg[RetireAR4Addr] ;
        end
    end

    assign ReMappingAS1 = ReMapping ? ArchStateReg[0] : 7'd0 ;
    assign ReMappingAS2 = ReMapping ? ArchStateReg[1] : 7'd0 ;
    assign ReMappingAS3 = ReMapping ? ArchStateReg[2] : 7'd0 ;
    assign ReMappingAS4 = ReMapping ? ArchStateReg[3] : 7'd0 ;
    assign ReMappingAS5 = ReMapping ? ArchStateReg[4] : 7'd0 ;
    assign ReMappingAS6 = ReMapping ? ArchStateReg[5] : 7'd0 ;
    assign ReMappingAS7 = ReMapping ? ArchStateReg[6] : 7'd0 ;
    assign ReMappingAS8 = ReMapping ? ArchStateReg[7] : 7'd0 ;
    assign ReMappingAS9 = ReMapping ? ArchStateReg[8] : 7'd0 ;
    assign ReMappingAS10= ReMapping ? ArchStateReg[9] : 7'd0 ;
    assign ReMappingAS11= ReMapping ? ArchStateReg[10] : 7'd0 ;
    assign ReMappingAS12= ReMapping ? ArchStateReg[11] : 7'd0 ;
    assign ReMappingAS13= ReMapping ? ArchStateReg[12] : 7'd0 ;
    assign ReMappingAS14= ReMapping ? ArchStateReg[13] : 7'd0 ;
    assign ReMappingAS15= ReMapping ? ArchStateReg[14] : 7'd0 ;
    assign ReMappingAS16= ReMapping ? ArchStateReg[15] : 7'd0 ;
    assign ReMappingAS17= ReMapping ? ArchStateReg[16] : 7'd0 ;
    assign ReMappingAS18= ReMapping ? ArchStateReg[17] : 7'd0 ;
    assign ReMappingAS19= ReMapping ? ArchStateReg[18] : 7'd0 ;
    assign ReMappingAS20= ReMapping ? ArchStateReg[19] : 7'd0 ;
    assign ReMappingAS21= ReMapping ? ArchStateReg[20] : 7'd0 ;
    assign ReMappingAS22= ReMapping ? ArchStateReg[21] : 7'd0 ;
    assign ReMappingAS23= ReMapping ? ArchStateReg[22] : 7'd0 ;
    assign ReMappingAS24= ReMapping ? ArchStateReg[23] : 7'd0 ;
    assign ReMappingAS25= ReMapping ? ArchStateReg[24] : 7'd0 ;
    assign ReMappingAS26= ReMapping ? ArchStateReg[25] : 7'd0 ;
    assign ReMappingAS27= ReMapping ? ArchStateReg[26] : 7'd0 ;
    assign ReMappingAS28= ReMapping ? ArchStateReg[27] : 7'd0 ;
    assign ReMappingAS29= ReMapping ? ArchStateReg[28] : 7'd0 ;
    assign ReMappingAS30= ReMapping ? ArchStateReg[29] : 7'd0 ;
    assign ReMappingAS31= ReMapping ? ArchStateReg[30] : 7'd0 ;
    assign ReMappingAS32= ReMapping ? ArchStateReg[31] : 7'd0 ;
endmodule
