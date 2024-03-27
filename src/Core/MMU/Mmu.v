`timescale 1ps/1ps
`include "../define.v"

module Mmu (
    input       wire                                     Clk           ,
    input       wire                                     Rest          ,
    //from Csr
    input       wire      [9:0]                          Asid          ,
    input       wire      [`DataBus]                     CsrDmw0Date   ,
    input       wire      [`DataBus]                     CsrDmw1Date   ,
    input       wire      [`DataBus]                     CsrCrmdDate   ,
    //input       wire                                     CsrReadTlbAble,
    input       wire      [5:0]                          CsrReadTlbAddr,
    output      wire      [89-1:0]                       CsrReadTlbDate, 
    input       wire                                     CsrSerchTlbAble, //单独起来，在tlb中单独支持
    input       wire      [63:0]                         CsrSerchInfrom ,
    output      wire      [5:0]                          CsrSerchIdxDate,
    input       wire                                     CsrWriteTlbAble,
    input       wire      [5:0]                          CsrWriteTlbAddr,
    input       wire      [63:0]                         CsrWriteTlbDate, 
    input       wire                                     CsrInvEn       ,
    input       wire      [ 4:0]                         CsrInvOp       ,
    input       wire      [ 9:0]                         CsrInvAsid     ,
    input       wire      [18:0]                         CsrInvVppn     , 
    //from Inst
    input       wire                                     InstFetch      ,
    input       wire      [31:0]                         InstVritualA   ,
    output      wire                                     InstTlbTrap    ,
    output      wire      [6:0]                          InstTlbTrapType,
    output      wire      [`InstAddrBus]                 InstPhysicalAddr,
    //from access memory
    input       wire                                     MemAccess      ,
    input       wire      [31:0]                         MemVritualA    ,
    output      wire      [18:0]                         MemTgeDate     ,
    output      wire                                     MemTlbFound    ,
    output      wire                                     MemTlbV        ,
    output      wire                                     MEmTLbD        ,
    output      wire      [1:0]                          MemTlbMat      ,
    output      wire      [1:0]                          MemTlbPlv      ,
    //from CtrlBlock
    input       wire                                     MmuStop        ,
    input       wire                                     MmuFlash      
);
    wire  [18:0]     MmuReadVppn ;
    wire  [9:0]      MmuReadAsid ;
    wire             MmuReadG    ;
    wire  [5:0]      MmuReadPs   ;
    wire             MmuReadE    ;
    wire             MmuReadV0   ;
    wire             MmuReadD0   ;
    wire  [1:0]      MmuReadMat0 ;
    wire  [1:0]      MmuReadPlv0 ;
    wire  [19:0]     MmuReadPpn0 ;
    wire             MmuReadV1   ;
    wire             MmuReadD1   ;
    wire  [1:0]      MmuReadMat1 ;
    wire  [1:0]      MmuReadPlv1 ;
    wire  [19:0]     MmuReadPpn1 ;

    assign CsrReadTlbDate = {MmuReadVppn,MmuReadAsid,MmuReadG,MmuReadPs,MmuReadE,
                             MmuReadV0,MmuReadD0,MmuReadMat0,MmuReadPlv0,MmuReadPpn0,
                             MmuReadV1,MmuReadD1,MmuReadMat1,MmuReadPlv1,MmuReadPpn1};

    reg               MemReqTemp     ;
    reg [31:0]        MemReqAddrTemp ;//当遇到csrserch时则优先csrserch 并将memory的serch挂起，毕竟memory的推测执行不急于一时
    always @(posedge Clk) begin
        if(!Rest) begin
            MemReqTemp <= 1'b0 ;
            MemReqAddrTemp <= `ZeorDate ;
        end
        else if(CsrSerchTlbAble && MemAccess)  begin
            MemReqTemp <= MemAccess ;
            MemReqAddrTemp <= MemVritualA ;
        end
    end

    wire                 DriectDmw0Able   = (InstVritualA[31:29] == CsrDmw0Date[31:29]);
    wire  [1:0]          DriectDmw0Plv    = {CsrDmw0Date[3],CsrDmw0Date[0]} ;
    wire  [1:0]          DriectDmw0Mat    = CsrDmw0Date[5:4] ;
    wire  [`InstAddrBus] Dmw0Physicaladdr = {CsrDmw1Date[27:25],InstVritualA[28:0]} ;
    wire                 DriectDmw1Able   = (InstVritualA[31:29] == CsrDmw1Date[31:29]);
    wire  [1:0]          DriectDmw1Plv    = {CsrDmw1Date[3],CsrDmw1Date[0]} ;
    wire  [1:0]          DriectDmw1Mat    = CsrDmw1Date[5:4] ;
    wire  [`InstAddrBus] Dmw1Physicaladdr = {CsrDmw1Date[27:25],InstVritualA[28:0]} ;


    wire  [18:0]   PortInstVppn = InstVritualA[31:13] ;
    wire           PortInstOdd  = ~InstVritualA[12]   ;
    wire  [19:0]   PortInstPpn ;
    wire           PortInstV   ;
    wire           PortInstD   ;
    wire  [1:0]    PortInstMat ;
    wire  [1:0]    PortInstPlv ;
    wire  [5:0]    PortInstPs  ;
    wire           MmuPhysicalAddr = {PortInstPpn, InstVritualA[11:0]} ;

    reg [`InstAddrBus] InstPhysicalAddrReg ;
    reg [5:0]          InstTlbTrapTypeReg  ;
    reg                InstTlbTrapAbleReg  ;     

    always @(posedge Clk) begin
        if(!Rest) begin
            InstPhysicalAddrReg <= `ZeorDate ;
            InstTlbTrapTypeReg <= 6'd0 ;
            InstTlbTrapAbleReg <= `EnableValue ;
        end
        else if(InstFetch) begin
            InstPhysicalAddrReg <= (CsrCrmdDate[3] && ~CsrCrmdDate[4]) ? InstVritualA : 
                                   ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && DriectDmw0Able) ? Dmw0Physicaladdr : 
                                   ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && DriectDmw1Able) ? Dmw1Physicaladdr :
                                   (~CsrCrmdDate[3] && CsrCrmdDate[4]) ? MmuPhysicalAddr : `ZeorDate ;
            {InstTlbTrapAbleReg, InstTlbTrapTypeReg} <= ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && DriectDmw0Able) ? {~((CsrDmw0Date[0] & (CsrCrmdDate[1:0] == 0)) || ~(CsrDmw0Date[3] & (CsrCrmdDate[1:0] == 3))), `PPI}:
                                                        ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && DriectDmw1Able) ? {~((CsrDmw1Date[0] & (CsrCrmdDate[1:0] == 0)) || ~(CsrDmw1Date[3] & (CsrCrmdDate[1:0] == 3))), `PPI}:
                                                        (~CsrCrmdDate[3] && CsrCrmdDate[4])  ? (PortInstV ?  {~(PortInstPlv == CsrCrmdDate[1:0]), `PPI} : {`AbleValue, `PIF}) {`EnableValue, 7'd0};
        end         
    end 

    assign InstPhysicalAddr = InstPhysicalAddrReg ;
    assign InstTlbTrapType  = InstTlbTrapTypeReg  ;
    assign InstTlbTrapAble  = InstTlbTrapAbleReg  ;

    wire  [18:0]   PortMemVppn = MemVritualA[31:13] ;
    wire           PortMemOdd  = ~MemVritualA[12] ?  ;
    wire  [19:0]   PortMemPpn ;
    wire           PortMemV   ;
    wire           PortMemD   ;
    wire  [1:0]    PortMemMat ;
    wire  [1:0]    PortMemPlv ;
    wire  [5:0]    PortMemPs  ;
    wire           MmuPhysicalAddr2 = {PortInstPpn, InstVritualA[11:0]} ;


    TlbEntry#(
        .TLBNUM     ( 64 )
    )u_TlbEntry(
        .Clk        ( Clk              ),
        .Rest       ( Rest             ),
        .S0Vppn     ( PortInstVppn     ),
        .S0OddPage  ( PortInstOdd      ),
        .S0Asid     ( Asid             ),
        .S0Fund     ( InstTlbFound     ),
        //.S0Index    ( S0Index    ),
        .S0Ps       ( PortInstPs       ),
        .S0Ppn      ( PortInstPpn      ),
        .S0V        ( PortInstV        ),
        .S0D        ( PortInstD        ),
        .S0Mat      ( PortInstMat      ),
        .S0Plv      ( PortInstPlv      ),
        .S1Vppn     ( S1Vppn     ),
        .S1OddPage  ( S1OddPage  ),
        .S1Asid     ( Asid       ),
        .S1Fund     ( S1Fund     ),
        .S1Index    ( S1Index    ),
        .S1Ps       ( S1Ps       ),
        .S1Ppn      ( S1Ppn      ),
        .S1V        ( S1V        ),
        .S1D        ( S1D        ),
        .S1Mat      ( S1Mat      ),
        .S1Plv      ( S1Plv      ),
        .We         ( We         ),
        .WIndex     ( WIndex     ),
        .WVppn      ( WVppn      ),
        .WAsid      ( WAsid      ),
        .WG         ( WG         ),
        .WPs        ( WPs        ),
        .WE         ( WE         ),
        .WV0        ( WV0        ),
        .WD0        ( WD0        ),
        .WMat0      ( WMat0      ),
        .WPlv0      ( WPlv0      ),
        .WPpn0      ( WPpn0      ),
        .WV1        ( WV1        ),
        .WD1        ( WD1        ),
        .WMat1      ( WMat1      ),
        .WPlv1      ( WPlv1      ),
        .WPpn1      ( WPpn1      ),
        .RIndex     ( CsrReadTlbAddr   ),
        .RVppn      ( MmuReadVppn      ),
        .RAsid      ( MmuReadAsid      ),
        .RG         ( MmuReadG         ),
        .RPs        ( MmuReadPs        ),
        .RE         ( MmuReadE         ),
        .RV0        ( MmuReadV0        ),
        .RD0        ( MmuReadD0        ),
        .RMat0      ( MmuReadMat0      ),
        .RPlv0      ( MmuReadPlv0      ),
        .RPpn0      ( MmuReadPpn0      ),
        .RV1        ( MmuReadV1        ),
        .RD1        ( MmuReadD1        ),
        .RMat1      ( MmuReadMat1      ),
        .RPlv1      ( MmuReadPlv1      ),
        .RPpn1      ( MmuReadPpn1      ),
        .InvEn      ( InvEn      ),
        .InvOp      ( InvOp      ),
        .InvAsid    ( InvAsid    ),
        .InvVppn    ( InvVppn    )
    );

    





    
endmodule 
 