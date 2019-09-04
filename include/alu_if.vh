`ifndef ALU_IF_VH
`define ALU_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface alu_if;
  // import types
  import cpu_types_pkg::*;

  logic negative, overflow, zero;
  word_t portA, portB, outPort;
  aluop_t aluOp;

  // alu ports
  modport alu (
    input   portA, portB, aluOp,
    output  negative, overflow, zero, outPort
  );
  // alu tb
  modport tb (
    input   negative, overflow, zero, outPort,
    output  portA, portB, aluOp
  );
endinterface

`endif //ALU_IF_VH