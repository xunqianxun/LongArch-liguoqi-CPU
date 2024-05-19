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
