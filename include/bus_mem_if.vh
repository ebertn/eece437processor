`ifndef BUS_MEM_IF_VH
`define BUS_MEM_IF_VH

// ram memory types
`include "cpu_types_pkg.vh"

interface bus_mem_if;

// import types
import cpu_types_pkg::*;

parameter CPUS = 2;

// arbitration
logic   [CPUS-1:0]       dwait, dREN, dWEN;
word_t  [CPUS-1:0]       dload, dstore;
word_t  [CPUS-1:0]       daddr;

modport mem_con (
input   dREN, dWEN, dstore, daddr,
output  dwait, dload
);

modport bus_con (
input    dwait, dload,
output   dREN, dWEN, dstore, daddr
);

endinterface : bus_mem_if
`endif