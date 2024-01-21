`timescale 1ps/1ps  
`include "define.v"

module Mul #(
    parameter WIDTH = 32
)(
    input         wire                                 Clk             ,
    input         wire                                 Rest            ,

    input         wire      [`MicOperateCode]          MultipMicOperate,
    input         wire                                 MultipAbleValue ,
    input         wire      [WIDTH-1:0]                Multiplier      ,
    input         wire      [`ArchRegBUs]              ReDataAddr      ,
    input         wire      [WIDTH-1:0]                Multiplicand    ,
    output        wire      [WIDTH-1:0]                ProductDate     ,
    output        wire                                 IqReqAbleValue  ,
    output        wire                                 ProductAbleValue
);

    // wire  [WIDTH  :0]     MulDateTempt              ;
    // wire  [WIDTH-1:0]     Bmultiper                 ;
    // wire  [WIDTH*2-1:0]   Booth        [1:WIDTH%2];
    // assign                MulDateTempt = {Multiplicand,1'b0} ;
    // assign                Bmultiper    = (Multiplier[31]) ? ~(Multiplier-1): (~Multiplier+1);

    // genvar BoothCodeLoop;
    // generate
    //     for (BoothCodeLoop = 1; BoothCodeLoop < WIDTH ; BoothCodeLoop = BoothCodeLoop+2) begin:BoothLoop
    //         assign Booth[(BoothCodeLoop+1)%2] = (MulDateTempt[BoothCodeLoop+1:BoothCodeLoop-1] == 3'b000)? `ZeroBoothDate                 :
    //                                 (MulDateTempt[BoothCodeLoop+1:BoothCodeLoop-1] == 3'b001)? {{WIDTH{Multiplier[31]}},Multiplier}       :
    //                                 (MulDateTempt[BoothCodeLoop+1:BoothCodeLoop-1] == 3'b010)? {{WIDTH{Multiplier[31]}},Multiplier}       :
    //                                 (MulDateTempt[BoothCodeLoop+1:BoothCodeLoop-1] == 3'b011)? {{WIDTH-1{Multiplier[31]}},Multiplier,1'b0}:
    //                                 (MulDateTempt[BoothCodeLoop+1:BoothCodeLoop-1] == 3'b100)? {{WIDTH-1{Bmultiper[31]}},Bmultiper ,1'b0} :
    //                                 (MulDateTempt[BoothCodeLoop+1:BoothCodeLoop-1] == 3'b101)? {{WIDTH{Bmultiper[31]}},Bmultiper}         :
    //                                 (MulDateTempt[BoothCodeLoop+1:BoothCodeLoop-1] == 3'b110)? {{WIDTH{Bmultiper[31]}},Bmultiper}         :`ZeroBoothDate;
    //     end
    // endgenerate

    // reg   [`MulStateBus]    BoothMulState   ;
    // //reg   [`MulStateBus]  NextMulState    ;
    // reg   [WIDTH*2-1   :0]  BoothCode [0:15];
    // reg   [7:0]             ValueLoop       ;

    // always @(posedge Clk) begin
    //     if(!Rest)
    //         BoothMulState <= `MulIdle    ;
    //     else 
    //         case (BoothMulState)
    //             `MulIdle    : if(MultipAbleValue)  BoothMulState <= `L1MulWallec    ; 
    //                           else                 BoothMulState <= `MulIdle        ;
    //             `L1MulWallec:                      BoothMulState <= `L2MulWallec    ;   
    //             `L2MulWallec:                      BoothMulState <= `L3MulWallec    ;
    //             `L3MulWallec:                      BoothMulState <= `MulOutDate     ;
    //             `MulOutDate :                      BoothMulState <= `MulIdle        ;
    //             default:                           BoothMulState <= `MulIdle        ;
    //         endcase
    // end

    // always @(posedge Clk) begin
    //     if(!Rest)begin
    //         for (ValueLoop = 0;ValueLoop < 16 ;ValueLoop = ValueLoop+1) begin
    //             BoothCode[ValueLoop[3:0]] <= `ZeroBoothDate;
    //         end
    //     end 
    //     else begin
    //         if((BoothMulState == `MulIdle)|(MultipAbleValue))begin
    //             for (ValueLoop = 0;ValueLoop < 16 ;ValueLoop = ValueLoop+1) begin
    //                 BoothCode[ValueLoop[3:0]] <= Booth[ValueLoop[3:0]+1] << ValueLoop[3:0];
    //             end
    //         end 
    //         else begin
    //             for (ValueLoop = 0;ValueLoop < 16 ;ValueLoop = ValueLoop+1) begin
    //                 BoothCode[ValueLoop[3:0]] <= `ZeroBoothDate;
    //             end
    //         end 
    //     end 
    // end

    // wire [WIDTH*2-1:0] CrsInt1L1  [0:7];
    // wire [WIDTH*2-1:0] L1Tempt1   [0:3]; 
    // wire [WIDTH*2-1:0] L1Tempt2   [0:3];

    // genvar L1wallecLoop;
    // generate
    //     for (L1wallecLoop = 0;L1wallecLoop < 4 ;L1wallecLoop = L1wallecLoop+1) begin:L1Loop
    //         assign L1Tempt1[L1wallecLoop]  = BoothCode[L1wallecLoop*4-3]^BoothCode[L1wallecLoop*4-2]^BoothCode[L1wallecLoop*4-1]   ;
    //         assign L1Tempt2[L1wallecLoop]  = BoothCode[L1wallecLoop*4-3]&BoothCode[L1wallecLoop*4-2]|BoothCode[L1wallecLoop*4-1]&(BoothCode[L1wallecLoop*4-3]|BoothCode[L1wallecLoop*4-2]);
    //         assign CrsInt1L1[L1wallecLoop*2]     = L1Tempt1[L1wallecLoop]^L1Tempt2[L1wallecLoop]^BoothCode[L1wallecLoop*4];
    //         assign CrsInt1L1[L1wallecLoop*2+1]   = L1Tempt1[L1wallecLoop]&L1Tempt2[L1wallecLoop]|BoothCode[L1wallecLoop*4]&(L1Tempt1[L1wallecLoop]|L1Tempt2[L1wallecLoop])   ;
    //     end
    // endgenerate
    
    // reg [WIDTH*2-1:0] WallecCodeL1[0:7]  ;
    // reg [3:0]         WallecLoop         ;
    // always @(posedge Clk) begin
    //     if(!Rest)begin
    //         for (WallecLoop = 0;WallecLoop < 8 ;WallecLoop = WallecLoop+1) begin
    //             WallecCodeL1[WallecLoop[2:0]] <= `ZeroBoothDate;
    //         end
    //     end
    //     else begin
    //         if(BoothMulState ==`L1MulWallec)begin
    //             for (WallecLoop = 0;WallecLoop < 8 ;WallecLoop = WallecLoop+1) begin
    //                 WallecCodeL1[WallecLoop[2:0]] <= CrsInt1L1[WallecLoop[2:0]];
    //             end                
    //         end
    //         else begin
    //             for (WallecLoop = 0;WallecLoop < 8 ;WallecLoop = WallecLoop+1) begin
    //                 WallecCodeL1[WallecLoop[2:0]] <= `ZeroBoothDate;
    //             end               
    //         end
    //     end 
    // end

    // wire [WIDTH*2-1:0] CrsInt1L2  [0:3];
    // wire [WIDTH*2-1:0] L2Tempt1   [0:1]; 
    // wire [WIDTH*2-1:0] L2Tempt2   [0:1];

    // assign L2Tempt1[0]  = WallecCodeL1[0]^WallecCodeL1[1]^WallecCodeL1[2]  ;
    // assign L2Tempt2[0]  = WallecCodeL1[0]&WallecCodeL1[1]|WallecCodeL1[2]&(WallecCodeL1[0]|WallecCodeL1[1]);
    // assign CrsInt1L2[0] = L2Tempt1[0]^L2Tempt2[0]^WallecCodeL1[3];
    // assign CrsInt1L2[1] = L2Tempt1[0]&L2Tempt2[0]|WallecCodeL1[3]&(L2Tempt1[0]|L2Tempt2[0])   ;
    // assign L2Tempt1[1]  = WallecCodeL1[4]^WallecCodeL1[5]^WallecCodeL1[6]  ;
    // assign L2Tempt2[1]  = WallecCodeL1[4]&WallecCodeL1[5]|WallecCodeL1[6]&(WallecCodeL1[4]|WallecCodeL1[5]);
    // assign CrsInt1L2[2] = L2Tempt1[1]^L2Tempt2[1]^WallecCodeL1[7];
    // assign CrsInt1L2[3] = L2Tempt1[1]&L2Tempt2[1]|WallecCodeL1[7]&(L2Tempt1[1]|L2Tempt2[1])   ;


    // reg  [WIDTH*2-1:0]  WallecCodeL2[0:3]  ;

    // always @(posedge Clk) begin
    //     if(!Rest)begin
    //         WallecCodeL2[0] <= `ZeroBoothDate;
    //         WallecCodeL2[1] <= `ZeroBoothDate;
    //         WallecCodeL2[2] <= `ZeroBoothDate;
    //         WallecCodeL2[3] <= `ZeroBoothDate;
    //     end
    //     else begin
    //         if(BoothMulState == `L2MulWallec)begin
    //             WallecCodeL2[0] <= CrsInt1L2[0];
    //             WallecCodeL2[1] <= CrsInt1L2[1];
    //             WallecCodeL2[2] <= CrsInt1L2[2];
    //             WallecCodeL2[3] <= CrsInt1L2[3]; 
    //         end
    //         else begin
    //             WallecCodeL2[0] <= `ZeroBoothDate;
    //             WallecCodeL2[1] <= `ZeroBoothDate;
    //             WallecCodeL2[2] <= `ZeroBoothDate;
    //             WallecCodeL2[3] <= `ZeroBoothDate;  
    //         end
    //     end 
    // end

    // wire [WIDTH*2-1:0] CrsInt1L3  [0:1];
    // wire [WIDTH*2-1:0] L3Tempt1        ; 
    // wire [WIDTH*2-1:0] L3Tempt2        ;

    // assign L3Tempt1  = WallecCodeL2[0]^WallecCodeL2[1]^WallecCodeL2[2]  ;
    // assign L3Tempt2  = WallecCodeL2[0]&WallecCodeL2[1]|WallecCodeL2[2]&(WallecCodeL2[0]|WallecCodeL2[1]);
    // assign CrsInt1L3[0] = L3Tempt1^L3Tempt2^WallecCodeL2[3];
    // assign CrsInt1L3[1] = L3Tempt1&L3Tempt2|WallecCodeL2[3]&(L3Tempt1|L3Tempt2)   ;

    // reg  [WIDTH*2-1:0]  WallecCodeL3[0:1]   ;

    // always @(posedge Clk) begin
    //     if(!Rest)begin
    //         WallecCodeL3[0] <= `ZeroBoothDate;
    //         WallecCodeL3[1] <= `ZeroBoothDate;
    //     end
    //     else begin
    //         if(BoothMulState == `L3MulWallec)begin
    //             WallecCodeL3[0] <= CrsInt1L3[0];
    //             WallecCodeL3[1] <= CrsInt1L3[1]; 
    //         end
    //         else begin
    //             WallecCodeL3[0] <= `ZeroBoothDate;
    //             WallecCodeL3[1] <= `ZeroBoothDate; 
    //         end
    //     end 
    // end

    // wire 

    // reg [WIDTH-1:0]  MulDate  ;
    // always @(posedge Clk) begin
    //     if(!Rest)begin
    //         MulDate <= `ZeorDate  ;
    //     end
    //     else begin
    //         if(BoothMulState == `MulOutDate)
    //         case (MultipMicOperate)
    //             `InstMulw: ProductDate <= (WallecCodeL3[0]+WallecCodeL3[1]);
    //             default: 
    //         endcase
    //     end

    // end

    wire [WIDTH*2+3:0] FormalMultiplicand;
    assign FormalMultiplicand = (Multiplicand[31] == `AbleValue)?{~{{36{Multiplicand[31]}},Multiplicand}+1}:{{36{Multiplicand[31]}},Multiplicand};
    wire [WIDTH+2  :0] FormalMultiplier  ;
    assign FormalMultiplier   = {{2{Multiplier[31]}},Multiplier,1'b0};

    wire  [WIDTH*2+3:0]   Booth        [1:17];
    wire  [16:0]          Upbit              ;     
    genvar BoothCodeLoop;
    generate
        for (BoothCodeLoop = 1; BoothCodeLoop < WIDTH+2 ; BoothCodeLoop = BoothCodeLoop+2) begin:BoothLoop
            assign {Booth[(BoothCodeLoop+1)%2],Upbit[((BoothCodeLoop-1)%2)]} = (FormalMultiplier[BoothCodeLoop+1:BoothCodeLoop-1] == 3'b000)? {`ZeroBoothDate,1'b0}                               :
                                                                                 (FormalMultiplier[BoothCodeLoop+1:BoothCodeLoop-1] == 3'b001)? {FormalMultiplicand << BoothCodeLoop-1,1'b0}        :
                                                                                 (FormalMultiplier[BoothCodeLoop+1:BoothCodeLoop-1] == 3'b010)? {FormalMultiplicand << BoothCodeLoop-1,1'b0}        :
                                                                                 (FormalMultiplier[BoothCodeLoop+1:BoothCodeLoop-1] == 3'b011)? {FormalMultiplicand  << BoothCodeLoop,1'b0}         :
                                                                                 (FormalMultiplier[BoothCodeLoop+1:BoothCodeLoop-1] == 3'b100)? {(~FormalMultiplicand) << BoothCodeLoop,1'b1}       :
                                                                                 (FormalMultiplier[BoothCodeLoop+1:BoothCodeLoop-1] == 3'b101)? {(~FormalMultiplicand) << BoothCodeLoop-1,1'b1}     :
                                                                                 (FormalMultiplier[BoothCodeLoop+1:BoothCodeLoop-1] == 3'b110)? {(~FormalMultiplicand) << BoothCodeLoop-1,1'b1} :{`ZeroBoothDate,1'b0};
        end
    endgenerate  

    reg  [16:0] SwitchData [1:68] ;
    reg  [6 :0] SwitchLoop        ;
    always @(posedge Clk) begin
        if(!Rest)begin
            for (SwitchLoop = 1;SwitchLoop < 69 ;SwitchLoop = SwitchLoop+1) begin
                SwitchData[SwitchLoop] <= 17'h0 ;
            end
        end
        else begin
            for (SwitchLoop = 1;SwitchLoop < 69 ;SwitchLoop = SwitchLoop+1) begin
                SwitchData[SwitchLoop] <= {Booth[17][SwitchLoop],Booth[16][SwitchLoop],Booth[15][SwitchLoop],Booth[14][SwitchLoop],
                                           Booth[13][SwitchLoop],Booth[12][SwitchLoop],Booth[11][SwitchLoop],Booth[10][SwitchLoop],
                                           Booth[9][SwitchLoop] ,Booth[8][SwitchLoop] ,Booth[7][SwitchLoop] ,Booth[6][SwitchLoop] ,
                                           Booth[5][SwitchLoop] ,Booth[4][SwitchLoop] ,Booth[3][SwitchLoop] ,Booth[2][SwitchLoop] ,Booth[1][SwitchLoop]} ;
            end            
        end
    end

    wire  [WIDTH*2+3:0]  Src1    ;
    wire  [WIDTH*2+3:0]  Src2    ; 
    wire  [13:0]         TempWt  [1:68];

    WaccleTree Wt1  (.SrcIn(SwitchData[1]) , .Cin(Upbit[16:2]), .CoutGroup(TempWt[1]) , .Cout(Src2[0]) , .S(Src1[0]));
    WaccleTree Wt2  (.SrcIn(SwitchData[2]) , .Cin(TempWt[1]) , .CoutGroup(TempWt[2]) , .Cout(Src2[1]) , .S(Src1[1]));
    WaccleTree Wt3  (.SrcIn(SwitchData[3]) , .Cin(TempWt[2]) , .CoutGroup(TempWt[3]) , .Cout(Src2[2]) , .S(Src1[2]));
    WaccleTree Wt4  (.SrcIn(SwitchData[4]) , .Cin(TempWt[3]) , .CoutGroup(TempWt[4]) , .Cout(Src2[3]) , .S(Src1[3]));
    WaccleTree Wt5  (.SrcIn(SwitchData[5]) , .Cin(TempWt[4]) , .CoutGroup(TempWt[5]) , .Cout(Src2[4]) , .S(Src1[4]));
    WaccleTree Wt6  (.SrcIn(SwitchData[6]) , .Cin(TempWt[5]) , .CoutGroup(TempWt[6]) , .Cout(Src2[5]) , .S(Src1[5]));
    WaccleTree Wt7  (.SrcIn(SwitchData[7]) , .Cin(TempWt[6]) , .CoutGroup(TempWt[7]) , .Cout(Src2[6]) , .S(Src1[6]));
    WaccleTree Wt8  (.SrcIn(SwitchData[8]) , .Cin(TempWt[7]) , .CoutGroup(TempWt[8]) , .Cout(Src2[7]) , .S(Src1[7]));
    WaccleTree Wt9  (.SrcIn(SwitchData[9]) , .Cin(TempWt[8]) , .CoutGroup(TempWt[9]) , .Cout(Src2[8]) , .S(Src1[8]));
    WaccleTree Wt10 (.SrcIn(SwitchData[10]), .Cin(TempWt[9]) , .CoutGroup(TempWt[10]), .Cout(Src2[9]) , .S(Src1[9]));
    WaccleTree Wt11 (.SrcIn(SwitchData[11]), .Cin(TempWt[10]), .CoutGroup(TempWt[11]), .Cout(Src2[10]), .S(Src1[10]));
    WaccleTree Wt12 (.SrcIn(SwitchData[12]), .Cin(TempWt[11]), .CoutGroup(TempWt[12]), .Cout(Src2[11]), .S(Src1[11]));
    WaccleTree Wt13 (.SrcIn(SwitchData[13]), .Cin(TempWt[12]), .CoutGroup(TempWt[13]), .Cout(Src2[12]), .S(Src1[12]));
    WaccleTree Wt14 (.SrcIn(SwitchData[14]), .Cin(TempWt[13]), .CoutGroup(TempWt[14]), .Cout(Src2[13]), .S(Src1[13]));
    WaccleTree Wt15 (.SrcIn(SwitchData[15]), .Cin(TempWt[14]), .CoutGroup(TempWt[15]), .Cout(Src2[14]), .S(Src1[14]));
    WaccleTree Wt16 (.SrcIn(SwitchData[16]), .Cin(TempWt[15]), .CoutGroup(TempWt[16]), .Cout(Src2[15]), .S(Src1[15]));
    WaccleTree Wt17 (.SrcIn(SwitchData[17]), .Cin(TempWt[16]), .CoutGroup(TempWt[17]), .Cout(Src2[16]), .S(Src1[16]));
    WaccleTree Wt18 (.SrcIn(SwitchData[18]), .Cin(TempWt[17]), .CoutGroup(TempWt[18]), .Cout(Src2[17]), .S(Src1[17]));
    WaccleTree Wt19 (.SrcIn(SwitchData[19]), .Cin(TempWt[18]), .CoutGroup(TempWt[19]), .Cout(Src2[18]), .S(Src1[18]));
    WaccleTree Wt20 (.SrcIn(SwitchData[20]), .Cin(TempWt[19]), .CoutGroup(TempWt[20]), .Cout(Src2[19]), .S(Src1[19]));
    WaccleTree Wt21 (.SrcIn(SwitchData[21]), .Cin(TempWt[20]), .CoutGroup(TempWt[21]), .Cout(Src2[20]), .S(Src1[20]));
    WaccleTree Wt22 (.SrcIn(SwitchData[22]), .Cin(TempWt[21]), .CoutGroup(TempWt[22]), .Cout(Src2[21]), .S(Src1[21]));
    WaccleTree Wt23 (.SrcIn(SwitchData[23]), .Cin(TempWt[22]), .CoutGroup(TempWt[23]), .Cout(Src2[22]), .S(Src1[22]));
    WaccleTree Wt24 (.SrcIn(SwitchData[24]), .Cin(TempWt[23]), .CoutGroup(TempWt[24]), .Cout(Src2[23]), .S(Src1[23]));
    WaccleTree Wt25 (.SrcIn(SwitchData[25]), .Cin(TempWt[24]), .CoutGroup(TempWt[25]), .Cout(Src2[24]), .S(Src1[24]));
    WaccleTree Wt26 (.SrcIn(SwitchData[26]), .Cin(TempWt[25]), .CoutGroup(TempWt[26]), .Cout(Src2[25]), .S(Src1[25]));
    WaccleTree Wt27 (.SrcIn(SwitchData[27]), .Cin(TempWt[26]), .CoutGroup(TempWt[27]), .Cout(Src2[26]), .S(Src1[26]));
    WaccleTree Wt28 (.SrcIn(SwitchData[28]), .Cin(TempWt[27]), .CoutGroup(TempWt[28]), .Cout(Src2[27]), .S(Src1[27]));
    WaccleTree Wt29 (.SrcIn(SwitchData[29]), .Cin(TempWt[28]), .CoutGroup(TempWt[29]), .Cout(Src2[28]), .S(Src1[28]));
    WaccleTree Wt30 (.SrcIn(SwitchData[30]), .Cin(TempWt[29]), .CoutGroup(TempWt[30]), .Cout(Src2[29]), .S(Src1[29]));
    WaccleTree Wt31 (.SrcIn(SwitchData[31]), .Cin(TempWt[30]), .CoutGroup(TempWt[31]), .Cout(Src2[30]), .S(Src1[30]));
    WaccleTree Wt32 (.SrcIn(SwitchData[32]), .Cin(TempWt[31]), .CoutGroup(TempWt[32]), .Cout(Src2[31]), .S(Src1[31]));
    WaccleTree Wt33 (.SrcIn(SwitchData[33]), .Cin(TempWt[32]), .CoutGroup(TempWt[33]), .Cout(Src2[32]), .S(Src1[32]));
    WaccleTree Wt34 (.SrcIn(SwitchData[34]), .Cin(TempWt[33]), .CoutGroup(TempWt[34]), .Cout(Src2[33]), .S(Src1[33]));
    WaccleTree Wt35 (.SrcIn(SwitchData[35]), .Cin(TempWt[34]), .CoutGroup(TempWt[35]), .Cout(Src2[34]), .S(Src1[34]));
    WaccleTree Wt36 (.SrcIn(SwitchData[36]), .Cin(TempWt[35]), .CoutGroup(TempWt[36]), .Cout(Src2[35]), .S(Src1[35]));
    WaccleTree Wt37 (.SrcIn(SwitchData[37]), .Cin(TempWt[36]), .CoutGroup(TempWt[37]), .Cout(Src2[36]), .S(Src1[36]));
    WaccleTree Wt38 (.SrcIn(SwitchData[38]), .Cin(TempWt[37]), .CoutGroup(TempWt[38]), .Cout(Src2[37]), .S(Src1[37]));
    WaccleTree Wt39 (.SrcIn(SwitchData[39]), .Cin(TempWt[38]), .CoutGroup(TempWt[39]), .Cout(Src2[38]), .S(Src1[38]));
    WaccleTree Wt40 (.SrcIn(SwitchData[40]), .Cin(TempWt[39]), .CoutGroup(TempWt[40]), .Cout(Src2[39]), .S(Src1[39]));
    WaccleTree Wt41 (.SrcIn(SwitchData[41]), .Cin(TempWt[40]), .CoutGroup(TempWt[41]), .Cout(Src2[40]), .S(Src1[40]));
    WaccleTree Wt42 (.SrcIn(SwitchData[42]), .Cin(TempWt[41]), .CoutGroup(TempWt[42]), .Cout(Src2[41]), .S(Src1[41]));
    WaccleTree Wt43 (.SrcIn(SwitchData[43]), .Cin(TempWt[42]), .CoutGroup(TempWt[43]), .Cout(Src2[42]), .S(Src1[42]));
    WaccleTree Wt44 (.SrcIn(SwitchData[44]), .Cin(TempWt[43]), .CoutGroup(TempWt[44]), .Cout(Src2[43]), .S(Src1[43]));
    WaccleTree Wt45 (.SrcIn(SwitchData[45]), .Cin(TempWt[44]), .CoutGroup(TempWt[45]), .Cout(Src2[44]), .S(Src1[44]));
    WaccleTree Wt46 (.SrcIn(SwitchData[46]), .Cin(TempWt[45]), .CoutGroup(TempWt[46]), .Cout(Src2[45]), .S(Src1[45]));
    WaccleTree Wt47 (.SrcIn(SwitchData[47]), .Cin(TempWt[46]), .CoutGroup(TempWt[47]), .Cout(Src2[46]), .S(Src1[46]));
    WaccleTree Wt48 (.SrcIn(SwitchData[48]), .Cin(TempWt[47]), .CoutGroup(TempWt[48]), .Cout(Src2[47]), .S(Src1[47]));
    WaccleTree Wt49 (.SrcIn(SwitchData[49]), .Cin(TempWt[48]), .CoutGroup(TempWt[49]), .Cout(Src2[48]), .S(Src1[48]));
    WaccleTree Wt50 (.SrcIn(SwitchData[50]), .Cin(TempWt[49]), .CoutGroup(TempWt[50]), .Cout(Src2[49]), .S(Src1[49]));
    WaccleTree Wt51 (.SrcIn(SwitchData[51]), .Cin(TempWt[50]), .CoutGroup(TempWt[51]), .Cout(Src2[50]), .S(Src1[50]));
    WaccleTree Wt52 (.SrcIn(SwitchData[52]), .Cin(TempWt[51]), .CoutGroup(TempWt[52]), .Cout(Src2[51]), .S(Src1[51]));
    WaccleTree Wt53 (.SrcIn(SwitchData[53]), .Cin(TempWt[52]), .CoutGroup(TempWt[53]), .Cout(Src2[52]), .S(Src1[52]));
    WaccleTree Wt54 (.SrcIn(SwitchData[54]), .Cin(TempWt[53]), .CoutGroup(TempWt[54]), .Cout(Src2[53]), .S(Src1[53]));
    WaccleTree Wt55 (.SrcIn(SwitchData[55]), .Cin(TempWt[54]), .CoutGroup(TempWt[55]), .Cout(Src2[54]), .S(Src1[54]));
    WaccleTree Wt56 (.SrcIn(SwitchData[56]), .Cin(TempWt[55]), .CoutGroup(TempWt[56]), .Cout(Src2[55]), .S(Src1[55]));
    WaccleTree Wt57 (.SrcIn(SwitchData[57]), .Cin(TempWt[56]), .CoutGroup(TempWt[57]), .Cout(Src2[56]), .S(Src1[56]));
    WaccleTree Wt58 (.SrcIn(SwitchData[58]), .Cin(TempWt[57]), .CoutGroup(TempWt[58]), .Cout(Src2[57]), .S(Src1[57]));
    WaccleTree Wt59 (.SrcIn(SwitchData[59]), .Cin(TempWt[58]), .CoutGroup(TempWt[59]), .Cout(Src2[58]), .S(Src1[58]));
    WaccleTree Wt60 (.SrcIn(SwitchData[60]), .Cin(TempWt[59]), .CoutGroup(TempWt[60]), .Cout(Src2[59]), .S(Src1[59]));
    WaccleTree Wt61 (.SrcIn(SwitchData[61]), .Cin(TempWt[60]), .CoutGroup(TempWt[61]), .Cout(Src2[60]), .S(Src1[60]));
    WaccleTree Wt62 (.SrcIn(SwitchData[62]), .Cin(TempWt[61]), .CoutGroup(TempWt[62]), .Cout(Src2[61]), .S(Src1[61]));
    WaccleTree Wt63 (.SrcIn(SwitchData[63]), .Cin(TempWt[62]), .CoutGroup(TempWt[63]), .Cout(Src2[62]), .S(Src1[62]));
    WaccleTree Wt64 (.SrcIn(SwitchData[64]), .Cin(TempWt[63]), .CoutGroup(TempWt[64]), .Cout(Src2[63]), .S(Src1[63]));
    WaccleTree Wt65 (.SrcIn(SwitchData[65]), .Cin(TempWt[64]), .CoutGroup(TempWt[65]), .Cout(Src2[64]), .S(Src1[64]));
    WaccleTree Wt66 (.SrcIn(SwitchData[66]), .Cin(TempWt[65]), .CoutGroup(TempWt[66]), .Cout(Src2[65]), .S(Src1[65]));
    WaccleTree Wt67 (.SrcIn(SwitchData[67]), .Cin(TempWt[66]), .CoutGroup(TempWt[67]), .Cout(Src2[66]), .S(Src1[66]));
    WaccleTree Wt68 (.SrcIn(SwitchData[68]), .Cin(TempWt[67]), .CoutGroup(TempWt[68]), .Cout(Src2[67]), .S(Src1[67]));
    

    wire [WIDTH*2+3:0]  FInSrc1 ;
    wire [WIDTH*2+3:0]  FInSrc2 ;
    wire [WIDTH*2+3:0]  MulData ;
    assign FInSrc1 = Src1               ;
    assign FInSrc2 = {Src2<<1,Upbit[1]} ;
    assign MulData = FInSrc1 + FInSrc2 + {67'b0,Upbit[0]};

    reg  [63:0]         MulOutReg       ;
    //reg                 MulWriteAble    ;
    always @(posedge Clk) begin
        if(!Rest)begin
            MulOutReg    <= 64'h0       ;
        end 
        else begin
            MulOutReg    <= MulData[63:0];
        end 
    end

    reg               IqReqReg          ;
    reg               MulLeve1          ;
    reg               MulLeve2          ;
    always @(posedge Clk) begin
        if(!Rest) begin
            IqReqReg <= `AbleValue      ;
            MulLeve2 <= `EnableValue    ;
            MulLeve3 <= `EnableValue    ;
        end 
        else begin
            if(MultipAbleValue | MulLeve2 | MulLeve3) begin
                IqReqReg <= `EnableValue;
            end
        end
    end

    assign ProductDate = (MultipMicOperate == `InstMulw)   ? MulOutReg[31:0]  :
                         (MultipMicOperate == `InstMulHw)  ? MulOutReg[63:32] :
                         (MultipMicOperate == `InstMulHuw) ? MulOutReg[63:32] : `ZeorDate;


endmodule

module WaccleTree (
    input     wire      [16:0]                      SrcIn     ,
    input     wire      [13:0]                      Cin       ,
    output    wire      [13:0]                      CoutGroup ,
    output    wire                                  Cout      ,
    output    wire                                  S         
);

    wire  [13:0] OutTemp    ;
    wire  [4 :0] Leve1Temp  ;

    Cas cas0(.A(SrcIn[2]) , .B(SrcIn[3]) , .Cin(SrcIn[4]) , .Cout(OutTemp[0]), .S(Leve1Temp[0]));
    Cas cas1(.A(SrcIn[5]) , .B(SrcIn[6]) , .Cin(SrcIn[7]) , .Cout(OutTemp[1]), .S(Leve1Temp[1]));
    Cas cas2(.A(SrcIn[8]) , .B(SrcIn[9]) , .Cin(SrcIn[10]), .Cout(OutTemp[2]), .S(Leve1Temp[2]));
    Cas cas3(.A(SrcIn[11]), .B(SrcIn[12]), .Cin(SrcIn[13]), .Cout(OutTemp[3]), .S(Leve1Temp[3]));
    Cas cas4(.A(SrcIn[14]), .B(SrcIn[15]), .Cin(SrcIn[16]), .Cout(OutTemp[4]), .S(Leve1Temp[4]));
    
    wire  [3 :0] Leve2Temp  ;
    Cas cas5(.A(Cin[0])       , .B(Cin[1])       , .Cin(Cin[2])       , .Cout(OutTemp[5]), .S(Leve2Temp[0]));
    Cas cas6(.A(SrcIn[0])     , .B(Cin[3])       , .Cin(Cin[4])       , .Cout(OutTemp[6]), .S(Leve2Temp[1]));
    Cas cas7(.A(SrcIn[1])     , .B(Leve1Temp[0]) , .Cin(Leve1Temp[1]) , .Cout(OutTemp[7]), .S(Leve2Temp[2]));
    Cas cas8(.A(Leve1Temp[2]) , .B(Leve1Temp[3]) , .Cin(Leve1Temp[4]) , .Cout(OutTemp[8]), .S(Leve2Temp[3]));

    wire  [1 :0] Leve3Temp  ;
    Cas cas9 (.A(Leve2Temp[0]) , .B(Cin[5])       , .Cin(Cin[6])       , .Cout(OutTemp[9]) , .S(Leve3Temp[0]));
    Cas cas10(.A(Leve2Temp[1]) , .B(Leve2Temp[2]) , .Cin(Leve2Temp[3]) , .Cout(OutTemp[10]), .S(Leve3Temp[1]));

    wire  [1 :0] Leve4Temp  ;
    Cas cas11(.A(Cin[7])       , .B(Cin[8])       , .Cin(Cin[9])       , .Cout(OutTemp[11]) , .S(Leve4Temp[0]));
    Cas cas12(.A(Leve3Temp[0]) , .B(Leve3Temp[1]) , .Cin(Cin[10])      , .Cout(OutTemp[12]) , .S(Leve4Temp[1]));

    wire         Leve5Temp  ;
    Cas cas13(.A(Leve4Temp[0]) , .B(Leve4Temp[1]) , .Cin(Cin[11])      , .Cout(OutTemp[13]) , .S(Leve5Temp));

    Cas cas14(.A(Leve5Temp)    , .B(Cin[12])      , .Cin(Cin[13])      , .Cout(Cout)        , .S(S));

    assign CoutGroup = OutTemp ;


endmodule


module Cas (
    input  wire    A    ,
    input  wire    B    ,
    input  wire    Cin  ,
    output wire    Cout ,
    output wire    S    
);

    assign S    = A ^ B ^ Cin              ;
    assign Cout = A & B | B & Cin | A & Cin;
    
endmodule