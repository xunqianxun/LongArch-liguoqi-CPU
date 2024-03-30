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
    output     wire                               LoadStop       ,
    output     wire                               StoreStop      ,
    //to ROB
    output     wire                               LoadInstReady    ,
    output     wire                               StoreInstReady   ,
    output     wire      [5:0]                    LoadInstPtr      ,
    output     wire      [5:0]                    StoreInstPtr     ,
    output     wire      [15:0]                   LoadReDirectable ,
    output     wire      [95:0]                   LoadReDirectPtr  ,
    output     wire                               LoadTrapAble     ,
    output     wire                               StoreTrapAble    ,
    output     wire      [7:0]                    LoadTrapCode     ,
    output     wire      [7:0]                    StoreTrapCode    ,
    output     wire      [4:0]                    LoadBufferPtr  ,
    output     wire      [4:0]                    StoreBufferPtr ,
    output     wire      [`InstAddrBus]           LoadTrapaddr   ,
    output     wire      [`InstAddrBus]           StoreTrapaddr  ,
    //from ROB
    input      wire                               RetireLoadAble1 , //为了减少违例检查的复杂度每个周期只会提交一个load或者store指令
    input      wire                               RetireLoadAble2 ,
    input      wire                               RetireLoadAble3 ,
    input      wire                               RetireLoadAble4 ,
    input      wire      [1:0]                    RetireStoreAble1, //10 write 01 delete
    input      wire      [1:0]                    RetireStoreAble2,
    input      wire      [1:0]                    RetireStoreAble3,
    input      wire      [1:0]                    RetireStoreAble4,
    input      wire      [4:0]                    RetireLoadPtr1  ,
    input      wire      [4:0]                    RetireLoadPtr2  ,
    input      wire      [4:0]                    RetireLoadPtr3  ,
    input      wire      [4:0]                    RetireLoadPtr4  ,
    input      wire      [4:0]                    RetireStorePtr1 ,
    input      wire      [4:0]                    RetireStorePtr2 ,
    input      wire      [4:0]                    RetireStorePtr3 ,
    input      wire      [4:0]                    RetireStorePtr4 ,
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
    input      wire      [`InstAddrBus]           MemPhysicalAddr, //如果发生中断此处就是发生中断的虚拟地址
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
    output     wire      [`DataBus]               StoreMask      ,
    input      wire                               LoadSuccess    ,
    input      wire      [`DataBus]               LoadInDate     ,
    input      wire      [4:0]                    LoadBackPtr    ,
    input      wire                               LoadBuzy       ,
    input      wire                               StoreBuzy      ,
    input      wire                               LoadTrapIn     ,
    //input      wire                               StoreTrapIn    ,
    input      wire                               DcacheFreeAll  ,
    //for ctrl
    input      wire                               LsuStop        ,
    input      wire                               LsuFLash       ,
    output     wire                               ReDirectLs 
); 
//******************************************************************// 
//TODOlist
//明天工作，处理删障指令，以及原子指令还有cacap，目前基本上乱序基本访存指令ok.原子指令和删障指令计划在ROB 里完成，还有一点就是在RS中增加一些特殊信号给lsu将删障和和直接映射的cocap跳过mmu
//*****************************************************************//

    reg   [67:0]     LOADBUFFER  [1:16] ; //define 0 bit as valid sign 
    reg   [91:0]     STOREBUFFER [1:16] ;

    //in inst send it to mmu trans addr
    assign MemAble = LSInstAble ;
    assign LoadStoreC = LoadOrStreInst ;
    assign InstLsuPtr = LoadOrStreInst ? StoreBufferIndex : LoadBufferIndex ;
    assign MemVritualAddr =  ArchRegDate0 + ArchRegDate1 ;

    //alloca free buffer enty
    wire [4:0] LoadBufferIndex = LOADBUFFER[1][0] ? 5'd1 :
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
    wire [4:0] StoreBufferIndex= STOREBUFFER[1][0] ? 5'd1 :
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

    wire LoadStop = (LoadBufferIndex == 5'd0) ;
    wire StoreStop = (StoreBufferIndex == 5'd0) ;

    localparam LOADINBUFFER       = 3'b001 ;
    localparam LOADMMUSUCCESS     = 3'b010 ;
    localparam LOADMMUFUALT       = 3'b011 ;
    localparam LOADWRITERET       = 3'b100 ; //weit retire

    localparam STOREINBUFFER      = 3'b001 ;
    localparam STOREMMUSUCCESS    = 3'b010 ;
    localparam STOREMMUFUALT      = 3'b011 ;
    localparam STOREREADYRET      = 3'b100 ;
    localparam STOREWWCACHE       = 3'b101 ; //weit write cache

    //关于store buffer有很大的问题就是写后写可能会同时存在在sotebuffer中，那么在load serch时因为不是fifo所以无法确定先后，所以只能在最新指令从rob回到的时候就要serch把旧同地址待写入buffer enty delete

    wire  Stoe1DeleteNum[1:16] ;
    wire  Stoe2DeleteNum[1:16] ;
    wire  Stoe3DeleteNum[1:16] ;
    wire  Stoe4DeleteNum[1:16] ;
    
    genvar j ;
    generate
        for ( j= 1;j<17 ;j=j+1 ) begin
            assign Stoe1DeleteNum[j] = (STOREBUFFER[RetireStorePtr1][81:50] == STOREBUFFER[j][81:50])&&(STOREBUFFER[j][11:9] == STOREWWCACHE) ;
            assign Stoe2DeleteNum[j] = (STOREBUFFER[RetireStorePtr2][81:50] == STOREBUFFER[j][81:50])&&(STOREBUFFER[j][11:9] == STOREWWCACHE) ;
            assign Stoe3DeleteNum[j] = (STOREBUFFER[RetireStorePtr3][81:50] == STOREBUFFER[j][81:50])&&(STOREBUFFER[j][11:9] == STOREWWCACHE) ;
            assign Stoe4DeleteNum[j] = (STOREBUFFER[RetireStorePtr4][81:50] == STOREBUFFER[j][81:50])&&(STOREBUFFER[j][11:9] == STOREWWCACHE) ;
        end
    endgenerate

    wire [16:1] Store1ReDirect ;
    wire [16:1] Store2ReDirect ;
    wire [16:1] Store3ReDirect ;
    wire [16:1] Store4ReDirect ;

    genvar a ;
    generate
        for (a =1 ;a < 17 ;a=a+1 ) begin
            assign Store1ReDirect[a] = (STOREBUFFER[RetireStorePtr1][81:50] == LOADBUFFER[a][49:18]) && (RetireStoreAble1 == 2'b10) && (LOADBUFFER[a][11:9] == LOADWRITERET) ;
            assign Store2ReDirect[a] = (STOREBUFFER[RetireStorePtr1][81:50] == LOADBUFFER[a][49:18]) && (RetireStoreAble1 == 2'b10) && (LOADBUFFER[a][11:9] == LOADWRITERET) ;
            assign Store3ReDirect[a] = (STOREBUFFER[RetireStorePtr1][81:50] == LOADBUFFER[a][49:18]) && (RetireStoreAble1 == 2'b10) && (LOADBUFFER[a][11:9] == LOADWRITERET) ;
            assign Store4ReDirect[a] = (STOREBUFFER[RetireStorePtr1][81:50] == LOADBUFFER[a][49:18]) && (RetireStoreAble1 == 2'b10) && (LOADBUFFER[a][11:9] == LOADWRITERET) ;
        end
    endgenerate

    assign LoadReDirectable = Store1ReDirect | Store2ReDirect | Store3ReDirect | Store4ReDirect ;
    assign LoadReDirectPtr = {LOADBUFFER[16][17:12],
                              LOADBUFFER[15][17:12],
                              LOADBUFFER[14][17:12],
                              LOADBUFFER[13][17:12],
                              LOADBUFFER[12][17:12],
                              LOADBUFFER[11][17:12],
                              LOADBUFFER[10][17:12],
                              LOADBUFFER[9][17:12],
                              LOADBUFFER[8][17:12],
                              LOADBUFFER[7][17:12],
                              LOADBUFFER[6][17:12],
                              LOADBUFFER[5][17:12],
                              LOADBUFFER[4][17:12],
                              LOADBUFFER[3][17:12],
                              LOADBUFFER[2][17:12],
                              LOADBUFFER[1][17:12]};

    integer i ;
    always @(posedge Clk) begin
        if(!Rest) begin
            for(i =1 ;i <=16 ; i=i+1 ) begin
                LOADBUFFER[i] <= 68'd0 ;
                STOREBUFFER[i] <= 92'd0 ;
            end
        end
        else begin
            LOADBUFFER[LoadBufferIndex][17:0] <= (LSInstAble & ~LoadOrStreInst) ? {LsInstRobPtr,LOADINBUFFER,LsMicOPercode,`AbleValue} : LOADBUFFER[LoadBufferIndex][11:0] ;
            STOREBUFFER[StoreBufferIndex][49:0] <= (LSInstAble & LoadOrStreInst) ? {ArchRegDate0,LsInstRobPtr,STOREINBUFFER,LsMicOPercode,`AbleValue} : STOREBUFFER[StoreBufferIndex][49:0] ;
            LOADBUFFER[InstLsuPtr][59:9]  <= (~LSSignCheck & MemMmuAble) ? {WritBackAddr,WritBackAble,MemMmuTrapCode,MemMmuTrap,MemCacheType,MemPhysicalAddr,LOADBUFFER[InstLsuPtr][17:12],(LOADMMUSUCCESS & {3{~MemMmuTrap}}) | (LOADMMUFUALT & {3{MemMmuTrap}})} : LOADBUFFER[InstLsuPtr][59:9] ;
            STOREBUFFER[InstLsuPtr][91:9] <= (LSSignCheck & MemMmuAble) ? {MemMmuTrapCode,MemMmuTrap,MemCacheType,MemPhysicalAddr,STOREBUFFER[InstLsuPtr][17:12],STOREBUFFER[InstLsuPtr][49:18],(STOREMMUSUCCESS & {3{~MemMmuTrap}}) | (STOREMMUFUALT & {3{MemMmuTrap}})} : STOREBUFFER[InstLsuPtr][91:9] ;
            LOADBUFFER[LoadBackPtr][11:9] <= LoadSuccess ? LOADWRITERET : LOADBUFFER[LoadBackPtr][11:9] ;
            LOADBUFFER[RetireLoadPtr] <= RetireLoadAble ? 68'd0 : LOADBUFFER[RetireLoadPtr] ;  
            STOREBUFFER[RetireStorePtr1] <= (RetireStoreAble1 == 2'b10) ? {STOREBUFFER[RetireStorePtr1][91:12],STOREWWCACHE,STOREBUFFER[RetireStorePtr1][8:0]} : 
                                            (RetireStoreAble1 == 2'b01) ? 92'd0 : STOREBUFFER[RetireStorePtr1];
            STOREBUFFER[RetireStorePtr2] <= (RetireStoreAble2 == 2'b10) ? {STOREBUFFER[RetireStorePtr2][91:12],STOREWWCACHE,STOREBUFFER[RetireStorePtr2][8:0]} : 
                                            (RetireStoreAble2 == 2'b01) ? 92'd0 : STOREBUFFER[RetireStorePtr2];
            STOREBUFFER[RetireStorePtr3] <= (RetireStoreAble3 == 2'b10) ? {STOREBUFFER[RetireStorePtr3][91:12],STOREWWCACHE,STOREBUFFER[RetireStorePtr3][8:0]} : 
                                            (RetireStoreAble3 == 2'b01) ? 92'd0 : STOREBUFFER[RetireStorePtr3];
            STOREBUFFER[RetireStorePtr4] <= (RetireStoreAble4 == 2'b10) ? {STOREBUFFER[RetireStorePtr4][91:12],STOREWWCACHE,STOREBUFFER[RetireStorePtr4][8:0]} : 
                                            (RetireStoreAble4 == 2'b01) ? 92'd0 : STOREBUFFER[RetireStorePtr4];
            STOREBUFFER[1] <= (Stoe1DeleteNum[1]|Stoe2DeleteNum[1]|Stoe3DeleteNum[1]|Stoe4DeleteNum[1]) ? 92'd0 : STOREBUFFER[1] ;
            STOREBUFFER[2] <= (Stoe1DeleteNum[2]|Stoe2DeleteNum[2]|Stoe3DeleteNum[2]|Stoe4DeleteNum[2]) ? 92'd0 : STOREBUFFER[2] ;
            STOREBUFFER[3] <= (Stoe1DeleteNum[3]|Stoe2DeleteNum[3]|Stoe3DeleteNum[3]|Stoe4DeleteNum[3]) ? 92'd0 : STOREBUFFER[3] ;
            STOREBUFFER[4] <= (Stoe1DeleteNum[4]|Stoe2DeleteNum[4]|Stoe3DeleteNum[4]|Stoe4DeleteNum[4]) ? 92'd0 : STOREBUFFER[4] ;
            STOREBUFFER[5] <= (Stoe1DeleteNum[5]|Stoe2DeleteNum[5]|Stoe3DeleteNum[5]|Stoe4DeleteNum[5]) ? 92'd0 : STOREBUFFER[5] ;
            STOREBUFFER[6] <= (Stoe1DeleteNum[6]|Stoe2DeleteNum[6]|Stoe3DeleteNum[6]|Stoe4DeleteNum[6]) ? 92'd0 : STOREBUFFER[6] ;
            STOREBUFFER[7] <= (Stoe1DeleteNum[7]|Stoe2DeleteNum[7]|Stoe3DeleteNum[7]|Stoe4DeleteNum[7]) ? 92'd0 : STOREBUFFER[7] ;
            STOREBUFFER[8] <= (Stoe1DeleteNum[8]|Stoe2DeleteNum[8]|Stoe3DeleteNum[8]|Stoe4DeleteNum[8]) ? 92'd0 : STOREBUFFER[8] ;
            STOREBUFFER[9] <= (Stoe1DeleteNum[9]|Stoe2DeleteNum[9]|Stoe3DeleteNum[9]|Stoe4DeleteNum[9]) ? 92'd0 : STOREBUFFER[9] ;
            STOREBUFFER[10] <= (Stoe1DeleteNum[10]|Stoe2DeleteNum[10]|Stoe3DeleteNum[10]|Stoe4DeleteNum[10]) ? 92'd0 : STOREBUFFER[10] ;
            STOREBUFFER[11] <= (Stoe1DeleteNum[11]|Stoe2DeleteNum[11]|Stoe3DeleteNum[11]|Stoe4DeleteNum[11]) ? 92'd0 : STOREBUFFER[11] ;
            STOREBUFFER[12] <= (Stoe1DeleteNum[12]|Stoe2DeleteNum[12]|Stoe3DeleteNum[12]|Stoe4DeleteNum[12]) ? 92'd0 : STOREBUFFER[12] ;
            STOREBUFFER[13] <= (Stoe1DeleteNum[13]|Stoe2DeleteNum[13]|Stoe3DeleteNum[13]|Stoe4DeleteNum[13]) ? 92'd0 : STOREBUFFER[13] ;
            STOREBUFFER[14] <= (Stoe1DeleteNum[14]|Stoe2DeleteNum[14]|Stoe3DeleteNum[14]|Stoe4DeleteNum[14]) ? 92'd0 : STOREBUFFER[14] ;
            STOREBUFFER[15] <= (Stoe1DeleteNum[15]|Stoe2DeleteNum[15]|Stoe3DeleteNum[15]|Stoe4DeleteNum[15]) ? 92'd0 : STOREBUFFER[15] ;
            STOREBUFFER[16] <= (Stoe1DeleteNum[16]|Stoe2DeleteNum[16]|Stoe3DeleteNum[16]|Stoe4DeleteNum[16]) ? 92'd0 : STOREBUFFER[16] ;
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



    //load date from Memory
    assign LoadAble = ~LoadBuzy & ~LoadEmptrAble & ~LoadPreOutDate[39];
    assign LoadAddr = LoadPreOutDate[36:5];
    assign LoadBuffPtr = LoadPreOutDate[4:0] ;
    assign LoadType = LoadPreOutDate[37:38];

    wire [20:1] SameAddrNum ;
    genvar b ;
    generate
        for (b =0 ;b<17 ;b=b+1 ) begin
            assign SameAddrNum[b] = ((LoadAddr == STOREBUFFER[1][81:50]) && (STOREBUFFER[1][11:0] == STOREWWCACHE)) ;
        end
    endgenerate
    assign SameAddrNum[17] = ((LoadAddr == STOREBUFFER[RetireLoadPtr1][81:50]) && (RetireStoreAble1 == 2'b10)) ;
    assign SameAddrNum[18] = ((LoadAddr == STOREBUFFER[RetireLoadPtr2][81:50]) && (RetireStoreAble2 == 2'b10)) ;
    assign SameAddrNum[19] = ((LoadAddr == STOREBUFFER[RetireLoadPtr3][81:50]) && (RetireStoreAble3 == 2'b10)) ;
    assign SameAddrNum[20] = ((LoadAddr == STOREBUFFER[RetireLoadPtr4][81:50]) && (RetireStoreAble4 == 2'b10)) ;



    reg              StoreRelatedAble;
    reg  [`DataBus]  StoreBufferDate ;
    always @(posedge Clk) begin
        if(!Rest) begin
            StoreRelatedAble <= `EnableValue ;
            StoreBufferDate <= `ZeorDate ;
        end
        else begin
            if((SameAddrNum[16:1] != 16'd0) & LoadAble) begin
                StoreRelatedAble <= `AbleValue ;
                StoreBufferDate <= ({32{SameAddrNum[1]}}&STOREBUFFER[1][49:18] | 
                                    {32{SameAddrNum[2]}}&STOREBUFFER[2][49:18] |
                                    {32{SameAddrNum[3]}}&STOREBUFFER[3][49:18] |
                                    {32{SameAddrNum[4]}}&STOREBUFFER[4][49:18] | 
                                    {32{SameAddrNum[5]}}&STOREBUFFER[5][49:18] |
                                    {32{SameAddrNum[6]}}&STOREBUFFER[6][49:18] |
                                    {32{SameAddrNum[7]}}&STOREBUFFER[7][49:18] |
                                    {32{SameAddrNum[8]}}&STOREBUFFER[8][49:18] |
                                    {32{SameAddrNum[9]}}&STOREBUFFER[9][49:18] |
                                    {32{SameAddrNum[10]}}&STOREBUFFER[10][49:18] |
                                    {32{SameAddrNum[11]}}&STOREBUFFER[11][49:18] |
                                    {32{SameAddrNum[12]}}&STOREBUFFER[12][49:18] |
                                    {32{SameAddrNum[13]}}&STOREBUFFER[13][49:18] |
                                    {32{SameAddrNum[14]}}&STOREBUFFER[14][49:18] |
                                    {32{SameAddrNum[15]}}&STOREBUFFER[15][49:18] |
                                    {32{SameAddrNum[16]}}&STOREBUFFER[16][49:18] );
            end
            if((SameAddrNum[20:17] != 4'd0) & LoadAble) begin
                StoreRelatedAble <= `AbleValue ;
                StoreBufferDate <= ({32{SameAddrNum[17]}}&STOREBUFFER[RetireStorePtr1][49:18] |
                                    {32{SameAddrNum[18]}}&STOREBUFFER[RetireStorePtr2][49:18] |
                                    {32{SameAddrNum[19]}}&STOREBUFFER[RetireStorePtr3][49:18] |
                                    {32{SameAddrNum[20]}}&STOREBUFFER[RetireStorePtr4][49:18] );
            end
            if(LoadSuccess)begin
                StoreRelatedAble <= `EnableValue ;
                StoreBufferDate <= `ZeorDate ;
            end
        end
    end

    wire [`DataBus] LoadDate = StoreRelatedAble ? StoreBufferDate : LoadInDate ;

    //load success write back physical regfile and ROB
    assign WriteAble = LoadSuccess ;
    assign WriteAddr = LOADBUFFER[LoadBackPtr][67:61] ;
    assign writeDate = (LOADBUFFER[LoadBackPtr][8:1] == `InstLdb) ?  ((LOADBUFFER[LoadBackPtr][19:18] == 0) ? {{24{LoadDate[7]}},LoadDate[7:0]}:
                                                                     (LOADBUFFER[LoadBackPtr][19:18] == 2) ? {{24{LoadDate[15]}},LoadDate[15:8]}:
                                                                     (LOADBUFFER[LoadBackPtr][19:18] == 3) ? {{24{LoadDate[23]}},LoadDate[23:16]}: {{16{LoadDate[31]}},LoadDate[31:24]}) :
                       (LOADBUFFER[LoadBackPtr][8:1] == `InstLdh)  ? ((LOADBUFFER[LoadBackPtr][19] == 0) ? {{24{LoadDate[15]}},{LoadDate[15:0]}} : {{16{LoadDate[31]}},{LoadDate[31:16]}}) :
                       ((LOADBUFFER[LoadBackPtr][8:1] == `InstLdw) || (LOADBUFFER[LoadBackPtr][8:1] == `InstLlw)) ? LoadDate :
                       (LOADBUFFER[LoadBackPtr][8:1] == `InstLdbu) ? ((LOADBUFFER[LoadBackPtr][19:18] == 0) ? {{24{1'b0}},LoadDate[7:0]}:
                                                                     (LOADBUFFER[LoadBackPtr][19:18] == 2) ? {{24{1'b0}},LoadDate[15:8]}:
                                                                     (LOADBUFFER[LoadBackPtr][19:18] == 3) ? {{24{1'b0}},LoadDate[23:16]}: {{16{1'b0}},LoadDate[31:24]}) :
                       (LOADBUFFER[LoadBackPtr][8:1] == `InstLdhu) ? ((LOADBUFFER[LoadBackPtr][19] == 0) ? {{24{1'b0}},{LoadDate[15:0]}} : {{16{1'b0}},{LoadDate[31:16]}}) :`ZeorDate ;


    // write csr
    reg [31:0] LLAddressReg ;
    always @(posedge Clk) begin
        if(!Rest)
            LLAddressReg <= `ZeorDate ;
        else if(LoadPreOutDate == `InstLlw)
            LLAddressReg <= WriteAddr ;
        else if(LLAddressReg[33] )

    end 
    assign WriteCsrAble = (LOADBUFFER[LoadBackPtr][8:1] == `InstLlw) ;
    assign WriteCsrMask = ;
    assign WriteCsrDate = ;


    assign LoadInstReady = LoadSuccess ;
    assign LoadInstPtr = LOADBUFFER[LoadBackPtr][17:12] ;
    assign LoadTrapAble = LoadTrapIn  ;
    assign LoadTrapCode = LOADBUFFER[LoadBackPtr][59:53] ;
    assign LoadBufferPtr = LoadBackPtr ;
    assign LoadTrapaddr = LOADBUFFER[LoadBackPtr][49:18] ;

    //store to rob
    assign StoreInstReady = MemMmuAble ;
    assign StoreInstPtr   = STOREBUFFER[InstLsuPtr][17:12];
    assign StoreTrapAble  = STOREBUFFER[InstLsuPtr][84];
    assign StoreTrapCode  = STOREBUFFER[InstLsuPtr][91:85];
    assign StoreBufferPtr = InstLsuPtr ;
    assign StoreTrapaddr  = STOREBUFFER[InstLsuPtr][81:50];

    //wirte to cache 
    wire [4:0] WriteIndex = (STOREBUFFER[1][11:9] == STOREWWCACHE) ? 5'd1 :
                              (STOREBUFFER[2][11:9] == STOREWWCACHE) ? 5'd2 :
                              (STOREBUFFER[3][11:9] == STOREWWCACHE) ? 5'd3 :
                              (STOREBUFFER[4][11:9] == STOREWWCACHE) ? 5'd4 :
                              (STOREBUFFER[5][11:9] == STOREWWCACHE) ? 5'd5 :
                              (STOREBUFFER[6][11:9] == STOREWWCACHE) ? 5'd6 :
                              (STOREBUFFER[7][11:9] == STOREWWCACHE) ? 5'd7 :
                              (STOREBUFFER[8][11:9] == STOREWWCACHE) ? 5'd8 :
                              (STOREBUFFER[9][11:9] == STOREWWCACHE) ? 5'd9 :
                              (STOREBUFFER[10][11:9] == STOREWWCACHE) ? 5'd10:
                              (STOREBUFFER[11][11:9] == STOREWWCACHE) ? 5'd11:
                              (STOREBUFFER[12][11:9] == STOREWWCACHE) ? 5'd12:
                              (STOREBUFFER[13][11:9] == STOREWWCACHE) ? 5'd13:
                              (STOREBUFFER[14][11:9] == STOREWWCACHE) ? 5'd14:
                              (STOREBUFFER[15][11:9] == STOREWWCACHE) ? 5'd15:
                              (STOREBUFFER[16][11:9] == STOREWWCACHE) ? 5'd16:5'd0 ;

    assign StoreAble = (WriteIndex != 5'd0) & ~StoreBuzy ;
    assign StoreType = STOREBUFFER[WriteIndex][83:82] ;
    assign StoreAddr = STOREBUFFER[WriteIndex][81:50] ;
    assign StoreDate = STOREBUFFER[WriteIndex][49:18] ;
    assign StoreMask = (STOREBUFFER[WriteIndex][8:1] == `InstCacop) ? 32'h00000000 :
                       (STOREBUFFER[WriteIndex][8:1] == `InstStb)   ? 32'h000000ff :
                       (STOREBUFFER[WriteIndex][8:1] == `InstSth)   ? 32'h0000ffff :
                       (STOREBUFFER[WriteIndex][8:1] == `InstScw)   ? 32'hffffffff : //这个的处理是在ROB 中进行的

    
    


    

    
endmodule  
