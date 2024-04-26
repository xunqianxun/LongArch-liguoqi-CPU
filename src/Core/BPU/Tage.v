`timescale 1ps/1ps
`include "../define.v"


module Tage (
    input     wire                                     Clk              ,
    input     wire                                     Rest             ,
    //stop 
    input     wire                                     TageStop         ,
    //from Pc
    input     wire                                     PcAble           ,
    input     wire       [`InstAddrBus]                PcAddr           ,
    //update from predecode 
    input     wire                                     PreUpDable       ,
    //from ROB
    input     wire                                     Attenuate        ,
    //update from FTQ(整体设计坏啦)
    input     wire                                     UpdateAble       ,
    input     wire       [2:0]                         UpSheetNum       ,
    input     wire       [1:0]                         UsefulDate       ,
    input     wire                                     UpPredAble       ,
    input     wire       [2:0]                         UpPredDate       ,
    input     wire                                     UpPredNewShet    ,
    input     wire       [2:0]                         UpNewSheetNum    ,
    input     wire       [14:0]                        UpNewSheetDate   ,   
    //to predecode 
    output    wire                                     PredictAble      ,
    output    wire                                     PredictMode      ,
    output    wire       [2:0]                         PredictJdate     ,
    output    wire       [2:0]                         PredictNum       ,
    output    wire       [2:0]                         PredictUset1     ,
    output    wire       [2:0]                         PredictUset2     ,
    output    wire       [2:0]                         PredictUset3     ,
    output    wire       [2:0]                         PredictUset4     ,
    output    wire       [2:0]                         PredictUset5     ,
    output    wire       [2:0]                         PredictUset6     
);

    //*********************************ABOUT TAGE**********************************//
    //       T NUMBER------------DEEP------------GHR WIDE---------TAG WIDE         //
    //         BASE              128             0                0                //
    //         T1                128             2                7                //
    //         T2                128             4                7                //
    //         T3                256             8                8                //
    //         T4                256             16               8                //
    //         T5                128             32               9                //
    //         T6                128             64               9                //
    //*****************************************************************************//

    reg [63:0] GHR ; //new ----> old

    

    reg        GHRsave1bit ;

    //pc cut 7
    wire [6:0] Cut7Index = PcAddr[11:5] ;
    wire [7:0] Cut8Index = PcAddr[12:5] ;

    //predict 
    //fold 7 
    wire [6:0] FoldPc7part1 = PcAddr[18:12]         ;
    wire [6:0] FoldPc7part2 = PcAddr[25:19]         ;
    wire [6:0] FoldPc7part3 = {1'b0,PcAddr[31:26] } ;

    wire [6:0] XorPc7 = FoldPc7part3^FoldPc7part2^FoldPc7part1 ;

    //fold 8
    wire [7:0] FoldPc8part1 = PcAddr[20:13]         ;
    wire [7:0] FoldPc8part2 = PcAddr[28:21]         ;
    wire [7:0] FoldPc8part3 = {5'b0,PcAddr[31:29]}  ;

    wire [7:0] XorPc8 = FoldPc8part3^FoldPc8part2^FoldPc8part1 ;

    //fold 9
    wire [8:0] FoldPc9part1 = PcAddr[20:12]         ;
    wire [8:0] FoldPc9part2 = PcAddr[29:21]         ;
    wire [8:0] FoldPc9part3 = {7'b0,PcAddr[31:30]}  ;

    wire [8:0] XorPc9 = FoldPc9part3^FoldPc9part2^FoldPc9part1 ;

    //fold GHR

    //fold t1 index
    wire [6:0] FoldGHRT1Part1 = {5'b0,GHR[63:62]} ;
    wire [6:0] FoldT1GHR = FoldGHRT1Part1         ;
    //fold t2 index
    wire [6:0] FoldGHRT2Part1 = {3'b0,GHR[63:60]} ;
    wire [6:0] FoldT2GHR = FoldGHRT1Part1         ;
    //fole t3 index
    wire [7:0] FoldGHRT3Part1 = GHR[63:56]        ;
    wire [7:0] FoldT3GHR = FoldGHRT3Part1         ;
    //fold t4 index
    wire [7:0] FoldGHRT4Part1 = GHR[63:56]        ;
    wire [7:0] FoldGHRT4Part2 = GHR[55:48]        ;
    wire [7:0] FoldT4GHR = FoldGHRT4Part2^FoldGHRT4Part1 ;
    //fold t5 index
    wire [6:0] FoldGHRT5Part1 = GHR[63:57]        ;
    wire [6:0] FoldGHRT5Part2 = GHR[56:50]        ;
    wire [6:0] FoldGHRT5Part3 = GHR[49:43]        ;
    wire [6:0] FoldGHRT5Part4 = GHR[42:36]        ;
    wire [6:0] FoldGHRT5Part5 = GHR[35:29]        ;
    wire [6:0] FoldT5GHR = FoldGHRT5Part5^FoldGHRT5Part4^FoldGHRT5Part3^FoldGHRT5Part2^FoldGHRT5Part1 ;
    //fold t6 index
    wire [6:0] FoldGHRT6Part1 = GHR[63:57]        ;
    wire [6:0] FoldGHRT6Part2 = GHR[56:50]        ;
    wire [6:0] FoldGHRT6Part3 = GHR[49:43]        ;
    wire [6:0] FoldGHRT6Part4 = GHR[42:36]        ;
    wire [6:0] FoldGHRT6Part5 = GHR[35:29]        ;
    wire [6:0] FoldGHRT6Part6 = GHR[28:22]        ;
    wire [6:0] FoldGHRT6Part7 = GHR[21:15]        ;
    wire [6:0] FoldGHRT6Part8 = GHR[14:8]         ;
    wire [6:0] FoldGHRT6Part9 = GHR[7:1]          ;
    wire [6:0] FoldGHRT6Part10= {6'd0,GHR[0]}     ;
    wire [6:0] FoldT6GHR = FoldGHRT6Part10^FoldGHRT6Part9^FoldGHRT6Part8^FoldGHRT6Part7^FoldGHRT6Part6^
                           FoldGHRT6Part5^FoldGHRT6Part4^FoldGHRT6Part3^FoldGHRT6Part2^FoldGHRT6Part1 ;


    //fold t1 t2 tag
    // wire [6:0] FoldGHR7Part1  = GHR[63:57]        ;
    // wire [6:0] FoldGHR7Part2  = GHR[56:50]        ;
    // wire [6:0] FoldGHR7Part3  = GHR[49:43]        ;
    // wire [6:0] FoldGHR7Part4  = GHR[42:36]        ;
    // wire [6:0] FoldGHR7Part5  = GHR[35:29]        ;
    // wire [6:0] FoldGHR7Part6  = GHR[28:22]        ;
    // wire [6:0] FoldGHR7Part7  = GHR[21:15]        ;
    // wire [6:0] FoldGHR7Part8  = GHR[14:8]         ;
    // wire [6:0] FoldGHR7Part9  = GHR[7:1]          ;
    // wire [6:0] FoldGHR7Part10 = {6'd0,GHR[0]}     ;

    // wire [6:0] FoldT1TagGHR = FoldGHR7Part10^FoldGHR7Part9^FoldGHR7Part8^FoldGHR7Part7^FoldGHR7Part6^
    //                           FoldGHR7Part5^FoldGHR7Part4^FoldGHR7Part3^FoldGHR7Part2^FoldGHR7Part1 ;
    // wire [6:0] FoldT2TagGHR = FoldGHR7Part10^FoldGHR7Part9^FoldGHR7Part8^FoldGHR7Part7^FoldGHR7Part6^
    //                           FoldGHR7Part5^FoldGHR7Part4^FoldGHR7Part3^FoldGHR7Part2^FoldGHR7Part1 ;

    wire [6:0] FoldGHR7Part1  = {5'b0,GHR[63:62]}    ;
    wire [6:0] FoldT1TagGHR   = FoldGHR7Part1        ;

    wire [6:0] FoldGHR7Part2  = {3'b0,GHR[63:60]}    ;
    wire [6:0] FoldT2TagGHR   = FoldGHR7Part2        ;

    //fold t3 t4 tag
    // wire [7:0] FoldGHR8Part1  = GHR[63:56]        ; 
    // wire [7:0] FoldGHR8Part2  = GHR[55:48]        ; 
    // wire [7:0] FoldGHR8Part3  = GHR[47:40]        ;
    // wire [7:0] FoldGHR8Part4  = GHR[39:32]        ;  
    // wire [7:0] FoldGHR8Part5  = GHR[31:24]        ; 
    // wire [7:0] FoldGHR8Part6  = GHR[23:16]        ; 
    // wire [7:0] FoldGHR8Part7  = GHR[15:8]         ; 
    // wire [7:0] FoldGHR8Part8  = GHR[7:0]          ; 

    // wire [7:0] FoldT3TagGHR = FoldGHR8Part8^FoldGHR8Part7^FoldGHR8Part6^FoldGHR8Part5^
    //                           FoldGHR8Part4^FoldGHR8Part3^FoldGHR8Part2^FoldGHR8Part1;
    // wire [7:0] FoldT4TagGHR = FoldGHR8Part8^FoldGHR8Part7^FoldGHR8Part6^FoldGHR8Part5^
    //                           FoldGHR8Part4^FoldGHR8Part3^FoldGHR8Part2^FoldGHR8Part1;

    wire [7:0] FoldGHR8Part1  = GHR[63:56]        ; 
    wire [7:0] FoldGHR8Part2  = GHR[55:48]        ; 

    wire [7:0] FoldT3TagGHR   = FoldGHR8Part1     ;
    wire [7:0] FoldT4TagGHR   = FoldGHR8Part2^FoldGHR8Part1;


    //fold t5 t6 tag
    wire [8:0] FoldGHR9Part1  = GHR[63:55]        ; 
    wire [8:0] FoldGHR9Part2  = GHR[54:46]        ; 
    wire [8:0] FoldGHR9Part3  = GHR[45:37]        ;
    wire [8:0] FordGHR9Parte  = {GHR[36:32],4'b0 };
    wire [8:0] FoldGHR9Part4  = GHR[36:28]        ; 
    wire [8:0] FoldGHR9Part5  = GHR[27:19]        ; 
    wire [8:0] FoldGHR9Part6  = GHR[18:10]        ; 
    wire [8:0] FoldGHR9Part7  = GHR[9:1]          ;  
    wire [8:0] FoldGHR9Part8  = {8'b0,GHR[0]}     ;

    // wire [8:0] FoldT5TagGHR = FoldGHR9Part8^FoldGHR9Part7^FoldGHR9Part6^FoldGHR9Part5^
    //                           FoldGHR9Part4^FoldGHR9Part3^FoldGHR9Part2^FoldGHR9Part1 ;
    // wire [8:0] FoldT6TagGHR = FoldGHR9Part8^FoldGHR9Part7^FoldGHR9Part6^FoldGHR9Part5^
    //                           FoldGHR9Part4^FoldGHR9Part3^FoldGHR9Part2^FoldGHR9Part1 ;

    wire [8:0] FoldT5TagGHR = FordGHR9Parte^FoldGHR9Part3^FoldGHR9Part2^FoldGHR9Part1 ;
    wire [8:0] FoldT6TagGHR = FoldGHR9Part8^FoldGHR9Part7^FoldGHR9Part6^FoldGHR9Part5^
                              FoldGHR9Part4^FoldGHR9Part3^FoldGHR9Part2^FoldGHR9Part1 ;

    //read
    wire [6:0] BaseReadIndex = Cut7Index     ;
    wire       BaseEna       = `AbleValue    ;
    wire       BaseWen       = UpdateAble    ;
    wire [5:0] BasePart                      ;
    

    data_Base_128 u_data_Base_128(
        .clka  ( Clk           ),
        .ena   ( BaseEna       ),
        .wea   ( BaseWen       ),
        .addra ( BaseReadIndex ),
        .dina  ( dina  ),
        .douta ( BasePart      )
    );

    wire [6:0] T1ReadIndex = Cut7Index^FoldT1GHR     ;
    wire [6:0] T1readTag   = XorPc7^FoldT1TagGHR     ;
    wire       T1Ena       = `AbleValue              ;
    wire       T1Wen       = UpdateAble              ;
    wire [12:0]T1Part                                ;
    wire [2:0] T1Count                               ;

    data_T1_128 ut1_data_T1_128(
        .clka  ( Clk          ),
        .ena   ( T1Ena        ),
        .wea   ( T1Wen        ),
        .addra ( T1ReadIndex  ),
        .dina  ( dina  ),
        .douta ( T1Part       )
    );

    Counter_128 ut1_Counter_128(
        .Clk   ( Clk          ),
        .Rest  ( Rest         ),
        .Addr  ( T1ReadIndex  ),
        .Dout  ( T1Count      ),
        .Wen   ( T1Wen        ),
        .Din   ( Din   )
    );

    wire [6:0] T2ReadIndex = Cut7Index^FoldT2GHR ;
    wire [6:0] T2readTag   = XorPc7^FoldT2TagGHR ;
    wire       T2Ena       = `AbleValue          ;
    wire       T2Wen       = UpdateAble          ;
    wire [12:0]T2Part                            ;
    wire [2:0] T2Count                           ;

    data_T1_128 ut2_data_T1_128(
        .clka  ( Clk         ),
        .ena   ( T2Ena       ),
        .wea   ( T2Wen       ),
        .addra ( T2ReadIndex ),
        .dina  ( dina  ),
        .douta ( T2Part      )
    );

    Counter_128 ut2_Counter_128(
        .Clk   ( Clk         ),
        .Rest  ( Rest        ),
        .Addr  ( T2ReadIndex ),
        .Dout  ( T2Count     ),
        .Wen   ( T2Wen       ),
        .Din   ( Din   )
    );

    wire [7:0] T3ReadIndex = Cut8Index^FoldT3GHR ;
    wire [7:0] T3readTag   = XorPc8^FoldT3TagGHR ;
    wire       T3Ena       = `AbleValue          ;
    wire       T3Wen       = UpdateAble          ;
    wire [13:0]T3Part                            ;
    wire [2:0] T3Count                           ;

    data_T3_256 ut3_data_T3_128(
        .clka  ( Clk         ),
        .ena   ( T3Ena       ),
        .wea   ( T3Wen       ),
        .addra ( T3ReadIndex ),
        .dina  ( dina  ),
        .douta ( T3Part      )
    );

    Counter_256 ut3_Counter_256(
        .Clk   ( Clk          ),
        .Rest  ( Rest         ),
        .Addr  ( T3ReadIndex  ),
        .Dout  ( T3Count      ),
        .Wen   ( T3Wen        ),
        .Din   ( Din   )
    );

    wire [7:0] T4ReadIndex = Cut8Index^FoldT4GHR ;
    wire [7:0] T4readTag   = XorPc8^FoldT4TagGHR ;
    wire       T4Ena       = `AbleValue          ;
    wire       T4Wen       = UpdateAble          ;
    wire [13:0]T4Part                            ;
    wire [2:0] T4Count                           ;

    data_T3_256 ut4_data_T3_128(
        .clka  ( Clk         ),
        .ena   ( T4Ena       ),
        .wea   ( T4Wen       ),
        .addra ( T4ReadIndex ),
        .dina  ( dina  ),
        .douta ( T4Part      )
    );

    Counter_256 ut4_Counter_256(
        .Clk   ( Clk          ),
        .Rest  ( Rest         ),
        .Addr  ( T4ReadIndex  ),
        .Dout  ( T4Count      ),
        .Wen   ( T4Wen        ),
        .Din   ( Din   )
    );

    wire [6:0] T5ReadIndex = Cut7Index^FoldT5GHR ;
    wire [8:0] T5readTag   = XorPc9^FoldT5TagGHR ;
    wire       T5Ena       = `AbleValue          ;
    wire       T5Wen       = UpdateAble          ;
    wire [14:0]T5Part                            ;
    wire [2:0] T5Count                           ;

    data_T5_128 ut5_data_T5_128(
        .clka  ( Clk         ),
        .ena   ( T5Ena       ),
        .wea   ( T5Wen       ),
        .addra ( T5ReadIndex ),
        .dina  ( dina  ),
        .douta ( T5Part      )
    );

    Counter_128 ut5_Counter_128(
        .Clk   ( Clk          ),
        .Rest  ( Rest         ),
        .Addr  ( T5ReadIndex  ),
        .Dout  ( T5Count      ),
        .Wen   ( T5Wen        ),
        .Din   ( Din   )
    );

    wire [6:0] T6ReadIndex = Cut7Index^FoldT6GHR ;
    wire [8:0] T6readTag   = XorPc9^FoldT6TagGHR ;
    wire       T6Ena       = `AbleValue          ;
    wire       T6Wen       = UpdateAble          ;
    wire [14:0]T6Part                            ;
    wire [2:0] T6Count                           ;

    data_T6_128 ut6_data_T6_128(
        .clka  ( Clk         ),
        .ena   ( T6Ena       ),
        .wea   ( T6Wen       ),
        .addra ( T6ReadIndex ),
        .dina  ( dina  ),
        .douta ( T6Part      )
    );

    Counter_128 ut6_Counter_128(
        .Clk   ( Clk          ),
        .Rest  ( Rest         ),
        .Addr  ( T6ReadIndex  ),
        .Dout  ( T6Count      ),
        .Wen   ( T6Wen        ),
        .Din   ( Din   )
    );

    reg                   RegUpDate      ;
    reg                   RegPcAble      ;
    reg [5:0]             RegBaseDate    ;
    reg [12:0]            RegT1Date      ;
    reg [6:0]             RegT1Tag       ;
    reg [2:0]             RegT1Useful    ;
    reg [12:0]            RegT2Date      ;
    reg [6:0]             RegT2Tag       ;
    reg [2:0]             RegT2Useful    ;
    reg [13:0]            RegT3Date      ;
    reg [7:0]             RegT3Tag       ;
    reg [2:0]             RegT3Useful    ;
    reg [13:0]            RegT4Date      ;
    reg [7:0]             RegT4Tag       ;
    reg [2:0]             RegT4Useful    ;
    reg [14:0]            RegT5Date      ;
    reg [8:0]             RegT5Tag       ;
    reg [2:0]             RegT5Useful    ;
    reg [14:0]            RegT6Date      ;
    reg [8:0]             RegT6Tag       ;
    reg [2:0]             RegT6Useful    ;

    always @(posedge Clk) begin
        if(!Rest) begin
            RegPcAble   <= `EnableValue ;
            RegUpDate   <= `EnableValue ;
            RegBaseDate <= 6'd0         ;
            RegT1Date   <= 13'd0        ;
            RegT1Tag    <= 7'd0         ;
            RegT1Useful <= 3'd0         ;
            RegT2Date   <= 13'd0        ;
            RegT2Tag    <= 7'd0         ;
            RegT2Useful <= 3'd0         ;
            RegT3Date   <= 14'd0        ;
            RegT3Tag    <= 8'd0         ;
            RegT3Useful <= 3'd0         ;
            RegT4Date   <= 14'd0        ;
            RegT4Tag    <= 8'd0         ;
            RegT4Useful <= 3'd0         ;
            RegT5Date   <= 15'd0        ;
            RegT5Tag    <= 9'd0         ;
            RegT5Useful <= 3'd0         ;
            RegT6Date   <= 15'd0        ;
            RegT6Tag    <= 9'd0         ;
            RegT6Useful <= 3'd0         ;
        end
        else if(TageStop) begin
            RegPcAble   <= RegPcAble    ;
            RegUpDate   <= RegUpDate    ;
            RegBaseDate <= RegBaseDate  ;
            RegT1Date   <= RegT1Date    ;
            RegT1Tag    <= RegT1Tag     ;
            RegT1Useful <= RegT1Useful  ;
            RegT2Date   <= RegT2Date    ;
            RegT2Tag    <= RegT2Tag     ;
            RegT2Useful <= RegT2Useful  ;
            RegT3Date   <= RegT3Date    ;
            RegT3Tag    <= RegT3Tag     ;
            RegT3Useful <= RegT3Useful  ;
            RegT4Date   <= RegT4Date    ;
            RegT4Tag    <= RegT4Tag     ;
            RegT4Useful <= RegT4Useful  ;
            RegT5Date   <= RegT5Date    ;
            RegT5Tag    <= RegT5Tag     ;
            RegT5Useful <= RegT5Useful  ;
            RegT6Date   <= RegT6Date    ;
            RegT6Tag    <= RegT6Tag     ;
            RegT6Useful <= RegT6Useful  ;
        end
        else begin
            RegPcAble   <= PcAble       ;
            RegUpDate   <= UpdateAble   ;
            RegBaseDate <= BasePart     ;
            RegT1Date   <= T1Date       ;
            RegT1Tag    <= T1Tag        ;
            RegT1Useful <= T1Useful     ;
            RegT2Date   <= T2Date       ;
            RegT2Tag    <= T2Tag        ;
            RegT2Useful <= T2Useful     ;
            RegT3Date   <= T3Date       ;
            RegT3Tag    <= T3Tag        ;
            RegT3Useful <= T3Useful     ;
            RegT4Date   <= T4Date       ;
            RegT4Tag    <= T4Tag        ;
            RegT4Useful <= T4Useful     ;
            RegT5Date   <= T5Date       ;
            RegT5Tag    <= T5Tag        ;
            RegT5Useful <= T5Useful     ;
            RegT6Date   <= T6Date       ;
            RegT6Tag    <= T6Tag        ;
            RegT6Useful <= T6Useful     ;
        end
    end


    assign [2:0] FInalChiose  = (RegT6Tag == RegT6Date[12:6]) ?  RegT6Date[5:3] : 
                                (RegT5Tag == RegT5Date[12:6]) ?  RegT5Date[5:3] : 
                                (RegT4Tag == RegT4Date[12:6]) ?  RegT4Date[5:3] : 
                                (RegT3Tag == RegT3Date[12:6]) ?  RegT3Date[5:3] : 
                                (RegT2Tag == RegT2Date[12:6]) ?  RegT2Date[5:3] : 
                                (RegT1Tag == RegT1Date[12:6]) ?  RegT1Date[5:3] : RegBaseDate[5:3] ;

    assign      FInalAble     = RegPcAble ;

    assign      PredictAble = FInalAble ;
    assign      PredictMode = (FInalChiose > 4) ? `AbleValue : `EnableValue ;

    //for update 




    
endmodule
