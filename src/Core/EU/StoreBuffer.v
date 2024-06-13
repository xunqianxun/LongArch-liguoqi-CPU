`timescale 1ps/1ps
`include "../define.v"

module StoreBuffer (
    input         wire                                 Clk              ,
    input         wire                                 Rest             ,

    input         wire                                 SbStop           ,
    input         wire                                 SbFlash          ,
    output        wire                                 SbReq            ,
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

    reg    [124:0]  STOREBUFFER [1:7] ;

    wire  Retir1Able = (RetirSAble1 & (STOREBUFFER[ReTirSPtr1][78:41] == InLoadEnty1[31:0]) & (InLoadEnty1[34:32] == 3'd3)) | 
                       (RetirSAble1 & (STOREBUFFER[ReTirSPtr1][78:41] == InLoadEnty2[31:0]) & (InLoadEnty2[34:32] == 3'd3)) | 
                       (RetirSAble1 & (STOREBUFFER[ReTirSPtr1][78:41] == InLoadEnty3[31:0]) & (InLoadEnty3[34:32] == 3'd3)) |
                       (RetirSAble1 & (STOREBUFFER[ReTirSPtr1][78:41] == InLoadEnty4[31:0]) & (InLoadEnty4[34:32] == 3'd3)) | 
                       (RetirSAble1 & (STOREBUFFER[ReTirSPtr1][78:41] == InLoadEnty5[31:0]) & (InLoadEnty5[34:32] == 3'd3)) | 
                       (RetirSAble1 & (STOREBUFFER[ReTirSPtr1][78:41] == InLoadEnty6[31:0]) & (InLoadEnty6[34:32] == 3'd3)) | 
                       (RetirSAble1 & (STOREBUFFER[ReTirSPtr1][78:41] == InLoadEnty7[31:0]) & (InLoadEnty7[34:32] == 3'd3)) ;

    wire  Retir2Able = (RetirSAble2 & (STOREBUFFER[ReTirSPtr2][78:41] == InLoadEnty1[31:0]) & (InLoadEnty1[34:32] == 3'd3)) | 
                       (RetirSAble2 & (STOREBUFFER[ReTirSPtr2][78:41] == InLoadEnty2[31:0]) & (InLoadEnty2[34:32] == 3'd3)) | 
                       (RetirSAble2 & (STOREBUFFER[ReTirSPtr2][78:41] == InLoadEnty3[31:0]) & (InLoadEnty3[34:32] == 3'd3)) |
                       (RetirSAble2 & (STOREBUFFER[ReTirSPtr2][78:41] == InLoadEnty4[31:0]) & (InLoadEnty4[34:32] == 3'd3)) | 
                       (RetirSAble2 & (STOREBUFFER[ReTirSPtr2][78:41] == InLoadEnty5[31:0]) & (InLoadEnty5[34:32] == 3'd3)) | 
                       (RetirSAble2 & (STOREBUFFER[ReTirSPtr2][78:41] == InLoadEnty6[31:0]) & (InLoadEnty6[34:32] == 3'd3)) | 
                       (RetirSAble2 & (STOREBUFFER[ReTirSPtr2][78:41] == InLoadEnty7[31:0]) & (InLoadEnty7[34:32] == 3'd3)) ;

    wire  Retir3Able = (RetirSAble3 & (STOREBUFFER[ReTirSPtr3][78:41] == InLoadEnty1[31:0]) & (InLoadEnty1[34:32] == 3'd3)) | 
                       (RetirSAble3 & (STOREBUFFER[ReTirSPtr3][78:41] == InLoadEnty2[31:0]) & (InLoadEnty2[34:32] == 3'd3)) | 
                       (RetirSAble3 & (STOREBUFFER[ReTirSPtr3][78:41] == InLoadEnty3[31:0]) & (InLoadEnty3[34:32] == 3'd3)) |
                       (RetirSAble3 & (STOREBUFFER[ReTirSPtr3][78:41] == InLoadEnty4[31:0]) & (InLoadEnty4[34:32] == 3'd3)) | 
                       (RetirSAble3 & (STOREBUFFER[ReTirSPtr3][78:41] == InLoadEnty5[31:0]) & (InLoadEnty5[34:32] == 3'd3)) | 
                       (RetirSAble3 & (STOREBUFFER[ReTirSPtr3][78:41] == InLoadEnty6[31:0]) & (InLoadEnty6[34:32] == 3'd3)) | 
                       (RetirSAble3 & (STOREBUFFER[ReTirSPtr3][78:41] == InLoadEnty7[31:0]) & (InLoadEnty7[34:32] == 3'd3)) ;

    wire  Retir4Able = (RetirSAble4 & (STOREBUFFER[ReTirSPtr4][78:41] == InLoadEnty1[31:0]) & (InLoadEnty1[34:32] == 3'd3)) | 
                       (RetirSAble4 & (STOREBUFFER[ReTirSPtr4][78:41] == InLoadEnty2[31:0]) & (InLoadEnty2[34:32] == 3'd3)) | 
                       (RetirSAble4 & (STOREBUFFER[ReTirSPtr4][78:41] == InLoadEnty3[31:0]) & (InLoadEnty3[34:32] == 3'd3)) |
                       (RetirSAble4 & (STOREBUFFER[ReTirSPtr4][78:41] == InLoadEnty4[31:0]) & (InLoadEnty4[34:32] == 3'd3)) | 
                       (RetirSAble4 & (STOREBUFFER[ReTirSPtr4][78:41] == InLoadEnty5[31:0]) & (InLoadEnty5[34:32] == 3'd3)) | 
                       (RetirSAble4 & (STOREBUFFER[ReTirSPtr4][78:41] == InLoadEnty6[31:0]) & (InLoadEnty6[34:32] == 3'd3)) | 
                       (RetirSAble4 & (STOREBUFFER[ReTirSPtr4][78:41] == InLoadEnty7[31:0]) & (InLoadEnty7[34:32] == 3'd3)) ;

    wire LLbCtrl     = (STOREBUFFER[ReTirSPtr4][78:41] == LLSCAddrIn) & LLSCAble ;
    assign LLSCClean = LLbCtrl ;
    assign LLCtrlEnA = LLbCtrl ;
    
    wire [2:0]  IndexSB = STOREBUFFER[1][124] ? 3'd1 :
                          STOREBUFFER[2][124] ? 3'd2 : 
                          STOREBUFFER[3][124] ? 3'd3 : 
                          STOREBUFFER[4][124] ? 3'd4 : 
                          STOREBUFFER[5][124] ? 3'd5 : 
                          STOREBUFFER[6][124] ? 3'd6 : 
                          STOREBUFFER[7][124] ? 3'd7 : 3'd0 ;

    wire [2:0]  IndexToSuc = (STOREBUFFER[7][123:121] == SWING) ? 3'd7 : 
                             (STOREBUFFER[6][123:121] == SWING) ? 3'd6 : 
                             (STOREBUFFER[5][123:121] == SWING) ? 3'd5 : 
                             (STOREBUFFER[4][123:121] == SWING) ? 3'd4 : 
                             (STOREBUFFER[3][123:121] == SWING) ? 3'd3 : 
                             (STOREBUFFER[2][123:121] == SWING) ? 3'd2 : 
                             (STOREBUFFER[1][123:121] == SWING) ? 3'd1 : 3'd0 ;


    wire         StoreBufferEmpty = ~STOREBUFFER[1][124] & 
                                    ~STOREBUFFER[2][124] & 
                                    ~STOREBUFFER[3][124] & 
                                    ~STOREBUFFER[4][124] & 
                                    ~STOREBUFFER[5][124] & 
                                    ~STOREBUFFER[6][124] & 
                                    ~STOREBUFFER[7][124] ;
    wire         StoreBufferFull  = STOREBUFFER[1][124] & 
                                    STOREBUFFER[2][124] & 
                                    STOREBUFFER[3][124] & 
                                    STOREBUFFER[4][124] & 
                                    STOREBUFFER[5][124] & 
                                    STOREBUFFER[6][124] & 
                                    STOREBUFFER[7][124] ;

    assign StoreEmpty = StoreBufferEmpty ;
    assign SbReq      = StoreBufferEmpty ;

    always @(posedge Clk) begin
        if(!Rest) begin
            STOREBUFFER[1] <= 125'd0 ;
            STOREBUFFER[2] <= 125'd0 ;
            STOREBUFFER[3] <= 125'd0 ;
            STOREBUFFER[4] <= 125'd0 ;
            STOREBUFFER[5] <= 125'd0 ;
            STOREBUFFER[6] <= 125'd0 ;
            STOREBUFFER[7] <= 125'd0 ;
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
            STOREBUFFER[1] <= 125'd0 ;
            STOREBUFFER[2] <= 125'd0 ;
            STOREBUFFER[3] <= 125'd0 ;
            STOREBUFFER[4] <= 125'd0 ;
            STOREBUFFER[5] <= 125'd0 ;
            STOREBUFFER[6] <= 125'd0 ;
            STOREBUFFER[7] <= 125'd0 ; 
        end
        else begin
            STOREBUFFER[IndexSB]    <= InSBAble       ? {`AbleValue,SWRITE,InSBMicOp,InSBDate,InSBMAT,InSBPAddr,InSBTrap,InSBTrapCode,InSBWbAble,25'd0,InSBWbAddr,InSBRobPtr} : STOREBUFFER[IndexSB] ;
            STOREBUFFER[RetirSPtr1] <= RetirSAble1    ? (~(STOREBUFFER[RetirSPtr1][120:113] == `InstScw) ? {`AbleValue,SWING,STOREBUFFER[RetirSPtr1][120:0]} : {125{LLctrlBit}}&{`AbleValue,SWING,STOREBUFFER[RetirSPtr1][120:0]}) : STOREBUFFER[RetirSPtr1] ;
            STOREBUFFER[RetirSPtr2] <= RetirSAble2    ? (~(STOREBUFFER[RetirSPtr2][120:113] == `InstScw) ? {`AbleValue,SWING,STOREBUFFER[RetirSPtr2][120:0]} : {125{LLctrlBit}}&{`AbleValue,SWING,STOREBUFFER[RetirSPtr2][120:0]}) : STOREBUFFER[RetirSPtr2] ;
            STOREBUFFER[RetirSPtr3] <= RetirSAble3    ? (~(STOREBUFFER[RetirSPtr3][120:113] == `InstScw) ? {`AbleValue,SWING,STOREBUFFER[RetirSPtr3][120:0]} : {125{LLctrlBit}}&{`AbleValue,SWING,STOREBUFFER[RetirSPtr3][120:0]}) : STOREBUFFER[RetirSPtr3] ;
            STOREBUFFER[RetirSPtr4] <= RetirSAble4    ? (~(STOREBUFFER[RetirSPtr4][120:113] == `InstScw) ? {`AbleValue,SWING,STOREBUFFER[RetirSPtr4][120:0]} : {125{LLctrlBit}}&{`AbleValue,SWING,STOREBUFFER[RetirSPtr4][120:0]}) : STOREBUFFER[RetirSPtr4] ;
            STOREBUFFER[IndexToSuc] <= DcdToSbSuccess ? {`AbleValue,SWEITCOM,STOREBUFFER[IndexToSuc][120:0]} : STOREBUFFER[IndexToSuc] ;
            STOREBUFFER[DcdToSbBackPtr] <= DcdToSbBackAble ? 125'd0 : STOREBUFFER[DcdToSbBackPtr] 
        end
    end
    
    assign SbToDcdAble = (IndexToSuc != 0) ;
    assign SbToDcdAMat = (IndexToSuc != 0) ? STOREBUFFER[IndexToSuc][80:79] : 2'b0 ;
    assign SbToDcdAPtr = (IndexToSuc != 0) ? IndexToSuc : 3'd0 ;
    assign SbToDcdAPhyAddr = (IndexToSuc != 0) ? STOREBUFFER[IndexToSuc][78:41]  : 32'd0 ;
    assign SbToDcdAPhyDate = (IndexToSuc != 0) ? STOREBUFFER[IndexToSuc][112:81] : 32'd0 ;

    assign CommitSAble   = InSBAble   ;
    assign CommitSRobPtr = InSBRobPtr ;
    assign CommitSTrap   = InSBTrap   ; 
    assign CommitSTrapCode = InSBTrapCode ;
    assign CommitSBPtr   = InSBRobPtr ;

    assign WBPhysicalAble = STOREBUFFER[DcdToSbBackPtr][38] ;
    assign WBPhysicalAddr = STOREBUFFER[DcdToSbBackPtr][12:6] ;
    assign WBPhysicalDate = LLctrlBit ;

    assign ReDirect = Retir1Able | Retir2Able | Retir3Able | Retir4Able ;
    assign ReDirectAddr = 

endmodule

