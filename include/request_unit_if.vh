`ifndef REQUEST_UNIT_IF_VH
`define REQUEST_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface request_unit_if;
  // import types
  import cpu_types_pkg::*;

	logic iMemRe, dMemWr, dMemRe, ihit, dhit, imemREN_out, dmemWEN_out, dmemREN_out;

	// alu ports
	modport ru (
	input   iMemRe, dMemWr, dMemRe, ihit, dhit, dMemStore,
	output  imemREN_out, dmemWEN_out, dmemREN_out
	);
	// alu tb
	modport tb (
	input   imemREN_out, dmemWEN_out, dmemREN_out
	output  iMemRe, dMemWr, dMemRe, ihit, dhit, dMemStore,
	);
endinterface

`endif //REQUEST_UNIT_VH
