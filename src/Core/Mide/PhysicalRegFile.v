`timescale 1ps/1ps
`include "../define.v"

module PhysicalRegFile (
    input          wire                                 Clk                 ,
    input          wire                                 Rest                ,
    //for ctrl
    input          wire                                 PhysicalStop        ,
    input          wire                                 PhysicalFlash       ,
    //from aRAT 
    //input          wire                                 ReloadPhy           , //此信号等于flash,已经使用不改啦
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
    output         wire      [`DataBus]                 Read42Date           ,
    input          wire                                 Read51Able           ,
    input          wire      [`ReNameRegBUs]            Read51Addr           ,
    output         wire      [`DataBus]                 Read51Date           ,
    input          wire                                 Read52Able           ,
    input          wire      [`ReNameRegBUs]            Read52Addr           ,
    output         wire      [`DataBus]                 Read52Date           ,
    input          wire                                 Read61Able           ,
    input          wire      [`ReNameRegBUs]            Read61Addr           ,
    output         wire      [`DataBus]                 Read61Date           ,
    input          wire                                 Read62Able           ,
    input          wire      [`ReNameRegBUs]            Read62Addr           ,
    output         wire      [`DataBus]                 Read62Date           ,
    input          wire                                 Read71Able           ,
    input          wire      [`ReNameRegBUs]            Read71Addr           ,
    output         wire      [`DataBus]                 Read71Date           ,
    input          wire                                 Read72Able           ,
    input          wire      [`ReNameRegBUs]            Read72Addr           ,
    output         wire      [`DataBus]                 Read72Date           ,
    input          wire                                 Read81Able           ,
    input          wire      [`ReNameRegBUs]            Read81Addr           ,
    output         wire      [`DataBus]                 Read81Date           ,
    input          wire                                 Read82Able           ,
    input          wire      [`ReNameRegBUs]            Read82Addr           ,
    output         wire      [`DataBus]                 Read82Date           
);

    reg  [`DataBus] PhysicalReg [0:127]  ;
    integer i ;
    integer j ;
    integer k ;
    integer l ;
    always @(posedge Clk) begin
        if(!Rest) begin
            for (i =0 ;i< 32 ;i=i+1 )
                 PhysicalReg[i] <= `ZeorDate ;
            for (j =0 ;j< 32 ;j=j+1 )
                 PhysicalReg[j+32] <= `ZeorDate ;
            for (k =0 ;k< 32 ;k=k+1 )
                 PhysicalReg[k+64] <= `ZeorDate ;
            for (l =0 ;l< 32 ;l=l+1 )
                 PhysicalReg[l+96] <= `ZeorDate ;
        end
        else if(PhysicalStop) begin
            for (i =0 ;i< 32 ;i=i+1 )
                 PhysicalReg[i] <=  PhysicalReg[i] ;
            for (j =0 ;j< 32 ;j=j+1 )
                 PhysicalReg[j+32] <= PhysicalReg[j+32] ;
            for (k =0 ;k< 32 ;k=k+1 )
                 PhysicalReg[k+64] <= PhysicalReg[k+64] ;
            for (l =0 ;l< 32 ;l=l+1 )
                 PhysicalReg[l+96] <= PhysicalReg[l+96] ;
        end
        else begin
            PhysicalReg[0] <= (PhysicalFlash ) ? PhysicalReg[Are1MapPregNum] : PhysicalReg[0] ;
            PhysicalReg[1] <= (PhysicalFlash ) ? PhysicalReg[Are2MapPregNum] : PhysicalReg[1] ;
            PhysicalReg[2] <= (PhysicalFlash ) ? PhysicalReg[Are3MapPregNum] : PhysicalReg[2] ;
            PhysicalReg[3] <= (PhysicalFlash ) ? PhysicalReg[Are4MapPregNum] : PhysicalReg[3] ;
            PhysicalReg[4] <= (PhysicalFlash ) ? PhysicalReg[Are5MapPregNum] : PhysicalReg[4] ;
            PhysicalReg[5] <= (PhysicalFlash ) ? PhysicalReg[Are6MapPregNum] : PhysicalReg[5] ;
            PhysicalReg[6] <= (PhysicalFlash ) ? PhysicalReg[Are7MapPregNum] : PhysicalReg[6] ;
            PhysicalReg[7] <= (PhysicalFlash ) ? PhysicalReg[Are8MapPregNum] : PhysicalReg[7] ;
            PhysicalReg[8] <= (PhysicalFlash ) ? PhysicalReg[Are9MapPregNum] : PhysicalReg[8] ;
            PhysicalReg[9] <= (PhysicalFlash ) ? PhysicalReg[Are10MapPregNum] : PhysicalReg[9] ;
            PhysicalReg[10] <= (PhysicalFlash ) ? PhysicalReg[Are11MapPregNum] : PhysicalReg[10] ;
            PhysicalReg[11] <= (PhysicalFlash ) ? PhysicalReg[Are12MapPregNum] : PhysicalReg[11] ;
            PhysicalReg[12] <= (PhysicalFlash ) ? PhysicalReg[Are13MapPregNum] : PhysicalReg[12] ;
            PhysicalReg[13] <= (PhysicalFlash ) ? PhysicalReg[Are14MapPregNum] : PhysicalReg[13] ;
            PhysicalReg[14] <= (PhysicalFlash ) ? PhysicalReg[Are15MapPregNum] : PhysicalReg[14] ;
            PhysicalReg[15] <= (PhysicalFlash ) ? PhysicalReg[Are16MapPregNum] : PhysicalReg[15] ;
            PhysicalReg[16] <= (PhysicalFlash ) ? PhysicalReg[Are17MapPregNum] : PhysicalReg[16] ;
            PhysicalReg[17] <= (PhysicalFlash ) ? PhysicalReg[Are18MapPregNum] : PhysicalReg[17] ;
            PhysicalReg[18] <= (PhysicalFlash ) ? PhysicalReg[Are19MapPregNum] : PhysicalReg[18] ;
            PhysicalReg[19] <= (PhysicalFlash ) ? PhysicalReg[Are20MapPregNum] : PhysicalReg[19] ;
            PhysicalReg[20] <= (PhysicalFlash ) ? PhysicalReg[Are21MapPregNum] : PhysicalReg[20] ;
            PhysicalReg[21] <= (PhysicalFlash ) ? PhysicalReg[Are22MapPregNum] : PhysicalReg[21] ;
            PhysicalReg[22] <= (PhysicalFlash ) ? PhysicalReg[Are23MapPregNum] : PhysicalReg[22] ;
            PhysicalReg[23] <= (PhysicalFlash ) ? PhysicalReg[Are24MapPregNum] : PhysicalReg[23] ;
            PhysicalReg[24] <= (PhysicalFlash ) ? PhysicalReg[Are25MapPregNum] : PhysicalReg[24] ;
            PhysicalReg[25] <= (PhysicalFlash ) ? PhysicalReg[Are26MapPregNum] : PhysicalReg[25] ;
            PhysicalReg[26] <= (PhysicalFlash ) ? PhysicalReg[Are27MapPregNum] : PhysicalReg[26] ;
            PhysicalReg[27] <= (PhysicalFlash ) ? PhysicalReg[Are28MapPregNum] : PhysicalReg[27] ;
            PhysicalReg[28] <= (PhysicalFlash ) ? PhysicalReg[Are29MapPregNum] : PhysicalReg[28] ;
            PhysicalReg[29] <= (PhysicalFlash ) ? PhysicalReg[Are30MapPregNum] : PhysicalReg[29] ;
            PhysicalReg[30] <= (PhysicalFlash ) ? PhysicalReg[Are31MapPregNum] : PhysicalReg[30] ;
            PhysicalReg[31] <= (PhysicalFlash ) ? PhysicalReg[Are32MapPregNum] : PhysicalReg[31] ;
            PhysicalReg[WriteBackAlu1Addr] <= (WriteBackAlu1 ) ? WriteBackAlu1Date : PhysicalReg[WriteBackAlu1Addr] ;
            PhysicalReg[WriteBackAlu2Addr] <= (WriteBackAlu2 ) ? WriteBackAlu2Date : PhysicalReg[WriteBackAlu2Addr] ;
            PhysicalReg[WriteBackDivAddr ] <= (WriteBackDiv  ) ? WriteBackDivDate  : PhysicalReg[WriteBackDivAddr ] ;
            PhysicalReg[WriteBackMulAddr ] <= (WriteBackMul  ) ? WriteBackMulDate  : PhysicalReg[WriteBackMulAddr ] ;
            PhysicalReg[WriteBackCsruAddr] <= (WriteBackCsru ) ? WriteBackCsruDate : PhysicalReg[WriteBackCsruAddr] ;
            PhysicalReg[WriteBackBruAddr ] <= (WriteBackBru  ) ? WriteBackBruDate  : PhysicalReg[WriteBackBruAddr ] ;
            PhysicalReg[WriteBackLsuAddr ] <= (WriteBackLsu  ) ? WriteBackLsuDate  : PhysicalReg[WriteBackLsuAddr ] ;
            PhysicalReg[WriteBackROBAddr ] <= (WriteBackROB  ) ? WriteBackROBDate  : PhysicalReg[WriteBackROBAddr ] ;

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
    assign Read51Date = Read51Able ? PhysicalReg[Read51Addr] : `ZeorDate ;
    assign Read52Date = Read52Able ? PhysicalReg[Read52Addr] : `ZeorDate ;
    assign Read61Date = Read61Able ? PhysicalReg[Read61Addr] : `ZeorDate ;
    assign Read62Date = Read62Able ? PhysicalReg[Read62Addr] : `ZeorDate ;
    assign Read71Date = Read71Able ? PhysicalReg[Read71Addr] : `ZeorDate ;
    assign Read72Date = Read72Able ? PhysicalReg[Read72Addr] : `ZeorDate ;
    assign Read81Date = Read81Able ? PhysicalReg[Read81Addr] : `ZeorDate ;
    assign Read82Date = Read82Able ? PhysicalReg[Read82Addr] : `ZeorDate ;
    
endmodule
