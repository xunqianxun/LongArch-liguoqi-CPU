`timescale 1ps/1ps
`include "../define.v"

module RenameArchTable (
    input           wire                                        Clk               ,
    input           wire                                        Rest              ,
    //for ctrl 
    input           wire                                        RatStop           ,
    input           wire                                        RatFlash          ,
    //output          wire                                        RatReq            ,
    //from Freelist
    input           wire                                        Way1RdRename      ,
    input           wire      [`ArchRegBUs]                     Way1RdAreg        ,    
    input           wire      [`ReNameRegBUs]                   Way1RdReNum       ,
    input           wire                                        Way2RdRename      ,
    input           wire      [`ArchRegBUs]                     Way2RdAreg        ,
    input           wire      [`ReNameRegBUs]                   Way2RdReNum       ,
    input           wire                                        Way3RdRename      ,
    input           wire      [`ArchRegBUs]                     Way3RdAreg        ,
    input           wire      [`ReNameRegBUs]                   Way3RdReNum       ,
    input           wire                                        Way4RdRename      ,
    input           wire      [`ArchRegBUs]                     Way4RdAreg        ,
    input           wire      [`ReNameRegBUs]                   Way4RdReNum       ,
    //from  Dispatch 
    input           wire                                        Way1Src1Rame      ,
    input           wire      [`ArchRegBUs]                     Way1Src1          ,
    input           wire                                        Way1Src2Rame      ,
    input           wire      [`ArchRegBUs]                     Way1Src2          ,
    input           wire                                        Way2Src1Rame      ,
    input           wire      [`ArchRegBUs]                     Way2Src1          ,
    input           wire                                        Way2Src2Rame      ,
    input           wire      [`ArchRegBUs]                     Way2Src2          ,
    input           wire                                        Way3Src1Rame      ,
    input           wire      [`ArchRegBUs]                     Way3Src1          ,
    input           wire                                        Way3Src2Rame      ,
    input           wire      [`ArchRegBUs]                     Way3Src2          ,
    input           wire                                        Way4Src1Rame      , 
    input           wire      [`ArchRegBUs]                     Way4Src1          ,
    input           wire                                        Way4Src2Rame      ,
    input           wire      [`ArchRegBUs]                     Way4Src2          ,
    //for Physical file
    output          wire                                        ReqRead11Able     ,
    output          wire      [`ReNameRegBUs]                   ReqRead11Addr     ,
    input           wire      [`DataBus]                        InRead11Date      ,
    output          wire                                        ReqRead12Able     ,
    output          wire      [`ReNameRegBUs]                   ReqRead12Addr     ,
    input           wire      [`DataBus]                        InRead12Date      ,
    output          wire                                        ReqRead21Able     ,
    output          wire      [`ReNameRegBUs]                   ReqRead21Addr     ,
    input           wire      [`DataBus]                        InRead21Date      ,
    output          wire                                        ReqRead22Able     ,
    output          wire      [`ReNameRegBUs]                   ReqRead22Addr     ,
    input           wire      [`DataBus]                        InRead22Date      ,
    output          wire                                        ReqRead31Able     ,
    output          wire      [`ReNameRegBUs]                   ReqRead31Addr     ,
    input           wire      [`DataBus]                        InRead31Date      ,
    output          wire                                        ReqRead32Able     ,
    output          wire      [`ReNameRegBUs]                   ReqRead32Addr     ,
    input           wire      [`DataBus]                        InRead32Date      ,
    output          wire                                        ReqRead41Able     ,
    output          wire      [`ReNameRegBUs]                   ReqRead41Addr     ,
    input           wire      [`DataBus]                        InRead41Date      ,
    output          wire                                        ReqRead42Able     ,
    output          wire      [`ReNameRegBUs]                   ReqRead42Addr     ,
    input           wire      [`DataBus]                        InRead42Date      ,                                        
    //to Dispatch  
    output          wire                                        Way1Src1Out       ,
    output          wire      [`ReNameRegBUs]                   Way1Src1Oaddr     ,
    output          wire      [32:0]                            Way1Src1ODate     ,
    output          wire                                        Way1Src2Out       ,
    output          wire      [`ReNameRegBUs]                   Way1Src2Oaddr     ,
    output          wire      [32:0]                            Way1Src2ODate     ,
    output          wire                                        Way2Src1Out       ,
    output          wire      [`ReNameRegBUs]                   Way2Src1Oaddr     ,
    output          wire      [32:0]                            Way2Src1ODate     ,
    output          wire                                        Way2Src2Out       ,
    output          wire      [`ReNameRegBUs]                   Way2Src2Oaddr     ,
    output          wire      [32:0]                            Way2Src2ODate     ,
    output          wire                                        Way3Src1Out       ,
    output          wire      [`ReNameRegBUs]                   Way3Src1Oaddr     ,
    output          wire      [32:0]                            Way3Src1ODate     ,
    output          wire                                        Way3Src2Out       ,
    output          wire      [`ReNameRegBUs]                   Way3Src2Oaddr     ,
    output          wire      [32:0]                            Way3Src2ODate     ,
    output          wire                                        Way4Src1Out       ,
    output          wire      [`ReNameRegBUs]                   Way4Src1Oaddr     ,
    output          wire      [32:0]                            Way4Src1ODate     ,
    output          wire                                        Way4Src2Out       ,
    output          wire      [`ReNameRegBUs]                   Way4Src2Oaddr     ,
    output          wire      [32:0]                            Way4Src2ODate     ,
    output          wire                                        Way1RdAble        ,
    output          wire      [`ReNameRegBUs]                   Way1RdAddr        ,
    output          wire                                        Way2RdAble        ,
    output          wire      [`ReNameRegBUs]                   Way2RdAddr        ,
    output          wire                                        Way3RdAble        ,
    output          wire      [`ReNameRegBUs]                   Way3RdAddr        ,
    output          wire                                        Way4RdAble        ,
    output          wire      [`ReNameRegBUs]                   Way4RdAddr        ,
    //from Alu1 
    input           wire                                        WriteBackAlu1R    ,
    input           wire      [`ReNameRegBUs]                   WriteBackAlu1AddrR,
    input           wire      [`DataBus]                        WriteBackAlu1DateR,
    //from Alu2 
    input           wire                                        WriteBackAlu2R    ,
    input           wire      [`ReNameRegBUs]                   WriteBackAlu2AddrR,
    input           wire      [`DataBus]                        WriteBackAlu2DateR,
    //from div 
    input           wire                                        WriteBackDivR     ,
    input           wire      [`ReNameRegBUs]                   WriteBackDivAddrR ,
    input           wire      [`DataBus]                        WriteBackDivDateR ,
    //from Mul 
    input           wire                                        WriteBackMulR     ,
    input           wire      [`ReNameRegBUs]                   WriteBackMulAddrR ,
    input           wire      [`DataBus]                        WriteBackMulDateR ,
    //from Csru 
    input           wire                                        WriteBackCsruR    ,
    input           wire      [`ReNameRegBUs]                   WriteBackCsruAddrR,
    input           wire      [`DataBus]                        WriteBackCsruDateR,
    //from Bru 
    input           wire                                        WriteBackBruR     ,
    input           wire      [`ReNameRegBUs]                   WriteBackBruAddrR ,
    input           wire      [`DataBus]                        WriteBackBruDateR ,
    //from lsu 
    input           wire                                        WriteBackLsuR     ,
    input           wire      [`ReNameRegBUs]                   WriteBackLsuAddrR ,
    input           wire      [`DataBus]                        WriteBackLsuDateR ,
    //from ROB 
    input           wire                                        WriteBackROBR     ,
    input           wire      [`ReNameRegBUs]                   WriteBackROBAddrR ,
    input           wire      [`DataBus]                        WriteBackROBDateR 
);

    reg [7:0] RATENTY [0:31] ; // rename[6:0]+valid[7]

    wire [5:0] ALu1Num   =  {6{(RATENTY[0][6:0] == WriteBackAlu1AddrR)}} & 6'd32 | //避免无命中为0和命中0冲突故而将MUM={1'b1,MUM[4:0]}
                            {6{(RATENTY[1][6:0] == WriteBackAlu1AddrR)}} & 6'd33 |
                            {6{(RATENTY[2][6:0] == WriteBackAlu1AddrR)}} & 6'd34 |
                            {6{(RATENTY[3][6:0] == WriteBackAlu1AddrR)}} & 6'd35 |
                            {6{(RATENTY[4][6:0] == WriteBackAlu1AddrR)}} & 6'd36 |
                            {6{(RATENTY[5][6:0] == WriteBackAlu1AddrR)}} & 6'd37 |
                            {6{(RATENTY[6][6:0] == WriteBackAlu1AddrR)}} & 6'd38 |
                            {6{(RATENTY[7][6:0] == WriteBackAlu1AddrR)}} & 6'd39 |
                            {6{(RATENTY[8][6:0] == WriteBackAlu1AddrR)}} & 6'd40 |
                            {6{(RATENTY[9][6:0] == WriteBackAlu1AddrR)}} & 6'd41 |
                            {6{(RATENTY[10][6:0] == WriteBackAlu1AddrR)}} & 6'd42 |
                            {6{(RATENTY[11][6:0] == WriteBackAlu1AddrR)}} & 6'd43 |
                            {6{(RATENTY[12][6:0] == WriteBackAlu1AddrR)}} & 6'd44 |
                            {6{(RATENTY[13][6:0] == WriteBackAlu1AddrR)}} & 6'd45 |
                            {6{(RATENTY[14][6:0] == WriteBackAlu1AddrR)}} & 6'd46 |
                            {6{(RATENTY[15][6:0] == WriteBackAlu1AddrR)}} & 6'd47 |
                            {6{(RATENTY[16][6:0] == WriteBackAlu1AddrR)}} & 6'd48 |
                            {6{(RATENTY[17][6:0] == WriteBackAlu1AddrR)}} & 6'd49 |
                            {6{(RATENTY[18][6:0] == WriteBackAlu1AddrR)}} & 6'd50 |
                            {6{(RATENTY[19][6:0] == WriteBackAlu1AddrR)}} & 6'd51 |
                            {6{(RATENTY[20][6:0] == WriteBackAlu1AddrR)}} & 6'd52 |
                            {6{(RATENTY[21][6:0] == WriteBackAlu1AddrR)}} & 6'd53 |
                            {6{(RATENTY[22][6:0] == WriteBackAlu1AddrR)}} & 6'd54 |
                            {6{(RATENTY[23][6:0] == WriteBackAlu1AddrR)}} & 6'd55 |
                            {6{(RATENTY[24][6:0] == WriteBackAlu1AddrR)}} & 6'd56 |
                            {6{(RATENTY[25][6:0] == WriteBackAlu1AddrR)}} & 6'd57 |
                            {6{(RATENTY[26][6:0] == WriteBackAlu1AddrR)}} & 6'd58 |
                            {6{(RATENTY[27][6:0] == WriteBackAlu1AddrR)}} & 6'd59 |
                            {6{(RATENTY[28][6:0] == WriteBackAlu1AddrR)}} & 6'd60 |
                            {6{(RATENTY[29][6:0] == WriteBackAlu1AddrR)}} & 6'd61 |
                            {6{(RATENTY[30][6:0] == WriteBackAlu1AddrR)}} & 6'd62 |
                            {6{(RATENTY[31][6:0] == WriteBackAlu1AddrR)}} & 6'd63 ;

    wire [5:0] ALu2Num   =  {6{(RATENTY[0][6:0] == WriteBackAlu2AddrR)}} & 6'd32 | //避免无命中为0和命中0冲突故而将MUM={1'b1,MUM[4:0]}
                            {6{(RATENTY[1][6:0] == WriteBackAlu2AddrR)}} & 6'd33 |
                            {6{(RATENTY[2][6:0] == WriteBackAlu2AddrR)}} & 6'd34 |
                            {6{(RATENTY[3][6:0] == WriteBackAlu2AddrR)}} & 6'd35 |
                            {6{(RATENTY[4][6:0] == WriteBackAlu2AddrR)}} & 6'd36 |
                            {6{(RATENTY[5][6:0] == WriteBackAlu2AddrR)}} & 6'd37 |
                            {6{(RATENTY[6][6:0] == WriteBackAlu2AddrR)}} & 6'd38 |
                            {6{(RATENTY[7][6:0] == WriteBackAlu2AddrR)}} & 6'd39 |
                            {6{(RATENTY[8][6:0] == WriteBackAlu2AddrR)}} & 6'd40 |
                            {6{(RATENTY[9][6:0] == WriteBackAlu2AddrR)}} & 6'd41 |
                            {6{(RATENTY[10][6:0] == WriteBackAlu2AddrR)}} & 6'd42 |
                            {6{(RATENTY[11][6:0] == WriteBackAlu2AddrR)}} & 6'd43 |
                            {6{(RATENTY[12][6:0] == WriteBackAlu2AddrR)}} & 6'd44 |
                            {6{(RATENTY[13][6:0] == WriteBackAlu2AddrR)}} & 6'd45 |
                            {6{(RATENTY[14][6:0] == WriteBackAlu2AddrR)}} & 6'd46 |
                            {6{(RATENTY[15][6:0] == WriteBackAlu2AddrR)}} & 6'd47 |
                            {6{(RATENTY[16][6:0] == WriteBackAlu2AddrR)}} & 6'd48 |
                            {6{(RATENTY[17][6:0] == WriteBackAlu2AddrR)}} & 6'd49 |
                            {6{(RATENTY[18][6:0] == WriteBackAlu2AddrR)}} & 6'd50 |
                            {6{(RATENTY[19][6:0] == WriteBackAlu2AddrR)}} & 6'd51 |
                            {6{(RATENTY[20][6:0] == WriteBackAlu2AddrR)}} & 6'd52 |
                            {6{(RATENTY[21][6:0] == WriteBackAlu2AddrR)}} & 6'd53 |
                            {6{(RATENTY[22][6:0] == WriteBackAlu2AddrR)}} & 6'd54 |
                            {6{(RATENTY[23][6:0] == WriteBackAlu2AddrR)}} & 6'd55 |
                            {6{(RATENTY[24][6:0] == WriteBackAlu2AddrR)}} & 6'd56 |
                            {6{(RATENTY[25][6:0] == WriteBackAlu2AddrR)}} & 6'd57 |
                            {6{(RATENTY[26][6:0] == WriteBackAlu2AddrR)}} & 6'd58 |
                            {6{(RATENTY[27][6:0] == WriteBackAlu2AddrR)}} & 6'd59 |
                            {6{(RATENTY[28][6:0] == WriteBackAlu2AddrR)}} & 6'd60 |
                            {6{(RATENTY[29][6:0] == WriteBackAlu2AddrR)}} & 6'd61 |
                            {6{(RATENTY[30][6:0] == WriteBackAlu2AddrR)}} & 6'd62 |
                            {6{(RATENTY[31][6:0] == WriteBackAlu2AddrR)}} & 6'd63 ;
                
    wire [5:0] DivNum    =  {6{(RATENTY[0][6:0] == WriteBackDivAddrR)}} & 6'd32 | //避免无命中为0和命中0冲突故而将MUM={1'b1,MUM[4:0]}
                            {6{(RATENTY[1][6:0] == WriteBackDivAddrR)}} & 6'd33 |
                            {6{(RATENTY[2][6:0] == WriteBackDivAddrR)}} & 6'd34 |
                            {6{(RATENTY[3][6:0] == WriteBackDivAddrR)}} & 6'd35 |
                            {6{(RATENTY[4][6:0] == WriteBackDivAddrR)}} & 6'd36 |
                            {6{(RATENTY[5][6:0] == WriteBackDivAddrR)}} & 6'd37 |
                            {6{(RATENTY[6][6:0] == WriteBackDivAddrR)}} & 6'd38 |
                            {6{(RATENTY[7][6:0] == WriteBackDivAddrR)}} & 6'd39 |
                            {6{(RATENTY[8][6:0] == WriteBackDivAddrR)}} & 6'd40 |
                            {6{(RATENTY[9][6:0] == WriteBackDivAddrR)}} & 6'd41 |
                            {6{(RATENTY[10][6:0] == WriteBackDivAddrR)}} & 6'd42 |
                            {6{(RATENTY[11][6:0] == WriteBackDivAddrR)}} & 6'd43 |
                            {6{(RATENTY[12][6:0] == WriteBackDivAddrR)}} & 6'd44 |
                            {6{(RATENTY[13][6:0] == WriteBackDivAddrR)}} & 6'd45 |
                            {6{(RATENTY[14][6:0] == WriteBackDivAddrR)}} & 6'd46 |
                            {6{(RATENTY[15][6:0] == WriteBackDivAddrR)}} & 6'd47 |
                            {6{(RATENTY[16][6:0] == WriteBackDivAddrR)}} & 6'd48 |
                            {6{(RATENTY[17][6:0] == WriteBackDivAddrR)}} & 6'd49 |
                            {6{(RATENTY[18][6:0] == WriteBackDivAddrR)}} & 6'd50 |
                            {6{(RATENTY[19][6:0] == WriteBackDivAddrR)}} & 6'd51 |
                            {6{(RATENTY[20][6:0] == WriteBackDivAddrR)}} & 6'd52 |
                            {6{(RATENTY[21][6:0] == WriteBackDivAddrR)}} & 6'd53 |
                            {6{(RATENTY[22][6:0] == WriteBackDivAddrR)}} & 6'd54 |
                            {6{(RATENTY[23][6:0] == WriteBackDivAddrR)}} & 6'd55 |
                            {6{(RATENTY[24][6:0] == WriteBackDivAddrR)}} & 6'd56 |
                            {6{(RATENTY[25][6:0] == WriteBackDivAddrR)}} & 6'd57 |
                            {6{(RATENTY[26][6:0] == WriteBackDivAddrR)}} & 6'd58 |
                            {6{(RATENTY[27][6:0] == WriteBackDivAddrR)}} & 6'd59 |
                            {6{(RATENTY[28][6:0] == WriteBackDivAddrR)}} & 6'd60 |
                            {6{(RATENTY[29][6:0] == WriteBackDivAddrR)}} & 6'd61 |
                            {6{(RATENTY[30][6:0] == WriteBackDivAddrR)}} & 6'd62 |
                            {6{(RATENTY[31][6:0] == WriteBackDivAddrR)}} & 6'd63 ;

    wire [5:0] MulNum    =  {6{(RATENTY[0][6:0] == WriteBackMulAddrR)}} & 6'd32 | //避免无命中为0和命中0冲突故而将MUM={1'b1,MUM[4:0]}
                            {6{(RATENTY[1][6:0] == WriteBackMulAddrR)}} & 6'd33 |
                            {6{(RATENTY[2][6:0] == WriteBackMulAddrR)}} & 6'd34 |
                            {6{(RATENTY[3][6:0] == WriteBackMulAddrR)}} & 6'd35 |
                            {6{(RATENTY[4][6:0] == WriteBackMulAddrR)}} & 6'd36 |
                            {6{(RATENTY[5][6:0] == WriteBackMulAddrR)}} & 6'd37 |
                            {6{(RATENTY[6][6:0] == WriteBackMulAddrR)}} & 6'd38 |
                            {6{(RATENTY[7][6:0] == WriteBackMulAddrR)}} & 6'd39 |
                            {6{(RATENTY[8][6:0] == WriteBackMulAddrR)}} & 6'd40 |
                            {6{(RATENTY[9][6:0] == WriteBackMulAddrR)}} & 6'd41 |
                            {6{(RATENTY[10][6:0] == WriteBackMulAddrR)}} & 6'd42 |
                            {6{(RATENTY[11][6:0] == WriteBackMulAddrR)}} & 6'd43 |
                            {6{(RATENTY[12][6:0] == WriteBackMulAddrR)}} & 6'd44 |
                            {6{(RATENTY[13][6:0] == WriteBackMulAddrR)}} & 6'd45 |
                            {6{(RATENTY[14][6:0] == WriteBackMulAddrR)}} & 6'd46 |
                            {6{(RATENTY[15][6:0] == WriteBackMulAddrR)}} & 6'd47 |
                            {6{(RATENTY[16][6:0] == WriteBackMulAddrR)}} & 6'd48 |
                            {6{(RATENTY[17][6:0] == WriteBackMulAddrR)}} & 6'd49 |
                            {6{(RATENTY[18][6:0] == WriteBackMulAddrR)}} & 6'd50 |
                            {6{(RATENTY[19][6:0] == WriteBackMulAddrR)}} & 6'd51 |
                            {6{(RATENTY[20][6:0] == WriteBackMulAddrR)}} & 6'd52 |
                            {6{(RATENTY[21][6:0] == WriteBackMulAddrR)}} & 6'd53 |
                            {6{(RATENTY[22][6:0] == WriteBackMulAddrR)}} & 6'd54 |
                            {6{(RATENTY[23][6:0] == WriteBackMulAddrR)}} & 6'd55 |
                            {6{(RATENTY[24][6:0] == WriteBackMulAddrR)}} & 6'd56 |
                            {6{(RATENTY[25][6:0] == WriteBackMulAddrR)}} & 6'd57 |
                            {6{(RATENTY[26][6:0] == WriteBackMulAddrR)}} & 6'd58 |
                            {6{(RATENTY[27][6:0] == WriteBackMulAddrR)}} & 6'd59 |
                            {6{(RATENTY[28][6:0] == WriteBackMulAddrR)}} & 6'd60 |
                            {6{(RATENTY[29][6:0] == WriteBackMulAddrR)}} & 6'd61 |
                            {6{(RATENTY[30][6:0] == WriteBackMulAddrR)}} & 6'd62 |
                            {6{(RATENTY[31][6:0] == WriteBackMulAddrR)}} & 6'd63 ;

    wire [5:0] CsruNum   =  {6{(RATENTY[0][6:0] == WriteBackCsruAddrR)}} & 6'd32 | //避免无命中为0和命中0冲突故而将MUM={1'b1,MUM[4:0]}
                            {6{(RATENTY[1][6:0] == WriteBackCsruAddrR)}} & 6'd33 |
                            {6{(RATENTY[2][6:0] == WriteBackCsruAddrR)}} & 6'd34 |
                            {6{(RATENTY[3][6:0] == WriteBackCsruAddrR)}} & 6'd35 |
                            {6{(RATENTY[4][6:0] == WriteBackCsruAddrR)}} & 6'd36 |
                            {6{(RATENTY[5][6:0] == WriteBackCsruAddrR)}} & 6'd37 |
                            {6{(RATENTY[6][6:0] == WriteBackCsruAddrR)}} & 6'd38 |
                            {6{(RATENTY[7][6:0] == WriteBackCsruAddrR)}} & 6'd39 |
                            {6{(RATENTY[8][6:0] == WriteBackCsruAddrR)}} & 6'd40 |
                            {6{(RATENTY[9][6:0] == WriteBackCsruAddrR)}} & 6'd41 |
                            {6{(RATENTY[10][6:0] == WriteBackCsruAddrR)}} & 6'd42 |
                            {6{(RATENTY[11][6:0] == WriteBackCsruAddrR)}} & 6'd43 |
                            {6{(RATENTY[12][6:0] == WriteBackCsruAddrR)}} & 6'd44 |
                            {6{(RATENTY[13][6:0] == WriteBackCsruAddrR)}} & 6'd45 |
                            {6{(RATENTY[14][6:0] == WriteBackCsruAddrR)}} & 6'd46 |
                            {6{(RATENTY[15][6:0] == WriteBackCsruAddrR)}} & 6'd47 |
                            {6{(RATENTY[16][6:0] == WriteBackCsruAddrR)}} & 6'd48 |
                            {6{(RATENTY[17][6:0] == WriteBackCsruAddrR)}} & 6'd49 |
                            {6{(RATENTY[18][6:0] == WriteBackCsruAddrR)}} & 6'd50 |
                            {6{(RATENTY[19][6:0] == WriteBackCsruAddrR)}} & 6'd51 |
                            {6{(RATENTY[20][6:0] == WriteBackCsruAddrR)}} & 6'd52 |
                            {6{(RATENTY[21][6:0] == WriteBackCsruAddrR)}} & 6'd53 |
                            {6{(RATENTY[22][6:0] == WriteBackCsruAddrR)}} & 6'd54 |
                            {6{(RATENTY[23][6:0] == WriteBackCsruAddrR)}} & 6'd55 |
                            {6{(RATENTY[24][6:0] == WriteBackCsruAddrR)}} & 6'd56 |
                            {6{(RATENTY[25][6:0] == WriteBackCsruAddrR)}} & 6'd57 |
                            {6{(RATENTY[26][6:0] == WriteBackCsruAddrR)}} & 6'd58 |
                            {6{(RATENTY[27][6:0] == WriteBackCsruAddrR)}} & 6'd59 |
                            {6{(RATENTY[28][6:0] == WriteBackCsruAddrR)}} & 6'd60 |
                            {6{(RATENTY[29][6:0] == WriteBackCsruAddrR)}} & 6'd61 |
                            {6{(RATENTY[30][6:0] == WriteBackCsruAddrR)}} & 6'd62 |
                            {6{(RATENTY[31][6:0] == WriteBackCsruAddrR)}} & 6'd63 ;

    wire [5:0] BruNum    =  {6{(RATENTY[0][6:0] == WriteBackBruAddrR)}} & 6'd32 | //避免无命中为0和命中0冲突故而将MUM={1'b1,MUM[4:0]}
                            {6{(RATENTY[1][6:0] == WriteBackBruAddrR)}} & 6'd33 |
                            {6{(RATENTY[2][6:0] == WriteBackBruAddrR)}} & 6'd34 |
                            {6{(RATENTY[3][6:0] == WriteBackBruAddrR)}} & 6'd35 |
                            {6{(RATENTY[4][6:0] == WriteBackBruAddrR)}} & 6'd36 |
                            {6{(RATENTY[5][6:0] == WriteBackBruAddrR)}} & 6'd37 |
                            {6{(RATENTY[6][6:0] == WriteBackBruAddrR)}} & 6'd38 |
                            {6{(RATENTY[7][6:0] == WriteBackBruAddrR)}} & 6'd39 |
                            {6{(RATENTY[8][6:0] == WriteBackBruAddrR)}} & 6'd40 |
                            {6{(RATENTY[9][6:0] == WriteBackBruAddrR)}} & 6'd41 |
                            {6{(RATENTY[10][6:0] == WriteBackBruAddrR)}} & 6'd42 |
                            {6{(RATENTY[11][6:0] == WriteBackBruAddrR)}} & 6'd43 |
                            {6{(RATENTY[12][6:0] == WriteBackBruAddrR)}} & 6'd44 |
                            {6{(RATENTY[13][6:0] == WriteBackBruAddrR)}} & 6'd45 |
                            {6{(RATENTY[14][6:0] == WriteBackBruAddrR)}} & 6'd46 |
                            {6{(RATENTY[15][6:0] == WriteBackBruAddrR)}} & 6'd47 |
                            {6{(RATENTY[16][6:0] == WriteBackBruAddrR)}} & 6'd48 |
                            {6{(RATENTY[17][6:0] == WriteBackBruAddrR)}} & 6'd49 |
                            {6{(RATENTY[18][6:0] == WriteBackBruAddrR)}} & 6'd50 |
                            {6{(RATENTY[19][6:0] == WriteBackBruAddrR)}} & 6'd51 |
                            {6{(RATENTY[20][6:0] == WriteBackBruAddrR)}} & 6'd52 |
                            {6{(RATENTY[21][6:0] == WriteBackBruAddrR)}} & 6'd53 |
                            {6{(RATENTY[22][6:0] == WriteBackBruAddrR)}} & 6'd54 |
                            {6{(RATENTY[23][6:0] == WriteBackBruAddrR)}} & 6'd55 |
                            {6{(RATENTY[24][6:0] == WriteBackBruAddrR)}} & 6'd56 |
                            {6{(RATENTY[25][6:0] == WriteBackBruAddrR)}} & 6'd57 |
                            {6{(RATENTY[26][6:0] == WriteBackBruAddrR)}} & 6'd58 |
                            {6{(RATENTY[27][6:0] == WriteBackBruAddrR)}} & 6'd59 |
                            {6{(RATENTY[28][6:0] == WriteBackBruAddrR)}} & 6'd60 |
                            {6{(RATENTY[29][6:0] == WriteBackBruAddrR)}} & 6'd61 |
                            {6{(RATENTY[30][6:0] == WriteBackBruAddrR)}} & 6'd62 |
                            {6{(RATENTY[31][6:0] == WriteBackBruAddrR)}} & 6'd63 ;

    wire [5:0] LsuNum    =  {6{(RATENTY[0][6:0] == WriteBackLsuAddrR)}} & 6'd32 | //避免无命中为0和命中0冲突故而将MUM={1'b1,MUM[4:0]}
                            {6{(RATENTY[1][6:0] == WriteBackLsuAddrR)}} & 6'd33 |
                            {6{(RATENTY[2][6:0] == WriteBackLsuAddrR)}} & 6'd34 |
                            {6{(RATENTY[3][6:0] == WriteBackLsuAddrR)}} & 6'd35 |
                            {6{(RATENTY[4][6:0] == WriteBackLsuAddrR)}} & 6'd36 |
                            {6{(RATENTY[5][6:0] == WriteBackLsuAddrR)}} & 6'd37 |
                            {6{(RATENTY[6][6:0] == WriteBackLsuAddrR)}} & 6'd38 |
                            {6{(RATENTY[7][6:0] == WriteBackLsuAddrR)}} & 6'd39 |
                            {6{(RATENTY[8][6:0] == WriteBackLsuAddrR)}} & 6'd40 |
                            {6{(RATENTY[9][6:0] == WriteBackLsuAddrR)}} & 6'd41 |
                            {6{(RATENTY[10][6:0] == WriteBackLsuAddrR)}} & 6'd42 |
                            {6{(RATENTY[11][6:0] == WriteBackLsuAddrR)}} & 6'd43 |
                            {6{(RATENTY[12][6:0] == WriteBackLsuAddrR)}} & 6'd44 |
                            {6{(RATENTY[13][6:0] == WriteBackLsuAddrR)}} & 6'd45 |
                            {6{(RATENTY[14][6:0] == WriteBackLsuAddrR)}} & 6'd46 |
                            {6{(RATENTY[15][6:0] == WriteBackLsuAddrR)}} & 6'd47 |
                            {6{(RATENTY[16][6:0] == WriteBackLsuAddrR)}} & 6'd48 |
                            {6{(RATENTY[17][6:0] == WriteBackLsuAddrR)}} & 6'd49 |
                            {6{(RATENTY[18][6:0] == WriteBackLsuAddrR)}} & 6'd50 |
                            {6{(RATENTY[19][6:0] == WriteBackLsuAddrR)}} & 6'd51 |
                            {6{(RATENTY[20][6:0] == WriteBackLsuAddrR)}} & 6'd52 |
                            {6{(RATENTY[21][6:0] == WriteBackLsuAddrR)}} & 6'd53 |
                            {6{(RATENTY[22][6:0] == WriteBackLsuAddrR)}} & 6'd54 |
                            {6{(RATENTY[23][6:0] == WriteBackLsuAddrR)}} & 6'd55 |
                            {6{(RATENTY[24][6:0] == WriteBackLsuAddrR)}} & 6'd56 |
                            {6{(RATENTY[25][6:0] == WriteBackLsuAddrR)}} & 6'd57 |
                            {6{(RATENTY[26][6:0] == WriteBackLsuAddrR)}} & 6'd58 |
                            {6{(RATENTY[27][6:0] == WriteBackLsuAddrR)}} & 6'd59 |
                            {6{(RATENTY[28][6:0] == WriteBackLsuAddrR)}} & 6'd60 |
                            {6{(RATENTY[29][6:0] == WriteBackLsuAddrR)}} & 6'd61 |
                            {6{(RATENTY[30][6:0] == WriteBackLsuAddrR)}} & 6'd62 |
                            {6{(RATENTY[31][6:0] == WriteBackLsuAddrR)}} & 6'd63 ;

    wire [5:0] ROBNum    =  {6{(RATENTY[0][6:0] == WriteBackROBAddrR)}} & 6'd32 | //避免无命中为0和命中0冲突故而将MUM={1'b1,MUM[4:0]}
                            {6{(RATENTY[1][6:0] == WriteBackROBAddrR)}} & 6'd33 |
                            {6{(RATENTY[2][6:0] == WriteBackROBAddrR)}} & 6'd34 |
                            {6{(RATENTY[3][6:0] == WriteBackROBAddrR)}} & 6'd35 |
                            {6{(RATENTY[4][6:0] == WriteBackROBAddrR)}} & 6'd36 |
                            {6{(RATENTY[5][6:0] == WriteBackROBAddrR)}} & 6'd37 |
                            {6{(RATENTY[6][6:0] == WriteBackROBAddrR)}} & 6'd38 |
                            {6{(RATENTY[7][6:0] == WriteBackROBAddrR)}} & 6'd39 |
                            {6{(RATENTY[8][6:0] == WriteBackROBAddrR)}} & 6'd40 |
                            {6{(RATENTY[9][6:0] == WriteBackROBAddrR)}} & 6'd41 |
                            {6{(RATENTY[10][6:0] == WriteBackROBAddrR)}} & 6'd42 |
                            {6{(RATENTY[11][6:0] == WriteBackROBAddrR)}} & 6'd43 |
                            {6{(RATENTY[12][6:0] == WriteBackROBAddrR)}} & 6'd44 |
                            {6{(RATENTY[13][6:0] == WriteBackROBAddrR)}} & 6'd45 |
                            {6{(RATENTY[14][6:0] == WriteBackROBAddrR)}} & 6'd46 |
                            {6{(RATENTY[15][6:0] == WriteBackROBAddrR)}} & 6'd47 |
                            {6{(RATENTY[16][6:0] == WriteBackROBAddrR)}} & 6'd48 |
                            {6{(RATENTY[17][6:0] == WriteBackROBAddrR)}} & 6'd49 |
                            {6{(RATENTY[18][6:0] == WriteBackROBAddrR)}} & 6'd50 |
                            {6{(RATENTY[19][6:0] == WriteBackROBAddrR)}} & 6'd51 |
                            {6{(RATENTY[20][6:0] == WriteBackROBAddrR)}} & 6'd52 |
                            {6{(RATENTY[21][6:0] == WriteBackROBAddrR)}} & 6'd53 |
                            {6{(RATENTY[22][6:0] == WriteBackROBAddrR)}} & 6'd54 |
                            {6{(RATENTY[23][6:0] == WriteBackROBAddrR)}} & 6'd55 |
                            {6{(RATENTY[24][6:0] == WriteBackROBAddrR)}} & 6'd56 |
                            {6{(RATENTY[25][6:0] == WriteBackROBAddrR)}} & 6'd57 |
                            {6{(RATENTY[26][6:0] == WriteBackROBAddrR)}} & 6'd58 |
                            {6{(RATENTY[27][6:0] == WriteBackROBAddrR)}} & 6'd59 |
                            {6{(RATENTY[28][6:0] == WriteBackROBAddrR)}} & 6'd60 |
                            {6{(RATENTY[29][6:0] == WriteBackROBAddrR)}} & 6'd61 |
                            {6{(RATENTY[30][6:0] == WriteBackROBAddrR)}} & 6'd62 |
                            {6{(RATENTY[31][6:0] == WriteBackROBAddrR)}} & 6'd63 ;

    //integer i ;
    always @(posedge Clk) begin
        if(!Rest) begin
           // for (i =0 ;i<32 ;i=i+1 ) begin
            //     RATENTY[i] <= i ;
            // end 
            RATENTY[0] <= {`EnableValue,7'd0}      ;
            RATENTY[1] <= {`EnableValue,7'd1}      ;
            RATENTY[2] <= {`EnableValue,7'd2}      ;
            RATENTY[3] <= {`EnableValue,7'd3}      ;
            RATENTY[4] <= {`EnableValue,7'd4}      ;
            RATENTY[5] <= {`EnableValue,7'd5}      ;
            RATENTY[6] <= {`EnableValue,7'd6}      ;
            RATENTY[7] <= {`EnableValue,7'd7}      ;
            RATENTY[8] <= {`EnableValue,7'd8}      ;
            RATENTY[9] <= {`EnableValue,7'd9}      ;
            RATENTY[10] <= {`EnableValue,7'd10}      ;
            RATENTY[11] <= {`EnableValue,7'd11}      ;
            RATENTY[12] <= {`EnableValue,7'd12}      ;
            RATENTY[13] <= {`EnableValue,7'd13}      ;
            RATENTY[14] <= {`EnableValue,7'd14}      ;
            RATENTY[15] <= {`EnableValue,7'd15}      ;
            RATENTY[16] <= {`EnableValue,7'd16}      ;
            RATENTY[17] <= {`EnableValue,7'd17}      ;
            RATENTY[18] <= {`EnableValue,7'd18}      ;
            RATENTY[19] <= {`EnableValue,7'd19}      ;
            RATENTY[20] <= {`EnableValue,7'd20}      ;
            RATENTY[21] <= {`EnableValue,7'd21}      ;
            RATENTY[22] <= {`EnableValue,7'd22}      ;
            RATENTY[23] <= {`EnableValue,7'd23}      ;
            RATENTY[24] <= {`EnableValue,7'd24}      ;
            RATENTY[25] <= {`EnableValue,7'd25}      ;
            RATENTY[26] <= {`EnableValue,7'd26}      ;
            RATENTY[27] <= {`EnableValue,7'd27}      ;
            RATENTY[28] <= {`EnableValue,7'd28}      ;
            RATENTY[29] <= {`EnableValue,7'd29}      ;
            RATENTY[30] <= {`EnableValue,7'd30}      ;
            RATENTY[31] <= {`EnableValue,7'd31}      ;
        end
        else if(RatFlash) begin
            RATENTY[0] <= {`EnableValue,7'd0}      ;
            RATENTY[1] <= {`EnableValue,7'd1}      ;
            RATENTY[2] <= {`EnableValue,7'd2}      ;
            RATENTY[3] <= {`EnableValue,7'd3}      ;
            RATENTY[4] <= {`EnableValue,7'd4}      ;
            RATENTY[5] <= {`EnableValue,7'd5}      ;
            RATENTY[6] <= {`EnableValue,7'd6}      ;
            RATENTY[7] <= {`EnableValue,7'd7}      ;
            RATENTY[8] <= {`EnableValue,7'd8}      ;
            RATENTY[9] <= {`EnableValue,7'd9}      ;
            RATENTY[10] <= {`EnableValue,7'd10}      ;
            RATENTY[11] <= {`EnableValue,7'd11}      ;
            RATENTY[12] <= {`EnableValue,7'd12}      ;
            RATENTY[13] <= {`EnableValue,7'd13}      ;
            RATENTY[14] <= {`EnableValue,7'd14}      ;
            RATENTY[15] <= {`EnableValue,7'd15}      ;
            RATENTY[16] <= {`EnableValue,7'd16}      ;
            RATENTY[17] <= {`EnableValue,7'd17}      ;
            RATENTY[18] <= {`EnableValue,7'd18}      ;
            RATENTY[19] <= {`EnableValue,7'd19}      ;
            RATENTY[20] <= {`EnableValue,7'd20}      ;
            RATENTY[21] <= {`EnableValue,7'd21}      ;
            RATENTY[22] <= {`EnableValue,7'd22}      ;
            RATENTY[23] <= {`EnableValue,7'd23}      ;
            RATENTY[24] <= {`EnableValue,7'd24}      ;
            RATENTY[25] <= {`EnableValue,7'd25}      ;
            RATENTY[26] <= {`EnableValue,7'd26}      ;
            RATENTY[27] <= {`EnableValue,7'd27}      ;
            RATENTY[28] <= {`EnableValue,7'd28}      ;
            RATENTY[29] <= {`EnableValue,7'd29}      ;
            RATENTY[30] <= {`EnableValue,7'd30}      ;
            RATENTY[31] <= {`EnableValue,7'd31}      ;
        end
        else begin
            RATENTY[Way1RdAreg] <= (Way1RdRename & ~RatStop) ? {`EnableValue,Way1RdReNum} : RATENTY[Way1RdAreg] ;
            RATENTY[Way2RdAreg] <= (Way2RdRename & ~RatStop) ? {`EnableValue,Way2RdReNum} : RATENTY[Way2RdAreg] ;
            RATENTY[Way3RdAreg] <= (Way3RdRename & ~RatStop) ? {`EnableValue,Way3RdReNum} : RATENTY[Way3RdAreg] ;
            RATENTY[Way4RdAreg] <= (Way4RdRename & ~RatStop) ? {`EnableValue,Way4RdReNum} : RATENTY[Way4RdAreg] ;
            RATENTY[ALu1Num[4:0]] <= ((ALu1Num != 0) & ~RatStop & WriteBackAlu1R) ? {`AbleValue,RATENTY[ALu1Num[4:0]][6:0]} : RATENTY[ALu1Num[4:0]] ;
            RATENTY[ALu2Num[4:0]] <= ((ALu2Num != 0) & ~RatStop & WriteBackAlu2R) ? {`AbleValue,RATENTY[ALu2Num[4:0]][6:0]} : RATENTY[ALu2Num[4:0]] ;
            RATENTY[DivNum[4:0]]  <= ((DivNum != 0)  & ~RatStop & WriteBackDivR)  ? {`AbleValue,RATENTY[DivNum[4:0]][6:0]}  : RATENTY[DivNum[4:0]]  ;
            RATENTY[MulNum[4:0]]  <= ((MulNum != 0)  & ~RatStop & WriteBackMulR)  ? {`AbleValue,RATENTY[MulNum[4:0]][6:0]}  : RATENTY[MulNum[4:0]]  ;
            RATENTY[BruNum[4:0]]  <= ((BruNum != 0)  & ~RatStop & WriteBackBruR)  ? {`AbleValue,RATENTY[BruNum[4:0]][6:0]}  : RATENTY[BruNum[4:0]]  ;
            RATENTY[CsruNum[4:0]] <= ((CsruNum != 0) & ~RatStop & WriteBackCsruR) ? {`AbleValue,RATENTY[CsruNum[4:0]][6:0]} : RATENTY[CsruNum[4:0]] ;
            RATENTY[LsuNum[4:0]]  <= ((LsuNum != 0)  & ~RatStop & WriteBackLsuR)  ? {`AbleValue,RATENTY[LsuNum[4:0]][6:0]}  : RATENTY[LsuNum[4:0]]  ;
            RATENTY[ROBNum[4:0]]  <= ((ROBNum != 0)  & ~RatStop & WriteBackROBR)  ? {`AbleValue,RATENTY[ROBNum[4:0]][6:0]}  : RATENTY[ROBNum[4:0]]  ;

        end
    end

    wire  [7:0] Way1Src1OEnty ;
    assign Way1Src1Out   = Way1Src1Rame & ~RatStop ;
    assign Way1Src1OEnty = RATENTY[Way1Src1]  ;
    assign Way1Src1Oaddr = Way1Src1OEnty[6:0] ;
    assign Way1Src1ODate = Way1Src1OEnty[7]           ? {`AbleValue,InRead11Date }      :
                           (ALu1Num[4:0] == Way1Src1) ? {`AbleValue,WriteBackAlu1DateR} :
                           (ALu2Num[4:0] == Way1Src1) ? {`AbleValue,WriteBackAlu2DateR} :
                           (DivNum[4:0]  == Way1Src1) ? {`AbleValue,WriteBackDivDateR}  :
                           (MulNum[4:0]  == Way1Src1) ? {`AbleValue,WriteBackMulDateR}  :
                           (BruNum[4:0]  == Way1Src1) ? {`AbleValue,WriteBackBruDateR}  :
                           (CsruNum[4:0] == Way1Src1) ? {`AbleValue,WriteBackCsruDateR} :
                           (LsuNum[4:0]  == Way1Src1) ? {`AbleValue,WriteBackLsuDateR}  :
                           (ROBNum[4:0]  == Way1Src1) ? {`AbleValue,WriteBackROBDateR}  : {`EnableValue, `ZeorDate};

    wire  [7:0] Way1Src2OEnty ;
    assign Way1Src2Out   = Way1Src2Rame & ~RatStop ;
    assign Way1Src2OEnty = RATENTY[Way1Src2]  ;
    assign Way1Src2Oaddr = Way1Src2OEnty[6:0] ;
    assign Way1Src2ODate = Way1Src2OEnty[7]           ? {`AbleValue,InRead12Date }      :
                           (ALu1Num[4:0] == Way1Src2) ? {`AbleValue,WriteBackAlu1DateR} :
                           (ALu2Num[4:0] == Way1Src2) ? {`AbleValue,WriteBackAlu2DateR} :
                           (DivNum[4:0]  == Way1Src2) ? {`AbleValue,WriteBackDivDateR}  :
                           (MulNum[4:0]  == Way1Src2) ? {`AbleValue,WriteBackMulDateR}  :
                           (BruNum[4:0]  == Way1Src2) ? {`AbleValue,WriteBackBruDateR}  :
                           (CsruNum[4:0] == Way1Src2) ? {`AbleValue,WriteBackCsruDateR} :
                           (LsuNum[4:0]  == Way1Src2) ? {`AbleValue,WriteBackLsuDateR}  :
                           (ROBNum[4:0]  == Way1Src2) ? {`AbleValue,WriteBackROBDateR}  : {`EnableValue, `ZeorDate};


    wire  [7:0] Way2Src1OEnty ;
    assign Way2Src1Out   = Way2Src1Rame & ~RatStop ;
    assign Way2Src1OEnty = ((Way1RdAreg == Way2Src1) & Way1RdRename) ? {`EnableValue,Way1RdReNum} : RATENTY[Way2Src1]  ;
    assign Way2Src1Oaddr = Way2Src1OEnty[6:0] ;
    assign Way2Src1ODate = Way2Src1OEnty[7]           ? {`AbleValue,InRead21Date }      :
                           (ALu1Num[4:0] == Way2Src1) ? {`AbleValue,WriteBackAlu1DateR} :
                           (ALu2Num[4:0] == Way2Src1) ? {`AbleValue,WriteBackAlu2DateR} :
                           (DivNum[4:0]  == Way2Src1) ? {`AbleValue,WriteBackDivDateR}  :
                           (MulNum[4:0]  == Way2Src1) ? {`AbleValue,WriteBackMulDateR}  :
                           (BruNum[4:0]  == Way2Src1) ? {`AbleValue,WriteBackBruDateR}  :
                           (CsruNum[4:0] == Way2Src1) ? {`AbleValue,WriteBackCsruDateR} :
                           (LsuNum[4:0]  == Way2Src1) ? {`AbleValue,WriteBackLsuDateR}  :
                           (ROBNum[4:0]  == Way2Src1) ? {`AbleValue,WriteBackROBDateR}  : {`EnableValue, `ZeorDate};
                           
    wire  [7:0] Way2Src2OEnty ;
    assign Way2Src2Out   = Way2Src2Rame & ~RatStop ;
    assign Way2Src2OEnty = ((Way1RdAreg == Way2Src2) & Way1RdRename) ? {`EnableValue,Way1RdReNum} : RATENTY[Way2Src2]  ;
    assign Way2Src2Oaddr = Way2Src2OEnty[6:0] ;
    assign Way2Src2ODate = Way2Src2OEnty[7]           ? {`AbleValue,InRead22Date }      :
                           (ALu1Num[4:0] == Way2Src2) ? {`AbleValue,WriteBackAlu1DateR} :
                           (ALu2Num[4:0] == Way2Src2) ? {`AbleValue,WriteBackAlu2DateR} :
                           (DivNum[4:0]  == Way2Src2) ? {`AbleValue,WriteBackDivDateR}  :
                           (MulNum[4:0]  == Way2Src2) ? {`AbleValue,WriteBackMulDateR}  :
                           (BruNum[4:0]  == Way2Src2) ? {`AbleValue,WriteBackBruDateR}  :
                           (CsruNum[4:0] == Way2Src2) ? {`AbleValue,WriteBackCsruDateR} :
                           (LsuNum[4:0]  == Way2Src2) ? {`AbleValue,WriteBackLsuDateR}  :
                           (ROBNum[4:0]  == Way2Src2) ? {`AbleValue,WriteBackROBDateR}  : {`EnableValue, `ZeorDate};

    wire  [7:0] Way3Src1OEnty ;
    assign Way3Src1Out   = Way3Src1Rame & ~RatStop ;
    assign Way3Src1OEnty = ((Way2RdAreg == Way3Src1) & Way2RdRename) ? {`EnableValue,Way2RdReNum} :
                           ((Way1RdAreg == Way3Src1) & Way1RdRename) ? {`EnableValue,Way1RdReNum} : RATENTY[Way3Src1]  ;
    assign Way3Src1Oaddr = Way3Src1OEnty[6:0] ;
    assign Way3Src1ODate = Way3Src1OEnty[7]           ? {`AbleValue,InRead31Date }      :
                           (ALu1Num[4:0] == Way3Src1) ? {`AbleValue,WriteBackAlu1DateR} :
                           (ALu2Num[4:0] == Way3Src1) ? {`AbleValue,WriteBackAlu2DateR} :
                           (DivNum[4:0]  == Way3Src1) ? {`AbleValue,WriteBackDivDateR}  :
                           (MulNum[4:0]  == Way3Src1) ? {`AbleValue,WriteBackMulDateR}  :
                           (BruNum[4:0]  == Way3Src1) ? {`AbleValue,WriteBackBruDateR}  :
                           (CsruNum[4:0] == Way3Src1) ? {`AbleValue,WriteBackCsruDateR} :
                           (LsuNum[4:0]  == Way3Src1) ? {`AbleValue,WriteBackLsuDateR}  :
                           (ROBNum[4:0]  == Way3Src1) ? {`AbleValue,WriteBackROBDateR}  : {`EnableValue, `ZeorDate};

    wire  [7:0] Way3Src2OEnty ;
    assign Way3Src2Out   = Way3Src2Rame & ~RatStop ;
    assign Way3Src2OEnty = ((Way2RdAreg == Way3Src2) & Way2RdRename) ? {`EnableValue,Way2RdReNum} :
                           ((Way1RdAreg == Way3Src2) & Way1RdRename) ? {`EnableValue,Way1RdReNum} : RATENTY[Way3Src2]  ;
    assign Way3Src2Oaddr = Way3Src2OEnty[6:0] ;
    assign Way3Src2ODate = Way3Src2OEnty[7]           ? {`AbleValue,InRead32Date }      :
                           (ALu1Num[4:0] == Way3Src2) ? {`AbleValue,WriteBackAlu1DateR} :
                           (ALu2Num[4:0] == Way3Src2) ? {`AbleValue,WriteBackAlu2DateR} :
                           (DivNum[4:0]  == Way3Src2) ? {`AbleValue,WriteBackDivDateR}  :
                           (MulNum[4:0]  == Way3Src2) ? {`AbleValue,WriteBackMulDateR}  :
                           (BruNum[4:0]  == Way3Src2) ? {`AbleValue,WriteBackBruDateR}  :
                           (CsruNum[4:0] == Way3Src2) ? {`AbleValue,WriteBackCsruDateR} :
                           (LsuNum[4:0]  == Way3Src2) ? {`AbleValue,WriteBackLsuDateR}  :
                           (ROBNum[4:0]  == Way3Src2) ? {`AbleValue,WriteBackROBDateR}  : {`EnableValue, `ZeorDate};


    wire  [7:0] Way4Src1OEnty ;
    assign Way4Src1Out   = Way4Src1Rame & ~RatStop ;
    assign Way4Src1OEnty = ((Way3RdAreg == Way4Src1) & Way3RdRename) ? {`EnableValue,Way3RdReNum} :
                           ((Way2RdAreg == Way4Src1) & Way2RdRename) ? {`EnableValue,Way2RdReNum} :
                           ((Way1RdAreg == Way4Src1) & Way1RdRename) ? {`EnableValue,Way1RdReNum} : RATENTY[Way4Src1]  ;
    assign Way4Src1Oaddr = Way4Src1OEnty[6:0] ;
    assign Way4Src1ODate = Way4Src1OEnty[7]           ? {`AbleValue,InRead41Date }      :
                           (ALu1Num[4:0] == Way4Src1) ? {`AbleValue,WriteBackAlu1DateR} :
                           (ALu2Num[4:0] == Way4Src1) ? {`AbleValue,WriteBackAlu2DateR} :
                           (DivNum[4:0]  == Way4Src1) ? {`AbleValue,WriteBackDivDateR}  :
                           (MulNum[4:0]  == Way4Src1) ? {`AbleValue,WriteBackMulDateR}  :
                           (BruNum[4:0]  == Way4Src1) ? {`AbleValue,WriteBackBruDateR}  :
                           (CsruNum[4:0] == Way4Src1) ? {`AbleValue,WriteBackCsruDateR} :
                           (LsuNum[4:0]  == Way4Src1) ? {`AbleValue,WriteBackLsuDateR}  :
                           (ROBNum[4:0]  == Way4Src1) ? {`AbleValue,WriteBackROBDateR}  : {`EnableValue, `ZeorDate};

    wire  [7:0] Way4Src2OEnty ;
    assign Way4Src2Out   = Way4Src2Rame & ~RatStop ;
    assign Way4Src2OEnty = ((Way3RdAreg == Way4Src2) & Way3RdRename) ? {`EnableValue,Way3RdReNum} :
                           ((Way2RdAreg == Way4Src2) & Way2RdRename) ? {`EnableValue,Way2RdReNum} :
                           ((Way1RdAreg == Way4Src2) & Way1RdRename) ? {`EnableValue,Way1RdReNum} : RATENTY[Way4Src2]  ;
    assign Way4Src2Oaddr = Way4Src2OEnty[6:0] ;
    assign Way4Src2ODate = Way4Src2OEnty[7]           ? {`AbleValue,InRead42Date }      :
                           (ALu1Num[4:0] == Way4Src2) ? {`AbleValue,WriteBackAlu1DateR} :
                           (ALu2Num[4:0] == Way4Src2) ? {`AbleValue,WriteBackAlu2DateR} :
                           (DivNum[4:0]  == Way4Src2) ? {`AbleValue,WriteBackDivDateR}  :
                           (MulNum[4:0]  == Way4Src2) ? {`AbleValue,WriteBackMulDateR}  :
                           (BruNum[4:0]  == Way4Src2) ? {`AbleValue,WriteBackBruDateR}  :
                           (CsruNum[4:0] == Way4Src2) ? {`AbleValue,WriteBackCsruDateR} :
                           (LsuNum[4:0]  == Way4Src2) ? {`AbleValue,WriteBackLsuDateR}  :
                           (ROBNum[4:0]  == Way4Src2) ? {`AbleValue,WriteBackROBDateR}  : {`EnableValue, `ZeorDate};

    assign Way1RdAble = Way1RdRename ;
    assign Way1RdAddr = Way1RdReNum  ;
    assign Way2RdAble = Way2RdRename ;
    assign Way2RdAddr = Way2RdReNum  ;
    assign Way3RdAble = Way3RdRename ;
    assign Way3RdAddr = Way3RdReNum  ;
    assign Way4RdAble = Way4RdRename ;
    assign Way4RdAddr = Way4RdReNum  ;

    assign ReqRead11Able = ~RatStop & Way1Src1Rame ;
    assign ReqRead11Addr = RATENTY[Way1Src1][6:0] ;  
    assign ReqRead12Able = ~RatStop & Way1Src2Rame ;
    assign ReqRead12Addr = RATENTY[Way1Src2][6:0] ;  
    assign ReqRead21Able = ~RatStop & Way2Src1Rame ;
    assign ReqRead21Addr = RATENTY[Way2Src1][6:0] ;  
    assign ReqRead22Able = ~RatStop & Way2Src2Rame ;
    assign ReqRead22Addr = RATENTY[Way2Src2][6:0] ;
    assign ReqRead31Able = ~RatStop & Way3Src1Rame ;
    assign ReqRead31Addr = RATENTY[Way3Src1][6:0] ;  
    assign ReqRead32Able = ~RatStop & Way3Src2Rame ;
    assign ReqRead32Addr = RATENTY[Way3Src2][6:0] ;
    assign ReqRead41Able = ~RatStop & Way4Src1Rame ;
    assign ReqRead41Addr = RATENTY[Way4Src1][6:0] ;  
    assign ReqRead42Able = ~RatStop & Way4Src2Rame ;
    assign ReqRead42Addr = RATENTY[Way4Src2][6:0] ;
    
endmodule
