`timescale 1ps/1ps
`include "../define.v"

module PreDecode (
    input          wire                                        Clk                ,
    input          wire                                        Rest               ,
    //in form Ctrll Block
    input          wire                                        PreDecodeFlash     ,   
    input          wire                                        PreDecodeStop      , 
    //from Btb
    input          wire                                        BtbAble            ,
    input          wire           [1:0]                        BtbBanKN           ,
    input          wire           [2:0]                        BtbType            ,
    input          wire           [`InstAddrBus]               BtbPc              ,
    //from Ras
    input          wire                                        RasAble            ,
    input          wire           [`InstAddrBus]               RasPc              ,
    //from tage
    input          wire                                        TageAble           ,
    input          wire                                        TageMode           ,
    input          wire           [2:0]                        TageJdate          ,
    input          wire           [2:0]                        TageNum            ,
    input          wire           [2:0]                        TageInt1           ,
    input          wire           [2:0]                        TageInt2           ,
    input          wire           [2:0]                        TageInt3           ,
    input          wire           [2:0]                        TageInt4           ,
    input          wire           [2:0]                        TageInt5           ,
    input          wire           [2:0]                        TageInt6           ,
    //from Icache 
    input          wire                                        FetchAble          ,
    input          wire           [255:0]                      FetchPcIvt         ,
    input          wire           [7:0]                        FetchInstIvt       ,
    input          wire           [255:0]                      FetchDate          ,
    //to pc 
    output         wire                                        PreReDirectAble    ,
    output         wire           [`InstAddrBus]               PreReDirectPc      ,
    //to btb
    output         wire                                        BtbUpPcAble        ,
    output         wire           [`InstAddrBus]               BtbUpPc            ,
    output         wire           [1:0]                        BtbUpBanKN         ,
    output         wire                                        BtbUpTypeAble      ,
    output         wire           [2:0]                        BtbUpType          ,
    output         wire                                        BtbUpTagetAble     ,
    output         wire           [`InstAddrBus]               BtbUpTaget         ,
    //to ras
    output         wire                                        RasUpAble          ,
    output         wire           [1:0]                        RasPtrType         ,
    output         wire           [`InstAddrBus]               RasAddrDate        ,
    //to tage      
    output         wire                                        TageUpAble         ,
    //to ftq
    output         wire                                        PredAble           ,
    output         wire           [2:0]                        PredJdate          ,
    output         wire           [2:0]                        PredNum            ,
    output         wire           [2:0]                        PredInt1           ,
    output         wire           [2:0]                        PredInt2           ,
    output         wire           [2:0]                        PredInt3           ,
    output         wire           [2:0]                        PredInt4           ,
    output         wire           [2:0]                        PredInt5           ,
    output         wire           [2:0]                        PredInt6           ,
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
    output         wire           [`InstDateBus]               ToIbInst8Date      
);  


    wire  [`InstDateBus] PreDecodeInst1 = FetchDate[32*8-1:32*7] ;
    wire  [`InstDateBus] PreDecodeInst2 = FetchDate[32*7-1:32*6] ;
    wire  [`InstDateBus] PreDecodeInst3 = FetchDate[32*6-1:32*5] ;
    wire  [`InstDateBus] PreDecodeInst4 = FetchDate[32*5-1:32*4] ;
    wire  [`InstDateBus] PreDecodeInst5 = FetchDate[32*4-1:32*3] ;
    wire  [`InstDateBus] PreDecodeInst6 = FetchDate[32*3-1:32*2] ;
    wire  [`InstDateBus] PreDecodeInst7 = FetchDate[32*2-1:32*1] ;
    wire  [`InstDateBus] PreDecodeInst8 = FetchDate[32*1-1:0] ;

    wire [`InstAddrBus] InstPc  [1:8] ;

    assign InstPc[1] = FetchPcIvt[32*8-1:32*7] ;
    assign InstPc[2] = FetchPcIvt[32*7-1:32*6] ;
    assign InstPc[3] = FetchPcIvt[32*6-1:32*5] ;
    assign InstPc[4] = FetchPcIvt[32*5-1:32*4] ;
    assign InstPc[5] = FetchPcIvt[32*4-1:32*3] ;
    assign InstPc[6] = FetchPcIvt[32*3-1:32*2] ;
    assign InstPc[7] = FetchPcIvt[32*2-1:32*1] ;
    assign InstPc[8] = FetchPcIvt[32*1-1:0] ;

    wire [2:0]          InstType[0:8] ;
    wire [25:0]         InstPreA[1:8] ;

    assign   InstType[0] = `TypeFORMAL ;

    assign   InstType[1] = {3{((PreDecodeInst1[31:26] == 6'b010011) & (PreDecodeInst1[9:5] == 5'd1) & (PreDecodeInst1[4:0] == 5'd0))}} & `TypeRTURN   | 
                           {3{((PreDecodeInst1[31:26] == 6'b010011) & (PreDecodeInst1[4:0] == 5'd1))}}                                 & `TypeCALL    |
                           {3{((PreDecodeInst1[31:26] == 6'b010100) | (PreDecodeInst1[31:26] == 6'b010101))}}                          & `TypeDIRECTB |
                           {3{((PreDecodeInst1[31:26] == 6'b010110) | (PreDecodeInst1[31:26] == 6'b010111) | (PreDecodeInst1[31:26] == 6'b011000)     |
                               (PreDecodeInst1[31:26] == 6'b011001) | (PreDecodeInst1[31:26] == 6'b011010) | (PreDecodeInst1[31:26] == 6'b011011))}} & `TypeBRANCH ;

    assign   InstPreA[1] = {PreDecodeInst1[9:0],PreDecodeInst1[25:10]} ;

    assign   InstType[2] = {3{((PreDecodeInst2[31:26] == 6'b010011) & (PreDecodeInst2[9:5] == 5'd1) & (PreDecodeInst2[4:0] == 5'd0))}} & `TypeRTURN   | 
                           {3{((PreDecodeInst2[31:26] == 6'b010011) & (PreDecodeInst2[4:0] == 5'd1))}}                                 & `TypeCALL    |
                           {3{((PreDecodeInst2[31:26] == 6'b010100) | (PreDecodeInst2[31:26] == 6'b010101))}}                          & `TypeDIRECTB |
                           {3{((PreDecodeInst2[31:26] == 6'b010110) | (PreDecodeInst2[31:26] == 6'b010111) | (PreDecodeInst2[31:26] == 6'b011000)     |
                               (PreDecodeInst2[31:26] == 6'b011001) | (PreDecodeInst2[31:26] == 6'b011010) | (PreDecodeInst2[31:26] == 6'b011011))}} & `TypeBRANCH ;
                            
    assign   InstPreA[2] = {PreDecodeInst2[9:0],PreDecodeInst2[25:10]} ;

    assign   InstType[3] = {3{((PreDecodeInst3[31:26] == 6'b010011) & (PreDecodeInst3[9:5] == 5'd1) & (PreDecodeInst3[4:0] == 5'd0))}} & `TypeRTURN   | 
                           {3{((PreDecodeInst3[31:26] == 6'b010011) & (PreDecodeInst3[4:0] == 5'd1))}}                                 & `TypeCALL    |
                           {3{((PreDecodeInst3[31:26] == 6'b010100) | (PreDecodeInst3[31:26] == 6'b010101))}}                          & `TypeDIRECTB |
                           {3{((PreDecodeInst3[31:26] == 6'b010110) | (PreDecodeInst3[31:26] == 6'b010111) | (PreDecodeInst3[31:26] == 6'b011000)     |
                               (PreDecodeInst3[31:26] == 6'b011001) | (PreDecodeInst3[31:26] == 6'b011010) | (PreDecodeInst3[31:26] == 6'b011011))}} & `TypeBRANCH ;

    assign   InstPreA[3] = {PreDecodeInst3[9:0],PreDecodeInst3[25:10]} ;

    assign   InstType[4] = {3{((PreDecodeInst4[31:26] == 6'b010011) & (PreDecodeInst4[9:5] == 5'd1) & (PreDecodeInst4[4:0] == 5'd0))}} & `TypeRTURN   | 
                           {3{((PreDecodeInst4[31:26] == 6'b010011) & (PreDecodeInst4[4:0] == 5'd1))}}                                 & `TypeCALL    |
                           {3{((PreDecodeInst4[31:26] == 6'b010100) | (PreDecodeInst4[31:26] == 6'b010101))}}                          & `TypeDIRECTB |
                           {3{((PreDecodeInst4[31:26] == 6'b010110) | (PreDecodeInst4[31:26] == 6'b010111) | (PreDecodeInst4[31:26] == 6'b011000)     |
                               (PreDecodeInst4[31:26] == 6'b011001) | (PreDecodeInst4[31:26] == 6'b011010) | (PreDecodeInst4[31:26] == 6'b011011))}} & `TypeBRANCH ;

    assign   InstPreA[4] = {PreDecodeInst4[9:0],PreDecodeInst4[25:10]} ;

    assign   InstType[5] = {3{((PreDecodeInst5[31:26] == 6'b010011) & (PreDecodeInst5[9:5] == 5'd1) & (PreDecodeInst5[4:0] == 5'd0))}} & `TypeRTURN   | 
                           {3{((PreDecodeInst5[31:26] == 6'b010011) & (PreDecodeInst5[4:0] == 5'd1))}}                                 & `TypeCALL    |
                           {3{((PreDecodeInst5[31:26] == 6'b010100) | (PreDecodeInst5[31:26] == 6'b010101))}}                          & `TypeDIRECTB |
                           {3{((PreDecodeInst5[31:26] == 6'b010110) | (PreDecodeInst5[31:26] == 6'b010111) | (PreDecodeInst5[31:26] == 6'b011000)     |
                               (PreDecodeInst5[31:26] == 6'b011001) | (PreDecodeInst5[31:26] == 6'b011010) | (PreDecodeInst5[31:26] == 6'b011011))}} & `TypeBRANCH ;
    assign   InstPreA[5] = {PreDecodeInst5[9:0],PreDecodeInst5[25:10]} ;

    assign   InstType[6] = {3{((PreDecodeInst6[31:26] == 6'b010011) & (PreDecodeInst6[9:5] == 5'd1) & (PreDecodeInst6[4:0] == 5'd0))}} & `TypeRTURN   | 
                           {3{((PreDecodeInst6[31:26] == 6'b010011) & (PreDecodeInst6[4:0] == 5'd1))}}                                 & `TypeCALL    |
                           {3{((PreDecodeInst6[31:26] == 6'b010100) | (PreDecodeInst6[31:26] == 6'b010101))}}                          & `TypeDIRECTB |
                           {3{((PreDecodeInst6[31:26] == 6'b010110) | (PreDecodeInst6[31:26] == 6'b010111) | (PreDecodeInst6[31:26] == 6'b011000)     |
                               (PreDecodeInst6[31:26] == 6'b011001) | (PreDecodeInst6[31:26] == 6'b011010) | (PreDecodeInst6[31:26] == 6'b011011))}} & `TypeBRANCH ;

    assign   InstPreA[6] = {PreDecodeInst6[9:0],PreDecodeInst6[25:10]} ;
 
    assign   InstType[7] = {3{((PreDecodeInst7[31:26] == 6'b010011) & (PreDecodeInst7[9:5] == 5'd1) & (PreDecodeInst7[4:0] == 5'd0))}} & `TypeRTURN   | 
                           {3{((PreDecodeInst7[31:26] == 6'b010011) & (PreDecodeInst7[4:0] == 5'd1))}}                                 & `TypeCALL    |
                           {3{((PreDecodeInst7[31:26] == 6'b010100) | (PreDecodeInst7[31:26] == 6'b010101))}}                          & `TypeDIRECTB |
                           {3{((PreDecodeInst7[31:26] == 6'b010110) | (PreDecodeInst7[31:26] == 6'b010111) | (PreDecodeInst7[31:26] == 6'b011000)     |
                               (PreDecodeInst7[31:26] == 6'b011001) | (PreDecodeInst7[31:26] == 6'b011010) | (PreDecodeInst7[31:26] == 6'b011011))}} & `TypeBRANCH ;
    assign   InstPreA[7] = {PreDecodeInst7[9:0],PreDecodeInst7[25:10]} ;

    assign   InstType[8] = {3{((PreDecodeInst8[31:26] == 6'b010011) & (PreDecodeInst8[9:5] == 5'd1) & (PreDecodeInst8[4:0] == 5'd0))}} & `TypeRTURN   | 
                           {3{((PreDecodeInst8[31:26] == 6'b010011) & (PreDecodeInst8[4:0] == 5'd1))}}                                 & `TypeCALL    |
                           {3{((PreDecodeInst8[31:26] == 6'b010100) | (PreDecodeInst8[31:26] == 6'b010101))}}                          & `TypeDIRECTB |
                           {3{((PreDecodeInst8[31:26] == 6'b010110) | (PreDecodeInst8[31:26] == 6'b010111) | (PreDecodeInst8[31:26] == 6'b011000)     |
                               (PreDecodeInst8[31:26] == 6'b011001) | (PreDecodeInst8[31:26] == 6'b011010) | (PreDecodeInst8[31:26] == 6'b011011))}} & `TypeBRANCH ;
    assign   InstPreA[8] = {PreDecodeInst8[9:0],PreDecodeInst8[25:10]} ;

    wire [3:0] JumpInstNum = ((InstType[1] != `TypeFORMAL) | ~FetchInstIvt[1]) ? 4'd1 :
                             ((InstType[2] != `TypeFORMAL) | ~FetchInstIvt[2]) ? 4'd2 :
                             ((InstType[3] != `TypeFORMAL) | ~FetchInstIvt[3]) ? 4'd3 :
                             ((InstType[4] != `TypeFORMAL) | ~FetchInstIvt[4]) ? 4'd4 :
                             ((InstType[5] != `TypeFORMAL) | ~FetchInstIvt[5]) ? 4'd5 :
                             ((InstType[6] != `TypeFORMAL) | ~FetchInstIvt[6]) ? 4'd6 :
                             ((InstType[7] != `TypeFORMAL) | ~FetchInstIvt[7]) ? 4'd7 :
                             ((InstType[8] != `TypeFORMAL) ) ? 4'd8 : 4'd0 ; 

    wire  TypeFault = (BtbType != InstType[JumpInstNum]) & BtbAble ; 
    wire  TagetFault1 = (InstType[JumpInstNum] == `TypeDIRECTB) & (({6'd0,InstPreA[JumpInstNum]} + InstPc[JumpInstNum]  != BtbPc)) & BtbAble ;   // use update 
    wire  TagetFault2 = (InstType[JumpInstNum] == `TypeRTURN)   & (RasPc != BtbPc) & RasAble & BtbAble ; 
    wire  TagetFault3 = (InstType[JumpInstNum] == `TypeBRANCH)  & (({16'd0,InstPreA[JumpInstNum][15:0]} + InstPc[JumpInstNum] != BtbPc) & TageMode) & TageAble & BtbAble ; 
    wire  TagetFault4 = (InstType[JumpInstNum] == `TypeBRANCH)  & ((32'd4 + InstPc[JumpInstNum] != BtbPc) & ~TageMode) & TageAble & BtbAble ;
    wire  TagetFault5 = (InstType[JumpInstNum] == `TypeFORMAL)  & (({InstPc[JumpInstNum][31:5],5'd0} + 32'd32) != BtbPc) & BtbAble ;

    wire [`InstAddrBus] ReviseAddr ={32{TagetFault1}} & ({6'd0,InstPreA[JumpInstNum]} + InstPc[JumpInstNum]) | 
                                    {32{TagetFault2}} & RasPc                 |
                                    {32{TagetFault3}} & ({16'd0,InstPreA[JumpInstNum][15:0]} + InstPc[JumpInstNum])  |
                                    {32{TagetFault4}} & (32'd4 + InstPc[JumpInstNum])  | 
                                    {32{TagetFault5}} & ({InstPc[JumpInstNum][31:5],5'd0} + 32'd32); 


    reg                  RegPreReDirectAble  ;
    reg [`InstAddrBus]   RegPreReDirectPc    ;
    reg                  RegBtbUpPcAble      ;
    reg [`InstAddrBus]   RegBtbUpPc          ;
    reg [1:0]            RegBtbUpBanKN       ;
    reg                  RegBtbUpTypeAble    ;
    reg [2:0]            RegBtbUpType        ;
    reg                  RegBtbUpTagetAble   ;
    reg [`InstAddrBus]   RegBtbUpTaget       ;
    reg                  RegRasUpAble        ;
    reg [1:0]            RegRasPtrType       ;
    reg [`InstAddrBus]   RegRasAddrDate      ;
    reg                  RegTageUpAble       ;
    reg                  RegPredAble         ;
    reg [2:0]            RegPredJdate        ;
    reg [2:0]            RegPredNum          ;
    reg [2:0]            RegPredInt1         ;
    reg [2:0]            RegPredInt2         ;
    reg [2:0]            RegPredInt3         ;
    reg [2:0]            RegPredInt4         ;
    reg [2:0]            RegPredInt5         ;
    reg [2:0]            RegPredInt6         ;
    reg                  RToIbInst1Able      ;
    reg                  RToIbInst1Mode      ;
    reg [`InstAddrBus]   RToIbInst1Pc        ;
    reg [`InstAddrBus]   RToIbInst1Redir     ;
    reg [`InstDateBus]   RToIbInst1Date      ;
    reg                  RToIbInst2Able      ;
    reg                  RToIbInst2Mode      ;
    reg [`InstAddrBus]   RToIbInst2Pc        ;
    reg [`InstAddrBus]   RToIbInst2Redir     ;
    reg [`InstDateBus]   RToIbInst2Date      ;
    reg                  RToIbInst3Able      ;
    reg                  RToIbInst3Mode      ;
    reg [`InstAddrBus]   RToIbInst3Pc        ;
    reg [`InstAddrBus]   RToIbInst3Redir     ;
    reg [`InstDateBus]   RToIbInst3Date      ;
    reg                  RToIbInst4Able      ;
    reg                  RToIbInst4Mode      ;
    reg [`InstAddrBus]   RToIbInst4Pc        ;
    reg [`InstAddrBus]   RToIbInst4Redir     ;
    reg [`InstDateBus]   RToIbInst4Date      ;
    reg                  RToIbInst5Able      ;
    reg                  RToIbInst5Mode      ;
    reg [`InstAddrBus]   RToIbInst5Pc        ;
    reg [`InstAddrBus]   RToIbInst5Redir     ;
    reg [`InstDateBus]   RToIbInst5Date      ;
    reg                  RToIbInst6Able      ;
    reg                  RToIbInst6Mode      ;
    reg [`InstAddrBus]   RToIbInst6Pc        ;
    reg [`InstAddrBus]   RToIbInst6Redir     ;
    reg [`InstDateBus]   RToIbInst6Date      ;
    reg                  RToIbInst7Able      ;
    reg                  RToIbInst7Mode      ;
    reg [`InstAddrBus]   RToIbInst7Pc        ;
    reg [`InstAddrBus]   RToIbInst7Redir     ;
    reg [`InstDateBus]   RToIbInst7Date      ;
    reg                  RToIbInst8Able      ;
    reg                  RToIbInst8Mode      ;
    reg [`InstAddrBus]   RToIbInst8Pc        ;
    reg [`InstAddrBus]   RToIbInst8Redir     ;
    reg [`InstDateBus]   RToIbInst8Date      ;

    always @(posedge Clk) begin
        if(!Rest) begin
            RegPreReDirectAble  <= `EnableValue ;
            RegPreReDirectPc    <= `ZeorDate    ;
            RegBtbUpPcAble      <= `EnableValue ;
            RegBtbUpPc          <= `ZeorDate    ;
            RegBtbUpBanKN       <= 2'b0         ;
            RegBtbUpTypeAble    <= `EnableValue ;
            RegBtbUpType        <= 3'd0         ;
            RegBtbUpTagetAble   <= `EnableValue ;
            RegBtbUpTaget       <= `ZeorDate    ;
            RegRasUpAble        <= `EnableValue ;
            RegRasPtrType       <= 2'b0         ;
            RegRasAddrDate      <= `ZeorDate    ;
            RegTageUpAble       <= `EnableValue ;
            RegPredAble         <= `EnableValue ;
            RegPredJdate        <= 3'd0         ;
            RegPredNum          <= 3'd0         ;
            RegPredInt1         <= 3'd0         ;
            RegPredInt2         <= 3'd0         ;
            RegPredInt3         <= 3'd0         ;
            RegPredInt4         <= 3'd0         ;
            RegPredInt5         <= 3'd0         ;
            RegPredInt6         <= 3'd0         ;
            RToIbInst1Able      <= `EnableValue ;
            RToIbInst1Mode      <= `EnableValue ;
            RToIbInst1Pc        <= `ZeorDate    ;
            RToIbInst1Redir     <= `ZeorDate    ;
            RToIbInst1Date      <= `ZeorDate    ;
            RToIbInst2Able      <= `EnableValue ;
            RToIbInst2Mode      <= `EnableValue ;
            RToIbInst2Pc        <= `ZeorDate    ;
            RToIbInst2Redir     <= `ZeorDate    ;
            RToIbInst2Date      <= `ZeorDate    ;
            RToIbInst3Able      <= `EnableValue ;
            RToIbInst3Mode      <= `EnableValue ;
            RToIbInst3Pc        <= `ZeorDate    ;
            RToIbInst3Redir     <= `ZeorDate    ;
            RToIbInst3Date      <= `ZeorDate    ;
            RToIbInst4Able      <= `EnableValue ;
            RToIbInst4Mode      <= `EnableValue ;
            RToIbInst4Pc        <= `ZeorDate    ;
            RToIbInst4Redir     <= `ZeorDate    ;
            RToIbInst4Date      <= `ZeorDate    ;
            RToIbInst5Able      <= `EnableValue ;
            RToIbInst5Mode      <= `EnableValue ;
            RToIbInst5Pc        <= `ZeorDate    ;
            RToIbInst5Redir     <= `ZeorDate    ;
            RToIbInst5Date      <= `ZeorDate    ;
            RToIbInst6Able      <= `EnableValue ;
            RToIbInst6Mode      <= `EnableValue ;
            RToIbInst6Pc        <= `ZeorDate    ;
            RToIbInst6Redir     <= `ZeorDate    ;
            RToIbInst6Date      <= `ZeorDate    ;
            RToIbInst7Able      <= `EnableValue ;
            RToIbInst7Mode      <= `EnableValue ;
            RToIbInst7Pc        <= `ZeorDate    ;
            RToIbInst7Redir     <= `ZeorDate    ;
            RToIbInst7Date      <= `ZeorDate    ;
            RToIbInst8Able      <= `EnableValue ;
            RToIbInst8Mode      <= `EnableValue ;
            RToIbInst8Pc        <= `ZeorDate    ;
            RToIbInst8Redir     <= `ZeorDate    ;
            RToIbInst8Date      <= `ZeorDate    ;
        end
        else if(PreDecodeStop) begin
            RegPreReDirectAble  <= RegPreReDirectAble ;
            RegPreReDirectPc    <= RegPreReDirectPc   ;
            RegBtbUpPcAble      <= RegBtbUpPcAble     ;
            RegBtbUpPc          <= RegBtbUpPc         ;
            RegBtbUpBanKN       <= RegBtbUpBanKN      ;
            RegBtbUpTypeAble    <= RegBtbUpTypeAble   ;
            RegBtbUpType        <= RegBtbUpType       ;
            RegBtbUpTagetAble   <= RegBtbUpTagetAble  ;
            RegBtbUpTaget       <= RegBtbUpTaget      ;
            RegRasUpAble        <= RegRasUpAble       ;
            RegRasPtrType       <= RegRasPtrType      ;
            RegRasAddrDate      <= RegRasAddrDate     ;
            RegTageUpAble       <= RegTageUpAble      ;
            RegPredAble         <= RegPredAble        ;
            RegPredJdate        <= RegPredJdate       ;
            RegPredNum          <= RegPredNum         ;
            RegPredInt1         <= RegPredInt1        ;
            RegPredInt2         <= RegPredInt2        ;
            RegPredInt3         <= RegPredInt3        ;
            RegPredInt4         <= RegPredInt4        ;
            RegPredInt5         <= RegPredInt5        ;
            RegPredInt6         <= RegPredInt6        ;
            RToIbInst1Mode      <= RToIbInst1Able     ;
            RToIbInst1Pc        <= RToIbInst1Pc       ;
            RToIbInst1Redir     <= RToIbInst1Redir    ;
            RToIbInst1Date      <= RToIbInst1Date     ;
            RToIbInst2Able      <= RToIbInst2Able     ;
            RToIbInst2Mode      <= RToIbInst2Mode     ;
            RToIbInst2Pc        <= RToIbInst2Pc       ;
            RToIbInst2Redir     <= RToIbInst2Redir    ;
            RToIbInst2Date      <= RToIbInst2Date     ;
            RToIbInst3Able      <= RToIbInst3Able     ;
            RToIbInst3Mode      <= RToIbInst3Mode     ;
            RToIbInst3Pc        <= RToIbInst3Pc       ;
            RToIbInst3Date      <= RToIbInst3Date     ;
            RToIbInst4Able      <= RToIbInst4Able     ;
            RToIbInst4Mode      <= RToIbInst4Mode     ;
            RToIbInst4Pc        <= RToIbInst4Pc       ;
            RToIbInst4Redir     <= RToIbInst4Redir    ;
            RToIbInst4Date      <= RToIbInst4Date     ;
            RToIbInst5Able      <= RToIbInst5Able     ;
            RToIbInst5Mode      <= RToIbInst5Mode     ;
            RToIbInst5Pc        <= RToIbInst5Pc       ;
            RToIbInst5Redir     <= RToIbInst5Redir    ;
            RToIbInst5Date      <= RToIbInst5Date     ;
            RToIbInst6Able      <= RToIbInst6Able     ;
            RToIbInst6Mode      <= RToIbInst6Mode     ;
            RToIbInst6Pc        <= RToIbInst6Pc       ;
            RToIbInst6Redir     <= RToIbInst6Redir    ;
            RToIbInst6Date      <= RToIbInst6Date     ;
            RToIbInst7Able      <= RToIbInst7Able     ;
            RToIbInst7Mode      <= RToIbInst7Mode     ;
            RToIbInst7Pc        <= RToIbInst7Pc       ;
            RToIbInst7Redir     <= RToIbInst7Redir    ;
            RToIbInst7Date      <= RToIbInst7Date     ;
            RToIbInst8Able      <= RToIbInst8Able     ;
            RToIbInst8Mode      <= RToIbInst8Mode     ;
            RToIbInst8Pc        <= RToIbInst8Pc       ;
            RToIbInst8Redir     <= RToIbInst8Redir    ;
            RToIbInst8Date      <= RToIbInst8Date     ;
        end
        else if(PreDecodeFlash) begin
            RegPreReDirectAble  <= `EnableValue ;
            RegPreReDirectPc    <= `ZeorDate    ;
            RegBtbUpPcAble      <= `EnableValue ;
            RegBtbUpPc          <= `ZeorDate    ;
            RegBtbUpBanKN       <= 2'b0         ;
            RegBtbUpTypeAble    <= `EnableValue ;
            RegBtbUpType        <= 3'd0         ;
            RegBtbUpTagetAble   <= `EnableValue ;
            RegBtbUpTaget       <= `ZeorDate    ;
            RegRasUpAble        <= `EnableValue ;
            RegRasPtrType       <= 2'b0         ;
            RegRasAddrDate      <= `ZeorDate    ;
            RegTageUpAble       <= `EnableValue ;
            RegPredAble         <= `EnableValue ;
            RegPredJdate        <= 3'd0         ;
            RegPredNum          <= 3'd0         ;
            RegPredInt1         <= 3'd0         ;
            RegPredInt2         <= 3'd0         ;
            RegPredInt3         <= 3'd0         ;
            RegPredInt4         <= 3'd0         ;
            RegPredInt5         <= 3'd0         ;
            RegPredInt6         <= 3'd0         ;
            RToIbInst1Able      <= `EnableValue ;
            RToIbInst1Mode      <= `EnableValue ;
            RToIbInst1Pc        <= `ZeorDate    ;
            RToIbInst1Redir     <= `ZeorDate    ;
            RToIbInst1Date      <= `ZeorDate    ;
            RToIbInst2Able      <= `EnableValue ;
            RToIbInst2Mode      <= `EnableValue ;
            RToIbInst2Pc        <= `ZeorDate    ;
            RToIbInst2Redir     <= `ZeorDate    ;
            RToIbInst2Date      <= `ZeorDate    ;
            RToIbInst3Able      <= `EnableValue ;
            RToIbInst3Mode      <= `EnableValue ;
            RToIbInst3Pc        <= `ZeorDate    ;
            RToIbInst3Redir     <= `ZeorDate    ;
            RToIbInst3Date      <= `ZeorDate    ;
            RToIbInst4Able      <= `EnableValue ;
            RToIbInst4Mode      <= `EnableValue ;
            RToIbInst4Pc        <= `ZeorDate    ;
            RToIbInst4Redir     <= `ZeorDate    ;
            RToIbInst4Date      <= `ZeorDate    ;
            RToIbInst5Able      <= `EnableValue ;
            RToIbInst5Mode      <= `EnableValue ;
            RToIbInst5Pc        <= `ZeorDate    ;
            RToIbInst5Redir     <= `ZeorDate    ;
            RToIbInst5Date      <= `ZeorDate    ;
            RToIbInst6Able      <= `EnableValue ;
            RToIbInst6Mode      <= `EnableValue ;
            RToIbInst6Pc        <= `ZeorDate    ;
            RToIbInst6Redir     <= `ZeorDate    ;
            RToIbInst6Date      <= `ZeorDate    ;
            RToIbInst7Able      <= `EnableValue ;
            RToIbInst7Mode      <= `EnableValue ;
            RToIbInst7Pc        <= `ZeorDate    ;
            RToIbInst7Redir     <= `ZeorDate    ;
            RToIbInst7Date      <= `ZeorDate    ;
            RToIbInst8Able      <= `EnableValue ;
            RToIbInst8Mode      <= `EnableValue ;
            RToIbInst8Pc        <= `ZeorDate    ;
            RToIbInst8Redir     <= `ZeorDate    ;
            RToIbInst8Date      <= `ZeorDate    ;
        end
        else if(FetchAble) begin

            RegPreReDirectAble <= TagetFault1 | TagetFault2 | TagetFault3 | TagetFault4 | TagetFault5; 
            RegPreReDirectPc   <= ReviseAddr                                                         ;
            RegBtbUpPcAble     <= TypeFault | TagetFault1 | TagetFault2 | TagetFault3 | TagetFault4 | TagetFault5  ;
            RegBtbUpPc         <= InstPc[1]                                                          ;
            //RegBtbUpOfs        <= 
            RegBtbUpBanKN      <= BtbBanKN                                                           ;
            RegBtbUpTypeAble   <= TypeFault                                                          ;
            RegBtbUpType       <= InstType[JumpInstNum]                                              ;
            RegBtbUpTagetAble  <= TagetFault1 | TagetFault2 | TagetFault3 | TagetFault4 | TagetFault5;
            RegBtbUpTaget      <= ReviseAddr                                                         ;
            RegRasUpAble       <= ((BtbType == `TypeCALL) & (InstType[JumpInstNum] != `TypeCALL)) | ((BtbType == `TypeRTURN) & (InstType[JumpInstNum] != `TypeRTURN)) ;
            RegRasPtrType      <= {2{((BtbType == `TypeCALL)  & (InstType[JumpInstNum] != `TypeCALL))}}  & 2'b01 |   // 2'b01 mean ptr sub 1
                                  {2{((BtbType == `TypeRTURN) & (InstType[JumpInstNum] != `TypeRTURN))}} & 2'b10 ;   // 2'b10 mean ptr add 1.  2'b00 no operate
            RegRasAddrDate     <= RasPc                                                              ;
            RegTageUpAble      <= (BtbType == `TypeBRANCH) & (InstType[JumpInstNum] != `TypeBRANCH);

            RegPredAble        <= (InstType[JumpInstNum] == `TypeBRANCH) & TageAble ;
            RegPredJdate       <= TageJdate         ;
            RegPredNum         <= TageNum           ;
            RegPredInt1        <= TageInt1          ;
            RegPredInt2        <= TageInt2          ;
            RegPredInt3        <= TageInt3          ;
            RegPredInt4        <= TageInt4          ;
            RegPredInt5        <= TageInt5          ;
            RegPredInt6        <= TageInt6          ;

            RToIbInst1Able <=  (JumpInstNum == 4'd1) | (JumpInstNum == 4'd2) | (JumpInstNum == 4'd3) | (JumpInstNum == 4'd4) |
                               (JumpInstNum == 4'd5) | (JumpInstNum == 4'd6) | (JumpInstNum == 4'd7) | (JumpInstNum == 4'd8) ;
            RToIbInst1Mode <=  (InstType[1] != `TypeFORMAL) ? (TageMode & TageAble) : `EnableValue ;
            RToIbInst1Pc   <=  InstPc[1]  ;
            RToIbInst1Redir<=  (InstType[1] != `TypeFORMAL) ? ((TagetFault1 | TagetFault2 | TagetFault3 | TagetFault4 | TagetFault5) ? ReviseAddr : BtbPc) : `ZeorDate ;
            RToIbInst1Date <=  PreDecodeInst1;
            RToIbInst2Able <=  (JumpInstNum == 4'd2) | (JumpInstNum == 4'd3) | (JumpInstNum == 4'd4) |
                               (JumpInstNum == 4'd5) | (JumpInstNum == 4'd6) | (JumpInstNum == 4'd7) | (JumpInstNum == 4'd8) ;
            RToIbInst2Mode <=  (InstType[2] != `TypeFORMAL) ? (TageMode & TageAble) : `EnableValue ;
            RToIbInst2Pc   <=  InstPc[2]  ;
            RToIbInst2Redir<=  (InstType[2] != `TypeFORMAL) ? ((TagetFault1 | TagetFault2 | TagetFault3 | TagetFault4 | TagetFault5) ? ReviseAddr : BtbPc) : `ZeorDate ;
            RToIbInst2Date <=  PreDecodeInst2;
            RToIbInst3Able <=  (JumpInstNum == 4'd3) | (JumpInstNum == 4'd4) |
                               (JumpInstNum == 4'd5) | (JumpInstNum == 4'd6) | (JumpInstNum == 4'd7) | (JumpInstNum == 4'd8) ;
            RToIbInst3Mode <=  (InstType[3] != `TypeFORMAL) ? (TageMode & TageAble) : `EnableValue ;
            RToIbInst3Pc   <=  InstPc[3]  ;
            RToIbInst3Redir<=  (InstType[3] != `TypeFORMAL) ? ((TagetFault1 | TagetFault2 | TagetFault3 | TagetFault4 | TagetFault5) ? ReviseAddr : BtbPc) : `ZeorDate ;
            RToIbInst3Date <=  PreDecodeInst3;
            RToIbInst4Able <=  (JumpInstNum == 4'd4) |
                               (JumpInstNum == 4'd5) | (JumpInstNum == 4'd6) | (JumpInstNum == 4'd7) | (JumpInstNum == 4'd8) ;
            RToIbInst4Mode <=  (InstType[4] != `TypeFORMAL) ? (TageMode & TageAble) : `EnableValue ;
            RToIbInst4Pc   <=  InstPc[4]  ;
            RToIbInst4Redir<=  (InstType[4] != `TypeFORMAL) ? ((TagetFault1 | TagetFault2 | TagetFault3 | TagetFault4 | TagetFault5) ? ReviseAddr : BtbPc) : `ZeorDate ;
            RToIbInst4Date <=  PreDecodeInst4;
            RToIbInst5Able <=  (JumpInstNum == 4'd5) | (JumpInstNum == 4'd6) | (JumpInstNum == 4'd7) | (JumpInstNum == 4'd8) ;
            RToIbInst5Mode <=  (InstType[5] != `TypeFORMAL) ? (TageMode & TageAble) : `EnableValue ;
            RToIbInst5Pc   <=  InstPc[5]  ;
            RToIbInst5Redir<=  (InstType[5] != `TypeFORMAL) ? ((TagetFault1 | TagetFault2 | TagetFault3 | TagetFault4 | TagetFault5) ? ReviseAddr : BtbPc) : `ZeorDate ;
            RToIbInst5Date <=  PreDecodeInst5;
            RToIbInst6Able <=  (JumpInstNum == 4'd6) | (JumpInstNum == 4'd7) | (JumpInstNum == 4'd8) ;
            RToIbInst6Mode <=  (InstType[6] != `TypeFORMAL) ? (TageMode & TageAble) : `EnableValue ;
            RToIbInst6Pc   <=  InstPc[6]  ;
            RToIbInst6Redir<=  (InstType[6] != `TypeFORMAL) ? ((TagetFault1 | TagetFault2 | TagetFault3 | TagetFault4 | TagetFault5) ? ReviseAddr : BtbPc) : `ZeorDate ;
            RToIbInst6Date <=  PreDecodeInst6;
            RToIbInst7Able <=  (JumpInstNum == 4'd7) | (JumpInstNum == 4'd8) ;
            RToIbInst7Mode <=  (InstType[7] != `TypeFORMAL) ? (TageMode & TageAble) : `EnableValue ;
            RToIbInst7Pc   <=  InstPc[7]  ;
            RToIbInst7Redir<=  (InstType[7] != `TypeFORMAL) ? ((TagetFault1 | TagetFault2 | TagetFault3 | TagetFault4 | TagetFault5) ? ReviseAddr : BtbPc) : `ZeorDate ;
            RToIbInst7Date <=  PreDecodeInst7;
            RToIbInst8Able <=  (JumpInstNum == 4'd8) ;
            RToIbInst8Mode <=  (InstType[8] != `TypeFORMAL) ? (TageMode & TageAble) : `EnableValue ;
            RToIbInst8Pc   <=  InstPc[8]  ;
            RToIbInst8Redir<=  (InstType[8] != `TypeFORMAL) ? ((TagetFault1 | TagetFault2 | TagetFault3 | TagetFault4 | TagetFault5) ? ReviseAddr : BtbPc) : `ZeorDate ;
            RToIbInst8Date <=  PreDecodeInst8;
        end
    end
    
    assign PreReDirectAble = RegPreReDirectAble ;
    assign PreReDirectPc   = RegPreReDirectPc   ;
    assign BtbUpPcAble     = RegBtbUpPcAble     ;
    assign BtbUpPc         = RegBtbUpPc         ;
    assign BtbUpBanKN      = RegBtbUpBanKN      ;
    assign BtbUpTypeAble   = RegBtbUpTypeAble   ;
    assign BtbUpType       = RegBtbUpType       ;
    assign BtbUpTagetAble  = RegBtbUpTagetAble  ;
    assign BtbUpTaget      = RegBtbUpTaget      ;
    assign RasUpAble       = RegRasUpAble       ;
    assign RasPtrType      = RegRasPtrType      ;
    assign RasAddrDate     = RegRasAddrDate     ;
    assign TageUpAble      = RegTageUpAble      ;
    assign PredAble        = RegPredAble        ;
    assign PredJdate       = RegPredJdate       ;
    assign PredNum         = RegPredNum         ;
    assign PredInt1        = RegPredInt1        ;
    assign PredInt2        = RegPredInt2        ;
    assign PredInt3        = RegPredInt3        ;
    assign PredInt4        = RegPredInt4        ;
    assign PredInt5        = RegPredInt5        ;
    assign PredInt6        = RegPredInt6        ;
    assign ToIbInst1Able   = RToIbInst1Able     ;
    assign ToIbInst1Mode   = RToIbInst1Mode     ;
    assign ToIbInst1Pc     = RToIbInst1Pc       ;
    assign ToIbInst1Redir  = RToIbInst1Redir    ;
    assign ToIbInst1Date   = RToIbInst1Date     ;
    assign ToIbInst2Able   = RToIbInst2Able     ;
    assign ToIbInst2Mode   = RToIbInst2Mode     ;
    assign ToIbInst2Pc     = RToIbInst2Pc       ;
    assign ToIbInst2Redir  = RToIbInst2Redir    ;
    assign ToIbInst2Date   = RToIbInst2Date     ;
    assign ToIbInst3Able   = RToIbInst3Able     ;
    assign ToIbInst3Mode   = RToIbInst3Mode     ;
    assign ToIbInst3Pc     = RToIbInst3Pc       ;
    assign ToIbInst3Redir  = RToIbInst3Redir    ;
    assign ToIbInst3Date   = RToIbInst3Date     ;
    assign ToIbInst4Able   = RToIbInst4Able     ;
    assign ToIbInst4Mode   = RToIbInst4Mode     ;
    assign ToIbInst4Pc     = RToIbInst4Pc       ;
    assign ToIbInst4Redir  = RToIbInst4Redir    ;
    assign ToIbInst4Date   = RToIbInst4Date     ;
    assign ToIbInst5Able   = RToIbInst5Able     ;
    assign ToIbInst5Mode   = RToIbInst5Mode     ;
    assign ToIbInst5Pc     = RToIbInst5Pc       ;
    assign ToIbInst5Redir  = RToIbInst5Redir    ;
    assign ToIbInst5Date   = RToIbInst5Date     ;
    assign ToIbInst6Able   = RToIbInst6Able     ;
    assign ToIbInst6Mode   = RToIbInst6Mode     ;
    assign ToIbInst6Pc     = RToIbInst6Pc       ;
    assign ToIbInst6Redir  = RToIbInst6Redir    ;
    assign ToIbInst6Date   = RToIbInst6Date     ;
    assign ToIbInst7Able   = RToIbInst7Able     ;
    assign ToIbInst7Mode   = RToIbInst7Mode     ;
    assign ToIbInst7Pc     = RToIbInst7Pc       ;
    assign ToIbInst7Redir  = RToIbInst7Redir    ;
    assign ToIbInst7Date   = RToIbInst7Date     ;
    assign ToIbInst8Able   = RToIbInst8Able     ;
    assign ToIbInst8Mode   = RToIbInst8Mode     ;
    assign ToIbInst8Pc     = RToIbInst8Pc       ;
    assign ToIbInst8Redir  = RToIbInst8Redir    ;
    assign ToIbInst8Date   = RToIbInst8Date     ; 
   
endmodule
