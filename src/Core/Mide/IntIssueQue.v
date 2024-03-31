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
    input      wire                                       ReqInstPort1 ,
    input      wire                                       ReqInstPort2 ,
    input      wire                                       ReqInstPort3 ,
    input      wire                                       ReqInstPort4 ,
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
    output     wire      [`InstAddrBus]                   OutInstNAdr4 ,
    output     wire                                       InstQEmpty   
);


    reg  [2:0]  WritePtr ;
    reg  [2:0]  ReadPtr  ;

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

    wire [2:0] ReqInstNum = (ReqInstPort1 & ReqInstPort2 & ReqInstPort3 & ReqInstPort4) ? 3'd4 : 
                            (ReqInstPort1 & ReqInstPort2 & ReqInstPort3 & ReqInstPort4) ? 3'd3 : 
                            (ReqInstPort1 & ReqInstPort2 & ReqInstPort3 & ReqInstPort4) ? 3'd2 : 
                            (ReqInstPort1 & ReqInstPort2 & ReqInstPort3 & ReqInstPort4) ? 3'd1 : 3'd0 ;

    always @(posedge Clk) begin
        if(!Rest) begin
            ReadPtr <= 3'd0 ;
        end
        else begin
            ReadPtr <= ReadPtr[1:0] + ReqInstNum ;
        end
    end
    // late one clk sent infromation
    reg [1:0] TempReadPtr ;
    always @(posedge Clk) begin
        if(!Rest) begin
            TempReadPtr <= 2'd0 ;
        end
        else begin
            TempReadPtr <= ReadPtr[1:0] ;
        end
    end

    wire  Read1Able   = (ReadPtr[1:0] == 0) ? ReqInstPort1 :
                        (ReadPtr[1:0] == 1) ? ReqInstPort4 :
                        (ReadPtr[1:0] == 2) ? ReqInstPort3 :
                        (ReadPtr[1:0] == 3) ? ReqInstPort2 : `EnableValue ;

    wire  Read2Able   = (ReadPtr[1:0] == 0) ? ReqInstPort2 :
                        (ReadPtr[1:0] == 1) ? ReqInstPort1 :
                        (ReadPtr[1:0] == 2) ? ReqInstPort4 :
                        (ReadPtr[1:0] == 3) ? ReqInstPort3 : `EnableValue ;

    wire  Read3Able   = (ReadPtr[1:0] == 0) ? ReqInstPort3 :
                        (ReadPtr[1:0] == 1) ? ReqInstPort2 :
                        (ReadPtr[1:0] == 2) ? ReqInstPort1 :
                        (ReadPtr[1:0] == 3) ? ReqInstPort4 : `EnableValue ;

    wire  Read4Able   = (ReadPtr[1:0] == 0) ? ReqInstPort4 :
                        (ReadPtr[1:0] == 1) ? ReqInstPort3 :
                        (ReadPtr[1:0] == 2) ? ReqInstPort2 :
                        (ReadPtr[1:0] == 3) ? ReqInstPort1 : `EnableValue ;

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

    assign InstQReqStop = U1Full | U2Full | U3Full | U4Full ;
    assign InstQEmpty   = U1Empty & U2Empty & U3Empty & U4Empty ;

    FIFO#(
        .FIFOWIDE   ( INSTQUEUEWIDE )
    )u1_FIFO(
        .Clk        ( Clk           ),
        .Rest       ( Rest          ),
        .Rable      ( Read1Able     ),
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
        .Rable      ( Read2Able     ),
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
        .Rable      ( Read3Able     ),
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
        .Rable      ( Read4Able     ),
        .Dout       ( Read4Date     ),
        .Wable      ( WriteU4Able   ),
        .Din        ( Write4Date    ),
        .FifoClean  ( U4Clean       ),
        .FifoFull   ( U4Full        ),
        .FifoEmpty  ( U4Empty       )
    );


    
endmodule 
