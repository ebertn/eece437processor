`ifndef IFID_IF_VH
`define IFID_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface ifid_if;
// import types
import cpu_types_pkg::*;

word_t pcplus4_in, pcplus4_out, instr_in, instr_out;

// ifit ports
modport ifit (
input   pcplus4_in, instr_in,
output  pcplus4_out, instr_out
);
// ifit tb
modport tb (
input   pcplus4_out, instr_out,
output  pcplus4_in, instr_in
);
endinterface

`endif //IFID_IF_VH