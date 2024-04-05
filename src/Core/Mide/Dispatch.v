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
    input       wire      [32:0]                    Way1Src1Date  ,
    input       wire                                Way1Src2Get   ,
    input       wire      [`ReNameRegBUs]           Way1Src2Raddr ,
    input       wire      [32:0]                    Way1Src2Date  ,
    input       wire                                Way2Src1Get   ,
    input       wire      [`ReNameRegBUs]           Way2Src1Raddr ,
    input       wire      [32:0]                    Way2Src1Date  ,
    input       wire                                Way2Src2Get   ,
    input       wire      [`ReNameRegBUs]           Way2Src2Raddr ,
    input       wire      [32:0]                    Way2Src2Date  ,
    input       wire                                Way3Src1Get   ,
    input       wire      [`ReNameRegBUs]           Way3Src1Raddr ,
    input       wire      [32:0]                    Way3Src1Date  ,
    input       wire                                Way3Src2Get   ,
    input       wire      [`ReNameRegBUs]           Way3Src2Raddr ,
    input       wire      [32:0]                    Way3Src2Date  ,
    input       wire                                Way4Src1Get   ,
    input       wire      [`ReNameRegBUs]           Way4Src1Raddr ,
    input       wire      [32:0]                    Way4Src1Date  ,
    input       wire                                Way4Src2Get   ,
    input       wire      [`ReNameRegBUs]           Way4Src2Raddr ,
    input       wire      [32:0]                    Way4Src2Date  ,
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
    //****MIcop 8bit | Src1Able 1bit | Src1Date 32Bit | Src2Able 1bit | Src2Date 32Bit | WriteAble 1bit | WriteAddr 32bit******//SrcDate 如果该数据未取到则此端口存放未取到的物理寄存器地址
    output      wire                                Alu1Inst1Able ,
    output      wire      [106:0]                   Alu1Inst1Infor,
    output      wire                                Alu1Inst2Able ,
    output      wire      [106:0]                   Alu1Inst2Infor,
    output      wire                                Alu1Inst3Able ,
    output      wire      [106:0]                   Alu1Inst3Infor,
    output      wire                                Alu1Inst4Able ,
    output      wire      [106:0]                   Alu1Inst4Infor,
    input       wire      [2:0]                     Alu1RsFreeNum ,
    //For Alu2Rs
    output      wire                                Alu2Inst1Able ,
    output      wire      [106:0]                   Alu2Inst1Infor,
    output      wire                                Alu2Inst2Able ,
    output      wire      [106:0]                   Alu2Inst2Infor,
    output      wire                                Alu2Inst3Able ,
    output      wire      [106:0]                   Alu2Inst3Infor,
    output      wire                                Alu2Inst4Able ,
    output      wire      [106:0]                   Alu2Inst4Infor,
    input       wire      [2:0]                     Alu2RsFreeNum ,
    //For BruRs
    //****MIcop 8bit | Src1Able 1bit | Src1Date 32Bit | Src2Able 1bit | Src2Date 32Bit | WriteAble 1bit | WriteAddr 32bit | Predictmode 1bit | PredictAddr 32bit******//SrcDate 如果该数据未取到则此端口存放未取到的物理寄存器地址
    output      wire                                BruInst1Able ,
    output      wire      [139:0]                   BruInst1Infor,
    output      wire                                BruInst2Able ,
    output      wire      [139:0]                   BruInst2Infor,
    output      wire                                BruInst3Able ,
    output      wire      [139:0]                   BruInst3Infor,
    output      wire                                BruInst4Able ,
    output      wire      [139:0]                   BruInst4Infor,
    input       wire      [2:0]                     BruRsFreeNum ,
    //For CsruRs
    output      wire                                CsruInst1Able ,
    output      wire      [106:0]                   CsruInst1Infor,
    output      wire                                CsruInst2Able ,
    output      wire      [106:0]                   CsruInst2Infor,
    output      wire                                CsruInst3Able ,
    output      wire      [106:0]                   CsruInst3Infor,
    output      wire                                CsruInst4Able ,
    output      wire      [106:0]                   CsruInst4Infor,
    input       wire      [2:0]                     CsruRsFreeNum ,
    //For DivRs
    output      wire                                DivInst1Able ,
    output      wire      [106:0]                   DivInst1Infor,
    output      wire                                DivInst2Able ,
    output      wire      [106:0]                   DivInst2Infor,
    output      wire                                DivInst3Able ,
    output      wire      [106:0]                   DivInst3Infor,
    output      wire                                DivInst4Able ,
    output      wire      [106:0]                   DivInst4Infor,
    input       wire      [2:0]                     DivRsFreeNum ,
    //For MulRs 
    output      wire                                MulInst1Able ,
    output      wire      [106:0]                   MulInst1Infor,
    output      wire                                MulInst2Able ,
    output      wire      [106:0]                   MulInst2Infor,
    output      wire                                MulInst3Able ,
    output      wire      [106:0]                   MulInst3Infor,
    output      wire                                MulInst4Able ,
    output      wire      [106:0]                   MulInst4Infor,
    input       wire      [2:0]                     MulRsFreeNum ,
    //For LsuRs
    output      wire                                MulInst1Able ,
    output      wire      [106:0]                   MulInst1Infor,
    output      wire                                MulInst2Able ,
    output      wire      [106:0]                   MulInst2Infor,
    output      wire                                MulInst3Able ,
    output      wire      [106:0]                   MulInst3Infor,
    output      wire                                MulInst4Able ,
    output      wire      [106:0]                   MulInst4Infor,
    input       wire      [2:0]                     MulRsFreeNum 

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