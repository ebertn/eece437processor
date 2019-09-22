`ifndef MEMWB_IF_VH
`define MEMWB_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface memwb_if;
// import types
import cpu_types_pkg::*;

// Inputs
word_t pcplus4_in, aluOutport_in, dmemload_in;
logic MemToReg_in, JType_in, RegDst_in, regWEN_in, PcSrc_in, JReg_in;

// Outputs
// Outputs
word_t pcplus4_out, aluOutport_out, dmemload_out;
logic MemToReg_out, JType_out, RegDst_out, regWEN_out, PcSrc_out, JReg_out;

// memwb ports
modport memwb (
input   pcplus4_in, aluOutport_in, MemToReg_in, JType_in, RegDst_in, regWEN_in, PcSrc_in, JReg_in,
output  pcplus4_out, aluOutport_out, MemToReg_out, JType_out, RegDst_out, regWEN_out, PcSrc_out, JReg_out
);
// memwb tb
modport tb (
input   pcplus4_out, aluOutport_out, MemToReg_out, JType_out, RegDst_out, regWEN_out, PcSrc_out, JReg_out,
output  pcplus4_in, aluOutport_in, MemToReg_in, JType_in, RegDst_in, regWEN_in, PcSrc_in, JReg_in
);
endinterface : memwb_if

`endif //MEMWB_IF_VH