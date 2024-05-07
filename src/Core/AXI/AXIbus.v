`timescale 1ps/1ps
`include "../define.v"

module AXIbus (  
    input       wire                       Clk         ,
    input       wire                       Rest        ,  
    //to cache 
    output      wire                       CacReadfree ,
    output      wire                       CacWritefree,
    output      wire                       ReadBackAble,
    output      wire     [511:0]           ReadBackDate,
    output      wire                       WritBAckAble,
    //for ICache
    input       wire                       IcaReadAble ,
    output      wire                       IRshankhand ,
    input       wire                       IUncacheRead,
    input       wire     [`InstAddrBus]    IcaReadAddr ,
    //for Dcache
    input       wire                       DcaWriteAble,
    output      wire                       DWshankhand , //与uncache 共用
    input       wire                       DWriteUncache,
    input       wire     [3:0]             UncacheStrb , //uncache 时只可能是len为1的时候
    input       wire     [`InstAddrBus]    DcaWriteAddr,
    input       wire     [255:0]           DcaWDate    ,
    input       wire                       DcaReadAble ,
    output      wire                       DRshankhand ,
    input       wire                       DUnacheRead ,
    input       wire     [`InstAddrBus]    DcaReadAddr ,
    // read request
    output      wire     [ 3:0]            Arid        ,
    output      wire     [31:0]            Araddr      ,
    output      wire     [ 7:0]            Arlen       ,
    output      wire     [ 2:0]            Arsize      ,
    output      wire     [ 1:0]            Arburst     ,
    output      wire     [ 1:0]            Arlock      ,
    output      wire     [ 3:0]            Arcache     ,
    output      wire     [ 2:0]            Arprot      ,
    output      wire                       Arvalid     ,
    input       wire                       Arready     ,
    //read back
    input       wire     [ 3:0]            Rid         ,
    input       wire     [31:0]            Rdata       ,
    input       wire     [ 1:0]            Rresp       ,
    input       wire                       Rlast       ,
    input       wire                       Rvalid      ,
    output      wire                       Rready      ,
    //write request
    output      wire     [ 3:0]            Awid        ,
    output      wire     [31:0]            Awaddr      ,
    output      wire     [ 7:0]            Awlen       ,
    output      wire     [ 2:0]            Awsize      ,
    output      wire     [ 1:0]            Awburst     ,
    output      wire     [ 1:0]            Awlock      ,
    output      wire     [ 3:0]            Awcache     ,
    output      wire     [ 2:0]            Awprot      ,
    output      wire                       Awvalid     ,
    input       wire                       Awready     ,  
    //write data
    output      wire     [ 3:0]            Wid         ,
    output      wire     [31:0]            Wdata       ,
    output      wire     [ 3:0]            Wstrb       ,
    output      wire                       Wlast       ,
    output      wire                       Wvalid      ,
    input       wire                       Wready      ,
    //write back
    input       wire     [ 3:0]            Bid         ,
    input       wire     [ 1:0]            Bresp       ,
    input       wire                       Bvalid      ,
    output      wire                       Bready      

);

    // Icache Dcache ICache frist 
    // cahce and uncache won't come together 
    localparam IDLE   = 3'b000 ;
    localparam RADDRC = 3'b001 ;
    localparam RDATEC = 3'b010 ;
    // localparam WADDRC = 3'b011 ;
    // localparam WDATEC = 3'b100 ;
    // localparam WRESPC = 3'b101 ;

    reg   [2:0]  ReadState     ;
    wire  [2:0]  NextReadState ;
    always @(posedge Clk) begin
        if(!Rest)
            ReadState <= IDLE ;
        else 
            ReadState <= NextReadState ;
    end

    assign  Arvalid = (IcaReadAble | IUncacheRead | DcaReadAble | DUnacheRead) ;
    assign  Araddr  = (IcaReadAble | IUncacheRead) ? IcaReadAddr : 
                      (DcaReadAble | DUnacheRead)  ? DcaReadAddr: 32'd0 ;

    assign  Arlen   = IUncacheRead ? 8'd1 :
                      IcaReadAble  ? 8'd8 : 
                      DUnacheRead  ? 8'd1 : 
                      DcaReadAble  ? 8'd4 : 8'd0 ;

    wire  [1:0] AlowSIgn =  (IcaReadAble | IUncacheRead) ? 2'b01 :
                            (DcaReadAble | DUnacheRead)  ? 2'b10 : 2'b00 ;

    assign  Arid    = 4'd1   ; 
    assign  Arsize  = 3'b010 ;
    assign  Arburst = 2'b01  ;
    assign  Arlock  = 2'b0   ;
    assign  Arcache = 4'b0   ;
    assign  Arprot  = 3'b0   ;

    assign IRshankhand = (AlowSIgn == 2'b01) & Arready ;
    assign DRshankhand = (AlowSIgn == 2'b10) & Arready ;

    //for R date ready 
    reg     RreadyTemp ;
    always @(posedge Clk) begin
        if(!Rest) 
            RreadyTemp <= `EnableValue ;
        else begin
            if(IRshankhand | DRshankhand)
                RreadyTemp <= `AbleValue ;
            if(Rlast & (Rresp == 2'b00) & (Rid == 4'd1))
                RreadyTemp <= `EnableValue ;
        end 
    end

    assign Rready = RreadyTemp | IRshankhand | DRshankhand ;

    integer i ;
    reg [31:0] ReadDateTemp[1:16] ;
    reg [5:0]   ReadCont     ;
    always @(posedge Clk) begin
        if(!Rest) begin
            for (i =0 ;i<16 ;i=i+1 ) begin
                ReadDateTemp[i] <= 32'd0 ;
            end
            ReadCont     <= 6'd1   ;
        end 
        else begin
            if(Rready) begin
                if(Rvalid) begin
                    ReadDateTemp[ReadCont[4:0]] <= Rdata ;
                    ReadCont <= ReadCont + 1 ;
                end
                else begin
                    for (i =0 ;i<=16 ;i=i+1 ) begin
                        ReadDateTemp[i] <= ReadDateTemp[i] ;
                    end
                    ReadCont <= ReadCont ;
                end
            end
            else begin
                for (i =0 ;i<16 ;i=i+1 ) begin
                    ReadDateTemp[i] <= 32'd0 ;
                end
                ReadCont     <= 6'd1   ;
            end     
        end 
    end 

    assign ReadBackAble = (Rlast & (Rresp == 2'b00) & (Rid == 4'd1)) ;
    assign ReadBackDate = {ReadDateTemp[16],ReadDateTemp[15],ReadDateTemp[14],ReadDateTemp[13],
                           ReadDateTemp[12],ReadDateTemp[11],ReadDateTemp[10],ReadDateTemp[9],
                           ReadDateTemp[8],ReadDateTemp[7],ReadDateTemp[6],ReadDateTemp[5],
                           ReadDateTemp[4],ReadDateTemp[3],ReadDateTemp[2],ReadDateTemp[1]} ;

    //assign CacReadfree = (ReadState == IDLE); //cache中发射数据需要打一个拍，避免组合逻辑环 ;

    assign NextReadState = Arvalid ? RADDRC : 
                           Rready  ? RDATEC : IDLE ;

    reg RegReadFree ;
    always @(posedge Clk) begin
        if(!Rest) 
           RegReadFree <= `EnableValue ; 
        else if(IRshankhand | DRshankhand) 
           RegReadFree <= `AbleValue ;
        else if(Rlast & (Rresp == 2'b00) & (Rid == 4'd1))
           RegReadFree <= `EnableValue ; 
    end        

    assign   CacReadfree = RegReadFree  ;  

    //for write 
    
    // reg   [2:0]  WriteState     ;
    // wire  [2:0]  NextWriteState ;
    // always @(posedge Clk) begin
    //     if(!Rest)
    //         WriteState <= IDLE ;
    //     else 
    //         WriteState <= NextWriteState ;
    // end

    assign Awvalid = DcaWriteAble | DWriteUncache ;
    assign Awaddr  = DcaWriteAddr ;
    assign Awlen   = DcaWriteAble  ? 8'd4 : 
                     DWriteUncache ? 8'd1 : 8'd0 ;
    assign Awid    = 4'd1   ;
    assign Awsize  = 3'b010 ;
    assign Awburst = 2'b01  ;
    assign Awlock  = 2'b0   ;
    assign Awcache = 4'b0   ;
    assign Awprot  = 3'b0   ;

    reg [7:0]   WriteLenTemp ;
    reg [3:0]   WriteStrbTemp;
    reg [255:0] WriteDateTemp;
    always @(posedge Clk) begin
        if(!Rest) begin
            WriteLenTemp <= 8'd0 ;
            WriteStrbTemp <= 4'd0 ;
            WriteDateTemp<= 256'd0 ;
        end
        else if(Awvalid) begin
            WriteLenTemp <= Awlen ;
            WriteStrbTemp <= UncacheStrb ;
            WriteDateTemp<= DcaWDate ;
        end
        else if(Wlast) begin
            WriteLenTemp <= 8'd0 ;
            WriteStrbTemp <= 4'd0 ;
            WriteDateTemp<= 256'd0 ;
        end
    end

    assign DWshankhand = Awready ;

    reg      WvalidTemp ; //用于标识处于写通道传输状态
    always @(posedge Clk) begin
        if(!Rest) 
            WvalidTemp <= `EnableValue ;
        else if(DWshankhand) 
            WvalidTemp <= `AbleValue ;
        else if(Wlast) 
            WvalidTemp <= `EnableValue ;
    end

    reg    BReadyTemp ;
    always @(posedge Clk) begin
        if(!Rest)
           BReadyTemp <=  `EnableValue ;
        else if(DWshankhand) 
            BReadyTemp <= `AbleValue ;
        else if((Bid ==4'd1) & (Bresp == 2'd0) & (Bvalid))
            BReadyTemp <=  `EnableValue ;
    end

    assign Bready = BReadyTemp ;

    assign Wvalid = WvalidTemp ;

    wire [31:0] WriteDAteDiv [1:8] ;
    assign WriteDAteDiv[1] = WriteDateTemp[31:0] ;
    assign WriteDAteDiv[2] = WriteDateTemp[63:32] ;
    assign WriteDAteDiv[3] = WriteDateTemp[95:64] ;
    assign WriteDAteDiv[4] = WriteDateTemp[127:96] ;
    assign WriteDAteDiv[5] = WriteDateTemp[159:128] ;
    assign WriteDAteDiv[6] = WriteDateTemp[191:160] ;
    assign WriteDAteDiv[7] = WriteDateTemp[223:192] ;
    assign WriteDAteDiv[8] = WriteDateTemp[255:224] ;


    reg [31:0]  RegWdate  ;
    reg         RegWlast  ;
    reg [7:0]   WriteCont ;
    always @(posedge Clk) begin
        if(!Rest) begin
            RegWlast  <= `EnableValue ;
            RegWdate  <= 32'd0 ;
            WriteCont <= 8'd1  ;
        end 
        else begin
            if(WvalidTemp) begin
                if(Wready & (WriteCont <= WriteLenTemp)) begin
                    RegWlast <= ((WriteLenTemp-WriteCont) == 1) ;
                    RegWdate <= WriteDAteDiv[WriteCont] ;
                    WriteCont <= WriteCont+1 ; 
                end
                else begin
                    RegWlast <= `EnableValue ;
                    RegWdate <= 32'd0 ;
                    WriteCont <= WriteCont ; 
                end
            end
            else begin
                RegWlast  <= `EnableValue ;
                RegWdate  <= 32'd0 ;
                WriteCont <= 8'd1  ;
            end
        end
    end

    // assign NextWriteState = Awvalid    ? WADDRC :
    //                         WvalidTemp ? WDATEC : 
    //                         BReadyTemp ? WRESPC : IDLE ;

     assign WritBAckAble = ((Bid ==4'd1) & (Bresp == 2'd0) & (Bvalid)) ;
    // assign CacWritefree = (WriteState == IDLE) ;

    assign CacWritefree = BReadyTemp ;


    assign Wid      = 4'd1 ;
    assign Wdata    = RegWdate ;
    assign Wstrb    = (WriteLenTemp == 8'd1) ? WriteStrbTemp : 4'b1111  ;
    assign Wlast    = RegWlast ;


endmodule
