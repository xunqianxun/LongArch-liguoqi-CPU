`timescale 1ps/1ps
`include "../define.v"

module Tage (
    input     wire                                     Clk              ,
    input     wire                                     Rest             ,
    //stop 
    input     wire                                     TageStop         ,
    //from Pc
    input     wire                                     PcAble           ,
    input     wire                                     PcAddr           ,
    //update from predecode 
    input     wire                                     PreUpDable       ,
    //update from ROB
    input     wire                                     UpdateAble       ,
    input     wire       [1:0]                         UpdateYorN       ,//2'b10 right 2'b01 fault 2'b00 ni operate 
    input     wire       [`InstAddrBus]                UpdateAddr       ,
    input     wire       [63:0]                        UpdateGHR        ,
    input     wire                                     UpdateMode       ,
    //to predecode 
    output    wire                                     PredictAble      ,
    output    wire                                     PredictMode      
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
    wire 

    //predict 
    //fold 7 
    wire [6:0] FoldPc7part1 = PcAddr[6:0]          ;
    wire [6:0] FoldPc7part2 = PcAddr[13:7]         ;
    wire [6:0] FoldPc7part3 = PcAddr[20:14]        ;
    wire [6:0] FoldPc7part4 = PcAddr[27:21]        ;
    wire [6:0] FoldPc7part5 = {3'b0,PcAddr[31:28]} ;

    wire [6:0] XorPc7 = FoldPc7part5^FoldPc7part4^FoldPc7part3^FoldPc7part2^FoldPc7part1 ;

    //fold 8
    wire [7:0] FoldPc8part1 = PcAddr[7:0]          ;
    wire [7:0] FoldPc8part2 = PcAddr[15:8]         ;
    wire [7:0] FoldPc8part3 = PcAddr[23:16]        ;
    wire [7:0] FoldPc8part4 = PcAddr[31:24]        ;

    wire [7:0] XorPc8 = FoldPc8part4^FoldPc8part3^FoldPc8part2^FoldPc8part1 ;

    //fold 9
    wire [8:0] FoldPc9part1 = PcAddr[8:0]          ;
    wire [8:0] FoldPc9part2 = PcAddr[17:9]         ;
    wire [8:0] FoldPc9part3 = PcAddr[26:18]        ;
    wire [8:0] FoldPc9part4 = {4'd0,PcAddr[31:27]} ;

    wire [8:0] XorPc9 = FoldPc9part4^FoldPc9part3^FoldPc9part2^FoldPc9part1 ;

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
    wire [7:0] FoldGHRT4Part2 = GHR[55:58]        ;
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
    wire [6:0] FoldGHR7Part1  = GHR[63:57]        ;
    wire [6:0] FoldGHR7Part2  = GHR[56:50]        ;
    wire [6:0] FoldGHR7Part3  = GHR[49:43]        ;
    wire [6:0] FoldGHR7Part4  = GHR[42:36]        ;
    wire [6:0] FoldGHR7Part5  = GHR[35:29]        ;
    wire [6:0] FoldGHR7Part6  = GHR[28:22]        ;
    wire [6:0] FoldGHR7Part7  = GHR[21:15]        ;
    wire [6:0] FoldGHR7Part8  = GHR[14:8]         ;
    wire [6:0] FoldGHR7Part9  = GHR[7:1]          ;
    wire [6:0] FoldGHR7Part10 = {6'd0,GHR[0]}     ;

    wire [6:0] FoldT1TagGHR = FoldGHR7Part10^FoldGHR7Part9^FoldGHR7Part8^FoldGHR7Part7^FoldGHR7Part6^
                              FoldGHR7Part5^FoldGHR7Part4^FoldGHR7Part3^FoldGHR7Part2^FoldGHR7Part1 ;
    wire [6:0] FoldT2TagGHR = FoldGHR7Part10^FoldGHR7Part9^FoldGHR7Part8^FoldGHR7Part7^FoldGHR7Part6^
                              FoldGHR7Part5^FoldGHR7Part4^FoldGHR7Part3^FoldGHR7Part2^FoldGHR7Part1 ;
    //fold t3 t4 tag
    wire [7:0] FoldGHR8Part1  = GHR[63:56]        ; 
    wire [7:0] FoldGHR8Part2  = GHR[55:48]        ; 
    wire [7:0] FoldGHR8Part3  = GHR[47:40]        ;
    wire [7:0] FoldGHR8Part4  = GHR[39:32]        ;  
    wire [7:0] FoldGHR8Part5  = GHR[31:24]        ; 
    wire [7:0] FoldGHR8Part6  = GHR[23:16]        ; 
    wire [7:0] FoldGHR8Part7  = GHR[15:8]         ; 
    wire [7:0] FoldGHR8Part8  = GHR[7:0]          ; 

    wire [7:0] FoldT3TagGHR = FoldGHR8Part8^FoldGHR8Part7^FoldGHR8Part6^FoldGHR8Part5^
                              FoldGHR8Part4^FoldGHR8Part3^FoldGHR8Part2^FoldGHR8Part1;
    wire [7:0] FoldT4TagGHR = FoldGHR8Part8^FoldGHR8Part7^FoldGHR8Part6^FoldGHR8Part5^
                              FoldGHR8Part4^FoldGHR8Part3^FoldGHR8Part2^FoldGHR8Part1;

    //fold t5 t6 tag
    wire [8:0] FoldGHR9Part1  = GHR[63:55]        ; 
    wire [8:0] FoldGHR9Part2  = GHR[54:46]        ; 
    wire [8:0] FoldGHR9Part3  = GHR[45:37]        ;
    wire [8:0] FoldGHR9Part4  = GHR[36:28]        ; 
    wire [8:0] FoldGHR9Part5  = GHR[27:19]        ; 
    wire [8:0] FoldGHR9Part6  = GHR[18:10]        ; 
    wire [8:0] FoldGHR9Part7  = GHR[9:1]          ;  
    wire [8:0] FoldGHR9Part8  = {8'b0,GHR[0]}     ;

    wire [8:0] FoldT5TagGHR = FoldGHR9Part8^FoldGHR9Part7^FoldGHR9Part6^FoldGHR9Part5^
                              FoldGHR9Part4^FoldGHR9Part3^FoldGHR9Part2^FoldGHR9Part1 ;
    wire [8:0] FoldT6TagGHR = FoldGHR9Part8^FoldGHR9Part7^FoldGHR9Part6^FoldGHR9Part5^
                              FoldGHR9Part4^FoldGHR9Part3^FoldGHR9Part2^FoldGHR9Part1 ;
    

    
endmodule