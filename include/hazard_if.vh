`ifndef HAZARD_IF_VH
`define HAZARD_IF_VH

`include "cpu_types_pkg.vh"

interface hazard_if; 
import cpu_types_pkg::*;


word_t rsel1, rsel2, mem_writeReg, ex_writeReg; 
logic hazard, equal, branch, jump, dhit, ex_regWEN, mem_regWEN, ex_dmemREN;
logic [3:0] hazardifstatement;
opcode_t instrOp, mem_instrOp;
funct_t instrFunc;

//logic ihit; 

modport haz (
input rsel1, rsel2, mem_writeReg, ex_writeReg, equal, instrOp, instrFunc, dhit, ex_regWEN, mem_regWEN, ex_dmemREN, mem_instrOp,
output hazard, branch, jump, hazardifstatement
); 

modport tb (
input hazard, branch, jump, hazardifstatement,
output rsel1, rsel2, mem_writeReg, ex_writeReg,equal, instrOp, instrFunc, dhit, ex_regWEN, mem_regWEN, ex_dmemREN, mem_instrOp
); 

endinterface : hazard_if

`endif