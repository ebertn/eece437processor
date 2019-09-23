`ifndef EXMEM_IF_VH
`define EXMEM_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface exmem_if;
// import types
import cpu_types_pkg::*;

// Inputs
word_t pcplus4_in, branchaddr_in, aluOutport_in, rdat2_in;
regbits_t rt_in, rd_in;
logic MemToReg_in, JType_in, RegDst_in, regWEN_in, PcSrc_in, JReg_in,
    Halt_in, dMemWEN_in, dMemREN_in;
logic writeEN, flush;

// Outputs
word_t pcplus4_out, branchaddr_out, aluOutport_out, rdat2_out;
regbits_t rt_out, rd_out;
logic MemToReg_out, JType_out, RegDst_out, regWEN_out, PcSrc_out, JReg_out,
      Halt_out, dMemWEN_out, dMemREN_out;

// exmem ports
modport exmem (
input   pcplus4_in, branchaddr_in, aluOutport_in, rdat2_in, rt_in, rd_in, MemToReg_in, JType_in, RegDst_in,
    regWEN_in, PcSrc_in, JReg_in, Halt_in, dMemWEN_in, dMemREN_in, writeEN, flush,
output  pcplus4_out, branchaddr_out, aluOutport_out, rdat2_out, rt_out, rd_out, MemToReg_out, JType_out, RegDst_out,
    regWEN_out, PcSrc_out, JReg_out, Halt_out, dMemWEN_out, dMemREN_out
);
// exmem tb
modport tb (
input   pcplus4_out, branchaddr_out, aluOutport_out, rdat2_out, rt_out, rd_out, MemToReg_out, JType_out, RegDst_out,
        regWEN_out, PcSrc_out, JReg_out, Halt_out, dMemWEN_out, dMemREN_out,
output  pcplus4_in, branchaddr_in, aluOutport_in, rdat2_in, rt_in, rd_in, MemToReg_in, JType_in, RegDst_in,
        regWEN_in, PcSrc_in, JReg_in, Halt_in, dMemWEN_in, dMemREN_in, writeEN, flush
);
endinterface : exmem_if

`endif //EXMEM_IF_VH