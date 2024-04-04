`timescale 1ps/1ps
`include "../define.v"

module PhysicalRegFile (
    input          wire                                 Clk                 ,
    input          wire                                 Rest                ,
    //for ctrl
    input          wire                                 PhysicalStop        ,
    //input          wire                                 PhysicalFlash       ,
    //output         wire                                 PhysicalReq         ,
    //from aRAT 
    input          wire                                 ReloadPhy           , //此信号等于flash,已经使用不改啦
    input          wire      [`ReNameRegBUs]            Are1MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are2MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are3MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are4MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are5MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are6MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are7MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are8MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are9MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are10MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are11MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are12MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are13MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are14MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are15MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are16MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are17MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are18MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are19MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are20MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are21MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are22MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are23MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are24MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are25MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are26MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are27MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are28MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are29MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are30MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are31MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are32MapPregNum      ,
    //from Alu1 
    input          wire                                 WriteBackAlu1        ,
    input          wire      [`ReNameRegBUs]            WriteBackAlu1Addr    ,
    input          wire      [`DataBus]                 WriteBackAlu1Date    ,
    //from Alu2 
    input          wire                                 WriteBackAlu2        ,
    input          wire      [`ReNameRegBUs]            WriteBackAlu2Addr    ,
    input          wire      [`DataBus]                 WriteBackAlu2Date    ,
    //from div 
    input          wire                                 WriteBackDiv         ,
    input          wire      [`ReNameRegBUs]            WriteBackDivAddr     ,
    input          wire      [`DataBus]                 WriteBackDivDate     ,
    //from Mul 
    input          wire                                 WriteBackMul         ,
    input          wire      [`ReNameRegBUs]            WriteBackMulAddr     ,
    input          wire      [`DataBus]                 WriteBackMulDate     ,
    //from Csru 
    input          wire                                 WriteBackCsru        ,
    input          wire      [`ReNameRegBUs]            WriteBackCsruAddr    ,
    input          wire      [`DataBus]                 WriteBackCsruDate    ,
    //from Bru 
    input          wire                                 WriteBackBru         ,
    input          wire      [`ReNameRegBUs]            WriteBackBruAddr     ,
    input          wire      [`DataBus]                 WriteBackBruDate     ,
    //from lsu 
    input          wire                                 WriteBackLsu         ,
    input          wire      [`ReNameRegBUs]            WriteBackLsuAddr     ,
    input          wire      [`DataBus]                 WriteBackLsuDate     ,
    //from ROB
    input          wire                                 WriteBackROB         ,
    input          wire      [`ReNameRegBUs]            WriteBackROBAddr     ,
    input          wire      [`DataBus]                 WriteBackROBDate     ,
    //for RAT
    input          wire                                 Read11Able           ,
    input          wire      [`ReNameRegBUs]            Read11Addr           ,
    output         wire      [`DataBus]                 Read11Date           ,
    input          wire                                 Read12Able           ,
    input          wire      [`ReNameRegBUs]            Read12Addr           ,
    output         wire      [`DataBus]                 Read12Date           ,
    input          wire                                 Read21Able           ,
    input          wire      [`ReNameRegBUs]            Read21Addr           ,
    output         wire      [`DataBus]                 Read21Date           ,
    input          wire                                 Read22Able           ,
    input          wire      [`ReNameRegBUs]            Read22Addr           ,
    output         wire      [`DataBus]                 Read22Date           ,
    input          wire                                 Read31Able           ,
    input          wire      [`ReNameRegBUs]            Read31Addr           ,
    output         wire      [`DataBus]                 Read31Date           ,
    input          wire                                 Read32Able           ,
    input          wire      [`ReNameRegBUs]            Read32Addr           ,
    output         wire      [`DataBus]                 Read32Date           ,
    input          wire                                 Read41Able           ,
    input          wire      [`ReNameRegBUs]            Read41Addr           ,
    output         wire      [`DataBus]                 Read41Date           ,
    input          wire                                 Read42Able           ,
    input          wire      [`ReNameRegBUs]            Read42Addr           ,
    output         wire      [`DataBus]                 Read42Date           
);

    reg  [`DataBus] PhysicalReg [0:127]  ;
    //integer i ;
    always @(posedge Clk) begin
        if(!Rest) begin
            //for (i =0 ;i< 128 ;i=i+1 )
                // PhysicalReg[i] <= `ZeorDate ;
            PhysicalReg[0] <= `ZeorDate ;
            PhysicalReg[1] <= `ZeorDate ;
            PhysicalReg[2] <= `ZeorDate ;
            PhysicalReg[3] <= `ZeorDate ;
            PhysicalReg[4] <= `ZeorDate ;
            PhysicalReg[5] <= `ZeorDate ;
            PhysicalReg[6] <= `ZeorDate ;
            PhysicalReg[7] <= `ZeorDate ;
            PhysicalReg[8] <= `ZeorDate ;
            PhysicalReg[9] <= `ZeorDate ;
            PhysicalReg[10] <= `ZeorDate ;
            PhysicalReg[11] <= `ZeorDate ;
            PhysicalReg[12] <= `ZeorDate ;
            PhysicalReg[13] <= `ZeorDate ;
            PhysicalReg[14] <= `ZeorDate ;
            PhysicalReg[15] <= `ZeorDate ;
            PhysicalReg[16] <= `ZeorDate ;
            PhysicalReg[17] <= `ZeorDate ;
            PhysicalReg[18] <= `ZeorDate ;
            PhysicalReg[19] <= `ZeorDate ;
            PhysicalReg[20] <= `ZeorDate ;
            PhysicalReg[21] <= `ZeorDate ;
            PhysicalReg[22] <= `ZeorDate ;
            PhysicalReg[23] <= `ZeorDate ;
            PhysicalReg[24] <= `ZeorDate ;
            PhysicalReg[25] <= `ZeorDate ;
            PhysicalReg[26] <= `ZeorDate ;
            PhysicalReg[27] <= `ZeorDate ;
            PhysicalReg[28] <= `ZeorDate ;
            PhysicalReg[29] <= `ZeorDate ;
            PhysicalReg[30] <= `ZeorDate ;
            PhysicalReg[31] <= `ZeorDate ;
            PhysicalReg[32] <= `ZeorDate ;
            PhysicalReg[33] <= `ZeorDate ;
            PhysicalReg[34] <= `ZeorDate ;
            PhysicalReg[35] <= `ZeorDate ;
            PhysicalReg[36] <= `ZeorDate ;
            PhysicalReg[37] <= `ZeorDate ;
            PhysicalReg[38] <= `ZeorDate ;
            PhysicalReg[38] <= `ZeorDate ;
            PhysicalReg[40] <= `ZeorDate ;
            PhysicalReg[41] <= `ZeorDate ;
            PhysicalReg[42] <= `ZeorDate ;
            PhysicalReg[43] <= `ZeorDate ;
            PhysicalReg[44] <= `ZeorDate ;
            PhysicalReg[45] <= `ZeorDate ;
            PhysicalReg[46] <= `ZeorDate ;
            PhysicalReg[47] <= `ZeorDate ;
            PhysicalReg[48] <= `ZeorDate ;
            PhysicalReg[49] <= `ZeorDate ;
            PhysicalReg[50] <= `ZeorDate ;
            PhysicalReg[51] <= `ZeorDate ;
            PhysicalReg[52] <= `ZeorDate ;
            PhysicalReg[53] <= `ZeorDate ;
            PhysicalReg[54] <= `ZeorDate ;
            PhysicalReg[55] <= `ZeorDate ;
            PhysicalReg[56] <= `ZeorDate ;
            PhysicalReg[57] <= `ZeorDate ;
            PhysicalReg[58] <= `ZeorDate ;
            PhysicalReg[59] <= `ZeorDate ;
            PhysicalReg[60] <= `ZeorDate ;
            PhysicalReg[61] <= `ZeorDate ;
            PhysicalReg[62] <= `ZeorDate ;
            PhysicalReg[63] <= `ZeorDate ;
            PhysicalReg[64] <= `ZeorDate ;
            PhysicalReg[65] <= `ZeorDate ;
            PhysicalReg[66] <= `ZeorDate ;
            PhysicalReg[67] <= `ZeorDate ;
            PhysicalReg[68] <= `ZeorDate ;
            PhysicalReg[69] <= `ZeorDate ;
            PhysicalReg[70] <= `ZeorDate ;
            PhysicalReg[71] <= `ZeorDate ;
            PhysicalReg[72] <= `ZeorDate ;
            PhysicalReg[73] <= `ZeorDate ;
            PhysicalReg[74] <= `ZeorDate ;
            PhysicalReg[75] <= `ZeorDate ;
            PhysicalReg[76] <= `ZeorDate ;
            PhysicalReg[77] <= `ZeorDate ;
            PhysicalReg[78] <= `ZeorDate ;
            PhysicalReg[79] <= `ZeorDate ;
            PhysicalReg[80] <= `ZeorDate ;
            PhysicalReg[81] <= `ZeorDate ;
            PhysicalReg[82] <= `ZeorDate ;
            PhysicalReg[83] <= `ZeorDate ;
            PhysicalReg[84] <= `ZeorDate ;
            PhysicalReg[85] <= `ZeorDate ;
            PhysicalReg[86] <= `ZeorDate ;
            PhysicalReg[87] <= `ZeorDate ;
            PhysicalReg[88] <= `ZeorDate ;
            PhysicalReg[89] <= `ZeorDate ;
            PhysicalReg[90] <= `ZeorDate ;
            PhysicalReg[91] <= `ZeorDate ;
            PhysicalReg[92] <= `ZeorDate ;
            PhysicalReg[93] <= `ZeorDate ;
            PhysicalReg[94] <= `ZeorDate ;
            PhysicalReg[95] <= `ZeorDate ;
            PhysicalReg[96] <= `ZeorDate ;
            PhysicalReg[97] <= `ZeorDate ;
            PhysicalReg[98] <= `ZeorDate ;
            PhysicalReg[99] <= `ZeorDate ;
            PhysicalReg[100] <= `ZeorDate ;
            PhysicalReg[102] <= `ZeorDate ;
            PhysicalReg[102] <= `ZeorDate ;
            PhysicalReg[103] <= `ZeorDate ;
            PhysicalReg[104] <= `ZeorDate ;
            PhysicalReg[105] <= `ZeorDate ;
            PhysicalReg[106] <= `ZeorDate ;
            PhysicalReg[107] <= `ZeorDate ;
            PhysicalReg[108] <= `ZeorDate ;
            PhysicalReg[109] <= `ZeorDate ;
            PhysicalReg[110] <= `ZeorDate ;
            PhysicalReg[111] <= `ZeorDate ;
            PhysicalReg[112] <= `ZeorDate ;
            PhysicalReg[113] <= `ZeorDate ;
            PhysicalReg[114] <= `ZeorDate ;
            PhysicalReg[115] <= `ZeorDate ;
            PhysicalReg[116] <= `ZeorDate ;
            PhysicalReg[117] <= `ZeorDate ;
            PhysicalReg[118] <= `ZeorDate ;
            PhysicalReg[119] <= `ZeorDate ;
            PhysicalReg[120] <= `ZeorDate ;
            PhysicalReg[121] <= `ZeorDate ;
            PhysicalReg[122] <= `ZeorDate ;
            PhysicalReg[123] <= `ZeorDate ;
            PhysicalReg[124] <= `ZeorDate ;
            PhysicalReg[125] <= `ZeorDate ;
            PhysicalReg[126] <= `ZeorDate ;
            PhysicalReg[127] <= `ZeorDate ;
        end
        else begin
            PhysicalReg[0] <= (ReloadPhy & ~PhysicalStop) ? PhysicalReg[Are1MapPregNum] : PhysicalReg[0] ;
            PhysicalReg[1] <= (ReloadPhy & ~PhysicalStop) ? PhysicalReg[Are2MapPregNum] : PhysicalReg[1] ;
            PhysicalReg[2] <= (ReloadPhy & ~PhysicalStop) ? PhysicalReg[Are3MapPregNum] : PhysicalReg[2] ;
            PhysicalReg[3] <= (ReloadPhy & ~PhysicalStop) ? PhysicalReg[Are4MapPregNum] : PhysicalReg[3] ;
            PhysicalReg[4] <= (ReloadPhy & ~PhysicalStop) ? PhysicalReg[Are5MapPregNum] : PhysicalReg[4] ;
            PhysicalReg[5] <= (ReloadPhy & ~PhysicalStop) ? PhysicalReg[Are6MapPregNum] : PhysicalReg[5] ;
            PhysicalReg[6] <= (ReloadPhy & ~PhysicalStop) ? PhysicalReg[Are7MapPregNum] : PhysicalReg[6] ;
            PhysicalReg[7] <= (ReloadPhy & ~PhysicalStop) ? PhysicalReg[Are8MapPregNum] : PhysicalReg[7] ;
            PhysicalReg[8] <= (ReloadPhy & ~PhysicalStop) ? PhysicalReg[Are9MapPregNum] : PhysicalReg[8] ;
            PhysicalReg[9] <= (ReloadPhy & ~PhysicalStop) ? PhysicalReg[Are10MapPregNum] : PhysicalReg[9] ;
            PhysicalReg[10] <= (ReloadPhy & ~PhysicalStop) ? PhysicalReg[Are11MapPregNum] : PhysicalReg[10] ;
            PhysicalReg[11] <= (ReloadPhy & ~PhysicalStop) ? PhysicalReg[Are12MapPregNum] : PhysicalReg[11] ;
            PhysicalReg[12] <= (ReloadPhy & ~PhysicalStop) ? PhysicalReg[Are13MapPregNum] : PhysicalReg[12] ;
            PhysicalReg[13] <= (ReloadPhy & ~PhysicalStop) ? PhysicalReg[Are14MapPregNum] : PhysicalReg[13] ;
            PhysicalReg[14] <= (ReloadPhy & ~PhysicalStop) ? PhysicalReg[Are15MapPregNum] : PhysicalReg[14] ;
            PhysicalReg[15] <= (ReloadPhy & ~PhysicalStop) ? PhysicalReg[Are16MapPregNum] : PhysicalReg[15] ;
            PhysicalReg[16] <= (ReloadPhy & ~PhysicalStop) ? PhysicalReg[Are17MapPregNum] : PhysicalReg[16] ;
            PhysicalReg[17] <= (ReloadPhy & ~PhysicalStop) ? PhysicalReg[Are18MapPregNum] : PhysicalReg[17] ;
            PhysicalReg[18] <= (ReloadPhy & ~PhysicalStop) ? PhysicalReg[Are19MapPregNum] : PhysicalReg[18] ;
            PhysicalReg[19] <= (ReloadPhy & ~PhysicalStop) ? PhysicalReg[Are20MapPregNum] : PhysicalReg[19] ;
            PhysicalReg[20] <= (ReloadPhy & ~PhysicalStop) ? PhysicalReg[Are21MapPregNum] : PhysicalReg[20] ;
            PhysicalReg[21] <= (ReloadPhy & ~PhysicalStop) ? PhysicalReg[Are22MapPregNum] : PhysicalReg[21] ;
            PhysicalReg[22] <= (ReloadPhy & ~PhysicalStop) ? PhysicalReg[Are23MapPregNum] : PhysicalReg[22] ;
            PhysicalReg[23] <= (ReloadPhy & ~PhysicalStop) ? PhysicalReg[Are24MapPregNum] : PhysicalReg[23] ;
            PhysicalReg[24] <= (ReloadPhy & ~PhysicalStop) ? PhysicalReg[Are25MapPregNum] : PhysicalReg[24] ;
            PhysicalReg[25] <= (ReloadPhy & ~PhysicalStop) ? PhysicalReg[Are26MapPregNum] : PhysicalReg[25] ;
            PhysicalReg[26] <= (ReloadPhy & ~PhysicalStop) ? PhysicalReg[Are27MapPregNum] : PhysicalReg[26] ;
            PhysicalReg[27] <= (ReloadPhy & ~PhysicalStop) ? PhysicalReg[Are28MapPregNum] : PhysicalReg[27] ;
            PhysicalReg[28] <= (ReloadPhy & ~PhysicalStop) ? PhysicalReg[Are29MapPregNum] : PhysicalReg[28] ;
            PhysicalReg[29] <= (ReloadPhy & ~PhysicalStop) ? PhysicalReg[Are30MapPregNum] : PhysicalReg[29] ;
            PhysicalReg[30] <= (ReloadPhy & ~PhysicalStop) ? PhysicalReg[Are31MapPregNum] : PhysicalReg[30] ;
            PhysicalReg[31] <= (ReloadPhy & ~PhysicalStop) ? PhysicalReg[Are32MapPregNum] : PhysicalReg[31] ;
            PhysicalReg[WriteBackAlu1Addr] <= (WriteBackAlu1 & ~PhysicalStop) ? WriteBackAlu1Date : PhysicalReg[WriteBackAlu1Addr] ;
            PhysicalReg[WriteBackAlu2Addr] <= (WriteBackAlu2 & ~PhysicalStop) ? WriteBackAlu2Date : PhysicalReg[WriteBackAlu2Addr] ;
            PhysicalReg[WriteBackDivAddr ] <= (WriteBackDiv  & ~PhysicalStop) ? WriteBackDivDate  : PhysicalReg[WriteBackDivAddr ] ;
            PhysicalReg[WriteBackMulAddr ] <= (WriteBackMul  & ~PhysicalStop) ? WriteBackMulDate  : PhysicalReg[WriteBackMulAddr ] ;
            PhysicalReg[WriteBackCsruAddr] <= (WriteBackCsru & ~PhysicalStop) ? WriteBackCsruDate : PhysicalReg[WriteBackCsruAddr] ;
            PhysicalReg[WriteBackBruAddr ] <= (WriteBackBru  & ~PhysicalStop) ? WriteBackBruDate  : PhysicalReg[WriteBackBruAddr ] ;
            PhysicalReg[WriteBackLsuAddr ] <= (WriteBackLsu  & ~PhysicalStop) ? WriteBackLsuDate  : PhysicalReg[WriteBackLsuAddr ] ;
            PhysicalReg[WriteBackROBAddr ] <= (WriteBackROB  & ~PhysicalStop) ? WriteBackROBDate  : PhysicalReg[WriteBackROBAddr ] ;

        end
    end 

    assign Read11Date = Read11Able ? PhysicalReg[Read11Addr] : `ZeorDate ;
    assign Read12Date = Read12Able ? PhysicalReg[Read12Addr] : `ZeorDate ;
    assign Read21Date = Read21Able ? PhysicalReg[Read21Addr] : `ZeorDate ;
    assign Read22Date = Read22Able ? PhysicalReg[Read22Addr] : `ZeorDate ;
    assign Read31Date = Read31Able ? PhysicalReg[Read31Addr] : `ZeorDate ;
    assign Read32Date = Read32Able ? PhysicalReg[Read32Addr] : `ZeorDate ;
    assign Read41Date = Read41Able ? PhysicalReg[Read41Addr] : `ZeorDate ;
    assign Read42Date = Read42Able ? PhysicalReg[Read42Addr] : `ZeorDate ;
    
    
endmodule
