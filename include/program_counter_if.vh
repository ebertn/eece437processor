`ifndef PROGRAM_COUNTER_IF_VH
`define PROGRAM_COUNTER_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface program_counter_if;
// import types
import cpu_types_pkg::*;

logic countEn;
word_t count, next_count;

// extender ports
modport pc (
input   countEn, next_count,
output  count
);
// extender tb
modport tb (
input   count,
output  countEn, next_count
);
endinterface

`endif //PROGRAM_COUNTER_IF_VH