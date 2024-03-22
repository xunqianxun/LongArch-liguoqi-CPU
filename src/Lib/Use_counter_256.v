`timescale 1ps/1ps
`include "IPsetting.v"

`define DEEP256PTR 8-1 : 0 
`define COUNTERWIDE 1:0

module Use_counter_256 (
    input       wire                                Clk             ,
    input       wire                                Rest            ,

    input       wire      [`DEEP256PTR]             Waddr           , 
    input       wire      [`DEEP256PTR]             Raddr           ,
    input       wire                                Atten           ,//衰减需要在判断的周期i里面进行这样不会和update争抢端口
    input       wire                                Wable           ,//源counter上加减该数据
    input       wire                                Rable           ,
    input       wire                                Wdate           ,
    output      wire      [`COUNTERWIDE]            Rdate                                          
);
    wire Wable1 = (Waddr[7:6] == 2'b00) && Wable ;
    wire Wable2 = (Waddr[7:6] == 2'b01) && Wable ;
    wire Wable3 = (Waddr[7:6] == 2'b10) && Wable ;
    wire Wable4 = (Waddr[7:6] == 2'b11) && Wable ;
    wire Rable1 = (Raddr[7:6] == 2'b00) && Rable ;
    wire Rable2 = (Raddr[7:6] == 2'b01) && Rable ; 
    wire Rable3 = (Raddr[7:6] == 2'b10) && Rable ;
    wire Rable4 = (Raddr[7:6] == 2'b11) && Rable ; 
    wire [`COUNTERWIDE] DoutCounter1 ;
    wire [`COUNTERWIDE] DoutCounter2 ;
    wire [`COUNTERWIDE] DoutCounter3 ;
    wire [`COUNTERWIDE] DoutCounter4 ;
    
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

    Counter_heap#(
        .COUNTERWIDE   ( 2 ),
        .COUNTERPW     ( 6 ),
        .COUNTERDEEP   ( 64 )
    )U3_Counter_heap(
        .Clk           ( Clk           ),
        .Rest          ( Rest          ),
        .UpAddr        ( Waddr[5:0]    ),
        .ReadAddr      ( Raddr[5:0]    ),
        .Attenuation   ( Atten         ),
        .UpdateAble    ( Wable3        ),
        .ReadAble      ( Rable3        ),
        .RightOrFault  ( Wdate         ),
        .DoutCounter   ( DoutCounter3  )
    );

    Counter_heap#(
        .COUNTERWIDE   ( 2 ),
        .COUNTERPW     ( 6 ),
        .COUNTERDEEP   ( 64 )
    )U4_Counter_heap(
        .Clk           ( Clk           ),
        .Rest          ( Rest          ),
        .UpAddr        ( Waddr[5:0]    ),
        .ReadAddr      ( Raddr[5:0]    ),
        .Attenuation   ( Atten         ),
        .UpdateAble    ( Wable4        ),
        .ReadAble      ( Rable4        ),
        .RightOrFault  ( Wdate         ),
        .DoutCounter   ( DoutCounter4  )
    );

    assign Rdate = DoutCounter1 | DoutCounter2 | DoutCounter3 | DoutCounter4;


endmodule
