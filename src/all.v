`timescale 1ps/1ps
`include "IPsetting.v"

module BrCsrIQ1Criq4 #(
    parameter CRIQWIDE = 4 ,
    parameter CRIQDEEP = 4  
) (
    input         wire                            Clk           ,
    input         wire                            Rest          ,

    input         wire                            Rable         ,
    output        wire       [CRIQWIDE-1:0]       Dout          , //23 wide

    output        wire       [CRIQWIDE-1:0]       CriqPreOut    ,

    input         wire                            Wable         ,
    input         wire       [CRIQWIDE-1:0]       Din           ,

    input         wire                            CriqClean     ,

    output        wire                            CriqFull      ,
    output        wire                            CriqEmpty     
);

    reg   [CRIQWIDE-1:0] CRIQREG [0:CRIQDEEP]  ;
    reg   [2:0]     Criqfront                  ;
    reg   [2:0]     Criqtril                   ;

    always @(posedge Clk) begin
        if(!Rest) begin
            Criqfront  <= 3'd4 ;
            CRIQREG[0] <= 4'd0 ;
            CRIQREG[1] <= 4'd4 ;
            CRIQREG[2] <= 4'd8 ;
            CRIQREG[3] <= 4'd12 ;
            CRIQREG[4] <= 4'd0 ;
        end
        else begin
            if(Wable) begin
              Criqfront <= (Criqfront == CRIQDEEP) ? 0 : Criqfront + 1 ;
              CRIQREG[Criqfront] <= Din ;
            end 
            if(CriqClean) begin
                Criqfront  <= 3'd4 ;
                CRIQREG[0] <= 4'd0 ;
                CRIQREG[1] <= 4'd4 ;
                CRIQREG[2] <= 4'd8 ;
                CRIQREG[3] <= 4'd12 ;
                CRIQREG[4] <= 4'd0 ;
            end
        end
    end

    reg  [CRIQWIDE-1:0]  CriqOutReg  ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Criqtril   <= 3'd0 ;
            CriqOutReg <= {CRIQWIDE{1'b0}};
        end 
        else begin
            if(Rable) begin
                CriqOutReg <= CRIQREG[Criqtril] ;
                Criqtril <= (Criqtril == CRIQDEEP) ? 3'd0 : Criqtril + 1 ;
            end
            if(CriqClean)
                Criqtril <= 3'd0 ;
        end
    end

    assign Dout       = CriqOutReg              ;
    assign CriqFull   = (((Criqfront - Criqtril) == 1) || ((Criqtril == 0) && (Criqfront == CRIQDEEP))) ;
    assign CriqEmpty  = (Criqtril == Criqfront) ;
    assign CriqPreOut = CRIQREG[Criqtril]       ;  

endmodule

`timescale 1ps/1ps
`include "IPsetting.v"

module BrCsrIQ2Criq4 #(
    parameter CRIQWIDE = 4 ,
    parameter CRIQDEEP = 4  
) (
    input         wire                            Clk           ,
    input         wire                            Rest          ,

    input         wire                            Rable         ,
    output        wire       [CRIQWIDE-1:0]       Dout          , //23 wide

    output        wire       [CRIQWIDE-1:0]       CriqPreOut    ,

    input         wire                            Wable         ,
    input         wire       [CRIQWIDE-1:0]       Din           ,

    input         wire                            CriqClean     ,

    output        wire                            CriqFull      ,
    output        wire                            CriqEmpty     
);

    reg   [CRIQWIDE-1:0] CRIQREG [0:CRIQDEEP]  ;
    reg   [2:0]     Criqfront                  ;
    reg   [2:0]     Criqtril                   ;

    always @(posedge Clk) begin
        if(!Rest) begin
            Criqfront  <= 3'd4 ;
            CRIQREG[0] <= 4'd1 ;
            CRIQREG[1] <= 4'd5 ;
            CRIQREG[2] <= 4'd9 ;
            CRIQREG[3] <= 4'd13 ;
            CRIQREG[4] <= 4'd0 ;
        end
        else begin
            if(Wable) begin
              Criqfront <= (Criqfront == CRIQDEEP) ? 0 : Criqfront + 1 ;
              CRIQREG[Criqfront] <= Din ;
            end 
            if(CriqClean) begin
                Criqfront  <= 3'd4 ;
                CRIQREG[0] <= 4'd1 ;
                CRIQREG[1] <= 4'd5 ;
                CRIQREG[2] <= 4'd9 ;
                CRIQREG[3] <= 4'd13 ;
                CRIQREG[4] <= 4'd0 ;
            end
        end
    end

    reg  [CRIQWIDE-1:0]  CriqOutReg  ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Criqtril   <= 3'd0 ;
            CriqOutReg <= {CRIQWIDE{1'b0}};
        end 
        else begin
            if(Rable) begin
                CriqOutReg <= CRIQREG[Criqtril] ;
                Criqtril <= (Criqtril == CRIQDEEP) ? 3'd0 : Criqtril + 1 ;
            end
            if(CriqClean)
                Criqtril <= 3'd0 ;
        end
    end

    assign Dout       = CriqOutReg              ;
    assign CriqFull   = (((Criqfront - Criqtril) == 1) || ((Criqtril == 0) && (Criqfront == CRIQDEEP))) ;
    assign CriqEmpty  = (Criqtril == Criqfront) ;
    assign CriqPreOut = CRIQREG[Criqtril]       ;  

endmodule

`timescale 1ps/1ps
`include "IPsetting.v"

module BrCsrIQ3Criq4 #(
    parameter CRIQWIDE = 4 ,
    parameter CRIQDEEP = 4  
) (
    input         wire                            Clk           ,
    input         wire                            Rest          ,

    input         wire                            Rable         ,
    output        wire       [CRIQWIDE-1:0]       Dout          , //23 wide

    output        wire       [CRIQWIDE-1:0]       CriqPreOut    ,

    input         wire                            Wable         ,
    input         wire       [CRIQWIDE-1:0]       Din           ,

    input         wire                            CriqClean     ,

    output        wire                            CriqFull      ,
    output        wire                            CriqEmpty     
);

    reg   [CRIQWIDE-1:0] CRIQREG [0:CRIQDEEP]  ;
    reg   [2:0]     Criqfront                  ;
    reg   [2:0]     Criqtril                   ;

    always @(posedge Clk) begin
        if(!Rest) begin
            Criqfront  <= 3'd4 ;
            CRIQREG[0] <= 4'd2 ;
            CRIQREG[1] <= 4'd6 ;
            CRIQREG[2] <= 4'd10 ;
            CRIQREG[3] <= 4'd14 ;
            CRIQREG[4] <= 4'd0 ;
        end
        else begin
            if(Wable) begin
              Criqfront <= (Criqfront == CRIQDEEP) ? 0 : Criqfront + 1 ;
              CRIQREG[Criqfront] <= Din ;
            end 
            if(CriqClean) begin
                Criqfront  <= 3'd4 ;
                CRIQREG[0] <= 4'd2 ;
                CRIQREG[1] <= 4'd6 ;
                CRIQREG[2] <= 4'd10 ;
                CRIQREG[3] <= 4'd14 ;
                CRIQREG[4] <= 4'd0 ;
            end
        end
    end

    reg  [CRIQWIDE-1:0]  CriqOutReg  ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Criqtril   <= 3'd0 ;
            CriqOutReg <= {CRIQWIDE{1'b0}};
        end 
        else begin
            if(Rable) begin
                CriqOutReg <= CRIQREG[Criqtril] ;
                Criqtril <= (Criqtril == CRIQDEEP) ? 3'd0 : Criqtril + 1 ;
            end
            if(CriqClean)
                Criqtril <= 3'd0 ;
        end
    end

    assign Dout       = CriqOutReg              ;
    assign CriqFull   = (((Criqfront - Criqtril) == 1) || ((Criqtril == 0) && (Criqfront == CRIQDEEP))) ;
    assign CriqEmpty  = (Criqtril == Criqfront) ;
    assign CriqPreOut = CRIQREG[Criqtril]       ;  

endmodule

`timescale 1ps/1ps
`include "IPsetting.v"

module BrCsrIQ4Criq4 #(
    parameter CRIQWIDE = 4 ,
    parameter CRIQDEEP = 4  
) (
    input         wire                            Clk           ,
    input         wire                            Rest          ,

    input         wire                            Rable         ,
    output        wire       [CRIQWIDE-1:0]       Dout          , //23 wide

    output        wire       [CRIQWIDE-1:0]       CriqPreOut    ,

    input         wire                            Wable         ,
    input         wire       [CRIQWIDE-1:0]       Din           ,

    input         wire                            CriqClean     ,

    output        wire                            CriqFull      ,
    output        wire                            CriqEmpty     
);

    reg   [CRIQWIDE-1:0] CRIQREG [0:CRIQDEEP]  ;
    reg   [2:0]     Criqfront                  ;
    reg   [2:0]     Criqtril                   ;

    always @(posedge Clk) begin
        if(!Rest) begin
            Criqfront  <= 3'd4 ;
            CRIQREG[0] <= 4'd3 ;
            CRIQREG[1] <= 4'd7 ;
            CRIQREG[2] <= 4'd11 ;
            CRIQREG[3] <= 4'd15 ;
            CRIQREG[4] <= 4'd0 ;
        end
        else begin
            if(Wable) begin
              Criqfront <= (Criqfront == CRIQDEEP) ? 0 : Criqfront + 1 ;
              CRIQREG[Criqfront] <= Din ;
            end 
            if(CriqClean) begin
                Criqfront  <= 3'd4 ;
                CRIQREG[0] <= 4'd3 ;
                CRIQREG[1] <= 4'd7 ;
                CRIQREG[2] <= 4'd11 ;
                CRIQREG[3] <= 4'd15 ;
                CRIQREG[4] <= 4'd0 ;
            end
        end
    end

    reg  [CRIQWIDE-1:0]  CriqOutReg  ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Criqtril   <= 3'd0 ;
            CriqOutReg <= {CRIQWIDE{1'b0}};
        end 
        else begin
            if(Rable) begin
                CriqOutReg <= CRIQREG[Criqtril] ;
                Criqtril <= (Criqtril == CRIQDEEP) ? 3'd0 : Criqtril + 1 ;
            end
            if(CriqClean)
                Criqtril <= 3'd0 ;
        end
    end

    assign Dout       = CriqOutReg              ;
    assign CriqFull   = (((Criqfront - Criqtril) == 1) || ((Criqtril == 0) && (Criqfront == CRIQDEEP))) ;
    assign CriqEmpty  = (Criqtril == Criqfront) ;
    assign CriqPreOut = CRIQREG[Criqtril]       ;  

endmodule

`timescale 1ps/1ps
`include "IPsetting.v"

module Cache_counter #(
    parameter COUNTERWIDE = 2 ,
    parameter COUNTERPW   = 6 ,
    parameter COUNTERDEEP = 64 
) (
    input      wire                                Clk             ,
    input      wire                                Rest            ,

    input      wire                                RABLE           ,
    input      wire                                WABLE           ,
    input      wire      [COUNTERPW-1:0]           RADDR           , 
    input      wire      [COUNTERPW-1:0]           WADDR           ,
    input      wire                                CLEAN           ,
    output     wire      [COUNTERWIDE-1:0]         RDATE     
);

    reg [COUNTERWIDE-1:0] Counter [0:COUNTERDEEP-1];
    reg [COUNTERWIDE-1:0] RegDout ;
    integer i ;
    always @(posedge Clk) begin
        if(!Rest)
            for (i=0 ;i < COUNTERDEEP ;i=i+1 ) begin
                Counter[i] <= {COUNTERWIDE{1'b0}};
            end
        else begin
            if(WABLE)
                Counter[WADDR] <= (Counter[WADDR] == 3) ? Counter[WADDR] : Counter[WADDR] + 1 ;
            if(CLEAN)
                Counter[WADDR] <= {COUNTERWIDE{1'b0}} ;
        end
    end
    
    always @(posedge Clk) begin
        if(!Rest)
            RegDout <= {COUNTERWIDE{1'b0}}  ;
        else 
            if(RABLE)
                RegDout <= Counter[RADDR]    ;
            else 
                RegDout <= {COUNTERWIDE{1'b0}}  ;  
    end
    assign RDATE = RegDout ;

    
endmodule
`timescale 1ps/1ps 
`include "IPsetting.v"

module Counter_128 (
    input        wire                                        Clk          ,
    input        wire                                        Rest         ,

    input        wire                                        Atten        ,
    input        wire       [6:0]                            Addr         ,
    output       wire       [2:0]                            Dout         ,
    input        wire                                        Wen          ,
    input        wire       [2:0]                            Din  
);

    reg [2:0] Counter[0:127] ;

    reg [2:0] RegDout ;
    integer i ;
    always @(posedge Clk) begin
        if(!Rest) begin
            RegDout <= 3'd0 ;
            for (i =0 ;i<32 ;i=i+1 ) begin
                Counter[i]    <= 3'd0 ;
                Counter[i+32] <= 3'd0 ;
                Counter[i+64] <= 3'd0 ;
                Counter[i+96] <= 3'd0 ;
            end
        end
        else if(Atten) begin
            for (i =0 ;i<32 ;i=i+1 ) begin
                Counter[i]    <= (Counter[i] > 0)    ? Counter[i]-1 : Counter[i]       ;
                Counter[i+32] <= (Counter[i+32] > 0) ? Counter[i+32]-1 : Counter[i+32] ;
                Counter[i+64] <= (Counter[i+64] > 0) ? Counter[i+64]-1 : Counter[i+64] ;
                Counter[i+96] <= (Counter[i+96] > 0) ? Counter[i+96]-1 : Counter[i+96] ;
            end
        end
        else begin
            RegDout <= Counter[Addr] ;
            if(Wen)
                Counter[Addr] <= Din ;
            else 
                Counter[Addr] <= Counter[Addr] ;
        end
    end

    assign Dout = RegDout ;

endmodule
`timescale 1ps/1ps 
`include "IPsetting.v"

module Counter_256 (
    input        wire                                        Clk          ,
    input        wire                                        Rest         ,

    input        wire                                        Atten        ,
    input        wire       [7:0]                            Addr         ,
    output       wire       [2:0]                            Dout         ,
    input        wire                                        Wen          ,
    input        wire       [2:0]                            Din  
);

    reg [2:0] Counter[0:255] ;

    reg [2:0] RegDout ;
    integer i ;
    always @(posedge Clk) begin
        if(!Rest) begin
            RegDout <= 3'd0 ;
            for (i =0 ;i<32 ;i=i+1 ) begin
                Counter[i]    <= 3'd0 ;
                Counter[i+32] <= 3'd0 ;
                Counter[i+64] <= 3'd0 ;
                Counter[i+96] <= 3'd0 ;
                Counter[i+128] <= 3'd0 ;
                Counter[i+160] <= 3'd0 ;
                Counter[i+192] <= 3'd0 ;
                Counter[i+224] <= 3'd0 ;
            end
        end
        else if(Atten) begin
            for (i =0 ;i<32 ;i=i+1 ) begin
                Counter[i]     <= (Counter[i] > 0)    ? Counter[i]-1     : Counter[i]    ;
                Counter[i+32]  <= (Counter[i+32] > 0) ? Counter[i+32]-1  : Counter[i+32] ;
                Counter[i+64]  <= (Counter[i+64] > 0) ? Counter[i+64]-1  : Counter[i+64] ;
                Counter[i+96]  <= (Counter[i+96] > 0) ? Counter[i+96]-1  : Counter[i+96] ;
                Counter[i+128] <= (Counter[i+128]> 0) ? Counter[i+128]-1 : Counter[i+128];
                Counter[i+160] <= (Counter[i+160]> 0) ? Counter[i+160]-1 : Counter[i+160];
                Counter[i+192] <= (Counter[i+192]> 0) ? Counter[i+192]-1 : Counter[i+192];
                Counter[i+224] <= (Counter[i+224]> 0) ? Counter[i+224]-1 : Counter[i+224];
            end
        end 
        else begin
            RegDout <= Counter[Addr] ;
            if(Wen)
                Counter[Addr] <= Din ;
            else 
                Counter[Addr] <= Counter[Addr] ;
        end
    end

    assign Dout = RegDout ;

endmodule
`timescale 1ps/1ps
`include "IPsetting.v"

module Counter_heap #(
    parameter COUNTERWIDE = 2 ,
    parameter COUNTERPW   = 6 ,
    parameter COUNTERDEEP = 64 
) (
    input      wire                                Clk             ,
    input      wire                                Rest            ,

    input      wire      [COUNTERPW-1:0]           UpAddr          , 
    input      wire      [COUNTERPW-1:0]           ReadAddr        ,
    input      wire                                Attenuation     ,//衰减需要在判断的周期i里面进行这样不会和update争抢端口
    input      wire                                UpdateAble      ,
    input      wire                                ReadAble        ,
    input      wire                                RightOrFault    ,
    output     wire      [COUNTERWIDE-1:0]         DoutCounter     
);

    reg [COUNTERWIDE-1:0] Counter [0:COUNTERDEEP-1];
    reg [COUNTERWIDE-1:0] RegDout ;
    integer i ;
    integer j ;
    always @(posedge Clk) begin
        if(!Rest)
            for (i=0 ;i < COUNTERDEEP ;i=i+1 ) begin
                Counter[i] <= {COUNTERWIDE{1'b0}};
            end
        else begin
            if(UpdateAble)
                Counter[UpAddr] <= (RightOrFault != 0) ? ((Counter[UpAddr] == 3) ? Counter[UpAddr] : Counter[UpAddr] +1) :((Counter[UpAddr] == 0) ? Counter[UpAddr] : Counter[UpAddr] -1) ;
            if(Attenuation)
                for (j =0 ;j< COUNTERDEEP ;j=j+1 ) begin
                    Counter[i] <= {1'b0,Counter[i][1]} ;
                end
        end
    end
    
    always @(posedge Clk) begin
        if(!Rest)
            RegDout <= {COUNTERWIDE{1'b0}}  ;
        else 
            if(ReadAble)
                RegDout <= Counter[ReadAddr]    ;
            else 
                RegDout <= {COUNTERWIDE{1'b0}}  ;  
    end
    assign DoutCounter = RegDout ;

    
endmodule
`timescale 1ps/1ps
`include "IPsetting.v"

module CRIQ #(
    parameter CRIQWIDE = 1 ,
    parameter CRIQDEEP = 1 ,
    parameter PTRWIDE  = 1 
) (
    input         wire                            Clk           ,
    input         wire                            Rest          ,

    input         wire                            Rable         ,
    //output        wire       [CRIQWIDE-1:0]       Dout          , //23 wide

    output        wire       [CRIQWIDE-1:0]       CriqPreOut    ,

    output        wire       [CRIQWIDE-1:0]       Frontd        ,

    input         wire                            Wable         ,
    input         wire       [CRIQWIDE-1:0]       Din           ,

    input         wire                            CriqClean     ,

    output        wire                            CriqFull      ,
    output        wire                            CriqEmpty     
);

    reg   [CRIQWIDE-1:0] CRIQREG [0:CRIQDEEP]  ;
    reg   [PTRWIDE-1:0]     Criqfront          ;
    reg   [PTRWIDE-1:0]     Criqtril           ;

    integer i ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Criqfront <= {PTRWIDE{1'b0}};
            for (i =0 ;i <= CRIQDEEP ;i = i + 1 ) begin
                CRIQREG[i] <= {CRIQWIDE{1'b0}};
            end
        end
        else begin
            if(Wable) begin
              Criqfront <= (Criqfront == CRIQDEEP) ? 0 : Criqfront + 1 ;
              CRIQREG[Criqfront] <= Din ;
            end 
            if(CriqClean)
              Criqfront <= 0 ;
        end
    end

    //reg  [CRIQWIDE-1:0]  CriqOutReg  ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Criqtril <= {PTRWIDE{1'b0}} ;
            //CriqOutReg <= {CRIQWIDE{1'b0}};
        end 
        else begin
            if(Rable) begin
                CriqOutReg <= CRIQREG[Criqtril] ;
                //Criqtril <= (Criqtril == CRIQDEEP) ? 0 : Criqtril + 1 ;
            end
            if(CriqClean)
                Criqtril <= 0 ;
        end
    end

    //assign Dout       = CriqOutReg              ;
    assign CriqFull   = (((Criqtril - Criqfront) == 1) || ((Criqtril == 0) && (Criqfront == CRIQDEEP))) ;
    assign CriqEmpty  = (Criqtril == Criqfront) ;
    assign CriqPreOut = CRIQREG[Criqtril]       ; 
    assign Frontd     = CriqEmpty ? {CRIQWIDE{1'b0}} : CRIQREG[Criqfront-1]    ; 

endmodule
`timescale 1ps/1ps
`include "IPsetting.v"

module CRIQBPU #(
    parameter CRIQWIDE = 7 ,
    parameter CRIQDEEP = 64  
) (
    input         wire                            Clk           ,
    input         wire                            Rest          ,

    input         wire                            Rable         ,
   // output        wire       [CRIQWIDE-1:0]       Dout          , //23 wide

    output        wire       [CRIQWIDE-1:0]       CriqPreOut    ,

    input         wire                            Wable         ,
    input         wire       [CRIQWIDE-1:0]       Din           ,

    input         wire                            CriqClean     ,

    output        wire                            CriqFull      
   // output        wire                            CriqEmpty     
);

    reg   [CRIQWIDE-1:0] CRIQREG [0:CRIQDEEP]  ;
    reg   [6:0]     Criqfront                  ;
    reg   [6:0]     Criqtril                   ;

    integer i ;
    integer a ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Criqfront  <= 7'd0 ;
            for (i =0 ;i<=31 ;i=i+1 ) begin
                CRIQREG[i] <= 7'd0 ;
            end
            for (a =32 ;a<=64 ;a=a+1 ) begin
                CRIQREG[a] <= 7'd0 ;
            end
        end
        else begin
            if(Wable) begin
              Criqfront <= (Criqfront == CRIQDEEP) ? 0 : Criqfront + 1 ;
              CRIQREG[Criqfront] <= Din ;
            end 
            if(CriqClean) begin
                Criqfront  <= 7'd0 ;
                for (i =0 ;i<=31 ;i=i+1 ) begin
                    CRIQREG[i] <= 7'd0 ;
                end
                for (a =32 ;a<=64 ;a=a+1 ) begin
                    CRIQREG[a] <= 7'd0 ;
                end
            end
        end
    end

    //reg  [CRIQWIDE-1:0]  CriqOutReg  ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Criqtril   <= 7'd0 ;
            //CriqOutReg <= {CRIQWIDE{1'b0}};
        end 
        else begin
            if(Rable) begin
                //CriqOutReg <= CRIQREG[Criqtril] ;
                Criqtril <= (Criqtril == CRIQDEEP) ? 7'd0 : Criqtril + 1 ;
            end
            if(CriqClean)
                Criqtril <= 7'd0 ;
        end
    end

    //assign Dout       = CriqOutReg              ;
    assign CriqFull   = (((Criqfront - Criqtril) == 1) || ((Criqtril == 0) && (Criqfront == CRIQDEEP))) ;
    //assign CriqEmpty  = (Criqtril == Criqfront) ;
    assign CriqPreOut = CRIQREG[Criqtril]       ;  

endmodule
`timescale 1ps/1ps
`include "IPsetting.v"

module FIFO_ftq #(
    parameter FIFOWIDE = 24
) (
    input         wire                            Clk           ,
    input         wire                            Rest          ,

    input         wire                            Rable         ,
    //output        wire       [FIFOWIDE-1:0]       Dout          , //23 wide

    output        wire       [FIFOWIDE-1:0]       FifoPreOut    ,

    input         wire                            Wable         ,
    input         wire       [FIFOWIDE-1:0]       Din           ,

    input         wire                            FifoClean     ,

    output        wire                            FifoFull      
    //output        wire                            FifoEmpty     
);

    reg  [FIFOWIDE-1:0] FIFOREG [0:64] ;
    reg   [6:0]     Fifofront          ;
    reg   [6:0]     Fifotril           ;

    integer i ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Fifofront <= 7'd0 ;
            for (i =0 ;i < 32 ;i = i + 1 ) begin
                FIFOREG[i] <= {FIFOWIDE{1'b0}};
                FIFOREG[1+32] <= {FIFOWIDE{1'b0}};
            end
            FIFOREG[64] <= {FIFOWIDE{1'b0}}; 
        end
        else begin
            if(Wable) begin
              Fifofront <=(Fifofront == 64) ? 0 : Fifofront + 1 ;
              FIFOREG[Fifofront] <= Din ;
            end 
            if(FifoClean)
              Fifofront <= 0 ;
        end
    end

    //reg  [FIFOWIDE-1:0]  FifoOutReg  ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Fifotril <= 7'd0 ;
            //FifoOutReg <= {FIFOWIDE{1'b0}};
        end 
        else begin
            if(Rable) begin
                //FifoOutReg <= FIFOREG[Fifotril] ;
                Fifotril <= (Fifotril == 64) ? 0 : Fifotril+1 ;
            end
            if(FifoClean)
                Fifotril <= 0 ;
        end
    end

    //assign Dout = FifoOutReg ;
    assign FifoFull = (((Fifotril - Fifofront) == 1) || ((Fifotril == 0) && (Fifofront == 64))) ;
    //assign FifoEmpty = (Fifotril == Fifofront) ;
    assign FifoPreOut = FIFOREG[Fifotril] ;
    

    
endmodule 
`timescale 1ps/1ps
`include "IPsetting.v"

module FIFO #(
    parameter FIFOWIDE = 1 
) (
    input         wire                            Clk           ,
    input         wire                            Rest          ,

    input         wire                            Rable         ,
    output        wire       [FIFOWIDE-1:0]       Dout          , //23 wide

    //output        wire       [FIFOWIDE-1:0]       FifoPreOut    ,

    input         wire                            Wable         ,
    input         wire       [FIFOWIDE-1:0]       Din           ,

    input         wire                            FifoClean     ,

    output        wire                            FifoFull      ,
    output        wire                            FifoEmpty     
);

    reg  [FIFOWIDE-1:0] FIFOREG [0:16] ;
    reg   [4:0]     Fifofront          ;
    reg   [4:0]     Fifotril           ;

    integer i ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Fifofront <= 5'd0 ;
            for (i =0 ;i < 17 ;i = i + 1 ) begin
                FIFOREG[i] <= {FIFOWIDE{1'b0}};
            end
        end
        else begin
            if(Wable) begin
              Fifofront <=(Fifofront == 16) ? 0 : Fifofront + 1 ;
              FIFOREG[Fifofront] <= Din ;
            end 
            if(FifoClean)
              Fifofront <= 0 ;
        end
    end

    reg  [FIFOWIDE-1:0]  FifoOutReg  ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Fifotril <= 5'd0 ;
            FifoOutReg <= {FIFOWIDE{1'b0}};
        end 
        else begin
            if(Rable) begin
                FifoOutReg <= FIFOREG[Fifotril] ;
                Fifotril <= Fifotril - 1 ;
            end
            if(FifoClean)
                Fifotril <= 0 ;
        end
    end

    assign Dout = FifoOutReg ;
    assign FifoFull = (((Fifotril - Fifofront) == 1) || ((Fifotril == 0) && (Fifofront == 8))) ;
    assign FifoEmpty = (Fifotril == Fifofront) ;
   // assign FifoPreOut = FIFOREG[Fifotril] ;
    

    
endmodule 
`timescale 1ps/1ps
`include "IPsetting.v"

module FIFOlsu #(
    parameter FIFOWIDE = 1 
) (
    input         wire                            Clk           ,
    input         wire                            Rest          ,

    input         wire                            Rable         ,
    output        wire       [FIFOWIDE-1:0]       Dout          , //23 wide

    output        wire       [FIFOWIDE-1:0]       FifoPreOut    ,

    input         wire                            Wable         ,
    input         wire       [FIFOWIDE-1:0]       Din           ,

    input         wire                            FifoClean     ,

    output        wire                            FifoFull      ,
    output        wire                            FifoEmpty     
);

    reg  [FIFOWIDE-1:0] FIFOREG [0:16] ;
    reg   [4:0]     Fifofront          ;
    reg   [4:0]     Fifotril           ;

    integer i ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Fifofront <= 5'd0 ;
            for (i =0 ;i < 17 ;i = i + 1 ) begin
                FIFOREG[i] <= {FIFOWIDE{1'b0}};
            end
        end
        else begin
            if(Wable) begin
              Fifofront <=(Fifofront == 16) ? 0 : Fifofront + 1 ;
              FIFOREG[Fifofront] <= Din ;
            end 
            if(FifoClean)
              Fifofront <= 0 ;
        end
    end

    reg  [FIFOWIDE-1:0]  FifoOutReg  ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Fifotril <= 5'd0 ;
            FifoOutReg <= {FIFOWIDE{1'b0}};
        end 
        else begin
            if(Rable) begin
                FifoOutReg <= FIFOREG[Fifotril] ;
                Fifotril <= Fifotril - 1 ;
            end
            if(FifoClean)
                Fifotril <= 0 ;
        end
    end

    assign Dout = FifoOutReg ;
    assign FifoFull = ((Fifotril - Fifofront) == 1) || ((Fifotril == 0) && (Fifofront == 16)) ;
    assign FifoEmpty = (Fifotril == Fifofront) ;
    assign FifoPreOut = FIFOREG[Fifotril] ;

endmodule
`timescale 1ps/1ps
`include "IPsetting.v"

module IntIQ1Criq8 #(
    parameter CRIQWIDE = 5 ,
    parameter CRIQDEEP = 8  
) (
    input         wire                            Clk           ,
    input         wire                            Rest          ,

    input         wire                            Rable         ,
    //output        wire       [CRIQWIDE-1:0]       Dout          , //23 wide

    output        wire       [CRIQWIDE-1:0]       CriqPreOut    ,

    input         wire                            Wable         ,
    input         wire       [CRIQWIDE-1:0]       Din           ,

    input         wire                            CriqClean     ,

    //output        wire                            CriqFull      ,
    output        wire                            CriqEmpty     
);

    reg   [CRIQWIDE-1:0] CRIQREG [0:CRIQDEEP]  ;
    reg   [3:0]     Criqfront                  ;
    reg   [3:0]     Criqtril                   ;

    always @(posedge Clk) begin
        if(!Rest) begin
            Criqfront  <= 4'd8 ;
            CRIQREG[0] <= 5'd0 ;
            CRIQREG[1] <= 5'd4 ;
            CRIQREG[2] <= 5'd8 ;
            CRIQREG[3] <= 5'd12 ;
            CRIQREG[4] <= 5'd16 ;
            CRIQREG[5] <= 5'd20 ;
            CRIQREG[6] <= 5'd24 ;
            CRIQREG[7] <= 5'd28 ;
            CRIQREG[8] <= 5'd0 ;
        end
        else begin
            if(Wable) begin
              Criqfront <= (Criqfront == CRIQDEEP) ? 0 : Criqfront + 1 ;
              CRIQREG[Criqfront] <= Din ;
            end 
            if(CriqClean) begin
                Criqfront  <= 4'd8 ;
                CRIQREG[0] <= 5'd0 ;
                CRIQREG[1] <= 5'd4 ;
                CRIQREG[2] <= 5'd8 ;
                CRIQREG[3] <= 5'd12 ;
                CRIQREG[4] <= 5'd16 ;
                CRIQREG[5] <= 5'd20 ;
                CRIQREG[6] <= 5'd24 ;
                CRIQREG[7] <= 5'd28 ;
                CRIQREG[8] <= 5'd0 ;
            end
        end
    end

    //reg  [CRIQWIDE-1:0]  CriqOutReg  ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Criqtril   <= 4'd0 ;
            //CriqOutReg <= {CRIQWIDE{1'b0}};
        end 
        else begin
            if(Rable) begin
                //CriqOutReg <= CRIQREG[Criqtril] ;
                Criqtril <= (Criqtril == CRIQDEEP) ? 4'd0 : Criqtril + 1 ;
            end
            if(CriqClean)
                Criqtril <= 4'd0 ;
        end
    end

    //assign Dout       = CriqOutReg              ;
    //assign CriqFull   = (((Criqfront - Criqtril) == 1) || ((Criqtril == 0) && (Criqfront == CRIQDEEP))) ;
    assign CriqEmpty  = (Criqtril == Criqfront) ;
    assign CriqPreOut = CRIQREG[Criqtril]       ;  

endmodule

`timescale 1ps/1ps
`include "IPsetting.v"

module IntIQ2Criq8 #(
    parameter CRIQWIDE = 5 ,
    parameter CRIQDEEP = 8  
) (
    input         wire                            Clk           ,
    input         wire                            Rest          ,

    input         wire                            Rable         ,
    //output        wire       [CRIQWIDE-1:0]       Dout          , //23 wide

    output        wire       [CRIQWIDE-1:0]       CriqPreOut    ,

    input         wire                            Wable         ,
    input         wire       [CRIQWIDE-1:0]       Din           ,

    input         wire                            CriqClean     ,

    //output        wire                            CriqFull      ,
    output        wire                            CriqEmpty     
);

    reg   [CRIQWIDE-1:0] CRIQREG [0:CRIQDEEP]  ;
    reg   [3:0]     Criqfront                  ;
    reg   [3:0]     Criqtril                   ;

    always @(posedge Clk) begin
        if(!Rest) begin
            Criqfront  <= 4'd8 ;
            CRIQREG[0] <= 5'd1 ;
            CRIQREG[1] <= 5'd5 ;
            CRIQREG[2] <= 5'd9 ;
            CRIQREG[3] <= 5'd13 ;
            CRIQREG[4] <= 5'd17 ;
            CRIQREG[5] <= 5'd21 ;
            CRIQREG[6] <= 5'd25 ;
            CRIQREG[7] <= 5'd29 ;
            CRIQREG[8] <= 5'd0 ;
        end
        else begin
            if(Wable) begin
              Criqfront <= (Criqfront == CRIQDEEP) ? 0 : Criqfront + 1 ;
              CRIQREG[Criqfront] <= Din ;
            end 
            if(CriqClean) begin
                Criqfront  <= 4'd8 ;
                CRIQREG[0] <= 5'd1 ;
                CRIQREG[1] <= 5'd5 ;
                CRIQREG[2] <= 5'd9 ;
                CRIQREG[3] <= 5'd13 ;
                CRIQREG[4] <= 5'd17 ;
                CRIQREG[5] <= 5'd21 ;
                CRIQREG[6] <= 5'd25 ;
                CRIQREG[7] <= 5'd29 ;
                CRIQREG[8] <= 5'd0 ;
            end
        end
    end

    //reg  [CRIQWIDE-1:0]  CriqOutReg  ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Criqtril   <= 4'd0 ;
            //CriqOutReg <= {CRIQWIDE{1'b0}};
        end 
        else begin
            if(Rable) begin
                //CriqOutReg <= CRIQREG[Criqtril] ;
                Criqtril <= (Criqtril == CRIQDEEP) ? 4'd0 : Criqtril + 1 ;
            end
            if(CriqClean)
                Criqtril <= 4'd0 ;
        end
    end

    //assign Dout       = CriqOutReg              ;
    //assign CriqFull   = (((Criqfront - Criqtril) == 1) || ((Criqtril == 0) && (Criqfront == CRIQDEEP))) ;
    assign CriqEmpty  = (Criqtril == Criqfront) ;
    assign CriqPreOut = CRIQREG[Criqtril]       ;  

endmodule

`timescale 1ps/1ps
`include "IPsetting.v"

module IntIQ3Criq8 #(
    parameter CRIQWIDE = 5 ,
    parameter CRIQDEEP = 8  
) (
    input         wire                            Clk           ,
    input         wire                            Rest          ,

    input         wire                            Rable         ,
    //output        wire       [CRIQWIDE-1:0]       Dout          , //23 wide

    output        wire       [CRIQWIDE-1:0]       CriqPreOut    ,

    input         wire                            Wable         ,
    input         wire       [CRIQWIDE-1:0]       Din           ,

    input         wire                            CriqClean     ,

    //output        wire                            CriqFull      ,
    output        wire                            CriqEmpty     
);

    reg   [CRIQWIDE-1:0] CRIQREG [0:CRIQDEEP]  ;
    reg   [3:0]     Criqfront                  ;
    reg   [3:0]     Criqtril                   ;

    always @(posedge Clk) begin
        if(!Rest) begin
            Criqfront  <= 4'd8 ;
            CRIQREG[0] <= 5'd2 ;
            CRIQREG[1] <= 5'd6 ;
            CRIQREG[2] <= 5'd10 ;
            CRIQREG[3] <= 5'd14 ;
            CRIQREG[4] <= 5'd18 ;
            CRIQREG[5] <= 5'd22 ;
            CRIQREG[6] <= 5'd26 ;
            CRIQREG[7] <= 5'd30 ;
            CRIQREG[8] <= 5'd0 ;
        end
        else begin
            if(Wable) begin
              Criqfront <= (Criqfront == CRIQDEEP) ? 0 : Criqfront + 1 ;
              CRIQREG[Criqfront] <= Din ;
            end 
            if(CriqClean) begin
                Criqfront  <= 4'd8 ;
                CRIQREG[0] <= 5'd2 ;
                CRIQREG[1] <= 5'd6 ;
                CRIQREG[2] <= 5'd10 ;
                CRIQREG[3] <= 5'd14 ;
                CRIQREG[4] <= 5'd18 ;
                CRIQREG[5] <= 5'd22 ;
                CRIQREG[6] <= 5'd26 ;
                CRIQREG[7] <= 5'd30 ;
                CRIQREG[8] <= 5'd0 ;
            end
        end
    end

    //reg  [CRIQWIDE-1:0]  CriqOutReg  ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Criqtril   <= 4'd0 ;
            //CriqOutReg <= {CRIQWIDE{1'b0}};
        end 
        else begin
            if(Rable) begin
                //CriqOutReg <= CRIQREG[Criqtril] ;
                Criqtril <= (Criqtril == CRIQDEEP) ? 4'd0 : Criqtril + 1 ;
            end
            if(CriqClean)
                Criqtril <= 4'd0 ;
        end
    end

    //assign Dout       = CriqOutReg              ;
    //assign CriqFull   = (((Criqfront - Criqtril) == 1) || ((Criqtril == 0) && (Criqfront == CRIQDEEP))) ;
    assign CriqEmpty  = (Criqtril == Criqfront) ;
    assign CriqPreOut = CRIQREG[Criqtril]       ;  

endmodule

`timescale 1ps/1ps
`include "IPsetting.v"

module IntIQ4Criq8 #(
    parameter CRIQWIDE = 5 ,
    parameter CRIQDEEP = 8  
) (
    input         wire                            Clk           ,
    input         wire                            Rest          ,

    input         wire                            Rable         ,
    //output        wire       [CRIQWIDE-1:0]       Dout          , //23 wide

    output        wire       [CRIQWIDE-1:0]       CriqPreOut    ,

    input         wire                            Wable         ,
    input         wire       [CRIQWIDE-1:0]       Din           ,

    input         wire                            CriqClean     ,

    //output        wire                            CriqFull      ,
    output        wire                            CriqEmpty     
);

    reg   [CRIQWIDE-1:0] CRIQREG [0:CRIQDEEP]  ;
    reg   [3:0]     Criqfront                  ;
    reg   [3:0]     Criqtril                   ;

    always @(posedge Clk) begin
        if(!Rest) begin
            Criqfront  <= 4'd8 ;
            CRIQREG[0] <= 5'd3 ;
            CRIQREG[1] <= 5'd7 ;
            CRIQREG[2] <= 5'd11 ;
            CRIQREG[3] <= 5'd15 ;
            CRIQREG[4] <= 5'd19 ;
            CRIQREG[5] <= 5'd23 ;
            CRIQREG[6] <= 5'd27 ;
            CRIQREG[7] <= 5'd31 ;
            CRIQREG[8] <= 5'd0 ;
        end
        else begin
            if(Wable) begin
              Criqfront <= (Criqfront == CRIQDEEP) ? 0 : Criqfront + 1 ;
              CRIQREG[Criqfront] <= Din ;
            end 
            if(CriqClean) begin
                Criqfront  <= 4'd8 ;
                CRIQREG[0] <= 5'd3 ;
                CRIQREG[1] <= 5'd7 ;
                CRIQREG[2] <= 5'd11 ;
                CRIQREG[3] <= 5'd15 ;
                CRIQREG[4] <= 5'd19 ;
                CRIQREG[5] <= 5'd23 ;
                CRIQREG[6] <= 5'd27 ;
                CRIQREG[7] <= 5'd31 ;
                CRIQREG[8] <= 5'd0 ;
            end
        end
    end

    //reg  [CRIQWIDE-1:0]  CriqOutReg  ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Criqtril   <= 4'd0 ;
            //CriqOutReg <= {CRIQWIDE{1'b0}};
        end 
        else begin
            if(Rable) begin
                //CriqOutReg <= CRIQREG[Criqtril] ;
                Criqtril <= (Criqtril == CRIQDEEP) ? 4'd0 : Criqtril + 1 ;
            end
            if(CriqClean)
                Criqtril <= 4'd0 ;
        end
    end

    //assign Dout       = CriqOutReg              ;
    //assign CriqFull   = (((Criqfront - Criqtril) == 1) || ((Criqtril == 0) && (Criqfront == CRIQDEEP))) ;
    assign CriqEmpty  = (Criqtril == Criqfront) ;
    assign CriqPreOut = CRIQREG[Criqtril]       ;  

endmodule

`timescale 1ps/1ps
`include "IPsetting.v"
`include "../Core/define.v"

module STACK_dout #(
    parameter STACKDEEP  = 16 ,
    parameter STACKPTRW  = 4  ,
    parameter STACKWIDE  = 32 ,
    parameter RECURCOUNT = 7
) (
    input         wire                            Clk           ,
    input         wire                            Rest          ,

    input         wire                            RABLE         ,
    input         wire                            WABLE         ,

    input         wire       [STACKWIDE-1:0]      DIN           ,

    //from FTQ
    input         wire                            REDIRCT       ,

    output        wire [STACKPTRW-1:0]            OUTDATEPTR    ,
    output        wire [STACKWIDE+RECURCOUNT-1:0] OUTDATELINE1  ,
    output        wire [STACKWIDE+RECURCOUNT-1:0] OUTDATELINE2  ,     
    output        wire [STACKWIDE+RECURCOUNT-1:0] OUTDATELINE3  ,
    output        wire [STACKWIDE+RECURCOUNT-1:0] OUTDATELINE4  ,
    output        wire [STACKWIDE+RECURCOUNT-1:0] OUTDATELINE5  ,
    output        wire [STACKWIDE+RECURCOUNT-1:0] OUTDATELINE6  ,
    output        wire [STACKWIDE+RECURCOUNT-1:0] OUTDATELINE7  ,
    output        wire [STACKWIDE+RECURCOUNT-1:0] OUTDATELINE8  ,
    output        wire [STACKWIDE+RECURCOUNT-1:0] OUTDATELINE9  ,
    output        wire [STACKWIDE+RECURCOUNT-1:0] OUTDATELINE10 ,
    output        wire [STACKWIDE+RECURCOUNT-1:0] OUTDATELINE11 ,
    output        wire [STACKWIDE+RECURCOUNT-1:0] OUTDATELINE12 ,
    output        wire [STACKWIDE+RECURCOUNT-1:0] OUTDATELINE13 ,
    output        wire [STACKWIDE+RECURCOUNT-1:0] OUTDATELINE14 ,
    output        wire [STACKWIDE+RECURCOUNT-1:0] OUTDATELINE15  
);

    reg [STACKWIDE+RECURCOUNT-1:0] STACKREG [0:STACKDEEP-1] ;
    integer i ;

    reg [STACKPTRW-1:0] StackPtr  ;

    reg [STACKPTRW-1:0]            REGOUTDATEPTR   ;
    reg [STACKWIDE+RECURCOUNT-1:0] REGOUTDATELINE1 ;
    reg [STACKWIDE+RECURCOUNT-1:0] REGOUTDATELINE2 ;
    reg [STACKWIDE+RECURCOUNT-1:0] REGOUTDATELINE3 ;
    reg [STACKWIDE+RECURCOUNT-1:0] REGOUTDATELINE4 ;
    reg [STACKWIDE+RECURCOUNT-1:0] REGOUTDATELINE5 ;
    reg [STACKWIDE+RECURCOUNT-1:0] REGOUTDATELINE6 ;
    reg [STACKWIDE+RECURCOUNT-1:0] REGOUTDATELINE7 ;
    reg [STACKWIDE+RECURCOUNT-1:0] REGOUTDATELINE8 ;
    reg [STACKWIDE+RECURCOUNT-1:0] REGOUTDATELINE9 ;
    reg [STACKWIDE+RECURCOUNT-1:0] REGOUTDATELINE10;
    reg [STACKWIDE+RECURCOUNT-1:0] REGOUTDATELINE11;
    reg [STACKWIDE+RECURCOUNT-1:0] REGOUTDATELINE12;
    reg [STACKWIDE+RECURCOUNT-1:0] REGOUTDATELINE13;
    reg [STACKWIDE+RECURCOUNT-1:0] REGOUTDATELINE14;
    reg [STACKWIDE+RECURCOUNT-1:0] REGOUTDATELINE15;
    always @(posedge Clk) begin
        if(!Rest) begin  
            StackPtr <= {STACKPTRW{1'b0}} ;
            for (i =0 ;i < STACKDEEP ;i = i + 1 ) begin
                STACKREG[i] <= {STACKWIDE+RECURCOUNT{1'b0}};
            end
        end
        else begin
            if(WABLE) begin
                if(STACKREG[StackPtr-1][STACKWIDE-1:0] == DIN) begin
                    StackPtr <= StackPtr ;
                    STACKREG[StackPtr][STACKWIDE+RECURCOUNT-1:STACKWIDE] <= STACKREG[StackPtr][STACKWIDE+RECURCOUNT-1:STACKWIDE] + 1 ; 
                end
                else begin 
                    StackPtr <= StackPtr + 1 ;
                    STACKREG[StackPtr] <= {{(RECURCOUNT-1){1'b0}},1'b1,DIN} ;
                end 
            end
            if(RABLE) begin
                if(STACKREG[StackPtr-1][STACKWIDE+RECURCOUNT-1:STACKWIDE] > 1)begin
                    StackPtr <= StackPtr         ;
                    STACKREG[StackPtr-1][STACKWIDE+RECURCOUNT-1:STACKWIDE] <= STACKREG[StackPtr-1][STACKWIDE+RECURCOUNT-1:STACKWIDE] - 1 ;
                end
                else begin 
                    StackPtr <= StackPtr - 1                        ;
                    STACKREG[StackPtr-1] <= {STACKWIDE+RECURCOUNT{1'b0}}       ;  
                end 
            end
            if(REDIRCT)begin
                REGOUTDATEPTR <= StackPtr ;
                REGOUTDATELINE1 <= STACKREG[0] ;
                REGOUTDATELINE2 <= STACKREG[1] ;
                REGOUTDATELINE3 <= STACKREG[2] ;
                REGOUTDATELINE4 <= STACKREG[3] ;
                REGOUTDATELINE5 <= STACKREG[4] ;
                REGOUTDATELINE6 <= STACKREG[5] ;
                REGOUTDATELINE7 <= STACKREG[6] ;
                REGOUTDATELINE8 <= STACKREG[7] ;
                REGOUTDATELINE9 <= STACKREG[8] ;
                REGOUTDATELINE10<= STACKREG[9]  ; 
                REGOUTDATELINE11<= STACKREG[10] ;
                REGOUTDATELINE12<= STACKREG[11] ;
                REGOUTDATELINE13<= STACKREG[12] ;
                REGOUTDATELINE14<= STACKREG[13] ;
                REGOUTDATELINE15<= STACKREG[14] ;
            end 
        end
    end


    assign OUTDATEPTR   = REGOUTDATEPTR    ;
    assign OUTDATELINE1 = REGOUTDATELINE1  ;
    assign OUTDATELINE2 = REGOUTDATELINE2  ;
    assign OUTDATELINE3 = REGOUTDATELINE3  ;
    assign OUTDATELINE4 = REGOUTDATELINE4  ;
    assign OUTDATELINE5 = REGOUTDATELINE5  ;
    assign OUTDATELINE6 = REGOUTDATELINE6  ;
    assign OUTDATELINE7 = REGOUTDATELINE7  ;
    assign OUTDATELINE8 = REGOUTDATELINE8  ;
    assign OUTDATELINE9 = REGOUTDATELINE9  ;
    assign OUTDATELINE10= REGOUTDATELINE10 ;
    assign OUTDATELINE11= REGOUTDATELINE11 ;
    assign OUTDATELINE12= REGOUTDATELINE12 ;
    assign OUTDATELINE13= REGOUTDATELINE13 ;
    assign OUTDATELINE14= REGOUTDATELINE14 ;
    assign OUTDATELINE15= REGOUTDATELINE15 ;

endmodule

`timescale 1ps/1ps
`include "IPsetting.v"
`include "../Core/define.v"

module STACK_reload #(
    parameter STACKDEEP  = 16 ,
    parameter STACKPTRW  = 4  ,
    parameter STACKWIDE  = 32 ,
    parameter RECURCOUNT = 7
) (
    input         wire                            Clk           ,
    input         wire                            Rest          ,

    input         wire                            RABLE         ,
    output        wire       [STACKWIDE-1:0]      DOUT          , 

    input         wire                            WABLE         ,
    input         wire       [STACKWIDE-1:0]      DIN           ,

    // output        wire                            STACKFULL     ,
    // output        wire                            STACKEMPTY    ,

    input         wire                            RELOAD        ,
    input         wire [STACKPTRW-1:0]            RELOADPTR     ,
    input         wire [STACKWIDE+RECURCOUNT-1:0] RELOADLINE1   ,
    input         wire [STACKWIDE+RECURCOUNT-1:0] RELOADLINE2   ,     
    input         wire [STACKWIDE+RECURCOUNT-1:0] RELOADLINE3   ,
    input         wire [STACKWIDE+RECURCOUNT-1:0] RELOADLINE4   ,
    input         wire [STACKWIDE+RECURCOUNT-1:0] RELOADLINE5   ,
    input         wire [STACKWIDE+RECURCOUNT-1:0] RELOADLINE6   ,
    input         wire [STACKWIDE+RECURCOUNT-1:0] RELOADLINE7   ,
    input         wire [STACKWIDE+RECURCOUNT-1:0] RELOADLINE8   ,
    input         wire [STACKWIDE+RECURCOUNT-1:0] RELOADLINE9   ,
    input         wire [STACKWIDE+RECURCOUNT-1:0] RELOADLINE10  ,
    input         wire [STACKWIDE+RECURCOUNT-1:0] RELOADLINE11  ,
    input         wire [STACKWIDE+RECURCOUNT-1:0] RELOADLINE12  ,
    input         wire [STACKWIDE+RECURCOUNT-1:0] RELOADLINE13  ,
    input         wire [STACKWIDE+RECURCOUNT-1:0] RELOADLINE14  ,
    input         wire [STACKWIDE+RECURCOUNT-1:0] RELOADLINE15  
);

    reg [STACKWIDE+RECURCOUNT-1:0] STACKREG [0:STACKDEEP-1] ;
    integer i ;

    reg [STACKPTRW-1:0] StackPtr  ;
    //reg [STACKWIDE-1:0] RegDout   ;
    always @(posedge Clk) begin
        if(!Rest) begin  
            StackPtr <= {STACKPTRW{1'b0}} ;
            for (i =0 ;i < STACKDEEP ;i = i + 1 ) begin
                STACKREG[i] <= {STACKWIDE+RECURCOUNT{1'b0}};
            end
        end
        else begin
            if(WABLE) begin
                if(STACKREG[StackPtr-1][STACKWIDE-1:0] == DIN) begin
                    StackPtr <= StackPtr ;
                    STACKREG[StackPtr][STACKWIDE+RECURCOUNT-1:STACKWIDE] <= STACKREG[StackPtr][STACKWIDE+RECURCOUNT-1:STACKWIDE] + 1 ; 
                end
                else begin 
                    StackPtr <= StackPtr + 1 ;
                    STACKREG[StackPtr] <= {{(RECURCOUNT-1){1'b0}},1'b1,DIN} ;
                end 
            end
            if(RABLE) begin
                if(STACKREG[StackPtr-1][STACKWIDE+RECURCOUNT-1:STACKWIDE] > 1)begin
                    StackPtr <= StackPtr         ;
                    //RegDout  <= STACKREG[StackPtr-1][STACKWIDE-1:0] ;
                    STACKREG[StackPtr-1][STACKWIDE+RECURCOUNT-1:STACKWIDE] <= STACKREG[StackPtr-1][STACKWIDE+RECURCOUNT-1:STACKWIDE] - 1 ;
                end
                else begin 
                    StackPtr <= StackPtr - 1                        ;
                    //RegDout  <= STACKREG[StackPtr-1][STACKWIDE-1:0] ;
                    STACKREG[StackPtr-1] <= {STACKWIDE+RECURCOUNT{1'b0}}       ;  
                end 
            end
            if(RELOAD)begin
                StackPtr     <= RELOADPTR   ;
                STACKREG[0]  <= RELOADLINE1 ;
                STACKREG[1]  <= RELOADLINE2 ;
                STACKREG[2]  <= RELOADLINE3 ;
                STACKREG[3]  <= RELOADLINE4 ;
                STACKREG[4]  <= RELOADLINE5 ;
                STACKREG[5]  <= RELOADLINE6 ;
                STACKREG[6]  <= RELOADLINE7 ;
                STACKREG[7]  <= RELOADLINE8 ;
                STACKREG[8]  <= RELOADLINE9 ;
                STACKREG[9]  <= RELOADLINE10;
                STACKREG[10] <= RELOADLINE11;
                STACKREG[11] <= RELOADLINE12;
                STACKREG[12] <= RELOADLINE13;
                STACKREG[13] <= RELOADLINE14;
                STACKREG[14] <= RELOADLINE15;
                //STACKREG[15] <= RELOADLINE16;
            end
        end
    end

    // assign STACKFULL   = (StackPtr == 15) ; //虽设计有第16项但设计的基本没有使用即可用15項
    // assign STACKEMPTY  = (StackPtr == 0)  ;
    assign DOUT        = RABLE ?  STACKREG[StackPtr-1][STACKWIDE-1:0] : 32'd0 ;
endmodule
`timescale 1ps/1ps
`include "IPsetting.v"

`define DEEP128PTR 7-1 : 0 
`define COUNTERWIDE 1:0

module Use_counter_128 (
    input       wire                                Clk             ,
    input       wire                                Rest            ,

    input       wire      [`DEEP128PTR]             Waddr           , 
    input       wire      [`DEEP128PTR]             Raddr           ,
    input       wire                                Atten           ,//衰减需要在判断的周期i里面进行这样不会和update争抢端口
    input       wire                                Wable           ,//源counter上加减该数据
    input       wire                                Rable           ,
    input       wire                                Wdate           ,
    output      wire      [`COUNTERWIDE]            Rdate                                          
);
    wire Wable1 = (Waddr[6] == 0) && Wable ;
    wire Wable2 = (Waddr[6] == 1) && Wable ;
    wire Rable1 = (Raddr[6] == 0) && Rable ;
    wire Rable2 = (Raddr[6] == 1) && Rable ; 
    wire [`COUNTERWIDE] DoutCounter1 ;
    wire [`COUNTERWIDE] DoutCounter2 ;
    
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

    assign Rdate = DoutCounter1 | DoutCounter2 ;


endmodule
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
`timescale 1ps/1ps
`include "../define.v"

module BtbMid (
    input       wire                              Clk           ,
    input       wire                              Rest          ,
    //from Ctrl 
    input       wire                              BMstop        ,
    input       wire                              BMFLash       ,
    //from btb 
    input       wire                              InNextAble    ,
    input       wire     [1:0]                    InHitBanN     ,
    input       wire     [`InstAddrBus]           InNextPc      ,
    input       wire     [2:0]                    InNextType    ,
    output      wire                              OtNextAble    ,
    output      wire     [1:0]                    OtHitBanN     ,
    output      wire     [`InstAddrBus]           OtNextPc      ,
    output      wire     [2:0]                    OtNextType    
);

    reg                   RegNextAble ; 
    reg    [1:0]          RegHitBanN  ;
    reg    [`InstAddrBus] RegNextPc   ;
    reg    [2:0]          RegNextType ;

    always @(posedge Clk) begin
        if(!Rest) begin
            RegNextAble <= 1'b0 ;
            RegHitBanN  <= 2'b0 ;
            RegNextPc   <= 32'd0 ;
            RegNextType <= 3'd0 ;
        end
        else if(BMstop) begin
            RegNextAble <= RegNextAble ;
            RegHitBanN  <= RegHitBanN  ;
            RegNextPc   <= RegNextPc   ;
            RegNextType <= RegNextType ;
        end
        else if(BMFLash) begin
            RegNextAble <= 1'b0 ;
            RegHitBanN  <= 2'b0 ;
            RegNextPc   <= 32'd0 ;
            RegNextType <= 3'd0 ;
        end 
        else begin
            RegNextAble <= InNextAble ;
            RegHitBanN  <= InHitBanN  ;
            RegNextPc   <= InNextPc   ;
            RegNextType <= InNextType ;
        end
    end
    
    assign OtNextAble = RegNextAble ;
    assign OtHitBanN  = RegHitBanN  ;
    assign OtNextPc   = RegNextPc   ;
    assign OtNextType = RegNextType ;

endmodule
`timescale 1ps/1ps
`include"../define.v"

module Btb (
    input        wire                                   Clk             ,
    input        wire                                   Rest            ,
    // stop
    input        wire                                   BtbStop         ,
    input        wire                                   BtbFlash        ,
    //input from pc
    input        wire                                   InstPcAble      ,
    input        wire     [`InstAddrBus]                InstPc          , //bit [4:0] un use
    //input from predecode 
    input        wire                                   UpAble          ,
    input        wire     [1:0]                         UpAbleBank      ,
    input        wire     [`InstAddrBus]                UpPc            , //bit [4:0] un use
    input        wire                                   UpCntAble       ,
    input        wire     [3:0]                         UpCnt           ,
    input        wire                                   BtbUpTypeAble   ,
    input        wire     [2:0]                         BtbUpType       ,
    input        wire                                   BtbUpTagetAble  ,
    input        wire     [`InstAddrBus]                BtbUpTaget      ,
    //to tage and ras
    output       wire                                   InstNextAble    ,
    output       wire     [1:0]                         InstHitBanN     ,
    output       wire     [`InstAddrBus]                InstNextPc      ,
    output       wire     [4:0]                         InstNextOffset  ,
    output       wire                                   InstNextMode    ,
    output       wire     [2:0]                         InstNextType   
);

    reg           StopTemp  ;
    //reg           FLashTemp ;
    always @(posedge Clk) begin
        if(!Rest) begin
            StopTemp  <= 1'b0 ;
            //FLashTemp <= 1'b0 ;
        end
        else begin
            StopTemp  <= BtbStop  ;
            //FLashTemp <= BtbFlash ;
        end
    end

    reg   [58:0]  BtbRamBank0 [0:255];
    reg   [58:0]  BtbRamBank1 [0:255];

    reg   [3:0]   CountBan0   [0:255];
    reg   [3:0]   CountBan1   [0:255];
    // for read 
    wire  [58:0]  ReadBtb0Enty = BtbRamBank0[InstPc[12:5]] ;
    wire  [58:0]  ReadBtb1Enty = BtbRamBank1[InstPc[12:5]] ;

    wire  [18:0]  Ban0Tag = ReadBtb0Enty[57:39] ;
    wire  [18:0]  Ban1Tag = ReadBtb1Enty[57:39] ;
    wire          Ban0Valid = ReadBtb0Enty[58]  ;
    wire          Ban1Valid = ReadBtb1Enty[58]  ;
    wire  [18:0]  PcTag   = InstPc[31:13]       ;

    //wire          HitOrNo = ((Ban0Tag == PcTag) & Ban0Valid) | ((Ban1Tag == PcTag) & Ban1Valid) ;

    wire          HitBan0Able =  ((Ban0Tag == PcTag) & Ban0Valid) ;
    wire          HitBan1Able =  ((Ban1Tag == PcTag) & Ban1Valid) ;
    // wire          AllChiose0  =  ((HitBan0Able & HitBan1Able) & (CountBan0[InstPc[12:5]] >= CountBan1[InstPc[12:5]])) | HitBan0Able ;
    // wire          AllChiose1  =  ((HitBan0Able & HitBan1Able) & (CountBan0[InstPc[12:5]] <  CountBan1[InstPc[12:5]])) | HitBan1Able ;

    wire  [38:0]  HitDate = ((Ban0Tag == PcTag) & Ban0Valid) ? ReadBtb0Enty[38:0] :
                            ((Ban1Tag == PcTag) & Ban1Valid) ? ReadBtb1Enty[38:0] : {4'd0,`TypeFORMAL,({InstPc[31:5],5'd0} + 32'd32)} ;


    wire WriteBan0Able ;
    wire WriteBan1Able ;

    assign WriteBan0Able = UpDateChiose0 ;
    assign WriteBan1Able = UpDateChiose1 ;


    integer i ;

    always @(posedge Clk) begin
        if(!Rest) begin
            for (i =0 ;i<32 ;i=i+1 ) begin
                CountBan0[i] <= 4'd0 ;
                CountBan1[i] <= 4'd0 ;
                CountBan0[i+32] <= 4'd0 ;
                CountBan1[i+32] <= 4'd0 ;
                CountBan0[i+64] <= 4'd0 ;
                CountBan1[i+64] <= 4'd0 ;
                CountBan0[i+96] <= 4'd0 ;
                CountBan1[i+96] <= 4'd0 ;
                CountBan1[i+128] <= 4'd0 ;
                CountBan0[i+128] <= 4'd0 ;
                CountBan1[i+160] <= 4'd0 ;
                CountBan0[i+160] <= 4'd0 ;
                CountBan1[i+192] <= 4'd0 ;
                CountBan0[i+192] <= 4'd0 ;
                CountBan1[i+224] <= 4'd0 ;
                CountBan0[i+224] <= 4'd0 ;
            end
        end 
            else begin
                CountBan0[InstPc[12:5]] <= (HitBan0Able & ~StopTemp)  ? 4'd0 :
                                           (HitBan1Able & ~StopTemp)  ? CountBan0[InstPc[12:5]] + 1 : CountBan0[InstPc[12:5]] ;
                CountBan1[InstPc[12:5]] <= (HitBan1Able & ~StopTemp)  ? 4'd0 :
                                           (HitBan0Able & ~StopTemp)  ? CountBan1[InstPc[12:5]] + 1 : CountBan1[InstPc[12:5]] ;
                CountBan0[UpPc[12:5]]   <= (WriteBan0Able & ~StopTemp) ? 4'd0 : CountBan0[UpPc[12:5]] ;
                CountBan1[UpPc[12:5]]   <= (WriteBan1Able & ~StopTemp) ? 4'd0 : CountBan1[UpPc[12:5]] ;
            end
    end
    
    reg                  RegNextAble  ;
    reg  [`InstAddrBus]  RegNextPc    ;
    reg  [4:0]           RegNextOffset;
    reg  [2:0]           RegNextType  ;
    reg                  RegNextMode ;
    reg  [1:0]           RegNextHitBn ;
    always @(posedge Clk) begin
        if(!Rest) begin
            RegNextAble <= `EnableValue ;
            RegNextPc   <= `ZeorDate    ;
            RegNextOffset<= 5'd0        ;
            RegNextType <= 3'd0         ;
            RegNextMode <= 1'b0         ;
            RegNextHitBn<= 2'd0         ;
        end
        else if(BtbStop) begin
            RegNextAble <= RegNextAble ;
            RegNextPc   <= RegNextPc   ;
            RegNextOffset<= RegNextOffset;
            RegNextType <= RegNextType ;
            RegNextMode <= RegNextMode ;
            RegNextHitBn<= RegNextHitBn;
        end
        else if(BtbFlash) begin
            RegNextAble <= `EnableValue ;
            RegNextPc   <= `ZeorDate    ;
            RegNextOffset<= 5'd0        ;
            RegNextType <= 3'd0         ;
            RegNextMode <= 1'b0         ;
            RegNextHitBn<= 2'd0         ;
        end
        else if(InstPcAble) begin
            RegNextAble <= `AbleValue ;
            RegNextPc   <= (HitDate[34:32] == `TypeBRANCH) ? (((HitDate[38] + HitDate[37] + HitDate[36] + HitDate[35]) > 2) ? HitDate[31:0] : ({InstPc[31:5],5'd0} + 32'd32)) : HitDate[31:0] ;
            RegNextOffset<= InstPc[4:0]  ;
            RegNextType <= HitDate[34:32] ;
            RegNextMode <= (HitDate[34:32] == `TypeBRANCH) & ((HitDate[38] + HitDate[37] + HitDate[36] + HitDate[35]) > 2) ;
            RegNextHitBn<= HitBan0Able ? 2'b01 :
                           HitBan1Able ? 2'b10 : 2'b00 ;                   
        end
        else begin
            RegNextAble <= `EnableValue ;
            RegNextPc   <= `ZeorDate    ;
            RegNextOffset<= 5'd0        ;
            RegNextType <= 3'd0         ;
            RegNextMode <= 1'b0         ;
            RegNextHitBn<= 2'd0         ;
        end
    end

    assign InstNextAble = RegNextAble ;
    assign InstNextPc   = RegNextPc   ;
    assign InstNextOffset= RegNextOffset;
    assign InstNextType = RegNextType ;
    assign InstNextMode = RegNextMode ;
    assign InstHitBanN  = RegNextHitBn;


    //for write

    wire  UpDateChiose0 = (UpAbleBank == 2'b01) | ((UpAbleBank == 2'b00) & (CountBan0[UpPc[12:5]] >= CountBan1[UpPc[12:5]])) ;
    wire  UpDateChiose1 = (UpAbleBank == 2'b10) | ((UpAbleBank == 2'b00) & (CountBan0[UpPc[12:5]] <  CountBan1[UpPc[12:5]])) ;


    integer ii  ;
    always @(posedge Clk) begin
        if(!Rest) begin
            for (ii =0 ;ii<32 ;ii=ii+1 ) begin
                BtbRamBank0[ii] <= 59'd0 ;
                BtbRamBank1[ii] <= 59'd0 ;
                BtbRamBank0[ii+32] <= 59'd0 ;
                BtbRamBank1[ii+32] <= 59'd0 ;
                BtbRamBank0[ii+64] <= 59'd0 ;
                BtbRamBank1[ii+64] <= 59'd0 ;
                BtbRamBank0[ii+96] <= 59'd0 ;
                BtbRamBank1[ii+96] <= 59'd0 ;
                BtbRamBank0[ii+128] <= 59'd0 ;
                BtbRamBank1[ii+128] <= 59'd0 ;
                BtbRamBank0[ii+160] <= 59'd0 ;
                BtbRamBank1[ii+160] <= 59'd0 ;
                BtbRamBank0[ii+192] <= 59'd0 ;
                BtbRamBank1[ii+192] <= 59'd0 ;
                BtbRamBank0[ii+224] <= 59'd0 ;
                BtbRamBank1[ii+224] <= 59'd0 ;
            end
        end
        else begin
            BtbRamBank0[UpPc[12:5]] <= (UpDateChiose0 & UpAble & ~StopTemp) ? (~{1'b1,{19{1'b1}},{4{UpCntAble}},{3{BtbUpTypeAble}},{32{BtbUpTagetAble}}} & BtbRamBank0[UpPc[12:5]]) |
                                                       ({1'b1,{19{1'b1}},{4{UpCntAble}},{3{BtbUpTypeAble}},{32{BtbUpTagetAble}}} & {`AbleValue,UpPc[31:13],UpCnt,BtbUpType,BtbUpTaget}) : BtbRamBank0[UpPc[12:5]] ;
            BtbRamBank1[UpPc[12:5]] <= (UpDateChiose1 & UpAble & ~StopTemp) ? (~{1'b1,{19{1'b1}},{4{UpCntAble}},{3{BtbUpTypeAble}},{32{BtbUpTagetAble}}} & BtbRamBank1[UpPc[12:5]]) |
                                                       ({1'b1,{19{1'b1}},{4{UpCntAble}},{3{BtbUpTypeAble}},{32{BtbUpTagetAble}}} & {`AbleValue,UpPc[31:13],UpCnt,BtbUpType,BtbUpTaget}) : BtbRamBank1[UpPc[12:5]] ;
            BtbRamBank0[InstPc[12:5]][38:35] <= (HitBan0Able  & ~StopTemp) ?  {BtbRamBank0[InstPc[12:5]][37:35],((HitDate[38] + HitDate[37] + HitDate[36] + HitDate[35]) > 2)} : BtbRamBank0[InstPc[12:5]][38:35] ;
            BtbRamBank1[InstPc[12:5]][38:35] <= (HitBan1Able  & ~StopTemp) ?  {BtbRamBank1[InstPc[12:5]][37:35],((HitDate[38] + HitDate[37] + HitDate[36] + HitDate[35]) > 2)} : BtbRamBank1[InstPc[12:5]][38:35] ;
        end
    end


endmodule
`timescale 1ps/1ps
`include "../define.v"
`include "../../Lib/FIFO_ftq.v"

module FTQ (
    input       wire                           Clk          ,
    input       wire                           Rest         ,
    //from ctrl 
    input       wire                           FTQStop      ,
    input       wire                           FTQFlash     ,
    input       wire                           FTQreq       ,
    //from ROB 
    input       wire                           ROBBranch    ,
    input       wire                           ROBBranchYN  ,//right = 1 fault = 0 
    input       wire       [`InstAddrBus]      ROBBranchPc  ,
    //from PreDecode  
    input       wire                           PredictAble  ,
    input       wire       [2:0]               PredictJdate ,
    input       wire       [2:0]               PredictNum   ,
    input       wire       [2:0]               PredictInt1  ,
    input       wire       [2:0]               PredictInt2  ,
    input       wire       [2:0]               PredictInt3  ,
    input       wire       [2:0]               PredictInt4  ,
    input       wire       [2:0]               PredictInt5  ,
    input       wire       [2:0]               PredictInt6  ,
    //to tage 
    output      wire       [`InstAddrBus]      OutUpDatePc  ,
    output      wire                           OutDateAble  ,
    output      wire       [2:0]               OutUpDate    ,
    output      wire       [2:0]               OutUpNum     ,
    output      wire       [2:0]               OutUpCnt     ,
    output      wire                           NewDateAble  ,
    output      wire       [2:0]               NewUpDate    ,
    output      wire       [2:0]               NewUpNum     ,
    output      wire       [2:0]               NewUpCnt     ,
    output      wire                           NewCnt1Able  ,
    output      wire       [2:0]               NewCnt1Date  ,
    output      wire                           NewCnt2Able  ,
    output      wire       [2:0]               NewCnt2Date  ,  
    output      wire                           NewCnt3Able  ,
    output      wire       [2:0]               NewCnt3Date  ,  
    output      wire                           NewCnt4Able  ,
    output      wire       [2:0]               NewCnt4Date  , 
    output      wire                           NewCnt5Able  ,
    output      wire       [2:0]               NewCnt5Date  ,  
    output      wire                           NewCnt6Able  ,
    output      wire       [2:0]               NewCnt6Date  

);
    
    wire        WriteAble = ~FTQStop & PredictAble ;
                            //|23  21|20  18|17  15|14 12|11  9|8  6|5  3|2  0|
    wire [23:0] WriteDate = {PredictNum,PredictJdate,PredictInt6,PredictInt5,PredictInt4,PredictInt3,PredictInt2,PredictInt1} ;

    wire [23:0] reOutDate ;

    FIFO_ftq#(
        .FIFOWIDE    ( 24 )
    )u_FIFO_ftq(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .Rable       ( ROBBranch   ),
        .FifoPreOut  ( reOutDate  ),
        .Wable       ( WriteAble   ),
        .Din         ( WriteDate   ),
        .FifoClean   ( FTQFlash    ),
        .FifoFull    ( FTQreq      )
    );

    wire [2:0] PredictUset1 = reOutDate[2:0]   ;
    wire [2:0] PredictUset2 = reOutDate[5:3]   ;
    wire [2:0] PredictUset3 = reOutDate[8:6]   ;
    wire [2:0] PredictUset4 = reOutDate[11:9]  ;
    wire [2:0] PredictUset5 = reOutDate[14:12] ;
    wire [2:0] PredictUset6 = reOutDate[17:15] ;

    wire [2:0] PreDictCnt  =  {3{(reOutDate[23:21] == 0)}} & 3'd0         |
                              {3{(reOutDate[23:21] == 1)}} & PredictUset1 |
                              {3{(reOutDate[23:21] == 2)}} & PredictUset2 |
                              {3{(reOutDate[23:21] == 3)}} & PredictUset3 |
                              {3{(reOutDate[23:21] == 4)}} & PredictUset4 |
                              {3{(reOutDate[23:21] == 5)}} & PredictUset5 |
                              {3{(reOutDate[23:21] == 6)}} & PredictUset6 ;

    wire Cnt0Able = ~ROBBranchYN & (reOutDate[23:21] == 0) & (PredictUset1 != 0) & (PredictUset2 != 0) & (PredictUset3 != 0) & (PredictUset4 != 0) & (PredictUset5 != 0) & (PredictUset6 != 0) ;
    wire Cnt1Able = ~ROBBranchYN & (reOutDate[23:21] == 1) & (PredictUset2 != 0) & (PredictUset3 != 0) & (PredictUset4 != 0) & (PredictUset5 != 0) & (PredictUset6 != 0) ;
    wire Cnt2Able = ~ROBBranchYN & (reOutDate[23:21] == 2) & (PredictUset3 != 0) & (PredictUset4 != 0) & (PredictUset5 != 0) & (PredictUset6 != 0) ;
    wire Cnt3Able = ~ROBBranchYN & (reOutDate[23:21] == 3) & (PredictUset4 != 0) & (PredictUset5 != 0) & (PredictUset6 != 0) ;
    wire Cnt4Able = ~ROBBranchYN & (reOutDate[23:21] == 4) & (PredictUset5 != 0) & (PredictUset6 != 0) ;
    wire Cnt5Able = ~ROBBranchYN & (reOutDate[23:21] == 5) & (PredictUset6 != 0) ;

    wire Num1CntAble = ~ROBBranchYN & (PredictUset1 == 0) ;
    wire Num2CntAble = ~ROBBranchYN & (PredictUset2 == 0) ;
    wire Num3CntAble = ~ROBBranchYN & (PredictUset3 == 0) ;
    wire Num4CntAble = ~ROBBranchYN & (PredictUset4 == 0) ;
    wire Num5CntAble = ~ROBBranchYN & (PredictUset5 == 0) ;
    wire Num6CntAble = ~ROBBranchYN & (PredictUset6 == 0) ;

    assign NewCnt1Able = Cnt0Able ;
    assign NewCnt1Date = PredictUset1-1 ;
    assign NewCnt2Able = Cnt0Able | Cnt1Able ;
    assign NewCnt2Date = PredictUset2-1 ;
    assign NewCnt3Able = Cnt0Able | Cnt1Able | Cnt2Able ;
    assign NewCnt3Date = PredictUset3-1 ;
    assign NewCnt4Able = Cnt0Able | Cnt1Able | Cnt2Able | Cnt3Able ;
    assign NewCnt4Date = PredictUset4-1 ;
    assign NewCnt5Able = Cnt0Able | Cnt1Able | Cnt2Able | Cnt3Able | Cnt4Able ;
    assign NewCnt5Date = PredictUset5-1 ;
    assign NewCnt6Able = Cnt0Able | Cnt1Able | Cnt2Able | Cnt3Able | Cnt4Able | Cnt5Able ;
    assign NewCnt6Date = PredictUset6-1 ;
    

    wire [2:0] NewNum  ;
    wire [2:0] NewDate ;
    wire       NewAble ;
    assign {NewAble,NewNum,NewDate}= {7{(reOutDate[23:21] == 0)}} & ({7{Num1CntAble}}&{1'b1,3'd1,((reOutDate[20:18] < 3'b100) ? 3'b100 : 3'b000)} | 
                                                                     {7{Num2CntAble}}&{1'b1,3'd2,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} | 
                                                                     {7{Num3CntAble}}&{1'b1,3'd3,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} | 
                                                                     {7{Num4CntAble}}&{1'b1,3'd4,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} | 
                                                                     {7{Num5CntAble}}&{1'b1,3'd5,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} | 
                                                                     {7{Num6CntAble}}&{1'b1,3'd6,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} ) | 
                                     {7{(reOutDate[23:21] == 1)}} & ({7{Num2CntAble}}&{1'b1,3'd2,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} | 
                                                                     {7{Num3CntAble}}&{1'b1,3'd3,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} | 
                                                                     {7{Num4CntAble}}&{1'b1,3'd4,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} | 
                                                                     {7{Num5CntAble}}&{1'b1,3'd5,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} | 
                                                                     {7{Num6CntAble}}&{1'b1,3'd6,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} ) | 
                                     {7{(reOutDate[23:21] == 2)}} & ({7{Num3CntAble}}&{1'b1,3'd3,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} | 
                                                                     {7{Num4CntAble}}&{1'b1,3'd4,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} | 
                                                                     {7{Num5CntAble}}&{1'b1,3'd5,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} | 
                                                                     {7{Num6CntAble}}&{1'b1,3'd6,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} ) | 
                                     {7{(reOutDate[23:21] == 3)}} & ({7{Num4CntAble}}&{1'b1,3'd4,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} | 
                                                                     {7{Num5CntAble}}&{1'b1,3'd5,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} | 
                                                                     {7{Num6CntAble}}&{1'b1,3'd6,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} ) | 
                                     {7{(reOutDate[23:21] == 4)}} & ({7{Num5CntAble}}&{1'b1,3'd5,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} | 
                                                                     {7{Num6CntAble}}&{1'b1,3'd6,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} ) | 
                                     {7{(reOutDate[23:21] == 5)}} & ({7{Num6CntAble}}&{1'b1,3'd6,((reOutDate[20:18] < 3'b100)  ? 3'b100 : 3'b000)} ) ;

    assign OutDateAble = ROBBranch   ;
    assign OutUpDatePc = ROBBranchPc ;
    assign OutUpNum    = reOutDate[23:21] ;
    assign OutUpDate   = ROBBranchMo ? ((reOutDate[20:18] == 0) ? reOutDate[20:18] : reOutDate[20:18] + 1) : 
                                       ((reOutDate[20:18] == 0) ? reOutDate[20:18] : reOutDate[20:18] - 1) ;
    assign OutUpCnt    = ROBBranchYN ? ((PreDictCnt == 0) ? PreDictCnt : PreDictCnt + 1) :
                                       ((PreDictCnt == 0) ? PreDictCnt : PreDictCnt - 1) ;
    assign NewDateAble = NewAble ;
    assign NewUpDate   = NewDate ;
    assign NewUpCnt    = 3'd0    ;
    assign NewUpNum    = NewNum  ;


endmodule
`timescale 1ps/1ps
`include "../define.v"

module Pc (
    input          wire                                    Clk            ,
    input          wire                                    Rest           ,
    //from ctrl
    input          wire                                    PcStop         , //stop also include icache req stop
    //from btb
    input          wire                                    BtbPredictAble ,
    input          wire          [`InstAddrBus]            BtbPreDictPc   ,
    //from predecode 
    input          wire                                    PreReDirAble   ,
    input          wire          [`InstAddrBus]            PreReDirPc     ,
    //from ROb
    input          wire                                    RobReDirAble   ,
    input          wire          [`InstAddrBus]            RobReDirPc     ,
    //to ICache and bpu
    output         wire                                    PcAble         ,
    output         wire          [`InstAddrBus]            PcDate                        
);

    reg [`InstAddrBus] RegPc      ;
    reg                RegAble    ;

    always @(posedge Clk) begin
        if(!Rest) begin
            RegPc   <= `_Entry      ;
            RegAble <= `EnableValue ;
        end
        else begin
            if(BtbPredictAble) begin
                RegPc   <= BtbPreDictPc  ;
                RegAble <= `AbleValue    ;
            end
            if(PcStop) begin
                RegPc   <= RegPc        ;
                RegAble <= RegAble      ;
            end
            if(PreReDirAble) begin
                RegPc   <= PreReDirPc    ; 
                RegAble <= `AbleValue    ;
            end
            if(RobReDirAble) begin
                RegPc   <= RobReDirPc    ;
                RegAble <= `AbleValue    ;
            end
        end
    end

    assign PcDate          = RegPc      ;
    assign PcAble          = RegAble    ;

    
endmodule  
`timescale 1ps/1ps
`include "../define.v"

module PreDecode (
    input          wire                                        Clk                ,
    input          wire                                        Rest               ,
    //in form Ctrll Block
    input          wire                                        PreDecodeFlash     ,   
    input          wire                                        PreDecodeStop      , 
    //from Btb
    input          wire                                        BtbAble            ,
    input          wire           [1:0]                        BtbBanKN           ,
    input          wire           [2:0]                        BtbType            ,
    input          wire           [`InstAddrBus]               BtbPc              ,
    //from Ras
    input          wire                                        RasAble            ,
    input          wire           [`InstAddrBus]               RasPc              ,
    //from tage
    input          wire                                        TageAble           ,
    input          wire                                        TageMode           ,
    input          wire           [2:0]                        TageJdate          ,
    input          wire           [2:0]                        TageNum            ,
    input          wire           [2:0]                        TageInt1           ,
    input          wire           [2:0]                        TageInt2           ,
    input          wire           [2:0]                        TageInt3           ,
    input          wire           [2:0]                        TageInt4           ,
    input          wire           [2:0]                        TageInt5           ,
    input          wire           [2:0]                        TageInt6           ,
    //from Icache 
    input          wire                                        FetchAble          ,
    input          wire           [255:0]                      FetchPcIvt         ,
    input          wire           [7:0]                        FetchInstIvt       ,
    input          wire           [255:0]                      FetchDate          ,
    //to pc 
    output         wire                                        PreReDirectAble    ,
    output         wire           [`InstAddrBus]               PreReDirectPc      ,
    //to btb
    output         wire                                        BtbUpPcAble        ,
    output         wire           [`InstAddrBus]               BtbUpPc            ,
    output         wire           [1:0]                        BtbUpBanKN         ,
    output         wire                                        BtbUpTypeAble      ,
    output         wire           [2:0]                        BtbUpType          ,
    output         wire                                        BtbUpTagetAble     ,
    output         wire           [`InstAddrBus]               BtbUpTaget         ,
    //to ras
    output         wire                                        RasUpAble          ,
    output         wire           [1:0]                        RasPtrType         ,
    output         wire           [`InstAddrBus]               RasAddrDate        ,
    //to tage      
    output         wire                                        TageUpAble         ,
    //to ftq
    output         wire                                        PredAble           ,
    output         wire           [2:0]                        PredJdate          ,
    output         wire           [2:0]                        PredNum            ,
    output         wire           [2:0]                        PredInt1           ,
    output         wire           [2:0]                        PredInt2           ,
    output         wire           [2:0]                        PredInt3           ,
    output         wire           [2:0]                        PredInt4           ,
    output         wire           [2:0]                        PredInt5           ,
    output         wire           [2:0]                        PredInt6           ,
    //to InstBuffer 
    output         wire                                        ToIbInst1Able      ,
    output         wire                                        ToIbInst1Mode      ,
    output         wire           [`InstAddrBus]               ToIbInst1Pc        ,
    output         wire           [`InstAddrBus]               ToIbInst1Redir     ,
    output         wire           [`InstDateBus]               ToIbInst1Date      ,   
    output         wire                                        ToIbInst2Able      ,
    output         wire                                        ToIbInst2Mode      ,
    output         wire           [`InstAddrBus]               ToIbInst2Pc        ,
    output         wire           [`InstAddrBus]               ToIbInst2Redir     ,
    output         wire           [`InstDateBus]               ToIbInst2Date      , 
    output         wire                                        ToIbInst3Able      ,
    output         wire                                        ToIbInst3Mode      ,
    output         wire           [`InstAddrBus]               ToIbInst3Pc        ,
    output         wire           [`InstAddrBus]               ToIbInst3Redir     ,
    output         wire           [`InstDateBus]               ToIbInst3Date      ,                   
    output         wire                                        ToIbInst4Able      ,
    output         wire                                        ToIbInst4Mode      ,
    output         wire           [`InstAddrBus]               ToIbInst4Pc        ,
    output         wire           [`InstAddrBus]               ToIbInst4Redir     ,
    output         wire           [`InstDateBus]               ToIbInst4Date      , 
    output         wire                                        ToIbInst5Able      ,
    output         wire                                        ToIbInst5Mode      ,
    output         wire           [`InstAddrBus]               ToIbInst5Pc        ,
    output         wire           [`InstAddrBus]               ToIbInst5Redir     ,
    output         wire           [`InstDateBus]               ToIbInst5Date      , 
    output         wire                                        ToIbInst6Able      ,
    output         wire                                        ToIbInst6Mode      ,
    output         wire           [`InstAddrBus]               ToIbInst6Pc        ,
    output         wire           [`InstAddrBus]               ToIbInst6Redir     ,
    output         wire           [`InstDateBus]               ToIbInst6Date      , 
    output         wire                                        ToIbInst7Able      ,
    output         wire                                        ToIbInst7Mode      ,
    output         wire           [`InstAddrBus]               ToIbInst7Pc        ,
    output         wire           [`InstAddrBus]               ToIbInst7Redir     ,
    output         wire           [`InstDateBus]               ToIbInst7Date      , 
    output         wire                                        ToIbInst8Able      ,
    output         wire                                        ToIbInst8Mode      ,
    output         wire           [`InstAddrBus]               ToIbInst8Pc        ,
    output         wire           [`InstAddrBus]               ToIbInst8Redir     ,
    output         wire           [`InstDateBus]               ToIbInst8Date      
);  


    wire  [`InstDateBus] PreDecodeInst1 = FetchDate[32*8-1:32*7] ;
    wire  [`InstDateBus] PreDecodeInst2 = FetchDate[32*7-1:32*6] ;
    wire  [`InstDateBus] PreDecodeInst3 = FetchDate[32*6-1:32*5] ;
    wire  [`InstDateBus] PreDecodeInst4 = FetchDate[32*5-1:32*4] ;
    wire  [`InstDateBus] PreDecodeInst5 = FetchDate[32*4-1:32*3] ;
    wire  [`InstDateBus] PreDecodeInst6 = FetchDate[32*3-1:32*2] ;
    wire  [`InstDateBus] PreDecodeInst7 = FetchDate[32*2-1:32*1] ;
    wire  [`InstDateBus] PreDecodeInst8 = FetchDate[32*1-1:0] ;

    wire [`InstAddrBus] InstPc  [1:8] ;

    assign InstPc[1] = FetchPcIvt[32*8-1:32*7] ;
    assign InstPc[2] = FetchPcIvt[32*7-1:32*6] ;
    assign InstPc[3] = FetchPcIvt[32*6-1:32*5] ;
    assign InstPc[4] = FetchPcIvt[32*5-1:32*4] ;
    assign InstPc[5] = FetchPcIvt[32*4-1:32*3] ;
    assign InstPc[6] = FetchPcIvt[32*3-1:32*2] ;
    assign InstPc[7] = FetchPcIvt[32*2-1:32*1] ;
    assign InstPc[8] = FetchPcIvt[32*1-1:0] ;

    wire [2:0]          InstType[0:8] ;
    wire [25:0]         InstPreA[1:8] ;

    assign   InstType[0] = `TypeFORMAL ;

    assign   InstType[1] = {3{((PreDecodeInst1[31:26] == 6'b010011) & (PreDecodeInst1[9:5] == 5'd1) & (PreDecodeInst1[4:0] == 5'd0))}} & `TypeRTURN   | 
                           {3{((PreDecodeInst1[31:26] == 6'b010011) & (PreDecodeInst1[4:0] == 5'd1))}}                                 & `TypeCALL    |
                           {3{((PreDecodeInst1[31:26] == 6'b010100) | (PreDecodeInst1[31:26] == 6'b010101))}}                          & `TypeDIRECTB |
                           {3{((PreDecodeInst1[31:26] == 6'b010110) | (PreDecodeInst1[31:26] == 6'b010111) | (PreDecodeInst1[31:26] == 6'b011000)     |
                               (PreDecodeInst1[31:26] == 6'b011001) | (PreDecodeInst1[31:26] == 6'b011010) | (PreDecodeInst1[31:26] == 6'b011011))}} & `TypeBRANCH ;

    assign   InstPreA[1] = {PreDecodeInst1[9:0],PreDecodeInst1[25:10]} ;

    assign   InstType[2] = {3{((PreDecodeInst2[31:26] == 6'b010011) & (PreDecodeInst2[9:5] == 5'd1) & (PreDecodeInst2[4:0] == 5'd0))}} & `TypeRTURN   | 
                           {3{((PreDecodeInst2[31:26] == 6'b010011) & (PreDecodeInst2[4:0] == 5'd1))}}                                 & `TypeCALL    |
                           {3{((PreDecodeInst2[31:26] == 6'b010100) | (PreDecodeInst2[31:26] == 6'b010101))}}                          & `TypeDIRECTB |
                           {3{((PreDecodeInst2[31:26] == 6'b010110) | (PreDecodeInst2[31:26] == 6'b010111) | (PreDecodeInst2[31:26] == 6'b011000)     |
                               (PreDecodeInst2[31:26] == 6'b011001) | (PreDecodeInst2[31:26] == 6'b011010) | (PreDecodeInst2[31:26] == 6'b011011))}} & `TypeBRANCH ;
                            
    assign   InstPreA[2] = {PreDecodeInst2[9:0],PreDecodeInst2[25:10]} ;

    assign   InstType[3] = {3{((PreDecodeInst3[31:26] == 6'b010011) & (PreDecodeInst3[9:5] == 5'd1) & (PreDecodeInst3[4:0] == 5'd0))}} & `TypeRTURN   | 
                           {3{((PreDecodeInst3[31:26] == 6'b010011) & (PreDecodeInst3[4:0] == 5'd1))}}                                 & `TypeCALL    |
                           {3{((PreDecodeInst3[31:26] == 6'b010100) | (PreDecodeInst3[31:26] == 6'b010101))}}                          & `TypeDIRECTB |
                           {3{((PreDecodeInst3[31:26] == 6'b010110) | (PreDecodeInst3[31:26] == 6'b010111) | (PreDecodeInst3[31:26] == 6'b011000)     |
                               (PreDecodeInst3[31:26] == 6'b011001) | (PreDecodeInst3[31:26] == 6'b011010) | (PreDecodeInst3[31:26] == 6'b011011))}} & `TypeBRANCH ;

    assign   InstPreA[3] = {PreDecodeInst3[9:0],PreDecodeInst3[25:10]} ;

    assign   InstType[4] = {3{((PreDecodeInst4[31:26] == 6'b010011) & (PreDecodeInst4[9:5] == 5'd1) & (PreDecodeInst4[4:0] == 5'd0))}} & `TypeRTURN   | 
                           {3{((PreDecodeInst4[31:26] == 6'b010011) & (PreDecodeInst4[4:0] == 5'd1))}}                                 & `TypeCALL    |
                           {3{((PreDecodeInst4[31:26] == 6'b010100) | (PreDecodeInst4[31:26] == 6'b010101))}}                          & `TypeDIRECTB |
                           {3{((PreDecodeInst4[31:26] == 6'b010110) | (PreDecodeInst4[31:26] == 6'b010111) | (PreDecodeInst4[31:26] == 6'b011000)     |
                               (PreDecodeInst4[31:26] == 6'b011001) | (PreDecodeInst4[31:26] == 6'b011010) | (PreDecodeInst4[31:26] == 6'b011011))}} & `TypeBRANCH ;

    assign   InstPreA[4] = {PreDecodeInst4[9:0],PreDecodeInst4[25:10]} ;

    assign   InstType[5] = {3{((PreDecodeInst5[31:26] == 6'b010011) & (PreDecodeInst5[9:5] == 5'd1) & (PreDecodeInst5[4:0] == 5'd0))}} & `TypeRTURN   | 
                           {3{((PreDecodeInst5[31:26] == 6'b010011) & (PreDecodeInst5[4:0] == 5'd1))}}                                 & `TypeCALL    |
                           {3{((PreDecodeInst5[31:26] == 6'b010100) | (PreDecodeInst5[31:26] == 6'b010101))}}                          & `TypeDIRECTB |
                           {3{((PreDecodeInst5[31:26] == 6'b010110) | (PreDecodeInst5[31:26] == 6'b010111) | (PreDecodeInst5[31:26] == 6'b011000)     |
                               (PreDecodeInst5[31:26] == 6'b011001) | (PreDecodeInst5[31:26] == 6'b011010) | (PreDecodeInst5[31:26] == 6'b011011))}} & `TypeBRANCH ;
    assign   InstPreA[5] = {PreDecodeInst5[9:0],PreDecodeInst5[25:10]} ;

    assign   InstType[6] = {3{((PreDecodeInst6[31:26] == 6'b010011) & (PreDecodeInst6[9:5] == 5'd1) & (PreDecodeInst6[4:0] == 5'd0))}} & `TypeRTURN   | 
                           {3{((PreDecodeInst6[31:26] == 6'b010011) & (PreDecodeInst6[4:0] == 5'd1))}}                                 & `TypeCALL    |
                           {3{((PreDecodeInst6[31:26] == 6'b010100) | (PreDecodeInst6[31:26] == 6'b010101))}}                          & `TypeDIRECTB |
                           {3{((PreDecodeInst6[31:26] == 6'b010110) | (PreDecodeInst6[31:26] == 6'b010111) | (PreDecodeInst6[31:26] == 6'b011000)     |
                               (PreDecodeInst6[31:26] == 6'b011001) | (PreDecodeInst6[31:26] == 6'b011010) | (PreDecodeInst6[31:26] == 6'b011011))}} & `TypeBRANCH ;

    assign   InstPreA[6] = {PreDecodeInst6[9:0],PreDecodeInst6[25:10]} ;
 
    assign   InstType[7] = {3{((PreDecodeInst7[31:26] == 6'b010011) & (PreDecodeInst7[9:5] == 5'd1) & (PreDecodeInst7[4:0] == 5'd0))}} & `TypeRTURN   | 
                           {3{((PreDecodeInst7[31:26] == 6'b010011) & (PreDecodeInst7[4:0] == 5'd1))}}                                 & `TypeCALL    |
                           {3{((PreDecodeInst7[31:26] == 6'b010100) | (PreDecodeInst7[31:26] == 6'b010101))}}                          & `TypeDIRECTB |
                           {3{((PreDecodeInst7[31:26] == 6'b010110) | (PreDecodeInst7[31:26] == 6'b010111) | (PreDecodeInst7[31:26] == 6'b011000)     |
                               (PreDecodeInst7[31:26] == 6'b011001) | (PreDecodeInst7[31:26] == 6'b011010) | (PreDecodeInst7[31:26] == 6'b011011))}} & `TypeBRANCH ;
    assign   InstPreA[7] = {PreDecodeInst7[9:0],PreDecodeInst7[25:10]} ;

    assign   InstType[8] = {3{((PreDecodeInst8[31:26] == 6'b010011) & (PreDecodeInst8[9:5] == 5'd1) & (PreDecodeInst8[4:0] == 5'd0))}} & `TypeRTURN   | 
                           {3{((PreDecodeInst8[31:26] == 6'b010011) & (PreDecodeInst8[4:0] == 5'd1))}}                                 & `TypeCALL    |
                           {3{((PreDecodeInst8[31:26] == 6'b010100) | (PreDecodeInst8[31:26] == 6'b010101))}}                          & `TypeDIRECTB |
                           {3{((PreDecodeInst8[31:26] == 6'b010110) | (PreDecodeInst8[31:26] == 6'b010111) | (PreDecodeInst8[31:26] == 6'b011000)     |
                               (PreDecodeInst8[31:26] == 6'b011001) | (PreDecodeInst8[31:26] == 6'b011010) | (PreDecodeInst8[31:26] == 6'b011011))}} & `TypeBRANCH ;
    assign   InstPreA[8] = {PreDecodeInst8[9:0],PreDecodeInst8[25:10]} ;

    wire [3:0] JumpInstNum = ((InstType[1] != `TypeFORMAL) | ~FetchInstIvt[1]) ? 4'd1 :
                             ((InstType[2] != `TypeFORMAL) | ~FetchInstIvt[2]) ? 4'd2 :
                             ((InstType[3] != `TypeFORMAL) | ~FetchInstIvt[3]) ? 4'd3 :
                             ((InstType[4] != `TypeFORMAL) | ~FetchInstIvt[4]) ? 4'd4 :
                             ((InstType[5] != `TypeFORMAL) | ~FetchInstIvt[5]) ? 4'd5 :
                             ((InstType[6] != `TypeFORMAL) | ~FetchInstIvt[6]) ? 4'd6 :
                             ((InstType[7] != `TypeFORMAL) | ~FetchInstIvt[7]) ? 4'd7 :
                             ((InstType[8] != `TypeFORMAL) ) ? 4'd8 : 4'd0 ; 

    wire  TypeFault = (BtbType != InstType[JumpInstNum]) & BtbAble ; 
    wire  TagetFault1 = (InstType[JumpInstNum] == `TypeDIRECTB) & (({6'd0,InstPreA[JumpInstNum]} + InstPc[JumpInstNum]  != BtbPc)) & BtbAble ;   // use update 
    wire  TagetFault2 = (InstType[JumpInstNum] == `TypeRTURN)   & (RasPc != BtbPc) & RasAble & BtbAble ; 
    wire  TagetFault3 = (InstType[JumpInstNum] == `TypeBRANCH)  & (({16'd0,InstPreA[JumpInstNum][15:0]} + InstPc[JumpInstNum] != BtbPc) & TageMode) & TageAble & BtbAble ; 
    wire  TagetFault4 = (InstType[JumpInstNum] == `TypeBRANCH)  & ((32'd4 + InstPc[JumpInstNum] != BtbPc) & ~TageMode) & TageAble & BtbAble ;
    wire  TagetFault5 = (InstType[JumpInstNum] == `TypeFORMAL)  & (({InstPc[JumpInstNum][31:5],5'd0} + 32'd32) != BtbPc) & BtbAble ;

    wire [`InstAddrBus] ReviseAddr ={32{TagetFault1}} & ({6'd0,InstPreA[JumpInstNum]} + InstPc[JumpInstNum]) | 
                                    {32{TagetFault2}} & RasPc                 |
                                    {32{TagetFault3}} & ({16'd0,InstPreA[JumpInstNum][15:0]} + InstPc[JumpInstNum])  |
                                    {32{TagetFault4}} & (32'd4 + InstPc[JumpInstNum])  | 
                                    {32{TagetFault5}} & ({InstPc[JumpInstNum][31:5],5'd0} + 32'd32); 


    reg                  RegPreReDirectAble  ;
    reg [`InstAddrBus]   RegPreReDirectPc    ;
    reg                  RegBtbUpPcAble      ;
    reg [`InstAddrBus]   RegBtbUpPc          ;
    reg [1:0]            RegBtbUpBanKN       ;
    reg                  RegBtbUpTypeAble    ;
    reg [2:0]            RegBtbUpType        ;
    reg                  RegBtbUpTagetAble   ;
    reg [`InstAddrBus]   RegBtbUpTaget       ;
    reg                  RegRasUpAble        ;
    reg [1:0]            RegRasPtrType       ;
    reg [`InstAddrBus]   RegRasAddrDate      ;
    reg                  RegTageUpAble       ;
    reg                  RegPredAble         ;
    reg [2:0]            RegPredJdate        ;
    reg [2:0]            RegPredNum          ;
    reg [2:0]            RegPredInt1         ;
    reg [2:0]            RegPredInt2         ;
    reg [2:0]            RegPredInt3         ;
    reg [2:0]            RegPredInt4         ;
    reg [2:0]            RegPredInt5         ;
    reg [2:0]            RegPredInt6         ;
    reg                  RToIbInst1Able      ;
    reg                  RToIbInst1Mode      ;
    reg [`InstAddrBus]   RToIbInst1Pc        ;
    reg [`InstAddrBus]   RToIbInst1Redir     ;
    reg [`InstDateBus]   RToIbInst1Date      ;
    reg                  RToIbInst2Able      ;
    reg                  RToIbInst2Mode      ;
    reg [`InstAddrBus]   RToIbInst2Pc        ;
    reg [`InstAddrBus]   RToIbInst2Redir     ;
    reg [`InstDateBus]   RToIbInst2Date      ;
    reg                  RToIbInst3Able      ;
    reg                  RToIbInst3Mode      ;
    reg [`InstAddrBus]   RToIbInst3Pc        ;
    reg [`InstAddrBus]   RToIbInst3Redir     ;
    reg [`InstDateBus]   RToIbInst3Date      ;
    reg                  RToIbInst4Able      ;
    reg                  RToIbInst4Mode      ;
    reg [`InstAddrBus]   RToIbInst4Pc        ;
    reg [`InstAddrBus]   RToIbInst4Redir     ;
    reg [`InstDateBus]   RToIbInst4Date      ;
    reg                  RToIbInst5Able      ;
    reg                  RToIbInst5Mode      ;
    reg [`InstAddrBus]   RToIbInst5Pc        ;
    reg [`InstAddrBus]   RToIbInst5Redir     ;
    reg [`InstDateBus]   RToIbInst5Date      ;
    reg                  RToIbInst6Able      ;
    reg                  RToIbInst6Mode      ;
    reg [`InstAddrBus]   RToIbInst6Pc        ;
    reg [`InstAddrBus]   RToIbInst6Redir     ;
    reg [`InstDateBus]   RToIbInst6Date      ;
    reg                  RToIbInst7Able      ;
    reg                  RToIbInst7Mode      ;
    reg [`InstAddrBus]   RToIbInst7Pc        ;
    reg [`InstAddrBus]   RToIbInst7Redir     ;
    reg [`InstDateBus]   RToIbInst7Date      ;
    reg                  RToIbInst8Able      ;
    reg                  RToIbInst8Mode      ;
    reg [`InstAddrBus]   RToIbInst8Pc        ;
    reg [`InstAddrBus]   RToIbInst8Redir     ;
    reg [`InstDateBus]   RToIbInst8Date      ;

    always @(posedge Clk) begin
        if(!Rest) begin
            RegPreReDirectAble  <= `EnableValue ;
            RegPreReDirectPc    <= `ZeorDate    ;
            RegBtbUpPcAble      <= `EnableValue ;
            RegBtbUpPc          <= `ZeorDate    ;
            RegBtbUpBanKN       <= 2'b0         ;
            RegBtbUpTypeAble    <= `EnableValue ;
            RegBtbUpType        <= 3'd0         ;
            RegBtbUpTagetAble   <= `EnableValue ;
            RegBtbUpTaget       <= `ZeorDate    ;
            RegRasUpAble        <= `EnableValue ;
            RegRasPtrType       <= 2'b0         ;
            RegRasAddrDate      <= `ZeorDate    ;
            RegTageUpAble       <= `EnableValue ;
            RegPredAble         <= `EnableValue ;
            RegPredJdate        <= 3'd0         ;
            RegPredNum          <= 3'd0         ;
            RegPredInt1         <= 3'd0         ;
            RegPredInt2         <= 3'd0         ;
            RegPredInt3         <= 3'd0         ;
            RegPredInt4         <= 3'd0         ;
            RegPredInt5         <= 3'd0         ;
            RegPredInt6         <= 3'd0         ;
            RToIbInst1Able      <= `EnableValue ;
            RToIbInst1Mode      <= `EnableValue ;
            RToIbInst1Pc        <= `ZeorDate    ;
            RToIbInst1Redir     <= `ZeorDate    ;
            RToIbInst1Date      <= `ZeorDate    ;
            RToIbInst2Able      <= `EnableValue ;
            RToIbInst2Mode      <= `EnableValue ;
            RToIbInst2Pc        <= `ZeorDate    ;
            RToIbInst2Redir     <= `ZeorDate    ;
            RToIbInst2Date      <= `ZeorDate    ;
            RToIbInst3Able      <= `EnableValue ;
            RToIbInst3Mode      <= `EnableValue ;
            RToIbInst3Pc        <= `ZeorDate    ;
            RToIbInst3Redir     <= `ZeorDate    ;
            RToIbInst3Date      <= `ZeorDate    ;
            RToIbInst4Able      <= `EnableValue ;
            RToIbInst4Mode      <= `EnableValue ;
            RToIbInst4Pc        <= `ZeorDate    ;
            RToIbInst4Redir     <= `ZeorDate    ;
            RToIbInst4Date      <= `ZeorDate    ;
            RToIbInst5Able      <= `EnableValue ;
            RToIbInst5Mode      <= `EnableValue ;
            RToIbInst5Pc        <= `ZeorDate    ;
            RToIbInst5Redir     <= `ZeorDate    ;
            RToIbInst5Date      <= `ZeorDate    ;
            RToIbInst6Able      <= `EnableValue ;
            RToIbInst6Mode      <= `EnableValue ;
            RToIbInst6Pc        <= `ZeorDate    ;
            RToIbInst6Redir     <= `ZeorDate    ;
            RToIbInst6Date      <= `ZeorDate    ;
            RToIbInst7Able      <= `EnableValue ;
            RToIbInst7Mode      <= `EnableValue ;
            RToIbInst7Pc        <= `ZeorDate    ;
            RToIbInst7Redir     <= `ZeorDate    ;
            RToIbInst7Date      <= `ZeorDate    ;
            RToIbInst8Able      <= `EnableValue ;
            RToIbInst8Mode      <= `EnableValue ;
            RToIbInst8Pc        <= `ZeorDate    ;
            RToIbInst8Redir     <= `ZeorDate    ;
            RToIbInst8Date      <= `ZeorDate    ;
        end
        else if(PreDecodeStop) begin
            RegPreReDirectAble  <= RegPreReDirectAble ;
            RegPreReDirectPc    <= RegPreReDirectPc   ;
            RegBtbUpPcAble      <= RegBtbUpPcAble     ;
            RegBtbUpPc          <= RegBtbUpPc         ;
            RegBtbUpBanKN       <= RegBtbUpBanKN      ;
            RegBtbUpTypeAble    <= RegBtbUpTypeAble   ;
            RegBtbUpType        <= RegBtbUpType       ;
            RegBtbUpTagetAble   <= RegBtbUpTagetAble  ;
            RegBtbUpTaget       <= RegBtbUpTaget      ;
            RegRasUpAble        <= RegRasUpAble       ;
            RegRasPtrType       <= RegRasPtrType      ;
            RegRasAddrDate      <= RegRasAddrDate     ;
            RegTageUpAble       <= RegTageUpAble      ;
            RegPredAble         <= RegPredAble        ;
            RegPredJdate        <= RegPredJdate       ;
            RegPredNum          <= RegPredNum         ;
            RegPredInt1         <= RegPredInt1        ;
            RegPredInt2         <= RegPredInt2        ;
            RegPredInt3         <= RegPredInt3        ;
            RegPredInt4         <= RegPredInt4        ;
            RegPredInt5         <= RegPredInt5        ;
            RegPredInt6         <= RegPredInt6        ;
            RToIbInst1Mode      <= RToIbInst1Able     ;
            RToIbInst1Pc        <= RToIbInst1Pc       ;
            RToIbInst1Redir     <= RToIbInst1Redir    ;
            RToIbInst1Date      <= RToIbInst1Date     ;
            RToIbInst2Able      <= RToIbInst2Able     ;
            RToIbInst2Mode      <= RToIbInst2Mode     ;
            RToIbInst2Pc        <= RToIbInst2Pc       ;
            RToIbInst2Redir     <= RToIbInst2Redir    ;
            RToIbInst2Date      <= RToIbInst2Date     ;
            RToIbInst3Able      <= RToIbInst3Able     ;
            RToIbInst3Mode      <= RToIbInst3Mode     ;
            RToIbInst3Pc        <= RToIbInst3Pc       ;
            RToIbInst3Date      <= RToIbInst3Date     ;
            RToIbInst4Able      <= RToIbInst4Able     ;
            RToIbInst4Mode      <= RToIbInst4Mode     ;
            RToIbInst4Pc        <= RToIbInst4Pc       ;
            RToIbInst4Redir     <= RToIbInst4Redir    ;
            RToIbInst4Date      <= RToIbInst4Date     ;
            RToIbInst5Able      <= RToIbInst5Able     ;
            RToIbInst5Mode      <= RToIbInst5Mode     ;
            RToIbInst5Pc        <= RToIbInst5Pc       ;
            RToIbInst5Redir     <= RToIbInst5Redir    ;
            RToIbInst5Date      <= RToIbInst5Date     ;
            RToIbInst6Able      <= RToIbInst6Able     ;
            RToIbInst6Mode      <= RToIbInst6Mode     ;
            RToIbInst6Pc        <= RToIbInst6Pc       ;
            RToIbInst6Redir     <= RToIbInst6Redir    ;
            RToIbInst6Date      <= RToIbInst6Date     ;
            RToIbInst7Able      <= RToIbInst7Able     ;
            RToIbInst7Mode      <= RToIbInst7Mode     ;
            RToIbInst7Pc        <= RToIbInst7Pc       ;
            RToIbInst7Redir     <= RToIbInst7Redir    ;
            RToIbInst7Date      <= RToIbInst7Date     ;
            RToIbInst8Able      <= RToIbInst8Able     ;
            RToIbInst8Mode      <= RToIbInst8Mode     ;
            RToIbInst8Pc        <= RToIbInst8Pc       ;
            RToIbInst8Redir     <= RToIbInst8Redir    ;
            RToIbInst8Date      <= RToIbInst8Date     ;
        end
        else if(PreDecodeFlash) begin
            RegPreReDirectAble  <= `EnableValue ;
            RegPreReDirectPc    <= `ZeorDate    ;
            RegBtbUpPcAble      <= `EnableValue ;
            RegBtbUpPc          <= `ZeorDate    ;
            RegBtbUpBanKN       <= 2'b0         ;
            RegBtbUpTypeAble    <= `EnableValue ;
            RegBtbUpType        <= 3'd0         ;
            RegBtbUpTagetAble   <= `EnableValue ;
            RegBtbUpTaget       <= `ZeorDate    ;
            RegRasUpAble        <= `EnableValue ;
            RegRasPtrType       <= 2'b0         ;
            RegRasAddrDate      <= `ZeorDate    ;
            RegTageUpAble       <= `EnableValue ;
            RegPredAble         <= `EnableValue ;
            RegPredJdate        <= 3'd0         ;
            RegPredNum          <= 3'd0         ;
            RegPredInt1         <= 3'd0         ;
            RegPredInt2         <= 3'd0         ;
            RegPredInt3         <= 3'd0         ;
            RegPredInt4         <= 3'd0         ;
            RegPredInt5         <= 3'd0         ;
            RegPredInt6         <= 3'd0         ;
            RToIbInst1Able      <= `EnableValue ;
            RToIbInst1Mode      <= `EnableValue ;
            RToIbInst1Pc        <= `ZeorDate    ;
            RToIbInst1Redir     <= `ZeorDate    ;
            RToIbInst1Date      <= `ZeorDate    ;
            RToIbInst2Able      <= `EnableValue ;
            RToIbInst2Mode      <= `EnableValue ;
            RToIbInst2Pc        <= `ZeorDate    ;
            RToIbInst2Redir     <= `ZeorDate    ;
            RToIbInst2Date      <= `ZeorDate    ;
            RToIbInst3Able      <= `EnableValue ;
            RToIbInst3Mode      <= `EnableValue ;
            RToIbInst3Pc        <= `ZeorDate    ;
            RToIbInst3Redir     <= `ZeorDate    ;
            RToIbInst3Date      <= `ZeorDate    ;
            RToIbInst4Able      <= `EnableValue ;
            RToIbInst4Mode      <= `EnableValue ;
            RToIbInst4Pc        <= `ZeorDate    ;
            RToIbInst4Redir     <= `ZeorDate    ;
            RToIbInst4Date      <= `ZeorDate    ;
            RToIbInst5Able      <= `EnableValue ;
            RToIbInst5Mode      <= `EnableValue ;
            RToIbInst5Pc        <= `ZeorDate    ;
            RToIbInst5Redir     <= `ZeorDate    ;
            RToIbInst5Date      <= `ZeorDate    ;
            RToIbInst6Able      <= `EnableValue ;
            RToIbInst6Mode      <= `EnableValue ;
            RToIbInst6Pc        <= `ZeorDate    ;
            RToIbInst6Redir     <= `ZeorDate    ;
            RToIbInst6Date      <= `ZeorDate    ;
            RToIbInst7Able      <= `EnableValue ;
            RToIbInst7Mode      <= `EnableValue ;
            RToIbInst7Pc        <= `ZeorDate    ;
            RToIbInst7Redir     <= `ZeorDate    ;
            RToIbInst7Date      <= `ZeorDate    ;
            RToIbInst8Able      <= `EnableValue ;
            RToIbInst8Mode      <= `EnableValue ;
            RToIbInst8Pc        <= `ZeorDate    ;
            RToIbInst8Redir     <= `ZeorDate    ;
            RToIbInst8Date      <= `ZeorDate    ;
        end
        else if(FetchAble) begin

            RegPreReDirectAble <= TagetFault1 | TagetFault2 | TagetFault3 | TagetFault4 | TagetFault5; 
            RegPreReDirectPc   <= ReviseAddr                                                         ;
            RegBtbUpPcAble     <= TypeFault | TagetFault1 | TagetFault2 | TagetFault3 | TagetFault4 | TagetFault5  ;
            RegBtbUpPc         <= InstPc[1]                                                          ;
            //RegBtbUpOfs        <= 
            RegBtbUpBanKN      <= BtbBanKN                                                           ;
            RegBtbUpTypeAble   <= TypeFault                                                          ;
            RegBtbUpType       <= InstType[JumpInstNum]                                              ;
            RegBtbUpTagetAble  <= TagetFault1 | TagetFault2 | TagetFault3 | TagetFault4 | TagetFault5;
            RegBtbUpTaget      <= ReviseAddr                                                         ;
            RegRasUpAble       <= ((BtbType == `TypeCALL) & (InstType[JumpInstNum] != `TypeCALL)) | ((BtbType == `TypeRTURN) & (InstType[JumpInstNum] != `TypeRTURN)) ;
            RegRasPtrType      <= {2{((BtbType == `TypeCALL)  & (InstType[JumpInstNum] != `TypeCALL))}}  & 2'b01 |   // 2'b01 mean ptr sub 1
                                  {2{((BtbType == `TypeRTURN) & (InstType[JumpInstNum] != `TypeRTURN))}} & 2'b10 ;   // 2'b10 mean ptr add 1.  2'b00 no operate
            RegRasAddrDate     <= RasPc                                                              ;
            RegTageUpAble      <= (BtbType == `TypeBRANCH) & (InstType[JumpInstNum] != `TypeBRANCH);

            RegPredAble        <= (InstType[JumpInstNum] == `TypeBRANCH) & TageAble ;
            RegPredJdate       <= TageJdate         ;
            RegPredNum         <= TageNum           ;
            RegPredInt1        <= TageInt1          ;
            RegPredInt2        <= TageInt2          ;
            RegPredInt3        <= TageInt3          ;
            RegPredInt4        <= TageInt4          ;
            RegPredInt5        <= TageInt5          ;
            RegPredInt6        <= TageInt6          ;

            RToIbInst1Able <=  (JumpInstNum == 4'd1) | (JumpInstNum == 4'd2) | (JumpInstNum == 4'd3) | (JumpInstNum == 4'd4) |
                               (JumpInstNum == 4'd5) | (JumpInstNum == 4'd6) | (JumpInstNum == 4'd7) | (JumpInstNum == 4'd8) ;
            RToIbInst1Mode <=  (InstType[1] != `TypeFORMAL) ? (TageMode & TageAble) : `EnableValue ;
            RToIbInst1Pc   <=  InstPc[1]  ;
            RToIbInst1Redir<=  (InstType[1] != `TypeFORMAL) ? ((TagetFault1 | TagetFault2 | TagetFault3 | TagetFault4 | TagetFault5) ? ReviseAddr : BtbPc) : `ZeorDate ;
            RToIbInst1Date <=  PreDecodeInst1;
            RToIbInst2Able <=  (JumpInstNum == 4'd2) | (JumpInstNum == 4'd3) | (JumpInstNum == 4'd4) |
                               (JumpInstNum == 4'd5) | (JumpInstNum == 4'd6) | (JumpInstNum == 4'd7) | (JumpInstNum == 4'd8) ;
            RToIbInst2Mode <=  (InstType[2] != `TypeFORMAL) ? (TageMode & TageAble) : `EnableValue ;
            RToIbInst2Pc   <=  InstPc[2]  ;
            RToIbInst2Redir<=  (InstType[2] != `TypeFORMAL) ? ((TagetFault1 | TagetFault2 | TagetFault3 | TagetFault4 | TagetFault5) ? ReviseAddr : BtbPc) : `ZeorDate ;
            RToIbInst2Date <=  PreDecodeInst2;
            RToIbInst3Able <=  (JumpInstNum == 4'd3) | (JumpInstNum == 4'd4) |
                               (JumpInstNum == 4'd5) | (JumpInstNum == 4'd6) | (JumpInstNum == 4'd7) | (JumpInstNum == 4'd8) ;
            RToIbInst3Mode <=  (InstType[3] != `TypeFORMAL) ? (TageMode & TageAble) : `EnableValue ;
            RToIbInst3Pc   <=  InstPc[3]  ;
            RToIbInst3Redir<=  (InstType[3] != `TypeFORMAL) ? ((TagetFault1 | TagetFault2 | TagetFault3 | TagetFault4 | TagetFault5) ? ReviseAddr : BtbPc) : `ZeorDate ;
            RToIbInst3Date <=  PreDecodeInst3;
            RToIbInst4Able <=  (JumpInstNum == 4'd4) |
                               (JumpInstNum == 4'd5) | (JumpInstNum == 4'd6) | (JumpInstNum == 4'd7) | (JumpInstNum == 4'd8) ;
            RToIbInst4Mode <=  (InstType[4] != `TypeFORMAL) ? (TageMode & TageAble) : `EnableValue ;
            RToIbInst4Pc   <=  InstPc[4]  ;
            RToIbInst4Redir<=  (InstType[4] != `TypeFORMAL) ? ((TagetFault1 | TagetFault2 | TagetFault3 | TagetFault4 | TagetFault5) ? ReviseAddr : BtbPc) : `ZeorDate ;
            RToIbInst4Date <=  PreDecodeInst4;
            RToIbInst5Able <=  (JumpInstNum == 4'd5) | (JumpInstNum == 4'd6) | (JumpInstNum == 4'd7) | (JumpInstNum == 4'd8) ;
            RToIbInst5Mode <=  (InstType[5] != `TypeFORMAL) ? (TageMode & TageAble) : `EnableValue ;
            RToIbInst5Pc   <=  InstPc[5]  ;
            RToIbInst5Redir<=  (InstType[5] != `TypeFORMAL) ? ((TagetFault1 | TagetFault2 | TagetFault3 | TagetFault4 | TagetFault5) ? ReviseAddr : BtbPc) : `ZeorDate ;
            RToIbInst5Date <=  PreDecodeInst5;
            RToIbInst6Able <=  (JumpInstNum == 4'd6) | (JumpInstNum == 4'd7) | (JumpInstNum == 4'd8) ;
            RToIbInst6Mode <=  (InstType[6] != `TypeFORMAL) ? (TageMode & TageAble) : `EnableValue ;
            RToIbInst6Pc   <=  InstPc[6]  ;
            RToIbInst6Redir<=  (InstType[6] != `TypeFORMAL) ? ((TagetFault1 | TagetFault2 | TagetFault3 | TagetFault4 | TagetFault5) ? ReviseAddr : BtbPc) : `ZeorDate ;
            RToIbInst6Date <=  PreDecodeInst6;
            RToIbInst7Able <=  (JumpInstNum == 4'd7) | (JumpInstNum == 4'd8) ;
            RToIbInst7Mode <=  (InstType[7] != `TypeFORMAL) ? (TageMode & TageAble) : `EnableValue ;
            RToIbInst7Pc   <=  InstPc[7]  ;
            RToIbInst7Redir<=  (InstType[7] != `TypeFORMAL) ? ((TagetFault1 | TagetFault2 | TagetFault3 | TagetFault4 | TagetFault5) ? ReviseAddr : BtbPc) : `ZeorDate ;
            RToIbInst7Date <=  PreDecodeInst7;
            RToIbInst8Able <=  (JumpInstNum == 4'd8) ;
            RToIbInst8Mode <=  (InstType[8] != `TypeFORMAL) ? (TageMode & TageAble) : `EnableValue ;
            RToIbInst8Pc   <=  InstPc[8]  ;
            RToIbInst8Redir<=  (InstType[8] != `TypeFORMAL) ? ((TagetFault1 | TagetFault2 | TagetFault3 | TagetFault4 | TagetFault5) ? ReviseAddr : BtbPc) : `ZeorDate ;
            RToIbInst8Date <=  PreDecodeInst8;
        end
    end
    
    assign PreReDirectAble = RegPreReDirectAble ;
    assign PreReDirectPc   = RegPreReDirectPc   ;
    assign BtbUpPcAble     = RegBtbUpPcAble     ;
    assign BtbUpPc         = RegBtbUpPc         ;
    assign BtbUpBanKN      = RegBtbUpBanKN      ;
    assign BtbUpTypeAble   = RegBtbUpTypeAble   ;
    assign BtbUpType       = RegBtbUpType       ;
    assign BtbUpTagetAble  = RegBtbUpTagetAble  ;
    assign BtbUpTaget      = RegBtbUpTaget      ;
    assign RasUpAble       = RegRasUpAble       ;
    assign RasPtrType      = RegRasPtrType      ;
    assign RasAddrDate     = RegRasAddrDate     ;
    assign TageUpAble      = RegTageUpAble      ;
    assign PredAble        = RegPredAble        ;
    assign PredJdate       = RegPredJdate       ;
    assign PredNum         = RegPredNum         ;
    assign PredInt1        = RegPredInt1        ;
    assign PredInt2        = RegPredInt2        ;
    assign PredInt3        = RegPredInt3        ;
    assign PredInt4        = RegPredInt4        ;
    assign PredInt5        = RegPredInt5        ;
    assign PredInt6        = RegPredInt6        ;
    assign ToIbInst1Able   = RToIbInst1Able     ;
    assign ToIbInst1Mode   = RToIbInst1Mode     ;
    assign ToIbInst1Pc     = RToIbInst1Pc       ;
    assign ToIbInst1Redir  = RToIbInst1Redir    ;
    assign ToIbInst1Date   = RToIbInst1Date     ;
    assign ToIbInst2Able   = RToIbInst2Able     ;
    assign ToIbInst2Mode   = RToIbInst2Mode     ;
    assign ToIbInst2Pc     = RToIbInst2Pc       ;
    assign ToIbInst2Redir  = RToIbInst2Redir    ;
    assign ToIbInst2Date   = RToIbInst2Date     ;
    assign ToIbInst3Able   = RToIbInst3Able     ;
    assign ToIbInst3Mode   = RToIbInst3Mode     ;
    assign ToIbInst3Pc     = RToIbInst3Pc       ;
    assign ToIbInst3Redir  = RToIbInst3Redir    ;
    assign ToIbInst3Date   = RToIbInst3Date     ;
    assign ToIbInst4Able   = RToIbInst4Able     ;
    assign ToIbInst4Mode   = RToIbInst4Mode     ;
    assign ToIbInst4Pc     = RToIbInst4Pc       ;
    assign ToIbInst4Redir  = RToIbInst4Redir    ;
    assign ToIbInst4Date   = RToIbInst4Date     ;
    assign ToIbInst5Able   = RToIbInst5Able     ;
    assign ToIbInst5Mode   = RToIbInst5Mode     ;
    assign ToIbInst5Pc     = RToIbInst5Pc       ;
    assign ToIbInst5Redir  = RToIbInst5Redir    ;
    assign ToIbInst5Date   = RToIbInst5Date     ;
    assign ToIbInst6Able   = RToIbInst6Able     ;
    assign ToIbInst6Mode   = RToIbInst6Mode     ;
    assign ToIbInst6Pc     = RToIbInst6Pc       ;
    assign ToIbInst6Redir  = RToIbInst6Redir    ;
    assign ToIbInst6Date   = RToIbInst6Date     ;
    assign ToIbInst7Able   = RToIbInst7Able     ;
    assign ToIbInst7Mode   = RToIbInst7Mode     ;
    assign ToIbInst7Pc     = RToIbInst7Pc       ;
    assign ToIbInst7Redir  = RToIbInst7Redir    ;
    assign ToIbInst7Date   = RToIbInst7Date     ;
    assign ToIbInst8Able   = RToIbInst8Able     ;
    assign ToIbInst8Mode   = RToIbInst8Mode     ;
    assign ToIbInst8Pc     = RToIbInst8Pc       ;
    assign ToIbInst8Redir  = RToIbInst8Redir    ;
    assign ToIbInst8Date   = RToIbInst8Date     ; 
   
endmodule
`timescale 1ps/1ps
`include "../define.v"
`include "../../Lib/STACK_dout.v"
`include "../../Lib/STACK_reload.v"

module Ras  (
    input    wire                               Clk           ,
    input    wire                               Rest          ,
    //stop
    input    wire                               RasStop       ,
    input    wire                               RasFLash      ,
    //from BTB
    input    wire                               BtbAble       ,
    input    wire        [2:0]                  BtbPredictType,
    input    wire        [`InstAddrBus]         BtbPcDate     ,
    input    wire        [4:0]                  BtbPcOffset   ,
    //speculate update with predecode
    input    wire                               UpAble        ,
    input    wire        [1:0]                  UpPtrType     ,
    input    wire        [`InstAddrBus]         UpAddrDate    ,
    //speculate ex to predecode
    output   wire                               ToPreAble     ,
    output   wire        [`InstAddrBus]         ToPreAddr     ,
    //Date update with retire
    input    wire                               UpdateInAble  ,
    input    wire                               UpdateReload  ,
    input    wire        [`InstAddrBus]         UpdateInDate  ,
    input    wire                               UpdateCall    ,
    input    wire                               UpdateReturn   
);

    wire ReadAble  = (BtbPredictType == `TypeRTURN) ;
    wire WriteAble = (BtbPredictType == `TypeCALL)  ;

    wire UpInAble  = (UpPtrType == 2'b10) & UpAble ;
    wire UpOutAble = (UpPtrType == 2'b01) & UpAble ;

    wire [`InstAddrBus] UpInDate  = UpAddrDate & {32{UpAble}} ;

    wire [`InstAddrBus] CallAddr  = (BtbPcDate + BtbPcOffset + 4) & {32{BtbAble}} ;
    wire [`InstAddrBus] ReturnAddr ;

    reg                 RegToPreAble ;
    reg  [`InstAddrBus] RegToPreAddr ;

    always @(posedge Clk) begin
        if(!Rest) begin
            RegToPreAble <= `EnableValue ;
            RegToPreAddr <= `ZeorDate    ;
        end
        else if(RasStop) begin
            RegToPreAble <= RegToPreAble ;
            RegToPreAddr <= RegToPreAddr ;
        end
        else if(RasFLash) begin
            RegToPreAble <= `EnableValue ;
            RegToPreAddr <= `ZeorDate    ;
        end
        else begin
            RegToPreAble <= BtbAble ;
            RegToPreAddr <= ReturnAddr ;
        end
    end

    assign ToPreAble = RegToPreAble ;
    assign ToPreAddr = RegToPreAddr ; 


    wire  [3:0]      ReloadPtr   ;
    wire  [32+7-1:0] ReloadDate1 ;
    wire  [32+7-1:0] ReloadDate2 ;
    wire  [32+7-1:0] ReloadDate3 ;
    wire  [32+7-1:0] ReloadDate4 ;
    wire  [32+7-1:0] ReloadDate5 ;
    wire  [32+7-1:0] ReloadDate6 ;
    wire  [32+7-1:0] ReloadDate7 ;
    wire  [32+7-1:0] ReloadDate8 ;
    wire  [32+7-1:0] ReloadDate9 ;
    wire  [32+7-1:0] ReloadDate10;
    wire  [32+7-1:0] ReloadDate11; 
    wire  [32+7-1:0] ReloadDate12;
    wire  [32+7-1:0] ReloadDate13;
    wire  [32+7-1:0] ReloadDate14;
    wire  [32+7-1:0] ReloadDate15;

    STACK_dout#(
        .STACKDEEP      ( 16 ),
        .STACKPTRW      ( 4 ),
        .STACKWIDE      ( 32 ),
        .RECURCOUNT     ( 7 )
    )u_STACK_dout(
        .Clk            ( Clk            ),
        .Rest           ( Rest           ),
        .RABLE          ( UpdateReturn   ),
        .WABLE          ( UpdateCall     ),
        .DIN            ( UpdateInDate   ),
        .REDIRCT        ( UpdateReload   ),
        .OUTDATEPTR     ( ReloadPtr      ),
        .OUTDATELINE1   ( ReloadDate1    ),
        .OUTDATELINE2   ( ReloadDate2    ),
        .OUTDATELINE3   ( ReloadDate3    ),
        .OUTDATELINE4   ( ReloadDate4    ),
        .OUTDATELINE5   ( ReloadDate5    ),
        .OUTDATELINE6   ( ReloadDate6    ),
        .OUTDATELINE7   ( ReloadDate7    ),
        .OUTDATELINE8   ( ReloadDate8    ),
        .OUTDATELINE9   ( ReloadDate9    ),
        .OUTDATELINE10  ( ReloadDate10   ),
        .OUTDATELINE11  ( ReloadDate11   ),
        .OUTDATELINE12  ( ReloadDate12   ),
        .OUTDATELINE13  ( ReloadDate13   ),
        .OUTDATELINE14  ( ReloadDate14   ),
        .OUTDATELINE15  ( ReloadDate15   )
    );

    STACK_reload#(
        .STACKDEEP     ( 16 ),
        .STACKPTRW     ( 4 ),
        .STACKWIDE     ( 32 ),
        .RECURCOUNT    ( 7 )
    )u_STACK_reload(
        .Clk           ( Clk           ),
        .Rest          ( Rest          ),
        .RABLE         ( ReadAble  |UpOutAble),
        .DOUT          ( ReturnAddr    ),
        .WABLE         ( WriteAble | UpInAble),
        .DIN           ( CallAddr  | UpInDate),
        .RELOAD        ( UpdateReload  ),
        .RELOADPTR     ( ReloadPtr     ),
        .RELOADLINE1   ( ReloadDate1   ),
        .RELOADLINE2   ( ReloadDate2   ),
        .RELOADLINE3   ( ReloadDate3   ),
        .RELOADLINE4   ( ReloadDate4   ),
        .RELOADLINE5   ( ReloadDate5   ),
        .RELOADLINE6   ( ReloadDate6   ),
        .RELOADLINE7   ( ReloadDate7   ),
        .RELOADLINE8   ( ReloadDate8   ),
        .RELOADLINE9   ( ReloadDate9   ),
        .RELOADLINE10  ( ReloadDate10  ),
        .RELOADLINE11  ( ReloadDate11  ),
        .RELOADLINE12  ( ReloadDate12  ),
        .RELOADLINE13  ( ReloadDate13  ),
        .RELOADLINE14  ( ReloadDate14  ),
        .RELOADLINE15  ( ReloadDate15  )
    );



    
endmodule
`timescale 1ps/1ps
`include "../define.v"
`include "../../IP/data_Base_128.xcix"
`include "../../IP/data_T1_128.xcix"
`include "../../IP/Counter_128.v"
`include "../../IP/data_T3_256.xcix"
`include "../../IP/Counter_256.v"
`include "../../IP/data_T5_128.xcix"
`include "../../IP/data_T6_128.xcix"



module Tage (
    input     wire                                     Clk              ,
    input     wire                                     Rest             ,
    //stop 
    input     wire                                     TageStop         ,
    input     wire                                     TageFlash        ,
    //from Pc
    input     wire                                     PcAble           ,
    input     wire       [`InstAddrBus]                PcDate           ,
    //from BTB
    input     wire                                     BtbAble          ,
    input     wire       [2:0]                         BtbType          ,
    input     wire                                     BtbMode          ,
    //update from predecode 
    input     wire                                     PreUpDable       ,
    input     wire       [63:0]                        PreUpDate        ,
    //from ROB
    input     wire                                     Attenuate        ,
    input     wire                                     GHRUpAble        ,
    input     wire       [64:0]                        GHRDate          ,
    //update from FTQ(整体设计坏啦)
    input     wire                                     InALwDateAble    ,
    input     wire       [`InstAddrBus]                InALwUpDatePc    ,
    input     wire       [2:0]                         InALwUpDate      ,
    input     wire       [2:0]                         InALwUpNum       ,
    input     wire       [2:0]                         InALwUpCnt       ,
    input     wire                                     InNewDateAble    ,
    input     wire       [2:0]                         InNewUpDate      ,
    input     wire       [2:0]                         InNewUpNum       ,
    input     wire       [2:0]                         InNewUpCnt       ,
    input     wire                                     InNewCnt1Able    ,
    input     wire       [2:0]                         InNewCnt1Date    ,
    input     wire                                     InNewCnt2Able    ,
    input     wire       [2:0]                         InNewCnt2Date    ,    
    input     wire                                     InNewCnt3Able    ,
    input     wire       [2:0]                         InNewCnt3Date    ,    
    input     wire                                     InNewCnt4Able    ,
    input     wire       [2:0]                         InNewCnt4Date    ,                                
    input     wire                                     InNewCnt5Able    ,
    input     wire       [2:0]                         InNewCnt5Date    ,  
    input     wire                                     InNewCnt6Able    ,
    input     wire       [2:0]                         InNewCnt6Date    ,  
    //to predecode 
    output    wire                                     PredictAble      ,
    output    wire                                     PredictMode      ,
    output    wire       [2:0]                         PredictJdate     ,
    output    wire       [2:0]                         PredictNum       ,
    output    wire       [2:0]                         PredictUset1     ,
    output    wire       [2:0]                         PredictUset2     ,
    output    wire       [2:0]                         PredictUset3     ,
    output    wire       [2:0]                         PredictUset4     ,
    output    wire       [2:0]                         PredictUset5     ,
    output    wire       [2:0]                         PredictUset6     
);

    //*********************************ABOUT TAGE**********************************//
    //       T NUMBER------------DEEP------------GHR WIDE---------TAG WIDE         //
    //         BASE              128             0                0                //
    //         T1                128             2                7                //
    //         T2                128             4                7                //
    //         T3                256             8                8                //
    //         T4                256             16               8                //
    //         T5                128             32               9                //
    //         T6                128             64               9                //
    //*****************************************************************************//

    reg [63:0] GHRDATE ; //new ----> old
    reg        GHRsave1bit ;


    always @(posedge Clk) begin
        if(!Rest) begin
            GHRDATE     <= 64'd0 ;
            GHRsave1bit <= 1'b0  ;
        end
        else begin
            if(BtbAble) begin
                GHRDATE <= {BtbMode,GHRDATE[62:0]} ;
            end
            if(PreUpDable) begin
                GHRDATE <= PreUpDate ;
            end
            if(GHRUpAble) begin
               GHRDATE <= GHRDate[64:1] ; 
            end
        end
    end


    wire [63:0] GHR = InALwDateAble ? GHRDate[63:0] :
                      PcAble        ? (BtbAble ? {BtbMode,GHRDATE[62:0]} : GHRDATE)  :  64'd0 ;

    wire [31:0] PcAddr = InALwDateAble ? InALwUpDatePc :
                         PcAble        ? PcDate        : 32'd0 ;

    //pc cut 7
    wire [6:0] Cut7Index = PcAddr[11:5] ;
    wire [7:0] Cut8Index = PcAddr[12:5] ;

    //predict 
    //fold 7 
    wire [6:0] FoldPc7part1 = PcAddr[18:12]         ;
    wire [6:0] FoldPc7part2 = PcAddr[25:19]         ;
    wire [6:0] FoldPc7part3 = {1'b0,PcAddr[31:26] } ;

    wire [6:0] XorPc7 = FoldPc7part3^FoldPc7part2^FoldPc7part1 ;

    //fold 8
    wire [7:0] FoldPc8part1 = PcAddr[20:13]         ;
    wire [7:0] FoldPc8part2 = PcAddr[28:21]         ;
    wire [7:0] FoldPc8part3 = {5'b0,PcAddr[31:29]}  ;

    wire [7:0] XorPc8 = FoldPc8part3^FoldPc8part2^FoldPc8part1 ;

    //fold 9
    wire [8:0] FoldPc9part1 = PcAddr[20:12]         ;
    wire [8:0] FoldPc9part2 = PcAddr[29:21]         ;
    wire [8:0] FoldPc9part3 = {7'b0,PcAddr[31:30]}  ;

    wire [8:0] XorPc9 = FoldPc9part3^FoldPc9part2^FoldPc9part1 ;

    //fold GHR

    //fold t1 index
    wire [6:0] FoldGHRT1Part1 = {5'b0,GHR[63:62]} ;
    wire [6:0] FoldT1GHR = FoldGHRT1Part1         ;
    //fold t2 index
    wire [6:0] FoldGHRT2Part1 = {3'b0,GHR[63:60]} ;
    wire [6:0] FoldT2GHR = FoldGHRT1Part1         ;
    //fole t3 index
    wire [7:0] FoldGHRT3Part1 = GHR[63:56]        ;
    wire [7:0] FoldT3GHR = FoldGHRT3Part1         ;
    //fold t4 index
    wire [7:0] FoldGHRT4Part1 = GHR[63:56]        ;
    wire [7:0] FoldGHRT4Part2 = GHR[55:48]        ;
    wire [7:0] FoldT4GHR = FoldGHRT4Part2^FoldGHRT4Part1 ;
    //fold t5 index
    wire [6:0] FoldGHRT5Part1 = GHR[63:57]        ;
    wire [6:0] FoldGHRT5Part2 = GHR[56:50]        ;
    wire [6:0] FoldGHRT5Part3 = GHR[49:43]        ;
    wire [6:0] FoldGHRT5Part4 = GHR[42:36]        ;
    wire [6:0] FoldGHRT5Part5 = GHR[35:29]        ;
    wire [6:0] FoldT5GHR = FoldGHRT5Part5^FoldGHRT5Part4^FoldGHRT5Part3^FoldGHRT5Part2^FoldGHRT5Part1 ;
    //fold t6 index
    wire [6:0] FoldGHRT6Part1 = GHR[63:57]        ;
    wire [6:0] FoldGHRT6Part2 = GHR[56:50]        ;
    wire [6:0] FoldGHRT6Part3 = GHR[49:43]        ;
    wire [6:0] FoldGHRT6Part4 = GHR[42:36]        ;
    wire [6:0] FoldGHRT6Part5 = GHR[35:29]        ;
    wire [6:0] FoldGHRT6Part6 = GHR[28:22]        ;
    wire [6:0] FoldGHRT6Part7 = GHR[21:15]        ;
    wire [6:0] FoldGHRT6Part8 = GHR[14:8]         ;
    wire [6:0] FoldGHRT6Part9 = GHR[7:1]          ;
    wire [6:0] FoldGHRT6Part10= {6'd0,GHR[0]}     ;
    wire [6:0] FoldT6GHR = FoldGHRT6Part10^FoldGHRT6Part9^FoldGHRT6Part8^FoldGHRT6Part7^FoldGHRT6Part6^
                           FoldGHRT6Part5^FoldGHRT6Part4^FoldGHRT6Part3^FoldGHRT6Part2^FoldGHRT6Part1 ;



    wire [6:0] FoldGHR7Part1  = {5'b0,GHR[63:62]}    ;
    wire [6:0] FoldT1TagGHR   = FoldGHR7Part1        ;

    wire [6:0] FoldGHR7Part2  = {3'b0,GHR[63:60]}    ;
    wire [6:0] FoldT2TagGHR   = FoldGHR7Part2        ;



    wire [7:0] FoldGHR8Part1  = GHR[63:56]        ; 
    wire [7:0] FoldGHR8Part2  = GHR[55:48]        ; 

    wire [7:0] FoldT3TagGHR   = FoldGHR8Part1     ;
    wire [7:0] FoldT4TagGHR   = FoldGHR8Part2^FoldGHR8Part1;


    //fold t5 t6 tag
    wire [8:0] FoldGHR9Part1  = GHR[63:55]        ; 
    wire [8:0] FoldGHR9Part2  = GHR[54:46]        ; 
    wire [8:0] FoldGHR9Part3  = GHR[45:37]        ;
    wire [8:0] FordGHR9Parte  = {GHR[36:32],4'b0 };
    wire [8:0] FoldGHR9Part4  = GHR[36:28]        ; 
    wire [8:0] FoldGHR9Part5  = GHR[27:19]        ; 
    wire [8:0] FoldGHR9Part6  = GHR[18:10]        ; 
    wire [8:0] FoldGHR9Part7  = GHR[9:1]          ;  
    wire [8:0] FoldGHR9Part8  = {8'b0,GHR[0]}     ;



    wire [8:0] FoldT5TagGHR = FordGHR9Parte^FoldGHR9Part3^FoldGHR9Part2^FoldGHR9Part1 ;
    wire [8:0] FoldT6TagGHR = FoldGHR9Part8^FoldGHR9Part7^FoldGHR9Part6^FoldGHR9Part5^
                              FoldGHR9Part4^FoldGHR9Part3^FoldGHR9Part2^FoldGHR9Part1 ;

    //read
    wire [6:0] BaseReadIndex = Cut7Index     ;
    wire       BaseEna       = `AbleValue    ;
    wire       BaseWen       = InALwDateAble & ~TageStop & (InALwUpNum == 0) ;
    wire [5:0] BasePart                      ;
    wire [2:0] BaseDin       = InALwUpDate   ;
    

    data_Base_128 u_data_Base_128(
        .clka  ( Clk           ),
        .ena   ( BaseEna       ),
        .wea   ( BaseWen       ),
        .addra ( BaseReadIndex ),
        .dina  ( dina  ),
        .douta ( BasePart      )
    );

    wire [6:0] T1ReadIndex = Cut7Index^FoldT1GHR     ;
    wire [6:0] T1readTag   = XorPc7^FoldT1TagGHR     ;
    wire       T1Ena       = `AbleValue              ;
    wire       T1Wen       = ((InALwDateAble & (InALwUpNum == 1)) | (InNewDateAble & (InNewUpNum == 1))) & ~TageStop ;
    wire [12:0]T1Din       = {13{(InALwDateAble & (InALwUpNum == 1)) & ~TageStop}} & {T1readTag,InALwUpDate,3'd0} | 
                             {13{(InNewDateAble & (InNewUpNum == 1)) & ~TageStop}} & {T1readTag,InNewUpDate,3'd0} ;
    wire       T1CWen      = ((InALwDateAble & (InALwUpNum == 1)) | (InNewDateAble & (InNewUpNum == 1)) | (InNewCnt1Able)) & ~TageStop ;
    wire [2:0] T1CDin      = {3{(InALwDateAble & (InALwUpNum == 1)) & ~TageStop}} & InALwUpCnt | 
                             {3{(InNewDateAble & (InNewUpNum == 1)) & ~TageStop}} & InNewUpCnt |
                             {3{InNewCnt1Able}} & InNewCnt1Date ;
    wire [12:0]T1Part                                ;
    wire [2:0] T1Count                               ;

    data_T1_128 ut1_data_T1_128(
        .clka  ( Clk          ),
        .ena   ( T1Ena        ),
        .wea   ( T1Wen        ),
        .addra ( T1ReadIndex  ),
        .dina  ( T1Din        ),
        .douta ( T1Part       )
    );

    Counter_128 ut1_Counter_128(
        .Clk   ( Clk          ),
        .Rest  ( Rest         ),
        .Atten ( Attenuate    ),
        .Addr  ( T1ReadIndex  ),
        .Dout  ( T1Count      ),
        .Wen   ( T1CWen       ),
        .Din   ( T1CDin       )
    );

    wire [6:0] T2ReadIndex = Cut7Index^FoldT2GHR ;
    wire [6:0] T2readTag   = XorPc7^FoldT2TagGHR ;
    wire       T2Ena       = `AbleValue          ;
    wire       T2Wen       = ((InALwDateAble & (InALwUpNum == 2)) | (InNewDateAble & (InNewUpNum == 2))) & ~TageStop ;
    wire [12:0]T2Din       = {13{(InALwDateAble & (InALwUpNum == 2)) & ~TageStop}} & {T2readTag,InALwUpDate,3'd0} | 
                             {13{(InNewDateAble & (InNewUpNum == 2)) & ~TageStop}} & {T2readTag,InNewUpDate,3'd0} ;
    wire       T2CWen      = ((InALwDateAble & (InALwUpNum == 2)) | (InNewDateAble & (InNewUpNum == 2)) | (InNewCnt2Able)) & ~TageStop ;
    wire [2:0] T2CDin      = {3{(InALwDateAble & (InALwUpNum == 2)) & ~TageStop}} & InALwUpCnt | 
                             {3{(InNewDateAble & (InNewUpNum == 2)) & ~TageStop}} & InNewUpCnt |
                             {3{InNewCnt2Able}} & InNewCnt2Date ;
    wire [12:0]T2Part                            ;
    wire [2:0] T2Count                           ;

    data_T1_128 ut2_data_T1_128(
        .clka  ( Clk         ),
        .ena   ( T2Ena       ),
        .wea   ( T2Wen       ),
        .addra ( T2ReadIndex ),
        .dina  ( T2Din       ),
        .douta ( T2Part      )
    );

    Counter_128 ut2_Counter_128(
        .Clk   ( Clk         ),
        .Rest  ( Rest        ),
        .Atten ( Attenuate   ),
        .Addr  ( T2ReadIndex ),
        .Dout  ( T2Count     ),
        .Wen   ( T2CWen      ),
        .Din   ( T2CDin      )
    );

    wire [7:0] T3ReadIndex = Cut8Index^FoldT3GHR ;
    wire [7:0] T3readTag   = XorPc8^FoldT3TagGHR ;
    wire       T3Ena       = `AbleValue          ;
    wire       T3Wen       = ((InALwDateAble & (InALwUpNum == 3)) | (InNewDateAble & (InNewUpNum == 3))) & ~TageStop ;
    wire [13:0]T3Din       = {14{(InALwDateAble & (InALwUpNum == 3)) & ~TageStop}} & {T3readTag,InALwUpDate,3'd0} | 
                             {14{(InNewDateAble & (InNewUpNum == 3)) & ~TageStop}} & {T3readTag,InNewUpDate,3'd0} ;
    wire       T3CWen      = ((InALwDateAble & (InALwUpNum == 3)) | (InNewDateAble & (InNewUpNum == 3)) | (InNewCnt3Able)) & ~TageStop ;
    wire [2:0] T3CDin      = {3{(InALwDateAble & (InALwUpNum == 3)) & ~TageStop}} & InALwUpCnt | 
                             {3{(InNewDateAble & (InNewUpNum == 3)) & ~TageStop}} & InNewUpCnt |
                             {3{InNewCnt3Able}} & InNewCnt3Date ;
    wire [13:0]T3Part                            ;
    wire [2:0] T3Count                           ;

    data_T3_256 ut3_data_T3_128(
        .clka  ( Clk         ),
        .ena   ( T3Ena       ),
        .wea   ( T3Wen       ),
        .addra ( T3ReadIndex ),
        .dina  ( T3Din       ),
        .douta ( T3Part      )
    );

    Counter_256 ut3_Counter_256(
        .Clk   ( Clk          ),
        .Rest  ( Rest         ),
        .Atten ( Attenuate    ),
        .Addr  ( T3ReadIndex  ),
        .Dout  ( T3Count      ),
        .Wen   ( T3CWen       ),
        .Din   ( T3CDin       )
    );

    wire [7:0] T4ReadIndex = Cut8Index^FoldT4GHR ;
    wire [7:0] T4readTag   = XorPc8^FoldT4TagGHR ;
    wire       T4Ena       = `AbleValue          ;
    wire       T4Wen       = ((InALwDateAble & (InALwUpNum == 4)) | (InNewDateAble & (InNewUpNum == 4))) & ~TageStop ;
    wire [13:0]T4Din       = {14{(InALwDateAble & (InALwUpNum == 4)) & ~TageStop}} & {T4readTag,InALwUpDate,3'd0} | 
                             {14{(InNewDateAble & (InNewUpNum == 4)) & ~TageStop}} & {T4readTag,InNewUpDate,3'd0} ;
    wire       T4CWen      = ((InALwDateAble & (InALwUpNum == 4)) | (InNewDateAble & (InNewUpNum == 4)) | (InNewCnt4Able)) & ~TageStop ;
    wire [2:0] T4CDin      = {3{(InALwDateAble & (InALwUpNum == 4)) & ~TageStop}} & InALwUpCnt | 
                             {3{(InNewDateAble & (InNewUpNum == 4)) & ~TageStop}} & InNewUpCnt |
                             {3{InNewCnt4Able}} & InNewCnt4Date ;
    wire [13:0]T4Part                            ;
    wire [2:0] T4Count                           ;

    data_T3_256 ut4_data_T3_128(
        .clka  ( Clk         ),
        .ena   ( T4Ena       ),
        .wea   ( T4Wen       ),
        .addra ( T4ReadIndex ),
        .dina  ( T4Din       ),
        .douta ( T4Part      )
    );

    Counter_256 ut4_Counter_256(
        .Clk   ( Clk          ),
        .Rest  ( Rest         ),
        .Atten ( Attenuate    ),
        .Addr  ( T4ReadIndex  ),
        .Dout  ( T4Count      ),
        .Wen   ( T4CWen       ),
        .Din   ( T4CDin       )
    );

    wire [6:0] T5ReadIndex = Cut7Index^FoldT5GHR ;
    wire [8:0] T5readTag   = XorPc9^FoldT5TagGHR ;
    wire       T5Ena       = `AbleValue          ;
    wire       T5Wen       = ((InALwDateAble & (InALwUpNum == 5)) | (InNewDateAble & (InNewUpNum == 5))) & ~TageStop ;
    wire [14:0]T5Din       = {15{(InALwDateAble & (InALwUpNum == 5)) & ~TageStop}} & {T5readTag,InALwUpDate,3'd0} | 
                             {15{(InNewDateAble & (InNewUpNum == 5)) & ~TageStop}} & {T5readTag,InNewUpDate,3'd0} ;
    wire       T5CWen      = ((InALwDateAble & (InALwUpNum == 5)) | (InNewDateAble & (InNewUpNum == 5)) | (InNewCnt5Able)) & ~TageStop ;
    wire [2:0] T5CDin      = {3{(InALwDateAble & (InALwUpNum == 5)) & ~TageStop}} & InALwUpCnt | 
                             {3{(InNewDateAble & (InNewUpNum == 5)) & ~TageStop}} & InNewUpCnt |
                             {3{InNewCnt5Able}} & InNewCnt5Date ;
    wire [14:0]T5Part                            ;
    wire [2:0] T5Count                           ;

    data_T5_128 ut5_data_T5_128(
        .clka  ( Clk         ),
        .ena   ( T5Ena       ),
        .wea   ( T5Wen       ),
        .addra ( T5ReadIndex ),
        .dina  ( T5Din       ),
        .douta ( T5Part      )
    );

    Counter_128 ut5_Counter_128(
        .Clk   ( Clk          ),
        .Rest  ( Rest         ),
        .Atten ( Attenuate    ),
        .Addr  ( T5ReadIndex  ),
        .Dout  ( T5Count      ),
        .Wen   ( T5CWen       ),
        .Din   ( T5CDin       )
    );

    wire [6:0] T6ReadIndex = Cut7Index^FoldT6GHR ;
    wire [8:0] T6readTag   = XorPc9^FoldT6TagGHR ;
    wire       T6Ena       = `AbleValue          ;
    wire       T6Wen       = ((InALwDateAble & (InALwUpNum == 6)) | (InNewDateAble & (InNewUpNum == 6))) & ~TageStop ;
    wire [14:0]T6Din       = {15{(InALwDateAble & (InALwUpNum == 6)) & ~TageStop}} & {T6readTag,InALwUpDate,3'd0} | 
                             {15{(InNewDateAble & (InNewUpNum == 6)) & ~TageStop}} & {T6readTag,InNewUpDate,3'd0} ;
    wire       T6CWen      = ((InALwDateAble & (InALwUpNum == 6)) | (InNewDateAble & (InNewUpNum == 6)) | (InNewCnt6Able)) & ~TageStop ;
    wire [2:0] T6CDin      = {3{(InALwDateAble & (InALwUpNum == 6)) & ~TageStop}} & InALwUpCnt | 
                             {3{(InNewDateAble & (InNewUpNum == 6)) & ~TageStop}} & InNewUpCnt |
                             {3{InNewCnt6Able}} & InNewCnt6Date ;
    wire [14:0]T6Part                            ;
    wire [2:0] T6Count                           ;

    data_T6_128 ut6_data_T6_128(
        .clka  ( Clk         ),
        .ena   ( T6Ena       ),
        .wea   ( T6Wen       ),
        .addra ( T6ReadIndex ),
        .dina  ( T6Din       ),
        .douta ( T6Part      )
    );

    Counter_128 ut6_Counter_128(
        .Clk   ( Clk          ),
        .Rest  ( Rest         ),
        .Atten ( Attenuate    ),
        .Addr  ( T6ReadIndex  ),
        .Dout  ( T6Count      ),
        .Wen   ( T6CWen       ),
        .Din   ( T6CDin       )
    );
    reg                   RegUpDate      ;
    reg [5:0]             RegBaseDate    ;
    reg [12:0]            RegT1Date      ;
    reg [6:0]             RegT1Tag       ;
    reg [2:0]             RegT1Useful    ;
    reg [12:0]            RegT2Date      ;
    reg [6:0]             RegT2Tag       ;
    reg [2:0]             RegT2Useful    ;
    reg [13:0]            RegT3Date      ;
    reg [7:0]             RegT3Tag       ;
    reg [2:0]             RegT3Useful    ;
    reg [13:0]            RegT4Date      ;
    reg [7:0]             RegT4Tag       ;
    reg [2:0]             RegT4Useful    ;
    reg [14:0]            RegT5Date      ;
    reg [8:0]             RegT5Tag       ;
    reg [2:0]             RegT5Useful    ;
    reg [14:0]            RegT6Date      ;
    reg [8:0]             RegT6Tag       ;
    reg [2:0]             RegT6Useful    ;

    always @(posedge Clk) begin
        if(!Rest) begin
            RegUpDate   <= `EnableValue ;
            RegBaseDate <= 6'd0         ;
            RegT1Date   <= 13'd0        ;
            RegT1Tag    <= 7'd0         ;
            RegT1Useful <= 3'd0         ;
            RegT2Date   <= 13'd0        ;
            RegT2Tag    <= 7'd0         ;
            RegT2Useful <= 3'd0         ;
            RegT3Date   <= 14'd0        ;
            RegT3Tag    <= 8'd0         ;
            RegT3Useful <= 3'd0         ;
            RegT4Date   <= 14'd0        ;
            RegT4Tag    <= 8'd0         ;
            RegT4Useful <= 3'd0         ;
            RegT5Date   <= 15'd0        ;
            RegT5Tag    <= 9'd0         ;
            RegT5Useful <= 3'd0         ;
            RegT6Date   <= 15'd0        ;
            RegT6Tag    <= 9'd0         ;
            RegT6Useful <= 3'd0         ;
        end
        else if(TageStop) begin
            RegUpDate   <= RegUpDate    ;
            RegBaseDate <= RegBaseDate  ;
            RegT1Date   <= RegT1Date    ;
            RegT1Tag    <= RegT1Tag     ;
            RegT1Useful <= RegT1Useful  ;
            RegT2Date   <= RegT2Date    ;
            RegT2Tag    <= RegT2Tag     ;
            RegT2Useful <= RegT2Useful  ;
            RegT3Date   <= RegT3Date    ;
            RegT3Tag    <= RegT3Tag     ;
            RegT3Useful <= RegT3Useful  ;
            RegT4Date   <= RegT4Date    ;
            RegT4Tag    <= RegT4Tag     ;
            RegT4Useful <= RegT4Useful  ;
            RegT5Date   <= RegT5Date    ;
            RegT5Tag    <= RegT5Tag     ;
            RegT5Useful <= RegT5Useful  ;
            RegT6Date   <= RegT6Date    ;
            RegT6Tag    <= RegT6Tag     ;
            RegT6Useful <= RegT6Useful  ;
        end
        else if(TageFlash) begin
            RegUpDate   <= `EnableValue ;
            RegBaseDate <= 6'd0         ;
            RegT1Date   <= 13'd0        ;
            RegT1Tag    <= 7'd0         ;
            RegT1Useful <= 3'd0         ;
            RegT2Date   <= 13'd0        ;
            RegT2Tag    <= 7'd0         ;
            RegT2Useful <= 3'd0         ;
            RegT3Date   <= 14'd0        ;
            RegT3Tag    <= 8'd0         ;
            RegT3Useful <= 3'd0         ;
            RegT4Date   <= 14'd0        ;
            RegT4Tag    <= 8'd0         ;
            RegT4Useful <= 3'd0         ;
            RegT5Date   <= 15'd0        ;
            RegT5Tag    <= 9'd0         ;
            RegT5Useful <= 3'd0         ;
            RegT6Date   <= 15'd0        ;
            RegT6Tag    <= 9'd0         ;
            RegT6Useful <= 3'd0         ;
        end
        else begin
            RegUpDate   <= PcAble       ;
            RegBaseDate <= BasePart     ;
            RegT1Date   <= T1Part       ;
            RegT1Tag    <= T1readTag    ;
            RegT1Useful <= T1Count      ;
            RegT2Date   <= T2Part       ;
            RegT2Tag    <= T2readTag    ;
            RegT2Useful <= T2Count      ;
            RegT3Date   <= T3Part       ;
            RegT3Tag    <= T3readTag    ;
            RegT3Useful <= T3Count      ;
            RegT4Date   <= T4Part       ;
            RegT4Tag    <= T4readTag    ;
            RegT4Useful <= T4Count      ;
            RegT5Date   <= T5Part       ;
            RegT5Tag    <= T5readTag    ;
            RegT5Useful <= T5Count      ;
            RegT6Date   <= T6Part       ;
            RegT6Tag    <= T6readTag    ;
            RegT6Useful <= T6Count      ;
        end
    end


    wire T1HitAble = (RegT1Tag == RegT1Date[12:6]) ;
    wire T2HitAble = (RegT2Tag == RegT2Date[12:6]) ;
    wire T3HitAble = (RegT3Tag == RegT3Date[13:6]) ;
    wire T4HitAble = (RegT4Tag == RegT4Date[13:6]) ;
    wire T5HitAble = (RegT5Tag == RegT5Date[14:6]) ;
    wire T6HitAble = (RegT6Tag == RegT6Date[14:6]) ;



    reg                  RegPredictAble  ;
    reg                  RegPredictMode  ;
    reg     [2:0]        RegPredictJdate ;
    reg     [2:0]        RegPredictNum   ;
    reg     [2:0]        RegPredictUset1 ;
    reg     [2:0]        RegPredictUset2 ;
    reg     [2:0]        RegPredictUset3 ;
    reg     [2:0]        RegPredictUset4 ;
    reg     [2:0]        RegPredictUset5 ;
    reg     [2:0]        RegPredictUset6 ;

    always @(posedge Clk) begin
        if(!Rest) begin
            RegPredictAble <= `EnableValue   ;
            RegPredictMode <= `EnableValue   ;
            RegPredictJdate <= 3'b0          ;
            RegPredictNum   <= 3'b0          ;
            RegPredictUset1 <= 3'b0          ;
            RegPredictUset2 <= 3'b0          ;
            RegPredictUset3 <= 3'b0          ;
            RegPredictUset4 <= 3'b0          ;
            RegPredictUset5 <= 3'b0          ;
            RegPredictUset6 <= 3'b0          ;
        end
        else if(TageStop) begin
            RegPredictAble <= RegPredictAble   ;
            RegPredictMode <= RegPredictMode   ;
            RegPredictJdate <= RegPredictJdate ;
            RegPredictNum   <= RegPredictNum   ;
            RegPredictUset1 <= RegPredictUset1 ;
            RegPredictUset2 <= RegPredictUset2 ;
            RegPredictUset3 <= RegPredictUset3 ;
            RegPredictUset4 <= RegPredictUset4 ;
            RegPredictUset5 <= RegPredictUset5 ;
            RegPredictUset6 <= RegPredictUset6 ;
        end
        else if(TageFlash) begin
            RegPredictAble <= `EnableValue   ;
            RegPredictMode <= `EnableValue   ;
            RegPredictJdate <= 3'b0          ;
            RegPredictNum   <= 3'b0          ;
            RegPredictUset1 <= 3'b0          ;
            RegPredictUset2 <= 3'b0          ;
            RegPredictUset3 <= 3'b0          ;
            RegPredictUset4 <= 3'b0          ;
            RegPredictUset5 <= 3'b0          ;
            RegPredictUset6 <= 3'b0          ;
        end
        else begin
            RegPredictAble   =  RegUpDate   ;
            {RegPredictMode, RegPredictJdate, RegPredictNum}  = T6HitAble ? {((RegT6Date[5:3] > 3'b100) ? `AbleValue : `EnableValue), RegT6Date[5:3], 3'd6 } :
                                                                T5HitAble ? {((RegT5Date[5:3] > 3'b100) ? `AbleValue : `EnableValue), RegT5Date[5:3], 3'd5 } :
                                                                T4HitAble ? {((RegT4Date[5:3] > 3'b100) ? `AbleValue : `EnableValue), RegT4Date[5:3], 3'd4 } :
                                                                T3HitAble ? {((RegT3Date[5:3] > 3'b100) ? `AbleValue : `EnableValue), RegT3Date[5:3], 3'd3 } :
                                                                T2HitAble ? {((RegT2Date[5:3] > 3'b100) ? `AbleValue : `EnableValue), RegT2Date[5:3], 3'd2 } :
                                                                T1HitAble ? {((RegT1Date[5:3] > 3'b100) ? `AbleValue : `EnableValue), RegT1Date[5:3], 3'd1 } : 
                                                                {((RegBaseDate[5:3] > 3'b100) ? `AbleValue : `EnableValue), RegBaseDate[5:3], 3'd0} ;
            RegPredictUset1  <=  RegT1Useful ;
            RegPredictUset2  <=  RegT2Useful ;
            RegPredictUset3  <=  RegT3Useful ;
            RegPredictUset4  <=  RegT4Useful ;
            RegPredictUset5  <=  RegT5Useful ;
            RegPredictUset6  <=  RegT6Useful ;
        end
    end

    
    assign PredictAble   =  RegPredictAble   ;
    assign PredictMode   =  RegPredictMode   ;
    assign PredictJdate  =  RegPredictJdate  ;
    assign PredictNum    =  RegPredictNum    ;
    assign PredictUset1  =  RegPredictUset1 ;
    assign PredictUset2  =  RegPredictUset2 ;
    assign PredictUset3  =  RegPredictUset3 ;
    assign PredictUset4  =  RegPredictUset4 ;
    assign PredictUset5  =  RegPredictUset5 ;
    assign PredictUset6  =  RegPredictUset6 ;

    
endmodule
`timescale 1ps/1ps
`include "../define.v"
`include "../../IP/data_128x256.xcix"
`include "../../IP/tag_128x256.xcix"

module DCacheStage1 (
    input        wire                                 Clk          ,
    input        wire                                 Rest         ,
    // for ctrl 
    input        wire                                 DcacheStop   ,
    input        wire                                 DcacheFlash  ,
    output       wire                                 DcacheReq    ,
    //from AGU1
    input        wire                                 LoadAble     ,
    input        wire     [1:0]                       LoadMat      ,
    input        wire     [2:0]                       LoadPtr      ,
    output       wire                                 LoadSuccess  ,
    input        wire     [`InstAddrBus]              LoadPhyAddr  ,
    //from AGU2
    input        wire                                 StoreAble    ,
    input        wire     [1:0]                       StoreMat     , 
    input        wire     [2:0]                       StorePtr     ,
    input        wire     [`DataBus]                  StoreDate    ,
    output       wire                                 StoreSuccess ,
    input        wire     [`InstAddrBus]              StorePhyAddr , 
    //to WriteBuffer
    output       wire                                 WriteBuffAble,
    output       wire     [`InstAddrBus]              WriteBuffAddr,
    output       wire     [255:0]                     WriteBackDate,
    output       wire     [7:0]                       WriteBackCnt ,
    output       wire     [2:0]                       WriteBuffPtr ,
    //to MSHR
    output       wire                                 MSHRAble     ,
    output       wire     [`InstAddrBus]              MSHRAddr     ,
    output       wire     [3:0]                       MSHRWay      ,
    output       wire                                 MSHRLoad     ,
    output       wire                                 MSHRStore    ,
    output       wire     [`DataBus]                  MSHRStoreTemp,
    output       wire     [2:0]                       MSHRPtr      ,  
    input        wire                                 MSHRUpAble   ,
    input        wire     [255:0]                     MSHRUpDate   ,
    input        wire     [`InstAddrBus]              MSHRUpAddr   ,
    input        wire     [3:0]                       MSHRUpWay    ,
    input        wire                                 In2HitAble   ,
    input        wire     [6:0]                       In2HitIndex  ,
    input        wire                                 In2HitWay1   ,
    input        wire                                 In2HitWay2   ,
    input        wire                                 In2HitWay3   ,
    input        wire                                 In2HitWay4   ,
    input        wire                                 Writ2DirtAble,
    input        wire     [6:0]                       Writ2HitIndex,
    input        wire                                 Writ2Way1Hit ,
    input        wire                                 Writ2Way2Hit ,
    input        wire                                 Writ2Way3Hit ,
    input        wire                                 Writ2Way4Hit ,
    //to AGU 
    output       wire                                 LoadBack     ,
    output       wire     [2:0]                       LoadBackPtr  ,
    output       wire     [`DataBus]                  LoadBackDate ,
    output       wire                                 StoreBack    ,
    output       wire     [2:0]                       StoreBackPtr
);

    reg   [2:0]  CountWay1 [0:127] ;
    reg   [2:0]  CountWay2 [0:127] ;
    reg   [2:0]  CountWay3 [0:127] ;
    reg   [2:0]  CountWay4 [0:127] ;

    wire       InHitAble  ;
    wire [6:0] InHitIndex ; 
    wire       InHitWay1  ;
    wire       InHitWay2  ;
    wire       InHitWay3  ;
    wire       InHitWay4  ;

    integer i ;
    always @(posedge Clk) begin
        if(!Rest) begin
            for (i =0 ;i<32 ;i=i+1 ) begin
                CountWay1[i]    <= 3'd0 ;
                CountWay1[i+32] <= 3'd0 ;
                CountWay1[i+64] <= 3'd0 ;
                CountWay1[i+96] <= 3'd0 ;
                CountWay2[i]    <= 3'd0 ;
                CountWay2[i+32] <= 3'd0 ;
                CountWay2[i+64] <= 3'd0 ;
                CountWay2[i+96] <= 3'd0 ;
                CountWay3[i]    <= 3'd0 ;
                CountWay3[i+32] <= 3'd0 ;
                CountWay3[i+64] <= 3'd0 ;
                CountWay3[i+96] <= 3'd0 ;
                CountWay4[i]    <= 3'd0 ;
                CountWay4[i+32] <= 3'd0 ;
                CountWay4[i+64] <= 3'd0 ;
                CountWay4[i+96] <= 3'd0 ;
            end
        end
        else begin
            if(InHitAble) begin
                if(InHitWay1) begin
                    CountWay1[InHitIndex] <= 3'd0 ;
                    CountWay2[InHitIndex] <= (CountWay2[InHitIndex] != 3'b111) ? CountWay2[InHitIndex] + 1 : CountWay2[InHitIndex] ;
                    CountWay3[InHitIndex] <= (CountWay3[InHitIndex] != 3'b111) ? CountWay3[InHitIndex] + 1 : CountWay3[InHitIndex] ;
                    CountWay4[InHitIndex] <= (CountWay4[InHitIndex] != 3'b111) ? CountWay4[InHitIndex] + 1 : CountWay4[InHitIndex] ;
                end 
                if(InHitWay2) begin
                    CountWay1[InHitIndex] <= (CountWay1[InHitIndex] != 3'b111) ? CountWay1[InHitIndex] + 1 : CountWay1[InHitIndex] ;
                    CountWay2[InHitIndex] <= 3'd0 ;
                    CountWay3[InHitIndex] <= (CountWay3[InHitIndex] != 3'b111) ? CountWay3[InHitIndex] + 1 : CountWay3[InHitIndex] ;
                    CountWay4[InHitIndex] <= (CountWay4[InHitIndex] != 3'b111) ? CountWay4[InHitIndex] + 1 : CountWay4[InHitIndex] ;
                end 
                if(InHitWay3) begin
                    CountWay1[InHitIndex] <= (CountWay1[InHitIndex] != 3'b111) ? CountWay1[InHitIndex] + 1 : CountWay1[InHitIndex] ;
                    CountWay2[InHitIndex] <= (CountWay2[InHitIndex] != 3'b111) ? CountWay2[InHitIndex] + 1 : CountWay2[InHitIndex] ;
                    CountWay3[InHitIndex] <= 3'd0 ;
                    CountWay4[InHitIndex] <= (CountWay4[InHitIndex] != 3'b111) ? CountWay4[InHitIndex] + 1 : CountWay4[InHitIndex] ;
                end 
                if(InHitWay4) begin
                    CountWay1[InHitIndex] <= (CountWay1[InHitIndex] != 3'b111) ? CountWay1[InHitIndex] + 1 : CountWay1[InHitIndex] ;
                    CountWay2[InHitIndex] <= (CountWay2[InHitIndex] != 3'b111) ? CountWay2[InHitIndex] + 1 : CountWay2[InHitIndex] ;
                    CountWay3[InHitIndex] <= (CountWay3[InHitIndex] != 3'b111) ? CountWay3[InHitIndex] + 1 : CountWay3[InHitIndex] ;
                    CountWay4[InHitIndex] <= 3'd0 ;
                end 
            end
            else begin
                CountWay1[InHitIndex] <= CountWay1[InHitIndex] ;
                CountWay2[InHitIndex] <= CountWay2[InHitIndex] ;
                CountWay3[InHitIndex] <= CountWay3[InHitIndex] ;
                CountWay4[InHitIndex] <= CountWay4[InHitIndex] ;
            end
        end
    end 

    reg [3:0] Dirty [0:127] ;

    wire       WriteDirtAble ;
    wire [6:0] WriteHitIndex ;
    wire       WriteWay1Hit  ;
    wire       WriteWay2Hit  ;
    wire       WriteWay3Hit  ;
    wire       WriteWay4Hit  ;
    wire       WriteBackAble ;
    wire [6:0] WriteBackIdex ;
    wire       WriteBack1Hit ;
    wire       WriteBack2Hit ;
    wire       WriteBack3Hit ;
    wire       WriteBack4Hit ;



    integer j ;
    always @(posedge Clk) begin
        if(!Rest) begin
            for (j =0 ;j < 32; j=j+1) begin
                Dirty[i] <= 4'd0 ; 
                Dirty[i+32] <= 4'd0 ; 
                Dirty[i+64] <= 4'd0 ; 
                Dirty[i+96] <= 4'd0 ; 
            end
        end
        else begin
            Dirty[WriteHitIndex] <= WriteDirtAble ? (Dirty[WriteHitIndex] | {WriteWay4Hit,WriteWay3Hit,WriteWay2Hit,WriteWay1Hit}) : Dirty[WriteHitIndex] ;
            Dirty[WriteBackIdex] <= WriteBackAble ? (Dirty[WriteBackIdex] & {~WriteBack4Hit,~WriteBack3Hit,~WriteBack2Hit,~WriteBack1Hit}) : Dirty[WriteBackIdex] ;
        end
    end 

    reg  [3:0] ReLoadIng [0:127] ;

    wire       ReloadAble  ;
    wire [6:0] ReloadIedx  ;
    wire       ReloadWay1  ;
    wire       ReloadWay2  ;
    wire       ReloadWay3  ;
    wire       ReloadWay4  ;
    wire       RlSuccAble  ;
    wire [6:0] RlSuccIedx  ;
    wire       RlSuccWay1  ;
    wire       RlSuccWay2  ;
    wire       RlSuccWay3  ;
    wire       RlSuccWay4  ;

    assign RlSuccAble = Writ2DirtAble ;
    assign RlSuccIedx = Writ2HitIndex ;
    assign RlSuccWay1 = Writ2Way1Hit  ;
    assign RlSuccWay2 = Writ2Way2Hit  ;
    assign RlSuccWay3 = Writ2Way3Hit  ;
    assign RlSuccWay4 = Writ2Way4Hit  ;



    integer k ;
    always @(posedge Clk) begin
        if(!Rest) begin
            for (k = 0;k<32;k=k+1 ) begin
                ReLoadIng[k]    <= 4'd0 ;
                ReLoadIng[k+32] <= 4'd0 ;
                ReLoadIng[k+64] <= 4'd0 ;
                ReLoadIng[k+96] <= 4'd0 ;
            end
        end
        else if(ReloadAble) begin
            ReLoadIng[ReloadIedx] <= {ReloadWay4,ReloadWay3,ReloadWay2,ReloadWay1} ;
        end
        else if(RlSuccAble) begin
            ReLoadIng[RlSuccIedx] <= ReLoadIng[RlSuccIedx] & {~RlSuccWay4,~RlSuccWay3,~RlSuccWay2,~RlSuccWay1}  ;
        end
    end


    reg         LoadStoreSelct ;
    reg         RLoadSuccess   ;
    reg         RStoreSuccess  ;
    always @(posedge Clk) begin
        if(!Rest) begin
            LoadStoreSelct <= 1'b0 ;
            RLoadSuccess    <= 1'b0 ;
            RStoreSuccess   <= 1'b0 ;
        end
        else if(LoadAble & StoreAble & ~LoadStoreSelct) begin
            LoadStoreSelct <= 1'b1 ;
            RLoadSuccess    <= 1'b1 ;
            RStoreSuccess   <= 1'b0 ;
        end
        else if(LoadAble & StoreAble & LoadStoreSelct) begin
            LoadStoreSelct <= 1'b0 ;
            RLoadSuccess    <= 1'b0 ;
            RStoreSuccess   <= 1'b1 ;
        end
        else if(LoadAble & ~StoreAble) begin
            LoadStoreSelct <= 1'b1 ;
            RLoadSuccess    <= 1'b1 ;
            RStoreSuccess   <= 1'b0 ;
        end
        else if(~LoadAble & StoreAble) begin
            LoadStoreSelct <= 1'b0 ;
            RLoadSuccess    <= 1'b0 ;
            RStoreSuccess   <= 1'b1 ;
        end
        else begin
            LoadStoreSelct <= 1'b0 ;
            RLoadSuccess    <= 1'b0 ;
            RStoreSuccess   <= 1'b0 ;
        end
    end

    assign LoadSuccess  = RLoadSuccess ;
    assign StoreSuccess = RStoreSuccess;


    wire [6:0] AGUIndex  = ((LoadAble & StoreAble & ~LoadStoreSelct) | (LoadAble & ~StoreAble)) ? LoadPhyAddr [11:5]   :
                           ((LoadAble & StoreAble &  LoadStoreSelct) | (~LoadAble & StoreAble)) ? StorePhyAddr[11:5]   : 7'd0 ;
    wire [4:0] AGUOffset = ((LoadAble & StoreAble & ~LoadStoreSelct) | (LoadAble & ~StoreAble)) ? LoadPhyAddr [4:0]    :
                           ((LoadAble & StoreAble &  LoadStoreSelct) | (~LoadAble & StoreAble)) ? StorePhyAddr[4:0]    : 5'd0 ;
    wire [19:0]AGUTag    = ((LoadAble & StoreAble & ~LoadStoreSelct) | (LoadAble & ~StoreAble)) ? LoadPhyAddr [31:12]  :
                           ((LoadAble & StoreAble &  LoadStoreSelct) | (~LoadAble & StoreAble)) ? StorePhyAddr[31:12]  : 20'd0 ;

    wire       FinalLoad = ((LoadAble & StoreAble & ~LoadStoreSelct) | (LoadAble & ~StoreAble)) ;
    wire       FinalStore= ((LoadAble & StoreAble &  LoadStoreSelct) | (~LoadAble & StoreAble)) ;


    wire         Way1Able   = `AbleValue ;
    wire  [6:0]  Way1Index  = MSHRUpAble              ? MSHRUpAddr[11:5] : 
                              (LoadAble | StoreAble)  ? AGUIndex         : 7'd0 ;
    wire  [31:0] Way1Wen    = ({32{(DcacheHit[0] & FinalStore)}} & {{4{(AGUOffset[4:2] == 3'd7)}},
                                                                    {4{(AGUOffset[4:2] == 3'd6)}},
                                                                    {4{(AGUOffset[4:2] == 3'd5)}},
                                                                    {4{(AGUOffset[4:2] == 3'd4)}},
                                                                    {4{(AGUOffset[4:2] == 3'd3)}},
                                                                    {4{(AGUOffset[4:2] == 3'd2)}},
                                                                    {4{(AGUOffset[4:2] == 3'd1)}},
                                                                    {4{(AGUOffset[4:2] == 3'd0)}}}) | {32{(MSHRUpAble & MSHRUpWay[0])}} ;
    wire         Way1TagWen = (MSHRUpAble & MSHRUpWay[0])   ;
    wire  [19:0] Way1Tag    = MSHRUpAddr[31:12]  ;
    wire  [255:0]Way1Date   = (DcacheHit[0] & FinalStore) ? {StoreDate,StoreDate,StoreDate,StoreDate,StoreDate,StoreDate,StoreDate,StoreDate} :
                              (MSHRUpAble & MSHRUpWay[0]) ? MSHRUpDate                                                                        : 256'd0 ;
    wire  [19:0] OutWay1Tag   ;
    wire  [255:0]OutWay1Date  ;


    data_128x256 way1_data_128x256(
    .clka  ( Clk         ),
    .ena   ( Way1Able    ),
    .wea   ( Way1Wen     ),
    .addra ( Way1Index   ),
    .dina  ( Way1Date    ),
    .douta ( OutWay1Date )
    ); 

    tag_128x256 way1_tag_128x256(
    .clka  ( Clk         ),
    .ena   ( Way1Able    ),
    .wea   ( Way1TagWen  ),
    .addra ( Way1Index   ),
    .dina  ( Way1Tag     ),
    .douta ( OutWay1Tag  )
    ); 

    wire         Way2Able   = `AbleValue ;
    wire  [6:0]  Way2Index  = MSHRUpAble              ? MSHRUpAddr[11:5] : 
                              (LoadAble | StoreAble)  ? AGUIndex         : 7'd0 ;
    wire  [31:0] Way2Wen    = ({32{(DcacheHit[1] & FinalStore)}} & {{4{(AGUOffset[4:2] == 3'd7)}},
                                                                    {4{(AGUOffset[4:2] == 3'd6)}},
                                                                    {4{(AGUOffset[4:2] == 3'd5)}},
                                                                    {4{(AGUOffset[4:2] == 3'd4)}},
                                                                    {4{(AGUOffset[4:2] == 3'd3)}},
                                                                    {4{(AGUOffset[4:2] == 3'd2)}},
                                                                    {4{(AGUOffset[4:2] == 3'd1)}},
                                                                    {4{(AGUOffset[4:2] == 3'd0)}}}) | {32{(MSHRUpAble & MSHRUpWay[1])}} ;
    wire         Way2TagWen = (MSHRUpAble & MSHRUpWay[1])   ;
    wire  [19:0] Way2Tag    = MSHRUpAddr[31:12]  ;
    wire  [255:0]Way2Date   = (DcacheHit[1] & FinalStore) ? {StoreDate,StoreDate,StoreDate,StoreDate,StoreDate,StoreDate,StoreDate,StoreDate} :
                              (MSHRUpAble & MSHRUpWay[1]) ? MSHRUpDate                                                                        : 256'd0 ;

    wire  [19:0] OutWay2Tag   ;
    wire  [255:0]OutWay2Date  ;

    data_128x256 way2_data_128x256(
    .clka  ( Clk         ),
    .ena   ( Way2Able    ),
    .wea   ( Way2Wen     ),
    .addra ( Way2Index   ),
    .dina  ( Way2Date    ),
    .douta ( OutWay2Date )
    ); 

    tag_128x256 way2_tag_128x256(
    .clka  ( Clk         ),
    .ena   ( Way2Able    ),
    .wea   ( Way2TagWen  ),
    .addra ( Way2Index   ),
    .dina  ( Way2Tag     ),
    .douta ( OutWay2Tag  )
    ); 

    wire         Way3Able   = `AbleValue ;
    wire  [6:0]  Way3Index  = MSHRUpAble              ? MSHRUpAddr[11:5] : 
                              (LoadAble | StoreAble)  ? AGUIndex         : 7'd0 ;
    wire  [31:0] Way3Wen    = ({32{(DcacheHit[2] & FinalStore)}} & {{4{(AGUOffset[4:2] == 3'd7)}},
                                                                    {4{(AGUOffset[4:2] == 3'd6)}},
                                                                    {4{(AGUOffset[4:2] == 3'd5)}},
                                                                    {4{(AGUOffset[4:2] == 3'd4)}},
                                                                    {4{(AGUOffset[4:2] == 3'd3)}},
                                                                    {4{(AGUOffset[4:2] == 3'd2)}},
                                                                    {4{(AGUOffset[4:2] == 3'd1)}},
                                                                    {4{(AGUOffset[4:2] == 3'd0)}}}) | {32{(MSHRUpAble & MSHRUpWay[2])}} ;
    wire         Way3TagWen = (MSHRUpAble & MSHRUpWay[2])   ;
    wire  [19:0] Way3Tag    = MSHRUpAddr[31:12]  ;
    wire  [255:0]Way3Date   = (DcacheHit[2] & FinalStore) ? {StoreDate,StoreDate,StoreDate,StoreDate,StoreDate,StoreDate,StoreDate,StoreDate} :
                              (MSHRUpAble & MSHRUpWay[2]) ? MSHRUpDate                                                                        : 256'd0 ;

    wire  [19:0] OutWay3Tag   ;
    wire  [255:0]OutWay3Date  ;

    data_128x256 way3_data_128x256(
    .clka  ( Clk         ),
    .ena   ( Way3Able    ),
    .wea   ( Way3Wen     ),
    .addra ( Way3Index   ),
    .dina  ( Way3Date    ),
    .douta ( OutWay3Date )
    ); 

    tag_128x256 way3_tag_128x256(
    .clka  ( Clk         ),
    .ena   ( Way3Able    ),
    .wea   ( Way3TagWen  ),
    .addra ( Way3Index   ),
    .dina  ( Way3Tag     ),
    .douta ( OutWay3Tag  )
    ); 

    wire         Way4Able   = `AbleValue ;
    wire  [6:0]  Way4Index  = MSHRUpAble              ? MSHRUpAddr[11:5] : 
                              (LoadAble | StoreAble)  ? AGUIndex         : 7'd0 ;
    wire  [31:0] Way4Wen    = ({32{(DcacheHit[3] & FinalStore)}} & {{4{(AGUOffset[4:2] == 3'd7)}},
                                                                    {4{(AGUOffset[4:2] == 3'd6)}},
                                                                    {4{(AGUOffset[4:2] == 3'd5)}},
                                                                    {4{(AGUOffset[4:2] == 3'd4)}},
                                                                    {4{(AGUOffset[4:2] == 3'd3)}},
                                                                    {4{(AGUOffset[4:2] == 3'd2)}},
                                                                    {4{(AGUOffset[4:2] == 3'd1)}},
                                                                    {4{(AGUOffset[4:2] == 3'd0)}}}) | {32{(MSHRUpAble & MSHRUpWay[3])}} ;
    wire         Way4TagWen = (MSHRUpAble & MSHRUpWay[3])   ;
    wire  [19:0] Way4Tag    = MSHRUpAddr[31:12]  ;
    wire  [255:0]Way4Date   = (DcacheHit[3] & FinalStore) ? {StoreDate,StoreDate,StoreDate,StoreDate,StoreDate,StoreDate,StoreDate,StoreDate} :
                              (MSHRUpAble & MSHRUpWay[3]) ? MSHRUpDate                                                                        : 256'd0 ;

    wire  [19:0] OutWay4Tag   ;
    wire  [255:0]OutWay4Date  ;

    data_128x256 way4_data_128x256(
    .clka  ( Clk         ),
    .ena   ( Way4Able    ),
    .wea   ( Way4Wen     ),
    .addra ( Way4Index   ),
    .dina  ( Way4Date    ),
    .douta ( OutWay4Date )
    ); 

    tag_128x256 way4_tag_128x256(
    .clka  ( Clk         ),
    .ena   ( Way4Able    ),
    .wea   ( Way4TagWen  ),
    .addra ( Way4Index   ),
    .dina  ( Way4Tag     ),
    .douta ( OutWay4Tag  )
    ); 

    wire [1:0]  DcacheMat  = ((LoadAble & StoreAble & ~LoadStoreSelct) | (LoadAble & ~StoreAble)) ? LoadMat   :
                             ((LoadAble & StoreAble &  LoadStoreSelct) | (~LoadAble & StoreAble)) ? StoreMat  :  2'b0 ;

    wire [3:0]  DcacheHit  = {4{(AGUTag == OutWay4Tag) & (DcacheMat != 2'b00) & ((FinalStore & (ReLoadIng[AGUIndex][3])) | (FinalLoad))}} & 4'b1000 |
                             {4{(AGUTag == OutWay3Tag) & (DcacheMat != 2'b00) & ((FinalStore & (ReLoadIng[AGUIndex][2])) | (FinalLoad))}} & 4'b0100 |
                             {4{(AGUTag == OutWay2Tag) & (DcacheMat != 2'b00) & ((FinalStore & (ReLoadIng[AGUIndex][1])) | (FinalLoad))}} & 4'b0010 |
                             {4{(AGUTag == OutWay1Tag) & (DcacheMat != 2'b00) & ((FinalStore & (ReLoadIng[AGUIndex][0])) | (FinalLoad))}} & 4'b0001 ;

    wire [255:0]DcacheHitDate = {256{(AGUTag == OutWay4Tag) & (DcacheMat != 2'b00)}} & Way4Date |
                                {256{(AGUTag == OutWay3Tag) & (DcacheMat != 2'b00)}} & Way3Date |
                                {256{(AGUTag == OutWay2Tag) & (DcacheMat != 2'b00)}} & Way2Date |
                                {256{(AGUTag == OutWay1Tag) & (DcacheMat != 2'b00)}} & Way1Date ;

    wire [255:0] LoadOut = DcacheHitDate >> {AGUOffset[4:2],5'd0} ;

    wire [6:0]  DIrtyindex = MSHRUpAble             ? MSHRUpAddr[11:5]   : 
                             (LoadAble | StoreAble) ? AGUIndex           : 7'd0 ;
    wire [3:0]  DcacheDirty= Dirty[DIrtyindex] ;

    wire [3:0]  ReplaceSelect = {4{((CountWay4[AGUIndex] > CountWay1[AGUIndex]) & (CountWay4[AGUIndex] > CountWay2[AGUIndex]) & 
                                  (CountWay4[AGUIndex] > CountWay3[AGUIndex]))}} & 4'b1000 |
                                {4{ ((CountWay3[AGUIndex] > CountWay1[AGUIndex]) & (CountWay3[AGUIndex] > CountWay2[AGUIndex]) & 
                                  (CountWay3[AGUIndex] > CountWay4[AGUIndex]))}} & 4'b0100 |
                                {4{((CountWay2[AGUIndex] > CountWay1[AGUIndex]) & (CountWay2[AGUIndex] > CountWay3[AGUIndex]) & 
                                  (CountWay2[AGUIndex] > CountWay4[AGUIndex]))}} & 4'b0010 |
                                {4{((CountWay1[AGUIndex] > CountWay2[AGUIndex]) & (CountWay1[AGUIndex] > CountWay3[AGUIndex]) & 
                                  (CountWay1[AGUIndex] > CountWay4[AGUIndex]))}} & 4'b0001 ;

    wire [3:0] DirtyReplace = ReplaceSelect & DcacheDirty ;
    
    assign WriteBuffAble = ((((FinalLoad) && (DirtyReplace != 4'b0000)) || (FinalStore && ((DirtyReplace != 4'b0000) || (DcacheMat == 2'b00)))) && (DcacheHit == 4'b0000)); 
    assign WriteBuffAddr = {AGUTag, AGUIndex,5'd0} ;
    assign WriteBuffPtr  = ((LoadAble & StoreAble & ~LoadStoreSelct) | (LoadAble & ~StoreAble)) ? LoadPtr   :
                           ((LoadAble & StoreAble &  LoadStoreSelct) | (~LoadAble & StoreAble)) ? StorePtr  :  3'b0 ;

    assign WriteBackCnt  = (FinalStore && (DcacheMat != 2'b00)) ? 8'b00000001 : 8'b11111111 ;
    assign WriteBackDate = (FinalStore && (DcacheMat != 2'b00)) ? {224'd0,StoreDate} : ({256{ReplaceSelect[0] & DcacheDirty[0]}} & OutWay1Date | 
                                                                                        {256{ReplaceSelect[1] & DcacheDirty[1]}} & OutWay2Date | 
                                                                                        {256{ReplaceSelect[2] & DcacheDirty[2]}} & OutWay3Date | 
                                                                                        {256{ReplaceSelect[3] & DcacheDirty[3]}} & OutWay4Date ) ;

    assign WriteBackAble = (((FinalLoad) && (DirtyReplace != 4'b0000)) | (FinalStore && ((DirtyReplace != 4'b0000) && (DcacheMat != 2'b00))) && (DcacheHit == 4'b0000)); 
    assign WriteBackIdex = AGUIndex ;
    assign WriteBack1Hit = ReplaceSelect[0] & DcacheDirty[0] ;
    assign WriteBack2Hit = ReplaceSelect[1] & DcacheDirty[1] ;
    assign WriteBack3Hit = ReplaceSelect[2] & DcacheDirty[2] ;
    assign WriteBack4Hit = ReplaceSelect[3] & DcacheDirty[3] ;

    assign InHitAble     = ((FinalLoad | FinalStore) & (DcacheHit != 4'd0 )) | (In2HitAble);
    assign InHitIndex    = (FinalLoad | FinalStore) ? AGUIndex    : 
                           In2HitAble               ? In2HitIndex : 7'd0 ;
    assign InHitWay1     = (FinalLoad | FinalStore) ? DcacheHit[0]: 
                           In2HitAble               ? In2HitWay1  : 1'd0 ;
    assign InHitWay2     = (FinalLoad | FinalStore) ? DcacheHit[1]: 
                           In2HitAble               ? In2HitWay2  : 1'd0 ;
    assign InHitWay3     = (FinalLoad | FinalStore) ? DcacheHit[2]: 
                           In2HitAble               ? In2HitWay3  : 1'd0 ;
    assign InHitWay4     = (FinalLoad | FinalStore) ? DcacheHit[3]: 
                           In2HitAble               ? In2HitWay4  : 1'd0 ;

    assign WriteDirtAble = (FinalStore & (DcacheHit != 4'd0 )) | Writ2DirtAble ;
    assign WriteHitIndex = FinalStore    ? AGUIndex      : 
                           Writ2DirtAble ? Writ2HitIndex : 7'd0 ;
    assign WriteWay1Hit  = FinalStore    ? DcacheHit[0]  : 
                           Writ2DirtAble ? Writ2Way1Hit  : 1'd0 ;
    assign WriteWay2Hit  = FinalStore    ? DcacheHit[1]  : 
                           Writ2DirtAble ? Writ2Way2Hit  : 1'd0 ;
    assign WriteWay3Hit  = FinalStore    ? DcacheHit[2]  : 
                           Writ2DirtAble ? Writ2Way3Hit  : 1'd0 ;
    assign WriteWay4Hit  = FinalStore    ? DcacheHit[3]  : 
                           Writ2DirtAble ? Writ2Way4Hit  : 1'd0 ;

    assign MSHRAble      = (FinalLoad | FinalStore ) && (DcacheHit == 4'b0000) ;
    assign MSHRAddr      = {AGUTag, AGUIndex,5'd0} ; 
    assign MSHRLoad      = FinalLoad  ;
    assign MSHRStore     = FinalStore ;
    assign MSHRStoreTemp = FinalStore ? StoreDate : 32'd0 ;
    assign MSHRWay       = ReplaceSelect ;
    assign MSHRPtr       = ((LoadAble & StoreAble & ~LoadStoreSelct) | (LoadAble & ~StoreAble)) ? LoadPtr   :
                           ((LoadAble & StoreAble &  LoadStoreSelct) | (~LoadAble & StoreAble)) ? StorePtr  :  3'b0 ;

    assign ReloadAble    = (FinalLoad | (FinalStore && (DcacheMat != 2'b00))) && (DcacheHit == 4'b0000) ;
    assign ReloadIedx    = AGUIndex ;
    assign WriteWay1Hit  = ReplaceSelect[0] ;
    assign WriteWay1Hit  = ReplaceSelect[1] ;
    assign WriteWay1Hit  = ReplaceSelect[2] ;
    assign WriteWay1Hit  = ReplaceSelect[3] ;



    reg                RLoadBack     ;
    reg    [2:0]       RLoadBackPtr  ;
    reg    [`DataBus]  RLoadBackDate ;
    reg                RStoreBack    ;
    reg    [2:0]       RStoreBackPtr ;

    always @(posedge Clk) begin
        if(!Rest) begin
            RLoadBack <= `EnableValue ;
            RLoadBackPtr <= 3'd0   ;
            RLoadBackDate <= 32'd0 ;
            RStoreBack <= `EnableValue ;
            RStoreBackPtr <= 3'd0 ;
        end
        else begin
            RLoadBack <= (DcacheHit != 4'b0000) & FinalLoad  ;
            RLoadBackPtr <= LoadPtr   ;
            RLoadBackDate <= LoadOut[31:0];
            RStoreBack <= (DcacheHit != 4'b0000) & FinalStore ;
            RStoreBackPtr <= StorePtr ;
        end
    end

    assign LoadBack     = RLoadBack      ;
    assign LoadBackPtr  = RLoadBackPtr   ;
    assign LoadBackDate = RLoadBackDate  ;
    assign StoreBack    = RStoreBack     ;
    assign StoreBackPtr = RStoreBackPtr  ;
    

endmodule 
`timescale 1ps/1ps
`include "../define.v"

module DCacheStage2 (
    input       wire                                 Clk          ,
    input       wire                                 Rest         ,
    //for write buffer
    input       wire                                 WriteBuffAble,
    input       wire     [`InstAddrBus]              WriteBuffAddr,
    input       wire     [255:0]                     WriteBackDate,
    input       wire     [7:0]                       WriteBackCnt ,
    input       wire     [2:0]                       WriteBuffPtr ,
    //for MSHR
    input       wire                                 MSHRAble     ,
    input       wire     [`InstAddrBus]              MSHRAddr     ,
    input       wire                                 MSHRLoad     ,
    input       wire                                 MSHRStore    ,
    input       wire     [`DataBus]                  MSHRStoreTemp,
    input       wire     [3:0]                       MSHRWay      ,
    input       wire     [2:0]                       MSHRPtr      ,  
    output      wire                                 MSHRUpAble   ,
    output      wire     [255:0]                     MSHRUpDate   ,
    output      wire     [`InstAddrBus]              MSHRUpAddr   ,
    output      wire     [3:0]                       MSHRUpWay    ,
    output      wire                                 In2HitAble   ,
    output      wire     [6:0]                       In2HitIndex  ,
    output      wire                                 In2HitWay1   ,
    output      wire                                 In2HitWay2   ,
    output      wire                                 In2HitWay3   ,
    output      wire                                 In2HitWay4   ,
    output      wire                                 Writ2DirtAble,
    output      wire     [6:0]                       Writ2HitIndex,
    output      wire                                 Writ2Way1Hit ,
    output      wire                                 Writ2Way2Hit ,
    output      wire                                 Writ2Way3Hit ,
    output      wire                                 Writ2Way4Hit ,
    //for AXI 
    output      wire                                 DcaWriteAble ,
    inout       wire                                 DWshankhand  , //与uncache 共用
    output      wire                                 DWriteUncache,
    output      wire     [3:0]                       UncacheStrb  , //uncache 时只可能是len为1的时候
    output      wire     [`InstAddrBus]              DcaWriteAddr ,
    output      wire     [255:0]                     DcaWDate     ,
    output      wire                                 DcaReadAble  ,
    input       wire                                 DRshankhand  ,
    output      wire                                 DUnacheRead  ,
    output      wire     [`InstAddrBus]              DcaReadAddr  ,
    //to lsu 
    output      wire                                 LoadBack     ,
    output      wire     [2:0]                       LoadBackPtr  ,
    output      wire     [`DataBus]                  LoadBackDate ,
    output      wire                                 StoreBack    ,
    output      wire     [2:0]                       StoreBackPtr
);

    reg [331:31] RegWriteBuffer [1:8] ;

    reg [2:0]   WritePtr ;
    reg [2:0]   ReadPtr  ;

    localparam WEITEWRITE = 3'b000 ;

    wire [3:0]  SamePtr = {4{(WriteBuffAddr == RegWriteBuffer[8][327:296]) && (RegWriteBuffer[8][332:328] == WEITEWRITE)}} & 4'd8 | 
                          {4{(WriteBuffAddr == RegWriteBuffer[7][327:296]) && (RegWriteBuffer[7][332:328] == WEITEWRITE)}} & 4'd7 | 
                          {4{(WriteBuffAddr == RegWriteBuffer[6][327:296]) && (RegWriteBuffer[6][332:328] == WEITEWRITE)}} & 4'd6 | 
                          {4{(WriteBuffAddr == RegWriteBuffer[5][327:296]) && (RegWriteBuffer[5][332:328] == WEITEWRITE)}} & 4'd5 | 
                          {4{(WriteBuffAddr == RegWriteBuffer[4][327:296]) && (RegWriteBuffer[4][332:328] == WEITEWRITE)}} & 4'd4 | 
                          {4{(WriteBuffAddr == RegWriteBuffer[3][327:296]) && (RegWriteBuffer[3][332:328] == WEITEWRITE)}} & 4'd3 | 
                          {4{(WriteBuffAddr == RegWriteBuffer[2][327:296]) && (RegWriteBuffer[2][332:328] == WEITEWRITE)}} & 4'd2 | 
                          {4{(WriteBuffAddr == RegWriteBuffer[1][327:296]) && (RegWriteBuffer[1][332:328] == WEITEWRITE)}} & 4'd1 ;

    always @(posedge Clk) begin
        if(!Rest) begin
            WritePtr          <= 3'd0   ;
            RegWriteBuffer[1] <= 300'd0 ;
            RegWriteBuffer[2] <= 300'd0 ;
            RegWriteBuffer[3] <= 300'd0 ;
            RegWriteBuffer[4] <= 300'd0 ;
            RegWriteBuffer[5] <= 300'd0 ;
            RegWriteBuffer[6] <= 300'd0 ;
            RegWriteBuffer[7] <= 300'd0 ;
            RegWriteBuffer[8] <= 300'd0 ;
        end
        else if(WriteBuffAble) begin
            if(SamePtr != 4'b0000) begin
                WritePtr <= WritePtr ;
                RegWriteBuffer[SamePtr] <= {RegWriteBuffer[SamePtr][331:296], (((RegWriteBuffer[SamePtr][295:40] & (~WriteBackCnt)) | (WriteBackDate & WriteBackCnt))),(RegWriteBuffer[SamePtr][39:32] | WriteBackCnt)} ;
                
            end
            
        end
    end
    
endmodule
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
`timescale 1ps/1ps
`include "../define.v" 

module AGUStore (
    input      wire                               Clk             ,
    input      wire                               Rest            ,

    input      wire                               AGUStoreStop    ,
    input      wire                               AGUStoreFlash   ,

    input      wire                               StoreInstAble   ,
    input      wire      [`MicOperateCode]        StoreMicOPercode,
    input      wire                               StoreRegAble0   ,
    input      wire      [`ReNameRegBUs]          StoreRegAddr0   ,
    input      wire      [`DataBus]               StoreRegDate0   ,
    input      wire                               StoreRegAble1   ,
    input      wire      [`ReNameRegBUs]          StoreRegAddr1   ,
    input      wire      [`DataBus]               StoreRegDate1   ,  
    input      wire      [11:0]                   StoreImmDate    ,
    input      wire                               StoreWbAble     ,
    input      wire      [`ReNameRegBUs]          StoreWbAddr     ,
    input      wire      [5:0]                    StoreInstRobPtr ,

    input      wire                               StoreBruAble    ,
    input      wire      [`ReNameRegBUs]          StoreBruAddr    ,
    input      wire      [`DataBus]               StoreBruDate    ,
    input      wire                               StoreAlu2Able   ,
    input      wire      [`ReNameRegBUs]          StoreAlu2Addr   ,
    input      wire      [`DataBus]               StoreAlu2Date   ,
    input      wire                               StoreAlu1Able   ,
    input      wire      [`ReNameRegBUs]          StoreAlu1Addr   ,
    input      wire      [`DataBus]               StoreAlu1Date   ,
    input      wire                               StoreMluAble    ,
    input      wire      [`ReNameRegBUs]          StoreMluAddr    ,
    input      wire      [`DataBus]               StoreMluDate    , 
    input      wire                               StoreCsrAble    ,
    input      wire      [`ReNameRegBUs]          StoreCsrAddr    ,
    input      wire      [`DataBus]               StoreCsrDate    ,
    //for mmu 
    output     wire                               ToSAccess       ,
    output     wire      [31:0]                   ToSVritualA     ,
    input      wire      [1:0]                    ToSOperType     ,
    input      wire                               ToSTlbTrap      ,
    input      wire      [6:0]                    ToSTlbTrapType  ,
    input      wire      [`InstAddrBus]           ToSPhysicalAddr ,                              
    //to load buffer
    output     wire                               ToSBAble       ,
    output     wire      [`MicOperateCode]        ToSBMicOp      ,
    output     wire      [`DataBus]               ToSBWDate      ,
    output     wire      [1:0]                    ToSBMAT        ,   
    output     wire      [`InstAddrBus]           ToSBPAddr      ,
    output     wire                               ToSBTrap       ,
    output     wire      [6:0]                    ToSBTrapCode   ,
    output     wire                               ToSBWbAble     ,
    output     wire      [`ReNameRegBUs]          ToSBWbAddr     ,
    output     wire      [5:0]                    ToSBRobPtr                            
);


    wire  [`DataBus] STSrc1Date   =  ((StoreRegAddr0 == StoreBruAddr ) & StoreBruAble  & StoreRegAble0) ? StoreBruDate :
                                     ((StoreRegAddr0 == StoreAlu1Addr) & StoreAlu1Able & StoreRegAble0) ? StoreAlu1Date:
                                     ((StoreRegAddr0 == StoreAlu2Addr) & StoreAlu2Able & StoreRegAble0) ? StoreAlu2Date:
                                     ((StoreRegAddr0 == StoreMluAddr ) & StoreMluAble  & StoreRegAble0) ? StoreMluDate :
                                     ((StoreRegAddr0 == StoreCsrAddr ) & StoreCsrAble  & StoreRegAble0) ? StoreCsrDate : StoreRegDate0 ;
     
    wire  [`DataBus] STSrc2Date   =  ((StoreRegAddr1 == StoreBruAddr ) & StoreBruAble  & StoreRegAble1) ? StoreBruDate :
                                     ((StoreRegAddr1 == StoreAlu1Addr) & StoreAlu1Able & StoreRegAble1) ? StoreAlu1Date:
                                     ((StoreRegAddr1 == StoreAlu2Addr) & StoreAlu2Able & StoreRegAble1) ? StoreAlu2Date:
                                     ((StoreRegAddr1 == StoreMluAddr ) & StoreMluAble  & StoreRegAble1) ? StoreMluDate :
                                     ((StoreRegAddr1 == StoreCsrAddr ) & StoreCsrAble  & StoreRegAble1) ? StoreCsrDate : StoreRegDate1 ;

    assign ToSAccess   = StoreInstAble ;
    assign ToSVritualA = STSrc1Date + {{20{StoreImmDate[11]}},StoreImmDate} ;

    reg                   ToSBAbleTemp    ;
    reg [`MicOperateCode] ToSBMicOpTemp   ;
    reg [`DataBus]        ToSBWDateTemp   ;
    reg                   ToSBWbAbleTemp  ;
    reg [`ReNameRegBUs]   ToSBWbAddrTemp  ;
    reg [5:0]             ToSBRobPtrTemp  ;
    always @(posedge Clk) begin
        if(!Rest) begin
            ToSBAbleTemp    <= 1'b0  ;
            ToSBMicOpTemp   <= 8'b0  ;
            ToSBWDateTemp   <= 32'b0 ;
            ToSBWbAbleTemp  <= 1'b0  ;
            ToSBWbAddrTemp  <= 7'b0  ;
            ToSBRobPtrTemp  <= 6'b0  ; 
        end
        else if(AGUStoreStop) begin
            ToSBAbleTemp    <= ToSBAbleTemp   ;
            ToSBMicOpTemp   <= ToSBMicOpTemp  ;
            ToSBWDateTemp   <= ToSBWDateTemp  ;
            ToSBWbAbleTemp  <= ToSBWbAbleTemp ;
            ToSBWbAddrTemp  <= ToSBWbAddrTemp ;
            ToSBRobPtrTemp  <= ToSBRobPtrTemp ; 
        end
        else if(AGUStoreFlash)begin
            ToSBAbleTemp    <= 1'b0  ;
            ToSBMicOpTemp   <= 8'b0  ;
            ToSBWDateTemp   <= 32'b0 ;
            ToSBWbAbleTemp  <= 1'b0  ;
            ToSBWbAddrTemp  <= 7'b0  ;
            ToSBRobPtrTemp  <= 6'b0  ;
        end
        else begin
            ToSBAbleTemp    <= StoreInstAble     ;
            ToSBMicOpTemp   <= StoreMicOPercode  ;
            ToSBWDateTemp   <= STSrc2Date       ;
            ToSBWbAbleTemp  <= StoreWbAble       ;
            ToSBWbAddrTemp  <= StoreWbAddr       ;
            ToSBRobPtrTemp  <= StoreInstRobPtr   ;
        end
    end
    

    assign ToSBAble    = ToSBAbleTemp    ;
    assign ToSBMicOp   = ToSBMicOpTemp   ;
    assign ToSBWDate   = ToSBWDateTemp   ;
    assign ToSBMAT     = ToSOperType     ;
    assign ToSBPAddr   = ToSPhysicalAddr ;
    assign ToSBTrap    = ToSTlbTrap      ;
    assign ToSBTrapCode= ToSTlbTrapType  ;
    assign ToSBWbAble  = ToSBWbAbleTemp  ;
    assign ToSBWbAddr  = ToSBWbAddrTemp  ;
    assign ToSBRobPtr  = ToSBRobPtrTemp  ;

        
endmodule
`timescale 1ps/1ps
`include "../define.v"

module Alu (
    input         wire                              Clk            ,
    input         wire                              Rest           ,
    //from ctrl 
    input         wire                              AluStop        ,
    input         wire                              AluFlash       ,
    //from issuequeueint 
    input         wire   [`InstAddrBus]             AluInstPc      ,
    input         wire   [`MicOperateCode]          AluMicOperate  ,
    input         wire                              AluSrc1Able    ,
    input         wire   [`ReNameRegBUs]            AluSrc1Addr    ,
    input         wire   [`DataBus]                 AluSrc1Date    ,
    input         wire                              AluSrc2Able    , //对于跳转指令的rd会被解码为src2
    input         wire   [`ReNameRegBUs]            AluSrc2Addr    ,
    input         wire   [`DataBus]                 AluSrc2Date    ,
    input         wire   [19:0]                     AluImmDate     ,
    input         wire                              AluRdAble      ,
    input         wire   [`ReNameRegBUs]            AluRdAddr      ,
    input         wire   [5:0]                      AluROBPtr      , 
    //from  bypass
    input         wire                              AluSelfAble    ,
    input         wire   [`ReNameRegBUs]            AluSelfAddr    ,
    input         wire   [`DataBus]                 AluSelfDate    ,
    input         wire                              AluBruAble     ,
    input         wire   [`ReNameRegBUs]            AluBruAddr     ,
    input         wire   [`DataBus]                 AluBruDate     ,
    input         wire                              AluAlu2Able    ,
    input         wire   [`ReNameRegBUs]            AluAlu2Addr    ,
    input         wire   [`DataBus]                 AluAlu2Date    ,
    input         wire                              AluMulAble     ,
    input         wire   [`ReNameRegBUs]            AluMulAddr     ,
    input         wire   [`DataBus]                 AluMulDate     , 
    input         wire                              AluCsrAble     ,
    input         wire   [`ReNameRegBUs]            AluCsrAddr     ,
    input         wire   [`DataBus]                 AluCsrDate     , 
    //to iqint 
    output        wire                              AluReq         ,
    //to physical 
    output        wire                              AluWBAble      ,
    output        wire   [`ReNameRegBUs]            AluWBAddr      ,
    output        wire   [`DataBus]                 AluWBDate      ,
    //to ROB
    output        wire                              AluCommitAble  ,
    output        wire   [5:0]                      AluCommitPtr   ,
    output        wire   [1:0]                      AluCommitType 

);

    reg             StopTemp     ;
    //reg             FLashTemp    ;

    always @(posedge Clk) begin
        if(!Rest) begin
            StopTemp  <= 1'b0 ;
            //FLashTemp <= 1'b0 ;
        end
        else begin
            StopTemp  <= AluStop  ;
            //FLashTemp <= AluFlash ;
        end
    end

    assign AluReq = ~StopTemp ;

    wire  [`DataBus] ASrc1Date   =  ((AluSrc1Addr == AluSelfAddr) & AluSelfAble & AluSrc1Able) ? AluSelfDate :
                                    ((AluSrc1Addr == AluBruAddr ) & AluBruAble  & AluSrc1Able) ? AluBruDate  :
                                    ((AluSrc1Addr == AluAlu2Addr) & AluAlu2Able & AluSrc1Able) ? AluAlu2Date :
                                    ((AluSrc1Addr == AluMulAddr ) & AluMulAble  & AluSrc1Able) ? AluMulDate  :
                                    ((AluSrc1Addr == AluCsrAddr ) & AluCsrAble  & AluSrc1Able) ? AluCsrDate  : AluSrc1Date ;
    
    wire  [`DataBus] ASrc2Date   =  ((AluSrc2Addr == AluSelfAddr) & AluSelfAble & AluSrc2Able) ? AluSelfDate :
                                    ((AluSrc2Addr == AluBruAddr ) & AluBruAble  & AluSrc2Able) ? AluBruDate  :
                                    ((AluSrc2Addr == AluAlu2Addr) & AluAlu2Able & AluSrc2Able) ? AluAlu2Date :
                                    ((AluSrc2Addr == AluMulAddr ) & AluMulAble  & AluSrc2Able) ? AluMulDate  :
                                    ((AluSrc2Addr == AluCsrAddr ) & AluCsrAble  & AluSrc2Able) ? AluCsrDate  : AluSrc2Date ;

    localparam REDIRNO     = 2'b00;

    reg                     RegAluWBAble      ;
    reg   [`ReNameRegBUs]   RegAluWBAddr      ;
    reg   [`DataBus]        RegAluWBDate      ;
    reg                     RegAluCommitAble  ;
    reg   [5:0]             RegAluCommitPtr   ;
    reg   [1:0]             RegAluCommitType  ;
    
    always @(posedge Clk) begin
        if(!Rest) begin
            RegAluWBAble <= `EnableValue ;
            RegAluWBAddr <= 7'b0         ;
            RegAluWBDate <= 32'd0        ;
            RegAluCommitAble <= `EnableValue ;
            RegAluCommitPtr <= 6'd0      ;
            RegAluCommitType <= REDIRNO  ;
        end
        else if(AluFlash) begin
            RegAluWBAble <= `EnableValue ;
            RegAluWBAddr <= 7'b0         ;
            RegAluWBDate <= 32'd0        ;
            RegAluCommitAble <= `EnableValue ;
            RegAluCommitPtr <= 6'd0      ;
            RegAluCommitType <= REDIRNO  ;
        end
        else if(StopTemp) begin
            RegAluWBAble <= RegAluWBAble        ;
            RegAluWBAddr <= RegAluWBAddr        ;
            RegAluWBDate <= RegAluWBDate        ;
            RegAluCommitAble <= RegAluCommitAble;
            RegAluCommitPtr <= RegAluCommitPtr  ;
            RegAluCommitType <= RegAluCommitType;
        end
        else begin
            RegAluWBAble <= AluRdAble ;
            RegAluWBAddr <= AluRdAddr ;
            RegAluCommitPtr <= AluROBPtr ;
            RegAluCommitType <= REDIRNO ;
            case (AluMicOperate)                     
                `InstAddw    :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= ASrc1Date + ASrc2Date ;                                                  end 
                `InstSubw    :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= ASrc1Date - ASrc2Date ;                                                  end 
                `InstAddiw   :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= ASrc1Date + {{20{AluImmDate[11]}}, AluImmDate[11:0]};                   end 
                `InstLu12iw  :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= {AluImmDate[19:0],12'd0};                                              end 
                `InstSlt     :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= ($signed(ASrc1Date) < $signed(ASrc2Date)) ? {31'd0,1'b1} : `ZeorDate ;  end
                `InstSltu    :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= (ASrc1Date < ASrc2Date) ? {31'd0,1'b1} : `ZeorDate ;                    end    
                `InstSlti    :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= ($signed(ASrc1Date) < {{20{AluImmDate[11]}},AluImmDate[11:0]}) ? {31'd0,1'b1} : `ZeorDate ;end 
                `InstSltui   :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= (ASrc1Date < {{20{1'b0}},AluImmDate[11:0]}) ? {31'd0,1'b1} : `ZeorDate;end 
                `InstAddu12i :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= AluInstPc + {AluImmDate[19:0],12'b0};                                  end 
                `InstAnd     :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= ASrc1Date & ASrc2Date ;                                                  end 
                `InstOr      :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= ASrc1Date | ASrc2Date ;                                                  end
                `InstNor     :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= ~(ASrc1Date | ASrc2Date) ;                                               end  
                `InstXor     :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= ASrc1Date ^ ASrc2Date ;                                                  end  
                `InstAndi    :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= ASrc1Date & {{20{1'b0}}, AluImmDate[11:0]};                             end
                `InstOri     :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= ASrc1Date | {{20{1'b0}}, AluImmDate[11:0]};                             end   
                `InstXori    :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= ASrc1Date ^ {{20{1'b0}}, AluImmDate[11:0]};                             end 
                `InstSllw    :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= ASrc1Date << ASrc2Date[4:0]      ;                                       end  
                `InstSrlw    :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= ASrc1Date >> ASrc2Date[4:0]      ;                                       end       
                `InstSraw    :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= ASrc1Date >>> ASrc2Date[4:0]     ;                                       end  
                `InstSlliw   :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= ASrc1Date << AluImmDate[4:0]    ;                                       end   
                `InstSrliw   :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= ASrc1Date >> AluImmDate[4:0]    ;                                       end 
                `InstSraiw   :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= ASrc1Date >>> AluImmDate[4:0]   ;                                       end     
                //`InstRdcntvlw:  begin   
                default: begin   RegAluCommitAble <= `EnableValue ;  RegAluWBDate <= `ZeorDate   ;   end 
            endcase
        end
    end
    
    assign AluWBAble  = RegAluWBAble  ;
    assign AluWBAddr  = RegAluWBAddr  ;
    assign AluWBDate  = RegAluWBDate  ;
    assign AluCommitAble = RegAluCommitAble ;
    assign AluCommitPtr  = RegAluCommitPtr  ;
    assign AluCommitType = RegAluCommitType ;

endmodule
`timescale 1ps/1ps
`include "../define.v"

module Bru (
    input         wire                                   Clk              ,
    input         wire                                   Rest             ,
    //for ctrl
    input         wire                                   BruStop          ,
    input         wire                                   BruFlash         ,
    //output        wire                                   BruReq           ,
    //from IssueQueueBrCsr
    input         wire   [`InstAddrBus]                  BruInstPc        ,
    input         wire   [`MicOperateCode]               BruMicOperate    ,
    input         wire                                   BruSrc1Able      ,
    input         wire   [`ReNameRegBUs]                 BruSrc1Addr      ,
    input         wire   [`DataBus]                      BruSrc1Date      ,
    input         wire                                   BruSrc2Able      , //对于跳转指令的rd会被解码为src2
    input         wire   [`ReNameRegBUs]                 BruSrc2Addr      ,
    input         wire   [`DataBus]                      BruSrc2Date      ,
    //input         wire                                   BruImmAble       ,
    input         wire   [25:0]                          BruImmDate       ,
    input         wire                                   BruRdAble        ,
    input         wire   [`ReNameRegBUs]                 BruRdAddr        ,
    input         wire                                   BruMode          ,
    input         wire   [`InstAddrBus]                  BruReDirDate     ,
    input         wire   [5:0]                           BruROBPtr        ,
    //from ex stage bypass
    input         wire                                   BruSelfAble      ,
    input         wire   [`ReNameRegBUs]                 BruSelfADdr      ,
    input         wire   [`DataBus]                      BruSelfDate      ,
    input         wire                                   BruAlu1Able      ,
    input         wire   [`ReNameRegBUs]                 BruALu1Addr      ,
    input         wire   [`DataBus]                      BruAlu1Date      ,
    input         wire                                   BruAlu2Able      ,
    input         wire   [`ReNameRegBUs]                 BruALu2Addr      ,
    input         wire   [`DataBus]                      BruAlu2Date      ,
    input         wire                                   BruMulAble       ,
    input         wire   [`ReNameRegBUs]                 BruMulAddr       ,
    input         wire   [`DataBus]                      BruMulDate       , 
    input         wire                                   BruCsrAble       ,
    input         wire   [`ReNameRegBUs]                 BruCsrAddr       ,
    input         wire   [`DataBus]                      BruCsrDate       ,                                   
    //to physical
    output        wire                                   BWriteBackAble   ,
    output        wire   [`ReNameRegBUs]                 BWriteBackAddr   ,
    output        wire   [`DataBus]                      BWriteBackDate   ,
    //to isse req
    output        wire                                   BruReqInst       ,
    //to ROB
    output        wire                                   BruCommitAble    ,
    output        wire   [5:0]                           BruCommitPtr     ,
    output        wire                                   BruReDirAble     ,
    output        wire   [`InstAddrBus]                  BruReDirPc          
);

    assign BruReqInst = ~BruStop ;

    wire signed [`DataBus] Src1Date  =  ((BruSrc1Addr == BruSelfADdr) & BruSelfAble & BruSrc1Able) ? BruSelfDate :
                                        ((BruSrc1Addr == BruALu1Addr) & BruAlu1Able & BruSrc1Able) ? BruAlu1Date :
                                        ((BruSrc1Addr == BruALu2Addr) & BruAlu2Able & BruSrc1Able) ? BruAlu2Date :
                                        ((BruSrc1Addr == BruMulAddr ) & BruMulAble  & BruSrc1Able) ? BruMulDate  :
                                        ((BruSrc1Addr == BruCsrAddr ) & BruCsrAble  & BruSrc1Able) ? BruCsrDate  : BruSrc1Date ;
    
    wire signed [`DataBus] Src2Date  =  ((BruSrc2Addr == BruSelfADdr) & BruSelfAble & BruSrc2Able) ? BruSelfDate :
                                        ((BruSrc2Addr == BruALu1Addr) & BruAlu1Able & BruSrc2Able) ? BruAlu1Date :
                                        ((BruSrc2Addr == BruALu2Addr) & BruAlu2Able & BruSrc2Able) ? BruAlu2Date :
                                        ((BruSrc2Addr == BruMulAddr ) & BruMulAble  & BruSrc2Able) ? BruMulDate  :
                                        ((BruSrc2Addr == BruCsrAddr ) & BruCsrAble  & BruSrc2Able) ? BruCsrDate  : BruSrc2Date ;

    // localparam REDIRNO     = 2'b00;
    // localparam REDIRNOJUMP = 2'b01;
    // localparam REDIRJUMP   = 2'b10;
    // localparam REDIRJUMPOA = 2'b11; //jump other address

    reg                 RegBWriteBackAble ;
    reg [`ReNameRegBUs] RegBWriteBackAddr ;
    reg [`DataBus]      RegBWriteBackDate ;

    reg                 RegBruCommitAble  ;
    reg [5:0]           RegBruCommitPtr   ;
    reg                 RegBruReDirType   ;
    reg [`InstAddrBus]  RegBruReDirPc     ;

    always @(posedge Clk) begin
        if(!Rest) begin
           RegBWriteBackAble <= `EnableValue ;
           RegBWriteBackAddr <= 7'b0         ;
           RegBWriteBackDate <= 32'd0        ;
           RegBruCommitAble  <= `EnableValue ;
           RegBruCommitPtr   <= 6'b0         ;
           RegBruReDirType   <= `EnableValue      ;
           RegBruReDirPc     <= 32'b0        ;
        end
        else if(BruFlash) begin
           RegBWriteBackAble <= `EnableValue ;
           RegBWriteBackAddr <= 7'b0         ;
           RegBWriteBackDate <= 32'd0        ;
           RegBruCommitAble  <= `EnableValue ;
           RegBruCommitPtr   <= 6'b0         ;
           RegBruReDirType   <= `EnableValue      ;
           RegBruReDirPc     <= 32'b0        ; 
        end
        else begin
            RegBWriteBackAble <= BruRdAble  ;
            RegBWriteBackAddr <= BruRdAddr  ;
            RegBruCommitPtr   <= BruROBPtr  ;
            case (BruMicOperate)
                `InstBeq : begin
                    if(Src1Date == Src2Date) begin 
                        RegBWriteBackDate <= 32'd0        ; 
                        RegBruCommitAble  <= `AbleValue   ; 
                        RegBruReDirType   <=  BruMode ? `EnableValue : `AbleValue ;
                        RegBruReDirPc     <=  BruInstPc + {{4{BruImmDate[25]}}, BruImmDate,2'b0} ;
                    end 
                    else begin
                        RegBWriteBackDate <= 32'd0        ; 
                        RegBruCommitAble  <= `AbleValue   ; 
                        RegBruReDirType   <=  ~BruMode ? `EnableValue : `AbleValue ;
                        RegBruReDirPc     <=  BruInstPc + 32'd4 ;
                    end 
                end
                `InstBne : begin
                    if(Src1Date != Src2Date) begin 
                        RegBWriteBackDate <= 32'd0        ; 
                        RegBruCommitAble  <= `AbleValue   ; 
                        RegBruReDirType   <=  BruMode ? `EnableValue : `AbleValue ;
                        RegBruReDirPc     <=  BruInstPc + {{4{BruImmDate[25]}}, BruImmDate,2'b0} ;
                    end 
                    else begin 
                        RegBWriteBackDate <= 32'd0        ; 
                        RegBruCommitAble  <= `AbleValue   ; 
                        RegBruReDirType   <=  ~BruMode ? `EnableValue : `AbleValue ;
                        RegBruReDirPc     <=  BruInstPc + 32'd4 ;
                    end 
                end
                `InstBlt : begin
                    if(Src1Date < Src2Date) begin 
                        RegBWriteBackDate <= 32'd0        ; 
                        RegBruCommitAble  <= `AbleValue   ; 
                        RegBruReDirType   <=  BruMode ? `EnableValue : `AbleValue ;
                        RegBruReDirPc     <=  BruInstPc + {{4{BruImmDate[25]}}, BruImmDate,2'b0} ;
                    end 
                    else begin  
                        RegBWriteBackDate <= 32'd0        ; 
                        RegBruCommitAble  <= `AbleValue   ; 
                        RegBruReDirType   <=  ~BruMode ? `EnableValue : `AbleValue ;
                        RegBruReDirPc     <=  BruInstPc + 32'd4 ;
                    end 
                end
                `InstBge : begin
                    if(Src1Date >= Src2Date) begin  
                        RegBWriteBackDate <= 32'd0        ; 
                        RegBruCommitAble  <= `AbleValue   ; 
                        RegBruReDirType   <=  BruMode ? `EnableValue : `AbleValue ;
                        RegBruReDirPc     <=  BruInstPc + {{4{BruImmDate[25]}}, BruImmDate,2'b0} ;
                    end 
                    else begin 
                        RegBWriteBackDate <= 32'd0        ; 
                        RegBruCommitAble  <= `AbleValue   ; 
                        RegBruReDirType   <=  ~BruMode ? `EnableValue : `AbleValue ;
                        RegBruReDirPc     <=  BruInstPc + 32'd4 ;
                    end 
                end
                `InstBltu : begin
                    if($unsigned(Src1Date) < $unsigned(Src2Date)) begin 
                        RegBWriteBackDate <= 32'd0        ; 
                        RegBruCommitAble  <= `AbleValue   ; 
                        RegBruReDirType   <=  BruMode ? `EnableValue : `AbleValue ;
                        RegBruReDirPc     <=  BruInstPc + {{4{BruImmDate[25]}}, BruImmDate,2'b0} ;
                    end 
                    else begin 
                        RegBWriteBackDate <= 32'd0        ; 
                        RegBruCommitAble  <= `AbleValue   ; 
                        RegBruReDirType   <=  ~BruMode ? `EnableValue : `AbleValue ;
                        RegBruReDirPc     <=  BruInstPc + 32'd4 ;
                    end 
                end
                `InstBgeu : begin
                    if($unsigned(Src1Date) >= $unsigned(Src2Date)) begin 
                        RegBWriteBackDate <= 32'd0        ; 
                        RegBruCommitAble  <= `AbleValue   ; 
                        RegBruReDirType   <=  BruMode ? `EnableValue : `AbleValue ;
                        RegBruReDirPc     <=  BruInstPc + {{4{BruImmDate[25]}}, BruImmDate,2'b0} ;
                    end 
                    else begin 
                        RegBWriteBackDate <= 32'd0        ; 
                        RegBruCommitAble  <= `AbleValue   ; 
                        RegBruReDirType   <=  ~BruMode ? `EnableValue : `AbleValue ;
                        RegBruReDirPc     <=  BruInstPc + 32'd4 ;
                    end 
                end
                `InstB : begin
                        RegBWriteBackDate <= 32'd0        ; 
                        RegBruCommitAble  <= `AbleValue   ; 
                        RegBruReDirType   <= `EnableValue     ;
                        RegBruReDirPc     <=  BruInstPc + {{4{BruImmDate[25]}}, BruImmDate,2'b0} ; ;
                end
                `InstBl : begin
                        RegBWriteBackDate <=  BruInstPc + 32'd4 ; 
                        RegBruCommitAble  <= `AbleValue   ; 
                        RegBruReDirType   <= `EnableValue     ;
                        RegBruReDirPc     <=  BruInstPc + {{4{BruImmDate[25]}}, BruImmDate,2'b0} ; ;
                end
                 `InstJirl : begin
                    if((Src2Date + {{4{BruImmDate[25]}}, BruImmDate,2'b0}) == BruReDirDate) begin
                        RegBWriteBackDate <= BruInstPc + 32'd4 ; 
                        RegBruCommitAble  <= `AbleValue   ; 
                        RegBruReDirType   <= `EnableValue     ;
                        RegBruReDirPc     <=  Src2Date + {{4{BruImmDate[25]}}, BruImmDate,2'b0} ;
                    end 
                    else begin
                        RegBWriteBackDate <= BruInstPc + 32'd4 ; 
                        RegBruCommitAble  <= `AbleValue   ; 
                        RegBruReDirType   <=  `AbleValue  ;
                        RegBruReDirPc     <=  Src2Date + {{4{BruImmDate[25]}}, BruImmDate,2'b0} ;
                    end
                 end
                default: begin
                    RegBWriteBackAddr <= 7'b0         ;
                    RegBWriteBackDate <= 32'd0        ;
                    RegBruCommitAble  <= `EnableValue ;
                    RegBruCommitPtr   <= 6'b0         ;
                    RegBruReDirType   <= `EnableValue ;
                    RegBruReDirPc     <= 32'b0        ; 
                end
            endcase
        end
    end
 
    assign BWriteBackAble =  RegBWriteBackAble  ;
    assign BWriteBackAddr =  RegBWriteBackAddr  ;
    assign BWriteBackDate =  RegBWriteBackDate  ;
    assign BruCommitAble  =  RegBruCommitAble   ;
    assign BruCommitPtr   =  RegBruCommitPtr    ;
    assign BruReDirAble   =  RegBruReDirType    ;
    assign BruReDirPc     =  RegBruReDirPc      ;
 
    
endmodule
`timescale 1ps/1ps
`include "../define.v"

module Csr (
    input        wire                                     Clk             ,
    input        wire                                     Rest            ,

    //interrupt from ROB
    input        wire                                     Interrupt       , //此处中断包括所有例外包括entry返回
    input        wire      [`InstAddrBus]                 InterruptPc     ,
    input        wire      [`InstAddrBus]                 InterruptAddr   , //例如一条访存指令发生重填，pc就是这条指令地址addr就是他访存的虚地址
    input        wire      [6:0]                          InterruptType   ,   
    input        wire                                     TrapEntry       ,
    //from soc
    input        wire      [7:0]                          SocInterrupt    ,
    //to ROB                                
    output       wire                                     EndowInterrupt  ,
    output       wire      [6:0]                          EndowCode       ,
    output       wire                                     LlbetlKlo       ,
    output       wire      [25:0]                         CsrTlbEntryDate ,
    output       wire      [25:0]                         CsrEntryDate    ,
    //to mmu   
    output       wire      [9:0]                          CsrAsidDate     ,
    output       wire      [`DataBus]                     CsrDmw0Date     ,
    output       wire      [`DataBus]                     CsrDmw1Date     ,
    //write csr
    input        wire                                     WEn             ,
    input        wire      [13:0]                         WAddr           ,
    input        wire      [`DataBus]                     WDate           ,  
    //read csr 
    input        wire                                     REn             ,
    input        wire      [13:0]                         RAddr           ,
    output       wire      [`DataBus]                     RDate           ,
    //direct write
    input        wire                                     InTlbIndexWAble ,
    input        wire      [`DataBus]                     InTlbIndexWMask ,
    input        wire      [`DataBus]                     InTlbIndexWDate ,
    input        wire                                     InTlbEhiWAble   ,
    input        wire      [`DataBus]                     InTlbEhiWDate   ,
    input        wire                                     InTlbElo0WAble  ,
    input        wire      [`DataBus]                     InTlbElo0WDate  ,
    input        wire                                     InTlbElo1WAble  ,
    input        wire      [`DataBus]                     InTlbElo1WDate  ,
    input        wire                                     InCrmdWAble     ,
    input        wire      [`DataBus]                     InCrmdWMask     ,
    input        wire      [`DataBus]                     InCrmdWDate     ,
    input        wire                                     InLlCtrlAble    ,
    //csr date to csru 
    output       wire      [2:0]                          OutCrmdData     ,
    output       wire      [2:0]                          OutPrmdDate     ,
    output       wire      [`DataBus]                     OutEraDate      ,
    output       wire      [9:0]                          OutAsidDate     ,
    output       wire      [18:0]                         OutTlbEhiDate   ,
    output       wire      [5:0]                          OutTlbIndex     ,
    output       wire      [5:0]                          OutTlbPs        ,
    output       wire      [`DataBus]                     OutTlbElo0      ,
    output       wire      [`DataBus]                     OutTlbElo1      ,
    output       wire      [5:0]                          OutTlbEcode     ,
    output       wire                                     OutTlbNe        ,
    output       wire                                     OutLlbCtlDate 
);

    localparam CRMD  = 14'h0;
    localparam PRMD  = 14'h1;
    localparam ECFG  = 14'h4;
    localparam ESTAT = 14'h5;
    localparam ERA   = 14'h6;
    localparam BADV  = 14'h7;
    localparam EENTRY = 14'hc;
    localparam TLBIDX= 14'h10;
    localparam TLBEHI= 14'h11;
    localparam TLBELO0=14'h12;
    localparam TLBELO1=14'h13;
    localparam ASID  = 14'h18;
    localparam PGDL  = 14'h19;
    localparam PGDH  = 14'h1a;
    localparam PGD   = 14'h1b;
    localparam CPUID = 14'h20;
    localparam SAVE0 = 14'h30;
    localparam SAVE1 = 14'h31;
    localparam SAVE2 = 14'h32;
    localparam SAVE3 = 14'h33;
    localparam TID   = 14'h40;
    localparam TCFG  = 14'h41;
    localparam TVAL  = 14'h42;
    //localparam CNTC  = 14'h43;
    localparam TICLR = 14'h44;
    localparam LLBCTL= 14'h60;
    localparam TLBRENTRY = 14'h88;
    localparam DMW0  = 14'h180;
    localparam DMW1  = 14'h181;
    // localparam BRK = 14'h100;
    // localparam DISABLE_CACHE = 14'h101;

    wire WriteCrmdEna      = ((WAddr == CRMD)      && (WEn)) ;
    wire WritePrmdEna      = ((WAddr == PRMD)      && (WEn)) ;
    wire WriteEcfgEna      = ((WAddr == ECFG)      && (WEn)) ;
    wire WriteEstatEna     = ((WAddr == ESTAT)     && (WEn)) ;
    wire WriteEraEna       = ((WAddr == ERA)       && (WEn)) ;
    wire WriteBadvEna      = ((WAddr == BADV)      && (WEn)) ;
    wire WriteEentryEna    = ((WAddr == EENTRY)    && (WEn)) ;
    wire WriteTlbidxEna    = ((WAddr == TLBIDX)    && (WEn)) ;
    wire WriteTlbehiENa    = ((WAddr == TLBEHI)    && (WEn)) ;
    wire WriteTlbelo0Ena   = ((WAddr == TLBELO0)   && (WEn)) ;
    wire WriteTlbelo1Ena   = ((WAddr == TLBELO1)   && (WEn)) ;
    wire WriteAsidEna      = ((WAddr == ASID)      && (WEn)) ;
    wire WritePgdlEna      = ((WAddr == PGDL)      && (WEn)) ;
    wire WritePgdhEna      = ((WAddr == PGDH)      && (WEn)) ;
    //wire WritePgdEna       = ((WAddr == PGD)       && (WEn)) ;
    wire WriteCpuidEna     = ((WAddr == CPUID)     && (WEn)) ;
    wire WriteSave0Ena     = ((WAddr == SAVE0)     && (WEn)) ;
    wire WriteSave1Ena     = ((WAddr == SAVE1)     && (WEn)) ;
    wire WriteSave2Ena     = ((WAddr == SAVE2)     && (WEn)) ;
    wire WriteSave3Ena     = ((WAddr == SAVE3)     && (WEn)) ;
    wire WriteTidEna       = ((WAddr == TID)       && (WEn)) ;
    wire WriteTcfgEna      = ((WAddr == TCFG)      && (WEn)) ;
    wire WriteTvalEna      = ((WAddr == TVAL)      && (WEn)) ;
    //wire WriteCntcEna      = ((WAddr == CNTC)      && (WEn)) ;
    wire WriteTiclrEna     = ((WAddr == TICLR)     && (WEn)) ;
    wire WriteLlbctlEna    = ((WAddr == LLBCTL)    && (WEn)) ;
    wire WriteTlbrentryEna = ((WAddr == TLBRENTRY) && (WEn)) ;
    wire WriteDmw0Ena      = ((WAddr == DMW0)      && (WEn)) ;
    wire WriteDmw1ENa      = ((WAddr == DMW1)      && (WEn)) ;
    // wire WriteBpkEna       = ((WAddr == BRK)       && (WEn)) ; 
    // wire WriteTlbelo0Ena   = ((WAddr == DISABLE_CACHE)&& (WEn)) ; 

    reg [`DataBus] CsrCrmd ;
    reg [`DataBus] CsrPrmd ;
    reg [`DataBus] CsrEcfg ;
    reg [`DataBus] CsrEstat;
    reg [`DataBus] CsrEra  ;
    reg [`DataBus] CsrBadv ;
    reg [`DataBus] CsrEentry;
    reg [`DataBus] CsrTlbidx;
    reg [`DataBus] CsrTlbehi;
    reg [`DataBus] CsrTlbelo0;
    reg [`DataBus] CsrTlbelo1;
    reg [`DataBus] CsrAsid ;
    reg [`DataBus] CsrPgdl ;
    reg [`DataBus] CsrPgdh ;
    //reg [`DataBus] CsrPgd  ;
    reg [`DataBus] CsrCpuid;
    reg [`DataBus] CsrSave0;
    reg [`DataBus] CsrSave1;
    reg [`DataBus] CsrSave2;
    reg [`DataBus] CsrSave3;
    reg [`DataBus] CsrTid  ;
    reg [`DataBus] CsrTcfg ;
    reg [`DataBus] CsrTval ;
    //reg [`DataBus] CsrCntc ;
    reg [`DataBus] CsrTiclr;
    reg [`DataBus] CsrLlbctl;
    reg [`DataBus] CsrTlbrentry;
    reg [`DataBus] CsrDmw0 ;
    reg [`DataBus] CsrDmw1 ;


    always @(posedge Clk) begin
        if(!Rest) begin
            CsrCrmd[`PLV]  <= 2'd0 ;
            CsrCrmd[`IE]   <= 1'b0 ;
            CsrCrmd[`DA]   <= 1'b1 ;
            CsrCrmd[`PG]   <= 1'b0 ;
            CsrCrmd[`DATF] <= 2'b0 ;
            CsrCrmd[`DATM] <= 2'd0 ;
            CsrCrmd[`SAVE] <= 23'd0 ;  
        end
        else if(Interrupt)begin
            CsrCrmd[`PLV]  <= TrapEntry ? CsrPrmd[`PPLV] : 0 ;
            CsrCrmd[`IE]   <= TrapEntry ? CsrPrmd[`PIE]  : 0 ;
            CsrCrmd[`DA]   <= (InterruptType == `TLBR)                    ? 1'b1 : 
                              (TrapEntry && (CsrEstat[`ECODE] == 6'h3f))  ? 1'b0 : CsrCrmd[`DA] ;
            CsrCrmd[`PG]   <= (InterruptType == `TLBR)                    ? 1'b0 : 
                              (TrapEntry && (CsrEstat[`ECODE] == 6'h3f))  ? 1'b1 : CsrCrmd[`PG] ;
            CsrCrmd[`DATF] <= CsrCrmd[`DATF] ;
            CsrCrmd[`DATM] <= CsrCrmd[`DATM] ;
            CsrCrmd[`SAVE] <= CsrCrmd[`SAVE] ;
        end
        else if(WriteCrmdEna) begin
            CsrCrmd[`PLV]  <= WDate[`PLV] ;
            CsrCrmd[`IE]   <= WDate[`IE]  ;
            CsrCrmd[`DA]   <= WDate[`DA]  ;
            CsrCrmd[`PG]   <= WDate[`PG]  ;
            CsrCrmd[`DATF] <= WDate[`DATF];
            CsrCrmd[`DATM] <= WDate[`DATM];
            CsrCrmd[`SAVE] <= WDate[`SAVE];
        end
        else if(InCrmdWAble) begin
            CsrCrmd <= (InCrmdWMask & InCrmdWDate) | (~InCrmdWMask & CsrCrmd) ;
        end
    end 

    always @(posedge Clk) begin
        if(!Rest) begin
            CsrPrmd[`PPLV] <= 2'b0 ;
            CsrPrmd[`PIE]  <= 1'b0 ;
            CsrPrmd[31:3]  <= 29'b0;
        end
        else if(Interrupt && ~TrapEntry)begin
            CsrPrmd[`PPLV] <= CsrCrmd[`PLV] ;
            CsrPrmd[`PIE]  <= CsrCrmd[`IE]  ;
            CsrPrmd[31:3]  <= CsrPrmd[31:3] ;
        end
        else if(WritePrmdEna) begin
            CsrPrmd[`PPLV] <= WDate[`PLV] ;
            CsrPrmd[`PIE]  <= WDate[`IE]  ;
            CsrPrmd[31:3]  <= WDate[31:3] ;
        end
    end


    always @(posedge Clk) begin
        if(!Rest)begin
            CsrEcfg <= `ZeorDate ;
        end
        else if(WriteEcfgEna)begin
            CsrEcfg <= WDate ;
        end
    end

    always @(posedge Clk) begin
        if(!Rest) begin
            CsrEstat[`IS1_0] <= 2'b0 ;
            CsrEstat[`IS9_2] <= 8'b0 ;
            CsrEstat[10]     <= 1'b0 ;
            CsrEstat[`IS11]  <= 1'b0 ;
            CsrEstat[`IS12]  <= 1'b0 ;
            CsrEstat[`ECODE] <= 6'b0 ;
            CsrEstat[`ESUBCODE] <= 9'd0 ;
            CsrEstat[31]     <= 1'b0 ;
            CsrEstat[15:13]  <= 3'd0 ;
        end
        else begin
            CsrEstat[`IS9_2] <= SocInterrupt ;
            if(WriteEstatEna)begin
                CsrEstat[`IS1_0] <= WDate[`IS1_0];
            end
            if((WriteTiclrEna) && (WDate[`CLR] == 1))
                CsrEstat[`IS11] <= 1'b0 ;
            if((CsrTcfg[`EN] == 1) && (CsrTval == 0))
                CsrEstat[`IS11] <= 1'b1 ;
            if(Interrupt && ~TrapEntry)begin
                CsrEstat[`ECODE] <= InterruptType[5:0] ;
                CsrEstat[`ESUBCODE] <= {8'd0, InterruptType[6]} ;
            end
        end
    end
    

    always @(posedge Clk) begin
        if(!Rest) begin
            CsrEra <= `ZeorDate ;
        end
        else begin
            if(Interrupt && ~TrapEntry)
                CsrEra <= InterruptPc ;
            if(WriteEraEna)
                CsrEra <= WDate ;   
        end
    end

    always @(posedge Clk) begin
        if(!Rest) begin
            CsrBadv <= `ZeorDate ;
        end
        else begin
            if(WriteBadvEna)
                CsrBadv <= WDate ;
            if(InterruptType == `ADEF)
                CsrBadv <= InterruptPc ;
            if((InterruptType == `TLBR)|| 
              (InterruptType == `ALE)  ||
              (InterruptType == `PIL)  ||
              (InterruptType == `PIS)  ||
              (InterruptType == `PME)  ||
              (InterruptType == `PPI   )) 
                CsrBadv <= InterruptAddr;
        end 
    end

    always @(posedge Clk) begin
        if(!Rest) 
            CsrEentry <= `ZeorDate ;
        else if(WriteEentryEna)
            CsrEentry <= WDate ;
    end

    assign CsrEntryDate = CsrEentry[31:6] ;

    always @(posedge Clk) begin
        if(!Rest)
            CsrCpuid <= `ZeorDate ;
        else if(WriteCpuidEna)
            CsrCpuid <= WDate ;
    end

    always @(posedge Clk) begin
        if(!Rest)
            CsrSave0 <= `ZeorDate ;
        else if(WriteSave0Ena)
            CsrSave0 <= WDate ;
    end

    always @(posedge Clk) begin
        if(!Rest)
            CsrSave1 <= `ZeorDate ;
        else if(WriteSave1Ena)
            CsrSave1 <= WDate ;
    end

    always @(posedge Clk) begin
        if(!Rest)
            CsrSave2 <= `ZeorDate ;
        else if(WriteSave2Ena)
            CsrSave2 <= WDate ;
    end

    always @(posedge Clk) begin
        if(!Rest)
            CsrSave3 <= `ZeorDate ;
        else if(WriteSave3Ena)
            CsrSave3 <= WDate ;
    end

    // TODO TODO TODO TODO 原子操作
    always @(posedge Clk) begin
        if(!Rest) begin
            CsrLlbctl[`ROLLB] <= 1'b0  ;
            CsrLlbctl[`WCLLB] <= 1'b0  ;
            CsrLlbctl[`KLO]   <= 1'b0  ;
            CsrLlbctl[31:3]   <= 29'b0 ;
        end 
        else begin
            if(WriteLlbctlEna)
                CsrLlbctl <= WDate ;
            if((WriteLlbctlEna) && (WDate[1] ==1))
                CsrLlbctl <= `ZeorDate ;
            if(InLlCtrlAble)
                CsrLlbctl[2] <= 1'b0 ;
        end
    end

    assign LlbetlKlo = CsrLlbctl[`KLO]  ; 

    always @(posedge Clk) begin
        if(!Rest) begin
            CsrTlbidx[`INDEX] <= 6'd0 ;
            CsrTlbidx[15:6]   <= 10'd0;
            CsrTlbidx[23:16]  <= 8'd0 ;
            CsrTlbidx[`PS]    <= 6'd0 ;
            CsrTlbidx[30]     <= 1'b0 ;
            CsrTlbidx[`NE]    <= 1'b0 ; 
        end
        else begin
            if(WriteTlbidxEna) begin
                CsrTlbidx[`INDEX] <= WDate[`INDEX];
                CsrTlbidx[15:6]   <= WDate[15:6]  ;
                CsrTlbidx[23:16]  <= WDate[23:16] ;
                CsrTlbidx[`PS]    <= WDate[`PS]   ;
                CsrTlbidx[30]     <= WDate[30]    ;
                CsrTlbidx[`NE]    <= WDate[`NE]   ;
            end 
            if(InTlbIndexWAble) 
                CsrTlbidx <= (InTlbIndexWMask &  InTlbIndexWDate) | (~InTlbIndexWMask & CsrTlbidx) ;
        end
    end

    always @(posedge Clk) begin
        if(!Rest) 
            CsrTlbehi <= `ZeorDate ;
        else begin
            if(WriteTlbehiENa) 
                CsrTlbehi <= WDate ;
            if(InTlbEhiWAble)
                CsrTlbehi <= InTlbEhiWDate;
            if((InterruptType == `TLBR) || 
              (InterruptType == `PIL)   ||
              (InterruptType == `PIS)   ||
              (InterruptType == `PIF)   || 
              (InterruptType == `PME)   || 
              (InterruptType == `PPI    ))
                CsrTlbehi <= {InterruptAddr[31:13], 13'd0};
        end
    end

    always @(posedge Clk) begin
        if(!Rest) 
            CsrTlbelo0 <= `ZeorDate ;
        else begin
            if(WriteTlbelo0Ena)
                CsrTlbelo0 <= WDate ;
            if(InTlbElo0WAble)
                CsrTlbelo0 <= InTlbElo0WDate ;
        end
    end

    always @(posedge Clk) begin
        if(!Rest) 
            CsrTlbelo1 <= `ZeorDate ;
        else begin
            if(WriteTlbelo1Ena)
                CsrTlbelo1 <= WDate ;
            if(InTlbElo1WAble)
                CsrTlbelo1 <= InTlbElo1WDate ;
        end
    end

    always @(posedge Clk) begin
        if(!Rest)
            CsrAsid <= `ZeorDate ;
        else begin
            if(WriteAsidEna) 
                CsrAsid <= WDate ;
        end
    end

    always @(posedge Clk) begin
        if(!Rest) 
            CsrPgdl <= `ZeorDate ;
        else if(WritePgdlEna)
            CsrPgdl <= {WDate[31:12],12'd0};
    end

    always @(posedge Clk) begin
        if(!Rest)
            CsrPgdh <= `ZeorDate ;
        else if(WritePgdhEna)
            CsrPgdh <= {WDate[31:12], 12'd0};
    end

    always @(posedge Clk) begin
        if(!Rest)
            CsrTlbrentry <= `ZeorDate ;
        else if(WriteTlbrentryEna)
            CsrTlbrentry <= {WDate[31:6],6'd0} ;
    end

    assign CsrTlbEntryDate = CsrTlbrentry[31:6] ;
        
    always @(posedge Clk) begin
        if(!Rest) 
            CsrDmw0 <= `ZeorDate ;
        else if(WriteDmw0Ena)
            CsrDmw0 <= WDate ;
    end

    always @(posedge Clk) begin
        if(!Rest) 
            CsrDmw1 <= `ZeorDate ;
        else if(WriteDmw1ENa)
            CsrDmw1 <= WDate ;
    end


    always @(posedge Clk) begin
        if(!Rest)
            CsrTid <= `ZeorDate ;
        else if(WriteTidEna) 
            CsrTid <= WDate ;
    end

    always @(posedge Clk) begin
        if(!Rest) begin
            CsrTcfg[`EN] <= 1'b0 ;
            CsrTcfg[`PERIODIC] <= 1'b0 ;
            CsrTcfg[`INITVAL]  <= 30'b0;
        end 
        else if(WriteTcfgEna) begin
            CsrTcfg[`EN] <= WDate[`EN] ;
            CsrTcfg[`PERIODIC] <= WDate[`PERIODIC] ;
            CsrTcfg[`INITVAL]  <= WDate[`INITVAL]  ;
        end
    end

    always @(posedge Clk) begin
        if(!Rest)
            CsrTval <= `ZeorDate ;
        else begin
            if(WriteTvalEna)
                CsrTval <= WDate ;
            if(CsrTval != 0)
                CsrTval <= CsrTval - 32'b1 ;
            if(CsrTval == 0)
                CsrTval <= CsrTcfg[`PERIODIC] ? {CsrTcfg[ `INITVAL],2'b0} : 32'hffffffff ;
        end
    end

    always @(posedge Clk) begin
        if(!Rest)
            CsrTiclr <= `ZeorDate ;
        else 
            CsrTiclr <= `ZeorDate ;
    end

    wire ReadCrmdEna      = ((RAddr == CRMD)     && REn);
    wire ReadPrmdEna      = ((RAddr == PRMD)     && REn);
    wire ReadEcfgEna      = ((RAddr == ECFG)     && REn);
    wire ReadEstatEna     = ((RAddr == ESTAT)    && REn);
    wire ReadEraEna       = ((RAddr == ERA)      && REn);
    wire ReadBadvEna      = ((RAddr == BADV)     && REn);
    wire ReadEentryEna    = ((RAddr == EENTRY)   && REn);
    wire ReadTlbidxEna    = ((RAddr == TLBIDX)   && REn);
    wire ReadTlbehiEna    = ((RAddr == TLBEHI)   && REn);
    wire ReadTlbelo0Ena   = ((RAddr == TLBELO0)  && REn);
    wire ReadTlbelo1Ena   = ((RAddr == TLBELO1)  && REn);
    wire ReadAsidEna      = ((RAddr == ASID)     && REn);
    wire ReadPgdlEna      = ((RAddr == PGDL)     && REn);
    wire ReadPgdhEna      = ((RAddr == PGDH)     && REn);
    wire ReadPgdEna       = ((RAddr == PGD)      && REn);
    wire ReadCpuidEna     = ((RAddr == CPUID)    && REn);
    wire ReadSave0Ena     = ((RAddr == SAVE0)    && REn);
    wire ReadSave1Ena     = ((RAddr == SAVE1)    && REn);
    wire ReadSave2Ena     = ((RAddr == SAVE2)    && REn);
    wire ReadSave3Ena     = ((RAddr == SAVE3)    && REn);
    wire ReadTidEna       = ((RAddr == TID)      && REn);
    wire ReadTcfgEna      = ((RAddr == TCFG)     && REn);
    wire ReadTvalEna      = ((RAddr == TVAL)     && REn);
    //wire ReadCntcEna      = ((RAddr == CNTC)     && REn);
    wire ReadTiclrEna     = ((RAddr == TICLR)    && REn);
    wire ReadLlbctlEna    = ((RAddr == LLBCTL)   && REn);
    wire ReadTlbrentryEna = ((RAddr == TLBRENTRY)&& REn);
    wire ReadDmw0Ena      = ((RAddr == DMW0)     && REn);
    wire ReadDmw1Ena      = ((RAddr == DMW1)     && REn);

    assign RDate = {32{ReadCrmdEna}}      & CsrCrmd      |
                   {32{ReadPrmdEna}}      & CsrPrmd      |
                   {32{ReadEcfgEna}}      & CsrEcfg      |
                   {32{ReadEstatEna}}     & CsrEstat     |
                   {32{ReadEraEna}}       & CsrEra       |
                   {32{ReadBadvEna}}      & CsrBadv      |
                   {32{ReadEentryEna}}    & CsrEentry    |
                   {32{ReadTlbidxEna}}    & CsrTlbidx    |
                   {32{ReadTlbehiEna}}    & CsrTlbehi    |
                   {32{ReadTlbelo0Ena}}   & CsrTlbelo0   |
                   {32{ReadTlbelo1Ena}}   & CsrTlbelo1   |
                   {32{ReadAsidEna}}      & CsrAsid      |
                   {32{ReadPgdlEna}}      & CsrPgdl      |
                   {32{ReadPgdhEna}}      & CsrPgdh      |
                   {32{ReadPgdEna}}       & (({32{CsrBadv[31]}} & CsrPgdh) | (~{32{CsrBadv[31]}} & CsrPgdl)) |
                   {32{ReadCpuidEna}}     & CsrCpuid     |
                   {32{ReadSave0Ena}}     & CsrSave0     |
                   {32{ReadSave1Ena}}     & CsrSave1     |
                   {32{ReadSave2Ena}}     & CsrSave2     |
                   {32{ReadSave3Ena}}     & CsrSave3     |
                   {32{ReadTidEna}}       & CsrTid       |
                   {32{ReadTcfgEna}}      & CsrTcfg      |
                   {32{ReadTvalEna}}      & CsrTval      |
                   //{32{ReadCntcEna}}      & CsrCntc      |
                   {32{ReadTiclrEna}}     & CsrTiclr     |
                   {32{ReadLlbctlEna}}    & CsrLlbctl    |
                   {32{ReadTlbrentryEna}} & CsrTlbrentry |
                   {32{ReadDmw0Ena}}      & CsrDmw0      |
                   {32{ReadDmw1Ena}}      & CsrDmw1      ;
                   

    assign EndowInterrupt = ((({CsrEcfg[12:11], CsrEcfg[9:0]} & {CsrEstat[`IS12], CsrEstat[`IS11], CsrEstat[`IS9_2], CsrEstat[`IS1_0]}) != 0) && CsrCrmd[`IE]) ;
    assign EndowCode      = `INT ;

    assign CsrAsidDate = CsrAsid[9:0] ;
    assign CsrDmw0Date = CsrDmw0 ;
    assign CsrDmw1Date = CsrDmw1 ;

    assign OutCrmdData  = CsrCrmd[2:0] ;
    assign OutPrmdDate  = CsrPrmd[2:0] ;
    assign OutEraDate   = CsrEra       ;
    assign OutAsidDate  = CsrAsid[9:0] ;
    assign OutTlbEhiDate= CsrTlbehi[31:13];
    assign OutTlbIndex  = CsrTlbidx[5:0] ;
    assign OutTlbPs     = CsrTlbidx[29:24];
    assign OutTlbElo0   = CsrTlbelo0     ;
    assign OutTlbElo1   = CsrTlbelo1     ;
    assign OutTlbEcode  = CsrEstat[21:16];
    assign OutTlbNe     = CsrTlbidx[31]  ;
    assign OutLlbCtlDate= CsrLlbctl[3]   ;


endmodule
`timescale 1ps/1ps
`include "../define.v"

module Csru (
    input        wire                                     Clk            ,
    input        wire                                     Rest           ,

    input        wire                                     CsruStop       ,
    input        wire                                     CsruFlash      ,

    //input from RS order
    input        wire                                     InInstAble     ,
    input        wire      [`InstAddrBus]                 InstVritualPc  ,
    input        wire      [`MicOperateCode]              CsrMicOpCOde   ,
    input        wire                                     ArchRegAble0   ,
    input        wire      [`ReNameRegBUs]                ArchRegNum0    ,
    input        wire      [`DataBus]                     ArchRegDate0   ,
    input        wire                                     ArchRegAble1   ,
    input        wire      [`ReNameRegBUs]                ArchRegNum1    ,
    input        wire                                     ArchRdAble     ,
    input        wire      [`ReNameRegBUs]                ArchRdAddr     ,
    input        wire      [`DataBus]                     ArchRegDate1   ,
    input        wire      [13:0]                         CsrNum         ,
    input        wire      [5:0]                          InstRobPtr     ,
    //to  CsrBrIQ
    output       wire                                     CsrReq         ,
    //write physical regfile
    output       wire                                     WriteBackAble  ,
    output       wire      [`DataBus]                     WriteBackDate  ,
    output       wire      [`ReNameRegBUs]                WriteBackAddr  , 
    //to ROB
    output       wire                                     ToRobInterrupt  ,
    output       wire      [6:0]                          ToRobCode       ,
    output       wire      [`InstAddrBus]                 ToRobAddr       ,
    output       wire                                     ToRobReady      ,
    output       wire      [5:0]                          ToRobPtr        ,
    output       wire                                     ToRobIdle       ,      
    //from ROB
    input        wire                                     InstRetireAble  ,
    input        wire      [7:0]                          InstRetireCode  ,
    //csr
    input        wire      [2:0]                          CrmdData        ,
    input        wire      [2:0]                          PrmdDate        ,
    input        wire      [`DataBus]                     EraDate         ,
    input        wire      [9:0]                          AsidDate        ,
    input        wire      [18:0]                         TlbEhiDate      ,
    input        wire      [5:0]                          TlbIndex        ,
    input        wire      [5:0]                          TlbPs           ,
    input        wire      [`DataBus]                     TlbElo0         ,
    input        wire      [`DataBus]                     TlbElo1         ,
    input        wire      [5:0]                          TlbEcode        ,
    input        wire                                     TlbNe           ,
    input        wire                                     LlbCtlDate      ,
    //read Csr
    output       wire                                     ReadCsrAble     ,
    output       wire      [13:0]                         ReadCsrAddr     ,
    input        wire      [`DataBus]                     ReadCsrDate     ,
    //write Csr
    output       wire                                     WriteCsrAble    ,
    output       wire      [13:0]                         WriteCsrAddr    ,
    output       wire      [`DataBus]                     WriteCsrDate    ,
    //direct use csr
    output       wire                                     TlbIndexWAble   ,
    output       wire      [`DataBus]                     TlbIndexWMask   ,
    output       wire      [`DataBus]                     TlbIndexWDate   ,
    output       wire                                     TlbEhiWAble     ,
    output       wire      [`DataBus]                     TlbEhiWDate     ,
    output       wire                                     TlbElo0WAble    ,
    output       wire      [`DataBus]                     TlbElo0WDate    ,
    output       wire                                     TlbElo1WAble    ,
    output       wire      [`DataBus]                     TlbElo1WDate    ,
    output       wire                                     CrmdWAble       ,
    output       wire      [`DataBus]                     CrmdWMask       ,
    output       wire      [`DataBus]                     CrmdWDate       ,
    output       wire                                     LlCtrlAble      ,
    //read MMU
    output       wire                                     ReadMmuAble     ,
    output       wire      [5:0]                          ReadMmuAddr     ,
    input        wire                                     ReadSUccess     ,
    input        wire      [89-1:0]                       ReadMmuDate     ,
    //write MMU 
    output       wire                                     WriteMmuAble    ,
    output       wire      [5:0]                          WriteMmuAddr    ,
    output       wire      [89-1:0]                       WriteMmuDate    ,
    //serch MMU
    output       wire                                     SerchMmuAble    ,
    output       wire      [28:0]                         SerchMmuInfr    ,
    input        wire                                     SerchSuccess    ,
    input        wire      [5:0]                          SerchIndexDate  ,
    //invtlb Mmu
    output       wire                                     CsrInvEn        ,
    output       wire      [ 4:0]                         CsrInvOp        ,
    output       wire      [ 9:0]                         CsrInvAsid      ,
    output       wire      [18:0]                         CsrInvVppn      , 
    //bypass other eu
    input        wire                                     CsrSelfAble     ,
    input        wire      [`ReNameRegBUs]                CsrSelfAddr     ,
    input        wire      [`DataBus]                     CsrSelfDate     ,
    input        wire                                     CsrAlu1Able     ,
    input        wire      [`ReNameRegBUs]                CsrAlu1Addr     ,
    input        wire      [`DataBus]                     CsrAlu1Date     ,
    input        wire                                     CsrAlu2Able     ,
    input        wire      [`ReNameRegBUs]                CsrAlu2Addr     ,
    input        wire      [`DataBus]                     CsrAlu2Date     ,
    input        wire                                     CsrMulAble      ,
    input        wire      [`ReNameRegBUs]                CsrMulAddr      ,
    input        wire      [`DataBus]                     CsrMulDate      ,
    input        wire                                     CsrBruAble      ,
    input        wire      [`ReNameRegBUs]                CsrBruAddr      ,
    input        wire      [`DataBus]                     CsrBruDate     
);

    wire  [`DataBus] ASrc1Date   =  ((ArchRegNum0 == CsrSelfAddr) & CsrSelfAble & ArchRegAble0) ? CsrSelfDate :
                                    ((ArchRegNum0 == CsrBruAddr ) & CsrBruAble  & ArchRegAble0) ? CsrBruDate  :
                                    ((ArchRegNum0 == CsrAlu2Addr) & CsrAlu2Able & ArchRegAble0) ? CsrAlu2Date :
                                    ((ArchRegNum0 == CsrMulAddr ) & CsrMulAble  & ArchRegAble0) ? CsrMulDate  :
                                    ((ArchRegNum0 == CsrAlu1Addr) & CsrAlu1Able & ArchRegAble0) ? CsrAlu1Date : ArchRegDate0 ;
    
    wire  [`DataBus] ASrc2Date   =  ((ArchRegNum1 == CsrSelfAddr) & CsrSelfAble & ArchRegAble1) ? CsrSelfDate :
                                    ((ArchRegNum1 == CsrBruAddr ) & CsrBruAble  & ArchRegAble1) ? CsrBruDate  :
                                    ((ArchRegNum1 == CsrAlu2Addr) & CsrAlu2Able & ArchRegAble1) ? CsrAlu2Date :
                                    ((ArchRegNum1 == CsrMulAddr ) & CsrMulAble  & ArchRegAble1) ? CsrMulDate  :
                                    ((ArchRegNum1 == CsrAlu1Addr) & CsrAlu1Able & ArchRegAble1) ? CsrAlu1Date : ArchRegDate1 ;

    assign  CsrReq = (CSRUREGTEMP[92] == `AbleValue) | (InstRetireAble) ;

    reg   [100:0]  CSRUREGTEMP ;
    reg   [5:0]    CstToRobPtr ;
    reg            CsruTrapAble;
    reg   [6:0]    CsruTrapCode;
    reg   [`InstAddrBus] CsruTrapAddr ;
    reg            CsruIdle    ;

    always @(posedge Clk) begin
        if(!Rest) begin
            CSRUREGTEMP <= 101'd0       ;
            CsruTrapAble<= `EnableValue;
            CstToRobPtr <= 6'd0        ;
            CsruTrapCode<= 7'b0        ;
            CsruIdle    <= 1'b0        ;
            CsruTrapAddr<= 32'd0       ;
        end
        else if(CsruStop)begin
            CSRUREGTEMP <= CSRUREGTEMP  ;
            CsruTrapAble<= CsruTrapAble ;
            CstToRobPtr <= CstToRobPtr  ;
            CsruTrapCode<= CsruTrapCode ;
            CsruIdle    <= CsruIdle     ;
            CsruTrapAddr<= CsruTrapAddr ;
        end
        else if(CsruFlash) begin
            CSRUREGTEMP <= 101'd0       ;
            CsruTrapAble<= `EnableValue;
            CstToRobPtr <= 6'd0        ;
            CsruTrapCode<= 7'b0        ;
            CsruIdle    <= 1'b0        ;
            CsruTrapAddr<= 32'd0       ;
        end 
        else if(InInstAble) begin
            CSRUREGTEMP <= {ArchRdAble, ArchRdAddr, `AbleValue, CsrNum, InstRobPtr, CsrMicOpCOde, ASrc1Date, ASrc2Date} ;
            CstToRobPtr <= InstRobPtr   ;
            case (CsrMicOpCOde)
                `InstCsrrd, `InstCsrwr, `InstCsrxchg, `InstCacop, `InstTlbsrchr, `InstTlbsrchw, 
                `InstTlbrd, `InstTlbwr, `InstTlbfill,`InstInvtlb : begin     
                            CsruTrapAble <= (CrmdData[`PLV] == 2'd0 & CrmdData[`IE]) ? `AbleValue : `EnableValue; 
                            CsruTrapCode <= (CrmdData[`PLV] == 2'd3) ? 7'b0 : `PPI              ;   
                            CsruTrapAddr <= (CrmdData[`PLV] == 2'd3) ? `ZeorDate : InstVritualPc; 
                            CsruIdle     <= `EnableValue     ;
                        end 
                `InstEntry : begin
                            CsruTrapAble <= CrmdData[`IE] ? `AbleValue : `EnableValue           ;
                            CsruTrapCode <= (CrmdData[`PLV] == 2'd3) ? 7'b0 : `PPI              ;
                            CsruTrapAddr <= (CrmdData[`PLV] == 2'd3) ? EraDate : InstVritualPc  ;
                            CsruIdle     <= `EnableValue  ;
                        end 
                `InstIdle : begin
                            CsruTrapAble <= `AbleValue ; 
                            CsruTrapCode <= (CrmdData[`PLV] == 2'd3) ? 7'b0 : `PPI              ;   
                            CsruTrapAddr <= (CrmdData[`PLV] == 2'd3) ? `ZeorDate : InstVritualPc; 
                            CsruIdle     <= `AbleValue    ;
                        end 
                `InstSyscall : begin
                            CsruTrapAble <= CrmdData[`IE] ? `AbleValue : `EnableValue           ;
                            CsruTrapCode <= (CrmdData[`PLV] == 2'd3) ? `SYS : `PPI              ;   
                            CsruTrapAddr <= (CrmdData[`PLV] == 2'd3) ? EraDate : InstVritualPc  ; 
                            CsruIdle     <= `EnableValue  ;
                        end 
                `InstBreak
                        : begin
                            CsruTrapAble <= CrmdData[`IE] ? `AbleValue : `EnableValue           ;
                            CsruTrapCode <= (CrmdData[`PLV] == 2'd3) ? `BRK : `PPI              ;   
                            CsruTrapAddr <= (CrmdData[`PLV] == 2'd3) ? EraDate : InstVritualPc  ; 
                            CsruIdle     <= `EnableValue  ;
                        end         
                default: begin
                    CsruTrapAble <= `EnableValue           ;
                    CsruTrapCode <= 7'd0                   ;
                    CsruTrapAddr <= 32'd0                  ;
                    CsruIdle     <= `EnableValue           ;
                end
            endcase
        end
        else if(InstRetireAble &&  (InstRetireCode == CSRUREGTEMP[71:64])) begin
            CSRUREGTEMP <= 101'd0 ;
            CstToRobPtr <= 6'd0  ;
            CsruTrapAble <= `EnableValue           ;
            CsruTrapCode <= 7'd0                   ;
            CsruTrapAddr <= 32'd0                  ;
            CsruIdle     <= `EnableValue           ;
        end
    end

    assign ToRobReady = CSRUREGTEMP[92]    ;
    assign ToRobPtr   = CSRUREGTEMP[77:72] ;
    assign ToRobInterrupt = CsruTrapAble   ; 
    assign ToRobCode  = CsruTrapCode       ;
    assign ToRobAddr  = CsruTrapAddr       ;
    assign ToRobIdle  = CsruIdle           ;

    //wire  sysOperate          since syscall and break no operate when after retire
    wire  CsrrdOperate    = (InstRetireAble & (CSRUREGTEMP[71:64] == `InstCsrrd))     ;
    wire  CsrwrOperate    = (InstRetireAble & (CSRUREGTEMP[71:64] == `InstCsrwr))     ;
    wire  CsrxchgOperate  = (InstRetireAble & (CSRUREGTEMP[71:64] == `InstCsrxchg))   ;
    wire  TlbsrchrOperate = (InstRetireAble & (CSRUREGTEMP[71:64] == `InstTlbsrchr))  ;
    wire  TlbsrchwOperate = (InstRetireAble & (CSRUREGTEMP[71:64] == `InstTlbsrchw))  ;
    wire  TlbrdOperate    = (InstRetireAble & (CSRUREGTEMP[71:64] == `InstTlbrd))     ;
    wire  TlbwrOperate    = (InstRetireAble & (CSRUREGTEMP[71:64] == `InstTlbwr))     ;
    wire  TlbfillOperate  = (InstRetireAble & (CSRUREGTEMP[71:64] == `InstTlbfill))   ;
    wire  InvtlbOperate   = (InstRetireAble & (CSRUREGTEMP[71:64] == `InstInvtlb))    ;
    wire  ErtnOperate     = (InstRetireAble & (CSRUREGTEMP[71:64] == `InstEntry))     ;


    assign WriteBackAble = (CsrrdOperate | CsrwrOperate | CsrxchgOperate) & InstRetireAble ;
    assign WriteBackDate = ReadCsrDate ;
    assign WriteBackAddr = CSRUREGTEMP[99:93] ;



    //csr read 
    wire CsrReadAble = (CsrrdOperate | CsrwrOperate | CsrxchgOperate) & InstRetireAble  ;
    wire [13:0] CsrReadAddr = CSRUREGTEMP[91:78] ;
    assign ReadCsrAble = CsrReadAble ;
    assign ReadCsrAddr = CsrReadAddr ;

    //csr witre 
    wire  CsrWriteAble = (CsrwrOperate | CsrxchgOperate | ErtnOperate | TlbsrchwOperate) & InstRetireAble ;
    wire [13:0]     CsrWriteAddr = CSRUREGTEMP[91:78] ;
    wire [`DataBus] CsrWriteDate = CsrxchgOperate ? (CSRUREGTEMP[63:32] & CSRUREGTEMP[31:0]) : CSRUREGTEMP[63:32] ; //sr2
    assign WriteCsrAble = CsrWriteAble ;
    assign WriteCsrAddr = CsrWriteAddr ;
    assign WriteCsrDate = CsrWriteDate ;

    //tlb read 
    wire TlbReadAble        = TlbrdOperate ;
    wire [5:0]  TlbReadaddr = TlbIndex     ;
    assign ReadMmuAble = TlbReadAble ;
    assign ReadMmuAddr = TlbReadaddr ;

    //tlb serch 
    wire TlbSerch              = TlbsrchrOperate ;
    wire [28:0] TlbSerchinform = {AsidDate, TlbEhiDate};
    assign SerchMmuAble = TlbSerch ;
    assign SerchMmuInfr = TlbSerchinform ;

    //tlb write 
    wire TlbWriteAble = (TlbwrOperate | TlbfillOperate) & InstRetireAble ;
    wire [5:0]  tlbWriteAddr = TlbwrOperate ? TlbIndex : 6'd33 ;
    wire [88:0] TlbWriteDate = (TlbEcode == 6'h3f) ? {TlbEhiDate,TlbElo0,TlbElo1,TlbPs} : (TlbNe ? 89'd0 : {TlbEhiDate,TlbElo0,TlbElo1,TlbPs} );
  
    assign WriteMmuAble = TlbWriteAble ;
    assign WriteMmuAddr = tlbWriteAddr ;
    assign WriteMmuDate = TlbWriteDate ;

    //csr write 
    wire CsrTlbIndexWAble = (TlbsrchrOperate | TlbrdOperate) & InstRetireAble;
    wire [`DataBus] CsrTlbIndexWMask = TlbsrchrOperate ?  (SerchSuccess ? {1'b1,25'd0,6'b111111} : {1'b1,31'd0}) : 
                                       TlbrdOperate    ?   {1'b1,1'b0,6'b111111,24'd0} : 32'd0       ;
    wire [`DataBus] CsrTlbIndexWDate = SerchSuccess ? (ReadSUccess ? {1'b0,25'd0,SerchIndexDate} : {1'b1,25'd0,6'd0 }) : 
                                       TlbrdOperate ? (ReadSUccess ? {1'b0,1'b0,ReadMmuDate[5:0],24'd0} : {1'b1,31'd0}) : 32'd0   ;

    assign TlbIndexWAble = CsrTlbIndexWAble ;
    assign TlbIndexWMask = CsrTlbIndexWMask ;
    assign TlbIndexWDate = CsrTlbIndexWDate ;

    wire CsrTlbEhiWAble = (TlbsrchrOperate | TlbrdOperate) & InstRetireAble;
    wire [`DataBus] CsrTlbEhiWDate = ReadSUccess ?  {ReadMmuDate[88:70],13'd0} : 32'd0 ;

    assign TlbEhiWAble = CsrTlbEhiWAble ;
    assign TlbEhiWDate =  CsrTlbEhiWDate ;

    wire CsrTlbElo0WAble = (TlbsrchrOperate | TlbrdOperate) & InstRetireAble; 
    wire [`DataBus] CsrTlbElo0WDate = ReadSUccess ? ReadMmuDate[69:38] : 32'd0 ;

    assign TlbElo0WAble = CsrTlbElo0WAble ;
    assign TlbElo0WDate = CsrTlbElo0WDate ;

    wire CsrTlbElo1WAble = (TlbsrchrOperate | TlbrdOperate) & InstRetireAble; 
    wire [`DataBus] CsrTlbElo1WDate = ReadSUccess ? ReadMmuDate[37:6] : 32'd0  ;

    assign TlbElo1WAble = CsrTlbElo1WAble ;
    assign TlbElo1WDate = CsrTlbElo1WDate ;

    wire CsrCrmdWAble = ErtnOperate & InstRetireAble ;
    wire [`DataBus] CsrCrmdWMask = {23'd0,6'd0,3'b111} ;
    wire [`DataBus] CsrCrmdWDate = {29'd0,PrmdDate} ;

    assign CrmdWAble = CsrCrmdWAble ;
    assign CrmdWMask = CsrCrmdWMask ;
    assign CrmdWDate = CsrCrmdWDate ;

    wire CsrLlbctlWAble = LlbCtlDate & ErtnOperate & InstRetireAble ;

    assign LlCtrlAble = CsrLlbctlWAble ;

    wire InvAble = InvtlbOperate & InstRetireAble ;
    wire [4:0] InvOp   = CSRUREGTEMP[82:78] ; 
    wire [9:0] InvAsid = ReadMmuDate[47:38] ;
    wire [18:0]InvVppn = ReadMmuDate[37:19] ;

    assign CsrInvEn = InvAble ;
    assign CsrInvOp = InvOp   ;
    assign CsrInvAsid  = InvAsid ;
    assign CsrInvVppn  = InvVppn ;


endmodule
`timescale 1ps/1ps  
`include "../define.v"

module Mlu #(
    parameter WIDTH = 32
)(
    input         wire                                 Clk             ,
    input         wire                                 Rest            ,

    input         wire                                 MluStop         ,
    input         wire                                 MluFlash        ,
    
    input         wire      [`MicOperateCode]          MlutipMicOperate,
    input         wire                                 MlutipAble      ,
    input         wire                                 MlutiplierAble  ,
    input         wire      [`ReNameRegBUs]            MlutiplierAddr  ,
    input         wire      [WIDTH-1:0]                Mlutiplier      ,
    input         wire                                 MlutiplicandAble,
    input         wire      [`ReNameRegBUs]            MluTiplicandAddr,
    input         wire      [WIDTH-1:0]                Mlutiplicand    ,
    input         wire                                 RdPhyAble       ,
    input         wire      [`ReNameRegBUs]            RdPhyAddr       ,
    input         wire      [5:0]                      MulRobPtr       ,
    //from  bypass
    input         wire                                 MluSelfAble     ,
    input         wire      [`ReNameRegBUs]            MluSelfAddr     ,
    input         wire      [`DataBus]                 MluSelfDate     ,
    input         wire                                 MluBruAble      ,
    input         wire      [`ReNameRegBUs]            MluBruAddr      ,
    input         wire      [`DataBus]                 MluBruDate      ,
    input         wire                                 MluAlu2Able     ,
    input         wire      [`ReNameRegBUs]            MluAlu2Addr     ,
    input         wire      [`DataBus]                 MluAlu2Date     ,
    input         wire                                 MluAlu1Able     ,
    input         wire      [`ReNameRegBUs]            MluAlu1Addr     ,
    input         wire      [`DataBus]                 MluAlu1Date     ,
    input         wire                                 MluCsrAble      ,
    input         wire      [`ReNameRegBUs]            MluCsrAddr      ,
    input         wire      [`DataBus]                 MluCsrDate      , 
    //to physical
    output        wire      [WIDTH-1:0]                MluToPhyDate    ,
    output        wire      [`ReNameRegBUs]            MluToPhyAddr    ,
    output        wire                                 MluToPhyAble    ,
    //to rob
    output        wire                                 MluToRobAble    ,
    output        wire      [5:0]                      MluToRobPtr     
);


    wire  [`DataBus] MSrc1Date   =  ((MlutiplierAddr == MluSelfAddr) & MluSelfAble & MlutiplierAble) ? MluSelfDate :
                                    ((MlutiplierAddr == MluBruAddr ) & MluBruAble  & MlutiplierAble) ? MluBruDate  :
                                    ((MlutiplierAddr == MluAlu2Addr) & MluAlu2Able & MlutiplierAble) ? MluAlu2Date :
                                    ((MlutiplierAddr == MluAlu1Addr) & MluAlu1Able & MlutiplierAble) ? MluAlu1Date :
                                    ((MlutiplierAddr == MluCsrAddr ) & MluCsrAble  & MlutiplierAble) ? MluCsrDate  : Mlutiplier ;
    
    wire  [`DataBus] MSrc2Date   =  ((MluTiplicandAddr == MluSelfAddr) & MluSelfAble & MlutiplicandAble) ? MluSelfDate :
                                    ((MluTiplicandAddr == MluBruAddr ) & MluBruAble  & MlutiplicandAble) ? MluBruDate  :
                                    ((MluTiplicandAddr == MluAlu2Addr) & MluAlu2Able & MlutiplicandAble) ? MluAlu2Date :
                                    ((MluTiplicandAddr == MluAlu2Addr) & MluAlu1Able & MlutiplicandAble) ? MluAlu1Date :
                                    ((MluTiplicandAddr == MluCsrAddr ) & MluCsrAble  & MlutiplicandAble) ? MluCsrDate  : Mlutiplicand ;
    

    wire [WIDTH*2+3:0] FormalMultiplicand;
    assign FormalMultiplicand = (MSrc2Date[31] == `AbleValue)?{~{{36{MSrc2Date[31]}},MSrc2Date}+1}:{{36{MSrc2Date[31]}},MSrc2Date};
    wire [WIDTH+2  :0] FormalMultiplier  ;
    assign FormalMultiplier   = {{2{MSrc1Date[31]}},MSrc1Date,1'b0};

    wire  [WIDTH*2+3:0]   Booth        [1:17];
    wire                  Upbit        [1:17];     
    genvar BoothCodeLoop;
    generate
        for (BoothCodeLoop = 1; BoothCodeLoop < WIDTH+2 ; BoothCodeLoop = BoothCodeLoop+2) begin:BoothLoop
            assign {Booth[(BoothCodeLoop+1)%2],Upbit[((BoothCodeLoop-1)%2)]} = (FormalMultiplier[BoothCodeLoop+1:BoothCodeLoop-1] == 3'b000)? {`ZeroBoothDate,1'b0}                                 :
                                                                                 (FormalMultiplier[BoothCodeLoop+1:BoothCodeLoop-1] == 3'b001)? {FormalMultiplicand << BoothCodeLoop-1,1'b0}        :
                                                                                 (FormalMultiplier[BoothCodeLoop+1:BoothCodeLoop-1] == 3'b010)? {FormalMultiplicand << BoothCodeLoop-1,1'b0}        :
                                                                                 (FormalMultiplier[BoothCodeLoop+1:BoothCodeLoop-1] == 3'b011)? {FormalMultiplicand  << BoothCodeLoop,1'b0}         :
                                                                                 (FormalMultiplier[BoothCodeLoop+1:BoothCodeLoop-1] == 3'b100)? {(~FormalMultiplicand) << BoothCodeLoop,1'b1}       :
                                                                                 (FormalMultiplier[BoothCodeLoop+1:BoothCodeLoop-1] == 3'b101)? {(~FormalMultiplicand) << BoothCodeLoop-1,1'b1}     :
                                                                                 (FormalMultiplier[BoothCodeLoop+1:BoothCodeLoop-1] == 3'b110)? {(~FormalMultiplicand) << BoothCodeLoop-1,1'b1} :  {`ZeroBoothDate,1'b0};
        end
    endgenerate  
    wire  [16:0] UpbitCog = {Upbit[17],Upbit[16],Upbit[15],Upbit[14],Upbit[13],Upbit[12],Upbit[11],Upbit[10],Upbit[9],Upbit[8],Upbit[7],Upbit[6],Upbit[5],Upbit[4],Upbit[3],Upbit[2],Upbit[1]};

    //need delay assign with this loop boday
    reg  [16:0] SwitchData [0:67] ;
    reg  [6 :0] SwitchLoop        ;
    reg  [6 :0] SwitchLoop1       ;
    reg  [`MicOperateCode]MluMicOpTemp   ;
    reg                   WbAbleTemp     ;
    reg  [`ReNameRegBUs]  WbAddrTemp     ;
    reg                   CommitAbleTemp ;
    reg  [5:0]            CommitPtrTemp  ;
    reg  [16:0]           UpBitDate      ;
    always @(posedge Clk) begin
        if(!Rest)begin
            MluMicOpTemp <= 8'd0 ;
            WbAbleTemp   <= 1'b0 ;
            WbAddrTemp   <= 7'b0 ;
            CommitAbleTemp <= 1'b0 ;
            CommitPtrTemp  <= 6'b0 ;
            UpBitDate      <= 17'd0;
            for (SwitchLoop = 0;SwitchLoop < 32 ;SwitchLoop = SwitchLoop+1) begin
                SwitchData[SwitchLoop] <= 17'h0 ;
            end
            for (SwitchLoop1 = 0;SwitchLoop1 < 32 ;SwitchLoop1 = SwitchLoop1+1) begin
                SwitchData[SwitchLoop1+32] <= 17'h0 ;
            end
            SwitchData[64] <= 17'h0 ;
            SwitchData[65] <= 17'h0 ;
            SwitchData[66] <= 17'h0 ;
            SwitchData[67] <= 17'h0 ;
        end
        else if(MluStop) begin
            MluMicOpTemp <= MluMicOpTemp ;
            WbAbleTemp   <= WbAbleTemp ;
            WbAddrTemp   <= WbAddrTemp ;
            CommitAbleTemp <= CommitAbleTemp ;
            CommitPtrTemp  <= CommitPtrTemp  ;
            UpBitDate      <= UpBitDate;
            for (SwitchLoop = 0;SwitchLoop < 32 ;SwitchLoop = SwitchLoop+1) begin
                SwitchData[SwitchLoop] <= SwitchData[SwitchLoop] ;
            end
            for (SwitchLoop1 = 0;SwitchLoop1 < 32 ;SwitchLoop1 = SwitchLoop1+1) begin
                SwitchData[SwitchLoop1+32] <= SwitchData[SwitchLoop1+32] ;
            end
            SwitchData[64] <= SwitchData[64] ;
            SwitchData[65] <= SwitchData[65] ;
            SwitchData[66] <= SwitchData[66] ;
            SwitchData[67] <= SwitchData[67] ;
        end
        else if(MluFlash) begin
            MluMicOpTemp <= 8'd0 ;
            WbAbleTemp   <= 1'b0 ;
            WbAddrTemp   <= 7'b0 ;
            CommitAbleTemp <= 1'b0 ;
            CommitPtrTemp  <= 6'b0 ;
            UpBitDate      <= 17'd0;
            for (SwitchLoop = 0;SwitchLoop < 32 ;SwitchLoop = SwitchLoop+1) begin
                SwitchData[SwitchLoop] <= 17'h0 ;
            end
            for (SwitchLoop1 = 0;SwitchLoop1 < 32 ;SwitchLoop1 = SwitchLoop1+1) begin
                SwitchData[SwitchLoop1+32] <= 17'h0 ;
            end
            SwitchData[64] <= 17'h0 ;
            SwitchData[65] <= 17'h0 ;
            SwitchData[66] <= 17'h0 ;
            SwitchData[67] <= 17'h0 ;
        end
        else begin
            MluMicOpTemp <= MlutipMicOperate ;
            WbAbleTemp   <= RdPhyAble ;
            WbAddrTemp   <= RdPhyAddr;
            CommitAbleTemp <= MlutipAble ;
            CommitPtrTemp  <= MulRobPtr  ;
            UpBitDate      <= UpbitCog;
            for (SwitchLoop = 0;SwitchLoop < 32 ;SwitchLoop = SwitchLoop+1) begin
                SwitchData[SwitchLoop] <= {Booth[17][SwitchLoop],Booth[16][SwitchLoop],Booth[15][SwitchLoop],Booth[13][SwitchLoop],
                                           Booth[13][SwitchLoop],Booth[12][SwitchLoop],Booth[11][SwitchLoop],Booth[9][SwitchLoop] ,
                                           Booth[9][SwitchLoop] ,Booth[8][SwitchLoop] ,Booth[7][SwitchLoop] ,Booth[5][SwitchLoop] ,
                                           Booth[5][SwitchLoop] ,Booth[4][SwitchLoop] ,Booth[3][SwitchLoop] ,Booth[2][SwitchLoop] , Booth[1][SwitchLoop] } ;
            end    
            for (SwitchLoop1 = 0;SwitchLoop1 < 32 ;SwitchLoop1 = SwitchLoop1+1) begin
                SwitchData[SwitchLoop1] <={Booth[17][SwitchLoop1],Booth[16][SwitchLoop1],Booth[15][SwitchLoop1],Booth[13][SwitchLoop1],
                                           Booth[13][SwitchLoop1],Booth[12][SwitchLoop1],Booth[11][SwitchLoop1],Booth[9][SwitchLoop1] ,
                                           Booth[9][SwitchLoop1] ,Booth[8][SwitchLoop1] ,Booth[7][SwitchLoop1] ,Booth[5][SwitchLoop1] ,
                                           Booth[5][SwitchLoop1] ,Booth[4][SwitchLoop1] ,Booth[3][SwitchLoop1] ,Booth[2][SwitchLoop1] , Booth[1][SwitchLoop1] } ;
            end  
        SwitchData[64] <= {Booth[17][64],Booth[16][64],Booth[15][64],Booth[14][64],
                           Booth[13][64],Booth[12][64],Booth[14][64],Booth[10][64] ,
                           Booth[9][64] ,Booth[8][64] ,Booth[7][64] ,Booth[6][64] ,
                           Booth[5][64] ,Booth[4][64] ,Booth[3][64] ,Booth[2][64] ,Booth[1][64] } ;
        SwitchData[65] <= {Booth[17][65],Booth[16][65],Booth[15][65],Booth[14][65],
                           Booth[13][65],Booth[12][65],Booth[14][65],Booth[10][65] ,
                           Booth[9][65] ,Booth[8][65] ,Booth[7][65] ,Booth[6][65] ,
                           Booth[5][65] ,Booth[4][65] ,Booth[3][65] ,Booth[2][65] ,Booth[1][65] } ;
        SwitchData[66] <= {Booth[17][66],Booth[16][66],Booth[15][66],Booth[14][66],
                           Booth[13][66],Booth[12][66],Booth[14][66],Booth[10][66] ,
                           Booth[9][66] ,Booth[8][66] ,Booth[7][66] ,Booth[6][66] ,
                           Booth[5][66] ,Booth[4][66] ,Booth[3][66] ,Booth[2][66] ,Booth[1][66] } ;
        SwitchData[67] <= {Booth[17][67],Booth[16][67],Booth[15][67],Booth[14][67],
                           Booth[13][67],Booth[12][67],Booth[14][67],Booth[10][67] ,
                           Booth[9][67] ,Booth[8][67] ,Booth[7][67] ,Booth[6][67] ,
                           Booth[5][67] ,Booth[4][67] ,Booth[3][67] ,Booth[2][67] ,Booth[1][67] } ;
        SwitchData[67] <= {Booth[17][67],Booth[16][67],Booth[15][67],Booth[14][67],
                           Booth[13][67],Booth[12][67],Booth[14][67],Booth[10][67] ,
                           Booth[9][67] ,Booth[8][67] ,Booth[7][67] ,Booth[6][67] ,
                           Booth[5][67] ,Booth[4][67] ,Booth[3][67] ,Booth[2][67] ,Booth[1][67] } ;
        
        end
    end

    wire  [WIDTH*2+3:0]  Src1    ;
    wire  [WIDTH*2+3:0]  Src2    ; 
    wire  [13:0]         TempWt  [1:68];
    

    WaccleTree Wt1  (.SrcIn(SwitchData[0]) , .Cin(UpbitCog[15:2]), .CoutGroup(TempWt[1]) , .Cout(Src2[0]) , .S(Src1[0]));
    WaccleTree Wt2  (.SrcIn(SwitchData[1]) , .Cin(TempWt[1]) , .CoutGroup(TempWt[2]) , .Cout(Src2[1]) , .S(Src1[1]));
    WaccleTree Wt3  (.SrcIn(SwitchData[2]) , .Cin(TempWt[2]) , .CoutGroup(TempWt[3]) , .Cout(Src2[2]) , .S(Src1[2]));
    WaccleTree Wt4  (.SrcIn(SwitchData[3]) , .Cin(TempWt[3]) , .CoutGroup(TempWt[4]) , .Cout(Src2[3]) , .S(Src1[3]));
    WaccleTree Wt5  (.SrcIn(SwitchData[4]) , .Cin(TempWt[4]) , .CoutGroup(TempWt[5]) , .Cout(Src2[4]) , .S(Src1[4]));
    WaccleTree Wt6  (.SrcIn(SwitchData[5]) , .Cin(TempWt[5]) , .CoutGroup(TempWt[6]) , .Cout(Src2[5]) , .S(Src1[5]));
    WaccleTree Wt7  (.SrcIn(SwitchData[6]) , .Cin(TempWt[6]) , .CoutGroup(TempWt[7]) , .Cout(Src2[6]) , .S(Src1[6]));
    WaccleTree Wt8  (.SrcIn(SwitchData[7]) , .Cin(TempWt[7]) , .CoutGroup(TempWt[8]) , .Cout(Src2[7]) , .S(Src1[7]));
    WaccleTree Wt9  (.SrcIn(SwitchData[8]) , .Cin(TempWt[8]) , .CoutGroup(TempWt[9]) , .Cout(Src2[8]) , .S(Src1[8]));
    WaccleTree Wt10 (.SrcIn(SwitchData[9]) , .Cin(TempWt[9]) , .CoutGroup(TempWt[10]), .Cout(Src2[9]) , .S(Src1[9]));
    WaccleTree Wt11 (.SrcIn(SwitchData[10]), .Cin(TempWt[10]), .CoutGroup(TempWt[11]), .Cout(Src2[10]), .S(Src1[10]));
    WaccleTree Wt12 (.SrcIn(SwitchData[11]), .Cin(TempWt[11]), .CoutGroup(TempWt[12]), .Cout(Src2[11]), .S(Src1[11]));
    WaccleTree Wt13 (.SrcIn(SwitchData[12]), .Cin(TempWt[12]), .CoutGroup(TempWt[13]), .Cout(Src2[12]), .S(Src1[12]));
    WaccleTree Wt14 (.SrcIn(SwitchData[13]), .Cin(TempWt[13]), .CoutGroup(TempWt[14]), .Cout(Src2[13]), .S(Src1[13]));
    WaccleTree Wt15 (.SrcIn(SwitchData[14]), .Cin(TempWt[14]), .CoutGroup(TempWt[15]), .Cout(Src2[14]), .S(Src1[14]));
    WaccleTree Wt16 (.SrcIn(SwitchData[15]), .Cin(TempWt[15]), .CoutGroup(TempWt[16]), .Cout(Src2[15]), .S(Src1[15]));
    WaccleTree Wt17 (.SrcIn(SwitchData[16]), .Cin(TempWt[16]), .CoutGroup(TempWt[17]), .Cout(Src2[16]), .S(Src1[16]));
    WaccleTree Wt18 (.SrcIn(SwitchData[17]), .Cin(TempWt[17]), .CoutGroup(TempWt[18]), .Cout(Src2[17]), .S(Src1[17]));
    WaccleTree Wt19 (.SrcIn(SwitchData[18]), .Cin(TempWt[18]), .CoutGroup(TempWt[19]), .Cout(Src2[18]), .S(Src1[18]));
    WaccleTree Wt20 (.SrcIn(SwitchData[29]), .Cin(TempWt[19]), .CoutGroup(TempWt[20]), .Cout(Src2[19]), .S(Src1[19]));
    WaccleTree Wt21 (.SrcIn(SwitchData[20]), .Cin(TempWt[20]), .CoutGroup(TempWt[21]), .Cout(Src2[20]), .S(Src1[20]));
    WaccleTree Wt22 (.SrcIn(SwitchData[21]), .Cin(TempWt[21]), .CoutGroup(TempWt[22]), .Cout(Src2[21]), .S(Src1[21]));
    WaccleTree Wt23 (.SrcIn(SwitchData[22]), .Cin(TempWt[22]), .CoutGroup(TempWt[23]), .Cout(Src2[22]), .S(Src1[22]));
    WaccleTree Wt24 (.SrcIn(SwitchData[23]), .Cin(TempWt[23]), .CoutGroup(TempWt[24]), .Cout(Src2[23]), .S(Src1[23]));
    WaccleTree Wt25 (.SrcIn(SwitchData[24]), .Cin(TempWt[24]), .CoutGroup(TempWt[25]), .Cout(Src2[24]), .S(Src1[24]));
    WaccleTree Wt26 (.SrcIn(SwitchData[25]), .Cin(TempWt[25]), .CoutGroup(TempWt[26]), .Cout(Src2[25]), .S(Src1[25]));
    WaccleTree Wt27 (.SrcIn(SwitchData[26]), .Cin(TempWt[26]), .CoutGroup(TempWt[27]), .Cout(Src2[26]), .S(Src1[26]));
    WaccleTree Wt28 (.SrcIn(SwitchData[27]), .Cin(TempWt[27]), .CoutGroup(TempWt[28]), .Cout(Src2[27]), .S(Src1[27]));
    WaccleTree Wt29 (.SrcIn(SwitchData[28]), .Cin(TempWt[28]), .CoutGroup(TempWt[29]), .Cout(Src2[28]), .S(Src1[28]));
    WaccleTree Wt30 (.SrcIn(SwitchData[29]), .Cin(TempWt[29]), .CoutGroup(TempWt[30]), .Cout(Src2[29]), .S(Src1[29]));
    WaccleTree Wt31 (.SrcIn(SwitchData[30]), .Cin(TempWt[30]), .CoutGroup(TempWt[31]), .Cout(Src2[30]), .S(Src1[30]));
    WaccleTree Wt32 (.SrcIn(SwitchData[31]), .Cin(TempWt[31]), .CoutGroup(TempWt[32]), .Cout(Src2[31]), .S(Src1[31]));
    WaccleTree Wt33 (.SrcIn(SwitchData[32]), .Cin(TempWt[32]), .CoutGroup(TempWt[33]), .Cout(Src2[32]), .S(Src1[32]));
    WaccleTree Wt34 (.SrcIn(SwitchData[33]), .Cin(TempWt[33]), .CoutGroup(TempWt[34]), .Cout(Src2[33]), .S(Src1[33]));
    WaccleTree Wt35 (.SrcIn(SwitchData[34]), .Cin(TempWt[34]), .CoutGroup(TempWt[35]), .Cout(Src2[34]), .S(Src1[34]));
    WaccleTree Wt36 (.SrcIn(SwitchData[35]), .Cin(TempWt[35]), .CoutGroup(TempWt[36]), .Cout(Src2[35]), .S(Src1[35]));
    WaccleTree Wt37 (.SrcIn(SwitchData[36]), .Cin(TempWt[36]), .CoutGroup(TempWt[37]), .Cout(Src2[36]), .S(Src1[36]));
    WaccleTree Wt38 (.SrcIn(SwitchData[37]), .Cin(TempWt[37]), .CoutGroup(TempWt[38]), .Cout(Src2[37]), .S(Src1[37]));
    WaccleTree Wt39 (.SrcIn(SwitchData[38]), .Cin(TempWt[38]), .CoutGroup(TempWt[39]), .Cout(Src2[38]), .S(Src1[38]));
    WaccleTree Wt40 (.SrcIn(SwitchData[39]), .Cin(TempWt[39]), .CoutGroup(TempWt[40]), .Cout(Src2[39]), .S(Src1[39]));
    WaccleTree Wt41 (.SrcIn(SwitchData[40]), .Cin(TempWt[40]), .CoutGroup(TempWt[41]), .Cout(Src2[40]), .S(Src1[40]));
    WaccleTree Wt42 (.SrcIn(SwitchData[41]), .Cin(TempWt[41]), .CoutGroup(TempWt[42]), .Cout(Src2[41]), .S(Src1[41]));
    WaccleTree Wt43 (.SrcIn(SwitchData[42]), .Cin(TempWt[42]), .CoutGroup(TempWt[43]), .Cout(Src2[42]), .S(Src1[42]));
    WaccleTree Wt44 (.SrcIn(SwitchData[43]), .Cin(TempWt[43]), .CoutGroup(TempWt[44]), .Cout(Src2[43]), .S(Src1[43]));
    WaccleTree Wt45 (.SrcIn(SwitchData[44]), .Cin(TempWt[44]), .CoutGroup(TempWt[45]), .Cout(Src2[44]), .S(Src1[44]));
    WaccleTree Wt46 (.SrcIn(SwitchData[45]), .Cin(TempWt[45]), .CoutGroup(TempWt[46]), .Cout(Src2[45]), .S(Src1[45]));
    WaccleTree Wt47 (.SrcIn(SwitchData[46]), .Cin(TempWt[46]), .CoutGroup(TempWt[47]), .Cout(Src2[46]), .S(Src1[46]));
    WaccleTree Wt48 (.SrcIn(SwitchData[47]), .Cin(TempWt[47]), .CoutGroup(TempWt[48]), .Cout(Src2[47]), .S(Src1[47]));
    WaccleTree Wt49 (.SrcIn(SwitchData[48]), .Cin(TempWt[48]), .CoutGroup(TempWt[49]), .Cout(Src2[48]), .S(Src1[48]));
    WaccleTree Wt50 (.SrcIn(SwitchData[49]), .Cin(TempWt[49]), .CoutGroup(TempWt[50]), .Cout(Src2[49]), .S(Src1[49]));
    WaccleTree Wt51 (.SrcIn(SwitchData[50]), .Cin(TempWt[50]), .CoutGroup(TempWt[51]), .Cout(Src2[50]), .S(Src1[50]));
    WaccleTree Wt52 (.SrcIn(SwitchData[51]), .Cin(TempWt[51]), .CoutGroup(TempWt[52]), .Cout(Src2[51]), .S(Src1[51]));
    WaccleTree Wt53 (.SrcIn(SwitchData[52]), .Cin(TempWt[52]), .CoutGroup(TempWt[53]), .Cout(Src2[52]), .S(Src1[52]));
    WaccleTree Wt54 (.SrcIn(SwitchData[53]), .Cin(TempWt[53]), .CoutGroup(TempWt[54]), .Cout(Src2[53]), .S(Src1[53]));
    WaccleTree Wt55 (.SrcIn(SwitchData[54]), .Cin(TempWt[54]), .CoutGroup(TempWt[55]), .Cout(Src2[54]), .S(Src1[54]));
    WaccleTree Wt56 (.SrcIn(SwitchData[55]), .Cin(TempWt[55]), .CoutGroup(TempWt[56]), .Cout(Src2[55]), .S(Src1[55]));
    WaccleTree Wt57 (.SrcIn(SwitchData[56]), .Cin(TempWt[56]), .CoutGroup(TempWt[57]), .Cout(Src2[56]), .S(Src1[56]));
    WaccleTree Wt58 (.SrcIn(SwitchData[57]), .Cin(TempWt[57]), .CoutGroup(TempWt[58]), .Cout(Src2[57]), .S(Src1[57]));
    WaccleTree Wt59 (.SrcIn(SwitchData[58]), .Cin(TempWt[58]), .CoutGroup(TempWt[59]), .Cout(Src2[58]), .S(Src1[58]));
    WaccleTree Wt60 (.SrcIn(SwitchData[59]), .Cin(TempWt[59]), .CoutGroup(TempWt[60]), .Cout(Src2[59]), .S(Src1[59]));
    WaccleTree Wt61 (.SrcIn(SwitchData[60]), .Cin(TempWt[60]), .CoutGroup(TempWt[61]), .Cout(Src2[60]), .S(Src1[60]));
    WaccleTree Wt62 (.SrcIn(SwitchData[61]), .Cin(TempWt[61]), .CoutGroup(TempWt[62]), .Cout(Src2[61]), .S(Src1[61]));
    WaccleTree Wt63 (.SrcIn(SwitchData[62]), .Cin(TempWt[62]), .CoutGroup(TempWt[63]), .Cout(Src2[62]), .S(Src1[62]));
    WaccleTree Wt64 (.SrcIn(SwitchData[63]), .Cin(TempWt[63]), .CoutGroup(TempWt[64]), .Cout(Src2[63]), .S(Src1[63]));
    WaccleTree Wt65 (.SrcIn(SwitchData[64]), .Cin(TempWt[64]), .CoutGroup(TempWt[65]), .Cout(Src2[64]), .S(Src1[64]));
    WaccleTree Wt66 (.SrcIn(SwitchData[65]), .Cin(TempWt[65]), .CoutGroup(TempWt[66]), .Cout(Src2[65]), .S(Src1[65]));
    WaccleTree Wt67 (.SrcIn(SwitchData[66]), .Cin(TempWt[66]), .CoutGroup(TempWt[67]), .Cout(Src2[66]), .S(Src1[66]));
    WaccleTree Wt68 (.SrcIn(SwitchData[67]), .Cin(TempWt[67]), .CoutGroup(TempWt[68]), .Cout(Src2[67]), .S(Src1[67]));
    

    reg  [`MicOperateCode]MluMicOpOut   ;
    reg                   WbAbleOut     ;
    reg  [`ReNameRegBUs]  WbAddrOut     ;
    reg                   CommitAblOut  ;
    reg  [5:0]            CommitPtrOut  ;
    reg  [WIDTH*2+3:0]    FSrc1Out      ;
    reg  [WIDTH*2+3:0]    FSrc2Out      ;
    reg  [1:0]            UpBitOut      ;   
    reg  [63:0]           MulOutReg     ;
    always @(posedge Clk) begin
        if(!Rest)begin
            MluMicOpOut  <= 8'b0        ;
            WbAbleOut    <= 1'b0        ;
            WbAddrOut    <= 7'b0        ;
            CommitAblOut <= 1'b0        ;
            CommitPtrOut <= 6'b0        ;
            FSrc1Out     <= 68'd0       ;
            FSrc2Out     <= 68'd0       ;
            UpBitOut     <= 2'b0        ;
            MulOutReg    <= 64'h0       ;
        end 
        else if(MluStop) begin
            MluMicOpOut  <= MluMicOpOut ;
            WbAbleOut    <= WbAbleOut   ;
            WbAddrOut    <= WbAddrOut   ;
            CommitAblOut <= CommitAblOut;
            CommitPtrOut <= CommitPtrOut;
            FSrc1Out     <= FSrc1Out    ;
            FSrc2Out     <= FSrc2Out    ;
            UpBitOut     <= UpBitOut    ;
            MulOutReg    <= MulOutReg   ;
        end
        else if(MluFlash) begin
            MluMicOpOut  <= 8'b0        ;
            WbAbleOut    <= 1'b0        ;
            WbAddrOut    <= 7'b0        ;
            CommitAblOut <= 1'b0        ;
            CommitPtrOut <= 6'b0        ;
            FSrc1Out     <= 68'd0       ;
            FSrc2Out     <= 68'd0       ;
            UpBitOut     <= 2'b0        ;
            MulOutReg    <= 64'h0       ;
        end
        else begin
            MluMicOpOut  <= MluMicOpTemp ;
            WbAbleOut    <= WbAbleTemp   ;
            WbAddrOut    <= WbAddrTemp   ;
            CommitAblOut <= CommitAbleTemp;
            CommitPtrOut <= CommitPtrTemp ;
            FSrc1Out     <= Src1          ;
            FSrc2Out     <= Src2          ;
            UpBitOut     <= UpBitDate[1:0];
            MulOutReg    <= MulData[63:0] ;
        end 
    end

    wire [WIDTH*2+3:0]  FInSrc1 ;
    wire [WIDTH*2+3:0]  FInSrc2 ;
    wire [WIDTH*2+3:0]  MulData ;
    assign FInSrc1 = FSrc1Out                  ;
    assign FInSrc2 = {FSrc2Out[WIDTH*2+2:0],UpBitOut[1]} ;
    assign MulData = FInSrc1 + FInSrc2 + {67'b0,UpBitOut[0]};

    assign MluToPhyAble = WbAbleOut ;
    assign MluToPhyAddr = WbAddrOut ;
    assign MluToPhyDate = (MluMicOpOut == `InstMulw)   ? MulOutReg[31:0]  :
                          (MluMicOpOut == `InstMulHw)  ? MulOutReg[63:32] :
                          (MluMicOpOut == `InstMulHuw) ? MulOutReg[63:32] : `ZeorDate;

    assign MluToRobAble = CommitAblOut ;
    assign MluToRobPtr  = CommitPtrOut ;


endmodule

module WaccleTree (
    input     wire      [16:0]                      SrcIn     ,
    input     wire      [13:0]                      Cin       ,
    output    wire      [13:0]                      CoutGroup ,
    output    wire                                  Cout      ,
    output    wire                                  S         
);

    wire  [13:0] OutTemp    ;
    wire  [4 :0] Leve1Temp  ;

    Cas cas0(.A(SrcIn[2]) , .B(SrcIn[3]) , .Cin(SrcIn[4]) , .Cout(OutTemp[0]), .S(Leve1Temp[0]));
    Cas cas1(.A(SrcIn[5]) , .B(SrcIn[6]) , .Cin(SrcIn[7]) , .Cout(OutTemp[1]), .S(Leve1Temp[1]));
    Cas cas2(.A(SrcIn[8]) , .B(SrcIn[9]) , .Cin(SrcIn[10]), .Cout(OutTemp[2]), .S(Leve1Temp[2]));
    Cas cas3(.A(SrcIn[11]), .B(SrcIn[12]), .Cin(SrcIn[13]), .Cout(OutTemp[3]), .S(Leve1Temp[3]));
    Cas cas4(.A(SrcIn[14]), .B(SrcIn[15]), .Cin(SrcIn[16]), .Cout(OutTemp[4]), .S(Leve1Temp[4]));
    
    wire  [3 :0] Leve2Temp  ;
    Cas cas5(.A(Cin[0])       , .B(Cin[1])       , .Cin(Cin[2])       , .Cout(OutTemp[5]), .S(Leve2Temp[0]));
    Cas cas6(.A(SrcIn[0])     , .B(Cin[3])       , .Cin(Cin[4])       , .Cout(OutTemp[6]), .S(Leve2Temp[1]));
    Cas cas7(.A(SrcIn[1])     , .B(Leve1Temp[0]) , .Cin(Leve1Temp[1]) , .Cout(OutTemp[7]), .S(Leve2Temp[2]));
    Cas cas8(.A(Leve1Temp[2]) , .B(Leve1Temp[3]) , .Cin(Leve1Temp[4]) , .Cout(OutTemp[8]), .S(Leve2Temp[3]));

    wire  [1 :0] Leve3Temp  ;
    Cas cas9 (.A(Leve2Temp[0]) , .B(Cin[5])       , .Cin(Cin[6])       , .Cout(OutTemp[9]) , .S(Leve3Temp[0]));
    Cas cas10(.A(Leve2Temp[1]) , .B(Leve2Temp[2]) , .Cin(Leve2Temp[3]) , .Cout(OutTemp[10]), .S(Leve3Temp[1]));

    wire  [1 :0] Leve4Temp  ;
    Cas cas11(.A(Cin[7])       , .B(Cin[8])       , .Cin(Cin[9])       , .Cout(OutTemp[11]) , .S(Leve4Temp[0]));
    Cas cas12(.A(Leve3Temp[0]) , .B(Leve3Temp[1]) , .Cin(Cin[10])      , .Cout(OutTemp[12]) , .S(Leve4Temp[1]));

    wire         Leve5Temp  ;
    Cas cas13(.A(Leve4Temp[0]) , .B(Leve4Temp[1]) , .Cin(Cin[11])      , .Cout(OutTemp[13]) , .S(Leve5Temp));

    Cas cas14(.A(Leve5Temp)    , .B(Cin[12])      , .Cin(Cin[13])      , .Cout(Cout)        , .S(S));

    assign CoutGroup = OutTemp ;


endmodule


module Cas (
    input  wire    A    ,
    input  wire    B    ,
    input  wire    Cin  ,
    output wire    Cout ,
    output wire    S    
);

    assign S    = A ^ B ^ Cin              ;
    assign Cout = A & B | B & Cin | A & Cin;
    
endmodule
`timescale 1ps/1ps
`include "../define.v"

module Div #(
    parameter WIDTH_DIV = 32 
) (
    input         wire                               Clk           ,
    input         wire                               Rest          , 
 
    input         wire                               DivStop       ,
    input         wire                               DivFlash      ,
 
    output        wire                               DivReq        ,
    //from issuequeueint 
    input         wire                               DivInstAble   ,
    input         wire   [`MicOperateCode]           DivMicopcode  ,
    input         wire                               DivSrc1Able   ,
    input         wire   [`ReNameRegBUs]             DivSrc1Addr   ,
    input         wire   [`DataBus]                  DivSrc1Date   ,
    input         wire                               DivSrc2Able   , //对于跳转指令的rd会被解码为src2
    input         wire   [`ReNameRegBUs]             DivSrc2Addr   ,
    input         wire   [`DataBus]                  DivSrc2Date   ,
    input         wire                               DivRdAble     ,
    input         wire   [`ReNameRegBUs]             DivRdAddr     ,
    input         wire   [5:0]                       DivROBPtr     , 

    input         wire                               DivBruAble     ,
    input         wire   [`ReNameRegBUs]             DivBruAddr     ,
    input         wire   [`DataBus]                  DivBruDate     ,
    input         wire                               DivAlu2Able    ,
    input         wire   [`ReNameRegBUs]             DivAlu2Addr    ,
    input         wire   [`DataBus]                  DivAlu2Date    ,
    input         wire                               DivMulAble     ,
    input         wire   [`ReNameRegBUs]             DivMulAddr     ,
    input         wire   [`DataBus]                  DivMulDate     , 
    input         wire                               DivCsrAble     ,
    input         wire   [`ReNameRegBUs]             DivCsrAddr     ,
    input         wire   [`DataBus]                  DivCsrDate     , 
    //to physical
    output        wire                               DivWBAble      ,
    output        wire   [`ReNameRegBUs]             DivWBAddr      ,
    output        wire   [`DataBus]                  DivWBDate      ,
    //to ROB
    output        wire                               DivCommitAble  ,
    output        wire   [5:0]                       DivCommitPtr   

);

    wire  [`DataBus] DSrc1Date   =  ((DivSrc1Addr == DivBruAddr ) & DivBruAble  & DivSrc1Able) ? DivBruDate  :
                                    ((DivSrc1Addr == DivAlu2Addr) & DivAlu2Able & DivSrc1Able) ? DivAlu2Date :
                                    ((DivSrc1Addr == DivMulAddr ) & DivMulAble  & DivSrc1Able) ? DivMulDate  :
                                    ((DivSrc1Addr == DivCsrAddr ) & DivCsrAble  & DivSrc1Able) ? DivCsrDate  : DivSrc1Date ;
    
    wire  [`DataBus] DSrc2Date   =  ((DivSrc2Addr == DivBruAddr ) & DivBruAble  & DivSrc2Able) ? DivBruDate  :
                                    ((DivSrc2Addr == DivAlu2Addr) & DivAlu2Able & DivSrc2Able) ? DivAlu2Date :
                                    ((DivSrc2Addr == DivMulAddr ) & DivMulAble  & DivSrc2Able) ? DivMulDate  :
                                    ((DivSrc2Addr == DivCsrAddr ) & DivCsrAble  & DivSrc2Able) ? DivCsrDate  : DivSrc2Date ;
    
    wire     [WIDTH_DIV-1:0]    UnsignDivisior  ;
    wire     [WIDTH_DIV-1:0]    UnsignDivdend   ;
    wire                        DivsignValue    ;
    assign DivsignValue   = DSrc2Date[31] ^ DSrc1Date[31];
    assign UnsignDivisior = (DSrc1Date[31])? ~DSrc1Date+1 : DSrc1Date ;
    assign UnsignDivdend  = (DSrc2Date[31])? ~DSrc2Date+1 : DSrc2Date ;

    wire                        Code1Selct      ;
    wire                        Code2Selct      ;
    wire                        Code3Selct      ;
    wire                        Code4Selct      ;
    wire                        Code5Selct      ;
    wire                        Code6Selct      ;
    wire                        Code7Selct      ;
    wire                        Code8Selct      ;
    assign Code1Selct     = UnsignDivisior[31]&UnsignDivisior[30]&UnsignDivisior[29]&UnsignDivisior[28];
    assign Code2Selct     = UnsignDivisior[27]&UnsignDivisior[26]&UnsignDivisior[25]&UnsignDivisior[24];
    assign Code3Selct     = UnsignDivisior[23]&UnsignDivisior[22]&UnsignDivisior[21]&UnsignDivisior[20];
    assign Code4Selct     = UnsignDivisior[19]&UnsignDivisior[18]&UnsignDivisior[17]&UnsignDivisior[16];
    assign Code5Selct     = UnsignDivisior[15]&UnsignDivisior[14]&UnsignDivisior[13]&UnsignDivisior[12];
    assign Code6Selct     = UnsignDivisior[11]&UnsignDivisior[10]&UnsignDivisior[9 ]&UnsignDivisior[8 ];
    assign Code7Selct     = UnsignDivisior[7 ]&UnsignDivisior[6 ]&UnsignDivisior[5 ]&UnsignDivisior[4 ];
    assign Code8Selct     = UnsignDivisior[3 ]&UnsignDivisior[2 ]&UnsignDivisior[1 ]&UnsignDivisior[0 ];  
  
    wire   [2:0]                 Code1ShiftSrc  ;
    wire   [2:0]                 Code2ShiftSrc  ;
    wire   [2:0]                 Code3ShiftSrc  ;
    wire   [2:0]                 Code4ShiftSrc  ;
    wire   [2:0]                 Code5ShiftSrc  ;
    wire   [2:0]                 Code6ShiftSrc  ;
    wire   [2:0]                 Code7ShiftSrc  ;
    wire   [2:0]                 Code8ShiftSrc  ;
   
    assign Code1ShiftSrc = ~UnsignDivisior[31] &  UnsignDivisior[30] ? 3'd1 :
                           ~UnsignDivisior[31] & ~UnsignDivisior[30] &  UnsignDivisior[29]  ? 3'd2 :
                           ~UnsignDivisior[31] & ~UnsignDivisior[30] & ~UnsignDivisior[29] &  UnsignDivisior[28] ? 3'd3 :
                           ~UnsignDivisior[31] & ~UnsignDivisior[30] & ~UnsignDivisior[29] & ~UnsignDivisior[28] ? 3'd4 :3'd0 ;
    assign Code2ShiftSrc = ~UnsignDivisior[27] &  UnsignDivisior[26] ? 3'd1 :
                           ~UnsignDivisior[27] & ~UnsignDivisior[26] &  UnsignDivisior[25]  ? 3'd2 :
                           ~UnsignDivisior[27] & ~UnsignDivisior[26] & ~UnsignDivisior[25] &  UnsignDivisior[24] ? 3'd3 :
                           ~UnsignDivisior[27] & ~UnsignDivisior[26] & ~UnsignDivisior[25] & ~UnsignDivisior[24] ? 3'd4 :3'd0 ;
    assign Code3ShiftSrc = ~UnsignDivisior[23] &  UnsignDivisior[22] ? 3'd1 :
                           ~UnsignDivisior[23] & ~UnsignDivisior[22] &  UnsignDivisior[21]  ? 3'd2 :
                           ~UnsignDivisior[23] & ~UnsignDivisior[22] & ~UnsignDivisior[21] &  UnsignDivisior[20] ? 3'd3 :
                           ~UnsignDivisior[23] & ~UnsignDivisior[22] & ~UnsignDivisior[21] & ~UnsignDivisior[20] ? 3'd4 :3'd0 ;
    assign Code4ShiftSrc = ~UnsignDivisior[19] &  UnsignDivisior[18] ? 3'd1 :
                           ~UnsignDivisior[19] & ~UnsignDivisior[18] &  UnsignDivisior[17]  ? 3'd2 :
                           ~UnsignDivisior[19] & ~UnsignDivisior[18] & ~UnsignDivisior[17] &  UnsignDivisior[16] ? 3'd3 :
                           ~UnsignDivisior[19] & ~UnsignDivisior[18] & ~UnsignDivisior[17] & ~UnsignDivisior[16] ? 3'd4 :3'd0 ;
    assign Code5ShiftSrc = ~UnsignDivisior[15] &  UnsignDivisior[14] ? 3'd1 :
                           ~UnsignDivisior[15] & ~UnsignDivisior[14] &  UnsignDivisior[13]  ? 3'd2 :
                           ~UnsignDivisior[15] & ~UnsignDivisior[14] & ~UnsignDivisior[13] &  UnsignDivisior[12] ? 3'd3 :
                           ~UnsignDivisior[15] & ~UnsignDivisior[14] & ~UnsignDivisior[13] & ~UnsignDivisior[12] ? 3'd4 :3'd0 ;
    assign Code6ShiftSrc = ~UnsignDivisior[11] &  UnsignDivisior[10] ? 3'd1 :
                           ~UnsignDivisior[11] & ~UnsignDivisior[10] &  UnsignDivisior[9 ]  ? 3'd2 :
                           ~UnsignDivisior[11] & ~UnsignDivisior[10] & ~UnsignDivisior[9 ] &  UnsignDivisior[8 ] ? 3'd3 :
                           ~UnsignDivisior[11] & ~UnsignDivisior[10] & ~UnsignDivisior[9 ] & ~UnsignDivisior[8 ] ? 3'd4 :3'd0 ;
    assign Code7ShiftSrc = ~UnsignDivisior[7 ] &  UnsignDivisior[6 ] ? 3'd1 :
                           ~UnsignDivisior[7 ] & ~UnsignDivisior[6 ] &  UnsignDivisior[5 ]  ? 3'd2 : 
                           ~UnsignDivisior[7 ] & ~UnsignDivisior[6 ] & ~UnsignDivisior[5 ] &  UnsignDivisior[4 ] ? 3'd3 :
                           ~UnsignDivisior[7 ] & ~UnsignDivisior[6 ] & ~UnsignDivisior[5 ] & ~UnsignDivisior[4 ] ? 3'd4 :3'd0 ;
    assign Code8ShiftSrc = ~UnsignDivisior[3 ] &  UnsignDivisior[2 ] ? 3'd1 :
                           ~UnsignDivisior[3 ] & ~UnsignDivisior[2 ] &  UnsignDivisior[1 ]  ? 3'd2 :
                           ~UnsignDivisior[3 ] & ~UnsignDivisior[2 ] & ~UnsignDivisior[1 ] &  UnsignDivisior[0 ] ? 3'd3 :
                           ~UnsignDivisior[3 ] & ~UnsignDivisior[2 ] & ~UnsignDivisior[1 ] & ~UnsignDivisior[0 ] ? 3'd4 :3'd0 ;

    wire   [5:0]         ShiftCode ;
    assign ShiftCode = Code1Selct ? {3'b0,Code1ShiftSrc}: //+0
                       Code2Selct ? (Code2ShiftSrc[2]? {2'b0,1'b1,3'b0}: {3'b0,1'b1, Code2ShiftSrc[1:0]}) : //+4
                       Code3Selct ? {2'b0,1'b1,Code3ShiftSrc} : //+8
                       Code4Selct ? (Code4ShiftSrc[2]? {1'b0,1'b1,4'b0}: {2'b0,2'b11,Code4ShiftSrc[1:0]}) : //+12
                       Code5Selct ? {1'b0,1'b1,1'b0,Code5ShiftSrc} : //+16
                       Code6Selct ? (Code6ShiftSrc[2]? {1'b0,2'b11,3'b0}: {1'b0,1'b1,1'b0,1'b1,Code6ShiftSrc[1:0]}) : //+20
                       Code7Selct ? {1'b0,2'b11,Code7ShiftSrc} : //+24
                       Code8Selct ? {Code8ShiftSrc[2]? {1'b1,5'b0}: {1'b0,3'b111,Code8ShiftSrc[1:0]}} : 6'd32 ; //+28

    wire   [WIDTH_DIV-1:0]  DivisiorTemp; //没有符号扩展因为在选取数据时已经是无符号，这样可以减少lead zero counter 和select quotient的电路复杂性
    wire   [WIDTH_DIV+2:0]  DividendTemp;
    wire   [5:0]            IterationsDub;
    assign DivisiorTemp = DSrc1Date <<ShiftCode ;
    assign DividendTemp = ShiftCode[0] ? {3'b0,UnsignDivdend} : {2'b0,UnsignDivdend,1'b0};
    assign IterationsDub= ShiftCode[0] ? ShiftCode+1 : ShiftCode ;
    

    wire   [WIDTH_DIV+2:0]  DivTempNext= (QOut == `PosiQuit2)? DivedRegdata - {1'b1,DivisiorData,2'b0} :
                                         (QOut == `PosiQuit1)? DivedRegdata - {2'b0,DivisiorData,1'b0} :
                                         (QOut == `ZeroQuit0)? DivedRegdata                            :
                                         (QOut == `NegiQuit1)? DivedRegdata + {2'b0,DivisiorData,1'b0} :
                                         (QOut == `NegiQuit1)? DivedRegdata + {1'b0,DivisiorData,2'b0} :
                                         35'h0              ;
    wire   [WIDTH_DIV+2:0]  DivDataNext = DivTempNext << 2 ;

    reg    [WIDTH_DIV+2:0]  DivedRegdata;
    reg    [WIDTH_DIV-1:0]  DivisiorData;
    reg                     DivSignReg  ;
    reg    [`MicOperateCode]DivOpcodeReg;
    reg    [`ReNameRegBUs]  DivDataAddr ;
    reg    [2:0]            DivState    ;
    reg    [5:0]            Iteration   ;
    reg    [WIDTH_DIV-1:0]  DivsiorTemp ;
    reg    [5:0]            DivRobPtrTemp ;

    always @(posedge Clk) begin
        if(!Rest) begin
            DivedRegdata <=  35'd0   ;
            DivisiorData <= `ZeorDate;
            DivSignReg   <= 1'b0     ;
            DivOpcodeReg <= 8'd0     ;
            DivDataAddr  <= 7'd0     ;
            DivState     <= `DivIdle ;
            Iteration    <= 6'd0     ;
            DivsiorTemp  <= `ZeorDate;
            DivRobPtrTemp<= 6'd0     ;
        end 
        else if(DivStop) begin
            DivedRegdata <= DivedRegdata  ;
            DivisiorData <= DivisiorData  ;
            DivSignReg   <= DivSignReg    ;
            DivOpcodeReg <= DivOpcodeReg  ;
            DivDataAddr  <= DivDataAddr   ;
            DivState     <= DivState      ;
            Iteration    <= Iteration     ;
            DivsiorTemp  <= DivsiorTemp   ;
            DivRobPtrTemp<= DivRobPtrTemp ;
        end
        else if(DivFlash) begin
            DivedRegdata <=  35'd0   ;
            DivisiorData <= `ZeorDate;
            DivSignReg   <= 1'b0     ;
            DivOpcodeReg <= 8'd0     ;
            DivDataAddr  <= 7'd0     ;
            DivState     <= `DivIdle ;
            Iteration    <= 6'd0     ;
            DivsiorTemp  <= `ZeorDate;
            DivRobPtrTemp<= 6'd0     ;
        end
        else begin
                case (DivState) 
                    `DivIdle: begin if(DivInstAble) begin //还缺少一种除零的情况，后续添加
                                    DivedRegdata <=  DividendTemp; 
                                    DivisiorData <=  DivisiorTemp;
                                    DivSignReg   <=  DivsignValue;
                                    DivOpcodeReg <=  DivMicopcode;
                                    DivDataAddr  <=  DivRdAddr   ; 
                                    DivState     <=  `DivItir    ; 
                                    Iteration    <=  IterationsDub;
                                    DivsiorTemp  <=  UnsignDivisior;
                                    DivRobPtrTemp<=  DivROBPtr     ;end 
                              else begin
                                    DivedRegdata <=  35'd0   ;
                                    DivisiorData <= `ZeorDate;
                                    DivSignReg   <= 1'b0     ;
                                    DivOpcodeReg <= 8'd0     ;
                                    DivDataAddr  <= 7'd0     ;
                                    DivState     <= `DivIdle ;
                                    Iteration    <= 6'd0     ;
                                    DivsiorTemp  <= `ZeorDate;
                                    DivRobPtrTemp<= 6'd0     ;end
                    end 
                    `DivItir: begin  if(Iteration > 0)begin 
                                    DivedRegdata <=  DivDataNext ; 
                                    DivisiorData <=  DivisiorData;
                                    DivSignReg   <=  DivSignReg  ;
                                    DivOpcodeReg <=  DivOpcodeReg;
                                    DivDataAddr  <=  DivDataAddr ; 
                                    DivState     <=  `DivItir    ; 
                                    Iteration    <=  Iteration-2 ;
                                    DivsiorTemp  <=  DivsiorTemp ;
                                    DivRobPtrTemp<=  DivRobPtrTemp;end 
                                else begin
                                    DivedRegdata <=  DivedRegdata;
                                    DivisiorData <=  DivisiorData;
                                    DivSignReg   <=  DivSignReg  ;
                                    DivOpcodeReg <=  DivOpcodeReg;
                                    DivDataAddr  <=  DivDataAddr ; 
                                    DivState     <=  `DivOut     ; 
                                    Iteration    <=  Iteration   ;
                                    DivsiorTemp  <=  DivsiorTemp ;
                                    DivRobPtrTemp<=  DivRobPtrTemp;end 
                    end 
                    `DivOut : begin
                                    DivedRegdata <=  DivedRegdata;
                                    DivisiorData <=  DivisiorData;
                                    DivSignReg   <=  DivSignReg  ;
                                    DivOpcodeReg <=  DivOpcodeReg;
                                    DivDataAddr  <=  DivDataAddr ; 
                                    DivState     <=  `DivIdle    ; 
                                    Iteration    <=  Iteration   ;
                                    DivsiorTemp  <=  DivsiorTemp ;
                                    DivRobPtrTemp<=  DivRobPtrTemp;end  
                    default : begin
                                    DivedRegdata <=  35'd0   ;
                                    DivisiorData <= `ZeorDate;
                                    DivSignReg   <= 1'b0     ;
                                    DivOpcodeReg <= 8'd0     ;
                                    DivDataAddr  <= 7'd0     ;
                                    DivState     <= `DivIdle ;
                                    Iteration    <= 6'd0     ;
                                    DivsiorTemp  <= `ZeorDate;
                                    DivRobPtrTemp<= 6'd0     ;end
                endcase
        end
    end

    wire [3:0] DivisiorIn ;
    wire [5:0] DividendIn ;
    wire [2:0] QOut       ;

    assign DivisiorIn = DivisiorData[WIDTH_DIV-1:WIDTH_DIV-4];
    assign DividendIn = DivedRegdata[WIDTH_DIV+2:WIDTH_DIV-3];

    SelecQuotient SDQ(
        .DivisiorSq (DivisiorIn),
        .DividendSq (DividendIn),
        .Quotient   (QOut      )
    );

    wire [2:0]      SelectIn    ;
    wire            OFCAble     ;
    wire [`DataBus] QuotientOut ;

    assign SelectIn = QOut ;
    assign OFCAble  = (DivState <= `DivItir);
    
    OneFlyConversion OFC (
        .Clk           (Clk         ),
        .Rest          (Rest        ),

        .OfcStop       (DivStop     ),
        .OfcFlash      (DivFlash    ),
    
        .SelectQuite   (SelectIn    ),
        .FlyConverStart(OFCAble     ),
        .QuotientData  (QuotientOut )
    );

    wire [WIDTH_DIV+2:0] ReminderTemp ;
    wire [WIDTH_DIV-1:0] QuotitentTemp;
    wire [WIDTH_DIV-1:0] QuotitentSign;
    assign ReminderTemp = DivedRegdata[WIDTH_DIV+2]? DivedRegdata+{2'b0,DivsiorTemp} : DivedRegdata;
    assign QuotitentTemp= DivedRegdata[WIDTH_DIV+2]? QuotientOut-1 : QuotientOut;
    assign QuotitentSign= DivSignReg ? ~QuotitentTemp + 1 : QuotitentTemp ;
    assign DivReq = ((DivState == `DivOut) | (DivState == `DivIdle)) & ~DivInstAble;
    assign {DivWBAble,DivWBAddr,DivWBDate} = ((DivState == `DivOut) & ((DivOpcodeReg == `InstDivw) | (DivOpcodeReg == `InstDivwu)))? {`AbleValue,DivDataAddr,QuotitentSign} :
                                                     ((DivState == `DivOut) & ((DivOpcodeReg == `InstModw) | (DivOpcodeReg == `InstModwu)))? {`AbleValue,DivDataAddr,ReminderTemp[31:0] } : {`EnableValue,7'b0,`ZeorDate};

    assign {DivCommitAble, DivCommitPtr} = (DivState == `DivOut) ? {`AbleValue,DivRobPtrTemp} : {`EnableValue,6'd0};

endmodule


module SelecQuotient (
    input     wire           [3:0]                   DivisiorSq,
    input     wire  signed   [5:0]                   DividendSq,

    output                   [2:0]                   Quotient  
); 

    wire SelectDivisior1000 = (DivisiorSq == 4'b1000) ;
    wire SelectDivisior1001 = (DivisiorSq == 4'b1001) ;
    wire SelectDivisior1010 = (DivisiorSq == 4'b1010) ;
    wire SelectDivisior1011 = (DivisiorSq == 4'b1011) ;
    wire SelectDivisior1100 = (DivisiorSq == 4'b1100) ;
    wire SelectDivisior1101 = (DivisiorSq == 4'b1101) ;
    wire SelectDivisior1110 = (DivisiorSq == 4'b1110) ;
    wire SelectDivisior1111 = (DivisiorSq == 4'b1111) ;


    wire ForDivsorP4   = (DividendSq >=  4) ;
    wire ForDivsorP6   = (DividendSq >=  6) ;
    wire ForDivsorP8   = (DividendSq >=  8) ;
    wire ForDivsorP12  = (DividendSq >=  12);
    wire ForDivsorP14  = (DividendSq >=  14);
    wire ForDivsorP15  = (DividendSq >=  15);
    wire ForDivsorP16  = (DividendSq >=  16);
    wire ForDivsorP18  = (DividendSq >=  18);
    wire ForDivsorP20  = (DividendSq >=  20);
    wire ForDivsorP24  = (DividendSq >=  24);
    wire ForDivsorN24  = (DividendSq >= -24);
    wire ForDivsorN22  = (DividendSq >= -22);
    wire ForDivsorN20  = (DividendSq >= -20);
    wire ForDivsorN18  = (DividendSq >= -18);
    wire ForDivsorN16  = (DividendSq >= -16);
    wire ForDivsorN15  = (DividendSq >= -15);
    wire ForDivsorN13  = (DividendSq >= -13);
    wire ForDivsorN8   = (DividendSq >= -8) ;
    wire ForDivsorN6   = (DividendSq >= -6) ;
    wire ForDivsorN4   = (DividendSq >= -4) ;

    wire For1000QP2 = (SelectDivisior1000 &  ForDivsorP12)                            ;
    wire For1000QP1 = (SelectDivisior1000 &  ForDivsorP4  & ~ForDivsorP12)            ;
    wire For1000Q00 = (SelectDivisior1000 & ~ForDivsorP4  &  ForDivsorN4)             ;
    wire For1000QN1 = (SelectDivisior1000 & ~ForDivsorN4  &  ForDivsorN13)            ;
    wire For1000QN2 = (SelectDivisior1000 & ~ForDivsorN13)                            ;

    wire For1001QP2 = (SelectDivisior1001 &  ForDivsorP14)                            ;
    wire For1001QP1 = (SelectDivisior1001 &  ForDivsorP4  & ~ForDivsorP14)            ;
    wire For1001Q00 = (SelectDivisior1001 & ~ForDivsorP4  &  ForDivsorN6)             ;
    wire For1001QN1 = (SelectDivisior1001 & ~ForDivsorN6  &  ForDivsorN15)            ;
    wire For1001QN2 = (SelectDivisior1001 & ~ForDivsorN15 )                           ;

    wire For1010QP2 = (SelectDivisior1010 &  ForDivsorP15)                            ;
    wire For1010QP1 = (SelectDivisior1010 & ~ForDivsorP15 &  ForDivsorP4)             ;
    wire For1010Q00 = (SelectDivisior1010 & ~ForDivsorP4  &  ForDivsorN6)             ;
    wire For1010QN1 = (SelectDivisior1010 & ~ForDivsorN6  &  ForDivsorN16)            ;
    wire For1010QN2 = (SelectDivisior1010 & ~ForDivsorN16)                            ;

    wire For1011QP2 = (SelectDivisior1011 &  ForDivsorP16)                            ;
    wire For1011QP1 = (SelectDivisior1011 & ~ForDivsorP16 &  ForDivsorP4)             ;
    wire For1011Q00 = (SelectDivisior1011 & ~ForDivsorP4  &  ForDivsorN6)             ;
    wire For1011QN1 = (SelectDivisior1011 & ~ForDivsorN6  &  ForDivsorN18)            ;
    wire For1011QN2 = (SelectDivisior1011 & ~ForDivsorN18)                            ;

    wire For1100QP2 = (SelectDivisior1100 &  ForDivsorP18)                            ;
    wire For1100QP1 = (SelectDivisior1100 & ~ForDivsorP18 & ForDivsorP6)              ;
    wire For1100Q00 = (SelectDivisior1100 & ~ForDivsorP6  & ForDivsorN8)              ;
    wire For1100QN1 = (SelectDivisior1100 & ~ForDivsorN8  & ForDivsorN20)             ;
    wire For1100QN2 = (SelectDivisior1100 & ~ForDivsorN20)                            ;

    wire For1101QP2 = (SelectDivisior1101 &  ForDivsorP20)                            ;
    wire For1101QP1 = (SelectDivisior1101 & ~ForDivsorP20 & ForDivsorP6)              ;
    wire For1101Q00 = (SelectDivisior1101 & ~ForDivsorP6  & ForDivsorN8)              ;
    wire For1101QN1 = (SelectDivisior1101 & ~ForDivsorN8  & ForDivsorN20)             ;
    wire For1101QN2 = (SelectDivisior1101 & ~ForDivsorN20)                            ;

    wire For1110QP2 = (SelectDivisior1110 &  ForDivsorP20)                            ;
    wire For1110QP1 = (SelectDivisior1110 & ~ForDivsorP20 & ForDivsorP8)              ;
    wire For1110Q00 = (SelectDivisior1110 & ~ForDivsorP8  & ForDivsorN8)              ;
    wire For1110QN1 = (SelectDivisior1110 & ~ForDivsorN8  & ForDivsorN22)             ;
    wire For1110QN2 = (SelectDivisior1110 & ~ForDivsorN22)                            ;

    wire For1111QP2 = (SelectDivisior1111 &  ForDivsorP24)                            ;  
    wire For1111QP1 = (SelectDivisior1111 & ~ForDivsorP24 & ForDivsorP8)              ;
    wire For1111Q00 = (SelectDivisior1111 & ~ForDivsorP8  & ForDivsorN8)              ;
    wire For1111QN1 = (SelectDivisior1111 & ~ForDivsorN8  & ForDivsorN24)             ;
    wire For1111QN2 = (SelectDivisior1111 & ~ForDivsorN24)                            ;

    wire Positive2  = For1000QP2 | For1001QP2 | For1010QP2 | For1011QP2 | For1100QP2 | For1101QP2 | For1110QP2 | For1111QP2 ;
    wire Positive1  = For1000QP1 | For1001QP1 | For1010QP1 | For1011QP1 | For1100QP1 | For1101QP1 | For1110QP1 | For1111QP1 ;
    wire Zero       = For1000Q00 | For1001Q00 | For1010Q00 | For1011Q00 | For1100Q00 | For1101Q00 | For1110Q00 | For1111Q00 ;
    wire Negitive1  = For1000QN1 | For1001QN1 | For1010QN1 | For1011QN1 | For1100QN1 | For1101QN1 | For1110QN1 | For1111QN1 ;
    wire Negitive2  = For1000QN2 | For1001QN2 | For1010QN2 | For1011QN2 | For1100QN2 | For1101QN2 | For1110QN2 | For1111QN2 ;

    assign Quotient = Positive2 ? `PosiQuit2 :
                      Positive1 ? `PosiQuit1 :
                      Zero      ? `ZeroQuit0 :
                      Negitive1 ? `NegiQuit1 :
                      Negitive2 ? `NegiQuit2 : 3'b111 ;
endmodule

module OneFlyConversion (
    input        wire                                        Clk           ,
    input        wire                                        Rest          ,

    input        wire                                        OfcStop       ,
    input        wire                                        OfcFlash      ,
  
    input        wire      [2:0]                             SelectQuite   ,
    input        wire                                        FlyConverStart,
    output       wire      [`DataBus]                        QuotientData 
);

    reg  [`DataBus] QuotiRegPreSub  ;
    reg  [`DataBus] QuotiReg        ;


    always @(posedge Clk) begin
        if(!Rest)begin
            QuotiRegPreSub <= `ZeorDate ;
            QuotiReg       <= `ZeorDate ;
        end 
        else if(OfcStop) begin
            QuotiRegPreSub <= QuotiRegPreSub ;
            QuotiReg       <= QuotiReg       ;
        end
        else if(OfcFlash) begin
            QuotiRegPreSub <= `ZeorDate ;
            QuotiReg       <= `ZeorDate ;
        end
        else begin
            if(FlyConverStart) begin
                case (SelectQuite)
                    `PosiQuit2: begin QuotiRegPreSub <= {QuotiReg[29:0],2'b01}      ; QuotiReg <= {QuotiReg[29:0],2'b10}      ; end 
                    `PosiQuit1: begin QuotiRegPreSub <= {QuotiReg[29:0],2'b00}      ; QuotiReg <= {QuotiReg[29:0],2'b01}      ; end 
                    `ZeroQuit0: begin QuotiRegPreSub <= {QuotiRegPreSub[29:0],2'b11}; QuotiReg <= {QuotiReg[29:0],2'b00}      ; end 
                    `NegiQuit1: begin QuotiRegPreSub <= {QuotiRegPreSub[29:0],2'b10}; QuotiReg <= {QuotiRegPreSub[29:0],2'b11}; end 
                    `NegiQuit2: begin QuotiRegPreSub <= {QuotiRegPreSub[29:0],2'b01}; QuotiReg <= {QuotiRegPreSub[29:0],2'b10}; end 
                    default   : begin QuotiRegPreSub <= `ZeorDate                   ; QuotiReg <= `ZeorDate                   ; end
                endcase
            end 
            else begin 
                QuotiRegPreSub <= `ZeorDate ;
                QuotiReg       <= `ZeorDate ;
            end 
        end 
    end

    assign QuotientData = QuotiReg ;
    
endmodule
`timescale 1ps/1ps
`include "../define.v"

module LoadBuffer (
    input         wire                                 Clk              ,
    input         wire                                 Rest             ,

    input         wire                                 LbStop           ,
    input         wire                                 LbFlash          ,
    output        wire                                 LsStopReq        ,

    //from store buffer
    input         wire                                 SbEmpty          ,
    input         wire                                 CleanLLSC        ,
    //to store buffer
    output        wire      [34:0]                     LoadEnty1        ,
    output        wire      [34:0]                     LoadEnty2        ,
    output        wire      [34:0]                     LoadEnty3        ,
    output        wire      [34:0]                     LoadEnty4        ,
    output        wire      [34:0]                     LoadEnty5        ,
    output        wire      [34:0]                     LoadEnty6        ,
    output        wire      [34:0]                     LoadEnty7        ,
    output        wire      [`InstAddrBus]             LLSCAddr         ,
    //from AGUload
    input         wire                                 InLBAble         ,
    input         wire      [`MicOperateCode]          InLBMicOp        ,
    input         wire      [1:0]                      InLBMAT          ,   
    input         wire      [`InstAddrBus]             InLBPAddr        ,
    input         wire                                 InLBTrap         ,
    input         wire      [6:0]                      InLBTrapCode     ,
    input         wire                                 InLBWbAble       ,
    input         wire      [`ReNameRegBUs]            InLBWbAddr       ,
    input         wire      [5:0]                      InLBRobPtr       ,
    //to phy 
    output        wire                                 LoadWPhyAble     ,
    output        wire      [`ReNameRegBUs]            LoadWPhyAddr     ,
    output        wire      [`DataBus]                 LoadWPhyDate     ,
    //to Rob
    output        wire                                 CommitLAble      ,
    output        wire      [5:0]                      CommitLRobPtr    ,
    output        wire                                 CommitLTrap      ,
    output        wire      [6:0]                      CommitLTrapCode  ,
    output        wire      [2:0]                      CommitLBPtr      ,
    //from Rob
    input         wire                                 RetirLAble1      ,
    input         wire      [2:0]                      ReTirLPtr1       ,
    input         wire                                 RetirLAble2      ,
    input         wire      [2:0]                      ReTirLPtr2       ,
    input         wire                                 RetirLAble3      ,
    input         wire      [2:0]                      ReTirLPtr3       ,
    input         wire                                 RetirLAble4      ,
    input         wire      [2:0]                      ReTirLPtr4       ,
    //to Dcache
    output        wire                                 LbToDcdAble      ,
    output        wire     [1:0]                       LbToDcdAMat      ,
    output        wire     [2:0]                       LbToDcdAPtr      ,
    input         wire                                 DcdToLbSuccess   ,
    output        wire     [`InstAddrBus]              LbToDcdAPhyAddr  ,
    input         wire                                 DcdToLbBackAble  ,
    input         wire     [2:0]                       DcdToLbBackPtr   ,
    input         wire     [`DataBus]                  DcdToLbBackDate  
); 
    localparam WRITE   = 3'd1 ;
    localparam WEITCOM = 3'd3 ;

    reg    [69:0]  LOADBUFFER [1:7] ;

    assign LoadEnty1 = {LOADBUFFER[1][68:66], LOADBUFFER[1][54:23]}  ;
    assign LoadEnty2 = {LOADBUFFER[2][68:66], LOADBUFFER[2][54:23]}  ;
    assign LoadEnty3 = {LOADBUFFER[3][68:66], LOADBUFFER[3][54:23]}  ;
    assign LoadEnty4 = {LOADBUFFER[4][68:66], LOADBUFFER[4][54:23]}  ;
    assign LoadEnty5 = {LOADBUFFER[5][68:66], LOADBUFFER[5][54:23]}  ;
    assign LoadEnty6 = {LOADBUFFER[6][68:66], LOADBUFFER[6][54:23]}  ;
    assign LoadEnty7 = {LOADBUFFER[7][68:66], LOADBUFFER[7][54:23]}  ;

    wire [2:0]  IndexLB = LOADBUFFER[1][69] ? 3'd1 :
                          LOADBUFFER[2][69] ? 3'd2 : 
                          LOADBUFFER[3][69] ? 3'd3 : 
                          LOADBUFFER[4][69] ? 3'd4 : 
                          LOADBUFFER[5][69] ? 3'd5 : 
                          LOADBUFFER[6][69] ? 3'd6 : 
                          LOADBUFFER[7][69] ? 3'd7 : 3'd0 ;

    wire [2:0]  IndexToSuc = (LOADBUFFER[7][68:66] == WRITE) ? 3'd7 : 
                             (LOADBUFFER[6][68:66] == WRITE) ? 3'd6 : 
                             (LOADBUFFER[5][68:66] == WRITE) ? 3'd5 : 
                             (LOADBUFFER[4][68:66] == WRITE) ? 3'd4 : 
                             (LOADBUFFER[3][68:66] == WRITE) ? 3'd3 : 
                             (LOADBUFFER[2][68:66] == WRITE) ? 3'd2 : 
                             (LOADBUFFER[1][68:66] == WRITE) ? 3'd1 : 3'd0 ;

    reg          IorDBarStop ;

    wire         LoadBufferEmpty = ~LOADBUFFER[1][69] & 
                                   ~LOADBUFFER[2][69] & 
                                   ~LOADBUFFER[3][69] & 
                                   ~LOADBUFFER[4][69] & 
                                   ~LOADBUFFER[5][69] & 
                                   ~LOADBUFFER[6][69] & 
                                   ~LOADBUFFER[7][69] ;
    wire         LoadBufferFull  = LOADBUFFER[1][69] & 
                                   LOADBUFFER[2][69] & 
                                   LOADBUFFER[3][69] & 
                                   LOADBUFFER[4][69] & 
                                   LOADBUFFER[5][69] & 
                                   LOADBUFFER[6][69] & 
                                   LOADBUFFER[7][69] ;

    always @(posedge Clk) begin
        if(!Rest) begin
            IorDBarStop <= 1'b0 ;
        end
        else if(LbStop) begin
            IorDBarStop <= IorDBarStop ;
        end
        else if(LbFlash) begin
            IorDBarStop <= 1'b0 ;
        end
        else begin
            if((InLBAble) & ((InLBMicOp == `InstIbar) | (InLBMicOp == `InstDbar))) begin
                IorDBarStop <= 1'b1 ;
            end
            if(LoadBufferEmpty & SbEmpty)begin
                IorDBarStop <= 1'b0 ;
            end
        end
    end

    assign LsStopReq = IorDBarStop | ((InLBMicOp == `InstIbar) | (InLBMicOp == `InstDbar)) | LoadBufferFull ;

    always @(posedge Clk) begin
        if(!Rest) begin
            LOADBUFFER[1] <= 70'd0 ;
            LOADBUFFER[2] <= 70'd0 ;
            LOADBUFFER[3] <= 70'd0 ;
            LOADBUFFER[4] <= 70'd0 ;
            LOADBUFFER[5] <= 70'd0 ;
            LOADBUFFER[6] <= 70'd0 ;
            LOADBUFFER[7] <= 70'd0 ;
        end
        else if(LbStop) begin
            LOADBUFFER[1] <= LOADBUFFER[1] ;
            LOADBUFFER[2] <= LOADBUFFER[2] ;
            LOADBUFFER[3] <= LOADBUFFER[3] ;
            LOADBUFFER[4] <= LOADBUFFER[4] ;
            LOADBUFFER[5] <= LOADBUFFER[5] ;
            LOADBUFFER[6] <= LOADBUFFER[6] ;
            LOADBUFFER[7] <= LOADBUFFER[7] ;
        end
        else if(LbFlash) begin
            LOADBUFFER[1] <= 70'd0 ;
            LOADBUFFER[2] <= 70'd0 ;
            LOADBUFFER[3] <= 70'd0 ;
            LOADBUFFER[4] <= 70'd0 ;
            LOADBUFFER[5] <= 70'd0 ;
            LOADBUFFER[6] <= 70'd0 ;
            LOADBUFFER[7] <= 70'd0 ;
        end
        else begin
            if(InLBAble & ~((InLBMicOp == `InstIbar) | (InLBMicOp == `InstDbar)))
                LOADBUFFER[IndexLB] <= {`AbleValue,WRITE,1'b0,InLBMicOp,InLBMAT,InLBPAddr,InLBTrap,InLBTrapCode,InLBWbAble,1'b0,InLBWbAddr,InLBRobPtr} ;
            if(DcdToLbSuccess)
                LOADBUFFER[IndexToSuc] <= {`AbleValue,WEITCOM,LOADBUFFER[IndexToSuc][65:0]} ;
            if(RetirLAble1) 
                LOADBUFFER[ReTirLPtr1] <= 70'd0 ; 
            if(RetirLAble2) 
                LOADBUFFER[ReTirLPtr2] <= 70'd0 ;
            if(RetirLAble3) 
                LOADBUFFER[ReTirLPtr3] <= 70'd0 ;
            if(RetirLAble4) 
                LOADBUFFER[ReTirLPtr4] <= 70'd0 ;
        end
    end

    assign LoadWPhyAble = DcdToLbBackAble & LOADBUFFER[DcdToLbBackPtr][14] ;
    assign LoadWPhyAddr = {7{DcdToLbBackAble}} & LOADBUFFER[DcdToLbBackPtr][12:6] ;
    assign LoadWPhyDate = {32{DcdToLbBackAble}} & DcdToLbBackDate ;

    assign LbToDcdAble = (IndexToSuc != 0) & LOADBUFFER[IndexToSuc][69]    ;
    assign LbToDcdAMat = {2{(IndexToSuc != 0)}} & LOADBUFFER[IndexToSuc][56:55] ;
    assign LbToDcdAPtr = {3{(IndexToSuc != 0)}} & IndexToSuc ;
    assign LbToDcdAPhyAddr = {32{(IndexToSuc != 0)}} & LOADBUFFER[IndexToSuc][54:23] ;

    assign CommitLAble   = DcdToLbBackAble ;
    assign CommitLRobPtr = LOADBUFFER[DcdToLbBackPtr][5:0] ;
    assign CommitLTrap   = LOADBUFFER[DcdToLbBackPtr][22]  ;
    assign CommitLTrapCode = LOADBUFFER[DcdToLbBackPtr][21:15] ;
    assign CommitLBPtr   = DcdToLbBackPtr  ;

    reg   [`InstAddrBus]   LLSCTemp ;
    always @(posedge Clk) begin
        if(!Rest) begin
            LLSCTemp <= 32'd0    ;
        end
        else if(LbStop) begin
            LLSCTemp <= LLSCTemp ;
        end
        else if(LbFlash) begin
            LLSCTemp <= 32'd0    ;
        end
        else begin
            if(RetirLAble1 & LOADBUFFER[ReTirLPtr1][64:57] == `InstLlw) begin
                LLSCTemp <= LOADBUFFER[ReTirLPtr1][54:23] ;
            end
            if(RetirLAble2 & LOADBUFFER[ReTirLPtr2][64:57] == `InstLlw) begin
                LLSCTemp <= LOADBUFFER[ReTirLPtr2][54:23] ;
            end
            if(RetirLAble3 & LOADBUFFER[ReTirLPtr3][64:57] == `InstLlw) begin
                LLSCTemp <= LOADBUFFER[ReTirLPtr3][54:23] ;
            end
            if(RetirLAble4 & LOADBUFFER[ReTirLPtr4][64:57] == `InstLlw) begin
                LLSCTemp <= LOADBUFFER[ReTirLPtr4][54:23] ;
            end
            if(CleanLLSC) begin
                LLSCTemp <= 32'd0    ;
            end
        end 
    end

    assign LLSCAddr = LLSCTemp ;

endmodule
 
`timescale 1ps/1ps
`include "../define.v"`timescale 1ps/1ps
//`include "IPsetting.v"

module IcacheFIFO #(
    parameter FIFOWIDE = 68
) (
    input         wire                            Clk           ,
    input         wire                            Rest          ,

    input         wire                            Rable         ,

    output        wire       [FIFOWIDE-1:0]       FifoPreOut    ,
    output        wire       [2:0]                FifoPrePtr    ,

    input         wire                            Wable         ,
    input         wire       [FIFOWIDE-1:0]       Din           ,

    input         wire                            StateWAble    ,
    input         wire       [2:0]                StatePtr      ,
    input         wire       [1:0]                StateDate     ,

    input         wire                            FifoClean     ,
    output        wire                            FifoEmpty     ,
    output        wire                            FifoFull  
);

    reg  [FIFOWIDE-1:0] FIFOREG [0:7] ;
    reg   [2:0]     Fifofront          ;
    reg   [2:0]     Fifotril           ;

    integer i ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Fifofront <= 3'd0 ;
            for (i =0 ;i < 8 ;i = i + 1 ) begin
                FIFOREG[i] <= {FIFOWIDE{1'b0}};
            end
        end
        else begin
            FIFOREG[StatePtr][3:2] <= StateWAble ? StateDate : FIFOREG[StatePtr][3:2] ;
            if(Wable) begin
              Fifofront <=(Fifofront == 7) ? 0 : Fifofront + 1 ;
              FIFOREG[Fifofront] <= Din ;
            end 
            if(FifoClean)
              Fifofront <= 0 ;
        end
    end

    //reg  [FIFOWIDE-1:0]  FifoOutReg  ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Fifotril <= 3'd0 ;
            //FifoOutReg <= {FIFOWIDE{1'b0}};
        end 
        else begin
            if(Rable) begin
                //FifoOutReg <= FIFOREG[Fifotril] ;
                Fifotril <= (Fifotril == 7) ? 0 : Fifotril+1 ;
            end
            if(FifoClean)
                Fifotril <= 0 ;
        end
    end

    //assign Dout = FifoOutReg ;
    assign FifoFull = (((Fifotril - Fifofront) == 1) || ((Fifotril == 0) && (Fifofront == 7))) ;
    assign FifoEmpty = (Fifotril == Fifofront) ;
    assign FifoPreOut = FIFOREG[Fifotril] ;
    assign FifoPrePtr = Fifotril ;
    

    
endmodule 
`timescale 1ps/1ps
`include "../define.v"
`include "../../IP/date_64x512.xcix"
`include "../../IP/tag_64x512.xcix"


module ICacheStage1 (
    input        wire                                     Clk           ,
    input        wire                                     Rest          ,
    //from ictrl
    input        wire                                     IcacheStop    ,
    input        wire                                     IcacheFlash   ,
    //from Pc 
    input        wire                                     FetchAble     ,
    input        wire       [`InstAddrBus]                FetchPc       ,
    //to stage 2 
    output       wire                                     ToStage2Able  ,
    output       wire       [`InstAddrBus]                ToStage2Pc    ,
   // output       wire       [5:0]                         To2Offset     ,
    output       wire       [511:0]                       To2Way1Date   ,
    output       wire       [19:0]                        To2Way1Tag    ,
    output       wire       [511:0]                       To2Way2Date   ,
    output       wire       [19:0]                        To2Way2Tag    ,
    output       wire       [511:0]                       To2Way3Date   ,
    output       wire       [19:0]                        To2Way3Tag    ,
    output       wire       [511:0]                       To2Way4Date   ,
    output       wire       [19:0]                        To2Way4Tag    ,
    // update when hit
    input        wire                                     InHitAble     ,
    input        wire       [5:0]                         InHitIndex    ,
    input        wire                                     InHitWay1     ,
    input        wire                                     InHitWay2     ,
    input        wire                                     InHitWay3     ,
    input        wire                                     InHitWay4     ,
    //from MSHR up when miss
    input        wire                                     InNewAble     ,
    input        wire       [5:0]                         InNewIndex    ,
    input        wire       [19:0]                        InNewTag      ,
    input        wire       [511:0]                       InNewDate     

);
    reg           StopTemp  ;
    reg           FLashTemp ;
    always @(posedge Clk) begin
        if(!Rest) begin
            StopTemp  <= 1'b0 ;
            FLashTemp <= 1'b0 ;
        end
        else begin
            StopTemp  <= IcacheStop  ;
            FLashTemp <= IcacheFlash ;
        end
    end

    reg   [2:0]  CountWay1 [0:63] ;
    reg   [2:0]  CountWay2 [0:63] ;
    reg   [2:0]  CountWay3 [0:63] ;
    reg   [2:0]  CountWay4 [0:63] ;

    integer i ;
    always @(posedge Clk) begin
        if(!Rest) begin
            for (i =0 ;i<32 ;i=i+1 ) begin
                CountWay1[i]    <= 3'd0 ;
                CountWay1[i+32] <= 3'd0 ;
                CountWay2[i]    <= 3'd0 ;
                CountWay2[i+32] <= 3'd0 ;
                CountWay3[i]    <= 3'd0 ;
                CountWay3[i+32] <= 3'd0 ;
                CountWay4[i]    <= 3'd0 ;
                CountWay4[i+32] <= 3'd0 ;
            end
        end
        else begin
            if(InHitAble & ~IcacheStop) begin
                if(InHitWay1) begin
                    CountWay1[InHitIndex] <= 3'd0 ;
                    CountWay2[InHitIndex] <= (CountWay2[InHitIndex] != 3'b111) ? CountWay2[InHitIndex] + 1 : CountWay2[InHitIndex] ;
                    CountWay3[InHitIndex] <= (CountWay3[InHitIndex] != 3'b111) ? CountWay3[InHitIndex] + 1 : CountWay3[InHitIndex] ;
                    CountWay4[InHitIndex] <= (CountWay4[InHitIndex] != 3'b111) ? CountWay4[InHitIndex] + 1 : CountWay4[InHitIndex] ;
                end 
                if(InHitWay2) begin
                    CountWay1[InHitIndex] <= (CountWay1[InHitIndex] != 3'b111) ? CountWay1[InHitIndex] + 1 : CountWay1[InHitIndex] ;
                    CountWay2[InHitIndex] <= 3'd0 ;
                    CountWay3[InHitIndex] <= (CountWay3[InHitIndex] != 3'b111) ? CountWay3[InHitIndex] + 1 : CountWay3[InHitIndex] ;
                    CountWay4[InHitIndex] <= (CountWay4[InHitIndex] != 3'b111) ? CountWay4[InHitIndex] + 1 : CountWay4[InHitIndex] ;
                end 
                if(InHitWay3) begin
                    CountWay1[InHitIndex] <= (CountWay1[InHitIndex] != 3'b111) ? CountWay1[InHitIndex] + 1 : CountWay1[InHitIndex] ;
                    CountWay2[InHitIndex] <= (CountWay2[InHitIndex] != 3'b111) ? CountWay2[InHitIndex] + 1 : CountWay2[InHitIndex] ;
                    CountWay3[InHitIndex] <= 3'd0 ;
                    CountWay4[InHitIndex] <= (CountWay4[InHitIndex] != 3'b111) ? CountWay4[InHitIndex] + 1 : CountWay4[InHitIndex] ;
                end 
                if(InHitWay4) begin
                    CountWay1[InHitIndex] <= (CountWay1[InHitIndex] != 3'b111) ? CountWay1[InHitIndex] + 1 : CountWay1[InHitIndex] ;
                    CountWay2[InHitIndex] <= (CountWay2[InHitIndex] != 3'b111) ? CountWay2[InHitIndex] + 1 : CountWay2[InHitIndex] ;
                    CountWay3[InHitIndex] <= (CountWay3[InHitIndex] != 3'b111) ? CountWay3[InHitIndex] + 1 : CountWay3[InHitIndex] ;
                    CountWay4[InHitIndex] <= 3'd0 ;
                end 
            end
            else begin
                CountWay1[InHitIndex] <= CountWay1[InHitIndex] ;
                CountWay2[InHitIndex] <= CountWay2[InHitIndex] ;
                CountWay3[InHitIndex] <= CountWay3[InHitIndex] ;
                CountWay4[InHitIndex] <= CountWay4[InHitIndex] ;
            end
        end
    end

    wire  [5:0]          VritualPcOffset = FetchPc[5:0]  ;
    reg   [5:0]          RVritualOffset  ;
    reg   [`InstAddrBus] RVritualPc ;
    reg                  RegFetchAble    ;

    always @(posedge Clk) begin
        if(!Rest)
            {RegFetchAble,RVritualOffset,RVritualPc} <= 39'b0 ;  
        else if(IcacheStop) 
            {RegFetchAble,RVritualOffset,RVritualPc} <= {RegFetchAble,RVritualOffset,RVritualPc} ;
        else if(IcacheFlash)
            {RegFetchAble,RVritualOffset,RVritualPc} <= 39'b0 ;
        else 
            {RegFetchAble,RVritualOffset,RVritualPc} <= {FetchAble,VritualPcOffset,FetchPc} ;
    end

    wire  [5:0]  VritualPcIndex  = FetchPc[11:6] ;

    wire         Way1Able = `AbleValue ;
    wire  [5:0]  Way1Index= InNewAble ? InNewIndex         : 
                            FetchAble ? VritualPcOffset    : 6'd0 ;
    wire         Way1Wen  = InNewAble & (((CountWay1[InNewIndex] > CountWay2[InNewIndex]) & (CountWay1[InNewIndex] > CountWay3[InNewIndex]) & 
                                          (CountWay1[InNewIndex] > CountWay4[InNewIndex])) ) & ~StopTemp;
    wire  [19:0] Way1Tag  = InNewTag  ;
    wire  [511:0]Way1Date = InNewDate ;
    wire  [19:0] OutWay1Tag   ;
    wire  [511:0]OutWay1Date  ;

    date_64x512 way1_date_64x512(
    .clka  ( Clk         ),
    .ena   ( Way1Able    ),
    .wea   ( Way1Wen     ),
    .addra ( Way1Index   ),
    .dina  ( Way1Date    ),
    .douta ( OutWay1Date )
    ); 

    tag_64x512 way1_tag_64x512(
    .clka  ( Clk         ),
    .ena   ( Way1Able    ),
    .wea   ( Way1Wen     ),
    .addra ( Way1Index   ),
    .dina  ( Way1Tag     ),
    .douta ( OutWay1Tag  )
    ); 

    wire         Way2Able = `AbleValue ;
    wire  [5:0]  Way2Index= InNewAble ? InNewIndex         : 
                            FetchAble ? VritualPcOffset    : 6'd0 ;
    wire         Way2Wen  = InNewAble & (((CountWay2[InNewIndex] > CountWay1[InNewIndex]) & (CountWay2[InNewIndex] > CountWay3[InNewIndex]) & 
                                          (CountWay2[InNewIndex] > CountWay4[InNewIndex])) )& ~StopTemp;
    wire  [19:0] Way2Tag  = InNewTag  ;
    wire  [511:0]Way2Date = InNewDate ;

    wire  [19:0] OutWay2Tag   ;
    wire  [511:0]OutWay2Date  ;

    date_64x512 way2_date_64x512(
    .clka  ( Clk         ),
    .ena   ( Way2Able    ),
    .wea   ( Way2Wen     ),
    .addra ( Way2Index   ),
    .dina  ( Way2Date    ),
    .douta ( OutWay2Date )
    ); 

    tag_64x512 way2_tag_64x512(
    .clka  ( Clk         ),
    .ena   ( Way2Able    ),
    .wea   ( Way2Wen     ),
    .addra ( Way2Index   ),
    .dina  ( Way2Tag     ),
    .douta ( OutWay2Tag  )
    ); 

    wire         Way3Able = `AbleValue ;
    wire  [5:0]  Way3Index= InNewAble ? InNewIndex         : 
                            FetchAble ? VritualPcOffset    : 6'd0 ;
    wire         Way3Wen  = InNewAble & (((CountWay3[InNewIndex] > CountWay1[InNewIndex]) & (CountWay3[InNewIndex] > CountWay2[InNewIndex]) & 
                                          (CountWay3[InNewIndex] > CountWay4[InNewIndex])) )& ~StopTemp;
    wire  [19:0] Way3Tag  = InNewTag  ;
    wire  [511:0]Way3Date = InNewDate ;

    wire  [19:0] OutWay3Tag   ;
    wire  [511:0]OutWay3Date  ;

    date_64x512 way3_date_64x512(
    .clka  ( Clk         ),
    .ena   ( Way3Able    ),
    .wea   ( Way3Wen     ),
    .addra ( Way3Index   ),
    .dina  ( Way3Date    ),
    .douta ( OutWay3Date )
    ); 

    tag_64x512 way3_tag_64x512(
    .clka  ( Clk         ),
    .ena   ( Way3Able    ),
    .wea   ( Way3Wen     ),
    .addra ( Way3Index   ),
    .dina  ( Way3Tag     ),
    .douta ( OutWay3Tag  )
    ); 

    wire         Way4Able = `AbleValue ;
    wire  [5:0]  Way4Index= InNewAble ? InNewIndex         : 
                            FetchAble ? VritualPcOffset    : 6'd0 ;
    wire         Way4Wen  = InNewAble & (((CountWay3[InNewIndex] > CountWay1[InNewIndex]) & (CountWay3[InNewIndex] > CountWay2[InNewIndex]) & 
                                          (CountWay3[InNewIndex] > CountWay4[InNewIndex])) )& ~StopTemp;
    wire  [19:0] Way4Tag  = InNewTag  ;
    wire  [511:0]Way4Date = InNewDate ;

    wire  [19:0] OutWay4Tag   ;
    wire  [511:0]OutWay4Date  ;

    date_64x512 way4_date_64x512(
    .clka  ( Clk         ),
    .ena   ( Way4Able    ),
    .wea   ( Way4Wen     ),
    .addra ( Way4Index   ),
    .dina  ( Way4Date    ),
    .douta ( OutWay4Date )
    ); 

    tag_64x512 way4_tag_64x512(
    .clka  ( Clk         ),
    .ena   ( Way4Able    ),
    .wea   ( Way4Wen     ),
    .addra ( Way4Index   ),
    .dina  ( Way4Tag     ),
    .douta ( OutWay4Tag  )
    ); 


    assign ToStage2Able = ~FLashTemp ?  RegFetchAble: 1'b0   ;
    assign ToStage2Pc   = ~FLashTemp ?  RVritualPc  : 32'b0  ;
    assign To2Way1Date  = ~FLashTemp ?  OutWay1Date : 512'b0 ;
    assign To2Way1Tag   = ~FLashTemp ?  OutWay1Tag  : 20'b0  ;
    assign To2Way2Date  = ~FLashTemp ?  OutWay2Date : 512'b0 ;
    assign To2Way2Tag   = ~FLashTemp ?  OutWay2Tag  : 20'b0  ;
    assign To2Way3Date  = ~FLashTemp ?  OutWay3Date : 512'b0 ;
    assign To2Way3Tag   = ~FLashTemp ?  OutWay3Tag  : 20'b0  ;
    assign To2Way4Date  = ~FLashTemp ?  OutWay4Date : 512'b0 ;
    assign To2Way4Tag   = ~FLashTemp ?  OutWay4Tag  : 20'b0  ;

endmodule
`timescale 1ps/1ps
`include "../define.v"

module ICacheStage2 (
    input       wire                                     Clk           ,
    input       wire                                     Rest          ,
    //for cache ctrl
    input       wire                                     ICacheFlash   ,
    output      wire                                     ICacheReq     , //stop cache and pc
    //to ctrl 
    output      wire                                     IcacheSFreq   , //stop fetech amd wwerit trap  
    //from MMU 
    input       wire       [1:0]                         InOperType    ,
    input       wire                                     InTlbTrap     ,
    input       wire       [`InstAddrBus]                InPhysicalAddr,         
    //from stage1 
    input       wire                                     InStage1Able  ,  
    input       wire       [`InstAddrBus]                InStage1Pc    ,
    input       wire       [511:0]                       In1Way1Date   ,
    input       wire       [19:0]                        In1Way1Tag    ,
    input       wire       [511:0]                       In1Way2Date   ,
    input       wire       [19:0]                        In1Way2Tag    ,
    input       wire       [511:0]                       In1Way3Date   ,
    input       wire       [19:0]                        In1Way3Tag    ,
    input       wire       [511:0]                       In1Way4Date   ,
    input       wire       [19:0]                        In1Way4Tag    ,  
    //to stage1 
    output      wire                                     OutHitAble    ,
    output      wire       [5:0]                         OutHitIndex   ,
    output      wire                                     OutHitWay1    ,
    output      wire                                     OutHitWay2    ,
    output      wire                                     OutHitWay3    ,
    output      wire                                     OutHitWay4    ,
    output      wire                                     OutNewAble    ,
    output      wire       [5:0]                         OutNewIndex   ,
    output      wire       [19:0]                        OutNewTag     ,
    output      wire       [511:0]                       OutNewDate    ,
    //for axi
    output      wire                                     IcaReadAble   ,
    input       wire                                     IRshankhand   ,
    output      wire                                     IUncacheRead  ,
    output      wire       [`InstAddrBus]                IcaReadAddr   ,
    input       wire                                     CacReadreq    ,
    input       wire                                     ReadBackAble  ,
    input       wire       [511:0]                       ReadBackDate  ,
    //to PreDecode 
    output      wire                                     OutPreAble    ,
    output      wire       [255:0]                       OutPcIvt      ,
    output      wire       [7:0]                         OutInstIvt    ,
    output      wire       [255:0]                       OutDate 
);
    
    assign IcacheSFreq = InTlbTrap ;

    //hit check
    wire [19:0] PhysicalTag = InPhysicalAddr[31:12] ;
    
    wire  HitWay1 = (PhysicalTag == In1Way1Tag) ;
    wire  HitWay2 = (PhysicalTag == In1Way2Tag) ;
    wire  HitWay3 = (PhysicalTag == In1Way3Tag) ;
    wire  HitWay4 = (PhysicalTag == In1Way4Tag) ;

    wire         WayHitAble ;
    wire [3:0]   WayHutNum  ;
    wire [511:0] WayHitDate ;
    assign {WayHutNum,WayHitAble,WayHitDate}  = ((~HitWay1 & ~HitWay2 & ~HitWay3 & HitWay4) & InOperType != 2'b00) ? {4'b1000,`AbleValue,In1Way1Date} : 
                                                ((~HitWay1 & ~HitWay2 & HitWay3 & ~HitWay4) & InOperType != 2'b00) ? {4'b0100,`AbleValue,In1Way2Date} : 
                                                ((~HitWay1 & HitWay2 & ~HitWay3 & ~HitWay4) & InOperType != 2'b00) ? {4'b0010,`AbleValue,In1Way3Date} : 
                                                ((HitWay1 & ~HitWay2 & ~HitWay3 & ~HitWay4) & InOperType != 2'b00) ? {4'b0001,`AbleValue,In1Way4Date} : {4'b0000,`EnableValue, 512'd0} ;

    // reg          WayHitAble ;
    // reg [3:0]    WayHutNum  ;
    // reg [255:0]  WayHitDate ;

    // always @(posedge Clk) begin
    //     if(!Rest) begin
    //         WayHitAble <= `EnableValue ;
    //         WayHutNum <= 4'd0 ;
    //         WayHitDate <= 256'd0 ;
    //     end
    //     else if()
    // end

    // wire [255:0] OutDate = {256{(In1Offset == {4'd0,2'd0})}} & WayHitDate[255:0]  |
    //                        {256{(In1Offset == {4'd1,2'd0})}} & WayHitDate[287:32] |
    //                        {256{(In1Offset == {4'd2,2'd0})}} & WayHitDate[319:64] |
    //                        {256{(In1Offset == {4'd3,2'd0})}} & WayHitDate[351:96] | 
    //                        {256{(In1Offset == {4'd4,2'd0})}} & WayHitDate[383:128] |
    //                        {256{(In1Offset == {4'd5,2'd0})}} & WayHitDate[415:160] |
    //                        {256{(In1Offset == {4'd6,2'd0})}} & WayHitDate[447:192] |
    //                        {256{(In1Offset == {4'd7,2'd0})}} & WayHitDate[479:224] |
    //                        {256{(In1Offset == {4'd8,2'd0})}} & WayHitDate[511:256] |
    //                        {256{(In1Offset == {4'd9,2'd0})}}  & {32'd0,WayHitDate[511:288]} |
    //                        {256{(In1Offset == {4'd10,2'd0})}} & {64'd0,WayHitDate[511:320]} |
    //                        {256{(In1Offset == {4'd11,2'd0})}} & {96'd0,WayHitDate[511:352]} |
    //                        {256{(In1Offset == {4'd12,2'd0})}} & {128'd0,WayHitDate[511:384]} |
    //                        {256{(In1Offset == {4'd13,2'd0})}} & {160'd0,WayHitDate[511:416]} |
    //                        {256{(In1Offset == {4'd14,2'd0})}} & {192'd0,WayHitDate[511:448]} |
    //                        {256{(In1Offset == {4'd15,2'd0})}} & {224'd0,WayHitDate[511:480]} ;

                           
    wire [255:0] OutPcIvtTemp  = {InStage1Pc+28,InStage1Pc+24,InStage1Pc+20,InStage1Pc+16,
                                  InStage1Pc+12,InStage1Pc+8,InStage1Pc+4,InStage1Pc} ;

    assign   OutHitAble  =  WayHitAble             ;
    assign   OutHitIndex =  InStage1Pc[11:6]       ;
    assign   OutHitWay1  =  WayHutNum[0]           ;
    assign   OutHitWay2  =  WayHutNum[1]           ;
    assign   OutHitWay3  =  WayHutNum[2]           ;
    assign   OutHitWay4  =  WayHutNum[3]           ;



    localparam WRITEARB  = 2'b01 ;
    localparam SHANKHAND = 2'b10 ;
 

    wire               WriteAble = ~WayHitAble & InStage1Able ;
    wire   [68:0]      WriteDate = {InStage1Pc,`AbleValue,InPhysicalAddr,WRITEARB,InOperType} ;
    wire   [68:0]      PreDate  ;
    wire   [2:0]       PrePtr   ;
    wire               MSHRRead ;
    wire               MSHREmpty;

    assign MSHRRead = (ReadBackAble & (PreDate[3:2] == SHANKHAND)) ;
    wire   MSHRFIll ;

    IcacheFIFO#(
        .FIFOWIDE    ( 69 )
    )u_IcacheFIFO(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .Rable       ( MSHRRead    ),
        .FifoPreOut  ( PreDate     ),
        .FifoPrePtr  ( PrePtr      ),
        .Wable       ( WriteAble   ),
        .Din         ( WriteDate   ),
        .StateWAble  ( IRshankhand ),
        .StatePtr    ( PrePtr      ),
        .StateDate   ( SHANKHAND   ),
        .FifoClean   ( ICacheFlash ),
        .FifoEmpty   ( MSHREmpty   ),
        .FifoFull    ( MSHRFIll    )
    );

    assign  ICacheReq = MSHRFIll | (WayHitAble & ~MSHREmpty) ;

    assign  IcaReadAble   =  CacReadreq & (PreDate[1:0] == 2'b01) & (PreDate[3:2] == WRITEARB) ;
    assign  IUncacheRead  =  CacReadreq & (PreDate[1:0] == 2'b00) & (PreDate[3:2] == WRITEARB) ;
    assign  IcaReadAddr   =  (CacReadreq & (PreDate[3:2] == WRITEARB)) ? PreDate[35:4] : 32'd0 ;


    assign  OutNewAble    =  ReadBackAble & (PreDate[1:0] == 2'b00) ;
    assign  OutNewIndex   =  PreDate[15:10] ;
    assign  OutNewTag     =  PreDate[35:16] ;
    assign  OutNewDate    =  ReadBackDate   ;


    reg              RegOutPreAble    ;
    reg [255:0]      RegOutPcIvt      ;
    reg [7:0]        RegOutInstIvt    ;
    reg [255:0]      RegOutDate       ;

    wire [511:0] ShiftCDate = (ReadBackDate >> {PreDate[9:6],5'd0}) ;
    wire [511:0] SHiftHDate = (WayHitDate >> {InStage1Pc[5:2],5'd0}) ;

    always @(posedge Clk) begin
        if(!Rest) begin
            RegOutPreAble <= `EnableValue ;
            RegOutPcIvt <= 256'd0 ;
            RegOutInstIvt <= 8'd0 ;
            RegOutDate <= 256'd0  ;
        end
        else if(ICacheFlash)begin
            RegOutPreAble <= `EnableValue ;
            RegOutPcIvt <= 256'd0 ;
            RegOutInstIvt <= 8'd0 ;
            RegOutDate <= 256'd0  ;
        end
        else if(~MSHREmpty) begin
            RegOutPreAble <= (PreDate[3:2] == SHANKHAND) & ReadBackAble ;
            RegOutPcIvt <= {PreDate[68:37]+28,PreDate[68:37]+24,PreDate[68:37]+20,PreDate[68:37]+16,
                            PreDate[68:37]+12,PreDate[68:37]+8,PreDate[68:37]+4,PreDate[68:37]} ;
            RegOutDate <= ShiftCDate[255:0] ;
            RegOutInstIvt <= (PreDate[1:0] == 2'b01) ? ({8{(PreDate[9:6]==4'd0) | 
                                                            (PreDate[9:6]==4'd1) | 
                                                            (PreDate[9:6]==4'd2) | 
                                                            (PreDate[9:6]==4'd3) | 
                                                            (PreDate[9:6]==4'd4) | 
                                                            (PreDate[9:6]==4'd5) | 
                                                            (PreDate[9:6]==4'd6) | 
                                                            (PreDate[9:6]==4'd7) | 
                                                            (PreDate[9:6]==4'd8)}} & 8'b11111111  |
                                                        {8{(PreDate[9:6]==4'd9)}}  & 8'b01111111  |
                                                        {8{(PreDate[9:6]==4'd10)}} & 8'b00111111  |
                                                        {8{(PreDate[9:6]==4'd11)}} & 8'b00011111  |
                                                        {8{(PreDate[9:6]==4'd12)}} & 8'b00001111  |
                                                        {8{(PreDate[9:6]==4'd13)}} & 8'b00000111  |
                                                        {8{(PreDate[9:6]==4'd14)}} & 8'b00000011  |
                                                        {8{(PreDate[9:6]==4'd15)}} & 8'b00000001  ) : 8'b00000001 ;
        end 
        else if(MSHREmpty | WayHitAble) begin
            RegOutPreAble <= `AbleValue ;
            RegOutPcIvt <= OutPcIvtTemp ;
            RegOutDate <= SHiftHDate[255:0] ;
            RegOutInstIvt <= {8{(InStage1Pc[5:2]==4'd0) | 
                                (InStage1Pc[5:2]==4'd1) | 
                                (InStage1Pc[5:2]==4'd2) | 
                                (InStage1Pc[5:2]==4'd3) | 
                                (InStage1Pc[5:2]==4'd4) | 
                                (InStage1Pc[5:2]==4'd5) | 
                                (InStage1Pc[5:2]==4'd6) | 
                                (InStage1Pc[5:2]==4'd7) | 
                                (InStage1Pc[5:2]==4'd8)}} & 8'b11111111  |
                            {8{(InStage1Pc[5:2]==4'd9)}}  & 8'b01111111  |
                            {8{(InStage1Pc[5:2]==4'd10)}} & 8'b00111111  |
                            {8{(InStage1Pc[5:2]==4'd11)}} & 8'b00011111  |
                            {8{(InStage1Pc[5:2]==4'd12)}} & 8'b00001111  |
                            {8{(InStage1Pc[5:2]==4'd13)}} & 8'b00000111  |
                            {8{(InStage1Pc[5:2]==4'd14)}} & 8'b00000011  |
                            {8{(InStage1Pc[5:2]==4'd15)}} & 8'b00000001  ;
        end
        else begin
            RegOutPreAble <= `EnableValue ;
            RegOutPcIvt <= 256'd0 ;
            RegOutInstIvt <= 8'd0 ;
            RegOutDate <= 256'd0  ;
        end
    end

    assign OutPreAble = RegOutPreAble ;
    assign OutPcIvt   = RegOutPcIvt   ;
    assign OutInstIvt = RegOutInstIvt ;
    assign OutDate    = RegOutDate    ;

endmodule
`timescale 1ps/1ps
`include "../define.v"

module ArchState (
    input       wire                                Clk           ,
    input       wire                                Rest          ,

    input       wire                                ArchSStop     ,
    
    input       wire                                RetireReg1Able, //此处输入的数据需要为顺序，即r1就是此周期提交的几条指令中的第一条指令的寄存器映射
    input       wire         [`ArchRegBUs]          RetireAR1Addr ,
    input       wire         [`ReNameRegBUs]        RetirePR1Addr ,
    input       wire                                RetireReg2Able,
    input       wire         [`ArchRegBUs]          RetireAR2Addr ,
    input       wire         [`ReNameRegBUs]        RetirePR2Addr ,
    input       wire                                RetireReg3Able,
    input       wire         [`ArchRegBUs]          RetireAR3Addr ,
    input       wire         [`ReNameRegBUs]        RetirePR3Addr ,
    input       wire                                RetireReg4Able,
    input       wire         [`ArchRegBUs]          RetireAR4Addr ,
    input       wire         [`ReNameRegBUs]        RetirePR4Addr ,
    input       wire                                ReMapping     ,

    output      wire         [`ReNameRegBUs]        ReMappingAS1  , 
    output      wire         [`ReNameRegBUs]        ReMappingAS2  , 
    output      wire         [`ReNameRegBUs]        ReMappingAS3  ,               
    output      wire         [`ReNameRegBUs]        ReMappingAS4  , 
    output      wire         [`ReNameRegBUs]        ReMappingAS5  , 
    output      wire         [`ReNameRegBUs]        ReMappingAS6  , 
    output      wire         [`ReNameRegBUs]        ReMappingAS7  , 
    output      wire         [`ReNameRegBUs]        ReMappingAS8  , 
    output      wire         [`ReNameRegBUs]        ReMappingAS9  , 
    output      wire         [`ReNameRegBUs]        ReMappingAS10 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS11 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS12 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS13 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS14 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS15 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS16 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS17 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS18 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS19 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS20 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS21 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS22 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS23 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS24 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS25 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS26 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS27 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS28 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS29 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS30 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS31 , 
    output      wire         [`ReNameRegBUs]        ReMappingAS32  
);

    reg [`ReNameRegBUs] ArchStateReg [0:31] ;
    integer j ;
    always @(posedge Clk) begin
        if(!Rest)
            for (j = 0;j < 32 ;j = j+1) begin
                ArchStateReg[j] <= j[6:0] ;
            end
        else if(ArchSStop) begin
            for (j = 0;j < 32 ;j = j+1) begin
                ArchStateReg[j] <= ArchStateReg[j] ;
            end
        end 
        else begin
            ArchStateReg[RetireAR1Addr] <= RetireReg1Able ? RetirePR1Addr : ArchStateReg[RetireAR1Addr] ;
            ArchStateReg[RetireAR2Addr] <= RetireReg2Able ? RetirePR2Addr : ArchStateReg[RetireAR2Addr] ;
            ArchStateReg[RetireAR3Addr] <= RetireReg3Able ? RetirePR3Addr : ArchStateReg[RetireAR3Addr] ;
            ArchStateReg[RetireAR4Addr] <= RetireReg4Able ? RetirePR4Addr : ArchStateReg[RetireAR4Addr] ;
        end
    end

    assign ReMappingAS1 = ReMapping ? ArchStateReg[0] : 7'd0 ;
    assign ReMappingAS2 = ReMapping ? ArchStateReg[1] : 7'd0 ;
    assign ReMappingAS3 = ReMapping ? ArchStateReg[2] : 7'd0 ;
    assign ReMappingAS4 = ReMapping ? ArchStateReg[3] : 7'd0 ;
    assign ReMappingAS5 = ReMapping ? ArchStateReg[4] : 7'd0 ;
    assign ReMappingAS6 = ReMapping ? ArchStateReg[5] : 7'd0 ;
    assign ReMappingAS7 = ReMapping ? ArchStateReg[6] : 7'd0 ;
    assign ReMappingAS8 = ReMapping ? ArchStateReg[7] : 7'd0 ;
    assign ReMappingAS9 = ReMapping ? ArchStateReg[8] : 7'd0 ;
    assign ReMappingAS10= ReMapping ? ArchStateReg[9] : 7'd0 ;
    assign ReMappingAS11= ReMapping ? ArchStateReg[10] : 7'd0 ;
    assign ReMappingAS12= ReMapping ? ArchStateReg[11] : 7'd0 ;
    assign ReMappingAS13= ReMapping ? ArchStateReg[12] : 7'd0 ;
    assign ReMappingAS14= ReMapping ? ArchStateReg[13] : 7'd0 ;
    assign ReMappingAS15= ReMapping ? ArchStateReg[14] : 7'd0 ;
    assign ReMappingAS16= ReMapping ? ArchStateReg[15] : 7'd0 ;
    assign ReMappingAS17= ReMapping ? ArchStateReg[16] : 7'd0 ;
    assign ReMappingAS18= ReMapping ? ArchStateReg[17] : 7'd0 ;
    assign ReMappingAS19= ReMapping ? ArchStateReg[18] : 7'd0 ;
    assign ReMappingAS20= ReMapping ? ArchStateReg[19] : 7'd0 ;
    assign ReMappingAS21= ReMapping ? ArchStateReg[20] : 7'd0 ;
    assign ReMappingAS22= ReMapping ? ArchStateReg[21] : 7'd0 ;
    assign ReMappingAS23= ReMapping ? ArchStateReg[22] : 7'd0 ;
    assign ReMappingAS24= ReMapping ? ArchStateReg[23] : 7'd0 ;
    assign ReMappingAS25= ReMapping ? ArchStateReg[24] : 7'd0 ;
    assign ReMappingAS26= ReMapping ? ArchStateReg[25] : 7'd0 ;
    assign ReMappingAS27= ReMapping ? ArchStateReg[26] : 7'd0 ;
    assign ReMappingAS28= ReMapping ? ArchStateReg[27] : 7'd0 ;
    assign ReMappingAS29= ReMapping ? ArchStateReg[28] : 7'd0 ;
    assign ReMappingAS30= ReMapping ? ArchStateReg[29] : 7'd0 ;
    assign ReMappingAS31= ReMapping ? ArchStateReg[30] : 7'd0 ;
    assign ReMappingAS32= ReMapping ? ArchStateReg[31] : 7'd0 ;
endmodule
`timescale 1ps/1ps
`include "../define.v"

module Ctrl (
    input        wire                                      Clk              ,
    input        wire                                      Rest             ,

    input        wire                                      ROBredir         ,
    //for bpu
    output       wire                                      StopToPc         ,
    output       wire                                      StopToBtb        ,
    output       wire                                      StopMidFlash     ,
    output       wire                                      StopTage         ,
    output       wire                                      FLashTage        ,
    output       wire                                      StopRas          ,
    output       wire                                      FLashRas         ,
    output       wire                                      IcacheFLash      ,
    output       wire                                      IcacheStop       ,
    output       wire                                      PredStop         ,
    output       wire                                      PredFlash        ,
    output       wire                                      FTQStop          ,
    output       wire                                      FTQFlash         ,
    
    input        wire                                      IcReq            , //只stop stage2 和PC
    input        wire                                      BpReq            , //stop BPU 不需要管Pc暂存数据因为是有Icache缺页所致会造成trap
    input        wire                                      PreReq           , //需要将icache状态和MSHR刷新
    input        wire                                      FTQReq           ,  //FTQ满了需要把前面全暂停
    input        wire                                      ISReq            

);

    reg   ICacheTrapReq ;
    always @(posedge Clk) begin
        if(!Rest)          ICacheTrapReq <= 1'b0    ;
        else if(BpReq)     ICacheTrapReq <= BpReq   ;
        else if(ROBredir)  ICacheTrapReq <= ROBredir; 
    end

    assign StopToPc     = IcReq | (BpReq | (ICacheTrapReq & ~ROBredir)) | FTQReq | ISReq ;
    assign StopToBtb    = IcReq | (BpReq | (ICacheTrapReq & ~ROBredir)) | FTQReq | ISReq ; 
    assign StopMidFlash = PreReq | ROBredir ;
    assign StopTage     = IcReq | (BpReq | (ICacheTrapReq & ~ROBredir)) | FTQReq | ISReq ;
    assign FLashTage    = PreReq | ROBredir ;
    assign StopRas      = IcReq | (BpReq | (ICacheTrapReq & ~ROBredir)) | FTQReq | ISReq ; 
    assign FLashRas     = PreReq | ROBredir ;
    assign IcacheStop   = IcReq | (BpReq | (ICacheTrapReq & ~ROBredir)) | FTQReq | ISReq ;
    assign IcacheFLash  = PreReq | ROBredir ;
    assign PredStop     = IcReq | (BpReq | (ICacheTrapReq & ~ROBredir)) | FTQReq | ISReq ;
    assign PredFlash    = ROBredir ;
    assign FTQStop      = IcReq | (BpReq | (ICacheTrapReq & ~ROBredir)) | FTQReq | ISReq ;
    assign FTQFlash     = ROBredir ;


endmodule
`timescale 1ps/1ps
`include "../define.v"

module DecodeOneWay (
    input       wire                                   Clk          ,
    input       wire                                   Rest         ,

    input       wire                                   DecodeStop   ,
    input       wire                                   DecodeFlash  ,
    input       wire     [`InstDateBus]                InInstDate   ,
    input       wire     [`InstAddrBus]                InInstAddr   ,
    input       wire                                   InInstPart   ,
    input       wire     [`InstAddrBus]                InInstNAdr   ,
    input       wire                                   InInstPort   ,

    output      wire     [`InstAddrBus]                InstAddr     ,
    output      wire     [`MicOperateCode]             InstOpcode   ,
    output      wire                                   InstSinumA   ,
    output      wire     [25:0]                        InstSiDate   ,
    output      wire                                   InstSr1Abl   ,
    output      wire     [`ArchRegBUs]                 InstSr1Num   ,
    output      wire                                   InstSr2Abl   ,
    output      wire     [`ArchRegBUs]                 InstSr2Num   ,
    output      wire                                   InsrWriteA   ,
    output      wire     [`ArchRegBUs]                 InstWriteN   ,
    output      wire                                   InstPart     ,
    output      wire     [`InstAddrBus]                InstNadr  
);

    wire  [5:0]  Inst1Op31to26 = InInstDate[31:26] ;
    wire  [3:0]  Inst1Op25to22 = InInstDate[25:22] ;
    wire  [1:0]  Inst1Op21to20 = InInstDate[21:20] ;
    wire  [4:0]  Inst1Op19to15 = InInstDate[19:15] ; 

    wire [4:0] Inst1Rd = InInstDate[4:0]   ;
    wire [4:0] Inst1rj = InInstDate[9:5]   ;
    wire [4:0] Inst1rk = InInstDate[14:10] ;

    wire [11:0] Inst1Imm12D  =  InInstDate[21:10] ;
    wire [13:0] Inst1Imm14D  =  InInstDate[23:10] ;
    wire [15:0] Inst1Imm16D  =  InInstDate[25:10] ;
    wire [19:0] Inst1Imm20D  =  InInstDate[24:5]  ;
    wire [25:0] Inst1Imm26D  =  {InInstDate[9:0], InInstDate[25:10]} ;

    wire Inst1Rdcntidw = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd0) & (Inst1Op19to15 == 5'd0) & (InInstDate[14:10] == 5'd24) & (InInstDate[4:0] == 5'd0) ; //alu  1
    wire Inst1Rdcntvlw = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd0) & (Inst1Op19to15 == 5'd0) & (InInstDate[14:10] == 5'd24) & (InInstDate[9:5] == 5'd0) ; //alu  2
    wire Inst1Rdcntvhw = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd0) & (Inst1Op19to15 == 5'd0) & (InInstDate[14:10] == 5'd25) & (InInstDate[9:5] == 5'd0) ; //alu  3
    wire Inst1Addw     = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd1) & (Inst1Op19to15 == 5'd0) ; //alu 4 
    wire Inst1Subw     = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd1) & (Inst1Op19to15 == 5'd2) ; //alu 5
    wire Inst1Slt      = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd1) & (Inst1Op19to15 == 5'd4) ; //alu 6
    wire Inst1Sltu     = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd1) & (Inst1Op19to15 == 5'd5) ; //alu 7
    wire Inst1Nor      = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd1) & (Inst1Op19to15 == 5'd8) ; //alu 8
    wire Inst1And      = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd1) & (Inst1Op19to15 == 5'd9) ; //alu 9
    wire Inst1Or       = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd1) & (Inst1Op19to15 == 5'd10) ; //alu 10
    wire Inst1Xor      = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd1) & (Inst1Op19to15 == 5'd11) ; //alu 11
    wire Inst1Sllw     = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd1) & (Inst1Op19to15 == 5'd14) ; //alu 12
    wire Inst1Srlw     = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd1) & (Inst1Op19to15 == 5'd15) ; //alu 13
    wire Inst1Sraw     = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd1) & (Inst1Op19to15 == 5'd16) ; //alu 14
    wire Inst1Mulw     = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd1) & (Inst1Op19to15 == 5'd24) ; //mul 1
    wire Inst1Mulhw    = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd1) & (Inst1Op19to15 == 5'd25) ; //mul 2
    wire Inst1Mulhwu   = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd1) & (Inst1Op19to15 == 5'd26) ; //mul 3
    wire Inst1Divw     = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd2) & (Inst1Op19to15 == 5'd0) ; //div 1
    wire Inst1Modw     = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd2) & (Inst1Op19to15 == 5'd1) ; //div 2
    wire Inst1Divwu    = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd2) & (Inst1Op19to15 == 5'd2) ; //div 3
    wire Inst1Modwu    = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd2) & (Inst1Op19to15 == 5'd3) ; //div 4
    wire Inst1Break    = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd2) & (Inst1Op19to15 == 5'd20) ; //csr 1
    wire Inst1Syscall  = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd2) & (Inst1Op19to15 == 5'd22) ; //csr 2
    wire Inst1Slliw    = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd1) & (Inst1Op21to20 == 2'd0) & (Inst1Op19to15 == 5'd1) ; //alu 15
    wire Inst1Srliw    = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd1) & (Inst1Op21to20 == 2'd0) & (Inst1Op19to15 == 5'd9) ; //alu 16
    wire Inst1Sraiw    = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd1) & (Inst1Op21to20 == 2'd0) & (Inst1Op19to15 == 5'd17) ; //alu 17
    wire Inst1Slti     = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd8) ; //alu 18
    wire Inst1Sltui    = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd9) ; //alu 19
    wire Inst1Addiw    = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd10) ; //alu 20 
    wire Inst1Andi     = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd13) ; //alu 21
    wire Inst1Ori      = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd14) ; //alu 22
    wire Inst1Xori     = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd15) ; //alu 23
    wire Inst1Csrrd    = (Inst1Op31to26 == 6'd1) & (InInstDate[25:24] == 2'd0) & (InInstDate[9:5] == 5'd0) ; //csr 3
    wire Inst1Csrwr    = (Inst1Op31to26 == 6'd1) & (InInstDate[25:24] == 2'd0) & (InInstDate[9:5] == 5'd1) ; //csr 4
    wire Inst1Csrxchg  = (Inst1Op31to26 == 6'd1) & (InInstDate[25:24] == 2'd0) & ((InInstDate[9:5] != 5'd0) & (InInstDate[9:5] != 5'd1)); //csr 5
  /*yaoxuigai*/   wire Inst1Cacop    = (Inst1Op31to26 == 6'd1) & (Inst1Op25to22 == 4'd8) ; // no one eu(6) 1
    wire Inst1Tlbsrch  = (Inst1Op31to26 == 6'd1) & (Inst1Op25to22 == 4'd9) & (Inst1Op21to20 == 2'd0) & (Inst1Op19to15 == 5'd16) & (InInstDate[14:10] == 5'd10) & (InInstDate[9:5] == 5'd0) & (InInstDate[4:0] == 5'd0) ; //csr 6
    wire Inst1Tlbrd    = (Inst1Op31to26 == 6'd1) & (Inst1Op25to22 == 4'd9) & (Inst1Op21to20 == 2'd0) & (Inst1Op19to15 == 5'd16) & (InInstDate[14:10] == 5'd11) & (InInstDate[9:5] == 5'd0) & (InInstDate[4:0] == 5'd0) ; //csr 7
    wire Inst1Tlbwr    = (Inst1Op31to26 == 6'd1) & (Inst1Op25to22 == 4'd9) & (Inst1Op21to20 == 2'd0) & (Inst1Op19to15 == 5'd16) & (InInstDate[14:10] == 5'd12) & (InInstDate[9:5] == 5'd0) & (InInstDate[4:0] == 5'd0) ; //csr 8
    wire Inst1Tlbfill  = (Inst1Op31to26 == 6'd1) & (Inst1Op25to22 == 4'd9) & (Inst1Op21to20 == 2'd0) & (Inst1Op19to15 == 5'd16) & (InInstDate[14:10] == 5'd13) & (InInstDate[9:5] == 5'd0) & (InInstDate[4:0] == 5'd0) ; //csr 9
    wire Inst1Ertn     = (Inst1Op31to26 == 6'd1) & (Inst1Op25to22 == 4'd9) & (Inst1Op21to20 == 2'd0) & (Inst1Op19to15 == 5'd16) & (InInstDate[14:10] == 5'd14) & (InInstDate[9:5] == 5'd0) & (InInstDate[4:0] == 5'd0) ; //csr 10
    wire Inst1Idle     = (Inst1Op31to26 == 6'd1) & (Inst1Op25to22 == 4'd9) & (Inst1Op21to20 == 2'd0) & (Inst1Op19to15 == 5'd17) ; //csr 11
    wire Inst1Invtlb   = (Inst1Op31to26 == 6'd1) & (Inst1Op25to22 == 4'd9) & (Inst1Op21to20 == 2'd0) & (Inst1Op19to15 == 5'd19) ; //csr 12
    wire Inst1Lu12iw   = (Inst1Op31to26 == 6'd5) & (InInstDate[25] == 0) ;//alu 24
    wire Inst1Pcaddu12i= (Inst1Op31to26 == 6'd7) & (InInstDate[25] == 0) ;//alu 25
    wire Inst1Llw      = (Inst1Op31to26 == 6'd8) & (InInstDate[25:24] == 2'd0) ;//lsu load 1    (load为0,store为1)
    wire Inst1Scw      = (Inst1Op31to26 == 6'd8) & (InInstDate[25:24] == 2'd1) ;//lsu store 1
    wire Inst1Ldb      = (Inst1Op31to26 == 6'd10) & (Inst1Op25to22 == 4'd0) ;//lsu load 2
    wire Inst1Ldh      = (Inst1Op31to26 == 6'd10) & (Inst1Op25to22 == 4'd1) ;//lsu load 3
    wire Inst1Ldw      = (Inst1Op31to26 == 6'd10) & (Inst1Op25to22 == 4'd2) ;//lsu load 4
    wire Inst1Stb      = (Inst1Op31to26 == 6'd10) & (Inst1Op25to22 == 4'd4) ;//lsu store 2
    wire Inst1Sth      = (Inst1Op31to26 == 6'd10) & (Inst1Op25to22 == 4'd5) ;//lsu store 3
    wire Inst1Stw      = (Inst1Op31to26 == 6'd10) & (Inst1Op25to22 == 4'd6) ;//lsu store 4
    wire Inst1Ldbu     = (Inst1Op31to26 == 6'd10) & (Inst1Op25to22 == 4'd8) ;//lsu load 5
    wire Inst1Ldhu     = (Inst1Op31to26 == 6'd10) & (Inst1Op25to22 == 4'd9) ;//lsu load 6
    wire Inst1Preld    = (Inst1Op31to26 == 6'd10) & (Inst1Op25to22 == 4'd11) ; //special 1
    wire Inst1Dbar     = (Inst1Op31to26 == 6'd14) & (Inst1Op25to22 == 4'd1) & (Inst1Op21to20 == 2'd3) & (Inst1Op19to15 == 5'd4) ;//special 2
    wire Inst1Ibar     = (Inst1Op31to26 == 6'd14) & (Inst1Op25to22 == 4'd1) & (Inst1Op21to20 == 2'd3) & (Inst1Op19to15 == 5'd5) ;//special 3
    wire Inst1Jirl     = (Inst1Op31to26 == 6'd19) ;//bru 1
    wire Inst1B        = (Inst1Op31to26 == 6'd20) ;//bru 2
    wire Inst1Bl       = (Inst1Op31to26 == 6'd21) ;//bru 3
    wire Inst1Beq      = (Inst1Op31to26 == 6'd22) ;//bru 4
    wire Inst1Bne      = (Inst1Op31to26 == 6'd23) ;//bru 5
    wire Inst1Blt      = (Inst1Op31to26 == 6'd24) ;//bru 6
    wire Inst1Bge      = (Inst1Op31to26 == 6'd25) ;//bru 7
    wire Inst1Bltu     = (Inst1Op31to26 == 6'd26) ;//bru 8
    wire Inst1Bgeu     = (Inst1Op31to26 == 6'd27) ;//bru 9
    // alu 1 div 2 mul 3 csr 4 lsu 5 qiyi 6 bru 7 special 0
    wire [`MicOperateCode] Inst1OperateCode ;
 
    assign Inst1OperateCode[7] = 0              |  0             | 0              | 0          | 0          | 0         | 0          | 0         | 0         | 0        | 0         | 0          | 0          | 0          | 0          | 0           | 0            | 0          | 0          | 0           | 0           |  Inst1Break |  Inst1Syscall | 0           | 0           | 0           | 0          | 0           | 0           | 0          | 0         | 0          |  Inst1Csrrd |  Inst1Csrwr |  Inst1Csrxchg |  Inst1Cacop |  Inst1Tlbsrch |  Inst1Tlbrd |  Inst1Tlbwr |  Inst1Tlbfill |  Inst1Ertn |  Inst1Idle |  Inst1Invtlb | 0            | 0               |  Inst1Llw |  Inst1Scw |  Inst1Ldb |  Inst1Ldh |  Inst1Ldw |  Inst1Stb |  Inst1Sth |  Inst1Stw |  Inst1Ldbu |  Inst1Ldhu |  Inst1Jirl |  Inst1B |  Inst1Bl |  Inst1Beq |  Inst1Bne |  Inst1Blt |  Inst1Bge |  Inst1Bltu |  Inst1Bgeu | 0           | 0          | 0          ;
    assign Inst1OperateCode[6] = 0              |  0             | 0              | 0          | 0          | 0         | 0          | 0         | 0         | 0        | 0         | 0          | 0          | 0          |  Inst1Mulw |  Inst1Mulhw |  Inst1Mulhwu |  Inst1Divw |  Inst1Modw |  Inst1Divwu |  Inst1Modwu | 0           | 0             | 0           | 0           | 0           | 0          | 0           | 0           | 0          | 0         | 0          | 0           | 0           | 0             |  Inst1Cacop | 0             | 0           | 0           | 0             | 0          | 0          | 0            | 0            | 0               | 0         | 0         | 0         | 0         | 0         |  0        | 0         | 0         | 0          | 0          |  Inst1Jirl |  Inst1B |  Inst1Bl |  Inst1Beq |  Inst1Bne |  Inst1Blt |  Inst1Bge |  Inst1Bltu |  Inst1Bgeu | 0           | 0          | 0          ;
    assign Inst1OperateCode[5] =  Inst1Rdcntidw |  Inst1Rdcntvlw |  Inst1Rdcntvhw |  Inst1Addw |  Inst1Subw |  Inst1Slt |  Inst1Sltu |  Inst1Nor |  Inst1And |  Inst1Or |  Inst1Xor |  Inst1Sllw |  Inst1Srlw |  Inst1Sraw |  Inst1Mulw |  Inst1Mulhw |  Inst1Mulhwu | 0          | 0          | 0           | 0           | 0           | 0             |  Inst1Slliw |  Inst1Srliw |  Inst1Sraiw |  Inst1Slti |  Inst1Sltui |  Inst1Addiw |  Inst1Andi |  Inst1Ori |  Inst1Xori | 0           | 0           | 0             | 0           | 0             | 0           | 0           | 0             | 0          | 0          | 0            |  Inst1Lu12iw |  Inst1Pcaddu12i |  Inst1Llw |  Inst1Scw |  Inst1Ldb |  Inst1Ldh |  Inst1Ldw |  Inst1Stb |  Inst1Sth |  Inst1Stw |  Inst1Ldbu |  Inst1Ldhu |  Inst1Jirl |  Inst1B |  Inst1Bl |  Inst1Beq |  Inst1Bne |  Inst1Blt |  Inst1Bge |  Inst1Bltu |  Inst1Bgeu | 0           | 0          | 0          ;
    assign Inst1OperateCode[4] = 0              |  0             | 0              | 0          | 0          | 0         | 0          | 0         | 0         | 0        | 0         | 0          | 0          | 0          | 0          | 0           | 0            | 0          | 0          | 0           | 0           | 0           | 0             | 0           |  Inst1Srliw |  Inst1Sraiw |  Inst1Slti |  Inst1Sltui |  Inst1Addiw |  Inst1Andi |  Inst1Ori |  Inst1Xori | 0           | 0           | 0             | 0           | 0             | 0           | 0           | 0             | 0          | 0          | 0            |  Inst1Lu12iw |  Inst1Pcaddu12i | 0         |  Inst1Scw | 0         | 0         | 0         |  Inst1Stb |  Inst1Sth |  Inst1Stw |  Inst1Ldbu |  Inst1Ldhu | 0          | 0       | 0        | 0         | 0         | 0         | 0         | 0          | 0          | 0           | 0          | 0          ;
    assign Inst1OperateCode[3] = 0              |  0             | 0              | 0          | 0          | 0         | 0          |  Inst1Nor |  Inst1And |  Inst1Or |  Inst1Xor |  Inst1Sllw |  Inst1Srlw |  Inst1Sraw | 0          | 0           | 0            | 0          | 0          | 0           | 0           | 0           | 0             |  Inst1Slliw | 0           | 0           | 0          | 0           | 0           | 0          | 0         | 0          | 0           | 0           | 0             | 0           | 0             | 0           |  Inst1Tlbwr |  Inst1Tlbfill |  Inst1Ertn |  Inst1Idle |  Inst1Invtlb |  Inst1Lu12iw |  Inst1Pcaddu12i | 0         | 0         | 0         | 0         | 0         | 0         | 0         | 0         | 0          | 0          | 0          | 0       | 0        | 0         | 0         | 0         | 0         |  Inst1Bltu |  Inst1Bgeu | 0           | 0          | 0          ;
    assign Inst1OperateCode[2] = 0              |  0             | 0              |  Inst1Addw |  Inst1Subw |  Inst1Slt |  Inst1Sltu | 0         | 0         | 0        | 0         |  Inst1Sllw |  Inst1Srlw |  Inst1Sraw | 0          | 0           | 0            | 0          | 0          | 0           |  Inst1Modwu | 0           | 0             |  Inst1Slliw | 0           | 0           | 0          | 0           |  Inst1Addiw |  Inst1Andi |  Inst1Ori |  Inst1Xori | 0           |  Inst1Csrwr |  Inst1Csrxchg | 0           |  Inst1Tlbsrch |  Inst1Tlbrd | 0           | 0             | 0          | 0          |  Inst1Invtlb | 0            | 0               | 0         | 0         | 0         | 0         |  Inst1Ldw | 0         | 0         |  Inst1Stw |  Inst1Ldbu |  Inst1Ldhu | 0          | 0       | 0        |  Inst1Beq |  Inst1Bne |  Inst1Blt |  Inst1Bge | 0          | 0          | 0           | 0          | 0          ;
    assign Inst1OperateCode[1] = 0              |  Inst1Rdcntvlw |  Inst1Rdcntvhw | 0          | 0          |  Inst1Slt |  Inst1Sltu | 0         |           |  Inst1Or |  Inst1Xor | 0          | 0          |  Inst1Sraw | 0          |  Inst1Mulhw |  Inst1Mulhwu | 0          |  Inst1Modw |  Inst1Divwu | 0           | 0           |  Inst1Syscall |  Inst1Slliw | 0           | 0           |  Inst1Slti |  Inst1Sltui | 0           | 0          |  Inst1Ori |  Inst1Xori |  Inst1Csrrd | 0           | 0             | 0           |  Inst1Tlbsrch |  Inst1Tlbrd | 0           | 0             |  Inst1Ertn |  Inst1Idle | 0            | 0            | 0               | 0         | 0         |  Inst1Ldb |  Inst1Ldh | 0         |  Inst1Stb |  Inst1Sth | 0         | 0          |  Inst1Ldhu | 0          |  Inst1B |  Inst1Bl | 0         | 0         |  Inst1Blt |  Inst1Bge | 0          | 0          | 0           |  Inst1Dbar |  Inst1Ibar ;
    assign Inst1OperateCode[0] =  Inst1Rdcntidw |  0             |  Inst1Rdcntvhw | 0          |  Inst1Subw | 0         |  Inst1Sltu | 0         |  Inst1And | 0        |  Inst1Xor | 0          |  Inst1Srlw | 0          |  Inst1Mulw | 0           |  Inst1Mulhwu |  Inst1Divw | 0          |  Inst1Divwu | 0           |  Inst1Break | 0             |  Inst1Slliw | 0           |  Inst1Sraiw | 0          |  Inst1Sltui | 0           |  Inst1Andi | 0         |  Inst1Xori |  Inst1Csrrd | 0           |  Inst1Csrxchg |  Inst1Cacop | 0             |  Inst1Tlbrd | 0           |  Inst1Tlbfill | 0          |  Inst1Idle | 0            | 0            |  Inst1Pcaddu12i |  Inst1Llw |  Inst1Scw | 0         |  Inst1Ldh | 0         | 0         |  Inst1Sth | 0         |  Inst1Ldbu | 0          |  Inst1Jirl | 0       |  Inst1Bl | 0         |  Inst1Bne | 0         |  Inst1Bge | 0          |  Inst1Bgeu |  Inst1Preld | 0          |  Inst1Ibar ;

    wire Inst1rdAble =  Inst1Rdcntvlw |
                        Inst1Rdcntvhw |
                        Inst1Addw     |
                        Inst1Subw     |
                        Inst1Slt      |
                        Inst1Sltu     |
                        Inst1Nor      |
                        Inst1And      |
                        Inst1Or       | 
                        Inst1Xor      | 
                        Inst1Sllw     |
                        Inst1Srlw     |
                        Inst1Sraw     |
                        Inst1Mulw     |
                        Inst1Mulhw    |
                        Inst1Mulhwu   |
                        Inst1Divw     |
                        Inst1Modw     |
                        Inst1Divwu    |
                        Inst1Modwu    |
                        Inst1Slliw    |
                        Inst1Srliw    |
                        Inst1Sraiw    |
                        Inst1Slti     |
                        Inst1Sltui    |
                        Inst1Addiw    |
                        Inst1Andi     |
                        Inst1Ori      |
                        Inst1Xori     |
                        Inst1Csrrd    |
                        Inst1Csrwr    |
                        Inst1Csrxchg  |
                        Inst1Cacop    |
                        Inst1Lu12iw   |
                        Inst1Pcaddu12i|
                        Inst1Llw      |
                        Inst1Scw      |
                        Inst1Ldb      |
                        Inst1Ldh      |
                        Inst1Ldw      |
                        Inst1Stb      |
                        Inst1Sth      |
                        Inst1Stw      |
                        Inst1Ldbu     |
                        Inst1Ldhu     |
                        Inst1Preld    |
                        Inst1Jirl     |
                        Inst1Bl       ;
                        // Inst1Beq      |
                        // Inst1Bne      |
                        // Inst1Blt      |
                        // Inst1Bge      |
                        // Inst1Bltu     |
                        // Inst1Bgeu     ;
    wire Inst1rjAble =  Inst1Rdcntidw |
                        Inst1Addw     |
                        Inst1Subw     |
                        Inst1Slt      |
                        Inst1Sltu     |
                        Inst1Nor      |
                        Inst1And      |
                        Inst1Or       |
                        Inst1Xor      |
                        Inst1Sllw     |
                        Inst1Srlw     |  
                        Inst1Sraw     |
                        Inst1Mulw     |
                        Inst1Mulhw    | 
                        Inst1Mulhwu   |
                        Inst1Divw     |
                        Inst1Modw     |
                        Inst1Divwu    |
                        Inst1Modwu    |
                        Inst1Slliw    |
                        Inst1Srliw    |
                        Inst1Sraiw    |
                        Inst1Slti     |
                        Inst1Sltui    |
                        Inst1Addiw    |
                        Inst1Andi     |
                        Inst1Ori      |
                        Inst1Xori     |
                        Inst1Cacop    |
                        Inst1Csrxchg  |
                        Inst1Invtlb   |
                        Inst1Llw      |
                        Inst1Scw      |
                        Inst1Ldb      |
                        Inst1Ldh      |
                        Inst1Ldw      |
                        Inst1Stb      |
                        Inst1Sth      |
                        Inst1Stw      |
                        Inst1Ldbu     |
                        Inst1Ldhu     |
                        Inst1Preld    |
                        Inst1Jirl     |
                        Inst1Beq      |
                        Inst1Bne      |
                        Inst1Blt      |
                        Inst1Bge      |
                        Inst1Bltu     |
                        Inst1Bgeu     ;
    wire Inst1rkAble =  Inst1Addw     |
                        Inst1Subw     |
                        Inst1Slt      |
                        Inst1Sltu     |
                        Inst1Nor      |
                        Inst1And      |
                        Inst1Or       |
                        Inst1Xor      |
                        Inst1Sllw     |
                        Inst1Srlw     |
                        Inst1Sraw     |
                        Inst1Mulw     |
                        Inst1Mulhw    |
                        Inst1Mulhwu   |
                        Inst1Divw     |
                        Inst1Modw     |
                        Inst1Divwu    |
                        Inst1Modwu    |
                        Inst1Beq      |
                        Inst1Bne      |
                        Inst1Blt      |
                        Inst1Bge      |
                        Inst1Bltu     |
                        Inst1Bgeu     |
                        Inst1Csrwr    | //csrwr指令的rd旧值
                        Inst1Csrxchg  | 
                        Inst1Invtlb   ;

    wire Inst1Imm12  =  Inst1Slti     |
                        Inst1Sltui    |
                        Inst1Addiw    |
                        Inst1Andi     |
                        Inst1Ori      |
                        Inst1Xori     |
                        Inst1Cacop    |
                        Inst1Ldb      |
                        Inst1Ldh      |
                        Inst1Ldw      |
                        Inst1Stb      |
                        Inst1Sth      |
                        Inst1Stw      |
                        Inst1Ldbu     |
                        Inst1Ldhu     |
                        Inst1Preld    ;
    wire Inst1Imm14  =  Inst1Csrrd    |
                        Inst1Csrwr    |
                        Inst1Csrxchg  |
                        Inst1Llw      |
                        Inst1Scw      ;
    wire Inst1Imm16  =  Inst1Jirl     |
                        Inst1Beq      |
                        Inst1Bne      |
                        Inst1Blt      |
                        Inst1Bge      |
                        Inst1Bltu     |
                        Inst1Bgeu     ;
    wire Inst1Imm26  =  Inst1B        |
                        Inst1Bl       ;
    wire Inst1Imm20   = Inst1Lu12iw   |
                        Inst1Pcaddu12i;
    wire InstCode     = Inst1Syscall  |
                        Inst1Idle     |
                        Inst1Dbar     |
                        Inst1Ibar     | 
                        Inst1Break    ;
    wire Inst1Imm5    = Inst1Slliw    | 
                        Inst1Srliw    | 
                        Inst1Sraiw    ;

    wire Inst1ImmAble = Inst1Imm14 | Inst1Imm12 | Inst1Imm16 | Inst1Imm26 | Inst1Imm20 | InstCode | Inst1Imm5 ;
    wire [25:0] Inst1ImmDate = Inst1Imm5 ? {21'd0,Inst1rk} :
                               InstCode  ? {11'd0,Inst1rk, Inst1rj, Inst1Rd} :
                               Inst1Imm12 ? {14'd0,Inst1Imm12D} :
                               Inst1Imm14 ? {12'd0,Inst1Imm14D} :
                               Inst1Imm16 ? {10'd0,Inst1Imm16D} :
                               Inst1Imm20 ? {6'd0,Inst1Imm20D} :
                               Inst1Imm26 ? Inst1Imm26D :26'd0 ;
    wire [4:0] Inst1RdAddr   = Inst1Bl ? 5'd1 : Inst1Rd  ;
    wire [4:0] Inst1Src1Addr = Inst1rj ;
    wire [4:0] Inst1Src2addr = (Inst1Beq | Inst1Bne | Inst1Blt | Inst1Bge | Inst1Bltu | Inst1Bgeu | Inst1Csrwr | Inst1Csrxchg) ? Inst1Rd : Inst1rk ; 

    reg [`MicOperateCode] Inst1OpcodeReg ;
    reg                   Inst1SinumAReg ;
    reg [25:0]            Inst1SiDateReg ;
    reg                   Inst1Sr1AblReg ;
    reg [`ArchRegBUs]     Inst1Sr1NumReg ;
    reg                   Inst1Sr2AblReg ;
    reg [`ArchRegBUs]     Inst1Sr2NumReg ;
    reg                   Insr1WriteAReg ;
    reg [`ArchRegBUs]     Inst1WriteNReg ;
    reg                   Inst1PartReg   ;
    reg [`InstAddrBus]    Inst1NadrReg   ;
    reg [`InstAddrBus]    Inst1AddrReg   ;

    always @(posedge Clk) begin
        if(!Rest) begin
            Inst1OpcodeReg <= 8'd0 ;
            Inst1SinumAReg <= `EnableValue ;
            Inst1SiDateReg <= 26'd0 ;
            Inst1Sr1AblReg <= `EnableValue ;
            Inst1Sr1NumReg <= 5'd0 ;
            Inst1Sr2AblReg <= `EnableValue ;
            Inst1Sr2NumReg <= 5'd0 ;
            Insr1WriteAReg <= `EnableValue ;
            Inst1WriteNReg <= 5'd0 ;
            Inst1PartReg   <= `EnableValue ;
            Inst1NadrReg   <= `ZeorDate ;
            Inst1AddrReg   <= `ZeorDate ;
        end
        else begin
            if(DecodeStop) begin
                Inst1OpcodeReg <= Inst1OpcodeReg ;
                Inst1SinumAReg <= Inst1SinumAReg ;
                Inst1SiDateReg <= Inst1SiDateReg ;
                Inst1Sr1AblReg <= Inst1Sr1AblReg ;
                Inst1Sr1NumReg <= Inst1Sr1NumReg ;
                Inst1Sr2AblReg <= Inst1Sr2AblReg ;
                Inst1Sr2NumReg <= Inst1Sr2NumReg ;
                Insr1WriteAReg <= Insr1WriteAReg ;
                Inst1WriteNReg <= Inst1WriteNReg ;
                Inst1PartReg   <= Inst1PartReg   ;
                Inst1NadrReg   <= Inst1NadrReg   ;
                Inst1AddrReg   <= Inst1AddrReg   ;
            end
            if(DecodeFlash) begin
                Inst1OpcodeReg <= 8'd0 ;
                Inst1SinumAReg <= `EnableValue ;
                Inst1SiDateReg <= 26'd0 ;
                Inst1Sr1AblReg <= `EnableValue ;
                Inst1Sr1NumReg <= 5'd0 ;
                Inst1Sr2AblReg <= `EnableValue ;
                Inst1Sr2NumReg <= 5'd0 ;
                Insr1WriteAReg <= `EnableValue ;
                Inst1WriteNReg <= 5'd0 ;
                Inst1PartReg   <= `EnableValue ;
                Inst1NadrReg   <= `ZeorDate ;
                Inst1AddrReg   <= `ZeorDate ;
            end
            if(InInstPort)begin
                Inst1OpcodeReg <= Inst1OperateCode ;
                Inst1SinumAReg <= Inst1ImmAble     ;
                Inst1SiDateReg <= Inst1ImmDate     ;
                Inst1Sr1AblReg <= Inst1rjAble      ;
                Inst1Sr1NumReg <= Inst1Src1Addr    ;
                Inst1Sr2AblReg <= Inst1rkAble      ;
                Inst1Sr2NumReg <= Inst1Src2addr    ;
                Insr1WriteAReg <= Inst1rdAble      ;
                Inst1WriteNReg <= Inst1RdAddr      ;
                Inst1PartReg   <= InInstPart       ;
                Inst1NadrReg   <= InInstNAdr       ;
                Inst1AddrReg   <= InInstAddr       ;
            end
        end
    end

    assign InstAddr   = Inst1AddrReg   ;
    assign InstOpcode = Inst1OpcodeReg ;
    assign InstSinumA = Inst1SinumAReg ;
    assign InstSiDate = Inst1SiDateReg ;
    assign InstSr1Abl = Inst1Sr1AblReg ;
    assign InstSr1Num = Inst1Sr1NumReg ; 
    assign InstSr2Abl = Inst1Sr2AblReg ;
    assign InstSr2Num = Inst1Sr2NumReg ;
    assign InsrWriteA = Insr1WriteAReg ;
    assign InstWriteN = Inst1WriteNReg ;
    assign InstPart   = Inst1PartReg   ;
    assign InstNadr   = Inst1NadrReg   ;
    
endmodule
`timescale 1ps/1ps
`include "../define.v"
`include "DecodeOneWay.v"

module Decode (
    input     wire                             Clk           ,
    input     wire                             Rest          ,
    //for ctrl
    input     wire                             DecodeStopS   ,
    input     wire                             DecodeFlashS  ,
    //output    wire                             DecodeReq     ,
    //from InsrQueue
    input     wire                             InInstPort1  ,
    input     wire                             InInstPort2  ,
    input     wire                             InInstPort3  ,
    input     wire                             InInstPort4  ,
    input     wire      [`InstAddrBus]         InInstAddr1   ,
    input     wire      [`InstDateBus]         InInstDate1   ,
    input     wire                             InInstPart1   ,
    input     wire      [`InstAddrBus]         InInstNAdr1   ,
    input     wire      [`InstAddrBus]         InInstAddr2   ,
    input     wire      [`InstDateBus]         InInstDate2   ,
    input     wire                             InInstPart2   ,
    input     wire      [`InstAddrBus]         InInstNAdr2   ,
    input     wire      [`InstAddrBus]         InInstAddr3   ,
    input     wire      [`InstDateBus]         InInstDate3   ,
    input     wire                             InInstPart3   ,
    input     wire      [`InstAddrBus]         InInstNAdr3   ,
    input     wire      [`InstAddrBus]         InInstAddr4   ,
    input     wire      [`InstDateBus]         InInstDate4   ,
    input     wire                             InInstPart4   ,
    input     wire      [`InstAddrBus]         InInstNAdr4   ,
    //input     wire                             QueueEmpty    ,
    //to  distpatch 
    output    wire      [`InstAddrBus]         Inst1Addr     ,
    output    wire      [`MicOperateCode]      Inst1Opcode   ,
    output    wire                             Inst1SinumA   ,
    output    wire      [25:0]                 Inst1SiDate   ,
    output    wire                             Inst1Sr1Abl   ,
    output    wire      [`ArchRegBUs]          Inst1Sr1Num   ,
    output    wire                             Inst1Sr2Abl   ,   
    output    wire      [`ArchRegBUs]          Inst1Sr2Num   ,
    output    wire                             Insr1WriteA   ,
    output    wire                             Inst1Part     , 
    output    wire      [`InstAddrBus]         Inst1Nadr     ,
    output    wire      [`ArchRegBUs]          Inst1WriteN   ,
    output    wire      [`InstAddrBus]         Inst2Addr     ,
    output    wire      [`MicOperateCode]      Inst2Opcode   ,
    output    wire                             Inst2SinumA   ,
    output    wire      [25:0]                 Inst2SiDate   ,
    output    wire                             Inst2Sr1Abl   ,
    output    wire      [`ArchRegBUs]          Inst2Sr1Num   ,
    output    wire                             Inst2Sr2Abl   ,   
    output    wire      [`ArchRegBUs]          Inst2Sr2Num   ,
    output    wire                             Insr2WriteA   ,
    output    wire      [`ArchRegBUs]          Inst2WriteN   ,
    output    wire                             Inst2Part     , 
    output    wire      [`InstAddrBus]         Inst2Nadr     ,
    output    wire      [`InstAddrBus]         Inst3Addr     ,
    output    wire      [`MicOperateCode]      Inst3Opcode   ,
    output    wire                             Inst3SinumA   ,
    output    wire      [25:0]                 Inst3SiDate   ,
    output    wire                             Inst3Sr1Abl   ,
    output    wire      [`ArchRegBUs]          Inst3Sr1Num   ,
    output    wire                             Inst3Sr2Abl   ,   
    output    wire      [`ArchRegBUs]          Inst3Sr2Num   ,
    output    wire                             Insr3WriteA   ,
    output    wire      [`ArchRegBUs]          Inst3WriteN   ,
    output    wire                             Inst3Part     , 
    output    wire      [`InstAddrBus]         Inst3Nadr     ,
    output    wire      [`InstAddrBus]         Inst4Addr     ,
    output    wire      [`MicOperateCode]      Inst4Opcode   ,
    output    wire                             Inst4SinumA   ,
    output    wire      [25:0]                 Inst4SiDate   ,
    output    wire                             Inst4Sr1Abl   ,
    output    wire      [`ArchRegBUs]          Inst4Sr1Num   ,
    output    wire                             Inst4Sr2Abl   ,   
    output    wire      [`ArchRegBUs]          Inst4Sr2Num   ,
    output    wire                             Insr4WriteA   ,
    output    wire      [`ArchRegBUs]          Inst4WriteN   ,
    output    wire                             Inst4Part     , 
    output    wire      [`InstAddrBus]         Inst4Nadr     
);

    DecodeOneWay u1_DecodeOneWay(
        .Clk          ( Clk          ),
        .Rest         ( Rest         ),
        .DecodeStop   ( DecodeStopS  ),
        .DecodeFlash  ( DecodeFlashS ),
        .InInstDate   ( InInstDate1  ),
        .InInstAddr   ( InInstAddr1  ),
        .InInstPart   ( InInstPart1  ),
        .InInstNAdr   ( InInstNAdr1  ),
        .InInstPort   ( InInstPort1  ),
        .InstAddr     ( Inst1Addr    ),
        .InstOpcode   ( Inst1Opcode  ),
        .InstSinumA   ( Inst1SinumA  ),
        .InstSiDate   ( Inst1SiDate  ),
        .InstSr1Abl   ( Inst1Sr1Abl  ),
        .InstSr1Num   ( Inst1Sr1Num  ),
        .InstSr2Abl   ( Inst1Sr2Abl  ),
        .InstSr2Num   ( Inst1Sr2Num  ),
        .InsrWriteA   ( Insr1WriteA  ),
        .InstWriteN   ( Inst1WriteN  ),
        .InstPart     ( Inst1Part    ),
        .InstNadr     ( Inst1Nadr    )
    );

    DecodeOneWay u2_DecodeOneWay(
        .Clk          ( Clk          ),
        .Rest         ( Rest         ),
        .DecodeStop   ( DecodeStopS  ),
        .DecodeFlash  ( DecodeFlashS ),
        .InInstDate   ( InInstDate2  ),
        .InInstAddr   ( InInstAddr2  ),
        .InInstPart   ( InInstPart2  ),
        .InInstNAdr   ( InInstNAdr2  ),
        .InInstPort   ( InInstPort2  ),
        .InstAddr     ( Inst2Addr    ),
        .InstOpcode   ( Inst2Opcode  ),
        .InstSinumA   ( Inst2SinumA  ),
        .InstSiDate   ( Inst2SiDate  ),
        .InstSr1Abl   ( Inst2Sr1Abl  ),
        .InstSr1Num   ( Inst2Sr1Num  ),
        .InstSr2Abl   ( Inst2Sr2Abl  ),
        .InstSr2Num   ( Inst2Sr2Num  ),
        .InsrWriteA   ( Insr2WriteA  ),
        .InstWriteN   ( Inst2WriteN  ),
        .InstPart     ( Inst2Part    ),
        .InstNadr     ( Inst2Nadr    )
    );

    DecodeOneWay u3_DecodeOneWay(
        .Clk          ( Clk          ),
        .Rest         ( Rest         ),
        .DecodeStop   ( DecodeStopS  ),
        .DecodeFlash  ( DecodeFlashS ),
        .InInstDate   ( InInstDate3  ),
        .InInstAddr   ( InInstAddr3  ),
        .InInstPart   ( InInstPart3  ),
        .InInstNAdr   ( InInstNAdr3  ),
        .InInstPort   ( InInstPort3  ),
        .InstAddr     ( Inst3Addr    ),
        .InstOpcode   ( Inst3Opcode  ),
        .InstSinumA   ( Inst3SinumA  ),
        .InstSiDate   ( Inst3SiDate  ),
        .InstSr1Abl   ( Inst3Sr1Abl  ),
        .InstSr1Num   ( Inst3Sr1Num  ),
        .InstSr2Abl   ( Inst3Sr2Abl  ),
        .InstSr2Num   ( Inst3Sr2Num  ),
        .InsrWriteA   ( Insr3WriteA  ),
        .InstWriteN   ( Inst3WriteN  ),
        .InstPart     ( Inst3Part    ),
        .InstNadr     ( Inst3Nadr    )
    );

    DecodeOneWay u4_DecodeOneWay(
        .Clk          ( Clk          ),
        .Rest         ( Rest         ),
        .DecodeStop   ( DecodeStopS  ),
        .DecodeFlash  ( DecodeFlashS ),
        .InInstDate   ( InInstDate4  ),
        .InInstAddr   ( InInstAddr4  ),
        .InInstPart   ( InInstPart4  ),
        .InInstNAdr   ( InInstNAdr4  ),
        .InInstPort   ( InInstPort4  ),
        .InstAddr     ( Inst4Addr    ),
        .InstOpcode   ( Inst4Opcode  ),
        .InstSinumA   ( Inst4SinumA  ),
        .InstSiDate   ( Inst4SiDate  ),
        .InstSr1Abl   ( Inst4Sr1Abl  ),
        .InstSr1Num   ( Inst4Sr1Num  ),
        .InstSr2Abl   ( Inst4Sr2Abl  ),
        .InstSr2Num   ( Inst4Sr2Num  ),
        .InsrWriteA   ( Insr4WriteA  ),
        .InstWriteN   ( Inst4WriteN  ),
        .InstPart     ( Inst4Part    ),
        .InstNadr     ( Inst4Nadr    )
    );



endmodule
`timescale 1ps/1ps
`include "../define.v"
`include "../../Lib/FIFO.v"

module InstIssueQue # (
    parameter  INSTQUEUEDEEP = 32 ,
    parameter  INSTQUEUEWIDE = 97 
) (
    input      wire                                       Clk          ,
    input      wire                                       Rest         ,
    //for ctrl
    input      wire                                       InstQStop    ,
    input      wire                                       InstQFlash   ,
    output     wire                                       InstQReqStop ,
    //input from PreDecode
    input      wire                                       FromPre1Able ,
    input      wire      [`InstAddrBus]                   FromPre1Addr ,
    input      wire      [`InstDateBus]                   FromPre1Date ,
    input      wire                                       FromPre1Part ,
    input      wire      [`InstAddrBus]                   FromPre1NAdr ,
    input      wire                                       FromPre2Able ,
    input      wire      [`InstAddrBus]                   FromPre2Addr ,
    input      wire      [`InstDateBus]                   FromPre2Date ,
    input      wire                                       FromPre2Part ,
    input      wire      [`InstAddrBus]                   FromPre2NAdr ,
    input      wire                                       FromPre3Able ,
    input      wire      [`InstAddrBus]                   FromPre3Addr ,
    input      wire      [`InstDateBus]                   FromPre3Date ,
    input      wire                                       FromPre3Part ,
    input      wire      [`InstAddrBus]                   FromPre3NAdr ,
    input      wire                                       FromPre4Able ,
    input      wire      [`InstAddrBus]                   FromPre4Addr ,
    input      wire      [`InstDateBus]                   FromPre4Date , 
    input      wire                                       FromPre4Part ,
    input      wire      [`InstAddrBus]                   FromPre4NAdr ,
    input      wire                                       FromPre5Able ,
    input      wire      [`InstAddrBus]                   FromPre5Addr ,
    input      wire      [`InstDateBus]                   FromPre5Date ,
    input      wire                                       FromPre5Part ,
    input      wire      [`InstAddrBus]                   FromPre5NAdr ,
    input      wire                                       FromPre6Able ,
    input      wire      [`InstAddrBus]                   FromPre6Addr ,
    input      wire      [`InstDateBus]                   FromPre6Date ,
    input      wire                                       FromPre6Part ,
    input      wire      [`InstAddrBus]                   FromPre6NAdr ,
    input      wire                                       FromPre7Able ,
    input      wire      [`InstAddrBus]                   FromPre7Addr ,
    input      wire      [`InstDateBus]                   FromPre7Date ,
    input      wire                                       FromPre7Part ,
    input      wire      [`InstAddrBus]                   FromPre7NAdr ,
    input      wire                                       FromPre8Able ,
    input      wire      [`InstAddrBus]                   FromPre8Addr ,
    input      wire      [`InstDateBus]                   FromPre8Date , 
    input      wire                                       FromPre8Part ,
    input      wire      [`InstAddrBus]                   FromPre8NAdr ,      
    //to decode 
    output     wire                                       OutInstPort1 ,
    output     wire                                       OutInstPort2 ,
    output     wire                                       OutInstPort3 ,
    output     wire                                       OutInstPort4 ,
    output     wire      [`InstAddrBus]                   OutInstAddr1 ,
    output     wire      [`InstDateBus]                   OutInstDate1 ,
    output     wire                                       OutInstPart1 ,
    output     wire      [`InstAddrBus]                   OutInstNAdr1 ,
    output     wire      [`InstAddrBus]                   OutInstAddr2 ,
    output     wire      [`InstDateBus]                   OutInstDate2 ,
    output     wire                                       OutInstPart2 ,
    output     wire      [`InstAddrBus]                   OutInstNAdr2 ,
    output     wire      [`InstAddrBus]                   OutInstAddr3 ,
    output     wire      [`InstDateBus]                   OutInstDate3 ,
    output     wire                                       OutInstPart3 ,
    output     wire      [`InstAddrBus]                   OutInstNAdr3 ,
    output     wire      [`InstAddrBus]                   OutInstAddr4 ,
    output     wire      [`InstDateBus]                   OutInstDate4 ,
    output     wire                                       OutInstPart4 ,
    output     wire      [`InstAddrBus]                   OutInstNAdr4 
);

    reg              StopTemp   ;
    reg              FLashTemp  ;

    always @(posedge Clk) begin
        if(!Rest) begin
            StopTemp  <= 1'b0 ;
            FLashTemp <= 1'b0 ;
        end
        else begin
            StopTemp  <= InstQStop  ;
            FLashTemp <= InstQFlash ;
        end
    end


    reg  [3:0]  WritePtr ;
    reg  [3:0]  ReadPtr  ;

    wire U1Clean = FLashTemp ;
    wire U1Full  ;
    wire U1Empty ;
    wire U2Clean = FLashTemp ;
    wire U2Full  ;
    wire U2Empty ;
    wire U3Clean = FLashTemp ;
    wire U3Full  ;
    wire U3Empty ;
    wire U4Clean = FLashTemp ;
    wire U4Full  ;
    wire U4Empty ;
    wire U5Clean = FLashTemp ;
    wire U5Full  ;
    wire U5Empty ;
    wire U6Clean = FLashTemp ;
    wire U6Full  ;
    wire U6Empty ;
    wire U7Clean = FLashTemp ;
    wire U7Full  ;
    wire U7Empty ;
    wire U8Clean = FLashTemp ;
    wire U8Full  ;
    wire U8Empty ;


    wire  [3:0] InInstNum = {4{( FromPre1Able &  FromPre2Able &  FromPre3Able &  FromPre4Able &  FromPre5Able &  FromPre6Able &  FromPre7Able &  FromPre8Able)}} & 4'd8 |
                            {4{( FromPre1Able &  FromPre2Able &  FromPre3Able &  FromPre4Able &  FromPre5Able &  FromPre6Able &  FromPre7Able & ~FromPre8Able)}} & 4'd7 |
                            {4{( FromPre1Able &  FromPre2Able &  FromPre3Able &  FromPre4Able &  FromPre5Able &  FromPre6Able & ~FromPre7Able & ~FromPre8Able)}} & 4'd6 |
                            {4{( FromPre1Able &  FromPre2Able &  FromPre3Able &  FromPre4Able &  FromPre5Able & ~FromPre6Able & ~FromPre7Able & ~FromPre8Able)}} & 4'd5 |
                            {4{( FromPre1Able &  FromPre2Able &  FromPre3Able &  FromPre4Able & ~FromPre5Able & ~FromPre6Able & ~FromPre7Able & ~FromPre8Able)}} & 4'd4 |
                            {4{( FromPre1Able &  FromPre2Able &  FromPre3Able & ~FromPre4Able & ~FromPre5Able & ~FromPre6Able & ~FromPre7Able & ~FromPre8Able)}} & 4'd3 |
                            {4{( FromPre1Able &  FromPre2Able & ~FromPre3Able & ~FromPre4Able & ~FromPre5Able & ~FromPre6Able & ~FromPre7Able & ~FromPre8Able)}} & 4'd2 |
                            {4{( FromPre1Able & ~FromPre2Able & ~FromPre3Able & ~FromPre4Able & ~FromPre5Able & ~FromPre6Able & ~FromPre7Able & ~FromPre8Able)}} & 4'd1 |
                            {4{(~FromPre1Able & ~FromPre2Able & ~FromPre3Able & ~FromPre4Able & ~FromPre5Able & ~FromPre6Able & ~FromPre7Able & ~FromPre8Able)}} & 4'd0 ;

    always @(posedge Clk) begin
        if(!Rest) begin
            WritePtr <= 4'd0 ;
        end
        else begin
            WritePtr <= WritePtr[2:0] + InInstNum ;
        end
    end

    wire [2:0] ReqInstNum = {3{(~U1Empty & ~U2Empty & ~U3Empty & ~U4Empty)}} & 3'd4 | 
                            {3{(~U1Empty & ~U2Empty & ~U3Empty &  U4Empty)}} & 3'd3 | 
                            {3{(~U1Empty & ~U2Empty &  U3Empty &  U4Empty)}} & 3'd2 | 
                            {3{(~U1Empty &  U2Empty &  U3Empty &  U4Empty)}} & 3'd1 ;

    always @(posedge Clk) begin
        if(!Rest) begin
            ReadPtr <= 4'd0 ;
        end
        else begin
            ReadPtr <= ~StopTemp ?  ReadPtr[2:0] + ReqInstNum : ReadPtr;
        end
    end
    // late one clk sent infromation
    reg [2:0] TempReadPtr ;
    reg [2:0] TempNumber  ;
    always @(posedge Clk) begin
        if(!Rest) begin
            TempReadPtr <= 3'd0 ;
            TempNumber  <= 3'd0 ;
        end
        else begin
            TempReadPtr <= ReadPtr[2:0] ;
            TempNumber  <= ReqInstNum   ;
        end
    end

    wire  Read1Able   = (ReadPtr[2:0] == 0) & (ReqInstNum != 0) |
                        (ReadPtr[2:0] == 5) & (ReqInstNum == 4) |
                        (ReadPtr[2:0] == 6) & ((ReqInstNum == 3) | (ReqInstNum == 4)) |
                        (ReadPtr[2:0] == 7) & ((ReqInstNum != 0) & (ReqInstNum != 1)) ;

    wire  Read2Able   = (ReadPtr[2:0] == 0) & ((ReqInstNum != 0) & (ReqInstNum != 1)) |
                        (ReadPtr[2:0] == 1) & (ReqInstNum != 0) |
                        (ReadPtr[2:0] == 6) & (ReqInstNum == 4) |
                        (ReadPtr[2:0] == 7) & ((ReqInstNum == 3) | (ReqInstNum == 4)) ;

    wire  Read3Able   = (ReadPtr[2:0] == 0) & ((ReqInstNum == 2) | (ReqInstNum == 3)) |
                        (ReadPtr[2:0] == 1) & ((ReqInstNum != 0) & (ReqInstNum != 1)) |
                        (ReadPtr[2:0] == 2) & (ReqInstNum != 0) |
                        (ReadPtr[2:0] == 7) & (ReqInstNum == 4) ;

    wire  Read4Able   = (ReadPtr[2:0] == 0) & (ReqInstNum == 4) |
                        (ReadPtr[2:0] == 1) & ((ReqInstNum == 2) | (ReqInstNum == 3)) |
                        (ReadPtr[2:0] == 2) & ((ReqInstNum != 0) & (ReqInstNum != 1)) |
                        (ReadPtr[2:0] == 3) & (ReqInstNum != 0) ;

    wire  Read5Able   = (ReadPtr[2:0] == 1) & (ReqInstNum == 4) |
                        (ReadPtr[2:0] == 2) & ((ReqInstNum == 2) | (ReqInstNum == 3)) |
                        (ReadPtr[2:0] == 3) & ((ReqInstNum != 0) & (ReqInstNum != 1)) |
                        (ReadPtr[2:0] == 4) & (ReqInstNum != 0);

    wire  Read6Able   = (ReadPtr[2:0] == 2) & (ReqInstNum == 4) |
                        (ReadPtr[2:0] == 3) & ((ReqInstNum == 2) | (ReqInstNum == 3)) |
                        (ReadPtr[2:0] == 4) & ((ReqInstNum != 0) & (ReqInstNum != 1)) |
                        (ReadPtr[2:0] == 5) & (ReqInstNum != 0);
        
    wire  Read7Able   = (ReadPtr[2:0] == 3) & (ReqInstNum == 4) |
                        (ReadPtr[2:0] == 4) & ((ReqInstNum == 2) | (ReqInstNum == 3)) |
                        (ReadPtr[2:0] == 5) & ((ReqInstNum != 0) & (ReqInstNum != 1)) |
                        (ReadPtr[2:0] == 6) & (ReqInstNum != 0);

    wire  Read8Able   = (ReadPtr[2:0] == 4) & (ReqInstNum == 4) |
                        (ReadPtr[2:0] == 5) & ((ReqInstNum == 2) | (ReqInstNum == 3)) |
                        (ReadPtr[2:0] == 6) & ((ReqInstNum != 0) & (ReqInstNum != 1)) |
                        (ReadPtr[2:0] == 7) & (ReqInstNum != 0);

   

    wire [INSTQUEUEWIDE-1:0] Read1Date ; 
    wire [INSTQUEUEWIDE-1:0] Read2Date ; 
    wire [INSTQUEUEWIDE-1:0] Read3Date ; 
    wire [INSTQUEUEWIDE-1:0] Read4Date ;
    wire [INSTQUEUEWIDE-1:0] Read5Date ; 
    wire [INSTQUEUEWIDE-1:0] Read6Date ; 
    wire [INSTQUEUEWIDE-1:0] Read7Date ; 
    wire [INSTQUEUEWIDE-1:0] Read8Date ;

    assign  { OutInstAddr1, OutInstDate1, OutInstPart1, OutInstNAdr1} = {INSTQUEUEWIDE{(TempReadPtr == 0)}} & Read1Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 1)}} & Read2Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 2)}} & Read3Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 3)}} & Read4Date |
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 4)}} & Read5Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 5)}} & Read6Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 6)}} & Read7Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 7)}} & Read8Date ;

    assign  { OutInstAddr2, OutInstDate2, OutInstPart2, OutInstNAdr2} = {INSTQUEUEWIDE{(TempReadPtr == 0)}} & Read2Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 1)}} & Read3Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 2)}} & Read4Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 3)}} & Read5Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 4)}} & Read6Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 5)}} & Read7Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 6)}} & Read8Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 7)}} & Read1Date ;

    assign  { OutInstAddr3, OutInstDate3, OutInstPart3, OutInstNAdr3} = {INSTQUEUEWIDE{(TempReadPtr == 0)}} & Read3Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 1)}} & Read4Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 2)}} & Read5Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 3)}} & Read6Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 4)}} & Read7Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 5)}} & Read8Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 6)}} & Read1Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 7)}} & Read2Date ; 

    assign  { OutInstAddr4, OutInstDate4, OutInstPart4, OutInstNAdr4} = {INSTQUEUEWIDE{(TempReadPtr == 0)}} & Read4Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 1)}} & Read5Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 2)}} & Read6Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 3)}} & Read7Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 4)}} & Read8Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 5)}} & Read1Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 6)}} & Read2Date | 
                                                                        {INSTQUEUEWIDE{(TempReadPtr == 7)}} & Read3Date ; 


    assign OutInstPort1 =  (TempNumber >= 1) && ~StopTemp;
    assign OutInstPort2 =  (TempNumber >= 2) && ~StopTemp;
    assign OutInstPort3 =  (TempNumber >= 3) && ~StopTemp;
    assign OutInstPort4 =  (TempNumber >= 4) && ~StopTemp;

    wire  WriteU1Able ;
    wire  WriteU2Able ;
    wire  WriteU3Able ;
    wire  WriteU4Able ;
    wire  WriteU5Able ;
    wire  WriteU6Able ;
    wire  WriteU7Able ;
    wire  WriteU8Able ;
    wire [INSTQUEUEWIDE-1:0] Write1Date ;
    wire [INSTQUEUEWIDE-1:0] Write2Date ;
    wire [INSTQUEUEWIDE-1:0] Write3Date ;
    wire [INSTQUEUEWIDE-1:0] Write4Date ;
    wire [INSTQUEUEWIDE-1:0] Write5Date ;
    wire [INSTQUEUEWIDE-1:0] Write6Date ;
    wire [INSTQUEUEWIDE-1:0] Write7Date ;
    wire [INSTQUEUEWIDE-1:0] Write8Date ;

    assign  {WriteU1Able,Write1Date}  = {INSTQUEUEWIDE+1{(WritePtr[2:0] == 0)}} & {FromPre1Able,FromPre1Addr, FromPre1Date, FromPre1Part, FromPre1NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 1)}} & {FromPre8Able,FromPre8Addr, FromPre8Date, FromPre8Part, FromPre8NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 2)}} & {FromPre7Able,FromPre7Addr, FromPre7Date, FromPre7Part, FromPre7NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 3)}} & {FromPre6Able,FromPre6Addr, FromPre6Date, FromPre6Part, FromPre6NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 4)}} & {FromPre5Able,FromPre5Addr, FromPre5Date, FromPre5Part, FromPre5NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 5)}} & {FromPre4Able,FromPre4Addr, FromPre4Date, FromPre4Part, FromPre4NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 6)}} & {FromPre3Able,FromPre3Addr, FromPre3Date, FromPre3Part, FromPre3NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 7)}} & {FromPre2Able,FromPre2Addr, FromPre2Date, FromPre2Part, FromPre2NAdr} ;

    assign  {WriteU2Able,Write2Date}  = {INSTQUEUEWIDE+1{(WritePtr[2:0] == 0)}} & {FromPre2Able,FromPre2Addr, FromPre2Date, FromPre2Part, FromPre2NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 1)}} & {FromPre1Able,FromPre1Addr, FromPre1Date, FromPre1Part, FromPre1NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 2)}} & {FromPre8Able,FromPre8Addr, FromPre8Date, FromPre8Part, FromPre8NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 3)}} & {FromPre7Able,FromPre7Addr, FromPre7Date, FromPre7Part, FromPre7NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 4)}} & {FromPre6Able,FromPre6Addr, FromPre6Date, FromPre6Part, FromPre6NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 5)}} & {FromPre5Able,FromPre5Addr, FromPre5Date, FromPre5Part, FromPre5NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 6)}} & {FromPre4Able,FromPre4Addr, FromPre4Date, FromPre4Part, FromPre4NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 7)}} & {FromPre3Able,FromPre3Addr, FromPre3Date, FromPre3Part, FromPre3NAdr} ;

    assign  {WriteU3Able,Write3Date}  = {INSTQUEUEWIDE+1{(WritePtr[2:0] == 0)}} & {FromPre3Able,FromPre3Addr, FromPre3Date, FromPre3Part, FromPre3NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 1)}} & {FromPre2Able,FromPre2Addr, FromPre2Date, FromPre2Part, FromPre2NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 2)}} & {FromPre1Able,FromPre1Addr, FromPre1Date, FromPre1Part, FromPre1NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 3)}} & {FromPre8Able,FromPre8Addr, FromPre8Date, FromPre8Part, FromPre8NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 4)}} & {FromPre7Able,FromPre7Addr, FromPre7Date, FromPre7Part, FromPre7NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 5)}} & {FromPre6Able,FromPre6Addr, FromPre6Date, FromPre6Part, FromPre6NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 6)}} & {FromPre5Able,FromPre5Addr, FromPre5Date, FromPre5Part, FromPre5NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 7)}} & {FromPre4Able,FromPre4Addr, FromPre4Date, FromPre4Part, FromPre4NAdr} ;


    assign  {WriteU4Able,Write4Date}  = {INSTQUEUEWIDE+1{(WritePtr[2:0] == 0)}} & {FromPre4Able,FromPre4Addr, FromPre4Date, FromPre4Part, FromPre4NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 1)}} & {FromPre3Able,FromPre3Addr, FromPre3Date, FromPre3Part, FromPre3NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 2)}} & {FromPre2Able,FromPre2Addr, FromPre2Date, FromPre2Part, FromPre2NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 3)}} & {FromPre1Able,FromPre1Addr, FromPre1Date, FromPre1Part, FromPre1NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 4)}} & {FromPre8Able,FromPre8Addr, FromPre8Date, FromPre8Part, FromPre8NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 5)}} & {FromPre7Able,FromPre7Addr, FromPre7Date, FromPre7Part, FromPre7NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 6)}} & {FromPre6Able,FromPre6Addr, FromPre6Date, FromPre6Part, FromPre6NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 7)}} & {FromPre5Able,FromPre5Addr, FromPre5Date, FromPre5Part, FromPre5NAdr} ;


    assign  {WriteU5Able,Write5Date}  = {INSTQUEUEWIDE+1{(WritePtr[2:0] == 0)}} & {FromPre5Able,FromPre5Addr, FromPre5Date, FromPre5Part, FromPre5NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 1)}} & {FromPre4Able,FromPre4Addr, FromPre4Date, FromPre4Part, FromPre4NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 2)}} & {FromPre3Able,FromPre3Addr, FromPre3Date, FromPre3Part, FromPre3NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 3)}} & {FromPre2Able,FromPre2Addr, FromPre2Date, FromPre2Part, FromPre2NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 4)}} & {FromPre1Able,FromPre1Addr, FromPre1Date, FromPre1Part, FromPre1NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 5)}} & {FromPre8Able,FromPre8Addr, FromPre8Date, FromPre8Part, FromPre8NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 6)}} & {FromPre7Able,FromPre7Addr, FromPre7Date, FromPre7Part, FromPre7NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 7)}} & {FromPre6Able,FromPre6Addr, FromPre6Date, FromPre6Part, FromPre6NAdr} ;


    assign  {WriteU6Able,Write6Date}  = {INSTQUEUEWIDE+1{(WritePtr[2:0] == 0)}} & {FromPre6Able,FromPre6Addr, FromPre6Date, FromPre6Part, FromPre6NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 1)}} & {FromPre5Able,FromPre5Addr, FromPre5Date, FromPre5Part, FromPre5NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 2)}} & {FromPre4Able,FromPre4Addr, FromPre4Date, FromPre4Part, FromPre4NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 3)}} & {FromPre3Able,FromPre3Addr, FromPre3Date, FromPre3Part, FromPre3NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 4)}} & {FromPre2Able,FromPre2Addr, FromPre2Date, FromPre2Part, FromPre2NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 5)}} & {FromPre1Able,FromPre1Addr, FromPre1Date, FromPre1Part, FromPre1NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 6)}} & {FromPre8Able,FromPre8Addr, FromPre8Date, FromPre8Part, FromPre8NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 7)}} & {FromPre7Able,FromPre7Addr, FromPre7Date, FromPre7Part, FromPre7NAdr} ;


    assign  {WriteU7Able,Write7Date}  = {INSTQUEUEWIDE+1{(WritePtr[2:0] == 0)}} & {FromPre7Able,FromPre7Addr, FromPre7Date, FromPre7Part, FromPre7NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 1)}} & {FromPre6Able,FromPre6Addr, FromPre6Date, FromPre6Part, FromPre6NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 2)}} & {FromPre5Able,FromPre5Addr, FromPre5Date, FromPre5Part, FromPre5NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 3)}} & {FromPre4Able,FromPre4Addr, FromPre4Date, FromPre4Part, FromPre4NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 4)}} & {FromPre3Able,FromPre3Addr, FromPre3Date, FromPre3Part, FromPre3NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 5)}} & {FromPre2Able,FromPre2Addr, FromPre2Date, FromPre2Part, FromPre2NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 6)}} & {FromPre1Able,FromPre1Addr, FromPre1Date, FromPre1Part, FromPre1NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 7)}} & {FromPre8Able,FromPre8Addr, FromPre8Date, FromPre8Part, FromPre8NAdr} ;


    assign  {WriteU8Able,Write8Date}  = {INSTQUEUEWIDE+1{(WritePtr[2:0] == 0)}} & {FromPre8Able,FromPre8Addr, FromPre8Date, FromPre8Part, FromPre8NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 1)}} & {FromPre7Able,FromPre7Addr, FromPre7Date, FromPre7Part, FromPre7NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 2)}} & {FromPre6Able,FromPre6Addr, FromPre6Date, FromPre6Part, FromPre6NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 3)}} & {FromPre5Able,FromPre5Addr, FromPre5Date, FromPre5Part, FromPre5NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 4)}} & {FromPre4Able,FromPre4Addr, FromPre4Date, FromPre4Part, FromPre4NAdr} |
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 5)}} & {FromPre3Able,FromPre3Addr, FromPre3Date, FromPre3Part, FromPre3NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 6)}} & {FromPre2Able,FromPre2Addr, FromPre2Date, FromPre2Part, FromPre2NAdr} | 
                                        {INSTQUEUEWIDE+1{(WritePtr[2:0] == 7)}} & {FromPre1Able,FromPre1Addr, FromPre1Date, FromPre1Part, FromPre1NAdr} ;


    assign InstQReqStop = U1Full | U2Full | U3Full | U4Full | U5Full | U6Full | U7Full | U8Full ;

    FIFO#(
        .FIFOWIDE   ( INSTQUEUEWIDE )
    )u1_FIFO(
        .Clk        ( Clk           ),
        .Rest       ( Rest          ),
        .Rable      ( Read1Able && ~StopTemp),
        .Dout       ( Read1Date     ),
        .Wable      ( WriteU1Able && ~U1Full ),
        .Din        ( Write1Date    ),
        .FifoClean  ( U1Clean       ),
        .FifoFull   ( U1Full        ),
        .FifoEmpty  ( U1Empty       )
    );

    FIFO#(
        .FIFOWIDE   ( INSTQUEUEWIDE )
    )u2_FIFO(
        .Clk        ( Clk           ),
        .Rest       ( Rest          ),
        .Rable      ( Read2Able  && ~StopTemp),
        .Dout       ( Read2Date     ),
        .Wable      ( WriteU2Able && ~U2Full   ),
        .Din        ( Write2Date    ),
        .FifoClean  ( U2Clean       ),
        .FifoFull   ( U2Full        ),
        .FifoEmpty  ( U2Empty       )
    );

    FIFO#(
        .FIFOWIDE   ( INSTQUEUEWIDE )
    )u3_FIFO(
        .Clk        ( Clk           ),
        .Rest       ( Rest          ),
        .Rable      ( Read3Able  && ~StopTemp),
        .Dout       ( Read3Date     ),
        .Wable      ( WriteU3Able && ~U3Full  ),
        .Din        ( Write3Date    ),
        .FifoClean  ( U3Clean       ),
        .FifoFull   ( U3Full        ),
        .FifoEmpty  ( U3Empty       )
    );

    FIFO#(
        .FIFOWIDE   ( INSTQUEUEWIDE )
    )u4_FIFO(
        .Clk        ( Clk           ),
        .Rest       ( Rest          ),
        .Rable      ( Read4Able  && ~StopTemp),
        .Dout       ( Read4Date     ),
        .Wable      ( WriteU4Able && ~U4Full  ),
        .Din        ( Write4Date    ),
        .FifoClean  ( U4Clean       ),
        .FifoFull   ( U4Full        ),
        .FifoEmpty  ( U4Empty       )
    );

    FIFO#(
        .FIFOWIDE   ( INSTQUEUEWIDE )
    )u5_FIFO(
        .Clk        ( Clk           ),
        .Rest       ( Rest          ),
        .Rable      ( Read5Able && ~StopTemp),
        .Dout       ( Read5Date     ),
        .Wable      ( WriteU5Able && ~U5Full  ),
        .Din        ( Write5Date    ),
        .FifoClean  ( U5Clean       ),
        .FifoFull   ( U5Full        ),
        .FifoEmpty  ( U5Empty       )
    );

    FIFO#(
        .FIFOWIDE   ( INSTQUEUEWIDE )
    )u6_FIFO(
        .Clk        ( Clk           ),
        .Rest       ( Rest          ),
        .Rable      ( Read6Able  && ~StopTemp),
        .Dout       ( Read6Date     ),
        .Wable      ( WriteU6Able && ~U6Full  ),
        .Din        ( Write6Date    ),
        .FifoClean  ( U6Clean       ),
        .FifoFull   ( U6Full        ),
        .FifoEmpty  ( U6Empty       )
    );

    FIFO#(
        .FIFOWIDE   ( INSTQUEUEWIDE )
    )u7_FIFO(
        .Clk        ( Clk           ),
        .Rest       ( Rest          ),
        .Rable      ( Read7Able  && ~StopTemp),
        .Dout       ( Read7Date     ),
        .Wable      ( WriteU7Able && ~U7Full  ),
        .Din        ( Write7Date    ),
        .FifoClean  ( U7Clean       ),
        .FifoFull   ( U7Full        ),
        .FifoEmpty  ( U7Empty       )
    );

    FIFO#(
        .FIFOWIDE   ( INSTQUEUEWIDE )
    )u8_FIFO(
        .Clk        ( Clk           ),
        .Rest       ( Rest          ),
        .Rable      ( Read8Able  && ~StopTemp),
        .Dout       ( Read8Date     ),
        .Wable      ( WriteU8Able && ~U8Full  ),
        .Din        ( Write8Date    ),
        .FifoClean  ( U8Clean       ),
        .FifoFull   ( U8Full        ),
        .FifoEmpty  ( U8Empty       )
    );
    
endmodule 
`timescale 1ps/1ps
`include "../define.v"
`include "../../Lib/BrCsrIQ1Criq4.v"
`include "../../Lib/BrCsrIQ2Criq4.v"
`include "../../Lib/BrCsrIQ3Criq4.v"
`include "../../Lib/BrCsrIQ4Criq4.v"

module IssueQueueBrCsr (
    input       wire                                      Clk               ,
    input       wire                                      Rest              ,
    //for ctrl
    input       wire                                      BrCsrStop         ,
    input       wire                                      BrCsrFlash        ,
    output      wire                                      BrCsrReq          ,
    //from RAT
    input       wire        [2:0]                         BInIQInstNum      ,
    input       wire                                      BIn1Src1Able      ,
    input       wire                                      BIn1Src1Ready     ,
    input       wire        [`ReNameRegBUs]               BIn1Src1Addr      ,
    input       wire                                      BIn1Src2Able      ,
    input       wire                                      BIn1Src2Ready     ,
    input       wire        [`ReNameRegBUs]               BIn1Src2Addr      ,
    input       wire                                      BIn1RdAble        ,
    input       wire        [`ReNameRegBUs]               BIn1RdAddr        ,
    input       wire                                      BIn2Src1Able      ,
    input       wire                                      BIn2Src1Ready     ,
    input       wire        [`ReNameRegBUs]               BIn2Src1Addr      ,
    input       wire                                      BIn2Src2Able      ,
    input       wire                                      BIn2Src2Ready     ,
    input       wire        [`ReNameRegBUs]               BIn2Src2Addr      ,
    input       wire                                      BIn2RdAble        ,
    input       wire        [`ReNameRegBUs]               BIn2RdAddr        ,
    input       wire                                      BIn3Src1Able      ,
    input       wire                                      BIn3Src1Ready     ,
    input       wire        [`ReNameRegBUs]               BIn3Src1Addr      ,
    input       wire                                      BIn3Src2Able      ,
    input       wire                                      BIn3Src2Ready     ,
    input       wire        [`ReNameRegBUs]               BIn3Src2Addr      ,
    input       wire                                      BIn3RdAble        ,
    input       wire        [`ReNameRegBUs]               BIn3RdAddr        ,
    input       wire                                      BIn4Src1Able      ,
    input       wire                                      BIn4Src1Ready     ,
    input       wire        [`ReNameRegBUs]               BIn4Src1Addr      ,
    input       wire                                      BIn4Src2Able      ,
    input       wire                                      BIn4Src2Ready     ,
    input       wire        [`ReNameRegBUs]               BIn4Src2Addr      ,
    input       wire                                      BIn4RdAble        ,
    input       wire        [`ReNameRegBUs]               BIn4RdAddr        ,
    //from decode delay 1 clcye
    input       wire                                      BIn1aAble         ,
    input       wire        [`MicOperateCode]             BIn1MicOpcode     ,
    input       wire                                      BIn1ImmAble       ,
    input       wire        [25:0]                        BIn1ImmDate       ,
    input       wire                                      BIn1Mode          ,
    input       wire        [`InstAddrBus]                BIn1ReDirAddr     ,
    input       wire        [6:0]                         BIn1RobPtr        ,
    input       wire                                      BIn2aAble         ,
    input       wire        [`MicOperateCode]             BIn2MicOpcode     ,
    input       wire                                      BIn2ImmAble       ,
    input       wire        [25:0]                        BIn2ImmDate       ,
    input       wire                                      BIn2Mode          ,
    input       wire        [`InstAddrBus]                BIn2ReDirAddr     ,
    input       wire        [6:0]                         BIn2RobPtr        ,
    input       wire                                      BIn3aAble         ,
    input       wire        [`MicOperateCode]             BIn3MicOpcode     ,
    input       wire                                      BIn3ImmAble       ,
    input       wire        [25:0]                        BIn3ImmDate       ,
    input       wire                                      BIn3Mode          ,
    input       wire        [`InstAddrBus]                BIn3ReDirAddr     ,
    input       wire        [6:0]                         BIn3RobPtr        ,
    input       wire                                      BIn4aAble         ,
    input       wire        [`MicOperateCode]             BIn4MicOpcode     ,
    input       wire                                      BIn4ImmAble       ,
    input       wire        [25:0]                        BIn4ImmDate       ,
    input       wire                                      BIn4Mode          ,
    input       wire        [`InstAddrBus]                BIn4ReDirAddr     ,
    input       wire        [6:0]                         BIn4RobPtr        ,
    //for req
    input       wire                                      CsrReq            ,
    input       wire                                      BrReq             ,
    //weak-up
    input       wire                                      FromIsQAlu1       ,
    input       wire        [`ReNameRegBUs]               FromAlu1Addr      , 
    input       wire                                      FromIsQAlu2       ,
    input       wire        [`ReNameRegBUs]               FromAlu2Addr      ,//delay broadcast
    input       wire                                      FromIsQMul        ,
    input       wire        [`ReNameRegBUs]               FromMulAddr       ,
    input       wire                                      ByPassBDiv        ,
    input       wire        [`ReNameRegBUs]               ByPassBDivAddr    ,
    input       wire                                      BypassBSC         ,
    input       wire        [`ReNameRegBUs]               BypassBSCAddr     ,
    input       wire                                      ByPassBLoad       ,
    input       wire        [`ReNameRegBUs]               ByPassBLoadAddr   ,//bypass
    //delay bus
    output      wire                                      OutCsrAble        ,
    output      wire        [`ReNameRegBUs]               OutCsrAddr        ,
    output      wire                                      OutBruAble        ,
    output      wire        [`ReNameRegBUs]               OutBruAddr        ,
    //to Eu
    output      wire        [`MicOperateCode]             BInst1MicOperate  , 
    output      wire                                      BInst1Src1RAble   ,
    output      wire        [`ReNameRegBUs]               BInst1Src1RAddr   , 
    output      wire                                      BInst1Src2RAble   ,
    output      wire        [`ReNameRegBUs]               BInst1Src2RAddr   ,    
    output      wire                                      BInst1ImmAble     ,
    output      wire        [25:0]                        BInst1ImmDate     ,
    output      wire                                      BInst1RdAble      ,
    output      wire        [`ReNameRegBUs]               BInst1RdAddr      , 
    output      wire                                      BInst1Mode        ,
    output      wire        [`InstAddrBus]                BInst1RedieAddr   ,
    output      wire        [5:0]                         BInst1RoBptr      ,
    output      wire        [`MicOperateCode]             BInst2MicOperate  , 
    output      wire                                      BInst2Src1RAble   ,
    output      wire        [`ReNameRegBUs]               BInst2Src1RAddr   , 
    output      wire                                      BInst2Src2RAble   ,
    output      wire        [`ReNameRegBUs]               BInst2Src2RAddr   ,    
    output      wire                                      BInst2ImmAble     ,
    output      wire        [25:0]                        BInst2ImmDate     ,
    output      wire                                      BInst2RdAble      ,
    output      wire        [`ReNameRegBUs]               BInst2RdAddr      , 
    output      wire        [5:0]                         BInst2RoBptr                                           
);

    reg StopTemp  ;
    reg FlashTemp ;

    always @(posedge Clk) begin
        if(!Rest) begin
            StopTemp    <= 1'b0 ;
            FlashTemp   <= 1'b0 ;
        end
        else begin
            StopTemp    <= BrCsrStop ;
            FlashTemp   <= BrCsrFlash;
        end
    end

    reg  [100:0] CBISSUE [0:15] ;

    reg  [2:0]  CBWritePtr ;
    reg  [2:0]  CBReadPtr  ;

    // wire [2:0]  ReadNum = BIn1aAble & BIn2aAble & BIn3aAble & BIn4aAble ? 3'd4 :
    //                       BIn1aAble & BIn2aAble & BIn3aAble & ~BIn4aAble ? 3'd3 :
    //                       BIn1aAble & BIn2aAble & ~BIn3aAble & ~BIn4aAble ? 3'd2 :
    //                       BIn1aAble & ~BIn2aAble & ~BIn3aAble & ~BIn4aAble ? 3'd1 : 3'd0 ;
                                                
    always @(posedge Clk) begin
        if(!Rest) begin
            CBReadPtr <= 3'd0 ;
        end        
        else begin
            CBReadPtr <= CBReadPtr[1:0] + BInIQInstNum ;
        end 
    end 

    wire                   BCsrIssueAble  ;
    wire  [`ReNameRegBUs]  BCsrIssueAddr  ; 
    wire                   BBrIssueAble   ;
    wire  [`ReNameRegBUs]  BBrIssueAddr   ; 

    wire         BInst1Src1Ready = ((BIn1Src1Addr == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                   ((BIn1Src1Addr == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                   ((BIn1Src1Addr == FromMulAddr    ) && (FromIsQMul )) ||
                                   ((BIn1Src1Addr == ByPassBDivAddr ) && (ByPassBDiv )) ||
                                   ((BIn1Src1Addr == BypassBSCAddr  ) && (BypassBSC  )) ||
                                   ((BIn1Src1Addr == ByPassBLoadAddr) && (ByPassBLoad)) ||
                                   ((BIn1Src1Addr == BCsrIssueAddr  ) && (BCsrIssueAble))||
                                   ((BIn1Src1Addr == BBrIssueAddr   ) && (BBrIssueAble)) ;

    wire         BInst2Src1Ready = ((BIn2Src1Addr == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                   ((BIn2Src1Addr == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                   ((BIn2Src1Addr == FromMulAddr    ) && (FromIsQMul )) ||
                                   ((BIn2Src1Addr == ByPassBDivAddr ) && (ByPassBDiv )) ||
                                   ((BIn2Src1Addr == BypassBSCAddr  ) && (BypassBSC  )) ||
                                   ((BIn2Src1Addr == ByPassBLoadAddr) && (ByPassBLoad)) ||
                                   ((BIn2Src1Addr == BCsrIssueAddr  ) && (BCsrIssueAble))||
                                   ((BIn2Src1Addr == BBrIssueAddr   ) && (BBrIssueAble)) ;

    wire         BInst3Src1Ready = ((BIn3Src1Addr == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                   ((BIn3Src1Addr == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                   ((BIn3Src1Addr == FromMulAddr    ) && (FromIsQMul )) ||
                                   ((BIn3Src1Addr == ByPassBDivAddr ) && (ByPassBDiv )) ||
                                   ((BIn3Src1Addr == BypassBSCAddr  ) && (BypassBSC  )) ||
                                   ((BIn3Src1Addr == ByPassBLoadAddr) && (ByPassBLoad)) ||
                                   ((BIn3Src1Addr == BCsrIssueAddr  ) && (BCsrIssueAble))||
                                   ((BIn3Src1Addr == BBrIssueAddr   ) && (BBrIssueAble)) ;

    wire         BInst4Src1Ready = ((BIn4Src1Addr == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                   ((BIn4Src1Addr == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                   ((BIn4Src1Addr == FromMulAddr    ) && (FromIsQMul )) ||
                                   ((BIn4Src1Addr == ByPassBDivAddr ) && (ByPassBDiv )) ||
                                   ((BIn4Src1Addr == BypassBSCAddr  ) && (BypassBSC  )) ||
                                   ((BIn4Src1Addr == ByPassBLoadAddr) && (ByPassBLoad)) ||
                                   ((BIn4Src1Addr == BCsrIssueAddr  ) && (BCsrIssueAble))||
                                   ((BIn4Src1Addr == BBrIssueAddr   ) && (BBrIssueAble)) ;

    wire         BInst1Src2Ready = ((BIn1Src2Addr == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                   ((BIn1Src2Addr == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                   ((BIn1Src2Addr == FromMulAddr    ) && (FromIsQMul )) ||
                                   ((BIn1Src2Addr == ByPassBDivAddr ) && (ByPassBDiv )) ||
                                   ((BIn1Src2Addr == BypassBSCAddr  ) && (BypassBSC  )) ||
                                   ((BIn1Src2Addr == ByPassBLoadAddr) && (ByPassBLoad)) ||
                                   ((BIn1Src2Addr == BCsrIssueAddr  ) && (BCsrIssueAble))||
                                   ((BIn1Src2Addr == BBrIssueAddr   ) && (BBrIssueAble)) ;

    wire         BInst2Src2Ready = ((BIn2Src2Addr == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                   ((BIn2Src2Addr == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                   ((BIn2Src2Addr == FromMulAddr    ) && (FromIsQMul )) ||
                                   ((BIn2Src2Addr == ByPassBDivAddr ) && (ByPassBDiv )) ||
                                   ((BIn2Src2Addr == BypassBSCAddr  ) && (BypassBSC  )) ||
                                   ((BIn2Src2Addr == ByPassBLoadAddr) && (ByPassBLoad)) ||
                                   ((BIn2Src2Addr == BCsrIssueAddr  ) && (BCsrIssueAble))||
                                   ((BIn2Src2Addr == BBrIssueAddr   ) && (BBrIssueAble)) ;

    wire         BInst3Src2Ready = ((BIn3Src2Addr == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                   ((BIn3Src2Addr == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                   ((BIn3Src2Addr == FromMulAddr    ) && (FromIsQMul )) ||
                                   ((BIn3Src2Addr == ByPassBDivAddr ) && (ByPassBDiv )) ||
                                   ((BIn3Src2Addr == BypassBSCAddr  ) && (BypassBSC  )) ||
                                   ((BIn3Src2Addr == ByPassBLoadAddr) && (ByPassBLoad)) ||
                                   ((BIn3Src2Addr == BCsrIssueAddr  ) && (BCsrIssueAble))||
                                   ((BIn3Src2Addr == BBrIssueAddr   ) && (BBrIssueAble)) ;

    wire         BInst4Src2Ready = ((BIn4Src2Addr == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                   ((BIn4Src2Addr == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                   ((BIn4Src2Addr == FromMulAddr    ) && (FromIsQMul )) ||
                                   ((BIn4Src2Addr == ByPassBDivAddr ) && (ByPassBDiv )) ||
                                   ((BIn4Src2Addr == BypassBSCAddr  ) && (BypassBSC  )) ||
                                   ((BIn4Src2Addr == ByPassBLoadAddr) && (ByPassBLoad)) ||
                                   ((BIn4Src2Addr == BCsrIssueAddr  ) && (BCsrIssueAble))||
                                   ((BIn4Src2Addr == BBrIssueAddr   ) && (BBrIssueAble)) ;

    wire [100:0] Write1Issue = {BIn1ReDirAddr,BIn1RobPtr,BIn1Src2Able,((StopTemp | BIn1Src2Ready | ~BIn1Src2Able) ? BIn1Src2Ready : BInst1Src2Ready),BIn1Src2Addr,
                                                         BIn1Src1Able,((StopTemp | BIn1Src1Ready | ~BIn1Src1Able) ? BIn1Src1Ready : BInst1Src1Ready),BIn1Src1Addr,
                                                         BIn1RdAble,BIn1RdAddr,BIn1MicOpcode,BIn1ImmAble,BIn1ImmDate,BIn1Mode} ; 
    wire [100:0] Write2Issue = {BIn2ReDirAddr,BIn2RobPtr,BIn2Src2Able,((StopTemp | BIn2Src2Ready | ~BIn2Src2Able) ? BIn2Src2Ready : BInst2Src2Ready),BIn2Src2Addr,
                                                         BIn2Src1Able,((StopTemp | BIn2Src1Ready | ~BIn2Src1Able) ? BIn2Src1Ready : BInst2Src1Ready),BIn2Src1Addr,
                                                         BIn2RdAble,BIn2RdAddr,BIn2MicOpcode,BIn2ImmAble,BIn2ImmDate,BIn2Mode} ;  
    wire [100:0] Write3Issue = {BIn3ReDirAddr,BIn3RobPtr,BIn3Src2Able,((StopTemp | BIn3Src2Ready | ~BIn3Src2Able) ? BIn3Src2Ready : BInst3Src2Ready),BIn3Src2Addr,
                                                         BIn3Src1Able,((StopTemp | BIn3Src1Ready | ~BIn3Src1Able) ? BIn3Src1Ready : BInst3Src1Ready),BIn3Src1Addr,
                                                         BIn3RdAble,BIn3RdAddr,BIn3MicOpcode,BIn3ImmAble,BIn3ImmDate,BIn3Mode} ;
    wire [100:0] Write4Issue = {BIn4ReDirAddr,BIn4RobPtr,BIn4Src2Able,((StopTemp | BIn4Src2Ready | ~BIn4Src2Able) ? BIn4Src2Ready : BInst4Src2Ready),BIn4Src2Addr,
                                                         BIn4Src1Able,((StopTemp | BIn4Src1Ready | ~BIn4Src1Able) ? BIn4Src1Ready : BInst4Src1Ready),BIn4Src1Addr,
                                                         BIn4RdAble,BIn4RdAddr,BIn4MicOpcode,BIn4ImmAble,BIn4ImmDate,BIn4Mode} ;

    wire          U1ReadAble  ;
    wire          U2ReadAble  ;
    wire          U3ReadAble  ;
    wire          U4ReadAble  ;
    wire  [100:0] WriteDate1  ;
    wire  [100:0] WriteDate2  ;
    wire  [100:0] WriteDate3  ;
    wire  [100:0] WriteDate4  ;

    assign {WriteDate1,U1ReadAble}   =  (CBReadPtr[1:0] == 0) ? {Write1Issue,BIn1aAble} : 
                                        (CBReadPtr[1:0] == 1) ? {Write4Issue,BIn4aAble} :
                                        (CBReadPtr[1:0] == 2) ? {Write3Issue,BIn3aAble} :
                                        (CBReadPtr[1:0] == 3) ? {Write2Issue,BIn2aAble} : {101'd0,`EnableValue} ;

    assign {WriteDate2,U2ReadAble}   =  (CBReadPtr[1:0] == 0) ? {Write2Issue,BIn2aAble} :
                                        (CBReadPtr[1:0] == 1) ? {Write1Issue,BIn1aAble} :
                                        (CBReadPtr[1:0] == 2) ? {Write4Issue,BIn4aAble} :
                                        (CBReadPtr[1:0] == 3) ? {Write3Issue,BIn3aAble} : {101'd0,`EnableValue} ;

    assign {WriteDate3,U3ReadAble}   =  (CBReadPtr[1:0] == 0) ? {Write3Issue,BIn3aAble} :
                                        (CBReadPtr[1:0] == 1) ? {Write2Issue,BIn2aAble} :
                                        (CBReadPtr[1:0] == 2) ? {Write1Issue,BIn1aAble} :
                                        (CBReadPtr[1:0] == 3) ? {Write4Issue,BIn4aAble} : {101'd0,`EnableValue} ;

    assign {WriteDate4,U4ReadAble}   =  (CBReadPtr[1:0] == 0) ? {Write4Issue,BIn4aAble} :
                                        (CBReadPtr[1:0] == 1) ? {Write3Issue,BIn3aAble} :
                                        (CBReadPtr[1:0] == 2) ? {Write2Issue,BIn2aAble} :
                                        (CBReadPtr[1:0] == 3) ? {Write1Issue,BIn1aAble} : {101'd0,`EnableValue} ;

    wire [3:0] CriqPreOut1 ;
    wire [3:0] CriqPreOut2 ;
    wire [3:0] CriqPreOut3 ;
    wire [3:0] CriqPreOut4 ;

    wire [7:0] CBQWritePtr ;
    wire       CBQWrite1   ;
    wire       CBQWrite2   ;

    assign {CBQWritePtr,CBQWrite1,CBQWrite2} = {10{({BCsrIssueAble,BBrIssueAble} == 2'b11)}} & {BCsrIssueAddr,BBrIssueAddr,2'b11} |
                                               {10{({BCsrIssueAble,BBrIssueAble} == 2'b10)}} & {4'b0,BCsrIssueAddr,2'b01} |   
                                               {10{({BCsrIssueAble,BBrIssueAble} == 2'b01)}} & {4'b0,BBrIssueAddr,2'b01} ;   

    wire [1:0] CBQWriteNum = (CBQWrite1 & CBQWrite2)  & 2'b10 |
                             (CBQWrite1 & ~CBQWrite2) & 2'b01 ;

    always @(posedge Clk) begin
        if(!Rest) begin
            CBWritePtr <= 3'b0 ;
        end
        else if(BrCsrFlash) begin
            CBWritePtr <= 3'b0 ; 
        end
        else begin
            CBWritePtr <= CBWritePtr[1:0] + CBQWriteNum ;
        end
    end

    wire        WriteCriq1Able = (CBWritePtr[1:0] == 0) ? CBQWrite1    : 
                                 (CBWritePtr[1:0] == 1) ? `EnableValue : 
                                 (CBWritePtr[1:0] == 2) ? `EnableValue : 
                                 (CBWritePtr[1:0] == 3) ? CBQWrite2    : `EnableValue ;
    wire        WriteCriq2Able = (CBWritePtr[1:0] == 0) ? CBQWrite2    : 
                                 (CBWritePtr[1:0] == 1) ? CBQWrite1    : 
                                 (CBWritePtr[1:0] == 2) ? `EnableValue : 
                                 (CBWritePtr[1:0] == 3) ? `EnableValue : `EnableValue ;
    wire        WriteCriq3Able = (CBWritePtr[1:0] == 0) ? `EnableValue : 
                                 (CBWritePtr[1:0] == 1) ? CBQWrite2    : 
                                 (CBWritePtr[1:0] == 2) ? CBQWrite1    : 
                                 (CBWritePtr[1:0] == 3) ? `EnableValue : `EnableValue ;
    wire        WriteCriq4Able = (CBWritePtr[1:0] == 0) ? `EnableValue : 
                                 (CBWritePtr[1:0] == 1) ? `EnableValue : 
                                 (CBWritePtr[1:0] == 2) ? CBQWrite2    : 
                                 (CBWritePtr[1:0] == 3) ? CBQWrite1    : `EnableValue ;
    
    wire  [3:0] WriteCriq1Addr = (CBWritePtr[1:0] == 0) ? CBQWritePtr[3:0]     : 
                                 (CBWritePtr[1:0] == 1) ? 4'b0 : 
                                 (CBWritePtr[1:0] == 2) ? 4'b0 : 
                                 (CBWritePtr[1:0] == 3) ? CBQWritePtr[7:4]     : 4'b0 ;
    wire  [3:0] WriteCriq2Addr = (CBWritePtr[1:0] == 0) ? CBQWritePtr[7:4]     :  
                                 (CBWritePtr[1:0] == 1) ? CBQWritePtr[3:0]     : 
                                 (CBWritePtr[1:0] == 2) ? 4'b0 : 
                                 (CBWritePtr[1:0] == 3) ? 4'b0 : 4'b0 ;
    wire  [3:0] WriteCriq3Addr = (CBWritePtr[1:0] == 0) ? 4'b0: 
                                 (CBWritePtr[1:0] == 1) ? CBQWritePtr[7:4]     : 
                                 (CBWritePtr[1:0] == 2) ? CBQWritePtr[3:0]     : 
                                 (CBWritePtr[1:0] == 3) ? 4'b0 : 4'b0 ;
    wire  [3:0] WriteCriq4Addr = (CBWritePtr[1:0] == 0) ? 4'b0 : 
                                 (CBWritePtr[1:0] == 1) ? 4'b0 : 
                                 (CBWritePtr[1:0] == 2) ? CBQWritePtr[7:4]     : 
                                 (CBWritePtr[1:0] == 3) ? CBQWritePtr[3:0]     : 4'b0 ;


    wire  CriqEmpty1 ;
    wire  CriqEmpty2 ;
    wire  CriqEmpty3 ;
    wire  CriqEmpty4 ;

    assign BrCsrReq = CriqEmpty1 | CriqEmpty2 | CriqEmpty3 | CriqEmpty4 ;

    BrCsrIQ1Criq4#(
        .CRIQWIDE    ( 4 ),
        .CRIQDEEP    ( 4 )
    )u_BrCsrIQ1Criq4(
        .Clk         ( Clk             ),
        .Rest        ( Rest            ),
        .Rable       ( U1ReadAble & ~StopTemp ),
        .CriqPreOut  ( CriqPreOut1     ),
        .Wable       ( WriteCriq1Able & ~StopTemp  ),
        .Din         ( WriteCriq1Addr  ),
        .CriqClean   ( FLashTemp      ),
        .CriqEmpty   ( CriqEmpty1      )
    );

    BrCsrIQ2Criq4#(
        .CRIQWIDE    ( 4 ),
        .CRIQDEEP    ( 4 )
    )u_BrCsrIQ2Criq4(
        .Clk         ( Clk             ),
        .Rest        ( Rest            ),
        .Rable       ( U2ReadAble & ~StopTemp      ),
        .CriqPreOut  ( CriqPreOut2     ),
        .Wable       ( WriteCriq2Able & ~StopTemp  ),
        .Din         ( WriteCriq2Addr  ),
        .CriqClean   ( FLashTemp      ),
        .CriqEmpty   ( CriqEmpty2      )
    );

    BrCsrIQ3Criq4#(
        .CRIQWIDE    ( 4 ),
        .CRIQDEEP    ( 4 )
    )u_BrCsrIQ3Criq4(
        .Clk         ( Clk            ),
        .Rest        ( Rest           ),
        .Rable       ( U3ReadAble & ~StopTemp     ),
        .CriqPreOut  ( CriqPreOut3    ),
        .Wable       ( WriteCriq3Able & ~StopTemp ),
        .Din         ( WriteCriq3Addr ),
        .CriqClean   ( FLashTemp     ),
        .CriqEmpty   ( CriqEmpty3     )
    );

    BrCsrIQ4Criq4#(
        .CRIQWIDE    ( 4 ),
        .CRIQDEEP    ( 4 )
    )u_BrCsrIQ4Criq4(
        .Clk         ( Clk            ),
        .Rest        ( Rest           ),
        .Rable       ( U4ReadAble & ~StopTemp     ),
        .CriqPreOut  ( CriqPreOut4    ),
        .Wable       ( WriteCriq4Able & ~StopTemp ),
        .Din         ( WriteCriq4Addr ),
        .CriqClean   ( FLashTemp     ),
        .CriqEmpty   ( CriqEmpty4     )
    );

    wire [3:0] BrSelectOldS1 [0:7] ;
    wire       BrSelectAblS1 [0:7] ;
    wire [3:0] CsSelectOldS1 [0:7] ;
    wire       CsSelectAblS1 [0:7] ;

    genvar a ;
    generate
        for (i =0 ;i<16 ;i=i+2) begin
            assign BrSelectOldS1[a/2] = {4{((CBISSUE[i][68] == CBISSUE[i+1][68]) & (CBISSUE[i][67:62] < CBISSUE[i+1][67:62]) & (CBISSUE[i][35:28] == `BRCODE) & (CBISSUE[i+1][35:28] == `BRCODE))}} & i |
                                        {4{((CBISSUE[i][68] != CBISSUE[i+1][68]) & (CBISSUE[i][67:62] > CBISSUE[i+1][67:62]) & (CBISSUE[i][35:28] == `BRCODE) & (CBISSUE[i+1][35:28] == `BRCODE))}} & i |
                                        {4{(CBISSUE[i][35:28] == `BRCODE) & ~(CBISSUE[i+1][35:28] == `BRCODE)}} & i |
                                        {4{~(CBISSUE[i][35:28] == `BRCODE) & (CBISSUE[i+1][35:28] == `BRCODE)}} & i+1 | 
                                        {4{((CBISSUE[i][68] == CBISSUE[i+1][68]) & (CBISSUE[i][67:62] > CBISSUE[i+1][67:62]) & (CBISSUE[i][35:28] == `BRCODE) & (CBISSUE[i+1][35:28] == `BRCODE))}} & i+1 |
                                        {4{((CBISSUE[i][68] != CBISSUE[i+1][68]) & (CBISSUE[i][67:62] < CBISSUE[i+1][67:62]) & (CBISSUE[i][35:28] == `BRCODE) & (CBISSUE[i+1][35:28] == `BRCODE))}} & i+1 ;
            assign BrSelectAblS1[a/2] = ~((~CBISSUE[i][35:28] == `BRCODE) & ~(CBISSUE[i+1][35:28] == `BRCODE)) | `AbleValue ;
            assign CsSelectOldS1[a/2] = {4{((CBISSUE[i][68] == CBISSUE[i+1][68]) & (CBISSUE[i][67:62] < CBISSUE[i+1][67:62]) & (CBISSUE[i][35:28] == `CSRCODE) & (CBISSUE[i+1][35:28] == `CSRCODE))}} & i |
                                        {4{((CBISSUE[i][68] != CBISSUE[i+1][68]) & (CBISSUE[i][67:62] > CBISSUE[i+1][67:62]) & (CBISSUE[i][35:28] == `CSRCODE) & (CBISSUE[i+1][35:28] == `CSRCODE))}} & i |
                                        {4{(CBISSUE[i][35:28] == `CSRCODE) & ~(CBISSUE[i+1][35:28] == `CSRCODE)}} & i |
                                        {4{~(CBISSUE[i][35:28] == `CSRCODE) & (CBISSUE[i+1][35:28] == `CSRCODE)}} & i+1 | 
                                        {4{((CBISSUE[i][68] == CBISSUE[i+1][68]) & (CBISSUE[i][67:62] > CBISSUE[i+1][67:62]) & (CBISSUE[i][35:28] == `CSRCODE) & (CBISSUE[i+1][35:28] == `CSRCODE))}} & i+1 |
                                        {4{((CBISSUE[i][68] != CBISSUE[i+1][68]) & (CBISSUE[i][67:62] < CBISSUE[i+1][67:62]) & (CBISSUE[i][35:28] == `CSRCODE) & (CBISSUE[i+1][35:28] == `CSRCODE))}} & i+1 ;
            assign CsSelectAblS1[a/2] = ~((~CBISSUE[i][35:28] == `CSRCODE) & ~(CBISSUE[i+1][35:28] == `CSRCODE)) | `AbleValue ;
        end   
    endgenerate


    wire [3:0] BrSelectOldS2 [0:3] ;
    wire       BrSelectAblS2 [0:3] ;
    wire [3:0] CsSelectOldS2 [0:3] ;
    wire       CsSelectAblS2 [0:3] ;

    genvar b ;
    generate
        for (b =0 ;b<8 ; b=b+2) begin
            assign BrSelectOldS2[b/2] = {4{(BrSelectAblS1[b] & BrSelectAblS1[b+1]) & (CBISSUE[BrSelectOldS1[b]][68] == CBISSUE[BrSelectOldS1[b+1]][68]) & (CBISSUE[BrSelectOldS1[b]][67:62] < CBISSUE[BrSelectOldS1[b+1]][67:62])}} & BrSelectOldS1[b] |
                                        {4{(BrSelectAblS1[b] & BrSelectAblS1[b+1]) & (CBISSUE[BrSelectOldS1[b]][68] != CBISSUE[BrSelectOldS1[b+1]][68]) & (CBISSUE[BrSelectOldS1[b]][67:62] > CBISSUE[BrSelectOldS1[b+1]][67:62])}} & BrSelectOldS1[b] |
                                        {4{(BrSelectAblS1[b] & ~BrSelectAblS1[b+1])}} & BrSelectOldS1[b] |
                                        {4{(~BrSelectAblS1[b] & BrSelectAblS1[b+1])}} & BrSelectOldS1[b+1] |
                                        {4{(BrSelectAblS1[b] & BrSelectAblS1[b+1]) & (CBISSUE[BrSelectOldS1[b]][68] == CBISSUE[BrSelectOldS1[b+1]][68]) & (CBISSUE[BrSelectOldS1[b]][67:62] > CBISSUE[BrSelectOldS1[b+1]][67:62])}} & BrSelectOldS1[b+1] |
                                        {4{(BrSelectAblS1[b] & BrSelectAblS1[b+1]) & (CBISSUE[BrSelectOldS1[b]][68] != CBISSUE[BrSelectOldS1[b+1]][68]) & (CBISSUE[BrSelectOldS1[b]][67:62] < CBISSUE[BrSelectOldS1[b+1]][67:62])}} & BrSelectOldS1[b+1] ;
            assign BrSelectAblS2[b/2] = ~(~BrSelectAblS1[b] & ~BrSelectAblS1[b+1]) & `AbleValue ;
            assign CsSelectOldS2[b/2] = {4{(CsSelectAblS1[b] & CsSelectAblS1[b+1]) & (CBISSUE[CsSelectOldS1[b]][68] == CBISSUE[CsSelectOldS1[b+1]][68]) & (CBISSUE[CsSelectOldS1[b]][67:62] < CBISSUE[CsSelectOldS1[b+1]][67:62])}} & CsSelectOldS1[b] |
                                        {4{(CsSelectAblS1[b] & CsSelectAblS1[b+1]) & (CBISSUE[CsSelectOldS1[b]][68] != CBISSUE[CsSelectOldS1[b+1]][68]) & (CBISSUE[CsSelectOldS1[b]][67:62] > CBISSUE[CsSelectOldS1[b+1]][67:62])}} & CsSelectOldS1[b] |
                                        {4{(CsSelectAblS1[b] & ~CsSelectAblS1[b+1])}} & CsSelectOldS1[b] |
                                        {4{(~CsSelectAblS1[b] & CsSelectAblS1[b+1])}} & CsSelectOldS1[b+1] |
                                        {4{(CsSelectAblS1[b] & CsSelectAblS1[b+1]) & (CBISSUE[CsSelectOldS1[b]][68] == CBISSUE[CsSelectOldS1[b+1]][68]) & (CBISSUE[CsSelectOldS1[b]][67:62] > CBISSUE[CsSelectOldS1[b+1]][67:62])}} & CsSelectOldS1[b+1] |
                                        {4{(CsSelectAblS1[b] & CsSelectAblS1[b+1]) & (CBISSUE[CsSelectOldS1[b]][68] != CBISSUE[CsSelectOldS1[b+1]][68]) & (CBISSUE[CsSelectOldS1[b]][67:62] < CBISSUE[CsSelectOldS1[b+1]][67:62])}} & CsSelectOldS1[b+1] ;
            assign CsSelectAblS2[b/2] = ~(~CsSelectAblS1[b] & ~CsSelectAblS1[b+1]) & `AbleValue ;
        end
    endgenerate

    wire [3:0] BrSelectOldS3 [0:1] ;
    wire       BrSelectAblS3 [0:1] ;
    wire [3:0] CsSelectOldS3 [0:1] ;
    wire       CsSelectAblS3 [0:1] ;

    genvar c ;
    generate
        for (c =0 ;c<4 ;c=c+2 ) begin
            assign BrSelectOldS3[c/2] = {4{(BrSelectAblS2[c] & BrSelectAblS2[c+1]) & (CBISSUE[BrSelectOldS2[c]][68] == CBISSUE[BrSelectOldS2[c+1]][68]) & (CBISSUE[BrSelectOldS2[c]][67:62] < CBISSUE[BrSelectOldS2[c+1]][67:62])}} &  BrSelectOldS2[c] |
                                        {4{(BrSelectAblS2[c] & BrSelectAblS2[c+1]) & (CBISSUE[BrSelectOldS2[c]][68] != CBISSUE[BrSelectOldS2[c+1]][68]) & (CBISSUE[BrSelectOldS2[c]][67:62] > CBISSUE[BrSelectOldS2[c+1]][67:62])}} &  BrSelectOldS2[c] |
                                        {4{(BrSelectAblS2[c] & ~BrSelectAblS2[c+1])}} & BrSelectOldS2[c] |
                                        {4{(~BrSelectAblS2[c] & BrSelectAblS2[c+1])}} & BrSelectOldS2[c+1] |  
                                        {4{(BrSelectAblS2[c] & BrSelectAblS2[c+1]) & (CBISSUE[BrSelectOldS2[c]][68] == CBISSUE[BrSelectOldS2[c+1]][68]) & (CBISSUE[BrSelectOldS2[c]][67:62] > CBISSUE[BrSelectOldS2[c+1]][67:62])}} &  BrSelectOldS2[c+1] |
                                        {4{(BrSelectAblS2[c] & BrSelectAblS2[c+1]) & (CBISSUE[BrSelectOldS2[c]][68] != CBISSUE[BrSelectOldS2[c+1]][68]) & (CBISSUE[BrSelectOldS2[c]][67:62] < CBISSUE[BrSelectOldS2[c+1]][67:62])}} &  BrSelectOldS2[c+1] ;
            assign BrSelectAblS3[c/2] = ~(~BrSelectAblS2[c] & ~BrSelectAblS2[c+1]) & `AbleValue ;
            assign CsSelectOldS3[c/2] = {4{(CsSelectAblS2[c] & CsSelectAblS2[c+1]) & (CBISSUE[CsSelectOldS2[c]][68] == CBISSUE[CsSelectOldS2[c+1]][68]) & (CBISSUE[CsSelectOldS2[c]][67:62] < CBISSUE[CsSelectOldS2[c+1]][67:62])}} &  CsSelectOldS2[c] |
                                        {4{(CsSelectAblS2[c] & CsSelectAblS2[c+1]) & (CBISSUE[CsSelectOldS2[c]][68] != CBISSUE[CsSelectOldS2[c+1]][68]) & (CBISSUE[CsSelectOldS2[c]][67:62] > CBISSUE[CsSelectOldS2[c+1]][67:62])}} &  CsSelectOldS2[c] |
                                        {4{(CsSelectAblS2[c] & ~CsSelectAblS2[c+1])}} & CsSelectOldS2[c] |
                                        {4{(~CsSelectAblS2[c] & CsSelectAblS2[c+1])}} & CsSelectOldS2[c+1] |  
                                        {4{(CsSelectAblS2[c] & CsSelectAblS2[c+1]) & (CBISSUE[CsSelectOldS2[c]][68] == CBISSUE[CsSelectOldS2[c+1]][68]) & (CBISSUE[CsSelectOldS2[c]][67:62] > CBISSUE[CsSelectOldS2[c+1]][67:62])}} &  CsSelectOldS2[c+1] |
                                        {4{(CsSelectAblS2[c] & CsSelectAblS2[c+1]) & (CBISSUE[CsSelectOldS2[c]][68] != CBISSUE[CsSelectOldS2[c+1]][68]) & (CBISSUE[CsSelectOldS2[c]][67:62] < CBISSUE[CsSelectOldS2[c+1]][67:62])}} &  CsSelectOldS2[c+1] ;
            assign CsSelectAblS3[c/2] = ~(~CsSelectAblS2[c] & ~CsSelectAblS2[c+1]) | `AbleValue ;
        end
    endgenerate

    wire [3:0] BrSelectOldS4 ;
    wire       BrSelectAblS4 ;
    wire [3:0] CsSelectOldS4 ;
    wire       CsSelectAblS4 ;

    assign BrSelectOldS4  = {4{(BrSelectAblS3[0] & BrSelectAblS3[1]) & (CBISSUE[BrSelectOldS3[0]][68] == CBISSUE[BrSelectOldS3[1]][68]) & (CBISSUE[BrSelectOldS3[0]][67:62] < CBISSUE[BrSelectOldS3[1]][67:62])}} &  BrSelectOldS3[0] |
                            {4{(BrSelectAblS3[0] & BrSelectAblS3[1]) & (CBISSUE[BrSelectOldS3[0]][68] != CBISSUE[BrSelectOldS3[1]][68]) & (CBISSUE[BrSelectOldS3[0]][67:62] > CBISSUE[BrSelectOldS3[1]][67:62])}} &  BrSelectOldS3[0] |
                            {4{(BrSelectAblS3[0] & ~BrSelectAblS3[1])}} & BrSelectOldS3[0] |
                            {4{(~BrSelectAblS3[0] & BrSelectAblS3[1])}} & BrSelectOldS3[1] |  
                            {4{(BrSelectAblS3[0] & BrSelectAblS3[1]) & (CBISSUE[BrSelectOldS3[0]][68] == CBISSUE[BrSelectOldS3[1]][68]) & (CBISSUE[BrSelectOldS3[0]][67:62] > CBISSUE[BrSelectOldS3[1]][67:62])}} &  BrSelectOldS3[1] |
                            {4{(BrSelectAblS3[0] & BrSelectAblS3[1]) & (CBISSUE[BrSelectOldS3[0]][68] != CBISSUE[BrSelectOldS3[1]][68]) & (CBISSUE[BrSelectOldS3[0]][67:62] < CBISSUE[BrSelectOldS3[1]][67:62])}} &  BrSelectOldS3[1] ;
    assign BrSelectAblS4  = ~(BrSelectAblS3[0] & ~BrSelectAblS3[1]) & `AbleValue ;
    assign CsSelectOldS4  = {4{(CsSelectAblS3[0] & CsSelectAblS3[1]) & (CBISSUE[CsSelectOldS3[0]][68] == CBISSUE[CsSelectOldS3[1]][68]) & (CBISSUE[CsSelectOldS3[0]][67:62] < CBISSUE[CsSelectOldS3[1]][67:62])}} &  CsSelectOldS3[0] |
                            {4{(CsSelectAblS3[0] & CsSelectAblS3[1]) & (CBISSUE[CsSelectOldS3[0]][68] != CBISSUE[CsSelectOldS3[1]][68]) & (CBISSUE[CsSelectOldS3[0]][67:62] > CBISSUE[CsSelectOldS3[1]][67:62])}} &  CsSelectOldS3[0] |
                            {4{(CsSelectAblS3[0] & ~CsSelectAblS3[1])}} & CsSelectOldS3[0] |
                            {4{(~CsSelectAblS3[0] & CsSelectAblS3[1])}} & CsSelectOldS3[1] |  
                            {4{(CsSelectAblS3[0] & CsSelectAblS3[1]) & (CBISSUE[CsSelectOldS3[0]][68] == CBISSUE[CsSelectOldS3[1]][68]) & (CBISSUE[CsSelectOldS3[0]][67:62] > CBISSUE[CsSelectOldS3[1]][67:62])}} &  CsSelectOldS3[1] |
                            {4{(CsSelectAblS3[0] & CsSelectAblS3[1]) & (CBISSUE[CsSelectOldS3[0]][68] != CBISSUE[CsSelectOldS3[1]][68]) & (CBISSUE[CsSelectOldS3[0]][67:62] < CBISSUE[CsSelectOldS3[1]][67:62])}} &  CsSelectOldS3[1] ;
    assign CsSelectAblS4  = ~(CsSelectAblS3[0] & ~CsSelectAblS3[1]) & `AbleValue ;

    wire                 FinalBrSendAble = BrReq  & BrSelectAblS4 & (~CBISSUE[BrSelectOldS4][61] | CBISSUE[BrSelectOldS4][60]) & (~CBISSUE[BrSelectOldS4][52] | CBISSUE[BrSelectOldS4][51]) ;
    wire                 FinalCsSendAble = CsrReq & CsSelectAblS4 & (~CBISSUE[CsSelectOldS4][61] | CBISSUE[CsSelectOldS4][60]) & (~CBISSUE[CsSelectOldS4][52] | CBISSUE[CsSelectOldS4][51]) ;


    reg  [`MicOperateCode]    RegBInst1MicOperate  ;
    reg                       RegBInst1Src1RAble   ;
    reg  [`ReNameRegBUs]      RegBInst1Src1RAddr   ; 
    reg                       RegBInst1Src2RAble   ;
    reg  [`ReNameRegBUs]      RegBInst1Src2RAddr   ;    
    reg                       RegBInst1ImmAble     ;
    reg  [25:0]               RegBInst1ImmDate     ;
    reg                       RegBInst1RdAble      ;
    reg  [`ReNameRegBUs]      RegBInst1RdAddr      ; 
    reg                       RegBInst1Mode        ;
    reg  [`InstAddrBus]       RegBInst1RedieAddr   ;
    reg  [5:0]                RegBInst1RoBptr      ;

    reg  [`MicOperateCode]    RegBInst2MicOperate  ;
    reg                       RegBInst2Src1RAble   ;
    reg  [`ReNameRegBUs]      RegBInst2Src1RAddr   ; 
    reg                       RegBInst2Src2RAble   ;
    reg  [`ReNameRegBUs]      RegBInst2Src2RAddr   ;    
    reg                       RegBInst2ImmAble     ;
    reg  [25:0]               RegBInst2ImmDate     ;
    reg                       RegBInst2RdAble      ;
    reg  [`ReNameRegBUs]      RegBInst2RdAddr      ; 
    reg  [5:0]                RegBInst2RoBptr      ;

    always @(posedge Clk) begin
        if(!Rest) begin
            RegBInst1MicOperate <=  8'b0;
            RegBInst1Src1RAble  <=  `EnableValue;
            RegBInst1Src1RAddr  <=  7'b0; 
            RegBInst1Src2RAble  <=  `EnableValue; 
            RegBInst1Src2RAddr  <=  7'b0;   
            RegBInst1ImmAble    <=  `EnableValue; 
            RegBInst1ImmDate    <=  26'b0; 
            RegBInst1RdAble     <=  `EnableValue; 
            RegBInst1RdAddr     <=  7'b0;  
            RegBInst1Mode       <=  `EnableValue; 
            RegBInst1RedieAddr  <=  32'b0; 
            RegBInst1RoBptr     <=  6'b0; 

            RegBInst2MicOperate <=  8'b0;
            RegBInst2Src1RAble  <=  `EnableValue;
            RegBInst2Src1RAddr  <=  7'b0; 
            RegBInst2Src2RAble  <=  `EnableValue; 
            RegBInst2Src2RAddr  <=  7'b0;   
            RegBInst2ImmAble    <=  `EnableValue; 
            RegBInst2ImmDate    <=  26'b0; 
            RegBInst2RdAble     <=  `EnableValue; 
            RegBInst2RdAddr     <=  7'b0;   
            RegBInst2RoBptr     <=  6'b0; 
        end
        else if(BrCsrFlash) begin
            RegBInst1MicOperate <=  8'b0;
            RegBInst1Src1RAble  <=  `EnableValue;
            RegBInst1Src1RAddr  <=  7'b0; 
            RegBInst1Src2RAble  <=  `EnableValue; 
            RegBInst1Src2RAddr  <=  7'b0;   
            RegBInst1ImmAble    <=  `EnableValue; 
            RegBInst1ImmDate    <=  26'b0; 
            RegBInst1RdAble     <=  `EnableValue; 
            RegBInst1RdAddr     <=  7'b0;  
            RegBInst1Mode       <=  `EnableValue; 
            RegBInst1RedieAddr  <=  32'b0; 
            RegBInst1RoBptr     <=  6'b0; 

            RegBInst2MicOperate <=  8'b0;
            RegBInst2Src1RAble  <=  `EnableValue;
            RegBInst2Src1RAddr  <=  7'b0; 
            RegBInst2Src2RAble  <=  `EnableValue; 
            RegBInst2Src2RAddr  <=  7'b0;   
            RegBInst2ImmAble    <=  `EnableValue; 
            RegBInst2ImmDate    <=  26'b0; 
            RegBInst2RdAble     <=  `EnableValue; 
            RegBInst2RdAddr     <=  7'b0;   
            RegBInst2RoBptr     <=  6'b0;
        end
        else if(FinalBrSendAble) begin
            RegBInst1MicOperate <=  CBISSUE[BrSelectOldS4][35:28];
            RegBInst1Src1RAble  <=  CBISSUE[BrSelectOldS4][52];
            RegBInst1Src1RAddr  <=  CBISSUE[BrSelectOldS4][50:44]; 
            RegBInst1Src2RAble  <=  CBISSUE[BrSelectOldS4][61]; 
            RegBInst1Src2RAddr  <=  CBISSUE[BrSelectOldS4][59:53];   
            RegBInst1ImmAble    <=  CBISSUE[BrSelectOldS4][27]; 
            RegBInst1ImmDate    <=  CBISSUE[BrSelectOldS4][26:1]; 
            RegBInst1RdAble     <=  CBISSUE[BrSelectOldS4][43]; 
            RegBInst1RdAddr     <=  CBISSUE[BrSelectOldS4][42:36];  
            RegBInst1Mode       <=  CBISSUE[BrSelectOldS4][0]; 
            RegBInst1RedieAddr  <=  CBISSUE[BrSelectOldS4][100:69]; 
            RegBInst1RoBptr     <=  CBISSUE[BrSelectOldS4][67:62]; 

            RegBInst2MicOperate <=  CBISSUE[CsSelectOldS4][35:28];
            RegBInst2Src1RAble  <=  CBISSUE[CsSelectOldS4][52];
            RegBInst2Src1RAddr  <=  CBISSUE[CsSelectOldS4][50:44]; 
            RegBInst2Src2RAble  <=  CBISSUE[CsSelectOldS4][61]; 
            RegBInst2Src2RAddr  <=  CBISSUE[CsSelectOldS4][59:53];   
            RegBInst2ImmAble    <=  CBISSUE[CsSelectOldS4][27]; 
            RegBInst2ImmDate    <=  CBISSUE[CsSelectOldS4][26:1]; 
            RegBInst2RdAble     <=  CBISSUE[CsSelectOldS4][43]; 
            RegBInst2RdAddr     <=  CBISSUE[CsSelectOldS4][42:36];   
            RegBInst2RoBptr     <=  CBISSUE[CsSelectOldS4][67:62]; 
        end
    end


    assign BInst1MicOperate = ~StopTemp ? RegBInst1MicOperate : 8'b0 ;
    assign BInst1Src1RAble  = ~StopTemp ? RegBInst1Src1RAble  : `EnableValue ;
    assign BInst1Src1RAddr  = ~StopTemp ? RegBInst1Src1RAddr  : 7'b0 ;
    assign BInst1Src2RAble  = ~StopTemp ? RegBInst1Src2RAble  : `EnableValue ;
    assign BInst1Src2RAddr  = ~StopTemp ? RegBInst1Src2RAddr  : 7'b0 ;
    assign BInst1ImmAble    = ~StopTemp ? RegBInst1ImmAble    : `EnableValue ;
    assign BInst1ImmDate    = ~StopTemp ? RegBInst1ImmDate    : 26'b0 ;
    assign BInst1RdAble     = ~StopTemp ? RegBInst1RdAble     : `EnableValue ;
    assign BInst1RdAddr     = ~StopTemp ? RegBInst1RdAddr     : 7'b0 ;
    assign BInst1Mode       = ~StopTemp ? RegBInst1Mode       : `EnableValue ;
    assign BInst1RedieAddr  = ~StopTemp ? RegBInst1RedieAddr  : 32'b0 ;
    assign BInst1RoBptr     = ~StopTemp ? RegBInst1RoBptr     : 6'b0 ;

    assign BInst2MicOperate = ~StopTemp ? RegBInst2MicOperate : 8'b0 ;
    assign BInst2Src1RAble  = ~StopTemp ? RegBInst2Src1RAble  : `EnableValue ;
    assign BInst2Src1RAddr  = ~StopTemp ? RegBInst2Src1RAddr  : 7'b0 ;
    assign BInst2Src2RAble  = ~StopTemp ? RegBInst2Src2RAble  : `EnableValue ;
    assign BInst2Src2RAddr  = ~StopTemp ? RegBInst2Src2RAddr  : 7'b0 ;
    assign BInst2ImmAble    = ~StopTemp ? RegBInst2ImmAble    : `EnableValue ;
    assign BInst2ImmDate    = ~StopTemp ? RegBInst2ImmDate    : 26'b0 ;
    assign BInst2RdAble     = ~StopTemp ? RegBInst2RdAble     : `EnableValue ;
    assign BInst2RdAddr     = ~StopTemp ? RegBInst2RdAddr     : 7'b0 ;
    assign BInst2RoBptr     = ~StopTemp ? RegBInst2RoBptr     : 6'b0 ;
  

    genvar i ;

    wire        InstSrc1Ready [0:15] ;
    wire        InstSrc2Ready [0:15] ;

    generate
        for (i =0 ;i<16 ;i=i+1 ) begin
            assign InstSrc1Ready[i]  =  ((CBISSUE[i][50:44] == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                        ((CBISSUE[i][50:44] == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                        ((CBISSUE[i][50:44] == FromMulAddr    ) && (FromIsQMul )) ||
                                        ((CBISSUE[i][50:44] == ByPassBDivAddr ) && (ByPassBDiv )) ||
                                        ((CBISSUE[i][50:44] == BypassBSCAddr  ) && (BypassBSC  )) ||
                                        ((CBISSUE[i][50:44] == ByPassBLoadAddr) && (ByPassBLoad)) ||
                                        ((CBISSUE[i][50:44] == BCsrIssueAddr  ) && (BCsrIssueAble))||
                                        ((CBISSUE[i][50:44] == BBrIssueAddr   ) && (BBrIssueAble)) ;
            assign InstSrc2Ready[i]  =  ((CBISSUE[i][59:53] == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                        ((CBISSUE[i][59:53] == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                        ((CBISSUE[i][59:53] == FromMulAddr    ) && (FromIsQMul )) ||
                                        ((CBISSUE[i][59:53] == ByPassBDivAddr ) && (ByPassBDiv )) ||
                                        ((CBISSUE[i][59:53] == BypassBSCAddr  ) && (BypassBSC  )) ||
                                        ((CBISSUE[i][59:53] == ByPassBLoadAddr) && (ByPassBLoad)) ||
                                        ((CBISSUE[i][59:53] == BCsrIssueAddr  ) && (BCsrIssueAble))||
                                        ((CBISSUE[i][59:53] == BBrIssueAddr   ) && (BBrIssueAble)) ;
        end
    endgenerate


    //tag broadcast
    assign                 BBrIssueAble   = FinalBrSendAble & CBISSUE[BrSelectOldS4][43] ; 
    assign                 BBrIssueAddr   = CBISSUE[BrSelectOldS4][42:36] ;
    assign                 BCsrIssueAble  = FinalCsSendAble & CBISSUE[CsSelectOldS4][43] ;
    assign                 BCsrIssueAddr  = CBISSUE[CsSelectOldS4][42:36] ;

    assign OutCsrAble = BCsrIssueAble ;
    assign OutCsrAddr = BCsrIssueAddr ;
    assign OutBruAble = BBrIssueAble  ; 
    assign OutBruAble = BBrIssueAddr  ;

    integer ii ;
    always @(posedge Clk) begin
        if(!Rest) begin
            for (ii =0 ;ii<32 ;ii=ii+1 ) begin
                CBISSUE[ii] <= 101'd0 ;
            end
        end 
        else if(BrCsrFlash) begin
            for (ii =0 ;ii<32 ;ii=ii+1 ) begin
                CBISSUE[ii] <= 101'd0 ;
            end
        end
        else if(BrCsrStop) begin
            for (ii =0 ;ii<32 ;ii=ii+1 ) begin
                CBISSUE[ii] <= CBISSUE[ii] ;
            end 
        end
        else begin
            CBISSUE[0][60] <= (~CBISSUE[0][61] | CBISSUE[0][60]) ? CBISSUE[0][60] : InstSrc1Ready[0] ;
            CBISSUE[0][51] <= (~CBISSUE[0][52] | CBISSUE[0][51]) ? CBISSUE[0][51] : InstSrc2Ready[0] ;
            CBISSUE[1][60] <= (~CBISSUE[1][61] | CBISSUE[1][60]) ? CBISSUE[1][60] : InstSrc1Ready[1] ;
            CBISSUE[1][51] <= (~CBISSUE[1][52] | CBISSUE[1][51]) ? CBISSUE[1][51] : InstSrc2Ready[1] ;
            CBISSUE[2][60] <= (~CBISSUE[2][61] | CBISSUE[2][60]) ? CBISSUE[2][60] : InstSrc1Ready[2] ;
            CBISSUE[2][51] <= (~CBISSUE[2][52] | CBISSUE[2][51]) ? CBISSUE[2][51] : InstSrc2Ready[2] ;
            CBISSUE[3][60] <= (~CBISSUE[3][61] | CBISSUE[3][60]) ? CBISSUE[3][60] : InstSrc1Ready[3] ;
            CBISSUE[3][51] <= (~CBISSUE[3][52] | CBISSUE[3][51]) ? CBISSUE[3][51] : InstSrc2Ready[3] ;
            CBISSUE[4][60] <= (~CBISSUE[4][61] | CBISSUE[4][60]) ? CBISSUE[4][60] : InstSrc1Ready[4] ;
            CBISSUE[4][51] <= (~CBISSUE[4][52] | CBISSUE[4][51]) ? CBISSUE[4][51] : InstSrc2Ready[4] ;
            CBISSUE[5][60] <= (~CBISSUE[5][61] | CBISSUE[5][60]) ? CBISSUE[5][60] : InstSrc1Ready[5] ;
            CBISSUE[5][51] <= (~CBISSUE[5][52] | CBISSUE[5][51]) ? CBISSUE[5][51] : InstSrc2Ready[5] ;
            CBISSUE[6][60] <= (~CBISSUE[6][61] | CBISSUE[6][60]) ? CBISSUE[6][60] : InstSrc1Ready[6] ;
            CBISSUE[6][51] <= (~CBISSUE[6][52] | CBISSUE[6][51]) ? CBISSUE[6][51] : InstSrc2Ready[6] ;
            CBISSUE[7][60] <= (~CBISSUE[7][61] | CBISSUE[7][60]) ? CBISSUE[7][60] : InstSrc1Ready[7] ;
            CBISSUE[7][51] <= (~CBISSUE[7][52] | CBISSUE[7][51]) ? CBISSUE[7][51] : InstSrc2Ready[7] ;
            CBISSUE[8][60] <= (~CBISSUE[8][61] | CBISSUE[8][60]) ? CBISSUE[8][60] : InstSrc1Ready[8] ;
            CBISSUE[8][51] <= (~CBISSUE[8][52] | CBISSUE[8][51]) ? CBISSUE[8][51] : InstSrc2Ready[8] ;
            CBISSUE[9][60] <= (~CBISSUE[9][61] | CBISSUE[9][60]) ? CBISSUE[9][60] : InstSrc1Ready[9] ;
            CBISSUE[9][51] <= (~CBISSUE[9][52] | CBISSUE[9][51]) ? CBISSUE[9][51] : InstSrc2Ready[9] ;
            CBISSUE[10][60] <= (~CBISSUE[10][61] | CBISSUE[10][60]) ? CBISSUE[10][60] : InstSrc1Ready[10] ;
            CBISSUE[10][51] <= (~CBISSUE[10][52] | CBISSUE[10][51]) ? CBISSUE[10][51] : InstSrc2Ready[10] ;
            CBISSUE[11][60] <= (~CBISSUE[11][61] | CBISSUE[11][60]) ? CBISSUE[11][60] : InstSrc1Ready[11] ;
            CBISSUE[11][51] <= (~CBISSUE[11][52] | CBISSUE[11][51]) ? CBISSUE[11][51] : InstSrc2Ready[11] ;
            CBISSUE[12][60] <= (~CBISSUE[12][61] | CBISSUE[12][60]) ? CBISSUE[12][60] : InstSrc1Ready[12] ;
            CBISSUE[12][51] <= (~CBISSUE[12][52] | CBISSUE[12][51]) ? CBISSUE[12][51] : InstSrc2Ready[12] ;
            CBISSUE[13][60] <= (~CBISSUE[13][61] | CBISSUE[13][60]) ? CBISSUE[13][60] : InstSrc1Ready[13] ;
            CBISSUE[13][51] <= (~CBISSUE[13][52] | CBISSUE[13][51]) ? CBISSUE[13][51] : InstSrc2Ready[13] ;
            CBISSUE[14][60] <= (~CBISSUE[14][61] | CBISSUE[14][60]) ? CBISSUE[14][60] : InstSrc1Ready[14] ;
            CBISSUE[14][51] <= (~CBISSUE[14][52] | CBISSUE[14][51]) ? CBISSUE[14][51] : InstSrc2Ready[14] ;
            CBISSUE[15][60] <= (~CBISSUE[15][61] | CBISSUE[15][60]) ? CBISSUE[15][60] : InstSrc1Ready[15] ;
            CBISSUE[15][51] <= (~CBISSUE[15][52] | CBISSUE[15][51]) ? CBISSUE[15][51] : InstSrc2Ready[15] ;
            CBISSUE[CriqPreOut1] <= U1ReadAble ? WriteDate1 : 101'd0 ;
            CBISSUE[CriqPreOut2] <= U2ReadAble ? WriteDate2 : 101'd0 ;
            CBISSUE[CriqPreOut3] <= U3ReadAble ? WriteDate3 : 101'd0 ;
            CBISSUE[CriqPreOut4] <= U3ReadAble ? WriteDate4 : 101'd0 ;
            CBISSUE[BrSelectOldS4] <= FinalBrSendAble ? 101'd0 : CBISSUE[BrSelectOldS4] ;
            CBISSUE[CsSelectOldS4] <= FinalCsSendAble ? 101'd0 : CBISSUE[CsSelectOldS4] ;
        end
    end

    
endmodule
`timescale 1ps/1ps
`include "../define.v"
`include "../../Lib/IntIQ1Criq8.v"
`include "../../Lib/IntIQ2Criq8.v"
`include "../../Lib/IntIQ3Criq8.v"
`include "../../Lib/IntIQ4Criq8.v"

module IssueQueueInt (
    input       wire                                      Clk              ,
    input       wire                                      Rest             ,
    //for ctrl    
    input       wire                                      IsQuIntStop      ,
    input       wire                                      IsQuIntFlash     ,
    output      wire                                      IsQuIntReq       ,
    //from RAT
    input       wire        [2:0]                         InIQInstNum      ,
    input       wire                                      In1Src1Able      ,
    input       wire                                      In1Src1Ready     ,
    input       wire        [`ReNameRegBUs]               In1Src1Addr      ,
    input       wire                                      In1Src2Able      ,
    input       wire                                      In1Src2Ready     ,
    input       wire        [`ReNameRegBUs]               In1Src2Addr      ,
    input       wire                                      In1RdAble        ,
    input       wire        [`ReNameRegBUs]               In1RdAddr        ,
    input       wire                                      In2Src1Able      ,
    input       wire                                      In2Src1Ready     ,
    input       wire        [`ReNameRegBUs]               In2Src1Addr      ,
    input       wire                                      In2Src2Able      ,
    input       wire                                      In2Src2Ready     ,
    input       wire        [`ReNameRegBUs]               In2Src2Addr      ,
    input       wire                                      In2RdAble        ,
    input       wire        [`ReNameRegBUs]               In2RdAddr        ,
    input       wire                                      In3Src1Able      ,
    input       wire                                      In3Src1Ready     ,
    input       wire        [`ReNameRegBUs]               In3Src1Addr      ,
    input       wire                                      In3Src2Able      ,
    input       wire                                      In3Src2Ready     ,
    input       wire        [`ReNameRegBUs]               In3Src2Addr      ,
    input       wire                                      In3RdAble        ,
    input       wire        [`ReNameRegBUs]               In3RdAddr        ,
    input       wire                                      In4Src1Able      ,
    input       wire                                      In4Src1Ready     ,
    input       wire        [`ReNameRegBUs]               In4Src1Addr      ,
    input       wire                                      In4Src2Able      ,
    input       wire                                      In4Src2Ready     ,
    input       wire        [`ReNameRegBUs]               In4Src2Addr      ,
    input       wire                                      In4RdAble        ,
    input       wire        [`ReNameRegBUs]               In4RdAddr        ,
    //from decode delay 1 clcye
    input       wire                                      In1aAble         ,
    input       wire        [`MicOperateCode]             In1MicOpcode     ,
    input       wire                                      In1ImmAble       ,
    input       wire        [25:0]                        In1ImmDate       ,
    input       wire        [6:0]                         In1RobPtr        ,
    input       wire                                      In2aAble         ,
    input       wire        [`MicOperateCode]             In2MicOpcode     ,
    input       wire                                      In2ImmAble       ,
    input       wire        [25:0]                        In2ImmDate       ,
    input       wire        [6:0]                         In2RobPtr        ,
    input       wire                                      In3aAble         ,
    input       wire        [`MicOperateCode]             In3MicOpcode     ,
    input       wire                                      In3ImmAble       ,
    input       wire        [25:0]                        In3ImmDate       ,
    input       wire        [6:0]                         In3RobPtr        ,
    input       wire                                      In4aAble         ,
    input       wire        [`MicOperateCode]             In4MicOpcode     ,
    input       wire                                      In4ImmAble       ,
    input       wire        [25:0]                        In4ImmDate       ,
    input       wire        [6:0]                         In4RobPtr        ,
    //Weak-up sign
    input       wire                                      FromIsQBr        ,
    input       wire        [`ReNameRegBUs]               FromBrAddr       , 
    input       wire                                      FromIsQCsr       ,
    input       wire        [`ReNameRegBUs]               FromCsrAddr      ,//delay broadcast
    input       wire                                      ByPassDiv        ,
    input       wire        [`ReNameRegBUs]               ByPassDivAddr    ,
    input       wire                                      BypassSC         ,
    input       wire        [`ReNameRegBUs]               BypassSCAddr     ,
    input       wire                                      ByPassLoad       ,
    input       wire        [`ReNameRegBUs]               ByPassLoadAddr   ,//bypass
    //in Req
    input       wire                                      Alu1Req          ,
    input       wire                                      Alu2Req          ,
    input       wire                                      MulReq           ,
    input       wire                                      DivReq           ,
    //to delay bus
    output      wire                                      Alu1Inst         , //not only other issuequeue but also busytable
    output      wire        [`ReNameRegBUs]               Alu1InstAddr     ,
    output      wire                                      Alu2Inst         ,
    output      wire        [`ReNameRegBUs]               ALu2InstAddr     ,
    output      wire                                      MulInst          ,
    output      wire        [`ReNameRegBUs]               MulInstAddr      ,
    //select inst to Physical
    output      wire        [`MicOperateCode]             Inst1MicOperate  , //alu1
    output      wire                                      Inst1Src1RAble   ,
    output      wire        [`ReNameRegBUs]               Inst1Src1RAddr   , 
    output      wire                                      Inst1Src2RAble   ,
    output      wire        [`ReNameRegBUs]               Inst1Src2RAddr   ,    
    output      wire                                      Inst1ImmAble     ,
    output      wire        [25:0]                        Inst1ImmDate     ,
    output      wire                                      Inst1RdAble      ,
    output      wire        [`ReNameRegBUs]               Inst1RdAddr      , 
    output      wire        [5:0]                         Inst1RoBptr      ,
    output      wire        [`MicOperateCode]             Inst2MicOperate  , //alu2
    output      wire                                      Inst2Src1RAble   ,
    output      wire        [`ReNameRegBUs]               Inst2Src1RAddr   , 
    output      wire                                      Inst2Src2RAble   ,
    output      wire        [`ReNameRegBUs]               Inst2Src2RAddr   ,    
    output      wire                                      Inst2ImmAble     ,
    output      wire        [25:0]                        Inst2ImmDate     ,
    output      wire                                      Inst2RdAble      ,
    output      wire        [`ReNameRegBUs]               Inst2RdAddr      , 
    output      wire        [5:0]                         Inst2RoBptr      ,
    output      wire        [`MicOperateCode]             Inst3MicOperate  , //div
    output      wire                                      Inst3Src1RAble   ,
    output      wire        [`ReNameRegBUs]               Inst3Src1RAddr   , 
    output      wire                                      Inst3Src2RAble   ,
    output      wire        [`ReNameRegBUs]               Inst3Src2RAddr   ,    
    output      wire                                      Inst3ImmAble     ,
    output      wire        [25:0]                        Inst3ImmDate     ,
    output      wire                                      Inst3RdAble      ,
    output      wire        [`ReNameRegBUs]               Inst3RdAddr      , 
    output      wire        [5:0]                         Inst3RoBptr      ,
    output      wire        [`MicOperateCode]             Inst4MicOperate  , //mul
    output      wire                                      Inst4Src1RAble   ,
    output      wire        [`ReNameRegBUs]               Inst4Src1RAddr   , 
    output      wire                                      Inst4Src2RAble   ,
    output      wire        [`ReNameRegBUs]               Inst4Src2RAddr   ,    
    output      wire                                      Inst4ImmAble     ,
    output      wire        [25:0]                        Inst4ImmDate     ,
    output      wire                                      Inst4RdAble      ,
    output      wire        [`ReNameRegBUs]               Inst4RdAddr      , 
    output      wire        [5:0]                         Inst4RoBptr      
);

    reg               StopTemp  ;
    reg               FlashTemp ;

    always @(posedge Clk) begin
        if(!Rest) begin
            StopTemp   <= 1'b0  ;
            FlashTemp  <= 1'b0  ;
        end
        else begin
            StopTemp   <= IsQuIntStop  ;
            FlashTemp  <= IsQuIntFlash ;
        end
    end

    reg [68:0] INTISSUE [0:31] ; // (ROBptr and Age)7 | (valid2 + ready2 + sec2)9 | (valid1 + ready1 + sec1)9 | (validrd + rd)8 | MicOpcode 8 | (validimm1 + Imm 26)27 | {ready | 暂时不用} ;

    reg [2:0]  ReadPtr  ;
    reg [2:0]  WritePtr ;
                         

    always @(posedge Clk) begin
        if(!Rest) begin
            ReadPtr    <= 3'd0 ;
        end
        else begin
            ReadPtr    <= ReadPtr[1:0] + InIQInstNum ;
        end
    end

    wire  Read1Able    = (ReadPtr == 0) & (InIQInstNum !=0) | 
                         (ReadPtr == 1) & (InIQInstNum ==4) | 
                         (ReadPtr == 2) & ((InIQInstNum ==3) | (InIQInstNum ==4)) | 
                         (ReadPtr == 3) & ((InIQInstNum !=0) & (InIQInstNum !=1)) ; 

    wire  Read2Able    = (ReadPtr == 0) & ((InIQInstNum !=0) & (InIQInstNum !=1)) | 
                         (ReadPtr == 1) & (InIQInstNum !=0) | 
                         (ReadPtr == 2) & (InIQInstNum ==4) | 
                         (ReadPtr == 3) & ((InIQInstNum ==3) | (InIQInstNum ==4)) ; 

    wire  Read3Able    = (ReadPtr == 0) & ((InIQInstNum ==3) | (InIQInstNum ==4)) | 
                         (ReadPtr == 1) & ((InIQInstNum !=0) & (InIQInstNum !=1)) | 
                         (ReadPtr == 2) & (InIQInstNum !=0) | 
                         (ReadPtr == 3) & (InIQInstNum ==4) ;

    wire  Read4Able    = (ReadPtr == 0) & (InIQInstNum ==4)  | 
                         (ReadPtr == 1) & ((InIQInstNum ==3) | (InIQInstNum ==4)) | 
                         (ReadPtr == 2) & ((InIQInstNum !=0) & (InIQInstNum !=1)) | 
                         (ReadPtr == 3) & (InIQInstNum !=0) ; 

    wire  [4:0] ReadPtr1 ;
    wire  [4:0] ReadPtr2 ;
    wire  [4:0] ReadPtr3 ;
    wire  [4:0] ReadPtr4 ;

    wire  [4:0] WriteInPtr1 ;
    wire  [4:0] WriteInPtr2 ;
    wire  [4:0] WriteInPtr3 ;
    wire  [4:0] WriteInPtr4 ;

    assign {WriteInPtr1, WriteInPtr2, WriteInPtr3, WriteInPtr4} = {20{( In1aAble & ~In2aAble & ~In3aAble & ~In4aAble)}} & {ReadPtr1, 5'd0, 5'd0, 5'd0} | 
                                                                  {20{(~In1aAble &  In2aAble & ~In3aAble & ~In4aAble)}} & {5'd0, ReadPtr1, 5'd0, 5'd0} | 
                                                                  {20{(~In1aAble & ~In2aAble &  In3aAble & ~In4aAble)}} & {5'd0, 5'd0, ReadPtr1, 5'd0} | 
                                                                  {20{(~In1aAble & ~In2aAble & ~In3aAble &  In4aAble)}} & {5'd0, 5'd0, 5'd0, ReadPtr1} | 
                                                                  {20{( In1aAble &  In2aAble & ~In3aAble & ~In4aAble)}} & {ReadPtr1, ReadPtr2, 5'd0, 5'd0} | 
                                                                  {20{( In1aAble & ~In2aAble &  In3aAble & ~In4aAble)}} & {ReadPtr1, 5'd0, ReadPtr2, 5'd0} | 
                                                                  {20{(~In1aAble &  In2aAble &  In3aAble & ~In4aAble)}} & {5'd0, ReadPtr1, ReadPtr2, 5'd0} | 
                                                                  {20{( In1aAble &  In2aAble &  In3aAble & ~In4aAble)}} & {ReadPtr1, ReadPtr2, ReadPtr3, 5'd0} | 
                                                                  {20{( In1aAble & ~In2aAble & ~In3aAble &  In4aAble)}} & {ReadPtr1, 5'd0, 5'd0, ReadPtr2} | 
                                                                  {20{(~In1aAble &  In2aAble & ~In3aAble &  In4aAble)}} & {5'd0, ReadPtr1, 5'd0, ReadPtr2} | 
                                                                  {20{( In1aAble &  In2aAble & ~In3aAble &  In4aAble)}} & {ReadPtr1, ReadPtr2, 5'd0, ReadPtr3} | 
                                                                  {20{(~In1aAble & ~In2aAble &  In3aAble &  In4aAble)}} & {5'd0, 5'd0, ReadPtr1, ReadPtr2} | 
                                                                  {20{( In1aAble & ~In2aAble &  In3aAble &  In4aAble)}} & {ReadPtr1, 5'd0, ReadPtr2, ReadPtr3} | 
                                                                  {20{(~In1aAble &  In2aAble &  In3aAble &  In4aAble)}} & {5'd0, ReadPtr1, ReadPtr2, ReadPtr3} | 
                                                                  {20{( In1aAble &  In2aAble &  In3aAble &  In4aAble)}} & {ReadPtr1, ReadPtr2, ReadPtr3, ReadPtr4};

    wire  [2:0] WriteNumber ;
    //wire        WriteAble1  ;
    wire  [4:0] WriteDate1  ;
    //wire        WriteAble2  ;
    wire  [4:0] WriteDate2  ;
    //wire        WriteAble3  ;
    wire  [4:0] WriteDate3  ;
    //wire        WriteAble4  ;
    wire  [4:0] WriteDate4  ;

    assign {WriteNumber,WriteDate1,WriteDate2,WriteDate3,WriteDate4} = 
                                    {23{( Inst1SelectAble & ~Inst2SelectAble & ~Inst3SelectAble & ~Inst4SelectAble)}} & {3'd1, Inst1SelectPtr, 5'd0, 5'd0, 5'd0} |
                                    {23{(~Inst1SelectAble &  Inst2SelectAble & ~Inst3SelectAble & ~Inst4SelectAble)}} & {3'd1, Inst2SelectPtr, 5'd0, 5'd0, 5'd0} |
                                    {23{( Inst1SelectAble &  Inst2SelectAble & ~Inst3SelectAble & ~Inst4SelectAble)}} & {3'd2, Inst1SelectPtr, Inst2SelectPtr, 5'd0, 5'd0} |
                                    {23{(~Inst1SelectAble & ~Inst2SelectAble &  Inst3SelectAble & ~Inst4SelectAble)}} & {3'd1, Inst3SelectPtr, 5'd0, 5'd0, 5'd0} |
                                    {23{( Inst1SelectAble & ~Inst2SelectAble &  Inst3SelectAble & ~Inst4SelectAble)}} & {3'd2, Inst1SelectPtr, Inst3SelectPtr, 5'd0, 5'd0} |
                                    {23{(~Inst1SelectAble &  Inst2SelectAble &  Inst3SelectAble & ~Inst4SelectAble)}} & {3'd2, Inst2SelectPtr, Inst3SelectPtr, 5'd0, 5'd0} |
                                    {23{( Inst1SelectAble &  Inst2SelectAble &  Inst3SelectAble & ~Inst4SelectAble)}} & {3'd3, Inst1SelectPtr, Inst2SelectPtr, Inst3SelectPtr, 5'd0} |
                                    {23{(~Inst1SelectAble & ~Inst2SelectAble & ~Inst3SelectAble &  Inst4SelectAble)}} & {3'd1, Inst4SelectPtr, 5'd0, 5'd0, 5'd0} |
                                    {23{( Inst1SelectAble & ~Inst2SelectAble & ~Inst3SelectAble &  Inst4SelectAble)}} & {3'd2, Inst1SelectPtr, Inst4SelectPtr, 5'd0, 5'd0} |
                                    {23{(~Inst1SelectAble &  Inst2SelectAble & ~Inst3SelectAble &  Inst4SelectAble)}} & {3'd2, Inst2SelectPtr, Inst4SelectPtr, 5'd0, 5'd0} |
                                    {23{( Inst1SelectAble &  Inst2SelectAble & ~Inst3SelectAble &  Inst4SelectAble)}} & {3'd3, Inst1SelectPtr, Inst2SelectPtr, Inst4SelectPtr, 5'd0} |
                                    {23{(~Inst1SelectAble & ~Inst2SelectAble &  Inst3SelectAble &  Inst4SelectAble)}} & {3'd2, Inst3SelectPtr, Inst4SelectPtr, 5'd0, 5'd0} |
                                    {23{( Inst1SelectAble & ~Inst2SelectAble &  Inst3SelectAble &  Inst4SelectAble)}} & {3'd3, Inst1SelectPtr, Inst3SelectPtr, Inst4SelectPtr, 5'd0} |
                                    {23{(~Inst1SelectAble &  Inst2SelectAble &  Inst3SelectAble &  Inst4SelectAble)}} & {3'd3, Inst2SelectPtr, Inst3SelectPtr, Inst4SelectPtr, 5'd0} |
                                    {23{( Inst1SelectAble &  Inst2SelectAble &  Inst3SelectAble &  Inst4SelectAble)}} & {3'd4, Inst1SelectPtr, Inst2SelectPtr, Inst3SelectPtr, Inst4SelectPtr} ;

    always @ (posedge Clk) begin
        if (!Rest) begin
            WritePtr <= 3'd0 ;
        end
        else begin
            WritePtr <= WritePtr[1:0] + WriteNumber ;
        end
    end

    wire  Write1Able = (WritePtr == 0) & (WriteNumber != 0) |
                       (WritePtr == 1) & (WriteNumber == 4) |
                       (WritePtr == 2) & ((WriteNumber == 3) | (WriteNumber == 4)) |
                       (WritePtr == 3) & ((WriteNumber != 0) & (WriteNumber != 1));

    wire  Write2Able = (WritePtr == 0) & ((WriteNumber != 0) & (WriteNumber != 1)) |
                       (WritePtr == 1) & (WriteNumber != 0) |
                       (WritePtr == 2) & (WriteNumber == 4) |
                       (WritePtr == 3) & ((WriteNumber == 3) | (WriteNumber == 4));

    wire  Write3Able = (WritePtr == 0) & ((WriteNumber == 3) | (WriteNumber == 4)) |
                       (WritePtr == 1) & ((WriteNumber != 0) & (WriteNumber != 1)) |
                       (WritePtr == 2) & (WriteNumber != 0) |
                       (WritePtr == 3) & (WriteNumber == 4);

    wire  Write4Able = (WritePtr == 0) & (WriteNumber == 4) |
                       (WritePtr == 1) & ((WriteNumber == 3) | (WriteNumber == 4)) |
                       (WritePtr == 2) & ((WriteNumber != 0) & (WriteNumber != 1)) |
                       (WritePtr == 3) & (WriteNumber != 0) ;

    wire     Criq1Empty ;
    wire     Criq2Empty ;
    wire     Criq3Empty ;
    wire     Criq4Empty ;


    IntIQ1Criq8#(
        .CRIQWIDE    ( 5 ),
        .CRIQDEEP    ( 8 )
    )u1_IntIQ1Criq8(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .Rable       ( Read1Able & ~StopTemp ),
        //.Dout        ( Dout        ),
        .CriqPreOut  ( ReadPtr1    ),
        .Wable       ( Write1Able & ~StopTemp  ),
        .Din         ( WriteDate1  ),
        .CriqClean   ( FlashTemp   ),
        //.CriqFull    ( CriqFull    ),
        .CriqEmpty   ( Criq1Empty  )
    );
    IntIQ1Criq8#(
        .CRIQWIDE    ( 5 ),
        .CRIQDEEP    ( 8 )
    )u2_IntIQ1Criq8(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .Rable       ( Read2Able & ~StopTemp   ),
        //.Dout        ( Dout        ),
        .CriqPreOut  ( ReadPtr2    ),
        .Wable       ( Write2Able & ~StopTemp  ),
        .Din         ( WriteDate2  ),
        .CriqClean   ( FlashTemp   ),
        //.CriqFull    ( CriqFull    ),
        .CriqEmpty   ( Criq2Empty  )
    );
    IntIQ1Criq8#(
        .CRIQWIDE    ( 5 ),
        .CRIQDEEP    ( 8 )
    )u3_IntIQ1Criq8(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .Rable       ( Read3Able & ~StopTemp  ),
        //.Dout        ( Dout        ),
        .CriqPreOut  ( ReadPtr3    ),
        .Wable       ( Write3Able & ~StopTemp ),
        .Din         ( WriteDate3  ),
        .CriqClean   ( FlashTemp   ),
        //.CriqFull    ( CriqFull    ),
        .CriqEmpty   ( Criq3Empty  )
    );
    IntIQ1Criq8#(
        .CRIQWIDE    ( 5 ),
        .CRIQDEEP    ( 8 )
    )u4_IntIQ1Criq8(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .Rable       ( Read4Able & ~StopTemp  ),
        //.Dout        ( Dout        ),
        .CriqPreOut  ( ReadPtr4    ),
        .Wable       ( Write4Able & ~StopTemp ),
        .Din         ( WriteDate4  ),
        .CriqClean   ( FlashTemp   ),
        //.CriqFull    ( CriqFull    ),
        .CriqEmpty   ( Criq4Empty  )
    );

    assign IsQuIntReq = Criq1Empty & Criq2Empty & Criq3Empty & Criq4Empty ;

    wire Alu1BroadcastAble ;
    wire [`ReNameRegBUs] Alu1BroadcastAddr ;
    wire Alu2BroadcastAble ;
    wire [`ReNameRegBUs] Alu2BroadcastAddr ;
    wire MulBroadcastAble ;
    wire [`ReNameRegBUs] MulBroadcastAddr ;

    wire InIssue1Src2Ready =((In1Src2Addr == Alu1BroadcastAddr)&& Alu1BroadcastAble) ||
                            ((In1Src2Addr == Alu2BroadcastAddr)&& Alu2BroadcastAble) || 
                            ((In1Src2Addr == MulBroadcastAddr) && MulBroadcastAble)  || 
                            ((In1Src2Addr == FromBrAddr      ) && FromIsQBr       )  || 
                            ((In1Src2Addr == FromCsrAddr     ) && FromIsQCsr      )  || 
                            ((In1Src2Addr == ByPassDivAddr   ) && ByPassDiv       )  || 
                            ((In1Src2Addr == BypassSCAddr    ) && BypassSC        )  || 
                            ((In1Src2Addr == ByPassLoadAddr  ) && ByPassLoad      )  ;
                        
    wire InIssue2Src2Ready =((In2Src2Addr == Alu1BroadcastAddr)&& Alu1BroadcastAble) || 
                            ((In2Src2Addr == Alu2BroadcastAddr)&& Alu2BroadcastAble) || 
                            ((In2Src2Addr == MulBroadcastAddr) && MulBroadcastAble)  || 
                            ((In2Src2Addr == FromBrAddr      ) && FromIsQBr       )  || 
                            ((In2Src2Addr == FromCsrAddr     ) && FromIsQCsr      )  || 
                            ((In2Src2Addr == ByPassDivAddr   ) && ByPassDiv       )  || 
                            ((In2Src2Addr == BypassSCAddr    ) && BypassSC        )  || 
                            ((In2Src2Addr == ByPassLoadAddr  ) && ByPassLoad      )  ;

    wire InIssue3Src2Ready =((In3Src2Addr == Alu1BroadcastAddr)&& Alu1BroadcastAble) ||
                            ((In3Src2Addr == Alu2BroadcastAddr)&& Alu2BroadcastAble) || 
                            ((In3Src2Addr == MulBroadcastAddr) && MulBroadcastAble)  || 
                            ((In3Src2Addr == FromBrAddr      ) && FromIsQBr       )  || 
                            ((In3Src2Addr == FromCsrAddr     ) && FromIsQCsr      )  || 
                            ((In3Src2Addr == ByPassDivAddr   ) && ByPassDiv       )  || 
                            ((In3Src2Addr == BypassSCAddr    ) && BypassSC        )  || 
                            ((In3Src2Addr == ByPassLoadAddr  ) && ByPassLoad      )  ;
                        
    wire InIssue4Src2Ready =((In4Src2Addr == Alu1BroadcastAddr)&& Alu1BroadcastAble) || 
                            ((In4Src2Addr == Alu2BroadcastAddr)&& Alu2BroadcastAble) || 
                            ((In4Src2Addr == MulBroadcastAddr) && MulBroadcastAble)  || 
                            ((In4Src2Addr == FromBrAddr      ) && FromIsQBr       )  || 
                            ((In4Src2Addr == FromCsrAddr     ) && FromIsQCsr      )  || 
                            ((In4Src2Addr == ByPassDivAddr   ) && ByPassDiv       )  || 
                            ((In4Src2Addr == BypassSCAddr    ) && BypassSC        )  || 
                            ((In4Src2Addr == ByPassLoadAddr  ) && ByPassLoad      )  ;

    wire InIssue1Src1Ready =((In1Src1Addr == Alu1BroadcastAddr)&& Alu1BroadcastAble) ||
                            ((In1Src1Addr == Alu2BroadcastAddr)&& Alu2BroadcastAble) || 
                            ((In1Src1Addr == MulBroadcastAddr) && MulBroadcastAble)  || 
                            ((In1Src1Addr == FromBrAddr      ) && FromIsQBr       )  || 
                            ((In1Src1Addr == FromCsrAddr     ) && FromIsQCsr      )  || 
                            ((In1Src1Addr == ByPassDivAddr   ) && ByPassDiv       )  || 
                            ((In1Src1Addr == BypassSCAddr    ) && BypassSC        )  || 
                            ((In1Src1Addr == ByPassLoadAddr  ) && ByPassLoad      )  ;
                        
    wire InIssue2Src1Ready =((In2Src1Addr == Alu1BroadcastAddr)&& Alu1BroadcastAble) || 
                            ((In2Src1Addr == Alu2BroadcastAddr)&& Alu2BroadcastAble) || 
                            ((In2Src1Addr == MulBroadcastAddr) && MulBroadcastAble)  || 
                            ((In2Src1Addr == FromBrAddr      ) && FromIsQBr       )  || 
                            ((In2Src1Addr == FromCsrAddr     ) && FromIsQCsr      )  || 
                            ((In2Src1Addr == ByPassDivAddr   ) && ByPassDiv       )  || 
                            ((In2Src1Addr == BypassSCAddr    ) && BypassSC        )  || 
                            ((In2Src1Addr == ByPassLoadAddr  ) && ByPassLoad      )  ;

    wire InIssue3Src1Ready =((In3Src1Addr == Alu1BroadcastAddr)&& Alu1BroadcastAble) ||
                            ((In3Src1Addr == Alu2BroadcastAddr)&& Alu2BroadcastAble) || 
                            ((In3Src1Addr == MulBroadcastAddr) && MulBroadcastAble)  || 
                            ((In3Src1Addr == FromBrAddr      ) && FromIsQBr       )  || 
                            ((In3Src1Addr == FromCsrAddr     ) && FromIsQCsr      )  || 
                            ((In3Src1Addr == ByPassDivAddr   ) && ByPassDiv       )  || 
                            ((In3Src1Addr == BypassSCAddr    ) && BypassSC        )  || 
                            ((In3Src1Addr == ByPassLoadAddr  ) && ByPassLoad      )  ;
                        
    wire InIssue4Src1Ready =((In4Src1Addr == Alu1BroadcastAddr)&& Alu1BroadcastAble) || 
                            ((In4Src1Addr == Alu2BroadcastAddr)&& Alu2BroadcastAble) || 
                            ((In4Src1Addr == MulBroadcastAddr) && MulBroadcastAble)  || 
                            ((In4Src1Addr == FromBrAddr      ) && FromIsQBr       )  || 
                            ((In4Src1Addr == FromCsrAddr     ) && FromIsQCsr      )  || 
                            ((In4Src1Addr == ByPassDivAddr   ) && ByPassDiv       )  || 
                            ((In4Src1Addr == BypassSCAddr    ) && BypassSC        )  || 
                            ((In4Src1Addr == ByPassLoadAddr  ) && ByPassLoad      )  ;
    wire InstSrc2Ready[0:31] ;
    wire InstSrc1Ready[0:31] ;               
    genvar a ;
    generate
        for ( a=0 ;a<32 ;a=a+1 ) begin
            assign InstSrc2Ready[a]=((INTISSUE[a][59:53] == Alu1BroadcastAddr)&& Alu1BroadcastAble) ||
                                    ((INTISSUE[a][59:53] == Alu2BroadcastAddr)&& Alu2BroadcastAble) || 
                                    ((INTISSUE[a][59:53] == MulBroadcastAddr) && MulBroadcastAble)  || 
                                    ((INTISSUE[a][59:53] == FromBrAddr      ) && FromIsQBr       )  || 
                                    ((INTISSUE[a][59:53] == FromCsrAddr     ) && FromIsQCsr      )  || 
                                    ((INTISSUE[a][59:53] == ByPassDivAddr   ) && ByPassDiv       )  || 
                                    ((INTISSUE[a][59:53] == BypassSCAddr    ) && BypassSC        )  || 
                                    ((INTISSUE[a][59:53] == ByPassLoadAddr  ) && ByPassLoad      )  ;
            assign InstSrc1Ready[a]=((INTISSUE[a][50:44] == Alu1BroadcastAddr)&& Alu1BroadcastAble) ||
                                    ((INTISSUE[a][50:44] == Alu2BroadcastAddr)&& Alu2BroadcastAble) || 
                                    ((INTISSUE[a][50:44] == MulBroadcastAddr) && MulBroadcastAble)  ||
                                    ((INTISSUE[a][50:44] == FromBrAddr      ) && FromIsQBr       )  ||
                                    ((INTISSUE[a][50:44] == FromCsrAddr     ) && FromIsQCsr      )  || 
                                    ((INTISSUE[a][50:44] == ByPassDivAddr   ) && ByPassDiv       )  || 
                                    ((INTISSUE[a][50:44] == BypassSCAddr    ) && BypassSC        )  || 
                                    ((INTISSUE[a][50:44] == ByPassLoadAddr  ) && ByPassLoad      )  ;
        end
    endgenerate
    

    reg     AluAllocate ;
    wire    AluInstHas  = ((In1aAble & (In1MicOpcode[7:5] == 3'b001)) |
                           (In2aAble & (In2MicOpcode[7:5] == 3'b001)) |
                           (In3aAble & (In3MicOpcode[7:5] == 3'b001)) |
                           (In4aAble & (In4MicOpcode[7:5] == 3'b001))) ? `AbleValue : `EnableValue ; 
    always @(posedge Clk) begin
        if(!Rest) 
            AluAllocate <= `EnableValue ;
        else if(IsQuIntFlash)
            AluAllocate <= `EnableValue ;
        else if(IsQuIntStop) 
            AluAllocate <= AluAllocate ;
        else 
            AluAllocate <= AluInstHas  ? ~AluAllocate : AluAllocate ;


    end
    
    integer j ;
    always @(posedge Clk) begin
        if(!Rest) begin
           for (j =0 ;j<33 ;j=j+1 ) begin
                INTISSUE[j] <= 69'd0 ;
            end 
        end
        else if(IsQuIntFlash) begin
            for (j =0 ;j<33 ;j=j+1 ) begin
                INTISSUE[j] <= 69'd0 ;
            end 
        end
        else if(IsQuIntStop) begin
            for (j =0 ;j<33 ;j=j+1 ) begin
                INTISSUE[j] <= INTISSUE[j] ;
            end 
        end
        else begin
            INTISSUE[0][60] <= (~INTISSUE[0][61] | INTISSUE[0][60] ) ? INTISSUE[0][60] : InstSrc2Ready[0] ;
            INTISSUE[0][51] <= (~INTISSUE[0][52] | INTISSUE[0][51] ) ? INTISSUE[0][51] : InstSrc1Ready[0] ;
            INTISSUE[1][60] <= (~INTISSUE[1][61] | INTISSUE[1][60] ) ? INTISSUE[1][60] : InstSrc2Ready[1] ;
            INTISSUE[1][51] <= (~INTISSUE[1][52] | INTISSUE[1][51] ) ? INTISSUE[1][51] : InstSrc1Ready[1] ;
            INTISSUE[2][60] <= (~INTISSUE[2][61] | INTISSUE[2][60] ) ? INTISSUE[2][60] : InstSrc2Ready[2] ;
            INTISSUE[2][51] <= (~INTISSUE[2][52] | INTISSUE[2][51] ) ? INTISSUE[2][51] : InstSrc1Ready[2] ;
            INTISSUE[3][60] <= (~INTISSUE[3][61] | INTISSUE[3][60] ) ? INTISSUE[3][60] : InstSrc2Ready[3] ;
            INTISSUE[3][51] <= (~INTISSUE[3][52] | INTISSUE[3][51] ) ? INTISSUE[3][51] : InstSrc1Ready[3] ;
            INTISSUE[4][60] <= (~INTISSUE[4][61] | INTISSUE[4][60] ) ? INTISSUE[4][60] : InstSrc2Ready[4] ;
            INTISSUE[4][51] <= (~INTISSUE[4][52] | INTISSUE[4][51] ) ? INTISSUE[4][51] : InstSrc1Ready[4] ;
            INTISSUE[5][60] <= (~INTISSUE[5][61] | INTISSUE[5][60] ) ? INTISSUE[5][60] : InstSrc2Ready[5] ;
            INTISSUE[5][51] <= (~INTISSUE[5][52] | INTISSUE[5][51] ) ? INTISSUE[5][51] : InstSrc1Ready[5] ;
            INTISSUE[6][60] <= (~INTISSUE[6][61] | INTISSUE[6][60] ) ? INTISSUE[6][60] : InstSrc2Ready[6] ;
            INTISSUE[6][51] <= (~INTISSUE[6][52] | INTISSUE[6][51] ) ? INTISSUE[6][51] : InstSrc1Ready[6] ;
            INTISSUE[7][60] <= (~INTISSUE[7][61] | INTISSUE[7][60] ) ? INTISSUE[7][60] : InstSrc2Ready[7] ;
            INTISSUE[7][51] <= (~INTISSUE[7][52] | INTISSUE[7][51] ) ? INTISSUE[7][51] : InstSrc1Ready[7] ;
            INTISSUE[8][60] <= (~INTISSUE[8][61] | INTISSUE[8][60] ) ? INTISSUE[8][60] : InstSrc2Ready[8] ;
            INTISSUE[8][51] <= (~INTISSUE[8][52] | INTISSUE[8][51] ) ? INTISSUE[8][51] : InstSrc1Ready[8] ;
            INTISSUE[9][60] <= (~INTISSUE[9][61] | INTISSUE[9][60] ) ? INTISSUE[9][60] : InstSrc2Ready[9] ;
            INTISSUE[9][51] <= (~INTISSUE[9][52] | INTISSUE[9][51] ) ? INTISSUE[9][51] : InstSrc1Ready[9] ;
            INTISSUE[10][60] <= (~INTISSUE[10][61] | INTISSUE[10][60] ) ? INTISSUE[10][60] : InstSrc2Ready[10] ;
            INTISSUE[10][51] <= (~INTISSUE[10][52] | INTISSUE[10][51] ) ? INTISSUE[10][51] : InstSrc1Ready[10] ;
            INTISSUE[11][60] <= (~INTISSUE[11][61] | INTISSUE[11][60] ) ? INTISSUE[11][60] : InstSrc2Ready[11] ;
            INTISSUE[11][51] <= (~INTISSUE[11][52] | INTISSUE[11][51] ) ? INTISSUE[11][51] : InstSrc1Ready[11] ;
            INTISSUE[12][60] <= (~INTISSUE[12][61] | INTISSUE[12][60] ) ? INTISSUE[12][60] : InstSrc2Ready[12] ;
            INTISSUE[12][51] <= (~INTISSUE[12][52] | INTISSUE[12][51] ) ? INTISSUE[12][51] : InstSrc1Ready[12] ;
            INTISSUE[13][60] <= (~INTISSUE[13][61] | INTISSUE[13][60] ) ? INTISSUE[13][60] : InstSrc2Ready[13] ;
            INTISSUE[13][51] <= (~INTISSUE[13][52] | INTISSUE[13][51] ) ? INTISSUE[13][51] : InstSrc1Ready[13] ;
            INTISSUE[14][60] <= (~INTISSUE[14][61] | INTISSUE[14][60] ) ? INTISSUE[14][60] : InstSrc2Ready[14] ;
            INTISSUE[14][51] <= (~INTISSUE[14][52] | INTISSUE[14][51] ) ? INTISSUE[14][51] : InstSrc1Ready[14] ;
            INTISSUE[15][60] <= (~INTISSUE[15][61] | INTISSUE[15][60] ) ? INTISSUE[15][60] : InstSrc2Ready[15] ;
            INTISSUE[15][51] <= (~INTISSUE[15][52] | INTISSUE[15][51] ) ? INTISSUE[15][51] : InstSrc1Ready[15] ;
            INTISSUE[16][60] <= (~INTISSUE[16][61] | INTISSUE[16][60] ) ? INTISSUE[16][60] : InstSrc2Ready[16] ;
            INTISSUE[16][51] <= (~INTISSUE[16][52] | INTISSUE[16][51] ) ? INTISSUE[16][51] : InstSrc1Ready[16] ;
            INTISSUE[17][60] <= (~INTISSUE[17][61] | INTISSUE[17][60] ) ? INTISSUE[17][60] : InstSrc2Ready[17] ;
            INTISSUE[17][51] <= (~INTISSUE[17][52] | INTISSUE[17][51] ) ? INTISSUE[17][51] : InstSrc1Ready[17] ;
            INTISSUE[18][60] <= (~INTISSUE[18][61] | INTISSUE[18][60] ) ? INTISSUE[18][60] : InstSrc2Ready[18] ;
            INTISSUE[18][51] <= (~INTISSUE[18][52] | INTISSUE[18][51] ) ? INTISSUE[18][51] : InstSrc1Ready[18] ;
            INTISSUE[19][60] <= (~INTISSUE[19][61] | INTISSUE[19][60] ) ? INTISSUE[19][60] : InstSrc2Ready[19] ;
            INTISSUE[19][51] <= (~INTISSUE[19][52] | INTISSUE[19][51] ) ? INTISSUE[19][51] : InstSrc1Ready[19] ;
            INTISSUE[20][60] <= (~INTISSUE[20][61] | INTISSUE[20][60] ) ? INTISSUE[20][60] : InstSrc2Ready[20] ;
            INTISSUE[20][51] <= (~INTISSUE[20][52] | INTISSUE[20][51] ) ? INTISSUE[20][51] : InstSrc1Ready[20] ;
            INTISSUE[21][60] <= (~INTISSUE[21][61] | INTISSUE[21][60] ) ? INTISSUE[21][60] : InstSrc2Ready[21] ;
            INTISSUE[21][51] <= (~INTISSUE[21][52] | INTISSUE[21][51] ) ? INTISSUE[21][51] : InstSrc1Ready[21] ;
            INTISSUE[22][60] <= (~INTISSUE[22][61] | INTISSUE[22][60] ) ? INTISSUE[22][60] : InstSrc2Ready[22] ;
            INTISSUE[22][51] <= (~INTISSUE[22][52] | INTISSUE[22][51] ) ? INTISSUE[22][51] : InstSrc1Ready[22] ;
            INTISSUE[23][60] <= (~INTISSUE[23][61] | INTISSUE[23][60] ) ? INTISSUE[23][60] : InstSrc2Ready[23] ;
            INTISSUE[23][51] <= (~INTISSUE[23][52] | INTISSUE[23][51] ) ? INTISSUE[23][51] : InstSrc1Ready[23] ;
            INTISSUE[24][60] <= (~INTISSUE[24][61] | INTISSUE[24][60] ) ? INTISSUE[24][60] : InstSrc2Ready[24] ;
            INTISSUE[24][51] <= (~INTISSUE[24][52] | INTISSUE[24][51] ) ? INTISSUE[24][51] : InstSrc1Ready[24] ;
            INTISSUE[25][60] <= (~INTISSUE[25][61] | INTISSUE[25][60] ) ? INTISSUE[25][60] : InstSrc2Ready[25] ;
            INTISSUE[25][51] <= (~INTISSUE[25][52] | INTISSUE[25][51] ) ? INTISSUE[25][51] : InstSrc1Ready[25] ;
            INTISSUE[26][60] <= (~INTISSUE[26][61] | INTISSUE[26][60] ) ? INTISSUE[26][60] : InstSrc2Ready[26] ;
            INTISSUE[26][51] <= (~INTISSUE[26][52] | INTISSUE[26][51] ) ? INTISSUE[26][51] : InstSrc1Ready[26] ;
            INTISSUE[27][60] <= (~INTISSUE[27][61] | INTISSUE[27][60] ) ? INTISSUE[27][60] : InstSrc2Ready[27] ;
            INTISSUE[27][51] <= (~INTISSUE[27][52] | INTISSUE[27][51] ) ? INTISSUE[27][51] : InstSrc1Ready[27] ;
            INTISSUE[28][60] <= (~INTISSUE[28][61] | INTISSUE[28][60] ) ? INTISSUE[28][60] : InstSrc2Ready[28] ;
            INTISSUE[28][51] <= (~INTISSUE[28][52] | INTISSUE[28][51] ) ? INTISSUE[28][51] : InstSrc1Ready[28] ;
            INTISSUE[29][60] <= (~INTISSUE[29][61] | INTISSUE[29][60] ) ? INTISSUE[29][60] : InstSrc2Ready[29] ;
            INTISSUE[29][51] <= (~INTISSUE[29][52] | INTISSUE[29][51] ) ? INTISSUE[29][51] : InstSrc1Ready[29] ;
            INTISSUE[30][60] <= (~INTISSUE[30][61] | INTISSUE[30][60] ) ? INTISSUE[30][60] : InstSrc2Ready[30] ;
            INTISSUE[30][51] <= (~INTISSUE[30][52] | INTISSUE[30][51] ) ? INTISSUE[30][51] : InstSrc1Ready[30] ;
            INTISSUE[31][60] <= (~INTISSUE[31][61] | INTISSUE[31][60] ) ? INTISSUE[31][60] : InstSrc2Ready[31] ;
            INTISSUE[31][51] <= (~INTISSUE[31][52] | INTISSUE[31][51] ) ? INTISSUE[31][51] : InstSrc1Ready[31] ;
            INTISSUE[WriteInPtr1[4:0]] <= (In1aAble  )? {In1RobPtr,In1Src2Able,((~In1Src2Able | In1Src2Ready ) ? In1Src2Ready : InIssue1Src2Ready),
                                                               In1Src2Addr,In1Src1Able,((~In1Src1Able | In1Src1Ready ) ? In1Src1Ready : InIssue1Src1Ready),
                                                               In1Src1Addr,In1RdAble,In1RdAddr,In1ImmAble,In1ImmDate,In1MicOpcode,AluAllocate} : INTISSUE[WriteInPtr1[4:0]] ;
            INTISSUE[WriteInPtr2[4:0]] <= (In2aAble  )? {In2RobPtr,In2Src2Able,((~In2Src2Able | In2Src2Ready ) ? In2Src2Ready : InIssue2Src2Ready),
                                                               In2Src2Addr,In2Src1Able,((~In2Src1Able | In2Src1Ready ) ? In2Src1Ready : InIssue2Src1Ready),
                                                               In2Src1Addr,In2RdAble,In2RdAddr,In2ImmAble,In2ImmDate,In2MicOpcode,AluAllocate} : INTISSUE[WriteInPtr2[4:0]] ;
            INTISSUE[WriteInPtr3[4:0]] <= (In3aAble  )? {In3RobPtr,In3Src2Able,((~In3Src2Able | In3Src2Ready ) ? In3Src2Ready : InIssue3Src2Ready),
                                                               In3Src2Addr,In3Src1Able,((~In3Src1Able | In3Src1Ready ) ? In3Src1Ready : InIssue3Src1Ready),
                                                               In3Src1Addr,In3RdAble,In3RdAddr,In3ImmAble,In3ImmDate,In3MicOpcode,AluAllocate} : INTISSUE[WriteInPtr3[4:0]] ;
            INTISSUE[WriteInPtr4[4:0]] <= (In4aAble  )? {In4RobPtr,In4Src2Able,((~In4Src2Able | In4Src2Ready ) ? In4Src2Ready : InIssue4Src2Ready),
                                                               In4Src2Addr,In4Src1Able,((~In4Src1Able | In4Src1Ready ) ? In4Src1Ready : InIssue4Src1Ready),
                                                               In4Src1Addr,In4RdAble,In4RdAddr,In4ImmAble,In4ImmDate,In4MicOpcode,AluAllocate} : INTISSUE[WriteInPtr4[4:0]] ;
            INTISSUE[Alu1SelectPtrS5P] <=  Alu1SelectAblS5P  ? 69'd0 : INTISSUE[Alu1SelectPtrS5P] ;
            INTISSUE[Alu2SelectPtrS5P] <=  Alu2SelectAblS5P  ? 69'd0 : INTISSUE[Alu2SelectPtrS5P] ;
            INTISSUE[MulSelectPtrS5P]  <=  MulSelectAblS5P   ? 69'd0 : INTISSUE[MulSelectPtrS5P]  ;                                      
            INTISSUE[DivSelectPtrS5P]  <=  DivSelectAblS5P   ? 69'd0 : INTISSUE[DivSelectPtrS5P]  ;

        end
    end

   
    //for Alu1
    wire       Alu1SelectAblS1P [0:15] ;//for Alu1 INTISSUE[i][0] == `AbleValue 
    wire [4:0] Alu1SelectPtrS1P [0:15] ;
    wire       ALu1SelectOld    [0:15] ;
    //for Alu2
    wire       Alu2SelectAblS1P [0:15] ;//for Alu1 INTISSUE[i][0] == `EnableValue 
    wire [4:0] Alu2SelectPtrS1P [0:15] ;
    wire       ALu2SelectOld    [0:15] ;
    //for mul
    wire       MulSelectAblS1P [0:15] ;
    wire [4:0] MulSelectPtrS1P [0:15] ;
    wire       MulSelectOld    [0:15] ;
    //for Div
    wire       DivSelectAblS1P [0:15] ;
    wire [4:0] DivSelectPtrS1P [0:15] ;
    wire       DivSelectOld    [0:15] ;

    genvar b ;
    generate
        for ( b=0 ;b<32 ;b=b+2 ) begin
            assign ALu1SelectOld[b/2]  =  ((INTISSUE[b][68] == INTISSUE[b+1][68] & (INTISSUE[b][67:62] < INTISSUE[b+1][67:62]))) | 
                                          ((INTISSUE[b][68] != INTISSUE[b+1][68] & (INTISSUE[b][67:62] > INTISSUE[b+1][67:62]))) ;
            assign Alu1SelectPtrS1P[b/2]  = {5{(((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & INTISSUE[b][0] & (INTISSUE[b][35:33] == `ALUCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & INTISSUE[b+1][0] & (INTISSUE[b+1][35:33] == `ALUCODE)) & 
                                            (ALu1SelectOld[b/2]))}} & b  | 
                                            {5{(((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & INTISSUE[b][0] & (INTISSUE[b][35:33] == `ALUCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & INTISSUE[b+1][0] & (INTISSUE[b+1][35:33] == `ALUCODE)) & 
                                            (~ALu1SelectOld[b/2]))}} & b+1 | 
                                            {5{(((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & INTISSUE[b][0] & (INTISSUE[b][35:33] == `ALUCODE)) &
                                            ~((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & INTISSUE[b+1][0] & (INTISSUE[b+1][35:33] == `ALUCODE)))}} & b |
                                            {5{(~((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & INTISSUE[b][0] & (INTISSUE[b][35:33] == `ALUCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & INTISSUE[b+1][0] & (INTISSUE[b+1][35:33] == `ALUCODE)))}} & b+1 ;
            assign Alu1SelectAblS1P[b/2]  = (((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & INTISSUE[b][0] & (INTISSUE[b][35:33] == `ALUCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & INTISSUE[b+1][0] & (INTISSUE[b+1][35:33] == `ALUCODE)) & 
                                            (ALu1SelectOld[b/2])) & `AbleValue  | 
                                            (((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & INTISSUE[b][0] & (INTISSUE[b][35:33] == `ALUCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & INTISSUE[b+1][0] & (INTISSUE[b+1][35:33] == `ALUCODE)) & 
                                            (~ALu1SelectOld[b/2])) & `AbleValue | 
                                            (((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & INTISSUE[b][0] & (INTISSUE[b][35:33] == `ALUCODE)) &
                                            ~((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & INTISSUE[b+1][0] & (INTISSUE[b+1][35:33] == `ALUCODE))) & `AbleValue |
                                            (~((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & INTISSUE[b][0] & (INTISSUE[b][35:33] == `ALUCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & INTISSUE[b+1][0] & (INTISSUE[b+1][35:33] == `ALUCODE))) & `AbleValue ;

            assign ALu2SelectOld[b/2]  =  ((INTISSUE[b][68] == INTISSUE[b+1][68] & (INTISSUE[b][67:62] < INTISSUE[b+1][67:62]))) | 
                                          ((INTISSUE[b][68] != INTISSUE[b+1][68] & (INTISSUE[b][67:62] > INTISSUE[b+1][67:62]))) ;
            assign Alu2SelectPtrS1P[b/2]  = {5{(((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & ~INTISSUE[b][0] & (INTISSUE[b][35:33] == `ALUCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & ~INTISSUE[b+1][0] & (INTISSUE[b+1][35:33] == `ALUCODE)) & 
                                            (ALu2SelectOld[b/2]))}} & b  | 
                                            {5{(((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & ~INTISSUE[b][0] & (INTISSUE[b][35:33] == `ALUCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & ~INTISSUE[b+1][0] & (INTISSUE[b+1][35:33] == `ALUCODE)) & 
                                            (~ALu2SelectOld[b/2]))}} & b+1 | 
                                            {5{(((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & ~INTISSUE[b][0] & (INTISSUE[b][35:33] == `ALUCODE)) &
                                            ~((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & ~INTISSUE[b+1][0] & (INTISSUE[b+1][35:33] == `ALUCODE)))}} & b |
                                            {5{(~((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & ~INTISSUE[b][0] & (INTISSUE[b][35:33] == `ALUCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & ~INTISSUE[b+1][0] & (INTISSUE[b+1][35:33] == `ALUCODE)))}} & b+1 ;
            assign Alu2SelectAblS1P[b/2]  = (((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & ~INTISSUE[b][0] & (INTISSUE[b][35:33] == `ALUCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & ~INTISSUE[b+1][0] & (INTISSUE[b+1][35:33] == `ALUCODE)) & 
                                            (ALu2SelectOld[b/2])) & `AbleValue  | 
                                            (((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & ~INTISSUE[b][0] & (INTISSUE[b][35:33] == `ALUCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & ~INTISSUE[b+1][0] & (INTISSUE[b+1][35:33] == `ALUCODE)) & 
                                            (~ALu2SelectOld[b/2])) & `AbleValue | 
                                            (((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & ~INTISSUE[b][0] & (INTISSUE[b][35:33] == `ALUCODE)) &
                                            ~((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & ~INTISSUE[b+1][0] & (INTISSUE[b+1][35:33] == `ALUCODE))) & `AbleValue |
                                            (~((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & ~INTISSUE[b][0] & (INTISSUE[b][35:33] == `ALUCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & ~INTISSUE[b+1][0] & (INTISSUE[b+1][35:33] == `ALUCODE))) & `AbleValue ;
            
            assign MulSelectOld[b/2]  =   ((INTISSUE[b][68] == INTISSUE[b+1][68] & (INTISSUE[b][67:62] < INTISSUE[b+1][67:62]))) | 
                                          ((INTISSUE[b][68] != INTISSUE[b+1][68] & (INTISSUE[b][67:62] > INTISSUE[b+1][67:62]))) ;
            assign MulSelectPtrS1P[b/2]  = {5{(((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) &(INTISSUE[b][35:33] == `MULCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][35:33] == `MULCODE)) & 
                                            (MulSelectOld[b/2]))}} & b  | 
                                            {5{(((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & (INTISSUE[b][35:33] == `MULCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][35:33] == `MULCODE)) & 
                                            (~MulSelectOld[b/2]))}} & b+1 | 
                                            {5{(((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & (INTISSUE[b][35:33] == `MULCODE)) &
                                            ~((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][35:33] == `MULCODE)))}} & b |
                                            {5{(~((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & (INTISSUE[b][35:33] == `MULCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][35:33] == `MULCODE)))}} & b+1 ;
            assign MulSelectAblS1P[b/2]  =  (((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & (INTISSUE[b][35:33] == `MULCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][35:33] == `MULCODE)) & 
                                            (MulSelectOld[b/2])) & `AbleValue  | 
                                            (((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & (INTISSUE[b][35:33] == `MULCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][35:33] == `MULCODE)) & 
                                            (~MulSelectOld[b/2])) & `AbleValue | 
                                            (((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & (INTISSUE[b][35:33] == `MULCODE)) &
                                            ~((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52])  & (INTISSUE[b+1][35:33] == `MULCODE))) & `AbleValue |
                                            (~((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52])  & (INTISSUE[b][35:33] == `MULCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][35:33] == `MULCODE))) & `AbleValue ;

            assign DivSelectOld[b/2]  =   ((INTISSUE[b][68] == INTISSUE[b+1][68] & (INTISSUE[b][67:62] < INTISSUE[b+1][67:62]))) | 
                                          ((INTISSUE[b][68] != INTISSUE[b+1][68] & (INTISSUE[b][67:62] > INTISSUE[b+1][67:62]))) ;
            assign DivSelectPtrS1P[b/2]  = {5{(((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & (INTISSUE[b][35:33] == `DIVCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][35:33] == `DIVCODE)) & 
                                            (DivSelectOld[b/2]))}} & b  | 
                                            {5{(((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & (INTISSUE[b][35:33] == `DIVCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][35:33] == `DIVCODE)) & 
                                            (~DivSelectOld[b/2]))}} & b+1 | 
                                            {5{(((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & (INTISSUE[b][35:33] == `DIVCODE)) &
                                            ~((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][35:33] == `DIVCODE)))}} & b |
                                            {5{(~((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & (INTISSUE[b][35:33] == `DIVCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][35:33] == `DIVCODE)))}} & b+1 ;
            assign DivSelectAblS1P[b/2]  =  (((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & (INTISSUE[b][35:33] == `DIVCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][35:33] == `DIVCODE)) & 
                                            (DivSelectOld[b/2])) & `AbleValue  | 
                                            (((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & (INTISSUE[b][35:33] == `DIVCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][35:33] == `DIVCODE)) & 
                                            (~DivSelectOld[b/2])) & `AbleValue | 
                                            (((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & (INTISSUE[b][35:33] == `DIVCODE)) &
                                            ~((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][35:33] == `DIVCODE))) & `AbleValue |
                                            (~((INTISSUE[b][60] | ~INTISSUE[b][61]) & (INTISSUE[b][51] | ~INTISSUE[b][52]) & (INTISSUE[b][35:33] == `DIVCODE)) &
                                            ((INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][51] | ~INTISSUE[b+1][52]) & (INTISSUE[b+1][35:33] == `DIVCODE))) & `AbleValue ;



        end
    endgenerate


    wire       Alu1SelectAblS2P [0:7] ;//for Alu1 INTISSUE[i][0] == `AbleValue 
    wire [4:0] Alu1SelectPtrS2P [0:7] ;
    wire       ALu1SelectOldS2P [0:7] ;     

    wire       Alu2SelectAblS2P [0:7] ; //for Alu2 INTISSUE[i][0] == `EnableValue
    wire [4:0] Alu2SelectPtrS2P [0:7] ;
    wire       Alu2SelectOldS2P [0:7] ;

    wire       MulSelectAblS2P [0:7] ; //for Alu2 INTISSUE[i][0] == `EnableValue
    wire [4:0] MulSelectPtrS2P [0:7] ;
    wire       MulSelectOldS2P [0:7] ;

    wire       DivSelectAblS2P [0:7] ; //for Alu2 INTISSUE[i][0] == `EnableValue
    wire [4:0] DivSelectPtrS2P [0:7] ;
    wire       DivSelectOldS2P [0:7] ;

    genvar c ;
    generate
        for (c =0 ;c<16 ;c=c+2 ) begin
            assign  ALu1SelectOldS2P[c/2] = ((INTISSUE[Alu1SelectPtrS1P[c]][68] == INTISSUE[Alu1SelectPtrS1P[c+1]][68]) & (INTISSUE[Alu1SelectPtrS1P[c]][67:62] < INTISSUE[Alu1SelectPtrS1P[c+1]][67:62])) |
                                            ((INTISSUE[Alu1SelectPtrS1P[c]][68] != INTISSUE[Alu1SelectPtrS1P[c+1]][68]) & (INTISSUE[Alu1SelectPtrS1P[c]][67:62] > INTISSUE[Alu1SelectPtrS1P[c+1]][67:62])) ;

            assign {Alu1SelectAblS2P[c/2],Alu1SelectPtrS2P[c/2]} = {6{(Alu1SelectAblS1P[c] & Alu1SelectAblS1P[c+1] & ALu1SelectOldS2P[c/2])}} & {`AbleValue,Alu1SelectPtrS1P[c]}    |
                                                                   {6{(Alu1SelectAblS1P[c] & Alu1SelectAblS1P[c+1] & ~ALu1SelectOldS2P[c/2])}} & {`AbleValue,Alu1SelectPtrS1P[c+1]} |
                                                                   {6{(Alu1SelectAblS1P[c] & ~Alu1SelectAblS1P[c+1])}} & {`AbleValue,Alu1SelectPtrS1P[c]}                        |
                                                                   {6{(~Alu1SelectAblS1P[c] & Alu1SelectAblS1P[c+1])}} & {`AbleValue,Alu1SelectPtrS1P[c+1]}                      ;

            assign  Alu2SelectOldS2P[c/2] = ((INTISSUE[Alu2SelectPtrS1P[c]][68] == INTISSUE[Alu2SelectPtrS1P[c+1]][68]) & (INTISSUE[Alu2SelectPtrS1P[c]][67:62] < INTISSUE[Alu2SelectPtrS1P[c+1]][67:62])) |
                                            ((INTISSUE[Alu2SelectPtrS1P[c]][68] != INTISSUE[Alu2SelectPtrS1P[c+1]][68]) & (INTISSUE[Alu2SelectPtrS1P[c]][67:62] > INTISSUE[Alu2SelectPtrS1P[c+1]][67:62])) ;

            assign {Alu2SelectAblS2P[c/2],Alu2SelectPtrS2P[c/2]} = {6{(Alu2SelectAblS1P[c] & Alu2SelectAblS1P[c+1] & Alu2SelectOldS2P[c/2])}} & {`AbleValue,Alu2SelectPtrS1P[c]}    |
                                                                   {6{(Alu2SelectAblS1P[c] & Alu2SelectAblS1P[c+1] & ~Alu2SelectOldS2P[c/2])}} & {`AbleValue,Alu2SelectPtrS1P[c+1]} |
                                                                   {6{(Alu2SelectAblS1P[c] & ~Alu2SelectAblS1P[c+1])}} & {`AbleValue,Alu2SelectPtrS1P[c]}                        |
                                                                   {6{(~Alu2SelectAblS1P[c] & Alu2SelectAblS1P[c+1])}} & {`AbleValue,Alu2SelectPtrS1P[c+1]}                      ;

            assign  MulSelectOldS2P[c/2] =  ((INTISSUE[MulSelectPtrS1P[c]][68] == INTISSUE[MulSelectPtrS1P[c+1]][68]) & (INTISSUE[MulSelectPtrS1P[c]][67:62] < INTISSUE[MulSelectPtrS1P[c+1]][67:62])) |
                                            ((INTISSUE[MulSelectPtrS1P[c]][68] != INTISSUE[MulSelectPtrS1P[c+1]][68]) & (INTISSUE[MulSelectPtrS1P[c]][67:62] > INTISSUE[MulSelectPtrS1P[c+1]][67:62])) ;

            assign {MulSelectAblS2P[c/2],MulSelectPtrS2P[c/2]} =   {6{(MulSelectAblS1P[c] & MulSelectAblS1P[c+1] & MulSelectOldS2P[c/2])}} & {`AbleValue,MulSelectPtrS1P[c]}    |
                                                                   {6{(MulSelectAblS1P[c] & MulSelectAblS1P[c+1] & ~MulSelectOldS2P[c/2])}} & {`AbleValue,MulSelectPtrS1P[c+1]} |
                                                                   {6{(MulSelectAblS1P[c] & ~MulSelectAblS1P[c+1])}} & {`AbleValue,MulSelectPtrS1P[c]}                        |
                                                                   {6{(~MulSelectAblS1P[c] & MulSelectAblS1P[c+1])}} & {`AbleValue,MulSelectPtrS1P[c+1]}                      ;

            assign  DivSelectOldS2P[c/2] =  ((INTISSUE[DivSelectPtrS1P[c]][68] == INTISSUE[DivSelectPtrS1P[c+1]][68]) & (INTISSUE[DivSelectPtrS1P[c]][67:62] < INTISSUE[DivSelectPtrS1P[c+1]][67:62])) |
                                            ((INTISSUE[DivSelectPtrS1P[c]][68] != INTISSUE[DivSelectPtrS1P[c+1]][68]) & (INTISSUE[DivSelectPtrS1P[c]][67:62] > INTISSUE[DivSelectPtrS1P[c+1]][67:62])) ;

            assign {DivSelectAblS2P[c/2],DivSelectPtrS2P[c/2]} = {6{(DivSelectAblS1P[c] & DivSelectAblS1P[c+1] & DivSelectOldS2P[c/2])}} & {`AbleValue,DivSelectPtrS1P[c]}    |
                                                                   {6{(DivSelectAblS1P[c] & DivSelectAblS1P[c+1] & ~DivSelectOldS2P[c/2])}} & {`AbleValue,DivSelectPtrS1P[c+1]} |
                                                                   {6{(DivSelectAblS1P[c] & ~DivSelectAblS1P[c+1])}} & {`AbleValue,DivSelectPtrS1P[c]}                        |
                                                                   {6{(~DivSelectAblS1P[c] & DivSelectAblS1P[c+1])}} & {`AbleValue,DivSelectPtrS1P[c+1]}                      ;
        end
    endgenerate

    wire       Alu1SelectAblS3P [0:3] ;//for Alu1 INTISSUE[i][0] == `AbleValue 
    wire [4:0] Alu1SelectPtrS3P [0:3] ;
    wire       ALu1SelectOldS3P [0:3] ;

    wire       Alu2SelectAblS3P [0:3] ;//for Alu1 INTISSUE[i][0] == `AbleValue 
    wire [4:0] Alu2SelectPtrS3P [0:3] ;
    wire       ALu2SelectOldS3P [0:3] ; 

    wire       MulSelectAblS3P [0:3] ;//for Alu1 INTISSUE[i][0] == `AbleValue 
    wire [4:0] MulSelectPtrS3P [0:3] ;
    wire       MulSelectOldS3P [0:3] ; 

    wire       DivSelectAblS3P [0:3] ;//for Alu1 INTISSUE[i][0] == `AbleValue 
    wire [4:0] DivSelectPtrS3P [0:3] ;
    wire       DivSelectOldS3P [0:3] ;      

    genvar d ;
    generate
        for (d =0 ;d<8 ;d=d+2 ) begin
            assign ALu1SelectOldS3P[d/2] = ((INTISSUE[Alu1SelectPtrS2P[d]][68] == INTISSUE[Alu1SelectPtrS2P[d+1]][68]) & (INTISSUE[Alu1SelectPtrS2P[d]][67:62] < INTISSUE[Alu1SelectPtrS2P[d+1]][67:62])) |
                                           ((INTISSUE[Alu1SelectPtrS2P[d]][68] != INTISSUE[Alu1SelectPtrS2P[d+1]][68]) & (INTISSUE[Alu1SelectPtrS2P[d]][67:62] > INTISSUE[Alu1SelectPtrS2P[d+1]][67:62])) ;

            assign {Alu1SelectAblS3P[d/2],Alu1SelectPtrS3P[d/2]} = {6{(Alu1SelectAblS2P[d] & Alu1SelectAblS2P[d+1] & ALu1SelectOldS3P[d/2])}} & {`AbleValue,Alu1SelectPtrS2P[d]} |
                                                                   {6{(Alu1SelectAblS2P[d] & Alu1SelectAblS2P[d+1] & ALu1SelectOldS3P[d/2])}} & {`AbleValue,Alu1SelectPtrS2P[d]} |
                                                                   {6{(Alu1SelectAblS2P[d] & ~Alu1SelectAblS2P[d+1])}} & {`AbleValue,Alu1SelectPtrS2P[d]} |
                                                                   {6{(~Alu1SelectAblS2P[d] & Alu1SelectAblS2P[d+1])}} & {`AbleValue,Alu1SelectPtrS2P[d+1]} ;

            assign ALu2SelectOldS3P[d/2] = ((INTISSUE[Alu2SelectPtrS2P[d]][68] == INTISSUE[Alu2SelectPtrS2P[d+1]][68]) & (INTISSUE[Alu2SelectPtrS2P[d]][67:62] < INTISSUE[Alu2SelectPtrS2P[d+1]][67:62])) |
                                           ((INTISSUE[Alu2SelectPtrS2P[d]][68] != INTISSUE[Alu2SelectPtrS2P[d+1]][68]) & (INTISSUE[Alu2SelectPtrS2P[d]][67:62] > INTISSUE[Alu2SelectPtrS2P[d+1]][67:62])) ;

            assign {Alu2SelectAblS3P[d/2],Alu2SelectPtrS3P[d/2]} = {6{(Alu2SelectAblS2P[d] & Alu2SelectAblS2P[d+1] & ALu2SelectOldS3P[d/2])}} & {`AbleValue,Alu2SelectPtrS2P[d]} |
                                                                   {6{(Alu2SelectAblS2P[d] & Alu2SelectAblS2P[d+1] & ALu2SelectOldS3P[d/2])}} & {`AbleValue,Alu2SelectPtrS2P[d]} |
                                                                   {6{(Alu2SelectAblS2P[d] & ~Alu2SelectAblS2P[d+1])}} & {`AbleValue,Alu2SelectPtrS2P[d]} |
                                                                   {6{(~Alu2SelectAblS2P[d] & Alu2SelectAblS2P[d+1])}} & {`AbleValue,Alu2SelectPtrS2P[d+1]} ;

            assign MulSelectOldS3P[d/2] =  ((INTISSUE[MulSelectPtrS2P[d]][68] == INTISSUE[MulSelectPtrS2P[d+1]][68]) & (INTISSUE[MulSelectPtrS2P[d]][67:62] < INTISSUE[MulSelectPtrS2P[d+1]][67:62])) |
                                           ((INTISSUE[MulSelectPtrS2P[d]][68] != INTISSUE[MulSelectPtrS2P[d+1]][68]) & (INTISSUE[MulSelectPtrS2P[d]][67:62] > INTISSUE[MulSelectPtrS2P[d+1]][67:62])) ;

            assign {MulSelectAblS3P[d/2],MulSelectPtrS3P[d/2]} =   {6{(MulSelectAblS2P[d] & MulSelectAblS2P[d+1] & MulSelectOldS3P[d/2])}} & {`AbleValue,MulSelectPtrS2P[d]} |
                                                                   {6{(MulSelectAblS2P[d] & MulSelectAblS2P[d+1] & MulSelectOldS3P[d/2])}} & {`AbleValue,MulSelectPtrS2P[d]} |
                                                                   {6{(MulSelectAblS2P[d] & ~MulSelectAblS2P[d+1])}} & {`AbleValue,MulSelectPtrS2P[d]} |
                                                                   {6{(~MulSelectAblS2P[d] & MulSelectAblS2P[d+1])}} & {`AbleValue,MulSelectPtrS2P[d+1]} ;

            assign DivSelectOldS3P[d/2] =  ((INTISSUE[DivSelectPtrS2P[d]][68] == INTISSUE[DivSelectPtrS2P[d+1]][68]) & (INTISSUE[DivSelectPtrS2P[d]][67:62] < INTISSUE[DivSelectPtrS2P[d+1]][67:62])) |
                                           ((INTISSUE[DivSelectPtrS2P[d]][68] != INTISSUE[DivSelectPtrS2P[d+1]][68]) & (INTISSUE[DivSelectPtrS2P[d]][67:62] > INTISSUE[DivSelectPtrS2P[d+1]][67:62])) ;

            assign {DivSelectAblS3P[d/2],DivSelectPtrS3P[d/2]} =   {6{(DivSelectAblS2P[d] & Alu1SelectAblS2P[d+1] & DivSelectOldS3P[d/2])}} & {`AbleValue,DivSelectPtrS2P[d]} |
                                                                   {6{(DivSelectAblS2P[d] & Alu1SelectAblS2P[d+1] & DivSelectOldS3P[d/2])}} & {`AbleValue,DivSelectPtrS2P[d]} |
                                                                   {6{(DivSelectAblS2P[d] & ~Alu1SelectAblS2P[d+1])}} & {`AbleValue,DivSelectPtrS2P[d]} |
                                                                   {6{(~DivSelectAblS2P[d] & Alu1SelectAblS2P[d+1])}} & {`AbleValue,DivSelectPtrS2P[d+1]} ;
        end
    endgenerate

    wire       Alu1SelectAblS4P [0:1] ;//for Alu1 INTISSUE[i][0] == `AbleValue 
    wire [4:0] Alu1SelectPtrS4P [0:1] ;
    wire       ALu1SelectOldS4P [0:1] ;

    wire       Alu2SelectAblS4P [0:1] ;//for Alu1 INTISSUE[i][0] == `AbleValue 
    wire [4:0] Alu2SelectPtrS4P [0:1] ;
    wire       ALu2SelectOldS4P [0:1] ;

    wire       MulSelectAblS4P [0:1] ;//for Alu1 INTISSUE[i][0] == `AbleValue 
    wire [4:0] MulSelectPtrS4P [0:1] ;
    wire       MulSelectOldS4P [0:1] ;

    wire       DivSelectAblS4P [0:1] ;//for Alu1 INTISSUE[i][0] == `AbleValue 
    wire [4:0] DivSelectPtrS4P [0:1] ;
    wire       DivSelectOldS4P [0:1] ;

    genvar e ;
    generate
        for (e =0 ;e<4 ;e=e+2 ) begin
            assign ALu1SelectOldS4P[e/2] = ((INTISSUE[Alu1SelectPtrS3P[e]][68] == INTISSUE[Alu1SelectPtrS3P[e+1]][68]) & (INTISSUE[Alu1SelectPtrS3P[e]][67:62] < INTISSUE[Alu1SelectPtrS3P[e+1]][67:62])) |
                                           ((INTISSUE[Alu1SelectPtrS3P[e]][68] != INTISSUE[Alu1SelectPtrS3P[e+1]][68]) & (INTISSUE[Alu1SelectPtrS3P[e]][67:62] > INTISSUE[Alu1SelectPtrS3P[e+1]][67:62])) ;
            assign {Alu1SelectAblS4P[e/2],Alu1SelectPtrS4P[e/2]} = {6{(Alu1SelectAblS3P[e] & Alu1SelectAblS3P[e+1] & ALu1SelectOldS4P[e/2])}} & {`AbleValue,Alu1SelectPtrS3P[e]} |
                                                                   {6{(Alu1SelectAblS3P[e] & Alu1SelectAblS3P[e+1] & ~ALu1SelectOldS4P[e/2])}} & {`AbleValue,Alu1SelectPtrS3P[e+1]} |
                                                                   {6{(Alu1SelectAblS3P[e] & ~Alu1SelectAblS3P[e+1])}} & {`AbleValue,Alu1SelectPtrS3P[e]} |
                                                                   {6{(~Alu1SelectAblS3P[e] & Alu1SelectAblS3P[e+1])}} & {`AbleValue,Alu1SelectPtrS3P[e+1]} ;
                                                            
            assign ALu2SelectOldS4P[e/2] = ((INTISSUE[Alu2SelectPtrS3P[e]][68] == INTISSUE[Alu2SelectPtrS3P[e+1]][68]) & (INTISSUE[Alu2SelectPtrS3P[e]][67:62] < INTISSUE[Alu2SelectPtrS3P[e+1]][67:62])) |
                                           ((INTISSUE[Alu2SelectPtrS3P[e]][68] != INTISSUE[Alu2SelectPtrS3P[e+1]][68]) & (INTISSUE[Alu2SelectPtrS3P[e]][67:62] > INTISSUE[Alu2SelectPtrS3P[e+1]][67:62])) ;
            assign {Alu2SelectAblS4P[e/2],Alu2SelectPtrS4P[e/2]} = {6{(Alu2SelectAblS3P[e] & Alu2SelectAblS3P[e+1] & ALu2SelectOldS4P[e/2])}} & {`AbleValue,Alu2SelectPtrS3P[e]} |
                                                                   {6{(Alu2SelectAblS3P[e] & Alu2SelectAblS3P[e+1] & ~ALu2SelectOldS4P[e/2])}} & {`AbleValue,Alu2SelectPtrS3P[e+1]} |
                                                                   {6{(Alu2SelectAblS3P[e] & ~Alu2SelectAblS3P[e+1])}} & {`AbleValue,Alu2SelectPtrS3P[e]} |
                                                                   {6{(~Alu2SelectAblS3P[e] & Alu2SelectAblS3P[e+1])}} & {`AbleValue,Alu2SelectPtrS3P[e+1]} ;

            assign MulSelectOldS4P[e/2] =  ((INTISSUE[MulSelectPtrS3P[e]][68] == INTISSUE[MulSelectPtrS3P[e+1]][68]) & (INTISSUE[MulSelectPtrS3P[e]][67:62] < INTISSUE[MulSelectPtrS3P[e+1]][67:62])) |
                                           ((INTISSUE[MulSelectPtrS3P[e]][68] != INTISSUE[MulSelectPtrS3P[e+1]][68]) & (INTISSUE[MulSelectPtrS3P[e]][67:62] > INTISSUE[MulSelectPtrS3P[e+1]][67:62])) ;
            assign {MulSelectAblS4P[e/2],MulSelectPtrS4P[e/2]} =   {6{(MulSelectAblS3P[e] & MulSelectAblS3P[e+1] & MulSelectOldS4P[e/2])}} & {`AbleValue,MulSelectPtrS3P[e]} |
                                                                   {6{(MulSelectAblS3P[e] & MulSelectAblS3P[e+1] & ~MulSelectOldS4P[e/2])}} & {`AbleValue,MulSelectPtrS3P[e+1]} |
                                                                   {6{(MulSelectAblS3P[e] & ~MulSelectAblS3P[e+1])}} & {`AbleValue,MulSelectPtrS3P[e]} |
                                                                   {6{(~MulSelectAblS3P[e] & MulSelectAblS3P[e+1])}} & {`AbleValue,MulSelectPtrS3P[e+1]} ;

            assign DivSelectOldS4P[e/2] =  ((INTISSUE[DivSelectPtrS3P[e]][68] == INTISSUE[DivSelectPtrS3P[e+1]][68]) & (INTISSUE[DivSelectPtrS3P[e]][67:62] < INTISSUE[DivSelectPtrS3P[e+1]][67:62])) |
                                           ((INTISSUE[DivSelectPtrS3P[e]][68] != INTISSUE[DivSelectPtrS3P[e+1]][68]) & (INTISSUE[DivSelectPtrS3P[e]][67:62] > INTISSUE[DivSelectPtrS3P[e+1]][67:62])) ;
            assign {DivSelectAblS4P[e/2],DivSelectPtrS4P[e/2]} =   {6{(DivSelectAblS3P[e] & DivSelectAblS3P[e+1] & DivSelectOldS4P[e/2])}} & {`AbleValue,DivSelectPtrS3P[e]} |
                                                                   {6{(DivSelectAblS3P[e] & DivSelectAblS3P[e+1] & ~DivSelectOldS4P[e/2])}} & {`AbleValue,DivSelectPtrS3P[e+1]} |
                                                                   {6{(DivSelectAblS3P[e] & ~DivSelectAblS3P[e+1])}} & {`AbleValue,DivSelectPtrS3P[e]} |
                                                                   {6{(~DivSelectAblS3P[e] & DivSelectAblS3P[e+1])}} & {`AbleValue,DivSelectPtrS3P[e+1]} ;
        end 
    endgenerate

    wire       Alu1SelectAblS5P  ;//for Alu1 INTISSUE[i][0] == `AbleValue 
    wire [4:0] Alu1SelectPtrS5P  ;
    wire       ALu1SelectOldS5P  ;

    wire       Alu2SelectAblS5P  ;//for Alu1 INTISSUE[i][0] == `AbleValue 
    wire [4:0] Alu2SelectPtrS5P  ;
    wire       ALu2SelectOldS5P  ;

    wire       MulSelectAblS5P  ;//for Alu1 INTISSUE[i][0] == `AbleValue 
    wire [4:0] MulSelectPtrS5P  ;
    wire       MulSelectOldS5P  ;

    wire       DivSelectAblS5P  ;//for Alu1 INTISSUE[i][0] == `AbleValue 
    wire [4:0] DivSelectPtrS5P  ;
    wire       DivSelectOldS5P  ;

    assign ALu1SelectOldS5P = ((INTISSUE[Alu1SelectPtrS4P[0]][68] == INTISSUE[Alu1SelectPtrS4P[1]][68]) & (INTISSUE[Alu1SelectPtrS4P[0]][67:62] < INTISSUE[Alu1SelectPtrS4P[1]][67:62])) |
                              ((INTISSUE[Alu1SelectPtrS4P[0]][68] != INTISSUE[Alu1SelectPtrS4P[1]][68]) & (INTISSUE[Alu1SelectPtrS4P[0]][67:62] > INTISSUE[Alu1SelectPtrS4P[1]][67:62])) ;

    assign {Alu1SelectAblS5P,Alu1SelectPtrS5P} = {6{(Alu1SelectAblS4P[0] & Alu1SelectAblS4P[1] & ALu1SelectOldS5P)}} & {`AbleValue,Alu1SelectPtrS4P[0]} |
                                                 {6{(Alu1SelectAblS4P[0] & Alu1SelectAblS4P[1] & ~ALu1SelectOldS5P)}} & {`AbleValue,Alu1SelectPtrS4P[1]} |
                                                 {6{(Alu1SelectAblS4P[0] & ~Alu1SelectAblS4P[1])}} & {`AbleValue,Alu1SelectPtrS4P[0]} |
                                                 {6{(~Alu1SelectAblS4P[0] & Alu1SelectAblS4P[1])}} & {`AbleValue,Alu1SelectPtrS4P[1]} ;

    assign ALu2SelectOldS5P = ((INTISSUE[Alu2SelectPtrS4P[0]][68] == INTISSUE[Alu2SelectPtrS4P[1]][68]) & (INTISSUE[Alu2SelectPtrS4P[0]][67:62] < INTISSUE[Alu2SelectPtrS4P[1]][67:62])) |
                              ((INTISSUE[Alu2SelectPtrS4P[0]][68] != INTISSUE[Alu2SelectPtrS4P[1]][68]) & (INTISSUE[Alu2SelectPtrS4P[0]][67:62] > INTISSUE[Alu2SelectPtrS4P[1]][67:62])) ;

    assign {Alu2SelectAblS5P,Alu2SelectPtrS5P} = {6{(Alu2SelectAblS4P[0] & Alu2SelectAblS4P[1] & ALu2SelectOldS5P)}} & {`AbleValue,Alu2SelectPtrS4P[0]} |
                                                 {6{(Alu2SelectAblS4P[0] & Alu2SelectAblS4P[1] & ~ALu2SelectOldS5P)}} & {`AbleValue,Alu2SelectPtrS4P[1]} |
                                                 {6{(Alu2SelectAblS4P[0] & ~Alu2SelectAblS4P[1])}} & {`AbleValue,Alu2SelectPtrS4P[0]} |
                                                 {6{(~Alu2SelectAblS4P[0] & Alu2SelectAblS4P[1])}} & {`AbleValue,Alu2SelectPtrS4P[1]} ;

    assign MulSelectOldS5P =  ((INTISSUE[MulSelectPtrS4P[0]][68] == INTISSUE[MulSelectPtrS4P[1]][68]) & (INTISSUE[MulSelectPtrS4P[0]][67:62] < INTISSUE[MulSelectPtrS4P[1]][67:62])) |
                              ((INTISSUE[MulSelectPtrS4P[0]][68] != INTISSUE[MulSelectPtrS4P[1]][68]) & (INTISSUE[MulSelectPtrS4P[0]][67:62] > INTISSUE[MulSelectPtrS4P[1]][67:62])) ;

    assign {MulSelectAblS5P,MulSelectPtrS5P} =   {6{(MulSelectAblS4P[0] & MulSelectAblS4P[1] & MulSelectOldS5P)}} & {`AbleValue,MulSelectPtrS4P[0]} |
                                                 {6{(MulSelectAblS4P[0] & MulSelectAblS4P[1] & ~MulSelectOldS5P)}} & {`AbleValue,MulSelectPtrS4P[1]} |
                                                 {6{(MulSelectAblS4P[0] & ~MulSelectAblS4P[1])}} & {`AbleValue,MulSelectPtrS4P[0]} |
                                                 {6{(~MulSelectAblS4P[0] & MulSelectAblS4P[1])}} & {`AbleValue,MulSelectPtrS4P[1]} ;

    assign DivSelectOldS5P =  ((INTISSUE[DivSelectPtrS4P[0]][68] == INTISSUE[DivSelectPtrS4P[1]][68]) & (INTISSUE[DivSelectPtrS4P[0]][67:62] < INTISSUE[DivSelectPtrS4P[1]][67:62])) |
                              ((INTISSUE[DivSelectPtrS4P[0]][68] != INTISSUE[DivSelectPtrS4P[1]][68]) & (INTISSUE[DivSelectPtrS4P[0]][67:62] > INTISSUE[DivSelectPtrS4P[1]][67:62])) ;

    assign {DivSelectAblS5P,DivSelectPtrS5P} =   {6{(DivSelectAblS4P[0] & DivSelectAblS4P[1] & DivSelectOldS5P)}} & {`AbleValue,DivSelectPtrS4P[0]} |
                                                 {6{(DivSelectAblS4P[0] & DivSelectAblS4P[1] & ~DivSelectOldS5P)}} & {`AbleValue,DivSelectPtrS4P[1]} |
                                                 {6{(DivSelectAblS4P[0] & ~DivSelectAblS4P[1])}} & {`AbleValue,DivSelectPtrS4P[0]} |
                                                 {6{(~DivSelectAblS4P[0] & DivSelectAblS4P[1])}} & {`AbleValue,DivSelectPtrS4P[1]} ;


   

    //boradcost

    //for delay
    reg [2:0]  MulShiftDelay ;
    reg [4:0]  MulDelayAddr  ;
    always @(posedge Clk) begin
        if(!Rest)begin
            MulShiftDelay <= 3'd0 ;
            MulDelayAddr  <= 5'd0 ;
        end
        else if(IsQuIntFlash) begin
            MulShiftDelay <= 3'd0 ;
            MulDelayAddr  <= 5'd0 ;
        end
        else if(IsQuIntStop) begin
            MulShiftDelay <= MulShiftDelay ;
            MulDelayAddr  <= MulDelayAddr ;
        end
        else begin
            if(MulSelectAblS5P) begin
                MulShiftDelay <= 3'b100 ;
                MulDelayAddr  <=  MulSelectPtrS5P ;
            end 
            else begin
                MulShiftDelay <= {1'b0,MulShiftDelay[1:0]} ;
                MulDelayAddr  <= MulDelayAddr ;
            end 
        end
    end

    assign Alu1BroadcastAble = Alu1SelectAblS5P & INTISSUE[Alu1SelectPtrS5P][43] & ~StopTemp            ;
    assign Alu1BroadcastAddr = INTISSUE[Alu1SelectPtrS5P][42:36] & {7{~StopTemp }}      ;
    assign Alu2BroadcastAble = Alu2SelectAblS5P & INTISSUE[Alu2SelectPtrS5P][43] & ~StopTemp            ;
    assign Alu2BroadcastAddr = INTISSUE[Alu2SelectPtrS5P][42:36] & {7{~StopTemp }}      ;
    assign MulBroadcastAble  = (MulShiftDelay == 3'b001) & INTISSUE[MulDelayAddr][43] & ~StopTemp       ;
    assign MulBroadcastAddr  = INTISSUE[MulDelayAddr][42:36]     & {7{~StopTemp }}      ;

    wire Inst1SelectAble   = Alu1SelectAblS5P & ~StopTemp ;
    wire [4:0] Inst1SelectPtr    = Alu1SelectPtrS5P & {5{~StopTemp}};
    wire Inst2SelectAble   = Alu2SelectAblS5P & ~StopTemp ;
    wire [4:0] Inst2SelectPtr    = Alu2SelectPtrS5P & {5{~StopTemp}};
    wire Inst3SelectAble   = MulSelectAblS5P & ~StopTemp ;
    wire [4:0] Inst3SelectPtr    = MulSelectPtrS5P & {5{~StopTemp}};
    wire Inst4SelectAble   = DivSelectAblS5P & ~StopTemp ;
    wire [4:0]Inst4SelectPtr    = DivSelectPtrS5P & {5{~StopTemp}};


    assign Alu1Inst          = Alu1BroadcastAble ;
    assign Alu1InstAddr      = Alu1BroadcastAddr ;
    assign Alu2Inst          = Alu2BroadcastAble ;
    assign ALu2InstAddr      = Alu2BroadcastAddr ;
    assign MulInst           = MulBroadcastAble  ;
    assign MulInstAddr       = MulBroadcastAddr  ;

    //to read physical

    assign Inst1MicOperate = Alu1Req ? INTISSUE[Alu1SelectPtrS5P][35:28] : 8'b0 ;
    assign Inst1Src1RAble  = Alu1Req ? INTISSUE[Alu1SelectPtrS5P][52]    : 1'b0 ;
    assign Inst1Src1RAddr  = Alu1Req ? INTISSUE[Alu1SelectPtrS5P][50:44] : 7'b0 ; 
    assign Inst1Src2RAble  = Alu1Req ? INTISSUE[Alu1SelectPtrS5P][61]    : 1'b0 ;
    assign Inst1Src2RAddr  = Alu1Req ? INTISSUE[Alu1SelectPtrS5P][59:53] : 7'b0 ;
    assign Inst1ImmAble    = Alu1Req ? INTISSUE[Alu1SelectPtrS5P][27]    : 1'b0 ;
    assign Inst1ImmDate    = Alu1Req ? INTISSUE[Alu1SelectPtrS5P][26:1]  : 26'b0;
    assign Inst1RdAble     = Alu1Req ? INTISSUE[Alu1SelectPtrS5P][43]    : 1'b0 ;
    assign Inst1RdAddr     = Alu1Req ? INTISSUE[Alu1SelectPtrS5P][42:36] : 7'b0 ;
    assign Inst1RoBptr     = Alu1Req ? INTISSUE[Alu1SelectPtrS5P][67:62] : 6'b0 ;

    assign Inst2MicOperate = Alu2Req ? INTISSUE[Alu2SelectPtrS5P][35:28] : 8'b0 ;
    assign Inst2Src1RAble  = Alu2Req ? INTISSUE[Alu2SelectPtrS5P][52]    : 1'b0 ;
    assign Inst2Src1RAddr  = Alu2Req ? INTISSUE[Alu2SelectPtrS5P][50:44] : 7'b0 ; 
    assign Inst2Src2RAble  = Alu2Req ? INTISSUE[Alu2SelectPtrS5P][61]    : 1'b0 ;
    assign Inst2Src2RAddr  = Alu2Req ? INTISSUE[Alu2SelectPtrS5P][59:53] : 7'b0 ;
    assign Inst2ImmAble    = Alu2Req ? INTISSUE[Alu2SelectPtrS5P][27]    : 1'b0 ;
    assign Inst2ImmDate    = Alu2Req ? INTISSUE[Alu2SelectPtrS5P][26:1]  : 26'b0;
    assign Inst2RdAble     = Alu2Req ? INTISSUE[Alu2SelectPtrS5P][43]    : 1'b0 ;
    assign Inst2RdAddr     = Alu2Req ? INTISSUE[Alu2SelectPtrS5P][42:36] : 7'b0 ;
    assign Inst2RoBptr     = Alu2Req ? INTISSUE[Alu2SelectPtrS5P][67:62] : 6'b0 ;

    assign Inst3MicOperate = MulReq ? INTISSUE[MulSelectPtrS5P][35:28] : 8'b0 ;
    assign Inst3Src1RAble  = MulReq ? INTISSUE[MulSelectPtrS5P][52]    : 1'b0 ;
    assign Inst3Src1RAddr  = MulReq ? INTISSUE[MulSelectPtrS5P][50:44] : 7'b0 ; 
    assign Inst3Src2RAble  = MulReq ? INTISSUE[MulSelectPtrS5P][61]    : 1'b0 ;
    assign Inst3Src2RAddr  = MulReq ? INTISSUE[MulSelectPtrS5P][59:53] : 7'b0 ;
    assign Inst3ImmAble    = MulReq ? INTISSUE[MulSelectPtrS5P][27]    : 1'b0 ;
    assign Inst3ImmDate    = MulReq ? INTISSUE[MulSelectPtrS5P][26:1]  : 26'b0;
    assign Inst3RdAble     = MulReq ? INTISSUE[MulSelectPtrS5P][43]    : 1'b0 ;
    assign Inst3RdAddr     = MulReq ? INTISSUE[MulSelectPtrS5P][42:36] : 7'b0 ;
    assign Inst3RoBptr     = MulReq ? INTISSUE[MulSelectPtrS5P][67:62] : 6'b0 ;

    assign Inst4MicOperate = DivReq ? INTISSUE[DivSelectPtrS5P][35:28] : 8'b0 ;
    assign Inst4Src1RAble  = DivReq ? INTISSUE[DivSelectPtrS5P][52]    : 1'b0 ;
    assign Inst4Src1RAddr  = DivReq ? INTISSUE[DivSelectPtrS5P][50:44] : 7'b0 ; 
    assign Inst4Src2RAble  = DivReq ? INTISSUE[DivSelectPtrS5P][61]    : 1'b0 ;
    assign Inst4Src2RAddr  = DivReq ? INTISSUE[DivSelectPtrS5P][59:53] : 7'b0 ;
    assign Inst4ImmAble    = DivReq ? INTISSUE[DivSelectPtrS5P][27]    : 1'b0 ;
    assign Inst4ImmDate    = DivReq ? INTISSUE[DivSelectPtrS5P][26:1]  : 26'b0;
    assign Inst4RdAble     = DivReq ? INTISSUE[DivSelectPtrS5P][43]    : 1'b0 ;
    assign Inst4RdAddr     = DivReq ? INTISSUE[DivSelectPtrS5P][42:36] : 7'b0 ;
    assign Inst4RoBptr     = DivReq ? INTISSUE[DivSelectPtrS5P][67:62] : 6'b0 ;

endmodule 
`timescale 1ps/1ps
`include "../define.v"
`include "../../Lib/BrCsrIQ1Criq4.v"
`include "../../Lib/BrCsrIQ2Criq4.v"
`include "../../Lib/BrCsrIQ3Criq4.v"
`include "../../Lib/BrCsrIQ4Criq4.v"

module IssueQueueMem ( 
    input        wire                                     Clk               ,
    input        wire                                     Rest              ,
    //for ctrl
    input        wire                                     MemQStop          ,
    input        wire                                     MemQFlash         ,
    output       wire                                     MemReq            ,
    //from RAT
    input       wire                                      InIQMemNum        ,
    input       wire                                      MIn1Src1Able      ,
    input       wire                                      MIn1Src1Ready     ,
    input       wire        [`ReNameRegBUs]               MIn1Src1Addr      ,
    input       wire                                      MIn1Src2Able      ,
    input       wire                                      MIn1Src2Ready     ,
    input       wire        [`ReNameRegBUs]               MIn1Src2Addr      ,
    input       wire                                      MIn1RdAble        ,
    input       wire        [`ReNameRegBUs]               MIn1RdAddr        ,
    input       wire                                      MIn2Src1Able      ,
    input       wire                                      MIn2Src1Ready     ,
    input       wire        [`ReNameRegBUs]               MIn2Src1Addr      ,
    input       wire                                      MIn2Src2Able      ,
    input       wire                                      MIn2Src2Ready     ,
    input       wire        [`ReNameRegBUs]               MIn2Src2Addr      ,
    input       wire                                      MIn2RdAble        ,
    input       wire        [`ReNameRegBUs]               MIn2RdAddr        ,
    input       wire                                      MIn3Src1Able      ,
    input       wire                                      MIn3Src1Ready     ,
    input       wire        [`ReNameRegBUs]               MIn3Src1Addr      ,
    input       wire                                      MIn3Src2Able      ,
    input       wire                                      MIn3Src2Ready     ,
    input       wire        [`ReNameRegBUs]               MIn3Src2Addr      ,
    input       wire                                      MIn3RdAble        ,
    input       wire        [`ReNameRegBUs]               MIn3RdAddr        ,
    input       wire                                      MIn4Src1Able      ,
    input       wire                                      MIn4Src1Ready     ,
    input       wire        [`ReNameRegBUs]               MIn4Src1Addr      ,
    input       wire                                      MIn4Src2Able      ,
    input       wire                                      MIn4Src2Ready     ,
    input       wire        [`ReNameRegBUs]               MIn4Src2Addr      ,
    input       wire                                      MIn4RdAble        ,
    input       wire        [`ReNameRegBUs]               MIn4RdAddr        ,
    //from decode delay 1 clcye
    input       wire                                      MIn1aAble         ,
    input       wire        [`MicOperateCode]             MIn1MicOpcode     ,
    input       wire                                      MIn1ImmAble       ,
    input       wire        [25:0]                        MIn1ImmDate       ,
    input       wire        [6:0]                         MIn1RobPtr        ,
    input       wire                                      MIn2aAble         ,
    input       wire        [`MicOperateCode]             MIn2MicOpcode     ,
    input       wire                                      MIn2ImmAble       ,
    input       wire        [25:0]                        MIn2ImmDate       ,
    input       wire        [6:0]                         MIn2RobPtr        ,
    input       wire                                      MIn3aAble         ,
    input       wire        [`MicOperateCode]             MIn3MicOpcode     ,
    input       wire                                      MIn3ImmAble       ,
    input       wire        [25:0]                        MIn3ImmDate       ,
    input       wire        [6:0]                         MIn3RobPtr        ,
    input       wire                                      MIn4aAble         ,
    input       wire        [`MicOperateCode]             MIn4MicOpcode     ,
    input       wire                                      MIn4ImmAble       ,
    input       wire        [25:0]                        MIn4ImmDate       ,
    input       wire        [6:0]                         MIn4RobPtr        ,
    //eu req 
    input       wire                                      LoadReq           ,
    input       wire                                      StoreReq          ,
    // weak up bus
    input       wire                                      FromBCQBru        ,
    input       wire        [`ReNameRegBUs]               FromBruAddr       ,
    input       wire                                      FromBCQCsr        ,
    input       wire        [`ReNameRegBUs]               FromCsrAddr       ,
    input       wire                                      FromIsQAlu1       ,
    input       wire        [`ReNameRegBUs]               FromAlu1Addr      , 
    input       wire                                      FromIsQAlu2       ,
    input       wire        [`ReNameRegBUs]               FromAlu2Addr      ,//delay broadcast
    input       wire                                      FromIsQMul        ,
    input       wire        [`ReNameRegBUs]               FromMulAddr       ,
    input       wire                                      ByPassMDiv        ,
    input       wire        [`ReNameRegBUs]               ByPassMDivAddr    ,//bypass
    input       wire                                      ByPassMLoad       ,
    input       wire        [`ReNameRegBUs]               ByPassMLoadAddr   ,
    input       wire                                      ByPassMSC         ,
    input       wire        [`ReNameRegBUs]               ByPassMSCAddr     ,
    //to eu 
    output      wire        [`MicOperateCode]             MInst1MicOperate  ,  //load
    output      wire                                      MInst1Src1RAble   ,
    output      wire        [`ReNameRegBUs]               MInst1Src1RAddr   , 
    output      wire                                      MInst1Src2RAble   ,
    output      wire        [`ReNameRegBUs]               MInst1Src2RAddr   ,    
    output      wire                                      MInst1ImmAble     ,
    output      wire        [25:0]                        MInst1ImmDate     ,
    output      wire                                      MInst1RdAble      ,
    output      wire        [`ReNameRegBUs]               MInst1RdAddr      , 
    output      wire        [5:0]                         MInst1RoBptr      ,
    output      wire        [`MicOperateCode]             MInst2MicOperate  ,  //store
    output      wire                                      MInst2Src1RAble   ,
    output      wire        [`ReNameRegBUs]               MInst2Src1RAddr   , 
    output      wire                                      MInst2Src2RAble   ,
    output      wire        [`ReNameRegBUs]               MInst2Src2RAddr   ,    
    output      wire                                      MInst2ImmAble     ,
    output      wire        [25:0]                        MInst2ImmDate     ,
    output      wire                                      MInst2RdAble      ,
    output      wire        [`ReNameRegBUs]               MInst2RdAddr      , 
    output      wire        [5:0]                         MInst2RoBptr      
);

    reg  [68:0] MEMISSUE [0:15] ;
    reg  [2:0]  MWritePtr ;
    reg  [2:0]  MReadPtr  ;


    wire         MInst1Src1Ready = ((MIn1Src1Addr == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                   ((MIn1Src1Addr == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                   ((MIn1Src1Addr == FromMulAddr    ) && (FromIsQMul )) ||
                                   ((MIn1Src1Addr == ByPassMDivAddr ) && (ByPassMDiv )) ||
                                   ((MIn1Src1Addr == ByPassMSCAddr  ) && (ByPassMSC  )) ||
                                   ((MIn1Src1Addr == ByPassMLoadAddr) && (ByPassMLoad)) ||
                                   ((MIn1Src1Addr == FromBruAddr    ) && (FromBCQBru )) ||
                                   ((MIn1Src1Addr == FromCsrAddr    ) && (FromBCQCsr )) ; 

    wire         MInst2Src1Ready = ((MIn2Src1Addr == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                   ((MIn2Src1Addr == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                   ((MIn2Src1Addr == FromMulAddr    ) && (FromIsQMul )) ||
                                   ((MIn2Src1Addr == ByPassMDivAddr ) && (ByPassMDiv )) ||
                                   ((MIn2Src1Addr == ByPassMSCAddr  ) && (ByPassMSC  )) ||
                                   ((MIn2Src1Addr == ByPassMLoadAddr) && (ByPassMLoad)) ||
                                   ((MIn2Src1Addr == FromBruAddr    ) && (FromBCQBru )) ||
                                   ((MIn2Src1Addr == FromCsrAddr    ) && (FromBCQCsr )) ; 

    wire         MInst3Src1Ready = ((MIn3Src1Addr == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                   ((MIn3Src1Addr == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                   ((MIn3Src1Addr == FromMulAddr    ) && (FromIsQMul )) ||
                                   ((MIn3Src1Addr == ByPassMDivAddr ) && (ByPassMDiv )) ||
                                   ((MIn3Src1Addr == ByPassMSCAddr  ) && (ByPassMSC  )) ||
                                   ((MIn3Src1Addr == ByPassMLoadAddr) && (ByPassMLoad)) ||
                                   ((MIn3Src1Addr == FromBruAddr    ) && (FromBCQBru )) ||
                                   ((MIn3Src1Addr == FromCsrAddr    ) && (FromBCQCsr )) ; 

    wire         MInst4Src1Ready = ((MIn4Src1Addr == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                   ((MIn4Src1Addr == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                   ((MIn4Src1Addr == FromMulAddr    ) && (FromIsQMul )) ||
                                   ((MIn4Src1Addr == ByPassMDivAddr ) && (ByPassMDiv )) ||
                                   ((MIn4Src1Addr == ByPassMSCAddr  ) && (ByPassMSC  )) ||
                                   ((MIn4Src1Addr == ByPassMLoadAddr) && (ByPassMLoad)) ||
                                   ((MIn4Src1Addr == FromBruAddr    ) && (FromBCQBru )) ||
                                   ((MIn4Src1Addr == FromCsrAddr    ) && (FromBCQCsr )) ; 

    wire         MInst1Src2Ready = ((MIn1Src2Addr == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                   ((MIn1Src2Addr == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                   ((MIn1Src2Addr == FromMulAddr    ) && (FromIsQMul )) ||
                                   ((MIn1Src2Addr == ByPassMDivAddr ) && (ByPassMDiv )) ||
                                   ((MIn1Src2Addr == ByPassMSCAddr  ) && (ByPassMSC  )) ||
                                   ((MIn1Src2Addr == ByPassMLoadAddr) && (ByPassMLoad)) ||
                                   ((MIn1Src2Addr == FromBruAddr    ) && (FromBCQBru )) ||
                                   ((MIn1Src2Addr == FromCsrAddr    ) && (FromBCQCsr )) ; 

    wire         MInst2Src2Ready = ((MIn2Src2Addr == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                   ((MIn2Src2Addr == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                   ((MIn2Src2Addr == FromMulAddr    ) && (FromIsQMul )) ||
                                   ((MIn2Src2Addr == ByPassMDivAddr ) && (ByPassMDiv )) ||
                                   ((MIn2Src2Addr == ByPassMSCAddr  ) && (ByPassMSC  )) ||
                                   ((MIn2Src2Addr == ByPassMLoadAddr) && (ByPassMLoad)) ||
                                   ((MIn2Src2Addr == FromBruAddr    ) && (FromBCQBru )) ||
                                   ((MIn2Src2Addr == FromCsrAddr    ) && (FromBCQCsr )) ; 

    wire         MInst3Src2Ready = ((MIn3Src2Addr == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                   ((MIn3Src2Addr == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                   ((MIn3Src2Addr == FromMulAddr    ) && (FromIsQMul )) ||
                                   ((MIn3Src2Addr == ByPassMDivAddr ) && (ByPassMDiv )) ||
                                   ((MIn3Src2Addr == ByPassMSCAddr  ) && (ByPassMSC  )) ||
                                   ((MIn3Src2Addr == ByPassMLoadAddr) && (ByPassMLoad)) ||
                                   ((MIn3Src2Addr == FromBruAddr    ) && (FromBCQBru )) ||
                                   ((MIn3Src2Addr == FromCsrAddr    ) && (FromBCQCsr )) ; 

    wire         MInst4Src2Ready = ((MIn4Src2Addr == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                   ((MIn4Src2Addr == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                   ((MIn4Src2Addr == FromMulAddr    ) && (FromIsQMul )) ||
                                   ((MIn4Src2Addr == ByPassMDivAddr ) && (ByPassMDiv )) ||
                                   ((MIn4Src2Addr == ByPassMSCAddr  ) && (ByPassMSC  )) ||
                                   ((MIn4Src2Addr == ByPassMLoadAddr) && (ByPassMLoad)) ||
                                   ((MIn4Src2Addr == FromBruAddr    ) && (FromBCQBru )) ||
                                   ((MIn4Src2Addr == FromCsrAddr    ) && (FromBCQCsr )) ; 


    wire        MInstSrc1Ready [0:15];
    wire        MInstSrc2Ready [0:15];
    genvar ii ;
    generate
        for (ii =0 ;ii<16 ;ii=ii+1 ) begin
            assign MInstSrc1Ready =((MEMISSUE[ii][50:44]  == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                   ((MEMISSUE[ii][50:44]  == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                   ((MEMISSUE[ii][50:44]  == FromMulAddr    ) && (FromIsQMul )) ||
                                   ((MEMISSUE[ii][50:44]  == ByPassMDivAddr ) && (ByPassMDiv )) ||
                                   ((MEMISSUE[ii][50:44]  == ByPassMSCAddr  ) && (ByPassMSC  )) ||
                                   ((MEMISSUE[ii][50:44]  == ByPassMLoadAddr) && (ByPassMLoad)) ||
                                   ((MEMISSUE[ii][50:44]  == FromBruAddr    ) && (FromBCQBru )) ||
                                   ((MEMISSUE[ii][50:44]  == FromCsrAddr    ) && (FromBCQCsr )) ; 

            assign MInstSrc2Ready =((MEMISSUE[ii][59:53]  == FromAlu1Addr   ) && (FromIsQAlu1)) ||
                                   ((MEMISSUE[ii][59:53]  == FromAlu2Addr   ) && (FromIsQAlu2)) ||
                                   ((MEMISSUE[ii][59:53]  == FromMulAddr    ) && (FromIsQMul )) ||
                                   ((MEMISSUE[ii][59:53]  == ByPassMDivAddr ) && (ByPassMDiv )) ||
                                   ((MEMISSUE[ii][59:53]  == ByPassMSCAddr  ) && (ByPassMSC  )) ||
                                   ((MEMISSUE[ii][59:53]  == ByPassMLoadAddr) && (ByPassMLoad)) ||
                                   ((MEMISSUE[ii][59:53]  == FromBruAddr    ) && (FromBCQBru )) ||
                                   ((MEMISSUE[ii][59:53]  == FromCsrAddr    ) && (FromBCQCsr )) ;
        end
    endgenerate

    wire  [68:0]  WriteMIQ1  = {MIn1RobPtr,MIn1Src2Able, ((MemQStop | ~MIn1Src2Able | MIn1Src2Ready) ? MIn1Src2Ready :MInst1Src2Ready), MIn1Src2Addr, 
                                           MIn1Src1Able, ((MemQStop | ~MIn1Src1Able | MIn1Src1Ready) ? MIn1Src1Ready :MInst1Src1Ready), MIn1Src1Addr,
                                           MIn1RdAble, MIn1RdAddr, MIn1ImmAble, MIn1ImmDate,MIn1MicOpcode, `EnableValue} ;

    wire  [68:0]  WriteMIQ2  = {MIn2RobPtr,MIn2Src2Able, ((MemQStop | ~MIn2Src2Able | MIn2Src2Ready) ? MIn2Src2Ready :MInst2Src2Ready), MIn2Src2Addr, 
                                           MIn2Src1Able, ((MemQStop | ~MIn2Src1Able | MIn2Src1Ready) ? MIn2Src1Ready :MInst2Src1Ready), MIn2Src1Addr,
                                           MIn2RdAble, MIn2RdAddr, MIn2ImmAble, MIn2ImmDate,MIn2MicOpcode, `EnableValue} ;

    wire  [68:0]  WriteMIQ3  = {MIn3RobPtr,MIn3Src2Able, ((MemQStop | ~MIn3Src2Able | MIn3Src2Ready) ? MIn3Src2Ready :MInst3Src2Ready), MIn3Src2Addr, 
                                           MIn3Src1Able, ((MemQStop | ~MIn3Src1Able | MIn3Src1Ready) ? MIn3Src1Ready :MInst3Src1Ready), MIn3Src1Addr,
                                           MIn3RdAble, MIn3RdAddr, MIn3ImmAble, MIn3ImmDate,MIn3MicOpcode, `EnableValue} ;

    wire  [68:0]  WriteMIQ4  = {MIn4RobPtr,MIn4Src2Able, ((MemQStop | ~MIn4Src2Able | MIn4Src2Ready) ? MIn4Src2Ready :MInst4Src2Ready), MIn4Src2Addr, 
                                           MIn4Src1Able, ((MemQStop | ~MIn4Src1Able | MIn4Src1Ready) ? MIn4Src1Ready :MInst4Src1Ready), MIn4Src1Addr,
                                           MIn4RdAble, MIn4RdAddr, MIn4ImmAble, MIn4ImmDate,MIn4MicOpcode, `EnableValue} ;   
                                        

    wire [2:0]  MWriteNum  = (MIn1aAble & MIn2aAble & MIn3aAble & MIn4aAble) ? 3'd4 :
                             (MIn1aAble & MIn2aAble & MIn3aAble & ~MIn4aAble) ? 3'd3 :
                             (MIn1aAble & MIn2aAble & ~MIn3aAble & ~MIn4aAble) ? 3'd2 :
                             (MIn1aAble & ~MIn2aAble & ~MIn3aAble & ~MIn4aAble) ? 3'd1 : 3'd0 ;

    always @(posedge Clk) begin
        if(!Rest) begin
            MReadPtr <= 3'd0 ;
        end
        else if(MemQFlash) begin
            MReadPtr <= 3'd0 ;
        end
        else begin
            MReadPtr <= MReadPtr[1:0] + MWriteNum ;
        end
    end

    

    wire  ReadM1Able = (MReadPtr[1:0] == 0) ? MIn1aAble :
                       (MReadPtr[1:0] == 1) ? MIn4aAble : 
                       (MReadPtr[1:0] == 2) ? MIn3aAble : 
                       (MReadPtr[1:0] == 3) ? MIn2aAble : `EnableValue ;

    wire  ReadM2Able = (MReadPtr[1:0] == 0) ? MIn2aAble :
                       (MReadPtr[1:0] == 1) ? MIn1aAble : 
                       (MReadPtr[1:0] == 2) ? MIn4aAble : 
                       (MReadPtr[1:0] == 3) ? MIn3aAble : `EnableValue ;

    wire  ReadM3Able = (MReadPtr[1:0] == 0) ? MIn3aAble :
                       (MReadPtr[1:0] == 1) ? MIn2aAble : 
                       (MReadPtr[1:0] == 2) ? MIn1aAble : 
                       (MReadPtr[1:0] == 3) ? MIn4aAble : `EnableValue ;

    wire  ReadM4Able = (MReadPtr[1:0] == 0) ? MIn4aAble :
                       (MReadPtr[1:0] == 1) ? MIn3aAble : 
                       (MReadPtr[1:0] == 2) ? MIn2aAble : 
                       (MReadPtr[1:0] == 3) ? MIn1aAble : `EnableValue ;

    wire [3:0] PrePutPtr1 ;
    wire [3:0] PrePutPtr2 ;
    wire [3:0] PrePutPtr3 ;
    wire [3:0] PrePutPtr4 ;

    BrCsrIQ1Criq4#(
        .CRIQWIDE    ( 4 ),
        .CRIQDEEP    ( 4 )
    )u_BrCsrIQ1Criq4(
        .Clk         ( Clk             ),
        .Rest        ( Rest            ),
        .Rable       ( ReadM1Able      ),
        .CriqPreOut  ( PrePutPtr1      ),
        .Wable       ( WriteCriq1Able  ),
        .Din         ( WriteCriq1Addr  ),
        .CriqClean   ( BrCsrFlash      ),
        .CriqEmpty   ( CriqEmpty1      )
    );

    BrCsrIQ2Criq4#(
        .CRIQWIDE    ( 4 ),
        .CRIQDEEP    ( 4 )
    )u_BrCsrIQ2Criq4(
        .Clk         ( Clk             ),
        .Rest        ( Rest            ),
        .Rable       ( ReadM2Able      ),
        .CriqPreOut  ( PrePutPtr2      ),
        .Wable       ( WriteCriq2Able  ),
        .Din         ( WriteCriq2Addr  ),
        .CriqClean   ( BrCsrFlash      ),
        .CriqEmpty   ( CriqEmpty2      )
    );

    BrCsrIQ3Criq4#(
        .CRIQWIDE    ( 4 ),
        .CRIQDEEP    ( 4 )
    )u_BrCsrIQ3Criq4(
        .Clk         ( Clk            ),
        .Rest        ( Rest           ),
        .Rable       ( ReadM3Able     ),
        .CriqPreOut  ( PrePutPtr3     ),
        .Wable       ( WriteCriq3Able ),
        .Din         ( WriteCriq3Addr ),
        .CriqClean   ( BrCsrFlash     ),
        .CriqEmpty   ( CriqEmpty3     )
    );

    BrCsrIQ4Criq4#(
        .CRIQWIDE    ( 4 ),
        .CRIQDEEP    ( 4 )
    )u_BrCsrIQ4Criq4(
        .Clk         ( Clk            ),
        .Rest        ( Rest           ),
        .Rable       ( ReadM4Able     ),
        .CriqPreOut  ( PrePutPtr4     ),
        .Wable       ( WriteCriq4Able ),
        .Din         ( WriteCriq4Addr ),
        .CriqClean   ( BrCsrFlash     ),
        .CriqEmpty   ( CriqEmpty4     )
    );


    genvar a ;

    wire        LodSelect1S1   [0:7] ;
    wire [3:0]  LodSelectOldS1 [0:7] ;
    wire        LodSelectAblS1 [0:7] ;

    wire        StoSelect1S1   [0:7] ;
    wire [3:0]  StoSelectOldS1 [0:7] ;
    wire        StoSelectAblS1 [0:7] ;

    generate
        for (a =0 ;a<16 ;a=a+2 ) begin
            assign LodSelect1S1[a/2]    =   (MEMISSUE[a][68] == MEMISSUE[a+1][68]) & (MEMISSUE[a][67:62] < MEMISSUE[a+1][67:62]) | 
                                            (MEMISSUE[a][68] != MEMISSUE[a+1][68]) & (MEMISSUE[a][67:62] > MEMISSUE[a+1][67:62]) ;
            assign LodSelectOldS1[a/2]  =   {4{(((MEMISSUE[a][60] | ~MEMISSUE[a][61]) & (MEMISSUE[a][51] | ~MEMISSUE[a][52])) & (MEMISSUE[a][35:33] == `LSUCODE ) & MEMISSUE[a][32]) & 
                                               (((MEMISSUE[a+1][60] | ~MEMISSUE[a+1][61]) & (MEMISSUE[a+1][51] | ~MEMISSUE[a+1][52])) & (MEMISSUE[a+1][35:33] == `LSUCODE ) & MEMISSUE[a+1][32]) & 
                                                LodSelect1S1[a/2]}} & a |
                                            {4{(((MEMISSUE[a][60] | ~MEMISSUE[a][61]) & (MEMISSUE[a][51] | ~MEMISSUE[a][52])) & (MEMISSUE[a][35:33] == `LSUCODE ) & MEMISSUE[a][32]) & 
                                               (((MEMISSUE[a+1][60] | ~MEMISSUE[a+1][61]) & (MEMISSUE[a+1][51] | ~MEMISSUE[a+1][52])) & (MEMISSUE[a+1][35:33] == `LSUCODE ) & MEMISSUE[a+1][32]) & 
                                                ~LodSelect1S1[a/2]}} & a+1 |
                                            {4{(((MEMISSUE[a][60] | ~MEMISSUE[a][61]) & (MEMISSUE[a][51] | ~MEMISSUE[a][52])) & (MEMISSUE[a][35:33] == `LSUCODE ) & MEMISSUE[a][32]) & 
                                               ~(((MEMISSUE[a+1][60] | ~MEMISSUE[a+1][61]) & (MEMISSUE[a+1][51] | ~MEMISSUE[a+1][52])) & (MEMISSUE[a+1][35:33] == `LSUCODE ) & MEMISSUE[a+1][32])}} & a |
                                            {4{~(((MEMISSUE[a][60] | ~MEMISSUE[a][61]) & (MEMISSUE[a][51] | ~MEMISSUE[a][52])) & (MEMISSUE[a][35:33] == `LSUCODE ) & MEMISSUE[a][32]) & 
                                               (((MEMISSUE[a+1][60] | ~MEMISSUE[a+1][61]) & (MEMISSUE[a+1][51] | ~MEMISSUE[a+1][52])) & (MEMISSUE[a+1][35:33] == `LSUCODE ) & MEMISSUE[a+1][32])}} & a+1 ;
            assign LodSelectAblS1[a/2]  =     ~(~(((MEMISSUE[a][60] | ~MEMISSUE[a][61]) & (MEMISSUE[a][51] | ~MEMISSUE[a][52])) & (MEMISSUE[a][35:33] == `LSUCODE ) & MEMISSUE[a][32]) & 
                                              ~(((MEMISSUE[a+1][60] | ~MEMISSUE[a+1][61]) & (MEMISSUE[a+1][51] | ~MEMISSUE[a+1][52])) & (MEMISSUE[a+1][35:33] == `LSUCODE ) & MEMISSUE[a+1][32])) ;
        
            assign StoSelect1S1[a/2]    =   (MEMISSUE[a][68] == MEMISSUE[a+1][68]) & (MEMISSUE[a][67:62] < MEMISSUE[a+1][67:62]) | 
                                            (MEMISSUE[a][68] != MEMISSUE[a+1][68]) & (MEMISSUE[a][67:62] > MEMISSUE[a+1][67:62]) ;
            assign StoSelectOldS1[a/2]  =   {4{(((MEMISSUE[a][60] | ~MEMISSUE[a][61]) & (MEMISSUE[a][51] | ~MEMISSUE[a][52])) & (MEMISSUE[a][35:33] == `LSUCODE ) & ~MEMISSUE[a][32]) & 
                                               (((MEMISSUE[a+1][60] | ~MEMISSUE[a+1][61]) & (MEMISSUE[a+1][51] | ~MEMISSUE[a+1][52])) & (MEMISSUE[a+1][35:33] == `LSUCODE ) & ~MEMISSUE[a+1][32]) & 
                                                StoSelect1S1[a/2]}} & a |
                                            {4{(((MEMISSUE[a][60] | ~MEMISSUE[a][61]) & (MEMISSUE[a][51] | ~MEMISSUE[a][52])) & (MEMISSUE[a][35:33] == `LSUCODE ) & ~MEMISSUE[a][32]) & 
                                               (((MEMISSUE[a+1][60] | ~MEMISSUE[a+1][61]) & (MEMISSUE[a+1][51] | ~MEMISSUE[a+1][52])) & (MEMISSUE[a+1][35:33] == `LSUCODE ) & ~MEMISSUE[a+1][32]) & 
                                                ~StoSelect1S1[a/2]}} & a+1 |
                                            {4{(((MEMISSUE[a][60] | ~MEMISSUE[a][61]) & (MEMISSUE[a][51] | ~MEMISSUE[a][52])) & (MEMISSUE[a][35:33] == `LSUCODE ) & ~MEMISSUE[a][32]) & 
                                               ~(((MEMISSUE[a+1][60] | ~MEMISSUE[a+1][61]) & (MEMISSUE[a+1][51] | ~MEMISSUE[a+1][52])) & (MEMISSUE[a+1][35:33] == `LSUCODE ) & ~MEMISSUE[a+1][32])}} & a |
                                            {4{~(((MEMISSUE[a][60] | ~MEMISSUE[a][61]) & (MEMISSUE[a][51] | ~MEMISSUE[a][52])) & (MEMISSUE[a][35:33] == `LSUCODE ) & ~MEMISSUE[a][32]) & 
                                               (((MEMISSUE[a+1][60] | ~MEMISSUE[a+1][61]) & (MEMISSUE[a+1][51] | ~MEMISSUE[a+1][52])) & (MEMISSUE[a+1][35:33] == `LSUCODE ) & ~MEMISSUE[a+1][32])}} & a+1 ;
            assign StoSelectAblS1[a/2]  =     ~(~(((MEMISSUE[a][60] | ~MEMISSUE[a][61]) & (MEMISSUE[a][51] | ~MEMISSUE[a][52])) & (MEMISSUE[a][35:33] == `LSUCODE ) & ~MEMISSUE[a][32]) & 
                                              ~(((MEMISSUE[a+1][60] | ~MEMISSUE[a+1][61]) & (MEMISSUE[a+1][51] | ~MEMISSUE[a+1][52])) & (MEMISSUE[a+1][35:33] == `LSUCODE ) & ~MEMISSUE[a+1][32])) ;
            
        end
    endgenerate


    wire        LodSelect1S2   [0:3] ;
    wire [3:0]  LodSelectOldS2 [0:3] ;
    wire        LodSelectAblS2 [0:3] ;

    wire        StoSelect1S2   [0:3] ;
    wire [3:0]  StoSelectOldS2 [0:3] ;
    wire        StoSelectAblS2 [0:3] ;

    genvar b ;
    generate
        for (b =0 ;b<8 ;b=b+2 ) begin
            assign LodSelect1S2[b/2] =   (MEMISSUE[LodSelectOldS1[b]][68] == MEMISSUE[LodSelectOldS1[b+1]][68]) & (MEMISSUE[LodSelectOldS1[b]][67:62] < MEMISSUE[LodSelectOldS1[b+1]][67:62]) | 
                                         (MEMISSUE[LodSelectOldS1[b]][68] != MEMISSUE[LodSelectOldS1[b+1]][68]) & (MEMISSUE[LodSelectOldS1[b]][67:62] > MEMISSUE[LodSelectOldS1[b+1]][67:62]) ;
            assign LodSelectOldS2[b/2]= {4{(LodSelectAblS1[b] & LodSelectAblS1[b+1] & LodSelect1S2[b/2])}} &  LodSelectOldS1[b] | 
                                        {4{(LodSelectAblS1[b] & LodSelectAblS1[b+1] & ~LodSelect1S2[b/2])}} &  LodSelectOldS1[b+1] | 
                                        {4{(LodSelectAblS1[b] & ~LodSelectAblS1[b+1])}} &  LodSelectOldS1[b] | 
                                        {4{(~LodSelectAblS1[b] & LodSelectAblS1[b+1])}} &  LodSelectOldS1[b+1] ;
            assign LodSelectAblS2[b/2]= ~(~LodSelectAblS1[b] & ~LodSelectAblS1[b+1]) ;

            assign StoSelect1S2[b/2] =   (MEMISSUE[StoSelectOldS1[b]][68] == MEMISSUE[StoSelectOldS1[b+1]][68]) & (MEMISSUE[StoSelectOldS1[b]][67:62] < MEMISSUE[StoSelectOldS1[b+1]][67:62]) | 
                                         (MEMISSUE[StoSelectOldS1[b]][68] != MEMISSUE[StoSelectOldS1[b+1]][68]) & (MEMISSUE[StoSelectOldS1[b]][67:62] > MEMISSUE[StoSelectOldS1[b+1]][67:62]) ;
            assign StoSelectOldS2[b/2]= {4{(StoSelectAblS1[b] & StoSelectAblS1[b+1] & StoSelect1S2[b/2])}} &  StoSelectOldS1[b] | 
                                        {4{(StoSelectAblS1[b] & StoSelectAblS1[b+1] & ~StoSelect1S2[b/2])}} &  StoSelectOldS1[b+1] | 
                                        {4{(StoSelectAblS1[b] & ~StoSelectAblS1[b+1])}} &  StoSelectOldS1[b] | 
                                        {4{(~StoSelectAblS1[b] & StoSelectAblS1[b+1])}} &  StoSelectOldS1[b+1] ;      
            assign StoSelectAblS2[b/2]= ~(~StoSelectAblS1[b] & ~StoSelectAblS1[b+1]) ;
        end
    endgenerate

    wire        LodSelect1S3   [0:1] ;
    wire [3:0]  LodSelectOldS3 [0:1] ;
    wire        LodSelectAblS3 [0:1] ;

    wire        StoSelect1S3   [0:1] ;
    wire [3:0]  StoSelectOldS3 [0:1] ;
    wire        StoSelectAblS3 [0:1] ;

    genvar c ;
    generate
        for (c =0 ;c<4 ;c=c+2 ) begin
            assign LodSelect1S3[c/2] =   (MEMISSUE[LodSelectOldS2[c]][68] == MEMISSUE[LodSelectOldS2[c+1]][68]) & (MEMISSUE[LodSelectOldS2[c]][67:62] < MEMISSUE[LodSelectOldS2[c+1]][67:62]) | 
                                         (MEMISSUE[LodSelectOldS2[c]][68] != MEMISSUE[LodSelectOldS2[c+1]][68]) & (MEMISSUE[LodSelectOldS2[c]][67:62] > MEMISSUE[LodSelectOldS2[c+1]][67:62]) ;
            assign LodSelectOldS3[c/2]= {4{(LodSelectAblS2[c] & LodSelectAblS2[c+1] & LodSelect1S3[c/2])}} &  LodSelectOldS2[c] | 
                                        {4{(LodSelectAblS2[c] & LodSelectAblS2[c+1] & ~LodSelect1S3[c/2])}} &  LodSelectOldS2[c+1] | 
                                        {4{(LodSelectAblS2[c] & ~LodSelectAblS2[c+1])}} &  LodSelectOldS2[c] | 
                                        {4{(~LodSelectAblS2[c] & LodSelectAblS2[c+1])}} &  LodSelectOldS2[c+1] ; 
            assign LodSelectAblS3[c/2]= ~(~LodSelectAblS2[c] & ~LodSelectAblS2[c+1]) ;

            assign StoSelect1S3[c/2] =   (MEMISSUE[StoSelectOldS2[c]][68] == MEMISSUE[StoSelectOldS2[c+1]][68]) & (MEMISSUE[StoSelectOldS2[c]][67:62] < MEMISSUE[StoSelectOldS2[c+1]][67:62]) | 
                                         (MEMISSUE[StoSelectOldS2[c]][68] != MEMISSUE[StoSelectOldS2[c+1]][68]) & (MEMISSUE[StoSelectOldS2[c]][67:62] > MEMISSUE[StoSelectOldS2[c+1]][67:62]) ;
            assign StoSelectOldS3[c/2]= {4{(StoSelectAblS2[c] & StoSelectAblS2[c+1] & StoSelect1S3[c/2])}} &  StoSelectOldS2[c] | 
                                        {4{(StoSelectAblS2[c] & StoSelectAblS2[c+1] & ~StoSelect1S3[c/2])}} &  StoSelectOldS2[c+1] | 
                                        {4{(StoSelectAblS2[c] & ~StoSelectAblS2[c+1])}} &  StoSelectOldS2[c] | 
                                        {4{(~StoSelectAblS2[c] & StoSelectAblS2[c+1])}} &  StoSelectOldS2[c+1] ; 
            assign StoSelectAblS3[c/2] = ~(~StoSelectAblS2[c] & ~StoSelectAblS2[c+1]) ;
        end
    endgenerate

    wire        LodSelect1S4    ;
    wire [3:0]  LodSelectOldS4  ;
    wire        LodSelectAblS4  ;

    wire        StoSelect1S4    ;
    wire [3:0]  StoSelectOldS4  ;
    wire        StoSelectAblS4  ;

    assign  LodSelect1S4 =  (MEMISSUE[LodSelectOldS3[0]][68] == MEMISSUE[LodSelectOldS3[1]][68]) & (MEMISSUE[LodSelectOldS3[0]][67:62] < MEMISSUE[LodSelectOldS3[1]][67:62]) | 
                            (MEMISSUE[LodSelectOldS3[0]][68] != MEMISSUE[LodSelectOldS3[1]][68]) & (MEMISSUE[LodSelectOldS3[0]][67:62] > MEMISSUE[LodSelectOldS3[1]][67:62]) ;
    assign LodSelectOldS4 = {4{(LodSelectAblS3[0] & LodSelectAblS3[1] & LodSelect1S4)}} &  LodSelectOldS3[0] | 
                            {4{(LodSelectAblS3[0] & LodSelectAblS3[1] & ~LodSelect1S4)}} &  LodSelectOldS3[1] | 
                            {4{(LodSelectAblS3[0] & ~LodSelectAblS3[1])}} &  LodSelectOldS3[0] | 
                            {4{(~LodSelectAblS3[0] & LodSelectAblS3[1])}} &  LodSelectOldS3[1] ; 
    assign LodSelectAblS4 = ~((~LodSelectAblS3[0] & ~LodSelectAblS3[1])) ;
    
    assign StoSelect1S4 =   (MEMISSUE[StoSelectOldS3[0]][68] == MEMISSUE[StoSelectOldS3[1]][68]) & (MEMISSUE[StoSelectOldS3[0]][67:62] < MEMISSUE[StoSelectOldS3[1]][67:62]) | 
                            (MEMISSUE[StoSelectOldS3[0]][68] != MEMISSUE[StoSelectOldS3[1]][68]) & (MEMISSUE[StoSelectOldS3[0]][67:62] > MEMISSUE[StoSelectOldS3[1]][67:62]) ;
    assign StoSelectOldS4 = {4{(StoSelectAblS3[0] & StoSelectAblS3[1] & StoSelect1S4)}} &  StoSelectOldS3[0] | 
                            {4{(StoSelectAblS3[0] & StoSelectAblS3[1] & ~StoSelect1S4)}} &  StoSelectOldS3[1] | 
                            {4{(StoSelectAblS3[0] & ~StoSelectAblS3[1])}} &  StoSelectOldS3[0] | 
                            {4{(~StoSelectAblS3[0] & StoSelectAblS3[1])}} &  StoSelectOldS3[1] ; 
    assign StoSelectAblS4 = ~(~StoSelectAblS3[0] & ~StoSelectAblS3[1]) ;


    wire CanIssueLoad  = LodSelectAblS4 & LoadReq & ~MemQStop ;
    wire CanIssueStore = StoSelectAblS4 & StoreReq & ~MemQStop ;




    integer i ;
    always @(posedge Clk) begin
        if(!Rest) begin
            for (i =0 ;i<16 ;i=i+2 ) begin
                MEMISSUE[i] <= 69'd0 ;
            end
        end
        else if(MemQFlash) begin
            for (i =0 ;i<16 ;i=i+2 ) begin
                MEMISSUE[i] <= 69'd0 ;
            end
        end 
        else begin
            MEMISSUE[0][60] <= (MemQStop | MEMISSUE[0][60] | ~MEMISSUE[0][61]) ? MEMISSUE[0][60] : MInstSrc2Ready[0] ;
            MEMISSUE[0][51] <= (MemQStop | MEMISSUE[0][51] | ~MEMISSUE[0][52]) ? MEMISSUE[0][51] : MInstSrc1Ready[0] ;
            MEMISSUE[1][60] <= (MemQStop | MEMISSUE[1][60] | ~MEMISSUE[1][61]) ? MEMISSUE[1][60] : MInstSrc2Ready[1] ;
            MEMISSUE[1][51] <= (MemQStop | MEMISSUE[1][51] | ~MEMISSUE[1][52]) ? MEMISSUE[1][51] : MInstSrc1Ready[1] ;
            MEMISSUE[2][60] <= (MemQStop | MEMISSUE[2][60] | ~MEMISSUE[2][61]) ? MEMISSUE[2][60] : MInstSrc2Ready[2] ;
            MEMISSUE[2][51] <= (MemQStop | MEMISSUE[2][51] | ~MEMISSUE[2][52]) ? MEMISSUE[2][51] : MInstSrc1Ready[2] ;
            MEMISSUE[3][60] <= (MemQStop | MEMISSUE[3][60] | ~MEMISSUE[3][61]) ? MEMISSUE[3][60] : MInstSrc2Ready[3] ;
            MEMISSUE[3][51] <= (MemQStop | MEMISSUE[3][51] | ~MEMISSUE[3][52]) ? MEMISSUE[3][51] : MInstSrc1Ready[3] ;
            MEMISSUE[4][60] <= (MemQStop | MEMISSUE[4][60] | ~MEMISSUE[4][61]) ? MEMISSUE[4][60] : MInstSrc2Ready[4] ;
            MEMISSUE[4][51] <= (MemQStop | MEMISSUE[4][51] | ~MEMISSUE[4][52]) ? MEMISSUE[4][51] : MInstSrc1Ready[4] ;
            MEMISSUE[5][60] <= (MemQStop | MEMISSUE[5][60] | ~MEMISSUE[5][61]) ? MEMISSUE[5][60] : MInstSrc2Ready[5] ;
            MEMISSUE[5][51] <= (MemQStop | MEMISSUE[5][51] | ~MEMISSUE[5][52]) ? MEMISSUE[5][51] : MInstSrc1Ready[5] ;
            MEMISSUE[6][60] <= (MemQStop | MEMISSUE[6][60] | ~MEMISSUE[6][61]) ? MEMISSUE[6][60] : MInstSrc2Ready[6] ;
            MEMISSUE[6][51] <= (MemQStop | MEMISSUE[6][51] | ~MEMISSUE[6][52]) ? MEMISSUE[6][51] : MInstSrc1Ready[6] ;
            MEMISSUE[7][60] <= (MemQStop | MEMISSUE[7][60] | ~MEMISSUE[7][61]) ? MEMISSUE[7][60] : MInstSrc2Ready[7] ;
            MEMISSUE[7][51] <= (MemQStop | MEMISSUE[7][51] | ~MEMISSUE[7][52]) ? MEMISSUE[7][51] : MInstSrc1Ready[7] ;
            MEMISSUE[8][60] <= (MemQStop | MEMISSUE[8][60] | ~MEMISSUE[8][61]) ? MEMISSUE[8][60] : MInstSrc2Ready[8] ;
            MEMISSUE[8][51] <= (MemQStop | MEMISSUE[8][51] | ~MEMISSUE[8][52]) ? MEMISSUE[8][51] : MInstSrc1Ready[8] ;
            MEMISSUE[9][60] <= (MemQStop | MEMISSUE[9][60] | ~MEMISSUE[9][61]) ? MEMISSUE[9][60] : MInstSrc2Ready[9] ;
            MEMISSUE[9][51] <= (MemQStop | MEMISSUE[9][51] | ~MEMISSUE[9][52]) ? MEMISSUE[9][51] : MInstSrc1Ready[9] ;
            MEMISSUE[10][60] <= (MemQStop | MEMISSUE[10][60] | ~MEMISSUE[10][61]) ? MEMISSUE[10][60] : MInstSrc2Ready[10] ;
            MEMISSUE[10][51] <= (MemQStop | MEMISSUE[10][51] | ~MEMISSUE[10][52]) ? MEMISSUE[10][51] : MInstSrc1Ready[10] ;
            MEMISSUE[11][60] <= (MemQStop | MEMISSUE[11][60] | ~MEMISSUE[11][61]) ? MEMISSUE[11][60] : MInstSrc2Ready[11] ;
            MEMISSUE[11][51] <= (MemQStop | MEMISSUE[11][51] | ~MEMISSUE[11][52]) ? MEMISSUE[11][51] : MInstSrc1Ready[11] ;
            MEMISSUE[12][60] <= (MemQStop | MEMISSUE[12][60] | ~MEMISSUE[12][61]) ? MEMISSUE[12][60] : MInstSrc2Ready[12] ;
            MEMISSUE[12][51] <= (MemQStop | MEMISSUE[12][51] | ~MEMISSUE[12][52]) ? MEMISSUE[12][51] : MInstSrc1Ready[12] ;
            MEMISSUE[13][60] <= (MemQStop | MEMISSUE[13][60] | ~MEMISSUE[13][61]) ? MEMISSUE[13][60] : MInstSrc2Ready[13] ;
            MEMISSUE[13][51] <= (MemQStop | MEMISSUE[13][51] | ~MEMISSUE[13][52]) ? MEMISSUE[13][51] : MInstSrc1Ready[13] ;
            MEMISSUE[14][60] <= (MemQStop | MEMISSUE[14][60] | ~MEMISSUE[14][61]) ? MEMISSUE[14][60] : MInstSrc2Ready[14] ;
            MEMISSUE[14][51] <= (MemQStop | MEMISSUE[14][51] | ~MEMISSUE[14][52]) ? MEMISSUE[14][51] : MInstSrc1Ready[14] ;
            MEMISSUE[15][60] <= (MemQStop | MEMISSUE[15][60] | ~MEMISSUE[15][61]) ? MEMISSUE[15][60] : MInstSrc2Ready[15] ;
            MEMISSUE[15][51] <= (MemQStop | MEMISSUE[15][51] | ~MEMISSUE[15][52]) ? MEMISSUE[15][51] : MInstSrc1Ready[15] ;
            MEMISSUE[PrePutPtr1] <= ReadM1Able ? WriteMIQ1 : MEMISSUE[PrePutPtr1] ;
            MEMISSUE[PrePutPtr2] <= ReadM2Able ? WriteMIQ2 : MEMISSUE[PrePutPtr2] ;
            MEMISSUE[PrePutPtr3] <= ReadM3Able ? WriteMIQ3 : MEMISSUE[PrePutPtr3] ;
            MEMISSUE[PrePutPtr4] <= ReadM4Able ? WriteMIQ4 : MEMISSUE[PrePutPtr4] ;
            MEMISSUE[LodSelectOldS4] <= CanIssueLoad  ? 69'd0 : MEMISSUE[LodSelectOldS4] ;
            MEMISSUE[StoSelectOldS4] <= CanIssueStore ? 69'd0 : MEMISSUE[StoSelectOldS4] ;
        end
    end

    
endmodule
`timescale 1ps/1ps
`include "../define.v"

module PhysicalRegFile (
    input          wire                                 Clk                 ,
    input          wire                                 Rest                ,
    //for ctrl
    input          wire                                 PhysicalStop        ,
    //input          wire                                 PhysicalFlash       ,
    //output         wire                                 PhysicalReq         ,
    //from aRAT 
    input          wire                                 ReloadPhy           , //此信号等于flash,已经使用不改啦
    input          wire      [`ReNameRegBUs]            Are1MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are2MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are3MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are4MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are5MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are6MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are7MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are8MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are9MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are10MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are11MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are12MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are13MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are14MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are15MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are16MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are17MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are18MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are19MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are20MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are21MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are22MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are23MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are24MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are25MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are26MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are27MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are28MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are29MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are30MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are31MapPregNum      ,
    input          wire      [`ReNameRegBUs]            Are32MapPregNum      ,
    //from Alu1 
    input          wire                                 WriteBackAlu1        ,
    input          wire      [`ReNameRegBUs]            WriteBackAlu1Addr    ,
    input          wire      [`DataBus]                 WriteBackAlu1Date    ,
    //from Alu2 
    input          wire                                 WriteBackAlu2        ,
    input          wire      [`ReNameRegBUs]            WriteBackAlu2Addr    ,
    input          wire      [`DataBus]                 WriteBackAlu2Date    ,
    //from div 
    input          wire                                 WriteBackDiv         ,
    input          wire      [`ReNameRegBUs]            WriteBackDivAddr     ,
    input          wire      [`DataBus]                 WriteBackDivDate     ,
    //from Mul 
    input          wire                                 WriteBackMul         ,
    input          wire      [`ReNameRegBUs]            WriteBackMulAddr     ,
    input          wire      [`DataBus]                 WriteBackMulDate     ,
    //from Csru 
    input          wire                                 WriteBackCsru        ,
    input          wire      [`ReNameRegBUs]            WriteBackCsruAddr    ,
    input          wire      [`DataBus]                 WriteBackCsruDate    ,
    //from Bru 
    input          wire                                 WriteBackBru         ,
    input          wire      [`ReNameRegBUs]            WriteBackBruAddr     ,
    input          wire      [`DataBus]                 WriteBackBruDate     ,
    //from lsu 
    input          wire                                 WriteBackLsu         ,
    input          wire      [`ReNameRegBUs]            WriteBackLsuAddr     ,
    input          wire      [`DataBus]                 WriteBackLsuDate     ,
    //from ROB
    input          wire                                 WriteBackROB         ,
    input          wire      [`ReNameRegBUs]            WriteBackROBAddr     ,
    input          wire      [`DataBus]                 WriteBackROBDate     ,
    //for RAT
    input          wire                                 Read11Able           ,
    input          wire      [`ReNameRegBUs]            Read11Addr           ,
    output         wire      [`DataBus]                 Read11Date           ,
    input          wire                                 Read12Able           ,
    input          wire      [`ReNameRegBUs]            Read12Addr           ,
    output         wire      [`DataBus]                 Read12Date           ,
    input          wire                                 Read21Able           ,
    input          wire      [`ReNameRegBUs]            Read21Addr           ,
    output         wire      [`DataBus]                 Read21Date           ,
    input          wire                                 Read22Able           ,
    input          wire      [`ReNameRegBUs]            Read22Addr           ,
    output         wire      [`DataBus]                 Read22Date           ,
    input          wire                                 Read31Able           ,
    input          wire      [`ReNameRegBUs]            Read31Addr           ,
    output         wire      [`DataBus]                 Read31Date           ,
    input          wire                                 Read32Able           ,
    input          wire      [`ReNameRegBUs]            Read32Addr           ,
    output         wire      [`DataBus]                 Read32Date           ,
    input          wire                                 Read41Able           ,
    input          wire      [`ReNameRegBUs]            Read41Addr           ,
    output         wire      [`DataBus]                 Read41Date           ,
    input          wire                                 Read42Able           ,
    input          wire      [`ReNameRegBUs]            Read42Addr           ,
    output         wire      [`DataBus]                 Read42Date           ,
    input          wire                                 Read51Able           ,
    input          wire      [`ReNameRegBUs]            Read51Addr           ,
    output         wire      [`DataBus]                 Read51Date           ,
    input          wire                                 Read52Able           ,
    input          wire      [`ReNameRegBUs]            Read52Addr           ,
    output         wire      [`DataBus]                 Read52Date           ,
    input          wire                                 Read61Able           ,
    input          wire      [`ReNameRegBUs]            Read61Addr           ,
    output         wire      [`DataBus]                 Read61Date           ,
    input          wire                                 Read62Able           ,
    input          wire      [`ReNameRegBUs]            Read62Addr           ,
    output         wire      [`DataBus]                 Read62Date           ,
    input          wire                                 Read71Able           ,
    input          wire      [`ReNameRegBUs]            Read71Addr           ,
    output         wire      [`DataBus]                 Read71Date           ,
    input          wire                                 Read72Able           ,
    input          wire      [`ReNameRegBUs]            Read72Addr           ,
    output         wire      [`DataBus]                 Read72Date           ,
    input          wire                                 Read81Able           ,
    input          wire      [`ReNameRegBUs]            Read81Addr           ,
    output         wire      [`DataBus]                 Read81Date           ,
    input          wire                                 Read82Able           ,
    input          wire      [`ReNameRegBUs]            Read82Addr           ,
    output         wire      [`DataBus]                 Read82Date           
);

    reg  [`DataBus] PhysicalReg [0:127]  ;
    integer i ;
    integer j ;
    integer k ;
    integer l ;
    always @(posedge Clk) begin
        if(!Rest) begin
            for (i =0 ;i< 32 ;i=i+1 )
                 PhysicalReg[i] <= `ZeorDate ;
            for (j =0 ;j< 32 ;j=j+1 )
                 PhysicalReg[j+32] <= `ZeorDate ;
            for (k =0 ;k< 32 ;k=k+1 )
                 PhysicalReg[k+64] <= `ZeorDate ;
            for (l =0 ;l< 32 ;l=l+1 )
                 PhysicalReg[l+96] <= `ZeorDate ;
        end
        else if(PhysicalStop) begin
            for (i =0 ;i< 32 ;i=i+1 )
                 PhysicalReg[i] <=  PhysicalReg[i] ;
            for (j =0 ;j< 32 ;j=j+1 )
                 PhysicalReg[j+32] <= PhysicalReg[j+32] ;
            for (k =0 ;k< 32 ;k=k+1 )
                 PhysicalReg[k+64] <= PhysicalReg[k+64] ;
            for (l =0 ;l< 32 ;l=l+1 )
                 PhysicalReg[l+96] <= PhysicalReg[l+96] ;
        end
        else begin
            PhysicalReg[0] <= (ReloadPhy ) ? PhysicalReg[Are1MapPregNum] : PhysicalReg[0] ;
            PhysicalReg[1] <= (ReloadPhy ) ? PhysicalReg[Are2MapPregNum] : PhysicalReg[1] ;
            PhysicalReg[2] <= (ReloadPhy ) ? PhysicalReg[Are3MapPregNum] : PhysicalReg[2] ;
            PhysicalReg[3] <= (ReloadPhy ) ? PhysicalReg[Are4MapPregNum] : PhysicalReg[3] ;
            PhysicalReg[4] <= (ReloadPhy ) ? PhysicalReg[Are5MapPregNum] : PhysicalReg[4] ;
            PhysicalReg[5] <= (ReloadPhy ) ? PhysicalReg[Are6MapPregNum] : PhysicalReg[5] ;
            PhysicalReg[6] <= (ReloadPhy ) ? PhysicalReg[Are7MapPregNum] : PhysicalReg[6] ;
            PhysicalReg[7] <= (ReloadPhy ) ? PhysicalReg[Are8MapPregNum] : PhysicalReg[7] ;
            PhysicalReg[8] <= (ReloadPhy ) ? PhysicalReg[Are9MapPregNum] : PhysicalReg[8] ;
            PhysicalReg[9] <= (ReloadPhy ) ? PhysicalReg[Are10MapPregNum] : PhysicalReg[9] ;
            PhysicalReg[10] <= (ReloadPhy ) ? PhysicalReg[Are11MapPregNum] : PhysicalReg[10] ;
            PhysicalReg[11] <= (ReloadPhy ) ? PhysicalReg[Are12MapPregNum] : PhysicalReg[11] ;
            PhysicalReg[12] <= (ReloadPhy ) ? PhysicalReg[Are13MapPregNum] : PhysicalReg[12] ;
            PhysicalReg[13] <= (ReloadPhy ) ? PhysicalReg[Are14MapPregNum] : PhysicalReg[13] ;
            PhysicalReg[14] <= (ReloadPhy ) ? PhysicalReg[Are15MapPregNum] : PhysicalReg[14] ;
            PhysicalReg[15] <= (ReloadPhy ) ? PhysicalReg[Are16MapPregNum] : PhysicalReg[15] ;
            PhysicalReg[16] <= (ReloadPhy ) ? PhysicalReg[Are17MapPregNum] : PhysicalReg[16] ;
            PhysicalReg[17] <= (ReloadPhy ) ? PhysicalReg[Are18MapPregNum] : PhysicalReg[17] ;
            PhysicalReg[18] <= (ReloadPhy ) ? PhysicalReg[Are19MapPregNum] : PhysicalReg[18] ;
            PhysicalReg[19] <= (ReloadPhy ) ? PhysicalReg[Are20MapPregNum] : PhysicalReg[19] ;
            PhysicalReg[20] <= (ReloadPhy ) ? PhysicalReg[Are21MapPregNum] : PhysicalReg[20] ;
            PhysicalReg[21] <= (ReloadPhy ) ? PhysicalReg[Are22MapPregNum] : PhysicalReg[21] ;
            PhysicalReg[22] <= (ReloadPhy ) ? PhysicalReg[Are23MapPregNum] : PhysicalReg[22] ;
            PhysicalReg[23] <= (ReloadPhy ) ? PhysicalReg[Are24MapPregNum] : PhysicalReg[23] ;
            PhysicalReg[24] <= (ReloadPhy ) ? PhysicalReg[Are25MapPregNum] : PhysicalReg[24] ;
            PhysicalReg[25] <= (ReloadPhy ) ? PhysicalReg[Are26MapPregNum] : PhysicalReg[25] ;
            PhysicalReg[26] <= (ReloadPhy ) ? PhysicalReg[Are27MapPregNum] : PhysicalReg[26] ;
            PhysicalReg[27] <= (ReloadPhy ) ? PhysicalReg[Are28MapPregNum] : PhysicalReg[27] ;
            PhysicalReg[28] <= (ReloadPhy ) ? PhysicalReg[Are29MapPregNum] : PhysicalReg[28] ;
            PhysicalReg[29] <= (ReloadPhy ) ? PhysicalReg[Are30MapPregNum] : PhysicalReg[29] ;
            PhysicalReg[30] <= (ReloadPhy ) ? PhysicalReg[Are31MapPregNum] : PhysicalReg[30] ;
            PhysicalReg[31] <= (ReloadPhy ) ? PhysicalReg[Are32MapPregNum] : PhysicalReg[31] ;
            PhysicalReg[WriteBackAlu1Addr] <= (WriteBackAlu1 ) ? WriteBackAlu1Date : PhysicalReg[WriteBackAlu1Addr] ;
            PhysicalReg[WriteBackAlu2Addr] <= (WriteBackAlu2 ) ? WriteBackAlu2Date : PhysicalReg[WriteBackAlu2Addr] ;
            PhysicalReg[WriteBackDivAddr ] <= (WriteBackDiv  ) ? WriteBackDivDate  : PhysicalReg[WriteBackDivAddr ] ;
            PhysicalReg[WriteBackMulAddr ] <= (WriteBackMul  ) ? WriteBackMulDate  : PhysicalReg[WriteBackMulAddr ] ;
            PhysicalReg[WriteBackCsruAddr] <= (WriteBackCsru ) ? WriteBackCsruDate : PhysicalReg[WriteBackCsruAddr] ;
            PhysicalReg[WriteBackBruAddr ] <= (WriteBackBru  ) ? WriteBackBruDate  : PhysicalReg[WriteBackBruAddr ] ;
            PhysicalReg[WriteBackLsuAddr ] <= (WriteBackLsu  ) ? WriteBackLsuDate  : PhysicalReg[WriteBackLsuAddr ] ;
            PhysicalReg[WriteBackROBAddr ] <= (WriteBackROB  ) ? WriteBackROBDate  : PhysicalReg[WriteBackROBAddr ] ;

        end
    end 

    assign Read11Date = Read11Able ? PhysicalReg[Read11Addr] : `ZeorDate ;
    assign Read12Date = Read12Able ? PhysicalReg[Read12Addr] : `ZeorDate ;
    assign Read21Date = Read21Able ? PhysicalReg[Read21Addr] : `ZeorDate ;
    assign Read22Date = Read22Able ? PhysicalReg[Read22Addr] : `ZeorDate ;
    assign Read31Date = Read31Able ? PhysicalReg[Read31Addr] : `ZeorDate ;
    assign Read32Date = Read32Able ? PhysicalReg[Read32Addr] : `ZeorDate ;
    assign Read41Date = Read41Able ? PhysicalReg[Read41Addr] : `ZeorDate ;
    assign Read42Date = Read42Able ? PhysicalReg[Read42Addr] : `ZeorDate ;
    assign Read51Date = Read51Able ? PhysicalReg[Read51Addr] : `ZeorDate ;
    assign Read52Date = Read52Able ? PhysicalReg[Read52Addr] : `ZeorDate ;
    assign Read61Date = Read61Able ? PhysicalReg[Read61Addr] : `ZeorDate ;
    assign Read62Date = Read62Able ? PhysicalReg[Read62Addr] : `ZeorDate ;
    assign Read71Date = Read71Able ? PhysicalReg[Read71Addr] : `ZeorDate ;
    assign Read72Date = Read72Able ? PhysicalReg[Read72Addr] : `ZeorDate ;
    assign Read81Date = Read81Able ? PhysicalReg[Read81Addr] : `ZeorDate ;
    assign Read82Date = Read82Able ? PhysicalReg[Read82Addr] : `ZeorDate ;
    
endmodule
`timescale 1ps/1ps
`include "../define.v"

module ReOrderBuffer (
    input         wire                               Clk            ,
    input         wire                               Rest           ,
    //for ctrl 
    input         wire                               ROBStop        ,
    input         wire                               ROBFlash       ,
    //for Icache 异常
    input         wire                               IcacheYc       ,
    input         wire       [6:0]                   IcacheYcCode   ,
    //from rename 为了简化，此处decode写入的一定的是四条指令
    input         wire                               InInst1Able    ,
    input         wire       [`InstAddrBus]          InInsr1Pc      ,
    input         wire       [`MicOperateCode]       InInst1MicOp   ,
    input         wire                               InInst1RdAble  ,
    input         wire       [`ArchRegBUs]           InInst1RdAnum  ,
    input         wire       [`ReNameRegBUs]         InInst1RdRnum  ,
    input         wire                               InInst2Able    ,
    input         wire       [`InstAddrBus]          InInsr2Pc      ,
    input         wire       [`MicOperateCode]       InInst2MicOp   ,
    input         wire                               InInst2RdAble  ,
    input         wire       [`ArchRegBUs]           InInst2RdAnum  ,
    input         wire       [`ReNameRegBUs]         InInst2RdRnum  ,  
    input         wire                               InInst3Able    ,
    input         wire       [`InstAddrBus]          InInsr3Pc      ,
    input         wire       [`MicOperateCode]       InInst3MicOp   ,
    input         wire                               InInst3RdAble  ,
    input         wire       [`ArchRegBUs]           InInst3RdAnum  ,
    input         wire       [`ReNameRegBUs]         InInst3RdRnum  ,  
    input         wire                               InInst4Able    ,
    input         wire       [`InstAddrBus]          InInsr4Pc      ,
    input         wire       [`MicOperateCode]       InInst4MicOp   ,
    input         wire                               InInst4RdAble  ,
    input         wire       [`ArchRegBUs]           InInst4RdAnum  ,
    input         wire       [`ReNameRegBUs]         InInst4RdRnum  ,                                                       
    //to rename 
    output        wire       [5:0]                   RobPtr1Alloc   ,
    output        wire       [5:0]                   RobPtr2Alloc   ,
    output        wire       [5:0]                   RobPtr3Alloc   ,
    output        wire       [5:0]                   RobPtr4Alloc   ,
    //from csr 
    input         wire                               ExtInterrupt   ,
    input         wire       [6:0]                   ExtCode        ,
    input         wire                               LlCtrlBit      ,
    input         wire       [25:0]                  InTlbEntryDate ,
    input         wire       [25:0]                  InEntryDate    ,
    output        wire                               Interrupt      , //此处中断包括所有例外包括entry返回
    output        wire       [`InstAddrBus]          InterruptPc    ,
    output        wire       [`InstAddrBus]          InterruptAddr  , //例如一条访存指令发生重填，pc就是这条指令地址addr就是他访存的虚地址
    output        wire       [6:0]                   InterruptType  ,   
    output        wire                               TrapEntry      ,
    //from eu
    //alu1
    input         wire                               Alu1ReadPcAble ,
    input         wire       [5:0]                   Alu1ReadPcPtr  ,
    output        wire       [`InstAddrBus]          Alu1ReadPcDate ,
    input         wire                               Alu1ComeAble   ,
    input         wire       [5:0]                   Alu1CoomePtr   ,
    //input         wire       [1:0]                   Alu1ComeType   ,
    //alu2
    input         wire                               Alu2ReadPcAble ,
    input         wire       [5:0]                   Alu2ReadPcPtr  ,
    output        wire       [`InstAddrBus]          Alu2ReadPcDate ,
    input         wire                               Alu2ComeAble   ,
    input         wire       [5:0]                   Alu2CoomePtr   ,
    //input         wire       [1:0]                   Alu2ComeType   ,
    //bru
    input         wire                               BruReadPcAble  ,
    input         wire       [5:0]                   BruReadPcPtr   ,
    output        wire       [`InstAddrBus]          BruReadPcDate  ,
    input         wire                               BruComeAble    ,
    input         wire       [5:0]                   BruCoomePtr    ,
    input         wire                               BruComeYN      ,
    input         wire       [1:0]                   BruCReDirType  ,
    input         wire       [`InstAddrBus]          BruCReDirPc    ,
    //div
    input         wire                               DivComeAble    ,
    input         wire       [5:0]                   DivCoomePtr    ,
    input         wire       [1:0]                   DivComeType    ,
    //mul 
    input         wire                               MulComeAble    ,
    input         wire       [5:0]                   MulCoomePtr    ,
    input         wire       [1:0]                   MulComeType    , 
    //csru 
    input         wire                               CsrReadPcAble  ,
    input         wire       [5:0]                   CsrReadPcPtr   ,
    output        wire       [`InstAddrBus]          CsrReadPcDate  ,
    input         wire                               CsrInterrupt   ,
    input         wire       [6:0]                   CsrCRobCode    ,
    input         wire       [`InstAddrBus]          CsrCRobAddr    ,
    input         wire                               CsrCRobReady   ,
    input         wire       [5:0]                   CsrCRobPtr     ,
    //input         wire                               CsrCRobIdle    ,  
    output        wire                               CsrRetirAble   ,
    output        wire       [`MicOperateCode]       CsrRetirMicOp  , 
    //AGUload
    input         wire                               LbReadPcAble   ,
    input         wire       [5:0]                   LbReadPcPtr    ,
    output        wire       [`InstAddrBus]          LbReadPcDate   ,
    //Load buffer
    input         wire                               LbComeAble     ,
    input         wire       [5:0]                   LbComeRobPtr   ,
    input         wire                               LbComeTrap     ,
    input         wire       [6:0]                   LbComeTrapCode ,
    input         wire       [2:0]                   LbComeBPtr     ,
    output        wire                               RetirLAble1    ,
    output        wire       [2:0]                   ReTirLPtr1     ,
    output        wire                               RetirLAble2    ,
    output        wire       [2:0]                   ReTirLPtr2     ,
    output        wire                               RetirLAble3    ,
    output        wire       [2:0]                   ReTirLPtr3     ,
    output        wire                               RetirLAble4    ,
    output        wire       [2:0]                   ReTirLPtr4     ,
    //store buffer
    input         wire                               StComeAble     ,
    input         wire       [5:0]                   StComeRobPtr   ,
    input         wire                               StComeTrap     ,
    input         wire       [6:0]                   StComeTrapCode ,
    input         wire       [2:0]                   StComeBPtr     ,
    output        wire                               RetirSAble1    ,
    output        wire       [2:0]                   ReTirSPtr1     ,
    output        wire                               RetirSAble2    ,
    output        wire       [2:0]                   ReTirSPtr2     ,
    output        wire                               RetirSAble3    ,
    output        wire       [2:0]                   ReTirSPtr3     ,
    output        wire                               RetirSAble4    ,
    output        wire       [2:0]                   ReTirSPtr4     ,
    //to FTQ 
    output        wire                               RobToFTQAble   ,//是否branch指令
    output        wire                               RobToFTQYN     ,//预测的对不对 
    output        wire       [`InstAddrBus]          RobToFTQPc     ,//指令的pc （branch指令的instpc不是nextpc）    
    //to PC
    output        wire                               RobReDirectAble,
    output        wire       [`InstAddrBus]          RobReDirectAddr,
    //to aRAT
    output        wire                               aRATRelaod     ,
    output        wire                               Inst1Map       ,
    output        wire       [`ArchRegBUs]           Inst1ArchReg   ,
    output        wire       [`ReNameRegBUs]         Inst1RenameReg ,
    output        wire                               Inst2Map       ,
    output        wire       [`ArchRegBUs]           Inst2ArchReg   ,
    output        wire       [`ReNameRegBUs]         Inst2RenameReg ,
    output        wire                               Inst3Map       ,
    output        wire       [`ArchRegBUs]           Inst3ArchReg   ,
    output        wire       [`ReNameRegBUs]         Inst3RenameReg ,
    output        wire                               Inst4Map       ,
    output        wire       [`ArchRegBUs]           Inst4ArchReg   ,
    output        wire       [`ReNameRegBUs]         Inst4RenameReg 
        
);

    reg    [102:0]  ROBENTY [0:63] ;

    assign Alu1ReadPcDate = Alu1ReadPcAble ? ROBENTY[Alu1ReadPcPtr][76:45] : 32'd0 ;
    assign Alu2ReadPcDate = Alu2ReadPcAble ? ROBENTY[Alu2ReadPcPtr][76:45] : 32'd0 ;
    assign BruReadPcDate  = BruReadPcAble  ? ROBENTY[BruReadPcPtr ][76:45] : 32'd0 ;
    assign CsrReadPcDate  = CsrReadPcAble  ? ROBENTY[CsrReadPcPtr ][76:45] : 32'd0 ;
    assign LbReadPcDate   = LbReadPcAble   ? ROBENTY[LbReadPcPtr  ][76:45] : 32'd0 ;

    wire            ROBEmpty       ;
    reg    [7:0]    IcacheYCTemp   ;
    always @(posedge Clk) begin
        if(!Rest) begin
            IcacheYCTemp <= 8'b0 ;
        end
        else if(ROBStop) begin
            IcacheYCTemp <= IcacheYCTemp ;
        end
        else if(ROBFlash) begin
            IcacheYCTemp <= 8'b0 ;
        end
        else if(IcacheYc) begin
            IcacheYCTemp <= {`AbleValue,IcacheYcCode} ;
        end
        else if(ROBEmpty) begin
            IcacheYCTemp <= 8'b0 ;
        end 
    end

    assign RobPtr1Alloc = Din1 ;
    assign RobPtr2Alloc = Din2 ;
    assign RobPtr3Alloc = Din3 ;
    assign RobPtr4Alloc = Din4 ;

    reg  [2:0] RobReadPtr ;
    wire [2:0] RobReadNum ;

    always @(posedge Clk) begin
        if(!Rest) begin
            RobReadPtr  <= 3'b0 ;
        end
        else begin
            RobReadPtr <= RobReadPtr[1:0] + RobReadNum ;
        end
    end

    wire [5:0] CheckInst1Ptr ; 
    wire [5:0] CheckInst2Ptr ; 
    wire [5:0] CheckInst3Ptr ; 
    wire [5:0] CheckInst4Ptr ; 

    assign {CheckInst1Ptr,CheckInst2Ptr,CheckInst3Ptr,CheckInst4Ptr} = (RobReadPtr == 0) ? {CriqPreOut1,CriqPreOut2,CriqPreOut3,CriqPreOut4} :
                                                                       (RobReadPtr == 1) ? {CriqPreOut2,CriqPreOut3,CriqPreOut4,CriqPreOut1} :
                                                                       (RobReadPtr == 2) ? {CriqPreOut3,CriqPreOut4,CriqPreOut1,CriqPreOut2} :
                                                                       (RobReadPtr == 3) ? {CriqPreOut3,CriqPreOut1,CriqPreOut2,CriqPreOut3} : 24'd0 ;

    wire Inst1CanRetir = ROBENTY[CheckInst1Ptr][44] ;
    wire Inst2CanRetir = ROBENTY[CheckInst2Ptr][44] ;
    wire Inst3CanRetir = ROBENTY[CheckInst3Ptr][44] ;
    wire Inst4CanRetir = ROBENTY[CheckInst4Ptr][44] ;

    wire Inst1KernalYN = (ROBENTY[CheckInst1Ptr][101:99] == 3'b100);
    wire Inst2KernalYN = (ROBENTY[CheckInst2Ptr][101:99] == 3'b100);
    wire Inst3KernalYN = (ROBENTY[CheckInst3Ptr][101:99] == 3'b100);
    wire Inst4KernalYN = (ROBENTY[CheckInst4Ptr][101:99] == 3'b100);

    wire Inst1Redirect = ROBENTY[CheckInst1Ptr][43] ;
    wire Inst2Redirect = ROBENTY[CheckInst2Ptr][43] ;
    wire Inst3Redirect = ROBENTY[CheckInst3Ptr][43] ;
    wire Inst4Redirect = ROBENTY[CheckInst4Ptr][43] ;

    wire Inst1Trap     = ROBENTY[CheckInst1Ptr][10] ;
    wire Inst2Trap     = ROBENTY[CheckInst2Ptr][10] ;
    wire Inst3Trap     = ROBENTY[CheckInst3Ptr][10] ;
    wire Inst4Trap     = ROBENTY[CheckInst4Ptr][10] ;
    
    wire FinalRetir1 = ~ExtInterrupt & Inst1CanRetir  ;
    wire FInalRetir2 = FinalRetir1 & ~Inst1KernalYN & ~Inst1Redirect ;
    wire FInalRetir3 = FInalRetir2 & ~Inst2KernalYN & ~Inst2Redirect ;
    wire FInalRetir4 = FInalRetir3 & ~Inst3KernalYN & ~Inst3Redirect ;

    wire LastComit1  = FinalRetir1 & ~FinalRetir2 & ~FinalRetir3 & ~FinalRetir4 ;
    wire LastComit2  = FinalRetir1 &  FinalRetir2 & ~FinalRetir3 & ~FinalRetir4 ;
    wire LastComit3  = FinalRetir1 &  FinalRetir2 &  FinalRetir3 & ~FinalRetir4 ;
    wire LastComit4  = FinalRetir1 &  FinalRetir2 &  FinalRetir3 &  FinalRetir4 ;

    assign RobReadNum = {3{(LastComit1)}} & 3'b1 |
                        {3{(LastComit2)}} & 3'b2 |
                        {3{(LastComit3)}} & 3'b3 |
                        {3{(LastComit4)}} & 3'b4 ;

    wire   CommitIdle =  LastComit1 & (ROBENTY[CheckInst1Ptr][101:93] == `InstIdle) |   
                         LastComit2 & (ROBENTY[CheckInst2Ptr][101:93] == `InstIdle) |    
                         LastComit3 & (ROBENTY[CheckInst3Ptr][101:93] == `InstIdle) |     
                         LastComit4 & (ROBENTY[CheckInst4Ptr][101:93] == `InstIdle) ;

    wire       

    wire Wu1_CRIQable = InInst1Able ;
    wire [5:0] CriqPreOut1          ;
    wire [5:0] Frontd1              ;
    wire [5:0] Din1   = Frontd1+4   ;

    

    CRIQ#(
        .CRIQWIDE    ( 6  ),
        .CRIQDEEP    ( 16 ),
        .PTRWIDE     ( 4  )
    )u1_CRIQ(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .Rable       ( Rable1      ),
        .Dout        ( Dout1       ),
        .CriqPreOut  ( CriqPreOut1 ),
        .Frontd      ( Frontd1     ),
        .Wable       ( Wu1_CRIQable),
        .Din         ( Din1        ),
        .CriqClean   ( CriqClean   ),
        .CriqFull    ( CriqFull1   ),
        .CriqEmpty   ( CriqEmpty   )
    );

    wire Wu2_CRIQable = InInst1Able ;
    wire [5:0] CriqPreOut2          ;
    wire [5:0] Frontd2              ;
    wire [5:0] Din2   = Frontd2+4   ;

     CRIQ#(
        .CRIQWIDE    ( 6  ),
        .CRIQDEEP    ( 16 ),
        .PTRWIDE     ( 4  )
    )u2_CRIQ(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .Rable       ( Rable1      ),
        .Dout        ( Dout1       ),
        .CriqPreOut  ( CriqPreOut1 ),
        .Frontd      ( Frontd2     ),
        .Wable       ( Wu2_CRIQable),
        .Din         ( Din2        ),
        .CriqClean   ( CriqClean   ),
        .CriqFull    ( CriqFull1   ),
        .CriqEmpty   ( CriqEmpty   )
    );

    wire Wu3_CRIQable = InInst1Able ;
    wire [5:0] CriqPreOut3          ;
    wire [5:0] Frontd3              ;
    wire [5:0] Din3   = Frontd3+4   ;

     CRIQ#(
        .CRIQWIDE    ( 6  ),
        .CRIQDEEP    ( 16 ),
        .PTRWIDE     ( 4  )
    )u3_CRIQ(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .Rable       ( Rable1      ),
        .Dout        ( Dout1       ),
        .CriqPreOut  ( CriqPreOut1 ),
        .Frontd      ( Frontd3     ),
        .Wable       ( Wu3_CRIQable),
        .Din         ( Din3        ),
        .CriqClean   ( CriqClean   ),
        .CriqFull    ( CriqFull1   ),
        .CriqEmpty   ( CriqEmpty   )
    );

    wire Wu4_CRIQable = InInst1Able ;
    wire [5:0] CriqPreOut4          ;
    wire [5:0] Frontd4              ;
    wire [5:0] Din4   = Frontd4+4   ;

     CRIQ#(
        .CRIQWIDE    ( 6  ),
        .CRIQDEEP    ( 16 ),
        .PTRWIDE     ( 4  )
    )u4_CRIQ(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .Rable       ( Rable1      ),
        .Dout        ( Dout1       ),
        .CriqPreOut  ( CriqPreOut1 ),
        .Frontd      ( Frontd4     ),
        .Wable       ( Wu4_CRIQable),
        .Din         ( Din4        ),
        .CriqClean   ( CriqClean   ),
        .CriqFull    ( CriqFull1   ),
        .CriqEmpty   ( CriqEmpty   )
    );
    
    integer i ;
    always @(posedge Clk) begin
        if(!Rest) begin
            for (i =0 ;i<32 ;i=i+1) begin
                ROBENTY[i]    <= 103'd0 ;
                ROBENTY[i+32] <= 103'd0 ;
            end
        end
        else if(ROBStop)begin
            for (i =0 ;i<32 ;i=i+1) begin
                ROBENTY[i]    <= ROBENTY[i]   ;
                ROBENTY[i+32] <= ROBENTY[i+32];
            end
        end 
        else if(ROBFlash)begin
            for (i =0 ;i<32 ;i=i+1) begin
                ROBENTY[i]    <= 103'd0 ;
                ROBENTY[i+32] <= 103'd0 ;
            end
        end
        else begin
            ROBENTY[Din1] <= InInst1Able ? {`AbleValue,InInst1MicOp,InInst1RdAble,InInst1RdAnum,InInst1RdRnum,InInsr1Pc,45'd0} ;
            ROBENTY[Din2] <= InInst2Able ? {`AbleValue,InInst2MicOp,InInst2RdAble,InInst2RdAnum,InInst2RdRnum,InInsr2Pc,45'd0} ;
            ROBENTY[Din3] <= InInst3Able ? {`AbleValue,InInst3MicOp,InInst3RdAble,InInst3RdAnum,InInst3RdRnum,InInsr3Pc,45'd0} ;
            ROBENTY[Din4] <= InInst4Able ? {`AbleValue,InInst4MicOp,InInst4RdAble,InInst4RdAnum,InInst4RdRnum,InInsr4Pc,45'd0} ;
            ROBENTY[Alu1CoomePtr][44] <=    Alu1ComeAble ? Alu1ComeAble : ROBENTY[Alu1CoomePtr][44] ;
            ROBENTY[Alu2CoomePtr][44] <=    Alu2ComeAble ? Alu2ComeAble : ROBENTY[Alu2CoomePtr][44] ;
            ROBENTY[BruCoomePtr ][44:11] <= BruComeAble  ? {BruComeAble,BruCReDirType,BruCReDirPc} : ROBENTY[BruCoomePtr ][44:11] ;
            ROBENTY[CsrCRobPtr  ][45:3]  <= CsrCRobReady ? {CsrCRobReady,1'b0,CsrCRobAddr,CsrInterrupt,CsrCRobCode} : ROBENTY[CsrCRobPtr  ][45:3] ;
            ROBENTY[LbComeRobPtr][44:0]  <= LbComeAble   ? {LbComeAble,1'b0,32'b0,LbComeTrap,LbComeTrapCode,LbComeBPtr} : ROBENTY[LbComeRobPtr][44:0] ;
            ROBENTY[StComeRobPtr][44:0]  <= StComeAble   ? {StComeAble,1'b0,32'b0,StComeTrap,StComeTrapCode,StComeBPtr} : ROBENTY[StComeRobPtr][44:0] ;
        end
    end

    
endmodule`timescale 1ps/1ps
`include "../define.v"

module Mmu (
    input       wire                                     Clk           ,
    input       wire                                     Rest          ,

    input       wire                                     MmuFlash      ,
    input       wire                                     MmuStop       ,
    //from Csr
    input       wire      [9:0]                          Asid          ,
    input       wire      [`DataBus]                     CsrDmw0Date   ,
    input       wire      [`DataBus]                     CsrDmw1Date   ,
    input       wire      [`DataBus]                     CsrCrmdDate   ,
    //input       wire                                     CsrReadTlbAble,
    input       wire      [5:0]                          CsrReadTlbAddr ,
    output      wire      [89-1:0]                       CsrReadTlbDate , 
    input       wire                                     CsrSerchTlbAble, 
    input       wire      [28:0]                         CsrSerchInfrom ,
    output      wire                                     CsrSerchAble   ,
    output      wire      [5:0]                          CsrSerchIdxDate,
    input       wire                                     CsrWriteTlbAble,
    input       wire      [5:0]                          CsrWriteTlbAddr,
    input       wire      [88:0]                         CsrWriteTlbDate, 
    input       wire                                     CsrInvEn       ,
    input       wire      [ 4:0]                         CsrInvOp       ,
    input       wire      [ 9:0]                         CsrInvAsid     ,
    input       wire      [18:0]                         CsrInvVppn     , 
    //from Inst
    input       wire                                     InstFetch      ,
    input       wire      [31:0]                         InstVritualA   ,
    output      wire      [1:0]                          InstOperType   ,
    output      wire                                     InstTlbTrap    , // //to ROB save ICache excaption when before inst exection finash
    output      wire      [6:0]                          InstTlbTrapType, 
    output      wire      [`InstAddrBus]                 InstPhysicalAddr,
    //from load
    input       wire                                     LoadAccess      ,
    //input       wire                                     LoadOrStore    , //1store 0load
    input       wire      [31:0]                         LoadVritualA    ,
    output      wire      [1:0]                          LoadOperType    ,
    output      wire                                     LoadTlbTrap     ,
    output      wire      [6:0]                          LoadTlbTrapType ,
    output      wire      [`InstAddrBus]                 LoadPhysicalAddr,
    //for store
    input       wire                                     StoreAccess      ,
    //input       wire                                     LoadOrStore    , //1store 0load
    input       wire      [31:0]                         StoreVritualA    ,
    output      wire      [1:0]                          StoreOperType    ,
    output      wire                                     StoreTlbTrap     ,
    output      wire      [6:0]                          StoreTlbTrapType ,
    output      wire      [`InstAddrBus]                 StorePhysicalAddr
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


    wire                 DriectDmw0Able   = (InstVritualA[31:29] == CsrDmw0Date[31:29]);
    // wire  [1:0]          DriectDmw0Plv    = {CsrDmw0Date[3],CsrDmw0Date[0]} ;
    // wire  [1:0]          DriectDmw0Mat    = CsrDmw0Date[5:4] ;
    wire  [`InstAddrBus] Dmw0Physicaladdr = {CsrDmw0Date[27:25],InstVritualA[28:0]} ;
    wire                 DriectDmw1Able   = (InstVritualA[31:29] == CsrDmw1Date[31:29]);
    // wire  [1:0]          DriectDmw1Plv    = {CsrDmw1Date[3],CsrDmw1Date[0]} ;
    // wire  [1:0]          DriectDmw1Mat    = CsrDmw1Date[5:4] ;
    wire  [`InstAddrBus] Dmw1Physicaladdr = {CsrDmw1Date[27:25],InstVritualA[28:0]} ;


    wire  [18:0]   PortInstVppn = InstVritualA[31:13] ;
    wire           PortInstOdd  = ~InstVritualA[12]   ;
    wire  [19:0]   PortInstPpn ;
    wire           PortInstFund;
    wire           PortInstV   ;
    wire           PortInstD   ;
    wire  [1:0]    PortInstMat ;
    wire  [1:0]    PortInstPlv ;
    wire  [5:0]    PortInstPs  ;
    wire  [`InstAddrBus]    MmuPhysicalAddr = {PortInstPpn, InstVritualA[11:0]} ;

    reg [`InstAddrBus] InstPhysicalAddrReg ;
    reg [6:0]          InstTlbTrapTypeReg  ;
    reg                InstTlbTrapAbleReg  ;     
    reg [1:0]          InstMatType         ;
    always @(posedge Clk) begin
        if(!Rest) begin
            InstPhysicalAddrReg<= `ZeorDate ;
            InstTlbTrapTypeReg <= 7'd0 ;
            InstTlbTrapAbleReg <= `EnableValue ;
            InstMatType        <= 2'd0 ;
        end
        else if(MmuFlash) begin
            InstPhysicalAddrReg<= `ZeorDate ;
            InstTlbTrapTypeReg <= 7'd0 ;
            InstTlbTrapAbleReg <= `EnableValue ;
            InstMatType        <= 2'd0 ;
        end
        else if(MmuStop) begin
            InstPhysicalAddrReg<= InstPhysicalAddrReg ;
            InstTlbTrapTypeReg <= InstTlbTrapTypeReg ;
            InstTlbTrapAbleReg <= InstTlbTrapAbleReg ;
            InstMatType        <= InstMatType ;
        end
        else if(InstFetch) begin
            InstPhysicalAddrReg <= (CsrCrmdDate[3] && ~CsrCrmdDate[4]) ? InstVritualA : 
                                   ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && DriectDmw0Able) ? Dmw0Physicaladdr : 
                                   ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && DriectDmw1Able) ? Dmw1Physicaladdr :
                                   (~CsrCrmdDate[3] && CsrCrmdDate[4]) ? MmuPhysicalAddr : `ZeorDate ;
            {InstTlbTrapAbleReg, InstTlbTrapTypeReg} <= ~PortInstFund ? {`AbleValue, `TLBR} : 
                                                        ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && DriectDmw0Able) ? {~((CsrDmw0Date[0] & (CsrCrmdDate[1:0] == 0)) || ~(CsrDmw0Date[3] & (CsrCrmdDate[1:0] == 3))), `PPI}:
                                                        ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && DriectDmw1Able) ? {~((CsrDmw1Date[0] & (CsrCrmdDate[1:0] == 0)) || ~(CsrDmw1Date[3] & (CsrCrmdDate[1:0] == 3))), `PPI}:
                                                        (~CsrCrmdDate[3] && CsrCrmdDate[4])  ? (PortInstV ?  {~(PortInstPlv == CsrCrmdDate[1:0]), `PPI} : {`AbleValue, `PIF}) : {`EnableValue, 7'd0};
            InstMatType  <= (CsrCrmdDate[3] && ~CsrCrmdDate[4]) ? CsrCrmdDate[6:5] :
                            ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && DriectDmw0Able) ? CsrDmw0Date[5:4] :
                            ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && DriectDmw1Able) ? CsrDmw1Date[5:4] :
                            (~CsrCrmdDate[3] && CsrCrmdDate[4]) ? PortInstMat : 2'b01 ;
        end         
    end 

    assign InstPhysicalAddr = InstPhysicalAddrReg ;
    assign InstTlbTrapType  = InstTlbTrapTypeReg  ;
    assign InstTlbTrap      = InstTlbTrapAbleReg  ;
    assign InstOperType     = InstMatType ;

    //for load 
    wire                 LDriectDmw0Able   = (LoadVritualA[31:29] == CsrDmw0Date[31:29]);
    // wire  [1:0]          MDriectDmw0Plv    = {CsrDmw0Date[3],CsrDmw0Date[0]} ;
    // wire  [1:0]          MDriectDmw0Mat    = CsrDmw0Date[5:4] ;
    wire  [`InstAddrBus] LDmw0Physicaladdr = {CsrDmw1Date[27:25],LoadVritualA[28:0]} ;
    wire                 LDriectDmw1Able   = (LoadVritualA[31:29] == CsrDmw1Date[31:29]);
    // wire  [1:0]          MDriectDmw1Plv    = {CsrDmw1Date[3],CsrDmw1Date[0]} ;
    // wire  [1:0]          MDriectDmw1Mat    = CsrDmw1Date[5:4] ;
    wire  [`InstAddrBus] LDmw1Physicaladdr = {CsrDmw1Date[27:25],LoadVritualA[28:0]} ;


    wire  [18:0]   PortLoadVppn = LoadVritualA[31:13] ;
    wire           PortLoadOdd  = ~LoadVritualA[12]   ;
    wire  [19:0]   PortLoadPpn ;
    wire           PortLoadFound;
    wire           PortLoadV   ;
    wire           PortLoadD   ;
    wire  [1:0]    PortLoadMat ;
    wire  [1:0]    PortLoadPlv ;
    wire  [5:0]    PortLoadPs  ;
    wire  [`InstAddrBus] MmuPhysicalAddr2 = {PortLoadPpn, LoadVritualA[11:0]} ;

    reg                  LoadTlbTrapReg ;
    reg   [6:0]          LoadTlbTrapTypeReg ;
    reg   [`InstAddrBus] LoadPhysicalAddrReg;
    reg   [1:0]          LoadMatType    ;    
    always @(posedge Clk) begin
        if(!Rest) begin
            LoadTlbTrapReg <= 1'b0 ;
            LoadTlbTrapTypeReg <= 7'd0 ;
            LoadPhysicalAddrReg <= `ZeorDate ;
            LoadMatType <= 2'b0 ;
        end
        else if(MmuFlash) begin
            LoadTlbTrapReg <= 1'b0 ;
            LoadTlbTrapTypeReg <= 7'd0 ;
            LoadPhysicalAddrReg <= `ZeorDate ;
            LoadMatType <= 2'b0 ;
        end
        else if(MmuStop) begin
            LoadTlbTrapReg <= LoadTlbTrapReg ;
            LoadTlbTrapTypeReg <= LoadTlbTrapTypeReg ;
            LoadPhysicalAddrReg <= LoadPhysicalAddrReg ;
            LoadMatType <= LoadMatType ;
        end
        else if(LoadAccess) begin
            LoadPhysicalAddrReg <= (CsrCrmdDate[3] && ~CsrCrmdDate[4]) ? LoadVritualA : 
                                  ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && LDriectDmw0Able) ? LDmw0Physicaladdr :
                                  ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && LDriectDmw1Able) ? LDmw1Physicaladdr :
                                  (~CsrCrmdDate[3] && CsrCrmdDate[4]) ? MmuPhysicalAddr2 : `ZeorDate ;
            {LoadTlbTrapReg,LoadTlbTrapTypeReg} <= ~PortLoadFound ? {`AbleValue, `TLBR} :
                                                 ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && LDriectDmw0Able) ? {~((CsrDmw0Date[0] & (CsrCrmdDate[1:0] == 0)) || ~(CsrDmw0Date[3] & (CsrCrmdDate[1:0] == 3))), `PPI}:
                                                 ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && LDriectDmw1Able) ? {~((CsrDmw1Date[0] & (CsrCrmdDate[1:0] == 0)) || ~(CsrDmw1Date[3] & (CsrCrmdDate[1:0] == 3))), `PPI}:
                                                 (~CsrCrmdDate[3] && CsrCrmdDate[4]) ? (~PortLoadV ? {`AbleValue,`PIL}:((PortLoadPlv == CsrCrmdDate[1:0])?{PortLoadD,`PME}:{`AbleValue,`PPI})):{`EnableValue,7'd0};
            LoadMatType <= (CsrCrmdDate[3] && ~CsrCrmdDate[4]) ? CsrCrmdDate[8:7] : 
                          ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && LDriectDmw0Able) ? CsrDmw0Date[5:4] :
                          ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && LDriectDmw1Able) ? CsrDmw1Date[5:4] :
                          (~CsrCrmdDate[3] && CsrCrmdDate[4]) ? PortLoadMat : 2'b01 ;
        end
    end

    assign LoadOperType = LoadMatType ;
    assign LoadTlbTrap  = LoadTlbTrapReg ;
    assign LoadTlbTrapType = LoadTlbTrapTypeReg ;
    assign LoadPhysicalAddr = LoadPhysicalAddrReg ;


//for store 
    wire                 SDriectDmw0Able   = (StoreVritualA[31:29] == CsrDmw0Date[31:29]);
    // wire  [1:0]          MDriectDmw0Plv    = {CsrDmw0Date[3],CsrDmw0Date[0]} ;
    // wire  [1:0]          MDriectDmw0Mat    = CsrDmw0Date[5:4] ;
    wire  [`InstAddrBus] SDmw0Physicaladdr = {CsrDmw1Date[27:25],StoreVritualA[28:0]} ;
    wire                 SDriectDmw1Able   = (StoreVritualA[31:29] == CsrDmw1Date[31:29]);
    // wire  [1:0]          MDriectDmw1Plv    = {CsrDmw1Date[3],CsrDmw1Date[0]} ;
    // wire  [1:0]          MDriectDmw1Mat    = CsrDmw1Date[5:4] ;
    wire  [`InstAddrBus] SDmw1Physicaladdr = {CsrDmw1Date[27:25],StoreVritualA[28:0]} ;


    wire  [18:0]   PortStoreVppn = LoadVritualA[31:13] ;
    wire           PortStoreOdd  = ~LoadVritualA[12]   ;
    wire  [19:0]   PortStorePpn ;
    wire           PortStoreFound;
    wire           PortStoreV   ;
    wire           PortStoreD   ;
    wire  [1:0]    PortStoreMat ;
    wire  [1:0]    PortStorePlv ;
    wire  [5:0]    PortStorePs  ;
    wire  [`InstAddrBus] MmuPhysicalAddr3 = {PortStorePpn, StoreVritualA[11:0]} ;

    reg                  StoreTlbTrapReg ;
    reg   [6:0]          StoreTlbTrapTypeReg ;
    reg   [`InstAddrBus] StorePhysicalAddrReg;
    reg   [1:0]          StoreMatType    ;    
    always @(posedge Clk) begin
        if(!Rest) begin
            StoreTlbTrapReg <= 1'b0 ;
            StoreTlbTrapTypeReg <= 7'd0 ;
            StorePhysicalAddrReg <= `ZeorDate ;
            StoreMatType <= 2'b0 ;
        end
        else if(MmuFlash) begin
            StoreTlbTrapReg <= 1'b0 ;
            StoreTlbTrapTypeReg <= 7'd0 ;
            StorePhysicalAddrReg <= `ZeorDate ;
            StoreMatType <= 2'b0 ;
        end
        else if(MmuStop) begin
            StoreTlbTrapReg <= StoreTlbTrapReg ;
            StoreTlbTrapTypeReg <= StoreTlbTrapTypeReg ;
            StorePhysicalAddrReg <= StorePhysicalAddrReg ;
            StoreMatType <= StoreMatType ;
        end
        else if(StoreAccess) begin
            StorePhysicalAddrReg <= (CsrCrmdDate[3] && ~CsrCrmdDate[4]) ? StoreVritualA : 
                                  ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && SDriectDmw0Able) ? SDmw0Physicaladdr :
                                  ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && SDriectDmw1Able) ? SDmw1Physicaladdr :
                                  (~CsrCrmdDate[3] && CsrCrmdDate[4]) ? MmuPhysicalAddr3 : `ZeorDate ;
            {StoreTlbTrapReg,StoreTlbTrapTypeReg} <= ~PortStoreFound ? {`AbleValue, `TLBR} :
                                                 ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && SDriectDmw0Able) ? {~((CsrDmw0Date[0] & (CsrCrmdDate[1:0] == 0)) || ~(CsrDmw0Date[3] & (CsrCrmdDate[1:0] == 3))), `PPI}:
                                                 ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && SDriectDmw1Able) ? {~((CsrDmw1Date[0] & (CsrCrmdDate[1:0] == 0)) || ~(CsrDmw1Date[3] & (CsrCrmdDate[1:0] == 3))), `PPI}:
                                                 (~CsrCrmdDate[3] && CsrCrmdDate[4]) ? (~PortStoreV ? {`AbleValue,`PIL}:((PortStorePlv == CsrCrmdDate[1:0])?{PortStoreD,`PME}:{`AbleValue,`PPI})):{`EnableValue,7'd0};
            StoreMatType <= (CsrCrmdDate[3] && ~CsrCrmdDate[4]) ? CsrCrmdDate[8:7] : 
                          ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && SDriectDmw0Able) ? CsrDmw0Date[5:4] :
                          ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && SDriectDmw1Able) ? CsrDmw1Date[5:4] :
                          (~CsrCrmdDate[3] && CsrCrmdDate[4]) ? PortStoreMat : 2'b01 ;
        end
    end
    
    assign StoreOperType = StoreMatType ;
    assign StoreTlbTrap  = StoreTlbTrapReg ;
    assign StoreTlbTrapType = StoreTlbTrapTypeReg ;
    assign StorePhysicalAddr = StorePhysicalAddrReg ;


    wire               SerchAble ;
    wire  [5:0]        SerchIndex;

    reg               SerchAbleReg ;
    reg   [5:0]       SerchIndexReg;
    always @(posedge Clk) begin
        if(!Rest) begin
            SerchAbleReg <= `EnableValue ;
            SerchIndexReg <= 6'd0 ;
        end
        else if(MmuFlash) begin
            SerchAbleReg <= `EnableValue ;
            SerchIndexReg <= 6'd0 ;
        end
        else if(MmuStop) begin
            SerchAbleReg <= SerchAbleReg ;
            SerchIndexReg <= SerchIndexReg ;
        end
        else if(CsrSerchTlbAble) begin
            SerchAbleReg <=  SerchAble ;
            SerchIndexReg <= SerchIndex;
        end
    end 

    assign CsrSerchIdxDate = SerchIndexReg ;
    assign CsrSerchAble = SerchAbleReg ;

    wire [18:0] WriteVppn = CsrWriteTlbDate[88:70];
    wire        WriteE    = CsrWriteTlbDate[69] ;
    wire [9:0]  WriteAsid = CsrWriteTlbDate[68:59];
    wire        WriteG    = CsrWriteTlbDate[58] ;
    wire [5:0]  WritePs   = CsrWriteTlbDate[57:52];
    wire [19:0] WritePpn0 = CsrWriteTlbDate[51:32];
    wire [1:0]  WritePlv0 = CsrWriteTlbDate[31:30];
    wire [1:0]  WriteMat0 = CsrWriteTlbDate[29:28];
    wire        WriteV0   = CsrWriteTlbDate[27];
    wire        WriteD0   = CsrWriteTlbDate[26];
    wire [19:0] WritePpn1 = CsrWriteTlbDate[25:6];
    wire [1:0]  WritePlv1 = CsrWriteTlbDate[5:4];
    wire [1:0]  WriteMat1 = CsrWriteTlbDate[3:2];
    wire        WriteV1   = CsrWriteTlbDate[1];
    wire        WriteD1   = CsrWriteTlbDate[0];


    TlbEntry#(
        .TLBNUM     ( 64 )
    )u_TlbEntry(
        .Clk        ( Clk              ),
        .Rest       ( Rest             ),
        .S0Vppn     ( PortInstVppn     ),
        .S0OddPage  ( PortInstOdd      ),
        .S0Asid     ( Asid             ),
        .S0Fund     ( PortInstFund     ),
        //.S0Index    ( S0Index    ),
        .S0Ps       ( PortInstPs       ),
        .S0Ppn      ( PortInstPpn      ),
        .S0V        ( PortInstV        ),
        .S0D        ( PortInstD        ),
        .S0Mat      ( PortInstMat      ),
        .S0Plv      ( PortInstPlv      ),
        .S1Vppn     ( PortLoadVppn     ),
        .S1OddPage  ( PortLoadOdd      ),
        .S1Asid     ( Asid             ),
        .S1Fund     ( PortLoadFound    ),
        //.S1Index    ( S1Index    ),
        .S1Ps       ( PortLoadPs        ),
        .S1Ppn      ( PortLoadPpn       ),
        .S1V        ( PortLoadV         ),
        .S1D        ( PortLoadD         ),
        .S1Mat      ( PortLoadMat       ),
        .S1Plv      ( PortLoadPlv       ),
        .S2Vppn     ( PortStoreVppn     ),
        .S2OddPage  ( PortStoreOdd      ),
        .S2Asid     ( Asid              ),
        .S2Fund     ( PortStoreFound    ),
        //.S2Index    ( S1Index    ),
        .S2Ps       ( PortStorePs        ),
        .S2Ppn      ( PortStorePpn       ),
        .S2V        ( PortStoreV         ),
        .S2D        ( PortStoreD         ),
        .S2Mat      ( PortStoreMat       ),
        .S2Plv      ( PortStorePlv       ),
        .CsrSerchInfrom (CsrSerchInfrom),
        .CsrSerchSucces (SerchAble     ),
        .csrSerchDate   (SerchIndex    ),
        .We         ( CsrWriteTlbAble  ),
        .WIndex     ( CsrWriteTlbAddr  ),
        .WVppn      ( WriteVppn        ),
        .WAsid      ( WriteAsid        ),
        .WG         ( WriteG           ),
        .WPs        ( WritePs          ),
        .WE         ( WriteE           ),
        .WV0        ( WriteV0          ),
        .WD0        ( WriteD0          ),
        .WMat0      ( WriteMat0        ),
        .WPlv0      ( WritePlv0        ),
        .WPpn0      ( WritePpn0        ),
        .WV1        ( WriteV1          ),
        .WD1        ( WriteD1          ),
        .WMat1      ( WriteMat1        ),
        .WPlv1      ( WritePlv1        ),
        .WPpn1      ( WritePpn1        ),
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
        .InvEn      ( CsrInvEn|MmuFlash),
        .InvOp      ( CsrInvOp|5'b0    ),
        .InvAsid    ( CsrInvAsid       ),
        .InvVppn    ( CsrInvVppn       )
    );

    
    
endmodule 
 `timescale 1ps/1ps
`include "../define.v"

module TlbEntry #(
    parameter TLBNUM = 64 
) (
    input        wire                                        Clk           ,
    input        wire                                        Rest          ,

    //inst search 
    //input        wire                                        S0Fetch       ,
    input        wire      [18:0]                            S0Vppn        ,
    input        wire                                        S0OddPage     ,
    input        wire      [ 9:0]                            S0Asid        ,
    output       wire                                        S0Fund        ,
    //output       wire      [$clog2(TLBNUM)-1:0]              S0Index       ,
    output       wire      [ 5:0]                            S0Ps          ,
    output       wire      [19:0]                            S0Ppn         ,
    output       wire                                        S0V           ,
    output       wire                                        S0D           ,
    output       wire      [ 1:0]                            S0Mat         ,
    output       wire      [ 1:0]                            S0Plv         ,
    //Load search 
    //input        wire                                        S1Fetch       ,
    input        wire      [18:0]                            S1Vppn        ,
    input        wire                                        S1OddPage     ,
    input        wire      [ 9:0]                            S1Asid        ,
    output       wire                                        S1Fund        ,
    //output       wire      [$clog2(TLBNUM)-1:0]              S1Index       ,
    output       wire      [ 5:0]                            S1Ps          ,
    output       wire      [19:0]                            S1Ppn         ,
    output       wire                                        S1V           ,
    output       wire                                        S1D           ,
    output       wire      [ 1:0]                            S1Mat         ,
    output       wire      [ 1:0]                            S1Plv         ,  
    //store search 
    //input        wire                                        S2Fetch       ,
    input        wire      [18:0]                            S2Vppn        ,
    input        wire                                        S2OddPage     ,
    input        wire      [ 9:0]                            S2Asid        ,
    output       wire                                        S2Fund        ,
    //output       wire      [$clog2(TLBNUM)-1:0]              S2Index       ,
    output       wire      [ 5:0]                            S2Ps          ,
    output       wire      [19:0]                            S2Ppn         ,
    output       wire                                        S2V           ,
    output       wire                                        S2D           ,
    output       wire      [ 1:0]                            S2Mat         ,
    output       wire      [ 1:0]                            S2Plv         , 
    //CSR serch
    //input        wire                                        CsrSerch      ,
    input        wire      [29-1:0]                          CsrSerchInfrom,
    output       wire                                        CsrSerchSucces,
    output       wire      [5:0]                             csrSerchDate  ,
    // write TLB
    input        wire                                        We            ,
    input        wire      [$clog2(TLBNUM)-1:0]              WIndex        ,
    input        wire      [18:0]                            WVppn         ,
    input        wire      [ 9:0]                            WAsid         ,
    input        wire                                        WG            ,
    input        wire      [ 5:0]                            WPs           ,
    input        wire                                        WE            ,
    input        wire                                        WV0           ,
    input        wire                                        WD0           ,
    input        wire      [ 1:0]                            WMat0         ,
    input        wire      [ 1:0]                            WPlv0         ,
    input        wire      [19:0]                            WPpn0         ,
    input        wire                                        WV1           ,
    input        wire                                        WD1           ,
    input        wire      [ 1:0]                            WMat1         ,
    input        wire      [ 1:0]                            WPlv1         ,
    input        wire      [19:0]                            WPpn1         ,
    // read TLB
    input        wire      [$clog2(TLBNUM)-1:0]              RIndex        ,
    output       wire      [18:0]                            RVppn         ,
    output       wire      [ 9:0]                            RAsid         ,
    output       wire                                        RG            ,
    output       wire      [ 5:0]                            RPs           ,
    output       wire                                        RE            ,
    output       wire                                        RV0           ,
    output       wire                                        RD0           ,
    output       wire      [ 1:0]                            RMat0         ,
    output       wire      [ 1:0]                            RPlv0         ,
    output       wire      [19:0]                            RPpn0         ,
    output       wire                                        RV1           ,
    output       wire                                        RD1           ,
    output       wire      [ 1:0]                            RMat1         ,
    output       wire      [ 1:0]                            RPlv1         ,
    output       wire      [19:0]                            RPpn1         ,
    //invable
    input        wire                                        InvEn         ,
    input        wire      [ 4:0]                            InvOp         ,
    input        wire      [ 9:0]                            InvAsid       ,
    input        wire      [18:0]                            InvVppn
);

    reg [18:0] TLBVPPN      [TLBNUM-1:0];
    reg        TLBE         [TLBNUM-1:0];
    reg [ 9:0] TLBASID      [TLBNUM-1:0];
    reg        TLBG         [TLBNUM-1:0];
    reg [ 5:0] TLBPS        [TLBNUM-1:0];
    reg [19:0] TLBPPN0      [TLBNUM-1:0];
    reg [ 1:0] TLBPLV0      [TLBNUM-1:0];
    reg [ 1:0] TLBMAT0      [TLBNUM-1:0];
    reg        TLBD0        [TLBNUM-1:0];
    reg        TLBV0        [TLBNUM-1:0];
    reg [19:0] TLBPPN1      [TLBNUM-1:0];
    reg [ 1:0] TLBPLV1      [TLBNUM-1:0]; 
    reg [ 1:0] TLBMAT1      [TLBNUM-1:0];
    reg        TLBD1        [TLBNUM-1:0];
    reg        TLBV1        [TLBNUM-1:0];

    wire [TLBNUM-1:0]       TwoChioseS0   ;
    wire [TLBNUM-1:0]       DateMatchS0   ;
    wire [TLBNUM-1:0]       TwoChioseS1   ;
    wire [TLBNUM-1:0]       DateMatchS1   ;
    wire [TLBNUM-1:0]       TwoChioseS2   ;
    wire [TLBNUM-1:0]       DateMatchS2   ;
    wire [TLBNUM-1:0]       DateMatchC0   ;
    //fror search 
    genvar i ;
    generate
        for (i =0 ;i< TLBNUM;i=i+1 ) begin
            assign TwoChioseS0[i] = (TLBPS[i] == 6'd12) ? S0OddPage : S0Vppn[8]; //0 mean odd 1 mean even
            assign DateMatchS0[i] = (TLBE[i] && (TLBPS[i] == 6'd12)) ? (TLBVPPN[i] == S0Vppn) : ((TLBVPPN[i][18:9] == S0Vppn[18:9]) && ((TLBASID[i] == S0Asid) || (TLBG)));
            assign TwoChioseS1[i] = (TLBPS[i] == 6'd12) ? S1OddPage : S1Vppn[8];
            assign DateMatchS1[i] = (TLBE[i] && (TLBPS[i] == 6'd12)) ? (TLBVPPN[i] == S1Vppn) : ((TLBVPPN[i][18:9] == S1Vppn[18:9]) && ((TLBASID[i] == S1Asid) || (TLBG)));
            assign TwoChioseS2[i] = (TLBPS[i] == 6'd12) ? S2OddPage : S2Vppn[8];
            assign DateMatchS2[i] = (TLBE[i] && (TLBPS[i] == 6'd12)) ? (TLBVPPN[i] == S2Vppn) : ((TLBVPPN[i][18:9] == S2Vppn[18:9]) && ((TLBASID[i] == S2Asid) || (TLBG)));
            assign DateMatchC0[i] = (TLBE[i] && (TLBPS[i] == 6'd12)) ? (TLBVPPN[i] == CsrSerchInfrom[18:0]) : ((TLBVPPN[i][18:9] == CsrSerchInfrom[18:9]) && ((TLBASID[i] == CsrSerchInfrom[28:19]) || (TLBG)));
        end
    endgenerate
    
    wire [$clog2(TLBNUM)-1:0] S0SearchIndex;
    wire [$clog2(TLBNUM)-1:0] S1SearchIndex;
    wire [$clog2(TLBNUM)-1:0] S2SearchIndex;
    wire [$clog2(TLBNUM)-1:0] C0SearchIndex;
    
    assign S0SearchIndex = ({6{DateMatchS0[0]}}  & 6'd0) | 
                           ({6{DateMatchS0[1]}}  & 6'd1) | 
                           ({6{DateMatchS0[2]}}  & 6'd2) | 
                           ({6{DateMatchS0[3]}}  & 6'd3) | 
                           ({6{DateMatchS0[4]}}  & 6'd4) | 
                           ({6{DateMatchS0[5]}}  & 6'd5) | 
                           ({6{DateMatchS0[6]}}  & 6'd6) | 
                           ({6{DateMatchS0[7]}}  & 6'd7) | 
                           ({6{DateMatchS0[8]}}  & 6'd8) | 
                           ({6{DateMatchS0[9]}}  & 6'd9) | 
                           ({6{DateMatchS0[10]}} & 6'd10)| 
                           ({6{DateMatchS0[11]}} & 6'd11)| 
                           ({6{DateMatchS0[12]}} & 6'd12)| 
                           ({6{DateMatchS0[13]}} & 6'd13)| 
                           ({6{DateMatchS0[14]}} & 6'd14)| 
                           ({6{DateMatchS0[15]}} & 6'd15)| 
                           ({6{DateMatchS0[16]}} & 6'd16)| 
                           ({6{DateMatchS0[17]}} & 6'd17)| 
                           ({6{DateMatchS0[18]}} & 6'd18)| 
                           ({6{DateMatchS0[19]}} & 6'd19)| 
                           ({6{DateMatchS0[20]}} & 6'd20)| 
                           ({6{DateMatchS0[21]}} & 6'd21)| 
                           ({6{DateMatchS0[22]}} & 6'd22)| 
                           ({6{DateMatchS0[23]}} & 6'd23)| 
                           ({6{DateMatchS0[24]}} & 6'd24)| 
                           ({6{DateMatchS0[25]}} & 6'd25)| 
                           ({6{DateMatchS0[26]}} & 6'd26)| 
                           ({6{DateMatchS0[27]}} & 6'd27)| 
                           ({6{DateMatchS0[28]}} & 6'd28)| 
                           ({6{DateMatchS0[29]}} & 6'd29)| 
                           ({6{DateMatchS0[30]}} & 6'd30)| 
                           ({6{DateMatchS0[31]}} & 6'd31)| 
                           ({6{DateMatchS0[32]}} & 6'd32)| 
                           ({6{DateMatchS0[33]}} & 6'd33)| 
                           ({6{DateMatchS0[34]}} & 6'd34)| 
                           ({6{DateMatchS0[35]}} & 6'd35)| 
                           ({6{DateMatchS0[36]}} & 6'd36)| 
                           ({6{DateMatchS0[37]}} & 6'd37)| 
                           ({6{DateMatchS0[38]}} & 6'd38)| 
                           ({6{DateMatchS0[39]}} & 6'd39)| 
                           ({6{DateMatchS0[40]}} & 6'd40)| 
                           ({6{DateMatchS0[41]}} & 6'd41)| 
                           ({6{DateMatchS0[42]}} & 6'd42)| 
                           ({6{DateMatchS0[43]}} & 6'd43)| 
                           ({6{DateMatchS0[44]}} & 6'd44)| 
                           ({6{DateMatchS0[45]}} & 6'd45)| 
                           ({6{DateMatchS0[46]}} & 6'd46)| 
                           ({6{DateMatchS0[47]}} & 6'd47)| 
                           ({6{DateMatchS0[48]}} & 6'd48)| 
                           ({6{DateMatchS0[49]}} & 6'd49)| 
                           ({6{DateMatchS0[50]}} & 6'd50)| 
                           ({6{DateMatchS0[51]}} & 6'd51)| 
                           ({6{DateMatchS0[52]}} & 6'd52)| 
                           ({6{DateMatchS0[53]}} & 6'd53)| 
                           ({6{DateMatchS0[54]}} & 6'd54)| 
                           ({6{DateMatchS0[55]}} & 6'd55)| 
                           ({6{DateMatchS0[56]}} & 6'd56)| 
                           ({6{DateMatchS0[57]}} & 6'd57)| 
                           ({6{DateMatchS0[58]}} & 6'd58)| 
                           ({6{DateMatchS0[59]}} & 6'd59)| 
                           ({6{DateMatchS0[60]}} & 6'd60)| 
                           ({6{DateMatchS0[61]}} & 6'd61)| 
                           ({6{DateMatchS0[62]}} & 6'd62)| 
                           ({6{DateMatchS0[63]}} & 6'd63); 

    assign S1SearchIndex = ({6{DateMatchS1[0]}}  & 6'd0) | 
                           ({6{DateMatchS1[1]}}  & 6'd1) | 
                           ({6{DateMatchS1[2]}}  & 6'd2) | 
                           ({6{DateMatchS1[3]}}  & 6'd3) | 
                           ({6{DateMatchS1[4]}}  & 6'd4) | 
                           ({6{DateMatchS1[5]}}  & 6'd5) | 
                           ({6{DateMatchS1[6]}}  & 6'd6) | 
                           ({6{DateMatchS1[7]}}  & 6'd7) | 
                           ({6{DateMatchS1[8]}}  & 6'd8) | 
                           ({6{DateMatchS1[9]}}  & 6'd9) | 
                           ({6{DateMatchS1[10]}} & 6'd10)| 
                           ({6{DateMatchS1[11]}} & 6'd11)| 
                           ({6{DateMatchS1[12]}} & 6'd12)| 
                           ({6{DateMatchS1[13]}} & 6'd13)| 
                           ({6{DateMatchS1[14]}} & 6'd14)| 
                           ({6{DateMatchS1[15]}} & 6'd15)| 
                           ({6{DateMatchS1[16]}} & 6'd16)| 
                           ({6{DateMatchS1[17]}} & 6'd17)| 
                           ({6{DateMatchS1[18]}} & 6'd18)| 
                           ({6{DateMatchS1[19]}} & 6'd19)| 
                           ({6{DateMatchS1[20]}} & 6'd20)| 
                           ({6{DateMatchS1[21]}} & 6'd21)| 
                           ({6{DateMatchS1[22]}} & 6'd22)| 
                           ({6{DateMatchS1[23]}} & 6'd23)| 
                           ({6{DateMatchS1[24]}} & 6'd24)| 
                           ({6{DateMatchS1[25]}} & 6'd25)| 
                           ({6{DateMatchS1[26]}} & 6'd26)| 
                           ({6{DateMatchS1[27]}} & 6'd27)| 
                           ({6{DateMatchS1[28]}} & 6'd28)| 
                           ({6{DateMatchS1[29]}} & 6'd29)| 
                           ({6{DateMatchS1[30]}} & 6'd30)| 
                           ({6{DateMatchS1[31]}} & 6'd31)| 
                           ({6{DateMatchS1[32]}} & 6'd32)| 
                           ({6{DateMatchS1[33]}} & 6'd33)| 
                           ({6{DateMatchS1[34]}} & 6'd34)| 
                           ({6{DateMatchS1[35]}} & 6'd35)| 
                           ({6{DateMatchS1[36]}} & 6'd36)| 
                           ({6{DateMatchS1[37]}} & 6'd37)| 
                           ({6{DateMatchS1[38]}} & 6'd38)| 
                           ({6{DateMatchS1[39]}} & 6'd39)| 
                           ({6{DateMatchS1[40]}} & 6'd40)| 
                           ({6{DateMatchS1[41]}} & 6'd41)| 
                           ({6{DateMatchS1[42]}} & 6'd42)| 
                           ({6{DateMatchS1[43]}} & 6'd43)| 
                           ({6{DateMatchS1[44]}} & 6'd44)| 
                           ({6{DateMatchS1[45]}} & 6'd45)| 
                           ({6{DateMatchS1[46]}} & 6'd46)| 
                           ({6{DateMatchS1[47]}} & 6'd47)| 
                           ({6{DateMatchS1[48]}} & 6'd48)| 
                           ({6{DateMatchS1[49]}} & 6'd49)| 
                           ({6{DateMatchS1[50]}} & 6'd50)| 
                           ({6{DateMatchS1[51]}} & 6'd51)| 
                           ({6{DateMatchS1[52]}} & 6'd52)| 
                           ({6{DateMatchS1[53]}} & 6'd53)| 
                           ({6{DateMatchS1[54]}} & 6'd54)| 
                           ({6{DateMatchS1[55]}} & 6'd55)| 
                           ({6{DateMatchS1[56]}} & 6'd56)| 
                           ({6{DateMatchS1[57]}} & 6'd57)| 
                           ({6{DateMatchS1[58]}} & 6'd58)| 
                           ({6{DateMatchS1[59]}} & 6'd59)| 
                           ({6{DateMatchS1[60]}} & 6'd60)| 
                           ({6{DateMatchS1[61]}} & 6'd61)| 
                           ({6{DateMatchS1[62]}} & 6'd62)| 
                           ({6{DateMatchS1[63]}} & 6'd63); 

    assign S2SearchIndex = ({6{DateMatchS2[0]}}  & 6'd0) | 
                           ({6{DateMatchS2[1]}}  & 6'd1) | 
                           ({6{DateMatchS2[2]}}  & 6'd2) | 
                           ({6{DateMatchS2[3]}}  & 6'd3) | 
                           ({6{DateMatchS2[4]}}  & 6'd4) | 
                           ({6{DateMatchS2[5]}}  & 6'd5) | 
                           ({6{DateMatchS2[6]}}  & 6'd6) | 
                           ({6{DateMatchS2[7]}}  & 6'd7) | 
                           ({6{DateMatchS2[8]}}  & 6'd8) | 
                           ({6{DateMatchS2[9]}}  & 6'd9) | 
                           ({6{DateMatchS2[10]}} & 6'd10)| 
                           ({6{DateMatchS2[11]}} & 6'd11)| 
                           ({6{DateMatchS2[12]}} & 6'd12)| 
                           ({6{DateMatchS2[13]}} & 6'd13)| 
                           ({6{DateMatchS2[14]}} & 6'd14)| 
                           ({6{DateMatchS2[15]}} & 6'd15)| 
                           ({6{DateMatchS2[16]}} & 6'd16)| 
                           ({6{DateMatchS2[17]}} & 6'd17)| 
                           ({6{DateMatchS2[18]}} & 6'd18)| 
                           ({6{DateMatchS2[19]}} & 6'd19)| 
                           ({6{DateMatchS2[20]}} & 6'd20)| 
                           ({6{DateMatchS2[21]}} & 6'd21)| 
                           ({6{DateMatchS2[22]}} & 6'd22)| 
                           ({6{DateMatchS2[23]}} & 6'd23)| 
                           ({6{DateMatchS2[24]}} & 6'd24)| 
                           ({6{DateMatchS2[25]}} & 6'd25)| 
                           ({6{DateMatchS2[26]}} & 6'd26)| 
                           ({6{DateMatchS2[27]}} & 6'd27)| 
                           ({6{DateMatchS2[28]}} & 6'd28)| 
                           ({6{DateMatchS2[29]}} & 6'd29)| 
                           ({6{DateMatchS2[30]}} & 6'd30)| 
                           ({6{DateMatchS2[31]}} & 6'd31)| 
                           ({6{DateMatchS2[32]}} & 6'd32)| 
                           ({6{DateMatchS2[33]}} & 6'd33)| 
                           ({6{DateMatchS2[34]}} & 6'd34)| 
                           ({6{DateMatchS2[35]}} & 6'd35)| 
                           ({6{DateMatchS2[36]}} & 6'd36)| 
                           ({6{DateMatchS2[37]}} & 6'd37)| 
                           ({6{DateMatchS2[38]}} & 6'd38)| 
                           ({6{DateMatchS2[39]}} & 6'd39)| 
                           ({6{DateMatchS2[40]}} & 6'd40)| 
                           ({6{DateMatchS2[41]}} & 6'd41)| 
                           ({6{DateMatchS2[42]}} & 6'd42)| 
                           ({6{DateMatchS2[43]}} & 6'd43)| 
                           ({6{DateMatchS2[44]}} & 6'd44)| 
                           ({6{DateMatchS2[45]}} & 6'd45)| 
                           ({6{DateMatchS2[46]}} & 6'd46)| 
                           ({6{DateMatchS2[47]}} & 6'd47)| 
                           ({6{DateMatchS2[48]}} & 6'd48)| 
                           ({6{DateMatchS2[49]}} & 6'd49)| 
                           ({6{DateMatchS2[50]}} & 6'd50)| 
                           ({6{DateMatchS2[51]}} & 6'd51)| 
                           ({6{DateMatchS2[52]}} & 6'd52)| 
                           ({6{DateMatchS2[53]}} & 6'd53)| 
                           ({6{DateMatchS2[54]}} & 6'd54)| 
                           ({6{DateMatchS2[55]}} & 6'd55)| 
                           ({6{DateMatchS2[56]}} & 6'd56)| 
                           ({6{DateMatchS2[57]}} & 6'd57)| 
                           ({6{DateMatchS2[58]}} & 6'd58)| 
                           ({6{DateMatchS2[59]}} & 6'd59)| 
                           ({6{DateMatchS2[60]}} & 6'd60)| 
                           ({6{DateMatchS2[61]}} & 6'd61)| 
                           ({6{DateMatchS2[62]}} & 6'd62)| 
                           ({6{DateMatchS2[63]}} & 6'd63); 

    assign C0SearchIndex=  ({6{DateMatchC0[0]}}  & 6'd0) | 
                           ({6{DateMatchC0[1]}}  & 6'd1) | 
                           ({6{DateMatchC0[2]}}  & 6'd2) | 
                           ({6{DateMatchC0[3]}}  & 6'd3) | 
                           ({6{DateMatchC0[4]}}  & 6'd4) | 
                           ({6{DateMatchC0[5]}}  & 6'd5) | 
                           ({6{DateMatchC0[6]}}  & 6'd6) | 
                           ({6{DateMatchC0[7]}}  & 6'd7) | 
                           ({6{DateMatchC0[8]}}  & 6'd8) | 
                           ({6{DateMatchC0[9]}}  & 6'd9) | 
                           ({6{DateMatchC0[10]}} & 6'd10)| 
                           ({6{DateMatchC0[11]}} & 6'd11)| 
                           ({6{DateMatchC0[12]}} & 6'd12)| 
                           ({6{DateMatchC0[13]}} & 6'd13)| 
                           ({6{DateMatchC0[14]}} & 6'd14)| 
                           ({6{DateMatchC0[15]}} & 6'd15)| 
                           ({6{DateMatchC0[16]}} & 6'd16)| 
                           ({6{DateMatchC0[17]}} & 6'd17)| 
                           ({6{DateMatchC0[18]}} & 6'd18)| 
                           ({6{DateMatchC0[19]}} & 6'd19)| 
                           ({6{DateMatchC0[20]}} & 6'd20)| 
                           ({6{DateMatchC0[21]}} & 6'd21)| 
                           ({6{DateMatchC0[22]}} & 6'd22)| 
                           ({6{DateMatchC0[23]}} & 6'd23)| 
                           ({6{DateMatchC0[24]}} & 6'd24)| 
                           ({6{DateMatchC0[25]}} & 6'd25)| 
                           ({6{DateMatchC0[26]}} & 6'd26)| 
                           ({6{DateMatchC0[27]}} & 6'd27)| 
                           ({6{DateMatchC0[28]}} & 6'd28)| 
                           ({6{DateMatchC0[29]}} & 6'd29)| 
                           ({6{DateMatchC0[30]}} & 6'd30)| 
                           ({6{DateMatchC0[31]}} & 6'd31)| 
                           ({6{DateMatchC0[32]}} & 6'd32)| 
                           ({6{DateMatchC0[33]}} & 6'd33)| 
                           ({6{DateMatchC0[34]}} & 6'd34)| 
                           ({6{DateMatchC0[35]}} & 6'd35)| 
                           ({6{DateMatchC0[36]}} & 6'd36)| 
                           ({6{DateMatchC0[37]}} & 6'd37)| 
                           ({6{DateMatchC0[38]}} & 6'd38)| 
                           ({6{DateMatchC0[39]}} & 6'd39)| 
                           ({6{DateMatchC0[40]}} & 6'd40)| 
                           ({6{DateMatchC0[41]}} & 6'd41)| 
                           ({6{DateMatchC0[42]}} & 6'd42)| 
                           ({6{DateMatchC0[43]}} & 6'd43)| 
                           ({6{DateMatchC0[44]}} & 6'd44)| 
                           ({6{DateMatchC0[45]}} & 6'd45)| 
                           ({6{DateMatchC0[46]}} & 6'd46)| 
                           ({6{DateMatchC0[47]}} & 6'd47)| 
                           ({6{DateMatchC0[48]}} & 6'd48)| 
                           ({6{DateMatchC0[49]}} & 6'd49)| 
                           ({6{DateMatchC0[50]}} & 6'd50)| 
                           ({6{DateMatchC0[51]}} & 6'd51)| 
                           ({6{DateMatchC0[52]}} & 6'd52)| 
                           ({6{DateMatchC0[53]}} & 6'd53)| 
                           ({6{DateMatchC0[54]}} & 6'd54)| 
                           ({6{DateMatchC0[55]}} & 6'd55)| 
                           ({6{DateMatchC0[56]}} & 6'd56)| 
                           ({6{DateMatchC0[57]}} & 6'd57)| 
                           ({6{DateMatchC0[58]}} & 6'd58)| 
                           ({6{DateMatchC0[59]}} & 6'd59)| 
                           ({6{DateMatchC0[60]}} & 6'd60)| 
                           ({6{DateMatchC0[61]}} & 6'd61)| 
                           ({6{DateMatchC0[62]}} & 6'd62)| 
                           ({6{DateMatchC0[63]}} & 6'd63); 

    assign   CsrSerchSucces = | C0SearchIndex ;
    assign   csrSerchDate   = C0SearchIndex   ;

    assign   S0Fund       = | DateMatchS0         ;
    //assign   S0Index      = S0SearchIndex        ;    
    assign   S0Ps         = TLBPS[S0SearchIndex] ;
    assign   S0Ppn        = TwoChioseS0[S0SearchIndex] ? TLBPPN1 : TLBPPN0 ;
    assign   S0V          = TwoChioseS0[S0SearchIndex] ? TLBV1   : TLBV0   ;
    assign   S0D          = TwoChioseS0[S0SearchIndex] ? TLBD1   : TLBD0   ;
    assign   S0Mat        = TwoChioseS0[S0SearchIndex] ? TLBMAT1 : TLBMAT0 ;
    assign   S0Plv        = TwoChioseS0[S0SearchIndex] ? TLBPLV1 : TLBPLV0 ;
    assign   S1Fund       = |DateMatchS1         ;
    //assign   S1Index      = S1SearchIndex        ;    
    assign   S1Ps         = TLBPS[S1SearchIndex] ;
    assign   S1Ppn        = TwoChioseS1[S1SearchIndex] ? TLBPPN1 : TLBPPN0 ;
    assign   S1V          = TwoChioseS1[S1SearchIndex] ? TLBV1   : TLBV0   ;
    assign   S1D          = TwoChioseS1[S1SearchIndex] ? TLBD1   : TLBD0   ;
    assign   S1Mat        = TwoChioseS1[S1SearchIndex] ? TLBMAT1 : TLBMAT0 ;
    assign   S1Plv        = TwoChioseS1[S1SearchIndex] ? TLBPLV1 : TLBPLV0 ;

    assign   S2Fund       = |DateMatchS2         ;
    //assign   S2Index      = S1SearchIndex        ;    
    assign   S2Ps         = TLBPS[S2SearchIndex] ;
    assign   S2Ppn        = TwoChioseS2[S2SearchIndex] ? TLBPPN1 : TLBPPN0 ;
    assign   S2V          = TwoChioseS2[S2SearchIndex] ? TLBV1   : TLBV0   ;
    assign   S2D          = TwoChioseS2[S2SearchIndex] ? TLBD1   : TLBD0   ;
    assign   S2Mat        = TwoChioseS2[S2SearchIndex] ? TLBMAT1 : TLBMAT0 ;
    assign   S2Plv        = TwoChioseS2[S2SearchIndex] ? TLBPLV1 : TLBPLV0 ;

    assign   RVppn        = TLBVPPN[RIndex]      ;        
    assign   RAsid        = TLBASID[RIndex]      ;
    assign   RG           = TLBG[RIndex]         ;
    assign   RPs          = TLBPS[RIndex]        ;
    assign   RE           = TLBE[RIndex]         ;
    assign   RV0          = TLBV0[RIndex]        ;
    assign   RD0          = TLBD0[RIndex]        ;
    assign   RMat0        = TLBMAT0[RIndex]      ;
    assign   RPlv0        = TLBPLV0[RIndex]      ;
    assign   RPpn0        = TLBPPN0[RIndex]      ;
    assign   RV1          = TLBV1[RIndex]        ;
    assign   RD1          = TLBD1[RIndex]        ;
    assign   RMat1        = TLBMAT1[RIndex]      ;
    assign   RPlv1        = TLBPLV1[RIndex]      ;
    assign   RPpn1        = TLBPPN1[RIndex]      ;

    integer a ;
    integer b ;
    always @(posedge Clk) begin
        if(!Rest)
            for (a =0 ;a < TLBNUM ;a=a+1 ) begin
                TLBVPPN[a] <= 19'd0 ;
                TLBE[a]    <= 1'd0  ;
                TLBASID[a] <= 10'd0 ;
                TLBG[a]    <= 1'd0  ;
                TLBPS[a]   <= 6'd0  ;
                TLBPPN0[a] <= 20'd0 ;
                TLBPLV0[a] <= 2'd0  ;
                TLBMAT0[a] <= 2'd0  ;
                TLBD0[a]   <= 1'd0  ;
                TLBV0[a]   <= 1'd0  ;
                TLBPPN1[a] <= 20'd0 ;
                TLBPLV1[a] <= 2'd0  ; 
                TLBMAT1[a] <= 2'd0  ;
                TLBD1[a]   <= 1'd0  ;
                TLBV1[a]   <= 1'd0  ;  
            end
            else if(We) begin
                TLBVPPN[WIndex] <= WVppn ;
                TLBE[WIndex]    <= WE    ;
                TLBASID[WIndex] <= WAsid ;
                TLBG[WIndex]    <= WG    ;
                TLBPS[WIndex]   <= WPs   ;
                TLBPPN0[WIndex] <= WPpn0 ;
                TLBPLV0[WIndex] <= WPlv0 ;
                TLBMAT0[WIndex] <= WMat0 ;
                TLBD0[WIndex]   <= WD0   ;
                TLBV0[WIndex]   <= WV0   ;
                TLBPPN1[WIndex] <= WPpn1 ;
                TLBPLV1[WIndex] <= WPlv1 ; 
                TLBMAT1[WIndex] <= WMat1 ;
                TLBD1[WIndex]   <= WD1   ;
                TLBV1[WIndex]   <= WV1   ; 
            end
            else if(InvEn)begin
                for (b =0 ;b < TLBNUM ;b=b+1 ) begin
                    if((InvOp == 0) || (InvOp == 1)) begin
                        TLBE[b] <= 1'd0  ;
                    end 
                    if(InvOp == 2) begin
                        TLBE[b] <= TLBG[b] ? `EnableValue : TLBE[b] ; 
                    end
                    if(InvOp == 3) begin
                        TLBE[b] <= ~TLBG[b] ? `EnableValue : TLBE[b] ; 
                    end
                    if(InvOp == 4) begin
                        TLBE[b] <= (~TLBG[b] && (TLBASID[b] == InvAsid)) ? `EnableValue :  TLBE[b] ;
                    end
                    if(InvOp == 5) begin
                        TLBE[b] <= (~TLBG[b] && (TLBASID[b] == InvAsid) && (TLBVPPN[b] == InvVppn)) ? `EnableValue :  TLBE[b] ;
                    end
                    if(InvOp == 6) begin
                        TLBE[b] <= (TLBG[b] && (TLBASID[b] == InvAsid) && (TLBVPPN[b] == InvVppn)) ? `EnableValue :  TLBE[b] ;
                    end
                end
            end
    end
  
endmodule
`timescale 1ps/1ps
`include "../define.v"

module BusyTable (
    input       wire                                 Clk             ,
    input       wire                                 Rest            ,
    //for ctrl  
    input       wire                                 BusyStop        ,
    input       wire                                 BusyFlash       ,
    //from delay weak-up and physical 
    input       wire                                 UnBusyAble1     ,
    input       wire      [`ReNameRegBUs]            UnBusyAddr1     ,    
    input       wire                                 UnBusyAble2     ,
    input       wire      [`ReNameRegBUs]            UnBusyAddr2     ,   
    input       wire                                 UnBusyAble3     ,
    input       wire      [`ReNameRegBUs]            UnBusyAddr3     ,   
    input       wire                                 UnBusyAble4     ,
    input       wire      [`ReNameRegBUs]            UnBusyAddr4     ,                               
    input       wire                                 UnBusyAble5     ,
    input       wire      [`ReNameRegBUs]            UnBusyAddr5     ,   
    input       wire                                 UnBusyAble6     ,
    input       wire      [`ReNameRegBUs]            UnBusyAddr6     ,  
    input       wire                                 UnBusyAble7     ,
    input       wire      [`ReNameRegBUs]            UnBusyAddr7     ,  
    //from RAT
    input       wire                                 BIn1Src1Able     ,
    input       wire                                 BIn1Src1NoDate   ,
    input       wire     [`ReNameRegBUs]             BIn1Src1Addr     ,
    input       wire                                 BIn1Src2Able     ,
    input       wire                                 BIn1Src2NoDate   ,
    input       wire     [`ReNameRegBUs]             BIn1Src2Addr     ,
    input       wire                                 BIn1RdAble       ,
    input       wire     [`ReNameRegBUs]             BIn1RdAddr       ,
    input       wire                                 BIn2Src1Able     ,
    input       wire                                 BIn2Src1NoDate   ,
    input       wire     [`ReNameRegBUs]             BIn2Src1Addr     ,
    input       wire                                 BIn2Src2Able     ,
    input       wire                                 BIn2Src2NoDate   ,
    input       wire     [`ReNameRegBUs]             BIn2Src2Addr     ,
    input       wire                                 BIn2RdAble       ,
    input       wire     [`ReNameRegBUs]             BIn2RdAddr       ,
    input       wire                                 BIn3Src1Able     ,
    input       wire                                 BIn3Src1NoDate   ,
    input       wire     [`ReNameRegBUs]             BIn3Src1Addr     ,
    input       wire                                 BIn3Src2Able     ,
    input       wire                                 BIn3Src2NoDate   ,
    input       wire     [`ReNameRegBUs]             BIn3Src2Addr     ,
    input       wire                                 BIn3RdAble       ,
    input       wire     [`ReNameRegBUs]             BIn3RdAddr       ,
    input       wire                                 BIn4Src1Able     ,
    input       wire                                 BIn4Src1NoDate   ,
    input       wire     [`ReNameRegBUs]             BIn4Src1Addr     ,
    input       wire                                 BIn4Src2Able     ,
    input       wire                                 BIn4Src2NoDate   ,
    input       wire     [`ReNameRegBUs]             BIn4Src2Addr     ,
    input       wire                                 BIn4RdAble       ,
    input       wire     [`ReNameRegBUs]             BIn4RdAddr       ,
    //to IssueQueue
    output       wire                                BOut1Src1Able     ,
    output       wire                                Bout1Src1Ready    ,
    output       wire     [`ReNameRegBUs]            BOut1Src1Addr     ,
    output       wire                                BOut1Src2Able     ,
    output       wire                                Bout1Src2Ready    ,
    output       wire     [`ReNameRegBUs]            BOut1Src2Addr     ,
    output       wire                                BOut1RdAble       ,
    output       wire     [`ReNameRegBUs]            BOut1RdAddr       ,
    output       wire                                BOut2Src1Able     ,
    output       wire                                Bout2Src1Ready    ,
    output       wire     [`ReNameRegBUs]            BOut2Src1Addr     ,
    output       wire                                BOut2Src2Able     ,
    output       wire                                Bout2Src2Ready    ,
    output       wire     [`ReNameRegBUs]            BOut2Src2Addr     ,
    output       wire                                BOut2RdAble       ,
    output       wire     [`ReNameRegBUs]            BOut2RdAddr       ,
    output       wire                                BOut3Src1Able     ,
    output       wire                                Bout3Src1Ready    ,
    output       wire     [`ReNameRegBUs]            BOut3Src1Addr     ,
    output       wire                                BOut3Src2Able     ,
    output       wire                                Bout3Src2Ready    ,
    output       wire     [`ReNameRegBUs]            BOut3Src2Addr     ,
    output       wire                                BOut3RdAble       ,
    output       wire     [`ReNameRegBUs]            BOut3RdAddr       ,
    output       wire                                BOut4Src1Able     ,
    output       wire                                Bout4Src1Ready    ,
    output       wire     [`ReNameRegBUs]            BOut4Src1Addr     ,
    output       wire                                BOut4Src2Able     ,
    output       wire                                Bout4Src2Ready    ,
    output       wire     [`ReNameRegBUs]            BOut4Src2Addr     ,
    output       wire                                BOut4RdAble       ,
    output       wire     [`ReNameRegBUs]            BOut4RdAddr       
);

    reg              BusyTableSign  [0:127] ;

    integer i ;
    integer j ;
    integer k ;
    integer y ;
    always @(posedge Clk) begin
        if(!Rest) begin
            for (i =0 ;i<32 ;i=i+1 ) begin
                BusyTableSign[i] <= `EnableValue ;
            end
            for (j =32 ;j<64 ;j=j+1 ) begin
                BusyTableSign[j] <= `EnableValue ;
            end
            for (k =64 ;k<96 ;k=k+1 ) begin
                BusyTableSign[k] <= `EnableValue ;
            end
            for (y =96 ;y<128 ;y=y+1 ) begin
                BusyTableSign[y] <= `EnableValue ;
            end
        end 
        if(BusyFlash) begin
            for (i =0 ;i<32 ;i=i+1 ) begin
                BusyTableSign[i] <= `EnableValue ;
            end
            for (j =32 ;j<64 ;j=j+1 ) begin
                BusyTableSign[j] <= `EnableValue ;
            end
            for (k =64 ;k<96 ;k=k+1 ) begin
                BusyTableSign[k] <= `EnableValue ;
            end
            for (y =96 ;y<128 ;y=y+1 ) begin
                BusyTableSign[y] <= `EnableValue ;
            end
        end
        else begin
            BusyTableSign[BIn1RdAddr] <= BIn1RdAble ? `AbleValue : `EnableValue ;
            BusyTableSign[BIn2RdAddr] <= BIn2RdAble ? `AbleValue : `EnableValue ;
            BusyTableSign[BIn3RdAddr] <= BIn3RdAble ? `AbleValue : `EnableValue ;
            BusyTableSign[BIn4RdAddr] <= BIn4RdAble ? `AbleValue : `EnableValue ;
            BusyTableSign[UnBusyAddr1] <= UnBusyAble1 ? `EnableValue : BusyTableSign[UnBusyAddr1] ;
            BusyTableSign[UnBusyAddr2] <= UnBusyAble2 ? `EnableValue : BusyTableSign[UnBusyAddr2] ;
            BusyTableSign[UnBusyAddr3] <= UnBusyAble3 ? `EnableValue : BusyTableSign[UnBusyAddr3] ;
            BusyTableSign[UnBusyAddr4] <= UnBusyAble4 ? `EnableValue : BusyTableSign[UnBusyAddr4] ;
            BusyTableSign[UnBusyAddr5] <= UnBusyAble5 ? `EnableValue : BusyTableSign[UnBusyAddr5] ;
            BusyTableSign[UnBusyAddr6] <= UnBusyAble6 ? `EnableValue : BusyTableSign[UnBusyAddr6] ;
            BusyTableSign[UnBusyAddr7] <= UnBusyAble7 ? `EnableValue : BusyTableSign[UnBusyAddr7] ;
        end
    end

    assign BOut1Src1Able  = ~BusyStop ? BIn1Src1Able : `EnableValue ;
    assign BOut1Src1Addr  = BIn1Src1Addr  ;
    assign Bout1Src1Ready = ~BIn1Src1NoDate ?(((~BusyTableSign[BIn1Src1Addr])| 
                            ((BIn1Src1Addr == UnBusyAddr1)&UnBusyAble1)|
                            ((BIn1Src1Addr == UnBusyAddr2)&UnBusyAble2)|
                            ((BIn1Src1Addr == UnBusyAddr3)&UnBusyAble3)| 
                            ((BIn1Src1Addr == UnBusyAddr4)&UnBusyAble4)|
                            ((BIn1Src1Addr == UnBusyAddr5)&UnBusyAble5)|
                            ((BIn1Src1Addr == UnBusyAddr6)&UnBusyAble6)|
                            ((BIn1Src1Addr == UnBusyAddr7)&UnBusyAble7)) ? `AbleValue : `EnableValue) : `EnableValue ;
    
    assign BOut1Src2Able  = ~BusyStop ? BIn1Src2Able : `EnableValue ;
    assign BOut1Src2Addr  = BIn1Src2Addr  ;
    assign Bout1Src2Ready = ~BIn1Src2NoDate ? (((~BusyTableSign[BIn1Src2Addr])| 
                            ((BIn1Src2Addr == UnBusyAddr1)&UnBusyAble1)|
                            ((BIn1Src2Addr == UnBusyAddr2)&UnBusyAble2)|
                            ((BIn1Src2Addr == UnBusyAddr3)&UnBusyAble3)| 
                            ((BIn1Src2Addr == UnBusyAddr4)&UnBusyAble4)|
                            ((BIn1Src2Addr == UnBusyAddr5)&UnBusyAble5)|
                            ((BIn1Src2Addr == UnBusyAddr6)&UnBusyAble6)|
                            ((BIn1Src2Addr == UnBusyAddr7)&UnBusyAble7)) ? `AbleValue : `EnableValue) : `EnableValue ;
                        
    assign BOut1RdAble    = ~BusyStop ? BIn1RdAble : `EnableValue ;
    assign BOut1RdAddr    = BIn1RdAddr ;


    assign BOut2Src1Able  = ~BusyStop ? BIn2Src1Able : `EnableValue ;
    assign BOut2Src1Addr  = BIn2Src1Addr  ;
    assign Bout2Src1Ready = ~BIn2Src1NoDate ? (((~BusyTableSign[BIn2Src1Addr])| 
                            ((BIn2Src1Addr == UnBusyAddr1)&UnBusyAble1)|
                            ((BIn2Src1Addr == UnBusyAddr2)&UnBusyAble2)|
                            ((BIn2Src1Addr == UnBusyAddr3)&UnBusyAble3)| 
                            ((BIn2Src1Addr == UnBusyAddr4)&UnBusyAble4)|
                            ((BIn2Src1Addr == UnBusyAddr5)&UnBusyAble5)|
                            ((BIn2Src1Addr == UnBusyAddr6)&UnBusyAble6)|
                            ((BIn2Src1Addr == UnBusyAddr7)&UnBusyAble7)) ? `AbleValue : `EnableValue) : `EnableValue ;

    assign BOut2Src2Able  = ~BusyStop ? BIn2Src2Able : `EnableValue ;
    assign BOut2Src2Addr  = BIn2Src2Addr  ;
    assign Bout2Src2Ready = ~BIn2Src2NoDate ? (((~BusyTableSign[BIn2Src2Addr])| 
                            ((BIn2Src2Addr == UnBusyAddr1)&UnBusyAble1)|
                            ((BIn2Src2Addr == UnBusyAddr2)&UnBusyAble2)|
                            ((BIn2Src2Addr == UnBusyAddr3)&UnBusyAble3)| 
                            ((BIn2Src2Addr == UnBusyAddr4)&UnBusyAble4)|
                            ((BIn2Src2Addr == UnBusyAddr5)&UnBusyAble5)|
                            ((BIn2Src2Addr == UnBusyAddr6)&UnBusyAble6)|
                            ((BIn2Src2Addr == UnBusyAddr7)&UnBusyAble7)) ? `AbleValue : `EnableValue) : `EnableValue ;

    assign BOut2RdAble    = ~BusyStop ? BIn2RdAble : `EnableValue ;
    assign BOut2RdAddr    = BIn2RdAddr ;

    assign BOut3Src1Able  = ~BusyStop ? BIn3Src1Able : `EnableValue ;
    assign BOut3Src1Addr  = BIn3Src1Addr  ;
    assign Bout3Src1Ready = ~BIn3Src1NoDate ? ((~BusyTableSign[BIn3Src1Addr]| 
                            ((BIn3Src1Addr == UnBusyAddr1)&UnBusyAble1)|
                            ((BIn3Src1Addr == UnBusyAddr2)&UnBusyAble2)|
                            ((BIn3Src1Addr == UnBusyAddr3)&UnBusyAble3)| 
                            ((BIn3Src1Addr == UnBusyAddr4)&UnBusyAble4)|
                            ((BIn3Src1Addr == UnBusyAddr5)&UnBusyAble5)|
                            ((BIn3Src1Addr == UnBusyAddr6)&UnBusyAble6)|
                            ((BIn3Src1Addr == UnBusyAddr7)&UnBusyAble7)) ? `AbleValue : `EnableValue) : `EnableValue ;

    assign BOut3Src2Able  = ~BusyStop ? BIn3Src2Able : `EnableValue ;
    assign BOut3Src2Addr  = BIn3Src2Addr  ;
    assign Bout3Src2Ready = ~BIn3Src2NoDate ? ((~BusyTableSign[BIn3Src2Addr]| 
                            ((BIn3Src2Addr == UnBusyAddr1)&UnBusyAble1)|
                            ((BIn3Src2Addr == UnBusyAddr2)&UnBusyAble2)|
                            ((BIn3Src2Addr == UnBusyAddr3)&UnBusyAble3)| 
                            ((BIn3Src2Addr == UnBusyAddr4)&UnBusyAble4)|
                            ((BIn3Src2Addr == UnBusyAddr5)&UnBusyAble5)|
                            ((BIn3Src2Addr == UnBusyAddr6)&UnBusyAble6)|
                            ((BIn3Src2Addr == UnBusyAddr7)&UnBusyAble7)) ? `AbleValue : `EnableValue) : `EnableValue ;

    assign BOut3RdAble    = ~BusyStop ? BIn3RdAble : `EnableValue ;
    assign BOut3RdAddr    = BIn3RdAddr ;

    assign BOut4Src1Able  = ~BusyStop ? BIn4Src1Able : `EnableValue ;
    assign BOut4Src1Addr  = BIn4Src1Addr  ;
    assign Bout4Src1Ready = ~BIn4Src1NoDate ? (((~BusyTableSign[BIn4Src1Addr]| 
                            ((BIn4Src1Addr == UnBusyAddr1)&UnBusyAble1)|
                            ((BIn4Src1Addr == UnBusyAddr2)&UnBusyAble2)|
                            ((BIn4Src1Addr == UnBusyAddr3)&UnBusyAble3)| 
                            ((BIn4Src1Addr == UnBusyAddr4)&UnBusyAble4)|
                            ((BIn4Src1Addr == UnBusyAddr5)&UnBusyAble5)|
                            ((BIn4Src1Addr == UnBusyAddr6)&UnBusyAble6)|
                            ((BIn4Src1Addr == UnBusyAddr7)&UnBusyAble7))) ? `AbleValue : `EnableValue) : `EnableValue ;

    assign BOut4Src2Able  = ~BusyStop ? BIn4Src2Able : `EnableValue ;
    assign BOut4Src2Addr  = BIn4Src2Addr  ;
    assign Bout4Src2Ready = ~BIn4Src2NoDate ? ((~BusyTableSign[BIn4Src2Addr]| 
                            ((BIn4Src2Addr == UnBusyAddr1)&UnBusyAble1)|
                            ((BIn4Src2Addr == UnBusyAddr2)&UnBusyAble2)|
                            ((BIn4Src2Addr == UnBusyAddr3)&UnBusyAble3)| 
                            ((BIn4Src2Addr == UnBusyAddr4)&UnBusyAble4)|
                            ((BIn4Src2Addr == UnBusyAddr5)&UnBusyAble5)|
                            ((BIn4Src2Addr == UnBusyAddr6)&UnBusyAble6)|
                            ((BIn4Src2Addr == UnBusyAddr7)&UnBusyAble7)) ? `AbleValue : `EnableValue) : `EnableValue ;

    assign BOut4RdAble    = ~BusyStop ? BIn4RdAble : `EnableValue ;
    assign BOut4RdAddr    = BIn4RdAddr ;

endmodule
`timescale 1ps/1ps
`include "../define"

module CriqFreelist1 #(
    parameter CRIQWIDE = 7  ,
    parameter CRIQDEEP = 32 ,
    parameter PTRWIDE  = 6 
) (
    input         wire                            Clk           ,
    input         wire                            Rest          ,

    input         wire                            Rable         ,
    //output        wire       [CRIQWIDE-1:0]       Dout          , //23 wide

    output        wire       [CRIQWIDE-1:0]       CriqPreOut    ,

    input         wire                            Wable         ,
    input         wire       [CRIQWIDE-1:0]       Din           ,

    input         wire                            CriqClean     ,

    //output        wire                            CriqFull      ,
    output        wire                            CriqEmpty     
);

    reg   [CRIQWIDE-1:0] CRIQREG [0:CRIQDEEP]  ;
    reg   [PTRWIDE-1:0]     Criqfront          ;
    reg   [PTRWIDE-1:0]     Criqtril           ;

    always @(posedge Clk) begin
        if(!Rest) begin
            Criqfront <= 23;
            CRIQREG[0] <= 32 ;
            CRIQREG[1] <= 36 ;
            CRIQREG[2] <= 40 ;
            CRIQREG[3] <= 44 ;
            CRIQREG[4] <= 48 ;
            CRIQREG[5] <= 52 ;
            CRIQREG[6] <= 56 ;
            CRIQREG[7] <= 70 ;
            CRIQREG[8] <= 64 ;
            CRIQREG[9] <= 68 ;
            CRIQREG[10] <= 72 ;
            CRIQREG[11] <= 76 ;
            CRIQREG[12] <= 80 ;
            CRIQREG[13] <= 84 ;
            CRIQREG[14] <= 88 ;
            CRIQREG[15] <= 92 ;
            CRIQREG[16] <= 96 ;
            CRIQREG[17] <= 100 ;
            CRIQREG[18] <= 104 ;
            CRIQREG[19] <= 108 ;
            CRIQREG[20] <= 112 ;
            CRIQREG[21] <= 116 ;
            CRIQREG[22] <= 120 ;
            CRIQREG[23] <= 124 ;
            CRIQREG[24] <= 0 ;
            CRIQREG[25] <= 0 ;
            CRIQREG[26] <= 0 ;
            CRIQREG[27] <= 0 ;
            CRIQREG[28] <= 0 ;
            CRIQREG[29] <= 0 ;
            CRIQREG[30] <= 0 ;
            CRIQREG[31] <= 0 ;
        end
        else begin
            if(Wable) begin
                Criqfront <= (Criqfront == 32) ? 0 : Criqfront + 1 ;
                CRIQREG[Criqfront] <= Din ;
            end 
            if(CriqClean) begin
                Criqfront <= 23;
                CRIQREG[0] <= 32 ;
                CRIQREG[1] <= 36 ;
                CRIQREG[2] <= 40 ;
                CRIQREG[3] <= 44 ;
                CRIQREG[4] <= 48 ;
                CRIQREG[5] <= 52 ;
                CRIQREG[6] <= 56 ;
                CRIQREG[7] <= 70 ;
                CRIQREG[8] <= 64 ;
                CRIQREG[9] <= 68 ;
                CRIQREG[10] <= 72 ;
                CRIQREG[11] <= 76 ;
                CRIQREG[12] <= 80 ;
                CRIQREG[13] <= 84 ;
                CRIQREG[14] <= 88 ;
                CRIQREG[15] <= 92 ;
                CRIQREG[16] <= 96 ;
                CRIQREG[17] <= 100 ;
                CRIQREG[18] <= 104 ;
                CRIQREG[19] <= 108 ;
                CRIQREG[20] <= 112 ;
                CRIQREG[21] <= 116 ;
                CRIQREG[22] <= 120 ;
                CRIQREG[23] <= 124 ;
                CRIQREG[24] <= 0 ;
                CRIQREG[25] <= 0 ;
                CRIQREG[26] <= 0 ;
                CRIQREG[27] <= 0 ;
                CRIQREG[28] <= 0 ;
                CRIQREG[29] <= 0 ;
                CRIQREG[30] <= 0 ;
                CRIQREG[31] <= 0 ;
            end
        end
    end

    //reg  [CRIQWIDE-1:0]  CriqOutReg  ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Criqtril <= {PTRWIDE{1'b0}} ;
            //CriqOutReg <= {CRIQWIDE{1'b0}};
        end 
        else begin
            if(Rable) begin
                //CriqOutReg <= CRIQREG[Criqtril] ;
                Criqtril <= Criqtril - 1 ;
            end
            if(CriqClean)
                Criqtril <= 0 ;
        end
    end

    //assign Dout       = CriqOutReg              ;
    //assign CriqFull   = (((Criqtril - Criqfront) == 1) || ((Criqtril == 0) && (Criqfront == CRIQDEEP))) ;
    assign CriqEmpty  = (Criqtril == Criqfront) ;
    assign CriqPreOut = CRIQREG[Criqtril]       ; 

endmodule
`timescale 1ps/1ps
`include "../define"

module CriqFreelist2 #(
    parameter CRIQWIDE = 7  ,
    parameter CRIQDEEP = 32 ,
    parameter PTRWIDE  = 6 
) (
    input         wire                            Clk           ,
    input         wire                            Rest          ,

    input         wire                            Rable         ,
    //output        wire       [CRIQWIDE-1:0]       Dout          , //23 wide

    output        wire       [CRIQWIDE-1:0]       CriqPreOut    ,

    input         wire                            Wable         ,
    input         wire       [CRIQWIDE-1:0]       Din           ,

    input         wire                            CriqClean     ,

    //output        wire                            CriqFull      ,
    output        wire                            CriqEmpty     
);

    reg   [CRIQWIDE-1:0] CRIQREG [0:CRIQDEEP]  ;
    reg   [PTRWIDE-1:0]     Criqfront          ;
    reg   [PTRWIDE-1:0]     Criqtril           ;

    always @(posedge Clk) begin
        if(!Rest) begin
            Criqfront <= 23;
            CRIQREG[0] <= 33 ;
            CRIQREG[1] <= 37 ;
            CRIQREG[2] <= 41 ;
            CRIQREG[3] <= 45 ;
            CRIQREG[4] <= 49 ;
            CRIQREG[5] <= 53 ;
            CRIQREG[6] <= 57 ;
            CRIQREG[7] <= 61 ;
            CRIQREG[8] <= 65 ;
            CRIQREG[9] <= 69 ;
            CRIQREG[10] <= 73 ;
            CRIQREG[11] <= 77 ;
            CRIQREG[12] <= 81 ;
            CRIQREG[13] <= 85 ;
            CRIQREG[14] <= 89 ;
            CRIQREG[15] <= 93 ;
            CRIQREG[16] <= 97 ;
            CRIQREG[17] <= 101 ;
            CRIQREG[18] <= 105 ;
            CRIQREG[19] <= 109 ;
            CRIQREG[20] <= 113 ;
            CRIQREG[21] <= 117 ;
            CRIQREG[22] <= 121 ;
            CRIQREG[23] <= 125 ;
            CRIQREG[24] <= 0 ;
            CRIQREG[25] <= 0 ;
            CRIQREG[26] <= 0 ;
            CRIQREG[27] <= 0 ;
            CRIQREG[28] <= 0 ;
            CRIQREG[29] <= 0 ;
            CRIQREG[30] <= 0 ;
            CRIQREG[31] <= 0 ;
        end
        else begin
            if(Wable) begin
                Criqfront <= (Criqfront == 32) ? 0 : Criqfront + 1 ;
                CRIQREG[Criqfront] <= Din ;
            end 
            if(CriqClean) begin
                Criqfront <= 23;
                CRIQREG[0] <= 33 ;
                CRIQREG[1] <= 37 ;
                CRIQREG[2] <= 41 ;
                CRIQREG[3] <= 45 ;
                CRIQREG[4] <= 49 ;
                CRIQREG[5] <= 53 ;
                CRIQREG[6] <= 57 ;
                CRIQREG[7] <= 61 ;
                CRIQREG[8] <= 65 ;
                CRIQREG[9] <= 69 ;
                CRIQREG[10] <= 73 ;
                CRIQREG[11] <= 77 ;
                CRIQREG[12] <= 81 ;
                CRIQREG[13] <= 85 ;
                CRIQREG[14] <= 89 ;
                CRIQREG[15] <= 93 ;
                CRIQREG[16] <= 97 ;
                CRIQREG[17] <= 101 ;
                CRIQREG[18] <= 105 ;
                CRIQREG[19] <= 109 ;
                CRIQREG[20] <= 113 ;
                CRIQREG[21] <= 117 ;
                CRIQREG[22] <= 121 ;
                CRIQREG[23] <= 125 ;
                CRIQREG[24] <= 0 ;
                CRIQREG[25] <= 0 ;
                CRIQREG[26] <= 0 ;
                CRIQREG[27] <= 0 ;
                CRIQREG[28] <= 0 ;
                CRIQREG[29] <= 0 ;
                CRIQREG[30] <= 0 ;
                CRIQREG[31] <= 0 ;
            end
        end
    end

    //reg  [CRIQWIDE-1:0]  CriqOutReg  ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Criqtril <= {PTRWIDE{1'b0}} ;
            //CriqOutReg <= {CRIQWIDE{1'b0}};
        end 
        else begin
            if(Rable) begin
                //CriqOutReg <= CRIQREG[Criqtril] ;
                Criqtril <= Criqtril - 1 ;
            end
            if(CriqClean)
                Criqtril <= 0 ;
        end
    end

    //assign Dout       = CriqOutReg              ;
    //assign CriqFull   = (((Criqtril - Criqfront) == 1) || ((Criqtril == 0) && (Criqfront == CRIQDEEP))) ;
    assign CriqEmpty  = (Criqtril == Criqfront) ;
    assign CriqPreOut = CRIQREG[Criqtril]       ; 

endmodule
`timescale 1ps/1ps
`include "../define"

module CriqFreelist3 #(
    parameter CRIQWIDE = 7  ,
    parameter CRIQDEEP = 32 ,
    parameter PTRWIDE  = 6 
) (
    input         wire                            Clk           ,
    input         wire                            Rest          ,

    input         wire                            Rable         ,
    //output        wire       [CRIQWIDE-1:0]       Dout          , //23 wide

    output        wire       [CRIQWIDE-1:0]       CriqPreOut    ,

    input         wire                            Wable         ,
    input         wire       [CRIQWIDE-1:0]       Din           ,

    input         wire                            CriqClean     ,

    //output        wire                            CriqFull      ,
    output        wire                            CriqEmpty     
);

    reg   [CRIQWIDE-1:0] CRIQREG [0:CRIQDEEP]  ;
    reg   [PTRWIDE-1:0]     Criqfront          ;
    reg   [PTRWIDE-1:0]     Criqtril           ;

    always @(posedge Clk) begin
        if(!Rest) begin
            Criqfront <= 23;
            CRIQREG[0] <= 34 ;
            CRIQREG[1] <= 38 ;
            CRIQREG[2] <= 42 ;
            CRIQREG[3] <= 46 ;
            CRIQREG[4] <= 50 ;
            CRIQREG[5] <= 54 ;
            CRIQREG[6] <= 58 ;
            CRIQREG[7] <= 62 ;
            CRIQREG[8] <= 66 ;
            CRIQREG[9] <= 70 ;
            CRIQREG[10] <= 74 ;
            CRIQREG[11] <= 78 ;
            CRIQREG[12] <= 82 ;
            CRIQREG[13] <= 86 ;
            CRIQREG[14] <= 90 ;
            CRIQREG[15] <= 94 ;
            CRIQREG[16] <= 98 ;
            CRIQREG[17] <= 102 ;
            CRIQREG[18] <= 106 ;
            CRIQREG[19] <= 110 ;
            CRIQREG[20] <= 114 ;
            CRIQREG[21] <= 118 ;
            CRIQREG[22] <= 122 ;
            CRIQREG[23] <= 126 ;
            CRIQREG[24] <= 0 ;
            CRIQREG[25] <= 0 ;
            CRIQREG[26] <= 0 ;
            CRIQREG[27] <= 0 ;
            CRIQREG[28] <= 0 ;
            CRIQREG[29] <= 0 ;
            CRIQREG[30] <= 0 ;
            CRIQREG[31] <= 0 ;
        end
        else begin
            if(Wable) begin
                Criqfront <= (Criqfront == 32) ? 0 : Criqfront + 1 ;
                CRIQREG[Criqfront] <= Din ;
            end 
            if(CriqClean) begin
                Criqfront <= 23;
                CRIQREG[0] <= 34 ;
                CRIQREG[1] <= 38 ;
                CRIQREG[2] <= 42 ;
                CRIQREG[3] <= 46 ;
                CRIQREG[4] <= 50 ;
                CRIQREG[5] <= 54 ;
                CRIQREG[6] <= 58 ;
                CRIQREG[7] <= 62 ;
                CRIQREG[8] <= 66 ;
                CRIQREG[9] <= 70 ;
                CRIQREG[10] <= 74 ;
                CRIQREG[11] <= 78 ;
                CRIQREG[12] <= 82 ;
                CRIQREG[13] <= 86 ;
                CRIQREG[14] <= 90 ;
                CRIQREG[15] <= 94 ;
                CRIQREG[16] <= 98 ;
                CRIQREG[17] <= 102 ;
                CRIQREG[18] <= 106 ;
                CRIQREG[19] <= 110 ;
                CRIQREG[20] <= 114 ;
                CRIQREG[21] <= 118 ;
                CRIQREG[22] <= 122 ;
                CRIQREG[23] <= 126 ;
                CRIQREG[24] <= 0 ;
                CRIQREG[25] <= 0 ;
                CRIQREG[26] <= 0 ;
                CRIQREG[27] <= 0 ;
                CRIQREG[28] <= 0 ;
                CRIQREG[29] <= 0 ;
                CRIQREG[30] <= 0 ;
                CRIQREG[31] <= 0 ;
            end
        end
    end

    //reg  [CRIQWIDE-1:0]  CriqOutReg  ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Criqtril <= {PTRWIDE{1'b0}} ;
            //CriqOutReg <= {CRIQWIDE{1'b0}};
        end 
        else begin
            if(Rable) begin
                //CriqOutReg <= CRIQREG[Criqtril] ;
                Criqtril <= Criqtril - 1 ;
            end
            if(CriqClean)
                Criqtril <= 0 ;
        end
    end

    //assign Dout       = CriqOutReg              ;
    //assign CriqFull   = (((Criqtril - Criqfront) == 1) || ((Criqtril == 0) && (Criqfront == CRIQDEEP))) ;
    assign CriqEmpty  = (Criqtril == Criqfront) ;
    assign CriqPreOut = CRIQREG[Criqtril]       ; 

endmodule
`timescale 1ps/1ps
`include "../define"

module CriqFreelist4 #(
    parameter CRIQWIDE = 7  ,
    parameter CRIQDEEP = 32 ,
    parameter PTRWIDE  = 6 
) (
    input         wire                            Clk           ,
    input         wire                            Rest          ,

    input         wire                            Rable         ,
    //output        wire       [CRIQWIDE-1:0]       Dout          , //23 wide

    output        wire       [CRIQWIDE-1:0]       CriqPreOut    ,

    input         wire                            Wable         ,
    input         wire       [CRIQWIDE-1:0]       Din           ,

    input         wire                            CriqClean     ,

    //output        wire                            CriqFull      ,
    output        wire                            CriqEmpty     
);

    reg   [CRIQWIDE-1:0] CRIQREG [0:CRIQDEEP]  ;
    reg   [PTRWIDE-1:0]     Criqfront          ;
    reg   [PTRWIDE-1:0]     Criqtril           ;

    always @(posedge Clk) begin
        if(!Rest) begin
            Criqfront <= 23;
            CRIQREG[0] <= 35 ;
            CRIQREG[1] <= 39 ;
            CRIQREG[2] <= 43 ;
            CRIQREG[3] <= 47 ;
            CRIQREG[4] <= 51 ;
            CRIQREG[5] <= 55 ;
            CRIQREG[6] <= 59 ;
            CRIQREG[7] <= 63 ;
            CRIQREG[8] <= 67 ;
            CRIQREG[9] <= 71 ;
            CRIQREG[10] <= 75 ;
            CRIQREG[11] <= 79 ;
            CRIQREG[12] <= 83 ;
            CRIQREG[13] <= 87 ;
            CRIQREG[14] <= 91 ;
            CRIQREG[15] <= 95 ;
            CRIQREG[16] <= 99 ;
            CRIQREG[17] <= 103 ;
            CRIQREG[18] <= 107 ;
            CRIQREG[19] <= 111 ;
            CRIQREG[20] <= 115 ;
            CRIQREG[21] <= 119 ;
            CRIQREG[22] <= 123 ;
            CRIQREG[23] <= 127 ;
            CRIQREG[24] <= 0 ;
            CRIQREG[25] <= 0 ;
            CRIQREG[26] <= 0 ;
            CRIQREG[27] <= 0 ;
            CRIQREG[28] <= 0 ;
            CRIQREG[29] <= 0 ;
            CRIQREG[30] <= 0 ;
            CRIQREG[31] <= 0 ;
        end
        else begin
            if(Wable) begin
                Criqfront <= (Criqfront == 32) ? 0 : Criqfront + 1 ;
                CRIQREG[Criqfront] <= Din ;
            end 
            if(CriqClean) begin
                Criqfront <= 23;
                CRIQREG[0] <= 35 ;
                CRIQREG[1] <= 39 ;
                CRIQREG[2] <= 43 ;
                CRIQREG[3] <= 47 ;
                CRIQREG[4] <= 51 ;
                CRIQREG[5] <= 55 ;
                CRIQREG[6] <= 59 ;
                CRIQREG[7] <= 63 ;
                CRIQREG[8] <= 67 ;
                CRIQREG[9] <= 71 ;
                CRIQREG[10] <= 75 ;
                CRIQREG[11] <= 79 ;
                CRIQREG[12] <= 83 ;
                CRIQREG[13] <= 87 ;
                CRIQREG[14] <= 91 ;
                CRIQREG[15] <= 95 ;
                CRIQREG[16] <= 99 ;
                CRIQREG[17] <= 103 ;
                CRIQREG[18] <= 107 ;
                CRIQREG[19] <= 111 ;
                CRIQREG[20] <= 115 ;
                CRIQREG[21] <= 119 ;
                CRIQREG[22] <= 123 ;
                CRIQREG[23] <= 127 ;
                CRIQREG[24] <= 0 ;
                CRIQREG[25] <= 0 ;
                CRIQREG[26] <= 0 ;
                CRIQREG[27] <= 0 ;
                CRIQREG[28] <= 0 ;
                CRIQREG[29] <= 0 ;
                CRIQREG[30] <= 0 ;
                CRIQREG[31] <= 0 ;
            end
        end
    end

    //reg  [CRIQWIDE-1:0]  CriqOutReg  ;
    always @(posedge Clk) begin
        if(!Rest) begin
            Criqtril <= {PTRWIDE{1'b0}} ;
            //CriqOutReg <= {CRIQWIDE{1'b0}};
        end 
        else begin
            if(Rable) begin
                //CriqOutReg <= CRIQREG[Criqtril] ;
                Criqtril <= Criqtril - 1 ;
            end
            if(CriqClean)
                Criqtril <= 0 ;
        end
    end

    //assign Dout       = CriqOutReg              ;
    //assign CriqFull   = (((Criqtril - Criqfront) == 1) || ((Criqtril == 0) && (Criqfront == CRIQDEEP))) ;
    assign CriqEmpty  = (Criqtril == Criqfront) ;
    assign CriqPreOut = CRIQREG[Criqtril]       ; 

endmodule
`timescale 1ps/1ps
`include "../define.v"
`include "CriqFreelist1.v"
`include "CriqFreelist2.v"
`include "CriqFreelist3.v"
`include "CriqFreelist4.v"

module FreeList (
    input       wire                               Clk          ,
    input       wire                               Rest         ,
    //for ctrl 
    input       wire                               FreelistStop ,
    input       wire                               FreeListFlash,
    output      wire                               FreeListReq  ,
    //from dispatch 
    input       wire                               InWay1Rename ,
    input       wire      [`ArchRegBUs]            InWay1RegNum ,
    input       wire                               InWay2Rename ,
    input       wire      [`ArchRegBUs]            InWay2RegNum ,
    input       wire                               InWay3Rename ,
    input       wire      [`ArchRegBUs]            InWay3RegNum ,
    input       wire                               InWay4Rename ,
    input       wire      [`ArchRegBUs]            InWay4RegNum ,
    //to RAT
    output      wire                               OutWay1Rename,
    output      wire      [`ArchRegBUs]            OutWay1Areg  ,
    output      wire      [`ReNameRegBUs]          OutWay1RegNum,
    output      wire                               OutWay2Rename,
    output      wire      [`ArchRegBUs]            OutWay2Areg  ,
    output      wire      [`ReNameRegBUs]          OutWay2RegNum,
    output      wire                               OutWay3Rename,
    output      wire      [`ArchRegBUs]            OutWay3Areg  ,
    output      wire      [`ReNameRegBUs]          OutWay3RegNum,
    output      wire                               OutWay4Rename,
    output      wire      [`ArchRegBUs]            OutWay4Areg  ,
    output      wire      [`ReNameRegBUs]          OutWay4RegNum,
    //from ROB
    input       wire                               ReloadAble   ,
    //from RefTable
    input       wire                               FreeAble1    ,
    input       wire      [`ReNameRegBUs]          FreeAddr1    ,
    input       wire                               FreeAble2    ,
    input       wire      [`ReNameRegBUs]          FreeAddr2    ,
    input       wire                               FreeAble3    ,
    input       wire      [`ReNameRegBUs]          FreeAddr3    ,
    input       wire                               FreeAble4    ,
    input       wire      [`ReNameRegBUs]          FreeAddr4    
);
    reg            StopTemp  ;
    reg            FlashTemp ;

    always @(posedge Clk) begin
        if(!Rest) begin
            StopTemp  <= 1'b0 ;
            FlashTemp <= 1'b0 ;
        end 
        else begin
            StopTemp  <= FreelistStop  ;
            FlashTemp <= FreeListFlash ;
        end
    end

    reg [2:0] WritePtr ;
    reg [2:0] ReadPtr  ;

    wire [2:0] ReadCounter = InWay1Rename  & InWay2Rename   & InWay3Rename  & InWay4Rename  ? 3'd4 :
                             InWay1Rename  & InWay2Rename   & InWay3Rename  & ~InWay4Rename ? 3'd3 :
                             InWay1Rename  & InWay2Rename   & ~InWay3Rename & ~InWay4Rename ? 3'd2 :
                             InWay1Rename  & ~InWay2Rename  & ~InWay3Rename & ~InWay4Rename ? 3'd1 : 3'd0 ;
    wire [2:0] WriteCounter = FreeAble1 & FreeAble2  & FreeAble3  & FreeAble4  ? 3'd4 :
                              FreeAble1 & FreeAble2  & FreeAble3  & ~FreeAble4 ? 3'd3 :
                              FreeAble1 & FreeAble2  & ~FreeAble3 & ~FreeAble4 ? 3'd2 :
                              FreeAble1 & ~FreeAble2 & ~FreeAble3 & ~FreeAble4 ? 3'd1 : 3'd0 ;

    always @(posedge Clk) begin
        if(!Rest)
            WritePtr <= 3'd0 ;
        else 
            WritePtr <= WritePtr[1:0] + WriteCounter ;
    end

    always @(posedge Clk) begin
        if(!Rest) 
            ReadPtr <= 3'd0 ;
        else 
            ReadPtr <= ReadPtr[1:0] + ReadCounter ;
    end

    wire U1Write = ((WritePtr[1:0] == 0) & ~StopTemp) ? FreeAble1 :
                   ((WritePtr[1:0] == 1) & ~StopTemp) ? FreeAble4 :
                   ((WritePtr[1:0] == 2) & ~StopTemp) ? FreeAble3 :
                   ((WritePtr[1:0] == 3) & ~StopTemp) ? FreeAble2 : `EnableValue ;

    wire U2Write = ((WritePtr[1:0] == 0) & ~StopTemp) ? FreeAble2 :
                   ((WritePtr[1:0] == 1) & ~StopTemp) ? FreeAble1 :
                   ((WritePtr[1:0] == 2) & ~StopTemp) ? FreeAble4 :
                   ((WritePtr[1:0] == 3) & ~StopTemp) ? FreeAble3 : `EnableValue ;

    wire U3Write = ((WritePtr[1:0] == 0) & ~StopTemp) ? FreeAble3 :
                   ((WritePtr[1:0] == 1) & ~StopTemp) ? FreeAble2 :
                   ((WritePtr[1:0] == 2) & ~StopTemp) ? FreeAble1 :
                   ((WritePtr[1:0] == 3) & ~StopTemp) ? FreeAble4 : `EnableValue ;

    wire U4Write = ((WritePtr[1:0] == 0) & ~StopTemp) ? FreeAble4 :
                   ((WritePtr[1:0] == 1) & ~StopTemp) ? FreeAble3 :
                   ((WritePtr[1:0] == 2) & ~StopTemp) ? FreeAble2 :
                   ((WritePtr[1:0] == 3) & ~StopTemp) ? FreeAble1 : `EnableValue ;

    wire [`ReNameRegBUs] U1Date = ((WritePtr[1:0] == 0) & ~StopTemp) ? FreeAddr1 :
                                  ((WritePtr[1:0] == 1) & ~StopTemp) ? FreeAddr4 :
                                  ((WritePtr[1:0] == 2) & ~StopTemp) ? FreeAddr3 :
                                  ((WritePtr[1:0] == 3) & ~StopTemp) ? FreeAddr2 : 7'd0 ;

    wire [`ReNameRegBUs] U2Date = ((WritePtr[1:0] == 0) & ~StopTemp) ? FreeAddr2 :
                                  ((WritePtr[1:0] == 1) & ~StopTemp) ? FreeAddr1 :
                                  ((WritePtr[1:0] == 2) & ~StopTemp) ? FreeAddr4 :
                                  ((WritePtr[1:0] == 3) & ~StopTemp) ? FreeAddr3 : 7'd0  ;

    wire [`ReNameRegBUs] U3Date = ((WritePtr[1:0] == 0) & ~StopTemp) ? FreeAddr3 :
                                  ((WritePtr[1:0] == 1) & ~StopTemp) ? FreeAddr2 :
                                  ((WritePtr[1:0] == 2) & ~StopTemp) ? FreeAddr1 :
                                  ((WritePtr[1:0] == 3) & ~StopTemp) ? FreeAddr4 : 7'd0  ;

    wire [`ReNameRegBUs] U4Date = ((WritePtr[1:0] == 0) & ~StopTemp) ? FreeAddr4 :
                                  ((WritePtr[1:0] == 1) & ~StopTemp) ? FreeAddr3 :
                                  ((WritePtr[1:0] == 2) & ~StopTemp) ? FreeAddr2 :
                                  ((WritePtr[1:0] == 3) & ~StopTemp) ? FreeAddr1 : 7'd0  ;

    wire U1Read = ((ReadPtr[1:0] == 0) & ~StopTemp) ? InWay1Rename :
                  ((ReadPtr[1:0] == 1) & ~StopTemp) ? InWay4Rename :
                  ((ReadPtr[1:0] == 2) & ~StopTemp) ? InWay3Rename :
                  ((ReadPtr[1:0] == 3) & ~StopTemp) ? InWay2Rename : `EnableValue ;

    wire U2Read = ((ReadPtr[1:0] == 0) & ~StopTemp) ? InWay2Rename :
                  ((ReadPtr[1:0] == 1) & ~StopTemp) ? InWay1Rename :
                  ((ReadPtr[1:0] == 2) & ~StopTemp) ? InWay4Rename :
                  ((ReadPtr[1:0] == 3) & ~StopTemp) ? InWay3Rename : `EnableValue ;

    wire U3Read = ((ReadPtr[1:0] == 0) & ~StopTemp) ? InWay3Rename :
                  ((ReadPtr[1:0] == 1) & ~StopTemp) ? InWay2Rename :
                  ((ReadPtr[1:0] == 2) & ~StopTemp) ? InWay1Rename :
                  ((ReadPtr[1:0] == 3) & ~StopTemp) ? InWay4Rename : `EnableValue ;

    wire U4Read = ((ReadPtr[1:0] == 0) & ~StopTemp) ? InWay4Rename :
                  ((ReadPtr[1:0] == 1) & ~StopTemp) ? InWay3Rename :
                  ((ReadPtr[1:0] == 2) & ~StopTemp) ? InWay2Rename :
                  ((ReadPtr[1:0] == 3) & ~StopTemp) ? InWay1Rename : `EnableValue ;

    wire [`ReNameRegBUs] U1PreDate ;
    wire [`ReNameRegBUs] U2PreDate ;
    wire [`ReNameRegBUs] U3PreDate ;
    wire [`ReNameRegBUs] U4PreDate ;

    assign OutWay1Rename = InWay1Rename ; 
    assign OutWay2Rename = InWay2Rename ; 
    assign OutWay3Rename = InWay3Rename ; 
    assign OutWay4Rename = InWay4Rename ; 

    assign OutWay1RegNum = (ReadPtr[1:0] == 0) ? U1PreDate :
                           (ReadPtr[1:0] == 1) ? U2PreDate :
                           (ReadPtr[1:0] == 2) ? U3PreDate :
                           (ReadPtr[1:0] == 3) ? U4PreDate : 7'd0 ;

    assign OutWay2RegNum = (ReadPtr[1:0] == 0) ? U2PreDate :
                           (ReadPtr[1:0] == 1) ? U3PreDate :
                           (ReadPtr[1:0] == 2) ? U4PreDate :
                           (ReadPtr[1:0] == 3) ? U1PreDate : 7'd0 ;

    assign OutWay3RegNum = (ReadPtr[1:0] == 0) ? U3PreDate :
                           (ReadPtr[1:0] == 1) ? U4PreDate :
                           (ReadPtr[1:0] == 2) ? U1PreDate :
                           (ReadPtr[1:0] == 3) ? U2PreDate : 7'd0 ;

    assign OutWay4RegNum = (ReadPtr[1:0] == 0) ? U4PreDate :
                           (ReadPtr[1:0] == 1) ? U1PreDate :
                           (ReadPtr[1:0] == 2) ? U2PreDate :
                           (ReadPtr[1:0] == 3) ? U3PreDate : 7'd0 ;


    assign OutWay1Areg = InWay1RegNum ;
    assign OutWay2Areg = InWay2RegNum ;
    assign OutWay3Areg = InWay3RegNum ;
    assign OutWay4Areg = InWay4RegNum ;

    wire U1Clean = ReloadAble | FlashTemp ;
    wire U2Clean = ReloadAble | FlashTemp ;
    wire U3Clean = ReloadAble | FlashTemp ;
    wire U4Clean = ReloadAble | FlashTemp ;

    wire U1ReqStop ;
    wire U2ReqStop ;
    wire U3ReqStop ;
    wire U4ReqStop ;

    assign FreeListReq = U1ReqStop | U2ReqStop | U3ReqStop | U4ReqStop ;


    CriqFreelist1#(
        .CRIQWIDE    ( 7           ),
        .CRIQDEEP    ( 32          ),
        .PTRWIDE     ( 6           )
    )u_CriqFreelist1(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .Rable       ( U1Read      ),
        //.Dout        ( Dout        ),
        .CriqPreOut  ( U1PreDate   ),
        .Wable       ( U1Write     ),
        .Din         ( U1Date      ),
        .CriqClean   ( U1Clean     ),
        //.CriqFull    ( CriqFull    ),
        .CriqEmpty   ( U1ReqStop   )
    );

    CriqFreelist2#(
        .CRIQWIDE    ( 7           ),
        .CRIQDEEP    ( 32          ),
        .PTRWIDE     ( 6           )
    )u_CriqFreelist2(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .Rable       ( U2Read      ),
        //.Dout        ( Dout        ),
        .CriqPreOut  ( U2PreDate   ),
        .Wable       ( U2Write     ),
        .Din         ( U2Date      ),
        .CriqClean   ( U2Clean     ),
        //.CriqFull    ( CriqFull    ),
        .CriqEmpty   ( U2ReqStop   )
    );

    CriqFreelist3#(
        .CRIQWIDE    ( 7           ),
        .CRIQDEEP    ( 32          ),
        .PTRWIDE     ( 6           )
    )u_CriqFreelist3(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .Rable       ( U3Read      ),
        //.Dout        ( Dout        ),
        .CriqPreOut  ( U3PreDate   ),
        .Wable       ( U3Write     ),
        .Din         ( U3Date      ),
        .CriqClean   ( U3Clean     ),
        //.CriqFull    ( CriqFull    ),
        .CriqEmpty   ( U3ReqStop   )
    );

    CriqFreelist4#(
        .CRIQWIDE    ( 7           ),
        .CRIQDEEP    ( 32          ),
        .PTRWIDE     ( 6           )
    )u_CriqFreelist4(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .Rable       ( U4Read      ),
        //.Dout        ( Dout        ),
        .CriqPreOut  ( U4PreDate   ),
        .Wable       ( U4Write     ),
        .Din         ( U4Date      ),
        .CriqClean   ( U4Clean     ),
        //.CriqFull    ( CriqFull    ),
        .CriqEmpty   ( U4ReqStop   )
    );

    
endmodule
`timescale 1ps/1ps
`include "../define.v"

module RefTable (
    input       wire                                    Clk              ,
    input       wire                                    Rest             ,
    //from 
    input       wire                                    RefTableStop     ,
    input       wire                                    RefTableFLash    ,
    //from RAT 
    input       wire                                    Inst1Src1Able    ,
    input       wire      [`ReNameRegBUs]               Inst1Src1Addr    ,
    input       wire                                    Inst1Src2Able    ,
    input       wire      [`ReNameRegBUs]               Inst1Src2Addr    ,
    input       wire                                    Inst1RdAble      ,
    input       wire      [`ReNameRegBUs]               Inst1RdAddr      ,
    input       wire                                    Inst2Src1Able    ,
    input       wire      [`ReNameRegBUs]               Inst2Src1Addr    ,
    input       wire                                    Inst2Src2Able    ,
    input       wire      [`ReNameRegBUs]               Inst2Src2Addr    ,
    input       wire                                    Inst2RdAble      ,
    input       wire      [`ReNameRegBUs]               Inst2RdAddr      ,
    input       wire                                    Inst3Src1Able    ,
    input       wire      [`ReNameRegBUs]               Inst3Src1Addr    ,
    input       wire                                    Inst3Src2Able    ,
    input       wire      [`ReNameRegBUs]               Inst3Src2Addr    ,
    input       wire                                    Inst3RdAble      ,
    input       wire      [`ReNameRegBUs]               Inst3RdAddr      ,
    input       wire                                    Inst4Src1Able    ,
    input       wire      [`ReNameRegBUs]               Inst4Src1Addr    ,
    input       wire                                    Inst4Src2Able    ,
    input       wire      [`ReNameRegBUs]               Inst4Src2Addr    ,
    input       wire                                    Inst4RdAble      ,
    input       wire      [`ReNameRegBUs]               Inst4RdAddr      ,
    input       wire                                    Lock1Able        ,
    input       wire      [`ReNameRegBUs]               Lock1Addr        ,
    input       wire                                    Lock2Able        ,
    input       wire      [`ReNameRegBUs]               Lock2Addr        ,
    input       wire                                    Lock3Able        ,
    input       wire      [`ReNameRegBUs]               Lock3Addr        ,
    input       wire                                    Lock4Able        ,
    input       wire      [`ReNameRegBUs]               Lock4Addr        ,
    //from Physical Regfiles
    input       wire                                    Inst1Read1Able   ,
    input       wire      [`ReNameRegBUs]               Inst1Read1Addr   ,
    input       wire                                    Inst1Read2Able   ,
    input       wire      [`ReNameRegBUs]               Inst1Read2Addr   ,   
    input       wire                                    Inst2Read1Able   ,
    input       wire      [`ReNameRegBUs]               Inst2Read1Addr   ,
    input       wire                                    Inst2Read2Able   ,
    input       wire      [`ReNameRegBUs]               Inst2Read2Addr   ,
    input       wire                                    Inst3Read1Able   ,
    input       wire      [`ReNameRegBUs]               Inst3Read1Addr   ,
    input       wire                                    Inst3Read2Able   ,
    input       wire      [`ReNameRegBUs]               Inst3Read2Addr   ,
    input       wire                                    Inst4Read1Able   ,
    input       wire      [`ReNameRegBUs]               Inst4Read1Addr   ,
    input       wire                                    Inst4Read2Able   ,
    input       wire      [`ReNameRegBUs]               Inst4Read2Addr   ,     
    input       wire                                    WritBack1Able    ,
    input       wire      [`ReNameRegBUs]               WritBack1Addr    ,      
    input       wire                                    WritBack2Able    ,
    input       wire      [`ReNameRegBUs]               WritBack2Addr    ,                      
    input       wire                                    WritBack3Able    ,
    input       wire      [`ReNameRegBUs]               WritBack3Addr    ,    
    input       wire                                    WritBack4Able    ,
    input       wire      [`ReNameRegBUs]               WritBack4Addr    ,    
    input       wire                                    WritBack5Able    ,
    input       wire      [`ReNameRegBUs]               WritBack5Addr    ,    
    input       wire                                    WritBack6Able    ,
    input       wire      [`ReNameRegBUs]               WritBack6Addr    ,    
    input       wire                                    WritBack7Able    ,
    input       wire      [`ReNameRegBUs]               WritBack7Addr    ,    
    input       wire                                    WritBack8Able    ,
    input       wire      [`ReNameRegBUs]               WritBack8Addr    ,
    //to Freelist
    output      wire      [`ReNameRegBUs]               WriteNum1        ,
    output      wire                                    WriteAble1       ,
    output      wire      [`ReNameRegBUs]               WriteNum2        ,
    output      wire                                    WriteAble2       ,
    output      wire      [`ReNameRegBUs]               WriteNum3        ,
    output      wire                                    WriteAble3       ,
    output      wire      [`ReNameRegBUs]               WriteNum4        ,
    output      wire                                    WriteAble4       
);
    reg           REFLOCK       [0:127] ;
    reg    [6:0]  REFTABLEUSE   [0:127] ;
    reg    [6:0]  REFTABLEUNUSE [0:127] ;

    wire [7:0] Index1Unuse = ({8{(REFLOCK[0])  & (REFTABLEUSE[0] == REFTABLEUNUSE[0])}}   & {1'b1,7'd0})  |
                             ({8{(REFLOCK[4])  & (REFTABLEUSE[4] == REFTABLEUNUSE[4])}}   & {1'b1,7'd4})  | 
                             ({8{(REFLOCK[8])  & (REFTABLEUSE[8] == REFTABLEUNUSE[8])}}   & {1'b1,7'd8})  | 
                             ({8{(REFLOCK[12]) & (REFTABLEUSE[12] == REFTABLEUNUSE[12])}} & {1'b1,7'd12}) | 
                             ({8{(REFLOCK[16]) & (REFTABLEUSE[16] == REFTABLEUNUSE[16])}} & {1'b1,7'd16}) | 
                             ({8{(REFLOCK[20]) & (REFTABLEUSE[20] == REFTABLEUNUSE[20])}} & {1'b1,7'd20}) | 
                             ({8{(REFLOCK[24]) & (REFTABLEUSE[24] == REFTABLEUNUSE[24])}} & {1'b1,7'd24}) | 
                             ({8{(REFLOCK[28]) & (REFTABLEUSE[28] == REFTABLEUNUSE[28])}} & {1'b1,7'd28}) | 
                             ({8{(REFLOCK[32]) & (REFTABLEUSE[32] == REFTABLEUNUSE[32])}} & {1'b1,7'd32}) | 
                             ({8{(REFLOCK[36]) & (REFTABLEUSE[36] == REFTABLEUNUSE[36])}} & {1'b1,7'd36}) | 
                             ({8{(REFLOCK[40]) & (REFTABLEUSE[40] == REFTABLEUNUSE[40])}} & {1'b1,7'd40}) | 
                             ({8{(REFLOCK[44]) & (REFTABLEUSE[44] == REFTABLEUNUSE[44])}} & {1'b1,7'd44}) | 
                             ({8{(REFLOCK[48]) & (REFTABLEUSE[48] == REFTABLEUNUSE[48])}} & {1'b1,7'd48}) | 
                             ({8{(REFLOCK[52]) & (REFTABLEUSE[52] == REFTABLEUNUSE[52])}} & {1'b1,7'd52}) | 
                             ({8{(REFLOCK[56]) & (REFTABLEUSE[56] == REFTABLEUNUSE[56])}} & {1'b1,7'd56}) | 
                             ({8{(REFLOCK[60]) & (REFTABLEUSE[60] == REFTABLEUNUSE[60])}} & {1'b1,7'd60}) | 
                             //{8{(REFLOCK[64]) & (REFTABLEUSE[64] == REFTABLEUNUSE[64])}} & {1'b1,7'd64} | 
                             ({8{(REFLOCK[64]) & (REFTABLEUSE[64] == REFTABLEUNUSE[64])}} & {1'b1,7'd64}) | 
                             ({8{(REFLOCK[68]) & (REFTABLEUSE[68] == REFTABLEUNUSE[68])}} & {1'b1,7'd68}) | 
                             ({8{(REFLOCK[72]) & (REFTABLEUSE[72] == REFTABLEUNUSE[72])}} & {1'b1,7'd72}) | 
                             ({8{(REFLOCK[76]) & (REFTABLEUSE[76] == REFTABLEUNUSE[76])}} & {1'b1,7'd76}) | 
                             ({8{(REFLOCK[80]) & (REFTABLEUSE[80] == REFTABLEUNUSE[80])}} & {1'b1,7'd80}) | 
                             ({8{(REFLOCK[84]) & (REFTABLEUSE[84] == REFTABLEUNUSE[84])}} & {1'b1,7'd84}) | 
                             ({8{(REFLOCK[88]) & (REFTABLEUSE[88] == REFTABLEUNUSE[88])}} & {1'b1,7'd88}) | 
                             ({8{(REFLOCK[92]) & (REFTABLEUSE[92] == REFTABLEUNUSE[92])}} & {1'b1,7'd92}) | 
                             ({8{(REFLOCK[96]) & (REFTABLEUSE[96] == REFTABLEUNUSE[96])}} & {1'b1,7'd96}) | 
                             ({8{(REFLOCK[100]) & (REFTABLEUSE[100] == REFTABLEUNUSE[100])}} & {1'b1,7'd100}) | 
                             ({8{(REFLOCK[104]) & (REFTABLEUSE[104] == REFTABLEUNUSE[104])}} & {1'b1,7'd104}) | 
                             ({8{(REFLOCK[108]) & (REFTABLEUSE[108] == REFTABLEUNUSE[108])}} & {1'b1,7'd108}) | 
                             ({8{(REFLOCK[112]) & (REFTABLEUSE[112] == REFTABLEUNUSE[112])}} & {1'b1,7'd112}) | 
                             ({8{(REFLOCK[116]) & (REFTABLEUSE[116] == REFTABLEUNUSE[116])}} & {1'b1,7'd116}) | 
                             ({8{(REFLOCK[120]) & (REFTABLEUSE[120] == REFTABLEUNUSE[120])}} & {1'b1,7'd120}) | 
                             ({8{(REFLOCK[124]) & (REFTABLEUSE[124] == REFTABLEUNUSE[124])}} & {1'b1,7'd124}) ;
    wire [7:0] Index2Unuse = ({8{(REFLOCK[1])  & (REFTABLEUSE[1] == REFTABLEUNUSE[1])}}   & {1'b1,7'd1})  | 
                             ({8{(REFLOCK[5])  & (REFTABLEUSE[5] == REFTABLEUNUSE[5])}}   & {1'b1,7'd5})  |  
                             ({8{(REFLOCK[9])  & (REFTABLEUSE[9] == REFTABLEUNUSE[9])}}   & {1'b1,7'd9})  | 
                             ({8{(REFLOCK[13]) & (REFTABLEUSE[13] == REFTABLEUNUSE[13])}} & {1'b1,7'd13}) | 
                             ({8{(REFLOCK[17]) & (REFTABLEUSE[17] == REFTABLEUNUSE[17])}} & {1'b1,7'd17}) | 
                             ({8{(REFLOCK[21]) & (REFTABLEUSE[21] == REFTABLEUNUSE[21])}} & {1'b1,7'd21}) | 
                             ({8{(REFLOCK[25]) & (REFTABLEUSE[25] == REFTABLEUNUSE[25])}} & {1'b1,7'd25}) | 
                             ({8{(REFLOCK[29]) & (REFTABLEUSE[29] == REFTABLEUNUSE[29])}} & {1'b1,7'd29}) | 
                             ({8{(REFLOCK[33]) & (REFTABLEUSE[33] == REFTABLEUNUSE[33])}} & {1'b1,7'd33}) | 
                             ({8{(REFLOCK[37]) & (REFTABLEUSE[37] == REFTABLEUNUSE[37])}} & {1'b1,7'd37}) | 
                             ({8{(REFLOCK[41]) & (REFTABLEUSE[41] == REFTABLEUNUSE[41])}} & {1'b1,7'd41}) | 
                             ({8{(REFLOCK[45]) & (REFTABLEUSE[45] == REFTABLEUNUSE[45])}} & {1'b1,7'd45}) | 
                             ({8{(REFLOCK[49]) & (REFTABLEUSE[49] == REFTABLEUNUSE[49])}} & {1'b1,7'd49}) | 
                             ({8{(REFLOCK[53]) & (REFTABLEUSE[53] == REFTABLEUNUSE[53])}} & {1'b1,7'd53}) | 
                             ({8{(REFLOCK[57]) & (REFTABLEUSE[57] == REFTABLEUNUSE[57])}} & {1'b1,7'd57}) | 
                             ({8{(REFLOCK[61]) & (REFTABLEUSE[61] == REFTABLEUNUSE[61])}} & {1'b1,7'd61}) | 
                             ({8{(REFLOCK[65]) & (REFTABLEUSE[65] == REFTABLEUNUSE[65])}} & {1'b1,7'd65}) | 
                             //{8{(REFLOCK[65]) & (REFTABLEUSE[65] == REFTABLEUNUSE[65])}} & {1'b1,7'd65} | 
                             ({8{(REFLOCK[69]) & (REFTABLEUSE[69] == REFTABLEUNUSE[69])}} & {1'b1,7'd69}) | 
                             ({8{(REFLOCK[73]) & (REFTABLEUSE[73] == REFTABLEUNUSE[73])}} & {1'b1,7'd73}) | 
                             ({8{(REFLOCK[77]) & (REFTABLEUSE[77] == REFTABLEUNUSE[77])}} & {1'b1,7'd77}) | 
                             ({8{(REFLOCK[81]) & (REFTABLEUSE[81] == REFTABLEUNUSE[81])}} & {1'b1,7'd81}) | 
                             ({8{(REFLOCK[85]) & (REFTABLEUSE[85] == REFTABLEUNUSE[85])}} & {1'b1,7'd85}) | 
                             ({8{(REFLOCK[89]) & (REFTABLEUSE[89] == REFTABLEUNUSE[89])}} & {1'b1,7'd89}) | 
                             ({8{(REFLOCK[93]) & (REFTABLEUSE[93] == REFTABLEUNUSE[93])}} & {1'b1,7'd93}) | 
                             ({8{(REFLOCK[97]) & (REFTABLEUSE[97] == REFTABLEUNUSE[97])}} & {1'b1,7'd97}) | 
                             ({8{(REFLOCK[101]) & (REFTABLEUSE[101] == REFTABLEUNUSE[101])}} & {1'b1,7'd101}) | 
                             ({8{(REFLOCK[105]) & (REFTABLEUSE[105] == REFTABLEUNUSE[105])}} & {1'b1,7'd105}) | 
                             ({8{(REFLOCK[109]) & (REFTABLEUSE[109] == REFTABLEUNUSE[109])}} & {1'b1,7'd109}) | 
                             ({8{(REFLOCK[113]) & (REFTABLEUSE[113] == REFTABLEUNUSE[113])}} & {1'b1,7'd113}) | 
                             ({8{(REFLOCK[117]) & (REFTABLEUSE[117] == REFTABLEUNUSE[117])}} & {1'b1,7'd117}) | 
                             ({8{(REFLOCK[121]) & (REFTABLEUSE[121] == REFTABLEUNUSE[121])}} & {1'b1,7'd121}) | 
                             ({8{(REFLOCK[125]) & (REFTABLEUSE[125] == REFTABLEUNUSE[125])}} & {1'b1,7'd125}) ;
    wire [7:0] Index3Unuse = ({8{(REFLOCK[2])  & (REFTABLEUSE[2] == REFTABLEUNUSE[2])}}   & {1'b1,7'd2})  | 
                             ({8{(REFLOCK[6])  & (REFTABLEUSE[6] == REFTABLEUNUSE[6])}}   & {1'b1,7'd6})  |  
                             ({8{(REFLOCK[10]) & (REFTABLEUSE[10] == REFTABLEUNUSE[10])}} & {1'b1,7'd10}) | 
                             ({8{(REFLOCK[14]) & (REFTABLEUSE[14] == REFTABLEUNUSE[14])}} & {1'b1,7'd14}) | 
                             ({8{(REFLOCK[18]) & (REFTABLEUSE[18] == REFTABLEUNUSE[18])}} & {1'b1,7'd18}) | 
                             ({8{(REFLOCK[22]) & (REFTABLEUSE[22] == REFTABLEUNUSE[22])}} & {1'b1,7'd22}) | 
                             ({8{(REFLOCK[26]) & (REFTABLEUSE[26] == REFTABLEUNUSE[26])}} & {1'b1,7'd26}) | 
                             ({8{(REFLOCK[30]) & (REFTABLEUSE[30] == REFTABLEUNUSE[30])}} & {1'b1,7'd30}) | 
                             ({8{(REFLOCK[34]) & (REFTABLEUSE[34] == REFTABLEUNUSE[34])}} & {1'b1,7'd34}) | 
                             ({8{(REFLOCK[38]) & (REFTABLEUSE[38] == REFTABLEUNUSE[38])}} & {1'b1,7'd38}) | 
                             ({8{(REFLOCK[42]) & (REFTABLEUSE[42] == REFTABLEUNUSE[42])}} & {1'b1,7'd42}) | 
                             ({8{(REFLOCK[46]) & (REFTABLEUSE[46] == REFTABLEUNUSE[46])}} & {1'b1,7'd46}) | 
                             ({8{(REFLOCK[50]) & (REFTABLEUSE[50] == REFTABLEUNUSE[50])}} & {1'b1,7'd50}) | 
                             ({8{(REFLOCK[54]) & (REFTABLEUSE[54] == REFTABLEUNUSE[54])}} & {1'b1,7'd54}) | 
                             ({8{(REFLOCK[58]) & (REFTABLEUSE[58] == REFTABLEUNUSE[58])}} & {1'b1,7'd58}) | 
                             ({8{(REFLOCK[62]) & (REFTABLEUSE[62] == REFTABLEUNUSE[62])}} & {1'b1,7'd62}) | 
                             //{8{(REFLOCK[66]) & (REFTABLEUSE[66] == REFTABLEUNUSE[66])}} & {1'b1,7'd66} | 
                             ({8{(REFLOCK[66]) & (REFTABLEUSE[66] == REFTABLEUNUSE[66])}} & {1'b1,7'd66}) | 
                             ({8{(REFLOCK[70]) & (REFTABLEUSE[70] == REFTABLEUNUSE[70])}} & {1'b1,7'd70}) | 
                             ({8{(REFLOCK[74]) & (REFTABLEUSE[74] == REFTABLEUNUSE[74])}} & {1'b1,7'd74}) | 
                             ({8{(REFLOCK[78]) & (REFTABLEUSE[78] == REFTABLEUNUSE[78])}} & {1'b1,7'd78}) | 
                             ({8{(REFLOCK[82]) & (REFTABLEUSE[82] == REFTABLEUNUSE[82])}} & {1'b1,7'd82}) | 
                             ({8{(REFLOCK[86]) & (REFTABLEUSE[86] == REFTABLEUNUSE[86])}} & {1'b1,7'd86}) | 
                             ({8{(REFLOCK[90]) & (REFTABLEUSE[90] == REFTABLEUNUSE[90])}} & {1'b1,7'd90}) | 
                             ({8{(REFLOCK[94]) & (REFTABLEUSE[94] == REFTABLEUNUSE[94])}} & {1'b1,7'd94}) | 
                             ({8{(REFLOCK[98]) & (REFTABLEUSE[98] == REFTABLEUNUSE[98])}} & {1'b1,7'd98}) | 
                             ({8{(REFLOCK[102]) & (REFTABLEUSE[102] == REFTABLEUNUSE[102])}} & {1'b1,7'd102}) | 
                             ({8{(REFLOCK[106]) & (REFTABLEUSE[106] == REFTABLEUNUSE[106])}} & {1'b1,7'd106}) | 
                             ({8{(REFLOCK[110]) & (REFTABLEUSE[110] == REFTABLEUNUSE[110])}} & {1'b1,7'd110}) | 
                             ({8{(REFLOCK[114]) & (REFTABLEUSE[114] == REFTABLEUNUSE[114])}} & {1'b1,7'd114}) | 
                             ({8{(REFLOCK[118]) & (REFTABLEUSE[118] == REFTABLEUNUSE[118])}} & {1'b1,7'd118}) | 
                             ({8{(REFLOCK[122]) & (REFTABLEUSE[122] == REFTABLEUNUSE[122])}} & {1'b1,7'd122}) | 
                             ({8{(REFLOCK[126]) & (REFTABLEUSE[126] == REFTABLEUNUSE[126])}} & {1'b1,7'd126}) ;
    wire [7:0] Index4Unuse = ({8{(REFLOCK[3])  & (REFTABLEUSE[3] == REFTABLEUNUSE[3])}}   & {1'b1,7'd3})  | 
                             ({8{(REFLOCK[7])  & (REFTABLEUSE[7] == REFTABLEUNUSE[7])}}   & {1'b1,7'd7})  |  
                             ({8{(REFLOCK[11]) & (REFTABLEUSE[11] == REFTABLEUNUSE[11])}} & {1'b1,7'd11}) | 
                             ({8{(REFLOCK[15]) & (REFTABLEUSE[15] == REFTABLEUNUSE[15])}} & {1'b1,7'd15}) | 
                             ({8{(REFLOCK[19]) & (REFTABLEUSE[19] == REFTABLEUNUSE[19])}} & {1'b1,7'd19}) | 
                             ({8{(REFLOCK[23]) & (REFTABLEUSE[23] == REFTABLEUNUSE[23])}} & {1'b1,7'd23}) | 
                             ({8{(REFLOCK[27]) & (REFTABLEUSE[27] == REFTABLEUNUSE[27])}} & {1'b1,7'd27}) | 
                             ({8{(REFLOCK[31]) & (REFTABLEUSE[31] == REFTABLEUNUSE[31])}} & {1'b1,7'd31}) | 
                             ({8{(REFLOCK[35]) & (REFTABLEUSE[35] == REFTABLEUNUSE[35])}} & {1'b1,7'd35}) | 
                             ({8{(REFLOCK[39]) & (REFTABLEUSE[39] == REFTABLEUNUSE[39])}} & {1'b1,7'd39}) | 
                             ({8{(REFLOCK[43]) & (REFTABLEUSE[43] == REFTABLEUNUSE[43])}} & {1'b1,7'd43}) | 
                             ({8{(REFLOCK[47]) & (REFTABLEUSE[47] == REFTABLEUNUSE[47])}} & {1'b1,7'd47}) | 
                             ({8{(REFLOCK[51]) & (REFTABLEUSE[51] == REFTABLEUNUSE[51])}} & {1'b1,7'd51}) | 
                             ({8{(REFLOCK[55]) & (REFTABLEUSE[55] == REFTABLEUNUSE[55])}} & {1'b1,7'd55}) | 
                             ({8{(REFLOCK[59]) & (REFTABLEUSE[59] == REFTABLEUNUSE[59])}} & {1'b1,7'd59}) | 
                             ({8{(REFLOCK[63]) & (REFTABLEUSE[63] == REFTABLEUNUSE[63])}} & {1'b1,7'd63}) | 
                             //{8{(REFLOCK[67]) & (REFTABLEUSE[67] == REFTABLEUNUSE[67])}} & {1'b1,7'd67} | 
                             ({8{(REFLOCK[67]) & (REFTABLEUSE[67] == REFTABLEUNUSE[67])}} & {1'b1,7'd67}) | 
                             ({8{(REFLOCK[71]) & (REFTABLEUSE[71] == REFTABLEUNUSE[71])}} & {1'b1,7'd71}) | 
                             ({8{(REFLOCK[75]) & (REFTABLEUSE[75] == REFTABLEUNUSE[75])}} & {1'b1,7'd75}) | 
                             ({8{(REFLOCK[79]) & (REFTABLEUSE[79] == REFTABLEUNUSE[79])}} & {1'b1,7'd79}) | 
                             ({8{(REFLOCK[83]) & (REFTABLEUSE[83] == REFTABLEUNUSE[83])}} & {1'b1,7'd83}) | 
                             ({8{(REFLOCK[87]) & (REFTABLEUSE[87] == REFTABLEUNUSE[87])}} & {1'b1,7'd87}) | 
                             ({8{(REFLOCK[91]) & (REFTABLEUSE[91] == REFTABLEUNUSE[91])}} & {1'b1,7'd91}) | 
                             ({8{(REFLOCK[95]) & (REFTABLEUSE[95] == REFTABLEUNUSE[95])}} & {1'b1,7'd95}) | 
                             ({8{(REFLOCK[99]) & (REFTABLEUSE[99] == REFTABLEUNUSE[99])}} & {1'b1,7'd99}) | 
                             ({8{(REFLOCK[103]) & (REFTABLEUSE[103] == REFTABLEUNUSE[103])}} & {1'b1,7'd103}) | 
                             ({8{(REFLOCK[107]) & (REFTABLEUSE[107] == REFTABLEUNUSE[107])}} & {1'b1,7'd107}) | 
                             ({8{(REFLOCK[111]) & (REFTABLEUSE[111] == REFTABLEUNUSE[111])}} & {1'b1,7'd111}) | 
                             ({8{(REFLOCK[115]) & (REFTABLEUSE[115] == REFTABLEUNUSE[115])}} & {1'b1,7'd115}) | 
                             ({8{(REFLOCK[119]) & (REFTABLEUSE[119] == REFTABLEUNUSE[119])}} & {1'b1,7'd119}) | 
                             ({8{(REFLOCK[123]) & (REFTABLEUSE[123] == REFTABLEUNUSE[123])}} & {1'b1,7'd123}) | 
                             ({8{(REFLOCK[127]) & (REFTABLEUSE[127] == REFTABLEUNUSE[127])}} & {1'b1,7'd127}) ;

    wire                    ToFreelistAble1 ;
    wire  [`ReNameRegBUs]   TOFreeListDate1 ;
    wire                    ToFreelistAble2 ;
    wire  [`ReNameRegBUs]   TOFreeListDate2 ;
    wire                    ToFreelistAble3 ;
    wire  [`ReNameRegBUs]   TOFreeListDate3 ;
    wire                    ToFreelistAble4 ;
    wire  [`ReNameRegBUs]   TOFreeListDate4 ;

 

    assign {ToFreelistAble1,TOFreeListDate1} = Index1Unuse[7] ? Index1Unuse : 
                                               Index2Unuse[7] ? Index2Unuse : 
                                               Index3Unuse[7] ? Index3Unuse : 
                                               Index4Unuse[7] ? Index4Unuse : {`EnableValue, 7'd0} ;

    assign {ToFreelistAble2,TOFreeListDate2} = ({Index4Unuse[7],Index3Unuse[7],Index2Unuse[7],Index1Unuse[7]} == 3) ? Index2Unuse :
                                               ({Index4Unuse[7],Index3Unuse[7],Index2Unuse[7],Index1Unuse[7]} == 5) ? Index3Unuse :
                                               ({Index4Unuse[7],Index3Unuse[7],Index2Unuse[7],Index1Unuse[7]} == 6) ? Index3Unuse :
                                               ({Index4Unuse[7],Index3Unuse[7],Index2Unuse[7],Index1Unuse[7]} == 7) ? Index2Unuse : 
                                               ({Index4Unuse[7],Index3Unuse[7],Index2Unuse[7],Index1Unuse[7]} == 9) ? Index4Unuse :
                                               ({Index4Unuse[7],Index3Unuse[7],Index2Unuse[7],Index1Unuse[7]} == 10) ? Index4Unuse :
                                               ({Index4Unuse[7],Index3Unuse[7],Index2Unuse[7],Index1Unuse[7]} == 11) ? Index2Unuse :
                                               ({Index4Unuse[7],Index3Unuse[7],Index2Unuse[7],Index1Unuse[7]} == 12) ? Index4Unuse :
                                               ({Index4Unuse[7],Index3Unuse[7],Index2Unuse[7],Index1Unuse[7]} == 13) ? Index3Unuse :
                                               ({Index4Unuse[7],Index3Unuse[7],Index2Unuse[7],Index1Unuse[7]} == 14) ? Index3Unuse :
                                               ({Index4Unuse[7],Index3Unuse[7],Index2Unuse[7],Index1Unuse[7]} == 15) ? Index2Unuse :{`EnableValue, 7'd0} ;

    assign {ToFreelistAble3,TOFreeListDate3} = ({Index4Unuse[7],Index3Unuse[7],Index2Unuse[7],Index1Unuse[7]} == 7)   ? Index3Unuse : 
                                               ({Index4Unuse[7],Index3Unuse[7],Index2Unuse[7],Index1Unuse[7]} == 11)  ? Index4Unuse :
                                               ({Index4Unuse[7],Index3Unuse[7],Index2Unuse[7],Index1Unuse[7]} == 13)  ? Index4Unuse :
                                               ({Index4Unuse[7],Index3Unuse[7],Index2Unuse[7],Index1Unuse[7]} == 14)  ? Index4Unuse :
                                               ({Index4Unuse[7],Index3Unuse[7],Index2Unuse[7],Index1Unuse[7]} == 15)  ? Index3Unuse :{`EnableValue, 7'd0} ;

   assign {ToFreelistAble4,TOFreeListDate4} =  ({Index4Unuse[7],Index3Unuse[7],Index2Unuse[7],Index1Unuse[7]} == 15)  ? Index3Unuse :{`EnableValue, 7'd0} ;

    reg    [`ReNameRegBUs]     RegWriteNum1    ;
    reg                        RegWriteAble1   ;
    reg    [`ReNameRegBUs]     RegWriteNum2    ;
    reg                        RegWriteAble2   ;
    reg    [`ReNameRegBUs]     RegWriteNum3    ;
    reg                        RegWriteAble3   ;
    reg    [`ReNameRegBUs]     RegWriteNum4    ;
    reg                        RegWriteAble4   ;

    always @(posedge Clk) begin
        if(!Rest) begin
            RegWriteAble1 <= `EnableValue ;
            RegWriteNum1  <= 7'd0         ;
            RegWriteAble2 <= `EnableValue ;
            RegWriteNum2  <= 7'd0         ;
            RegWriteAble3 <= `EnableValue ;
            RegWriteNum3  <= 7'd0         ;
            RegWriteAble4 <= `EnableValue ;
            RegWriteNum4  <= 7'd0         ;
        end
        else if(RefTableFLash) begin
            RegWriteAble1 <= `EnableValue ;
            RegWriteNum1  <= 7'd0         ;
            RegWriteAble2 <= `EnableValue ;
            RegWriteNum2  <= 7'd0         ;
            RegWriteAble3 <= `EnableValue ;
            RegWriteNum3  <= 7'd0         ;
            RegWriteAble4 <= `EnableValue ;
            RegWriteNum4  <= 7'd0         ;
        end 
        else begin
           RegWriteAble1 <= ~RefTableStop ? ToFreelistAble1 : `EnableValue ;
           RegWriteNum1  <= ~RefTableStop ? TOFreeListDate1 : 7'd0         ;
           RegWriteAble2 <= ~RefTableStop ? ToFreelistAble2 : `EnableValue ;
           RegWriteNum2  <= ~RefTableStop ? TOFreeListDate2 : 7'd0         ;
           RegWriteAble3 <= ~RefTableStop ? ToFreelistAble3 : `EnableValue ;
           RegWriteNum3  <= ~RefTableStop ? TOFreeListDate3 : 7'd0         ;
           RegWriteAble4 <= ~RefTableStop ? ToFreelistAble4 : `EnableValue ;
           RegWriteNum4  <= ~RefTableStop ? TOFreeListDate4 : 7'd0         ;
        end
    end

    assign WriteAble1 = RegWriteAble1 ;
    assign WriteNum1  = RegWriteNum1  ;
    assign WriteAble2 = RegWriteAble2 ;
    assign WriteNum2  = RegWriteNum2  ;
    assign WriteAble3 = RegWriteAble3 ;
    assign WriteNum3  = RegWriteNum3  ;
    assign WriteAble4 = RegWriteAble4 ;
    assign WriteNum4  = RegWriteNum4  ;



// complier use --unroll-stmts 100000
    integer i ;
    integer j ;
    always @(posedge Clk) begin
        if(!Rest) begin
            for (i = 0; i<32;i=i+1 ) begin
                REFTABLEUSE[i] <= 7'd0 ;
                REFLOCK    [i] <= 1'b0 ;
                REFTABLEUSE[i+32] <= 7'd0 ;
                REFLOCK    [i+32] <= 1'b0 ;
                REFTABLEUSE[i+64] <= 7'd0 ;
                REFLOCK    [i+64] <= 1'b0 ;
                REFTABLEUSE[i+96] <= 7'd0 ;
                REFLOCK    [i+96] <= 1'b0 ;
            end
        end
        else if(RefTableFLash) begin
            for (j = 0; j<32;j=j+1 ) begin
                REFTABLEUSE[i] <= 7'd0 ;
                REFLOCK    [i] <= 1'b0 ;
                REFTABLEUSE[i+32] <= 7'd0 ;
                REFLOCK    [i+32] <= 1'b0 ;
                REFTABLEUSE[i+64] <= 7'd0 ;
                REFLOCK    [i+64] <= 1'b0 ;
                REFTABLEUSE[i+96] <= 7'd0 ;
                REFLOCK    [i+96] <= 1'b0 ;
            end
        end
        else begin
            REFTABLEUSE[Inst1Src1Addr] <= (Inst1Src1Able  )? REFTABLEUSE[Inst1Src1Addr] + 1 : REFTABLEUSE[Inst1Src1Addr] ;
            REFTABLEUSE[Inst1Src2Addr] <= (Inst1Src2Able  )? REFTABLEUSE[Inst1Src2Addr] + 1 : REFTABLEUSE[Inst1Src2Addr] ;
            REFTABLEUSE[Inst2Src1Addr] <= (Inst2Src1Able  ) ? REFTABLEUSE[Inst2Src1Addr] + 1 : REFTABLEUSE[Inst2Src1Addr] ;
            REFTABLEUSE[Inst2Src2Addr] <= (Inst2Src2Able  ) ? REFTABLEUSE[Inst2Src2Addr] + 1 : REFTABLEUSE[Inst2Src2Addr] ;
            REFTABLEUSE[Inst3Src1Addr] <= (Inst3Src1Able  ) ? REFTABLEUSE[Inst3Src1Addr] + 1 : REFTABLEUSE[Inst3Src1Addr] ;
            REFTABLEUSE[Inst3Src2Addr] <= (Inst3Src2Able  ) ? REFTABLEUSE[Inst3Src2Addr] + 1 : REFTABLEUSE[Inst3Src2Addr] ;
            REFTABLEUSE[Inst4Src1Addr] <= (Inst4Src1Able  )  ? REFTABLEUSE[Inst4Src1Addr] + 1 : REFTABLEUSE[Inst4Src1Addr] ;
            REFTABLEUSE[Inst4Src2Addr] <= (Inst4Src2Able  ) ? REFTABLEUSE[Inst4Src2Addr] + 1 : REFTABLEUSE[Inst4Src2Addr] ;
            REFTABLEUSE[Inst1RdAddr]   <= (Inst1RdAble )   ? REFTABLEUSE[Inst1RdAddr]   + 1 : REFTABLEUSE[Inst1RdAddr]   ;
            REFTABLEUSE[Inst2RdAddr]   <= (Inst2RdAble )   ? REFTABLEUSE[Inst2RdAddr]   + 1 : REFTABLEUSE[Inst2RdAddr]   ;
            REFTABLEUSE[Inst3RdAddr]   <= (Inst3RdAble )   ? REFTABLEUSE[Inst3RdAddr]   + 1 : REFTABLEUSE[Inst3RdAddr]   ;
            REFTABLEUSE[Inst4RdAddr]   <= (Inst4RdAble )   ? REFTABLEUSE[Inst4RdAddr]   + 1 : REFTABLEUSE[Inst4RdAddr]   ;
            REFLOCK    [Lock1Addr]     <= (Lock1Able   )     ? REFLOCK    [Lock1Addr]     + 1 : REFLOCK    [Lock1Addr]     ;
            REFLOCK    [Lock2Addr]     <= (Lock2Able   )     ? REFLOCK    [Lock2Addr]     + 1 : REFLOCK    [Lock2Addr]     ;
            REFLOCK    [Lock3Addr]     <= (Lock3Able   )     ? REFLOCK    [Lock3Addr]     + 1 : REFLOCK    [Lock3Addr]     ;
            REFLOCK    [Lock4Addr]     <= (Lock4Able   )     ? REFLOCK    [Lock4Addr]     + 1 : REFLOCK    [Lock4Addr]     ;
            REFLOCK    [Index1Unuse[6:0]]   <=  (Index1Unuse[7] ) ? `EnableValue : REFLOCK    [Index1Unuse[6:0]]  ;
            REFTABLEUSE[Index1Unuse[6:0]]   <=  (Index1Unuse[7] ) ? 7'd0         : REFTABLEUSE[Index1Unuse[6:0]]  ;
            REFLOCK    [Index2Unuse[6:0]]   <=  (Index2Unuse[7] ) ? `EnableValue : REFLOCK    [Index2Unuse[6:0]]  ;
            REFTABLEUSE[Index2Unuse[6:0]]   <=  (Index2Unuse[7] ) ? 7'd0         : REFTABLEUSE[Index2Unuse[6:0]]  ;
            REFLOCK    [Index3Unuse[6:0]]   <=  (Index3Unuse[7] ) ? `EnableValue : REFLOCK    [Index3Unuse[6:0]]  ;
            REFTABLEUSE[Index3Unuse[6:0]]   <=  (Index3Unuse[7] ) ? 7'd0         : REFTABLEUSE[Index3Unuse[6:0]]  ;
            REFLOCK    [Index4Unuse[6:0]]   <=  (Index4Unuse[7] ) ? `EnableValue : REFLOCK    [Index4Unuse[6:0]]  ;
            REFTABLEUSE[Index4Unuse[6:0]]   <=  (Index4Unuse[7] ) ? 7'd0         : REFTABLEUSE[Index4Unuse[6:0]]  ;
        end 
        
    end

    always @(posedge Clk) begin
        if(!Rest) begin
            for (i = 0; i<32;i=i+1 ) begin
                REFTABLEUNUSE[i] <= 7'd0 ;
                REFTABLEUNUSE[i+32] <= 7'd0 ;
                REFTABLEUNUSE[i+64] <= 7'd0 ;
                REFTABLEUNUSE[i+96] <= 7'd0 ;
            end
        end
        else if(RefTableFLash) begin
           for (j = 0; j<32;j=j+1 ) begin
                REFTABLEUNUSE[i] <= 7'd0 ;
                REFTABLEUNUSE[i+32] <= 7'd0 ;
                REFTABLEUNUSE[i+64] <= 7'd0 ;
                REFTABLEUNUSE[i+96] <= 7'd0 ;
            end 
        end
        else begin
            REFTABLEUNUSE[Inst1Read1Addr] <= (Inst1Read1Able ) ? REFTABLEUNUSE[Inst1Read1Addr] + 1 : REFTABLEUNUSE[Inst1Read1Addr] ;
            REFTABLEUNUSE[Inst1Read2Addr] <= (Inst1Read2Able ) ? REFTABLEUNUSE[Inst1Read2Addr] + 1 : REFTABLEUNUSE[Inst1Read2Addr] ;
            REFTABLEUNUSE[Inst2Read1Addr] <= (Inst2Read1Able ) ? REFTABLEUNUSE[Inst2Read1Addr] + 1 : REFTABLEUNUSE[Inst2Read1Addr] ;
            REFTABLEUNUSE[Inst2Read2Addr] <= (Inst2Read2Able ) ? REFTABLEUNUSE[Inst2Read2Addr] + 1 : REFTABLEUNUSE[Inst2Read2Addr] ;
            REFTABLEUNUSE[Inst3Read1Addr] <= (Inst3Read1Able ) ? REFTABLEUNUSE[Inst3Read1Addr] + 1 : REFTABLEUNUSE[Inst3Read1Addr] ;
            REFTABLEUNUSE[Inst3Read2Addr] <= (Inst3Read2Able ) ? REFTABLEUNUSE[Inst3Read2Addr] + 1 : REFTABLEUNUSE[Inst3Read2Addr] ;
            REFTABLEUNUSE[Inst4Read1Addr] <= (Inst4Read1Able ) ? REFTABLEUNUSE[Inst4Read1Addr] + 1 : REFTABLEUNUSE[Inst4Read1Addr] ;
            REFTABLEUNUSE[Inst4Read2Addr] <= (Inst4Read2Able ) ? REFTABLEUNUSE[Inst4Read2Addr] + 1 : REFTABLEUNUSE[Inst4Read2Addr] ;
            REFTABLEUNUSE[WritBack1Addr]  <= (WritBack1Able ) ? REFTABLEUNUSE[WritBack1Addr]  + 1 : REFTABLEUNUSE[WritBack1Addr]  ;
            REFTABLEUNUSE[WritBack2Addr]  <= (WritBack2Able ) ? REFTABLEUNUSE[WritBack2Addr]  + 1 : REFTABLEUNUSE[WritBack2Addr]  ;
            REFTABLEUNUSE[WritBack3Addr]  <= (WritBack3Able ) ? REFTABLEUNUSE[WritBack3Addr]  + 1 : REFTABLEUNUSE[WritBack3Addr]  ;
            REFTABLEUNUSE[WritBack4Addr]  <= (WritBack4Able ) ? REFTABLEUNUSE[WritBack4Addr]  + 1 : REFTABLEUNUSE[WritBack4Addr]  ;
            REFTABLEUNUSE[WritBack5Addr]  <= (WritBack5Able ) ? REFTABLEUNUSE[WritBack5Addr]  + 1 : REFTABLEUNUSE[WritBack5Addr]  ;
            REFTABLEUNUSE[WritBack6Addr]  <= (WritBack6Able ) ? REFTABLEUNUSE[WritBack6Addr]  + 1 : REFTABLEUNUSE[WritBack6Addr]  ;
            REFTABLEUNUSE[WritBack7Addr]  <= (WritBack7Able ) ? REFTABLEUNUSE[WritBack7Addr]  + 1 : REFTABLEUNUSE[WritBack7Addr]  ;
            REFTABLEUNUSE[WritBack8Addr]  <= (WritBack8Able ) ? REFTABLEUNUSE[WritBack8Addr]  + 1 : REFTABLEUNUSE[WritBack8Addr]  ;
            REFTABLEUNUSE[Index1Unuse[6:0]] <= (Index1Unuse[7] ) ? 7'd0 : REFTABLEUNUSE[Index1Unuse[6:0]] ;
            REFTABLEUNUSE[Index2Unuse[6:0]] <= (Index2Unuse[7] ) ? 7'd0 : REFTABLEUNUSE[Index2Unuse[6:0]] ;
            REFTABLEUNUSE[Index3Unuse[6:0]] <= (Index3Unuse[7] ) ? 7'd0 : REFTABLEUNUSE[Index3Unuse[6:0]] ;
            REFTABLEUNUSE[Index4Unuse[6:0]] <= (Index4Unuse[7] ) ? 7'd0 : REFTABLEUNUSE[Index4Unuse[6:0]] ;
        end
    end

    
endmodule
`timescale 1ps/1ps
`include "../define.v"

module RenameArchTable (
    input        wire                                      Clk              ,
    input        wire                                      Rest             ,
    //for Ctrl
    input        wire                                      RATStop          ,
    input        wire                                      RATFlash         ,
    //output       wire                                      RATReq           ,
    //from freelist
    input        wire                                      Way1RdAble       ,
    input        wire        [`ArchRegBUs]                 Way1ArchAddr     ,
    input        wire        [`ReNameRegBUs]               Way1RdAddr       ,
    input        wire                                      Way2RdAble       ,
    input        wire        [`ArchRegBUs]                 Way2ArchAddr     ,
    input        wire        [`ReNameRegBUs]               Way2RdAddr       ,
    input        wire                                      Way3RdAble       ,
    input        wire        [`ArchRegBUs]                 Way3ArchAddr     ,
    input        wire        [`ReNameRegBUs]               Way3RdAddr       ,
    input        wire                                      Way4RdAble       ,
    input        wire        [`ArchRegBUs]                 Way4ArchAddr     ,
    input        wire        [`ReNameRegBUs]               Way4RdAddr       ,
    //from decode
    input        wire                                      Way1Src1Able     ,
    input        wire        [`ArchRegBUs]                 Way1Src1Addr     ,
    input        wire                                      Way1Src2Able     ,
    input        wire        [`ArchRegBUs]                 Way1Src2Addr     ,
    input        wire                                      Way2Src1Able     ,
    input        wire        [`ArchRegBUs]                 Way2Src1Addr     ,
    input        wire                                      Way2Src2Able     ,
    input        wire        [`ArchRegBUs]                 Way2Src2Addr     ,
    input        wire                                      Way3Src1Able     ,
    input        wire        [`ArchRegBUs]                 Way3Src1Addr     ,
    input        wire                                      Way3Src2Able     ,
    input        wire        [`ArchRegBUs]                 Way3Src2Addr     ,
    input        wire                                      Way4Src1Able     ,
    input        wire        [`ArchRegBUs]                 Way4Src1Addr     ,
    input        wire                                      Way4Src2Able     ,
    input        wire        [`ArchRegBUs]                 Way4Src2Addr     ,
    //to busytable
    //******************************************************************************//
    // rename stage need 1 cycle ,instraction other information should delay 1 cycle//
    //******************************************************************************// 
    output       wire                                      Out1Src1Able     , 
    output       wire                                      Out1Src1NoDate   , //虽然对于指令一来说这个信号没有用，但是我有强迫症。要保持平均。读者可删
    output       wire        [`ReNameRegBUs]               Out1Src1Addr     ,
    output       wire                                      Out1Src2Able     ,
    output       wire                                      Out1Src2NoDate   ,// and
    output       wire        [`ReNameRegBUs]               Out1Src2Addr     ,
    output       wire                                      Out1RdAble       ,
    output       wire        [`ReNameRegBUs]               Out1RdAddr       ,
    output       wire                                      Out2Src1Able     ,
    output       wire                                      Out2Src1NoDate   ,
    output       wire        [`ReNameRegBUs]               Out2Src1Addr     ,
    output       wire                                      Out2Src2Able     ,
    output       wire                                      Out2Src2NoDate   ,
    output       wire        [`ReNameRegBUs]               Out2Src2Addr     ,
    output       wire                                      Out2RdAble       ,
    output       wire        [`ReNameRegBUs]               Out2RdAddr       ,
    output       wire                                      Out3Src1Able     ,
    output       wire                                      Out3Src1NoDate   ,
    output       wire        [`ReNameRegBUs]               Out3Src1Addr     ,
    output       wire                                      Out3Src2Able     ,
    output       wire                                      Out3Src2NoDate   ,
    output       wire        [`ReNameRegBUs]               Out3Src2Addr     ,
    output       wire                                      Out3RdAble       ,
    output       wire        [`ReNameRegBUs]               Out3RdAddr       ,
    output       wire                                      Out4Src1Able     ,
    output       wire                                      Out4Src1NoDate   ,
    output       wire        [`ReNameRegBUs]               Out4Src1Addr     ,
    output       wire                                      Out4Src2Able     ,
    output       wire                                      Out4Src2NoDate   ,
    output       wire        [`ReNameRegBUs]               Out4Src2Addr     ,
    output       wire                                      Out4RdAble       ,
    output       wire        [`ReNameRegBUs]               Out4RdAddr       ,
    //to Reftable
    output       wire                                      Lock1Able        ,
    output       wire        [`ReNameRegBUs]               Lock1Addr        ,
    output       wire                                      Lock2Able        ,
    output       wire        [`ReNameRegBUs]               Lock2Addr        ,
    output       wire                                      Lock3Able        ,
    output       wire        [`ReNameRegBUs]               Lock3Addr        ,
    output       wire                                      Lock4Able        ,
    output       wire        [`ReNameRegBUs]               Lock4Addr        ,
    output       wire                                      Use1Able         ,
    output       wire        [`ReNameRegBUs]               Use1Addr         ,
    output       wire                                      Use2Able         ,
    output       wire        [`ReNameRegBUs]               Use2Addr         ,      
    output       wire                                      Use3Able         ,
    output       wire        [`ReNameRegBUs]               Use3Addr         ,
    output       wire                                      Use4Able         ,
    output       wire        [`ReNameRegBUs]               Use4Addr         ,  
    output       wire                                      Use5Able         ,
    output       wire        [`ReNameRegBUs]               Use5Addr         ,
    output       wire                                      Use6Able         ,
    output       wire        [`ReNameRegBUs]               Use6Addr         ,      
    output       wire                                      Use7Able         ,
    output       wire        [`ReNameRegBUs]               Use7Addr         ,
    output       wire                                      Use8Able         ,
    output       wire        [`ReNameRegBUs]               Use8Addr         ,  
    output       wire                                      Use9Able         ,
    output       wire        [`ReNameRegBUs]               Use9Addr         ,
    output       wire                                      Use10Able        ,
    output       wire        [`ReNameRegBUs]               Use10Addr        ,  
    output       wire                                      Use11Able        ,
    output       wire        [`ReNameRegBUs]               Use11Addr        ,
    output       wire                                      Use12Able        ,
    output       wire        [`ReNameRegBUs]               Use12Addr          

);

    reg   [6:0] RENAMETABLE [0:31] ;

    always @(posedge Clk) begin
        if(!Rest) begin
            RENAMETABLE[0] <= 7'd0 ;
            RENAMETABLE[1] <= 7'd1 ;
            RENAMETABLE[2] <= 7'd2 ;
            RENAMETABLE[3] <= 7'd3 ;
            RENAMETABLE[4] <= 7'd4 ;
            RENAMETABLE[5] <= 7'd5 ;
            RENAMETABLE[6] <= 7'd6 ;
            RENAMETABLE[7] <= 7'd7 ;
            RENAMETABLE[8] <= 7'd8 ;
            RENAMETABLE[9] <= 7'd9 ;
            RENAMETABLE[10] <= 7'd10 ;
            RENAMETABLE[11] <= 7'd11 ;
            RENAMETABLE[12] <= 7'd12 ;
            RENAMETABLE[13] <= 7'd13 ;
            RENAMETABLE[14] <= 7'd14 ;
            RENAMETABLE[15] <= 7'd15 ;
            RENAMETABLE[16] <= 7'd16 ;
            RENAMETABLE[17] <= 7'd17 ;
            RENAMETABLE[18] <= 7'd18 ;
            RENAMETABLE[19] <= 7'd19 ;
            RENAMETABLE[20] <= 7'd20 ;
            RENAMETABLE[21] <= 7'd21 ;
            RENAMETABLE[22] <= 7'd22 ;
            RENAMETABLE[23] <= 7'd23 ;
            RENAMETABLE[24] <= 7'd24 ;
            RENAMETABLE[25] <= 7'd25 ;
            RENAMETABLE[26] <= 7'd26 ;
            RENAMETABLE[27] <= 7'd27 ;
            RENAMETABLE[28] <= 7'd28 ;
            RENAMETABLE[29] <= 7'd29 ;
            RENAMETABLE[30] <= 7'd30 ;
            RENAMETABLE[31] <= 7'd31 ;
        end 
        else if(RATFlash) begin
            RENAMETABLE[0] <= 7'd0 ;
            RENAMETABLE[1] <= 7'd1 ;
            RENAMETABLE[2] <= 7'd2 ;
            RENAMETABLE[3] <= 7'd3 ;
            RENAMETABLE[4] <= 7'd4 ;
            RENAMETABLE[5] <= 7'd5 ;
            RENAMETABLE[6] <= 7'd6 ;
            RENAMETABLE[7] <= 7'd7 ;
            RENAMETABLE[8] <= 7'd8 ;
            RENAMETABLE[9] <= 7'd9 ;
            RENAMETABLE[10] <= 7'd10 ;
            RENAMETABLE[11] <= 7'd11 ;
            RENAMETABLE[12] <= 7'd12 ;
            RENAMETABLE[13] <= 7'd13 ;
            RENAMETABLE[14] <= 7'd14 ;
            RENAMETABLE[15] <= 7'd15 ;
            RENAMETABLE[16] <= 7'd16 ;
            RENAMETABLE[17] <= 7'd17 ;
            RENAMETABLE[18] <= 7'd18 ;
            RENAMETABLE[19] <= 7'd19 ;
            RENAMETABLE[20] <= 7'd20 ;
            RENAMETABLE[21] <= 7'd21 ;
            RENAMETABLE[22] <= 7'd22 ;
            RENAMETABLE[23] <= 7'd23 ;
            RENAMETABLE[24] <= 7'd24 ;
            RENAMETABLE[25] <= 7'd25 ;
            RENAMETABLE[26] <= 7'd26 ;
            RENAMETABLE[27] <= 7'd27 ;
            RENAMETABLE[28] <= 7'd28 ;
            RENAMETABLE[29] <= 7'd29 ;
            RENAMETABLE[30] <= 7'd30 ;
            RENAMETABLE[31] <= 7'd31 ;
        end
        else begin
           RENAMETABLE[Way1ArchAddr] <= Way1Src1Able ? Way1RdAddr : RENAMETABLE[Way1ArchAddr] ;
           RENAMETABLE[Way1ArchAddr] <= Way2Src1Able ? Way2RdAddr : RENAMETABLE[Way1ArchAddr] ;
           RENAMETABLE[Way1ArchAddr] <= Way3Src1Able ? Way3RdAddr : RENAMETABLE[Way1ArchAddr] ;
           RENAMETABLE[Way1ArchAddr] <= Way4Src1Able ? Way4RdAddr : RENAMETABLE[Way1ArchAddr] ;
        end
    end

    reg                   RegLock1Able ;
    reg  [`ReNameRegBUs]  RegLock1Addr ;
    reg                   RegLock2Able ;
    reg  [`ReNameRegBUs]  RegLock2Addr ;
    reg                   RegLock3Able ;
    reg  [`ReNameRegBUs]  RegLock3Addr ;
    reg                   RegLock4Able ;
    reg  [`ReNameRegBUs]  RegLock4Addr ;
    always @(posedge Clk) begin
        if(!Rest) begin
            RegLock1Able <= `EnableValue ;
            RegLock1Addr <= 7'd0         ;
            RegLock2Able <= `EnableValue ;
            RegLock2Addr <= 7'd0         ;
            RegLock3Able <= `EnableValue ;
            RegLock3Addr <= 7'd0         ;
            RegLock4Able <= `EnableValue ;
            RegLock4Addr <= 7'd0         ;
        end
        else if(RATFlash) begin
            RegLock1Able <= `EnableValue ;
            RegLock1Addr <= 7'd0         ;
            RegLock2Able <= `EnableValue ;
            RegLock2Addr <= 7'd0         ;
            RegLock3Able <= `EnableValue ;
            RegLock3Addr <= 7'd0         ;
            RegLock4Able <= `EnableValue ;
            RegLock4Addr <= 7'd0         ;
        end
        else if(RATStop) begin
            RegLock1Able <= RegLock1Able ;
            RegLock1Addr <= RegLock1Addr ;
            RegLock2Able <= RegLock2Able ;
            RegLock2Addr <= RegLock2Addr ;
            RegLock3Able <= RegLock3Able ;
            RegLock3Addr <= RegLock3Addr ;
            RegLock4Able <= RegLock4Able ;
            RegLock4Addr <= RegLock4Addr ;
        end
        else begin
            RegLock1Able <= ~RATStop ? Way1RdAble : `EnableValue         ;
            RegLock1Addr <= ~RATStop ? RENAMETABLE[Way1ArchAddr] : 7'd0  ;
            RegLock2Able <= ~RATStop ? Way2RdAble : `EnableValue         ;
            RegLock2Addr <= ~RATStop ? RENAMETABLE[Way2ArchAddr] : 7'd0  ;
            RegLock3Able <= ~RATStop ? Way3RdAble : `EnableValue         ;
            RegLock3Addr <= ~RATStop ? RENAMETABLE[Way3ArchAddr] : 7'd0  ;
            RegLock4Able <= ~RATStop ? Way4RdAble : `EnableValue         ;
            RegLock4Addr <= ~RATStop ? RENAMETABLE[Way4ArchAddr] : 7'd0  ;
        end
    end

    assign Lock1Able = RegLock1Able ; 
    assign Lock1Addr = RegLock1Addr ;
    assign Lock2Able = RegLock2Able ; 
    assign Lock2Addr = RegLock2Addr ;
    assign Lock3Able = RegLock3Able ; 
    assign Lock3Addr = RegLock3Addr ;
    assign Lock4Able = RegLock4Able ; 
    assign Lock4Addr = RegLock4Addr ;

    reg                   RegOut1Src1Able   ;
    reg                   RegOut1Src1NoDate ;
    reg  [`ReNameRegBUs]  RegOut1Src1Addr   ;  
    reg                   RegOut1Src2Able   ;
    reg                   RegOut1Src2NoDate ;
    reg  [`ReNameRegBUs]  RegOut1Src2Addr   ; 
    reg                   RegOut1RdAble     ;
    reg  [`ReNameRegBUs]  RegOut1RdAddr     ;
    reg                   RegOut2Src1Able   ;
    reg                   RegOut2Src1NoDate ;
    reg  [`ReNameRegBUs]  RegOut2Src1Addr   ;  
    reg                   RegOut2Src2Able   ;
    reg                   RegOut2Src2NoDate ;
    reg  [`ReNameRegBUs]  RegOut2Src2Addr   ; 
    reg                   RegOut2RdAble     ;
    reg  [`ReNameRegBUs]  RegOut2RdAddr     ;
    reg                   RegOut3Src1Able   ;
    reg                   RegOut3Src1NoDate ;
    reg  [`ReNameRegBUs]  RegOut3Src1Addr   ;  
    reg                   RegOut3Src2Able   ;
    reg                   RegOut3Src2NoDate ;
    reg  [`ReNameRegBUs]  RegOut3Src2Addr   ; 
    reg                   RegOut3RdAble     ;
    reg  [`ReNameRegBUs]  RegOut3RdAddr     ;
    reg                   RegOut4Src1Able   ;
    reg                   RegOut4Src1NoDate ;
    reg  [`ReNameRegBUs]  RegOut4Src1Addr   ;  
    reg                   RegOut4Src2Able   ; 
    reg                   RegOut4Src2NoDate ;
    reg  [`ReNameRegBUs]  RegOut4Src2Addr   ; 
    reg                   RegOut4RdAble     ;
    reg  [`ReNameRegBUs]  RegOut4RdAddr     ;

    always @(posedge Clk) begin
        if(!Rest) begin
            RegOut1Src1Able   <= `EnableValue ;
            RegOut1Src1NoDate <= `EnableValue ;
            RegOut1Src1Addr   <= 7'd0         ;
            RegOut1Src2Able   <= `EnableValue ;
            RegOut1Src2NoDate <= `EnableValue ;
            RegOut1Src2Addr   <= 7'd0         ;
            RegOut1RdAble     <= `EnableValue ;
            RegOut1RdAddr     <= 7'd0         ;
            RegOut2Src1Able   <= `EnableValue ;
            RegOut2Src1NoDate <= `EnableValue ;
            RegOut2Src1Addr   <= 7'd0         ;
            RegOut2Src2Able   <= `EnableValue ;
            RegOut2Src2NoDate <= `EnableValue ;
            RegOut2Src2Addr   <= 7'd0         ;
            RegOut2RdAble     <= `EnableValue ;
            RegOut2RdAddr     <= 7'd0         ;
            RegOut3Src1Able   <= `EnableValue ;
            RegOut3Src1NoDate <= `EnableValue ;
            RegOut3Src1Addr   <= 7'd0         ;
            RegOut3Src2Able   <= `EnableValue ;
            RegOut3Src2NoDate <= `EnableValue ;
            RegOut3Src2Addr   <= 7'd0         ;
            RegOut3RdAble     <= `EnableValue ;
            RegOut3RdAddr     <= 7'd0         ;
            RegOut4Src1Able   <= `EnableValue ;
            RegOut4Src1NoDate <= `EnableValue ;
            RegOut4Src1Addr   <= 7'd0         ;
            RegOut4Src2Able   <= `EnableValue ;
            RegOut4Src2NoDate <= `EnableValue ;
            RegOut4Src2Addr   <= 7'd0         ;
            RegOut4RdAble     <= `EnableValue ;
            RegOut4RdAddr     <= 7'd0         ;
        end  
        else if(RATFlash) begin
            RegOut1Src1Able   <= `EnableValue ;
            RegOut1Src1NoDate <= `EnableValue ;
            RegOut1Src1Addr   <= 7'd0         ;
            RegOut1Src2Able   <= `EnableValue ;
            RegOut1Src2NoDate <= `EnableValue ;
            RegOut1Src2Addr   <= 7'd0         ;
            RegOut1RdAble     <= `EnableValue ;
            RegOut1RdAddr     <= 7'd0         ;
            RegOut2Src1Able   <= `EnableValue ;
            RegOut2Src1NoDate <= `EnableValue ;
            RegOut2Src1Addr   <= 7'd0         ;
            RegOut2Src2Able   <= `EnableValue ;
            RegOut2Src2NoDate <= `EnableValue ;
            RegOut2Src2Addr   <= 7'd0         ;
            RegOut2RdAble     <= `EnableValue ;
            RegOut2RdAddr     <= 7'd0         ;
            RegOut3Src1Able   <= `EnableValue ;
            RegOut3Src1NoDate <= `EnableValue ;
            RegOut3Src1Addr   <= 7'd0         ;
            RegOut3Src2Able   <= `EnableValue ;
            RegOut3Src2NoDate <= `EnableValue ;
            RegOut3Src2Addr   <= 7'd0         ;
            RegOut3RdAble     <= `EnableValue ;
            RegOut3RdAddr     <= 7'd0         ;
            RegOut4Src1Able   <= `EnableValue ;
            RegOut4Src1NoDate <= `EnableValue ;
            RegOut4Src1Addr   <= 7'd0         ;
            RegOut4Src2Able   <= `EnableValue ;
            RegOut4Src2NoDate <= `EnableValue ;
            RegOut4Src2Addr   <= 7'd0         ;
            RegOut4RdAble     <= `EnableValue ;
            RegOut4RdAddr     <= 7'd0         ;
        end
        else if(RATStop) begin
            RegOut1Src1Able   <= RegOut1Src1Able   ;
            RegOut1Src1NoDate <= RegOut1Src1NoDate ;
            RegOut1Src1Addr   <= RegOut1Src1Addr   ;
            RegOut1Src2Able   <= RegOut1Src2Able   ;
            RegOut1Src2NoDate <= RegOut1Src2NoDate ;
            RegOut1Src2Addr   <= RegOut1Src2Addr   ;
            RegOut1RdAble     <= RegOut1RdAble     ;
            RegOut1RdAddr     <= RegOut1RdAddr     ;
            RegOut2Src1Able   <= RegOut2Src1Able   ;
            RegOut2Src1NoDate <= RegOut2Src1NoDate ;
            RegOut2Src1Addr   <= RegOut2Src1Addr   ;
            RegOut2Src2Able   <= RegOut2Src2Able   ;
            RegOut2Src2NoDate <= RegOut2Src2NoDate ;
            RegOut2Src2Addr   <= RegOut2Src2Addr   ;
            RegOut2RdAble     <= RegOut2RdAble     ;
            RegOut2RdAddr     <= RegOut2RdAddr     ;
            RegOut3Src1Able   <= RegOut3Src1Able   ;
            RegOut3Src1NoDate <= RegOut3Src1NoDate ;
            RegOut3Src1Addr   <= RegOut3Src1Addr   ;
            RegOut3Src2Able   <= RegOut3Src2Able   ;
            RegOut3Src2NoDate <= RegOut3Src2NoDate ;
            RegOut3Src2Addr   <= RegOut3Src2Addr   ;
            RegOut3RdAble     <= RegOut3RdAble     ;
            RegOut3RdAddr     <= RegOut3RdAddr     ;
            RegOut4Src1Able   <= RegOut4Src1Able   ;
            RegOut4Src1NoDate <= RegOut4Src1NoDate ;
            RegOut4Src1Addr   <= RegOut4Src1Addr   ;
            RegOut4Src2Able   <= RegOut4Src2Able   ;
            RegOut4Src2NoDate <= RegOut4Src2NoDate ;
            RegOut4Src2Addr   <= RegOut4Src2Addr   ;
            RegOut4RdAble     <= RegOut4RdAble     ;
            RegOut4RdAddr     <= RegOut4RdAddr     ;
        end
        else begin
            RegOut1Src1Able                     <= (Way1Src1Able ) ;
            {RegOut1Src1NoDate,RegOut1Src1Addr} <= (Way1Src1Able ) ? {`EnableValue,RENAMETABLE[Way1Src1Addr]} : {`EnableValue,7'd0} ;
            RegOut1Src2Able                     <= (Way1Src2Able ) ;
            {RegOut1Src2NoDate,RegOut1Src2Addr} <= (Way1Src2Able ) ? {`EnableValue,RENAMETABLE[Way1Src2Addr]} : {`EnableValue,7'd0} ;
            RegOut1RdAble                       <= (Way1RdAble   ) ; 
            RegOut1RdAddr                       <= (Way1RdAble   ) ? Way1RdAddr : 7'd0                ;
            RegOut2Src1Able                     <= (Way2Src1Able ) ;
            {RegOut2Src1NoDate,RegOut2Src1Addr} <= (Way2Src1Able ) ? (((Way2Src1Addr == Way1ArchAddr) & Way1RdAble) ? {`AbleValue,Way1RdAddr} : {`EnableValue,RENAMETABLE[Way2Src1Addr]}) : {`EnableValue,7'd0} ;
            RegOut2Src2Able                     <= (Way2Src2Able ) ;
            {RegOut2Src2NoDate,RegOut2Src2Addr} <= (Way2Src2Able ) ? (((Way2Src2Addr == Way1ArchAddr) & Way1RdAble) ? {`AbleValue,Way1RdAddr} : {`EnableValue,RENAMETABLE[Way2Src2Addr]}) : {`EnableValue,7'd0} ;
            RegOut2RdAble                       <= (Way2RdAble   ) ; 
            RegOut2RdAddr                       <= (Way2RdAble   ) ? Way2RdAddr : 7'd0                ;
            RegOut3Src1Able                     <= (Way3Src1Able ) ;
            {RegOut3Src1NoDate,RegOut3Src1Addr} <= (Way3Src1Able ) ? (((Way3Src1Addr == Way2ArchAddr) & Way2RdAble) ? {`AbleValue,Way2RdAddr} :
                                                                      ((Way3Src1Addr == Way1ArchAddr) & Way1RdAble) ? {`AbleValue,Way1RdAddr} : {`EnableValue,RENAMETABLE[Way3Src1Addr]}) : {`EnableValue,7'd0} ;
            RegOut3Src2Able                     <= (Way3Src2Able ) ;
            {RegOut3Src2NoDate,RegOut3Src2Addr} <= (Way3Src2Able ) ? (((Way3Src2Addr == Way2ArchAddr) & Way2RdAble) ? {`AbleValue,Way2RdAddr} :
                                                                      ((Way3Src2Addr == Way1ArchAddr) & Way1RdAble) ? {`AbleValue,Way1RdAddr} : {`EnableValue,RENAMETABLE[Way3Src2Addr]}) : {`EnableValue,7'd0} ;
            RegOut3RdAble                       <= (Way3RdAble   ) ; 
            RegOut3RdAddr                       <= (Way3RdAble   ) ? Way3RdAddr : 7'd0                ;
            RegOut4Src1Able                     <= (Way4Src1Able ) ;
            {RegOut4Src1NoDate,RegOut4Src1Addr} <= (Way4Src1Able ) ? (((Way3Src1Addr == Way3ArchAddr) & Way3RdAble) ? {`AbleValue,Way3RdAddr} :
                                                                      ((Way3Src1Addr == Way2ArchAddr) & Way2RdAble) ? {`AbleValue,Way2RdAddr} :
                                                                      ((Way3Src1Addr == Way1ArchAddr) & Way1RdAble) ? {`AbleValue,Way1RdAddr} : {`EnableValue,RENAMETABLE[Way4Src1Addr]}) : {`EnableValue,7'd0} ;
            RegOut4Src2Able                     <= (Way4Src2Able ) ;
            {RegOut4Src2NoDate,RegOut4Src2Addr} <= (Way4Src2Able ) ? (((Way3Src2Addr == Way3ArchAddr) & Way3RdAble) ? {`AbleValue,Way3RdAddr} :
                                                                      ((Way3Src2Addr == Way2ArchAddr) & Way2RdAble) ? {`AbleValue,Way2RdAddr} :
                                                                      ((Way3Src2Addr == Way1ArchAddr) & Way1RdAble) ? {`AbleValue,Way1RdAddr} : {`EnableValue,RENAMETABLE[Way4Src2Addr]}) : {`EnableValue,7'd0} ;
            RegOut4RdAble                       <= (Way4RdAble   ) ; 
            RegOut4RdAddr                       <= (Way4RdAble   ) ? Way4RdAddr : 7'd0                ;
        end
    end


    assign  Out1Src1Able   = RegOut1Src1Able ;
    assign  Out1Src1NoDate = RegOut1Src1NoDate ;
    assign  Out1Src1Addr   = RegOut1Src1Addr ;
    assign  Out1Src2Able   = RegOut1Src2Able ;
    assign  Out1Src2NoDate = RegOut1Src2NoDate ;
    assign  Out1Src2Addr   = RegOut1Src2Addr ; 
    assign  Out1RdAble     = RegOut1RdAble   ;
    assign  Out1RdAddr     = RegOut1RdAddr   ;
    assign  Out2Src1Able   = RegOut2Src1Able ;
    assign  Out2Src1NoDate = RegOut2Src1NoDate ;
    assign  Out2Src1Addr   = RegOut2Src1Addr ;  
    assign  Out2Src2Able   = RegOut2Src2Able ;
    assign  Out2Src2NoDate = RegOut2Src2NoDate ;
    assign  Out2Src2Addr   = RegOut2Src2Addr ; 
    assign  Out2RdAble     = RegOut2RdAble   ;
    assign  Out2RdAddr     = RegOut2RdAddr   ;
    assign  Out3Src1Able   = RegOut3Src1Able ;
    assign  Out3Src1NoDate = RegOut3Src1NoDate ;
    assign  Out3Src1Addr   = RegOut3Src1Addr ;  
    assign  Out3Src2Able   = RegOut3Src2Able ;
    assign  Out3Src2NoDate = RegOut3Src2NoDate ;
    assign  Out3Src2Addr   = RegOut3Src2Addr ; 
    assign  Out3RdAble     = RegOut3RdAble   ;
    assign  Out3RdAddr     = RegOut3RdAddr   ;
    assign  Out4Src1Able   = RegOut4Src1Able ;
    assign  Out4Src1NoDate = RegOut4Src1NoDate ;
    assign  Out4Src1Addr   = RegOut4Src1Addr ;  
    assign  Out4Src2Able   = RegOut4Src2Able ;
    assign  Out4Src2NoDate = RegOut4Src2NoDate ;
    assign  Out4Src2Addr   = RegOut4Src2Addr ; 
    assign  Out4RdAble     = RegOut4RdAble   ;
    assign  Out4RdAddr     = RegOut4RdAddr   ;


    assign Use1Able  = RegOut1Src1Able ;
    assign Use1Addr  = RegOut1Src1Addr ;
    assign Use2Able  = RegOut1Src2Able ;
    assign Use2Addr  = RegOut1Src2Addr ;
    assign Use3Able  = RegOut1RdAble   ;
    assign Use3Addr  = RegOut1RdAddr   ;
    assign Use4Able  = RegOut2Src1Able ;
    assign Use4Addr  = RegOut2Src1Addr ;
    assign Use5Able  = RegOut2Src2Able ;
    assign Use5Addr  = RegOut2Src2Addr ;
    assign Use6Able  = RegOut2RdAble   ;
    assign Use6Addr  = RegOut2RdAddr   ;
    assign Use7Able  = RegOut3Src1Able ;
    assign Use7Addr  = RegOut3Src1Addr ;
    assign Use8Able  = RegOut3Src2Able ;
    assign Use8Addr  = RegOut3Src2Addr ;
    assign Use9Able  = RegOut3RdAble   ;
    assign Use9Addr  = RegOut3RdAddr   ;
    assign Use10Able  = RegOut4Src1Able ;
    assign Use10Addr  = RegOut4Src1Addr ;
    assign Use11Able  = RegOut4Src2Able ;
    assign Use11Addr  = RegOut4Src2Addr ;
    assign Use12Able  = RegOut4RdAble   ;
    assign Use12Addr  = RegOut4RdAddr   ;
    
endmodule
// All 
`define _Entry         32'h80000000
`define InstAddrBus        31:0
`define TwoInstAddrBus     31:0*2
`define InstDateBus        31:0
`define TwoInstDateBus     31:0*2 
`define AbleValue          1'b1 
`define EnableValue        1'b0
`define ZeroBoothDate   68'h0
`define ZeorDate        32'h0
`define FzeroDate       64'h0

//if stage
`define StartAddr       32'h0000*2

//Multiplier
`define DataBus         31:0
`define MulDateTempt    34:0
`define MicOperateCode  7:0
`define MulStateBus     2:0
`define MulIdle         3'b000
`define L1MulWallec     3'b010
`define L2MulWallec     3'b011
`define L3MulWallec     3'b100 
`define MulOutDate      3'b101 
`define MulBoothBus     32:0
// `define BoothCodeBus    2:0
// `define BoothCodeP0     3'b000
// `define BoothCodep1     3'b001 
// `define BoothCodeP2     3'b010 
// `define BoothCoden1     3'b011    
// `define BoothCoden2     3'b100

//Decode Mic Operate
`define ReNameRegBUs   6:0
`define ArchRegBUs     4:0
`define InstMulw       8'h00000001
`define InstMulHw      8'h00000010
`define InstMulHuw     8'h00000011  
`define InstAddw       8'b00000100
`define InstSubw       8'b00000101 //关于此处指令全部都需要进行更改
`define InstAddiw      8'b00000110
`define InstLu12iw     8'b00000111
`define InstSlt        8'b00001000
`define InstSltu       8'b00001001
`define InstSlti       8'b00001010
`define InstSltui      8'b00001011
`define InstAddu12i    8'b00001100
`define InstAnd        8'b00001101 
`define InstOr         8'b00001110 
`define InstNor        8'b00001111
`define InstXor        8'b00010000 
`define InstAndi       8'b00010001 
`define InstOri        8'b00010010 
`define InstXori       8'b00010011 
`define InstSllw       8'b00010100 
`define InstSrlw       8'b00010101 
`define InstSraw       8'b00010110 
`define InstSlliw      8'b00010111 
`define InstSrliw      8'b00011000 
`define InstSraiw      8'b00011001 
`define InstBeq        8'b00011010 
`define InstBne        8'b00011011 
`define InstBlt        8'b00011100 
`define InstBge        8'b00011101 
`define InstBltu       8'b00011110 
`define InstBgeu       8'b00011111 
`define InstB          8'b00100000 
`define InstBl         8'b00100001 
`define InstJirl       8'b00100010 
`define InstDivw       8'b00100011 
`define InstDivwu      8'b00100100 
`define InstModw       8'b00100101 
`define InstModwu      8'b00100110 
`define InstCsrrd      8'b00100111 
`define InstSyscall    8'b10101000
`define InstBreak      8'b00101001 
`define InstCsrwr      8'b00101000 
`define InstCsrxchg    8'b10101001 
`define InstCacop      8'b00101010 
//inst divid
`define InstTlbsrchr   8'b00101011 
`define InstTlbsrchw   8'b10000010
`define InstTlbrd     8'b00101100 
`define InstTlbwr      8'b00110001 
`define InstTlbfill    8'b00101101 
`define InstInvtlb     8'b00101110 
`define InstEntry      8'b00101111 
`define InstIdle       8'b00110000 
//load or store
`define InstLdb        8'b00110001 
`define InstLdh        8'b00110010 
`define InstLdw        8'b00110011 
`define InstLdbu       8'b00110100 
`define InstLdhu       8'b00110101 
`define InstStb        8'b00110110 
`define InstSth        8'b00110111 
`define InstStw        8'b00111000 
`define InstLlw        8'b00111001 
`define InstScw        8'b00111010 
`define InstDbar       8'b00111011 
`define InstIbar       8'b00111100 
`define InstPreld      8'b00111101

//time read inst
`define InstRdcntvlw   8'b00111101 
`define InstRdcntvhw   8'b00111110 
`define InstRdcntid    8'b00111111 






//Flot alu module
`define FlotRNE        2'd0
`define FLotRZ         2'd1
`define FlotRP         2'd2 
`define FlotRM         2'd3 

//for div
`define PosiQuit2      3'b000
`define PosiQuit1      3'b001 
`define ZeroQuit0      3'b010 
`define NegiQuit1      3'b011 
`define NegiQuit2      3'b100

`define DivIdle        3'b001 
`define DivItir        3'b010
`define DivOut         3'b100 

//for BTB
`define BTBTageBus     18:0

//for Tage
`define TageGHRBus     63:0

//for pre decode state
`define TypeCALL       3'b100
`define TypeRTURN      3'b001 
`define TypeDIRECTB    3'b010 
`define TypeBRANCH     3'b011 
`define TypeFORMAL     3'b000
`define JumpAble       1'b1 
`define JumpEnbale     1'b0  

//for Csr
`define CsrWMaskAll    32'hffffffff

//for ROB 
`define ROBLineNumBus  6:0

//for csr
`define PLV  1:0
`define IE   2:2
`define DA   3:3
`define PG   4:4 
`define DATF 6:5
`define DATM 8:7
`define SAVE 31:9
`define PPLV 1:0
`define PIE  2:2

`define INT  7'h0 
`define PIL  7'h1
`define PIS  7'h2
`define PIF  7'h3 
`define PME  7'h4 
`define PPI  7'h7 
`define ADEF {1'b0, 6'h8} 
`define ADEM {1'b1, 6'h8}
`define ALE  7'h9 
`define SYS  7'hb 
`define BRK  7'hc 
`define INE  7'hd 
`define IPE  7'he 
`define FPD  7'hf 
`define FPE  7'h12 
`define TLBR 7'h3f

`define IS1_0   1:0
`define IS9_2   9:2 
`define IS11    11:11
`define IS12    12:12
`define ECODE   21:16
`define ESUBCODE 30:22

`define ROLLB 0
`define WCLLB 1
`define KLO   2

`define INDEX 5:0
`define PS    29:24
`define NE    31

`define EN    0
`define PERIODIC 1
`define INITVAL 31:2

`define CLR 0

`define ALUCODE 3'b001 
`define MULCODE 3'b011
`define DIVCODE 3'b010 
`define BRCODE  3'b111 
`define CSRCODE 3'b100
`define LSUCODE 3'b101 
`define SPECIAL 3'b000

`timescale 1ps/1ps
`include "define.v"

module mycpu_top (
    input      wire                         aclk       ,
    input      wire                         aresetn    ,
    input      wire    [ 7:0]               intrpt     , 
    //AXI interface 
    //read reqest
    output     wire    [ 3:0]               arid       ,
    output     wire    [31:0]               araddr     ,
    output     wire    [ 7:0]               arlen      ,
    output     wire    [ 2:0]               arsize     ,
    output     wire    [ 1:0]               arburst    ,
    output     wire    [ 1:0]               arlock     ,
    output     wire    [ 3:0]               arcache    ,
    output     wire    [ 2:0]               arprot     ,
    output     wire                         arvalid    ,
    input      wire                         arready    ,
    //read back
    input      wire    [ 3:0]               rid        ,
    input      wire    [31:0]               rdata      ,
    input      wire    [ 1:0]               rresp      ,
    input      wire                         rlast      ,
    input      wire                         rvalid     ,
    output     wire                         rready     , 
    //write request
    output     wire    [ 3:0]               awid       ,
    output     wire    [31:0]               awaddr     ,
    output     wire    [ 7:0]               awlen      ,
    output     wire    [ 2:0]               awsize     ,
    output     wire    [ 1:0]               awburst    ,
    output     wire    [ 1:0]               awlock     ,
    output     wire    [ 3:0]               awcache    ,
    output     wire    [ 2:0]               awprot     ,
    output     wire                         awvalid    ,
    input      wire                         awready    ,
    //write data
    output     wire    [ 3:0]               wid        ,
    output     wire    [31:0]               wdata      ,
    output     wire    [ 3:0]               wstrb      ,
    output     wire                         wlast      ,
    output     wire                         wvalid     ,
    input      wire                         wready     ,
    //write back
    input      wire    [ 3:0]               bid        ,
    input      wire    [ 1:0]               bresp      ,
    input      wire                         bvalid     , 
    output     wire                         bready     ,
    //debug
    input      wire                         break_point,
    input      wire                         infor_flag ,
    input      wire    [ 4:0]               reg_num    ,
    output     wire                         ws_valid   ,
    output     wire    [31:0]               rf_rdata   ,

    output     wire    [31:0]               debug0_wb_pc,
    output     wire    [ 3:0]               debug0_wb_rf_wen,
    output     wire    [ 4:0]               debug0_wb_rf_wnum,
    output     wire    [31:0]               debug0_wb_rf_wdata,
    output     wire    [31:0]               debug0_wb_inst

);
    wire Clk  = aclk    ;
    wire Rest = aresetn ;

    wire                    PcOutAble ;
    wire [`InstAddrBus]     PcOutPc   ;
    //for btb
    wire                    BtbPcAble ;
    wire [`InstAddrBus]     BtbPc     ;
    wire [2:0]              BtbType   ;
    wire [1:0]              BtbBanN   ;

    //for ctrl
    wire                    CtrlPreReq ;
    wire                    CtrlFTQReq ;
    wire                    CtrlIcReq  ;
    wire                    CtrlBpReq  ;

    wire                    CtrlToPcStop   ;
    wire                    CtrlToBtbStop  ;
    wire                    CtrlToBtbFlash ;
    wire                    CtrlToTageStop ;
    wire                    CtrlToTageFLash;
    wire                    CtrlTORasStop  ;
    wire                    CtrlToRasFlash ;
    wire                    CtrlToIcacStop ;
    wire                    CtrlToIcacFLash;
    wire                    CtrlToFTQStop  ;
    wire                    CtrlToFTQFlash ;
    wire                    CtrlTOPreStop  ;
    wire                    CtrlToPreFLash ;

    //for btb 
    wire                    BtbToMidAble  ;
    wire  [1:0]             BtbToMidBank  ;
    wire  [`InstAddrBus]    BtbToMidPc    ;
    wire  [4:0]             BtbToRasOfs   ;
    wire                    BtbToTageMode ;
    wire  [2:0]             BtbToMidType  ;
    wire                    PreToBtbAble  ;
    wire  [1:0]             PreToBtbBank  ;
    wire  [`InstAddrBus]    PreToBtbPc    ;
    wire                    PreToBtbCAble ;
    wire  [3:0]             PreToBtbCnt   ;
    wire                    PreToBtbTAble ;
    wire  [2:0]             PreToBtbType  ;
    wire                    PreToBtbGAble ;
    wire  [`InstAddrBus]    PreToBtbTargrt;
    //for mid 
    wire                    MidToPreAble  ;
    wire  [1:0]             MidToPreBank  ;
    wire  [`InstAddrBus]    MidToPrePc    ;
    wire  [2:0]             MidToPreType  ;

    // for pc 
    wire                    PreToPcAble   ;
    wire  [`InstAddrBus]    PreToPcPc     ;
    wire                    RobToPcAble   ;
    wire  [`InstAddrBus]    RobToPcPc     ;

    //for ftq 
    wire                    PredToFTQAble ;
    wire                    PredToFTQMode ;
    wire  [2:0]             PredToFTQJdate;
    wire  [2:0]             PredToFTQNum  ;
    wire  [2:0]             PredToFTQU1   ;
    wire  [2:0]             PredToFTQU2   ;
    wire  [2:0]             PredToFTQU3   ;
    wire  [2:0]             PredToFTQU4   ;
    wire  [2:0]             PredToFTQU5   ;
    wire  [2:0]             PredToFTQU6   ;

    wire                    FTQToTageAble ;
    wire  [`InstAddrBus]    FTQToTagePc   ;
    wire  [2:0]             FTQToTageDate ;
    wire  [2:0]             FTQToTageNum  ;
    wire  [2:0]             FTQToTageCnt  ;
    wire                    FTQToTageNable;
    wire  [2:0]             FTQToTageNDate;
    wire  [2:0]             FTQToTageNNum ;
    wire  [2:0]             FTQToTageNCnt ;
    wire                    FTQToTageNC1Able;
    wire  [2:0]             FTQTOTAgeNC1  ;
    wire                    FTQToTageNC2Able;
    wire  [2:0]             FTQTOTAgeNC2  ;
    wire                    FTQToTageNC3Able;
    wire  [2:0]             FTQTOTAgeNC3  ;
    wire                    FTQToTageNC4Able;
    wire  [2:0]             FTQTOTAgeNC4  ;
    wire                    FTQToTageNC5Able;
    wire  [2:0]             FTQTOTAgeNC5  ;
    wire                    FTQToTageNC6Able;
    wire  [2:0]             FTQTOTAgeNC6  ;
    
    //for RAS 

    wire                    PreTORasAble ;
    wire  [1:0]             PreToRasType ;
    wire  [`InstAddrBus]    PreToRasPc   ;
    wire                    RobToRasAble ;
    wire                    RobToRasRload;
    wire  [`InstAddrBus]    RobToRasDate ;
    wire                    RobToRasCall ;
    wire                    RobToRasRtrn ;
    wire                    RasToPreAble ;
    wire  [`InstAddrBus]    RasToPreAddr ;

    //for tage                   
    wire                    PreTOTageAble  ;
    wire  [`InstAddrBus]    PreToTageDate  ;
    wire                    RobToTageAtten ;
    wire                    RobToTggeGAble ;
    wire  [64:0]            RobToTageGHR   ;
    wire                    TageToPreAble  ;
    wire                    TageToPreMode  ;
    wire  [2:0]             TageToPreJdate ;
    wire  [2:0]             TageToPreNum   ;
    wire  [2:0]             TageToPreC1    ;
    wire  [2:0]             TageToPreC2    ;
    wire  [2:0]             TageToPreC3    ;
    wire  [2:0]             TageToPreC4    ;
    wire  [2:0]             TageToPreC5    ;
    wire  [2:0]             TageToPreC6    ;
    
    //for pre
    wire                    IcaToPreAble  ;
    wire  [255:0]           IcaToPrePcgrp ;
    wire  [7:0]             IcaToPreInvt  ;
    wire  [255:0]           IcaToPreIgrp  ;
    wire                    PredTo1ISAble ;
    wire                    PredTo1ISMode ;
    wire  [`InstAddrBus]    PredTo1ISPc   ;
    wire  [`InstAddrBus]    PredTo1ISRPc  ;
    wire  [`InstDateBus]    PredTo1ISInst ;
    wire                    PredTo2ISAble ;
    wire                    PredTo2ISMode ;
    wire  [`InstAddrBus]    PredTo2ISPc   ;
    wire  [`InstAddrBus]    PredTo2ISRPc  ;
    wire  [`InstDateBus]    PredTo2ISInst ;
    wire                    PredTo3ISAble ;
    wire                    PredTo3ISMode ;
    wire  [`InstAddrBus]    PredTo3ISPc   ;
    wire  [`InstAddrBus]    PredTo3ISRPc  ;
    wire  [`InstDateBus]    PredTo3ISInst ;
    wire                    PredTo4ISAble ;
    wire                    PredTo4ISMode ;
    wire  [`InstAddrBus]    PredTo4ISPc   ;
    wire  [`InstAddrBus]    PredTo4ISRPc  ;
    wire  [`InstDateBus]    PredTo4ISInst ;
    wire                    PredTo5ISAble ;
    wire                    PredTo5ISMode ;
    wire  [`InstAddrBus]    PredTo5ISPc   ;
    wire  [`InstAddrBus]    PredTo5ISRPc  ;
    wire  [`InstDateBus]    PredTo5ISInst ;
    wire                    PredTo6ISAble ;
    wire                    PredTo6ISMode ;
    wire  [`InstAddrBus]    PredTo6ISPc   ;
    wire  [`InstAddrBus]    PredTo6ISRPc  ;
    wire  [`InstDateBus]    PredTo6ISInst ;
    wire                    PredTo7ISAble ;
    wire                    PredTo7ISMode ;
    wire  [`InstAddrBus]    PredTo7ISPc   ;
    wire  [`InstAddrBus]    PredTo7ISRPc  ;
    wire  [`InstDateBus]    PredTo7ISInst ;
    wire                    PredTo8ISAble ;
    wire                    PredTo8ISMode ;
    wire  [`InstAddrBus]    PredTo8ISPc   ;
    wire  [`InstAddrBus]    PredTo8ISRPc  ;
    wire  [`InstDateBus]    PredTo8ISInst ;

    //for ICache 
    wire                    IcaToMmuAble  ;
    wire  [31:0]            IcaToMmuVPc   ;
    wire  [1:0]             MmuToIcaType  ;
    wire                    MmuToIcaTrap  ;
    wire  [`InstAddrBus]    MmuToIcaPPc   ;
    wire                    IcaToAXIAble  ;
    wire                    AXIToIcaSKH   ;
    wire                    UcaToAXIAble  ;
    wire  [`InstAddrBus]    IcaToAXIAddr  ;
    wire                    AXIToIcaAble  ;
    wire                    AXIToIcaReq   ;
    wire  [511:0]           AXIToIcaDate  ; 

    //fro InstQUeue 
    wire                    ISToDcodePort1  ;
    wire                    ISToDcodePort2  ;
    wire                    ISToDcodePort3  ;
    wire                    ISToDcodePort4  ;
    wire  [`InstAddrBus]    ISToDcodeAddr1  ;
    wire  [`InstDateBus]    ISToDcodeDate1  ; 
    wire                    ISToDcodePart1  ; 
    wire  [`InstAddrBus]    ISToDcodeRPc1   ; 
    wire  [`InstAddrBus]    ISToDcodeAddr2  ;
    wire  [`InstDateBus]    ISToDcodeDate2  ; 
    wire                    ISToDcodePart2  ; 
    wire  [`InstAddrBus]    ISToDcodeRPc2   ;   
    wire  [`InstAddrBus]    ISToDcodeAddr3  ;
    wire  [`InstDateBus]    ISToDcodeDate3  ; 
    wire                    ISToDcodePart3  ; 
    wire  [`InstAddrBus]    ISToDcodeRPc3   ; 
    wire  [`InstAddrBus]    ISToDcodeAddr4  ;
    wire  [`InstDateBus]    ISToDcodeDate4  ; 
    wire                    ISToDcodePart4  ; 
    wire  [`InstAddrBus]    ISToDcodeRPc4   ; 

    //for decode
    wire  [`InstAddrBus]    DcdToRnm1Pc      ;
    wire  [`MicOperateCode] DcdToRnm1Opcode  ;
    wire                    DcdToRnm1ImAble  ;
    wire  [25:0]            DcdToRnm1ImDate  ;
    wire                    DcdToRnm1Sr1Able ;
    wire  [`ArchRegBUs]     DcdToRnm1Sr1Num  ;
    wire                    DcdToRnm1Sr2Able ;
    wire  [`ArchRegBUs]     DcdToRnm1Sr2Num  ;
    wire                    DcdToRnm1WAble   ;
    wire                    DcdToRnm1Part    ;
    wire  [`InstAddrBus]    DcdToRnm1Naddr   ;
    wire  [`ArchRegBUs]     DcdToRnm1Wnum    ;
    wire  [`InstAddrBus]    DcdToRnm2Pc      ;
    wire  [`MicOperateCode] DcdToRnm2Opcode  ;
    wire                    DcdToRnm2ImAble  ;
    wire  [25:0]            DcdToRnm2ImDate  ;
    wire                    DcdToRnm2Sr1Able ;
    wire  [`ArchRegBUs]     DcdToRnm2Sr1Num  ;
    wire                    DcdToRnm2Sr2Able ;
    wire  [`ArchRegBUs]     DcdToRnm2Sr2Num  ;
    wire                    DcdToRnm2WAble   ;
    wire                    DcdToRnm2Part    ;
    wire  [`InstAddrBus]    DcdToRnm2Naddr   ;
    wire  [`ArchRegBUs]     DcdToRnm2Wnum    ;
    wire  [`InstAddrBus]    DcdToRnm3Pc      ;
    wire  [`MicOperateCode] DcdToRnm3Opcode  ;
    wire                    DcdToRnm3ImAble  ;
    wire  [25:0]            DcdToRnm3ImDate  ;
    wire                    DcdToRnm3Sr1Able ;
    wire  [`ArchRegBUs]     DcdToRnm3Sr1Num  ;
    wire                    DcdToRnm3Sr2Able ;
    wire  [`ArchRegBUs]     DcdToRnm3Sr2Num  ;
    wire                    DcdToRnm3WAble   ;
    wire                    DcdToRnm3Part    ;
    wire  [`InstAddrBus]    DcdToRnm3Naddr   ;
    wire  [`ArchRegBUs]     DcdToRnm3Wnum    ;
    wire  [`InstAddrBus]    DcdToRnm4Pc      ;
    wire  [`MicOperateCode] DcdToRnm4Opcode  ;
    wire                    DcdToRnm4ImAble  ;
    wire  [25:0]            DcdToRnm4ImDate  ;
    wire                    DcdToRnm4Sr1Able ;
    wire  [`ArchRegBUs]     DcdToRnm4Sr1Num  ;
    wire                    DcdToRnm4Sr2Able ;
    wire  [`ArchRegBUs]     DcdToRnm4Sr2Num  ;
    wire                    DcdToRnm4WAble   ;
    wire                    DcdToRnm4Part    ;
    wire  [`InstAddrBus]    DcdToRnm4Naddr   ;
    wire  [`ArchRegBUs]     DcdToRnm4Wnum    ;

    //for free list 
    wire                    FLToRAT1Able     ;
    wire  [`ArchRegBUs]     FLToRAT1Areg     ;
    wire  [`ReNameRegBUs]   FLToRAT1RReg     ;  
    wire                    FLToRAT2Able     ;
    wire  [`ArchRegBUs]     FLToRAT2Areg     ;
    wire  [`ReNameRegBUs]   FLToRAT2RReg     ;
    wire                    FLToRAT3Able     ;
    wire  [`ArchRegBUs]     FLToRAT3Areg     ;
    wire  [`ReNameRegBUs]   FLToRAT3RReg     ;
    wire                    FLToRAT4Able     ;
    wire  [`ArchRegBUs]     FLToRAT4Areg     ;
    wire  [`ReNameRegBUs]   FLToRAT4RReg     ;
    wire                    RobToFLRload     ;
    wire                    RefToFLF1Able    ;
    wire  [`ReNameRegBUs]   RefToFLF1Addr    ;
    wire                    RefToFLF2Able    ;
    wire  [`ReNameRegBUs]   RefToFLF2Addr    ;
    wire                    RefToFLF3Able    ;
    wire  [`ReNameRegBUs]   RefToFLF3Addr    ;
    wire                    RefToFLF4Able    ;
    wire  [`ReNameRegBUs]   RefToFLF4Addr    ;

    //for RAT 
    wire                    RATToBYT1Sr1Able   ;
    wire                    RATToBYT1Sr1ND     ;
    wire  [`ReNameRegBUs]   RATToBYT1Sr1Num    ;
    wire                    RATToBYT1Sr2Able   ;
    wire                    RATToBYT1Sr2ND     ;
    wire  [`ReNameRegBUs]   RATToBYT1Sr2Num    ;
    wire                    RATToBYT1WAble     ;
    wire  [`ReNameRegBUs]   RATToBYT1WNum      ;
    wire                    RATToBYT2Sr1Able   ;
    wire                    RATToBYT2Sr1ND     ;
    wire  [`ReNameRegBUs]   RATToBYT2Sr1Num    ;
    wire                    RATToBYT2Sr2Able   ;
    wire                    RATToBYT2Sr2ND     ;
    wire  [`ReNameRegBUs]   RATToBYT2Sr2Num    ;
    wire                    RATToBYT2WAble     ;
    wire  [`ReNameRegBUs]   RATToBYT2WNum      ;
    wire                    RATToBYT3Sr1Able   ;
    wire                    RATToBYT3Sr1ND     ;
    wire  [`ReNameRegBUs]   RATToBYT3Sr1Num    ;
    wire                    RATToBYT3Sr2Able   ;
    wire                    RATToBYT3Sr2ND     ;
    wire  [`ReNameRegBUs]   RATToBYT3Sr2Num    ;
    wire                    RATToBYT3WAble     ;
    wire  [`ReNameRegBUs]   RATToBYT3WNum      ;
    wire                    RATToBYT4Sr1Able   ;
    wire                    RATToBYT4Sr1ND     ;
    wire  [`ReNameRegBUs]   RATToBYT4Sr1Num    ;
    wire                    RATToBYT4Sr2Able   ;
    wire                    RATToBYT4Sr2ND     ;
    wire  [`ReNameRegBUs]   RATToBYT4Sr2Num    ;
    wire                    RATToBYT4WAble     ;
    wire  [`ReNameRegBUs]   RATToBYT4WNum      ;
    wire                    RATToRefLock1      ;
    wire  [`ReNameRegBUs]   RATToRefLock1Addr  ;
    wire                    RATToRefLock2      ;
    wire  [`ReNameRegBUs]   RATToRefLock2Addr  ;
    wire                    RATToRefLock3      ;
    wire  [`ReNameRegBUs]   RATToRefLock3Addr  ;
    wire                    RATToRefLock4      ;
    wire  [`ReNameRegBUs]   RATToRefLock4Addr  ;
    wire                    RATToRefUse1       ;
    wire  [`ReNameRegBUs]   RATToRefUse1Addr   ;
    wire                    RATToRefUse2       ;
    wire  [`ReNameRegBUs]   RATToRefUse2Addr   ;
    wire                    RATToRefUse3       ;
    wire  [`ReNameRegBUs]   RATToRefUse3Addr   ;
    wire                    RATToRefUse4       ;
    wire  [`ReNameRegBUs]   RATToRefUse4Addr   ;
    wire                    RATToRefUse5       ;
    wire  [`ReNameRegBUs]   RATToRefUse5Addr   ;
    wire                    RATToRefUse6       ;
    wire  [`ReNameRegBUs]   RATToRefUse6Addr   ;
    wire                    RATToRefUse7       ;
    wire  [`ReNameRegBUs]   RATToRefUse7Addr   ;
    wire                    RATToRefUse8       ;
    wire  [`ReNameRegBUs]   RATToRefUse8Addr   ;
    wire                    RATToRefUse9       ;
    wire  [`ReNameRegBUs]   RATToRefUse9Addr   ;
    wire                    RATToRefUse10      ;
    wire  [`ReNameRegBUs]   RATToRefUse10Addr  ;
    wire                    RATToRefUse11      ;
    wire  [`ReNameRegBUs]   RATToRefUse11Addr  ;
    wire                    RATToRefUse12      ;
    wire  [`ReNameRegBUs]   RATToRefUse12Addr  ;

    wire                    BYTToIQ1Sr1Able    ;
    wire                    BYTToIQ1Sr1Ready   ;
    wire  [`ReNameRegBUs]   BYTToIQ1Sr1Num     ;
    wire                    BYTToIQ1Sr2Able    ;
    wire                    BYTToIQ1Sr2Ready   ;
    wire  [`ReNameRegBUs]   BYTToIQ1Sr2Num     ;
    wire                    BYTToIQ1WAble      ;
    wire  [`ReNameRegBUs]   BYTToIQ1WNum       ;
    wire                    BYTToIQ2Sr1Able    ;
    wire                    BYTToIQ2Sr1Ready   ;
    wire  [`ReNameRegBUs]   BYTToIQ2Sr1Num     ;
    wire                    BYTToIQ2Sr2Able    ;
    wire                    BYTToIQ2Sr2Ready   ;
    wire  [`ReNameRegBUs]   BYTToIQ2Sr2Num     ;
    wire                    BYTToIQ2WAble      ;
    wire  [`ReNameRegBUs]   BYTToIQ2WNum       ;
    wire                    BYTToIQ3Sr1Able    ;
    wire                    BYTToIQ3Sr1Ready   ;
    wire  [`ReNameRegBUs]   BYTToIQ3Sr1Num     ;
    wire                    BYTToIQ3Sr2Able    ;
    wire                    BYTToIQ3Sr2Ready   ;
    wire  [`ReNameRegBUs]   BYTToIQ3Sr2Num     ;
    wire                    BYTToIQ3WAble      ;
    wire  [`ReNameRegBUs]   BYTToIQ3WNum       ;
    wire                    BYTToIQ4Sr1Able    ;
    wire                    BYTToIQ4Sr1Ready   ;
    wire  [`ReNameRegBUs]   BYTToIQ4Sr1Num     ;
    wire                    BYTToIQ4Sr2Able    ;
    wire                    BYTToIQ4Sr2Ready   ;
    wire  [`ReNameRegBUs]   BYTToIQ4Sr2Num     ;
    wire                    BYTToIQ4WAble      ;
    wire  [`ReNameRegBUs]   BYTToIQ4WNum       ;

    //for reftable 
    wire                    PHYToRef1Sr1Able      ;
    wire  [`ReNameRegBUs]   PHYToRef1Sr1Num       ;
    wire                    PHYToRef1Sr2Able      ;
    wire  [`ReNameRegBUs]   PHYToRef1Sr2Num       ;
    wire                    PHYToRef2Sr1Able      ;
    wire  [`ReNameRegBUs]   PHYToRef2Sr1Num       ;
    wire                    PHYToRef2Sr2Able      ;
    wire  [`ReNameRegBUs]   PHYToRef2Sr2Num       ;
    wire                    PHYToRef3Sr1Able      ;
    wire  [`ReNameRegBUs]   PHYToRef3Sr1Num       ;
    wire                    PHYToRef3Sr2Able      ;
    wire  [`ReNameRegBUs]   PHYToRef3Sr2Num       ;
    wire                    PHYToRef4Sr1Able      ;
    wire  [`ReNameRegBUs]   PHYToRef4Sr1Num       ;
    wire                    PHYToRef4Sr2Able      ;
    wire  [`ReNameRegBUs]   PHYToRef4Sr2Num       ;

    wire                    PHYToRef1WAble        ;
    wire  [`ReNameRegBUs]   PHYToRef1Wnum         ;
    wire                    PHYToRef2WAble        ;
    wire  [`ReNameRegBUs]   PHYToRef2Wnum         ;
    wire                    PHYToRef3WAble        ;
    wire  [`ReNameRegBUs]   PHYToRef3Wnum         ;
    wire                    PHYToRef4WAble        ;
    wire  [`ReNameRegBUs]   PHYToRef4Wnum         ;
    wire                    PHYToRef5WAble        ;
    wire  [`ReNameRegBUs]   PHYToRef5Wnum         ;
    wire                    PHYToRef6WAble        ;
    wire  [`ReNameRegBUs]   PHYToRef6Wnum         ;
    wire                    PHYToRef7WAble        ;
    wire  [`ReNameRegBUs]   PHYToRef7Wnum         ;
    wire                    PHYToRef8WAble        ;
    wire  [`ReNameRegBUs]   PHYToRef8Wnum         ;

    //for brcsr 
    wire                    EXCsrToIQReq          ;
    wire                    EXBrToIQReq           ;
    wire                    IntToBrCsrWKAlu1      ;
    wire  [`ReNameRegBUs]   IntToBrCsrWKANum1     ;
    wire                    IntToBrCsrWKAlu2      ;
    wire  [`ReNameRegBUs]   IntToBrCsrWKANum2     ;
    wire                    IntToBrCsrWKMul       ;
    wire  [`ReNameRegBUs]   IntToBrCsrWKMNum      ;
    wire                    ByPassDivAble         ;
    wire  [`ReNameRegBUs]   ByPassDivNum          ;
    wire                    ByPassSCAble          ;
    wire  [`ReNameRegBUs]   ByPassSCNum           ;
    wire                    ByPassLoadAble        ;
    wire  [`ReNameRegBUs]   ByPassLoadNum         ;
    wire                    CsrToOtherAble        ;
    wire  [`ReNameRegBUs]   CsrToOtherAddr        ;
    wire                    BrToOtherAble         ;
    wire                    BrToOtherAddr         ;
    wire  [`MicOperateCode] BrCsrTo1EUMicop       ;
    wire                    BrCsrTo1EUSr1A        ;
    wire  [`ReNameRegBUs]   BrCsrTo1EUSr1Num      ;
    wire                    BrCsrTo1EUSr2A        ;
    wire  [`ReNameRegBUs]   BrCsrTo1EUSr2Num      ;
    wire                    BrCsrTo1EUImA         ;
    wire  [25:0]            BrCsrTO1EUImDate      ;
    wire                    BrCsrTo1EURdA         ;
    wire  [`ReNameRegBUs]   BRCsrTo1EURdNum       ;
    wire                    BrCsrTo1EUMode        ;
    wire  [`InstAddrBus]    BrCsrTo1EURAddr       ;
    wire                    BrCstTO1EURobPtr      ;
    wire  [`MicOperateCode] BrCsrTo2EUMicop       ;
    wire                    BrCsrTo2EUSr1A        ;
    wire  [`ReNameRegBUs]   BrCsrTo2EUSr1Num      ;
    wire                    BrCsrTo2EUSr2A        ;
    wire  [`ReNameRegBUs]   BrCsrTo2EUSr2Num      ;
    wire                    BrCsrTo2EUImA         ;
    wire  [25:0]            BrCsrTO2EUImDate      ;
    wire                    BrCsrTo2EURdA         ;
    wire  [`ReNameRegBUs]   BRCsrTo2EURdNum       ;
    wire                    BrCstTO2EURobPtr      ;

    //for IQInt 
    wire                    EXALU1ToIQReq        ;
    wire                    EXALU2ToIQReq        ;
    wire                    EXMulToIQReq         ;
    wire                    EXDivToIQReq         ;
    wire                    Alu1ToOtherAble      ;
    wire  [`ReNameRegBUs]   Alu1ToOtherNum       ;
    wire                    ALu2ToOtherAble      ;
    wire  [`ReNameRegBUs]   Alu2ToOtherNum       ;
    wire                    MulToOtherAble       ;
    wire  [`ReNameRegBUs]   MulToOtherNum        ;
    wire  [`MicOperateCode] IntToEX1MicOp        ;
    wire                    IntToEX1Sr1Able      ;
    wire  [`ReNameRegBUs]   IntToEX1Sr1Num       ;
    wire                    IntToEX1Sr2Able      ;
    wire  [`ReNameRegBUs]   IntToEX1Sr2Num       ;
    wire                    IntToEx1ImmAble      ;
    wire  [25:0]            IntToEx1ImmDate      ;
    wire                    IntToEX1RdAble       ;
    wire  [`ReNameRegBUs]   IntTOEx1RdNum        ;
    wire  [7:0]             IntToEX1RobPtr       ;
    wire  [`MicOperateCode] IntToEX2MicOp        ;
    wire                    IntToEX2Sr1Able      ;
    wire  [`ReNameRegBUs]   IntToEX2Sr1Num       ;
    wire                    IntToEX2Sr2Able      ;
    wire  [`ReNameRegBUs]   IntToEX2Sr2Num       ;
    wire                    IntToEx2ImmAble      ;
    wire  [25:0]            IntToEx2ImmDate      ;
    wire                    IntToEX2RdAble       ;
    wire  [`ReNameRegBUs]   IntTOEx2RdNum        ;
    wire  [7:0]             IntToEX2RobPtr       ;
    wire  [`MicOperateCode] IntToEX3MicOp        ;
    wire                    IntToEX3Sr1Able      ;
    wire  [`ReNameRegBUs]   IntToEX3Sr1Num       ;
    wire                    IntToEX3Sr2Able      ;
    wire  [`ReNameRegBUs]   IntToEX3Sr2Num       ;
    wire                    IntToEx3ImmAble      ;
    wire  [25:0]            IntToEx3ImmDate      ;
    wire                    IntToEX3RdAble       ;
    wire  [`ReNameRegBUs]   IntTOEx3RdNum        ;
    wire  [7:0]             IntToEX3RobPtr       ;
    wire  [`MicOperateCode] IntToEX4MicOp        ;
    wire                    IntToEX4Sr1Able      ;
    wire  [`ReNameRegBUs]   IntToEX4Sr1Num       ;
    wire                    IntToEX4Sr2Able      ;
    wire  [`ReNameRegBUs]   IntToEX4Sr2Num       ;
    wire                    IntToEx4ImmAble      ;
    wire  [25:0]            IntToEx4ImmDate      ;
    wire                    IntToEX4RdAble       ;
    wire  [`ReNameRegBUs]   IntTOEx4RdNum        ;
    wire  [7:0]             IntToEX4RobPtr       ;

    //for iQ mem
    wire                    LoadToIQReq         ;
    wire                    StoreTOIQReq        ;
    wire  [`MicOperateCode] MemToLS1MicOp       ;
    wire                    MemToLS1Sr1Able     ;
    wire  [`ReNameRegBUs]   MemToLS1Sr1Num      ;
    wire                    MemToLS1Sr2Able     ;
    wire  [`ReNameRegBUs]   MemToLS1Sr2Num      ;
    wire                    MemToLS1ImAble      ;
    wire  [25:0]            MemToLS1ImDate      ;
    wire                    MemToLS1RdAble      ;
    wire  [`ReNameRegBUs]   MemToLS1RdNum       ;
    wire  [7:0]             MemToLS1RobPtr      ;
    wire  [`MicOperateCode] MemToLS2MicOp       ;
    wire                    MemToLS2Sr1Able     ;
    wire  [`ReNameRegBUs]   MemToLS2Sr1Num      ;
    wire                    MemToLS2Sr2Able     ;
    wire  [`ReNameRegBUs]   MemToLS2Sr2Num      ;
    wire                    MemToLS2ImAble      ;
    wire  [25:0]            MemToLS2ImDate      ;
    wire                    MemToLS2RdAble      ;
    wire  [`ReNameRegBUs]   MemToLS2RdNum       ;
    wire  [7:0]             MemToLS2RobPtr      ;

    //for physical 
    wire                    ArchSToPhyReload    ;
    wire [`ReNameRegBUs]    ArchSToPhy1Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy2Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy3Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy4Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy5Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy6Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy7Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy8Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy9Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy10Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy11Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy12Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy13Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy14Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy15Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy16Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy17Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy18Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy19Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy20Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy21Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy22Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy23Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy24Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy25Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy26Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy27Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy28Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy29Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy30Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy31Num      ;
    wire [`ReNameRegBUs]    ArchSToPhy32Num      ;

    wire                    Alu1ToPhyAble        ;
    wire [`ReNameRegBUs]    Alu1ToPhyAddr        ;
    wire [`DataBus]         Alu1ToPhyDate        ;
    wire                    Alu2ToPhyAble        ;
    wire [`ReNameRegBUs]    Alu2ToPhyAddr        ;
    wire [`DataBus]         Alu2ToPhyDate        ;
    wire                    DivToPhyAble         ;
    wire [`ReNameRegBUs]    DivToPhyAddr         ;
    wire [`DataBus]         DivToPhyDate         ;
    wire                    MulToPhyAble         ;
    wire [`ReNameRegBUs]    MulToPhyAddr         ;
    wire [`DataBus]         MulToPhyDate         ;
    wire                    CsruToPhyAble        ;
    wire [`ReNameRegBUs]    CsruToPhyAddr        ;
    wire [`DataBus]         CsruToPhyDate        ;
    wire                    BruToPhyAble         ;
    wire [`ReNameRegBUs]    BruToPhyAddr         ;
    wire [`DataBus]         BruToPhyDate         ;
    wire                    LsuToPhyAble         ;
    wire [`ReNameRegBUs]    LsuToPhyAddr         ;
    wire [`DataBus]         LsuToPhyDate         ;
    wire                    RobToPhyAble         ;
    wire [`ReNameRegBUs]    RobToPhyAddr         ;
    wire [`DataBus]         RobToPhyDate         ;

    wire [`DataBus]         PhyToEuDate11        ;
    wire [`DataBus]         PhyToEuDate12        ;
    wire [`DataBus]         PhyToEuDate21        ;
    wire [`DataBus]         PhyToEuDate22        ;
    wire [`DataBus]         PhyToEuDate31        ;
    wire [`DataBus]         PhyToEuDate32        ;
    wire [`DataBus]         PhyToEuDate41        ;
    wire [`DataBus]         PhyToEuDate42        ;
    wire [`DataBus]         PhyToEuDate51        ;
    wire [`DataBus]         PhyToEuDate52        ;
    wire [`DataBus]         PhyToEuDate61        ;
    wire [`DataBus]         PhyToEuDate62        ;
    wire [`DataBus]         PhyToEuDate71        ;
    wire [`DataBus]         PhyToEuDate72        ;
    wire [`DataBus]         PhyToEuDate81        ;
    wire [`DataBus]         PhyToEuDate82        ;

    //for mmu
    wire [9:0]              CstToMmuAsidDate    ;
    wire [`DataBus]         CsrToMmuDmw0Date    ;
    wire [`DataBus]         CsrToMmuDmw1Date    ;
    wire [`DataBus]         CsrToMmuCrmdDate    ;
    wire [5:0]              CsrToMmuRTAddr      ;
    wire [89-1:0]           MmuToCsrRTDate      ;
    wire                    CsrToMmuSTAble      ;
    wire [28:0]             CsrToMmuSTInfo      ;
    wire                    CsrToMmuSAble       ;
    wire [5:0]              CsrToMmuSIndex      ;
    wire                    CsrToMmuWTAble      ;
    wire [5:0]              CsrToMmuWTAddr      ;
    wire [88:0]             CsrToMmuWTDate      ;
    wire                    CsrToMmuInvEn       ;
    wire [4:0]              CsrToMmuInvOp       ;
    wire [9:0]              CsrToMmuInvAsid     ;
    wire [18:0]             CsrToMmuInvVppn     ;

    wire                    InstToMmuFetch      ;
    wire [31:0]             InstToMmuVA         ;
    wire [1:0]              MmuToInstOpType     ;
    wire                    MmuToInstTrap       ;
    wire [6:0]              MmuToInstTrapCode   ;
    wire [`InstAddrBus]     MmuToInstPA         ;

    wire                    LoadToMmuAccess     ;
    wire [31:0]             LoadToMmuVA         ;
    wire [1:0]              MmuToLoadOpType     ;
    wire                    MmuToLoadTrap       ;
    wire [6:0]              MmuToLoadTrapCode   ;
    wire [`InstAddrBus]     MmuToLoadPA         ;

    wire                    StoreToMmuAccess    ;
    wire [31:0]             StoreToMmuVA        ;
    wire [1:0]              MmuToStoreOpType    ;
    wire                    MmuToStoreTrap      ;
    wire [6:0]              MmuToStoreTrapCode  ;
    wire [`InstAddrBus]     MmuToStorePA        ;

    //for alu1 
    wire                    Alu1ToIQReq         ;
    wire                    Alu1ToPhyWBAble     ;
    wire [`ReNameRegBUs]    Alu1ToPhyWBNum      ;
    wire [`DataBus]         Alu1ToPhyWBDate     ;
    wire                    Alu1ToRobAble       ;
    wire [5:0]              Alu1ToRobPtr        ;
    wire [1:0]              Alu1ToRobType       ;
    //for alu2
    wire                    Alu2ToIQReq         ;
    wire                    Alu2ToPhyWBAble     ;
    wire [`ReNameRegBUs]    Alu2ToPhyWBNum      ;
    wire [`DataBus]         Alu2ToPhyWBDate     ;
    wire                    Alu2ToRobAble       ;
    wire [5:0]              Alu2ToRobPtr        ;
    wire [1:0]              Alu2ToRobType       ;

 
    Ctrl u_Ctrl(
    .Clk           ( Clk               ),
    .Rest          ( Rest              ),
    .ROBredir      ( ROBredir          ),
    .StopToPc      ( CtrlToPcStop      ),
    .StopToBtb     ( CtrlToBtbStop     ),
    .StopMidFlash  ( CtrlToBtbFlash    ),
    .StopTage      ( CtrlToTageStop    ),
    .FLashTage     ( CtrlToTageFLash   ),
    .StopRas       ( CtrlTORasStop     ),
    .FLashRas      ( CtrlToRasFlash    ),
    .IcacheFLash   ( CtrlToIcacFLash   ),
    .IcacheStop    ( CtrlToIcacStop    ),
    .PredStop      ( CtrlTOPreStop     ),
    .PredFlash     ( CtrlToPreFLash    ),
    .FTQStop       ( CtrlToFTQStop     ),
    .FTQFlash      ( CtrlToFTQFlash    ),
    .IcReq         ( CtrlIcReq         ),
    .BpReq         ( CtrlBpReq         ),
    .PreReq        ( CtrlPreReq        ),
    .FTQReq        ( CtrlFTQReq        )
    );

    Pc u_Pc(
    .Clk             ( Clk             ),
    .Rest            ( Rest            ),
    .PcStop          ( CtrlToPcStop    ),
    .BtbPredictAble  ( BtbPcAble       ),
    .BtbPreDictPc    ( BtbPc           ),
    .PreReDirAble    ( PreToPcAble     ),
    .PreReDirPc      ( PreToPcPc       ),
    .RobReDirAble    ( RobToPcAble     ),
    .RobReDirPc      ( RobToPcPc       ),
    .PcAble          ( PcOutAble       ),
    .PcDate          ( PcOutPc         )
    );



    Btb u_Btb(
    .Clk             ( Clk             ),
    .Rest            ( Rest            ),
    .BtbStop         ( CtrlToBtbStop   ),
    .BtbFlash        ( CtrlToBtbFlash  ),
    .InstPcAble      ( PcOutAble       ),
    .InstPc          ( PcOutPc         ),
    .UpAble          ( PreToBtbAble    ),
    .UpAbleBank      ( PreToBtbBank    ),
    .UpPc            ( PreToBtbPc      ),
    .UpCntAble       ( PreToBtbCAble   ),
    .UpCnt           ( PreToBtbCnt     ),
    .BtbUpTypeAble   ( PreToBtbTAble   ),
    .BtbUpType       ( PreToBtbType    ),
    .BtbUpTagetAble  ( PreToBtbGAble   ),
    .BtbUpTaget      ( PreToBtbTargrt  ),
    .InstNextAble    ( BtbToMidAble    ),
    .InstHitBanN     ( BtbToMidBank    ),
    .InstNextPc      ( BtbToMidPc      ),
    .InstNextOffset  ( BtbToRasOfs     ),
    .InstNextMode    ( BtbToTageMode   ),
    .InstNextType    ( BtbToMidType    )
    );

    BtbMid u_BtbMid(
    .Clk         ( Clk         ),
    .Rest        ( Rest        ),
    .BMstop      ( CtrlToBtbStop ),
    .BMFLash     ( CtrlToBtbFlash),
    .InNextAble  ( BtbToMidAble),
    .InHitBanN   ( BtbToMidBank),
    .InNextPc    ( BtbToMidPc  ),
    .InNextType  ( BtbToMidType),
    .OtNextAble  ( MidToPreAble),
    .OtHitBanN   ( MidToPreBank),
    .OtNextPc    ( MidToPrePc  ),
    .OtNextType  ( MidToPreType)
    );


    FTQ u_FTQ(
    .Clk           ( Clk             ),
    .Rest          ( Rest            ),
    .FTQStop       ( CtrlToFTQStop   ),
    .FTQFlash      ( CtrlToFTQFlash  ),
    .FTQreq        ( CtrlFTQReq      ),
    .ROBBranch     ( ROBBranch       ),
    .ROBBranchYN   ( ROBBranchYN     ),
    .ROBBranchMo   ( ROBBranchMo     ),
    .ROBBranchPc   ( ROBBranchPc     ),
    .PredictAble   ( PredToFTQAble   ),
    .PredictJdate  ( PredToFTQJdate  ),
    .PredictNum    ( PredToFTQNum    ),
    .PredictInt1   ( PredToFTQU1     ),
    .PredictInt2   ( PredToFTQU2     ),
    .PredictInt3   ( PredToFTQU3     ),
    .PredictInt4   ( PredToFTQU4     ),
    .PredictInt5   ( PredToFTQU5     ),
    .PredictInt6   ( PredToFTQU6     ),
    .OutUpDatePc   ( FTQToTagePc     ),
    .OutDateAble   ( FTQToTageAble   ),
    .OutUpDate     ( FTQToTageDate   ),
    .OutUpNum      ( FTQToTageNum    ),
    .OutUpCnt      ( FTQToTageCnt    ),
    .NewDateAble   ( FTQToTageNable  ),
    .NewUpDate     ( FTQToTageNDate  ),
    .NewUpNum      ( FTQToTageNNum   ),
    .NewUpCnt      ( FTQToTageNCnt   ),
    .NewCnt1Able   ( FTQToTageNC1Able),
    .NewCnt1Date   ( FTQTOTAgeNC1    ),
    .NewCnt2Able   ( FTQToTageNC2Able),
    .NewCnt2Date   ( FTQTOTAgeNC2    ),
    .NewCnt3Able   ( FTQToTageNC3Able),
    .NewCnt3Date   ( FTQTOTAgeNC3    ),
    .NewCnt4Able   ( FTQToTageNC4Able),
    .NewCnt4Date   ( FTQTOTAgeNC4    ),
    .NewCnt5Able   ( FTQToTageNC5Able),
    .NewCnt5Date   ( FTQTOTAgeNC5    ),
    .NewCnt6Able   ( FTQToTageNC6Able),
    .NewCnt6Date   ( FTQTOTAgeNC6    )
    );

    Ras u_Ras(
    .Clk            ( Clk            ),
    .Rest           ( Rest           ),
    .RasStop        ( CtrlTORasStop  ),
    .RasFLash       ( CtrlToRasFlash ),
    .BtbAble        ( BtbToMidAble   ),
    .BtbPredictType ( BtbToMidType   ),
    .BtbPcDate      ( BtbToMidPc     ),
    .BtbPcOffset    ( BtbToRasOfs    ),
    .UpAble         ( PreTORasAble   ),
    .UpPtrType      ( PreToRasType   ),
    .UpAddrDate     ( PreToRasPc     ),
    .ToPreAble      ( RasToPreAble   ),
    .ToPreAddr      ( RasToPreAddr   ),
    .UpdateInAble   ( RobToRasAble   ),
    .UpdateReload   ( RobToRasRload  ),
    .UpdateInDate   ( RobToRasDate   ),
    .UpdateCall     ( RobToRasCall   ),
    .UpdateReturn   ( RobToRasRtrn   )
    );

    Tage u_Tage(
    .Clk            ( Clk               ),
    .Rest           ( Rest              ),
    .TageStop       ( CtrlToTageStop    ),
    .TageFlash      ( CtrlToTageFLash   ),
    .PcAble         ( PcOutAble         ),
    .PcDate         ( PcOutPc           ),
    .BtbAble        ( BtbToMidAble      ),
    .BtbType        ( BtbToMidType      ),
    .BtbMode        ( BtbToTageMode     ),
    .PreUpDable     ( PreTOTageAble     ),
    .PreUpDate      ( PreToTageDate     ),
    .Attenuate      ( RobToTageAtten    ),
    .GHRUpAble      ( RobToTggeGAble    ),
    .GHRDate        ( RobToTageGHR      ),
    .InALwDateAble  ( FTQToTageAble     ),
    .InALwUpDatePc  ( FTQToTagePc       ),
    .InALwUpDate    ( FTQToTageDate     ),
    .InALwUpNum     ( FTQToTageNum      ),
    .InALwUpCnt     ( FTQToTageCnt      ),
    .InNewDateAble  ( FTQToTageNable    ),
    .InNewUpDate    ( FTQToTageNDate    ),
    .InNewUpNum     ( FTQToTageNNum     ),
    .InNewUpCnt     ( FTQToTageNCnt     ),
    .InNewCnt1Able  ( FTQToTageNC1Able  ),
    .InNewCnt1Date  ( FTQTOTAgeNC1      ),
    .InNewCnt2Able  ( FTQToTageNC2Able  ),
    .InNewCnt2Date  ( FTQTOTAgeNC2      ),
    .InNewCnt3Able  ( FTQToTageNC3Able  ),
    .InNewCnt3Date  ( FTQTOTAgeNC3      ),
    .InNewCnt4Able  ( FTQToTageNC4Able  ),
    .InNewCnt4Date  ( FTQTOTAgeNC4      ),
    .InNewCnt5Able  ( FTQToTageNC5Able  ),
    .InNewCnt5Date  ( FTQTOTAgeNC5      ),
    .InNewCnt6Able  ( FTQToTageNC6Able  ),
    .InNewCnt6Date  ( FTQTOTAgeNC6      ),
    .PredictAble    ( TageToPreAble     ),
    .PredictMode    ( TageToPreMode     ),
    .PredictJdate   ( TageToPreJdate    ),
    .PredictNum     ( TageToPreNum      ),
    .PredictUset1   ( TageToPreC1       ),
    .PredictUset2   ( TageToPreC2       ),
    .PredictUset3   ( TageToPreC3       ),
    .PredictUset4   ( TageToPreC4       ),
    .PredictUset5   ( TageToPreC5       ),
    .PredictUset6   ( TageToPreC6       )
    );


    PreDecode u_PreDecode(
    .Clk              ( Clk              ),
    .Rest             ( Rest             ),
    .PreDecodeFlash   ( CtrlToPreFLash   ),
    .PreDecodeStop    ( CtrlTOPreStop    ),
    .BtbAble          ( MidToPreAble     ),
    .BtbBanKN         ( MidToPreBank     ),
    .BtbType          ( MidToPreType     ),
    .BtbPc            ( MidToPrePc       ),
    .RasAble          ( RasToPreAble     ),
    .RasPc            ( RasToPreAddr     ),
    .TageAble         ( TageToPreAble    ),
    .TageJdate        ( TageToPreJdate   ),
    .TageMode         ( TageToPreMode    ),
    .TageNum          ( TageToPreNum     ),
    .TageInt1         ( TageToPreC1      ),
    .TageInt2         ( TageToPreC2      ),
    .TageInt3         ( TageToPreC3      ),
    .TageInt4         ( TageToPreC4      ),
    .TageInt5         ( TageToPreC5      ),
    .TageInt6         ( TageToPreC6      ),
    .FetchAble        ( FetchAble        ),
    .FetchPcIvt       ( FetchPcIvt       ),
    .FetchInstIvt     ( FetchInstIvt     ),
    .FetchDate        ( FetchDate        ),
    .PreReDirectAble  ( PreToPcAble      ),
    .PreReDirectPc    ( PreToPcPc        ),
    .BtbUpPcAble      ( PreToBtbAble     ),
    .BtbUpPc          ( PreToBtbPc       ),
    .BtbUpBanKN       ( PreToBtbBank     ),
    .BtbUpTypeAble    ( PreToBtbTAble    ),
    .BtbUpType        ( PreToBtbType     ),
    .BtbUpTagetAble   ( PreToBtbGAble    ),
    .BtbUpTaget       ( PreToBtbTargrt   ),
    .RasUpAble        ( PreTORasAble     ),
    .RasPtrType       ( PreToRasType     ),
    .RasAddrDate      ( PreToRasPc       ),
    .TageUpAble       ( PreTOTageAble    ),
    .PredAble         ( PredToFTQAble    ),
    .PredJdate        ( PredToFTQJdate   ),
    .PredNum          ( PredToFTQNum     ),
    .PredInt1         ( PredToFTQU1      ),
    .PredInt2         ( PredToFTQU2      ),
    .PredInt3         ( PredToFTQU3      ),
    .PredInt4         ( PredToFTQU4      ),
    .PredInt5         ( PredToFTQU5      ),
    .PredInt6         ( PredToFTQU6      ),
    .ToIbInst1Able    ( PredTo1ISAble    ),
    .ToIbInst1Mode    ( PredTo1ISMode    ),
    .ToIbInst1Pc      ( PredTo1ISPc      ),
    .ToIbInst1Redir   ( PredTo1ISRPc     ),
    .ToIbInst1Date    ( PredTo1ISInst    ),
    .ToIbInst2Able    ( PredTo2ISAble    ),
    .ToIbInst2Mode    ( PredTo2ISMode    ),
    .ToIbInst2Pc      ( PredTo2ISPc      ),
    .ToIbInst2Redir   ( PredTo2ISRPc     ),
    .ToIbInst2Date    ( PredTo2ISInst    ),
    .ToIbInst3Able    ( PredTo3ISAble    ),
    .ToIbInst3Mode    ( PredTo3ISMode    ),
    .ToIbInst3Pc      ( PredTo3ISPc      ),
    .ToIbInst3Redir   ( PredTo3ISRPc     ),
    .ToIbInst3Date    ( PredTo3ISInst    ),
    .ToIbInst4Able    ( PredTo4ISAble    ),
    .ToIbInst4Mode    ( PredTo4ISMode    ),
    .ToIbInst4Pc      ( PredTo4ISPc      ),
    .ToIbInst4Redir   ( PredTo4ISRPc     ),
    .ToIbInst4Date    ( PredTo4ISInst    ),
    .ToIbInst5Able    ( PredTo5ISAble    ),
    .ToIbInst5Mode    ( PredTo5ISMode    ),
    .ToIbInst5Pc      ( PredTo5ISPc      ),
    .ToIbInst5Redir   ( PredTo5ISRPc     ),
    .ToIbInst5Date    ( PredTo5ISInst    ),
    .ToIbInst6Able    ( PredTo6ISAble    ),
    .ToIbInst6Mode    ( PredTo6ISMode    ),
    .ToIbInst6Pc      ( PredTo6ISPc      ),
    .ToIbInst6Redir   ( PredTo6ISRPc     ),
    .ToIbInst6Date    ( PredTo6ISInst    ),
    .ToIbInst7Able    ( PredTo7ISAble    ),
    .ToIbInst7Mode    ( PredTo7ISMode    ),
    .ToIbInst7Pc      ( PredTo7ISPc      ),
    .ToIbInst7Redir   ( PredTo7ISRPc     ),
    .ToIbInst7Date    ( PredTo7ISInst    ),
    .ToIbInst8Able    ( PredTo8ISAble    ),
    .ToIbInst8Mode    ( PredTo8ISMode    ),
    .ToIbInst8Pc      ( PredTo8ISPc      ),
    .ToIbInst8Redir   ( PredTo8ISRPc     ),
    .ToIbInst8Date    ( PredTo8ISInst    )
    );

    ICache u_ICache(
    .Clk             ( Clk             ),
    .Rest            ( Rest            ),
    .IcFLash         ( CtrlToIcacFLash ),
    .IcStop          ( CtrlToIcacStop  ),
    .IcReq           ( CtrlIcReq       ),
    .BpReq           ( CtrlBpReq       ),
    .ToMuFetch       ( IcaToMmuAble    ),
    .ToMuVritualA    ( IcaToMmuVPc     ),
    .InCOperType     ( MmuToIcaType    ),
    .InCTlbTrap      ( MmuToIcaTrap    ),
    .InCPhysicalAddr ( MmuToIcaPPc     ),
    .BpuReqAble      ( PcOutAble       ),
    .BpuReqPc        ( PcOutPc         ),
    .ToPreAble       ( IcaToPreAble    ),
    .ToPcIvt         ( IcaToPrePcgrp   ),
    .ToInstIvt       ( IcaToPreInvt    ),
    .ToDate          ( IcaToPreIgrp    ),
    .OutReadAble     ( IcaToAXIAble    ),
    .Inshankhand     ( AXIToIcaSKH     ),
    .OutUncacheRead  ( UcaToAXIAble    ),
    .OutReadAddr     ( IcaToAXIAddr    ),
    .InReadreq       ( AXIToIcaReq     ),
    .InReadBackAble  ( AXIToIcaAble    ),
    .InReadBackDate  ( AXIToIcaDate    )
    );



    InstIssueQue#(
    .INSTQUEUEDEEP ( 32 ),
    .INSTQUEUEWIDE ( 97 )
    )u_InstIssueQue(
    .Clk           ( Clk           ),
    .Rest          ( Rest          ),
    .InstQStop     ( InstQStop     ),
    .InstQFlash    ( InstQFlash    ),
    .InstQReqStop  ( InstQReqStop  ),
    .FromPre1Able  ( PredTo1ISAble ),
    .FromPre1Addr  ( PredTo1ISPc   ),
    .FromPre1Date  ( PredTo1ISInst ),
    .FromPre1Part  ( PredTo1ISMode ),
    .FromPre1NAdr  ( PredTo1ISRPc  ),
    .FromPre2Able  ( PredTo2ISAble ),
    .FromPre2Addr  ( PredTo2ISPc   ),
    .FromPre2Date  ( PredTo2ISInst ),
    .FromPre2Part  ( PredTo2ISMode ),
    .FromPre2NAdr  ( PredTo2ISRPc  ),
    .FromPre3Able  ( PredTo3ISAble ),
    .FromPre3Addr  ( PredTo3ISPc   ),
    .FromPre3Date  ( PredTo3ISInst ),
    .FromPre3Part  ( PredTo3ISMode ),
    .FromPre3NAdr  ( PredTo3ISRPc  ),
    .FromPre4Able  ( PredTo4ISAble ),
    .FromPre4Addr  ( PredTo4ISPc   ),
    .FromPre4Date  ( PredTo4ISRPc  ),
    .FromPre4Part  ( PredTo4ISMode ),
    .FromPre4NAdr  ( PredTo4ISRPc  ),
    .FromPre5Able  ( PredTo5ISAble ),
    .FromPre5Addr  ( PredTo5ISPc   ),
    .FromPre5Date  ( PredTo5ISInst ),
    .FromPre5Part  ( PredTo5ISMode ),
    .FromPre5NAdr  ( PredTo5ISRPc  ),
    .FromPre6Able  ( PredTo6ISAble ),
    .FromPre6Addr  ( PredTo6ISPc   ),
    .FromPre6Date  ( PredTo6ISInst ),
    .FromPre6Part  ( PredTo6ISMode ),
    .FromPre6NAdr  ( PredTo6ISRPc  ),
    .FromPre7Able  ( PredTo7ISAble ),
    .FromPre7Addr  ( PredTo7ISPc   ),
    .FromPre7Date  ( PredTo7ISInst ),
    .FromPre7Part  ( PredTo7ISMode ),
    .FromPre7NAdr  ( PredTo7ISRPc  ),
    .FromPre8Able  ( PredTo8ISAble ),
    .FromPre8Addr  ( PredTo8ISPc   ),
    .FromPre8Date  ( PredTo8ISInst ),
    .FromPre8Part  ( PredTo8ISMode ),
    .FromPre8NAdr  ( PredTo8ISRPc  ),
    .OutInstPort1  ( ISToDcodePort1),
    .OutInstPort2  ( ISToDcodePort2),
    .OutInstPort3  ( ISToDcodePort3),
    .OutInstPort4  ( ISToDcodePort4),
    .OutInstAddr1  ( ISToDcodeAddr1),
    .OutInstDate1  ( ISToDcodeDate1),
    .OutInstPart1  ( ISToDcodePart1),
    .OutInstNAdr1  ( ISToDcodeRPc1 ),
    .OutInstAddr2  ( ISToDcodeAddr2),
    .OutInstDate2  ( ISToDcodeDate2),
    .OutInstPart2  ( ISToDcodePart2),
    .OutInstNAdr2  ( ISToDcodeRPc2 ),
    .OutInstAddr3  ( ISToDcodeAddr3),
    .OutInstDate3  ( ISToDcodeDate3),
    .OutInstPart3  ( ISToDcodePart3),
    .OutInstNAdr3  ( ISToDcodeRPc3 ),
    .OutInstAddr4  ( ISToDcodeAddr4),
    .OutInstDate4  ( ISToDcodeDate4),
    .OutInstPart4  ( ISToDcodePart4),
    .OutInstNAdr4  ( ISToDcodeRPc4 )
    );



    Decode u_Decode(
    .Clk           ( Clk           ),
    .Rest          ( Rest          ),
    .DecodeStopS   ( DecodeStopS   ),
    .DecodeFlashS  ( DecodeFlashS  ),
    .InInstPort1   ( ISToDcodePort1   ),
    .InInstPort2   ( ISToDcodePort2   ),
    .InInstPort3   ( ISToDcodePort3   ),
    .InInstPort4   ( ISToDcodePort4   ),
    .InInstAddr1   ( ISToDcodeAddr1   ),
    .InInstDate1   ( ISToDcodeDate1   ),
    .InInstPart1   ( ISToDcodePart1   ),
    .InInstNAdr1   ( ISToDcodeRPc1   ),
    .InInstAddr2   ( ISToDcodeAddr2   ),
    .InInstDate2   ( ISToDcodeDate2   ),
    .InInstPart2   ( ISToDcodePart2   ),
    .InInstNAdr2   ( ISToDcodePart2   ),
    .InInstAddr3   ( ISToDcodeAddr3   ),
    .InInstDate3   ( ISToDcodeDate3   ),
    .InInstPart3   ( ISToDcodePart3   ),
    .InInstNAdr3   ( ISToDcodeRPc3    ),
    .InInstAddr4   ( ISToDcodeAddr4   ),
    .InInstDate4   ( ISToDcodeDate4   ),
    .InInstPart4   ( ISToDcodePart4   ),
    .InInstNAdr4   ( ISToDcodeRPc4    ),
    .Inst1Addr     ( DcdToRnm1Pc      ),
    .Inst1Opcode   ( DcdToRnm1Opcode  ),
    .Inst1SinumA   ( DcdToRnm1ImAble  ),
    .Inst1SiDate   ( DcdToRnm1ImDate  ),
    .Inst1Sr1Abl   ( DcdToRnm1Sr1Able ),
    .Inst1Sr1Num   ( DcdToRnm1Sr1Num  ),
    .Inst1Sr2Abl   ( DcdToRnm1Sr2Able ),
    .Inst1Sr2Num   ( DcdToRnm1Sr2Num  ),
    .Insr1WriteA   ( DcdToRnm1WAble   ),
    .Inst1Part     ( DcdToRnm1Part    ),
    .Inst1Nadr     ( DcdToRnm1Naddr   ),
    .Inst1WriteN   ( DcdToRnm1Wnum    ),
    .Inst2Addr     ( DcdToRnm2Pc      ),
    .Inst2Opcode   ( DcdToRnm2Opcode  ),
    .Inst2SinumA   ( DcdToRnm2ImAble  ),
    .Inst2SiDate   ( DcdToRnm2ImDate  ),
    .Inst2Sr1Abl   ( DcdToRnm2Sr1Able ),
    .Inst2Sr1Num   ( DcdToRnm2Sr1Num  ),
    .Inst2Sr2Abl   ( DcdToRnm2Sr2Able ),
    .Inst2Sr2Num   ( DcdToRnm2Sr2Num  ),
    .Insr2WriteA   ( DcdToRnm2WAble   ),
    .Inst2WriteN   ( DcdToRnm2Wnum    ),
    .Inst2Part     ( DcdToRnm2Part    ),
    .Inst2Nadr     ( DcdToRnm2Naddr   ),
    .Inst3Addr     ( DcdToRnm3Pc      ),
    .Inst3Opcode   ( DcdToRnm3Opcode  ),
    .Inst3SinumA   ( DcdToRnm3ImAble  ),
    .Inst3SiDate   ( DcdToRnm3ImDate  ),
    .Inst3Sr1Abl   ( DcdToRnm3Sr1Able ),
    .Inst3Sr1Num   ( DcdToRnm3Sr1Num  ),
    .Inst3Sr2Abl   ( DcdToRnm3Sr2Able ),
    .Inst3Sr2Num   ( DcdToRnm3Sr2Num  ),
    .Insr3WriteA   ( DcdToRnm3WAble   ),
    .Inst3WriteN   ( DcdToRnm3Wnum    ),
    .Inst3Part     ( DcdToRnm3Part    ),
    .Inst3Nadr     ( DcdToRnm3Naddr   ),
    .Inst4Addr     ( DcdToRnm4Pc      ),
    .Inst4Opcode   ( DcdToRnm4Opcode  ),
    .Inst4SinumA   ( DcdToRnm4ImAble  ),
    .Inst4SiDate   ( DcdToRnm4ImDate  ),
    .Inst4Sr1Abl   ( DcdToRnm4Sr1Able ),
    .Inst4Sr1Num   ( DcdToRnm4Sr1Num  ),
    .Inst4Sr2Abl   ( DcdToRnm4Sr2Able ),
    .Inst4Sr2Num   ( DcdToRnm4Sr2Num  ),
    .Insr4WriteA   ( DcdToRnm4WAble   ),
    .Inst4WriteN   ( DcdToRnm4Wnum    ),
    .Inst4Part     ( DcdToRnm4Part    ),
    .Inst4Nadr     ( DcdToRnm4Naddr   )
    );

        FreeList u_FreeList(
    .Clk           ( Clk           ),
    .Rest          ( Rest          ),
    .FreelistStop  ( FreelistStop  ),
    .FreeListFlash ( FreeListFlash ),
    .FreeListReq   ( FreeListReq   ),
    .InWay1Rename  ( DcdToRnm1WAble),
    .InWay1RegNum  ( DcdToRnm1Wnum ),
    .InWay2Rename  ( DcdToRnm2WAble),
    .InWay2RegNum  ( DcdToRnm2Wnum ),
    .InWay3Rename  ( DcdToRnm3WAble),
    .InWay3RegNum  ( DcdToRnm3Wnum ),
    .InWay4Rename  ( DcdToRnm4WAble),
    .InWay4RegNum  ( DcdToRnm4Wnum ),
    .OutWay1Rename ( FLToRAT1Able  ),
    .OutWay1Areg   ( FLToRAT1Areg  ),
    .OutWay1RegNum ( FLToRAT1RReg  ),
    .OutWay2Rename ( FLToRAT2Able  ),
    .OutWay2Areg   ( FLToRAT2Areg  ),
    .OutWay2RegNum ( FLToRAT2RReg  ),
    .OutWay3Rename ( FLToRAT3Able  ),
    .OutWay3Areg   ( FLToRAT2Areg  ),
    .OutWay3RegNum ( FLToRAT3RReg  ),
    .OutWay4Rename ( FLToRAT4Able  ),
    .OutWay4Areg   ( FLToRAT4Areg  ),
    .OutWay4RegNum ( FLToRAT4RReg  ),
    .ReloadAble    ( RobToFLRload  ),
    .FreeAble1     ( RefToFLF1Able ),
    .FreeAddr1     ( RefToFLF1Addr ),
    .FreeAble2     ( RefToFLF2Able ),
    .FreeAddr2     ( RefToFLF2Addr ),
    .FreeAble3     ( RefToFLF3Able ),
    .FreeAddr3     ( RefToFLF3Addr ),
    .FreeAble4     ( RefToFLF4Able ),
    .FreeAddr4     ( RefToFLF4Addr )
    );

    RenameArchTable u_RenameArchTable(
    .Clk             ( Clk             ),
    .Rest            ( Rest            ),
    .RATStop         ( RATStop         ),
    .RATFlash        ( RATFlash        ),
    .Way1RdAble      ( FLToRAT1Able    ),
    .Way1ArchAddr    ( FLToRAT1Areg    ),
    .Way1RdAddr      ( FLToRAT1RReg    ),
    .Way2RdAble      ( FLToRAT2Able    ),
    .Way2ArchAddr    ( FLToRAT2Areg    ),
    .Way2RdAddr      ( FLToRAT2RReg    ),
    .Way3RdAble      ( FLToRAT3Able    ),
    .Way3ArchAddr    ( FLToRAT3Areg    ),
    .Way3RdAddr      ( FLToRAT3RReg    ),
    .Way4RdAble      ( FLToRAT4Able    ),
    .Way4ArchAddr    ( FLToRAT4Areg    ),
    .Way4RdAddr      ( FLToRAT4RReg    ),
    .Way1Src1Able    ( DcdToRnm1Sr1Able   ),
    .Way1Src1Addr    ( DcdToRnm1Sr1Num    ),
    .Way1Src2Able    ( DcdToRnm1Sr2Able   ),
    .Way1Src2Addr    ( DcdToRnm1Sr2Num    ),
    .Way2Src1Able    ( DcdToRnm2Sr1Able   ),
    .Way2Src1Addr    ( DcdToRnm2Sr1Num    ),
    .Way2Src2Able    ( DcdToRnm2Sr2Able   ),
    .Way2Src2Addr    ( DcdToRnm2Sr2Num    ),
    .Way3Src1Able    ( DcdToRnm3Sr1Able   ),
    .Way3Src1Addr    ( DcdToRnm3Sr1Num    ),
    .Way3Src2Able    ( DcdToRnm3Sr2Able   ),
    .Way3Src2Addr    ( DcdToRnm3Sr2Num    ),
    .Way4Src1Able    ( DcdToRnm4Sr1Able   ),
    .Way4Src1Addr    ( DcdToRnm4Sr1Num    ),
    .Way4Src2Able    ( DcdToRnm4Sr2Able   ),
    .Way4Src2Addr    ( DcdToRnm4Sr2Num    ),
    .Out1Src1Able    ( RATToBYT1Sr1Able   ),
    .Out1Src1NoDate  ( RATToBYT1Sr1ND     ),
    .Out1Src1Addr    ( RATToBYT1Sr1Num    ),
    .Out1Src2Able    ( RATToBYT1Sr2Able   ),
    .Out1Src2NoDate  ( RATToBYT1Sr2ND     ),
    .Out1Src2Addr    ( RATToBYT1Sr2Num    ),
    .Out1RdAble      ( RATToBYT1WAble     ),
    .Out1RdAddr      ( RATToBYT1WNum      ),
    .Out2Src1Able    ( RATToBYT2Sr1Able   ),
    .Out2Src1NoDate  ( RATToBYT2Sr1ND     ),
    .Out2Src1Addr    ( RATToBYT2Sr1Num    ),
    .Out2Src2Able    ( RATToBYT2Sr2Able   ),
    .Out2Src2NoDate  ( RATToBYT2Sr2ND     ),
    .Out2Src2Addr    ( RATToBYT2Sr2Num    ),
    .Out2RdAble      ( RATToBYT2WAble     ),
    .Out2RdAddr      ( RATToBYT2WNum      ),
    .Out3Src1Able    ( RATToBYT3Sr1Able   ),
    .Out3Src1NoDate  ( RATToBYT3Sr1ND     ),
    .Out3Src1Addr    ( RATToBYT3Sr1Num    ),
    .Out3Src2Able    ( RATToBYT3Sr2Able   ),
    .Out3Src2NoDate  ( RATToBYT3Sr2ND     ),
    .Out3Src2Addr    ( RATToBYT3Sr2Num    ),
    .Out3RdAble      ( RATToBYT3WAble     ),
    .Out3RdAddr      ( RATToBYT3WNum      ),
    .Out4Src1Able    ( RATToBYT4Sr1Able   ),
    .Out4Src1NoDate  ( RATToBYT4Sr1ND     ),
    .Out4Src1Addr    ( RATToBYT4Sr1Num    ),
    .Out4Src2Able    ( RATToBYT4Sr2Able   ),
    .Out4Src2NoDate  ( RATToBYT4Sr2ND     ),
    .Out4Src2Addr    ( RATToBYT4Sr2Num    ),
    .Out4RdAble      ( RATToBYT4WAble     ),
    .Out4RdAddr      ( RATToBYT4WNum      ),
    .Lock1Able       ( RATToRefLock1      ),
    .Lock1Addr       ( RATToRefLock1Addr  ),
    .Lock2Able       ( RATToRefLock2      ),
    .Lock2Addr       ( RATToRefLock2Addr  ),
    .Lock3Able       ( RATToRefLock3      ),
    .Lock3Addr       ( RATToRefLock3Addr  ),
    .Lock4Able       ( RATToRefLock4      ),
    .Lock4Addr       ( RATToRefLock4Addr  ),
    .Use1Able        ( RATToRefUse1       ),
    .Use1Addr        ( RATToRefUse1Addr   ),
    .Use2Able        ( RATToRefUse2       ),
    .Use2Addr        ( RATToRefUse2Addr   ),
    .Use3Able        ( RATToRefUse3       ),
    .Use3Addr        ( RATToRefUse3Addr   ),
    .Use4Able        ( RATToRefUse4       ),
    .Use4Addr        ( RATToRefUse4Addr   ),
    .Use5Able        ( RATToRefUse5       ),
    .Use5Addr        ( RATToRefUse5Addr   ),
    .Use6Able        ( RATToRefUse6       ),
    .Use6Addr        ( RATToRefUse6Addr   ),
    .Use7Able        ( RATToRefUse7       ),
    .Use7Addr        ( RATToRefUse7Addr   ),
    .Use8Able        ( RATToRefUse8       ),
    .Use8Addr        ( RATToRefUse8Addr   ),
    .Use9Able        ( RATToRefUse9       ),
    .Use9Addr        ( RATToRefUse9Addr   ),
    .Use10Able       ( RATToRefUse10      ),
    .Use10Addr       ( RATToRefUse10Addr  ),
    .Use11Able       ( RATToRefUse11      ),
    .Use11Addr       ( RATToRefUse11Addr  ),
    .Use12Able       ( RATToRefUse12      ),
    .Use12Addr       ( RATToRefUse12Addr  )
    );

    BusyTable u_BusyTable(
    .Clk             ( Clk             ),
    .Rest            ( Rest            ),
    .BusyStop        ( BusyStop        ),
    .BusyFlash       ( BusyFlash       ),
    .UnBusyAble1     ( UnBusyAble1     ),
    .UnBusyAddr1     ( UnBusyAddr1     ),
    .UnBusyAble2     ( UnBusyAble2     ),
    .UnBusyAddr2     ( UnBusyAddr2     ),
    .UnBusyAble3     ( UnBusyAble3     ),
    .UnBusyAddr3     ( UnBusyAddr3     ),
    .UnBusyAble4     ( UnBusyAble4     ),
    .UnBusyAddr4     ( UnBusyAddr4     ),
    .UnBusyAble5     ( UnBusyAble5     ),
    .UnBusyAddr5     ( UnBusyAddr5     ),
    .UnBusyAble6     ( UnBusyAble6     ),
    .UnBusyAddr6     ( UnBusyAddr6     ),
    .UnBusyAble7     ( UnBusyAble7     ),
    .UnBusyAddr7     ( UnBusyAddr7     ),
    .BIn1Src1Able    ( RATToBYT1Sr1Able),
    .BIn1Src1NoDate  ( RATToBYT1Sr1ND  ),
    .BIn1Src1Addr    ( RATToBYT1Sr1Num ),
    .BIn1Src2Able    ( RATToBYT1Sr2Able),
    .BIn1Src2NoDate  ( RATToBYT1Sr2ND  ),
    .BIn1Src2Addr    ( RATToBYT1Sr2Num ),
    .BIn1RdAble      ( RATToBYT1WAble  ),
    .BIn1RdAddr      ( RATToBYT1WNum   ),
    .BIn2Src1Able    ( RATToBYT2Sr1Able),
    .BIn2Src1NoDate  ( RATToBYT2Sr1ND  ),
    .BIn2Src1Addr    ( RATToBYT2Sr1Num ),
    .BIn2Src2Able    ( RATToBYT2Sr2Able),
    .BIn2Src2NoDate  ( RATToBYT2Sr2ND  ),
    .BIn2Src2Addr    ( RATToBYT2Sr2Num ),
    .BIn2RdAble      ( RATToBYT2WAble  ),
    .BIn2RdAddr      ( RATToBYT2WNum   ),
    .BIn3Src1Able    ( RATToBYT3Sr1Able),
    .BIn3Src1NoDate  ( RATToBYT3Sr1ND  ),
    .BIn3Src1Addr    ( RATToBYT3Sr1Num ),
    .BIn3Src2Able    ( RATToBYT3Sr2Able),
    .BIn3Src2NoDate  ( RATToBYT3Sr2ND  ),
    .BIn3Src2Addr    ( RATToBYT3Sr2Num ),
    .BIn3RdAble      ( RATToBYT3WAble  ),
    .BIn3RdAddr      ( RATToBYT3WNum   ),
    .BIn4Src1Able    ( RATToBYT4Sr1Able),
    .BIn4Src1NoDate  ( RATToBYT4Sr1ND  ),
    .BIn4Src1Addr    ( RATToBYT4Sr1Num ),
    .BIn4Src2Able    ( RATToBYT4Sr2Able),
    .BIn4Src2NoDate  ( RATToBYT4Sr2ND  ),
    .BIn4Src2Addr    ( RATToBYT4Sr2Num ),
    .BIn4RdAble      ( RATToBYT4WAble  ),
    .BIn4RdAddr      ( RATToBYT4WNum   ),
    .BOut1Src1Able   ( BYTToIQ1Sr1Able ),
    .Bout1Src1Ready  ( BYTToIQ1Sr1Ready),
    .BOut1Src1Addr   ( BYTToIQ1Sr1Num  ),
    .BOut1Src2Able   ( BYTToIQ1Sr2Able ),
    .Bout1Src2Ready  ( BYTToIQ1Sr2Ready),
    .BOut1Src2Addr   ( BYTToIQ1Sr2Num  ),
    .BOut1RdAble     ( BYTToIQ1WAble   ),
    .BOut1RdAddr     ( BYTToIQ1WNum    ),
    .BOut2Src1Able   ( BYTToIQ2Sr1Able ),
    .Bout2Src1Ready  ( BYTToIQ2Sr1Ready),
    .BOut2Src1Addr   ( BYTToIQ2Sr1Num  ),
    .BOut2Src2Able   ( BYTToIQ2Sr2Able ),
    .Bout2Src2Ready  ( BYTToIQ2Sr2Ready),
    .BOut2Src2Addr   ( BYTToIQ2Sr2Num  ),
    .BOut2RdAble     ( BYTToIQ2WAble   ),
    .BOut2RdAddr     ( BYTToIQ2WNum    ),
    .BOut3Src1Able   ( BYTToIQ3Sr1Able ),
    .Bout3Src1Ready  ( BYTToIQ3Sr1Ready),
    .BOut3Src1Addr   ( BYTToIQ3Sr1Num  ),
    .BOut3Src2Able   ( BYTToIQ3Sr2Able ),
    .Bout3Src2Ready  ( BYTToIQ3Sr2Ready),
    .BOut3Src2Addr   ( BYTToIQ3Sr2Num  ),
    .BOut3RdAble     ( BYTToIQ3WAble   ),
    .BOut3RdAddr     ( BYTToIQ3WNum    ),
    .BOut4Src1Able   ( BYTToIQ4Sr1Able ),
    .Bout4Src1Ready  ( BYTToIQ4Sr1Ready),
    .BOut4Src1Addr   ( BYTToIQ4Sr1Num  ),
    .BOut4Src2Able   ( BYTToIQ4Sr2Able ),
    .Bout4Src2Ready  ( BYTToIQ4Sr2Ready),
    .BOut4Src2Addr   ( BYTToIQ4Sr2Num  ),
    .BOut4RdAble     ( BYTToIQ4WAble   ),
    .BOut4RdAddr     ( BYTToIQ4WNum    )
    );

    RefTable u_RefTable(
    .Clk             ( Clk             ),
    .Rest            ( Rest            ),
    .RefTableStop    ( RefTableStop    ),
    .RefTableFLash   ( RefTableFLash   ),
    .Inst1Src1Able   ( RATToRefUse1    ),
    .Inst1Src1Addr   ( RATToRefUse1Addr),
    .Inst1Src2Able   ( RATToRefUse2    ),
    .Inst1Src2Addr   ( RATToRefUse2Addr),
    .Inst1RdAble     ( RATToRefUse3    ),
    .Inst1RdAddr     ( RATToRefUse3Addr),
    .Inst2Src1Able   ( RATToRefUse4    ),
    .Inst2Src1Addr   ( RATToRefUse4Addr),
    .Inst2Src2Able   ( RATToRefUse5    ),
    .Inst2Src2Addr   ( RATToRefUse5Addr),
    .Inst2RdAble     ( RATToRefUse6    ),
    .Inst2RdAddr     ( RATToRefUse6Addr),
    .Inst3Src1Able   ( RATToRefUse7    ),
    .Inst3Src1Addr   ( RATToRefUse7Addr),
    .Inst3Src2Able   ( RATToRefUse8    ),
    .Inst3Src2Addr   ( RATToRefUse8Addr),
    .Inst3RdAble     ( RATToRefUse9    ),
    .Inst3RdAddr     ( RATToRefUse9Addr),
    .Inst4Src1Able   ( RATToRefUse10   ),
    .Inst4Src1Addr   ( RATToRefUse10Addr),
    .Inst4Src2Able   ( RATToRefUse11   ),
    .Inst4Src2Addr   ( RATToRefUse11Addr),
    .Inst4RdAble     ( RATToRefUse12   ),
    .Inst4RdAddr     ( RATToRefUse12Addr),
    .Lock1Able       ( RATToRefLock1   ),
    .Lock1Addr       ( RATToRefLock1Addr),
    .Lock2Able       ( RATToRefLock2   ),
    .Lock2Addr       ( RATToRefLock2Addr),
    .Lock3Able       ( RATToRefLock3   ),
    .Lock3Addr       ( RATToRefLock3Addr),
    .Lock4Able       ( RATToRefLock4   ),
    .Lock4Addr       ( RATToRefLock4Addr),
    .Inst1Read1Able  ( PHYToRef1Sr1Able),
    .Inst1Read1Addr  ( PHYToRef1Sr1Num ),
    .Inst1Read2Able  ( PHYToRef1Sr2Able),
    .Inst1Read2Addr  ( PHYToRef1Sr2Num ),
    .Inst2Read1Able  ( PHYToRef2Sr1Able),
    .Inst2Read1Addr  ( PHYToRef2Sr1Num ),
    .Inst2Read2Able  ( PHYToRef2Sr2Able),
    .Inst2Read2Addr  ( PHYToRef2Sr2Num ),
    .Inst3Read1Able  ( PHYToRef3Sr1Able),
    .Inst3Read1Addr  ( PHYToRef3Sr1Num ),
    .Inst3Read2Able  ( PHYToRef3Sr2Able),
    .Inst3Read2Addr  ( PHYToRef3Sr2Num ),
    .Inst4Read1Able  ( PHYToRef4Sr1Able),
    .Inst4Read1Addr  ( PHYToRef4Sr1Num ),
    .Inst4Read2Able  ( PHYToRef4Sr2Able),
    .Inst4Read2Addr  ( PHYToRef4Sr2Num ),
    .WritBack1Able   ( PHYToRef1WAble  ),
    .WritBack1Addr   ( PHYToRef1Wnum   ),
    .WritBack2Able   ( PHYToRef2WAble  ),
    .WritBack2Addr   ( PHYToRef2Wnum   ),
    .WritBack3Able   ( PHYToRef3WAble  ),
    .WritBack3Addr   ( PHYToRef3Wnum   ),
    .WritBack4Able   ( PHYToRef4WAble  ),
    .WritBack4Addr   ( PHYToRef4Wnum   ),
    .WritBack5Able   ( PHYToRef5WAble  ),
    .WritBack5Addr   ( PHYToRef5Wnum   ),
    .WritBack6Able   ( PHYToRef6WAble  ),
    .WritBack6Addr   ( PHYToRef6Wnum   ),
    .WritBack7Able   ( PHYToRef7WAble  ),
    .WritBack7Addr   ( PHYToRef7Wnum   ),
    .WritBack8Able   ( PHYToRef8WAble  ),
    .WritBack8Addr   ( PHYToRef8Wnum   ),
    .WriteNum1       ( RefToFLF1Addr   ),
    .WriteAble1      ( RefToFLF1Able   ),
    .WriteNum2       ( RefToFLF2Addr   ),
    .WriteAble2      ( RefToFLF2Able   ),
    .WriteNum3       ( RefToFLF3Addr   ),
    .WriteAble3      ( RefToFLF3Able   ),
    .WriteNum4       ( RefToFLF4Addr   ),
    .WriteAble4      ( RefToFLF4Able   )
    );

    reg                   StopTemp  ;
    reg                   FLashTemp ;

    always @(posedge Clk) begin
        if(!Rest) begin
            StopTemp   <= 1'b0 ;
            FLashTemp  <= 1'b0 ;
        end
        else begin
            StopTemp   <=      ;
            FLashTemp  <=      ;
        end
    end

    reg                   DcdToBrCsr1Able;
    reg                   DcdToInt1Able  ;
    reg                   DcdToMem1Able  ;
    reg                   DcdToBrCsr2Able;
    reg                   DcdToInt2Able  ;
    reg                   DcdToMem2Able  ;
    reg                   DcdToBrCsr3Able;
    reg                   DcdToInt3Able  ;
    reg                   DcdToMem3Able  ;
    reg                   DcdToBrCsr4Able;
    reg                   DcdToInt4Able  ;
    reg                   DcdToMem4Able  ;
    reg [`MicOperateCode] DcdToIQ1MicOp  ;    
    reg                   DcdToIQ1ImAble ;
    reg [25:0]            DcdToIQ1ImDate ;
    reg                   DcdToIQ1Mode   ;
    reg [`InstAddrBus]    DcdToIQ1RAddr  ;
    reg                   DcdToIQ2Able   ;
    reg [`MicOperateCode] DcdToIQ2MicOp  ;    
    reg                   DcdToIQ2ImAble ;
    reg [25:0]            DcdToIQ2ImDate ;
    reg                   DcdToIQ2Mode   ;
    reg [`InstAddrBus]    DcdToIQ2RAddr  ;
    reg                   DcdToIQ3Able   ;
    reg [`MicOperateCode] DcdToIQ3MicOp  ;    
    reg                   DcdToIQ3ImAble ;
    reg [25:0]            DcdToIQ3ImDate ;
    reg                   DcdToIQ3Mode   ;
    reg [`InstAddrBus]    DcdToIQ3RAddr  ;
    reg                   DcdToIQ4Able   ;
    reg [`MicOperateCode] DcdToIQ4MicOp  ;    
    reg                   DcdToIQ4ImAble ;
    reg [25:0]            DcdToIQ4ImDate ;
    reg                   DcdToIQ4Mode   ;
    reg [`InstAddrBus]    DcdToIQ4RAddr  ;
    reg [2:0]             DcdToCsrBruNum ;
    reg [2:0]             DcdToIntNum    ;
    reg [2:0]             DcdToMemNum    ;

    wire  BrCsr1Able  = (DcdToRnm1Opcode[7:5] == 4) | (DcdToRnm1Opcode[7:5] == 7) ;
    wire  Int1Able    = (DcdToRnm1Opcode[7:5] == 1) | (DcdToRnm1Opcode[7:5] == 2) | (DcdToRnm1Opcode[7:5] == 3) ;
    wire  Mem1Able    = (DcdToRnm1Opcode[7:5] == 0) | (DcdToRnm1Opcode[7:5] == 5) ;

    wire  BrCsr2Able  = (DcdToRnm2Opcode[7:5] == 4) | (DcdToRnm2Opcode[7:5] == 7) ;
    wire  Int2Able    = (DcdToRnm2Opcode[7:5] == 1) | (DcdToRnm2Opcode[7:5] == 2) | (DcdToRnm2Opcode[7:5] == 3) ;
    wire  Mem2Able    = (DcdToRnm2Opcode[7:5] == 0) | (DcdToRnm2Opcode[7:5] == 5) ;

    wire  BrCsr3Able  = (DcdToRnm3Opcode[7:5] == 4) | (DcdToRnm3Opcode[7:5] == 7) ;
    wire  Int3Able    = (DcdToRnm3Opcode[7:5] == 1) | (DcdToRnm3Opcode[7:5] == 2) | (DcdToRnm3Opcode[7:5] == 3) ;
    wire  Mem3Able    = (DcdToRnm3Opcode[7:5] == 0) | (DcdToRnm3Opcode[7:5] == 5) ;

    wire  BrCsr4Able  = (DcdToRnm4Opcode[7:5] == 4) | (DcdToRnm4Opcode[7:5] == 7) ;
    wire  Int4Able    = (DcdToRnm4Opcode[7:5] == 1) | (DcdToRnm4Opcode[7:5] == 2) | (DcdToRnm4Opcode[7:5] == 3) ;
    wire  Mem4Able    = (DcdToRnm4Opcode[7:5] == 0) | (DcdToRnm4Opcode[7:5] == 5) ;

    wire [2:0]  AddBrCsrNum =    BrCsr1Able + BrCsr2Able + BrCsr3Able + BrCsr4Able ; 
    wire [2:0]  AddIntNum   =    Int1Able   + Int2Able   + Int3Able   + Int4Able   ;
    wire [2:0]  AddMemNum   =    Mem1Able   + Mem2Able   + Mem3Able   + Mem4Able   ;

    always @(posedge Clk) begin
        if(!Rest) begin
            DcdToBrCsr1Able  <=  1'b0  ;
            DcdToInt1Able    <=  1'b0  ;
            DcdToMem1Able    <=  1'b0  ;
            DcdToIQ1MicOp    <=  8'b0  ;
            DcdToIQ1ImAble   <=  1'b0  ;
            DcdToIQ1ImDate   <=  26'd0 ;
            DcdToIQ1Mode     <=  1'b0  ;
            DcdToIQ1RAddr    <=  32'd0 ;
            DcdToBrCsr2Able  <=  1'b0  ;
            DcdToInt2Able    <=  1'b0  ;
            DcdToMem2Able    <=  1'b0  ;
            DcdToIQ2MicOp    <=  8'b0  ;
            DcdToIQ2ImAble   <=  1'b0  ;
            DcdToIQ2ImDate   <=  26'd0 ;
            DcdToIQ2Mode     <=  1'b0  ;
            DcdToIQ2RAddr    <=  32'd0 ;
            DcdToBrCsr3Able  <=  1'b0  ;
            DcdToInt3Able    <=  1'b0  ;
            DcdToMem3Able    <=  1'b0  ;
            DcdToIQ3MicOp    <=  8'b0  ;
            DcdToIQ3ImAble   <=  1'b0  ;
            DcdToIQ3ImDate   <=  26'd0 ;
            DcdToIQ3Mode     <=  1'b0  ;
            DcdToIQ3RAddr    <=  32'd0 ;
            DcdToBrCsr4Able  <=  1'b0  ;
            DcdToInt4Able    <=  1'b0  ;
            DcdToMem4Able    <=  1'b0  ;
            DcdToIQ4MicOp    <=  8'b0  ;
            DcdToIQ4ImAble   <=  1'b0  ;
            DcdToIQ4ImDate   <=  26'd0 ;
            DcdToIQ4Mode     <=  1'b0  ;
            DcdToIQ4RAddr    <=  32'd0 ;
            DcdToCsrBruNum   <=  3'd0  ;
            DcdToIntNum      <=  3'd0  ;
            DcdToMemNum      <=  3'd0  ;
        end 
        else if(StopTemp) begin
            DcdToBrCsr1Able  <=  DcdToBrCsr1Able   ;
            DcdToInt1Able    <=  DcdToInt1Able     ;
            DcdToMem1Able    <=  DcdToMem1Able     ;
            DcdToIQ1MicOp    <=  DcdToIQ1MicOp     ;
            DcdToIQ1ImAble   <=  DcdToIQ1ImAble    ;
            DcdToIQ1ImDate   <=  DcdToIQ1ImDate    ;
            DcdToIQ1Mode     <=  DcdToIQ1Mode      ;
            DcdToIQ1RAddr    <=  DcdToIQ1RAddr     ;
            DcdToBrCsr2Able  <=  DcdToBrCsr2Able   ;
            DcdToInt2Able    <=  DcdToInt2Able     ;
            DcdToMem2Able    <=  DcdToMem2Able     ;
            DcdToIQ2MicOp    <=  DcdToIQ2MicOp     ;
            DcdToIQ2ImAble   <=  DcdToIQ2ImAble    ;
            DcdToIQ2ImDate   <=  DcdToIQ2ImDate    ;
            DcdToIQ2Mode     <=  DcdToIQ2Mode      ;
            DcdToIQ2RAddr    <=  DcdToIQ2RAddr     ;
            DcdToBrCsr3Able  <=  DcdToBrCsr3Able   ;
            DcdToInt3Able    <=  DcdToInt3Able     ;
            DcdToMem3Able    <=  DcdToMem3Able     ;
            DcdToIQ3MicOp    <=  DcdToIQ3MicOp     ;
            DcdToIQ3ImAble   <=  DcdToIQ3ImAble    ;
            DcdToIQ3ImDate   <=  DcdToIQ3ImDate    ;
            DcdToIQ3Mode     <=  DcdToIQ3Mode      ;
            DcdToIQ3RAddr    <=  DcdToIQ3RAddr     ;
            DcdToBrCsr3Able  <=  DcdToBrCsr3Able   ;
            DcdToInt3Able    <=  DcdToInt3Able     ;
            DcdToMem3Able    <=  DcdToMem3Able     ;
            DcdToIQ4MicOp    <=  DcdToIQ4MicOp     ;
            DcdToIQ4ImAble   <=  DcdToIQ4ImAble    ;
            DcdToIQ4ImDate   <=  DcdToIQ4ImDate    ;
            DcdToIQ4Mode     <=  DcdToIQ4Mode      ;
            DcdToIQ4RAddr    <=  DcdToIQ4RAddr     ;
            DcdToCsrBruNum   <=  DcdToCsrBruNum    ;
            DcdToIntNum      <=  DcdToIntNum       ;
            DcdToMemNum      <=  DcdToMemNum       ;
        end
        else if(FlashTemp) begin
            DcdToBrCsr1Able  <=  1'b0  ;
            DcdToInt1Able    <=  1'b0  ;
            DcdToMem1Able    <=  1'b0  ;
            DcdToIQ1MicOp    <=  8'b0  ;
            DcdToIQ1ImAble   <=  1'b0  ;
            DcdToIQ1ImDate   <=  26'd0 ;
            DcdToIQ1Mode     <=  1'b0  ;
            DcdToIQ1RAddr    <=  32'd0 ;
            DcdToBrCsr2Able  <=  1'b0  ;
            DcdToInt2Able    <=  1'b0  ;
            DcdToMem2Able    <=  1'b0  ;
            DcdToIQ2MicOp    <=  8'b0  ;
            DcdToIQ2ImAble   <=  1'b0  ;
            DcdToIQ2ImDate   <=  26'd0 ;
            DcdToIQ2Mode     <=  1'b0  ;
            DcdToIQ2RAddr    <=  32'd0 ;
            DcdToBrCsr3Able  <=  1'b0  ;
            DcdToInt3Able    <=  1'b0  ;
            DcdToMem3Able    <=  1'b0  ;
            DcdToIQ3MicOp    <=  8'b0  ;
            DcdToIQ3ImAble   <=  1'b0  ;
            DcdToIQ3ImDate   <=  26'd0 ;
            DcdToIQ3Mode     <=  1'b0  ;
            DcdToIQ3RAddr    <=  32'd0 ;
            DcdToBrCsr4Able  <=  1'b0  ;
            DcdToInt4Able    <=  1'b0  ;
            DcdToMem4Able    <=  1'b0  ;
            DcdToIQ4MicOp    <=  8'b0  ;
            DcdToIQ4ImAble   <=  1'b0  ;
            DcdToIQ4ImDate   <=  26'd0 ;
            DcdToIQ4Mode     <=  1'b0  ;
            DcdToIQ4RAddr    <=  32'd0 ;
            DcdToCsrBruNum   <=  3'd0  ;
            DcdToIntNum      <=  3'd0  ;
            DcdToMemNum      <=  3'd0  ;
        end
        else begin
            DcdToBrCsr1Able  <=  BrCsr1Able       ;
            DcdToInt1Able    <=  Int1Able         ;
            DcdToMem1Able    <=  Mem1Able         ;
            DcdToIQ1MicOp    <=  DcdToRnm1Opcode  ;
            DcdToIQ1ImAble   <=  DcdToRnm1ImAble  ;
            DcdToIQ1ImDate   <=  DcdToRnm1ImDate  ;
            DcdToIQ1Mode     <=  DcdToRnm1Part    ;
            DcdToIQ1RAddr    <=  DcdToRnm1Naddr   ;
            DcdToBrCsr2Able  <=  BrCsr2Able       ;
            DcdToInt2Able    <=  Int2Able         ;
            DcdToMem2Able    <=  Mem2Able         ;
            DcdToIQ2MicOp    <=  DcdToRnm2Opcode  ;
            DcdToIQ2ImAble   <=  DcdToRnm2ImAble  ;
            DcdToIQ2ImDate   <=  DcdToRnm2ImDate  ;
            DcdToIQ2Mode     <=  DcdToRnm2Part    ;
            DcdToIQ2RAddr    <=  DcdToRnm2Naddr   ;
            DcdToBrCsr3Able  <=  BrCsr3Able       ;
            DcdToInt3Able    <=  Int3Able         ;
            DcdToMem3Able    <=  Mem3Able         ;
            DcdToIQ3MicOp    <=  DcdToRnm3Opcode  ;
            DcdToIQ3ImAble   <=  DcdToRnm3ImAble  ;
            DcdToIQ3ImDate   <=  DcdToRnm3ImDate  ;
            DcdToIQ3Mode     <=  DcdToRnm3Part    ;
            DcdToIQ3RAddr    <=  DcdToRnm3Naddr   ;
            DcdToBrCsr4Able  <=  BrCsr4Able       ;
            DcdToInt3Able    <=  Int4Able         ;
            DcdToMem3Able    <=  Mem4Able         ;
            DcdToIQ4MicOp    <=  DcdToRnm4Opcode  ;
            DcdToIQ4ImAble   <=  DcdToRnm4ImAble  ;
            DcdToIQ4ImDate   <=  DcdToRnm4ImDate  ;
            DcdToIQ4Mode     <=  DcdToRnm4Part    ;
            DcdToIQ4RAddr    <=  DcdToRnm4Naddr   ;
            DcdToCsrBruNum   <=  AddBrCsrNum      ;
            DcdToIntNum      <=  AddIntNum        ;
            DcdToMemNum      <=  AddMemNum        ;
        end
    end


    IssueQueueBrCsr u_IssueQueueBrCsr(
    .Clk               ( Clk               ),
    .Rest              ( Rest              ),
    .BrCsrStop         ( BrCsrStop         ),
    .BrCsrFlash        ( BrCsrFlash        ),
    .BrCsrReq          ( BrCsrReq          ),
    .BInIQInstNum      ( DcdToCsrBruNum    ),
    .BIn1Src1Able      ( BYTToIQ1Sr1Able   ),
    .BIn1Src1Ready     ( BYTToIQ1Sr1Ready  ),
    .BIn1Src1Addr      ( BYTToIQ1Sr1Num    ),
    .BIn1Src2Able      ( BYTToIQ1Sr2Able   ),
    .BIn1Src2Ready     ( BYTToIQ1Sr2Ready  ),
    .BIn1Src2Addr      ( BYTToIQ1Sr2Num    ),
    .BIn1RdAble        ( BYTToIQ1WAble     ),
    .BIn1RdAddr        ( BYTToIQ1WNum      ),
    .BIn2Src1Able      ( BYTToIQ2Sr1Able   ),
    .BIn2Src1Ready     ( BYTToIQ2Sr1Ready  ),
    .BIn2Src1Addr      ( BYTToIQ2Sr1Num    ),
    .BIn2Src2Able      ( BYTToIQ2Sr2Able   ),
    .BIn2Src2Ready     ( BYTToIQ2Sr2Ready  ),
    .BIn2Src2Addr      ( BYTToIQ2Sr2Num    ),
    .BIn2RdAble        ( BYTToIQ2WAble     ),
    .BIn2RdAddr        ( BYTToIQ2WNum      ),
    .BIn3Src1Able      ( BYTToIQ3Sr1Able   ),
    .BIn3Src1Ready     ( BYTToIQ3Sr1Ready  ),
    .BIn3Src1Addr      ( BYTToIQ3Sr1Num    ),
    .BIn3Src2Able      ( BYTToIQ3Sr2Able   ),
    .BIn3Src2Ready     ( BYTToIQ3Sr2Ready  ),
    .BIn3Src2Addr      ( BYTToIQ3Sr2Num    ),
    .BIn3RdAble        ( BYTToIQ3WAble     ),
    .BIn3RdAddr        ( BYTToIQ3WNum      ),
    .BIn4Src1Able      ( BYTToIQ4Sr1Able   ),
    .BIn4Src1Ready     ( BYTToIQ4Sr1Ready  ),
    .BIn4Src1Addr      ( BYTToIQ4Sr1Num    ),
    .BIn4Src2Able      ( BYTToIQ4Sr2Able   ),
    .BIn4Src2Ready     ( BYTToIQ4Sr2Ready  ),
    .BIn4Src2Addr      ( BYTToIQ4Sr2Num    ),
    .BIn4RdAble        ( BYTToIQ4WAble     ),
    .BIn4RdAddr        ( BYTToIQ4WNum      ),
    .BIn1aAble         ( DcdToBrCsr1Able   ),
    .BIn1MicOpcode     ( DcdToIQ1MicOp     ),
    .BIn1ImmAble       ( DcdToIQ1ImAble    ),
    .BIn1ImmDate       ( DcdToIQ1ImDate    ),
    .BIn1Mode          ( DcdToIQ1Mode      ),
    .BIn1ReDirAddr     ( DcdToIQ1RAddr     ),
    .BIn1RobPtr        ( BIn1RobPtr        ),
    .BIn2aAble         ( DcdToBrCsr2Able   ),
    .BIn2MicOpcode     ( DcdToIQ2MicOp     ),
    .BIn2ImmAble       ( DcdToIQ2ImAble    ),
    .BIn2ImmDate       ( DcdToIQ2ImDate    ),
    .BIn2Mode          ( DcdToIQ2Mode      ),
    .BIn2ReDirAddr     ( DcdToIQ2RAddr     ),
    .BIn2RobPtr        ( BIn2RobPtr        ),
    .BIn3aAble         ( DcdToBrCsr2Able   ),
    .BIn3MicOpcode     ( DcdToIQ2MicOp     ),
    .BIn3ImmAble       ( DcdToIQ2ImAble    ),
    .BIn3ImmDate       ( DcdToIQ2ImDate    ),
    .BIn3Mode          ( DcdToIQ2Mode      ),
    .BIn3ReDirAddr     ( DcdToIQ2RAddr     ),
    .BIn3RobPtr        ( BIn3RobPtr        ),
    .BIn4aAble         ( DcdToBrCsr4Able   ),
    .BIn4MicOpcode     ( DcdToIQ4MicOp     ),
    .BIn4ImmAble       ( DcdToIQ4ImAble    ),
    .BIn4ImmDate       ( DcdToIQ4ImDate    ),
    .BIn4Mode          ( DcdToIQ4Mode      ),
    .BIn4ReDirAddr     ( DcdToIQ4RAddr     ),
    .BIn4RobPtr        ( BIn4RobPtr        ),
    .CsrReq            ( EXCsrToIQReq      ),
    .BrReq             ( EXBrToIQReq       ),
    .FromIsQAlu1       ( IntToBrCsrWKAlu1  ),
    .FromAlu1Addr      ( IntToBrCsrWKANum1 ),
    .FromIsQAlu2       ( IntToBrCsrWKAlu2  ),
    .FromAlu2Addr      ( IntToBrCsrWKANum2 ),
    .FromIsQMul        ( IntToBrCsrWKMul   ),
    .FromMulAddr       ( IntToBrCsrWKMNum  ),
    .ByPassBDiv        ( ByPassDivAble     ),
    .ByPassBDivAddr    ( ByPassDivNum      ),
    .BypassBSC         ( ByPassSCAble      ),
    .BypassBSCAddr     ( ByPassSCNum       ),
    .ByPassBLoad       ( ByPassLoadAble    ),
    .ByPassBLoadAddr   ( ByPassLoadNum     ),
    .OutCsrAble        ( CsrToOtherAble    ),
    .OutCsrAddr        ( CsrToOtherAddr    ),
    .OutBruAble        ( BrToOtherAble     ),
    .OutBruAddr        ( BrToOtherAddr     ),
    .BInst1MicOperate  ( BrCsrTo1EUMicop   ),
    .BInst1Src1RAble   ( BrCsrTo1EUSr1A    ),
    .BInst1Src1RAddr   ( BrCsrTo1EUSr1Num  ),
    .BInst1Src2RAble   ( BrCsrTo1EUSr2A    ),
    .BInst1Src2RAddr   ( BrCsrTo1EUSr2Num  ),
    .BInst1ImmAble     ( BrCsrTo1EUImA     ),
    .BInst1ImmDate     ( BrCsrTO1EUImDate  ),
    .BInst1RdAble      ( BrCsrTo1EURdA     ),
    .BInst1RdAddr      ( BRCsrTo1EURdNum   ),
    .BInst1Mode        ( BrCsrTo1EUMode    ),
    .BInst1RedieAddr   ( BrCsrTo1EURAddr   ),
    .BInst1RoBptr      ( BrCstTO1EURobPtr  ),
    .BInst2MicOperate  ( BrCsrTo2EUMicop   ),
    .BInst2Src1RAble   ( BrCsrTo2EUSr1A    ),
    .BInst2Src1RAddr   ( BrCsrTo2EUSr1Num  ),
    .BInst2Src2RAble   ( BrCsrTo2EUSr2A    ),
    .BInst2Src2RAddr   ( BrCsrTo2EUSr2Num  ),
    .BInst2ImmAble     ( BrCsrTo2EUImA     ),
    .BInst2ImmDate     ( BrCsrTO2EUImDate  ),
    .BInst2RdAble      ( BrCsrTo2EURdA     ),
    .BInst2RdAddr      ( BRCsrTo2EURdNum   ),
    .BInst2RoBptr      ( BrCstTO2EURobPtr  )
    );

    IssueQueueInt u_IssueQueueInt(
    .Clk              ( Clk                 ),
    .Rest             ( Rest                ),
    .IsQuIntStop      ( IsQuIntStop         ),
    .IsQuIntFlash     ( IsQuIntFlash        ),
    .IsQuIntReq       ( IsQuIntReq          ),
    .InIQInstNum      ( DcdToIntNum         ),
    .In1Src1Able      ( BYTToIQ1Sr1Able     ),
    .In1Src1Ready     ( BYTToIQ1Sr1Ready    ),
    .In1Src1Addr      ( BYTToIQ1Sr1Num      ),
    .In1Src2Able      ( BYTToIQ1Sr2Able     ),
    .In1Src2Ready     ( BYTToIQ1Sr2Ready    ),
    .In1Src2Addr      ( BYTToIQ1Sr2Num      ),
    .In1RdAble        ( BYTToIQ1WAble       ),
    .In1RdAddr        ( BYTToIQ1WNum        ),
    .In2Src1Able      ( BYTToIQ2Sr1Able     ),
    .In2Src1Ready     ( BYTToIQ2Sr1Ready    ),
    .In2Src1Addr      ( BYTToIQ2Sr1Num      ),
    .In2Src2Able      ( BYTToIQ2Sr2Able     ),
    .In2Src2Ready     ( BYTToIQ2Sr2Ready    ),
    .In2Src2Addr      ( BYTToIQ2Sr2Num      ),
    .In2RdAble        ( BYTToIQ2WAble       ),
    .In2RdAddr        ( BYTToIQ2WNum        ),
    .In3Src1Able      ( BYTToIQ3Sr1Able     ),
    .In3Src1Ready     ( BYTToIQ3Sr1Ready    ),
    .In3Src1Addr      ( BYTToIQ3Sr1Num      ),
    .In3Src2Able      ( BYTToIQ3Sr2Able     ),
    .In3Src2Ready     ( BYTToIQ3Sr2Ready    ),
    .In3Src2Addr      ( BYTToIQ3Sr2Num      ),
    .In3RdAble        ( BYTToIQ3WAble       ),
    .In3RdAddr        ( BYTToIQ3WNum        ),
    .In4Src1Able      ( BYTToIQ4Sr1Able     ),
    .In4Src1Ready     ( BYTToIQ4Sr1Ready    ),
    .In4Src1Addr      ( BYTToIQ4Sr1Num      ),
    .In4Src2Able      ( BYTToIQ4Sr2Able     ),
    .In4Src2Ready     ( BYTToIQ4Sr2Ready    ),
    .In4Src2Addr      ( BYTToIQ4Sr2Num      ),
    .In4RdAble        ( BYTToIQ4WAble       ),
    .In4RdAddr        ( BYTToIQ4WNum        ),
    .In1aAble         ( DcdToInt1Able       ),
    .In1MicOpcode     ( DcdToIQ1MicOp       ),
    .In1ImmAble       ( DcdToIQ1ImAble      ),
    .In1ImmDate       ( DcdToIQ1ImDate      ),
    .In1RobPtr        ( In1RobPtr           ),
    .In2aAble         ( DcdToInt2Able       ),
    .In2MicOpcode     ( DcdToIQ2MicOp       ),
    .In2ImmAble       ( DcdToIQ2ImAble      ),
    .In2ImmDate       ( DcdToIQ2ImDate      ),
    .In2RobPtr        ( In2RobPtr           ),
    .In3aAble         ( DcdToInt3Able       ),
    .In3MicOpcode     ( DcdToIQ4MicOp       ),
    .In3ImmAble       ( DcdToIQ4ImAble      ),
    .In3ImmDate       ( DcdToIQ4ImDate      ),
    .In3RobPtr        ( In3RobPtr           ),
    .In4aAble         ( DcdToInt4Able       ),
    .In4MicOpcode     ( DcdToIQ4MicOp       ),
    .In4ImmAble       ( DcdToIQ4ImAble      ),
    .In4ImmDate       ( DcdToIQ4ImDate      ),
    .In4RobPtr        ( In4RobPtr           ),
    .FromIsQBr        ( BrToOtherAble       ),
    .FromBrAddr       ( BrToOtherAddr       ),
    .FromIsQCsr       ( CsrToOtherAble      ),
    .FromCsrAddr      ( CsrToOtherAddr      ),
    .ByPassDiv        ( ByPassDivAble       ),
    .ByPassDivAddr    ( ByPassDivNum        ),
    .BypassSC         ( ByPassSCAble        ),
    .BypassSCAddr     ( ByPassSCNum         ),
    .ByPassLoad       ( ByPassLoadAble      ),
    .ByPassLoadAddr   ( ByPassLoadNum       ),
    .Alu1Req          ( EXALU1ToIQReq       ),
    .Alu2Req          ( EXALU2ToIQReq       ),
    .MulReq           ( EXMulToIQReq        ),
    .DivReq           ( EXDivToIQReq        ),
    .Alu1Inst         ( Alu1ToOtherAble     ),
    .Alu1InstAddr     ( Alu1ToOtherNum      ),
    .Alu2Inst         ( ALu2ToOtherAble     ),
    .ALu2InstAddr     ( Alu2ToOtherNum      ),
    .MulInst          ( MulToOtherAble      ),
    .MulInstAddr      ( MulToOtherNum       ),
    .Inst1MicOperate  ( IntToEX1MicOp       ),
    .Inst1Src1RAble   ( IntToEX1Sr1Able     ),
    .Inst1Src1RAddr   ( IntToEX1Sr1Num      ),
    .Inst1Src2RAble   ( IntToEX1Sr2Able     ),
    .Inst1Src2RAddr   ( IntToEX1Sr2Num      ),
    .Inst1ImmAble     ( IntToEx1ImmAble     ),
    .Inst1ImmDate     ( IntToEx1ImmDate     ),
    .Inst1RdAble      ( IntToEX1RdAble      ),
    .Inst1RdAddr      ( IntTOEx1RdNum       ),
    .Inst1RoBptr      ( IntToEX1RobPtr      ),
    .Inst2MicOperate  ( IntToEX2MicOp       ),
    .Inst2Src1RAble   ( IntToEX2Sr1Able     ),
    .Inst2Src1RAddr   ( IntToEX2Sr1Num      ),
    .Inst2Src2RAble   ( IntToEX2Sr2Able     ),
    .Inst2Src2RAddr   ( IntToEX2Sr2Num      ),
    .Inst2ImmAble     ( IntToEx2ImmAble     ),
    .Inst2ImmDate     ( IntToEx2ImmDate     ),
    .Inst2RdAble      ( IntToEX2RdAble      ),
    .Inst2RdAddr      ( IntTOEx2RdNum       ),
    .Inst2RoBptr      ( IntToEX2RobPtr      ),
    .Inst3MicOperate  ( IntToEX3MicOp       ),
    .Inst3Src1RAble   ( IntToEX3Sr1Able     ),
    .Inst3Src1RAddr   ( IntToEX3Sr1Num      ),
    .Inst3Src2RAble   ( IntToEX3Sr2Able     ),
    .Inst3Src2RAddr   ( IntToEX3Sr2Num      ),
    .Inst3ImmAble     ( IntToEx3ImmAble     ),
    .Inst3ImmDate     ( IntToEx3ImmDate     ),
    .Inst3RdAble      ( IntToEX3RdAble      ),
    .Inst3RdAddr      ( IntTOEx3RdNum       ),
    .Inst3RoBptr      ( IntToEX3RobPtr      ),
    .Inst4MicOperate  ( IntToEX4MicOp       ),
    .Inst4Src1RAble   ( IntToEX4Sr1Able     ),
    .Inst4Src1RAddr   ( IntToEX4Sr1Num      ),
    .Inst4Src2RAble   ( IntToEX4Sr2Able     ),
    .Inst4Src2RAddr   ( IntToEX4Sr2Num      ),
    .Inst4ImmAble     ( IntToEx4ImmAble     ),
    .Inst4ImmDate     ( IntToEx4ImmDate     ),
    .Inst4RdAble      ( IntToEX4RdAble      ),
    .Inst4RdAddr      ( IntTOEx4RdNum       ),
    .Inst4RoBptr      ( IntToEX4RobPtr      )
    );

    IssueQueueMem u_IssueQueueMem(
    .Clk               ( Clk                  ),
    .Rest              ( Rest                 ),
    .MemQStop          ( MemQStop             ),
    .MemQFlash         ( MemQFlash            ),
    .MemReq            ( MemReq               ),
    .InIQInstNum       ( AddMemNum            ),
    .MIn1Src1Able      ( BYTToIQ1Sr1Able      ),
    .MIn1Src1Ready     ( BYTToIQ1Sr1Ready     ),
    .MIn1Src1Addr      ( BYTToIQ1Sr1Num       ),
    .MIn1Src2Able      ( BYTToIQ1Sr2Able      ),
    .MIn1Src2Ready     ( BYTToIQ1Sr2Ready     ),
    .MIn1Src2Addr      ( BYTToIQ1Sr2Num       ),
    .MIn1RdAble        ( BYTToIQ1WAble        ),
    .MIn1RdAddr        ( BYTToIQ1WNum         ),
    .MIn2Src1Able      ( BYTToIQ2Sr1Able      ),
    .MIn2Src1Ready     ( BYTToIQ2Sr1Ready     ),
    .MIn2Src1Addr      ( BYTToIQ2Sr1Num       ),
    .MIn2Src2Able      ( BYTToIQ2Sr2Able      ),
    .MIn2Src2Ready     ( BYTToIQ2Sr2Ready     ),
    .MIn2Src2Addr      ( BYTToIQ2Sr2Num       ),
    .MIn2RdAble        ( BYTToIQ2WAble        ),
    .MIn2RdAddr        ( BYTToIQ2WNum         ),
    .MIn3Src1Able      ( BYTToIQ3Sr1Able      ),
    .MIn3Src1Ready     ( BYTToIQ3Sr1Ready     ),
    .MIn3Src1Addr      ( BYTToIQ3Sr1Num       ),
    .MIn3Src2Able      ( BYTToIQ3Sr2Able      ),
    .MIn3Src2Ready     ( BYTToIQ3Sr2Ready     ),
    .MIn3Src2Addr      ( BYTToIQ3Sr2Num       ),
    .MIn3RdAble        ( BYTToIQ3WAble        ),
    .MIn3RdAddr        ( BYTToIQ3WNum         ),
    .MIn4Src1Able      ( BYTToIQ4Sr1Able      ),
    .MIn4Src1Ready     ( BYTToIQ4Sr1Ready     ),
    .MIn4Src1Addr      ( BYTToIQ4Sr1Num       ),
    .MIn4Src2Able      ( BYTToIQ4Sr2Able      ),
    .MIn4Src2Ready     ( BYTToIQ4Sr2Ready     ),
    .MIn4Src2Addr      ( BYTToIQ4Sr2Num       ),
    .MIn4RdAble        ( BYTToIQ4WAble        ),
    .MIn4RdAddr        ( BYTToIQ4WNum         ),
    .MIn1aAble         ( DcdToMem1Able        ),
    .MIn1MicOpcode     ( DcdToIQ1MicOp        ),
    .MIn1ImmAble       ( DcdToIQ1ImAble       ),
    .MIn1ImmDate       ( DcdToIQ1ImDate       ),
    .MIn1RobPtr        ( MIn1RobPtr           ),
    .MIn2aAble         ( DcdToMem2Able        ),
    .MIn2MicOpcode     ( DcdToIQ2MicOp        ),
    .MIn2ImmAble       ( DcdToIQ2ImAble       ),
    .MIn2ImmDate       ( DcdToIQ2ImDate       ),
    .MIn2RobPtr        ( MIn2RobPtr           ),
    .MIn3aAble         ( DcdToMem3Able        ),
    .MIn3MicOpcode     ( DcdToIQ4MicOp        ),
    .MIn3ImmAble       ( DcdToIQ4ImAble       ),
    .MIn3ImmDate       ( DcdToIQ4ImDate       ),
    .MIn3RobPtr        ( MIn3RobPtr           ),
    .MIn4aAble         ( DcdToMem4Able        ),
    .MIn4MicOpcode     ( DcdToIQ4MicOp        ),
    .MIn4ImmAble       ( DcdToIQ4ImAble       ),
    .MIn4ImmDate       ( DcdToIQ4ImDate       ),
    .MIn4RobPtr        ( MIn4RobPtr           ),
    .LoadReq           ( LoadToIQReq          ),
    .StoreReq          ( StoreTOIQReq         ),
    .FromBCQBru        ( BrToOtherAble        ),
    .FromBruAddr       ( BrToOtherAddr        ),
    .FromBCQCsr        ( CsrToOtherAble       ),
    .FromCsrAddr       ( CsrToOtherAddr       ),
    .FromIsQAlu1       ( Alu1ToOtherAble      ),
    .FromAlu1Addr      ( Alu1ToOtherNum       ),
    .FromIsQAlu2       ( Alu2ToOtherAble      ),
    .FromAlu2Addr      ( Alu2ToOtherNum       ),
    .FromIsQMul        ( MulToOtherAble       ),
    .FromMulAddr       ( MulToOtherNum        ),
    .ByPassMDiv        ( ByPassDivAble        ),
    .ByPassMDivAddr    ( ByPassDivAddr        ),
    .ByPassMLoad       ( ByPassLoadAble       ),
    .ByPassMLoadAddr   ( ByPassLoadNum        ),
    .ByPassMSC         ( ByPassSCAble         ),
    .ByPassMSCAddr     ( ByPassSCNum          ),
    .MInst1MicOperate  ( MemToLS1MicOp        ),
    .MInst1Src1RAble   ( MemToLS1Sr1Able      ),
    .MInst1Src1RAddr   ( MemToLS1Sr1Num       ),
    .MInst1Src2RAble   ( MemToLS1Sr2Able      ),
    .MInst1Src2RAddr   ( MemToLS1Sr2Num       ),
    .MInst1ImmAble     ( MemToLS1ImAble       ),
    .MInst1ImmDate     ( MemToLS1ImDate       ),
    .MInst1RdAble      ( MemToLS1RdAble       ),
    .MInst1RdAddr      ( MemToLS1RdNum        ),
    .MInst1RoBptr      ( MemToLS1RobPtr       ),
    .MInst2MicOperate  ( MemToLS2MicOp        ),
    .MInst2Src1RAble   ( MemToLS2Sr1Able      ),
    .MInst2Src1RAddr   ( MemToLS2Sr1Num       ),
    .MInst2Src2RAble   ( MemToLS2Sr2Able      ),
    .MInst2Src2RAddr   ( MemToLS2Sr2Num       ),
    .MInst2ImmAble     ( MemToLS2ImAble       ),
    .MInst2ImmDate     ( MemToLS2ImDate       ),
    .MInst2RdAble      ( MemToLS2RdAble       ),
    .MInst2RdAddr      ( MemToLS2RdNum        ),
    .MInst2RoBptr      ( MemToLS2RobPtr       )
    );

    PhysicalRegFile u_PhysicalRegFile(
    .Clk                ( Clk                ),
    .Rest               ( Rest               ),
    .PhysicalStop       ( PhysicalStop       ),
    .ReloadPhy          ( ArchSToPhyReload   ),
    .Are1MapPregNum     ( ArchSToPhy1Num     ),
    .Are2MapPregNum     ( ArchSToPhy2Num     ),
    .Are3MapPregNum     ( ArchSToPhy3Num     ),
    .Are4MapPregNum     ( ArchSToPhy4Num     ),
    .Are5MapPregNum     ( ArchSToPhy5Num     ),
    .Are6MapPregNum     ( ArchSToPhy6Num     ),
    .Are7MapPregNum     ( ArchSToPhy7Num     ),
    .Are8MapPregNum     ( ArchSToPhy8Num     ),
    .Are9MapPregNum     ( ArchSToPhy9Num     ),
    .Are10MapPregNum    ( ArchSToPhy10Num    ),
    .Are11MapPregNum    ( ArchSToPhy11Num    ),
    .Are12MapPregNum    ( ArchSToPhy12Num    ),
    .Are13MapPregNum    ( ArchSToPhy13Num    ),
    .Are14MapPregNum    ( ArchSToPhy14Num    ),
    .Are15MapPregNum    ( ArchSToPhy15Num    ),
    .Are16MapPregNum    ( ArchSToPhy16Num    ),
    .Are17MapPregNum    ( ArchSToPhy17Num    ),
    .Are18MapPregNum    ( ArchSToPhy18Num    ),
    .Are19MapPregNum    ( ArchSToPhy19Num    ),
    .Are20MapPregNum    ( ArchSToPhy20Num    ),
    .Are21MapPregNum    ( ArchSToPhy21Num    ),
    .Are22MapPregNum    ( ArchSToPhy22Num    ),
    .Are23MapPregNum    ( ArchSToPhy23Num    ),
    .Are24MapPregNum    ( ArchSToPhy24Num    ),
    .Are25MapPregNum    ( ArchSToPhy25Num    ),
    .Are26MapPregNum    ( ArchSToPhy26Num    ),
    .Are27MapPregNum    ( ArchSToPhy27Num    ),
    .Are28MapPregNum    ( ArchSToPhy28Num    ),
    .Are29MapPregNum    ( ArchSToPhy29Num    ),
    .Are30MapPregNum    ( ArchSToPhy30Num    ),
    .Are31MapPregNum    ( ArchSToPhy31Num    ),
    .Are32MapPregNum    ( ArchSToPhy32Num    ),
    .WriteBackAlu1      ( Alu1ToPhyAble      ),
    .WriteBackAlu1Addr  ( Alu1ToPhyAddr      ),
    .WriteBackAlu1Date  ( Alu1ToPhyDate      ),
    .WriteBackAlu2      ( Alu2ToPhyAble      ),
    .WriteBackAlu2Addr  ( Alu2ToPhyAddr      ),
    .WriteBackAlu2Date  ( Alu2ToPhyDate      ),
    .WriteBackDiv       ( DivToPhyAble       ),
    .WriteBackDivAddr   ( DivToPhyAddr       ),
    .WriteBackDivDate   ( DivToPhyDate       ),
    .WriteBackMul       ( MulToPhyAble       ),
    .WriteBackMulAddr   ( MulToPhyAddr       ),
    .WriteBackMulDate   ( MulToPhyDate       ),
    .WriteBackCsru      ( CsruToPhyAble      ),
    .WriteBackCsruAddr  ( CsruToPhyAddr      ),
    .WriteBackCsruDate  ( CsruToPhyDate      ),
    .WriteBackBru       ( BruToPhyAble       ),
    .WriteBackBruAddr   ( BruToPhyAddr       ),
    .WriteBackBruDate   ( BruToPhyDate       ),
    .WriteBackLsu       ( LsuToPhyAble       ),
    .WriteBackLsuAddr   ( LsuToPhyAddr       ),
    .WriteBackLsuDate   ( LsuToPhyDate       ),
    .WriteBackROB       ( RobToPhyAble       ),
    .WriteBackROBAddr   ( RobToPhyAddr       ),
    .WriteBackROBDate   ( RobToPhyDate       ),
    .Read11Able         ( IntToEX1Sr1Able    ),
    .Read11Addr         ( IntToEX1Sr1Num     ),
    .Read11Date         ( PhyToEuDate11      ),
    .Read12Able         ( IntToEX1Sr2Able    ),
    .Read12Addr         ( IntToEX1Sr2Num     ),
    .Read12Date         ( PhyToEuDate12      ),
    .Read21Able         ( IntToEX2Sr1Able    ),
    .Read21Addr         ( IntToEX2Sr1Num     ),
    .Read21Date         ( PhyToEuDate21      ),
    .Read22Able         ( IntToEX2Sr2Able    ),
    .Read22Addr         ( IntToEX2Sr2Num     ),
    .Read22Date         ( PhyToEuDate22      ),
    .Read31Able         ( IntToEX3Sr1Able    ),
    .Read31Addr         ( IntToEX3Sr1Num     ),
    .Read31Date         ( PhyToEuDate31      ),
    .Read32Able         ( IntToEX3Sr2Able    ),
    .Read32Addr         ( IntToEX3Sr2Num     ),
    .Read32Date         ( PhyToEuDate32      ),
    .Read41Able         ( IntToEX4Sr1Able    ),
    .Read41Addr         ( IntToEX4Sr1Num     ),
    .Read41Date         ( PhyToEuDate41      ),
    .Read42Able         ( IntToEX4Sr2Able    ),
    .Read42Addr         ( IntToEX4Sr2Num     ),
    .Read42Date         ( PhyToEuDate42      ),
    .Read51Able         ( BrCsrTo1EUSr1A     ),
    .Read51Addr         ( BrCsrTo1EUSr1Num   ),
    .Read51Date         ( PhyToEuDate51      ),
    .Read52Able         ( BrCsrTo1EUSr2A     ),
    .Read52Addr         ( BrCsrTo1EUSr2Num   ),
    .Read52Date         ( PhyToEuDate52      ),
    .Read61Able         ( BrCsrTo2EUSr1A     ),
    .Read61Addr         ( BrCsrTo2EUSr1Num   ),
    .Read61Date         ( PhyToEuDate61      ),
    .Read62Able         ( BrCsrTo2EUSr2A     ),
    .Read62Addr         ( BrCsrTo2EUSr2Num   ),
    .Read62Date         ( PhyToEuDate62      ),
    .Read71Able         ( MemToLS1Sr1Able    ),
    .Read71Addr         ( MemToLS1Sr1Num     ),
    .Read71Date         ( PhyToEuDate71      ),
    .Read72Able         ( MemToLS1Sr2Able    ),
    .Read72Addr         ( MemToLS1Sr2Num     ),
    .Read72Date         ( PhyToEuDate72      ),
    .Read81Able         ( MemToLS2Sr1Able    ),
    .Read81Addr         ( MemToLS2Sr1Num     ),
    .Read81Date         ( PhyToEuDate81      ),
    .Read82Able         ( MemToLS2Sr2Able    ),
    .Read82Addr         ( MemToLS2Sr2Num     ),
    .Read82Date         ( PhyToEuDate82      ),
    );

    Mmu u_Mmu(
    .Clk               ( Clk               ),
    .Rest              ( Rest              ),
    .MmuFlash          ( MmuFlash          ),
    .MmuStop           ( MmuStop           ),
    .Asid              ( CstToMmuAsidDate  ),
    .CsrDmw0Date       ( CsrToMmuDmw0Date  ),
    .CsrDmw1Date       ( CsrToMmuDmw1Date  ),
    .CsrCrmdDate       ( CsrToMmuCrmdDate  ),
    .CsrReadTlbAddr    ( CsrToMmuRTAddr    ),
    .CsrReadTlbDate    ( MmuToCsrRTDate    ),
    .CsrSerchTlbAble   ( CsrToMmuSTAble    ),
    .CsrSerchInfrom    ( CsrToMmuSTInfo    ),
    .CsrSerchAble      ( CsrToMmuSAble     ),
    .CsrSerchIdxDate   ( CsrToMmuSIndex    ),
    .CsrWriteTlbAble   ( CsrToMmuWTAble    ),
    .CsrWriteTlbAddr   ( CsrToMmuWTAddr    ),
    .CsrWriteTlbDate   ( CsrToMmuWTDate    ),
    .CsrInvEn          ( CsrToMmuInvEn     ),
    .CsrInvOp          ( CsrToMmuInvOp     ),
    .CsrInvAsid        ( CsrToMmuInvAsid   ),
    .CsrInvVppn        ( CsrToMmuInvVppn   ),
    .InstFetch         ( InstToMmuFetch    ),
    .InstVritualA      ( InstToMmuVA       ),
    .InstOperType      ( MmuToInstOpType   ),
    .InstTlbTrap       ( MmuToInstTrap     ),
    .InstTlbTrapType   ( MmuToInstTrapCode ),
    .InstPhysicalAddr  ( MmuToInstPA       ),
    .LoadAccess        ( LoadToMmuAccess   ),
    .LoadVritualA      ( LoadToMmuVA       ),
    .LoadOperType      ( MmuToLoadOpType   ),
    .LoadTlbTrap       ( MmuToLoadTrap     ),
    .LoadTlbTrapType   ( MmuToLoadTrapCode ),
    .LoadPhysicalAddr  ( MmuToLoadPA       ),
    .StoreAccess       ( StoreToMmuAccess  ),
    .StoreVritualA     ( StoreToMmuVA      ),
    .StoreOperType     ( MmuToStoreOpType  ),
    .StoreTlbTrap      ( MmuToStoreTrap    ),
    .StoreTlbTrapType  ( MmuToStoreTrapCode),
    .StorePhysicalAddr ( MmuToStorePA      )
    );




    Alu u_Alu1(
    .Clk            ( Clk            ),
    .Rest           ( Rest           ),
    .AluStop        ( AluStop        ),
    .AluFlash       ( AluFlash       ),
    .AluInstPc      ( AluInstPc      ),
    .AluMicOperate  ( IntToEX1MicOp  ),
    .AluSrc1Able    ( IntToEX1Sr1Able),
    .AluSrc1Addr    ( IntToEX1Sr1Num ),
    .AluSrc1Date    ( PhyToEuDate11  ),
    .AluSrc2Able    ( IntToEX1Sr2Able),
    .AluSrc2Addr    ( IntToEX1Sr2Num ),
    .AluSrc2Date    ( PhyToEuDate12  ),
    .AluImmDate     ( IntToEx1ImmDate),
    .AluRdAble      ( IntToEX1RdAble ),
    .AluRdAddr      ( IntTOEx1RdNum  ),
    .AluROBPtr      ( IntToEX1RobPtr      ),
    .AluSelfAble    ( AluSelfAble    ),
    .AluSelfAddr    ( AluSelfAddr    ),
    .AluSelfDate    ( AluSelfDate    ),
    .AluBruAble     ( AluBruAble     ),
    .AluBruAddr     ( AluBruAddr     ),
    .AluBruDate     ( AluBruDate     ),
    .AluAlu2Able    ( AluAlu2Able    ),
    .AluAlu2Addr    ( AluAlu2Addr    ),
    .AluAlu2Date    ( AluAlu2Date    ),
    .AluMulAble     ( AluMulAble     ),
    .AluMulAddr     ( AluMulAddr     ),
    .AluMulDate     ( AluMulDate     ),
    .AluCsrAble     ( AluCsrAble     ),
    .AluCsrAddr     ( AluCsrAddr     ),
    .AluCsrDate     ( AluCsrDate     ),
    .AluReq         ( AluReq         ),
    .AluWBAble      ( AluWBAble      ),
    .AluWBAddr      ( AluWBAddr      ),
    .AluWBDate      ( AluWBDate      ),
    .AluCommitAble  ( AluCommitAble  ),
    .AluCommitPtr   ( AluCommitPtr   ),
    .AluCommitType  ( AluCommitType  )
    );

    Alu u_Alu2(
    .Clk            ( Clk            ),
    .Rest           ( Rest           ),
    .AluStop        ( AluStop        ),
    .AluFlash       ( AluFlash       ),
    .AluInstPc      ( AluInstPc      ),
    .AluMicOperate  ( AluMicOperate  ),
    .AluSrc1Able    ( AluSrc1Able    ),
    .AluSrc1Addr    ( AluSrc1Addr    ),
    .AluSrc1Date    ( AluSrc1Date    ),
    .AluSrc2Able    ( AluSrc2Able    ),
    .AluSrc2Addr    ( AluSrc2Addr    ),
    .AluSrc2Date    ( AluSrc2Date    ),
    .AluImmDate     ( AluImmDate     ),
    .AluRdAble      ( AluRdAble      ),
    .AluRdAddr      ( AluRdAddr      ),
    .AluROBPtr      ( AluROBPtr      ),
    .AluSelfAble    ( AluSelfAble    ),
    .AluSelfAddr    ( AluSelfAddr    ),
    .AluSelfDate    ( AluSelfDate    ),
    .AluBruAble     ( AluBruAble     ),
    .AluBruAddr     ( AluBruAddr     ),
    .AluBruDate     ( AluBruDate     ),
    .AluAlu2Able    ( AluAlu2Able    ),
    .AluAlu2Addr    ( AluAlu2Addr    ),
    .AluAlu2Date    ( AluAlu2Date    ),
    .AluMulAble     ( AluMulAble     ),
    .AluMulAddr     ( AluMulAddr     ),
    .AluMulDate     ( AluMulDate     ),
    .AluCsrAble     ( AluCsrAble     ),
    .AluCsrAddr     ( AluCsrAddr     ),
    .AluCsrDate     ( AluCsrDate     ),
    .AluReq         ( AluReq         ),
    .AluWBAble      ( AluWBAble      ),
    .AluWBAddr      ( AluWBAddr      ),
    .AluWBDate      ( AluWBDate      ),
    .AluCommitAble  ( AluCommitAble  ),
    .AluCommitPtr   ( AluCommitPtr   ),
    .AluCommitType  ( AluCommitType  )
    );

    Bru u_Bru(
        .Clk             ( Clk             ),
        .Rest            ( Rest            ),
        .BruStop         ( BruStop         ),
        .BruFlash        ( BruFlash        ),
        .BruInstPc       ( BruInstPc       ),
        .BruMicOperate   ( BruMicOperate   ),
        .BruSrc1Able     ( BruSrc1Able     ),
        .BruSrc1Addr     ( BruSrc1Addr     ),
        .BruSrc1Date     ( BruSrc1Date     ),
        .BruSrc2Able     ( BruSrc2Able     ),
        .BruSrc2Addr     ( BruSrc2Addr     ),
        .BruSrc2Date     ( BruSrc2Date     ),
        .BruImmDate      ( BruImmDate      ),
        .BruRdAble       ( BruRdAble       ),
        .BruRdAddr       ( BruRdAddr       ),
        .BruMode         ( BruMode         ),
        .BruReDirDate    ( BruReDirDate    ),
        .BruROBPtr       ( BruROBPtr       ),
        .BruSelfAble     ( BruSelfAble     ),
        .BruSelfADdr     ( BruSelfADdr     ),
        .BruSelfDate     ( BruSelfDate     ),
        .BruAlu1Able     ( BruAlu1Able     ),
        .BruALu1Addr     ( BruALu1Addr     ),
        .BruAlu1Date     ( BruAlu1Date     ),
        .BruAlu2Able     ( BruAlu2Able     ),
        .BruALu2Addr     ( BruALu2Addr     ),
        .BruAlu2Date     ( BruAlu2Date     ),
        .BruMulAble      ( BruMulAble      ),
        .BruMulAddr      ( BruMulAddr      ),
        .BruMulDate      ( BruMulDate      ),
        .BruCsrAble      ( BruCsrAble      ),
        .BruCsrAddr      ( BruCsrAddr      ),
        .BruCsrDate      ( BruCsrDate      ),
        .BWriteBackAble  ( BWriteBackAble  ),
        .BWriteBackAddr  ( BWriteBackAddr  ),
        .BWriteBackDate  ( BWriteBackDate  ),
        .BruReqInst      ( BruReqInst      ),
        .BruCommitAble   ( BruCommitAble   ),
        .BruCommitPtr    ( BruCommitPtr    ),
        .BruReDirType    ( BruReDirType    ),
        .BruReDirPc      ( BruReDirPc      )
    );

    Csru u_Csru(
        .Clk               ( Clk               ),
        .Rest              ( Rest              ),
        .InInstAble        ( InInstAble        ),
        .InstVritualPc     ( InstVritualPc     ),
        .CsrMicOpCOde      ( CsrMicOpCOde      ),
        .ArchRegDate0      ( ArchRegDate0      ),
        .ArchRegDate1      ( ArchRegDate1      ),
        .CsrNum            ( CsrNum            ),
        .InstRobPtr        ( InstRobPtr        ),
        .CsruFree          ( CsruFree          ),
        .WriteBackDate     ( WriteBackDate     ),
        .WriteBackAddr     ( WriteBackAddr     ),
        .ToRobInterrupt    ( ToRobInterrupt    ),
        .ToRobCode         ( ToRobCode         ),
        .ToRobLlbetlKlo    ( ToRobLlbetlKlo    ),
        .InstReadyAble     ( InstReadyAble     ),
        .InstReadyPtr      ( InstReadyPtr      ),
        .InstReDirectAble  ( InstReDirectAble  ),
        .InstReDriectEntry ( InstReDriectEntry ),
        .InstReDirectIdle  ( InstReDirectIdle  ),
        .InstReDirectCode  ( InstReDirectCode  ),
        .InstReDirectAddr  ( InstReDirectAddr  ),
        .InstRetireAble    ( InstRetireAble    ),
        .InstRetireCode    ( InstRetireCode    ),
        .CrmdData          ( CrmdData          ),
        .EraDate           ( EraDate           ),
        .EstatDate         ( EstatDate         ),
        .ReadCsrAble       ( ReadCsrAble       ),
        .ReadCsrAddr       ( ReadCsrAddr       ),
        .ReadCsrDate       ( ReadCsrDate       ),
        .WriteCsrAble      ( WriteCsrAble      ),
        .WriteCsrAddr      ( WriteCsrAddr      ),
        .WriteCsrDate      ( WriteCsrDate      ),
        .IndexDate         ( IndexDate         ),
        .WIndexAble        ( WIndexAble        ),
        .WIndexMask        ( WIndexMask        ),
        .WIndexDate        ( WIndexDate        ),
        .TlbehiDate        ( TlbehiDate        ),
        .WEhiTLBAble       ( WEhiTLBAble       ),
        .WEhiTLBMask       ( WEhiTLBMask       ),
        .WEhiTLBDate       ( WEhiTLBDate       ),
        .Elo0TLBDate       ( Elo0TLBDate       ),
        .WElo0TLBAble      ( WElo0TLBAble      ),
        .WElo0TLBMask      ( WElo0TLBMask      ),
        .WElo0TLBDate      ( WElo0TLBDate      ),
        .Elo1TLBDate       ( Elo1TLBDate       ),
        .WElo1TLBAble      ( WElo1TLBAble      ),
        .WElo1TLBMask      ( WElo1TLBMask      ),
        .WElo1TLBDate      ( WElo1TLBDate      ),
        .AsidTLBDate       ( AsidTLBDate       ),
        .WAsidTLBAble      ( WAsidTLBAble      ),
        .WAsidTLBMask      ( WAsidTLBMask      ),
        .WAsidTLBDate      ( WAsidTLBDate      ),
        .ReadMmuAble       ( ReadMmuAble       ),
        .ReadMmuAddr       ( ReadMmuAddr       ),
        .ReadMmuDate       ( ReadMmuDate       ),
        .WriteMmuAble      ( WriteMmuAble      ),
        .WriteMmuAddr      ( WriteMmuAddr      ),
        .WriteMmuDate      ( WriteMmuDate      ),
        .SerchMmuAble      ( SerchMmuAble      ),
        .SerchMmuInfr      ( SerchMmuInfr      ),
        .SerchSuccess      ( SerchSuccess      ),
        .SerchIndexDate    ( SerchIndexDate    ),
        .CsruStop          ( CsruStop          ),
        .CsruFlash         ( CsruFlash         )
    );


    AXIbus u_AXIbus(
        .Clk           ( Clk           ),
        .Rest          ( Rest          ),
        .CacReadfree   ( CacReadfree   ),
        .CacWritefree  ( CacWritefree  ),
        .ReadBackAble  ( ReadBackAble  ),
        .ReadBackDate  ( ReadBackDate  ),
        .WritBAckAble  ( WritBAckAble  ),
        .IcaReadAble   ( IcaReadAble   ),
        .IRshankhand   ( IRshankhand   ),
        .IUncacheRead  ( IUncacheRead  ),
        .IcaReadAddr   ( IcaReadAddr   ),
        .DcaWriteAble  ( DcaWriteAble  ),
        .DWshankhand   ( DWshankhand   ),
        .DWriteUncache ( DWriteUncache ),
        .UncacheStrb   ( UncacheStrb   ),
        .DcaWriteAddr  ( DcaWriteAddr  ),
        .DcaWDate      ( DcaWDate      ),
        .DcaReadAble   ( DcaReadAble   ),
        .DRshankhand   ( DRshankhand   ),
        .DUnacheRead   ( DUnacheRead   ),
        .DcaReadAddr   ( DcaReadAddr   ),
        .Arid          ( Arid          ),
        .Araddr        ( Araddr        ),
        .Arlen         ( Arlen         ),
        .Arsize        ( Arsize        ),
        .Arburst       ( Arburst       ),
        .Arlock        ( Arlock        ),
        .Arcache       ( Arcache       ),
        .Arprot        ( Arprot        ),
        .Arvalid       ( Arvalid       ),
        .Arready       ( Arready       ),
        .Rid           ( Rid           ),
        .Rdata         ( Rdata         ),
        .Rresp         ( Rresp         ),
        .Rlast         ( Rlast         ),
        .Rvalid        ( Rvalid        ),
        .Rready        ( Rready        ),
        .Awid          ( Awid          ),
        .Awaddr        ( Awaddr        ),
        .Awlen         ( Awlen         ),
        .Awsize        ( Awsize        ),
        .Awburst       ( Awburst       ),
        .Awlock        ( Awlock        ),
        .Awcache       ( Awcache       ),
        .Awprot        ( Awprot        ),
        .Awvalid       ( Awvalid       ),
        .Awready       ( Awready       ),
        .Wid           ( Wid           ),
        .Wdata         ( Wdata         ),
        .Wstrb         ( Wstrb         ),
        .Wlast         ( Wlast         ),
        .Wvalid        ( Wvalid        ),
        .Wready        ( Wready        ),
        .Bid           ( Bid           ),
        .Bresp         ( Bresp         ),
        .Bvalid        ( Bvalid        ),
        .Bready        ( Bready        )
    );



    ProfCtr u_ProfCtr(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .DcacheMiss  ( DcacheMiss  ),
        .IcacheMiss  ( IcacheMiss  ),
        .CommitInst  ( CommitInst  ),
        .BrInst      ( BrInst      ),
        .MemInst     ( MemInst     ),
        .BrPre       ( BrPre       ),
        .BrPreErrot  ( BrPreErrot  )
    );



`ifdef DIFFTEST_EN
// difftest
// from wb_stage
wire            ws_valid_diff       ;
wire            cnt_inst_diff       ;
wire    [63:0]  timer_64_diff       ;
wire    [ 7:0]  inst_ld_en_diff     ;
wire    [31:0]  ld_paddr_diff       ;
wire    [31:0]  ld_vaddr_diff       ;
wire    [ 7:0]  inst_st_en_diff     ;
wire    [31:0]  st_paddr_diff       ;
wire    [31:0]  st_vaddr_diff       ;
wire    [31:0]  st_data_diff        ;
wire            csr_rstat_en_diff   ;
wire    [31:0]  csr_data_diff       ;

wire inst_valid_diff = ws_valid_diff;
reg             cmt_valid           ;
reg             cmt_cnt_inst        ;
reg     [63:0]  cmt_timer_64        ;
reg     [ 7:0]  cmt_inst_ld_en      ;
reg     [31:0]  cmt_ld_paddr        ;
reg     [31:0]  cmt_ld_vaddr        ;
reg     [ 7:0]  cmt_inst_st_en      ;
reg     [31:0]  cmt_st_paddr        ;
reg     [31:0]  cmt_st_vaddr        ;
reg     [31:0]  cmt_st_data         ;
reg             cmt_csr_rstat_en    ;
reg     [31:0]  cmt_csr_data        ;

reg             cmt_wen             ;
reg     [ 7:0]  cmt_wdest           ;
reg     [31:0]  cmt_wdata           ;
reg     [31:0]  cmt_pc              ;
reg     [31:0]  cmt_inst            ;

reg             cmt_excp_flush      ;
reg             cmt_ertn            ;
reg     [5:0]   cmt_csr_ecode       ;
reg             cmt_tlbfill_en      ;
reg     [4:0]   cmt_rand_index      ;

// to difftest debug
reg             trap                ;
reg     [ 7:0]  trap_code           ;
reg     [63:0]  cycleCnt            ;
reg     [63:0]  instrCnt            ;

// from regfile
wire    [31:0]  regs[31:0]          ;

// from csr
wire    [31:0]  csr_crmd_diff_0     ;
wire    [31:0]  csr_prmd_diff_0     ;
wire    [31:0]  csr_ectl_diff_0     ;
wire    [31:0]  csr_estat_diff_0    ;
wire    [31:0]  csr_era_diff_0      ;
wire    [31:0]  csr_badv_diff_0     ;
wire	[31:0]  csr_eentry_diff_0   ;
wire 	[31:0]  csr_tlbidx_diff_0   ;
wire 	[31:0]  csr_tlbehi_diff_0   ;
wire 	[31:0]  csr_tlbelo0_diff_0  ;
wire 	[31:0]  csr_tlbelo1_diff_0  ;
wire 	[31:0]  csr_asid_diff_0     ;
wire 	[31:0]  csr_save0_diff_0    ;
wire 	[31:0]  csr_save1_diff_0    ;
wire 	[31:0]  csr_save2_diff_0    ;
wire 	[31:0]  csr_save3_diff_0    ;
wire 	[31:0]  csr_tid_diff_0      ;
wire 	[31:0]  csr_tcfg_diff_0     ;
wire 	[31:0]  csr_tval_diff_0     ;
wire 	[31:0]  csr_ticlr_diff_0    ;
wire 	[31:0]  csr_llbctl_diff_0   ;
wire 	[31:0]  csr_tlbrentry_diff_0;
wire 	[31:0]  csr_dmw0_diff_0     ;
wire 	[31:0]  csr_dmw1_diff_0     ;
wire 	[31:0]  csr_pgdl_diff_0     ;
wire 	[31:0]  csr_pgdh_diff_0     ;

always @(posedge aclk) begin
    if (reset) begin
        {cmt_valid, cmt_cnt_inst, cmt_timer_64, cmt_inst_ld_en, cmt_ld_paddr, cmt_ld_vaddr, cmt_inst_st_en, cmt_st_paddr, cmt_st_vaddr, cmt_st_data, cmt_csr_rstat_en, cmt_csr_data} <= 0;
        {cmt_wen, cmt_wdest, cmt_wdata, cmt_pc, cmt_inst} <= 0;
        {trap, trap_code, cycleCnt, instrCnt} <= 0;
    end else if (~trap) begin
        cmt_valid       <= inst_valid_diff          ;
        cmt_cnt_inst    <= cnt_inst_diff            ;
        cmt_timer_64    <= timer_64_diff            ;
        cmt_inst_ld_en  <= inst_ld_en_diff          ;
        cmt_ld_paddr    <= ld_paddr_diff            ;
        cmt_ld_vaddr    <= ld_vaddr_diff            ;
        cmt_inst_st_en  <= inst_st_en_diff          ;
        cmt_st_paddr    <= st_paddr_diff            ;
        cmt_st_vaddr    <= st_vaddr_diff            ;
        cmt_st_data     <= st_data_diff             ;
        cmt_csr_rstat_en<= csr_rstat_en_diff        ;
        cmt_csr_data    <= csr_data_diff            ;

        cmt_wen     <=  debug0_wb_rf_wen            ;
        cmt_wdest   <=  {3'd0, debug0_wb_rf_wnum}   ;
        cmt_wdata   <=  debug0_wb_rf_wdata          ;
        cmt_pc      <=  debug0_wb_pc                ;
        cmt_inst    <=  debug0_wb_inst              ;

        cmt_excp_flush  <= excp_flush               ;
        cmt_ertn        <= ertn_flush               ;
        cmt_csr_ecode   <= ws_csr_ecode             ;
        cmt_tlbfill_en  <= tlbfill_en               ;
        cmt_rand_index  <= rand_index               ;

        trap            <= 0                        ;
        trap_code       <= regs[10][7:0]            ;
        cycleCnt        <= cycleCnt + 1             ;
        instrCnt        <= instrCnt + inst_valid_diff;
    end
end

DifftestInstrCommit DifftestInstrCommit(
    .clock              (aclk           ),
    .coreid             (0              ),
    .index              (0              ),
    .valid              (cmt_valid      ),
    .pc                 (cmt_pc         ),
    .instr              (cmt_inst       ),
    .skip               (0              ),
    .is_TLBFILL         (cmt_tlbfill_en ),
    .TLBFILL_index      (cmt_rand_index ),
    .is_CNTinst         (cmt_cnt_inst   ),
    .timer_64_value     (cmt_timer_64   ),
    .wen                (cmt_wen        ),
    .wdest              (cmt_wdest      ),
    .wdata              (cmt_wdata      ),
    .csr_rstat          (cmt_csr_rstat_en),
    .csr_data           (cmt_csr_data   )
);

DifftestExcpEvent DifftestExcpEvent(
    .clock              (aclk           ),
    .coreid             (0              ),
    .excp_valid         (cmt_excp_flush ),
    .eret               (cmt_ertn       ),
    .intrNo             (csr_estat_diff_0[12:2]),
    .cause              (cmt_csr_ecode  ),
    .exceptionPC        (cmt_pc         ),
    .exceptionInst      (cmt_inst       )
);

DifftestTrapEvent DifftestTrapEvent(
    .clock              (aclk           ),
    .coreid             (0              ),
    .valid              (trap           ),
    .code               (trap_code      ),
    .pc                 (cmt_pc         ),
    .cycleCnt           (cycleCnt       ),
    .instrCnt           (instrCnt       )
);

DifftestStoreEvent DifftestStoreEvent(
    .clock              (aclk           ),
    .coreid             (0              ),
    .index              (0              ),
    .valid              (cmt_inst_st_en ),
    .storePAddr         (cmt_st_paddr   ),
    .storeVAddr         (cmt_st_vaddr   ),
    .storeData          (cmt_st_data    )
);

DifftestLoadEvent DifftestLoadEvent(
    .clock              (aclk           ),
    .coreid             (0              ),
    .index              (0              ),
    .valid              (cmt_inst_ld_en ),
    .paddr              (cmt_ld_paddr   ),
    .vaddr              (cmt_ld_vaddr   )
);

DifftestCSRRegState DifftestCSRRegState(
    .clock              (aclk               ),
    .coreid             (0                  ),
    .crmd               (csr_crmd_diff_0    ),
    .prmd               (csr_prmd_diff_0    ),
    .euen               (0                  ),
    .ecfg               (csr_ectl_diff_0    ),
    .estat              (csr_estat_diff_0   ),
    .era                (csr_era_diff_0     ),
    .badv               (csr_badv_diff_0    ),
    .eentry             (csr_eentry_diff_0  ),
    .tlbidx             (csr_tlbidx_diff_0  ),
    .tlbehi             (csr_tlbehi_diff_0  ),
    .tlbelo0            (csr_tlbelo0_diff_0 ),
    .tlbelo1            (csr_tlbelo1_diff_0 ),
    .asid               (csr_asid_diff_0    ),
    .pgdl               (csr_pgdl_diff_0    ),
    .pgdh               (csr_pgdh_diff_0    ),
    .save0              (csr_save0_diff_0   ),
    .save1              (csr_save1_diff_0   ),
    .save2              (csr_save2_diff_0   ),
    .save3              (csr_save3_diff_0   ),
    .tid                (csr_tid_diff_0     ),
    .tcfg               (csr_tcfg_diff_0    ),
    .tval               (csr_tval_diff_0    ),
    .ticlr              (csr_ticlr_diff_0   ),
    .llbctl             (csr_llbctl_diff_0  ),
    .tlbrentry          (csr_tlbrentry_diff_0),
    .dmw0               (csr_dmw0_diff_0    ),
    .dmw1               (csr_dmw1_diff_0    )
);

DifftestGRegState DifftestGRegState(
    .clock              (aclk       ),
    .coreid             (0          ),
    .gpr_0              (0          ),
    .gpr_1              (regs[1]    ),
    .gpr_2              (regs[2]    ),
    .gpr_3              (regs[3]    ),
    .gpr_4              (regs[4]    ),
    .gpr_5              (regs[5]    ),
    .gpr_6              (regs[6]    ),
    .gpr_7              (regs[7]    ),
    .gpr_8              (regs[8]    ),
    .gpr_9              (regs[9]    ),
    .gpr_10             (regs[10]   ),
    .gpr_11             (regs[11]   ),
    .gpr_12             (regs[12]   ),
    .gpr_13             (regs[13]   ),
    .gpr_14             (regs[14]   ),
    .gpr_15             (regs[15]   ),
    .gpr_16             (regs[16]   ),
    .gpr_17             (regs[17]   ),
    .gpr_18             (regs[18]   ),
    .gpr_19             (regs[19]   ),
    .gpr_20             (regs[20]   ),
    .gpr_21             (regs[21]   ),
    .gpr_22             (regs[22]   ),
    .gpr_23             (regs[23]   ),
    .gpr_24             (regs[24]   ),
    .gpr_25             (regs[25]   ),
    .gpr_26             (regs[26]   ),
    .gpr_27             (regs[27]   ),
    .gpr_28             (regs[28]   ),
    .gpr_29             (regs[29]   ),
    .gpr_30             (regs[30]   ),
    .gpr_31             (regs[31]   )
);
`endif
    
endmodulemodule ProfCtr (
    input     wire            Clk              ,
    input     wire            Rest             ,

    input     wire            DcacheMiss      ,
    input     wire            IcacheMiss      ,
    input     wire            CommitInst      ,
    input     wire            BrInst          ,
    input     wire            MemInst         ,
    input     wire            BrPre           ,
    input     wire            BrPreErrot     
);

reg[31:0] DcacheMissCtr      ;
reg[31:0] IcacheMissCtr      ;
reg[31:0] CommitInstCtr      ;
reg[31:0] BrInstCtr          ;
reg[31:0] MemInstCtr         ;
reg[31:0] BrPreCtr           ;
reg[31:0] BrPreErrorCtr      ;

always @(posedge Clk) begin
    if (!Rest) begin
        DcacheMissCtr  <= 32'b0;
        IcacheMissCtr  <= 32'b0;
        CommitInstCtr  <= 32'b0;
        BrInstCtr      <= 32'b0;
        MemInstCtr     <= 32'b0;
        BrPreCtr       <= 32'b0;
        BrPreErrorCtr  <= 32'b0;
    end
    else begin
        if (DcacheMiss) begin
            DcacheMissCtr <= DcacheMissCtr + 32'b1;
        end
        if (IcacheMiss) begin
            IcacheMissCtr <= IcacheMissCtr + 32'b1;
        end
        if (CommitInst) begin
            CommitInstCtr <= CommitInstCtr + 32'b1;
        end
        if (BrInst    ) begin
            BrInstCtr     <= BrInstCtr + 32'b1;
        end
        if (MemInst   ) begin
            MemInstCtr    <= MemInstCtr + 32'b1;
        end
        if (BrPre     ) begin
            BrPreCtr      <= BrPreCtr + 32'b1;
        end
        if (BrPreErrot) begin
            BrPreErrorCtr <= BrPreErrorCtr + 32'b1;
        end
    end
end

endmodule
`include "config.h"

module soc_top(
    input         resetn, 
    input         clk,

    //------gpio----------------
    output [15:0] led,
    output [1 :0] led_rg0,
    output [1 :0] led_rg1,
    output [7 :0] num_csn,
    output [6 :0] num_a_g,
    input  [7 :0] switch, 
    output [3 :0] btn_key_col,
    input  [3 :0] btn_key_row,
    input  [1 :0] btn_step,

    //------DDR3 interface------
    inout  [15:0] ddr3_dq,
    output [12:0] ddr3_addr,
    output [2 :0] ddr3_ba,
    output        ddr3_ras_n,
    output        ddr3_cas_n,
    output        ddr3_we_n,
    output        ddr3_odt,
    output        ddr3_reset_n,
    output        ddr3_cke,
    output [1:0]  ddr3_dm,
    inout  [1:0]  ddr3_dqs_p,
    inout  [1:0]  ddr3_dqs_n,
    output        ddr3_ck_p,
    output        ddr3_ck_n,

    //------mac controller-------
    //TX
    input         mtxclk_0,     
    output        mtxen_0,      
    output [3:0]  mtxd_0,       
    output        mtxerr_0,
    //RX
    input         mrxclk_0,      
    input         mrxdv_0,     
    input  [3:0]  mrxd_0,        
    input         mrxerr_0,
    input         mcoll_0,
    input         mcrs_0,
    // MIIM
    output        mdc_0,
    inout         mdio_0,
    
    output        phy_rstn,
 
    //------EJTAG-------
    input         EJTAG_TRST,
    input         EJTAG_TCK,
    input         EJTAG_TDI,
    input         EJTAG_TMS,
    output        EJTAG_TDO,

    //------uart-------
    inout         UART_RX,
    inout         UART_TX,

    //------debug-uart------
    input         UART_RX2,
    output        UART_TX2,

    //------nand-------
    output        NAND_CLE ,
    output        NAND_ALE ,
    input         NAND_RDY ,
    inout [7:0]   NAND_DATA,
    output        NAND_RD  ,
    output        NAND_CE  ,  //low active
    output        NAND_WR  ,  
       
    //------spi flash-------
    output        SPI_CLK,
    output        SPI_CS,
    inout         SPI_MISO,
    inout         SPI_MOSI
);
wire        aclk;
wire        aresetn;
wire        cpu_clk;
wire        uncore_clk;

wire [`LID         -1 :0] m0_awid;
wire [`Lawaddr     -1 :0] m0_awaddr;
wire [`Lawlen      -1 :0] m0_awlen;
wire [`Lawsize     -1 :0] m0_awsize;
wire [`Lawburst    -1 :0] m0_awburst;
wire [`Lawlock     -1 :0] m0_awlock;
wire [`Lawcache    -1 :0] m0_awcache;
wire [`Lawprot     -1 :0] m0_awprot;
wire                      m0_awvalid;
wire                      m0_awready;
wire [`LID         -1 :0] m0_wid;
wire [`Lwdata      -1 :0] m0_wdata;
wire [`Lwstrb      -1 :0] m0_wstrb;
wire                      m0_wlast;
wire                      m0_wvalid;
wire                      m0_wready;
wire [`LID         -1 :0] m0_bid;
wire [`Lbresp      -1 :0] m0_bresp;
wire                      m0_bvalid;
wire                      m0_bready;
wire [`LID         -1 :0] m0_arid;
wire [`Laraddr     -1 :0] m0_araddr;
wire [`Larlen      -1 :0] m0_arlen;
wire [`Larsize     -1 :0] m0_arsize;
wire [`Larburst    -1 :0] m0_arburst;
wire [`Larlock     -1 :0] m0_arlock;
wire [`Larcache    -1 :0] m0_arcache;
wire [`Larprot     -1 :0] m0_arprot;
wire                      m0_arvalid;
wire                      m0_arready;
wire [`LID         -1 :0] m0_rid;
wire [`Lrdata      -1 :0] m0_rdata;
wire [`Lrresp      -1 :0] m0_rresp;
wire                      m0_rlast;
wire                      m0_rvalid;
wire                      m0_rready;

wire [`LID         -1 :0] m0_async_awid;
wire [`Lawaddr     -1 :0] m0_async_awaddr;
wire [`Lawlen      -1 :0] m0_async_awlen;
wire [`Lawsize     -1 :0] m0_async_awsize;
wire [`Lawburst    -1 :0] m0_async_awburst;
wire [`Lawlock     -1 :0] m0_async_awlock;
wire [`Lawcache    -1 :0] m0_async_awcache;
wire [`Lawprot     -1 :0] m0_async_awprot;
wire                      m0_async_awvalid;
wire                      m0_async_awready;
wire [`LID         -1 :0] m0_async_wid;
wire [`Lwdata      -1 :0] m0_async_wdata;
wire [`Lwstrb      -1 :0] m0_async_wstrb;
wire                      m0_async_wlast;
wire                      m0_async_wvalid;
wire                      m0_async_wready;
wire [`LID         -1 :0] m0_async_bid;
wire [`Lbresp      -1 :0] m0_async_bresp;
wire                      m0_async_bvalid;
wire                      m0_async_bready;
wire [`LID         -1 :0] m0_async_arid;
wire [`Laraddr     -1 :0] m0_async_araddr;
wire [`Larlen      -1 :0] m0_async_arlen;
wire [`Larsize     -1 :0] m0_async_arsize;
wire [`Larburst    -1 :0] m0_async_arburst;
wire [`Larlock     -1 :0] m0_async_arlock;
wire [`Larcache    -1 :0] m0_async_arcache;
wire [`Larprot     -1 :0] m0_async_arprot;
wire                      m0_async_arvalid;
wire                      m0_async_arready;
wire [`LID         -1 :0] m0_async_rid;
wire [`Lrdata      -1 :0] m0_async_rdata;
wire [`Lrresp      -1 :0] m0_async_rresp;
wire                      m0_async_rlast;
wire                      m0_async_rvalid;
wire                      m0_async_rready;

wire [`LID         -1 :0] spi_s_awid;
wire [`Lawaddr     -1 :0] spi_s_awaddr;
wire [`Lawlen      -1 :0] spi_s_awlen;
wire [`Lawsize     -1 :0] spi_s_awsize;
wire [`Lawburst    -1 :0] spi_s_awburst;
wire [`Lawlock     -1 :0] spi_s_awlock;
wire [`Lawcache    -1 :0] spi_s_awcache;
wire [`Lawprot     -1 :0] spi_s_awprot;
wire                      spi_s_awvalid;
wire                      spi_s_awready;
wire [`LID         -1 :0] spi_s_wid;
wire [`Lwdata      -1 :0] spi_s_wdata;
wire [`Lwstrb      -1 :0] spi_s_wstrb;
wire                      spi_s_wlast;
wire                      spi_s_wvalid;
wire                      spi_s_wready;
wire [`LID         -1 :0] spi_s_bid;
wire [`Lbresp      -1 :0] spi_s_bresp;
wire                      spi_s_bvalid;
wire                      spi_s_bready;
wire [`LID         -1 :0] spi_s_arid;
wire [`Laraddr     -1 :0] spi_s_araddr;
wire [`Larlen      -1 :0] spi_s_arlen;
wire [`Larsize     -1 :0] spi_s_arsize;
wire [`Larburst    -1 :0] spi_s_arburst;
wire [`Larlock     -1 :0] spi_s_arlock;
wire [`Larcache    -1 :0] spi_s_arcache;
wire [`Larprot     -1 :0] spi_s_arprot;
wire                      spi_s_arvalid;
wire                      spi_s_arready;
wire [`LID         -1 :0] spi_s_rid;
wire [`Lrdata      -1 :0] spi_s_rdata;
wire [`Lrresp      -1 :0] spi_s_rresp;
wire                      spi_s_rlast;
wire                      spi_s_rvalid;
wire                      spi_s_rready;

wire [`LID         -1 :0] conf_s_awid;
wire [`Lawaddr     -1 :0] conf_s_awaddr;
wire [`Lawlen      -1 :0] conf_s_awlen;
wire [`Lawsize     -1 :0] conf_s_awsize;
wire [`Lawburst    -1 :0] conf_s_awburst;
wire [`Lawlock     -1 :0] conf_s_awlock;
wire [`Lawcache    -1 :0] conf_s_awcache;
wire [`Lawprot     -1 :0] conf_s_awprot;
wire                      conf_s_awvalid;
wire                      conf_s_awready;
wire [`LID         -1 :0] conf_s_wid;
wire [`Lwdata      -1 :0] conf_s_wdata;
wire [`Lwstrb      -1 :0] conf_s_wstrb;
wire                      conf_s_wlast;
wire                      conf_s_wvalid;
wire                      conf_s_wready;
wire [`LID         -1 :0] conf_s_bid;
wire [`Lbresp      -1 :0] conf_s_bresp;
wire                      conf_s_bvalid;
wire                      conf_s_bready;
wire [`LID         -1 :0] conf_s_arid;
wire [`Laraddr     -1 :0] conf_s_araddr;
wire [`Larlen      -1 :0] conf_s_arlen;
wire [`Larsize     -1 :0] conf_s_arsize;
wire [`Larburst    -1 :0] conf_s_arburst;
wire [`Larlock     -1 :0] conf_s_arlock;
wire [`Larcache    -1 :0] conf_s_arcache;
wire [`Larprot     -1 :0] conf_s_arprot;
wire                      conf_s_arvalid;
wire                      conf_s_arready;
wire [`LID         -1 :0] conf_s_rid;
wire [`Lrdata      -1 :0] conf_s_rdata;
wire [`Lrresp      -1 :0] conf_s_rresp;
wire                      conf_s_rlast;
wire                      conf_s_rvalid;
wire                      conf_s_rready;

wire [`LID         -1 :0] mac_s_awid;
wire [`Lawaddr     -1 :0] mac_s_awaddr;
wire [`Lawlen      -1 :0] mac_s_awlen;
wire [`Lawsize     -1 :0] mac_s_awsize;
wire [`Lawburst    -1 :0] mac_s_awburst;
wire [`Lawlock     -1 :0] mac_s_awlock;
wire [`Lawcache    -1 :0] mac_s_awcache;
wire [`Lawprot     -1 :0] mac_s_awprot;
wire                      mac_s_awvalid;
wire                      mac_s_awready;
wire [`LID         -1 :0] mac_s_wid;
wire [`Lwdata      -1 :0] mac_s_wdata;
wire [`Lwstrb      -1 :0] mac_s_wstrb;
wire                      mac_s_wlast;
wire                      mac_s_wvalid;
wire                      mac_s_wready;
wire [`LID         -1 :0] mac_s_bid;
wire [`Lbresp      -1 :0] mac_s_bresp;
wire                      mac_s_bvalid;
wire                      mac_s_bready;
wire [`LID         -1 :0] mac_s_arid;
wire [`Laraddr     -1 :0] mac_s_araddr;
wire [`Larlen      -1 :0] mac_s_arlen;
wire [`Larsize     -1 :0] mac_s_arsize;
wire [`Larburst    -1 :0] mac_s_arburst;
wire [`Larlock     -1 :0] mac_s_arlock;
wire [`Larcache    -1 :0] mac_s_arcache;
wire [`Larprot     -1 :0] mac_s_arprot;
wire                      mac_s_arvalid;
wire                      mac_s_arready;
wire [`LID         -1 :0] mac_s_rid;
wire [`Lrdata      -1 :0] mac_s_rdata;
wire [`Lrresp      -1 :0] mac_s_rresp;
wire                      mac_s_rlast;
wire                      mac_s_rvalid;
wire                      mac_s_rready;

wire [`LID         -1 :0] mac_m_awid;
wire [`Lawaddr     -1 :0] mac_m_awaddr;
wire [`Lawlen      -1 :0] mac_m_awlen;
wire [`Lawsize     -1 :0] mac_m_awsize;
wire [`Lawburst    -1 :0] mac_m_awburst;
wire [`Lawlock     -1 :0] mac_m_awlock;
wire [`Lawcache    -1 :0] mac_m_awcache;
wire [`Lawprot     -1 :0] mac_m_awprot;
wire                      mac_m_awvalid;
wire                      mac_m_awready;
wire [`LID         -1 :0] mac_m_wid;
wire [`Lwdata      -1 :0] mac_m_wdata;
wire [`Lwstrb      -1 :0] mac_m_wstrb;
wire                      mac_m_wlast;
wire                      mac_m_wvalid;
wire                      mac_m_wready;
wire [`LID         -1 :0] mac_m_bid;
wire [`Lbresp      -1 :0] mac_m_bresp;
wire                      mac_m_bvalid;
wire                      mac_m_bready;
wire [`LID         -1 :0] mac_m_arid;
wire [`Laraddr     -1 :0] mac_m_araddr;
wire [`Larlen      -1 :0] mac_m_arlen;
wire [`Larsize     -1 :0] mac_m_arsize;
wire [`Larburst    -1 :0] mac_m_arburst;
wire [`Larlock     -1 :0] mac_m_arlock;
wire [`Larcache    -1 :0] mac_m_arcache;
wire [`Larprot     -1 :0] mac_m_arprot;
wire                      mac_m_arvalid;
wire                      mac_m_arready;
wire [`LID         -1 :0] mac_m_rid;
wire [`Lrdata      -1 :0] mac_m_rdata;
wire [`Lrresp      -1 :0] mac_m_rresp;
wire                      mac_m_rlast;
wire                      mac_m_rvalid;
wire                      mac_m_rready;

wire [`LID         -1 :0] s0_awid;
wire [`Lawaddr     -1 :0] s0_awaddr;
wire [`Lawlen      -1 :0] s0_awlen;
wire [`Lawsize     -1 :0] s0_awsize;
wire [`Lawburst    -1 :0] s0_awburst;
wire [`Lawlock     -1 :0] s0_awlock;
wire [`Lawcache    -1 :0] s0_awcache;
wire [`Lawprot     -1 :0] s0_awprot;
wire                      s0_awvalid;
wire                      s0_awready;
wire [`LID         -1 :0] s0_wid;
wire [`Lwdata      -1 :0] s0_wdata;
wire [`Lwstrb      -1 :0] s0_wstrb;
wire                      s0_wlast;
wire                      s0_wvalid;
wire                      s0_wready;
wire [`LID         -1 :0] s0_bid;
wire [`Lbresp      -1 :0] s0_bresp;
wire                      s0_bvalid;
wire                      s0_bready;
wire [`LID         -1 :0] s0_arid;
wire [`Laraddr     -1 :0] s0_araddr;
wire [`Larlen      -1 :0] s0_arlen;
wire [`Larsize     -1 :0] s0_arsize;
wire [`Larburst    -1 :0] s0_arburst;
wire [`Larlock     -1 :0] s0_arlock;
wire [`Larcache    -1 :0] s0_arcache;
wire [`Larprot     -1 :0] s0_arprot;
wire                      s0_arvalid;
wire                      s0_arready;
wire [`LID         -1 :0] s0_rid;
wire [`Lrdata      -1 :0] s0_rdata;
wire [`Lrresp      -1 :0] s0_rresp;
wire                      s0_rlast;
wire                      s0_rvalid;
wire                      s0_rready;

wire [8            -1 :0] mig_awid;
wire [`Lawaddr     -1 :0] mig_awaddr;
wire [8            -1 :0] mig_awlen;
wire [`Lawsize     -1 :0] mig_awsize;
wire [`Lawburst    -1 :0] mig_awburst;
wire [`Lawlock     -1 :0] mig_awlock;
wire [`Lawcache    -1 :0] mig_awcache;
wire [`Lawprot     -1 :0] mig_awprot;
wire                      mig_awvalid;
wire                      mig_awready;
wire [8            -1 :0] mig_wid;
wire [`Lwdata      -1 :0] mig_wdata;
wire [`Lwstrb      -1 :0] mig_wstrb;
wire                      mig_wlast;
wire                      mig_wvalid;
wire                      mig_wready;
wire [8            -1 :0] mig_bid;
wire [`Lbresp      -1 :0] mig_bresp;
wire                      mig_bvalid;
wire                      mig_bready;
wire [8            -1 :0] mig_arid;
wire [`Laraddr     -1 :0] mig_araddr;
wire [8            -1 :0] mig_arlen;
wire [`Larsize     -1 :0] mig_arsize;
wire [`Larburst    -1 :0] mig_arburst;
wire [`Larlock     -1 :0] mig_arlock;
wire [`Larcache    -1 :0] mig_arcache;
wire [`Larprot     -1 :0] mig_arprot;
wire                      mig_arvalid;
wire                      mig_arready;
wire [8            -1 :0] mig_rid;
wire [`Lrdata      -1 :0] mig_rdata;
wire [`Lrresp      -1 :0] mig_rresp;
wire                      mig_rlast;
wire                      mig_rvalid;
wire                      mig_rready;

wire [`LID         -1 :0] dma0_awid       ;
wire [`Lawaddr     -1 :0] dma0_awaddr     ;
wire [`Lawlen      -1 :0] dma0_awlen      ;
wire [`Lawsize     -1 :0] dma0_awsize     ;
wire [`Lawburst    -1 :0] dma0_awburst    ;
wire [`Lawlock     -1 :0] dma0_awlock     ;
wire [`Lawcache    -1 :0] dma0_awcache    ;
wire [`Lawprot     -1 :0] dma0_awprot     ;
wire                      dma0_awvalid    ;
wire                      dma0_awready    ;
wire [`LID         -1 :0] dma0_wid        ;
wire [64           -1 :0] dma0_wdata      ;
wire [8            -1 :0] dma0_wstrb      ;
wire                      dma0_wlast      ;
wire                      dma0_wvalid     ;
wire                      dma0_wready     ;
wire [`LID         -1 :0] dma0_bid        ;
wire [`Lbresp      -1 :0] dma0_bresp      ;
wire                      dma0_bvalid     ;
wire                      dma0_bready     ;
wire [`LID         -1 :0] dma0_arid       ;
wire [`Laraddr     -1 :0] dma0_araddr     ;
wire [`Larlen      -1 :0] dma0_arlen      ;
wire [`Larsize     -1 :0] dma0_arsize     ;
wire [`Larburst    -1 :0] dma0_arburst    ;
wire [`Larlock     -1 :0] dma0_arlock     ;
wire [`Larcache    -1 :0] dma0_arcache    ;
wire [`Larprot     -1 :0] dma0_arprot     ;
wire                      dma0_arvalid    ;
wire                      dma0_arready    ;
wire [`LID         -1 :0] dma0_rid        ;
wire [64           -1 :0] dma0_rdata      ;
wire [`Lrresp      -1 :0] dma0_rresp      ;
wire                      dma0_rlast      ;
wire                      dma0_rvalid     ;
wire                      dma0_rready     ;

wire [`LID         -1 :0] apb_s_awid;
wire [`Lawaddr     -1 :0] apb_s_awaddr;
wire [`Lawlen      -1 :0] apb_s_awlen;
wire [`Lawsize     -1 :0] apb_s_awsize;
wire [`Lawburst    -1 :0] apb_s_awburst;
wire [`Lawlock     -1 :0] apb_s_awlock;
wire [`Lawcache    -1 :0] apb_s_awcache;
wire [`Lawprot     -1 :0] apb_s_awprot;
wire                      apb_s_awvalid;
wire                      apb_s_awready;
wire [`LID         -1 :0] apb_s_wid;
wire [`Lwdata      -1 :0] apb_s_wdata;
wire [`Lwstrb      -1 :0] apb_s_wstrb;
wire                      apb_s_wlast;
wire                      apb_s_wvalid;
wire                      apb_s_wready;
wire [`LID         -1 :0] apb_s_bid;
wire [`Lbresp      -1 :0] apb_s_bresp;
wire                      apb_s_bvalid;
wire                      apb_s_bready;
wire [`LID         -1 :0] apb_s_arid;
wire [`Laraddr     -1 :0] apb_s_araddr;
wire [`Larlen      -1 :0] apb_s_arlen;
wire [`Larsize     -1 :0] apb_s_arsize;
wire [`Larburst    -1 :0] apb_s_arburst;
wire [`Larlock     -1 :0] apb_s_arlock;
wire [`Larcache    -1 :0] apb_s_arcache;
wire [`Larprot     -1 :0] apb_s_arprot;
wire                      apb_s_arvalid;
wire                      apb_s_arready;
wire [`LID         -1 :0] apb_s_rid;
wire [`Lrdata      -1 :0] apb_s_rdata;
wire [`Lrresp      -1 :0] apb_s_rresp;
wire                      apb_s_rlast;
wire                      apb_s_rvalid;
wire                      apb_s_rready;

wire          apb_ready_dma0;
wire          apb_start_dma0;
wire          apb_rw_dma0;
wire          apb_psel_dma0;
wire          apb_penable_dma0;
wire[31:0]    apb_addr_dma0;
wire[31:0]    apb_wdata_dma0;
wire[31:0]    apb_rdata_dma0;

wire         dma_int;
wire         dma_ack;
wire         dma_req;

wire                      dma0_gnt;
wire[31:0]                order_addr_in;
wire                      write_dma_end;
wire                      finish_read_order;

//spi
wire [3:0]spi_csn_o ;
wire [3:0]spi_csn_en;
wire spi_sck_o ;
wire spi_sdo_i ;
wire spi_sdo_o ;
wire spi_sdo_en;
wire spi_sdi_i ;
wire spi_sdi_o ;
wire spi_sdi_en;
wire spi_inta_o;
assign     SPI_CLK = spi_sck_o;
assign     SPI_CS  = ~spi_csn_en[0] & spi_csn_o[0];
assign     SPI_MOSI = spi_sdo_en ? 1'bz : spi_sdo_o ;
assign     SPI_MISO = spi_sdi_en ? 1'bz : spi_sdi_o ;
assign     spi_sdo_i = SPI_MOSI;
assign     spi_sdi_i = SPI_MISO;

// confreg 
wire   [31:0] cr00,cr01,cr02,cr03,cr04,cr05,cr06,cr07;

//mac
wire md_i_0;      // MII data input (from I/O cell)
wire md_o_0;      // MII data output (to I/O cell)
wire md_oe_0;     // MII data output enable (to I/O cell)
IOBUF mac_mdio(.IO(mdio_0),.I(md_o_0),.T(~md_oe_0),.O(md_i_0));
assign phy_rstn = aresetn;

//nand
wire       nand_cle   ;
wire       nand_ale   ;
wire [3:0] nand_rdy   ;
wire [3:0] nand_ce    ;
wire       nand_rd    ;
wire       nand_wr    ;
wire       nand_dat_oe;
wire [7:0] nand_dat_i ;
wire [7:0] nand_dat_o ;
wire       nand_int   ;
assign     NAND_CLE = nand_cle;
assign     NAND_ALE = nand_ale;
assign     nand_rdy = {3'd0,NAND_RDY};
assign     NAND_RD  = nand_rd;
assign     NAND_CE  = nand_ce[0];  //low active
assign     NAND_WR  = nand_wr;  
generate
    genvar i;
    for(i=0;i<8;i=i+1)
    begin: nand_data_loop
        IOBUF nand_data(.IO(NAND_DATA[i]),.I(nand_dat_o[i]),.T(nand_dat_oe),.O(nand_dat_i[i]));
    end
endgenerate

//uart
wire UART_CTS,   UART_RTS;
wire UART_DTR,   UART_DSR;
wire UART_RI,    UART_DCD;
assign UART_CTS = 1'b0;
assign UART_DSR = 1'b0;
assign UART_DCD = 1'b0;
wire uart0_int   ;
wire uart0_txd_o ;
wire uart0_txd_i ;
wire uart0_txd_oe;
wire uart0_rxd_o ;
wire uart0_rxd_i ;
wire uart0_rxd_oe;
wire uart0_rts_o ;
wire uart0_cts_i ;
wire uart0_dsr_i ;
wire uart0_dcd_i ;
wire uart0_dtr_o ;
wire uart0_ri_i  ;
assign     UART_RX     = uart0_rxd_oe ? 1'bz : uart0_rxd_o ;
assign     UART_TX     = uart0_txd_oe ? 1'bz : uart0_txd_o ;
assign     UART_RTS    = uart0_rts_o ;
assign     UART_DTR    = uart0_dtr_o ;
assign     uart0_txd_i = UART_TX;
assign     uart0_rxd_i = UART_RX;
assign     uart0_cts_i = UART_CTS;
assign     uart0_dcd_i = UART_DCD;
assign     uart0_dsr_i = UART_DSR;
assign     uart0_ri_i  = UART_RI ;

//interrupt
wire mac_int;
wire [5:0] int_out;
wire [5:0] int_n_i;
assign int_out = {1'b0,dma_int,nand_int,spi_inta_o,uart0_int,mac_int};
assign int_n_i = ~int_out;

reg cpu_aresetn_1;
reg cpu_aresetn_2;

wire cpu_aresetn;

always @(posedge cpu_clk) begin
    cpu_aresetn_1 <= aresetn;
    cpu_aresetn_2 <= cpu_aresetn_1;
end

assign cpu_aresetn = cpu_aresetn_2;

//debug signals
wire [31:0] debug_wb_pc;
wire [3 :0] debug_wb_rf_wen;
wire [4 :0] debug_wb_rf_wnum;
wire [31:0] debug_wb_rf_wdata;
wire        ws_valid;
wire        break_point;
wire        infor_flag;
wire [ 4:0] reg_num;
wire [31:0] rf_rdata;

//uart_ram signals
wire [3 :0] uart_arid   ;
wire [31:0] uart_araddr ;
wire [7 :0] uart_arlen  ;
wire [2 :0] uart_arsize ;
wire [1 :0] uart_arburst;
wire [1 :0] uart_arlock ;
wire [3 :0] uart_arcache;
wire [2 :0] uart_arprot ;
wire        uart_arvalid;
wire        uart_arready;
wire [3 :0] uart_rid    ;
wire [31:0] uart_rdata  ;
wire [1 :0] uart_rresp  ;
wire        uart_rlast  ;
wire        uart_rvalid ;
wire        uart_rready ;

wire        infom_flag;
wire [31:0] start_addr;
wire        mem_flag;
wire [ 7:0] mem_rdata;

//axi_2x1 signals
wire [`LID         -1 :0] m1_arid;
wire [`Laraddr     -1 :0] m1_araddr;
wire [`Larlen      -1 :0] m1_arlen;
wire [`Larsize     -1 :0] m1_arsize;
wire [`Larburst    -1 :0] m1_arburst;
wire [`Larlock     -1 :0] m1_arlock;
wire [`Larcache    -1 :0] m1_arcache;
wire [`Larprot     -1 :0] m1_arprot;
wire                      m1_arvalid;
wire                      m1_arready;
wire [`LID         -1 :0] m1_rid;
wire [`Lrdata      -1 :0] m1_rdata;
wire [`Lrresp      -1 :0] m1_rresp;
wire                      m1_rlast;
wire                      m1_rvalid;
wire                      m1_rready;

debug_top u_debug_top(
    .sys_clk              (cpu_clk          ),
    .sys_rst_n            (resetn           ),
    .uart_rxd             (UART_RX2         ),
    .debug_wb_pc          (debug_wb_pc      ),
    .debug_wb_rf_wnum     (debug_wb_rf_wnum ),
    .debug_wb_rf_wdata    (debug_wb_rf_wdata),
    .ws_valid             (ws_valid         ),
    .break_point          (break_point      ),
    .infor_flag           (infor_flag       ),
    .reg_num              (reg_num          ),
    .rf_rdata             (rf_rdata         ),
    .infom_flag           (infom_flag       ),
    .start_addr           (start_addr       ),
    .mem_flag             (mem_flag         ),
    .mem_rdata            (mem_rdata        ),
    .uart_txd             (UART_TX2         )

);


debug_sram u_debug_sram(
    .clk       (cpu_clk        ),
    .aresetn   (resetn         ),   

    .arid      (uart_arid      ),
    .araddr    (uart_araddr    ),
    .arlen     (uart_arlen     ),
    .arsize    (uart_arsize    ),
    .arburst   (uart_arburst   ),
    .arlock    (uart_arlock    ),
    .arcache   (uart_arcache   ),
    .arprot    (uart_arprot    ),
    .arvalid   (uart_arvalid   ),
    .arready   (uart_arready   ),
                
    .rid       (uart_rid       ),
    .rdata     (uart_rdata     ),
    .rresp     (uart_rresp     ),
    .rlast     (uart_rlast     ),
    .rvalid    (uart_rvalid    ),
    .rready    (uart_rready    ),

    .break_point(              ),
    .cpu_rready (              ),  
    .rvalid_r   (              ),
    .rid_r      (              ),
    .rdata_r    (              ),
    .rlast_r    (              ),
    .flag       (              ),

    .infom_flag(infom_flag    ),
    .start_addr(start_addr    ),
    .mem_flag  (mem_flag      ),
    .mem_rdata (mem_rdata     ) 

);

// cpu
core_top cpu_mid(
  .aclk             (cpu_clk),
  .intrpt           ({3'b0, int_out[4:0]}),  //232 only 5bit
  //.nmi              (1'b1),

  .aresetn          (cpu_aresetn  ),
  .arid         (m0_arid[3:0] ),
  .araddr       (m0_araddr    ),
  .arlen        (m0_arlen     ),
  .arsize       (m0_arsize    ),
  .arburst      (m0_arburst   ),
  .arlock       (m0_arlock    ),
  .arcache      (m0_arcache   ),
  .arprot       (m0_arprot    ),
  .arvalid      (m0_arvalid   ),
  .arready      (m0_arready   ),
  .rid          (m0_rid[3:0]  ),
  .rdata        (m0_rdata     ),
  .rresp        (m0_rresp     ),
  .rlast        (m0_rlast     ),
  .rvalid       (m0_rvalid    ),
  .rready       (m0_rready    ),
  .awid         (m0_awid[3:0] ),
  .awaddr       (m0_awaddr    ),
  .awlen        (m0_awlen     ),
  .awsize       (m0_awsize    ),
  .awburst      (m0_awburst   ),
  .awlock       (m0_awlock    ),
  .awcache      (m0_awcache   ),
  .awprot       (m0_awprot    ),
  .awvalid      (m0_awvalid   ),
  .awready      (m0_awready   ),
  .wid          (m0_wid[3:0]  ),
  .wdata        (m0_wdata     ),
  .wstrb        (m0_wstrb     ),
  .wlast        (m0_wlast     ),
  .wvalid       (m0_wvalid    ),
  .wready       (m0_wready    ),
  .bid          (m0_bid[3:0]  ),
  .bresp        (m0_bresp     ),
  .bvalid       (m0_bvalid    ),
  .bready       (m0_bready    ),

  .ws_valid     (ws_valid     ),
  .break_point  (break_point  ),
  .infor_flag   (infor_flag   ),
  .reg_num      (reg_num      ),
  .rf_rdata     (rf_rdata     ),

  .debug0_wb_pc        (debug_wb_pc      ),
  .debug0_wb_rf_wen    (debug_wb_rf_wen  ),
  .debug0_wb_rf_wnum   (debug_wb_rf_wnum ),
  .debug0_wb_rf_wdata  (debug_wb_rf_wdata)
);

//AXI_2x1_MUX
axi_2x1_mux u_axi_2x1_mux
(
    .INTERCONNECT_ACLK   (cpu_clk     ),
    .INTERCONNECT_ARESETN(resetn      ),
    .S00_AXI_ACLK        (cpu_clk     ),
    .S00_AXI_ARESET_OUT_N(            ),
    .S00_AXI_ARADDR      (m0_araddr   ),
    .S00_AXI_ARBURST     (m0_arburst  ),
    .S00_AXI_ARCACHE     (m0_arcache  ),
    .S00_AXI_ARID        (m0_arid[3:0]),
    .S00_AXI_ARLEN       (m0_arlen    ),
    .S00_AXI_ARLOCK      (m0_arlock   ),
    .S00_AXI_ARPROT      (m0_arprot   ),
    .S00_AXI_ARQOS       (4'b0        ),
    .S00_AXI_ARREADY     (m0_arready  ),
    .S00_AXI_ARSIZE      (m0_arsize   ),
    .S00_AXI_ARVALID     (m0_arvalid  ),
    .S00_AXI_RDATA       (m0_rdata    ),
    .S00_AXI_RID         (m0_rid[3:0] ),
    .S00_AXI_RLAST       (m0_rlast    ),
    .S00_AXI_RREADY      (m0_rready   ),
    .S00_AXI_RRESP       (m0_rresp    ),
    .S00_AXI_RVALID      (m0_rvalid   ),
    .S00_AXI_AWADDR      (`Lawaddr'b0 ),
    .S00_AXI_AWBURST     (`Lawburst'b0),
    .S00_AXI_AWCACHE     (`Lawcache'b0),
    .S00_AXI_AWID        (`LID'b0     ),
    .S00_AXI_AWLEN       (`Lawlen'b0  ),
    .S00_AXI_AWLOCK      (`Lawlock'b0 ),
    .S00_AXI_AWPROT      (`Lawprot'b0 ),
    .S00_AXI_AWQOS       (4'b0        ),
    .S00_AXI_AWREADY     (            ),
    .S00_AXI_AWSIZE      (`Lawsize'b0 ),
    .S00_AXI_AWVALID     (1'b0        ),
    .S00_AXI_WDATA       (`Lwdata'b0  ),
    .S00_AXI_WLAST       (1'b0        ),
    .S00_AXI_WREADY      (            ),
    .S00_AXI_WSTRB       (`Lwstrb'b0  ),
    .S00_AXI_WVALID      (1'b0        ),
    .S00_AXI_BID         (            ),
    .S00_AXI_BREADY      (1'b0        ),
    .S00_AXI_BRESP       (            ),
    .S00_AXI_BVALID      (            ),
   
    .S01_AXI_ACLK        (cpu_clk     ),
    .S01_AXI_ARESET_OUT_N(            ),
    .S01_AXI_ARADDR      (uart_araddr ),
    .S01_AXI_ARBURST     (uart_arburst),
    .S01_AXI_ARCACHE     (uart_arcache),
    .S01_AXI_ARID        (uart_arid   ),
    .S01_AXI_ARLEN       (uart_arlen  ),
    .S01_AXI_ARLOCK      (uart_arlock ),
    .S01_AXI_ARPROT      (uart_arprot ),
    .S01_AXI_ARQOS       (4'b0        ),
    .S01_AXI_ARREADY     (uart_arready),
    .S01_AXI_ARSIZE      (uart_arsize ),
    .S01_AXI_ARVALID     (uart_arvalid),
    .S01_AXI_RDATA       (uart_rdata  ),
    .S01_AXI_RID         (uart_rid    ),
    .S01_AXI_RLAST       (uart_rlast  ),
    .S01_AXI_RREADY      (uart_rready ),
    .S01_AXI_RRESP       (uart_rresp  ),
    .S01_AXI_RVALID      (uart_rvalid ),
    .S01_AXI_AWADDR      (`Lawaddr'b0 ),
    .S01_AXI_AWBURST     (`Lawburst'b0),
    .S01_AXI_AWCACHE     (`Lawcache'b0),
    .S01_AXI_AWID        (`LID'b0     ),
    .S01_AXI_AWLEN       (`Lawlen'b0  ),
    .S01_AXI_AWLOCK      (`Lawlock'b0 ),
    .S01_AXI_AWPROT      (`Lawprot'b0 ),
    .S01_AXI_AWQOS       (4'b0        ),
    .S01_AXI_AWREADY     (            ),
    .S01_AXI_AWSIZE      (`Lawsize'b0 ),
    .S01_AXI_AWVALID     (1'b0        ),
    .S01_AXI_WDATA       (`Lwdata'b0  ),
    .S01_AXI_WLAST       (1'b0        ),
    .S01_AXI_WREADY      (            ),
    .S01_AXI_WSTRB       (`Lwstrb'b0  ),
    .S01_AXI_WVALID      (1'b0        ),
    .S01_AXI_BID         (            ),
    .S01_AXI_BREADY      (1'b0        ),
    .S01_AXI_BRESP       (            ),
    .S01_AXI_BVALID      (            ),
    
    .M00_AXI_ACLK        (cpu_clk     ),
    .M00_AXI_ARESET_OUT_N(            ),
    .M00_AXI_ARADDR      (m1_araddr   ),
    .M00_AXI_ARBURST     (m1_arburst  ),
    .M00_AXI_ARCACHE     (m1_arcache  ),
    .M00_AXI_ARID        (m1_arid[3:0]),
    .M00_AXI_ARLEN       (m1_arlen    ),
    .M00_AXI_ARLOCK      (m1_arlock   ),
    .M00_AXI_ARPROT      (m1_arprot   ),
    .M00_AXI_ARQOS       (4'b0        ),
    .M00_AXI_ARREADY     (m1_arready  ),
    .M00_AXI_ARSIZE      (m1_arsize   ),
    .M00_AXI_ARVALID     (m1_arvalid  ),
    .M00_AXI_RDATA       (m1_rdata    ),
    .M00_AXI_RID         ({1'b0,m1_rid[3:0]} ),
    .M00_AXI_RLAST       (m1_rlast    ),
    .M00_AXI_RREADY      (m1_rready   ),
    .M00_AXI_RRESP       (m1_rresp    ),
    .M00_AXI_RVALID      (m1_rvalid   ),
    .M00_AXI_AWADDR      (            ),
    .M00_AXI_AWBURST     (            ),
    .M00_AXI_AWCACHE     (            ),
    .M00_AXI_AWID        (            ),
    .M00_AXI_AWLEN       (            ),
    .M00_AXI_AWLOCK      (            ),
    .M00_AXI_AWPROT      (            ),
    .M00_AXI_AWQOS       (            ),
    .M00_AXI_AWREADY     (1'b0        ),
    .M00_AXI_AWSIZE      (            ),
    .M00_AXI_AWVALID     (            ),
    .M00_AXI_WDATA       (            ),
    .M00_AXI_WLAST       (            ),
    .M00_AXI_WREADY      (1'b0        ),
    .M00_AXI_WSTRB       (            ),
    .M00_AXI_WVALID      (            ),
    .M00_AXI_BID         (5'b0        ),
    .M00_AXI_BREADY      (            ),
    .M00_AXI_BRESP       (`Lbresp'b0  ),
    .M00_AXI_BVALID      (1'b0        )
);

// cpu_axi asyn
axi_clock_converter_0 AXI_CLK_CONVERTER (
    .s_axi_awid       (m0_awid[3:0]       ),	
    .s_axi_awaddr     (m0_awaddr          ),
    .s_axi_awlen      (m0_awlen           ),
    .s_axi_awsize     (m0_awsize          ),
    .s_axi_awburst    (m0_awburst         ),
    .s_axi_awlock     (m0_awlock          ),
    .s_axi_awcache    (m0_awcache         ),
    .s_axi_awprot     (m0_awprot          ),
    .s_axi_awqos      (4'b0               ),
    .s_axi_awvalid    (m0_awvalid         ),
    .s_axi_awready    (m0_awready         ),
    .s_axi_wid        (m0_wid[3:0]        ),
    .s_axi_wdata      (m0_wdata           ),
    .s_axi_wstrb      (m0_wstrb           ),
    .s_axi_wlast      (m0_wlast           ),
    .s_axi_wvalid     (m0_wvalid          ),
    .s_axi_wready     (m0_wready          ),
    .s_axi_bid        (m0_bid[3:0]        ),
    .s_axi_bresp      (m0_bresp           ),
    .s_axi_bvalid     (m0_bvalid          ),
    .s_axi_bready     (m0_bready          ),
    .s_axi_arid       (m1_arid[3:0]       ),
    .s_axi_araddr     (m1_araddr          ),
    .s_axi_arlen      (m1_arlen           ),
    .s_axi_arsize     (m1_arsize          ),
    .s_axi_arburst    (m1_arburst         ),
    .s_axi_arlock     (m1_arlock          ),
    .s_axi_arcache    (m1_arcache         ),
    .s_axi_arprot     (m1_arprot          ),
    .s_axi_arqos      (4'b0               ),
    .s_axi_arvalid    (m1_arvalid         ),
    .s_axi_arready    (m1_arready         ),
    .s_axi_rid        (m1_rid[3:0]        ),
    .s_axi_rdata      (m1_rdata           ),
    .s_axi_rresp      (m1_rresp           ),
    .s_axi_rlast      (m1_rlast           ),
    .s_axi_rvalid     (m1_rvalid          ),
    .s_axi_rready     (m1_rready          ),

    .s_axi_aclk	      (cpu_clk            ),
    .s_axi_aresetn    (cpu_aresetn        ),
    
    .m_axi_awid       (m0_async_awid[3:0] ),
    .m_axi_awaddr     (m0_async_awaddr    ),
    .m_axi_awlen      (m0_async_awlen     ),
    .m_axi_awsize     (m0_async_awsize    ),
    .m_axi_awburst    (m0_async_awburst   ),
    .m_axi_awlock     (m0_async_awlock    ),
    .m_axi_awcache    (m0_async_awcache   ),
    .m_axi_awprot     (m0_async_awprot    ),
    .m_axi_awqos      (                   ),
    .m_axi_awvalid    (m0_async_awvalid   ),
    .m_axi_awready    (m0_async_awready   ),
    .m_axi_wid        (m0_async_wid[3:0]  ),
    .m_axi_wdata      (m0_async_wdata     ),
    .m_axi_wstrb      (m0_async_wstrb     ),
    .m_axi_wlast      (m0_async_wlast     ),
    .m_axi_wvalid     (m0_async_wvalid    ),
    .m_axi_wready     (m0_async_wready    ),
    .m_axi_bid        (m0_async_bid[3:0]  ),
    .m_axi_bresp      (m0_async_bresp     ),
    .m_axi_bvalid     (m0_async_bvalid    ),
    .m_axi_bready     (m0_async_bready    ),
    .m_axi_arid       (m0_async_arid[3:0] ),
    .m_axi_araddr     (m0_async_araddr    ),
    .m_axi_arlen      (m0_async_arlen     ),
    .m_axi_arsize     (m0_async_arsize    ),
    .m_axi_arburst    (m0_async_arburst   ),
    .m_axi_arlock     (m0_async_arlock    ),
    .m_axi_arcache    (m0_async_arcache   ),
    .m_axi_arprot     (m0_async_arprot    ),
    .m_axi_arqos      (                   ),
    .m_axi_arvalid    (m0_async_arvalid   ),
    .m_axi_arready    (m0_async_arready   ),
    .m_axi_rid        (m0_async_rid[3:0]  ),
    .m_axi_rdata      (m0_async_rdata     ),
    .m_axi_rresp      (m0_async_rresp     ),
    .m_axi_rlast      (m0_async_rlast     ),
    .m_axi_rvalid     (m0_async_rvalid    ),
    .m_axi_rready     (m0_async_rready    ),

    .m_axi_aclk	      (aclk               ),
    .m_axi_aresetn    (aresetn            )
);

// AXI_MUX
axi_slave_mux AXI_SLAVE_MUX
(
.axi_s_aresetn     (aresetn              ),
.spi_boot          (1'b1                 ),  

.axi_s_awid        (m0_async_awid        ),
.axi_s_awaddr      (m0_async_awaddr      ),
.axi_s_awlen       (m0_async_awlen       ),
.axi_s_awsize      (m0_async_awsize      ),
.axi_s_awburst     (m0_async_awburst     ),
.axi_s_awlock      (m0_async_awlock      ),
.axi_s_awcache     (m0_async_awcache     ),
.axi_s_awprot      (m0_async_awprot      ),
.axi_s_awvalid     (m0_async_awvalid     ),
.axi_s_awready     (m0_async_awready     ),
.axi_s_wready      (m0_async_wready      ),
.axi_s_wid         (m0_async_wid         ),
.axi_s_wdata       (m0_async_wdata       ),
.axi_s_wstrb       (m0_async_wstrb       ),
.axi_s_wlast       (m0_async_wlast       ),
.axi_s_wvalid      (m0_async_wvalid      ),
.axi_s_bid         (m0_async_bid         ),
.axi_s_bresp       (m0_async_bresp       ),
.axi_s_bvalid      (m0_async_bvalid      ),
.axi_s_bready      (m0_async_bready      ),
.axi_s_arid        (m0_async_arid        ),
.axi_s_araddr      (m0_async_araddr      ),
.axi_s_arlen       (m0_async_arlen       ),
.axi_s_arsize      (m0_async_arsize      ),
.axi_s_arburst     (m0_async_arburst     ),
.axi_s_arlock      (m0_async_arlock      ),
.axi_s_arcache     (m0_async_arcache     ),
.axi_s_arprot      (m0_async_arprot      ),
.axi_s_arvalid     (m0_async_arvalid     ),
.axi_s_arready     (m0_async_arready     ),
.axi_s_rready      (m0_async_rready      ),
.axi_s_rid         (m0_async_rid         ),
.axi_s_rdata       (m0_async_rdata       ),
.axi_s_rresp       (m0_async_rresp       ),
.axi_s_rlast       (m0_async_rlast       ),
.axi_s_rvalid      (m0_async_rvalid      ),

.s0_awid           (s0_awid         ),
.s0_awaddr         (s0_awaddr       ),
.s0_awlen          (s0_awlen        ),
.s0_awsize         (s0_awsize       ),
.s0_awburst        (s0_awburst      ),
.s0_awlock         (s0_awlock       ),
.s0_awcache        (s0_awcache      ),
.s0_awprot         (s0_awprot       ),
.s0_awvalid        (s0_awvalid      ),
.s0_awready        (s0_awready      ),
.s0_wid            (s0_wid          ),
.s0_wdata          (s0_wdata        ),
.s0_wstrb          (s0_wstrb        ),
.s0_wlast          (s0_wlast        ),
.s0_wvalid         (s0_wvalid       ),
.s0_wready         (s0_wready       ),
.s0_bid            (s0_bid          ),
.s0_bresp          (s0_bresp        ),
.s0_bvalid         (s0_bvalid       ),
.s0_bready         (s0_bready       ),
.s0_arid           (s0_arid         ),
.s0_araddr         (s0_araddr       ),
.s0_arlen          (s0_arlen        ),
.s0_arsize         (s0_arsize       ),
.s0_arburst        (s0_arburst      ),
.s0_arlock         (s0_arlock       ),
.s0_arcache        (s0_arcache      ),
.s0_arprot         (s0_arprot       ),
.s0_arvalid        (s0_arvalid      ),
.s0_arready        (s0_arready      ),
.s0_rid            (s0_rid          ),
.s0_rdata          (s0_rdata        ),
.s0_rresp          (s0_rresp        ),
.s0_rlast          (s0_rlast        ),
.s0_rvalid         (s0_rvalid       ),
.s0_rready         (s0_rready       ),

.s1_awid           (spi_s_awid          ),
.s1_awaddr         (spi_s_awaddr        ),
.s1_awlen          (spi_s_awlen         ),
.s1_awsize         (spi_s_awsize        ),
.s1_awburst        (spi_s_awburst       ),
.s1_awlock         (spi_s_awlock        ),
.s1_awcache        (spi_s_awcache       ),
.s1_awprot         (spi_s_awprot        ),
.s1_awvalid        (spi_s_awvalid       ),
.s1_awready        (spi_s_awready       ),
.s1_wid            (spi_s_wid           ),
.s1_wdata          (spi_s_wdata         ),
.s1_wstrb          (spi_s_wstrb         ),
.s1_wlast          (spi_s_wlast         ),
.s1_wvalid         (spi_s_wvalid        ),
.s1_wready         (spi_s_wready        ),
.s1_bid            (spi_s_bid           ),
.s1_bresp          (spi_s_bresp         ),
.s1_bvalid         (spi_s_bvalid        ),
.s1_bready         (spi_s_bready        ),
.s1_arid           (spi_s_arid          ),
.s1_araddr         (spi_s_araddr        ),
.s1_arlen          (spi_s_arlen         ),
.s1_arsize         (spi_s_arsize        ),
.s1_arburst        (spi_s_arburst       ),
.s1_arlock         (spi_s_arlock        ),
.s1_arcache        (spi_s_arcache       ),
.s1_arprot         (spi_s_arprot        ),
.s1_arvalid        (spi_s_arvalid       ),
.s1_arready        (spi_s_arready       ),
.s1_rid            (spi_s_rid           ),
.s1_rdata          (spi_s_rdata         ),
.s1_rresp          (spi_s_rresp         ),
.s1_rlast          (spi_s_rlast         ),
.s1_rvalid         (spi_s_rvalid        ),
.s1_rready         (spi_s_rready        ),

.s2_awid           (apb_s_awid         ),
.s2_awaddr         (apb_s_awaddr       ),
.s2_awlen          (apb_s_awlen        ),
.s2_awsize         (apb_s_awsize       ),
.s2_awburst        (apb_s_awburst      ),
.s2_awlock         (apb_s_awlock       ),
.s2_awcache        (apb_s_awcache      ),
.s2_awprot         (apb_s_awprot       ),
.s2_awvalid        (apb_s_awvalid      ),
.s2_awready        (apb_s_awready      ),
.s2_wid            (apb_s_wid          ),
.s2_wdata          (apb_s_wdata        ),
.s2_wstrb          (apb_s_wstrb        ),
.s2_wlast          (apb_s_wlast        ),
.s2_wvalid         (apb_s_wvalid       ),
.s2_wready         (apb_s_wready       ),
.s2_bid            (apb_s_bid          ),
.s2_bresp          (apb_s_bresp        ),
.s2_bvalid         (apb_s_bvalid       ),
.s2_bready         (apb_s_bready       ),
.s2_arid           (apb_s_arid         ),
.s2_araddr         (apb_s_araddr       ),
.s2_arlen          (apb_s_arlen        ),
.s2_arsize         (apb_s_arsize       ),
.s2_arburst        (apb_s_arburst      ),
.s2_arlock         (apb_s_arlock       ),
.s2_arcache        (apb_s_arcache      ),
.s2_arprot         (apb_s_arprot       ),
.s2_arvalid        (apb_s_arvalid      ),
.s2_arready        (apb_s_arready      ),
.s2_rid            (apb_s_rid          ),
.s2_rdata          (apb_s_rdata        ),
.s2_rresp          (apb_s_rresp        ),
.s2_rlast          (apb_s_rlast        ),
.s2_rvalid         (apb_s_rvalid       ),
.s2_rready         (apb_s_rready       ),

.s3_awid           (conf_s_awid         ),
.s3_awaddr         (conf_s_awaddr       ),
.s3_awlen          (conf_s_awlen        ),
.s3_awsize         (conf_s_awsize       ),
.s3_awburst        (conf_s_awburst      ),
.s3_awlock         (conf_s_awlock       ),
.s3_awcache        (conf_s_awcache      ),
.s3_awprot         (conf_s_awprot       ),
.s3_awvalid        (conf_s_awvalid      ),
.s3_awready        (conf_s_awready      ),
.s3_wid            (conf_s_wid          ),
.s3_wdata          (conf_s_wdata        ),
.s3_wstrb          (conf_s_wstrb        ),
.s3_wlast          (conf_s_wlast        ),
.s3_wvalid         (conf_s_wvalid       ),
.s3_wready         (conf_s_wready       ),
.s3_bid            (conf_s_bid          ),
.s3_bresp          (conf_s_bresp        ),
.s3_bvalid         (conf_s_bvalid       ),
.s3_bready         (conf_s_bready       ),
.s3_arid           (conf_s_arid         ),
.s3_araddr         (conf_s_araddr       ),
.s3_arlen          (conf_s_arlen        ),
.s3_arsize         (conf_s_arsize       ),
.s3_arburst        (conf_s_arburst      ),
.s3_arlock         (conf_s_arlock       ),
.s3_arcache        (conf_s_arcache      ),
.s3_arprot         (conf_s_arprot       ),
.s3_arvalid        (conf_s_arvalid      ),
.s3_arready        (conf_s_arready      ),
.s3_rid            (conf_s_rid          ),
.s3_rdata          (conf_s_rdata        ),
.s3_rresp          (conf_s_rresp        ),
.s3_rlast          (conf_s_rlast        ),
.s3_rvalid         (conf_s_rvalid       ),
.s3_rready         (conf_s_rready       ),

.s4_awid           (mac_s_awid         ),
.s4_awaddr         (mac_s_awaddr       ),
.s4_awlen          (mac_s_awlen        ),
.s4_awsize         (mac_s_awsize       ),
.s4_awburst        (mac_s_awburst      ),
.s4_awlock         (mac_s_awlock       ),
.s4_awcache        (mac_s_awcache      ),
.s4_awprot         (mac_s_awprot       ),
.s4_awvalid        (mac_s_awvalid      ),
.s4_awready        (mac_s_awready      ),
.s4_wid            (mac_s_wid          ),
.s4_wdata          (mac_s_wdata        ),
.s4_wstrb          (mac_s_wstrb        ),
.s4_wlast          (mac_s_wlast        ),
.s4_wvalid         (mac_s_wvalid       ),
.s4_wready         (mac_s_wready       ),
.s4_bid            (mac_s_bid          ),
.s4_bresp          (mac_s_bresp        ),
.s4_bvalid         (mac_s_bvalid       ),
.s4_bready         (mac_s_bready       ),
.s4_arid           (mac_s_arid         ),
.s4_araddr         (mac_s_araddr       ),
.s4_arlen          (mac_s_arlen        ),
.s4_arsize         (mac_s_arsize       ),
.s4_arburst        (mac_s_arburst      ),
.s4_arlock         (mac_s_arlock       ),
.s4_arcache        (mac_s_arcache      ),
.s4_arprot         (mac_s_arprot       ),
.s4_arvalid        (mac_s_arvalid      ),
.s4_arready        (mac_s_arready      ),
.s4_rid            (mac_s_rid          ),
.s4_rdata          (mac_s_rdata        ),
.s4_rresp          (mac_s_rresp        ),
.s4_rlast          (mac_s_rlast        ),
.s4_rvalid         (mac_s_rvalid       ),
.s4_rready         (mac_s_rready       ),

.axi_s_aclk        (aclk                )
);

//SPI
spi_flash_ctrl SPI                    
(                                         
.aclk           (aclk              ),       
.aresetn        (aresetn           ),       
.spi_addr       (16'h1fe8          ),
.fast_startup   (1'b0              ),
.s_awid         (spi_s_awid        ),
.s_awaddr       (spi_s_awaddr      ),
.s_awlen        (spi_s_awlen       ),
.s_awsize       (spi_s_awsize      ),
.s_awburst      (spi_s_awburst     ),
.s_awlock       (spi_s_awlock      ),
.s_awcache      (spi_s_awcache     ),
.s_awprot       (spi_s_awprot      ),
.s_awvalid      (spi_s_awvalid     ),
.s_awready      (spi_s_awready     ),
.s_wready       (spi_s_wready      ),
.s_wid          (spi_s_wid         ),
.s_wdata        (spi_s_wdata       ),
.s_wstrb        (spi_s_wstrb       ),
.s_wlast        (spi_s_wlast       ),
.s_wvalid       (spi_s_wvalid      ),
.s_bid          (spi_s_bid         ),
.s_bresp        (spi_s_bresp       ),
.s_bvalid       (spi_s_bvalid      ),
.s_bready       (spi_s_bready      ),
.s_arid         (spi_s_arid        ),
.s_araddr       (spi_s_araddr      ),
.s_arlen        (spi_s_arlen       ),
.s_arsize       (spi_s_arsize      ),
.s_arburst      (spi_s_arburst     ),
.s_arlock       (spi_s_arlock      ),
.s_arcache      (spi_s_arcache     ),
.s_arprot       (spi_s_arprot      ),
.s_arvalid      (spi_s_arvalid     ),
.s_arready      (spi_s_arready     ),
.s_rready       (spi_s_rready      ),
.s_rid          (spi_s_rid         ),
.s_rdata        (spi_s_rdata       ),
.s_rresp        (spi_s_rresp       ),
.s_rlast        (spi_s_rlast       ),
.s_rvalid       (spi_s_rvalid      ),

.power_down_req (1'b0              ),
.power_down_ack (                  ),
.csn_o          (spi_csn_o         ),
.csn_en         (spi_csn_en        ), 
.sck_o          (spi_sck_o         ),
.sdo_i          (spi_sdo_i         ),
.sdo_o          (spi_sdo_o         ),
.sdo_en         (spi_sdo_en        ), // active low
.sdi_i          (spi_sdi_i         ),
.sdi_o          (spi_sdi_o         ),
.sdi_en         (spi_sdi_en        ),
.inta_o         (spi_inta_o        )
);

//confreg
confreg CONFREG(
.aclk              (aclk               ),       
.aresetn           (aresetn            ),       
.s_awid            (conf_s_awid        ),
.s_awaddr          (conf_s_awaddr      ),
.s_awlen           (conf_s_awlen       ),
.s_awsize          (conf_s_awsize      ),
.s_awburst         (conf_s_awburst     ),
.s_awlock          (conf_s_awlock      ),
.s_awcache         (conf_s_awcache     ),
.s_awprot          (conf_s_awprot      ),
.s_awvalid         (conf_s_awvalid     ),
.s_awready         (conf_s_awready     ),
.s_wready          (conf_s_wready      ),
.s_wid             (conf_s_wid         ),
.s_wdata           (conf_s_wdata       ),
.s_wstrb           (conf_s_wstrb       ),
.s_wlast           (conf_s_wlast       ),
.s_wvalid          (conf_s_wvalid      ),
.s_bid             (conf_s_bid         ),
.s_bresp           (conf_s_bresp       ),
.s_bvalid          (conf_s_bvalid      ),
.s_bready          (conf_s_bready      ),
.s_arid            (conf_s_arid        ),
.s_araddr          (conf_s_araddr      ),
.s_arlen           (conf_s_arlen       ),
.s_arsize          (conf_s_arsize      ),
.s_arburst         (conf_s_arburst     ),
.s_arlock          (conf_s_arlock      ),
.s_arcache         (conf_s_arcache     ),
.s_arprot          (conf_s_arprot      ),
.s_arvalid         (conf_s_arvalid     ),
.s_arready         (conf_s_arready     ),
.s_rready          (conf_s_rready      ),
.s_rid             (conf_s_rid         ),
.s_rdata           (conf_s_rdata       ),
.s_rresp           (conf_s_rresp       ),
.s_rlast           (conf_s_rlast       ),
.s_rvalid          (conf_s_rvalid      ),

//dma
.order_addr_reg    (order_addr_in      ),
.write_dma_end     (write_dma_end      ),
.finish_read_order (finish_read_order  ),

//cr00~cr07
.cr00              (cr00        ),
.cr01              (cr01        ),
.cr02              (cr02        ),
.cr03              (cr03        ),
.cr04              (cr04        ),
.cr05              (cr05        ),
.cr06              (cr06        ),
.cr07              (cr07        ),

.led               (led         ),
.led_rg0           (led_rg0     ),
.led_rg1           (led_rg1     ),
.num_csn           (num_csn     ),
.num_a_g           (num_a_g     ),
.switch            (switch      ),
.btn_key_col       (btn_key_col ),
.btn_key_row       (btn_key_row ),
.btn_step          (btn_step    )
);

//MAC top
ethernet_top ETHERNET_TOP(

    .hclk       (aclk   ),
    .hrst_      (aresetn),      
    //axi master
    .mawid_o    (mac_m_awid    ),
    .mawaddr_o  (mac_m_awaddr  ),
    .mawlen_o   (mac_m_awlen   ),
    .mawsize_o  (mac_m_awsize  ),
    .mawburst_o (mac_m_awburst ),
    .mawlock_o  (mac_m_awlock  ),
    .mawcache_o (mac_m_awcache ),
    .mawprot_o  (mac_m_awprot  ),
    .mawvalid_o (mac_m_awvalid ),
    .mawready_i (mac_m_awready ),
    .mwid_o     (mac_m_wid     ),
    .mwdata_o   (mac_m_wdata   ),
    .mwstrb_o   (mac_m_wstrb   ),
    .mwlast_o   (mac_m_wlast   ),
    .mwvalid_o  (mac_m_wvalid  ),
    .mwready_i  (mac_m_wready  ),
    .mbid_i     (mac_m_bid     ),
    .mbresp_i   (mac_m_bresp   ),
    .mbvalid_i  (mac_m_bvalid  ),
    .mbready_o  (mac_m_bready  ),
    .marid_o    (mac_m_arid    ),
    .maraddr_o  (mac_m_araddr  ),
    .marlen_o   (mac_m_arlen   ),
    .marsize_o  (mac_m_arsize  ),
    .marburst_o (mac_m_arburst ),
    .marlock_o  (mac_m_arlock  ),
    .marcache_o (mac_m_arcache ),
    .marprot_o  (mac_m_arprot  ),
    .marvalid_o (mac_m_arvalid ),
    .marready_i (mac_m_arready ),
    .mrid_i     (mac_m_rid     ),
    .mrdata_i   (mac_m_rdata   ),
    .mrresp_i   (mac_m_rresp   ),
    .mrlast_i   (mac_m_rlast   ),
    .mrvalid_i  (mac_m_rvalid  ),
    .mrready_o  (mac_m_rready  ),
    //axi slaver
    .sawid_i    (mac_s_awid    ),
    .sawaddr_i  (mac_s_awaddr  ),
    .sawlen_i   (mac_s_awlen   ),
    .sawsize_i  (mac_s_awsize  ),
    .sawburst_i (mac_s_awburst ),
    .sawlock_i  (mac_s_awlock  ),
    .sawcache_i (mac_s_awcache ),
    .sawprot_i  (mac_s_awprot  ),
    .sawvalid_i (mac_s_awvalid ),
    .sawready_o (mac_s_awready ),   
    .swid_i     (mac_s_wid     ),
    .swdata_i   (mac_s_wdata   ),
    .swstrb_i   (mac_s_wstrb   ),
    .swlast_i   (mac_s_wlast   ),
    .swvalid_i  (mac_s_wvalid  ),
    .swready_o  (mac_s_wready  ),
    .sbid_o     (mac_s_bid     ),
    .sbresp_o   (mac_s_bresp   ),
    .sbvalid_o  (mac_s_bvalid  ),
    .sbready_i  (mac_s_bready  ),
    .sarid_i    (mac_s_arid    ),
    .saraddr_i  (mac_s_araddr  ),
    .sarlen_i   (mac_s_arlen   ),
    .sarsize_i  (mac_s_arsize  ),
    .sarburst_i (mac_s_arburst ),
    .sarlock_i  (mac_s_arlock  ),
    .sarcache_i (mac_s_arcache ),
    .sarprot_i  (mac_s_arprot  ),
    .sarvalid_i (mac_s_arvalid ),
    .sarready_o (mac_s_arready ),
    .srid_o     (mac_s_rid     ),
    .srdata_o   (mac_s_rdata   ),
    .srresp_o   (mac_s_rresp   ),
    .srlast_o   (mac_s_rlast   ),
    .srvalid_o  (mac_s_rvalid  ),
    .srready_i  (mac_s_rready  ),                 

    .interrupt_0 (mac_int),
 
    // I/O pad interface signals
    //TX
    .mtxclk_0    (mtxclk_0 ),     
    .mtxen_0     (mtxen_0  ),      
    .mtxd_0      (mtxd_0   ),       
    .mtxerr_0    (mtxerr_0 ),
    //RX
    .mrxclk_0    (mrxclk_0 ),      
    .mrxdv_0     (mrxdv_0  ),     
    .mrxd_0      (mrxd_0   ),        
    .mrxerr_0    (mrxerr_0 ),
    .mcoll_0     (mcoll_0  ),
    .mcrs_0      (mcrs_0   ),
    // MIIM
    .mdc_0       (mdc_0    ),
    .md_i_0      (md_i_0   ),
    .md_o_0      (md_o_0   ),       
    .md_oe_0     (md_oe_0  )

);

//ddr3
wire   c1_sys_clk_i;
wire   c1_clk_ref_i;
wire   c1_sys_rst_i;
wire   c1_calib_done;
wire   c1_clk0;
wire   c1_rst0;
wire        ddr_aresetn;
reg         interconnect_aresetn;

clk_pll_33  clk_pll_33
 (
  // Clock out ports
  .clk_out1(cpu_clk),  //50MHz
  .clk_out2(uncore_clk), //33MHz
 // Clock in ports
  .clk_in1(clk)        //100MHz
 );

clk_wiz_0  clk_pll_1
(
    .clk_out1(c1_clk_ref_i),  //200MHz
    .clk_in1(clk)             //100MHz
);

assign c1_sys_clk_i      = clk;
assign c1_sys_rst_i      = resetn;
assign aclk              = uncore_clk;
//assign aclk              = c1_clk0;
// Reset to the AXI shim
reg c1_calib_done_0;
reg c1_calib_done_1;
reg c1_rst0_0;
reg c1_rst0_1;
reg interconnect_aresetn_0;
/*always @(posedge aclk)
begin
    c1_calib_done_0 <= c1_calib_done;
    c1_calib_done_1 <= c1_calib_done_0;
    c1_rst0_0       <= c1_rst0;
    c1_rst0_1       <= c1_rst0_0;

    interconnect_aresetn_0 <= ~c1_rst0_1 && c1_calib_done_1;
    interconnect_aresetn   <= interconnect_aresetn_0 ;
end*/
always @(posedge c1_clk0)
begin
    interconnect_aresetn <= ~c1_rst0 && c1_calib_done;
end

//axi 3x1
axi_interconnect_0 mig_axi_interconnect (
    .INTERCONNECT_ACLK    (c1_clk0             ),
    .INTERCONNECT_ARESETN (interconnect_aresetn),
    .S00_AXI_ARESET_OUT_N (aresetn             ),
    .S00_AXI_ACLK         (aclk                ),
    .S00_AXI_AWID         (s0_awid[3:0]        ),
    .S00_AXI_AWADDR       (s0_awaddr           ),
    .S00_AXI_AWLEN        ({4'b0,s0_awlen}     ),
    .S00_AXI_AWSIZE       (s0_awsize           ),
    .S00_AXI_AWBURST      (s0_awburst          ),
    .S00_AXI_AWLOCK       (s0_awlock[0:0]      ),
    .S00_AXI_AWCACHE      (s0_awcache          ),
    .S00_AXI_AWPROT       (s0_awprot           ),
    .S00_AXI_AWQOS        (4'b0                ),
    .S00_AXI_AWVALID      (s0_awvalid          ),
    .S00_AXI_AWREADY      (s0_awready          ),
    .S00_AXI_WDATA        (s0_wdata            ),
    .S00_AXI_WSTRB        (s0_wstrb            ),
    .S00_AXI_WLAST        (s0_wlast            ),
    .S00_AXI_WVALID       (s0_wvalid           ),
    .S00_AXI_WREADY       (s0_wready           ),
    .S00_AXI_BID          (s0_bid[3:0]         ),
    .S00_AXI_BRESP        (s0_bresp            ),
    .S00_AXI_BVALID       (s0_bvalid           ),
    .S00_AXI_BREADY       (s0_bready           ),
    .S00_AXI_ARID         (s0_arid[3:0]        ),
    .S00_AXI_ARADDR       (s0_araddr           ),
    .S00_AXI_ARLEN        ({4'b0,s0_arlen}     ),
    .S00_AXI_ARSIZE       (s0_arsize           ),
    .S00_AXI_ARBURST      (s0_arburst          ),
    .S00_AXI_ARLOCK       (s0_arlock[0:0]      ),
    .S00_AXI_ARCACHE      (s0_arcache          ),
    .S00_AXI_ARPROT       (s0_arprot           ),
    .S00_AXI_ARQOS        (4'b0                ),
    .S00_AXI_ARVALID      (s0_arvalid          ),
    .S00_AXI_ARREADY      (s0_arready          ),
    .S00_AXI_RID          (s0_rid[3:0]         ),
    .S00_AXI_RDATA        (s0_rdata            ),
    .S00_AXI_RRESP        (s0_rresp            ),
    .S00_AXI_RLAST        (s0_rlast            ),
    .S00_AXI_RVALID       (s0_rvalid           ),
    .S00_AXI_RREADY       (s0_rready           ),

    .S01_AXI_ARESET_OUT_N (                    ),
    .S01_AXI_ACLK         (aclk                ),
    .S01_AXI_AWID         (mac_m_awid[3:0]     ),
    .S01_AXI_AWADDR       (mac_m_awaddr        ),
    .S01_AXI_AWLEN        ({4'b0,mac_m_awlen}  ),
    .S01_AXI_AWSIZE       (mac_m_awsize        ),
    .S01_AXI_AWBURST      (mac_m_awburst       ),
    .S01_AXI_AWLOCK       (mac_m_awlock[0:0]   ),
    .S01_AXI_AWCACHE      (mac_m_awcache       ),
    .S01_AXI_AWPROT       (mac_m_awprot        ),
    .S01_AXI_AWQOS        (4'b0                ),
    .S01_AXI_AWVALID      (mac_m_awvalid       ),
    .S01_AXI_AWREADY      (mac_m_awready       ),
    .S01_AXI_WDATA        (mac_m_wdata         ),
    .S01_AXI_WSTRB        (mac_m_wstrb         ),
    .S01_AXI_WLAST        (mac_m_wlast         ),
    .S01_AXI_WVALID       (mac_m_wvalid        ),
    .S01_AXI_WREADY       (mac_m_wready        ),
    .S01_AXI_BID          (mac_m_bid[3:0]      ),
    .S01_AXI_BRESP        (mac_m_bresp         ),
    .S01_AXI_BVALID       (mac_m_bvalid        ),
    .S01_AXI_BREADY       (mac_m_bready        ),
    .S01_AXI_ARID         (mac_m_arid[3:0]     ),
    .S01_AXI_ARADDR       (mac_m_araddr        ),
    .S01_AXI_ARLEN        ({4'b0,mac_m_arlen}  ),
    .S01_AXI_ARSIZE       (mac_m_arsize        ),
    .S01_AXI_ARBURST      (mac_m_arburst       ),
    .S01_AXI_ARLOCK       (mac_m_arlock[0:0]   ),
    .S01_AXI_ARCACHE      (mac_m_arcache       ),
    .S01_AXI_ARPROT       (mac_m_arprot        ),
    .S01_AXI_ARQOS        (4'b0                ),
    .S01_AXI_ARVALID      (mac_m_arvalid       ),
    .S01_AXI_ARREADY      (mac_m_arready       ),
    .S01_AXI_RID          (mac_m_rid[3:0]      ),
    .S01_AXI_RDATA        (mac_m_rdata         ),
    .S01_AXI_RRESP        (mac_m_rresp         ),
    .S01_AXI_RLAST        (mac_m_rlast         ),
    .S01_AXI_RVALID       (mac_m_rvalid        ),
    .S01_AXI_RREADY       (mac_m_rready        ),

    .S02_AXI_ARESET_OUT_N (                    ),
    .S02_AXI_ACLK         (aclk                ),
    .S02_AXI_AWID         (dma0_awid           ),
    .S02_AXI_AWADDR       (dma0_awaddr         ),
    .S02_AXI_AWLEN        ({4'd0,dma0_awlen}   ),
    .S02_AXI_AWSIZE       (dma0_awsize         ),
    .S02_AXI_AWBURST      (dma0_awburst        ),
    .S02_AXI_AWLOCK       (dma0_awlock[0:0]    ),
    .S02_AXI_AWCACHE      (dma0_awcache        ),
    .S02_AXI_AWPROT       (dma0_awprot         ),
    .S02_AXI_AWQOS        (4'b0                ),
    .S02_AXI_AWVALID      (dma0_awvalid        ),
    .S02_AXI_AWREADY      (dma0_awready        ),
    .S02_AXI_WDATA        (dma0_wdata          ),
    .S02_AXI_WSTRB        (dma0_wstrb          ),
    .S02_AXI_WLAST        (dma0_wlast          ),
    .S02_AXI_WVALID       (dma0_wvalid         ),
    .S02_AXI_WREADY       (dma0_wready         ),
    .S02_AXI_BID          (dma0_bid            ),
    .S02_AXI_BRESP        (dma0_bresp          ),
    .S02_AXI_BVALID       (dma0_bvalid         ),
    .S02_AXI_BREADY       (dma0_bready         ),
    .S02_AXI_ARID         (dma0_arid           ),
    .S02_AXI_ARADDR       (dma0_araddr         ),
    .S02_AXI_ARLEN        ({4'd0,dma0_arlen}   ),
    .S02_AXI_ARSIZE       (dma0_arsize         ),
    .S02_AXI_ARBURST      (dma0_arburst        ),
    .S02_AXI_ARLOCK       (dma0_arlock[0:0]    ),
    .S02_AXI_ARCACHE      (dma0_arcache        ),
    .S02_AXI_ARPROT       (dma0_arprot         ),
    .S02_AXI_ARQOS        (4'b0                ),
    .S02_AXI_ARVALID      (dma0_arvalid        ),
    .S02_AXI_ARREADY      (dma0_arready        ),
    .S02_AXI_RID          (dma0_rid            ),
    .S02_AXI_RDATA        (dma0_rdata          ),
    .S02_AXI_RRESP        (dma0_rresp          ),
    .S02_AXI_RLAST        (dma0_rlast          ),
    .S02_AXI_RVALID       (dma0_rvalid         ),
    .S02_AXI_RREADY       (dma0_rready         ),

    .M00_AXI_ARESET_OUT_N (ddr_aresetn         ),
    .M00_AXI_ACLK         (c1_clk0             ),
    .M00_AXI_AWID         (mig_awid            ),
    .M00_AXI_AWADDR       (mig_awaddr          ),
    .M00_AXI_AWLEN        ({mig_awlen}         ),
    .M00_AXI_AWSIZE       (mig_awsize          ),
    .M00_AXI_AWBURST      (mig_awburst         ),
    .M00_AXI_AWLOCK       (mig_awlock[0:0]     ),
    .M00_AXI_AWCACHE      (mig_awcache         ),
    .M00_AXI_AWPROT       (mig_awprot          ),
    .M00_AXI_AWQOS        (                    ),
    .M00_AXI_AWVALID      (mig_awvalid         ),
    .M00_AXI_AWREADY      (mig_awready         ),
    .M00_AXI_WDATA        (mig_wdata           ),
    .M00_AXI_WSTRB        (mig_wstrb           ),
    .M00_AXI_WLAST        (mig_wlast           ),
    .M00_AXI_WVALID       (mig_wvalid          ),
    .M00_AXI_WREADY       (mig_wready          ),
    .M00_AXI_BID          (mig_bid             ),
    .M00_AXI_BRESP        (mig_bresp           ),
    .M00_AXI_BVALID       (mig_bvalid          ),
    .M00_AXI_BREADY       (mig_bready          ),
    .M00_AXI_ARID         (mig_arid            ),
    .M00_AXI_ARADDR       (mig_araddr          ),
    .M00_AXI_ARLEN        ({mig_arlen}         ),
    .M00_AXI_ARSIZE       (mig_arsize          ),
    .M00_AXI_ARBURST      (mig_arburst         ),
    .M00_AXI_ARLOCK       (mig_arlock[0:0]     ),
    .M00_AXI_ARCACHE      (mig_arcache         ),
    .M00_AXI_ARPROT       (mig_arprot          ),
    .M00_AXI_ARQOS        (                    ),
    .M00_AXI_ARVALID      (mig_arvalid         ),
    .M00_AXI_ARREADY      (mig_arready         ),
    .M00_AXI_RID          (mig_rid             ),
    .M00_AXI_RDATA        (mig_rdata           ),
    .M00_AXI_RRESP        (mig_rresp           ),
    .M00_AXI_RLAST        (mig_rlast           ),
    .M00_AXI_RVALID       (mig_rvalid          ),
    .M00_AXI_RREADY       (mig_rready          )
);
//ddr3 controller
mig_axi_32 mig_axi (
    // Inouts
    .ddr3_dq             (ddr3_dq         ),  
    .ddr3_dqs_p          (ddr3_dqs_p      ),    // for X16 parts 
    .ddr3_dqs_n          (ddr3_dqs_n      ),  // for X16 parts
    // Outputs
    .ddr3_addr           (ddr3_addr       ),  
    .ddr3_ba             (ddr3_ba         ),
    .ddr3_ras_n          (ddr3_ras_n      ),                        
    .ddr3_cas_n          (ddr3_cas_n      ),                        
    .ddr3_we_n           (ddr3_we_n       ),                          
    .ddr3_reset_n        (ddr3_reset_n    ),
    .ddr3_ck_p           (ddr3_ck_p       ),                          
    .ddr3_ck_n           (ddr3_ck_n       ),       
    .ddr3_cke            (ddr3_cke        ),                          
    .ddr3_dm             (ddr3_dm         ),
    .ddr3_odt            (ddr3_odt        ),
    
	.ui_clk              (c1_clk0         ),
    .ui_clk_sync_rst     (c1_rst0         ),
 
    .sys_clk_i           (c1_sys_clk_i    ),
    .sys_rst             (c1_sys_rst_i    ),                        
    .init_calib_complete (c1_calib_done   ),
    .clk_ref_i           (c1_clk_ref_i    ),
    .mmcm_locked         (                ),
	
	.app_sr_active       (                ),
    .app_ref_ack         (                ),
    .app_zq_ack          (                ),
    .app_sr_req          (1'b0            ),
    .app_ref_req         (1'b0            ),
    .app_zq_req          (1'b0            ),
    
    .aresetn             (ddr_aresetn     ),
    .s_axi_awid          (mig_awid        ),
    .s_axi_awaddr        (mig_awaddr[26:0]),
    .s_axi_awlen         ({mig_awlen}     ),
    .s_axi_awsize        (mig_awsize      ),
    .s_axi_awburst       (mig_awburst     ),
    .s_axi_awlock        (mig_awlock[0:0] ),
    .s_axi_awcache       (mig_awcache     ),
    .s_axi_awprot        (mig_awprot      ),
    .s_axi_awqos         (4'b0            ),
    .s_axi_awvalid       (mig_awvalid     ),
    .s_axi_awready       (mig_awready     ),
    .s_axi_wdata         (mig_wdata       ),
    .s_axi_wstrb         (mig_wstrb       ),
    .s_axi_wlast         (mig_wlast       ),
    .s_axi_wvalid        (mig_wvalid      ),
    .s_axi_wready        (mig_wready      ),
    .s_axi_bid           (mig_bid         ),
    .s_axi_bresp         (mig_bresp       ),
    .s_axi_bvalid        (mig_bvalid      ),
    .s_axi_bready        (mig_bready      ),
    .s_axi_arid          (mig_arid        ),
    .s_axi_araddr        (mig_araddr[26:0]),
    .s_axi_arlen         ({mig_arlen}     ),
    .s_axi_arsize        (mig_arsize      ),
    .s_axi_arburst       (mig_arburst     ),
    .s_axi_arlock        (mig_arlock[0:0] ),
    .s_axi_arcache       (mig_arcache     ),
    .s_axi_arprot        (mig_arprot      ),
    .s_axi_arqos         (4'b0            ),
    .s_axi_arvalid       (mig_arvalid     ),
    .s_axi_arready       (mig_arready     ),
    .s_axi_rid           (mig_rid         ),
    .s_axi_rdata         (mig_rdata       ),
    .s_axi_rresp         (mig_rresp       ),
    .s_axi_rlast         (mig_rlast       ),
    .s_axi_rvalid        (mig_rvalid      ),
    .s_axi_rready        (mig_rready      )
);

//DMA
dma_master DMA_MASTER0
(
.clk                (aclk                   ),
.rst_n		        (aresetn                ),
.awid               (dma0_awid              ), 
.awaddr             (dma0_awaddr            ), 
.awlen              (dma0_awlen             ), 
.awsize             (dma0_awsize            ), 
.awburst            (dma0_awburst           ),
.awlock             (dma0_awlock            ), 
.awcache            (dma0_awcache           ), 
.awprot             (dma0_awprot            ), 
.awvalid            (dma0_awvalid           ), 
.awready            (dma0_awready           ), 
.wid                (dma0_wid               ), 
.wdata              (dma0_wdata             ), 
.wstrb              (dma0_wstrb             ), 
.wlast              (dma0_wlast             ), 
.wvalid             (dma0_wvalid            ), 
.wready             (dma0_wready            ),
.bid                (dma0_bid               ), 
.bresp              (dma0_bresp             ), 
.bvalid             (dma0_bvalid            ), 
.bready             (dma0_bready            ),
.arid               (dma0_arid              ), 
.araddr             (dma0_araddr            ), 
.arlen              (dma0_arlen             ), 
.arsize             (dma0_arsize            ), 
.arburst            (dma0_arburst           ), 
.arlock             (dma0_arlock            ), 
.arcache            (dma0_arcache           ),
.arprot             (dma0_arprot            ),
.arvalid            (dma0_arvalid           ), 
.arready            (dma0_arready           ),
.rid                (dma0_rid               ), 
.rdata              (dma0_rdata             ), 
.rresp              (dma0_rresp             ),
.rlast              (dma0_rlast             ), 
.rvalid             (dma0_rvalid            ), 
.rready             (dma0_rready            ),

.dma_int            (dma_int                ), 
.dma_req_in         (dma_req                ), 
.dma_ack_out        (dma_ack                ), 

.dma_gnt            (dma0_gnt               ),
.apb_rw             (apb_rw_dma0            ),
.apb_psel           (apb_psel_dma0          ),
.apb_valid_req      (apb_start_dma0	        ),
.apb_penable        (apb_penable_dma0       ),
.apb_addr           (apb_addr_dma0          ),
.apb_wdata          (apb_wdata_dma0         ),
.apb_rdata          (apb_rdata_dma0         ),

.order_addr_in      (order_addr_in          ),
.write_dma_end      (write_dma_end          ),
.finish_read_order  (finish_read_order      ) 
);

//AXI2APB
axi2apb_misc APB_DEV 
(
.clk                (aclk               ),
.rst_n              (aresetn            ),

.axi_s_awid         (apb_s_awid         ),
.axi_s_awaddr       (apb_s_awaddr       ),
.axi_s_awlen        (apb_s_awlen        ),
.axi_s_awsize       (apb_s_awsize       ),
.axi_s_awburst      (apb_s_awburst      ),
.axi_s_awlock       (apb_s_awlock       ),
.axi_s_awcache      (apb_s_awcache      ),
.axi_s_awprot       (apb_s_awprot       ),
.axi_s_awvalid      (apb_s_awvalid      ),
.axi_s_awready      (apb_s_awready      ),
.axi_s_wid          (apb_s_wid          ),
.axi_s_wdata        (apb_s_wdata        ),
.axi_s_wstrb        (apb_s_wstrb        ),
.axi_s_wlast        (apb_s_wlast        ),
.axi_s_wvalid       (apb_s_wvalid       ),
.axi_s_wready       (apb_s_wready       ),
.axi_s_bid          (apb_s_bid          ),
.axi_s_bresp        (apb_s_bresp        ),
.axi_s_bvalid       (apb_s_bvalid       ),
.axi_s_bready       (apb_s_bready       ),
.axi_s_arid         (apb_s_arid         ),
.axi_s_araddr       (apb_s_araddr       ),
.axi_s_arlen        (apb_s_arlen        ),
.axi_s_arsize       (apb_s_arsize       ),
.axi_s_arburst      (apb_s_arburst      ),
.axi_s_arlock       (apb_s_arlock       ),
.axi_s_arcache      (apb_s_arcache      ),
.axi_s_arprot       (apb_s_arprot       ),
.axi_s_arvalid      (apb_s_arvalid      ),
.axi_s_arready      (apb_s_arready      ),
.axi_s_rid          (apb_s_rid          ),
.axi_s_rdata        (apb_s_rdata        ),
.axi_s_rresp        (apb_s_rresp        ),
.axi_s_rlast        (apb_s_rlast        ),
.axi_s_rvalid       (apb_s_rvalid       ),
.axi_s_rready       (apb_s_rready       ),

.apb_rw_dma         (apb_rw_dma0        ),
.apb_psel_dma       (apb_psel_dma0      ),
.apb_enab_dma       (apb_penable_dma0   ),
.apb_addr_dma       (apb_addr_dma0[19:0]),
.apb_valid_dma      (apb_start_dma0     ),
.apb_wdata_dma      (apb_wdata_dma0     ),
.apb_rdata_dma      (apb_rdata_dma0     ),
.apb_ready_dma      (                   ), //output, no use
.dma_grant          (dma0_gnt           ),

.dma_req_o          (dma_req            ),
.dma_ack_i          (dma_ack            ),

//UART0
.uart0_txd_i        (uart0_txd_i      ),
.uart0_txd_o        (uart0_txd_o      ),
.uart0_txd_oe       (uart0_txd_oe     ),
.uart0_rxd_i        (uart0_rxd_i      ),
.uart0_rxd_o        (uart0_rxd_o      ),
.uart0_rxd_oe       (uart0_rxd_oe     ),
.uart0_rts_o        (uart0_rts_o      ),
.uart0_dtr_o        (uart0_dtr_o      ),
.uart0_cts_i        (uart0_cts_i      ),
.uart0_dsr_i        (uart0_dsr_i      ),
.uart0_dcd_i        (uart0_dcd_i      ),
.uart0_ri_i         (uart0_ri_i       ),
.uart0_int          (uart0_int        ),

.nand_type          (2'h2             ),  //1Gbit
.nand_cle           (nand_cle         ),
.nand_ale           (nand_ale         ),
.nand_rdy           (nand_rdy         ),
.nand_rd            (nand_rd          ),
.nand_ce            (nand_ce          ),
.nand_wr            (nand_wr          ),
.nand_dat_i         (nand_dat_i       ),
.nand_dat_o         (nand_dat_o       ),
.nand_dat_oe        (nand_dat_oe      ),

.nand_int           (nand_int         )
);
endmodule

module debug_top(
     input           sys_clk,            
     input           sys_rst_n,          
     input           uart_rxd,
     input[31:0]     debug_wb_pc,
     input[ 4:0]     debug_wb_rf_wnum,
     input[31:0]     debug_wb_rf_wdata,
     input           ws_valid,
     output          break_point,
     output          infor_flag,
     output[ 4:0]    reg_num,
     input [31:0]    rf_rdata,
     output          infom_flag,
     output[31:0]    start_addr,
     input           mem_flag,
     input[ 7:0]     mem_rdata,   
     output          uart_txd          
     );
 
  //parameter define
parameter  CLK_FREQ = 50000000;         
parameter  UART_BPS = 9600;          
    
//wire define   
wire       uart_recv_done;              
wire [7:0] uart_recv_data;              
wire       uart_send_en;                
wire [7:0] uart_send_data;             
wire       uart_tx_busy;                


uart_recv u_uart_recv(                 
    .sys_clk        (sys_clk), 
    .sys_rst_n      (sys_rst_n),
    
    .uart_rxd       (uart_rxd),
    .uart_done      (uart_recv_done),
    .uart_data      (uart_recv_data)
    );

  
uart_send  u_uart_send(                 
    .sys_clk        (sys_clk),
    .sys_rst_n      (sys_rst_n),
    
    .uart_en        (uart_send_en),
    .uart_din       (uart_send_data),
    .uart_tx_busy   (uart_tx_busy),
    .uart_txd       (uart_txd)
    );
    
  
trace_debug u_trace_debug(
    .sys_clk        (sys_clk),             
    .sys_rst_n      (sys_rst_n),           

    .recv_done      (uart_recv_done),   
    .recv_data      (uart_recv_data),

    .debug_wb_pc      (debug_wb_pc      ),
    .debug_wb_rf_wnum (debug_wb_rf_wnum ),
    .debug_wb_rf_wdata(debug_wb_rf_wdata),
    .ws_valid         (ws_valid         ),
    .break_point      (break_point      ),
    .infor_flag       (infor_flag       ),
    .reg_num          (reg_num          ),
    .rf_rdata         (rf_rdata         ),
    .infom_flag       (infom_flag       ),
    .start_addr       (start_addr       ),
    .mem_flag         (mem_flag         ),
    .mem_rdata        (mem_rdata        ),
  
    .tx_busy        (uart_tx_busy),           
    .send_en        (uart_send_en),     
    .send_data      (uart_send_data)    
    );
    
endmodule 

module uart_recv(
    input             sys_clk,                  
    input             sys_rst_n,               
     
    input             uart_rxd,                 
    output  reg       uart_done,               
    output  reg [7:0] uart_data               
    );
    
//parameter define
parameter  CLK_FREQ = 50000000;               
parameter  UART_BPS = 9600;                    
localparam  BPS_CNT  = CLK_FREQ/UART_BPS;       
                                                
//reg define
reg        uart_rxd_d0;
reg        uart_rxd_d1;
reg        rx_flag; 
reg [15:0] clk_cnt;                
reg [ 3:0] rx_cnt;                  
reg [ 7:0] rxdata;                             

//wire define
wire       start_flag;

assign  start_flag = uart_rxd_d1 & (~uart_rxd_d0);    

always @(posedge sys_clk or negedge sys_rst_n) begin 
    if (!sys_rst_n) begin 
        uart_rxd_d0 <= 1'b0;
        uart_rxd_d1 <= 1'b0;          
    end
    else begin
        uart_rxd_d0  <= uart_rxd;                   
        uart_rxd_d1  <= uart_rxd_d0;
    end   
end

  
always @(posedge sys_clk or negedge sys_rst_n) begin         
    if (!sys_rst_n)                                  
        rx_flag <= 1'b0;
    else begin
        if(start_flag)                          
            rx_flag <= 1'b1;                    
                                               
        else if((rx_cnt == 4'd9) && (clk_cnt == BPS_CNT/2))
            rx_flag <= 1'b0;                   
            else
               rx_flag <= rx_flag;
    end
end


always @(posedge sys_clk or negedge sys_rst_n) begin         
    if (!sys_rst_n)                             
        clk_cnt <= 16'd0;                                  
    else if ( rx_flag ) begin                   
        if (clk_cnt < BPS_CNT - 1)
            clk_cnt <= clk_cnt + 1'b1;
      else
            clk_cnt <= 16'd0;                   
    end
    else                                            
        clk_cnt <= 16'd0;                       
end


always @(posedge sys_clk or negedge sys_rst_n) begin         
    if (!sys_rst_n)                             
        rx_cnt  <= 4'd0;
    else if ( rx_flag ) begin                   
        if (clk_cnt == BPS_CNT - 1)             
            rx_cnt <= rx_cnt + 1'b1;           
        else
            rx_cnt <= rx_cnt;       
    end
    else
        rx_cnt  <= 4'd0;                        
end


always @(posedge sys_clk or negedge sys_rst_n) begin 
    if ( !sys_rst_n)  
        rxdata <= 8'd0;                                     
    else if(rx_flag)                            
        if (clk_cnt == BPS_CNT/2) begin         
            case ( rx_cnt )
            4'd1 : rxdata[0] <= uart_rxd_d1;   
            4'd2 : rxdata[1] <= uart_rxd_d1;
            4'd3 : rxdata[2] <= uart_rxd_d1;
            4'd4 : rxdata[3] <= uart_rxd_d1;
            4'd5 : rxdata[4] <= uart_rxd_d1;
            4'd6 : rxdata[5] <= uart_rxd_d1;
            4'd7 : rxdata[6] <= uart_rxd_d1;
            4'd8 : rxdata[7] <= uart_rxd_d1;   
           default:;                                    
           endcase
       end
       else 
           rxdata <= rxdata;
    else
        rxdata <= 8'd0;
end


always @(posedge sys_clk or negedge sys_rst_n) begin        
    if (!sys_rst_n) begin
        uart_data <= 8'd0;                               
        uart_done <= 1'b0;
    end
    else if(rx_cnt == 4'd9) begin                         
        uart_data <= rxdata;                    
        uart_done <= 1'b1;                    
    end
    else begin
        uart_data <= 8'd0;                                   
        uart_done <= 1'b0; 
    end    
end

endmodule    

module uart_send(
    input              sys_clk,             
    input              sys_rst_n,           
    input              uart_en,             
    input       [ 7:0] uart_din,            
    output             uart_tx_busy,                   
    output  reg        uart_txd                  
    );
    
//parameter define
parameter  CLK_FREQ = 50000000;             
parameter  UART_BPS = 9600;                 
localparam  BPS_CNT  = CLK_FREQ/UART_BPS;   

//reg define
reg        uart_en_d0; 
reg        uart_en_d1;  
reg        tx_flag;
reg [15:0] clk_cnt;             
reg [ 7:0] tx_data;             
reg [ 3:0] tx_cnt; 

wire       en_flag;                            

assign uart_tx_busy = tx_flag;

assign en_flag = (~uart_en_d1) & uart_en_d0;

always @(posedge sys_clk or negedge sys_rst_n) begin         
    if (!sys_rst_n) begin
        uart_en_d0 <= 1'b0;                                  
        uart_en_d1 <= 1'b0;
    end                                                      
    else begin                                               
        uart_en_d0 <= uart_en;                               
        uart_en_d1 <= uart_en_d0;                            
    end
end


always @(posedge sys_clk or negedge sys_rst_n) begin         
    if (!sys_rst_n) begin                                  
        tx_flag <= 1'b0;
        tx_data <= 8'd0;
    end 
    else if (en_flag) begin                             
            tx_flag <= 1'b1;               
            tx_data <= uart_din;           
        end
                                            
        else if ((tx_cnt == 4'd9) && (clk_cnt == BPS_CNT - (BPS_CNT/16))) begin                                       
            tx_flag <= 1'b0;                
            tx_data <= 8'd0;
        end
        else begin
            tx_flag <= tx_flag;
            tx_data <= tx_data;
        end 
end


always @(posedge sys_clk or negedge sys_rst_n) begin         
    if (!sys_rst_n)                             
        clk_cnt <= 16'd0;                                  
    else if (tx_flag) begin                
        if (clk_cnt < BPS_CNT - 1)
            clk_cnt <= clk_cnt + 1'b1;
        else
            clk_cnt <= 16'd0;               
    end
    else                             
        clk_cnt <= 16'd0;                   
end


always @(posedge sys_clk or negedge sys_rst_n) begin         
    if (!sys_rst_n)                             
        tx_cnt <= 4'd0;
    else if (tx_flag) begin                 
        if (clk_cnt == BPS_CNT - 1)         
            tx_cnt <= tx_cnt + 1'b1;        
        else
            tx_cnt <= tx_cnt;       
    end
    else                              
        tx_cnt  <= 4'd0;                    
end


always @(posedge sys_clk or negedge sys_rst_n) begin        
    if (!sys_rst_n)  
        uart_txd <= 1'b1;        
    else if (tx_flag)
       case(tx_cnt)
           4'd0: uart_txd <= 1'b0;        
           4'd1: uart_txd <= tx_data[0];   
           4'd2: uart_txd <= tx_data[1];
           4'd3: uart_txd <= tx_data[2];
           4'd4: uart_txd <= tx_data[3];
           4'd5: uart_txd <= tx_data[4];
           4'd6: uart_txd <= tx_data[5];
           4'd7: uart_txd <= tx_data[6];
           4'd8: uart_txd <= tx_data[7];   
           4'd9: uart_txd <= 1'b1;         
           default: ;
     endcase
    else 
        uart_txd <= 1'b1;                   
end

endmodule             


/*...........................................................Debug module........................................*/
module trace_debug(
     input            sys_clk,                   
     input            sys_rst_n,                
     
     input            recv_done,                 
     input[7:0]       recv_data,

     input[31:0]      debug_wb_pc,
     input[ 4:0]      debug_wb_rf_wnum,
     input[31:0]      debug_wb_rf_wdata,
     input            ws_valid,
     output           break_point,
     output           infor_flag,
     output[ 4:0]     reg_num, 
     input [31:0]     rf_rdata,

     output           infom_flag,
     output[31:0]     start_addr,
     input            mem_flag,
     input[ 7:0]      mem_rdata,

     input            tx_busy,                      
     output reg       send_en,                   
     output reg [7:0] send_data                  
    );

//reg define
reg recv_done_d0;
reg recv_done_d1;

//wire define
wire recv_done_flag;

assign recv_done_flag = (~recv_done_d1) & recv_done_d0;
                                                
always @(posedge sys_clk or negedge sys_rst_n) begin         
    if (!sys_rst_n) begin
        recv_done_d0 <= 1'b0;                                  
        recv_done_d1 <= 1'b0;
    end                                                      
    else begin                                               
        recv_done_d0 <= recv_done;                               
        recv_done_d1 <= recv_done_d0;                            
    end
end


//receive
reg[31:0] break_pc;
reg[ 4:0] recv_state;
reg       break_flag;
reg       infor_flag_r;
reg[ 7:0] reg_num_r;
reg       infom_flag_r;
reg[31:0] start_addr_r;
reg       step_flag;
reg[31:0] step_pc;
reg[31:0] trace_pc;
reg       trace_flag;
reg       list_flag;
always@(posedge sys_clk or negedge sys_rst_n)begin
    if(!sys_rst_n)begin  
        recv_state  <=5'd0;
        break_flag  <=1'b0;
        break_pc    <=32'd0;
        infor_flag_r<=1'b0;
        reg_num_r   <=8'd0;
        infom_flag_r<=1'b0;
        start_addr_r<=32'd0;
        step_flag   <=1'b0;
        step_pc     <=32'd0;
        trace_pc    <=32'd0;
        trace_flag  <=1'b0;
        list_flag   <=1'b0;
    end
    else begin
        case(recv_state)
        5'd00:begin
            if(recv_done_flag && recv_data==8'd01)begin          //trace
                recv_state<=5'd22;
                trace_flag<=1'b1;  
            end
            if(recv_done_flag && recv_data==8'd02)begin          //break_point
                recv_state<=recv_state+1'b1;
                break_flag<=1'b1;
                step_flag <=1'b0;
                trace_flag<=1'b0;   
            end
            else if(recv_done_flag && recv_data==8'd03)begin    //continue
                recv_state  <=5'd09;
                break_flag  <=1'b0;
                step_flag   <=1'b0;
            end
            else if(recv_done_flag && recv_data==8'd04)begin    //infor
                recv_state<=5'd10;
            end
            else if(recv_done_flag && recv_data==8'd05)begin    //infom
                recv_state<=5'd13;
            end
            else if(recv_done_flag && recv_data==8'd06)begin    //step
                recv_state<=5'd09;
                step_flag <=1'b1;
                break_flag<=1'b0;
                step_pc   <=debug_wb_pc;
            end
            else if(recv_done_flag && recv_data==8'd07)begin   //list
                recv_state<=5'd30;
                list_flag <=1'b1;
            end
        end
        //receive break_point
        5'd01:if(!recv_done_flag)
                recv_state    <=recv_state+1'b1;
        5'd02:begin
            if(recv_done_flag)begin
                break_pc[31:24]<=recv_data;
                recv_state     <=recv_state+1'b1;
            end
        end
        5'd03:if(!recv_done_flag)
                recv_state    <=recv_state+1'b1;
        5'd04:begin
            if(recv_done_flag)begin
                break_pc[23:16]<=recv_data;
                recv_state     <=recv_state+1'b1;
            end
        end
        5'd05:if(!recv_done_flag)
                recv_state   <=recv_state+1'b1;
        5'd06:begin
            if(recv_done_flag)begin
                break_pc[15:8]<=recv_data;
                recv_state    <=recv_state+1'b1;
            end
        end
        5'd07:if(!recv_done_flag)
                recv_state   <=recv_state+1'b1;
        5'd08:begin
            if(recv_done_flag)begin
                break_pc[7:0]<=recv_data;
                recv_state   <=recv_state+1'b1;
            end
        end
        5'd09:if(!recv_done_flag)
                recv_state  <=5'd0;

        //receive reg_num 
        5'd10:if(!recv_done_flag)
                recv_state  <=recv_state+1'b1;
        5'd11:begin
            if(recv_done_flag)begin
                infor_flag_r<=1'b1;
                reg_num_r   <=recv_data;
                recv_state  <=recv_state+1'b1;
            end
        end
        5'd12:begin
            infor_flag_r<=1'b0;
            recv_state  <=5'd09;
        end

        //receive mem_addr
        5'd13:if(!recv_done_flag)
                recv_state    <=recv_state+1'b1;
        5'd14:begin
            if(recv_done_flag)begin
                start_addr_r[31:24]<=recv_data;
                recv_state         <=recv_state+1'b1;
            end
        end
        5'd15:if(!recv_done_flag)
                recv_state    <=recv_state+1'b1;
        5'd16:begin
            if(recv_done_flag)begin
                start_addr_r[23:16]<=recv_data;
                recv_state         <=recv_state+1'b1;
            end 
        end
        5'd17:if(!recv_done_flag)
                recv_state   <=recv_state+1'b1;
        5'd18:begin
            if(recv_done_flag)begin
                start_addr_r[15:8]<=recv_data;
                recv_state        <=recv_state+1'b1;
            end
        end
        5'd19:if(!recv_done_flag)
                recv_state   <=recv_state+1'b1;
        5'd20:begin
            if(recv_done_flag)begin
                infom_flag_r   <=1'b1;
                start_addr_r[7:0]<=recv_data;
                recv_state       <=recv_state+1'b1;
            end
        end
        5'd21:begin
            if(mem_flag)begin
                infom_flag_r<=1'b0;
                recv_state  <=5'd09;
            end
        end
        
        5'd22:if(!recv_done_flag)
                recv_state    <=recv_state+1'b1;
        5'd23:begin
            if(recv_done_flag)begin
                trace_pc[31:24]<=recv_data;
                recv_state    <=recv_state+1'b1;
            end
        end
        5'd24:if(!recv_done_flag)
                recv_state    <=recv_state+1'b1;
        5'd25:begin
            if(recv_done_flag)begin
                trace_pc[23:16]<=recv_data;
                recv_state    <=recv_state+1'b1;
            end
        end
        5'd26:if(!recv_done_flag)
                recv_state   <=recv_state+1'b1;
        5'd27:begin
            if(recv_done_flag)begin
                trace_pc[15:8]<=recv_data;
                recv_state   <=recv_state+1'b1;
            end
        end
        5'd28:if(!recv_done_flag)
                recv_state   <=recv_state+1'b1;
        5'd29:begin
            if(recv_done_flag)begin
                trace_pc[7:0]<=recv_data;
                recv_state  <=5'd09;
            end
        end
        5'd30:begin
            list_flag <=1'b0;
            recv_state<=5'd0;
        end
        default:;
        endcase
    end
end


//break_point and step processing
assign break_point=((break_pc==debug_wb_pc && ws_valid && break_flag) || (step_pc!=debug_wb_pc && step_flag))? 1'b1:1'b0; 
//infor processing
assign infor_flag=infor_flag_r;
assign reg_num=reg_num_r[4:0];
//infom processing
assign infom_flag=infom_flag_r;
assign start_addr=start_addr_r;


//send
reg a_flag;
reg send_flag;
reg[ 5:0] send_state;
reg[31:0] rf_rdata_r;
reg[ 7:0] mem_rdata_r;
reg[ 4:0] wnum_r;
reg[31:0] wdata_r;
reg[31:0] list_pc_r;

always@(posedge sys_clk or negedge sys_rst_n) begin         
      if (!sys_rst_n) begin
          send_en   <= 1'b0;
          send_data <= 8'd0;
          send_flag <= 1'b0;
          a_flag    <= 1'b0;
          send_state<= 6'd0;
      end                                                      
      else if(infor_flag)begin 
               send_flag <= 1'b1;
               send_state<= 6'd0;
               rf_rdata_r<= rf_rdata;                                                        
          end
      else if(infom_flag && mem_flag)begin
               send_flag  <=1'b1;
               send_state <=6'd20;
               mem_rdata_r<=mem_rdata;
      end
      else if(trace_pc==debug_wb_pc && trace_flag && !a_flag)begin 
               send_flag <= 1'b1;
               a_flag    <= 1'b1;
               send_state<= 6'd25;
               wnum_r    <= debug_wb_rf_wnum;
               wdata_r   <= debug_wb_rf_wdata;                                                          
          end
      else if(list_flag)begin
               send_flag<=1'b1;
               send_state<=6'd50;
               list_pc_r<=debug_wb_pc;
      end
      else if(send_flag)begin
        case(send_state)
        6'd00:begin
            if(~tx_busy)begin
              send_en   <= 1'b1;
              send_data <= rf_rdata_r[31:24];
              send_state<=send_state+1'b1;
            end
      end
        6'd04:begin
                send_en   <= 1'b0;
                send_state<= send_state+1'b1;
        end
        6'd05:begin
            if(~tx_busy)begin
                send_en   <= 1'b1;
                send_data <=rf_rdata_r[23:16];
                send_state<=send_state+1'b1;   
            end
        end
        6'd09:begin
                send_en   <= 1'b0;
                send_state<= send_state+1'b1;
        end
        6'd10:begin
            if(~tx_busy)begin
                send_en   <= 1'b1;
                send_data <=rf_rdata_r[15:8];
                send_state<=send_state+1'b1;   
            end
        end
        6'd14:begin
                send_en   <= 1'b0;
                send_state<= send_state+1'b1;
        end 
        6'd15:begin
            if(~tx_busy)begin
                send_en   <= 1'b1;
                send_data <=rf_rdata_r[7:0];
                send_state<=send_state+1'b1;   
            end
        end
        6'd19:begin
                send_en   <= 1'b0;
                send_flag <= 1'b0;
                send_state<= 6'd0;
        end


        6'd20:begin
            if(~tx_busy)begin
              send_en   <= 1'b1;
              send_data <= mem_rdata_r;
              send_state<=send_state+1'b1;
            end
      end
        6'd24:begin
                send_en   <= 1'b0;
                send_flag <= 1'b0;
                send_state<= 5'd0;
        end
        

        6'd25:begin
            if(~tx_busy)begin
              send_en   <= 1'b1;
              send_data <={3'd0,wnum_r};
              send_state<=send_state+1'b1;
            end
      end
        6'd29:begin
                send_en   <= 1'b0;
                send_state<= send_state+1'b1;
        end
        6'd30:begin
            if(~tx_busy)begin
                send_en   <= 1'b1;
                send_data <=wdata_r[31:24];
                send_state<=send_state+1'b1;   
            end
        end
        6'd34:begin
                send_en   <= 1'b0;
                send_state<= send_state+1'b1;
        end
        6'd35:begin
            if(~tx_busy)begin
                send_en   <= 1'b1;
                send_data <=wdata_r[23:16];
                send_state<=send_state+1'b1;   
            end
        end
        6'd39:begin
                send_en   <= 1'b0;
                send_state<= send_state+1'b1;
        end 
        6'd40:begin
            if(~tx_busy)begin
                send_en   <= 1'b1;
                send_data <=wdata_r[15:8];
                send_state<=send_state+1'b1;   
            end
        end
        6'd44:begin
                send_en   <= 1'b0;
                send_state<= send_state+1'b1;
        end 
        6'd45:begin
            if(~tx_busy)begin
                send_en   <= 1'b1;
                send_data <=wdata_r[7:0];
                send_state<=send_state+1'b1;   
            end
        end
        6'd49:begin
            if(recv_state==5'd10 || recv_state==5'd13 || recv_state==5'd29)begin
                send_en   <= 1'b0;
                send_flag <= 1'b0;
                a_flag    <= 1'b0;
                send_state<= 6'd0;
            end
        end


        6'd50:begin
            if(~tx_busy)begin
              send_en   <= 1'b1;
              send_data <= list_pc_r[31:24];
              send_state<=send_state+1'b1;
            end
      end
        6'd52:begin
                send_en   <= 1'b0;
                send_state<= send_state+1'b1;
        end
        6'd53:begin
            if(~tx_busy)begin
                send_en   <= 1'b1;
                send_data <=list_pc_r[23:16];
                send_state<=send_state+1'b1;   
            end
        end
        6'd55:begin
                send_en   <= 1'b0;
                send_state<= send_state+1'b1;
        end
        6'd56:begin
            if(~tx_busy)begin
                send_en   <= 1'b1;
                send_data <=list_pc_r[15:8];
                send_state<=send_state+1'b1;   
            end
        end
        6'd58:begin
                send_en   <= 1'b0;
                send_state<= send_state+1'b1;
        end 
        6'd59:begin
            if(~tx_busy)begin
                send_en   <= 1'b1;
                send_data <=list_pc_r[7:0];
                send_state<=send_state+1'b1;   
            end
        end
        6'd61:begin
                send_en   <= 1'b0;
                send_flag <= 1'b0;
                send_state<= 6'd0;
        end   
        default:send_state <= send_state+1'b1;
        endcase
      end
end

endmodule  