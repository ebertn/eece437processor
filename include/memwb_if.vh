`ifndef MEMWB_IF_V
`define MEMWB_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface memwb_if;
// import types
import cpu_types_pkg::*;

// Inputs
word_t pcplus4_in, aluOutport_in, dmemload_in;
regbits_t rt_in, rd_in;
logic MemToReg_in, JType_in, RegDst_in, regWEN_in, PcSrc_in, JReg_in;
logic writeEN, flush;

// Outputs
// Outputs
word_t pcplus4_out, aluOutport_out, dmemload_out;
regbits_t rt_out, rd_out;
logic MemToReg_out, JType_out, RegDst_out, regWEN_out, PcSrc_out, JReg_out;

//DEBUG PURPOSES 
opcode_t InstrOp_in;
funct_t InstrFunc_in;
opcode_t InstrOp_out;
funct_t InstrFunc_out;
regbits_t rs_in; 
regbits_t rs_out; 
word_t instr_in, instr_out, next_pc_in, next_pc_out, imm_in, imm_out, branchaddr_in, branchaddr_out; 
logic [15:0] imm_16_in, imm_16_out; 
logic [4:0] shamt_in, shamt_out; 
// memwb ports
modport memwb (
input   pcplus4_in, aluOutport_in, dmemload_in, rt_in, rd_in, MemToReg_in, JType_in, RegDst_in, regWEN_in, PcSrc_in, JReg_in, writeEN, flush, InstrOp_in, InstrFunc_in, rs_in, instr_in, next_pc_in, imm_in,imm_16_in, branchaddr_in, shamt_in, 
output  pcplus4_out, aluOutport_out, dmemload_out, rt_out, rd_out, MemToReg_out, JType_out, RegDst_out, regWEN_out, PcSrc_out, JReg_out, InstrOp_out, InstrFunc_out, rs_out, instr_out, next_pc_out, imm_out, imm_16_out, branchaddr_out, shamt_out 
);
// memwb tb
modport tb (
input   pcplus4_out, aluOutport_out, dmemload_out, rt_out, rd_out, MemToReg_out, JType_out, RegDst_out, regWEN_out, PcSrc_out, JReg_out,InstrOp_out,InstrFunc_out, rs_out, instr_out, next_pc_out, imm_out, imm_16_out,branchaddr_out, shamt_out, 
output  pcplus4_in, aluOutport_in, dmemload_in, rt_in, rd_in, MemToReg_in, JType_in, RegDst_in, regWEN_in, PcSrc_in, JReg_in, writeEN, flush, InstrOp_in, InstrFunc_in,rs_in,instr_in,next_pc_in, imm_in, imm_16_in, branchaddr_in, shamt_in
);
endinterface : memwb_if

`endif //MEMWB_IF_VH