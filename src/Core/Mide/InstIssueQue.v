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


    reg  [2:0]  WritePtr ;
    reg  [2:0]  ReadPtr  ;

    wire U1Clean = InstQFlash ;
    wire U1Full  ;
    wire U1Empty ;
    wire U2Clean = InstQFlash ;
    wire U2Full  ;
    wire U2Empty ;
    wire U3Clean = InstQFlash ;
    wire U3Full  ;
    wire U3Empty ;
    wire U4Clean = InstQFlash ;
    wire U4Full  ;
    wire U4Empty ;


    wire  [2:0] InInstNum = (FromPre1Able & FromPre2Able & FromPre3Able & FromPre4Able) ? 3'd4 : 
                            (FromPre1Able & FromPre2Able & FromPre3Able &~FromPre4Able) ? 3'd3 : 
                            (FromPre1Able & FromPre2Able &~FromPre3Able &~FromPre4Able) ? 3'd2 : 
                            (FromPre1Able &~FromPre2Able &~FromPre3Able &~FromPre4Able) ? 3'd1 : 3'd0 ;

    always @(posedge Clk) begin
        if(!Rest) begin
            WritePtr <= 3'd0 ;
        end
        else begin
            WritePtr <= WritePtr[1:0] + InInstNum ;
        end
    end

    wire [2:0] ReqInstNum = (~U1Empty & ~U2Empty & ~U3Empty & ~U4Empty) ? 3'd4 : 
                            (~U1Empty & ~U2Empty & ~U3Empty &  U4Empty) ? 3'd3 : 
                            (~U1Empty & ~U2Empty &  U3Empty &  U4Empty) ? 3'd2 : 
                            (~U1Empty &  U2Empty &  U3Empty &  U4Empty) ? 3'd1 : 3'd0 ;

    always @(posedge Clk) begin
        if(!Rest) begin
            ReadPtr <= 3'd0 ;
        end
        else begin
            ReadPtr <= ~InstQStop ?  ReadPtr[1:0] + ReqInstNum : ReadPtr;
        end
    end
    // late one clk sent infromation
    reg [1:0] TempReadPtr ;
    reg [2:0] TempNumber  ;
    always @(posedge Clk) begin
        if(!Rest) begin
            TempReadPtr <= 2'd0 ;
            TempNumber  <= 3'd0 ;
        end
        else begin
            TempReadPtr <= ReadPtr[1:0] ;
            TempNumber  <= ReqInstNum   ;
        end
    end

    wire  Read1Able   = (ReadPtr[1:0] == 0) ? (ReqInstNum == 1) :
                        (ReadPtr[1:0] == 1) ? (ReqInstNum == 4) :
                        (ReadPtr[1:0] == 2) ? (ReqInstNum == 3) :
                        (ReadPtr[1:0] == 3) ? (ReqInstNum == 2) : `EnableValue ;

    wire  Read2Able   = (ReadPtr[1:0] == 0) ? (ReqInstNum == 2) :
                        (ReadPtr[1:0] == 1) ? (ReqInstNum == 1) :
                        (ReadPtr[1:0] == 2) ? (ReqInstNum == 4) :
                        (ReadPtr[1:0] == 3) ? (ReqInstNum == 3) : `EnableValue ;

    wire  Read3Able   = (ReadPtr[1:0] == 0) ? (ReqInstNum == 3) :
                        (ReadPtr[1:0] == 1) ? (ReqInstNum == 2) :
                        (ReadPtr[1:0] == 2) ? (ReqInstNum == 1) :
                        (ReadPtr[1:0] == 3) ? (ReqInstNum == 4) : `EnableValue ;

    wire  Read4Able   = (ReadPtr[1:0] == 0) ? (ReqInstNum == 4) :
                        (ReadPtr[1:0] == 1) ? (ReqInstNum == 3) :
                        (ReadPtr[1:0] == 2) ? (ReqInstNum == 2) :
                        (ReadPtr[1:0] == 3) ? (ReqInstNum == 1) : `EnableValue ;

    wire [INSTQUEUEWIDE-1:0] Read1Date ; 
    wire [INSTQUEUEWIDE-1:0] Read2Date ; 
    wire [INSTQUEUEWIDE-1:0] Read3Date ; 
    wire [INSTQUEUEWIDE-1:0] Read4Date ;

    assign  { OutInstAddr1, OutInstDate1, OutInstPart1, OutInstNAdr1} = (TempReadPtr == 0) ? Read1Date : 
                                                                        (TempReadPtr == 1) ? Read2Date : 
                                                                        (TempReadPtr == 2) ? Read3Date : 
                                                                        (TempReadPtr == 3) ? Read4Date :  {INSTQUEUEWIDE{1'b0}} ;         

    assign  { OutInstAddr2, OutInstDate2, OutInstPart2, OutInstNAdr2} = (TempReadPtr == 0) ? Read2Date : 
                                                                        (TempReadPtr == 1) ? Read3Date : 
                                                                        (TempReadPtr == 2) ? Read4Date : 
                                                                        (TempReadPtr == 3) ? Read1Date :  {INSTQUEUEWIDE{1'b0}} ;  

    assign  { OutInstAddr3, OutInstDate3, OutInstPart3, OutInstNAdr3} = (TempReadPtr == 0) ? Read3Date : 
                                                                        (TempReadPtr == 1) ? Read4Date : 
                                                                        (TempReadPtr == 2) ? Read1Date : 
                                                                        (TempReadPtr == 3) ? Read2Date :  {INSTQUEUEWIDE{1'b0}} ;  

    assign  { OutInstAddr4, OutInstDate4, OutInstPart4, OutInstNAdr4} = (TempReadPtr == 0) ? Read4Date : 
                                                                        (TempReadPtr == 1) ? Read1Date : 
                                                                        (TempReadPtr == 2) ? Read2Date : 
                                                                        (TempReadPtr == 3) ? Read3Date :  {INSTQUEUEWIDE{1'b0}} ;     

    assign OutInstPort1 =  (TempNumber >= 1) && ~InstQStop;
    assign OutInstPort2 =  (TempNumber >= 2) && ~InstQStop;
    assign OutInstPort3 =  (TempNumber >= 3) && ~InstQStop;
    assign OutInstPort4 =  (TempNumber >= 4) && ~InstQStop;

    wire  WriteU1Able = (WritePtr[1:0] == 0) ? FromPre1Able :
                        (WritePtr[1:0] == 1) ? FromPre4Able : 
                        (WritePtr[1:0] == 2) ? FromPre3Able : 
                        (WritePtr[1:0] == 3) ? FromPre2Able : `EnableValue ;

    wire  WriteU2Able = (WritePtr[1:0] == 0) ? FromPre2Able :
                        (WritePtr[1:0] == 1) ? FromPre1Able : 
                        (WritePtr[1:0] == 2) ? FromPre4Able : 
                        (WritePtr[1:0] == 3) ? FromPre3Able : `EnableValue ;

    wire  WriteU3Able = (WritePtr[1:0] == 0) ? FromPre3Able :
                        (WritePtr[1:0] == 1) ? FromPre2Able : 
                        (WritePtr[1:0] == 2) ? FromPre1Able : 
                        (WritePtr[1:0] == 3) ? FromPre4Able : `EnableValue ;

    wire  WriteU4Able = (WritePtr[1:0] == 0) ? FromPre4Able :
                        (WritePtr[1:0] == 1) ? FromPre3Able : 
                        (WritePtr[1:0] == 2) ? FromPre2Able : 
                        (WritePtr[1:0] == 3) ? FromPre1Able : `EnableValue ;

    wire [INSTQUEUEWIDE-1:0] Write1Date = (WritePtr[1:0] == 0) ?{FromPre1Addr, FromPre1Date, FromPre1Part, FromPre1NAdr} : 
                                          (WritePtr[1:0] == 1) ?{FromPre4Addr, FromPre4Date, FromPre4Part, FromPre4NAdr} : 
                                          (WritePtr[1:0] == 2) ?{FromPre3Addr, FromPre3Date, FromPre3Part, FromPre3NAdr} : 
                                          (WritePtr[1:0] == 3) ?{FromPre2Addr, FromPre2Date, FromPre2Part, FromPre2NAdr} : {32'd0,32'd0,1'b0,32'd0};

    wire [INSTQUEUEWIDE-1:0] Write2Date = (WritePtr[1:0] == 0) ?{FromPre2Addr, FromPre2Date, FromPre2Part, FromPre2NAdr} : 
                                          (WritePtr[1:0] == 1) ?{FromPre1Addr, FromPre1Date, FromPre1Part, FromPre1NAdr} : 
                                          (WritePtr[1:0] == 2) ?{FromPre4Addr, FromPre4Date, FromPre4Part, FromPre4NAdr} : 
                                          (WritePtr[1:0] == 3) ?{FromPre3Addr, FromPre3Date, FromPre3Part, FromPre3NAdr} : {32'd0,32'd0,1'b0,32'd0};

    wire [INSTQUEUEWIDE-1:0] Write3Date = (WritePtr[1:0] == 0) ?{FromPre3Addr, FromPre3Date, FromPre3Part, FromPre3NAdr} : 
                                          (WritePtr[1:0] == 1) ?{FromPre2Addr, FromPre2Date, FromPre2Part, FromPre2NAdr} : 
                                          (WritePtr[1:0] == 2) ?{FromPre1Addr, FromPre1Date, FromPre1Part, FromPre1NAdr} : 
                                          (WritePtr[1:0] == 3) ?{FromPre4Addr, FromPre4Date, FromPre4Part, FromPre4NAdr} : {32'd0,32'd0,1'b0,32'd0};

    wire [INSTQUEUEWIDE-1:0] Write4Date = (WritePtr[1:0] == 0) ?{FromPre4Addr, FromPre4Date, FromPre4Part, FromPre4NAdr} : 
                                          (WritePtr[1:0] == 1) ?{FromPre3Addr, FromPre3Date, FromPre3Part, FromPre3NAdr} : 
                                          (WritePtr[1:0] == 2) ?{FromPre2Addr, FromPre2Date, FromPre2Part, FromPre2NAdr} : 
                                          (WritePtr[1:0] == 3) ?{FromPre1Addr, FromPre1Date, FromPre1Part, FromPre1NAdr} : {32'd0,32'd0,1'b0,32'd0};

    assign InstQReqStop = U1Full | U2Full | U3Full | U4Full ;

    FIFO#(
        .FIFOWIDE   ( INSTQUEUEWIDE )
    )u1_FIFO(
        .Clk        ( Clk           ),
        .Rest       ( Rest          ),
        .Rable      ( Read1Able && ~InstQStop),
        .Dout       ( Read1Date     ),
        .Wable      ( WriteU1Able   ),
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
        .Rable      ( Read2Able  && ~InstQStop),
        .Dout       ( Read2Date     ),
        .Wable      ( WriteU2Able   ),
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
        .Rable      ( Read3Able  && ~InstQStop),
        .Dout       ( Read3Date     ),
        .Wable      ( WriteU3Able   ),
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
        .Rable      ( Read4Able  && ~InstQStop),
        .Dout       ( Read4Date     ),
        .Wable      ( WriteU4Able   ),
        .Din        ( Write4Date    ),
        .FifoClean  ( U4Clean       ),
        .FifoFull   ( U4Full        ),
        .FifoEmpty  ( U4Empty       )
    );


    
endmodule 
