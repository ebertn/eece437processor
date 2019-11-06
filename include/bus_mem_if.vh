`ifndef BUS_MEM_IF_VH
`define BUS_MEM_IF_VH

// ram memory types
`include "cpu_types_pkg.vh"

interface bus_mem_if;

// import types
import cpu_types_pkg::*;

parameter CPUS = 2;

// Needs this just to interact with data memory. Cache signals come from ccif

logic  dwait, dREN, dWEN;
word_t dload, dstore;
word_t daddr;

modport bus_con (
input    dwait, dload,
output   dREN, dWEN, dstore, daddr
);

endinterface : bus_mem_if
`endif