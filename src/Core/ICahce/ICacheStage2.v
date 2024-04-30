`timescale 1ps/1ps
`include "../define.v"

module ICacheStage2 (
    input       wire                                     Clk           ,
    input       wire                                     Rest          ,
    //for cache ctrl 
    input       wire                                     IcacheStop    ,
    input       wire                                     ICacheFlash   ,
    output      wire                                     ICacheReq     ,
    output      wire                                     BpuReq        ,
    //from MMU 
    input       wire       [1:0]                         InOperType    ,
    input       wire                                     InTlbTrap     ,
    //input       wire       [6:0]                         InTlbTrapType ,
    input       wire       [`InstAddrBus]                InPhysicalAddr,         
    //from stage1 
    input       wire                                     InStage1Able  ,
    input       wire       [7:0]                         In1Offset     ,
    input       wire       [255:0]                       In1Way1Date   ,
    input       wire       [19:0]                        In1Way1Tag    ,
    input       wire       [255:0]                       In1Way2Date   ,
    input       wire       [19:0]                        In1Way2Tag    ,
    input       wire       [255:0]                       In1Way3Date   ,
    input       wire       [19:0]                        In1Way3Tag    ,
    input       wire       [255:0]                       In1Way4Date   ,
    input       wire       [19:0]                        In1Way4Tag    ,  
    //to stage1 
    output      wire                                     OutHitAble    ,
    output      wire       [3:0]                         OutHitIndex   ,
    output      wire                                     OutHitWay1    ,
    output      wire                                     OutHitWay2    ,
    output      wire                                     OutHitWay3    ,
    output      wire                                     OutHitWay4    ,
    output      wire                                     OutNewAble    ,
    output      wire       [3:0]                         OutNewIndex   ,
    output      wire       [19:0]                        OutNewTag     ,
    output      wire       [255:0]                       OutNewDate    ,
    //to PreDecode 
    //output      wire       [2:0]                         OutType       ,
    output      wire       [255:0]                       OutPcIvt      ,
    output      wire       [7:0]                         OutInstIvt    ,
    output      wire       [255:0]                       OutDate 
);
    
    //hit check
    wire [19:0] PhysicalTag = InPhysicalAddr[31:12] ;
    
    wire  HitWay1 = (PhysicalTag == In1Way1Tag) ;
    wire  HitWay2 = (PhysicalTag == In1Way2Tag) ;
    wire  HitWay3 = (PhysicalTag == In1Way3Tag) ;
    wire  HitWay4 = (PhysicalTag == In1Way4Tag) ;

    wire         WayHitAble ;
    wire [255:0] WayHitDate ;
    assign {WayHitAble,WayHitDate} = (~HitWay1 & ~HitWay2 & ~HitWay3 & HitWay4) ? {`AbleValue,In1Way1Date} : 
                                     (~HitWay1 & ~HitWay2 & HitWay3 & ~HitWay4) ? {`AbleValue,In1Way2Date} : 
                                     (~HitWay1 & HitWay2 & ~HitWay3 & ~HitWay4) ? {`AbleValue,In1Way3Date} : 
                                     (HitWay1 & ~HitWay2 & ~HitWay3 & ~HitWay4) ? {`AbleValue,In1Way4Date} : {`EnableValue, 256'd0} ;

    wire [255:0] OutDate = In1Offset == 8'd0 
    


endmodule