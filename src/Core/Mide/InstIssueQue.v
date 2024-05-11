`timescale 1ps/1ps
`include "../define.v"
`include "../../Lib/FIFO.v"

module InstIssueQue # (
    parameter  INSTQUEUEDEEP = 32 ,
    parameter  INSTQUEUEWIDE = 97 
) (
    input      wire                                       Clk          ,
    input      wire                                       Rest         ,
    //for ctrl
    input      wire                                       InstQStop    ,
    input      wire                                       InstQFlash   ,
    output     wire                                       InstQReqStop ,
    //input from PreDecode
    input      wire                                       FromPre1Able ,
    input      wire      [`InstAddrBus]                   FromPre1Addr ,
    input      wire      [`InstDateBus]                   FromPre1Date ,
    input      wire                                       FromPre1Part ,
    input      wire      [`InstAddrBus]                   FromPre1NAdr ,
    input      wire                                       FromPre2Able ,
    input      wire      [`InstAddrBus]                   FromPre2Addr ,
    input      wire      [`InstDateBus]                   FromPre2Date ,
    input      wire                                       FromPre2Part ,
    input      wire      [`InstAddrBus]                   FromPre2NAdr ,
    input      wire                                       FromPre3Able ,
    input      wire      [`InstAddrBus]                   FromPre3Addr ,
    input      wire      [`InstDateBus]                   FromPre3Date ,
    input      wire                                       FromPre3Part ,
    input      wire      [`InstAddrBus]                   FromPre3NAdr ,
    input      wire                                       FromPre4Able ,
    input      wire      [`InstAddrBus]                   FromPre4Addr ,
    input      wire      [`InstDateBus]                   FromPre4Date , 
    input      wire                                       FromPre4Part ,
    input      wire      [`InstAddrBus]                   FromPre4NAdr ,
    input      wire                                       FromPre5Able ,
    input      wire      [`InstAddrBus]                   FromPre5Addr ,
    input      wire      [`InstDateBus]                   FromPre5Date ,
    input      wire                                       FromPre5Part ,
    input      wire      [`InstAddrBus]                   FromPre5NAdr ,
    input      wire                                       FromPre6Able ,
    input      wire      [`InstAddrBus]                   FromPre6Addr ,
    input      wire      [`InstDateBus]                   FromPre6Date ,
    input      wire                                       FromPre6Part ,
    input      wire      [`InstAddrBus]                   FromPre6NAdr ,
    input      wire                                       FromPre7Able ,
    input      wire      [`InstAddrBus]                   FromPre7Addr ,
    input      wire      [`InstDateBus]                   FromPre7Date ,
    input      wire                                       FromPre7Part ,
    input      wire      [`InstAddrBus]                   FromPre7NAdr ,
    input      wire                                       FromPre8Able ,
    input      wire      [`InstAddrBus]                   FromPre8Addr ,
    input      wire      [`InstDateBus]                   FromPre8Date , 
    input      wire                                       FromPre8Part ,
    input      wire      [`InstAddrBus]                   FromPre8NAdr ,      
    //to decode 
    output     wire                                       OutInstPort1 ,
    output     wire                                       OutInstPort2 ,
    output     wire                                       OutInstPort3 ,
    output     wire                                       OutInstPort4 ,
    output     wire      [`InstAddrBus]                   OutInstAddr1 ,
    output     wire      [`InstDateBus]                   OutInstDate1 ,
    output     wire                                       OutInstPart1 ,
    output     wire      [`InstAddrBus]                   OutInstNAdr1 ,
    output     wire      [`InstAddrBus]                   OutInstAddr2 ,
    output     wire      [`InstDateBus]                   OutInstDate2 ,
    output     wire                                       OutInstPart2 ,
    output     wire      [`InstAddrBus]                   OutInstNAdr2 ,
    output     wire      [`InstAddrBus]                   OutInstAddr3 ,
    output     wire      [`InstDateBus]                   OutInstDate3 ,
    output     wire                                       OutInstPart3 ,
    output     wire      [`InstAddrBus]                   OutInstNAdr3 ,
    output     wire      [`InstAddrBus]                   OutInstAddr4 ,
    output     wire      [`InstDateBus]                   OutInstDate4 ,
    output     wire                                       OutInstPart4 ,
    output     wire      [`InstAddrBus]                   OutInstNAdr4 
);

    reg              StopTemp   ;
    reg              FLashTemp  ;

    always @(posedge Clk) begin
        if(!Rest) begin
            StopTemp  <= 1'b0 ;
            FLashTemp <= 1'b0 ;
        end
        else begin
            StopTemp  <= InstQStop  ;
            FLashTemp <= InstQFlash ;
        end
    end


    reg  [3:0]  WritePtr ;
    reg  [3:0]  ReadPtr  ;

    wire U1Clean = FLashTemp ;
    wire U1Full  ;
    wire U1Empty ;
    wire U2Clean = FLashTemp ;
    wire U2Full  ;
    wire U2Empty ;
    wire U3Clean = FLashTemp ;
    wire U3Full  ;
    wire U3Empty ;
    wire U4Clean = FLashTemp ;
    wire U4Full  ;
    wire U4Empty ;
    wire U5Clean = FLashTemp ;
    wire U5Full  ;
    wire U5Empty ;
    wire U6Clean = FLashTemp ;
    wire U6Full  ;
    wire U6Empty ;
    wire U7Clean = FLashTemp ;
    wire U7Full  ;
    wire U7Empty ;
    wire U8Clean = FLashTemp ;
    wire U8Full  ;
    wire U8Empty ;


    wire  [3:0] InInstNum = {4{( FromPre1Able &  FromPre2Able &  FromPre3Able &  FromPre4Able &  FromPre5Able &  FromPre6Able &  FromPre7Able &  FromPre8Able)}} & 4'd8 |
                            {4{( FromPre1Able &  FromPre2Able &  FromPre3Able &  FromPre4Able &  FromPre5Able &  FromPre6Able &  FromPre7Able & ~FromPre8Able)}} & 4'd7 |
                            {4{( FromPre1Able &  FromPre2Able &  FromPre3Able &  FromPre4Able &  FromPre5Able &  FromPre6Able & ~FromPre7Able & ~FromPre8Able)}} & 4'd6 |
                            {4{( FromPre1Able &  FromPre2Able &  FromPre3Able &  FromPre4Able &  FromPre5Able & ~FromPre6Able & ~FromPre7Able & ~FromPre8Able)}} & 4'd5 |
                            {4{( FromPre1Able &  FromPre2Able &  FromPre3Able &  FromPre4Able & ~FromPre5Able & ~FromPre6Able & ~FromPre7Able & ~FromPre8Able)}} & 4'd4 |
                            {4{( FromPre1Able &  FromPre2Able &  FromPre3Able & ~FromPre4Able & ~FromPre5Able & ~FromPre6Able & ~FromPre7Able & ~FromPre8Able)}} & 4'd3 |
                            {4{( FromPre1Able &  FromPre2Able & ~FromPre3Able & ~FromPre4Able & ~FromPre5Able & ~FromPre6Able & ~FromPre7Able & ~FromPre8Able)}} & 4'd2 |
                            {4{( FromPre1Able & ~FromPre2Able & ~FromPre3Able & ~FromPre4Able & ~FromPre5Able & ~FromPre6Able & ~FromPre7Able & ~FromPre8Able)}} & 4'd1 |
                            {4{(~FromPre1Able & ~FromPre2Able & ~FromPre3Able & ~FromPre4Able & ~FromPre5Able & ~FromPre6Able & ~FromPre7Able & ~FromPre8Able)}} & 4'd0 ;

    always @(posedge Clk) begin
        if(!Rest) begin
            WritePtr <= 4'd0 ;
        end
        else begin
            WritePtr <= WritePtr[2:0] + InInstNum ;
        end
    end

    wire [2:0] ReqInstNum = {3{(~U1Empty & ~U2Empty & ~U3Empty & ~U4Empty)}} & 3'd4 | 
                            {3{(~U1Empty & ~U2Empty & ~U3Empty &  U4Empty)}} & 3'd3 | 
                            {3{(~U1Empty & ~U2Empty &  U3Empty &  U4Empty)}} & 3'd2 | 
                            {3{(~U1Empty &  U2Empty &  U3Empty &  U4Empty)}} & 3'd1 ;

    always @(posedge Clk) begin
        if(!Rest) begin
            ReadPtr <= 4'd0 ;
        end
        else begin
            ReadPtr <= ~StopTemp ?  ReadPtr[2:0] + ReqInstNum : ReadPtr;
        end
    end
    // late one clk sent infromation
    reg [2:0] TempReadPtr ;
    reg [2:0] TempNumber  ;
    always @(posedge Clk) begin
        if(!Rest) begin
            TempReadPtr <= 3'd0 ;
            TempNumber  <= 3'd0 ;
        end
        else begin
            TempReadPtr <= ReadPtr[2:0] ;
            TempNumber  <= ReqInstNum   ;
        end
    end

    wire  Read1Able   = (ReadPtr[2:0] == 0) & (ReqInstNum != 0) |
                        (ReadPtr[2:0] == 5) & (ReqInstNum == 4) |
                        (ReadPtr[2:0] == 6) & ((ReqInstNum == 3) | (ReqInstNum == 4)) |
                        (ReadPtr[2:0] == 7) & ((ReqInstNum != 0) & (ReqInstNum != 1)) ;

    wire  Read2Able   = (ReadPtr[2:0] == 0) & ((ReqInstNum != 0) & (ReqInstNum != 1)) |
                        (ReadPtr[2:0] == 1) & (ReqInstNum != 0) |
                        (ReadPtr[2:0] == 6) & (ReqInstNum == 4) |
                        (ReadPtr[2:0] == 7) & ((ReqInstNum == 3) | (ReqInstNum == 4)) ;

    wire  Read3Able   = (ReadPtr[2:0] == 0) & ((ReqInstNum == 2) | (ReqInstNum == 3)) |
                        (ReadPtr[2:0] == 1) & ((ReqInstNum != 0) & (ReqInstNum != 1)) |
                        (ReadPtr[2:0] == 2) & (ReqInstNum != 0) |
                        (ReadPtr[2:0] == 7) & (ReqInstNum == 4) ;

    wire  Read4Able   = (ReadPtr[2:0] == 0) & (ReqInstNum == 4) |
                        (ReadPtr[2:0] == 1) & ((ReqInstNum == 2) | (ReqInstNum == 3)) |
                        (ReadPtr[2:0] == 2) & ((ReqInstNum != 0) & (ReqInstNum != 1)) |
                        (ReadPtr[2:0] == 3) & (ReqInstNum != 0) ;

    wire  Read5Able   = (ReadPtr[2:0] == 1) & (ReqInstNum == 4) |
                        (ReadPtr[2:0] == 2) & ((ReqInstNum == 2) | (ReqInstNum == 3)) |
                        (ReadPtr[2:0] == 3) & ((ReqInstNum != 0) & (ReqInstNum != 1)) |
                        (ReadPtr[2:0] == 4) & (ReqInstNum != 0);

    wire  Read6Able   = (ReadPtr[2:0] == 2) & (ReqInstNum == 4) |
                        (ReadPtr[2:0] == 3) & ((ReqInstNum == 2) | (ReqInstNum == 3)) |
                        (ReadPtr[2:0] == 4) & ((ReqInstNum != 0) & (ReqInstNum != 1)) |
                        (ReadPtr[2:0] == 5) & (ReqInstNum != 0);
        
    wire  Read7Able   = (ReadPtr[2:0] == 3) & (ReqInstNum == 4) |
                        (ReadPtr[2:0] == 4) & ((ReqInstNum == 2) | (ReqInstNum == 3)) |
                        (ReadPtr[2:0] == 5) & ((ReqInstNum != 0) & (ReqInstNum != 1)) |
                        (ReadPtr[2:0] == 6) & (ReqInstNum != 0);

    wire  Read8Able   = (ReadPtr[2:0] == 4) & (ReqInstNum == 4) |
                        (ReadPtr[2:0] == 5) & ((ReqInstNum == 2) | (ReqInstNum == 3)) |
                        (ReadPtr[2:0] == 6) & ((ReqInstNum != 0) & (ReqInstNum != 1)) |
                        (ReadPtr[2:0] == 7) & (ReqInstNum != 0);

   

    wire [INSTQUEUEWIDE-1:0] Read1Date ; 
    wire [INSTQUEUEWIDE-1:0] Read2Date ; 
    wire [INSTQUEUEWIDE-1:0] Read3Date ; 
    wire [INSTQUEUEWIDE-1:0] Read4Date ;
    wire [INSTQUEUEWIDE-1:0] Read5Date ; 
    wire [INSTQUEUEWIDE-1:0] Read6Date ; 
    wire [INSTQUEUEWIDE-1:0] Read7Date ; 
    wire [INSTQUEUEWIDE-1:0] Read8Date ;

    assign  { OutInstAddr1, OutInstDate1, OutInstPart1, OutInstNAdr1} = {INSTQUEUEWIDE{(TempReadPtr == 0)}} & Read1Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 1)}} & Read2Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 2)}} & Read3Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 3)}} & Read4Date |
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 4)}} & Read5Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 5)}} & Read6Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 6)}} & Read7Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 7)}} & Read8Date ;

    assign  { OutInstAddr2, OutInstDate2, OutInstPart2, OutInstNAdr2} = {INSTQUEUEWIDE{(TempReadPtr == 0)}} & Read2Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 1)}} & Read3Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 2)}} & Read4Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 3)}} & Read5Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 4)}} & Read6Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 5)}} & Read7Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 6)}} & Read8Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 7)}} & Read1Date ;

    assign  { OutInstAddr3, OutInstDate3, OutInstPart3, OutInstNAdr3} = {INSTQUEUEWIDE{(TempReadPtr == 0)}} & Read3Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 1)}} & Read4Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 2)}} & Read5Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 3)}} & Read6Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 4)}} & Read7Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 5)}} & Read8Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 6)}} & Read1Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 7)}} & Read2Date ; 

    assign  { OutInstAddr4, OutInstDate4, OutInstPart4, OutInstNAdr4} = {INSTQUEUEWIDE{(TempReadPtr == 0)}} & Read4Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 1)}} & Read5Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 2)}} & Read6Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 3)}} & Read7Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 4)}} & Read8Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 5)}} & Read1Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 6)}} & Read2Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 7)}} & Read3Date ; 


    assign OutInstPort1 =  (TempNumber >= 1) && ~StopTemp;
    assign OutInstPort2 =  (TempNumber >= 2) && ~StopTemp;
    assign OutInstPort3 =  (TempNumber >= 3) && ~StopTemp;
    assign OutInstPort4 =  (TempNumber >= 4) && ~StopTemp;

    wire  WriteU1Able ;
    wire  WriteU2Able ;
    wire  WriteU3Able ;
    wire  WriteU4Able ;
    wire  WriteU5Able ;
    wire  WriteU6Able ;
    wire  WriteU7Able ;
    wire  WriteU8Able ;
    wire [INSTQUEUEWIDE-1:0] Write1Date ;
    wire [INSTQUEUEWIDE-1:0] Write2Date ;
    wire [INSTQUEUEWIDE-1:0] Write3Date ;
    wire [INSTQUEUEWIDE-1:0] Write4Date ;
    wire [INSTQUEUEWIDE-1:0] Write5Date ;
    wire [INSTQUEUEWIDE-1:0] Write6Date ;
    wire [INSTQUEUEWIDE-1:0] Write7Date ;
    wire [INSTQUEUEWIDE-1:0] Write8Date ;

    assign  {WriteU1Able,Write1Date}  = {INSTQUEUEWIDE+1{(WritePtr[2:0] == 0)}} & {FromPre1Able,FromPre1Addr, FromPre1Date, FromPre1Part, FromPre1NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 1)}} & {FromPre8Able,FromPre8Addr, FromPre8Date, FromPre8Part, FromPre8NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 2)}} & {FromPre7Able,FromPre7Addr, FromPre7Date, FromPre7Part, FromPre7NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 3)}} & {FromPre6Able,FromPre6Addr, FromPre6Date, FromPre6Part, FromPre6NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 4)}} & {FromPre5Able,FromPre5Addr, FromPre5Date, FromPre5Part, FromPre5NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 5)}} & {FromPre4Able,FromPre4Addr, FromPre4Date, FromPre4Part, FromPre4NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 6)}} & {FromPre3Able,FromPre3Addr, FromPre3Date, FromPre3Part, FromPre3NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 7)}} & {FromPre2Able,FromPre2Addr, FromPre2Date, FromPre2Part, FromPre2NAdr} ;

    assign  {WriteU2Able,Write2Date}  = {INSTQUEUEWIDE+1{(WritePtr[2:0] == 0)}} & {FromPre2Able,FromPre2Addr, FromPre2Date, FromPre2Part, FromPre2NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 1)}} & {FromPre1Able,FromPre1Addr, FromPre1Date, FromPre1Part, FromPre1NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 2)}} & {FromPre8Able,FromPre8Addr, FromPre8Date, FromPre8Part, FromPre8NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 3)}} & {FromPre7Able,FromPre7Addr, FromPre7Date, FromPre7Part, FromPre7NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 4)}} & {FromPre6Able,FromPre6Addr, FromPre6Date, FromPre6Part, FromPre6NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 5)}} & {FromPre5Able,FromPre5Addr, FromPre5Date, FromPre5Part, FromPre5NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 6)}} & {FromPre4Able,FromPre4Addr, FromPre4Date, FromPre4Part, FromPre4NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 7)}} & {FromPre3Able,FromPre3Addr, FromPre3Date, FromPre3Part, FromPre3NAdr} ;

    assign  {WriteU3Able,Write3Date}  = {INSTQUEUEWIDE+1{(WritePtr[2:0] == 0)}} & {FromPre3Able,FromPre3Addr, FromPre3Date, FromPre3Part, FromPre3NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 1)}} & {FromPre2Able,FromPre2Addr, FromPre2Date, FromPre2Part, FromPre2NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 2)}} & {FromPre1Able,FromPre1Addr, FromPre1Date, FromPre1Part, FromPre1NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 3)}} & {FromPre8Able,FromPre8Addr, FromPre8Date, FromPre8Part, FromPre8NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 4)}} & {FromPre7Able,FromPre7Addr, FromPre7Date, FromPre7Part, FromPre7NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 5)}} & {FromPre6Able,FromPre6Addr, FromPre6Date, FromPre6Part, FromPre6NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 6)}} & {FromPre5Able,FromPre5Addr, FromPre5Date, FromPre5Part, FromPre5NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 7)}} & {FromPre4Able,FromPre4Addr, FromPre4Date, FromPre4Part, FromPre4NAdr} ;


    assign  {WriteU4Able,Write4Date}  = {INSTQUEUEWIDE+1{(WritePtr[2:0] == 0)}} & {FromPre4Able,FromPre4Addr, FromPre4Date, FromPre4Part, FromPre4NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 1)}} & {FromPre3Able,FromPre3Addr, FromPre3Date, FromPre3Part, FromPre3NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 2)}} & {FromPre2Able,FromPre2Addr, FromPre2Date, FromPre2Part, FromPre2NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 3)}} & {FromPre1Able,FromPre1Addr, FromPre1Date, FromPre1Part, FromPre1NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 4)}} & {FromPre8Able,FromPre8Addr, FromPre8Date, FromPre8Part, FromPre8NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 5)}} & {FromPre7Able,FromPre7Addr, FromPre7Date, FromPre7Part, FromPre7NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 6)}} & {FromPre6Able,FromPre6Addr, FromPre6Date, FromPre6Part, FromPre6NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 7)}} & {FromPre5Able,FromPre5Addr, FromPre5Date, FromPre5Part, FromPre5NAdr} ;


    assign  {WriteU5Able,Write5Date}  = {INSTQUEUEWIDE+1{(WritePtr[2:0] == 0)}} & {FromPre5Able,FromPre5Addr, FromPre5Date, FromPre5Part, FromPre5NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 1)}} & {FromPre4Able,FromPre4Addr, FromPre4Date, FromPre4Part, FromPre4NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 2)}} & {FromPre3Able,FromPre3Addr, FromPre3Date, FromPre3Part, FromPre3NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 3)}} & {FromPre2Able,FromPre2Addr, FromPre2Date, FromPre2Part, FromPre2NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 4)}} & {FromPre1Able,FromPre1Addr, FromPre1Date, FromPre1Part, FromPre1NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 5)}} & {FromPre8Able,FromPre8Addr, FromPre8Date, FromPre8Part, FromPre8NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 6)}} & {FromPre7Able,FromPre7Addr, FromPre7Date, FromPre7Part, FromPre7NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 7)}} & {FromPre6Able,FromPre6Addr, FromPre6Date, FromPre6Part, FromPre6NAdr} ;


    assign  {WriteU6Able,Write6Date}  = {INSTQUEUEWIDE+1{(WritePtr[2:0] == 0)}} & {FromPre6Able,FromPre6Addr, FromPre6Date, FromPre6Part, FromPre6NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 1)}} & {FromPre5Able,FromPre5Addr, FromPre5Date, FromPre5Part, FromPre5NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 2)}} & {FromPre4Able,FromPre4Addr, FromPre4Date, FromPre4Part, FromPre4NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 3)}} & {FromPre3Able,FromPre3Addr, FromPre3Date, FromPre3Part, FromPre3NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 4)}} & {FromPre2Able,FromPre2Addr, FromPre2Date, FromPre2Part, FromPre2NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 5)}} & {FromPre1Able,FromPre1Addr, FromPre1Date, FromPre1Part, FromPre1NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 6)}} & {FromPre8Able,FromPre8Addr, FromPre8Date, FromPre8Part, FromPre8NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 7)}} & {FromPre7Able,FromPre7Addr, FromPre7Date, FromPre7Part, FromPre7NAdr} ;


    assign  {WriteU7Able,Write7Date}  = {INSTQUEUEWIDE+1{(WritePtr[2:0] == 0)}} & {FromPre7Able,FromPre7Addr, FromPre7Date, FromPre7Part, FromPre7NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 1)}} & {FromPre6Able,FromPre6Addr, FromPre6Date, FromPre6Part, FromPre6NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 2)}} & {FromPre5Able,FromPre5Addr, FromPre5Date, FromPre5Part, FromPre5NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 3)}} & {FromPre4Able,FromPre4Addr, FromPre4Date, FromPre4Part, FromPre4NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 4)}} & {FromPre3Able,FromPre3Addr, FromPre3Date, FromPre3Part, FromPre3NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 5)}} & {FromPre2Able,FromPre2Addr, FromPre2Date, FromPre2Part, FromPre2NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 6)}} & {FromPre1Able,FromPre1Addr, FromPre1Date, FromPre1Part, FromPre1NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 7)}} & {FromPre8Able,FromPre8Addr, FromPre8Date, FromPre8Part, FromPre8NAdr} ;


    assign  {WriteU8Able,Write8Date}  = {INSTQUEUEWIDE+1{(WritePtr[2:0] == 0)}} & {FromPre8Able,FromPre8Addr, FromPre8Date, FromPre8Part, FromPre8NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 1)}} & {FromPre7Able,FromPre7Addr, FromPre7Date, FromPre7Part, FromPre7NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 2)}} & {FromPre6Able,FromPre6Addr, FromPre6Date, FromPre6Part, FromPre6NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 3)}} & {FromPre5Able,FromPre5Addr, FromPre5Date, FromPre5Part, FromPre5NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 4)}} & {FromPre4Able,FromPre4Addr, FromPre4Date, FromPre4Part, FromPre4NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 5)}} & {FromPre3Able,FromPre3Addr, FromPre3Date, FromPre3Part, FromPre3NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 6)}} & {FromPre2Able,FromPre2Addr, FromPre2Date, FromPre2Part, FromPre2NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 7)}} & {FromPre1Able,FromPre1Addr, FromPre1Date, FromPre1Part, FromPre1NAdr} ;


    assign InstQReqStop = U1Full | U2Full | U3Full | U4Full | U5Full | U6Full | U7Full | U8Full ;

    FIFO#(
        .FIFOWIDE   ( INSTQUEUEWIDE )
    )u1_FIFO(
        .Clk        ( Clk           ),
        .Rest       ( Rest          ),
        .Rable      ( Read1Able && ~StopTemp),
        .Dout       ( Read1Date     ),
        .Wable      ( WriteU1Able && ~U1Full ),
        .Din        ( Write1Date    ),
        .FifoClean  ( U1Clean       ),
        .FifoFull   ( U1Full        ),
        .FifoEmpty  ( U1Empty       )
    );

    FIFO#(
        .FIFOWIDE   ( INSTQUEUEWIDE )
    )u2_FIFO(
        .Clk        ( Clk           ),
        .Rest       ( Rest          ),
        .Rable      ( Read2Able  && ~StopTemp),
        .Dout       ( Read2Date     ),
        .Wable      ( WriteU2Able && ~U2Full   ),
        .Din        ( Write2Date    ),
        .FifoClean  ( U2Clean       ),
        .FifoFull   ( U2Full        ),
        .FifoEmpty  ( U2Empty       )
    );

    FIFO#(
        .FIFOWIDE   ( INSTQUEUEWIDE )
    )u3_FIFO(
        .Clk        ( Clk           ),
        .Rest       ( Rest          ),
        .Rable      ( Read3Able  && ~StopTemp),
        .Dout       ( Read3Date     ),
        .Wable      ( WriteU3Able && ~U3Full  ),
        .Din        ( Write3Date    ),
        .FifoClean  ( U3Clean       ),
        .FifoFull   ( U3Full        ),
        .FifoEmpty  ( U3Empty       )
    );

    FIFO#(
        .FIFOWIDE   ( INSTQUEUEWIDE )
    )u4_FIFO(
        .Clk        ( Clk           ),
        .Rest       ( Rest          ),
        .Rable      ( Read4Able  && ~StopTemp),
        .Dout       ( Read4Date     ),
        .Wable      ( WriteU4Able && ~U4Full  ),
        .Din        ( Write4Date    ),
        .FifoClean  ( U4Clean       ),
        .FifoFull   ( U4Full        ),
        .FifoEmpty  ( U4Empty       )
    );

    FIFO#(
        .FIFOWIDE   ( INSTQUEUEWIDE )
    )u5_FIFO(
        .Clk        ( Clk           ),
        .Rest       ( Rest          ),
        .Rable      ( Read5Able && ~StopTemp),
        .Dout       ( Read5Date     ),
        .Wable      ( WriteU5Able && ~U5Full  ),
        .Din        ( Write5Date    ),
        .FifoClean  ( U5Clean       ),
        .FifoFull   ( U5Full        ),
        .FifoEmpty  ( U5Empty       )
    );

    FIFO#(
        .FIFOWIDE   ( INSTQUEUEWIDE )
    )u6_FIFO(
        .Clk        ( Clk           ),
        .Rest       ( Rest          ),
        .Rable      ( Read6Able  && ~StopTemp),
        .Dout       ( Read6Date     ),
        .Wable      ( WriteU6Able && ~U6Full  ),
        .Din        ( Write6Date    ),
        .FifoClean  ( U6Clean       ),
        .FifoFull   ( U6Full        ),
        .FifoEmpty  ( U6Empty       )
    );

    FIFO#(
        .FIFOWIDE   ( INSTQUEUEWIDE )
    )u7_FIFO(
        .Clk        ( Clk           ),
        .Rest       ( Rest          ),
        .Rable      ( Read7Able  && ~StopTemp),
        .Dout       ( Read7Date     ),
        .Wable      ( WriteU7Able && ~U7Full  ),
        .Din        ( Write7Date    ),
        .FifoClean  ( U7Clean       ),
        .FifoFull   ( U7Full        ),
        .FifoEmpty  ( U7Empty       )
    );

    FIFO#(
        .FIFOWIDE   ( INSTQUEUEWIDE )
    )u8_FIFO(
        .Clk        ( Clk           ),
        .Rest       ( Rest          ),
        .Rable      ( Read8Able  && ~StopTemp),
        .Dout       ( Read8Date     ),
        .Wable      ( WriteU8Able && ~U8Full  ),
        .Din        ( Write8Date    ),
        .FifoClean  ( U8Clean       ),
        .FifoFull   ( U8Full        ),
        .FifoEmpty  ( U8Empty       )
    );
    
endmodule 
