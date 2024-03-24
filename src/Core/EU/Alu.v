`timescale 1ps/1ps
`include "define.v"

module Alu #(
    parameter WIDTH_ALU = 32
) (
    input        wire                           Clk           ,
    input        wire                           Rest          ,
    
    input        wire      [`MicOperateCode]    AluMicOperate ,
    input        wire      [WIDTH_ALU-1:0]      ArchRegister1 ,
    input        wire      [WIDTH_ALU-1:0]      ArchRegister2 ,
    input        wire      [WIDTH_ALU-1:0]      JumpOffset    ,
    input        wire      [`ArchRegBUs]        ReDataAddr    ,
    input        wire      [WIDTH_ALU-1:0]      AluInstAddr   ,
    input        wire                           PredictValue  ,   

    output       wire      [WIDTH_ALU-1:0]      OutReData     ,
    output       wire      [`ArchRegBUs]        OutReDataAddr ,
    output       wire                           OutDataAble   , 
    output       wire                           JumpExvalue   ,
    output       wire      [WIDTH_ALU-1:0]      JumpExPc      ,
    output       wire                           ReqIsQInst    
);
    wire signed [WIDTH_ALU-1:0] SignedReg1    ;
    wire signed [WIDTH_ALU-1:0] SignedReg2    ;
    wire signed [WIDTH_ALU-1:0] SignedOffset  ;
    wire [WIDTH_ALU-1:0]        SluExtend  ;
    wire [WIDTH_ALU-1:0]        SluExtendU ;
    wire unsigned [4:0]         ShiftNumb  ;
    wire [WIDTH_ALU-1:0]        ShiftReg   ;
    assign SignedReg1   = ArchRegister1      ;
    assign SignedReg2   = ArchRegister2      ;
    assign SignedOffset = JumpOffset         ;   

    assign SluExtend   = (SignedReg1 < SignedReg2)?{{31{1'b0}},1'b1}:`ZeorDate       ; 
    assign SluExtendU  = (ArchRegister1 < ArchRegister2)?{{31{1'b0}},1'b1}:`ZeorDate ;
    assign ShiftNumb   = ArchRegister2[4:0]                                          ;
    assign ShiftReg    = ({32{ArchRegister1[31]}}<<(6'd32-{1'b0,ShiftNumb}))|(ArchRegister1 >> ShiftNumb) ;


    reg  [WIDTH_ALU-1:0] AluData              ;
    reg                  RdBackValue          ;
    reg                  ReqValue1            ;
    always @(posedge Clk) begin
        if(!Rest)begin
            AluData     <= `ZeorDate      ;
            RdBackValue <= `EnableValue   ;
            ReqValue1   <= `AbleValue     ;
        end 
        else begin
            case (AluMicOperate)
                `InstAddw    ,`InstAddiw   : begin AluData <= ArchRegister1 + ArchRegister2       ; RdBackValue <= `AbleValue ; ReqValue1 <= `AbleValue; end 
                `InstSubw                  : begin AluData <= ArchRegister1 - ArchRegister2       ; RdBackValue <= `AbleValue ; ReqValue1 <= `AbleValue; end 
                `InstLu12iw                : begin AluData <= ArchRegister1                       ; RdBackValue <= `AbleValue ; ReqValue1 <= `AbleValue; end 
                `InstSlt     ,`InstSlti    : begin AluData <= SluExtend                           ; RdBackValue <= `AbleValue ; ReqValue1 <= `AbleValue; end 
                `InstSltu    ,`InstSltui   : begin AluData <= SluExtendU                          ; RdBackValue <= `AbleValue ; ReqValue1 <= `AbleValue; end 
                `InstAddu12i               : begin AluData <= ArchRegister1 + ArchRegister2       ; RdBackValue <= `AbleValue ; ReqValue1 <= `AbleValue; end 
                `InstAnd     ,`InstAndi    : begin AluData <= ArchRegister1 & ArchRegister2       ; RdBackValue <= `AbleValue ; ReqValue1 <= `AbleValue; end 
                `InstOr      ,`InstOri     : begin AluData <= ArchRegister1 | ArchRegister2       ; RdBackValue <= `AbleValue ; ReqValue1 <= `AbleValue; end 
                `InstNor                   : begin AluData <= ~(ArchRegister1 | ArchRegister2)    ; RdBackValue <= `AbleValue ; ReqValue1 <= `AbleValue; end 
                `InstXor     ,`InstXori    : begin AluData <= ArchRegister1 ^ ArchRegister2       ; RdBackValue <= `AbleValue ; ReqValue1 <= `AbleValue; end 
                `InstSllw    ,`InstSlliw   : begin AluData <= ArchRegister1 << ShiftNumb          ; RdBackValue <= `AbleValue ; ReqValue1 <= `AbleValue; end 
                `InstSrlw    ,`InstSrliw   : begin AluData <= ArchRegister1 >> ShiftNumb          ; RdBackValue <= `AbleValue ; ReqValue1 <= `AbleValue; end 
                `InstSraw    ,`InstSraiw   : begin AluData <= ShiftReg                            ; RdBackValue <= `AbleValue ; ReqValue1 <= `AbleValue; end 
                `InstBl      ,`InstJirl    : begin AluData <= AluInstAddr + 32'd4                 ; RdBackValue <= `AbleValue ; ReqValue1 <= `AbleValue; end 
                default                    : begin AluData <= `ZeorDate                           ; RdBackValue <= `EnableValue ;  ReqValue1 <= `EnableValue; end 
            endcase
        end
    end

    reg                   JumpValue ;
    reg  [WIDTH_ALU-1:0]  NewPc     ;
    reg                   ReqValue2 ;
    always @(posedge Clk) begin 
        if(!Rest)begin
            JumpValue <= `EnableValue ;
            NewPc     <= `ZeorDate    ;
            ReqValue2 <= `AbleValue   ;
        end 
        else begin
            case (AluMicOperate)
                `InstBeq   : begin 
                             ReqValue2 <= `AbleValue;
                             if((SignedReg1 == SignedReg2) == (!PredictValue))      begin NewPc <= AluInstAddr + SignedOffset ; JumpValue <= `AbleValue   ; end 
                             else if(!(SignedReg1 == SignedReg2) == (PredictValue)) begin NewPc <= AluInstAddr + 32'd4        ; JumpValue <= `AbleValue   ; end
                             else                                                   begin NewPc <= `ZeorDate                  ; JumpValue <= `EnableValue ; end
                             end 
                `InstBne   : begin 
                             ReqValue2 <= `AbleValue;
                             if((SignedReg1 != SignedReg2) == (!PredictValue))      begin NewPc <= AluInstAddr + SignedOffset ; JumpValue <= `AbleValue   ; end 
                             else if(!(SignedReg1 != SignedReg2) == (PredictValue)) begin NewPc <= AluInstAddr + 32'd4        ; JumpValue <= `AbleValue   ; end                                 
                             else                                                   begin NewPc <= `ZeorDate                  ; JumpValue <= `EnableValue ; end
                             end 
                `InstBlt   : begin 
                             ReqValue2 <= `AbleValue;
                             if((SignedReg1 < SignedReg2) == (!PredictValue))       begin NewPc <= AluInstAddr + SignedOffset ; JumpValue <= `AbleValue   ; end 
                             else if(!(SignedReg1 < SignedReg2) == (PredictValue))  begin NewPc <= AluInstAddr + 32'd4        ; JumpValue <= `AbleValue   ; end  
                             else                                                   begin NewPc <= `ZeorDate                  ; JumpValue <= `EnableValue ; end
                             end 
                `InstBge   : begin 
                             ReqValue2 <= `AbleValue;
                             if((SignedReg1 >= SignedReg2) == (!PredictValue))       begin NewPc <= AluInstAddr + SignedOffset ; JumpValue <= `AbleValue   ; end 
                             else if(!(SignedReg1 >= SignedReg2) == (PredictValue))  begin NewPc <= AluInstAddr + 32'd4        ; JumpValue <= `AbleValue   ; end
                             else                                                    begin NewPc <= `ZeorDate                  ; JumpValue <= `EnableValue ; end
                             end 
                `InstBltu  : begin
                             ReqValue2 <= `AbleValue; 
                             if((ArchRegister1 < ArchRegister2) == (!PredictValue))       begin NewPc <= AluInstAddr + JumpOffset   ; JumpValue <= `AbleValue   ; end 
                             else if(!(ArchRegister1 < ArchRegister2) == (PredictValue))  begin NewPc <= AluInstAddr + 32'd4        ; JumpValue <= `AbleValue   ; end
                             else                                                         begin NewPc <= `ZeorDate                  ; JumpValue <= `EnableValue ; end
                             end 
                `InstBgeu  : begin 
                             ReqValue2 <= `AbleValue;
                             if((ArchRegister1 >= ArchRegister2) == (!PredictValue))       begin NewPc <= AluInstAddr + JumpOffset   ; JumpValue <= `AbleValue   ; end 
                             else if(!(ArchRegister1 >= ArchRegister2) == (PredictValue))  begin NewPc <= AluInstAddr + 32'd4        ; JumpValue <= `AbleValue   ; end
                             else                                                          begin NewPc <= `ZeorDate                  ; JumpValue <= `EnableValue ; end
                             end 
                `InstB  ,`InstBl  ,`InstJirl : begin NewPc     <= AluInstAddr + SignedOffset   ; JumpValue <= `AbleValue   ; ReqValue2 <= `AbleValue  ; end
                default                      : begin NewPc     <= `ZeorDate                    ; JumpValue <= `EnableValue ; ReqValue2 <= `EnableValue;end
            endcase
        end
    end

    assign OutReDataAddr = ReDataAddr   ;
    assign OutReData     = AluData      ;
    assign OutDataAble   = RdBackValue  ;
    assign JumpExvalue   = JumpValue    ;
    assign ReqIsQInst    = ReqValue1 | ReqValue2;
    assign JumpExPc      = NewPc        ;

endmodule
