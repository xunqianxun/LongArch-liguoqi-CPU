`timescale 1ps/1ps
`include "IPsetting.v"

`define DEEP128PTR 7-1 : 0 
`define COUNTERWIDE 1:0

module Use_counter_128 (
    input       wire                                Clk             ,
    input       wire                                Rest            ,

    input       wire      [`DEEP128PTR]             Waddr           , 
    input       wire      [`DEEP128PTR]             Raddr           ,
    input       wire                                Atten           ,//衰减需要在判断的周期i里面进行这样不会和update争抢端口
    input       wire                                Wable           ,//源counter上加减该数据
    input       wire                                Rable           ,
    input       wire                                Wdate           ,
    output      wire      [`COUNTERWIDE]            Rdate                                          
);
    wire Wable1 = (Waddr[6] == 0) && Wable ;
    wire Wable2 = (Waddr[6] == 1) && Wable ;
    wire Rable1 = (Raddr[6] == 0) && Rable ;
    wire Rable2 = (Raddr[6] == 1) && Rable ; 
    wire [`COUNTERWIDE] DoutCounter1 ;
    wire [`COUNTERWIDE] DoutCounter2 ;
    
    Counter_heap#(
        .COUNTERWIDE   ( 2 ),
        .COUNTERPW     ( 6 ),
        .COUNTERDEEP   ( 64 )
    )U1_Counter_heap(
        .Clk           ( Clk           ),
        .Rest          ( Rest          ),
        .UpAddr        ( Waddr[5:0]    ),
        .ReadAddr      ( Raddr[5:0]    ),
        .Attenuation   ( Atten         ),
        .UpdateAble    ( Wable1        ),
        .ReadAble      ( Rable1        ),
        .RightOrFault  ( Wdate         ),
        .DoutCounter   ( DoutCounter1  )
    );

    Counter_heap#(
        .COUNTERWIDE   ( 2 ),
        .COUNTERPW     ( 6 ),
        .COUNTERDEEP   ( 64 )
    )U2_Counter_heap(
        .Clk           ( Clk           ),
        .Rest          ( Rest          ),
        .UpAddr        ( Waddr[5:0]    ),
        .ReadAddr      ( Raddr[5:0]    ),
        .Attenuation   ( Atten         ),
        .UpdateAble    ( Wable2        ),
        .ReadAble      ( Rable2        ),
        .RightOrFault  ( Wdate         ),
        .DoutCounter   ( DoutCounter2  )
    );

    assign Rdate = DoutCounter1 | DoutCounter2 ;


endmodule
