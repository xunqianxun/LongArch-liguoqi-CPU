module ProfCtr (
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
