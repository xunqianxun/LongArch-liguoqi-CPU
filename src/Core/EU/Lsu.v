`timescale 1ps/1ps
`include "../define.v"
`include "../../Lib/FIFOlsu.v"

module Lsu (
    input      wire                               Clk            ,
    input      wire                               Rest           ,

    //for LsuRS
    input      wire                               LSInstAble     ,
    input      wire      [`MicOperateCode]        LsMicOPercode  ,
    input      wire                               LoadOrStreInst ,
    input      wire      [`InstAddrBus]           LsInstVAddr    ,
    input      wire      [`DataBus]               ArchRegDate0   ,
    input      wire      [`DataBus]               ArchRegDate1   ,  // endow mean si12
    input      wire                               WritBackAble   ,
    input      wire      [`ReNameRegBUs]          WritBackAddr   ,
    input      wire      [5:0]                    LsInstRobPtr   ,
    output     wire                               Loadfull       ,
    output     wire                               StoreFull      ,
    //to ROB
    output     wire                               LoadInstReady    ,
    output     wire      [5:0]                    LoadInstPtr      ,
    output     wire                               LoadReDirectAble ,
    output     wire                               LoadTrapAble     ,
    output     wire      [7:0]                    LoadTrapCode     ,
    output     wire      [4:0]                    LoadBufferPtr  ,
    output     wire      [4:0]                    StoreBufferPtr ,
    output     wire      [`InstAddrBus]           LoadTrapaddr   ,
    //from ROB
    input      wire                               RetireLoadAble ,
    input      wire                               RetireStoreAble,
    input      wire      [4:0]                    RetireLoadPtr  ,
    input      wire      [4:0]                    RetireStorePtr ,
    //for csr
    input      wire      [`DataBus]               CsrLlbctlDate  ,
    output     wire                               WriteCsrAble   ,
    output     wire      [`DataBus]               WriteCsrMask   ,
    output     wire      [`DataBus]               WriteCsrDate   ,
    //to physical
    output     wire                               WriteAble      ,
    output     wire      [`ReNameRegBUs]          WriteAddr      ,
    output     wire      [`DataBus]               writeDate      ,
    //to mmu
    output     wire                               MemAble        ,
    output     wire                               LoadStoreC     ,
    output     wire      [`InstAddrBus]           MemVritualAddr ,
    output     wire      [4:0]                    InstLsuPtr     ,
    input      wire                               MemMmuAble     ,
    input      wire                               LSSignCheck    ,
    input      wire      [4:0]                    MemInPtr       ,
    input      wire      [1:0]                    MemCacheType   ,
    input      wire                               MemMmuTrap     ,
    input      wire      [6:0]                    MemMmuTrapCode ,
    input      wire      [`InstAddrBus]           MemPhysicalAddr,
    //to Cache
    output     wire                               LoadAble       ,
    output     wire                               StoreAble      ,
    output     wire      [1:0]                    LoadType       ,
    output     wire      [1:0]                    StoreType      ,  
    output     wire      [`InstAddrBus]           LoadAddr       ,
    output     wire      [`InstAddrBus]           StoreAddr      ,     
    output     wire      [4:0]                    LoadBuffPtr    ,
    output     wire      [`DataBus]               StoreDate      ,
    output     wire                               LoadTrapAble   ,
    output     wire                               StoreTrapAble  ,
    input      wire                               LoadSuccess    ,
    input      wire      [`DataBus]               LoadDate       ,
    input      wire      [4:0]                    LoadBackPtr    ,
    input      wire                               LoadBuzy       ,
    input      wire                               StoreBuzy      ,
    input      wire                               LoadTrapIn     ,
    input      wire                               StoreTrapIn    ,
    input      wire                               DcacheFreeAll  ,
    //for ctrl
    input      wire                               LsuStop        ,
    input      wire                               LsuFLash       ,
    output     wire                               ReDirectLs 
);  

    reg   [67:0]     LOADBUFFER  [1:16] ; //define 0 bit as valid sign 
    reg   [59:0]     STOREBUFFER [1:16] ;

    //in inst send it to mmu trans addr
    assign MemAble = LSInstAble ;
    assign LoadStoreC = LoadOrStreInst ;
    assign InstLsuPtr = LoadOrStreInst ? StoreBufferIndex : LoadBufferIndex ;
    assign MemVritualAddr =  ArchRegDate0 + ArchRegDate1 ;

    //alloca free buffer enty
    assign [4:0] LoadBufferIndex = LOADBUFFER[1][0] ? 5'd1 :
                                   LOADBUFFER[2][0] ? 5'd2 :
                                   LOADBUFFER[3][0] ? 5'd3 :
                                   LOADBUFFER[4][0] ? 5'd4 :
                                   LOADBUFFER[5][0] ? 5'd5 :
                                   LOADBUFFER[6][0] ? 5'd6 :
                                   LOADBUFFER[7][0] ? 5'd7 :
                                   LOADBUFFER[8][0] ? 5'd8 :
                                   LOADBUFFER[9][0] ? 5'd9 :
                                   LOADBUFFER[10][0] ? 5'd10 :
                                   LOADBUFFER[11][0] ? 5'd11 :
                                   LOADBUFFER[12][0] ? 5'd12 :
                                   LOADBUFFER[13][0] ? 5'd13 :
                                   LOADBUFFER[14][0] ? 5'd14 :
                                   LOADBUFFER[15][0] ? 5'd15 :
                                   LOADBUFFER[16][0] ? 5'd16 : 5'd0 ;
    assign [4:0] StoreBufferIndex= STOREBUFFER[1][0] ? 5'd1 :
                                   STOREBUFFER[2][0] ? 5'd2 :
                                   STOREBUFFER[3][0] ? 5'd3 :
                                   STOREBUFFER[4][0] ? 5'd4 :
                                   STOREBUFFER[5][0] ? 5'd5 :
                                   STOREBUFFER[6][0] ? 5'd6 :
                                   STOREBUFFER[7][0] ? 5'd7 :
                                   STOREBUFFER[8][0] ? 5'd8 :
                                   STOREBUFFER[9][0] ? 5'd9 :
                                   STOREBUFFER[10][0] ? 5'd10 :
                                   STOREBUFFER[11][0] ? 5'd11 :
                                   STOREBUFFER[12][0] ? 5'd12 :
                                   STOREBUFFER[13][0] ? 5'd13 :
                                   STOREBUFFER[14][0] ? 5'd14 :
                                   STOREBUFFER[15][0] ? 5'd15 :
                                   STOREBUFFER[16][0] ? 5'd16 : 5'd0 ;

    localparam LOADINBUFFER       = 3'b001 ;
    localparam LOADMMUSUCCESS     = 3'b010 ;
    localparam LOADMMUFUALT       = 3'b011 ;
    localparam LOADWRITERET       = 3'b100 ;

    localparam STOREINBUFFER      = 3'b001 ;
    localparam STOREMMUSUCCESS    = 3'b010 ;
    localparam STOREMMUFUALT      = 3'b011 ;
    localparam STOREREADYRET      = 3'b100 ;


    integer i ;
    always @(posedge Clk) begin
        if(!Rest) begin
            for(i =1 ;i <=16 ; i=i+1 ) begin
                LOADBUFFER[i] <= 68:0 ;
                STOREBUFFER[i] <= 60'd0 ;
            end
        end
        else begin
            LOADBUFFER[LoadBufferIndex][17:0] <= (LSInstAble & ~LoadOrStreInst) ? {LsInstRobPtr,LOADINBUFFER,LsMicOPercode,`AbleValue} : LOADBUFFER[LoadBufferIndex][11:0] ;
            STOREBUFFER[StoreBufferIndex][17:0] <= (LSInstAble & LoadOrStreInst) ? {LsInstRobPtr,STOREINBUFFER,LsMicOPercode,`AbleValue} : LOADBUFFER[LoadBufferIndex][11:0] ;
            LOADBUFFER[InstLsuPtr][59:9]  <= (~LSSignCheck & MemMmuAble) ? {WritBackAddr,WritBackAble,MemMmuTrapCode,MemMmuTrap,MemCacheType,MemPhysicalAddr,LOADBUFFER[InstLsuPtr][17:12],(LOADMMUSUCCESS & {3{~MemMmuTrap}}) | (LOADMMUFUALT & {3{MemMmuTrap}})} : LOADBUFFER[InstLsuPtr][59:9] ;
            STOREBUFFER[InstLsuPtr][59:9] <= (LSSignCheck & MemMmuAble) ? {MemMmuTrapCode,MemMmuTrap,MemCacheType,MemPhysicalAddr,STOREBUFFER[InstLsuPtr][17:12],(STOREMMUSUCCESS & {3{~MemMmuTrap}}) | (STOREMMUFUALT & {3{MemMmuTrap}})} : STOREBUFFER[InstLsuPtr][59:9] ;
            LOADBUFFER[LoadBackPtr][11:9] <= LoadSuccess ? LOADWRITERET : LOADBUFFER[LoadBackPtr][11:9] ;
            LOADBUFFER[RetireLoadPtr] <= RetireLoadAble ? 68'd0 : LOADBUFFER[RetireLoadPtr] ;  
        end
    end

    wire LoadWriteAble = MemMmuAble & ~LSSignCheck ;
    wire LoadInfromIn  = {LOADBUFFER[InstLsuPtr][8:1],MemMmuTrapCode,MemMmuTrap,MemCacheType,MemPhysicalAddr,InstLsuPtr};
    wire LoadFullAble ;
    wire LoadEmptrAble;
    wire [39:0]LoadPreOutDate;

    FIFOlsu#(
        .FIFOWIDE    ( 40 )
    )u_FIFOlsu(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .Rable       ( LoadAble|LoadPreOutDate[39]),
        .Dout        ( Dout        ),
        .FifoPreOut  ( LoadPreOutDate ),
        .Wable       ( LoadWriteAble  ),
        .Din         ( LoadInfromIn   ),
        .FifoClean   ( FifoClean   ),
        .FifoFull    ( LoadFullAble   ),
        .FifoEmpty   ( LoadEmptrAble  )
    );

    reg [32+1+1-1] LLAddressReg ;
    always @(posedge Clk) begin
        if(!Rest)
            LLAddressReg <= `ZeorDate ;
        else if(LoadPreOutDate == `InstLlw)
            LLAddressReg <= {`AbleValue, LoadPreOutDate[36:5],`EnableValue} ;
        else if(LLAddressReg[33] )

    end 

    //load date from Memory
    assign LoadAble = ~LoadBuzy & ~LoadEmptrAble & ~LoadPreOutDate[39];
    assign LoadAddr = LoadPreOutDate[36:5];
    assign LoadBuffPtr = LoadPreOutDate[4:0] ;
    assign LoadType = LoadPreOutDate[37:38];
    //load success write back physical regfile and ROB
    assign WriteAble = LoadSuccess ;
    assign WriteAddr = LOADBUFFER[LoadBackPtr][67:61] ;
    assign writeDate = ((LOADBUFFER[LoadBackPtr][8:1] == `InstLdb) || (LOADBUFFER[LoadBackPtr][8:1] == `InstLlw)) ?
                                                                     ((LOADBUFFER[LoadBackPtr][19:18] == 0) ? {{24{LoadDate[7]}},LoadDate[7:0]}:
                                                                     (LOADBUFFER[LoadBackPtr][19:18] == 2) ? {{24{LoadDate[15]}},LoadDate[15:8]}:
                                                                     (LOADBUFFER[LoadBackPtr][19:18] == 3) ? {{24{LoadDate[23]}},LoadDate[23:16]}: {{16{LoadDate[31]}},LoadDate[31:24]}) :
                       (LOADBUFFER[LoadBackPtr][8:1] == `InstLdh)  ? ((LOADBUFFER[LoadBackPtr][19] == 0) ? {{24{LoadDate[15]}},{LoadDate[15:0]}} : {{16{LoadDate[31]}},{LoadDate[31:16]}}) :
                       (LOADBUFFER[LoadBackPtr][8:1] == `InstLdw)  ? LoadDate :
                       (LOADBUFFER[LoadBackPtr][8:1] == `InstLdbu) ? ((LOADBUFFER[LoadBackPtr][19:18] == 0) ? {{24{1'b0}},LoadDate[7:0]}:
                                                                     (LOADBUFFER[LoadBackPtr][19:18] == 2) ? {{24{1'b0}},LoadDate[15:8]}:
                                                                     (LOADBUFFER[LoadBackPtr][19:18] == 3) ? {{24{1'b0}},LoadDate[23:16]}: {{16{1'b0}},LoadDate[31:24]}) :
                       (LOADBUFFER[LoadBackPtr][8:1] == `InstLdhu) ? ((LOADBUFFER[LoadBackPtr][19] == 0) ? {{24{1'b0}},{LoadDate[15:0]}} : {{16{1'b0}},{LoadDate[31:16]}}) :`ZeorDate ;


    assign LoadInstReady = LoadSuccess ;
    assign LoadInstPtr = LOADBUFFER[LoadBackPtr][17:12] ;
    assign LoadTrapAble = LoadTrapIn  ;
    assign LoadTrapCode = LOADBUFFER[LoadBackPtr][59:53] ;
    assign LoadBufferPtr = LoadBackPtr ;
    assign LoadTrapaddr = LOADBUFFER[LoadBackPtr][49:18] ;
    

    
endmodule  
