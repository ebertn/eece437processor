`ifndef CONTROL_UNIT_IF_VH
`define CONTROL_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface control_unit_if;
  // import types
  import cpu_types_pkg::*;

	logic Equal, PcSrc, Halt, iMemRe, dMemRe, dMemWr, RegDst, MemToReg, regWEN, UpperImm, AluSrc, ExtOp, JType, RegZero, JReg;
	opcode_t InstrOp;
	funct_t InstrFunc;
 	aluop_t AluOp;

	// control unit ports
	modport cu (
	input   Equal, InstrOp, InstrFunc,
	output  PcSrc, iMemRe, RegDst, AluOp, dMemWr, MemToReg, Halt, dMemRe, AluSrc, ExtOp, regWEN, UpperImm, RegZero, JType, JReg
	);
	// control unit tb
	modport tb (
	input   PcSrc, iMemRe, RegDst, AluOp, dMemWr, MemToReg, Halt, dMemRe, AluSrc, ExtOp, regWEN, UpperImm, RegZero, JType, JReg,
	output  Equal, InstrOp, InstrFunc
	);
endinterface

`endif //CONTROL_UNIT_VH
