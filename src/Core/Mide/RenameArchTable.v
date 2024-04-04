`timescale 1ps/1ps
`include "../define.v"

module RenameArchTable (
    input           wire                                        Clk               ,
    input           wire                                        Rest              ,
    //for ctrl 
    input           wire                                        RatStop           ,
    input           wire                                        RatFlash          ,
    output          wire                                        RatReq            ,
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
    //to Dispatch  
    output          wire                                        Way1Src1Out       ,
    output          wire      [`ReNameRegBUs]                   Way1Src1Oaddr     ,
    output          wire      [`DataBus]                        Way1Src1ODate     ,
    output          wire                                        Way1Src2Out       ,
    output          wire      [`ReNameRegBUs]                   Way1Src2Oaddr     ,
    output          wire      [`DataBus]                        Way1Src2ODate     ,
    output          wire                                        Way2Src1Out       ,
    output          wire      [`ReNameRegBUs]                   Way2Src1Oaddr     ,
    output          wire      [`DataBus]                        Way2Src1ODate     ,
    output          wire                                        Way2Src2Out       ,
    output          wire      [`ReNameRegBUs]                   Way2Src2Oaddr     ,
    output          wire      [`DataBus]                        Way2Src2ODate     ,
    output          wire                                        Way3Src1Out       ,
    output          wire      [`ReNameRegBUs]                   Way3Src1Oaddr     ,
    output          wire      [`DataBus]                        Way3Src1ODate     ,
    output          wire                                        Way3Src2Out       ,
    output          wire      [`ReNameRegBUs]                   Way3Src2Oaddr     ,
    output          wire      [`DataBus]                        Way3Src2ODate     ,
    output          wire                                        Way4Src1Out       ,
    output          wire      [`ReNameRegBUs]                   Way4Src1Oaddr     ,
    output          wire      [`DataBus]                        Way4Src1ODate     ,
    output          wire                                        Way4Src2Out       ,
    output          wire      [`ReNameRegBUs]                   Way4Src2Oaddr     ,
    output          wire      [`DataBus]                        Way4Src2ODate     ,
    output          wire                                        Way1RdAble        ,
    output          wire      [`ReNameRegBUs]                   Way1RdAddr        ,
    output          wire                                        Way2RdAble        ,
    output          wire      [`ReNameRegBUs]                   Way2RdAddr        ,
    output          wire                                        Way3RdAble        ,
    output          wire      [`ReNameRegBUs]                   Way3RdAddr        ,
    output          wire                                        Way4RdAble        ,
    output          wire      [`ReNameRegBUs]                   Way4RdAddr        ,
    //from ROB 
    input           wire                                        Inst1RetirAble    ,
    input           wire      [`ArchRegBUs]                     Inst1RetirAddr    ,
    input           wire                                        Inst2RetirAble    ,
    input           wire      [`ArchRegBUs]                     Inst2RetirAddr    ,
    input           wire                                        Inst3RetirAble    ,
    input           wire      [`ArchRegBUs]                     Inst3RetirAddr    ,
    input           wire                                        Inst4RetirAble    ,
    input           wire      [`ArchRegBUs]                     Inst4RetirAddr    ,
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

    wire [4:0] ALu1Num   =  (5{(RATENTY[0][6:0] == WriteBackAlu1AddrR)}) & 5'd0 |
                            (5{(RATENTY[1][6:0] == WriteBackAlu1AddrR)}) & 5'd1 |
                            (5{(RATENTY[2][6:0] == WriteBackAlu1AddrR)}) & 5'd2 |
                            (5{(RATENTY[3][6:0] == WriteBackAlu1AddrR)}) & 5'd3 |
                            (5{(RATENTY[4][6:0] == WriteBackAlu1AddrR)}) & 5'd4 |
                            (5{(RATENTY[5][6:0] == WriteBackAlu1AddrR)}) & 5'd5 |
                            (5{(RATENTY[6][6:0] == WriteBackAlu1AddrR)}) & 5'd6 |
                            (5{(RATENTY[7][6:0] == WriteBackAlu1AddrR)}) & 5'd7 |
                            (5{(RATENTY[8][6:0] == WriteBackAlu1AddrR)}) & 5'd8 |
                            (5{(RATENTY[9][6:0] == WriteBackAlu1AddrR)}) & 5'd9 |
                            (5{(RATENTY[10][6:0] == WriteBackAlu1AddrR)}) & 5'd10 |
                            (5{(RATENTY[11][6:0] == WriteBackAlu1AddrR)}) & 5'd11 |
                            (5{(RATENTY[12][6:0] == WriteBackAlu1AddrR)}) & 5'd12 |
                            (5{(RATENTY[13][6:0] == WriteBackAlu1AddrR)}) & 5'd13 |
                            (5{(RATENTY[14][6:0] == WriteBackAlu1AddrR)}) & 5'd14 |
                            (5{(RATENTY[15][6:0] == WriteBackAlu1AddrR)}) & 5'd15 |
                            (5{(RATENTY[16][6:0] == WriteBackAlu1AddrR)}) & 5'd16 |
                            (5{(RATENTY[17][6:0] == WriteBackAlu1AddrR)}) & 5'd17 |
                            (5{(RATENTY[18][6:0] == WriteBackAlu1AddrR)}) & 5'd18 |
                            (5{(RATENTY[19][6:0] == WriteBackAlu1AddrR)}) & 5'd19 |
                            (5{(RATENTY[20][6:0] == WriteBackAlu1AddrR)}) & 5'd20 |
                            (5{(RATENTY[21][6:0] == WriteBackAlu1AddrR)}) & 5'd21 |
                            (5{(RATENTY[22][6:0] == WriteBackAlu1AddrR)}) & 5'd22 |
                            (5{(RATENTY[23][6:0] == WriteBackAlu1AddrR)}) & 5'd23 |
                            (5{(RATENTY[24][6:0] == WriteBackAlu1AddrR)}) & 5'd24 |
                            (5{(RATENTY[25][6:0] == WriteBackAlu1AddrR)}) & 5'd25 |
                            (5{(RATENTY[26][6:0] == WriteBackAlu1AddrR)}) & 5'd26 |
                            (5{(RATENTY[27][6:0] == WriteBackAlu1AddrR)}) & 5'd27 |
                            (5{(RATENTY[28][6:0] == WriteBackAlu1AddrR)}) & 5'd28 |
                            (5{(RATENTY[29][6:0] == WriteBackAlu1AddrR)}) & 5'd29 |
                            (5{(RATENTY[30][6:0] == WriteBackAlu1AddrR)}) & 5'd30 |
                            (5{(RATENTY[31][6:0] == WriteBackAlu1AddrR)}) & 5'd31 ;

    wire [4:0] ALu2Num   =  (5{(RATENTY[0][6:0] == WriteBackAlu1AddrR)}) & 5'd0 |
                            (5{(RATENTY[1][6:0] == WriteBackAlu1AddrR)}) & 5'd1 |
                            (5{(RATENTY[2][6:0] == WriteBackAlu1AddrR)}) & 5'd2 |
                            (5{(RATENTY[3][6:0] == WriteBackAlu1AddrR)}) & 5'd3 |
                            (5{(RATENTY[4][6:0] == WriteBackAlu1AddrR)}) & 5'd4 |
                            (5{(RATENTY[5][6:0] == WriteBackAlu1AddrR)}) & 5'd5 |
                            (5{(RATENTY[6][6:0] == WriteBackAlu1AddrR)}) & 5'd6 |
                            (5{(RATENTY[7][6:0] == WriteBackAlu1AddrR)}) & 5'd7 |
                            (5{(RATENTY[8][6:0] == WriteBackAlu1AddrR)}) & 5'd8 |
                            (5{(RATENTY[9][6:0] == WriteBackAlu1AddrR)}) & 5'd9 |
                            (5{(RATENTY[10][6:0] == WriteBackAlu1AddrR)}) & 5'd10 |
                            (5{(RATENTY[11][6:0] == WriteBackAlu1AddrR)}) & 5'd11 |
                            (5{(RATENTY[12][6:0] == WriteBackAlu1AddrR)}) & 5'd12 |
                            (5{(RATENTY[13][6:0] == WriteBackAlu1AddrR)}) & 5'd13 |
                            (5{(RATENTY[14][6:0] == WriteBackAlu1AddrR)}) & 5'd14 |
                            (5{(RATENTY[15][6:0] == WriteBackAlu1AddrR)}) & 5'd15 |
                            (5{(RATENTY[16][6:0] == WriteBackAlu1AddrR)}) & 5'd16 |
                            (5{(RATENTY[17][6:0] == WriteBackAlu1AddrR)}) & 5'd17 |
                            (5{(RATENTY[18][6:0] == WriteBackAlu1AddrR)}) & 5'd18 |
                            (5{(RATENTY[19][6:0] == WriteBackAlu1AddrR)}) & 5'd19 |
                            (5{(RATENTY[20][6:0] == WriteBackAlu1AddrR)}) & 5'd20 |
                            (5{(RATENTY[21][6:0] == WriteBackAlu1AddrR)}) & 5'd21 |
                            (5{(RATENTY[22][6:0] == WriteBackAlu1AddrR)}) & 5'd22 |
                            (5{(RATENTY[23][6:0] == WriteBackAlu1AddrR)}) & 5'd23 |
                            (5{(RATENTY[24][6:0] == WriteBackAlu1AddrR)}) & 5'd24 |
                            (5{(RATENTY[25][6:0] == WriteBackAlu1AddrR)}) & 5'd25 |
                            (5{(RATENTY[26][6:0] == WriteBackAlu1AddrR)}) & 5'd26 |
                            (5{(RATENTY[27][6:0] == WriteBackAlu1AddrR)}) & 5'd27 |
                            (5{(RATENTY[28][6:0] == WriteBackAlu1AddrR)}) & 5'd28 |
                            (5{(RATENTY[29][6:0] == WriteBackAlu1AddrR)}) & 5'd29 |
                            (5{(RATENTY[30][6:0] == WriteBackAlu1AddrR)}) & 5'd30 |
                            (5{(RATENTY[31][6:0] == WriteBackAlu1AddrR)}) & 5'd31 ;
                
    wire [4:0] DivNum    =  (5{(RATENTY[0][6:0] == WriteBackAlu1AddrR)}) & 5'd0 |
                            (5{(RATENTY[1][6:0] == WriteBackAlu1AddrR)}) & 5'd1 |
                            (5{(RATENTY[2][6:0] == WriteBackAlu1AddrR)}) & 5'd2 |
                            (5{(RATENTY[3][6:0] == WriteBackAlu1AddrR)}) & 5'd3 |
                            (5{(RATENTY[4][6:0] == WriteBackAlu1AddrR)}) & 5'd4 |
                            (5{(RATENTY[5][6:0] == WriteBackAlu1AddrR)}) & 5'd5 |
                            (5{(RATENTY[6][6:0] == WriteBackAlu1AddrR)}) & 5'd6 |
                            (5{(RATENTY[7][6:0] == WriteBackAlu1AddrR)}) & 5'd7 |
                            (5{(RATENTY[8][6:0] == WriteBackAlu1AddrR)}) & 5'd8 |
                            (5{(RATENTY[9][6:0] == WriteBackAlu1AddrR)}) & 5'd9 |
                            (5{(RATENTY[10][6:0] == WriteBackAlu1AddrR)}) & 5'd10 |
                            (5{(RATENTY[11][6:0] == WriteBackAlu1AddrR)}) & 5'd11 |
                            (5{(RATENTY[12][6:0] == WriteBackAlu1AddrR)}) & 5'd12 |
                            (5{(RATENTY[13][6:0] == WriteBackAlu1AddrR)}) & 5'd13 |
                            (5{(RATENTY[14][6:0] == WriteBackAlu1AddrR)}) & 5'd14 |
                            (5{(RATENTY[15][6:0] == WriteBackAlu1AddrR)}) & 5'd15 |
                            (5{(RATENTY[16][6:0] == WriteBackAlu1AddrR)}) & 5'd16 |
                            (5{(RATENTY[17][6:0] == WriteBackAlu1AddrR)}) & 5'd17 |
                            (5{(RATENTY[18][6:0] == WriteBackAlu1AddrR)}) & 5'd18 |
                            (5{(RATENTY[19][6:0] == WriteBackAlu1AddrR)}) & 5'd19 |
                            (5{(RATENTY[20][6:0] == WriteBackAlu1AddrR)}) & 5'd20 |
                            (5{(RATENTY[21][6:0] == WriteBackAlu1AddrR)}) & 5'd21 |
                            (5{(RATENTY[22][6:0] == WriteBackAlu1AddrR)}) & 5'd22 |
                            (5{(RATENTY[23][6:0] == WriteBackAlu1AddrR)}) & 5'd23 |
                            (5{(RATENTY[24][6:0] == WriteBackAlu1AddrR)}) & 5'd24 |
                            (5{(RATENTY[25][6:0] == WriteBackAlu1AddrR)}) & 5'd25 |
                            (5{(RATENTY[26][6:0] == WriteBackAlu1AddrR)}) & 5'd26 |
                            (5{(RATENTY[27][6:0] == WriteBackAlu1AddrR)}) & 5'd27 |
                            (5{(RATENTY[28][6:0] == WriteBackAlu1AddrR)}) & 5'd28 |
                            (5{(RATENTY[29][6:0] == WriteBackAlu1AddrR)}) & 5'd29 |
                            (5{(RATENTY[30][6:0] == WriteBackAlu1AddrR)}) & 5'd30 |
                            (5{(RATENTY[31][6:0] == WriteBackAlu1AddrR)}) & 5'd31 ;

    wire [4:0] MulNum    =  (5{(RATENTY[0][6:0] == WriteBackAlu1AddrR)}) & 5'd0 |
                            (5{(RATENTY[1][6:0] == WriteBackAlu1AddrR)}) & 5'd1 |
                            (5{(RATENTY[2][6:0] == WriteBackAlu1AddrR)}) & 5'd2 |
                            (5{(RATENTY[3][6:0] == WriteBackAlu1AddrR)}) & 5'd3 |
                            (5{(RATENTY[4][6:0] == WriteBackAlu1AddrR)}) & 5'd4 |
                            (5{(RATENTY[5][6:0] == WriteBackAlu1AddrR)}) & 5'd5 |
                            (5{(RATENTY[6][6:0] == WriteBackAlu1AddrR)}) & 5'd6 |
                            (5{(RATENTY[7][6:0] == WriteBackAlu1AddrR)}) & 5'd7 |
                            (5{(RATENTY[8][6:0] == WriteBackAlu1AddrR)}) & 5'd8 |
                            (5{(RATENTY[9][6:0] == WriteBackAlu1AddrR)}) & 5'd9 |
                            (5{(RATENTY[10][6:0] == WriteBackAlu1AddrR)}) & 5'd10 |
                            (5{(RATENTY[11][6:0] == WriteBackAlu1AddrR)}) & 5'd11 |
                            (5{(RATENTY[12][6:0] == WriteBackAlu1AddrR)}) & 5'd12 |
                            (5{(RATENTY[13][6:0] == WriteBackAlu1AddrR)}) & 5'd13 |
                            (5{(RATENTY[14][6:0] == WriteBackAlu1AddrR)}) & 5'd14 |
                            (5{(RATENTY[15][6:0] == WriteBackAlu1AddrR)}) & 5'd15 |
                            (5{(RATENTY[16][6:0] == WriteBackAlu1AddrR)}) & 5'd16 |
                            (5{(RATENTY[17][6:0] == WriteBackAlu1AddrR)}) & 5'd17 |
                            (5{(RATENTY[18][6:0] == WriteBackAlu1AddrR)}) & 5'd18 |
                            (5{(RATENTY[19][6:0] == WriteBackAlu1AddrR)}) & 5'd19 |
                            (5{(RATENTY[20][6:0] == WriteBackAlu1AddrR)}) & 5'd20 |
                            (5{(RATENTY[21][6:0] == WriteBackAlu1AddrR)}) & 5'd21 |
                            (5{(RATENTY[22][6:0] == WriteBackAlu1AddrR)}) & 5'd22 |
                            (5{(RATENTY[23][6:0] == WriteBackAlu1AddrR)}) & 5'd23 |
                            (5{(RATENTY[24][6:0] == WriteBackAlu1AddrR)}) & 5'd24 |
                            (5{(RATENTY[25][6:0] == WriteBackAlu1AddrR)}) & 5'd25 |
                            (5{(RATENTY[26][6:0] == WriteBackAlu1AddrR)}) & 5'd26 |
                            (5{(RATENTY[27][6:0] == WriteBackAlu1AddrR)}) & 5'd27 |
                            (5{(RATENTY[28][6:0] == WriteBackAlu1AddrR)}) & 5'd28 |
                            (5{(RATENTY[29][6:0] == WriteBackAlu1AddrR)}) & 5'd29 |
                            (5{(RATENTY[30][6:0] == WriteBackAlu1AddrR)}) & 5'd30 |
                            (5{(RATENTY[31][6:0] == WriteBackAlu1AddrR)}) & 5'd31 ;

    wire [4:0] CsruNum   =  (5{(RATENTY[0][6:0] == WriteBackAlu1AddrR)}) & 5'd0 |
                            (5{(RATENTY[1][6:0] == WriteBackAlu1AddrR)}) & 5'd1 |
                            (5{(RATENTY[2][6:0] == WriteBackAlu1AddrR)}) & 5'd2 |
                            (5{(RATENTY[3][6:0] == WriteBackAlu1AddrR)}) & 5'd3 |
                            (5{(RATENTY[4][6:0] == WriteBackAlu1AddrR)}) & 5'd4 |
                            (5{(RATENTY[5][6:0] == WriteBackAlu1AddrR)}) & 5'd5 |
                            (5{(RATENTY[6][6:0] == WriteBackAlu1AddrR)}) & 5'd6 |
                            (5{(RATENTY[7][6:0] == WriteBackAlu1AddrR)}) & 5'd7 |
                            (5{(RATENTY[8][6:0] == WriteBackAlu1AddrR)}) & 5'd8 |
                            (5{(RATENTY[9][6:0] == WriteBackAlu1AddrR)}) & 5'd9 |
                            (5{(RATENTY[10][6:0] == WriteBackAlu1AddrR)}) & 5'd10 |
                            (5{(RATENTY[11][6:0] == WriteBackAlu1AddrR)}) & 5'd11 |
                            (5{(RATENTY[12][6:0] == WriteBackAlu1AddrR)}) & 5'd12 |
                            (5{(RATENTY[13][6:0] == WriteBackAlu1AddrR)}) & 5'd13 |
                            (5{(RATENTY[14][6:0] == WriteBackAlu1AddrR)}) & 5'd14 |
                            (5{(RATENTY[15][6:0] == WriteBackAlu1AddrR)}) & 5'd15 |
                            (5{(RATENTY[16][6:0] == WriteBackAlu1AddrR)}) & 5'd16 |
                            (5{(RATENTY[17][6:0] == WriteBackAlu1AddrR)}) & 5'd17 |
                            (5{(RATENTY[18][6:0] == WriteBackAlu1AddrR)}) & 5'd18 |
                            (5{(RATENTY[19][6:0] == WriteBackAlu1AddrR)}) & 5'd19 |
                            (5{(RATENTY[20][6:0] == WriteBackAlu1AddrR)}) & 5'd20 |
                            (5{(RATENTY[21][6:0] == WriteBackAlu1AddrR)}) & 5'd21 |
                            (5{(RATENTY[22][6:0] == WriteBackAlu1AddrR)}) & 5'd22 |
                            (5{(RATENTY[23][6:0] == WriteBackAlu1AddrR)}) & 5'd23 |
                            (5{(RATENTY[24][6:0] == WriteBackAlu1AddrR)}) & 5'd24 |
                            (5{(RATENTY[25][6:0] == WriteBackAlu1AddrR)}) & 5'd25 |
                            (5{(RATENTY[26][6:0] == WriteBackAlu1AddrR)}) & 5'd26 |
                            (5{(RATENTY[27][6:0] == WriteBackAlu1AddrR)}) & 5'd27 |
                            (5{(RATENTY[28][6:0] == WriteBackAlu1AddrR)}) & 5'd28 |
                            (5{(RATENTY[29][6:0] == WriteBackAlu1AddrR)}) & 5'd29 |
                            (5{(RATENTY[30][6:0] == WriteBackAlu1AddrR)}) & 5'd30 |
                            (5{(RATENTY[31][6:0] == WriteBackAlu1AddrR)}) & 5'd31 ;

    wire [4:0] BruNum    =  (5{(RATENTY[0][6:0] == WriteBackAlu1AddrR)}) & 5'd0 |
                            (5{(RATENTY[1][6:0] == WriteBackAlu1AddrR)}) & 5'd1 |
                            (5{(RATENTY[2][6:0] == WriteBackAlu1AddrR)}) & 5'd2 |
                            (5{(RATENTY[3][6:0] == WriteBackAlu1AddrR)}) & 5'd3 |
                            (5{(RATENTY[4][6:0] == WriteBackAlu1AddrR)}) & 5'd4 |
                            (5{(RATENTY[5][6:0] == WriteBackAlu1AddrR)}) & 5'd5 |
                            (5{(RATENTY[6][6:0] == WriteBackAlu1AddrR)}) & 5'd6 |
                            (5{(RATENTY[7][6:0] == WriteBackAlu1AddrR)}) & 5'd7 |
                            (5{(RATENTY[8][6:0] == WriteBackAlu1AddrR)}) & 5'd8 |
                            (5{(RATENTY[9][6:0] == WriteBackAlu1AddrR)}) & 5'd9 |
                            (5{(RATENTY[10][6:0] == WriteBackAlu1AddrR)}) & 5'd10 |
                            (5{(RATENTY[11][6:0] == WriteBackAlu1AddrR)}) & 5'd11 |
                            (5{(RATENTY[12][6:0] == WriteBackAlu1AddrR)}) & 5'd12 |
                            (5{(RATENTY[13][6:0] == WriteBackAlu1AddrR)}) & 5'd13 |
                            (5{(RATENTY[14][6:0] == WriteBackAlu1AddrR)}) & 5'd14 |
                            (5{(RATENTY[15][6:0] == WriteBackAlu1AddrR)}) & 5'd15 |
                            (5{(RATENTY[16][6:0] == WriteBackAlu1AddrR)}) & 5'd16 |
                            (5{(RATENTY[17][6:0] == WriteBackAlu1AddrR)}) & 5'd17 |
                            (5{(RATENTY[18][6:0] == WriteBackAlu1AddrR)}) & 5'd18 |
                            (5{(RATENTY[19][6:0] == WriteBackAlu1AddrR)}) & 5'd19 |
                            (5{(RATENTY[20][6:0] == WriteBackAlu1AddrR)}) & 5'd20 |
                            (5{(RATENTY[21][6:0] == WriteBackAlu1AddrR)}) & 5'd21 |
                            (5{(RATENTY[22][6:0] == WriteBackAlu1AddrR)}) & 5'd22 |
                            (5{(RATENTY[23][6:0] == WriteBackAlu1AddrR)}) & 5'd23 |
                            (5{(RATENTY[24][6:0] == WriteBackAlu1AddrR)}) & 5'd24 |
                            (5{(RATENTY[25][6:0] == WriteBackAlu1AddrR)}) & 5'd25 |
                            (5{(RATENTY[26][6:0] == WriteBackAlu1AddrR)}) & 5'd26 |
                            (5{(RATENTY[27][6:0] == WriteBackAlu1AddrR)}) & 5'd27 |
                            (5{(RATENTY[28][6:0] == WriteBackAlu1AddrR)}) & 5'd28 |
                            (5{(RATENTY[29][6:0] == WriteBackAlu1AddrR)}) & 5'd29 |
                            (5{(RATENTY[30][6:0] == WriteBackAlu1AddrR)}) & 5'd30 |
                            (5{(RATENTY[31][6:0] == WriteBackAlu1AddrR)}) & 5'd31 ;

    wire [4:0] LsuNum    =  (5{(RATENTY[0][6:0] == WriteBackAlu1AddrR)}) & 5'd0 |
                            (5{(RATENTY[1][6:0] == WriteBackAlu1AddrR)}) & 5'd1 |
                            (5{(RATENTY[2][6:0] == WriteBackAlu1AddrR)}) & 5'd2 |
                            (5{(RATENTY[3][6:0] == WriteBackAlu1AddrR)}) & 5'd3 |
                            (5{(RATENTY[4][6:0] == WriteBackAlu1AddrR)}) & 5'd4 |
                            (5{(RATENTY[5][6:0] == WriteBackAlu1AddrR)}) & 5'd5 |
                            (5{(RATENTY[6][6:0] == WriteBackAlu1AddrR)}) & 5'd6 |
                            (5{(RATENTY[7][6:0] == WriteBackAlu1AddrR)}) & 5'd7 |
                            (5{(RATENTY[8][6:0] == WriteBackAlu1AddrR)}) & 5'd8 |
                            (5{(RATENTY[9][6:0] == WriteBackAlu1AddrR)}) & 5'd9 |
                            (5{(RATENTY[10][6:0] == WriteBackAlu1AddrR)}) & 5'd10 |
                            (5{(RATENTY[11][6:0] == WriteBackAlu1AddrR)}) & 5'd11 |
                            (5{(RATENTY[12][6:0] == WriteBackAlu1AddrR)}) & 5'd12 |
                            (5{(RATENTY[13][6:0] == WriteBackAlu1AddrR)}) & 5'd13 |
                            (5{(RATENTY[14][6:0] == WriteBackAlu1AddrR)}) & 5'd14 |
                            (5{(RATENTY[15][6:0] == WriteBackAlu1AddrR)}) & 5'd15 |
                            (5{(RATENTY[16][6:0] == WriteBackAlu1AddrR)}) & 5'd16 |
                            (5{(RATENTY[17][6:0] == WriteBackAlu1AddrR)}) & 5'd17 |
                            (5{(RATENTY[18][6:0] == WriteBackAlu1AddrR)}) & 5'd18 |
                            (5{(RATENTY[19][6:0] == WriteBackAlu1AddrR)}) & 5'd19 |
                            (5{(RATENTY[20][6:0] == WriteBackAlu1AddrR)}) & 5'd20 |
                            (5{(RATENTY[21][6:0] == WriteBackAlu1AddrR)}) & 5'd21 |
                            (5{(RATENTY[22][6:0] == WriteBackAlu1AddrR)}) & 5'd22 |
                            (5{(RATENTY[23][6:0] == WriteBackAlu1AddrR)}) & 5'd23 |
                            (5{(RATENTY[24][6:0] == WriteBackAlu1AddrR)}) & 5'd24 |
                            (5{(RATENTY[25][6:0] == WriteBackAlu1AddrR)}) & 5'd25 |
                            (5{(RATENTY[26][6:0] == WriteBackAlu1AddrR)}) & 5'd26 |
                            (5{(RATENTY[27][6:0] == WriteBackAlu1AddrR)}) & 5'd27 |
                            (5{(RATENTY[28][6:0] == WriteBackAlu1AddrR)}) & 5'd28 |
                            (5{(RATENTY[29][6:0] == WriteBackAlu1AddrR)}) & 5'd29 |
                            (5{(RATENTY[30][6:0] == WriteBackAlu1AddrR)}) & 5'd30 |
                            (5{(RATENTY[31][6:0] == WriteBackAlu1AddrR)}) & 5'd31 ;

    wire [4:0] ROBNum    =  (5{(RATENTY[0][6:0] == WriteBackAlu1AddrR)}) & 5'd0 |
                            (5{(RATENTY[1][6:0] == WriteBackAlu1AddrR)}) & 5'd1 |
                            (5{(RATENTY[2][6:0] == WriteBackAlu1AddrR)}) & 5'd2 |
                            (5{(RATENTY[3][6:0] == WriteBackAlu1AddrR)}) & 5'd3 |
                            (5{(RATENTY[4][6:0] == WriteBackAlu1AddrR)}) & 5'd4 |
                            (5{(RATENTY[5][6:0] == WriteBackAlu1AddrR)}) & 5'd5 |
                            (5{(RATENTY[6][6:0] == WriteBackAlu1AddrR)}) & 5'd6 |
                            (5{(RATENTY[7][6:0] == WriteBackAlu1AddrR)}) & 5'd7 |
                            (5{(RATENTY[8][6:0] == WriteBackAlu1AddrR)}) & 5'd8 |
                            (5{(RATENTY[9][6:0] == WriteBackAlu1AddrR)}) & 5'd9 |
                            (5{(RATENTY[10][6:0] == WriteBackAlu1AddrR)}) & 5'd10 |
                            (5{(RATENTY[11][6:0] == WriteBackAlu1AddrR)}) & 5'd11 |
                            (5{(RATENTY[12][6:0] == WriteBackAlu1AddrR)}) & 5'd12 |
                            (5{(RATENTY[13][6:0] == WriteBackAlu1AddrR)}) & 5'd13 |
                            (5{(RATENTY[14][6:0] == WriteBackAlu1AddrR)}) & 5'd14 |
                            (5{(RATENTY[15][6:0] == WriteBackAlu1AddrR)}) & 5'd15 |
                            (5{(RATENTY[16][6:0] == WriteBackAlu1AddrR)}) & 5'd16 |
                            (5{(RATENTY[17][6:0] == WriteBackAlu1AddrR)}) & 5'd17 |
                            (5{(RATENTY[18][6:0] == WriteBackAlu1AddrR)}) & 5'd18 |
                            (5{(RATENTY[19][6:0] == WriteBackAlu1AddrR)}) & 5'd19 |
                            (5{(RATENTY[20][6:0] == WriteBackAlu1AddrR)}) & 5'd20 |
                            (5{(RATENTY[21][6:0] == WriteBackAlu1AddrR)}) & 5'd21 |
                            (5{(RATENTY[22][6:0] == WriteBackAlu1AddrR)}) & 5'd22 |
                            (5{(RATENTY[23][6:0] == WriteBackAlu1AddrR)}) & 5'd23 |
                            (5{(RATENTY[24][6:0] == WriteBackAlu1AddrR)}) & 5'd24 |
                            (5{(RATENTY[25][6:0] == WriteBackAlu1AddrR)}) & 5'd25 |
                            (5{(RATENTY[26][6:0] == WriteBackAlu1AddrR)}) & 5'd26 |
                            (5{(RATENTY[27][6:0] == WriteBackAlu1AddrR)}) & 5'd27 |
                            (5{(RATENTY[28][6:0] == WriteBackAlu1AddrR)}) & 5'd28 |
                            (5{(RATENTY[29][6:0] == WriteBackAlu1AddrR)}) & 5'd29 |
                            (5{(RATENTY[30][6:0] == WriteBackAlu1AddrR)}) & 5'd30 |
                            (5{(RATENTY[31][6:0] == WriteBackAlu1AddrR)}) & 5'd31 ;

    integer i ;
    always @(posedge Clk) begin
        if(!Rest)
            for (i =0 ;i<32 ;i=i+1 ) begin
                RATENTY[i] <= i ;
            end
        else begin
            RATENTY[Way1RdAreg] = (Way1RdRename & ~RatStop) ? {`EnableValue,Way1RdReNum} : RATENTY[Way1RdAreg] ;
            RATENTY[Way2RdAreg] = (Way1RdRename & ~RatStop) ? {`EnableValue,Way2RdReNum} : RATENTY[Way2RdAreg] ;
            RATENTY[Way3RdAreg] = (Way1RdRename & ~RatStop) ? {`EnableValue,Way3RdReNum} : RATENTY[Way3RdAreg] ;
            RATENTY[Way4RdAreg] = (Way1RdRename & ~RatStop) ? {`EnableValue,Way4RdReNum} : RATENTY[Way4RdAreg] ;

        end
    end

    
endmodule