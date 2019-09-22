`ifndef EXMEM_IF_VH
`define EXMEM_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface exmem_if;
// import types
import cpu_types_pkg::*;

// Inputs
word_t pcplus4_in, branchaddr_in, aluOutport_in, rdat2_in;
logic MemToReg_in, JType_in, RegDst_in, regWEN_in, PcSrc_in, JReg_in,
    Halt_in, dMemWEN_in, dMemREN_in;

// Outputs
// Outputs
word_t pcplus4_out, branchaddr_out, aluOutport_out, rdat2_out;
logic MemToReg_out, JType_out, RegDst_out, regWEN_out, PcSrc_out, JReg_out,
      Halt_out, dMemWEN_out, dMemREN_out;

// exmem ports
modport exmem (
input   pcplus4_in, branchaddr_in, aluOutport_in, rdat2_in, MemToReg_in, JType_in, RegDst_in,
    regWEN_in, PcSrc_in, JReg_in, Halt_in, dMemWEN_in, dMemREN_in,
output  pcplus4_out, branchaddr_out, aluOutport_out, rdat2_out, MemToReg_out, JType_out, RegDst_out,
    regWEN_out, PcSrc_out, JReg_out, Halt_out, dMemWEN_out, dMemREN_out
);
// exmem tb
modport tb (
input   pcplus4_out, branchaddr_out, aluOutport_out, rdat2_out, MemToReg_out, JType_out, RegDst_out,
        regWEN_out, PcSrc_out, JReg_out, Halt_out, dMemWEN_out, dMemREN_out,
output  pcplus4_in, branchaddr_in, aluOutport_in, rdat2_in, MemToReg_in, JType_in, RegDst_in,
        regWEN_in, PcSrc_in, JReg_in, Halt_in, dMemWEN_in, dMemREN_in,
);
endinterface : exmem_if

`endif //EXMEM_IF_VH