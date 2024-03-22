`timescale 1ps/1ps
`include "../IP/Bram_SIM.v"
`include "../Lib/Counter_heap.v"
`include "define.v"

module TageBankCtrl #(
    parameter TDEEP = 128,
    parameter TTAG  = 7  ,
    parameter TDPW  = 7  ,
    parameter TWIDE = 9  ,
    parameter COUNTWIDE = 2 
) (
    input       wire                                        Clk        ,
    input       wire                                        Rest       ,

    input       wire                                        Ren        ,
    input       wire                                        Wen        ,
    input       wire                                        Atte       ,
    input       wire      [TDPW-1:0]                        Raddr      ,
    input       wire      [TDPW-1:0]                        Waddr      ,
    input       wire      [TWIDE+COUNTWIDE-1:0]             Din        ,
    output      wire      [((TDEEP/32)*(TWIDE+COUNTWIDE))-1:0]  Dout     
);

    wire [TWIDE-1:0] TAGANDPT [0:TDEEP/32-1] ;
    wire [COUNTWIDE-1:0] COUN  [0:TDEEP/32-1] ;
    wire              TPWABLE  [0:TDEEP/32-1] ;
    wire              COUNWABLE[0:TDEEP/32-1] ;
    //wire              COUNATTE [0:TDEEP/32] ;
    wire              TPRABLE  [0:TDEEP/32-1] ;
    wire              COUNRABLE[0:TDEEP/32-1] ;
    wire [((TDEEP/32)*(TWIDE+COUNTWIDE-1)):0] DataOut  ;


    genvar  i  ;
    generate
        for (i = 0;i < TDEEP/32 ;i=i+1 ) begin :Loop

            assign TAGANDPT[i]  = Din[TWIDE-1:0]     ;
            assign COUN    [i]  = Din[COUNTWIDE-1:0] ;
            assign TPWABLE [i]  = ((Waddr[TDPW-1:5] == i) && (Wen)) ? `AbleValue : `EnableValue             ;
            assign COUNWABLE[i] = ((Waddr[TDPW-1:5] == i) && (Wen)) ? `AbleValue : `EnableValue             ;                                                             
            assign TPRABLE [i]  = ((Raddr[TDPW-1:5] == i) && (Ren)) ? `AbleValue : `EnableValue             ;
            assign COUNRABLE[i] = ((Raddr[TDPW-1:5] == i) && (Ren)) ? `AbleValue : `EnableValue             ;

            Bram_SIM#(
                .BRAMWIDE ( TWIDE   ),
                .BRAMDEPW ( 5       ),
                .BRAMDEEP ( 32      )
            )u_Bram_SIM(
                .Clk      ( Clk         ),
                .Rest     ( Rest        ),
                .REN      ( TPRABLE[i]  ),
                .WEN      ( TPWABLE[i]  ),
                .RADDR    ( Raddr       ),
                .WADDR    ( Waddr       ),
                .DIN      ( TAGANDPT[i] ),
                .DOUT     ( DataOut[((i+1)*(TWIDE+COUNTWIDE))-1:i*(TWIDE+COUNTWIDE)])
            );

            Counter_heap#(
                .COUNTERWIDE   ( COUNTWIDE ),
                .COUNTERPW     ( 5         ),
                .COUNTERDEEP   ( 32        )
            )u_Counter_heap(
                .Clk           ( Clk           ),
                .Rest          ( Rest          ),
                .UpAddr        ( Waddr         ),
                .ReadAddr      ( Raddr         ),
                .Attenuation   ( Atte          ),
                .UpdateAble    ( COUNWABLE[i]  ),
                .ReadAble      ( COUNRABLE[i]  ),
                .RightOrFault  ( COUN[i][0]    ),
                .DoutCounter   ( DataOut[((i+1)*(COUNTWIDE))-1:i*(COUNTWIDE)])
            );

        end
    endgenerate

    assign Dout = DataOut ;
    
endmodule 
