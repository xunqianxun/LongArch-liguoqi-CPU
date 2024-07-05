`timescale 1ps/1ps
`include "../define.v"

module ArchState (
    input       wire                                Clk           ,
    input       wire                                Rest          ,

    input       wire                                ArchSStop     ,
    input       wire                                ArchSFlash    ,

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
        else  if(ArchSFlash) begin
            for (j = 0;j < 32 ;j = j+1) begin
                ArchStateReg[j] <= j[6:0]  ;
            end
        end  
        else begin
            ArchStateReg[RetireAR1Addr] <= RetireReg1Able ? RetirePR1Addr : ArchStateReg[RetireAR1Addr] ;
            ArchStateReg[RetireAR2Addr] <= RetireReg2Able ? RetirePR2Addr : ArchStateReg[RetireAR2Addr] ;
            ArchStateReg[RetireAR3Addr] <= RetireReg3Able ? RetirePR3Addr : ArchStateReg[RetireAR3Addr] ;
            ArchStateReg[RetireAR4Addr] <= RetireReg4Able ? RetirePR4Addr : ArchStateReg[RetireAR4Addr] ;
        end
    end

    assign ReMappingAS1 =  ArchStateReg[0]  ;
    assign ReMappingAS2 =  ArchStateReg[1]  ;
    assign ReMappingAS3 =  ArchStateReg[2]  ;
    assign ReMappingAS4 =  ArchStateReg[3]  ;
    assign ReMappingAS5 =  ArchStateReg[4]  ;
    assign ReMappingAS6 =  ArchStateReg[5]  ;
    assign ReMappingAS7 =  ArchStateReg[6]  ;
    assign ReMappingAS8 =  ArchStateReg[7]  ;
    assign ReMappingAS9 =  ArchStateReg[8]  ;
    assign ReMappingAS10=  ArchStateReg[9]  ;
    assign ReMappingAS11=  ArchStateReg[10] ;
    assign ReMappingAS12=  ArchStateReg[11] ;
    assign ReMappingAS13=  ArchStateReg[12] ;
    assign ReMappingAS14=  ArchStateReg[13] ;
    assign ReMappingAS15=  ArchStateReg[14] ;
    assign ReMappingAS16=  ArchStateReg[15] ;
    assign ReMappingAS17=  ArchStateReg[16] ;
    assign ReMappingAS18=  ArchStateReg[17] ;
    assign ReMappingAS19=  ArchStateReg[18] ;
    assign ReMappingAS20=  ArchStateReg[19] ;
    assign ReMappingAS21=  ArchStateReg[20] ;
    assign ReMappingAS22=  ArchStateReg[21] ;
    assign ReMappingAS23=  ArchStateReg[22] ;
    assign ReMappingAS24=  ArchStateReg[23] ;
    assign ReMappingAS25=  ArchStateReg[24] ;
    assign ReMappingAS26=  ArchStateReg[25] ;
    assign ReMappingAS27=  ArchStateReg[26] ;
    assign ReMappingAS28=  ArchStateReg[27] ;
    assign ReMappingAS29=  ArchStateReg[28] ;
    assign ReMappingAS30=  ArchStateReg[29] ;
    assign ReMappingAS31=  ArchStateReg[30] ;
    assign ReMappingAS32=  ArchStateReg[31] ;
endmodule
