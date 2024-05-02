`timescale 1ps/1ps
`include "../define.v"

module ICacheStage2 (
    input       wire                                     Clk           ,
    input       wire                                     Rest          ,
    //for cache ctrl 
    //input       wire                                     IcacheStop    ,
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
    input       wire       [`InstAddrBus]                InStage1Pc    ,
    input       wire       [5:0]                         In1Offset     ,
    input       wire       [511:0]                       In1Way1Date   ,
    input       wire       [19:0]                        In1Way1Tag    ,
    input       wire       [511:0]                       In1Way2Date   ,
    input       wire       [19:0]                        In1Way2Tag    ,
    input       wire       [511:0]                       In1Way3Date   ,
    input       wire       [19:0]                        In1Way3Tag    ,
    input       wire       [511:0]                       In1Way4Date   ,
    input       wire       [19:0]                        In1Way4Tag    ,  
    //to stage1 
    output      wire                                     OutHitAble    ,
    output      wire       [5:0]                         OutHitIndex   ,
    output      wire                                     OutHitWay1    ,
    output      wire                                     OutHitWay2    ,
    output      wire                                     OutHitWay3    ,
    output      wire                                     OutHitWay4    ,
    output      wire                                     OutNewAble    ,
    output      wire       [5:0]                         OutNewIndex   ,
    output      wire       [19:0]                        OutNewTag     ,
    output      wire       [511:0]                       OutNewDate    ,
    //for axi
    output      wire                                     IcaReadAble   ,
    input       wire                                     IRshankhand   ,
    output      wire                                     IUncacheRead  ,
    output      wire     [`InstAddrBus]                  IcaReadAddr   ,
    input       wire                                     CacReadfree   ,
    input       wire                                     ReadBackAble  ,
    input       wire     [511:0]                         ReadBackDate  ,
    //to PreDecode 
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
                                     (HitWay1 & ~HitWay2 & ~HitWay3 & ~HitWay4) ? {`AbleValue,In1Way4Date} : {`EnableValue, 512'd0} ;

    wire [511:0] FInalOutDate ;

    wire [255:0] OutDate = {256{(In1Offset == {4'd0,2'd0})}} & FInalOutDate[255:0]  |
                           {256{(In1Offset == {4'd1,2'd0})}} & FInalOutDate[287:32] |
                           {256{(In1Offset == {4'd2,2'd0})}} & FInalOutDate[319:64] |
                           {256{(In1Offset == {4'd3,2'd0})}} & FInalOutDate[351:96] | 
                           {256{(In1Offset == {4'd4,2'd0})}} & FInalOutDate[383:128] |
                           {256{(In1Offset == {4'd5,2'd0})}} & FInalOutDate[415:160] |
                           {256{(In1Offset == {4'd6,2'd0})}} & FInalOutDate[447:192] |
                           {256{(In1Offset == {4'd7,2'd0})}} & FInalOutDate[479:224] |
                           {256{(In1Offset == {4'd8,2'd0})}} & FInalOutDate[511:256] |
                           {256{(In1Offset == {4'd9,2'd0})}}  & {32'd0,FInalOutDate[511:288]} |
                           {256{(In1Offset == {4'd10,2'd0})}} & {64'd0,FInalOutDate[511:320]} |
                           {256{(In1Offset == {4'd11,2'd0})}} & {96'd0,FInalOutDate[511:352]} |
                           {256{(In1Offset == {4'd12,2'd0})}} & {128'd0,FInalOutDate[511:384]} |
                           {256{(In1Offset == {4'd13,2'd0})}} & {160'd0,FInalOutDate[511:416]} |
                           {256{(In1Offset == {4'd14,2'd0})}} & {192'd0,FInalOutDate[511:448]} |
                           {256{(In1Offset == {4'd15,2'd0})}} & {224'd0,FInalOutDate[511:480]} ;

                           
    wire [31:0]  FInalPc    ;
    wire [255:0] OutPcIvt = {FInalPc+28,FInalPc+24,FInalPc+20,FInalPc+16,
                             FInalPc+12,FInalPc+8,FInalPc+4,FInalPc}

    reg [37:0] MSHR[0:7] ;

    integer i ;
    always @(posedge Clk) begin
        if(!Rest) begin
            for (i =0 ;i<8 ;i=i+1 ) begin
                MSHR[i] <= 38'd0 ;
            end  
        end
        else begin
            if(ICacheFlash) 
                for (i =0 ;i<8 ;i=i+1 ) begin
                    MSHR[i] <= 38'd0 ;
                end
            if()
        end
    end

    


endmodule
