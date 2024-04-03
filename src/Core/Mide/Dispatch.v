`timescale 1ps/1ps
`include "../define.v"

module Dispatch (
    input       wire                                Clk           ,
    input       wire                                Rest          ,
    //for ctrl
    inout       wire                                DispatchStop  ,
    input       wire                                DispatchFlash ,
    output      wire                                DIspatchReqs  ,
    //from decode 
    input       wire      [`InstAddrBus]            Way1Addr      ,
    input       wire      [`MicOperateCode]         Way1Opcode    ,
    input       wire                                Way1ImmAble   ,
    input       wire      [25:0]                    Way1ImmDate   ,
    input       wire                                Way1Src1Able  ,
    input       wire      [`ArchRegBUs]             Way1Src1Numb  ,
    input       wire                                Way1Src2Able  ,   
    input       wire      [`ArchRegBUs]             Way1Src2Numb  ,
    input       wire                                Way1WriteAble ,
    input       wire                                Way1Part      ,  // jump mode
    input       wire      [`InstAddrBus]            Way1Nadr      ,
    input       wire      [`ArchRegBUs]             Way1WritNumb  ,
    input       wire      [`InstAddrBus]            Way2Addr      ,
    input       wire      [`MicOperateCode]         Way2Opcode    ,
    input       wire                                Way2ImmAble   ,
    input       wire      [25:0]                    Way2ImmDate   ,
    input       wire                                Way2Src1Able  ,
    input       wire      [`ArchRegBUs]             Way2Src1Numb  ,
    input       wire                                Way2Src2Able  ,   
    input       wire      [`ArchRegBUs]             Way2Src2Numb  ,
    input       wire                                Way2WriteAble ,
    input       wire                                Way2Part      ,  // jump mode
    input       wire      [`InstAddrBus]            Way2Nadr      ,
    input       wire      [`ArchRegBUs]             Way2WritNumb  ,
    input       wire      [`InstAddrBus]            Way3Addr      ,
    input       wire      [`MicOperateCode]         Way3Opcode    ,
    input       wire                                Way3ImmAble   ,
    input       wire      [25:0]                    Way3ImmDate   ,
    input       wire                                Way3Src1Able  ,
    input       wire      [`ArchRegBUs]             Way3Src1Numb  ,
    input       wire                                Way3Src2Able  ,   
    input       wire      [`ArchRegBUs]             Way3Src2Numb  ,
    input       wire                                Way3WriteAble ,
    input       wire                                Way3Part      ,  // jump mode
    input       wire      [`InstAddrBus]            Way3Nadr      ,
    input       wire      [`ArchRegBUs]             Way3WritNumb  ,
    input       wire      [`InstAddrBus]            Way4Addr      ,
    input       wire      [`MicOperateCode]         Way4Opcode    ,
    input       wire                                Way4ImmAble   ,
    input       wire      [25:0]                    Way4ImmDate   ,
    input       wire                                Way4Src1Able  ,
    input       wire      [`ArchRegBUs]             Way4Src1Numb  ,
    input       wire                                Way4Src2Able  ,   
    input       wire      [`ArchRegBUs]             Way4Src2Numb  ,
    input       wire                                Way4WriteAble ,
    input       wire                                Way4Part      ,  // jump mode
    input       wire      [`InstAddrBus]            Way4Nadr      ,
    input       wire      [`ArchRegBUs]             Way4WritNumb  ,
    //to free list
    output      wire                                Way1Rename    ,
    output      wire      [`ArchRegBUs]             Way1RegNum    ,
    output      wire                                Way2Rename    ,
    output      wire      [`ArchRegBUs]             Way2RegNum    ,
    output      wire                                Way3Rename    ,
    output      wire      [`ArchRegBUs]             Way3RegNum    ,
    output      wire                                Way4Rename    ,
    output      wire      [`ArchRegBUs]             Way4RegNum    ,
    //to Rename ArchReg TAble 
    output      wire                                Way1Src1Rame  ,
    output      wire      [`ArchRegBUs]             Way1Src1      ,
    output      wire                                Way1Src2Rame  ,
    output      wire      [`ArchRegBUs]             Way1Src2      ,
    output      wire                                Way2Src1Rame  ,
    output      wire      [`ArchRegBUs]             Way2Src1      ,
    output      wire                                Way2Src2Rame  ,
    output      wire      [`ArchRegBUs]             Way2Src2      ,
    output      wire                                Way3Src1Rame  ,
    output      wire      [`ArchRegBUs]             Way3Src1      ,
    output      wire                                Way3Src2Rame  ,
    output      wire      [`ArchRegBUs]             Way3Src2      ,
    output      wire                                Way4Src1Rame  ,
    output      wire      [`ArchRegBUs]             Way4Src1      ,
    output      wire                                Way4Src2Rame  ,
    output      wire      [`ArchRegBUs]             Way4Src2      ,
    //from Rename Archreg Table
    input       wire                                Way1Src1Get   ,
    input       wire      [`ReNameRegBUs]           Way1Src1Raddr ,
    input       wire      [`DataBus]                Way1Src1Date  ,
    input       wire                                Way1Src2Get   ,
    input       wire      [`ReNameRegBUs]           Way1Src2Raddr ,
    input       wire      [`DataBus]                Way1Src2Date  ,
    input       wire                                Way2Src1Get   ,
    input       wire      [`ReNameRegBUs]           Way2Src1Raddr ,
    input       wire      [`DataBus]                Way2Src1Date  ,
    input       wire                                Way2Src2Get   ,
    input       wire      [`ReNameRegBUs]           Way2Src2Raddr ,
    input       wire      [`DataBus]                Way2Src2Date  ,
    input       wire                                Way3Src1Get   ,
    input       wire      [`ReNameRegBUs]           Way3Src1Raddr ,
    input       wire      [`DataBus]                Way3Src1Date  ,
    input       wire                                Way3Src2Get   ,
    input       wire      [`ReNameRegBUs]           Way3Src2Raddr ,
    input       wire      [`DataBus]                Way3Src2Date  ,
    input       wire                                Way4Src1Get   ,
    input       wire      [`ReNameRegBUs]           Way4Src1Raddr ,
    input       wire      [`DataBus]                Way4Src1Date  ,
    input       wire                                Way4Src2Get   ,
    input       wire      [`ReNameRegBUs]           Way4Src2Raddr ,
    input       wire      [`DataBus]                Way4Src2Date  ,
    input       wire                                Way1WritAble  ,
    input       wire      [`ReNameRegBUs]           Way1WritAddr  ,
    input       wire                                Way2WritAble  ,
    input       wire      [`ReNameRegBUs]           Way2WritAddr  ,
    input       wire                                Way3WritAble  ,
    input       wire      [`ReNameRegBUs]           Way3WritAddr  ,
    input       wire                                Way4WritAble  ,
    input       wire      [`ReNameRegBUs]           Way4WritAddr  ,
    //for ROB 
    input       wire      [6:0]                     RobFreeNumb   ,
    output      wire      [`InstAddrBus]            Inst1PcDate   ,
    output      wire                                Inst1InRob    ,
    output      wire      [`MicOperateCode]         Inst1MicOp    ,
    output      wire      [7+5-1:0]                 Inst1RnamInfo ,
    output      wire      [`InstAddrBus]            Inst2PcDate   ,
    output      wire                                Inst2InRob    ,
    output      wire      [`MicOperateCode]         Inst2MicOp    ,
    output      wire      [7+5-1:0]                 Inst2RnamInfo ,
    output      wire      [`InstAddrBus]            Inst3PcDate   ,
    output      wire                                Inst3InRob    ,
    output      wire      [`MicOperateCode]         Inst3MicOp    ,
    output      wire      [7+5-1:0]                 Inst3RnamInfo ,
    output      wire      [`InstAddrBus]            Inst4PcDate   ,
    output      wire                                Inst4InRob    ,
    output      wire      [`MicOperateCode]         Inst4MicOp    ,
    output      wire      [7+5-1:0]                 Inst4RnamInfo ,
    //For Alu1Rs
    output      wire      [`MicOperateCode]         Alu1MicOp     ,
    output      wire      [`DataBus]                Alu1Src1      , //如果该数据未取到则次端口存放未取到的物理寄存器地址
    output      wire                                Alu1Src1Able  , //数据是取到
    output      wire      [`DataBus]                Alu1Src2      ,
    output      wire                                Alu1Src2Able  ,
    output      wire      [`ReNameRegBUs]           Alu1WriteAddr ,
    output      wire                                Alu1WriteAble ,
    input       wire                                Alu1RsFull    ,
    //For Alu2Rs
    output      wire      [`MicOperateCode]         Alu2MicOp     ,
    output      wire      [`DataBus]                Alu2Src1      , 
    output      wire                                Alu2Src1Able  , 
    output      wire      [`DataBus]                Alu2Src2      ,
    output      wire                                Alu2Src2Able  ,
    output      wire      [`ReNameRegBUs]           Alu2WriteAddr ,
    output      wire                                Alu2WriteAble ,
    input       wire                                Alu2RsFull    ,
    //For BruRs
    output      wire      [`MicOperateCode]         BruMicOp      ,
    output      wire      [`DataBus]                BruSrc1       , 
    output      wire                                BruSrc1Able   , 
    output      wire      [`DataBus]                BruSrc2       ,
    output      wire                                BruSrc2Able   ,
    output      wire      [`ReNameRegBUs]           BruWriteAddr  ,
    output      wire                                BruWriteAble  , 
    output      wire                                BruPredictmode,
    output      wire      [`InstAddrBus]            BruPredictAddr,
    input       wire                                BruRsFull     ,
    //For CsruRs
    output      wire      [`MicOperateCode]         CsruMicOp     ,
    output      wire      [`DataBus]                CsruSrc1      , 
    output      wire                                CsruSrc1Able  , 
    output      wire      [`DataBus]                CsruSrc2      ,
    output      wire                                CsruSrc2Able  ,
    output      wire      [`ReNameRegBUs]           CsruWriteAddr ,
    output      wire                                CsruWriteAble ,
    input       wire                                CsruRsFull    ,
    //For DivRs
    output      wire      [`MicOperateCode]         DivMicOp      ,
    output      wire      [`DataBus]                DivSrc1       , 
    output      wire                                DivSrc1Able   , 
    output      wire      [`DataBus]                DivSrc2       ,
    output      wire                                DivSrc2Able   ,
    output      wire      [`ReNameRegBUs]           DivWriteAddr  ,
    output      wire                                DivWriteAble  ,
    input       wire                                DivRsFull     ,
    //For MulRs 
    output      wire      [`MicOperateCode]         MulMicOp      ,
    output      wire      [`DataBus]                MulSrc1       , 
    output      wire                                MulSrc1Able   , 
    output      wire      [`DataBus]                MulSrc2       ,
    output      wire                                MulSrc2Able   ,
    output      wire      [`ReNameRegBUs]           MulWriteAddr  ,
    output      wire                                MulWriteAble  ,
    input       wire                                MulRsFull     ,
    //For LsuRs
    output      wire      [`MicOperateCode]         LsuMicOp      ,
    output      wire      [`DataBus]                LsuSrc1       , 
    output      wire                                LsuSrc1Able   , 
    output      wire      [`DataBus]                LsuSrc2       ,
    output      wire                                LsuSrc2Able   ,
    output      wire      [`ReNameRegBUs]           LsuWriteAddr  ,
    output      wire                                LsuWriteAble  ,
    input       wire                                LsuRsFull     

); 

    //to freelist
    assign  Way1Rename = Way1WriteAble ;
    assign  Way1RegNum = Way1WritNumb  ;
    assign  Way2Rename = Way2WriteAble ;
    assign  Way2RegNum = Way2WritNumb  ;
    assign  Way3Rename = Way3WriteAble ;
    assign  Way3RegNum = Way3WritNumb  ;
    assign  Way4Rename = Way4WriteAble ;
    assign  Way4RegNum = Way4WritNumb  ;
    //to RAT
    assign Way1Src1Rame = Way1Src1Able ;
    assign Way1Src1     = Way1Src1Numb ;
    assign Way1Src2Rame = Way1Src2Able ;
    assign Way1Src2     = Way1Src2Numb ;
    assign Way2Src1Rame = Way2Src1Able ;
    assign Way2Src1     = Way2Src1Numb ;
    assign Way2Src2Rame = Way2Src2Able ;
    assign Way2Src2     = Way2Src2Numb ;
    assign Way3Src1Rame = Way3Src1Able ;
    assign Way3Src1     = Way3Src1Numb ;
    assign Way3Src2Rame = Way3Src2Able ;
    assign Way3Src2     = Way3Src2Numb ;
    assign Way4Src1Rame = Way4Src1Able ;
    assign Way4Src1     = Way4Src1Numb ;
    assign Way4Src2Rame = Way4Src2Able ;
    assign Way4Src2     = Way4Src2Numb ;



    
endmodule