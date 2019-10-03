`ifndef FORWARD_IF_VH
`define FORWARD_IF_VH

`include "cpu_types_pkg.vh"

interface forward_if; 
import cpu_types_pkg::*;

regbits_t rsel1, rsel2, mem_writeReg, wb_writeReg;
logic [1:0] forwardA, forwardB;
logic mem_regWEN, wb_regWEN, mem_dmemREN, mem_dmemWEN;

modport forw (
input rsel1, rsel2, mem_writeReg, wb_writeReg, mem_dmemREN, mem_dmemWEN,
output forwardA, forwardB
); 

modport tb (
input forwardA, forwardB,
output rsel1, rsel2, mem_writeReg, wb_writeReg, mem_dmemREN, mem_dmemWEN
); 

endinterface 

`endif