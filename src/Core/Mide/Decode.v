`timescale 1ps/1ps
`include "define.v"

module Decode (
    input     wire                             Clk           ,
    input     wire                             Rest          ,

    //to InstQueue
    output    wire                             ReqInstPort1  ,
    output    wire                             ReqInstPort2  ,
    output    wire                             ReqInstPort3  ,
    output    wire                             ReqInstPort4  ,
    //from InsrQueue
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
    input     wire                             QueueEmpty    ,
    //to Rename stage 
    output    
    output    wire                             RenameAble11  ,
    output    wire      [`ArchRegBUs]          ReadRename11  ,
    output    wire                             RenameAble12  ,
    output    wire      [`ArchRegBUs]          ReadRename12  ,
    output    wire                             RenameAble21  ,
    output    wire      [`ArchRegBUs]          ReadRename21  ,
    output    wire                             RenameAble22  ,
    output    wire      [`ArchRegBUs]          ReadRename22  ,
    output    wire                             RenameAble31  ,
    output    wire      [`ArchRegBUs]          ReadRename31  ,
    output    wire                             RenameAble32  ,
    output    wire      [`ArchRegBUs]          ReadRename32  ,
    output    wire                             RenameAble41  ,
    output    wire      [`ArchRegBUs]          ReadRename41  ,
    output    wire                             RenameAble42  ,
    output    wire      [`ArchRegBUs]          ReadRename42  ,
    output    wire                             WRenameAble1  ,   
    output    wire      [`ArchRegBUs]          WRenameDate1  ,  
    output    wire                             WRenameAble2  ,   
    output    wire      [`ArchRegBUs]          WRenameDate2  ,
    output    wire                             WRenameAble3  ,   
    output    wire      [`ArchRegBUs]          WRenameDate3  ,
    output    wire                             WRenameAble4  ,   
    output    wire      [`ArchRegBUs]          WRenameDate4  , 
    //to                 



    //input from Rename  map free reg tabe
    

    

);
    
endmodule