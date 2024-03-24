`timescale 1ps/1ps
`include "../define.v"

module Mmu (
    input       wire                                     Clk           ,
    input       wire                                     Rest          ,
    //from Csr
    input       wire      [9:0]                          Asid          ,

    //from Inst
    input       wire                                     InstFetch     ,
    input       wire      [31:0]                         InstVritualA  ,
    input       wire                                     InstDmw0En    ,
    input                  inst_dmw1_en         ,
    //output [ 7:0]          inst_index           ,
    output [19:0]          inst_tag             ,
    output [ 3:0]          inst_offset          ,
    output                 inst_tlb_found       ,
    output                 inst_tlb_v           ,
    output                 inst_tlb_d           ,
    output [ 1:0]          inst_tlb_mat         ,
    output [ 1:0]          inst_tlb_plv         ,     
);
    
endmodule 
