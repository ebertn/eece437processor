`ifndef HAZARD_IF_VH
`define HAZARD_IF_VH

`include "cpu_types_pkg.vh"

interface hazard_if; 
import cpu_types_pkg::*;


word_t rsel1, rsel2, mem_writeReg, ex_writeReg; 
logic hazard, equal, branch, jump;
opcode_t instrOp; 

modport haz (
input rsel1, rsel2, mem_writeReg, ex_writeReg, equal, instrOp,  
output hazard, branch, jump
); 

modport tb (
input hazard, branch, jump,
output rsel1, rsel2, mem_writeReg, ex_writeReg,equal, instrOp
); 

endinterface

`endif