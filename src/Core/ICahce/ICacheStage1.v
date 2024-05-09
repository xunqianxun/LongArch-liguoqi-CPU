`timescale 1ps/1ps
`include "../define.v"
`include "../../IP/date_64x512.xcix"
`include "../../IP/tag_64x512.xcix"


module ICacheStage1 (
    input        wire                                     Clk           ,
    input        wire                                     Rest          ,
    //from ictrl
    input        wire                                     IcacheStop    ,
    input        wire                                     IcacheFlash   ,
    //from Pc 
    input        wire                                     FetchAble     ,
    input        wire       [`InstAddrBus]                FetchPc       ,
    //to stage 2 
    output       wire                                     ToStage2Able  ,
    output       wire       [`InstAddrBus]                ToStage2Pc    ,
   // output       wire       [5:0]                         To2Offset     ,
    output       wire       [511:0]                       To2Way1Date   ,
    output       wire       [19:0]                        To2Way1Tag    ,
    output       wire       [511:0]                       To2Way2Date   ,
    output       wire       [19:0]                        To2Way2Tag    ,
    output       wire       [511:0]                       To2Way3Date   ,
    output       wire       [19:0]                        To2Way3Tag    ,
    output       wire       [511:0]                       To2Way4Date   ,
    output       wire       [19:0]                        To2Way4Tag    ,
    // update when hit
    input        wire                                     InHitAble     ,
    input        wire       [5:0]                         InHitIndex    ,
    input        wire                                     InHitWay1     ,
    input        wire                                     InHitWay2     ,
    input        wire                                     InHitWay3     ,
    input        wire                                     InHitWay4     ,
    //from MSHR up when miss
    input        wire                                     InNewAble     ,
    input        wire       [5:0]                         InNewIndex    ,
    input        wire       [19:0]                        InNewTag      ,
    input        wire       [511:0]                       InNewDate     

);
    reg           StopTemp  ;
    reg           FLashTemp ;
    always @(posedge Clk) begin
        if(!Rest) begin
            StopTemp  <= 1'b0 ;
            FLashTemp <= 1'b0 ;
        end
        else begin
            StopTemp  <= IcacheStop  ;
            FLashTemp <= IcacheFlash ;
        end
    end

    reg   [2:0]  CountWay1 [0:63] ;
    reg   [2:0]  CountWay2 [0:63] ;
    reg   [2:0]  CountWay3 [0:63] ;
    reg   [2:0]  CountWay4 [0:63] ;

    integer i ;
    always @(posedge Clk) begin
        if(!Rest) begin
            for (i =0 ;i<32 ;i=i+1 ) begin
                CountWay1[i]    <= 3'd0 ;
                CountWay1[i+32] <= 3'd0 ;
                CountWay2[i]    <= 3'd0 ;
                CountWay2[i+32] <= 3'd0 ;
                CountWay3[i]    <= 3'd0 ;
                CountWay3[i+32] <= 3'd0 ;
                CountWay4[i]    <= 3'd0 ;
                CountWay4[i+32] <= 3'd0 ;
            end
        end
        else begin
            if(InHitAble & ~IcacheStop) begin
                if(InHitWay1) begin
                    CountWay1[InHitIndex] <= 3'd0 ;
                    CountWay2[InHitIndex] <= (CountWay2[InHitIndex] != 3'b111) ? CountWay2[InHitIndex] + 1 : CountWay2[InHitIndex] ;
                    CountWay3[InHitIndex] <= (CountWay3[InHitIndex] != 3'b111) ? CountWay3[InHitIndex] + 1 : CountWay3[InHitIndex] ;
                    CountWay4[InHitIndex] <= (CountWay4[InHitIndex] != 3'b111) ? CountWay4[InHitIndex] + 1 : CountWay4[InHitIndex] ;
                end 
                if(InHitWay2) begin
                    CountWay1[InHitIndex] <= (CountWay1[InHitIndex] != 3'b111) ? CountWay1[InHitIndex] + 1 : CountWay1[InHitIndex] ;
                    CountWay2[InHitIndex] <= 3'd0 ;
                    CountWay3[InHitIndex] <= (CountWay3[InHitIndex] != 3'b111) ? CountWay3[InHitIndex] + 1 : CountWay3[InHitIndex] ;
                    CountWay4[InHitIndex] <= (CountWay4[InHitIndex] != 3'b111) ? CountWay4[InHitIndex] + 1 : CountWay4[InHitIndex] ;
                end 
                if(InHitWay3) begin
                    CountWay1[InHitIndex] <= (CountWay1[InHitIndex] != 3'b111) ? CountWay1[InHitIndex] + 1 : CountWay1[InHitIndex] ;
                    CountWay2[InHitIndex] <= (CountWay2[InHitIndex] != 3'b111) ? CountWay2[InHitIndex] + 1 : CountWay2[InHitIndex] ;
                    CountWay3[InHitIndex] <= 3'd0 ;
                    CountWay4[InHitIndex] <= (CountWay4[InHitIndex] != 3'b111) ? CountWay4[InHitIndex] + 1 : CountWay4[InHitIndex] ;
                end 
                if(InHitWay4) begin
                    CountWay1[InHitIndex] <= (CountWay1[InHitIndex] != 3'b111) ? CountWay1[InHitIndex] + 1 : CountWay1[InHitIndex] ;
                    CountWay2[InHitIndex] <= (CountWay2[InHitIndex] != 3'b111) ? CountWay2[InHitIndex] + 1 : CountWay2[InHitIndex] ;
                    CountWay3[InHitIndex] <= (CountWay3[InHitIndex] != 3'b111) ? CountWay3[InHitIndex] + 1 : CountWay3[InHitIndex] ;
                    CountWay4[InHitIndex] <= 3'd0 ;
                end 
            end
            else begin
                CountWay1[InHitIndex] <= CountWay1[InHitIndex] ;
                CountWay2[InHitIndex] <= CountWay2[InHitIndex] ;
                CountWay3[InHitIndex] <= CountWay3[InHitIndex] ;
                CountWay4[InHitIndex] <= CountWay4[InHitIndex] ;
            end
        end
    end

    wire  [5:0]          VritualPcOffset = FetchPc[5:0]  ;
    reg   [5:0]          RVritualOffset  ;
    reg   [`InstAddrBus] RVritualPc ;
    reg                  RegFetchAble    ;

    always @(posedge Clk) begin
        if(!Rest)
            {RegFetchAble,RVritualOffset,RVritualPc} <= 39'b0 ;  
        else if(IcacheStop) 
            {RegFetchAble,RVritualOffset,RVritualPc} <= {RegFetchAble,RVritualOffset,RVritualPc} ;
        else if(IcacheFlash)
            {RegFetchAble,RVritualOffset,RVritualPc} <= 39'b0 ;
        else 
            {RegFetchAble,RVritualOffset,RVritualPc} <= {FetchAble,VritualPcOffset,FetchPc} ;
    end

    wire  [5:0]  VritualPcIndex  = FetchPc[11:6] ;

    wire         Way1Able = `AbleValue ;
    wire  [5:0]  Way1Index= InNewAble ? InNewIndex         : 
                            FetchAble ? VritualPcOffset    : 6'd0 ;
    wire         Way1Wen  = InNewAble & (((CountWay1[InNewIndex] > CountWay2[InNewIndex]) & (CountWay1[InNewIndex] > CountWay3[InNewIndex]) & 
                                          (CountWay1[InNewIndex] > CountWay4[InNewIndex])) ) & ~StopTemp;
    wire  [19:0] Way1Tag  = InNewTag  ;
    wire  [511:0]Way1Date = InNewDate ;
    wire  [19:0] OutWay1Tag   ;
    wire  [511:0]OutWay1Date  ;

    date_64x512 way1_date_64x512(
    .clka  ( Clk         ),
    .ena   ( Way1Able    ),
    .wea   ( Way1Wen     ),
    .addra ( Way1Index   ),
    .dina  ( Way1Date    ),
    .douta ( OutWay1Date )
    ); 

    tag_64x512 way1_tag_64x512(
    .clka  ( Clk         ),
    .ena   ( Way1Able    ),
    .wea   ( Way1Wen     ),
    .addra ( Way1Index   ),
    .dina  ( Way1Tag     ),
    .douta ( OutWay1Tag  )
    ); 

    wire         Way2Able = `AbleValue ;
    wire  [5:0]  Way2Index= InNewAble ? InNewIndex         : 
                            FetchAble ? VritualPcOffset    : 6'd0 ;
    wire         Way2Wen  = InNewAble & (((CountWay2[InNewIndex] > CountWay1[InNewIndex]) & (CountWay2[InNewIndex] > CountWay3[InNewIndex]) & 
                                          (CountWay2[InNewIndex] > CountWay4[InNewIndex])) )& ~StopTemp;
    wire  [19:0] Way2Tag  = InNewTag  ;
    wire  [511:0]Way2Date = InNewDate ;

    wire  [19:0] OutWay2Tag   ;
    wire  [511:0]OutWay2Date  ;

    date_64x512 way2_date_64x512(
    .clka  ( Clk         ),
    .ena   ( Way2Able    ),
    .wea   ( Way2Wen     ),
    .addra ( Way2Index   ),
    .dina  ( Way2Date    ),
    .douta ( OutWay2Date )
    ); 

    tag_64x512 way2_tag_64x512(
    .clka  ( Clk         ),
    .ena   ( Way2Able    ),
    .wea   ( Way2Wen     ),
    .addra ( Way2Index   ),
    .dina  ( Way2Tag     ),
    .douta ( OutWay2Tag  )
    ); 

    wire         Way3Able = `AbleValue ;
    wire  [5:0]  Way3Index= InNewAble ? InNewIndex         : 
                            FetchAble ? VritualPcOffset    : 6'd0 ;
    wire         Way3Wen  = InNewAble & (((CountWay3[InNewIndex] > CountWay1[InNewIndex]) & (CountWay3[InNewIndex] > CountWay2[InNewIndex]) & 
                                          (CountWay3[InNewIndex] > CountWay4[InNewIndex])) )& ~StopTemp;
    wire  [19:0] Way3Tag  = InNewTag  ;
    wire  [511:0]Way3Date = InNewDate ;

    wire  [19:0] OutWay3Tag   ;
    wire  [511:0]OutWay3Date  ;

    date_64x512 way3_date_64x512(
    .clka  ( Clk         ),
    .ena   ( Way3Able    ),
    .wea   ( Way3Wen     ),
    .addra ( Way3Index   ),
    .dina  ( Way3Date    ),
    .douta ( OutWay3Date )
    ); 

    tag_64x512 way3_tag_64x512(
    .clka  ( Clk         ),
    .ena   ( Way3Able    ),
    .wea   ( Way3Wen     ),
    .addra ( Way3Index   ),
    .dina  ( Way3Tag     ),
    .douta ( OutWay3Tag  )
    ); 

    wire         Way4Able = `AbleValue ;
    wire  [5:0]  Way4Index= InNewAble ? InNewIndex         : 
                            FetchAble ? VritualPcOffset    : 6'd0 ;
    wire         Way4Wen  = InNewAble & (((CountWay3[InNewIndex] > CountWay1[InNewIndex]) & (CountWay3[InNewIndex] > CountWay2[InNewIndex]) & 
                                          (CountWay3[InNewIndex] > CountWay4[InNewIndex])) )& ~StopTemp;
    wire  [19:0] Way4Tag  = InNewTag  ;
    wire  [511:0]Way4Date = InNewDate ;

    wire  [19:0] OutWay4Tag   ;
    wire  [511:0]OutWay4Date  ;

    date_64x512 way4_date_64x512(
    .clka  ( Clk         ),
    .ena   ( Way4Able    ),
    .wea   ( Way4Wen     ),
    .addra ( Way4Index   ),
    .dina  ( Way4Date    ),
    .douta ( OutWay4Date )
    ); 

    tag_64x512 way4_tag_64x512(
    .clka  ( Clk         ),
    .ena   ( Way4Able    ),
    .wea   ( Way4Wen     ),
    .addra ( Way4Index   ),
    .dina  ( Way4Tag     ),
    .douta ( OutWay4Tag  )
    ); 


    assign ToStage2Able = ~FLashTemp ?  RegFetchAble: 1'b0   ;
    assign ToStage2Pc   = ~FLashTemp ?  RVritualPc  : 32'b0  ;
    assign To2Way1Date  = ~FLashTemp ?  OutWay1Date : 512'b0 ;
    assign To2Way1Tag   = ~FLashTemp ?  OutWay1Tag  : 20'b0  ;
    assign To2Way2Date  = ~FLashTemp ?  OutWay2Date : 512'b0 ;
    assign To2Way2Tag   = ~FLashTemp ?  OutWay2Tag  : 20'b0  ;
    assign To2Way3Date  = ~FLashTemp ?  OutWay3Date : 512'b0 ;
    assign To2Way3Tag   = ~FLashTemp ?  OutWay3Tag  : 20'b0  ;
    assign To2Way4Date  = ~FLashTemp ?  OutWay4Date : 512'b0 ;
    assign To2Way4Tag   = ~FLashTemp ?  OutWay4Tag  : 20'b0  ;

endmodule
