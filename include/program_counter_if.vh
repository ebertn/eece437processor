`ifndef PROGRAM_COUNTER_IF_VH
`define PROGRAM_COUNTER_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface program_counter_if;
// import types
import cpu_types_pkg::*;

logic countEn;
word_t pc, next_PC;

// extender ports
modport pc (
input   countEn, next_PC,
output  pc
);
// extender tb
modport tb (
input   pc,
output  countEn, next_PC
);
endinterface

`endif //PROGRAM_COUNTER_IF_VH