`timescale 1ps/1ps
`include "../define.v"

module StoreBuffer (
    input         wire                                 Clk              ,
    input         wire                                 Rest             ,

    input         wire                                 SbStop           ,
    input         wire                                 SbFlash          ,
    output        wire                                 SbWlFlash        ,
    output        wire                                 SbWlStop         ,

    output        wire                                 SbReq            , //表示buffer full
    //to store buffer
    input         wire      [34:0]                     InLoadEnty1      ,
    input         wire      [34:0]                     InLoadEnty2      ,
    input         wire      [34:0]                     InLoadEnty3      ,
    input         wire      [34:0]                     InLoadEnty4      ,
    input         wire      [34:0]                     InLoadEnty5      ,
    input         wire      [34:0]                     InLoadEnty6      ,
    input         wire      [34:0]                     InLoadEnty7      ,
    output        wire                                 StoreEmpty       ,
    input         wire                                 LLSCAble         ,
    input         wire      [`InstAddrBus]             LLSCAddrIn       ,
    output        wire                                 LLSCClean        ,
    //for csr 
    input         wire                                 LLctrlBit        ,
    output        wire                                 LLCtrlEnA        , //不正确的store了llsc的地址，或者
    //from AGUload
    input         wire                                 InSBAble         ,
    input         wire      [`InstAddrBus]             InSBPc           ,
    input         wire      [`MicOperateCode]          InSBMicOp        ,
    input         wire      [`DataBus]                 InSBDate         ,
    input         wire      [1:0]                      InSBMAT          ,   
    input         wire      [`InstAddrBus]             InSBPAddr        ,
    input         wire                                 InSBTrap         ,
    input         wire      [6:0]                      InSBTrapCode     ,
    input         wire                                 InSBWbAble       ,
    input         wire      [`ReNameRegBUs]            InSBWbAddr       ,
    input         wire      [5:0]                      InSBRobPtr       ,
    //to physcoal 
    output        wire                                 WBPhysicalAble   ,
    output        wire      [`ReNameRegBUs]            WBPhysicalAddr   ,
    output        wire      [`DataBus]                 WBPhysicalDate   ,
    //to Rob
    output        wire                                 CommitSAble      ,
    output        wire      [5:0]                      CommitSRobPtr    ,
    output        wire                                 CommitSTrap      ,
    output        wire      [6:0]                      CommitSTrapCode  ,
    output        wire      [2:0]                      CommitSBPtr      ,
    //to pc 
    output        wire                                 ReDirect         ,
    output        wire      [`InstAddrBus]             ReDirectAddr     ,
    //from Rob
    input         wire                                 RetirSAble1      ,
    input         wire      [2:0]                      ReTirSPtr1       ,
    input         wire                                 RetirSAble2      ,
    input         wire      [2:0]                      ReTirSPtr2       ,
    input         wire                                 RetirSAble3      ,
    input         wire      [2:0]                      ReTirSPtr3       ,
    input         wire                                 RetirSAble4      ,
    input         wire      [2:0]                      ReTirSPtr4       ,
    //to Dcache
    output        wire                                 SbToDcdAble      ,
    output        wire     [1:0]                       SbToDcdAMat      ,
    output        wire     [2:0]                       SbToDcdAPtr      ,
    input         wire                                 DcdToSbSuccess   ,
    output        wire     [`InstAddrBus]              SbToDcdAPhyAddr  ,
    output        wire     [`DataBus]                  SbToDcdAPhyDate  ,
    input         wire                                 DcdToSbBackAble  ,
    input         wire     [2:0]                       DcdToSbBackPtr   
);

    localparam SWRITE   = 3'd1 ;
    localparam SWING    = 3'd2 ;
    localparam SWEITCOM = 3'd3 ;

    reg    [155:0]  STOREBUFFER [1:7] ;

    wire  Retir1Able = (RetirSAble1 & (STOREBUFFER[ReTirSPtr1][77:46] == InLoadEnty1[31:0]) & (InLoadEnty1[34:32] == 3'd3)) | 
                       (RetirSAble1 & (STOREBUFFER[ReTirSPtr1][77:46] == InLoadEnty2[31:0]) & (InLoadEnty2[34:32] == 3'd3)) | 
                       (RetirSAble1 & (STOREBUFFER[ReTirSPtr1][77:46] == InLoadEnty3[31:0]) & (InLoadEnty3[34:32] == 3'd3)) |
                       (RetirSAble1 & (STOREBUFFER[ReTirSPtr1][77:46] == InLoadEnty4[31:0]) & (InLoadEnty4[34:32] == 3'd3)) | 
                       (RetirSAble1 & (STOREBUFFER[ReTirSPtr1][77:46] == InLoadEnty5[31:0]) & (InLoadEnty5[34:32] == 3'd3)) | 
                       (RetirSAble1 & (STOREBUFFER[ReTirSPtr1][77:46] == InLoadEnty6[31:0]) & (InLoadEnty6[34:32] == 3'd3)) | 
                       (RetirSAble1 & (STOREBUFFER[ReTirSPtr1][77:46] == InLoadEnty7[31:0]) & (InLoadEnty7[34:32] == 3'd3)) ;

    wire  Retir2Able = (RetirSAble2 & (STOREBUFFER[ReTirSPtr2][77:46] == InLoadEnty1[31:0]) & (InLoadEnty1[34:32] == 3'd3)) | 
                       (RetirSAble2 & (STOREBUFFER[ReTirSPtr2][77:46] == InLoadEnty2[31:0]) & (InLoadEnty2[34:32] == 3'd3)) | 
                       (RetirSAble2 & (STOREBUFFER[ReTirSPtr2][77:46] == InLoadEnty3[31:0]) & (InLoadEnty3[34:32] == 3'd3)) |
                       (RetirSAble2 & (STOREBUFFER[ReTirSPtr2][77:46] == InLoadEnty4[31:0]) & (InLoadEnty4[34:32] == 3'd3)) | 
                       (RetirSAble2 & (STOREBUFFER[ReTirSPtr2][77:46] == InLoadEnty5[31:0]) & (InLoadEnty5[34:32] == 3'd3)) | 
                       (RetirSAble2 & (STOREBUFFER[ReTirSPtr2][77:46] == InLoadEnty6[31:0]) & (InLoadEnty6[34:32] == 3'd3)) | 
                       (RetirSAble2 & (STOREBUFFER[ReTirSPtr2][77:46] == InLoadEnty7[31:0]) & (InLoadEnty7[34:32] == 3'd3)) ;

    wire  Retir3Able = (RetirSAble3 & (STOREBUFFER[ReTirSPtr3][77:46] == InLoadEnty1[31:0]) & (InLoadEnty1[34:32] == 3'd3)) | 
                       (RetirSAble3 & (STOREBUFFER[ReTirSPtr3][77:46] == InLoadEnty2[31:0]) & (InLoadEnty2[34:32] == 3'd3)) | 
                       (RetirSAble3 & (STOREBUFFER[ReTirSPtr3][77:46] == InLoadEnty3[31:0]) & (InLoadEnty3[34:32] == 3'd3)) |
                       (RetirSAble3 & (STOREBUFFER[ReTirSPtr3][77:46] == InLoadEnty4[31:0]) & (InLoadEnty4[34:32] == 3'd3)) | 
                       (RetirSAble3 & (STOREBUFFER[ReTirSPtr3][77:46] == InLoadEnty5[31:0]) & (InLoadEnty5[34:32] == 3'd3)) | 
                       (RetirSAble3 & (STOREBUFFER[ReTirSPtr3][77:46] == InLoadEnty6[31:0]) & (InLoadEnty6[34:32] == 3'd3)) | 
                       (RetirSAble3 & (STOREBUFFER[ReTirSPtr3][77:46] == InLoadEnty7[31:0]) & (InLoadEnty7[34:32] == 3'd3)) ;

    wire  Retir4Able = (RetirSAble4 & (STOREBUFFER[ReTirSPtr4][77:46] == InLoadEnty1[31:0]) & (InLoadEnty1[34:32] == 3'd3)) | 
                       (RetirSAble4 & (STOREBUFFER[ReTirSPtr4][77:46] == InLoadEnty2[31:0]) & (InLoadEnty2[34:32] == 3'd3)) | 
                       (RetirSAble4 & (STOREBUFFER[ReTirSPtr4][77:46] == InLoadEnty3[31:0]) & (InLoadEnty3[34:32] == 3'd3)) |
                       (RetirSAble4 & (STOREBUFFER[ReTirSPtr4][77:46] == InLoadEnty4[31:0]) & (InLoadEnty4[34:32] == 3'd3)) | 
                       (RetirSAble4 & (STOREBUFFER[ReTirSPtr4][77:46] == InLoadEnty5[31:0]) & (InLoadEnty5[34:32] == 3'd3)) | 
                       (RetirSAble4 & (STOREBUFFER[ReTirSPtr4][77:46] == InLoadEnty6[31:0]) & (InLoadEnty6[34:32] == 3'd3)) | 
                       (RetirSAble4 & (STOREBUFFER[ReTirSPtr4][77:46] == InLoadEnty7[31:0]) & (InLoadEnty7[34:32] == 3'd3)) ;

    wire LLbCtrl     = ((STOREBUFFER[ReTirSPtr1][77:46] == LLSCAddrIn) & RetirSAble1) & LLSCAble |
                       ((STOREBUFFER[ReTirSPtr2][77:46] == LLSCAddrIn) & RetirSAble1) & LLSCAble |
                       ((STOREBUFFER[ReTirSPtr3][77:46] == LLSCAddrIn) & RetirSAble1) & LLSCAble |
                       ((STOREBUFFER[ReTirSPtr4][77:46] == LLSCAddrIn) & RetirSAble1) & LLSCAble ;
    assign LLSCClean = LLbCtrl ;
    assign LLCtrlEnA = LLbCtrl ;
    
    wire [2:0]  IndexSB = STOREBUFFER[1][124] ? 3'd1 :
                          STOREBUFFER[2][124] ? 3'd2 : 
                          STOREBUFFER[3][124] ? 3'd3 : 
                          STOREBUFFER[4][124] ? 3'd4 : 
                          STOREBUFFER[5][124] ? 3'd5 : 
                          STOREBUFFER[6][124] ? 3'd6 : 
                          STOREBUFFER[7][124] ? 3'd7 : 3'd0 ;

    wire [2:0]  IndexToSuc = (STOREBUFFER[7][123:121] == SWING) & ((STOREBUFFER[7][120:113]!=`InstDbar)|(STOREBUFFER[7][120:113]!=`InstIbar)) ? 3'd7 : 
                             (STOREBUFFER[6][123:121] == SWING) & ((STOREBUFFER[6][120:113]!=`InstDbar)|(STOREBUFFER[6][120:113]!=`InstIbar)) ? 3'd6 : 
                             (STOREBUFFER[5][123:121] == SWING) & ((STOREBUFFER[5][120:113]!=`InstDbar)|(STOREBUFFER[5][120:113]!=`InstIbar)) ? 3'd5 : 
                             (STOREBUFFER[4][123:121] == SWING) & ((STOREBUFFER[4][120:113]!=`InstDbar)|(STOREBUFFER[4][120:113]!=`InstIbar)) ? 3'd4 : 
                             (STOREBUFFER[3][123:121] == SWING) & ((STOREBUFFER[3][120:113]!=`InstDbar)|(STOREBUFFER[3][120:113]!=`InstIbar)) ? 3'd3 : 
                             (STOREBUFFER[2][123:121] == SWING) & ((STOREBUFFER[2][120:113]!=`InstDbar)|(STOREBUFFER[2][120:113]!=`InstIbar)) ? 3'd2 : 
                             (STOREBUFFER[1][123:121] == SWING) & ((STOREBUFFER[1][120:113]!=`InstDbar)|(STOREBUFFER[1][120:113]!=`InstIbar)) ? 3'd1 : 3'd0 ;



    wire         StoreBufferEmpty = ~STOREBUFFER[1][155] & 
                                    ~STOREBUFFER[2][155] & 
                                    ~STOREBUFFER[3][155] & 
                                    ~STOREBUFFER[4][155] & 
                                    ~STOREBUFFER[5][155] & 
                                    ~STOREBUFFER[6][155] & 
                                    ~STOREBUFFER[7][155] ;
    // wire         StoreBufferFull  = STOREBUFFER[1][155] & 
    //                                 STOREBUFFER[2][155] & 
    //                                 STOREBUFFER[3][155] & 
    //                                 STOREBUFFER[4][155] & 
    //                                 STOREBUFFER[5][155] & 
    //                                 STOREBUFFER[6][155] & 
    //                                 STOREBUFFER[7][155] ;

    assign StoreEmpty = StoreBufferEmpty ;
    assign SbReq      = StoreBufferEmpty ;

    always @(posedge Clk) begin
        if(!Rest) begin
            STOREBUFFER[1] <= 156'd0 ;
            STOREBUFFER[2] <= 156'd0 ;
            STOREBUFFER[3] <= 156'd0 ;
            STOREBUFFER[4] <= 156'd0 ;
            STOREBUFFER[5] <= 156'd0 ;
            STOREBUFFER[6] <= 156'd0 ;
            STOREBUFFER[7] <= 156'd0 ;
        end
        else if(SbStop) begin
            STOREBUFFER[1] <= STOREBUFFER[1] ;
            STOREBUFFER[2] <= STOREBUFFER[2] ;
            STOREBUFFER[3] <= STOREBUFFER[3] ;
            STOREBUFFER[4] <= STOREBUFFER[4] ;
            STOREBUFFER[5] <= STOREBUFFER[5] ;
            STOREBUFFER[6] <= STOREBUFFER[6] ;
            STOREBUFFER[7] <= STOREBUFFER[7] ;
        end
        else if(SbFlash) begin
            STOREBUFFER[1] <= 156'd0 ;
            STOREBUFFER[2] <= 156'd0 ;
            STOREBUFFER[3] <= 156'd0 ;
            STOREBUFFER[4] <= 156'd0 ;
            STOREBUFFER[5] <= 156'd0 ;
            STOREBUFFER[6] <= 156'd0 ;
            STOREBUFFER[7] <= 156'd0 ; 
        end
        else begin
            STOREBUFFER[IndexSB]    <= InSBAble       ? {`AbleValue,SWRITE,InSBPc,InSBMicOp,InSBDate,InSBMAT,InSBPAddr,InSBTrap,InSBTrapCode,InSBWbAble,24'd0,InSBWbAddr,InSBRobPtr} : STOREBUFFER[IndexSB] ;
            STOREBUFFER[ReTirSPtr1] <= RetirSAble1    ? (~(STOREBUFFER[ReTirSPtr1][120:113] == `InstScw) ? {`AbleValue,SWING,STOREBUFFER[ReTirSPtr1][151:0]} : {156{LLctrlBit}}&{`AbleValue,SWING,STOREBUFFER[ReTirSPtr1][151:0]}) : STOREBUFFER[ReTirSPtr1] ;
            STOREBUFFER[ReTirSPtr2] <= RetirSAble2    ? (~(STOREBUFFER[ReTirSPtr2][120:113] == `InstScw) ? {`AbleValue,SWING,STOREBUFFER[ReTirSPtr2][151:0]} : {156{LLctrlBit}}&{`AbleValue,SWING,STOREBUFFER[ReTirSPtr2][151:0]}) : STOREBUFFER[ReTirSPtr2] ;
            STOREBUFFER[ReTirSPtr3] <= RetirSAble3    ? (~(STOREBUFFER[ReTirSPtr3][120:113] == `InstScw) ? {`AbleValue,SWING,STOREBUFFER[ReTirSPtr3][151:0]} : {156{LLctrlBit}}&{`AbleValue,SWING,STOREBUFFER[ReTirSPtr3][151:0]}) : STOREBUFFER[ReTirSPtr3] ;
            STOREBUFFER[ReTirSPtr4] <= RetirSAble4    ? (~(STOREBUFFER[ReTirSPtr4][120:113] == `InstScw) ? {`AbleValue,SWING,STOREBUFFER[ReTirSPtr4][151:0]} : {156{LLctrlBit}}&{`AbleValue,SWING,STOREBUFFER[ReTirSPtr4][151:0]}) : STOREBUFFER[ReTirSPtr4] ;
            STOREBUFFER[IndexToSuc] <= DcdToSbSuccess ? {`AbleValue,SWEITCOM,STOREBUFFER[IndexToSuc][151:0]} : STOREBUFFER[IndexToSuc] ;
            STOREBUFFER[DcdToSbBackPtr] <= DcdToSbBackAble ? 156'd0 : STOREBUFFER[DcdToSbBackPtr] ;
        end
    end
    
    assign SbToDcdAble = (IndexToSuc != 0) ;
    assign SbToDcdAMat = (IndexToSuc != 0) ? STOREBUFFER[IndexToSuc][79:78] : 2'b0 ;
    assign SbToDcdAPtr = (IndexToSuc != 0) ? IndexToSuc : 3'd0 ;
    assign SbToDcdAPhyAddr = (IndexToSuc != 0) ? STOREBUFFER[IndexToSuc][77:46]  : 32'd0 ;
    assign SbToDcdAPhyDate = (IndexToSuc != 0) ? ({32{((STOREBUFFER[IndexToSuc][120:113]) == `InstStw)}}         & STOREBUFFER[IndexToSuc][111:80]) |
                                                 ({16'd0,{16{((STOREBUFFER[IndexToSuc][120:113]) == `InstSth)}}} & STOREBUFFER[IndexToSuc][111:80]) |  
                                                 ({24'd0,{8{((STOREBUFFER[IndexToSuc][120:113]) == `InstStb)}}}  & STOREBUFFER[IndexToSuc][111:80]) | 
                                                 ({32{((STOREBUFFER[IndexToSuc][120:113]) == `InstScw)}}         & STOREBUFFER[IndexToSuc][111:80]) : 32'd0 ;

    assign CommitSAble   = InSBAble   ;
    assign CommitSRobPtr = InSBRobPtr ;
    assign CommitSTrap   = InSBTrap   ; 
    assign CommitSTrapCode = InSBTrapCode ;
    assign CommitSBPtr   = IndexSB    ;

    assign WBPhysicalAble = STOREBUFFER[DcdToSbBackPtr][37] ;
    assign WBPhysicalAddr = STOREBUFFER[DcdToSbBackPtr][12:6] ;
    assign WBPhysicalDate = {31'd0,LLctrlBit} ;

    assign ReDirect = Retir1Able | Retir2Able | Retir3Able | Retir4Able ;
    assign ReDirectAddr = Retir1Able ? STOREBUFFER[ReTirSPtr1][151:120]  : 
                          Retir1Able ? STOREBUFFER[ReTirSPtr1][151:120]  : 
                          Retir1Able ? STOREBUFFER[ReTirSPtr1][151:120]  : 
                          Retir1Able ? STOREBUFFER[ReTirSPtr1][151:120]  : 32'd0; 

    assign SbWlFlash = ReDirect ;
    assign SbWlStop  = (STOREBUFFER[1][120:113] == `InstIbar) | (STOREBUFFER[1][120:113] == `InstDbar) 

endmodule

//TODO list:
// no1 : Reorder buffer need check load and store instrucation Dbat or Ibar then stop the instrucation it new than the Inst 
// No2 : 

