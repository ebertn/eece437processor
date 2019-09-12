`ifndef CONTROL_UNIT_IF_VH
`define CONTROL_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface control_unit_if;
  // import types
  import cpu_types_pkg::*;

	logic iHit, Equal, dHit, PcSrc, PcCountEn, iMemRe, RegDst, dMemWr, MemToReg, AluSrc, ExtOp, JType, RegZero, JReg;
	opcode_t InstrOp;
	funct_t InstrFunc;
 	aluop_t AluOp;

	// control unit ports
	modport cu (
	input   iHit, Equal, dHit, InstrOp, InstrFunc,
	output  PcSrc, iMemRe, RegDst, AluOp, dMemWr, MemToReg, Halt, dMemRe, AluSrc, ExtOp, regWEN, UpperImm, RegZero, JType, JReg
	);
	// control unit tb
	modport tb (
	input   PcSrc, iMemRe, RegDst, AluOp, dMemWr, MemToReg, Halt, dMemRe, AluSrc, ExtOp, regWEN, UpperImm, RegZero, JType, JReg,
	output  iHit, Equal, dHit, InstrOp
	);
endinterface

`endif //CONTROL_UNIT_VH
