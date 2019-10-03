`include "forward_if.vh"
`include "cpu_types_pkg.vh"

module forward_unit
(
	forward_if forwardif
); 

import cpu_types_pkg::*;

// rs = rsel1, rt = rsel2
always_comb begin
	forwardif.forwardA = 0;
	forwardif.forwardB = 0;

	if (forwardif.wb_regWEN && forwardif.wb_writeReg != 0 && forwardif.wb_writeReg == forwardif.rsel1) begin
		forwardif.forwardA = 1;
	end

	if (forwardif.wb_regWEN && forwardif.wb_writeReg != 0 && forwardif.wb_writeReg == forwardif.rsel2) begin
		forwardif.forwardB = 1;
	end

	// MEM has priority over WB, since it will just overwrite wb after
	if (forwardif.mem_regWEN && forwardif.mem_writeReg != 0 && forwardif.mem_writeReg == forwardif.rsel1) begin
		forwardif.forwardA = 2;
	end

	if (forwardif.mem_regWEN && forwardif.mem_writeReg != 0 && forwardif.mem_writeReg == forwardif.rsel2) begin
		forwardif.forwardB = 2;
	end
end

endmodule
