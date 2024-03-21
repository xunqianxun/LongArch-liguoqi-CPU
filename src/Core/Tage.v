`timescale 1ps/1ps
`include "define.v"
`include "../IP/Bram_SIM.v"

module Tage #(
    parameter BASEDEEP       = 128  ,
    parameter BASEPW         = 7    ,
    parameter T1DEEP         = 128  ,
    parameter T1PW           = 7    ,
    parameter T1GHR          = 2    ,
    parameter T1TGE          = 7    ,
    parameter T2DEEP         = 128  ,
    parameter T2PW           = 7    ,
    parameter T2GHR          = 4    ,
    parameter T2TGE          = 7    ,
    parameter T3DEEP         = 256  ,
    parameter T3PW           = 8    ,
    parameter T3GHR          = 8    ,
    parameter T3TGE          = 8    ,
    parameter T4DEEP         = 256  ,
    parameter T4PW           = 8    ,
    parameter T4GHR          = 16   ,
    parameter T4TGE          = 8    ,
    parameter T5DEEP         = 128  ,
    parameter T5PW           = 7    ,
    parameter T5GHR          = 32   ,
    parameter T5TGE          = 9    ,
    parameter T6DEEP         = 128  ,
    parameter T6PW           = 7    ,
    parameter T6GHR          = 72   ,
    parameter T6TGE          = 9    ,
    parameter TAGEBANK       = 6    ,
    parameter TAGEPRW        = 2    ,
    parameter GHRWIDE        = 72  
) (
    input          wire                                           Clk               ,
    input          wire                                           Rest              ,
    input          wire                                           ForceAble         ,
    input          wire           [`InstAddrBus]                  Pc                ,

    output         wire                                           FoutAble          ,
    output         wire                                           Fpredict          ,
    output         wire           [TAGEBANK-1:0]                  FinaSelectBank    ,
    output         wire           [TAGEBANWIDE-1:0]               FInaSelectPtr     ,
    output         wire           [GHRWIDE-1:0]                   FGHR              ,
    output         wire           [`InstAddrBus]                  FPc               ,

    input          wire                                           UpDateAble        ,
    input          wire                                           UpDatePredict     ,
    input          wire           [TAGEBANK-1:0]                  UpDateSelectB     ,
    input          wire           [TAGEBANWIDE-1:0]               UpDateSelectP     ,
    input          wire           [GHRWIDE-1:0]                   UpdateGHR         ,
    input          wire           [`InstAddrBus]                  UpdatePc                           
);
    
    //*********************************ABOUT TAGE**********************************//
    //       T NUMBER------------DEEP------------GHR WIDE---------TAG WIDE         //
    //         BASE              128             0                0                //
    //         T1                128             2                7                //
    //         T2                128             4                7                //
    //         T3                256             8                8                //
    //         T4                256             16               8                //
    //         T5                128             32               9                //
    //         T6                128             72               9                //
    //*****************************************************************************//

    //this design mand copy from BOOM hhhh
 
    // attenuation counter
    reg [17:0] AttenuationCounter ;
    always @(posedge Clk) begin
        if(!Rest)
            AttenuationCounter <= 18'd0 ;
        else begin
            if(UpDateAble) 
                AttenuationCounter <= AttenuationCounter + 1 ;
            if(AttenuationCounter == 18'b111111111111111111)
                AttenuationCounter <= 18'd0                  ;
        end 

    end

    wire AttenuationAble = (AttenuationCounter == 18'b111111111111111111);

    reg [GHRWIDE-1:0] GHR  ; //oldest ----------> new
    always @(posedge Clk) begin
        if(!Rest) 
            GHR <= {GHRWIDE{1'b0}};
        else begin
            if(UpDateAble)
                GHR <= UpdateGHR ;
            if(FoutAble)
                GHR <= FoutAble ? {GHR[GHRWIDE-1-1:0],Fpredict} : GHR ;
        end
    end

    //for base INDEX: XOR PC
    wire  [BASEPW-1:0]   BaseIndex ;
    wire  [BASEPW-1:0]   Part1Pc = Pc[3+BASEPW-1:3] ;
    wire  [BASEPW-1:0]   Part2Pc = Pc[3+BASEPW+BASEPW-1:3+BASEPW] ;
    wire  [BASEPW-1:0]   Part3Pc = Pc[3+BASEPW+BASEPW+BASEPW-1:3+BASEPW+BASEPW] ;
    wire  [BASEPW-1:0]   Part4Pc = Pc[3+BASEPW+BASEPW+BASEPW+BASEPW-1:3+BASEPW+BASEPW+BASEPW] ;
    wire  [BASEPW-1:0]   Part5Pc = {{(BASEPW-1){1'b0}},Pc[3+BASEPW+BASEPW+BASEPW+BASEPW]}     ;
    assign BaseIndex             = Part5Pc ^ Part4Pc ^ Part3Pc ^ Part2Pc ^ Part1Pc            ;
    wire  [(BASEDEEP/32)*(0+2+2)-1:0] Dou1 ;
    wire  [1:0] BaseDate  ;
    wire  [1:0] BaseCounte;

        TageBankCtrl#(
            .TDEEP     ( BASEDEEP ),
            .TTAG      ( 0        ),
            .TDPW      ( BASEPW   ), //Ti deep ptr wide
            .TWIDE     ( 0+2      ),
            .COUNTWIDE ( 2        )
        )Base_TageBankCtrl(
            .Clk       ( Clk      ),
            .Rest      ( Rest     ),
            .Ren       ( FoutAble ),
            .Wen       (  ),
            .Atte      ( AttenuationAble ),
            .Raddr     ( BaseIndex),
            .Waddr     (  ),
            .Din       (  ),
            .Dout      ( Dou1     )
        );

        assign {BaseDate, BaseCounte} = Dou1[4*(0+2+2)-1:3*(0+2+2)] | Dou1[3*(0+2+2)-1:2*(0+2+2)] | Dou1[2*(0+2+2)-1:(0+2+2)] | Dou1[(0+2+2)-1:0] ;

        wire [T1PW-1:0]  T1Index ;
        wire [T1TGE-1:0] T1Tag   ;


        TageBankCtrl#(
            .TDEEP     ( T1DEEP ),
            .TTAG      ( T1TGE  ),
            .TDPW      ( T1PW   ),
            .TWIDE     ( T1TGE+2),//2:2 bit 饱和计数器的宽度
            .COUNTWIDE ( 2      )
        )T1_TageBankCtrl(
            .Clk       ( Clk    ),
            .Rest      ( Rest   ),
            .Ren       (  ),
            .Wen       (  ),
            .Atte      (  ),
            .Raddr     (  ),
            .Waddr     (  ),
            .Din       (  ),
            .Dout      (  )
        );

        TageBankCtrl#(
            .TDEEP     ( 128 ),
            .TTAG      ( 7 ),
            .TDPW      ( 7 ),
            .TWIDE     ( 9 ),
            .COUNTWIDE ( 2 )
        )T2_TageBankCtrl(
            .Clk       ( Clk    ),
            .Rest      ( Rest   ),
            .Ren       (  ),
            .Wen       (  ),
            .Atte      (  ),
            .Raddr     (  ),
            .Waddr     (  ),
            .Din       (  ),
            .Dout      (  )
        );

        TageBankCtrl#(
            .TDEEP     ( 128 ),
            .TTAG      ( 7 ),
            .TDPW      ( 7 ),
            .TWIDE     ( 9 ),
            .COUNTWIDE ( 2 )
        )T3_TageBankCtrl(
            .Clk       ( Clk    ),
            .Rest      ( Rest   ),
            .Ren       (  ),
            .Wen       (  ),
            .Atte      (  ),
            .Raddr     (  ),
            .Waddr     (  ),
            .Din       (  ),
            .Dout      (  )
        );

        TageBankCtrl#(
            .TDEEP     ( 128 ),
            .TTAG      ( 7 ),
            .TDPW      ( 7 ),
            .TWIDE     ( 9 ),
            .COUNTWIDE ( 2 )
        )T4_TageBankCtrl(
            .Clk       ( Clk    ),
            .Rest      ( Rest   ),
            .Ren       (  ),
            .Wen       (  ),
            .Atte      (  ),
            .Raddr     (  ),
            .Waddr     (  ),
            .Din       (  ),
            .Dout      (  )
        );

        TageBankCtrl#(
            .TDEEP     ( 128 ),
            .TTAG      ( 7 ),
            .TDPW      ( 7 ),
            .TWIDE     ( 9 ),
            .COUNTWIDE ( 2 )
        )T5_TageBankCtrl(
            .Clk       ( Clk    ),
            .Rest      ( Rest   ),
            .Ren       (  ),
            .Wen       (  ),
            .Atte      (  ),
            .Raddr     (  ),
            .Waddr     (  ),
            .Din       (  ),
            .Dout      (  )
        );

        TageBankCtrl#(
            .TDEEP     ( 128 ),
            .TTAG      ( 7 ),
            .TDPW      ( 7 ),
            .TWIDE     ( 9 ),
            .COUNTWIDE ( 2 )
        )T6_TageBankCtrl(
            .Clk       ( Clk    ),
            .Rest      ( Rest   ),
            .Ren       (  ),
            .Wen       (  ),
            .Atte      (  ),
            .Raddr     (  ),
            .Waddr     (  ),
            .Din       (  ),
            .Dout      (  )
        );


    
endmodule
