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
    genvar BoothCodeLoop;
    generate
        for (BoothCodeLoop = 1; BoothCodeLoop < WIDTH+2 ; BoothCodeLoop = BoothCodeLoop+2) begin:BoothLoop
            assign Booth[(BoothCodeLoop+1)%2] = (FormalMultiplier[BoothCodeLoop+1:BoothCodeLoop-1] == 3'b000)? `ZeroBoothDate                             :
                                                (FormalMultiplier[BoothCodeLoop+1:BoothCodeLoop-1] == 3'b001)? FormalMultiplicand << BoothCodeLoop-1      :
                                                (FormalMultiplier[BoothCodeLoop+1:BoothCodeLoop-1] == 3'b010)? FormalMultiplicand << BoothCodeLoop-1      :
                                                (FormalMultiplier[BoothCodeLoop+1:BoothCodeLoop-1] == 3'b011)? FormalMultiplicand << BoothCodeLoop        :
                                                (FormalMultiplier[BoothCodeLoop+1:BoothCodeLoop-1] == 3'b100)? (~FormalMultiplicand+1) << BoothCodeLoop   :
                                                (FormalMultiplier[BoothCodeLoop+1:BoothCodeLoop-1] == 3'b101)? (~FormalMultiplicand+1) << BoothCodeLoop-1 :
                                                (FormalMultiplier[BoothCodeLoop+1:BoothCodeLoop-1] == 3'b110)? (~FormalMultiplicand+1) << BoothCodeLoop-1 :`ZeroBoothDate;
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
                                           Booth[9][SwitchLoop],Booth[8][SwitchLoop],Booth[7][SwitchLoop],Booth[6][SwitchLoop],
                                           Booth[5][SwitchLoop],Booth[4][SwitchLoop],Booth[3][SwitchLoop],Booth[2][SwitchLoop],Booth[1][SwitchLoop]} ;
            end            
        end
    end



endmodule
