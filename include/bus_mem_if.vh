`ifndef BUS_MEM_IF_VH
`define BUS_MEM_IF_VH

// ram memory types
`include "cpu_types_pkg.vh"

interface bus_mem_if;

// import types
import cpu_types_pkg::*;

parameter CPUS = 2;

// Needs this just to interact with data memory. Cache signals come from ccif

// Memory interface
logic  dwait, dREN, dWEN;
word_t dload, dstore;
word_t daddr;

logic   [CPUS-1:0]       ccif_dwait, ccif_dREN, ccif_dWEN, ccif_halt, ccif_flushed;
word_t  [CPUS-1:0]       ccif_dload, ccif_dstore;
word_t  [CPUS-1:0]       ccif_daddr;

logic   [CPUS-1:0]      ccif_ccwait, ccif_ccinv;
logic   [CPUS-1:0]      ccif_ccwrite, ccif_cctrans;
word_t  [CPUS-1:0]      ccif_ccsnoopaddr;

modport bus_con (
input    dwait, dload,
            ccif_dREN, ccif_dWEN, ccif_dstore, ccif_daddr, ccif_halt, ccif_flushed,
            // coherence inputs from cache
            ccif_ccwrite, ccif_cctrans,
output   dREN, dWEN, dstore, daddr,
            ccif_dwait, ccif_dload,
            // coherence outputs to cache
            ccif_ccwait, ccif_ccinv, ccif_ccsnoopaddr
);

endinterface : bus_mem_if
`endif