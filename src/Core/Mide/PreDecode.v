`timescale 1ps/1ps
`include "define.v"

module PreDecodeBPCheck (
    input          wire                                        Clk                ,
    input          wire                                        Rest               ,
    //in form Ctrll Block
    input          wire                                        CtrllBlockFlash    ,              
    //in form FTQ
    input          wire          [`InstAddrBus]                FTQPc              ,
    input          wire          [2:0]                         FTQType            ,
    //input          wire          [2:0]                         FTQPosi            ,//经过漫长的取舍我决定舍去位置信息，在单跳转中位置信息貌似没什么收益，可能在双跳转中有较大的收益
    input          wire                                        FTQDirct           ,
    input          wire          [4:0]                         FTQPtr             ,
    //in form Icache
    input          wire                                        InstAble           ,
    input          wire          [`InstAddrBus]                InstPc             ,
    input          wire          [`FetchInstBus]               InstData           ,
    input          wire          [4:0]                         InstPtr            ,
    //input          wire                                        InstDelete         ,
    //out to FTQ
    output         wire                                        UpdataAble         ,
    output         wire                                        UpdataPcAble       ,
    output         wire          [`InstAddrBus]                UpdataPc           ,
    output         wire                                        UpdataTypeAble     ,
    output         wire          [2:0]                         UpdataType         ,
    // output         wire                                        UpdataPosiAble     ,
    // output         wire          [2:0]                         UpdataPosi         ,
    output         wire                                        UpdataDirectAble   ,
    output         wire          [4:0]                         UpFTQPtr           ,
    //out to InstBuffer
    output         wire                                        InstBufferAble     ,
    output         wire          [`InstAddrBus]                InstBufferPc       ,
    output         wire          [`FetchInstBus]               InstBufferData     ,
    output         wire          [4:0]                         InstBufferPtr      ,
    //output         wire                                        InstBufferDirct    ,
    //output         wire          [`InstAddrBus]                InstBufferDirPc    ,
    output         wire          [2:0]                         InstBufferNumb     
);

    wire       [`InstAddrBus]       InstPc1 ;
    wire       [`InstAddrBus]       InstPc2 ;
    wire       [`InstAddrBus]       InstPc3 ;
    wire       [`InstAddrBus]       InstPc4 ;
    assign InstPc1 = InstPc      ;
    assign InstPc2 = InstPc + 4  ;
    assign InstPc3 = InstPc + 8  ;
    assign InstPc4 = InstPc + 12 ; 
    wire       [`InstDateBus]       InstData1 ;
    wire       [`InstDateBus]       InstData2 ;
    wire       [`InstDateBus]       InstData3 ;
    wire       [`InstDateBus]       InstData4 ;
    assign InstData1 = InstData[31:0]   ;
    assign InstData2 = InstData[63:32]  ;  
    assign InstData3 = InstData[95:64]  ;
    assign InstData4 = InstData[127:96] ;
    wire       [2:0]                InstType  [1:4] ;

    assign InstType[1] = (InstData1[31:26] == 6'b010011) ? `TypeRTURN  :
                       (InstData1[31:26] == 6'b010100) ? `TypeDIRECTB:
                       ((InstData1[31:26] == 6'b010101) || (InstData1[9:5] == 5'b00001))  ? `TypeCALL   :
                       ((InstData1[31:26] == 6'b010010) || (InstData1[31:26] == 6'b010110) || (InstData1[31:26] == 6'b010111) || (InstData1[30:29] == 2'b11)) ? `TypeBRANCH : `TypeFALT ;
    assign InstType[2] = (InstData2[31:26] == 6'b010011) ? `TypeRTURN  :
                       (InstData2[31:26] == 6'b010100) ? `TypeDIRECTB:
                       ((InstData2[31:26] == 6'b010101) || (InstData2[9:5] == 5'b00001))  ? `TypeCALL   :
                       ((InstData2[31:26] == 6'b010010) || (InstData2[31:26] == 6'b010110) || (InstData2[31:26] == 6'b010111) || (InstData2[30:29] == 2'b11)) ? `TypeBRANCH : `TypeFALT ; 
    assign InstType[3] = (InstData3[31:26] == 6'b010011) ? `TypeRTURN  :
                       (InstData3[31:26] == 6'b010100) ? `TypeDIRECTB:
                       ((InstData3[31:26] == 6'b010101) || (InstData3[9:5] == 5'b00001))  ? `TypeCALL   :
                       ((InstData3[31:26] == 6'b010010) || (InstData3[31:26] == 6'b010110) || (InstData3[31:26] == 6'b010111) || (InstData3[30:29] == 2'b11)) ? `TypeBRANCH : `TypeFALT ;
    assign InstType[4] = (InstData4[31:26] == 6'b010011) ? `TypeRTURN  :
                       (InstData4[31:26] == 6'b010100) ? `TypeDIRECTB:
                       ((InstData4[31:26] == 6'b010101) || (InstData4[9:5] == 5'b00001))  ? `TypeCALL   :
                       ((InstData4[31:26] == 6'b010010) || (InstData4[31:26] == 6'b010110) || (InstData4[31:26] == 6'b010111) || (InstData4[30:29] == 2'b11)) ? `TypeBRANCH : `TypeFALT ;

    wire       [`InstAddrBus]      InstPredictPc  [1:4] ;
    assign InstPredictPc[1] = ((InstType[1] == `TypeDIRECTB) || (InstType[1] == `TypeCALL)) ? InstPc1 + {6'b0,InstData1[9:0],InstData1[25:10]}:
                              //(InstType[1] == `TypeRTURN)  ? FTQPc :
                              (InstType[1] == `TypeBRANCH) ? InstPc1 + {14'b0,InstData1[25:10],2'b00}: InstPc1 + 4 ;

    assign InstPredictPc[2] = ((InstType[2] == `TypeDIRECTB) || (InstType[2] == `TypeCALL)) ? InstPc2 + {6'b0,InstData2[9:0],InstData2[25:10]}:
                              //(InstType[2] == `TypeRTURN)  ? FTQPc :
                              (InstType[2] == `TypeBRANCH) ? InstPc2 + {14'b0,InstData2[25:10],2'b00}: InstPc2 + 4 ;

    assign InstPredictPc[3] = ((InstType[3] == `TypeDIRECTB) || (InstType[3] == `TypeCALL)) ? InstPc3 + {6'b0,InstData3[9:0],InstData3[25:10]}:
                              //(InstType[3] == `TypeRTURN)  ? FTQPc :
                              (InstType[3] == `TypeBRANCH) ? InstPc3 + {14'b0,InstData3[25:10],2'b00}: InstPc3 + 4 ;

    assign InstPredictPc[4] = ((InstType[4] == `TypeDIRECTB) || (InstType[4] == `TypeCALL)) ? InstPc4 + {6'b0,InstData4[9:0],InstData4[25:10]}:
                              //(InstType[4] == `TypeRTURN)  ? FTQPc :
                              (InstType[4] == `TypeBRANCH) ? InstPc4 + {14'b0,InstData4[25:10],2'b00}: InstPc4 + 4 ;

    wire   [2:0] InstPredictPosi ;
    assign InstPredictPosi  = (~(InstType[1] == `TypeFALT)) ? 3'b001 :
                              ((InstType[1] == `TypeFALT) && ~(InstType[2] == `TypeFALT)) ? 3'b010 :
                              ((InstType[1] == `TypeFALT) && (InstType[2] == `TypeFALT) && ~(InstType[3] == `TypeFALT)) ? 3'b011 :
                              ((InstType[1] == `TypeFALT) && (InstType[2] == `TypeFALT) && (InstType[3] == `TypeFALT) && ~(InstType[3] == `TypeFALT)) ? 3'b100 : 3'b100 ; 
                              
    // wire   CheckPredictPosi        ;
    // assign CheckPredictPosi  = (InstPredictPosi == FTQPosi) ? `EnableValue : `AbleValue   ;
    // wire   [2:0] PosiDataTemp      ;
    // assign PosiDataTemp      = InstPredictPosi                                            ;
    wire   CheckPredictType        ;
    assign CheckPredictType  = (InstType[InstPredictPosi] == FTQType) ? `EnableValue : `AbleValue ;
    wire   [2:0] TypeDataTemp      ;
    assign TypeDataTemp      =  InstType[InstPredictPosi] ;
    wire   CheckPredictPc    ;
    assign CheckPredictPc    = ((InstPredictPc[InstPredictPosi] == FTQPc) || (InstType[InstPredictPosi] == `TypeRTURN)) ? `EnableValue : `AbleValue;
    wire   [`InstAddrBus] PcDataTemp ; 
    assign PcDataTemp        = InstPredictPc[InstPredictPosi];
    wire   CheckPredictDirect;
    assign CheckPredictDirect= (((InstType[InstPredictPosi] == `TypeCALL) || (InstType[InstPredictPosi] == `TypeDIRECTB) || (InstType[InstPredictPosi] == `TypeRTURN)) && (FTQDirct == `EnableValue)) ? `AbleValue : `EnableValue ;

    //out to FTQ
    reg                       RegUpdataAble       ;
    reg                       RegUpdataPcAble     ;
    reg   [`InstAddrBus]      RegUpdataPc         ;
    reg                       RegUpdataTypeAble   ;
    reg   [2:0]               RegUpdataType       ;
    reg                       RegUpdataDirectAble ;
    reg   [4:0]               RegUpFTQPtr         ;
    //out to InstBuffer
    reg                       RegInstBufferAble     ;
    reg   [`InstAddrBus]      RegInstBufferPc       ;
    reg   [`FetchInstBus]     RegInstBufferData     ;
    reg   [4:0]               RegInstBufferPtr      ;
    // reg                       RegInstBufferDirct    ;
    // reg   [`InstAddrBus]      RegInstBufferDirPc    ;
    reg   [2:0]               RegInstBufferNumb     ;

    always @(posedge Clk) begin
        if(!Rest) begin
            RegUpdataAble       <= `EnableValue   ;
            RegUpdataPcAble     <= `EnableValue   ;
            RegUpdataPc         <= `ZeorDate      ;
            RegUpdataTypeAble   <= `EnableValue   ;
            RegUpdataType       <= 3'b000         ;
            RegUpdataDirectAble <= `EnableValue   ;
            RegUpFTQPtr         <= 5'b00000       ;
            RegInstBufferAble   <= `EnableValue   ;
            RegInstBufferPc     <= `ZeorDate      ;
            RegInstBufferData   <= 128'b0         ;
            RegInstBufferPtr    <= 5'b00000       ;
            // RegInstBufferDirct  <= `JumpEnbale    ;
            // RegInstBufferDirPc  <= `ZeorDate      ;
            RegInstBufferNumb   <= 3'b000         ;
        end
        else begin
            if((InstAble) && (FTQPtr == InstPtr) && ~(CtrllBlockFlash)) begin
                RegUpdataAble       <= `AbleValue         ;
                RegUpdataPcAble     <= CheckPredictPc     ;
                RegUpdataPc         <= PcDataTemp         ;
                RegUpdataTypeAble   <= CheckPredictType   ;
                RegUpdataType       <= TypeDataTemp       ;
                RegUpdataDirectAble <= CheckPredictDirect ;
                RegUpFTQPtr         <= FTQPtr             ;
                RegInstBufferAble   <= `AbleValue         ;
                RegInstBufferPc     <= InstPc             ;
                RegInstBufferData   <= InstData           ;
                RegInstBufferPtr    <= FTQPtr             ;
                // RegInstBufferDirct  <= (CheckPredictDirect | FTQDirct) ;
                // RegInstBufferDirPc  <= `ZeorDate      ;
                RegInstBufferNumb   <= InstPredictPosi    ;
            end 
            else begin
                RegUpdataAble       <= `EnableValue   ;
                RegUpdataPcAble     <= `EnableValue   ;
                RegUpdataPc         <= `ZeorDate      ;
                RegUpdataTypeAble   <= `EnableValue   ;
                RegUpdataType       <= 3'b000         ;
                RegUpdataDirectAble <= `EnableValue   ;
                RegUpFTQPtr         <= 5'b00000       ;
                RegInstBufferAble   <= `EnableValue   ;
                RegInstBufferPc     <= `ZeorDate      ;
                RegInstBufferData   <= 128'b0         ;
                RegInstBufferPtr    <= 5'b00000       ;
                // RegInstBufferDirct  <= `JumpEnbale    ;
                // RegInstBufferDirPc  <= `ZeorDate      ;
                RegInstBufferNumb   <= 3'b000         ;
            end
        end  
    end

    assign UpdataAble       = RegUpdataAble      ;
    assign UpdataPcAble     = RegUpdataPcAble    ;
    assign UpdataPc         = RegUpdataPc        ;
    assign UpdataTypeAble   = RegUpdataTypeAble  ;
    assign UpdataType       = RegUpdataType      ;
    assign UpdataDirectAble = RegUpdataDirectAble;
    assign UpFTQPtr         = RegUpFTQPtr        ;
    assign InstBufferAble   = RegInstBufferAble  ;
    assign InstBufferPc     = RegInstBufferPc    ;
    assign InstBufferData   = RegInstBufferData  ;
    assign InstBufferPtr    = RegInstBufferPtr   ;
    assign InstBufferNumb   = RegInstBufferNumb  ;




endmodule
