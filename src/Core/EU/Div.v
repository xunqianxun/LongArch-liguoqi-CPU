`timescale 1ps/1ps
`include "../define.v"

module Div #(
    parameter WIDTH_DIV = 32 
) (
    input         wire                               Clk           ,
    input         wire                               Rest          , 
 
    input         wire                               DivStop       ,
    input         wire                               DivFlash      ,
 
    output        wire                               DivReq        ,
    //from issuequeueint 
    input         wire                               DivInstAble   ,
    input         wire   [`MicOperateCode]           DivMicopcode  ,
    input         wire                               DivSrc1Able   ,
    input         wire   [`ReNameRegBUs]             DivSrc1Addr   ,
    input         wire   [`DataBus]                  DivSrc1Date   ,
    input         wire                               DivSrc2Able   , //对于跳转指令的rd会被解码为src2
    input         wire   [`ReNameRegBUs]             DivSrc2Addr   ,
    input         wire   [`DataBus]                  DivSrc2Date   ,
    input         wire                               DivRdAble     ,
    input         wire   [`ReNameRegBUs]             DivRdAddr     ,
    input         wire   [5:0]                       DivROBPtr     , 

    input         wire                               DivBruAble     ,
    input         wire   [`ReNameRegBUs]             DivBruAddr     ,
    input         wire   [`DataBus]                  DivBruDate     ,
    input         wire                               DivAlu2Able    ,
    input         wire   [`ReNameRegBUs]             DivAlu2Addr    ,
    input         wire   [`DataBus]                  DivAlu2Date    ,
    input         wire                               DivMulAble     ,
    input         wire   [`ReNameRegBUs]             DivMulAddr     ,
    input         wire   [`DataBus]                  DivMulDate     , 
    input         wire                               DivCsrAble     ,
    input         wire   [`ReNameRegBUs]             DivCsrAddr     ,
    input         wire   [`DataBus]                  DivCsrDate     , 
    //to physical
    output        wire                               DivWBAble      ,
    output        wire   [`ReNameRegBUs]             DivWBAddr      ,
    output        wire   [`DataBus]                  DivWBDate      ,
    //to ROB
    output        wire                               DivCommitAble  ,
    output        wire   [5:0]                       DivCommitPtr   

);

    wire  [`DataBus] DSrc1Date   =  ((DivSrc1Addr == DivBruAddr ) & DivBruAble  & DivSrc1Able) ? DivBruDate  :
                                    ((DivSrc1Addr == DivAlu2Addr) & DivAlu2Able & DivSrc1Able) ? DivAlu2Date :
                                    ((DivSrc1Addr == DivMulAddr ) & DivMulAble  & DivSrc1Able) ? DivMulDate  :
                                    ((DivSrc1Addr == DivCsrAddr ) & DivCsrAble  & DivSrc1Able) ? DivCsrDate  : DivSrc1Date ;
    
    wire  [`DataBus] DSrc2Date   =  ((DivSrc2Addr == DivBruAddr ) & DivBruAble  & DivSrc2Able) ? DivBruDate  :
                                    ((DivSrc2Addr == DivAlu2Addr) & DivAlu2Able & DivSrc2Able) ? DivAlu2Date :
                                    ((DivSrc2Addr == DivMulAddr ) & DivMulAble  & DivSrc2Able) ? DivMulDate  :
                                    ((DivSrc2Addr == DivCsrAddr ) & DivCsrAble  & DivSrc2Able) ? DivCsrDate  : DivSrc2Date ;
    
    wire     [WIDTH_DIV-1:0]    UnsignDivisior  ;
    wire     [WIDTH_DIV-1:0]    UnsignDivdend   ;
    wire                        DivsignValue    ;
    assign DivsignValue   = DSrc2Date[31] ^ DSrc1Date[31];
    assign UnsignDivisior = (DSrc1Date[31])? ~DSrc1Date+1 : DSrc1Date ;
    assign UnsignDivdend  = (DSrc2Date[31])? ~DSrc2Date+1 : DSrc2Date ;

    wire                        Code1Selct      ;
    wire                        Code2Selct      ;
    wire                        Code3Selct      ;
    wire                        Code4Selct      ;
    wire                        Code5Selct      ;
    wire                        Code6Selct      ;
    wire                        Code7Selct      ;
    wire                        Code8Selct      ;
    assign Code1Selct     = UnsignDivisior[31]&UnsignDivisior[30]&UnsignDivisior[29]&UnsignDivisior[28];
    assign Code2Selct     = UnsignDivisior[27]&UnsignDivisior[26]&UnsignDivisior[25]&UnsignDivisior[24];
    assign Code3Selct     = UnsignDivisior[23]&UnsignDivisior[22]&UnsignDivisior[21]&UnsignDivisior[20];
    assign Code4Selct     = UnsignDivisior[19]&UnsignDivisior[18]&UnsignDivisior[17]&UnsignDivisior[16];
    assign Code5Selct     = UnsignDivisior[15]&UnsignDivisior[14]&UnsignDivisior[13]&UnsignDivisior[12];
    assign Code6Selct     = UnsignDivisior[11]&UnsignDivisior[10]&UnsignDivisior[9 ]&UnsignDivisior[8 ];
    assign Code7Selct     = UnsignDivisior[7 ]&UnsignDivisior[6 ]&UnsignDivisior[5 ]&UnsignDivisior[4 ];
    assign Code8Selct     = UnsignDivisior[3 ]&UnsignDivisior[2 ]&UnsignDivisior[1 ]&UnsignDivisior[0 ];  
  
    wire   [2:0]                 Code1ShiftSrc  ;
    wire   [2:0]                 Code2ShiftSrc  ;
    wire   [2:0]                 Code3ShiftSrc  ;
    wire   [2:0]                 Code4ShiftSrc  ;
    wire   [2:0]                 Code5ShiftSrc  ;
    wire   [2:0]                 Code6ShiftSrc  ;
    wire   [2:0]                 Code7ShiftSrc  ;
    wire   [2:0]                 Code8ShiftSrc  ;
   
    assign Code1ShiftSrc = ~UnsignDivisior[31] &  UnsignDivisior[30] ? 3'd1 :
                           ~UnsignDivisior[31] & ~UnsignDivisior[30] &  UnsignDivisior[29]  ? 3'd2 :
                           ~UnsignDivisior[31] & ~UnsignDivisior[30] & ~UnsignDivisior[29] &  UnsignDivisior[28] ? 3'd3 :
                           ~UnsignDivisior[31] & ~UnsignDivisior[30] & ~UnsignDivisior[29] & ~UnsignDivisior[28] ? 3'd4 :3'd0 ;
    assign Code2ShiftSrc = ~UnsignDivisior[27] &  UnsignDivisior[26] ? 3'd1 :
                           ~UnsignDivisior[27] & ~UnsignDivisior[26] &  UnsignDivisior[25]  ? 3'd2 :
                           ~UnsignDivisior[27] & ~UnsignDivisior[26] & ~UnsignDivisior[25] &  UnsignDivisior[24] ? 3'd3 :
                           ~UnsignDivisior[27] & ~UnsignDivisior[26] & ~UnsignDivisior[25] & ~UnsignDivisior[24] ? 3'd4 :3'd0 ;
    assign Code3ShiftSrc = ~UnsignDivisior[23] &  UnsignDivisior[22] ? 3'd1 :
                           ~UnsignDivisior[23] & ~UnsignDivisior[22] &  UnsignDivisior[21]  ? 3'd2 :
                           ~UnsignDivisior[23] & ~UnsignDivisior[22] & ~UnsignDivisior[21] &  UnsignDivisior[20] ? 3'd3 :
                           ~UnsignDivisior[23] & ~UnsignDivisior[22] & ~UnsignDivisior[21] & ~UnsignDivisior[20] ? 3'd4 :3'd0 ;
    assign Code4ShiftSrc = ~UnsignDivisior[19] &  UnsignDivisior[18] ? 3'd1 :
                           ~UnsignDivisior[19] & ~UnsignDivisior[18] &  UnsignDivisior[17]  ? 3'd2 :
                           ~UnsignDivisior[19] & ~UnsignDivisior[18] & ~UnsignDivisior[17] &  UnsignDivisior[16] ? 3'd3 :
                           ~UnsignDivisior[19] & ~UnsignDivisior[18] & ~UnsignDivisior[17] & ~UnsignDivisior[16] ? 3'd4 :3'd0 ;
    assign Code5ShiftSrc = ~UnsignDivisior[15] &  UnsignDivisior[14] ? 3'd1 :
                           ~UnsignDivisior[15] & ~UnsignDivisior[14] &  UnsignDivisior[13]  ? 3'd2 :
                           ~UnsignDivisior[15] & ~UnsignDivisior[14] & ~UnsignDivisior[13] &  UnsignDivisior[12] ? 3'd3 :
                           ~UnsignDivisior[15] & ~UnsignDivisior[14] & ~UnsignDivisior[13] & ~UnsignDivisior[12] ? 3'd4 :3'd0 ;
    assign Code6ShiftSrc = ~UnsignDivisior[11] &  UnsignDivisior[10] ? 3'd1 :
                           ~UnsignDivisior[11] & ~UnsignDivisior[10] &  UnsignDivisior[9 ]  ? 3'd2 :
                           ~UnsignDivisior[11] & ~UnsignDivisior[10] & ~UnsignDivisior[9 ] &  UnsignDivisior[8 ] ? 3'd3 :
                           ~UnsignDivisior[11] & ~UnsignDivisior[10] & ~UnsignDivisior[9 ] & ~UnsignDivisior[8 ] ? 3'd4 :3'd0 ;
    assign Code7ShiftSrc = ~UnsignDivisior[7 ] &  UnsignDivisior[6 ] ? 3'd1 :
                           ~UnsignDivisior[7 ] & ~UnsignDivisior[6 ] &  UnsignDivisior[5 ]  ? 3'd2 : 
                           ~UnsignDivisior[7 ] & ~UnsignDivisior[6 ] & ~UnsignDivisior[5 ] &  UnsignDivisior[4 ] ? 3'd3 :
                           ~UnsignDivisior[7 ] & ~UnsignDivisior[6 ] & ~UnsignDivisior[5 ] & ~UnsignDivisior[4 ] ? 3'd4 :3'd0 ;
    assign Code8ShiftSrc = ~UnsignDivisior[3 ] &  UnsignDivisior[2 ] ? 3'd1 :
                           ~UnsignDivisior[3 ] & ~UnsignDivisior[2 ] &  UnsignDivisior[1 ]  ? 3'd2 :
                           ~UnsignDivisior[3 ] & ~UnsignDivisior[2 ] & ~UnsignDivisior[1 ] &  UnsignDivisior[0 ] ? 3'd3 :
                           ~UnsignDivisior[3 ] & ~UnsignDivisior[2 ] & ~UnsignDivisior[1 ] & ~UnsignDivisior[0 ] ? 3'd4 :3'd0 ;

    wire   [5:0]         ShiftCode ;
    assign ShiftCode = Code1Selct ? {3'b0,Code1ShiftSrc}: //+0
                       Code2Selct ? (Code2ShiftSrc[2]? {2'b0,1'b1,3'b0}: {3'b0,1'b1, Code2ShiftSrc[1:0]}) : //+4
                       Code3Selct ? {2'b0,1'b1,Code3ShiftSrc} : //+8
                       Code4Selct ? (Code4ShiftSrc[2]? {1'b0,1'b1,4'b0}: {2'b0,2'b11,Code4ShiftSrc[1:0]}) : //+12
                       Code5Selct ? {1'b0,1'b1,1'b0,Code5ShiftSrc} : //+16
                       Code6Selct ? (Code6ShiftSrc[2]? {1'b0,2'b11,3'b0}: {1'b0,1'b1,1'b0,1'b1,Code6ShiftSrc[1:0]}) : //+20
                       Code7Selct ? {1'b0,2'b11,Code7ShiftSrc} : //+24
                       Code8Selct ? {Code8ShiftSrc[2]? {1'b1,5'b0}: {1'b0,3'b111,Code8ShiftSrc[1:0]}} : 6'd32 ; //+28

    wire   [WIDTH_DIV-1:0]  DivisiorTemp; //没有符号扩展因为在选取数据时已经是无符号，这样可以减少lead zero counter 和select quotient的电路复杂性
    wire   [WIDTH_DIV+2:0]  DividendTemp;
    wire   [5:0]            IterationsDub;
    assign DivisiorTemp = DSrc1Date <<ShiftCode ;
    assign DividendTemp = ShiftCode[0] ? {3'b0,UnsignDivdend} : {2'b0,UnsignDivdend,1'b0};
    assign IterationsDub= ShiftCode[0] ? ShiftCode+1 : ShiftCode ;
    

    wire   [WIDTH_DIV+2:0]  DivTempNext= (QOut == `PosiQuit2)? DivedRegdata - {1'b1,DivisiorData,2'b0} :
                                         (QOut == `PosiQuit1)? DivedRegdata - {2'b0,DivisiorData,1'b0} :
                                         (QOut == `ZeroQuit0)? DivedRegdata                            :
                                         (QOut == `NegiQuit1)? DivedRegdata + {2'b0,DivisiorData,1'b0} :
                                         (QOut == `NegiQuit1)? DivedRegdata + {1'b0,DivisiorData,2'b0} :
                                         35'h0              ;
    wire   [WIDTH_DIV+2:0]  DivDataNext = DivTempNext << 2 ;

    reg    [WIDTH_DIV+2:0]  DivedRegdata;
    reg    [WIDTH_DIV-1:0]  DivisiorData;
    reg                     DivSignReg  ;
    reg    [`MicOperateCode]DivOpcodeReg;
    reg    [`ReNameRegBUs]  DivDataAddr ;
    reg    [2:0]            DivState    ;
    reg    [5:0]            Iteration   ;
    reg    [WIDTH_DIV-1:0]  DivsiorTemp ;
    reg    [5:0]            DivRobPtrTemp ;

    always @(posedge Clk) begin
        if(!Rest) begin
            DivedRegdata <=  35'd0   ;
            DivisiorData <= `ZeorDate;
            DivSignReg   <= 1'b0     ;
            DivOpcodeReg <= 8'd0     ;
            DivDataAddr  <= 7'd0     ;
            DivState     <= `DivIdle ;
            Iteration    <= 6'd0     ;
            DivsiorTemp  <= `ZeorDate;
            DivRobPtrTemp<= 6'd0     ;
        end 
        else if(DivStop) begin
            DivedRegdata <= DivedRegdata  ;
            DivisiorData <= DivisiorData  ;
            DivSignReg   <= DivSignReg    ;
            DivOpcodeReg <= DivOpcodeReg  ;
            DivDataAddr  <= DivDataAddr   ;
            DivState     <= DivState      ;
            Iteration    <= Iteration     ;
            DivsiorTemp  <= DivsiorTemp   ;
            DivRobPtrTemp<= DivRobPtrTemp ;
        end
        else if(DivFlash) begin
            DivedRegdata <=  35'd0   ;
            DivisiorData <= `ZeorDate;
            DivSignReg   <= 1'b0     ;
            DivOpcodeReg <= 8'd0     ;
            DivDataAddr  <= 7'd0     ;
            DivState     <= `DivIdle ;
            Iteration    <= 6'd0     ;
            DivsiorTemp  <= `ZeorDate;
            DivRobPtrTemp<= 6'd0     ;
        end
        else begin
                case (DivState) 
                    `DivIdle: begin if(DivInstAble) begin //还缺少一种除零的情况，后续添加
                                    DivedRegdata <=  DividendTemp; 
                                    DivisiorData <=  DivisiorTemp;
                                    DivSignReg   <=  DivsignValue;
                                    DivOpcodeReg <=  DivMicopcode;
                                    DivDataAddr  <=  DivRdAddr   ; 
                                    DivState     <=  `DivItir    ; 
                                    Iteration    <=  IterationsDub;
                                    DivsiorTemp  <=  UnsignDivisior;
                                    DivRobPtrTemp<=  DivROBPtr     ;end 
                              else begin
                                    DivedRegdata <=  35'd0   ;
                                    DivisiorData <= `ZeorDate;
                                    DivSignReg   <= 1'b0     ;
                                    DivOpcodeReg <= 8'd0     ;
                                    DivDataAddr  <= 7'd0     ;
                                    DivState     <= `DivIdle ;
                                    Iteration    <= 6'd0     ;
                                    DivsiorTemp  <= `ZeorDate;
                                    DivRobPtrTemp<= 6'd0     ;end
                    end 
                    `DivItir: begin  if(Iteration > 0)begin 
                                    DivedRegdata <=  DivDataNext ; 
                                    DivisiorData <=  DivisiorData;
                                    DivSignReg   <=  DivSignReg  ;
                                    DivOpcodeReg <=  DivOpcodeReg;
                                    DivDataAddr  <=  DivDataAddr ; 
                                    DivState     <=  `DivItir    ; 
                                    Iteration    <=  Iteration-2 ;
                                    DivsiorTemp  <=  DivsiorTemp ;
                                    DivRobPtrTemp<=  DivRobPtrTemp;end 
                                else begin
                                    DivedRegdata <=  DivedRegdata;
                                    DivisiorData <=  DivisiorData;
                                    DivSignReg   <=  DivSignReg  ;
                                    DivOpcodeReg <=  DivOpcodeReg;
                                    DivDataAddr  <=  DivDataAddr ; 
                                    DivState     <=  `DivOut     ; 
                                    Iteration    <=  Iteration   ;
                                    DivsiorTemp  <=  DivsiorTemp ;
                                    DivRobPtrTemp<=  DivRobPtrTemp;end 
                    end 
                    `DivOut : begin
                                    DivedRegdata <=  DivedRegdata;
                                    DivisiorData <=  DivisiorData;
                                    DivSignReg   <=  DivSignReg  ;
                                    DivOpcodeReg <=  DivOpcodeReg;
                                    DivDataAddr  <=  DivDataAddr ; 
                                    DivState     <=  `DivIdle    ; 
                                    Iteration    <=  Iteration   ;
                                    DivsiorTemp  <=  DivsiorTemp ;
                                    DivRobPtrTemp<=  DivRobPtrTemp;end  
                    default : begin
                                    DivedRegdata <=  35'd0   ;
                                    DivisiorData <= `ZeorDate;
                                    DivSignReg   <= 1'b0     ;
                                    DivOpcodeReg <= 8'd0     ;
                                    DivDataAddr  <= 7'd0     ;
                                    DivState     <= `DivIdle ;
                                    Iteration    <= 6'd0     ;
                                    DivsiorTemp  <= `ZeorDate;
                                    DivRobPtrTemp<= 6'd0     ;end
                endcase
        end
    end

    wire [3:0] DivisiorIn ;
    wire [5:0] DividendIn ;
    wire [2:0] QOut       ;

    assign DivisiorIn = DivisiorData[WIDTH_DIV-1:WIDTH_DIV-4];
    assign DividendIn = DivedRegdata[WIDTH_DIV+2:WIDTH_DIV-3];

    SelecQuotient SDQ(
        .DivisiorSq (DivisiorIn),
        .DividendSq (DividendIn),
        .Quotient   (QOut      )
    );

    wire [2:0]      SelectIn    ;
    wire            OFCAble     ;
    wire [`DataBus] QuotientOut ;

    assign SelectIn = QOut ;
    assign OFCAble  = (DivState <= `DivItir);
    
    OneFlyConversion OFC (
        .Clk           (Clk         ),
        .Rest          (Rest        ),

        .OfcStop       (DivStop     ),
        .OfcFlash      (DivFlash    ),
    
        .SelectQuite   (SelectIn    ),
        .FlyConverStart(OFCAble     ),
        .QuotientData  (QuotientOut )
    );

    wire [WIDTH_DIV+2:0] ReminderTemp ;
    wire [WIDTH_DIV-1:0] QuotitentTemp;
    wire [WIDTH_DIV-1:0] QuotitentSign;
    assign ReminderTemp = DivedRegdata[WIDTH_DIV+2]? DivedRegdata+{2'b0,DivsiorTemp} : DivedRegdata;
    assign QuotitentTemp= DivedRegdata[WIDTH_DIV+2]? QuotientOut-1 : QuotientOut;
    assign QuotitentSign= DivSignReg ? ~QuotitentTemp + 1 : QuotitentTemp ;
    assign DivReq = ((DivState == `DivOut) | (DivState == `DivIdle)) & ~DivInstAble;
    assign {DivWBAble,DivWBAddr,DivWBDate} = ((DivState == `DivOut) & ((DivOpcodeReg == `InstDivw) | (DivOpcodeReg == `InstDivwu)))? {`AbleValue,DivDataAddr,QuotitentSign} :
                                                     ((DivState == `DivOut) & ((DivOpcodeReg == `InstModw) | (DivOpcodeReg == `InstModwu)))? {`AbleValue,DivDataAddr,ReminderTemp[31:0] } : {`EnableValue,7'b0,`ZeorDate};

    assign {DivCommitAble, DivCommitPtr} = (DivState == `DivOut) ? {`AbleValue,DivRobPtrTemp} : {`EnableValue,6'd0};

endmodule


module SelecQuotient (
    input     wire           [3:0]                   DivisiorSq,
    input     wire  signed   [5:0]                   DividendSq,

    output                   [2:0]                   Quotient  
); 

    wire SelectDivisior1000 = (DivisiorSq == 4'b1000) ;
    wire SelectDivisior1001 = (DivisiorSq == 4'b1001) ;
    wire SelectDivisior1010 = (DivisiorSq == 4'b1010) ;
    wire SelectDivisior1011 = (DivisiorSq == 4'b1011) ;
    wire SelectDivisior1100 = (DivisiorSq == 4'b1100) ;
    wire SelectDivisior1101 = (DivisiorSq == 4'b1101) ;
    wire SelectDivisior1110 = (DivisiorSq == 4'b1110) ;
    wire SelectDivisior1111 = (DivisiorSq == 4'b1111) ;


    wire ForDivsorP4   = (DividendSq >=  4) ;
    wire ForDivsorP6   = (DividendSq >=  6) ;
    wire ForDivsorP8   = (DividendSq >=  8) ;
    wire ForDivsorP12  = (DividendSq >=  12);
    wire ForDivsorP14  = (DividendSq >=  14);
    wire ForDivsorP15  = (DividendSq >=  15);
    wire ForDivsorP16  = (DividendSq >=  16);
    wire ForDivsorP18  = (DividendSq >=  18);
    wire ForDivsorP20  = (DividendSq >=  20);
    wire ForDivsorP24  = (DividendSq >=  24);
    wire ForDivsorN24  = (DividendSq >= -24);
    wire ForDivsorN22  = (DividendSq >= -22);
    wire ForDivsorN20  = (DividendSq >= -20);
    wire ForDivsorN18  = (DividendSq >= -18);
    wire ForDivsorN16  = (DividendSq >= -16);
    wire ForDivsorN15  = (DividendSq >= -15);
    wire ForDivsorN13  = (DividendSq >= -13);
    wire ForDivsorN8   = (DividendSq >= -8) ;
    wire ForDivsorN6   = (DividendSq >= -6) ;
    wire ForDivsorN4   = (DividendSq >= -4) ;

    wire For1000QP2 = (SelectDivisior1000 &  ForDivsorP12)                            ;
    wire For1000QP1 = (SelectDivisior1000 &  ForDivsorP4  & ~ForDivsorP12)            ;
    wire For1000Q00 = (SelectDivisior1000 & ~ForDivsorP4  &  ForDivsorN4)             ;
    wire For1000QN1 = (SelectDivisior1000 & ~ForDivsorN4  &  ForDivsorN13)            ;
    wire For1000QN2 = (SelectDivisior1000 & ~ForDivsorN13)                            ;

    wire For1001QP2 = (SelectDivisior1001 &  ForDivsorP14)                            ;
    wire For1001QP1 = (SelectDivisior1001 &  ForDivsorP4  & ~ForDivsorP14)            ;
    wire For1001Q00 = (SelectDivisior1001 & ~ForDivsorP4  &  ForDivsorN6)             ;
    wire For1001QN1 = (SelectDivisior1001 & ~ForDivsorN6  &  ForDivsorN15)            ;
    wire For1001QN2 = (SelectDivisior1001 & ~ForDivsorN15 )                           ;

    wire For1010QP2 = (SelectDivisior1010 &  ForDivsorP15)                            ;
    wire For1010QP1 = (SelectDivisior1010 & ~ForDivsorP15 &  ForDivsorP4)             ;
    wire For1010Q00 = (SelectDivisior1010 & ~ForDivsorP4  &  ForDivsorN6)             ;
    wire For1010QN1 = (SelectDivisior1010 & ~ForDivsorN6  &  ForDivsorN16)            ;
    wire For1010QN2 = (SelectDivisior1010 & ~ForDivsorN16)                            ;

    wire For1011QP2 = (SelectDivisior1011 &  ForDivsorP16)                            ;
    wire For1011QP1 = (SelectDivisior1011 & ~ForDivsorP16 &  ForDivsorP4)             ;
    wire For1011Q00 = (SelectDivisior1011 & ~ForDivsorP4  &  ForDivsorN6)             ;
    wire For1011QN1 = (SelectDivisior1011 & ~ForDivsorN6  &  ForDivsorN18)            ;
    wire For1011QN2 = (SelectDivisior1011 & ~ForDivsorN18)                            ;

    wire For1100QP2 = (SelectDivisior1100 &  ForDivsorP18)                            ;
    wire For1100QP1 = (SelectDivisior1100 & ~ForDivsorP18 & ForDivsorP6)              ;
    wire For1100Q00 = (SelectDivisior1100 & ~ForDivsorP6  & ForDivsorN8)              ;
    wire For1100QN1 = (SelectDivisior1100 & ~ForDivsorN8  & ForDivsorN20)             ;
    wire For1100QN2 = (SelectDivisior1100 & ~ForDivsorN20)                            ;

    wire For1101QP2 = (SelectDivisior1101 &  ForDivsorP20)                            ;
    wire For1101QP1 = (SelectDivisior1101 & ~ForDivsorP20 & ForDivsorP6)              ;
    wire For1101Q00 = (SelectDivisior1101 & ~ForDivsorP6  & ForDivsorN8)              ;
    wire For1101QN1 = (SelectDivisior1101 & ~ForDivsorN8  & ForDivsorN20)             ;
    wire For1101QN2 = (SelectDivisior1101 & ~ForDivsorN20)                            ;

    wire For1110QP2 = (SelectDivisior1110 &  ForDivsorP20)                            ;
    wire For1110QP1 = (SelectDivisior1110 & ~ForDivsorP20 & ForDivsorP8)              ;
    wire For1110Q00 = (SelectDivisior1110 & ~ForDivsorP8  & ForDivsorN8)              ;
    wire For1110QN1 = (SelectDivisior1110 & ~ForDivsorN8  & ForDivsorN22)             ;
    wire For1110QN2 = (SelectDivisior1110 & ~ForDivsorN22)                            ;

    wire For1111QP2 = (SelectDivisior1111 &  ForDivsorP24)                            ;  
    wire For1111QP1 = (SelectDivisior1111 & ~ForDivsorP24 & ForDivsorP8)              ;
    wire For1111Q00 = (SelectDivisior1111 & ~ForDivsorP8  & ForDivsorN8)              ;
    wire For1111QN1 = (SelectDivisior1111 & ~ForDivsorN8  & ForDivsorN24)             ;
    wire For1111QN2 = (SelectDivisior1111 & ~ForDivsorN24)                            ;

    wire Positive2  = For1000QP2 | For1001QP2 | For1010QP2 | For1011QP2 | For1100QP2 | For1101QP2 | For1110QP2 | For1111QP2 ;
    wire Positive1  = For1000QP1 | For1001QP1 | For1010QP1 | For1011QP1 | For1100QP1 | For1101QP1 | For1110QP1 | For1111QP1 ;
    wire Zero       = For1000Q00 | For1001Q00 | For1010Q00 | For1011Q00 | For1100Q00 | For1101Q00 | For1110Q00 | For1111Q00 ;
    wire Negitive1  = For1000QN1 | For1001QN1 | For1010QN1 | For1011QN1 | For1100QN1 | For1101QN1 | For1110QN1 | For1111QN1 ;
    wire Negitive2  = For1000QN2 | For1001QN2 | For1010QN2 | For1011QN2 | For1100QN2 | For1101QN2 | For1110QN2 | For1111QN2 ;

    assign Quotient = Positive2 ? `PosiQuit2 :
                      Positive1 ? `PosiQuit1 :
                      Zero      ? `ZeroQuit0 :
                      Negitive1 ? `NegiQuit1 :
                      Negitive2 ? `NegiQuit2 : 3'b111 ;
endmodule

module OneFlyConversion (
    input        wire                                        Clk           ,
    input        wire                                        Rest          ,

    input        wire                                        OfcStop       ,
    input        wire                                        OfcFlash      ,
  
    input        wire      [2:0]                             SelectQuite   ,
    input        wire                                        FlyConverStart,
    output       wire      [`DataBus]                        QuotientData 
);

    reg  [`DataBus] QuotiRegPreSub  ;
    reg  [`DataBus] QuotiReg        ;


    always @(posedge Clk) begin
        if(!Rest)begin
            QuotiRegPreSub <= `ZeorDate ;
            QuotiReg       <= `ZeorDate ;
        end 
        else if(OfcStop) begin
            QuotiRegPreSub <= QuotiRegPreSub ;
            QuotiReg       <= QuotiReg       ;
        end
        else if(OfcFlash) begin
            QuotiRegPreSub <= `ZeorDate ;
            QuotiReg       <= `ZeorDate ;
        end
        else begin
            if(FlyConverStart) begin
                case (SelectQuite)
                    `PosiQuit2: begin QuotiRegPreSub <= {QuotiReg[29:0],2'b01}      ; QuotiReg <= {QuotiReg[29:0],2'b10}      ; end 
                    `PosiQuit1: begin QuotiRegPreSub <= {QuotiReg[29:0],2'b00}      ; QuotiReg <= {QuotiReg[29:0],2'b01}      ; end 
                    `ZeroQuit0: begin QuotiRegPreSub <= {QuotiRegPreSub[29:0],2'b11}; QuotiReg <= {QuotiReg[29:0],2'b00}      ; end 
                    `NegiQuit1: begin QuotiRegPreSub <= {QuotiRegPreSub[29:0],2'b10}; QuotiReg <= {QuotiRegPreSub[29:0],2'b11}; end 
                    `NegiQuit2: begin QuotiRegPreSub <= {QuotiRegPreSub[29:0],2'b01}; QuotiReg <= {QuotiRegPreSub[29:0],2'b10}; end 
                    default   : begin QuotiRegPreSub <= `ZeorDate                   ; QuotiReg <= `ZeorDate                   ; end
                endcase
            end 
            else begin 
                QuotiRegPreSub <= `ZeorDate ;
                QuotiReg       <= `ZeorDate ;
            end 
        end 
    end

    assign QuotientData = QuotiReg ;
    
endmodule
