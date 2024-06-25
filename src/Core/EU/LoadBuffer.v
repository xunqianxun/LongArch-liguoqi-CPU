`timescale 1ps/1ps
`include "../define.v"

module LoadBuffer (
    input         wire                                 Clk              ,
    input         wire                                 Rest             ,

    input         wire                                 LbStop           ,
    input         wire                                 LbFlash          ,
    output        wire                                 LsStopReq        ,

    //from store buffer
    input         wire                                 SbEmpty          ,
    input         wire                                 CleanLLSC        ,
    //to store buffer
    output        wire      [34:0]                     LoadEnty1        ,
    output        wire      [34:0]                     LoadEnty2        ,
    output        wire      [34:0]                     LoadEnty3        ,
    output        wire      [34:0]                     LoadEnty4        ,
    output        wire      [34:0]                     LoadEnty5        ,
    output        wire      [34:0]                     LoadEnty6        ,
    output        wire      [34:0]                     LoadEnty7        ,
    output        wire      [`InstAddrBus]             LLSCAddr         ,
    //from AGUload
    input         wire                                 InLBAble         ,
    input         wire      [`InstAddrBus]             InLBPc           ,
    input         wire      [`MicOperateCode]          InLBMicOp        ,
    input         wire      [1:0]                      InLBMAT          ,   
    input         wire      [`InstAddrBus]             InLBPAddr        ,
    input         wire                                 InLBTrap         ,
    input         wire      [6:0]                      InLBTrapCode     ,
    input         wire                                 InLBWbAble       ,
    input         wire      [`ReNameRegBUs]            InLBWbAddr       ,
    input         wire      [5:0]                      InLBRobPtr       ,
    //to phy 
    output        wire                                 LoadWPhyAble     ,
    output        wire      [`ReNameRegBUs]            LoadWPhyAddr     ,
    output        wire      [`DataBus]                 LoadWPhyDate     ,
    //to Rob
    output        wire                                 CommitLAble      ,
    output        wire      [5:0]                      CommitLRobPtr    ,
    output        wire                                 CommitLTrap      ,
    output        wire      [6:0]                      CommitLTrapCode  ,
    output        wire      [2:0]                      CommitLBPtr      ,
    //from Rob
    input         wire                                 RetirLAble1      ,
    input         wire      [2:0]                      ReTirLPtr1       ,
    input         wire                                 RetirLAble2      ,
    input         wire      [2:0]                      ReTirLPtr2       ,
    input         wire                                 RetirLAble3      ,
    input         wire      [2:0]                      ReTirLPtr3       ,
    input         wire                                 RetirLAble4      ,
    input         wire      [2:0]                      ReTirLPtr4       ,
    //to Dcache
    output        wire                                 LbToDcdAble      ,
    output        wire     [1:0]                       LbToDcdAMat      ,
    output        wire     [2:0]                       LbToDcdAPtr      ,
    input         wire                                 DcdToLbSuccess   ,
    output        wire     [`InstAddrBus]              LbToDcdAPhyAddr  ,
    input         wire                                 DcdToLbBackAble  ,
    input         wire     [2:0]                       DcdToLbBackPtr   ,
    input         wire     [`DataBus]                  DcdToLbBackDate  
); 
    localparam WRITE   = 3'd1 ;
    localparam WEITCOM = 3'd3 ;

    reg    [69:0]  LOADBUFFER [1:7] ;

    assign LoadEnty1 = {LOADBUFFER[1][68:66], LOADBUFFER[1][54:23]}  ;
    assign LoadEnty2 = {LOADBUFFER[2][68:66], LOADBUFFER[2][54:23]}  ;
    assign LoadEnty3 = {LOADBUFFER[3][68:66], LOADBUFFER[3][54:23]}  ;
    assign LoadEnty4 = {LOADBUFFER[4][68:66], LOADBUFFER[4][54:23]}  ;
    assign LoadEnty5 = {LOADBUFFER[5][68:66], LOADBUFFER[5][54:23]}  ;
    assign LoadEnty6 = {LOADBUFFER[6][68:66], LOADBUFFER[6][54:23]}  ;
    assign LoadEnty7 = {LOADBUFFER[7][68:66], LOADBUFFER[7][54:23]}  ;

    wire [2:0]  IndexLB = LOADBUFFER[1][69] ? 3'd1 :
                          LOADBUFFER[2][69] ? 3'd2 : 
                          LOADBUFFER[3][69] ? 3'd3 : 
                          LOADBUFFER[4][69] ? 3'd4 : 
                          LOADBUFFER[5][69] ? 3'd5 : 
                          LOADBUFFER[6][69] ? 3'd6 : 
                          LOADBUFFER[7][69] ? 3'd7 : 3'd0 ;

    wire [2:0]  IndexToSuc = (LOADBUFFER[7][68:66] == WRITE) ? 3'd7 : 
                             (LOADBUFFER[6][68:66] == WRITE) ? 3'd6 : 
                             (LOADBUFFER[5][68:66] == WRITE) ? 3'd5 : 
                             (LOADBUFFER[4][68:66] == WRITE) ? 3'd4 : 
                             (LOADBUFFER[3][68:66] == WRITE) ? 3'd3 : 
                             (LOADBUFFER[2][68:66] == WRITE) ? 3'd2 : 
                             (LOADBUFFER[1][68:66] == WRITE) ? 3'd1 : 3'd0 ;

    reg          IorDBarStop ;

    wire         LoadBufferEmpty = ~LOADBUFFER[1][69] & 
                                   ~LOADBUFFER[2][69] & 
                                   ~LOADBUFFER[3][69] & 
                                   ~LOADBUFFER[4][69] & 
                                   ~LOADBUFFER[5][69] & 
                                   ~LOADBUFFER[6][69] & 
                                   ~LOADBUFFER[7][69] ;
    wire         LoadBufferFull  = LOADBUFFER[1][69] & 
                                   LOADBUFFER[2][69] & 
                                   LOADBUFFER[3][69] & 
                                   LOADBUFFER[4][69] & 
                                   LOADBUFFER[5][69] & 
                                   LOADBUFFER[6][69] & 
                                   LOADBUFFER[7][69] ;

    always @(posedge Clk) begin
        if(!Rest) begin
            IorDBarStop <= 1'b0 ;
        end
        else if(LbStop) begin
            IorDBarStop <= IorDBarStop ;
        end
        else if(LbFlash) begin
            IorDBarStop <= 1'b0 ;
        end
        else begin
            if((InLBAble) & ((InLBMicOp == `InstIbar) | (InLBMicOp == `InstDbar))) begin
                IorDBarStop <= 1'b1 ;
            end
            if(LoadBufferEmpty & SbEmpty)begin
                IorDBarStop <= 1'b0 ;
            end
        end
    end

    assign LsStopReq = IorDBarStop | ((InLBMicOp == `InstIbar) | (InLBMicOp == `InstDbar)) | LoadBufferFull ;

    always @(posedge Clk) begin
        if(!Rest) begin
            LOADBUFFER[1] <= 70'd0 ;
            LOADBUFFER[2] <= 70'd0 ;
            LOADBUFFER[3] <= 70'd0 ;
            LOADBUFFER[4] <= 70'd0 ;
            LOADBUFFER[5] <= 70'd0 ;
            LOADBUFFER[6] <= 70'd0 ;
            LOADBUFFER[7] <= 70'd0 ;
        end
        else if(LbStop) begin
            LOADBUFFER[1] <= LOADBUFFER[1] ;
            LOADBUFFER[2] <= LOADBUFFER[2] ;
            LOADBUFFER[3] <= LOADBUFFER[3] ;
            LOADBUFFER[4] <= LOADBUFFER[4] ;
            LOADBUFFER[5] <= LOADBUFFER[5] ;
            LOADBUFFER[6] <= LOADBUFFER[6] ;
            LOADBUFFER[7] <= LOADBUFFER[7] ;
        end
        else if(LbFlash) begin
            LOADBUFFER[1] <= 70'd0 ;
            LOADBUFFER[2] <= 70'd0 ;
            LOADBUFFER[3] <= 70'd0 ;
            LOADBUFFER[4] <= 70'd0 ;
            LOADBUFFER[5] <= 70'd0 ;
            LOADBUFFER[6] <= 70'd0 ;
            LOADBUFFER[7] <= 70'd0 ;
        end
        else begin
            if(InLBAble & ~((InLBMicOp == `InstIbar) | (InLBMicOp == `InstDbar)))
                LOADBUFFER[IndexLB] <= {`AbleValue,WRITE,1'b0,InLBMicOp,InLBMAT,InLBPAddr,InLBTrap,InLBTrapCode,InLBWbAble,1'b0,InLBWbAddr,InLBRobPtr} ;
            if(DcdToLbSuccess)
                LOADBUFFER[IndexToSuc] <= {`AbleValue,WEITCOM,LOADBUFFER[IndexToSuc][65:0]} ;
            if(RetirLAble1) 
                LOADBUFFER[ReTirLPtr1] <= 70'd0 ; 
            if(RetirLAble2) 
                LOADBUFFER[ReTirLPtr2] <= 70'd0 ;
            if(RetirLAble3) 
                LOADBUFFER[ReTirLPtr3] <= 70'd0 ;
            if(RetirLAble4) 
                LOADBUFFER[ReTirLPtr4] <= 70'd0 ;
        end
    end

    assign LoadWPhyAble = DcdToLbBackAble & LOADBUFFER[DcdToLbBackPtr][14] ;
    assign LoadWPhyAddr = {7{DcdToLbBackAble}} & LOADBUFFER[DcdToLbBackPtr][12:6] ;
    assign LoadWPhyDate = {32{DcdToLbBackAble}} & DcdToLbBackDate ;

    assign LbToDcdAble = (IndexToSuc != 0) & LOADBUFFER[IndexToSuc][69]    ;
    assign LbToDcdAMat = {2{(IndexToSuc != 0)}} & LOADBUFFER[IndexToSuc][56:55] ;
    assign LbToDcdAPtr = {3{(IndexToSuc != 0)}} & IndexToSuc ;
    assign LbToDcdAPhyAddr = {32{(IndexToSuc != 0)}} & LOADBUFFER[IndexToSuc][54:23] ;

    assign CommitLAble   = DcdToLbBackAble ;
    assign CommitLRobPtr = LOADBUFFER[DcdToLbBackPtr][5:0] ;
    assign CommitLTrap   = LOADBUFFER[DcdToLbBackPtr][22]  ;
    assign CommitLTrapCode = LOADBUFFER[DcdToLbBackPtr][21:15] ;
    assign CommitLBPtr   = DcdToLbBackPtr  ;

    reg   [`InstAddrBus]   LLSCTemp ;
    always @(posedge Clk) begin
        if(!Rest) begin
            LLSCTemp <= 32'd0    ;
        end
        else if(LbStop) begin
            LLSCTemp <= LLSCTemp ;
        end
        else if(LbFlash) begin
            LLSCTemp <= 32'd0    ;
        end
        else begin
            if(RetirLAble1 & LOADBUFFER[ReTirLPtr1][64:57] == `InstLlw) begin
                LLSCTemp <= LOADBUFFER[ReTirLPtr1][54:23] ;
            end
            if(RetirLAble2 & LOADBUFFER[ReTirLPtr2][64:57] == `InstLlw) begin
                LLSCTemp <= LOADBUFFER[ReTirLPtr2][54:23] ;
            end
            if(RetirLAble3 & LOADBUFFER[ReTirLPtr3][64:57] == `InstLlw) begin
                LLSCTemp <= LOADBUFFER[ReTirLPtr3][54:23] ;
            end
            if(RetirLAble4 & LOADBUFFER[ReTirLPtr4][64:57] == `InstLlw) begin
                LLSCTemp <= LOADBUFFER[ReTirLPtr4][54:23] ;
            end
            if(CleanLLSC) begin
                LLSCTemp <= 32'd0    ;
            end
        end 
    end

    assign LLSCAddr = LLSCTemp ;

endmodule
 
