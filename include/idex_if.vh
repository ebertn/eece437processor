`ifndef IDEX_IF_VH
`define IDEX_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface idex_if;
// import types
import cpu_types_pkg::*;

// Inputs
word_t pcplus4_in, rdat1_in, rdat2_in, immext_in;
regbits_t rt_in, rd_in;
aluop_t AluOp_in;
logic MemToReg_in, AluSrc_in, JType_in, RegDst_in, regWEN_in, PcSrc_in, JReg_in,
    Halt_in, dMemWEN_in, dMemREN_in;
logic writeEN, flush;

// Outputs
word_t pcplus4_out, rdat1_out, rdat2_out, immext_out;
regbits_t rt_out, rd_out;
aluop_t AluOp_out;
logic MemToReg_out, AluSrc_out, JType_out, RegDst_out, regWEN_out, PcSrc_out, JReg_out,
    Halt_out, dMemWEN_out, dMemREN_out;

// idex ports
modport idex (
input   pcplus4_in, rdat1_in, rdat2_in, immext_in, rt_in, rd_in, MemToReg_in, AluOp_in, AluSrc_in, JType_in,
    RegDst_in, regWEN_in, PcSrc_in, JReg_in, Halt_in, dMemWEN_in, dMemREN_in, writeEN, flush,
output  pcplus4_out, rdat1_out, rdat2_out, immext_out, rt_out, rd_out, MemToReg_out, AluOp_out, AluSrc_out,
    JType_out, RegDst_out, regWEN_out, PcSrc_out, JReg_out, Halt_out, dMemWEN_out, dMemREN_out
);
// idex tb
modport tb (
input   pcplus4_out, rdat1_out, rdat2_out, immext_out, rt_out, rd_out, MemToReg_out, AluOp_out, AluSrc_out,
        JType_out, RegDst_out, regWEN_out, PcSrc_out, JReg_out, Halt_out, dMemWEN_out, dMemREN_out,
output  pcplus4_in, rdat1_in, rdat2_in, immext_in, rt_in, rd_in, MemToReg_in, AluOp_in, AluSrc_in, JType_in,
        RegDst_in, regWEN_in, PcSrc_in, JReg_in, Halt_in, dMemWEN_in, dMemREN_in, writeEN, flush
);
endinterface : idex_if

`endif //IDEX_IF_VH
