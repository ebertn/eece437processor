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
	input   iMemRe, dMemWr, dMemRe, ihit, dhit,
	output  imemREN, dmemWEN, dmemREN
	);
	// alu tb
	modport tb (
	input   imemREN, dmemWEN, dmemREN,
	output  iMemRe, dMemWr, dMemRe, ihit, dhit
	);
endinterface

`endif //REQUEST_UNIT_VH
