`timescale 1ps/1ps
`include "../define.v"
`include "../../IP/data_Base_128.xcix"
`include "../../IP/data_T1_128.xcix"
`include "../../IP/Counter_128.v"
`include "../../IP/data_T3_256.xcix"
`include "../../IP/Counter_256.v"
`include "../../IP/data_T5_128.xcix"
`include "../../IP/data_T6_128.xcix"



module Tage (
    input     wire                                     Clk              ,
    input     wire                                     Rest             ,
    //stop 
    input     wire                                     TageStop         ,
    input     wire                                     TageFlash        ,
    //from Pc
    input     wire                                     PcAble           ,
    input     wire       [`InstAddrBus]                PcDate           ,
    //from BTB
    input     wire                                     BtbAble          ,
    input     wire       [2:0]                         BtbType          ,
    input     wire                                     BtbMode          ,
    //update from predecode 
    input     wire                                     PreUpDable       ,
    input     wire       [63:0]                        PreUpDate        ,
    //from ROB
    input     wire                                     Attenuate        ,
    input     wire                                     GHRUpAble        ,
    input     wire       [64:0]                        GHRDate          ,
    //update from FTQ(整体设计坏啦)
    input     wire                                     InALwDateAble    ,
    input     wire       [`InstAddrBus]                InALwUpDatePc    ,
    input     wire       [2:0]                         InALwUpDate      ,
    input     wire       [2:0]                         InALwUpNum       ,
    input     wire       [2:0]                         InALwUpCnt       ,
    input     wire                                     InNewDateAble    ,
    input     wire       [2:0]                         InNewUpDate      ,
    input     wire       [2:0]                         InNewUpNum       ,
    input     wire       [2:0]                         InNewUpCnt       ,
    input     wire                                     InNewCnt1Able    ,
    input     wire       [2:0]                         InNewCnt1Date    ,
    input     wire                                     InNewCnt2Able    ,
    input     wire       [2:0]                         InNewCnt2Date    ,    
    input     wire                                     InNewCnt3Able    ,
    input     wire       [2:0]                         InNewCnt3Date    ,    
    input     wire                                     InNewCnt4Able    ,
    input     wire       [2:0]                         InNewCnt4Date    ,                                
    input     wire                                     InNewCnt5Able    ,
    input     wire       [2:0]                         InNewCnt5Date    ,  
    input     wire                                     InNewCnt6Able    ,
    input     wire       [2:0]                         InNewCnt6Date    ,  
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

    reg [63:0] GHRDATE ; //new ----> old
    reg        GHRsave1bit ;


    always @(posedge Clk) begin
        if(!Rest) begin
            GHRDATE     <= 64'd0 ;
            GHRsave1bit <= 1'b0  ;
        end
        else begin
            if(BtbAble) begin
                GHRDATE <= {BtbMode,GHRDATE[62:0]} ;
            end
            if(PreUpDable) begin
                GHRDATE <= PreUpDate ;
            end
            if(GHRUpAble) begin
               GHRDATE <= GHRDate[64:1] ; 
            end
        end
    end


    wire [63:0] GHR = InALwDateAble ? GHRDate[63:0] :
                      PcAble        ? (BtbAble ? {BtbMode,GHRDATE[62:0]} : GHRDATE)  :  64'd0 ;

    wire [31:0] PcAddr = InALwDateAble ? InALwUpDatePc :
                         PcAble        ? PcDate        : 32'd0 ;

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



    wire [6:0] FoldGHR7Part1  = {5'b0,GHR[63:62]}    ;
    wire [6:0] FoldT1TagGHR   = FoldGHR7Part1        ;

    wire [6:0] FoldGHR7Part2  = {3'b0,GHR[63:60]}    ;
    wire [6:0] FoldT2TagGHR   = FoldGHR7Part2        ;



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



    wire [8:0] FoldT5TagGHR = FordGHR9Parte^FoldGHR9Part3^FoldGHR9Part2^FoldGHR9Part1 ;
    wire [8:0] FoldT6TagGHR = FoldGHR9Part8^FoldGHR9Part7^FoldGHR9Part6^FoldGHR9Part5^
                              FoldGHR9Part4^FoldGHR9Part3^FoldGHR9Part2^FoldGHR9Part1 ;

    //read
    wire [6:0] BaseReadIndex = Cut7Index     ;
    wire       BaseEna       = `AbleValue    ;
    wire       BaseWen       = InALwDateAble & ~TageStop & (InALwUpNum == 0) ;
    wire [5:0] BasePart                      ;
    wire [2:0] BaseDin       = InALwUpDate   ;
    

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
    wire       T1Wen       = ((InALwDateAble & (InALwUpNum == 1)) | (InNewDateAble & (InNewUpNum == 1))) & ~TageStop ;
    wire [12:0]T1Din       = {13{(InALwDateAble & (InALwUpNum == 1)) & ~TageStop}} & {T1readTag,InALwUpDate,3'd0} | 
                             {13{(InNewDateAble & (InNewUpNum == 1)) & ~TageStop}} & {T1readTag,InNewUpDate,3'd0} ;
    wire       T1CWen      = ((InALwDateAble & (InALwUpNum == 1)) | (InNewDateAble & (InNewUpNum == 1)) | (InNewCnt1Able)) & ~TageStop ;
    wire [2:0] T1CDin      = {3{(InALwDateAble & (InALwUpNum == 1)) & ~TageStop}} & InALwUpCnt | 
                             {3{(InNewDateAble & (InNewUpNum == 1)) & ~TageStop}} & InNewUpCnt |
                             {3{InNewCnt1Able}} & InNewCnt1Date ;
    wire [12:0]T1Part                                ;
    wire [2:0] T1Count                               ;

    data_T1_128 ut1_data_T1_128(
        .clka  ( Clk          ),
        .ena   ( T1Ena        ),
        .wea   ( T1Wen        ),
        .addra ( T1ReadIndex  ),
        .dina  ( T1Din        ),
        .douta ( T1Part       )
    );

    Counter_128 ut1_Counter_128(
        .Clk   ( Clk          ),
        .Rest  ( Rest         ),
        .Atten ( Attenuate    ),
        .Addr  ( T1ReadIndex  ),
        .Dout  ( T1Count      ),
        .Wen   ( T1CWen       ),
        .Din   ( T1CDin       )
    );

    wire [6:0] T2ReadIndex = Cut7Index^FoldT2GHR ;
    wire [6:0] T2readTag   = XorPc7^FoldT2TagGHR ;
    wire       T2Ena       = `AbleValue          ;
    wire       T2Wen       = ((InALwDateAble & (InALwUpNum == 2)) | (InNewDateAble & (InNewUpNum == 2))) & ~TageStop ;
    wire [12:0]T2Din       = {13{(InALwDateAble & (InALwUpNum == 2)) & ~TageStop}} & {T2readTag,InALwUpDate,3'd0} | 
                             {13{(InNewDateAble & (InNewUpNum == 2)) & ~TageStop}} & {T2readTag,InNewUpDate,3'd0} ;
    wire       T2CWen      = ((InALwDateAble & (InALwUpNum == 2)) | (InNewDateAble & (InNewUpNum == 2)) | (InNewCnt2Able)) & ~TageStop ;
    wire [2:0] T2CDin      = {3{(InALwDateAble & (InALwUpNum == 2)) & ~TageStop}} & InALwUpCnt | 
                             {3{(InNewDateAble & (InNewUpNum == 2)) & ~TageStop}} & InNewUpCnt |
                             {3{InNewCnt2Able}} & InNewCnt2Date ;
    wire [12:0]T2Part                            ;
    wire [2:0] T2Count                           ;

    data_T1_128 ut2_data_T1_128(
        .clka  ( Clk         ),
        .ena   ( T2Ena       ),
        .wea   ( T2Wen       ),
        .addra ( T2ReadIndex ),
        .dina  ( T2Din       ),
        .douta ( T2Part      )
    );

    Counter_128 ut2_Counter_128(
        .Clk   ( Clk         ),
        .Rest  ( Rest        ),
        .Atten ( Attenuate   ),
        .Addr  ( T2ReadIndex ),
        .Dout  ( T2Count     ),
        .Wen   ( T2CWen      ),
        .Din   ( T2CDin      )
    );

    wire [7:0] T3ReadIndex = Cut8Index^FoldT3GHR ;
    wire [7:0] T3readTag   = XorPc8^FoldT3TagGHR ;
    wire       T3Ena       = `AbleValue          ;
    wire       T3Wen       = ((InALwDateAble & (InALwUpNum == 3)) | (InNewDateAble & (InNewUpNum == 3))) & ~TageStop ;
    wire [13:0]T3Din       = {14{(InALwDateAble & (InALwUpNum == 3)) & ~TageStop}} & {T3readTag,InALwUpDate,3'd0} | 
                             {14{(InNewDateAble & (InNewUpNum == 3)) & ~TageStop}} & {T3readTag,InNewUpDate,3'd0} ;
    wire       T3CWen      = ((InALwDateAble & (InALwUpNum == 3)) | (InNewDateAble & (InNewUpNum == 3)) | (InNewCnt3Able)) & ~TageStop ;
    wire [2:0] T3CDin      = {3{(InALwDateAble & (InALwUpNum == 3)) & ~TageStop}} & InALwUpCnt | 
                             {3{(InNewDateAble & (InNewUpNum == 3)) & ~TageStop}} & InNewUpCnt |
                             {3{InNewCnt3Able}} & InNewCnt3Date ;
    wire [13:0]T3Part                            ;
    wire [2:0] T3Count                           ;

    data_T3_256 ut3_data_T3_128(
        .clka  ( Clk         ),
        .ena   ( T3Ena       ),
        .wea   ( T3Wen       ),
        .addra ( T3ReadIndex ),
        .dina  ( T3Din       ),
        .douta ( T3Part      )
    );

    Counter_256 ut3_Counter_256(
        .Clk   ( Clk          ),
        .Rest  ( Rest         ),
        .Atten ( Attenuate    ),
        .Addr  ( T3ReadIndex  ),
        .Dout  ( T3Count      ),
        .Wen   ( T3CWen       ),
        .Din   ( T3CDin       )
    );

    wire [7:0] T4ReadIndex = Cut8Index^FoldT4GHR ;
    wire [7:0] T4readTag   = XorPc8^FoldT4TagGHR ;
    wire       T4Ena       = `AbleValue          ;
    wire       T4Wen       = ((InALwDateAble & (InALwUpNum == 4)) | (InNewDateAble & (InNewUpNum == 4))) & ~TageStop ;
    wire [13:0]T4Din       = {14{(InALwDateAble & (InALwUpNum == 4)) & ~TageStop}} & {T4readTag,InALwUpDate,3'd0} | 
                             {14{(InNewDateAble & (InNewUpNum == 4)) & ~TageStop}} & {T4readTag,InNewUpDate,3'd0} ;
    wire       T4CWen      = ((InALwDateAble & (InALwUpNum == 4)) | (InNewDateAble & (InNewUpNum == 4)) | (InNewCnt4Able)) & ~TageStop ;
    wire [2:0] T4CDin      = {3{(InALwDateAble & (InALwUpNum == 4)) & ~TageStop}} & InALwUpCnt | 
                             {3{(InNewDateAble & (InNewUpNum == 4)) & ~TageStop}} & InNewUpCnt |
                             {3{InNewCnt4Able}} & InNewCnt4Date ;
    wire [13:0]T4Part                            ;
    wire [2:0] T4Count                           ;

    data_T3_256 ut4_data_T3_128(
        .clka  ( Clk         ),
        .ena   ( T4Ena       ),
        .wea   ( T4Wen       ),
        .addra ( T4ReadIndex ),
        .dina  ( T4Din       ),
        .douta ( T4Part      )
    );

    Counter_256 ut4_Counter_256(
        .Clk   ( Clk          ),
        .Rest  ( Rest         ),
        .Atten ( Attenuate    ),
        .Addr  ( T4ReadIndex  ),
        .Dout  ( T4Count      ),
        .Wen   ( T4CWen       ),
        .Din   ( T4CDin       )
    );

    wire [6:0] T5ReadIndex = Cut7Index^FoldT5GHR ;
    wire [8:0] T5readTag   = XorPc9^FoldT5TagGHR ;
    wire       T5Ena       = `AbleValue          ;
    wire       T5Wen       = ((InALwDateAble & (InALwUpNum == 5)) | (InNewDateAble & (InNewUpNum == 5))) & ~TageStop ;
    wire [14:0]T5Din       = {15{(InALwDateAble & (InALwUpNum == 5)) & ~TageStop}} & {T5readTag,InALwUpDate,3'd0} | 
                             {15{(InNewDateAble & (InNewUpNum == 5)) & ~TageStop}} & {T5readTag,InNewUpDate,3'd0} ;
    wire       T5CWen      = ((InALwDateAble & (InALwUpNum == 5)) | (InNewDateAble & (InNewUpNum == 5)) | (InNewCnt5Able)) & ~TageStop ;
    wire [2:0] T5CDin      = {3{(InALwDateAble & (InALwUpNum == 5)) & ~TageStop}} & InALwUpCnt | 
                             {3{(InNewDateAble & (InNewUpNum == 5)) & ~TageStop}} & InNewUpCnt |
                             {3{InNewCnt5Able}} & InNewCnt5Date ;
    wire [14:0]T5Part                            ;
    wire [2:0] T5Count                           ;

    data_T5_128 ut5_data_T5_128(
        .clka  ( Clk         ),
        .ena   ( T5Ena       ),
        .wea   ( T5Wen       ),
        .addra ( T5ReadIndex ),
        .dina  ( T5Din       ),
        .douta ( T5Part      )
    );

    Counter_128 ut5_Counter_128(
        .Clk   ( Clk          ),
        .Rest  ( Rest         ),
        .Atten ( Attenuate    ),
        .Addr  ( T5ReadIndex  ),
        .Dout  ( T5Count      ),
        .Wen   ( T5CWen       ),
        .Din   ( T5CDin       )
    );

    wire [6:0] T6ReadIndex = Cut7Index^FoldT6GHR ;
    wire [8:0] T6readTag   = XorPc9^FoldT6TagGHR ;
    wire       T6Ena       = `AbleValue          ;
    wire       T6Wen       = ((InALwDateAble & (InALwUpNum == 6)) | (InNewDateAble & (InNewUpNum == 6))) & ~TageStop ;
    wire [14:0]T6Din       = {15{(InALwDateAble & (InALwUpNum == 6)) & ~TageStop}} & {T6readTag,InALwUpDate,3'd0} | 
                             {15{(InNewDateAble & (InNewUpNum == 6)) & ~TageStop}} & {T6readTag,InNewUpDate,3'd0} ;
    wire       T6CWen      = ((InALwDateAble & (InALwUpNum == 6)) | (InNewDateAble & (InNewUpNum == 6)) | (InNewCnt6Able)) & ~TageStop ;
    wire [2:0] T6CDin      = {3{(InALwDateAble & (InALwUpNum == 6)) & ~TageStop}} & InALwUpCnt | 
                             {3{(InNewDateAble & (InNewUpNum == 6)) & ~TageStop}} & InNewUpCnt |
                             {3{InNewCnt6Able}} & InNewCnt6Date ;
    wire [14:0]T6Part                            ;
    wire [2:0] T6Count                           ;

    data_T6_128 ut6_data_T6_128(
        .clka  ( Clk         ),
        .ena   ( T6Ena       ),
        .wea   ( T6Wen       ),
        .addra ( T6ReadIndex ),
        .dina  ( T6Din       ),
        .douta ( T6Part      )
    );

    Counter_128 ut6_Counter_128(
        .Clk   ( Clk          ),
        .Rest  ( Rest         ),
        .Atten ( Attenuate    ),
        .Addr  ( T6ReadIndex  ),
        .Dout  ( T6Count      ),
        .Wen   ( T6CWen       ),
        .Din   ( T6CDin       )
    );
    reg                   RegUpDate      ;
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
        else if(TageFlash) begin
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
        else begin
            RegUpDate   <= PcAble       ;
            RegBaseDate <= BasePart     ;
            RegT1Date   <= T1Part       ;
            RegT1Tag    <= T1readTag    ;
            RegT1Useful <= T1Count      ;
            RegT2Date   <= T2Part       ;
            RegT2Tag    <= T2readTag    ;
            RegT2Useful <= T2Count      ;
            RegT3Date   <= T3Part       ;
            RegT3Tag    <= T3readTag    ;
            RegT3Useful <= T3Count      ;
            RegT4Date   <= T4Part       ;
            RegT4Tag    <= T4readTag    ;
            RegT4Useful <= T4Count      ;
            RegT5Date   <= T5Part       ;
            RegT5Tag    <= T5readTag    ;
            RegT5Useful <= T5Count      ;
            RegT6Date   <= T6Part       ;
            RegT6Tag    <= T6readTag    ;
            RegT6Useful <= T6Count      ;
        end
    end


    wire T1HitAble = (RegT1Tag == RegT1Date[12:6]) ;
    wire T2HitAble = (RegT2Tag == RegT2Date[12:6]) ;
    wire T3HitAble = (RegT3Tag == RegT3Date[13:6]) ;
    wire T4HitAble = (RegT4Tag == RegT4Date[13:6]) ;
    wire T5HitAble = (RegT5Tag == RegT5Date[14:6]) ;
    wire T6HitAble = (RegT6Tag == RegT6Date[14:6]) ;



    reg                  RegPredictAble  ;
    reg                  RegPredictMode  ;
    reg     [2:0]        RegPredictJdate ;
    reg     [2:0]        RegPredictNum   ;
    reg     [2:0]        RegPredictUset1 ;
    reg     [2:0]        RegPredictUset2 ;
    reg     [2:0]        RegPredictUset3 ;
    reg     [2:0]        RegPredictUset4 ;
    reg     [2:0]        RegPredictUset5 ;
    reg     [2:0]        RegPredictUset6 ;

    always @(posedge Clk) begin
        if(!Rest) begin
            RegPredictAble <= `EnableValue   ;
            RegPredictMode <= `EnableValue   ;
            RegPredictJdate <= 3'b0          ;
            RegPredictNum   <= 3'b0          ;
            RegPredictUset1 <= 3'b0          ;
            RegPredictUset2 <= 3'b0          ;
            RegPredictUset3 <= 3'b0          ;
            RegPredictUset4 <= 3'b0          ;
            RegPredictUset5 <= 3'b0          ;
            RegPredictUset6 <= 3'b0          ;
        end
        else if(TageStop) begin
            RegPredictAble <= RegPredictAble   ;
            RegPredictMode <= RegPredictMode   ;
            RegPredictJdate <= RegPredictJdate ;
            RegPredictNum   <= RegPredictNum   ;
            RegPredictUset1 <= RegPredictUset1 ;
            RegPredictUset2 <= RegPredictUset2 ;
            RegPredictUset3 <= RegPredictUset3 ;
            RegPredictUset4 <= RegPredictUset4 ;
            RegPredictUset5 <= RegPredictUset5 ;
            RegPredictUset6 <= RegPredictUset6 ;
        end
        else if(TageFlash) begin
            RegPredictAble <= `EnableValue   ;
            RegPredictMode <= `EnableValue   ;
            RegPredictJdate <= 3'b0          ;
            RegPredictNum   <= 3'b0          ;
            RegPredictUset1 <= 3'b0          ;
            RegPredictUset2 <= 3'b0          ;
            RegPredictUset3 <= 3'b0          ;
            RegPredictUset4 <= 3'b0          ;
            RegPredictUset5 <= 3'b0          ;
            RegPredictUset6 <= 3'b0          ;
        end
        else begin
            RegPredictAble   =  RegUpDate   ;
            {RegPredictMode, RegPredictJdate, RegPredictNum}  = T6HitAble ? {((RegT6Date[5:3] > 3'b100) ? `AbleValue : `EnableValue), RegT6Date[5:3], 3'd6 } :
                                                                T5HitAble ? {((RegT5Date[5:3] > 3'b100) ? `AbleValue : `EnableValue), RegT5Date[5:3], 3'd5 } :
                                                                T4HitAble ? {((RegT4Date[5:3] > 3'b100) ? `AbleValue : `EnableValue), RegT4Date[5:3], 3'd4 } :
                                                                T3HitAble ? {((RegT3Date[5:3] > 3'b100) ? `AbleValue : `EnableValue), RegT3Date[5:3], 3'd3 } :
                                                                T2HitAble ? {((RegT2Date[5:3] > 3'b100) ? `AbleValue : `EnableValue), RegT2Date[5:3], 3'd2 } :
                                                                T1HitAble ? {((RegT1Date[5:3] > 3'b100) ? `AbleValue : `EnableValue), RegT1Date[5:3], 3'd1 } : 
                                                                {((RegBaseDate[5:3] > 3'b100) ? `AbleValue : `EnableValue), RegBaseDate[5:3], 3'd0} ;
            RegPredictUset1  <=  RegT1Useful ;
            RegPredictUset2  <=  RegT2Useful ;
            RegPredictUset3  <=  RegT3Useful ;
            RegPredictUset4  <=  RegT4Useful ;
            RegPredictUset5  <=  RegT5Useful ;
            RegPredictUset6  <=  RegT6Useful ;
        end
    end

    
    assign PredictAble   =  RegPredictAble   ;
    assign PredictMode   =  RegPredictMode   ;
    assign PredictJdate  =  RegPredictJdate  ;
    assign PredictNum    =  RegPredictNum    ;
    assign PredictUset1  =  RegPredictUset1 ;
    assign PredictUset2  =  RegPredictUset2 ;
    assign PredictUset3  =  RegPredictUset3 ;
    assign PredictUset4  =  RegPredictUset4 ;
    assign PredictUset5  =  RegPredictUset5 ;
    assign PredictUset6  =  RegPredictUset6 ;

    
endmodule
