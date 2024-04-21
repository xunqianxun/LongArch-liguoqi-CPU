`timescale 1ps/1ps
`include "../define.v"

module PreDecode (
    input          wire                                        Clk                ,
    input          wire                                        Rest               ,
    //in form Ctrll Block
    input          wire                                        PreDecodeFlash     ,   
    input          wire                                        PreDecodeStop      ,
    output         wire                                        PreDecodeReq       ,   
    //from Btb
    input          wire                                        BtbAble            ,
    input          wire           [`InstAddrBus]               BtbPc              ,
    //from Ras
    input          wire                                        RasAble            ,
    input          wire           [`InstAddrBus]               RasPc              ,
    //from tage
    input          wire                                        TageAble           ,
    input          wire                                        TageMode           ,
    //from Icache 
    input          wire           [2:0]                        FinalType          ,
    input          wire           [`InstAddrBus]               FinalPc            ,
    input          wire           [3:0]                        FetchInstNum       ,
    input          wire           [32*8-1:0]                   FetchDate          ,
    //to pc 
    output         wire                                        PreReDirectAble    ,
    output         wire                                        PreReDirectPc      ,
    //to btb
    output         wire                                        BtbUpAble          ,
    output         wire           [`InstAddrBus]               BtbUpPc            ,
    output         wire           [2:0]                        BtbUpType          ,
    output         wire           [`InstAddrBus]               BtbUpTaget         ,
    //to ras
    output         wire                                        RasUpAble          ,
    output         wire           [1:0]                        RasPtrType         ,
    output         wire           [`InstAddrBus]               RasAddrDate        ,
    //to tage      
    output         wire                                        TageUpAble         ,
    output         wire                                        TAgePreYorN        ,
    //to InstBuffer 
    output         wire                                        ToIbInst1Able      ,
    output         wire                                        ToIbInst1Mode      ,
    output         wire           [`InstAddrBus]               ToIbInst1Pc        ,
    output         wire           [`InstAddrBus]               ToIbInst1Redir     ,
    output         wire           [`InstDateBus]               ToIbInst1Date      ,   
    output         wire                                        ToIbInst2Able      ,
    output         wire                                        ToIbInst2Mode      ,
    output         wire           [`InstAddrBus]               ToIbInst2Pc        ,
    output         wire           [`InstAddrBus]               ToIbInst2Redir     ,
    output         wire           [`InstDateBus]               ToIbInst2Date      , 
    output         wire                                        ToIbInst3Able      ,
    output         wire                                        ToIbInst3Mode      ,
    output         wire           [`InstAddrBus]               ToIbInst3Pc        ,
    output         wire           [`InstAddrBus]               ToIbInst3Redir     ,
    output         wire           [`InstDateBus]               ToIbInst3Date      ,                   
    output         wire                                        ToIbInst4Able      ,
    output         wire                                        ToIbInst4Mode      ,
    output         wire           [`InstAddrBus]               ToIbInst4Pc        ,
    output         wire           [`InstAddrBus]               ToIbInst4Redir     ,
    output         wire           [`InstDateBus]               ToIbInst4Date      , 
    output         wire                                        ToIbInst5Able      ,
    output         wire                                        ToIbInst5Mode      ,
    output         wire           [`InstAddrBus]               ToIbInst5Pc        ,
    output         wire           [`InstAddrBus]               ToIbInst5Redir     ,
    output         wire           [`InstDateBus]               ToIbInst5Date      , 
    output         wire                                        ToIbInst6Able      ,
    output         wire                                        ToIbInst6Mode      ,
    output         wire           [`InstAddrBus]               ToIbInst6Pc        ,
    output         wire           [`InstAddrBus]               ToIbInst6Redir     ,
    output         wire           [`InstDateBus]               ToIbInst6Date      , 
    output         wire                                        ToIbInst7Able      ,
    output         wire                                        ToIbInst7Mode      ,
    output         wire           [`InstAddrBus]               ToIbInst7Pc        ,
    output         wire           [`InstAddrBus]               ToIbInst7Redir     ,
    output         wire           [`InstDateBus]               ToIbInst7Date      , 
    output         wire                                        ToIbInst8Able      ,
    output         wire                                        ToIbInst8Mode      ,
    output         wire           [`InstAddrBus]               ToIbInst8Pc        ,
    output         wire           [`InstAddrBus]               ToIbInst8Redir     ,
    output         wire           [`InstDateBus]               ToIbInst8Date      , 

);  


    wire  [`InstDateBus] PreDecodeInst1 = FetchDate[32*8-1:32*7] ;
    wire  [`InstDateBus] PreDecodeInst2 = FetchDate[32*8-1:32*7] ;
    wire  [`InstDateBus] PreDecodeInst3 = FetchDate[32*8-1:32*7] ;
    wire  [`InstDateBus] PreDecodeInst4 = FetchDate[32*8-1:32*7] ;
    wire  [`InstDateBus] PreDecodeInst5 = FetchDate[32*8-1:32*7] ;
    wire  [`InstDateBus] PreDecodeInst6 = FetchDate[32*8-1:32*7] ;
    wire  [`InstDateBus] PreDecodeInst7 = FetchDate[32*8-1:32*7] ;
    wire  [`InstDateBus] PreDecodeInst8 = FetchDate[32*8-1:32*7] ;

    wire [2:0]          InstType[0:8] ;
    wire [`InstAddrBus] InstPc  [1:8] ;
    wire [`InstDateBus] InstPreA[1:8] ;

    assign   InstType[0] = `TypeFORMAL ;

    assign   InstType[1] = {3{((PreDecodeInst1[31:26] == 2'b010011) & (PreDecodeInst1[9:5] == 5'd1) & (PreDecodeInst1[4:0] == 5'd0))}} & `TypeRTURN   | 
                           {3{((PreDecodeInst1[31:26] == 2'b010011) & (PreDecodeInst1[4:0] == 5'd1))}}                                 & `TypeCALL    |
                           {3{((PreDecodeInst1[31:26] == 2'b010100) | (PreDecodeInst1[31:26] == 2'b010101))}}                          & `TypeDIRECTB |
                           {3{((PreDecodeInst1[31:26] == 2'b010110) | (PreDecodeInst1[31:26] == 2'b010111) | (PreDecodeInst1[31:26] == 2'b011000)     |
                               (PreDecodeInst1[31:26] == 2'b011001) | (PreDecodeInst1[31:26] == 2'b011010) | (PreDecodeInst1[31:26] == 2'b011011))}} & `TypeBRANCH ;

    assign   InstPc  [1] = FinalPc ;
    assign   InstPreA[1] = {PreDecodeInst1[9:0],PreDecodeInst1[25:10]} ;

    assign   InstType[2] = {3{((PreDecodeInst2[31:26] == 2'b010011) & (PreDecodeInst2[9:5] == 5'd1) & (PreDecodeInst2[4:0] == 5'd0))}} & `TypeRTURN   | 
                           {3{((PreDecodeInst2[31:26] == 2'b010011) & (PreDecodeInst2[4:0] == 5'd1))}}                                 & `TypeCALL    |
                           {3{((PreDecodeInst2[31:26] == 2'b010100) | (PreDecodeInst2[31:26] == 2'b010101))}}                          & `TypeDIRECTB |
                           {3{((PreDecodeInst2[31:26] == 2'b010110) | (PreDecodeInst2[31:26] == 2'b010111) | (PreDecodeInst2[31:26] == 2'b011000)     |
                               (PreDecodeInst2[31:26] == 2'b011001) | (PreDecodeInst2[31:26] == 2'b011010) | (PreDecodeInst2[31:26] == 2'b011011))}} & `TypeBRANCH ;
                            
    assign   InstPc  [2] = FinalPc+4 ;
    assign   InstPreA[2] = {PreDecodeInst2[9:0],PreDecodeInst2[25:10]} ;

    assign   InstType[3] = {3{((PreDecodeInst3[31:26] == 2'b010011) & (PreDecodeInst3[9:5] == 5'd1) & (PreDecodeInst3[4:0] == 5'd0))}} & `TypeRTURN   | 
                           {3{((PreDecodeInst3[31:26] == 2'b010011) & (PreDecodeInst3[4:0] == 5'd1))}}                                 & `TypeCALL    |
                           {3{((PreDecodeInst3[31:26] == 2'b010100) | (PreDecodeInst3[31:26] == 2'b010101))}}                          & `TypeDIRECTB |
                           {3{((PreDecodeInst3[31:26] == 2'b010110) | (PreDecodeInst3[31:26] == 2'b010111) | (PreDecodeInst3[31:26] == 2'b011000)     |
                               (PreDecodeInst3[31:26] == 2'b011001) | (PreDecodeInst3[31:26] == 2'b011010) | (PreDecodeInst3[31:26] == 2'b011011))}} & `TypeBRANCH ;

    assign   InstPc  [3] = FinalPc+8 ;
    assign   InstPreA[3] = {PreDecodeInst3[9:0],PreDecodeInst3[25:10]} ;

    assign   InstType[4] = {3{((PreDecodeInst4[31:26] == 2'b010011) & (PreDecodeInst4[9:5] == 5'd1) & (PreDecodeInst4[4:0] == 5'd0))}} & `TypeRTURN   | 
                           {3{((PreDecodeInst4[31:26] == 2'b010011) & (PreDecodeInst4[4:0] == 5'd1))}}                                 & `TypeCALL    |
                           {3{((PreDecodeInst4[31:26] == 2'b010100) | (PreDecodeInst4[31:26] == 2'b010101))}}                          & `TypeDIRECTB |
                           {3{((PreDecodeInst4[31:26] == 2'b010110) | (PreDecodeInst4[31:26] == 2'b010111) | (PreDecodeInst4[31:26] == 2'b011000)     |
                               (PreDecodeInst4[31:26] == 2'b011001) | (PreDecodeInst4[31:26] == 2'b011010) | (PreDecodeInst4[31:26] == 2'b011011))}} & `TypeBRANCH ;

    assign   InstPc  [4] = FinalPc+12 ;
    assign   InstPreA[4] = {PreDecodeInst4[9:0],PreDecodeInst4[25:10]} ;

    assign   InstType[5] = {3{((PreDecodeInst5[31:26] == 2'b010011) & (PreDecodeInst5[9:5] == 5'd1) & (PreDecodeInst5[4:0] == 5'd0))}} & `TypeRTURN   | 
                           {3{((PreDecodeInst5[31:26] == 2'b010011) & (PreDecodeInst5[4:0] == 5'd1))}}                                 & `TypeCALL    |
                           {3{((PreDecodeInst5[31:26] == 2'b010100) | (PreDecodeInst5[31:26] == 2'b010101))}}                          & `TypeDIRECTB |
                           {3{((PreDecodeInst5[31:26] == 2'b010110) | (PreDecodeInst5[31:26] == 2'b010111) | (PreDecodeInst5[31:26] == 2'b011000)     |
                               (PreDecodeInst5[31:26] == 2'b011001) | (PreDecodeInst5[31:26] == 2'b011010) | (PreDecodeInst5[31:26] == 2'b011011))}} & `TypeBRANCH ;

    assign   InstPc  [5] = FinalPc+16 ;
    assign   InstPreA[5] = {PreDecodeInst5[9:0],PreDecodeInst5[25:10]} ;

    assign   InstType[6] = {3{((PreDecodeInst6[31:26] == 2'b010011) & (PreDecodeInst6[9:5] == 5'd1) & (PreDecodeInst6[4:0] == 5'd0))}} & `TypeRTURN   | 
                           {3{((PreDecodeInst6[31:26] == 2'b010011) & (PreDecodeInst6[4:0] == 5'd1))}}                                 & `TypeCALL    |
                           {3{((PreDecodeInst6[31:26] == 2'b010100) | (PreDecodeInst6[31:26] == 2'b010101))}}                          & `TypeDIRECTB |
                           {3{((PreDecodeInst6[31:26] == 2'b010110) | (PreDecodeInst6[31:26] == 2'b010111) | (PreDecodeInst6[31:26] == 2'b011000)     |
                               (PreDecodeInst6[31:26] == 2'b011001) | (PreDecodeInst6[31:26] == 2'b011010) | (PreDecodeInst6[31:26] == 2'b011011))}} & `TypeBRANCH ;

    assign   InstPc  [6] = FinalPc+20 ;
    assign   InstPreA[6] = {PreDecodeInst6[9:0],PreDecodeInst6[25:10]} ;
 
    assign   InstType[7] = {3{((PreDecodeInst7[31:26] == 2'b010011) & (PreDecodeInst7[9:5] == 5'd1) & (PreDecodeInst7[4:0] == 5'd0))}} & `TypeRTURN   | 
                           {3{((PreDecodeInst7[31:26] == 2'b010011) & (PreDecodeInst7[4:0] == 5'd1))}}                                 & `TypeCALL    |
                           {3{((PreDecodeInst7[31:26] == 2'b010100) | (PreDecodeInst7[31:26] == 2'b010101))}}                          & `TypeDIRECTB |
                           {3{((PreDecodeInst7[31:26] == 2'b010110) | (PreDecodeInst7[31:26] == 2'b010111) | (PreDecodeInst7[31:26] == 2'b011000)     |
                               (PreDecodeInst7[31:26] == 2'b011001) | (PreDecodeInst7[31:26] == 2'b011010) | (PreDecodeInst7[31:26] == 2'b011011))}} & `TypeBRANCH ;
    assign   InstPc  [7] = FinalPc+24 ;
    assign   InstPreA[7] = {PreDecodeInst7[9:0],PreDecodeInst7[25:10]} ;

    assign   InstType[8] = {3{((PreDecodeInst8[31:26] == 2'b010011) & (PreDecodeInst8[9:5] == 5'd1) & (PreDecodeInst8[4:0] == 5'd0))}} & `TypeRTURN   | 
                           {3{((PreDecodeInst8[31:26] == 2'b010011) & (PreDecodeInst8[4:0] == 5'd1))}}                                 & `TypeCALL    |
                           {3{((PreDecodeInst8[31:26] == 2'b010100) | (PreDecodeInst8[31:26] == 2'b010101))}}                          & `TypeDIRECTB |
                           {3{((PreDecodeInst8[31:26] == 2'b010110) | (PreDecodeInst8[31:26] == 2'b010111) | (PreDecodeInst8[31:26] == 2'b011000)     |
                               (PreDecodeInst8[31:26] == 2'b011001) | (PreDecodeInst8[31:26] == 2'b011010) | (PreDecodeInst8[31:26] == 2'b011011))}} & `TypeBRANCH ;
    assign   InstPc  [8] = FinalPc+28 ;
    assign   InstPreA[8] = {PreDecodeInst8[9:0],PreDecodeInst8[25:10]} ;

    wire [3:0] JumpInstNum = (InstType[1] != `TypeFORMAL) ? 4'd1 :
                             (InstType[2] != `TypeFORMAL) ? 4'd2 :
                             (InstType[3] != `TypeFORMAL) ? 4'd3 :
                             (InstType[4] != `TypeFORMAL) ? 4'd4 :
                             (InstType[5] != `TypeFORMAL) ? 4'd5 :
                             (InstType[6] != `TypeFORMAL) ? 4'd6 :
                             (InstType[7] != `TypeFORMAL) ? 4'd7 :
                             (InstType[8] != `TypeFORMAL) ? 4'd8 : 4'd0 ; 

    wire  TypeFault = (BtbType != InstType[JumpInstNum]) & BtbAble ; 
    wire  ModeFault = (InstType[JumpInstNum] == `TypeBRANCH) & TageMode & TageAble ; 
    wire  TagetFault1 = (InstType[JumpInstNum] == `TypeDIRECTB) & (InstPreA[JumpInstNum] != BtbPc) & BtbAble ; 
    wire  TagetFault2 = (InstType[JumpInstNum] == `TypeRTURN) & (InstPreA[JumpInstNum] != RasAddr) & RasAble ; 


    reg 
    always @(posedge Clk) begin
        if(!Rest) begin
            
        end
    end
    


   

endmodule
