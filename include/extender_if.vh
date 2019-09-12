`ifndef EXTENDER_IF_VH
`define EXTENDER_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface extender_if;
// import types
import cpu_types_pkg::*;

logic JType, ExtOp, UpperImm;
word_t out;
logic [IMM_W-1:0] imm16;
logic [ADDR_W-1:0] imm26;

// extender ports
modport ext (
input   JType, ExtOp, UpperImm, imm16, imm26,
output  out
);
// extender tb
modport tb (
input   out,
output  JType, ExtOp, UpperImm, imm16, imm26
);
endinterface

`endif //EXTENDER_IF_VH