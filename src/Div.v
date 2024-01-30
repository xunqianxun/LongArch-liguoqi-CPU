`timescale 1ps/1ps
`include "define.v"

module Div #(
    parameter WIDTH_DIV = 32 
) (
    input      wire                                  Clk          ,
    input      wire                                  Rest         ,

    input      wire       [`MicOperateCode]          DivMicopcode ,
    input      wire                                  DivAbleValue ,
    input      wire       [WIDTH_DIV-1:0]            Divisior     ,
    input      wire       [WIDTH_DIV-1:0]            Dividend     ,
    input      wire       [`ArchRegBUs]              DivWriteBack ,

    output     wire       [WIDTH_DIV-1:0]            WriteBackData,
    output     wire       [`ArchRegBUs]              WriteBackAddr,
    output     wire                                  DivIqReq      

);
    
    wire     [WIDTH_DIV-1:0]    UnsignDivisior  ;
    wire     [WIDTH_DIV-1:0]    UnsignDivdend   ;
    assign UnsignDivisior = (Divisior[31])? ~Divisior+1 : Divisior ;
    assign UnsignDivdend  = (Dividend[31])? ~Dividend+1 : Dividend ;

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

    // wire                         Asign1         ;
    // assign Asign1 = ~UnsignDivisior[31] & ~UnsignDivisior[30];
    // wire                         Asign2         ;
    // assign Asign2 = Asign1 & ~UnsignDivisior[29]             ;
    // wire                         Asign3         ;
    // assign Asign3 = Asign2 & ~UnsignDivisior[28]             ;
    // assign Code1ShiftSrc  = ~nsignDivisior[31] ? 3'd1     :
    //                         Asign1             ? 3'd2     :
    //                         Asign2             ? 3'd3     : 
    //                         Asign3             ? 3'd4     :3'd0 ;    
    assign Code1ShiftSrc = ~UnsignDivisior[31] &  UnsignDivisior[30] ? 3'd1 :
                           ~UnsignDivisior[31] & ~UnsignDivisior[30] &  UnsignDivisior[29]  ? 3'd2 :
                           ~UnsignDivisior[31] & ~UnsignDivisior[30] & ~UnsignDivisior[29] &  UnsignDivisior[28] ? 3'd3 :
                           ~UnsignDivisior[31] & ~UnsignDivisior[30] & ~UnsignDivisior[29] & ~UnsignDivisior[28] ? 3'd4 :3'd0 ;
    assign Code1ShiftSrc = ~UnsignDivisior[27] &  UnsignDivisior[26] ? 3'd1 :
                           ~UnsignDivisior[27] & ~UnsignDivisior[26] &  UnsignDivisior[25]  ? 3'd2 :
                           ~UnsignDivisior[27] & ~UnsignDivisior[26] & ~UnsignDivisior[25] &  UnsignDivisior[24] ? 3'd3 :
                           ~UnsignDivisior[27] & ~UnsignDivisior[26] & ~UnsignDivisior[25] & ~UnsignDivisior[24] ? 3'd4 :3'd0 ;
    assign Code1ShiftSrc = ~UnsignDivisior[23] &  UnsignDivisior[22] ? 3'd1 :
                           ~UnsignDivisior[23] & ~UnsignDivisior[22] &  UnsignDivisior[21]  ? 3'd2 :
                           ~UnsignDivisior[23] & ~UnsignDivisior[22] & ~UnsignDivisior[21] &  UnsignDivisior[20] ? 3'd3 :
                           ~UnsignDivisior[23] & ~UnsignDivisior[22] & ~UnsignDivisior[21] & ~UnsignDivisior[20] ? 3'd4 :3'd0 ;
    assign Code1ShiftSrc = ~UnsignDivisior[19] &  UnsignDivisior[18] ? 3'd1 :
                           ~UnsignDivisior[19] & ~UnsignDivisior[18] &  UnsignDivisior[17]  ? 3'd2 :
                           ~UnsignDivisior[19] & ~UnsignDivisior[18] & ~UnsignDivisior[17] &  UnsignDivisior[16] ? 3'd3 :
                           ~UnsignDivisior[19] & ~UnsignDivisior[18] & ~UnsignDivisior[17] & ~UnsignDivisior[16] ? 3'd4 :3'd0 ;
    assign Code1ShiftSrc = ~UnsignDivisior[15] &  UnsignDivisior[14] ? 3'd1 :
                           ~UnsignDivisior[15] & ~UnsignDivisior[14] &  UnsignDivisior[13]  ? 3'd2 :
                           ~UnsignDivisior[15] & ~UnsignDivisior[14] & ~UnsignDivisior[13] &  UnsignDivisior[12] ? 3'd3 :
                           ~UnsignDivisior[15] & ~UnsignDivisior[14] & ~UnsignDivisior[13] & ~UnsignDivisior[12] ? 3'd4 :3'd0 ;
    assign Code1ShiftSrc = ~UnsignDivisior[11] &  UnsignDivisior[10] ? 3'd1 :
                           ~UnsignDivisior[11] & ~UnsignDivisior[10] &  UnsignDivisior[9 ]  ? 3'd2 :
                           ~UnsignDivisior[11] & ~UnsignDivisior[10] & ~UnsignDivisior[9 ] &  UnsignDivisior[8 ] ? 3'd3 :
                           ~UnsignDivisior[11] & ~UnsignDivisior[10] & ~UnsignDivisior[9 ] & ~UnsignDivisior[8 ] ? 3'd4 :3'd0 ;
    assign Code1ShiftSrc = ~UnsignDivisior[7 ] &  UnsignDivisior[6 ] ? 3'd1 :
                           ~UnsignDivisior[7 ] & ~UnsignDivisior[6 ] &  UnsignDivisior[5 ]  ? 3'd2 : 
                           ~UnsignDivisior[7 ] & ~UnsignDivisior[6 ] & ~UnsignDivisior[5 ] &  UnsignDivisior[4 ] ? 3'd3 :
                           ~UnsignDivisior[7 ] & ~UnsignDivisior[6 ] & ~UnsignDivisior[5 ] & ~UnsignDivisior[4 ] ? 3'd4 :3'd0 ;
    assign Code1ShiftSrc = ~UnsignDivisior[3 ] &  UnsignDivisior[2 ] ? 3'd1 :
                           ~UnsignDivisior[3 ] & ~UnsignDivisior[2 ] &  UnsignDivisior[1 ]  ? 3'd2 :
                           ~UnsignDivisior[3 ] & ~UnsignDivisior[2 ] & ~UnsignDivisior[1 ] &  UnsignDivisior[0 ] ? 3'd3 :
                           ~UnsignDivisior[3 ] & ~UnsignDivisior[2 ] & ~UnsignDivisior[1 ] & ~UnsignDivisior[0 ] ? 3'd4 :3'd0 ;

    wire   [5:0]         ShiftCode ;
    assign ShiftCode = Code1Selct ? {3'b0,Code1ShiftSrc}: //+0
                       Code2Selct ? (Code2ShiftSrc[2]? {2'b0,1'b1,3'b0}: {3'b0,1'b1, Code2ShiftSrc[1:0]}) : //+4
                       Code3Selct ? {2'b0,1'b1,Code3ShiftSrc} : //+8
                       Code4Selct ? (Code4ShiftSrc[2]? {1'b0,1'b1,3'b0}: {2'b0,2'b11,Code4ShiftSrc[1:0]}) : //+12
                       Code5Selct ? {1'b0,1'b1,1'b0,Code5ShiftSrc} : //+16
                       Code6Selct ? (Code6ShiftSrc[2]? {1'b0,2'b11,3'b0}: {1'b0,1'b1,1'b0,1'b1,Code6ShiftSrc[1:0]}) : //+20
                       Code7Selct ? {1'b0,2'b11,Code7ShiftSrc} : //+24
                       Code8Selct ? {Code8ShiftSrc[2]? {1'b1,5'b0}: {1'b0,3'b111,Code8ShiftSrc[1:0]}} : 6'd32 ; //+28

    wire   [WIDTH_DIV-1:0]  DivisiorTemp; //没有符号扩展因为在选取数据时已经是无符号，这样可以减少lead zero counter 和select quotient的电路复杂性
    wire   [WIDTH_DIV+2:0]  DividendTemp;
    wire   [5:0]            IterationsDub;
    assign DivisiorTemp = Divisior <<ShiftCode ;
    assign DividendTemp = ShiftCode[0] ? {3'b0,Dividend} : {2'b0,Dividend,1'b0};
    assign IterationsDub= ShiftCode[0] ? ShiftCode+1 : ShiftCode ;
    

    wire   [WIDTH_DIV+2:0]  DivDataNext= (QOut == `PosiQuit2)? DivedRegdata - {1'b1,UnsignDivisior,2'b0} :
                                         (QOut == `PosiQuit1)? DivedRegdata - {2'b0,UnsignDivisior,1'b0} :
                                         (QOut == `ZeroQuit0)? DivedRegdata                              :
                                         (QOut == `NegiQuit1)? DivedRegdata + {2'b0,UnsignDivisior,1'b0} :
                                         (QOut == `NegiQuit1)? DivedRegdata + {1'b0,UnsignDivisior,2'b0} :
                                         34'h0              ;

    reg    [WIDTH_DIV+2:0]  DivedRegdata;
    reg    [2:0]            DivState    ;
    reg    [5:0]            Iteration   ;

    always @(posedge Clk) begin
        if(!Rest) begin
            DivedRegdata <= `35'd0  ;
            DivState     <= `DivIdle;
            Iteration    <= 6'd0    ;
        end 
        else begin
            if(DivAbleValue) begin
                case (DivState)
                    `DivIdle: begin DivedRegdata <=  DividendTemp; DivState <= `DivItir; Iteration <=ShiftCode end 
                    `DivItir: begin  
                                if(Iteration > 0)begin 
                                    DivedRegdata <=  DivDataNext ; iv
                                end 
                                else begin

                                end 
                              end 
                    default: 
                endcase
            end 
            else begin
                DivedRegdata <= `35'd0  ;
                DivState     <= `DivIdle;
                Iteration    <= 6'd0    ;
            end 
        end
    end

    wire [3:0] DivisiorIn ;
    wire [5:0] DividendIn ;
    wire [2:0] QOut       ;
    SelecQuotient SDQ(
        .DivisiorSq (DivisiorIn),
        .DividendSq (DividendIn),
        .Quotient   (QOut      )
    );

    wire [2:0]      SelectIn    ;
    wire            OFCAble     ;
    wire [`DataBus] QuotientOut ;
    
    OneFlyConversion OFC (
        .Clk           (Clk         ),
        .Rest          (Rest        ),
    
        .SelectQuite   (SelectIn    ),
        .FlyConverStart(OFCAble     ),
        .QuotientData  (QuotientOut )
    );


    
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
  
    input        wire      [2:0]                             SelectQuite   ,
    input        wire                                        FlyConverStart,
    output       wire      [`DataBus]                        QuotientData 
);

    reg  [`DataBus] QuotiRegPreSub  ;
    reg  [`DataBus] QuotiReg        ;

    // wire [`DataBus] QuotiTempPreSub ;
    // wire [`DataBus] QuotiTemp       ;
    // assign QuotiTempPreSub =  (FlyConverStart & (SelectQuite == `PosiQuit2))? {QuotiReg,2'b01}       :
    //                           (FlyConverStart & (SelectQuite == `PosiQuit1))? {QuotiReg,2'b00}       :
    //                           (FlyConverStart & (SelectQuite == `ZeroQuit0))? {QuotiRegPreSub,2'b11} :
    //                           (FlyConverStart & (SelectQuite == `NegiQuit1))? {QuotiRegPreSub,2'b10} :
    //                           (FlyConverStart & (SelectQuite == `NegiQuit2))? {QuotiRegPreSub,2'b01} : `ZeorDate;

    // assign QuotiTemp       =  (FlyConverStart & (SelectQuite == `PosiQuit2))? {QuotiReg,2'b10}       :
    //                           (FlyConverStart & (SelectQuite == `PosiQuit1))? {QuotiReg,2'b01}       :
    //                           (FlyConverStart & (SelectQuite == `ZeroQuit0))? {QuotiReg,2'b00}       :
    //                           (FlyConverStart & (SelectQuite == `NegiQuit1))? {QuotiRegPreSub,2'b11} :
    //                           (FlyConverStart & (SelectQuite == `NegiQuit2))? {QuotiRegPreSub,2'b10} : `ZeorDate;

    always @(posedge Clk) begin
        if(!Rest)begin
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
    
endmodule