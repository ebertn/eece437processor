`ifndef HAZARD_IF_VH
`define HAZARD_IF_VH

`include "cpu_types_pkg.vh"

interface hazard_if; 
import cpu_types_pkg::*;


word_t rsel1, rsel2, mem_writeReg, ex_writeReg; 
logic hazard, equal, branch, jump, dhit;
opcode_t instrOp;
funct_t instrFunc;

//logic ihit; 

modport haz (
input rsel1, rsel2, mem_writeReg, ex_writeReg, equal, instrOp, instrFunc, dhit,
output hazard, branch, jump
); 

modport tb (
input hazard, branch, jump,
output rsel1, rsel2, mem_writeReg, ex_writeReg,equal, instrOp, instrFunc, dhit 
); 

endinterface : hazard_if

`endif