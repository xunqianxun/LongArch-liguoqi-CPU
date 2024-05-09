`timescale 1ps/1ps
`include "../define.v"
`include "../MMU/Mmu.v"


module ICache (
    input      wire                             Clk            ,
    input      wire                             Rest           ,  
    //for ctrl 
    input      wire                             IcFLash        ,
    input      wire                             IcStop         ,
    output     wire                             IcReq          ,
    output     wire                             BpReq          ,
    //for mmu 
    output     wire                             ToMuFetch      ,
    output     wire      [31:0]                 ToMuVritualA   ,
    input      wire      [1:0]                  InCOperType    ,
    input      wire                             InCTlbTrap     , 
    input      wire      [`InstAddrBus]         InCPhysicalAddr,
    //from BPU 
    input      wire                             BpuReqAble     ,
    input      wire      [`InstAddrBus]         BpuReqPc       ,
    //to Predecoe 
    output     wire                             ToPreAble      ,
    output     wire      [255:0]                ToPcIvt        ,
    output     wire      [7:0]                  ToInstIvt      ,
    output     wire      [255:0]                ToDate         ,
    //to Arb tran
    output     wire                             OutReadAble    ,
    input      wire                             Inshankhand    ,
    output     wire                             OutUncacheRead ,
    output     wire      [`InstAddrBus]         OutReadAddr    ,
    input      wire                             InReadreq      ,
    input      wire                             InReadBackAble ,
    input      wire      [511:0]                InReadBackDate  
);
    wire               Stage1to2Able ;
    wire [`InstAddrBus]Stage1to2Pc   ;
    wire [511:0]       Way1S1ToS2Date;
    wire [19:0]        Way1S1ToS2Tag ;
    wire [511:0]       Way2S1ToS2Date;
    wire [19:0]        Way2S1ToS2Tag ;
    wire [511:0]       Way3S1ToS2Date;
    wire [19:0]        Way3S1ToS2Tag ;
    wire [511:0]       Way4S1ToS2Date;
    wire [19:0]        Way4S1ToS2Tag ;

    wire               HitUp2to1Able ;
    wire [5:0]         HitUp2to1Idx  ;
    wire               HitUp2to1Way1 ;
    wire               HitUp2to1Way2 ;
    wire               HitUp2to1Way3 ;
    wire               HitUp2to1Way4 ;

    wire               NewUp2to1Able ;
    wire  [5:0]        NewUp2to1Idx  ;
    wire  [19:0]       NewUp2to1Tag  ;
    wire  [511:0]      NewUp2to1Date ;

    ICacheStage1 u_ICacheStage1(
        .Clk           ( Clk            ),
        .Rest          ( Rest           ),
        .IcacheStop    ( IcStop         ),
        .IcacheFlash   ( IcFLash        ),
        .FetchAble     ( BpuReqAble     ),
        .FetchPc       ( BpuReqPc       ),
        .ToStage2Able  ( Stage1to2Able  ),
        .ToStage2Pc    ( Stage1to2Pc    ),
        .To2Way1Date   ( Way1S1ToS2Date ),
        .To2Way1Tag    ( Way1S1ToS2Tag  ),
        .To2Way2Date   ( Way2S1ToS2Date ),
        .To2Way2Tag    ( Way2S1ToS2Tag  ),
        .To2Way3Date   ( Way3S1ToS2Date ),
        .To2Way3Tag    ( Way3S1ToS2Tag  ),
        .To2Way4Date   ( Way4S1ToS2Date ),
        .To2Way4Tag    ( Way4S1ToS2Tag  ),
        .InHitAble     ( HitUp2to1Able  ),
        .InHitIndex    ( HitUp2to1Idx   ),
        .InHitWay1     ( HitUp2to1Way1  ),
        .InHitWay2     ( HitUp2to1Way2  ),
        .InHitWay3     ( HitUp2to1Way3  ),
        .InHitWay4     ( HitUp2to1Way4  ),
        .InNewAble     ( NewUp2to1Able  ),
        .InNewIndex    ( NewUp2to1Idx   ),
        .InNewTag      ( NewUp2to1Tag   ),
        .InNewDate     ( NewUp2to1Date  )
    );

    ICacheStage2 u_ICacheStage2(
        .Clk            ( Clk             ),
        .Rest           ( Rest            ),
        .ICacheFlash    ( IcFLash         ),
        .ICacheReq      ( BpReq           ),
        .IcacheSFreq    ( IcReq           ),
        .InOperType     ( InCOperType     ),
        .InTlbTrap      ( InCTlbTrap      ),
        .InPhysicalAddr ( InCPhysicalAddr ),
        .InStage1Able   ( Stage1to2Able   ),
        .InStage1Pc     ( Stage1to2Pc     ),
        .In1Way1Date    ( Way1S1ToS2Date  ),
        .In1Way1Tag     ( Way1S1ToS2Tag   ),
        .In1Way2Date    ( Way2S1ToS2Date  ),
        .In1Way2Tag     ( Way2S1ToS2Tag   ),
        .In1Way3Date    ( Way3S1ToS2Date  ),
        .In1Way3Tag     ( Way3S1ToS2Tag   ),
        .In1Way4Date    ( Way4S1ToS2Date  ),
        .In1Way4Tag     ( Way4S1ToS2Tag   ),
        .OutHitAble     ( HitUp2to1Able   ),
        .OutHitIndex    ( HitUp2to1Idx    ),
        .OutHitWay1     ( HitUp2to1Way1   ),
        .OutHitWay2     ( HitUp2to1Way2   ),
        .OutHitWay3     ( HitUp2to1Way3   ),
        .OutHitWay4     ( HitUp2to1Way4   ),
        .OutNewAble     ( NewUp2to1Able   ),
        .OutNewIndex    ( NewUp2to1Idx    ),
        .OutNewTag      ( NewUp2to1Tag    ),
        .OutNewDate     ( NewUp2to1Date   ),
        .IcaReadAble    ( OutReadAble     ),
        .IRshankhand    ( Inshankhand     ),
        .IUncacheRead   ( OutUncacheRead  ),
        .IcaReadAddr    ( OutReadAddr     ),
        .CacReadreq     ( InReadreq       ),
        .ReadBackAble   ( InReadBackAble  ),
        .ReadBackDate   ( InReadBackDate  ),
        .OutPreAble     ( ToPreAble       ),
        .OutPcIvt       ( ToPcIvt         ),
        .OutInstIvt     ( ToInstIvt       ),
        .OutDate        ( ToDate          )
    );

endmodule
