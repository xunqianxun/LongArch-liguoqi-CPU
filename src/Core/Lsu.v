`timescale 1ps/1ps
`include "define.v"

module Lsu (
    input         wire                                Clk             ,
    input         wire                                Rest            ,

    //load inst information
    input         wire                                LoadInstInAble         ,
    input         wire      [`ROBLineNumBus]          LoadInstROBPtr         ,
    input         wire      [`MicOperateCode]         LoadMicOperateCode     ,
    input         wire      [`DataBus]                LoadArchRegister1      , 
    input         wire      [`DataBus]                LoadArchRegister2      , //si12  
    input         wire      [`ReNameRegBUs]           LoadWriteBackAddr      ,
    //sore inst information
    input         wire                                StorInstInAble         ,
    input         wire      [`ROBLineNumBus]          StornstROBPtr          ,
    input         wire      [`MicOperateCode]         StorMicOperateCode     ,
    input         wire      [`DataBus]                StorArchRegister1      , 
    input         wire      [`DataBus]                StorArchRegister2      , //si12
    // to ROB
    output        wire                                LoadInstAble           ,
    output        wire      [4:0]                     LoadBufferPtr          , //load指令的源寄存器的重命名存储段被复义为loadbuffer的ptr
    output        wire      [7:0]                     LoadInstROBPtr         ,
    //from ROB
    //input         wire      [8*4-1:0]                 ROBForROBPrtClass      ,
    input         wire      [5*4-1:0]                 ROBForLsuPtrClass      ,
    input         wire      [4-1:0]                   ROBForLoadInvt         , //since ROB each clacy commit 6 inst
    input         wire      [4-1:0]                   ROBForStorInvt         ,
    // Load update data to ARF
    output        wire                                LoadUpDateAble         ,
    output        wire      [7:0]                     LoadUpDateAddr         ,
    output        wire      [`DataBus]                LoadUpDate             ,
    //load and store illeagl to ARF
    output        wire                                IlligalAble            ,
    output        wire      [7:0]                     IlligalAddr            ,
    output        wire      [`DataBus]                IlligalDate            ,
    //load to TLB
    output        wire                                LoadTLBAble            ,
    output        wire      [`InstAddrBus]            LoadTLBAddr            ,
    //load to DCache 
    output        wire                                LoadVindecAble         ,
    output        wire      [11:0]                    LoadVritueIndex        , //[11:10]:arry bank ; [9:3]:addr in bank ;[2] line bank; [1:0] offset ;
    output        wire      [4:0]                     LoadInstBufferPtr      ,
    //load data from Dcache
    input         wire                                DCacheInAble           ,
    input         wire      [`DataBus]                DCacheInDate           ,
    input         wire      [4:0]                     DCacheLoadBUfferPtr    ,
    
    //store to Dcache
    output        wire      [11:0]                    StorVritueIndex        
    

   

    //in from ROB


);

    // //for load and state buffer 
    // reg   [55+8:0]  LoadBuffer [1:16] ; //  [55] valid ; [54:48] micoperatecode ;[[39:8]] 其中8为指令状态，16-9 为写回地址 7：0数据地址
    // reg   [55:0]  StorBuffer [1:16] ; //

    // //********************************** load state one vritue address send to trans********************************//

    // //入buffer操作，时序逻辑下的
    // wire [4:0] FreeLineNumber ;
    // assign FreeLineNumber =  ~LoadBuffer[1][55] ? 5'd1  :
    //                          ~LoadBuffer[2][55] ? 5'd2  :
    //                          ~LoadBuffer[3][55] ? 5'd3  :
    //                          ~LoadBuffer[4][55] ? 5'd4  :
    //                          ~LoadBuffer[5][55] ? 5'd5  :
    //                          ~LoadBuffer[6][55] ? 5'd6  :
    //                          ~LoadBuffer[7][55] ? 5'd7  :
    //                          ~LoadBuffer[8][55] ? 5'd8  :
    //                          ~LoadBuffer[9][55] ? 5'd9  :
    //                          ~LoadBuffer[10][55] ? 5'd10  :
    //                          ~LoadBuffer[11][55] ? 5'd11  :
    //                          ~LoadBuffer[12][55] ? 5'd12  :
    //                          ~LoadBuffer[13][55] ? 5'd13  :
    //                          ~LoadBuffer[14][55] ? 5'd14  :
    //                          ~LoadBuffer[15][55] ? 5'd15  :
    //                          ~LoadBuffer[16][55] ? 5'd16  :
    //                          5'd0 ; // when freelinenumb == 0 mean buffer full
    // // load buffer operate

    // wire [4:0] CommitLsInst1 = ROBForLsuPtrClass[4:0];
    // wire [4:0] CommitLsInst2 = ROBForLsuPtrClass[9:5];
    // wire [4:0] CommitLsInst3 = ROBForLsuPtrClass[14:10];
    // wire [4:0] CommitLsInst4 = ROBForLsuPtrClass[19:15];

    // reg [4:0] LoopClean ;
    // always @(posedge Clk) begin
    //     if(!Rest) begin
    //         for (LoopClean = 1; LoopClean <=16 ;LoopClean = LoopClean+1 ) begin
    //             LoadBuffer[LoopClean][7:0] <= 8'd0                 ;
    //             LoadBuffer[LoopClean][47:40] <= 8'd0               ;
    //             LoadBuffer[LoopClean][54:48] <= 7'd0               ;
    //             LoadBuffer[LoopClean][55] <= `EnableValue          ;
    //             LoadBuffer[LoopClean][63:56] <= 8'd0               ;
    //         end
    //     end 
    //     else begin
    //         if(LoadInstInAble && (ROBForLoadInvt != 0)) begin
    //             LoadBuffer[FreeLineNumber][7:0] <= LoadWriteBackAddr    ;
    //             LoadBuffer[FreeLineNumber][47:40] <= LoadMicOperateCode ;
    //             LoadBuffer[FreeLineNumber][54:48] <= LoadInstROBPtr     ;
    //             LoadBuffer[FreeLineNumber][55] <= `AbleValue            ; 
    //             LoadBuffer[FreeLineNumber][63:56] <=  LoadWriteBackAddr ;
    //             LoadBuffer[CommitLsInst1][55]  <= ROBForLoadInvt[0] ? `EnableValue : LoadBuffer[CommitLsInst1][55] ;
    //             LoadBuffer[CommitLsInst2][55]  <= ROBForLoadInvt[1] ? `EnableValue : LoadBuffer[CommitLsInst2][55] ;
    //             LoadBuffer[CommitLsInst3][55]  <= ROBForLoadInvt[2] ? `EnableValue : LoadBuffer[CommitLsInst3][55] ;
    //             LoadBuffer[CommitLsInst4][55]  <= ROBForLoadInvt[3] ? `EnableValue : LoadBuffer[CommitLsInst4][55] ;
    //         end
    //         else if(LoadInstInAble) begin
    //             LoadBuffer[FreeLineNumber][7:0] <= LoadWriteBackAddr    ;
    //             LoadBuffer[FreeLineNumber][47:40] <= LoadMicOperateCode ;
    //             LoadBuffer[FreeLineNumber][54:48] <= LoadInstROBPtr     ;
    //             LoadBuffer[FreeLineNumber][55] <= `AbleValue            ;
    //             LoadBuffer[FreeLineNumber][63:56] <=  LoadWriteBackAddr ;
    //         end
    //         else if (ROBForLoadInvt != 0) begin
    //             LoadBuffer[FreeLineNumber][7:0] <= LoadBuffer[FreeLineNumber][7:0]     ;
    //             LoadBuffer[FreeLineNumber][47:40] <= LoadBuffer[FreeLineNumber][47:40] ;
    //             LoadBuffer[FreeLineNumber][54:48] <= LoadBuffer[FreeLineNumber][54:48] ;
    //             LoadBuffer[FreeLineNumber][55] <= LoadBuffer[FreeLineNumber][55]       ;
    //             LoadBuffer[FreeLineNumber][63:56] <= LoadBuffer[FreeLineNumber][63:56] ;
    //             LoadBuffer[CommitLsInst1][55]  <= ROBForLoadInvt[0] ? `EnableValue : LoadBuffer[CommitLsInst1][55] ;
    //             LoadBuffer[CommitLsInst2][55]  <= ROBForLoadInvt[1] ? `EnableValue : LoadBuffer[CommitLsInst2][55] ;
    //             LoadBuffer[CommitLsInst3][55]  <= ROBForLoadInvt[2] ? `EnableValue : LoadBuffer[CommitLsInst3][55] ;
    //             LoadBuffer[CommitLsInst4][55]  <= ROBForLoadInvt[3] ? `EnableValue : LoadBuffer[CommitLsInst4][55] ;
    //         end
    //         else begin
    //             LoadBuffer[FreeLineNumber][7:0] <= LoadBuffer[FreeLineNumber][7:0]     ;
    //             LoadBuffer[FreeLineNumber][47:40] <= LoadBuffer[FreeLineNumber][47:40] ;
    //             LoadBuffer[FreeLineNumber][54:48] <= LoadBuffer[FreeLineNumber][54:48] ;
    //             LoadBuffer[FreeLineNumber][55] <= LoadBuffer[FreeLineNumber][55]       ;
    //             LoadBuffer[FreeLineNumber][63:56] <= LoadBuffer[FreeLineNumber][63:56] ;
    //         end
            
    //     end
    // end
    // //check has commit inst



    // //get load inst vritue address 
    // wire   LoadVAToPAAble                  ;
    // assign LoadVAToPAAble = LoadInstInAble ;
    // assign LoadTLBAble    = LoadVAToPAAble ;
    // wire   [`InstAddrBus] LoadVAData       ;
    // assign LoadVAData = LoadArchRegister1 + LoadArchRegister2 ;
    // assign LoadTLBAddr = LoadVAData        ;
    // //to dcache 
    // wire   LoadDcacheAble;
    // assign LoadDcacheAble = LoadInstInAble ;
    // assign LoadVindecAble = LoadDcacheAble ;
    // wire   [11:0] SerchCacheAddr ;
    // assign SerchCacheAddr = LoadVAData[11:0] ;
    // assign LoadVritueIndex = SerchCacheAddr ;
    // assign LoadInstBufferPtr = FreeLineNumber ;

    // //************* get load data from cache and write in buffer and send ready to ROB******************//
    // reg [4:0] LoopDisable       ;
    // reg       RegLoadInstAble   ;
    // reg [4:0] RegLoadBufferPtr  ;
    // reg [7:0] RegLoadInstROBPtr ;

    // always @(posedge Clk) begin
    //     if(!Rest)begin
    //         for (LoopDisable = 1; LoopDisable <=16 ;LoopDisable = LoopDisable+1 ) begin
    //            LoadBuffer[LoopDisable][39:8] <= `ZeorDate               ;
    //            RegLoadInstAble <= `EnableValue                          ;
    //            RegLoadBufferPtr <= 5'd0                                 ;
    //            RegLoadInstROBPtr <= 8'd0                                ;
    //         end
    //     end
    //     else begin
    //         if(DCacheInAble) begin
    //            LoadBuffer[DCacheLoadBUfferPtr][39:8] <= DCacheInDate    ;
    //            RegLoadInstAble <= `AbleValue                            ;
    //            RegLoadBufferPtr <= DCacheLoadBUfferPtr                  ;
    //            RegLoadInstROBPtr <= LoadBuffer[DCacheLoadBUfferPtr][54:48];
    //         end
    //         else begin
    //            LoadBuffer[DCacheLoadBUfferPtr][39:8] <= LoadBuffer[DCacheLoadBUfferPtr][39:8] ; 
    //            RegLoadInstAble <= `EnableValue                          ;
    //            RegLoadBufferPtr <= 5'd0                                 ; 
    //            RegLoadInstROBPtr <= 8'd0                                ;
    //         end
            
    //     end
    // end
    // assign LoadInstAble   = RegLoadInstAble   ;
    // assign LoadBufferPtr  = RegLoadBufferPtr  ;
    // assign LoadInstROBPtr = RegLoadInstROBPtr ;

    // //************************ ROB commit and update load write back data to ARF*****************************//
    // //enable about inst buffer has operate in buffer operate cube
    // reg           RegLoadUpDateAble     ;
    // reg [7:0]     RegLoadUpDateAddr     ;
    // reg [`DataBus] RegLoadUpDate        ;
    // always @(posedge Clk) begin
    //     if(!Rest) begin
            
    //     end
    //     else begin
    //         if(ROBForLoadInvt != 0) begin
    //             RegLoadUpDateAble <=  ROBForLoadInvt ;
    //         end
    //     end
    // end

    localparam IDLE    = 3'b001 ;
    //localparam WRIT = 3'b010  ;
    localparam LOADING = 3'b010 ;
    localparam LOADOK  = 3'b011 ;

    //load queue
    reg  [3:0]   LoadQueuePtr ;
    reg  [3:0]   LoadQUeueEnd ;

    reg  [58:0]  LoadQueue [0:15];

    // in queue
    reg  [4:0] LoopRest ;
    always @(posedge CLk) begin
        if(!Rest) begin
            LoadQueuePtr <= 4'd0  ;
            for (LoopRest = 0; LoopRest < 16; LoopRest = LoopRest + 1) begin
                LoadQueue[LoopRest] <= 59'b0 ;
            end
        end
        else begin
            if(LoadInstInAble) begin
                LoadQueue[LoadQueuePtr] <= {1'b1, LoadMicOperateCode, LoadArchRegister1+LoadArchRegister2, LoadWriteBackAddr, IDLE} ;
                if(LoadQueuePtr == 4'd15) 
                    LoadQueuePtr <= 4'd0 ;
                else 
                    LoadQueuePtr <= LoadQueuePtr + 1 ;
            end
            else begin
                
            end
            
        end
    end



    
endmodule
 