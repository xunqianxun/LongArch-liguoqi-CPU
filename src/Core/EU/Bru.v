`timescale 1ps/1ps
`include "../define.v"

module Bru (
    input         wire                                   Clk              ,
    input         wire                                   Rest             ,
    //for ctrl
    input         wire                                   BruStop          ,
    input         wire                                   BruFlash         ,
    //output        wire                                   BruReq           ,
    //from IssueQueueBrCsr
    input         wire   [`InstAddrBus]                  BruInstPc        ,
    input         wire   [`MicOperateCode]               BruMicOperate    ,
    input         wire                                   BruSrc1Able      ,
    input         wire   [`ReNameRegBUs]                 BruSrc1Addr      ,
    input         wire   [`DataBus]                      BruSrc1Date      ,
    input         wire                                   BruSrc2Able      , //对于跳转指令的rd会被解码为src2
    input         wire   [`ReNameRegBUs]                 BruSrc2Addr      ,
    input         wire   [`DataBus]                      BruSrc2Date      ,
    //input         wire                                   BruImmAble       ,
    input         wire   [25:0]                          BruImmDate       ,
    input         wire                                   BruRdAble        ,
    input         wire   [`ReNameRegBUs]                 BruRdAddr        ,
    input         wire                                   BruMode          ,
    input         wire   [`InstAddrBus]                  BruReDirDate     ,
    input         wire   [5:0]                           BruROBPtr        ,
    //from ex stage bypass
    input         wire                                   BruSelfAble      ,
    input         wire   [`ReNameRegBUs]                 BruSelfADdr      ,
    input         wire   [`DataBus]                      BruSelfDate      ,
    input         wire                                   BruAlu1Able      ,
    input         wire   [`ReNameRegBUs]                 BruALu1Addr      ,
    input         wire   [`DataBus]                      BruAlu1Date      ,
    input         wire                                   BruAlu2Able      ,
    input         wire   [`ReNameRegBUs]                 BruALu2Addr      ,
    input         wire   [`DataBus]                      BruAlu2Date      ,
    input         wire                                   BruMulAble       ,
    input         wire   [`ReNameRegBUs]                 BruMulAddr       ,
    input         wire   [`DataBus]                      BruMulDate       , 
    input         wire                                   BruCsrAble       ,
    input         wire   [`ReNameRegBUs]                 BruCsrAddr       ,
    input         wire   [`DataBus]                      BruCsrDate       ,                                   
    //to physical
    output        wire                                   BWriteBackAble   ,
    output        wire   [`ReNameRegBUs]                 BWriteBackAddr   ,
    output        wire   [`DataBus]                      BWriteBackDate   ,
    //to isse req
    output        wire                                   BruReqInst       ,
    //to ROB
    output        wire                                   BruCommitAble    ,
    output        wire   [5:0]                           BruCommitPtr     ,
    output        wire                                   BruReDirAble     ,
    output        wire   [`InstAddrBus]                  BruReDirPc          
);

    assign BruReqInst = ~BruStop ;

    wire signed [`DataBus] Src1Date  =  ((BruSrc1Addr == BruSelfADdr) & BruSelfAble & BruSrc1Able) ? BruSelfDate :
                                        ((BruSrc1Addr == BruALu1Addr) & BruAlu1Able & BruSrc1Able) ? BruAlu1Date :
                                        ((BruSrc1Addr == BruALu2Addr) & BruAlu2Able & BruSrc1Able) ? BruAlu2Date :
                                        ((BruSrc1Addr == BruMulAddr ) & BruMulAble  & BruSrc1Able) ? BruMulDate  :
                                        ((BruSrc1Addr == BruCsrAddr ) & BruCsrAble  & BruSrc1Able) ? BruCsrDate  : BruSrc1Date ;
    
    wire signed [`DataBus] Src2Date  =  ((BruSrc2Addr == BruSelfADdr) & BruSelfAble & BruSrc2Able) ? BruSelfDate :
                                        ((BruSrc2Addr == BruALu1Addr) & BruAlu1Able & BruSrc2Able) ? BruAlu1Date :
                                        ((BruSrc2Addr == BruALu2Addr) & BruAlu2Able & BruSrc2Able) ? BruAlu2Date :
                                        ((BruSrc2Addr == BruMulAddr ) & BruMulAble  & BruSrc2Able) ? BruMulDate  :
                                        ((BruSrc2Addr == BruCsrAddr ) & BruCsrAble  & BruSrc2Able) ? BruCsrDate  : BruSrc2Date ;

    // localparam REDIRNO     = 2'b00;
    // localparam REDIRNOJUMP = 2'b01;
    // localparam REDIRJUMP   = 2'b10;
    // localparam REDIRJUMPOA = 2'b11; //jump other address

    reg                 RegBWriteBackAble ;
    reg [`ReNameRegBUs] RegBWriteBackAddr ;
    reg [`DataBus]      RegBWriteBackDate ;

    reg                 RegBruCommitAble  ;
    reg [5:0]           RegBruCommitPtr   ;
    reg                 RegBruReDirType   ;
    reg [`InstAddrBus]  RegBruReDirPc     ;

    always @(posedge Clk) begin
        if(!Rest) begin
           RegBWriteBackAble <= `EnableValue ;
           RegBWriteBackAddr <= 7'b0         ;
           RegBWriteBackDate <= 32'd0        ;
           RegBruCommitAble  <= `EnableValue ;
           RegBruCommitPtr   <= 6'b0         ;
           RegBruReDirType   <= `EnableValue      ;
           RegBruReDirPc     <= 32'b0        ;
        end
        else if(BruFlash) begin
           RegBWriteBackAble <= `EnableValue ;
           RegBWriteBackAddr <= 7'b0         ;
           RegBWriteBackDate <= 32'd0        ;
           RegBruCommitAble  <= `EnableValue ;
           RegBruCommitPtr   <= 6'b0         ;
           RegBruReDirType   <= `EnableValue      ;
           RegBruReDirPc     <= 32'b0        ; 
        end
        else begin
            RegBWriteBackAble <= BruRdAble  ;
            RegBWriteBackAddr <= BruRdAddr  ;
            RegBruCommitPtr   <= BruROBPtr  ;
            case (BruMicOperate)
                `InstBeq : begin
                    if(Src1Date == Src2Date) begin 
                        RegBWriteBackDate <= 32'd0        ; 
                        RegBruCommitAble  <= `AbleValue   ; 
                        RegBruReDirType   <=  BruMode ? `EnableValue : `AbleValue ;
                        RegBruReDirPc     <=  BruInstPc + {{4{BruImmDate[25]}}, BruImmDate,2'b0} ;
                    end 
                    else begin
                        RegBWriteBackDate <= 32'd0        ; 
                        RegBruCommitAble  <= `AbleValue   ; 
                        RegBruReDirType   <=  ~BruMode ? `EnableValue : `AbleValue ;
                        RegBruReDirPc     <=  BruInstPc + 32'd4 ;
                    end 
                end
                `InstBne : begin
                    if(Src1Date != Src2Date) begin 
                        RegBWriteBackDate <= 32'd0        ; 
                        RegBruCommitAble  <= `AbleValue   ; 
                        RegBruReDirType   <=  BruMode ? `EnableValue : `AbleValue ;
                        RegBruReDirPc     <=  BruInstPc + {{4{BruImmDate[25]}}, BruImmDate,2'b0} ;
                    end 
                    else begin 
                        RegBWriteBackDate <= 32'd0        ; 
                        RegBruCommitAble  <= `AbleValue   ; 
                        RegBruReDirType   <=  ~BruMode ? `EnableValue : `AbleValue ;
                        RegBruReDirPc     <=  BruInstPc + 32'd4 ;
                    end 
                end
                `InstBlt : begin
                    if(Src1Date < Src2Date) begin 
                        RegBWriteBackDate <= 32'd0        ; 
                        RegBruCommitAble  <= `AbleValue   ; 
                        RegBruReDirType   <=  BruMode ? `EnableValue : `AbleValue ;
                        RegBruReDirPc     <=  BruInstPc + {{4{BruImmDate[25]}}, BruImmDate,2'b0} ;
                    end 
                    else begin  
                        RegBWriteBackDate <= 32'd0        ; 
                        RegBruCommitAble  <= `AbleValue   ; 
                        RegBruReDirType   <=  ~BruMode ? `EnableValue : `AbleValue ;
                        RegBruReDirPc     <=  BruInstPc + 32'd4 ;
                    end 
                end
                `InstBge : begin
                    if(Src1Date >= Src2Date) begin  
                        RegBWriteBackDate <= 32'd0        ; 
                        RegBruCommitAble  <= `AbleValue   ; 
                        RegBruReDirType   <=  BruMode ? `EnableValue : `AbleValue ;
                        RegBruReDirPc     <=  BruInstPc + {{4{BruImmDate[25]}}, BruImmDate,2'b0} ;
                    end 
                    else begin 
                        RegBWriteBackDate <= 32'd0        ; 
                        RegBruCommitAble  <= `AbleValue   ; 
                        RegBruReDirType   <=  ~BruMode ? `EnableValue : `AbleValue ;
                        RegBruReDirPc     <=  BruInstPc + 32'd4 ;
                    end 
                end
                `InstBltu : begin
                    if($unsigned(Src1Date) < $unsigned(Src2Date)) begin 
                        RegBWriteBackDate <= 32'd0        ; 
                        RegBruCommitAble  <= `AbleValue   ; 
                        RegBruReDirType   <=  BruMode ? `EnableValue : `AbleValue ;
                        RegBruReDirPc     <=  BruInstPc + {{4{BruImmDate[25]}}, BruImmDate,2'b0} ;
                    end 
                    else begin 
                        RegBWriteBackDate <= 32'd0        ; 
                        RegBruCommitAble  <= `AbleValue   ; 
                        RegBruReDirType   <=  ~BruMode ? `EnableValue : `AbleValue ;
                        RegBruReDirPc     <=  BruInstPc + 32'd4 ;
                    end 
                end
                `InstBgeu : begin
                    if($unsigned(Src1Date) >= $unsigned(Src2Date)) begin 
                        RegBWriteBackDate <= 32'd0        ; 
                        RegBruCommitAble  <= `AbleValue   ; 
                        RegBruReDirType   <=  BruMode ? `EnableValue : `AbleValue ;
                        RegBruReDirPc     <=  BruInstPc + {{4{BruImmDate[25]}}, BruImmDate,2'b0} ;
                    end 
                    else begin 
                        RegBWriteBackDate <= 32'd0        ; 
                        RegBruCommitAble  <= `AbleValue   ; 
                        RegBruReDirType   <=  ~BruMode ? `EnableValue : `AbleValue ;
                        RegBruReDirPc     <=  BruInstPc + 32'd4 ;
                    end 
                end
                `InstB : begin
                        RegBWriteBackDate <= 32'd0        ; 
                        RegBruCommitAble  <= `AbleValue   ; 
                        RegBruReDirType   <= `EnableValue     ;
                        RegBruReDirPc     <=  BruInstPc + {{4{BruImmDate[25]}}, BruImmDate,2'b0} ; ;
                end
                `InstBl : begin
                        RegBWriteBackDate <=  BruInstPc + 32'd4 ; 
                        RegBruCommitAble  <= `AbleValue   ; 
                        RegBruReDirType   <= `EnableValue     ;
                        RegBruReDirPc     <=  BruInstPc + {{4{BruImmDate[25]}}, BruImmDate,2'b0} ; ;
                end
                 `InstJirl : begin
                    if((Src2Date + {{4{BruImmDate[25]}}, BruImmDate,2'b0}) == BruReDirDate) begin
                        RegBWriteBackDate <= BruInstPc + 32'd4 ; 
                        RegBruCommitAble  <= `AbleValue   ; 
                        RegBruReDirType   <= `EnableValue     ;
                        RegBruReDirPc     <=  Src2Date + {{4{BruImmDate[25]}}, BruImmDate,2'b0} ;
                    end 
                    else begin
                        RegBWriteBackDate <= BruInstPc + 32'd4 ; 
                        RegBruCommitAble  <= `AbleValue   ; 
                        RegBruReDirType   <=  `AbleValue  ;
                        RegBruReDirPc     <=  Src2Date + {{4{BruImmDate[25]}}, BruImmDate,2'b0} ;
                    end
                 end
                default: begin
                    RegBWriteBackAddr <= 7'b0         ;
                    RegBWriteBackDate <= 32'd0        ;
                    RegBruCommitAble  <= `EnableValue ;
                    RegBruCommitPtr   <= 6'b0         ;
                    RegBruReDirType   <= `EnableValue ;
                    RegBruReDirPc     <= 32'b0        ; 
                end
            endcase
        end
    end
 
    assign BWriteBackAble =  RegBWriteBackAble  ;
    assign BWriteBackAddr =  RegBWriteBackAddr  ;
    assign BWriteBackDate =  RegBWriteBackDate  ;
    assign BruCommitAble  =  RegBruCommitAble   ;
    assign BruCommitPtr   =  RegBruCommitPtr    ;
    assign BruReDirAble   =  RegBruReDirType    ;
    assign BruReDirPc     =  RegBruReDirPc      ;
 
    
endmodule
