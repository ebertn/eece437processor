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

//DEBUG BULLSHIT
opcode_t InstrOp_in;
funct_t InstrFunc_in;
opcode_t InstrOp_out;
funct_t InstrFunc_out;
regbits_t rs_in; 
regbits_t rs_out;
word_t instr_in, instr_out, next_pc_in, next_pc_out, imm_in, imm_out; 
logic [15:0] imm_16_in, imm_16_out; 
logic [4:0] shamt_in, shamt_out; 

//HAZARD BULLSHIT
regbits_t writeReg_in, writeReg_out; 

// exmem ports
modport exmem (
input   pcplus4_in, branchaddr_in, aluOutport_in, rdat2_in, rt_in, rd_in, MemToReg_in, JType_in, RegDst_in,
    regWEN_in, PcSrc_in, JReg_in, Halt_in, dMemWEN_in, dMemREN_in,InstrOp_in, InstrFunc_in,rs_in, instr_in, 
    next_pc_in, imm_in,imm_16_in, shamt_in, writeEN, flush,writeReg_in, 
output  pcplus4_out, branchaddr_out, aluOutport_out, rdat2_out, rt_out, rd_out, MemToReg_out, JType_out, RegDst_out,
    regWEN_out, PcSrc_out, JReg_out, Halt_out, dMemWEN_out, dMemREN_out, InstrOp_out,InstrFunc_out, rs_out, instr_out, 
    next_pc_out, imm_out, imm_16_out, shamt_out, writeReg_out
);
// exmem tb
modport tb (
input   pcplus4_out, branchaddr_out, aluOutport_out, rdat2_out, rt_out, rd_out, MemToReg_out, JType_out, RegDst_out, 
        regWEN_out, PcSrc_out, JReg_out, Halt_out, dMemWEN_out, dMemREN_out,InstrOp_out,InstrFunc_out,rs_out,instr_out, 
	next_pc_out, imm_out, imm_16_out,shamt_out, writeReg_out,   
output  pcplus4_in, branchaddr_in, aluOutport_in, rdat2_in, rt_in, rd_in, MemToReg_in, JType_in, RegDst_in,
        regWEN_in, PcSrc_in, JReg_in, Halt_in, dMemWEN_in, dMemREN_in, writeEN, flush, InstrOp_in, InstrFunc_in, 
	rs_in, instr_in,next_pc_in, imm_in, imm_16_in, shamt_in, writeReg_in
);
endinterface : exmem_if

`endif //EXMEM_IF_VH