`timescale 1ps/1ps
`include "define.v"

module CtrlBlock #(
    parameter CBPTRWIDE = 1 
)(
    input     wire                                          Clk               ,
    input     wire                                          Rest              ,

    //from BRU
    input     wire                                          BruRedirect        , //类似与此种redirect情况在触发之后将会失能出发机制直到clean所有EU module
    input     wire        [CBPTRWIDE-1:0]                   BruRedirectPtr     ,
    //from CSRU
    input     wire                                          CsruRedirect       ,
    input     wire        [CBPTRWIDE-1:0]                   CsruRedirectPtr    ,
    input     wire        [`InstAddrBus]                    CsruRedirectPc     ,    
    //from LSU
    input     wire                                          LsuRedirect        ,
    input     wire        [CBPTRWIDE-1:0]                   LsuRedirectPtr     ,
    //from ROB
    input     wire                                          ROBReLoad          ,
    input     wire                                          ROBstop            ,
    //to FTQ
    output    wire                                          FTQstop            ,
    output    wire                                          FTQclean           ,
    output    wire        [CBPTRWIDE-1:0]                   CleanPtr           , 
    output    wire                                          FTQRedirect        , 
    output    wire                                          FTQRedirectPc      , 
    output    wire        [`InstAddrBus]                    RedirectPc         ,                 
    //to BPcheck
    output    wire                                          BPcstop            ,
    output    wire                                          BPCclean           ,
    //to InstQueue
    output    wire                                          IQstop             ,
    output    wire                                          IQclean            ,
    //to Decode 
    output    wire                                          IDstop             ,
    output    wire                                          IDclean            ,
    //to Dispath
    output    wire                                          Dispathclean       ,
    //to RS
    output    wire                                          Rsclean            , 
    //to EU   
    output    wire                                          EUclean            ,

);
    reg                   RegBruRedirect ;
    reg  [CBPTRWIDE-1:0]  RegBruRedirectPtr;
    always @(posedge Clk) begin
        if(!Rest) begin
            RegBruRedirect <= `EnableValue ;
            RegBruRedirectPtr <= {CBPTRWIDE{1'b0}} ;
        end 
        else begin
            if(BruRedirect) begin
                RegBruRedirect <= `AbleValue ; 
                RegBruRedirectPtr <= BruRedirectPtr ;
            end
            if(ROBReLoad) begin
                RegBruRedirect <= `EnableValue ;
                RegBruRedirectPtr <= {CBPTRWIDE{1'b0}} ;
            end 
        end
    end

    reg                   RegROBstop ;
    reg                   RegCsruRedirect ;
    reg  [CBPTRWIDE-1:0]  RegCsruRedirectPtr ;
    reg  [`InstAddrBus]   RegCsruRedirectPc  ;
    always @(posedge Clk) begin // 对于CSR来说无论是重定向还是STOP都会失能重定向和STOP的能力
        if(!Rest) begin
            RegROBstop <= `EnableValue ;
            RegCsruRedirect <= `EnableValue ;
            RegCsruRedirectPtr <= {CBPTRWIDE{1'b0}};
            RegCsruRedirectPc <= `ZeorDate ;
        end
        else begin
            if(CsruRedirect)begin
                RegROBstop <= `EnableValue ;
                RegCsruRedirect <= `AbleValue ;
                RegCsruRedirectPtr <= CsruRedirectPtr;
                RegCsruRedirectPc <= CsruRedirectPc ;
            end
            if(ROBstop)begin
                RegROBstop <= `AbleValue ;
                RegCsruRedirect <= `EnableValue ;
                RegCsruRedirectPtr <= {CBPTRWIDE{1'b0}};
                RegCsruRedirectPc <= `ZeorDate ;
            end
            if(ROBReLoad)begin
                RegROBstop <= `EnableValue ;
                RegCsruRedirect <= `EnableValue ;
                RegCsruRedirectPtr <= {CBPTRWIDE{1'b0}};
                RegCsruRedirectPc <= `ZeorDate ;
            end
        end
    end

    reg                   RegLsuRedirect ;
    reg  [CBPTRWIDE-1:0]  RegLsuRedirectPtr ;
    always @(posedge Clk) begin
        if(!Rest) begin
            RegLsuRedirect <= `EnableValue ;
            RegLsuRedirectPtr <= {CBPTRWIDE{1'b0}};
        end
        else begin
            if(LsuRedirect)begin
                RegLsuRedirect <= `AbleValue ;
                RegLsuRedirectPtr <= LsuRedirectPtr; 
            end
            if(ROBReLoad) begin
                RegLsuRedirect <= `EnableValue ;
                RegLsuRedirectPtr <= {CBPTRWIDE{1'b0}}; 
            end
        end
    end


    assign FTQstop  =  (ROBstop | RegROBstop) & (~CsruRedirect) ;
    assign 





    
endmodule