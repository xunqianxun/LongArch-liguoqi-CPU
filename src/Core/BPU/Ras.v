`timescale 1ps/1ps
`include "define.v"
`include "../Lib/STACK_dout.v"
`include "../Lib/STACK_reload.v"

module Ras #(
    parameter RASDEEP = 16 ,
    parameter RASPTRW = 4 
) (
    input    wire                               Clk           ,
    input    wire                               Rest          ,

    //speculate ex
    input    wire                               InStackAble   ,
    input    wire        [`InstAddrBus]         InStackDate   , 
    output   wire                               OutStackAble  ,
    output   wire        [`InstAddrBus]         OutStackDate  ,
    //Date update
    input    wire                               UpdateInAble  ,
    input    wire        [`InstAddrBus]         UpdateInDate  ,
    output   wire                               UpdateOutAble ,
    output   wire        [`InstAddrBus]         UpdateOutDate 
);


    STACK_dout#(
        .STACKDEEP      ( 16 ),
        .STACKPTRW      ( 4 ),
        .STACKWIDE      ( 32 ),
        .RECURCOUNT     ( 7 )
    )u_STACK_dout(
        .Clk            ( Clk            ),
        .Rest           ( Rest           ),
        .RABLE          ( RABLE          ),
        .DOUT           ( DOUT           ),
        .WABLE          ( WABLE          ),
        .DIN            ( DIN            ),
        .STACKFULL      ( STACKFULL      ),
        .STACKEMPTY     ( STACKEMPTY     ),
        .REDIRCT        ( REDIRCT        ),
        .OUTDATE        ( OUTDATE        ),
        .OUTDATEPTR     ( OUTDATEPTR     ),
        .OUTDATELINE1   ( OUTDATELINE1   ),
        .OUTDATELINE2   ( OUTDATELINE2   ),
        .OUTDATELINE3   ( OUTDATELINE3   ),
        .OUTDATELINE4   ( OUTDATELINE4   ),
        .OUTDATELINE5   ( OUTDATELINE5   ),
        .OUTDATELINE6   ( OUTDATELINE6   ),
        .OUTDATELINE7   ( OUTDATELINE7   ),
        .OUTDATELINE8   ( OUTDATELINE8   ),
        .OUTDATELINE9   ( OUTDATELINE9   ),
        .OUTDATELINE10  ( OUTDATELINE10  ),
        .OUTDATELINE11  ( OUTDATELINE11  ),
        .OUTDATELINE12  ( OUTDATELINE12  ),
        .OUTDATELINE13  ( OUTDATELINE13  ),
        .OUTDATELINE14  ( OUTDATELINE14  ),
        .OUTDATELINE15  ( OUTDATELINE15  )
    );

    STACK_reload#(
        .STACKDEEP     ( 16 ),
        .STACKPTRW     ( 4 ),
        .STACKWIDE     ( 32 ),
        .RECURCOUNT    ( 7 )
    )u_STACK_reload(
        .Clk           ( Clk           ),
        .Rest          ( Rest          ),
        .RABLE         ( RABLE         ),
        .DOUT          ( DOUT          ),
        .WABLE         ( WABLE         ),
        .DIN           ( DIN           ),
        .STACKFULL     ( STACKFULL     ),
        .STACKEMPTY    ( STACKEMPTY    ),
        .RELOAD        ( RELOAD        ),
        .RELOADPTR     ( RELOADPTR     ),
        .RELOADLINE1   ( RELOADLINE1   ),
        .RELOADLINE2   ( RELOADLINE2   ),
        .RELOADLINE3   ( RELOADLINE3   ),
        .RELOADLINE4   ( RELOADLINE4   ),
        .RELOADLINE5   ( RELOADLINE5   ),
        .RELOADLINE6   ( RELOADLINE6   ),
        .RELOADLINE7   ( RELOADLINE7   ),
        .RELOADLINE8   ( RELOADLINE8   ),
        .RELOADLINE9   ( RELOADLINE9   ),
        .RELOADLINE10  ( RELOADLINE10  ),
        .RELOADLINE11  ( RELOADLINE11  ),
        .RELOADLINE12  ( RELOADLINE12  ),
        .RELOADLINE13  ( RELOADLINE13  ),
        .RELOADLINE14  ( RELOADLINE14  ),
        .RELOADLINE15  ( RELOADLINE15  )
    );



    
endmodule