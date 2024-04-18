`timescale 1ps/1ps
`include "../define.v"

module CtrlBlock (
    input        wire                                      Clk              ,
    input        wire                                      Rest             ,

    //from FTQ
    input        wire                                     FtqReq            ,//  req all req stop 
    //from Inst QUeue
    input        wire                                      InstQUeueReq     , 
    //from Rename 
    input        wire                                      RenameReq        ,
    //from Issue
    input        wire                                      IntIqReq         ,
    input        wire                                      BCIqReq          ,
    input        wire                                      MemIqReq         ,
    //from Rob
    input        wire                                      RobReq           ,
    input        wire                                      Flash            ,

    //to Icache
    output       wire                                      IcacheStop       ,
    output       wire                                      IcacheFlash      ,
    //to FTQ
    output       wire                                      FtqStop          ,
    output       wire                                      FtqFlash         ,
    //to PreDecode
    output       wire                                      PreDecodeStop    ,
    output       wire                                      PreDecodeFlash   ,
    //to InstQueue 
    output       wire                                      InstQueueStop    ,
    output       wire                                      InstQueueFlash   ,
    //to Decode 
    output       wire                                      DecodeStop       ,
    output       wire                                      DecodeFlash      ,
    //to rename 
    output       wire                                      RenameStop       ,
    output       wire                                      RenameFlash      ,
    //to IssueQueue all
    output       wire                                      IssueQUeueStop   ,
    output       wire                                      IssueQUeueFlash  ,
    //to read file
    output       wire                                      ReadFileStop     ,
    output       wire                                      ReadFileFlash    ,
    //to eu all
    output       wire                                      EuAllStop        ,
    output       wire                                      EuAllFlash       ,
    //to Dcache
    output       wire                                      DcacheStop       ,
    output       wire                                      DecacheFlash     ,


);

endmodule
