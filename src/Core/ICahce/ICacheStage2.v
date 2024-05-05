`timescale 1ps/1ps
`include "../define.v"

module ICacheStage2 (
    input       wire                                     Clk           ,
    input       wire                                     Rest          ,
    //for cache ctrl
    input       wire                                     ICacheFlash   ,
    output      wire                                     ICacheReq     , //stop cache and pc
    //to ctrl 
    output      wire                                     IcacheSFreq   , //stop fetech amd wwerit trap  
    //from MMU 
    input       wire       [1:0]                         InOperType    ,
    input       wire                                     InTlbTrap     ,
    input       wire       [`InstAddrBus]                InPhysicalAddr,         
    //from stage1 
    input       wire                                     InStage1Able  ,  
    input       wire       [`InstAddrBus]                InStage1Pc    ,
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
    output      wire       [`InstAddrBus]                IcaReadAddr   ,
    input       wire                                     CacReadreq    ,
    input       wire                                     ReadBackAble  ,
    input       wire       [511:0]                       ReadBackDate  ,
    //to PreDecode 
    output      wire                                     OutPreAble    ,
    output      wire       [255:0]                       OutPcIvt      ,
    output      wire       [7:0]                         OutInstIvt    ,
    output      wire       [255:0]                       OutDate 
);
    
    assign IcacheSFreq = InTlbTrap ;

    //hit check
    wire [19:0] PhysicalTag = InPhysicalAddr[31:12] ;
    
    wire  HitWay1 = (PhysicalTag == In1Way1Tag) ;
    wire  HitWay2 = (PhysicalTag == In1Way2Tag) ;
    wire  HitWay3 = (PhysicalTag == In1Way3Tag) ;
    wire  HitWay4 = (PhysicalTag == In1Way4Tag) ;

    wire         WayHitAble ;
    wire [3:0]   WayHutNum  ;
    wire [511:0] WayHitDate ;
    assign {WayHutNum,WayHitAble,WayHitDate}  = ((~HitWay1 & ~HitWay2 & ~HitWay3 & HitWay4) & InOperType != 2'b00) ? {4'b1000,`AbleValue,In1Way1Date} : 
                                                ((~HitWay1 & ~HitWay2 & HitWay3 & ~HitWay4) & InOperType != 2'b00) ? {4'b0100,`AbleValue,In1Way2Date} : 
                                                ((~HitWay1 & HitWay2 & ~HitWay3 & ~HitWay4) & InOperType != 2'b00) ? {4'b0010,`AbleValue,In1Way3Date} : 
                                                ((HitWay1 & ~HitWay2 & ~HitWay3 & ~HitWay4) & InOperType != 2'b00) ? {4'b0001,`AbleValue,In1Way4Date} : {4'b0000,`EnableValue, 512'd0} ;

    // reg          WayHitAble ;
    // reg [3:0]    WayHutNum  ;
    // reg [255:0]  WayHitDate ;

    // always @(posedge Clk) begin
    //     if(!Rest) begin
    //         WayHitAble <= `EnableValue ;
    //         WayHutNum <= 4'd0 ;
    //         WayHitDate <= 256'd0 ;
    //     end
    //     else if()
    // end

    // wire [255:0] OutDate = {256{(In1Offset == {4'd0,2'd0})}} & WayHitDate[255:0]  |
    //                        {256{(In1Offset == {4'd1,2'd0})}} & WayHitDate[287:32] |
    //                        {256{(In1Offset == {4'd2,2'd0})}} & WayHitDate[319:64] |
    //                        {256{(In1Offset == {4'd3,2'd0})}} & WayHitDate[351:96] | 
    //                        {256{(In1Offset == {4'd4,2'd0})}} & WayHitDate[383:128] |
    //                        {256{(In1Offset == {4'd5,2'd0})}} & WayHitDate[415:160] |
    //                        {256{(In1Offset == {4'd6,2'd0})}} & WayHitDate[447:192] |
    //                        {256{(In1Offset == {4'd7,2'd0})}} & WayHitDate[479:224] |
    //                        {256{(In1Offset == {4'd8,2'd0})}} & WayHitDate[511:256] |
    //                        {256{(In1Offset == {4'd9,2'd0})}}  & {32'd0,WayHitDate[511:288]} |
    //                        {256{(In1Offset == {4'd10,2'd0})}} & {64'd0,WayHitDate[511:320]} |
    //                        {256{(In1Offset == {4'd11,2'd0})}} & {96'd0,WayHitDate[511:352]} |
    //                        {256{(In1Offset == {4'd12,2'd0})}} & {128'd0,WayHitDate[511:384]} |
    //                        {256{(In1Offset == {4'd13,2'd0})}} & {160'd0,WayHitDate[511:416]} |
    //                        {256{(In1Offset == {4'd14,2'd0})}} & {192'd0,WayHitDate[511:448]} |
    //                        {256{(In1Offset == {4'd15,2'd0})}} & {224'd0,WayHitDate[511:480]} ;

                           
    wire [255:0] OutPcIvtTemp  = {InStage1Pc+28,InStage1Pc+24,InStage1Pc+20,InStage1Pc+16,
                                  InStage1Pc+12,InStage1Pc+8,InStage1Pc+4,InStage1Pc} ;

    assign   OutHitAble  =  WayHitAble             ;
    assign   OutHitIndex =  InStage1Pc[11:6]       ;
    assign   OutHitWay1  =  WayHutNum[0]           ;
    assign   OutHitWay2  =  WayHutNum[1]           ;
    assign   OutHitWay3  =  WayHutNum[2]           ;
    assign   OutHitWay4  =  WayHutNum[3]           ;



    localparam WRITEARB  = 2'b01 ;
    localparam SHANKHAND = 2'b10 ;
 

    wire               WriteAble = ~WayHitAble & InStage1Able ;
    wire   [68:0]      WriteDate = {InStage1Pc,`AbleValue,InPhysicalAddr,WRITEARB,InOperType} ;
    wire   [68:0]      PreDate  ;
    wire   [2:0]       PrePtr   ;
    wire               MSHRRead ;
    wire               MSHREmpty;

    assign MSHRRead = (ReadBackAble & (PreDate[3:2] == SHANKHAND)) ;
    wire   MSHRFIll ;

    IcacheFIFO#(
        .FIFOWIDE    ( 69 )
    )u_IcacheFIFO(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .Rable       ( MSHRRead    ),
        .FifoPreOut  ( PreDate     ),
        .FifoPrePtr  ( PrePtr      ),
        .Wable       ( WriteAble   ),
        .Din         ( WriteDate   ),
        .StateWAble  ( IRshankhand ),
        .StatePtr    ( PrePtr      ),
        .StateDate   ( SHANKHAND   ),
        .FifoClean   ( ICacheFlash ),
        .FifoEmpty   ( MSHREmpty   ),
        .FifoFull    ( MSHRFIll    )
    );

    assign  ICacheReq = MSHRFIll | (WayHitAble & ~MSHREmpty) ;

    assign  IcaReadAble   =  CacReadreq & (PreDate[1:0] == 2'b01) & (PreDate[3:2] == WRITEARB) ;
    assign  IUncacheRead  =  CacReadreq & (PreDate[1:0] == 2'b00) & (PreDate[3:2] == WRITEARB) ;
    assign  IcaReadAddr   =  (CacReadreq & (PreDate[3:2] == WRITEARB)) ? PreDate[35:4] : 32'd0 ;


    assign  OutNewAble    =  ReadBackAble & (PreDate[1:0] == 2'b00) ;
    assign  OutNewIndex   =  PreDate[15:10] ;
    assign  OutNewTag     =  PreDate[35:16] ;
    assign  OutNewDate    =  ReadBackDate   ;


    reg              RegOutPreAble    ;
    reg [255:0]      RegOutPcIvt      ;
    reg [7:0]        RegOutInstIvt    ;
    reg [255:0]      RegOutDate       ;

    wire [511:0] ShiftCDate = (ReadBackDate >> {PreDate[9:6],5'd0}) ;
    wire [511:0] SHiftHDate = (WayHitDate >> {InStage1Pc[5:2],5'd0}) ;

    always @(posedge Clk) begin
        if(!Rest) begin
            RegOutPreAble <= `EnableValue ;
            RegOutPcIvt <= 256'd0 ;
            RegOutInstIvt <= 8'd0 ;
            RegOutDate <= 256'd0  ;
        end
        else if(ICacheFlash)begin
            RegOutPreAble <= `EnableValue ;
            RegOutPcIvt <= 256'd0 ;
            RegOutInstIvt <= 8'd0 ;
            RegOutDate <= 256'd0  ;
        end
        else if(~MSHREmpty) begin
            RegOutPreAble <= (PreDate[3:2] == SHANKHAND) & ReadBackAble ;
            RegOutPcIvt <= {PreDate[68:37]+28,PreDate[68:37]+24,PreDate[68:37]+20,PreDate[68:37]+16,
                            PreDate[68:37]+12,PreDate[68:37]+8,PreDate[68:37]+4,PreDate[68:37]} ;
            RegOutDate <= ShiftCDate[255:0] ;
            RegOutInstIvt <= (PreDate[1:0] == 2'b01) ? ({8{(PreDate[9:6]==4'd0) | 
                                                            (PreDate[9:6]==4'd1) | 
                                                            (PreDate[9:6]==4'd2) | 
                                                            (PreDate[9:6]==4'd3) | 
                                                            (PreDate[9:6]==4'd4) | 
                                                            (PreDate[9:6]==4'd5) | 
                                                            (PreDate[9:6]==4'd6) | 
                                                            (PreDate[9:6]==4'd7) | 
                                                            (PreDate[9:6]==4'd8)}} & 8'b11111111  |
                                                        {8{(PreDate[9:6]==4'd9)}}  & 8'b01111111  |
                                                        {8{(PreDate[9:6]==4'd10)}} & 8'b00111111  |
                                                        {8{(PreDate[9:6]==4'd11)}} & 8'b00011111  |
                                                        {8{(PreDate[9:6]==4'd12)}} & 8'b00001111  |
                                                        {8{(PreDate[9:6]==4'd13)}} & 8'b00000111  |
                                                        {8{(PreDate[9:6]==4'd14)}} & 8'b00000011  |
                                                        {8{(PreDate[9:6]==4'd15)}} & 8'b00000001  ) : 8'b00000001 ;
        end 
        else if(MSHREmpty | WayHitAble) begin
            RegOutPreAble <= `AbleValue ;
            RegOutPcIvt <= OutPcIvtTemp ;
            RegOutDate <= SHiftHDate[255:0] ;
            RegOutInstIvt <= {8{(InStage1Pc[5:2]==4'd0) | 
                                (InStage1Pc[5:2]==4'd1) | 
                                (InStage1Pc[5:2]==4'd2) | 
                                (InStage1Pc[5:2]==4'd3) | 
                                (InStage1Pc[5:2]==4'd4) | 
                                (InStage1Pc[5:2]==4'd5) | 
                                (InStage1Pc[5:2]==4'd6) | 
                                (InStage1Pc[5:2]==4'd7) | 
                                (InStage1Pc[5:2]==4'd8)}} & 8'b11111111  |
                            {8{(InStage1Pc[5:2]==4'd9)}}  & 8'b01111111  |
                            {8{(InStage1Pc[5:2]==4'd10)}} & 8'b00111111  |
                            {8{(InStage1Pc[5:2]==4'd11)}} & 8'b00011111  |
                            {8{(InStage1Pc[5:2]==4'd12)}} & 8'b00001111  |
                            {8{(InStage1Pc[5:2]==4'd13)}} & 8'b00000111  |
                            {8{(InStage1Pc[5:2]==4'd14)}} & 8'b00000011  |
                            {8{(InStage1Pc[5:2]==4'd15)}} & 8'b00000001  ;
        end
        else begin
            RegOutPreAble <= `EnableValue ;
            RegOutPcIvt <= 256'd0 ;
            RegOutInstIvt <= 8'd0 ;
            RegOutDate <= 256'd0  ;
        end
    end

    assign OutPreAble = RegOutPreAble ;
    assign OutPcIvt   = RegOutPcIvt   ;
    assign OutInstIvt = RegOutInstIvt ;
    assign OutDate    = RegOutDate    ;

endmodule
