`timescale 1ps/1ps
`include "../define.v"

module DCacheStage1 (
    input        wire                                 Clk          ,
    input        wire                                 Rest         ,
    // for ctrl 
    input        wire                                 DcacheStop   ,
    input        wire                                 DcacheFlash  ,
    output       wire                                 DcacheReq    ,
    //from AGU1
    input        wire                                 LoadAble     ,
    input        wire     [1:0]                       LoadMat      ,
    input        wire     [2:0]                       LoadPtr      ,
    output       wire                                 LoadSuccess  ,
    input        wire     [`InstAddrBus]              LoadPhyAddr  ,
    //from AGU2
    input        wire                                 StoreAble    ,
    input        wire     [1:0]                       StoreMat     , 
    input        wire     [2:0]                       StorePtr     ,
    input        wire     [`DataBus]                  StoreDate    ,
    output       wire                                 StoreSuccess ,
    input        wire     [`InstAddrBus]              StorePhyAddr , 
    //to WriteBuffer
    output       wire                                 WriteBuffAble,
    output       wire     [`InstAddrBus]              WriteBuffAddr,
    output       wire     [255:0]                     WriteBackDate,
    output       wire     [3:0]                       WriteBackCnt ,
    output       wire     [2:0]                       WriteBuffPtr ,
    //to MSHR
    output       wire                                 MSHRAble     ,
    output       wire     [`InstAddrBus]              MSHRAddr     ,
    output       wire     [3:0]                       MSHRWay      ,
    output       wire     [2:0]                       MSHRPtr      ,  
    input        wire                                 MSHRUpAble   ,
    input        wire     [255:0]                     MSHRUpDate   ,
    input        wire     [6:0]                       MSHRUpIndex  ,
    input        wire     [4:0]                       MSHRUpOffset ,
    input        wire     [3:0]                       MSHRUpWay    ,
    //hit cont up 
    input        wire                                 HitUpCntAble ,
    input        wire     [6:0]                       HitUpIndex   ,
    input        wire                                 InHitWay1    ,
    input        wire                                 InHitWay2    ,
    input        wire                                 InHitWay3    ,   
    input        wire                                 InHitWay4    ,
    //up New enty 
    input        wire                                 InNewAble    ,
    input        wire     [5:0]                       InNewIndex   ,
    input        wire     [19:0]                      InNewTag     ,
    input        wire     [511:0]                     InNewDate     
    
);

    reg   [2:0]  CountWay1 [0:127] ;
    reg   [2:0]  CountWay2 [0:127] ;
    reg   [2:0]  CountWay3 [0:127] ;
    reg   [2:0]  CountWay4 [0:127] ;

    wire       InHitAble  ;
    wire [6:0] InHitIndex ; 
    wire       InHitWay1  ;
    wire       InHitWay2  ;
    wire       InHitWay3  ;
    wire       InHitWay4  ;

    integer i ;
    always @(posedge Clk) begin
        if(!Rest) begin
            for (i =0 ;i<32 ;i=i+1 ) begin
                CountWay1[i]    <= 3'd0 ;
                CountWay1[i+32] <= 3'd0 ;
                CountWay1[i+64] <= 3'd0 ;
                CountWay1[i+96] <= 3'd0 ;
                CountWay2[i]    <= 3'd0 ;
                CountWay2[i+32] <= 3'd0 ;
                CountWay2[i+64] <= 3'd0 ;
                CountWay2[i+96] <= 3'd0 ;
                CountWay3[i]    <= 3'd0 ;
                CountWay3[i+32] <= 3'd0 ;
                CountWay3[i+64] <= 3'd0 ;
                CountWay3[i+96] <= 3'd0 ;
                CountWay4[i]    <= 3'd0 ;
                CountWay4[i+32] <= 3'd0 ;
                CountWay4[i+64] <= 3'd0 ;
                CountWay4[i+96] <= 3'd0 ;
            end
        end
        else begin
            if(InHitAble) begin
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

    reg [3:0] Dirty [127:0] ;

    wire       WriteDirtAble ;
    wire [6:0] WriteHitIndex ;
    wire       WriteWay1Hit  ;
    wire       WriteWay2Hit  ;
    wire       WriteWay3Hit  ;
    wire       WriteWay4Hit  ;
    wire       WriteBackAble ;
    wire [6:0] WriteBackIdex ;
    wire       WriteBack1Hit ;
    wire       WriteBack2Hit ;
    wire       WriteBack3Hit ;
    wire       WriteBack4Hit ;



    integer j ;
    always @(posedge Clk) begin
        if(!Rest) begin
            for (j =0 ;j < 32; j=j+1) begin
                Dirty[i] <= 4'd0 ; 
                Dirty[i+32] <= 4'd0 ; 
                Dirty[i+64] <= 4'd0 ; 
                Dirty[i+96] <= 4'd0 ; 
            end
        end
        else begin
            Dirty[WriteHitIndex] <= WriteDirtAble ? (Dirty[WriteHitIndex] | {WriteWay4Hit,WriteWay3Hit,WriteWay2Hit,WriteWay1Hit}) : Dirty[WriteHitIndex] ;
            Dirty[WriteBackIdex] <= WriteBackAble ? (Dirty[WriteBackIdex] & {~WriteBack4Hit,~WriteBack3Hit,~WriteBack2Hit,~WriteBack1Hit}) : Dirty[WriteBackIdex] ;
        end
    end 


    reg         LoadStoreSelct ;
    reg         LoadSuccess    ;
    reg         StoreSuccess   ;
    always @(posedge Clk) begin
        if(!Rest) begin
            LoadStoreSelct <= 1'b0 ;
            LoadSuccess    <= 1'b0 ;
            StoreSuccess   <= 1'b0 ;
        end
        else if(LoadAble & StoreAble & ~LoadStoreSelct) begin
            LoadStoreSelct <= 1'b1 ;
            LoadSuccess    <= 1'b1 ;
            StoreSuccess   <= 1'b0 ;
        end
        else if(LoadAble & StoreAble & LoadStoreSelct) begin
            LoadStoreSelct <= 1'b0 ;
            LoadSuccess    <= 1'b0 ;
            StoreSuccess   <= 1'b1 ;
        end
        else if(LoadAble & ~StoreAble) begin
            LoadStoreSelct <= 1'b1 ;
            LoadSuccess    <= 1'b1 ;
            StoreSuccess   <= 1'b0 ;
        end
        else if(~LoadAble & StoreAble) begin
            LoadStoreSelct <= 1'b0 ;
            LoadSuccess    <= 1'b0 ;
            StoreSuccess   <= 1'b1 ;
        end
        else begin
            LoadStoreSelct <= 1'b0 ;
            LoadSuccess    <= 1'b0 ;
            StoreSuccess   <= 1'b0 ;
        end
    end


    wire [6:0] AGUIndex  = ((LoadAble & StoreAble & ~LoadStoreSelct) | (LoadAble & ~StoreAble)) ? LoadPhyAddr [11:5]   :
                           ((LoadAble & StoreAble &  LoadStoreSelct) | (~LoadAble & StoreAble)) ? StorePhyAddr[11:5]   : 7'd0 ;
    wire [4:0] AGUOffset = ((LoadAble & StoreAble & ~LoadStoreSelct) | (LoadAble & ~StoreAble)) ? LoadPhyAddr [4:0]    :
                           ((LoadAble & StoreAble &  LoadStoreSelct) | (~LoadAble & StoreAble)) ? StorePhyAddr[4:0]    : 5'd0 ;
    wire [19:0]AGUTag    = ((LoadAble & StoreAble & ~LoadStoreSelct) | (LoadAble & ~StoreAble)) ? LoadPhyAddr [31:12]  :
                           ((LoadAble & StoreAble &  LoadStoreSelct) | (~LoadAble & StoreAble)) ? StorePhyAddr[31:12]  : 20'd0 ;

    wire       FinalLoad = ((LoadAble & StoreAble & ~LoadStoreSelct) | (LoadAble & ~StoreAble)) ;
    wire       FinalStore= ((LoadAble & StoreAble &  LoadStoreSelct) | (~LoadAble & StoreAble)) ;


    wire         Way1Able = `AbleValue ;
    wire  [6:0]  Way1Index= InNewAble              ? InNewIndex         : 
                            (LoadAble | StoreAble) ? AGUIndex           : 7'd0 ;
    wire         Way1Wen  = InNewAble & (((CountWay1[InNewIndex] > CountWay2[InNewIndex]) & (CountWay1[InNewIndex] > CountWay3[InNewIndex]) & 
                                          (CountWay1[InNewIndex] > CountWay4[InNewIndex])) | (CountWay1[InNewIndex] == 3'b111));
    wire  [19:0] Way1Tag  = InNewTag  ;
    wire  [255:0]Way1Date = InNewDate ;
    wire  [19:0] OutWay1Tag   ;
    wire  [255:0]OutWay1Date  ;


    data_128x256 way1_data_128x256(
    .clka  ( Clk         ),
    .ena   ( Way1Able    ),
    .wea   ( Way1Wen     ),
    .addra ( Way1Index   ),
    .dina  ( Way1Date    ),
    .douta ( OutWay1Date )
    ); 

    tag_128x256 way1_tag_128x256(
    .clka  ( Clk         ),
    .ena   ( Way1Able    ),
    .wea   ( Way1Wen     ),
    .addra ( Way1Index   ),
    .dina  ( Way1Tag     ),
    .douta ( OutWay1Tag  )
    ); 

    wire         Way2Able = `AbleValue ;
    wire  [6:0]  Way2Index= InNewAble              ? InNewIndex         : 
                            (LoadAble | StoreAble) ? AGUIndex           : 7'd0 ;
    wire         Way2Wen  = InNewAble & (((CountWay2[InNewIndex] > CountWay1[InNewIndex]) & (CountWay2[InNewIndex] > CountWay3[InNewIndex]) & 
                                          (CountWay2[InNewIndex] > CountWay4[InNewIndex])) | (CountWay2[InNewIndex] == 3'b111));
    wire  [19:0] Way2Tag  = InNewTag  ;
    wire  [255:0]Way2Date = InNewDate ;

    wire  [19:0] OutWay2Tag   ;
    wire  [255:0]OutWay2Date  ;

    data_128x256 way2_data_128x256(
    .clka  ( Clk         ),
    .ena   ( Way2Able    ),
    .wea   ( Way2Wen     ),
    .addra ( Way2Index   ),
    .dina  ( Way2Date    ),
    .douta ( OutWay2Date )
    ); 

    tag_128x256 way2_tag_128x256(
    .clka  ( Clk         ),
    .ena   ( Way2Able    ),
    .wea   ( Way2Wen     ),
    .addra ( Way2Index   ),
    .dina  ( Way2Tag     ),
    .douta ( OutWay2Tag  )
    ); 

    wire         Way3Able = `AbleValue ;
    wire  [5:0]  Way3Index= InNewAble              ? InNewIndex         : 
                            (LoadAble | StoreAble) ? AGUIndex           : 7'd0 ;
    wire         Way3Wen  = InNewAble & (((CountWay4[InNewIndex] > CountWay1[InNewIndex]) & (CountWay3[InNewIndex] > CountWay2[InNewIndex]) & 
                                          (CountWay4[InNewIndex] > CountWay4[InNewIndex])) | (CountWay3[InNewIndex] == 3'b111));
    wire  [19:0] Way3Tag  = InNewTag  ;
    wire  [255:0]Way3Date = InNewDate ;

    wire  [19:0] OutWay3Tag   ;
    wire  [255:0]OutWay3Date  ;

    data_128x256 way3_data_128x256(
    .clka  ( Clk         ),
    .ena   ( Way3Able    ),
    .wea   ( Way3Wen     ),
    .addra ( Way3Index   ),
    .dina  ( Way3Date    ),
    .douta ( OutWay3Date )
    ); 

    tag_128x256 way3_tag_128x256(
    .clka  ( Clk         ),
    .ena   ( Way3Able    ),
    .wea   ( Way3Wen     ),
    .addra ( Way3Index   ),
    .dina  ( Way3Tag     ),
    .douta ( OutWay3Tag  )
    ); 

    wire         Way4Able = `AbleValue ;
    wire  [5:0]  Way4Index= InNewAble              ? InNewIndex         : 
                            (LoadAble | StoreAble) ? AGUIndex           : 7'd0 ;
    wire         Way4Wen  = InNewAble & (((CountWay3[InNewIndex] > CountWay1[InNewIndex]) & (CountWay3[InNewIndex] > CountWay2[InNewIndex]) & 
                                          (CountWay3[InNewIndex] > CountWay4[InNewIndex])) | (CountWay3[InNewIndex] == 3'b111));
    wire  [19:0] Way4Tag  = InNewTag  ;
    wire  [255:0]Way4Date = InNewDate ;

    wire  [19:0] OutWay4Tag   ;
    wire  [255:0]OutWay4Date  ;

    data_128x256 way4_data_128x256(
    .clka  ( Clk         ),
    .ena   ( Way4Able    ),
    .wea   ( Way4Wen     ),
    .addra ( Way4Index   ),
    .dina  ( Way4Date    ),
    .douta ( OutWay4Date )
    ); 

    tag_128x256 way4_tag_128x256(
    .clka  ( Clk         ),
    .ena   ( Way4Able    ),
    .wea   ( Way4Wen     ),
    .addra ( Way4Index   ),
    .dina  ( Way4Tag     ),
    .douta ( OutWay4Tag  )
    ); 

    wire [1:0]  DcacheMat = ((LoadAble & StoreAble & ~LoadStoreSelct) | (LoadAble & ~StoreAble)) ? LoadMat   :
                            ((LoadAble & StoreAble &  LoadStoreSelct) | (~LoadAble & StoreAble)) ? StoreMat  :  2'b0 ;

    wire [3:0]  DcacheHit  = {4{(AGUTag == OutWay4Tag) & (DcacheMat == 2'b00)}} & 4'b1000 |
                             {4{(AGUTag == OutWay3Tag) & (DcacheMat == 2'b00)}} & 4'b0100 |
                             {4{(AGUTag == OutWay2Tag) & (DcacheMat == 2'b00)}} & 4'b0010 |
                             {4{(AGUTag == OutWay1Tag) & (DcacheMat == 2'b00)}} & 4'b0001 ;

    wire [5:0]  DIrtyindex = InNewAble              ? InNewIndex         : 
                             (LoadAble | StoreAble) ? AGUIndex           : 7'd0 ;
    wire [3:0]  DcacheDirty= Dirty[DIrtyindex] ;

    wire [3:0]  ReplaceSelect = (((CountWay4[InNewIndex] > CountWay1[InNewIndex]) & (CountWay4[InNewIndex] > CountWay2[InNewIndex]) & 
                                  (CountWay4[InNewIndex] > CountWay3[InNewIndex]))) & 4'b1000 |
                                (((CountWay3[InNewIndex] > CountWay1[InNewIndex]) & (CountWay3[InNewIndex] > CountWay2[InNewIndex]) & 
                                  (CountWay3[InNewIndex] > CountWay4[InNewIndex]))) & 4'b0100 |
                                (((CountWay2[InNewIndex] > CountWay1[InNewIndex]) & (CountWay2[InNewIndex] > CountWay3[InNewIndex]) & 
                                  (CountWay2[InNewIndex] > CountWay4[InNewIndex]))) & 4'b0010 |
                                (((CountWay1[InNewIndex] > CountWay2[InNewIndex]) & (CountWay1[InNewIndex] > CountWay3[InNewIndex]) & 
                                  (CountWay1[InNewIndex] > CountWay4[InNewIndex]))) & 4'b0001 ;
    
    assign WriteBuffAble = (((FinalLoad) && (ReplaceSelect & DcacheDirty)) | (FinalStore && ((ReplaceSelect & DcacheDirty) | (DcacheMat == 2'b00))) && (DcacheHit == 4'b0000)); 
    assign WriteBuffAddr = {AGUTag, AGUIndex,5'd0} ;
    assign WriteBuffPtr  = ((LoadAble & StoreAble & ~LoadStoreSelct) | (LoadAble & ~StoreAble)) ? LoadPtr   :
                           ((LoadAble & StoreAble &  LoadStoreSelct) | (~LoadAble & StoreAble)) ? StorePtr  :  3'b0 ;

    assign WriteBackCnt  = (FinalStore && (DcacheMat != 2'b00)) ? 4'd1 : 4'd8 ;
    assign WriteBackDate = (FinalStore && (DcacheMat != 2'b00)) ? {224'd0,StoreDate} : ({256{ReplaceSelect[0] & DcacheDirty[0]}} & OutWay1Date | 
                                                                                        {256{ReplaceSelect[1] & DcacheDirty[1]}} & OutWay2Date | 
                                                                                        {256{ReplaceSelect[2] & DcacheDirty[2]}} & OutWay3Date | 
                                                                                        {256{ReplaceSelect[3] & DcacheDirty[3]}} & OutWay4Date ) ;

    assign MSHRAble      = 
    

endmodule 
