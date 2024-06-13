`timescale 1ps/1ps
`include "../define.v" 

module AGUload (
    input      wire                               Clk            ,
    input      wire                               Rest           ,

    input      wire                               AGULoadStop    ,
    input      wire                               AGULoadFlash   ,

    //read rob get pc 
    output     wire                               ReadPcAble     ,
    output     wire      [5:0]                    ReadPcRob      ,
    input      wire      [`InstAddrBus]           RobInstPc      ,

    input      wire                               LoadInstAble   ,
    input      wire      [`MicOperateCode]        LoadMicOPercode,
    input      wire                               LoadRegAble0   ,
    input      wire      [`ReNameRegBUs]          LoadRegAddr0   ,
    input      wire      [`DataBus]               LoadRegDate0   ,
    input      wire                               LoadRegAble1   ,
    input      wire      [`ReNameRegBUs]          LoadRegAddr1   ,
    input      wire      [`DataBus]               LoadRegDate1   ,  
    input      wire      [11:0]                   LoadImmDate    ,
    input      wire                               LoadWbAble     ,
    input      wire      [`ReNameRegBUs]          LoadWbAddr     ,
    input      wire      [5:0]                    LoadInstRobPtr ,

    input      wire                               LoadBruAble    ,
    input      wire      [`ReNameRegBUs]          LoadBruAddr    ,
    input      wire      [`DataBus]               LoadBruDate    ,
    input      wire                               LoadAlu2Able   ,
    input      wire      [`ReNameRegBUs]          LoadAlu2Addr   ,
    input      wire      [`DataBus]               LoadAlu2Date   ,
    input      wire                               LoadAlu1Able   ,
    input      wire      [`ReNameRegBUs]          LoadAlu1Addr   ,
    input      wire      [`DataBus]               LoadAlu1Date   ,
    input      wire                               LoadMluAble    ,
    input      wire      [`ReNameRegBUs]          LoadMluAddr    ,
    input      wire      [`DataBus]               LoadMluDate    , 
    input      wire                               LoadCsrAble    ,
    input      wire      [`ReNameRegBUs]          LoadCsrAddr    ,
    input      wire      [`DataBus]               LoadCsrDate    ,
    //for mmu 
    output     wire                               ToAccess       ,
    output     wire      [31:0]                   ToVritualA     ,
    input      wire      [1:0]                    ToOperType     ,
    input      wire                               ToTlbTrap      ,
    input      wire      [6:0]                    ToTlbTrapType  ,
    input      wire      [`InstAddrBus]           ToPhysicalAddr ,
    //to load buffer
    output     wire                               ToLBAble       ,
    output     wire      [`InstAddrBus]           ToLBPc         ,
    output     wire      [`MicOperateCode]        ToLBMicOp      ,
    output     wire      [1:0]                    ToLBMAT        ,   
    output     wire      [`InstAddrBus]           ToLBPAddr      ,
    output     wire                               ToLBTrap       ,
    output     wire      [6:0]                    ToLBTrapCode   ,
    output     wire                               ToLBWbAble     ,
    output     wire      [`ReNameRegBUs]          ToLBWbAddr     ,
    output     wire      [5:0]                    ToLBRobPtr 
);


    wire  [`DataBus] LDSrc1Date   =  ((LoadRegAddr0 == LoadBruAddr ) & LoadBruAble  & LoadRegAble0) ? LoadBruDate :
                                     ((LoadRegAddr0 == LoadAlu1Addr) & LoadAlu1Able & LoadRegAble0) ? LoadAlu1Date:
                                     ((LoadRegAddr0 == LoadAlu2Addr) & LoadAlu2Able & LoadRegAble0) ? LoadAlu2Date:
                                     ((LoadRegAddr0 == LoadMluAddr ) & LoadMluAble  & LoadRegAble0) ? LoadMluDate :
                                     ((LoadRegAddr0 == LoadCsrAddr ) & LoadCsrAble  & LoadRegAble0) ? LoadCsrDate : LoadRegDate0 ;
     
    wire  [`DataBus] LDSrc2Date   =  ((LoadRegAddr1 == LoadBruAddr ) & LoadBruAble  & LoadRegAble1) ? LoadBruDate :
                                     ((LoadRegAddr1 == LoadAlu1Addr) & LoadAlu1Able & LoadRegAble1) ? LoadAlu1Date:
                                     ((LoadRegAddr1 == LoadAlu2Addr) & LoadAlu2Able & LoadRegAble1) ? LoadAlu2Date:
                                     ((LoadRegAddr1 == LoadMluAddr ) & LoadMluAble  & LoadRegAble1) ? LoadMluDate :
                                     ((LoadRegAddr1 == LoadCsrAddr ) & LoadCsrAble  & LoadRegAble1) ? LoadCsrDate : LoadRegDate1 ;

    assign ToAccess   = LoadInstAble & ~((LoadMicOPercode == `InstDbar) | (LoadMicOPercode == `InstIbar) | (LoadMicOPercode == `InstPreld)) ;
    assign ToVritualA = LDSrc1Date + {{20{LoadImmDate[11]}},LoadImmDate} ;

    reg                   ToLBAbleTemp    ;
    reg [`MicOperateCode] ToLBMicOpTemp   ;
    reg                   ToLBWbAbleTemp  ;
    reg [`ReNameRegBUs]   ToLBWbAddrTemp  ;
    reg [5:0]             ToLBRobPtrTemp  ;
    reg [`InstAddrBus]    ToLBPcTemp      ;
    always @(posedge Clk) begin
        if(!Rest) begin
            ToLBAbleTemp    <= 1'b0  ;
            ToLBMicOpTemp   <= 8'b0  ;
            ToLBWbAbleTemp  <= 1'b0  ;
            ToLBWbAddrTemp  <= 7'b0  ;
            ToLBRobPtrTemp  <= 6'b0  ;
            ToLBPcTemp      <= 32'd0 ; 
        end
        else if(AGULoadStop) begin
            ToLBAbleTemp    <= ToLBAbleTemp   ;
            ToLBMicOpTemp   <= ToLBMicOpTemp  ;
            ToLBWbAbleTemp  <= ToLBWbAbleTemp ;
            ToLBWbAddrTemp  <= ToLBWbAddrTemp ;
            ToLBRobPtrTemp  <= ToLBRobPtrTemp ; 
            ToLBPcTemp      <= ToLBPcTemp     ;
        end
        else if(AGULoadFlash)begin
            ToLBAbleTemp    <= 1'b0  ;
            ToLBMicOpTemp   <= 8'b0  ;
            ToLBWbAbleTemp  <= 1'b0  ;
            ToLBWbAddrTemp  <= 7'b0  ;
            ToLBRobPtrTemp  <= 6'b0  ;
            ToLBPcTemp      <= 32'd0 ;
        end
        else begin
            ToLBAbleTemp    <= LoadInstAble     ;
            ToLBMicOpTemp   <= LoadMicOPercode  ;
            ToLBWbAbleTemp  <= LoadWbAble       ;
            ToLBWbAddrTemp  <= LoadWbAddr       ;
            ToLBRobPtrTemp  <= LoadInstRobPtr   ;
            ToLBPcTemp      <= RobInstPc        ;
        end
    end
    

    assign ToLBAble    = ToLBAbleTemp   ;
    assign ToLBMicOp   = ToLBMicOpTemp  ;
    assign ToLBMAT     = ToOperType     ;
    assign ToLBPAddr   = ToPhysicalAddr ;
    assign ToLBTrap    = ToTlbTrap      ;
    assign ToLBTrapCode= ToTlbTrapType  ;
    assign ToLBWbAble  = ToLBWbAbleTemp ;
    assign ToLBWbAddr  = ToLBWbAddrTemp ;
    assign ToLBRobPtr  = ToLBRobPtrTemp ;
    assign ToLBPc      = ToLBPcTemp     ;

    assign ReadPcAble = LoadInstAble ;
    assign ReadPcRob  = LoadInstRobPtr ;

        
endmodule
