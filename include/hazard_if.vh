`ifndef HAZARD_IF_VH
`define HAZARD_IF_VH

`include "cpu_types_pkg.vh"

interface hazard_if; 
import cpu_types_pkg::*;


word_t rsel1, rsel2, mem_writeReg, ex_writeReg; 
logic hazard, equal, branch; 
opcode_t instrOp; 

modport haz (
input rsel1, resel2, mem_writeReg, ex_writeReg, equal, instrOp,  
output hazard, branch
); 

modport tb (
input hazard, branch, 
output rsel1, resel2, mem_writeReg, ex_writeReg,equal, instrOp
); 

endinterface

`endif