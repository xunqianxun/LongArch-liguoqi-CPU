`timescale 1ps/1ps
`include "../define.v"
`include "CriqFreelist1.v"
`include "CriqFreelist2.v"
`include "CriqFreelist3.v"
`include "CriqFreelist4.v"

module FreeList (
    input       wire                               Clk          ,
    input       wire                               Rest         ,
    //for ctrl 
    input       wire                               FreelistStop ,
    input       wire                               FreeListFlash,
    output      wire                               FreeListReq  ,
    //from dispatch 
    input       wire                               InWay1Rename ,
    input       wire      [`ArchRegBUs]            InWay1RegNum ,
    input       wire                               InWay2Rename ,
    input       wire      [`ArchRegBUs]            InWay2RegNum ,
    input       wire                               InWay3Rename ,
    input       wire      [`ArchRegBUs]            InWay3RegNum ,
    input       wire                               InWay4Rename ,
    input       wire      [`ArchRegBUs]            InWay4RegNum ,
    //to RAT
    output      wire                               OutWay1Rename,
    output      wire      [`ArchRegBUs]            OutWay1Areg  ,
    output      wire      [`ReNameRegBUs]          OutWay1RegNum,
    output      wire                               OutWay2Rename,
    output      wire      [`ArchRegBUs]            OutWay2Areg  ,
    output      wire      [`ReNameRegBUs]          OutWay2RegNum,
    output      wire                               OutWay3Rename,
    output      wire      [`ArchRegBUs]            OutWay3Areg  ,
    output      wire      [`ReNameRegBUs]          OutWay3RegNum,
    output      wire                               OutWay4Rename,
    output      wire      [`ArchRegBUs]            OutWay4Areg  ,
    output      wire      [`ReNameRegBUs]          OutWay4RegNum,
    //from ROB
    input       wire                               ReloadAble   ,
    //from RefTable
    input       wire                               FreeAble1    ,
    input       wire      [`ReNameRegBUs]          FreeAddr1    ,
    input       wire                               FreeAble2    ,
    input       wire      [`ReNameRegBUs]          FreeAddr2    ,
    input       wire                               FreeAble3    ,
    input       wire      [`ReNameRegBUs]          FreeAddr3    ,
    input       wire                               FreeAble4    ,
    input       wire      [`ReNameRegBUs]          FreeAddr4    
);
    reg            StopTemp  ;
    reg            FlashTemp ;

    always @(posedge Clk) begin
        if(!Rest) begin
            StopTemp  <= 1'b0 ;
            FlashTemp <= 1'b0 ;
        end 
        else begin
            StopTemp  <= FreelistStop  ;
            FlashTemp <= FreeListFlash ;
        end
    end

    reg [2:0] WritePtr ;
    reg [2:0] ReadPtr  ;

    wire [2:0] ReadCounter = InWay1Rename  & InWay2Rename   & InWay3Rename  & InWay4Rename  ? 3'd4 :
                             InWay1Rename  & InWay2Rename   & InWay3Rename  & ~InWay4Rename ? 3'd3 :
                             InWay1Rename  & InWay2Rename   & ~InWay3Rename & ~InWay4Rename ? 3'd2 :
                             InWay1Rename  & ~InWay2Rename  & ~InWay3Rename & ~InWay4Rename ? 3'd1 : 3'd0 ;
    wire [2:0] WriteCounter = FreeAble1 & FreeAble2  & FreeAble3  & FreeAble4  ? 3'd4 :
                              FreeAble1 & FreeAble2  & FreeAble3  & ~FreeAble4 ? 3'd3 :
                              FreeAble1 & FreeAble2  & ~FreeAble3 & ~FreeAble4 ? 3'd2 :
                              FreeAble1 & ~FreeAble2 & ~FreeAble3 & ~FreeAble4 ? 3'd1 : 3'd0 ;

    always @(posedge Clk) begin
        if(!Rest)
            WritePtr <= 3'd0 ;
        else 
            WritePtr <= WritePtr[1:0] + WriteCounter ;
    end

    always @(posedge Clk) begin
        if(!Rest) 
            ReadPtr <= 3'd0 ;
        else 
            ReadPtr <= ReadPtr[1:0] + ReadCounter ;
    end

    wire U1Write = ((WritePtr[1:0] == 0) & ~StopTemp) ? FreeAble1 :
                   ((WritePtr[1:0] == 1) & ~StopTemp) ? FreeAble4 :
                   ((WritePtr[1:0] == 2) & ~StopTemp) ? FreeAble3 :
                   ((WritePtr[1:0] == 3) & ~StopTemp) ? FreeAble2 : `EnableValue ;

    wire U2Write = ((WritePtr[1:0] == 0) & ~StopTemp) ? FreeAble2 :
                   ((WritePtr[1:0] == 1) & ~StopTemp) ? FreeAble1 :
                   ((WritePtr[1:0] == 2) & ~StopTemp) ? FreeAble4 :
                   ((WritePtr[1:0] == 3) & ~StopTemp) ? FreeAble3 : `EnableValue ;

    wire U3Write = ((WritePtr[1:0] == 0) & ~StopTemp) ? FreeAble3 :
                   ((WritePtr[1:0] == 1) & ~StopTemp) ? FreeAble2 :
                   ((WritePtr[1:0] == 2) & ~StopTemp) ? FreeAble1 :
                   ((WritePtr[1:0] == 3) & ~StopTemp) ? FreeAble4 : `EnableValue ;

    wire U4Write = ((WritePtr[1:0] == 0) & ~StopTemp) ? FreeAble4 :
                   ((WritePtr[1:0] == 1) & ~StopTemp) ? FreeAble3 :
                   ((WritePtr[1:0] == 2) & ~StopTemp) ? FreeAble2 :
                   ((WritePtr[1:0] == 3) & ~StopTemp) ? FreeAble1 : `EnableValue ;

    wire [`ReNameRegBUs] U1Date = ((WritePtr[1:0] == 0) & ~StopTemp) ? FreeAddr1 :
                                  ((WritePtr[1:0] == 1) & ~StopTemp) ? FreeAddr4 :
                                  ((WritePtr[1:0] == 2) & ~StopTemp) ? FreeAddr3 :
                                  ((WritePtr[1:0] == 3) & ~StopTemp) ? FreeAddr2 : 7'd0 ;

    wire [`ReNameRegBUs] U2Date = ((WritePtr[1:0] == 0) & ~StopTemp) ? FreeAddr2 :
                                  ((WritePtr[1:0] == 1) & ~StopTemp) ? FreeAddr1 :
                                  ((WritePtr[1:0] == 2) & ~StopTemp) ? FreeAddr4 :
                                  ((WritePtr[1:0] == 3) & ~StopTemp) ? FreeAddr3 : 7'd0  ;

    wire [`ReNameRegBUs] U3Date = ((WritePtr[1:0] == 0) & ~StopTemp) ? FreeAddr3 :
                                  ((WritePtr[1:0] == 1) & ~StopTemp) ? FreeAddr2 :
                                  ((WritePtr[1:0] == 2) & ~StopTemp) ? FreeAddr1 :
                                  ((WritePtr[1:0] == 3) & ~StopTemp) ? FreeAddr4 : 7'd0  ;

    wire [`ReNameRegBUs] U4Date = ((WritePtr[1:0] == 0) & ~StopTemp) ? FreeAddr4 :
                                  ((WritePtr[1:0] == 1) & ~StopTemp) ? FreeAddr3 :
                                  ((WritePtr[1:0] == 2) & ~StopTemp) ? FreeAddr2 :
                                  ((WritePtr[1:0] == 3) & ~StopTemp) ? FreeAddr1 : 7'd0  ;

    wire U1Read = ((ReadPtr[1:0] == 0) & ~StopTemp) ? InWay1Rename :
                  ((ReadPtr[1:0] == 1) & ~StopTemp) ? InWay4Rename :
                  ((ReadPtr[1:0] == 2) & ~StopTemp) ? InWay3Rename :
                  ((ReadPtr[1:0] == 3) & ~StopTemp) ? InWay2Rename : `EnableValue ;

    wire U2Read = ((ReadPtr[1:0] == 0) & ~StopTemp) ? InWay2Rename :
                  ((ReadPtr[1:0] == 1) & ~StopTemp) ? InWay1Rename :
                  ((ReadPtr[1:0] == 2) & ~StopTemp) ? InWay4Rename :
                  ((ReadPtr[1:0] == 3) & ~StopTemp) ? InWay3Rename : `EnableValue ;

    wire U3Read = ((ReadPtr[1:0] == 0) & ~StopTemp) ? InWay3Rename :
                  ((ReadPtr[1:0] == 1) & ~StopTemp) ? InWay2Rename :
                  ((ReadPtr[1:0] == 2) & ~StopTemp) ? InWay1Rename :
                  ((ReadPtr[1:0] == 3) & ~StopTemp) ? InWay4Rename : `EnableValue ;

    wire U4Read = ((ReadPtr[1:0] == 0) & ~StopTemp) ? InWay4Rename :
                  ((ReadPtr[1:0] == 1) & ~StopTemp) ? InWay3Rename :
                  ((ReadPtr[1:0] == 2) & ~StopTemp) ? InWay2Rename :
                  ((ReadPtr[1:0] == 3) & ~StopTemp) ? InWay1Rename : `EnableValue ;

    wire [`ReNameRegBUs] U1PreDate ;
    wire [`ReNameRegBUs] U2PreDate ;
    wire [`ReNameRegBUs] U3PreDate ;
    wire [`ReNameRegBUs] U4PreDate ;

    assign OutWay1Rename = InWay1Rename ; 
    assign OutWay2Rename = InWay2Rename ; 
    assign OutWay3Rename = InWay3Rename ; 
    assign OutWay4Rename = InWay4Rename ; 

    assign OutWay1RegNum = (ReadPtr[1:0] == 0) ? U1PreDate :
                           (ReadPtr[1:0] == 1) ? U2PreDate :
                           (ReadPtr[1:0] == 2) ? U3PreDate :
                           (ReadPtr[1:0] == 3) ? U4PreDate : 7'd0 ;

    assign OutWay2RegNum = (ReadPtr[1:0] == 0) ? U2PreDate :
                           (ReadPtr[1:0] == 1) ? U3PreDate :
                           (ReadPtr[1:0] == 2) ? U4PreDate :
                           (ReadPtr[1:0] == 3) ? U1PreDate : 7'd0 ;

    assign OutWay3RegNum = (ReadPtr[1:0] == 0) ? U3PreDate :
                           (ReadPtr[1:0] == 1) ? U4PreDate :
                           (ReadPtr[1:0] == 2) ? U1PreDate :
                           (ReadPtr[1:0] == 3) ? U2PreDate : 7'd0 ;

    assign OutWay4RegNum = (ReadPtr[1:0] == 0) ? U4PreDate :
                           (ReadPtr[1:0] == 1) ? U1PreDate :
                           (ReadPtr[1:0] == 2) ? U2PreDate :
                           (ReadPtr[1:0] == 3) ? U3PreDate : 7'd0 ;


    assign OutWay1Areg = InWay1RegNum ;
    assign OutWay2Areg = InWay2RegNum ;
    assign OutWay3Areg = InWay3RegNum ;
    assign OutWay4Areg = InWay4RegNum ;

    wire U1Clean = ReloadAble | FlashTemp ;
    wire U2Clean = ReloadAble | FlashTemp ;
    wire U3Clean = ReloadAble | FlashTemp ;
    wire U4Clean = ReloadAble | FlashTemp ;

    wire U1ReqStop ;
    wire U2ReqStop ;
    wire U3ReqStop ;
    wire U4ReqStop ;

    assign FreeListReq = U1ReqStop | U2ReqStop | U3ReqStop | U4ReqStop ;


    CriqFreelist1#(
        .CRIQWIDE    ( 7           ),
        .CRIQDEEP    ( 32          ),
        .PTRWIDE     ( 6           )
    )u_CriqFreelist1(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .Rable       ( U1Read      ),
        //.Dout        ( Dout        ),
        .CriqPreOut  ( U1PreDate   ),
        .Wable       ( U1Write     ),
        .Din         ( U1Date      ),
        .CriqClean   ( U1Clean     ),
        //.CriqFull    ( CriqFull    ),
        .CriqEmpty   ( U1ReqStop   )
    );

    CriqFreelist2#(
        .CRIQWIDE    ( 7           ),
        .CRIQDEEP    ( 32          ),
        .PTRWIDE     ( 6           )
    )u_CriqFreelist2(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .Rable       ( U2Read      ),
        //.Dout        ( Dout        ),
        .CriqPreOut  ( U2PreDate   ),
        .Wable       ( U2Write     ),
        .Din         ( U2Date      ),
        .CriqClean   ( U2Clean     ),
        //.CriqFull    ( CriqFull    ),
        .CriqEmpty   ( U2ReqStop   )
    );

    CriqFreelist3#(
        .CRIQWIDE    ( 7           ),
        .CRIQDEEP    ( 32          ),
        .PTRWIDE     ( 6           )
    )u_CriqFreelist3(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .Rable       ( U3Read      ),
        //.Dout        ( Dout        ),
        .CriqPreOut  ( U3PreDate   ),
        .Wable       ( U3Write     ),
        .Din         ( U3Date      ),
        .CriqClean   ( U3Clean     ),
        //.CriqFull    ( CriqFull    ),
        .CriqEmpty   ( U3ReqStop   )
    );

    CriqFreelist4#(
        .CRIQWIDE    ( 7           ),
        .CRIQDEEP    ( 32          ),
        .PTRWIDE     ( 6           )
    )u_CriqFreelist4(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .Rable       ( U4Read      ),
        //.Dout        ( Dout        ),
        .CriqPreOut  ( U4PreDate   ),
        .Wable       ( U4Write     ),
        .Din         ( U4Date      ),
        .CriqClean   ( U4Clean     ),
        //.CriqFull    ( CriqFull    ),
        .CriqEmpty   ( U4ReqStop   )
    );

    
endmodule
