`timescale 1ps/1ps
`include "../define.v"
`include "../../IP/data_128x256.xcix"
`include "../../IP/tag_128x256.xcix"

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
    output       wire     [7:0]                       WriteBackCnt ,
    output       wire     [2:0]                       WriteBuffPtr ,
    //to MSHR
    output       wire                                 MSHRAble     ,
    output       wire     [`InstAddrBus]              MSHRAddr     ,
    output       wire     [3:0]                       MSHRWay      ,
    output       wire                                 MSHRLoad     ,
    output       wire                                 MSHRStore    ,
    output       wire     [`DataBus]                  MSHRStoreTemp,
    output       wire     [2:0]                       MSHRPtr      ,  
    input        wire                                 MSHRUpAble   ,
    input        wire     [255:0]                     MSHRUpDate   ,
    input        wire     [`InstAddrBus]              MSHRUpAddr   ,
    input        wire     [3:0]                       MSHRUpWay    ,
    input        wire                                 In2HitAble   ,
    input        wire     [6:0]                       In2HitIndex  ,
    input        wire                                 In2HitWay1   ,
    input        wire                                 In2HitWay2   ,
    input        wire                                 In2HitWay3   ,
    input        wire                                 In2HitWay4   ,
    input        wire                                 Writ2DirtAble,
    input        wire     [6:0]                       Writ2HitIndex,
    input        wire                                 Writ2Way1Hit ,
    input        wire                                 Writ2Way2Hit ,
    input        wire                                 Writ2Way3Hit ,
    input        wire                                 Writ2Way4Hit ,
    //to AGU 
    output       wire                                 LoadBack     ,
    output       wire     [2:0]                       LoadBackPtr  ,
    output       wire     [`DataBus]                  LoadBackDate ,
    output       wire                                 StoreBack    ,
    output       wire     [2:0]                       StoreBackPtr
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

    reg [3:0] Dirty [0:127] ;

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

    reg  [3:0] ReLoadIng [0:127] ;

    wire       ReloadAble  ;
    wire [6:0] ReloadIedx  ;
    wire       ReloadWay1  ;
    wire       ReloadWay2  ;
    wire       ReloadWay3  ;
    wire       ReloadWay4  ;
    wire       RlSuccAble  ;
    wire [6:0] RlSuccIedx  ;
    wire       RlSuccWay1  ;
    wire       RlSuccWay2  ;
    wire       RlSuccWay3  ;
    wire       RlSuccWay4  ;

    assign RlSuccAble = Writ2DirtAble ;
    assign RlSuccIedx = Writ2HitIndex ;
    assign RlSuccWay1 = Writ2Way1Hit  ;
    assign RlSuccWay2 = Writ2Way2Hit  ;
    assign RlSuccWay3 = Writ2Way3Hit  ;
    assign RlSuccWay4 = Writ2Way4Hit  ;



    integer k ;
    always @(posedge Clk) begin
        if(!Rest) begin
            for (k = 0;k<32;k=k+1 ) begin
                ReLoadIng[k]    <= 4'd0 ;
                ReLoadIng[k+32] <= 4'd0 ;
                ReLoadIng[k+64] <= 4'd0 ;
                ReLoadIng[k+96] <= 4'd0 ;
            end
        end
        else if(ReloadAble) begin
            ReLoadIng[ReloadIedx] <= {ReloadWay4,ReloadWay3,ReloadWay2,ReloadWay1} ;
        end
        else if(RlSuccAble) begin
            ReLoadIng[RlSuccIedx] <= ReLoadIng[RlSuccIedx] & {~RlSuccWay4,~RlSuccWay3,~RlSuccWay2,~RlSuccWay1}  ;
        end
    end


    reg         LoadStoreSelct ;
    reg         RLoadSuccess   ;
    reg         RStoreSuccess  ;
    always @(posedge Clk) begin
        if(!Rest) begin
            LoadStoreSelct <= 1'b0 ;
            RLoadSuccess    <= 1'b0 ;
            RStoreSuccess   <= 1'b0 ;
        end
        else if(LoadAble & StoreAble & ~LoadStoreSelct) begin
            LoadStoreSelct <= 1'b1 ;
            RLoadSuccess    <= 1'b1 ;
            RStoreSuccess   <= 1'b0 ;
        end
        else if(LoadAble & StoreAble & LoadStoreSelct) begin
            LoadStoreSelct <= 1'b0 ;
            RLoadSuccess    <= 1'b0 ;
            RStoreSuccess   <= 1'b1 ;
        end
        else if(LoadAble & ~StoreAble) begin
            LoadStoreSelct <= 1'b1 ;
            RLoadSuccess    <= 1'b1 ;
            RStoreSuccess   <= 1'b0 ;
        end
        else if(~LoadAble & StoreAble) begin
            LoadStoreSelct <= 1'b0 ;
            RLoadSuccess    <= 1'b0 ;
            RStoreSuccess   <= 1'b1 ;
        end
        else begin
            LoadStoreSelct <= 1'b0 ;
            RLoadSuccess    <= 1'b0 ;
            RStoreSuccess   <= 1'b0 ;
        end
    end

    assign LoadSuccess  = RLoadSuccess ;
    assign StoreSuccess = RStoreSuccess;


    wire [6:0] AGUIndex  = ((LoadAble & StoreAble & ~LoadStoreSelct) | (LoadAble & ~StoreAble)) ? LoadPhyAddr [11:5]   :
                           ((LoadAble & StoreAble &  LoadStoreSelct) | (~LoadAble & StoreAble)) ? StorePhyAddr[11:5]   : 7'd0 ;
    wire [4:0] AGUOffset = ((LoadAble & StoreAble & ~LoadStoreSelct) | (LoadAble & ~StoreAble)) ? LoadPhyAddr [4:0]    :
                           ((LoadAble & StoreAble &  LoadStoreSelct) | (~LoadAble & StoreAble)) ? StorePhyAddr[4:0]    : 5'd0 ;
    wire [19:0]AGUTag    = ((LoadAble & StoreAble & ~LoadStoreSelct) | (LoadAble & ~StoreAble)) ? LoadPhyAddr [31:12]  :
                           ((LoadAble & StoreAble &  LoadStoreSelct) | (~LoadAble & StoreAble)) ? StorePhyAddr[31:12]  : 20'd0 ;

    wire       FinalLoad = ((LoadAble & StoreAble & ~LoadStoreSelct) | (LoadAble & ~StoreAble)) ;
    wire       FinalStore= ((LoadAble & StoreAble &  LoadStoreSelct) | (~LoadAble & StoreAble)) ;


    wire         Way1Able   = `AbleValue ;
    wire  [6:0]  Way1Index  = MSHRUpAble              ? MSHRUpAddr[11:5] : 
                              (LoadAble | StoreAble)  ? AGUIndex         : 7'd0 ;
    wire  [31:0] Way1Wen    = ({32{(DcacheHit[0] & FinalStore)}} & {{4{(AGUOffset[4:2] == 3'd7)}},
                                                                    {4{(AGUOffset[4:2] == 3'd6)}},
                                                                    {4{(AGUOffset[4:2] == 3'd5)}},
                                                                    {4{(AGUOffset[4:2] == 3'd4)}},
                                                                    {4{(AGUOffset[4:2] == 3'd3)}},
                                                                    {4{(AGUOffset[4:2] == 3'd2)}},
                                                                    {4{(AGUOffset[4:2] == 3'd1)}},
                                                                    {4{(AGUOffset[4:2] == 3'd0)}}}) | {32{(MSHRUpAble & MSHRUpWay[0])}} ;
    wire         Way1TagWen = (MSHRUpAble & MSHRUpWay[0])   ;
    wire  [19:0] Way1Tag    = MSHRUpAddr[31:12]  ;
    wire  [255:0]Way1Date   = (DcacheHit[0] & FinalStore) ? {StoreDate,StoreDate,StoreDate,StoreDate,StoreDate,StoreDate,StoreDate,StoreDate} :
                              (MSHRUpAble & MSHRUpWay[0]) ? MSHRUpDate                                                                        : 256'd0 ;
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
    .wea   ( Way1TagWen  ),
    .addra ( Way1Index   ),
    .dina  ( Way1Tag     ),
    .douta ( OutWay1Tag  )
    ); 

    wire         Way2Able   = `AbleValue ;
    wire  [6:0]  Way2Index  = MSHRUpAble              ? MSHRUpAddr[11:5] : 
                              (LoadAble | StoreAble)  ? AGUIndex         : 7'd0 ;
    wire  [31:0] Way2Wen    = ({32{(DcacheHit[1] & FinalStore)}} & {{4{(AGUOffset[4:2] == 3'd7)}},
                                                                    {4{(AGUOffset[4:2] == 3'd6)}},
                                                                    {4{(AGUOffset[4:2] == 3'd5)}},
                                                                    {4{(AGUOffset[4:2] == 3'd4)}},
                                                                    {4{(AGUOffset[4:2] == 3'd3)}},
                                                                    {4{(AGUOffset[4:2] == 3'd2)}},
                                                                    {4{(AGUOffset[4:2] == 3'd1)}},
                                                                    {4{(AGUOffset[4:2] == 3'd0)}}}) | {32{(MSHRUpAble & MSHRUpWay[1])}} ;
    wire         Way2TagWen = (MSHRUpAble & MSHRUpWay[1])   ;
    wire  [19:0] Way2Tag    = MSHRUpAddr[31:12]  ;
    wire  [255:0]Way2Date   = (DcacheHit[1] & FinalStore) ? {StoreDate,StoreDate,StoreDate,StoreDate,StoreDate,StoreDate,StoreDate,StoreDate} :
                              (MSHRUpAble & MSHRUpWay[1]) ? MSHRUpDate                                                                        : 256'd0 ;

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
    .wea   ( Way2TagWen  ),
    .addra ( Way2Index   ),
    .dina  ( Way2Tag     ),
    .douta ( OutWay2Tag  )
    ); 

    wire         Way3Able   = `AbleValue ;
    wire  [6:0]  Way3Index  = MSHRUpAble              ? MSHRUpAddr[11:5] : 
                              (LoadAble | StoreAble)  ? AGUIndex         : 7'd0 ;
    wire  [31:0] Way3Wen    = ({32{(DcacheHit[2] & FinalStore)}} & {{4{(AGUOffset[4:2] == 3'd7)}},
                                                                    {4{(AGUOffset[4:2] == 3'd6)}},
                                                                    {4{(AGUOffset[4:2] == 3'd5)}},
                                                                    {4{(AGUOffset[4:2] == 3'd4)}},
                                                                    {4{(AGUOffset[4:2] == 3'd3)}},
                                                                    {4{(AGUOffset[4:2] == 3'd2)}},
                                                                    {4{(AGUOffset[4:2] == 3'd1)}},
                                                                    {4{(AGUOffset[4:2] == 3'd0)}}}) | {32{(MSHRUpAble & MSHRUpWay[2])}} ;
    wire         Way3TagWen = (MSHRUpAble & MSHRUpWay[2])   ;
    wire  [19:0] Way3Tag    = MSHRUpAddr[31:12]  ;
    wire  [255:0]Way3Date   = (DcacheHit[2] & FinalStore) ? {StoreDate,StoreDate,StoreDate,StoreDate,StoreDate,StoreDate,StoreDate,StoreDate} :
                              (MSHRUpAble & MSHRUpWay[2]) ? MSHRUpDate                                                                        : 256'd0 ;

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
    .wea   ( Way3TagWen  ),
    .addra ( Way3Index   ),
    .dina  ( Way3Tag     ),
    .douta ( OutWay3Tag  )
    ); 

    wire         Way4Able   = `AbleValue ;
    wire  [6:0]  Way4Index  = MSHRUpAble              ? MSHRUpAddr[11:5] : 
                              (LoadAble | StoreAble)  ? AGUIndex         : 7'd0 ;
    wire  [31:0] Way4Wen    = ({32{(DcacheHit[3] & FinalStore)}} & {{4{(AGUOffset[4:2] == 3'd7)}},
                                                                    {4{(AGUOffset[4:2] == 3'd6)}},
                                                                    {4{(AGUOffset[4:2] == 3'd5)}},
                                                                    {4{(AGUOffset[4:2] == 3'd4)}},
                                                                    {4{(AGUOffset[4:2] == 3'd3)}},
                                                                    {4{(AGUOffset[4:2] == 3'd2)}},
                                                                    {4{(AGUOffset[4:2] == 3'd1)}},
                                                                    {4{(AGUOffset[4:2] == 3'd0)}}}) | {32{(MSHRUpAble & MSHRUpWay[3])}} ;
    wire         Way4TagWen = (MSHRUpAble & MSHRUpWay[3])   ;
    wire  [19:0] Way4Tag    = MSHRUpAddr[31:12]  ;
    wire  [255:0]Way4Date   = (DcacheHit[3] & FinalStore) ? {StoreDate,StoreDate,StoreDate,StoreDate,StoreDate,StoreDate,StoreDate,StoreDate} :
                              (MSHRUpAble & MSHRUpWay[3]) ? MSHRUpDate                                                                        : 256'd0 ;

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
    .wea   ( Way4TagWen  ),
    .addra ( Way4Index   ),
    .dina  ( Way4Tag     ),
    .douta ( OutWay4Tag  )
    ); 

    wire [1:0]  DcacheMat  = ((LoadAble & StoreAble & ~LoadStoreSelct) | (LoadAble & ~StoreAble)) ? LoadMat   :
                             ((LoadAble & StoreAble &  LoadStoreSelct) | (~LoadAble & StoreAble)) ? StoreMat  :  2'b0 ;

    wire [3:0]  DcacheHit  = {4{(AGUTag == OutWay4Tag) & (DcacheMat != 2'b00) & ((FinalStore & (ReLoadIng[AGUIndex][3])) | (FinalLoad))}} & 4'b1000 |
                             {4{(AGUTag == OutWay3Tag) & (DcacheMat != 2'b00) & ((FinalStore & (ReLoadIng[AGUIndex][2])) | (FinalLoad))}} & 4'b0100 |
                             {4{(AGUTag == OutWay2Tag) & (DcacheMat != 2'b00) & ((FinalStore & (ReLoadIng[AGUIndex][1])) | (FinalLoad))}} & 4'b0010 |
                             {4{(AGUTag == OutWay1Tag) & (DcacheMat != 2'b00) & ((FinalStore & (ReLoadIng[AGUIndex][0])) | (FinalLoad))}} & 4'b0001 ;

    wire [255:0]DcacheHitDate = {256{(AGUTag == OutWay4Tag) & (DcacheMat != 2'b00)}} & Way4Date |
                                {256{(AGUTag == OutWay3Tag) & (DcacheMat != 2'b00)}} & Way3Date |
                                {256{(AGUTag == OutWay2Tag) & (DcacheMat != 2'b00)}} & Way2Date |
                                {256{(AGUTag == OutWay1Tag) & (DcacheMat != 2'b00)}} & Way1Date ;

    wire [255:0] LoadOut = DcacheHitDate >> {AGUOffset[4:2],5'd0} ;

    wire [6:0]  DIrtyindex = MSHRUpAble             ? MSHRUpAddr[11:5]   : 
                             (LoadAble | StoreAble) ? AGUIndex           : 7'd0 ;
    wire [3:0]  DcacheDirty= Dirty[DIrtyindex] ;

    wire [3:0]  ReplaceSelect = {4{((CountWay4[AGUIndex] > CountWay1[AGUIndex]) & (CountWay4[AGUIndex] > CountWay2[AGUIndex]) & 
                                  (CountWay4[AGUIndex] > CountWay3[AGUIndex]))}} & 4'b1000 |
                                {4{ ((CountWay3[AGUIndex] > CountWay1[AGUIndex]) & (CountWay3[AGUIndex] > CountWay2[AGUIndex]) & 
                                  (CountWay3[AGUIndex] > CountWay4[AGUIndex]))}} & 4'b0100 |
                                {4{((CountWay2[AGUIndex] > CountWay1[AGUIndex]) & (CountWay2[AGUIndex] > CountWay3[AGUIndex]) & 
                                  (CountWay2[AGUIndex] > CountWay4[AGUIndex]))}} & 4'b0010 |
                                {4{((CountWay1[AGUIndex] > CountWay2[AGUIndex]) & (CountWay1[AGUIndex] > CountWay3[AGUIndex]) & 
                                  (CountWay1[AGUIndex] > CountWay4[AGUIndex]))}} & 4'b0001 ;

    wire [3:0] DirtyReplace = ReplaceSelect & DcacheDirty ;
    
    assign WriteBuffAble = ((((FinalLoad) && (DirtyReplace != 4'b0000)) || (FinalStore && ((DirtyReplace != 4'b0000) || (DcacheMat == 2'b00)))) && (DcacheHit == 4'b0000)); 
    assign WriteBuffAddr = {AGUTag, AGUIndex,5'd0} ;
    assign WriteBuffPtr  = ((LoadAble & StoreAble & ~LoadStoreSelct) | (LoadAble & ~StoreAble)) ? LoadPtr   :
                           ((LoadAble & StoreAble &  LoadStoreSelct) | (~LoadAble & StoreAble)) ? StorePtr  :  3'b0 ;

    assign WriteBackCnt  = (FinalStore && (DcacheMat != 2'b00)) ? 8'b00000001 : 8'b11111111 ;
    assign WriteBackDate = (FinalStore && (DcacheMat != 2'b00)) ? {224'd0,StoreDate} : ({256{ReplaceSelect[0] & DcacheDirty[0]}} & OutWay1Date | 
                                                                                        {256{ReplaceSelect[1] & DcacheDirty[1]}} & OutWay2Date | 
                                                                                        {256{ReplaceSelect[2] & DcacheDirty[2]}} & OutWay3Date | 
                                                                                        {256{ReplaceSelect[3] & DcacheDirty[3]}} & OutWay4Date ) ;

    assign WriteBackAble = (((FinalLoad) && (DirtyReplace != 4'b0000)) | (FinalStore && ((DirtyReplace != 4'b0000) && (DcacheMat != 2'b00))) && (DcacheHit == 4'b0000)); 
    assign WriteBackIdex = AGUIndex ;
    assign WriteBack1Hit = ReplaceSelect[0] & DcacheDirty[0] ;
    assign WriteBack2Hit = ReplaceSelect[1] & DcacheDirty[1] ;
    assign WriteBack3Hit = ReplaceSelect[2] & DcacheDirty[2] ;
    assign WriteBack4Hit = ReplaceSelect[3] & DcacheDirty[3] ;

    assign InHitAble     = ((FinalLoad | FinalStore) & (DcacheHit != 4'd0 )) | (In2HitAble);
    assign InHitIndex    = (FinalLoad | FinalStore) ? AGUIndex    : 
                           In2HitAble               ? In2HitIndex : 7'd0 ;
    assign InHitWay1     = (FinalLoad | FinalStore) ? DcacheHit[0]: 
                           In2HitAble               ? In2HitWay1  : 1'd0 ;
    assign InHitWay2     = (FinalLoad | FinalStore) ? DcacheHit[1]: 
                           In2HitAble               ? In2HitWay2  : 1'd0 ;
    assign InHitWay3     = (FinalLoad | FinalStore) ? DcacheHit[2]: 
                           In2HitAble               ? In2HitWay3  : 1'd0 ;
    assign InHitWay4     = (FinalLoad | FinalStore) ? DcacheHit[3]: 
                           In2HitAble               ? In2HitWay4  : 1'd0 ;

    assign WriteDirtAble = (FinalStore & (DcacheHit != 4'd0 )) | Writ2DirtAble ;
    assign WriteHitIndex = FinalStore    ? AGUIndex      : 
                           Writ2DirtAble ? Writ2HitIndex : 7'd0 ;
    assign WriteWay1Hit  = FinalStore    ? DcacheHit[0]  : 
                           Writ2DirtAble ? Writ2Way1Hit  : 1'd0 ;
    assign WriteWay2Hit  = FinalStore    ? DcacheHit[1]  : 
                           Writ2DirtAble ? Writ2Way2Hit  : 1'd0 ;
    assign WriteWay3Hit  = FinalStore    ? DcacheHit[2]  : 
                           Writ2DirtAble ? Writ2Way3Hit  : 1'd0 ;
    assign WriteWay4Hit  = FinalStore    ? DcacheHit[3]  : 
                           Writ2DirtAble ? Writ2Way4Hit  : 1'd0 ;

    assign MSHRAble      = (FinalLoad | FinalStore ) && (DcacheHit == 4'b0000) ;
    assign MSHRAddr      = {AGUTag, AGUIndex,5'd0} ; 
    assign MSHRLoad      = FinalLoad  ;
    assign MSHRStore     = FinalStore ;
    assign MSHRStoreTemp = FinalStore ? StoreDate : 32'd0 ;
    assign MSHRWay       = ReplaceSelect ;
    assign MSHRPtr       = ((LoadAble & StoreAble & ~LoadStoreSelct) | (LoadAble & ~StoreAble)) ? LoadPtr   :
                           ((LoadAble & StoreAble &  LoadStoreSelct) | (~LoadAble & StoreAble)) ? StorePtr  :  3'b0 ;

    assign ReloadAble    = (FinalLoad | (FinalStore && (DcacheMat != 2'b00))) && (DcacheHit == 4'b0000) ;
    assign ReloadIedx    = AGUIndex ;
    assign WriteWay1Hit  = ReplaceSelect[0] ;
    assign WriteWay1Hit  = ReplaceSelect[1] ;
    assign WriteWay1Hit  = ReplaceSelect[2] ;
    assign WriteWay1Hit  = ReplaceSelect[3] ;



    reg                RLoadBack     ;
    reg    [2:0]       RLoadBackPtr  ;
    reg    [`DataBus]  RLoadBackDate ;
    reg                RStoreBack    ;
    reg    [2:0]       RStoreBackPtr ;

    always @(posedge Clk) begin
        if(!Rest) begin
            RLoadBack <= `EnableValue ;
            RLoadBackPtr <= 3'd0   ;
            RLoadBackDate <= 32'd0 ;
            RStoreBack <= `EnableValue ;
            RStoreBackPtr <= 3'd0 ;
        end
        else begin
            RLoadBack <= (DcacheHit != 4'b0000) & FinalLoad  ;
            RLoadBackPtr <= LoadPtr   ;
            RLoadBackDate <= LoadOut[31:0];
            RStoreBack <= (DcacheHit != 4'b0000) & FinalStore ;
            RStoreBackPtr <= StorePtr ;
        end
    end

    assign LoadBack     = RLoadBack      ;
    assign LoadBackPtr  = RLoadBackPtr   ;
    assign LoadBackDate = RLoadBackDate  ;
    assign StoreBack    = RStoreBack     ;
    assign StoreBackPtr = RStoreBackPtr  ;
    

endmodule 
