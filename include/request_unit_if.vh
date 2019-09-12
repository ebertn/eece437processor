`ifndef REQUEST_UNIT_IF_VH
`define REQUEST_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface request_unit_if;
  // import types
  import cpu_types_pkg::*;

	logic iMemRe, dMemWr, dMemRe, ihit, dhit, imemREN, dmemWEN, dmemREN;

	// alu ports
	modport ru (
	input   iMemRe, iMemAddr, dMemWr, dMemRe, dMemAddr, dMemStore, Halt,
	output  iHit, iMemLoad, dHit, dMemLoad
	);
	// alu tb
	modport tb (
	input   iHit, iMemLoad, dHit, dMemLoad,
	output  iMemRe, iMemAddr, dMemWr, dMemRe, dMemAddr, dMemStore, Halt
	);
endinterface

`endif //REQUEST_UNIT_VH
