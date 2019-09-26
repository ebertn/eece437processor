

`include "hazard_if.vh"
`include "cpu_types_pkg.vh"

module hazard_unit
(
	hazard_if hazif
); 

	import cpu_types_pkg::*;
	always_comb begin
		if (hazif.ex_writeReg == hazif.rsel1 && hazif.ex_writeReg != 0 && !hazif.branch == 1)  begin 
			hazif.hazard = 1; 
		end else if (hazif.ex_writeReg == hazif.rsel2 && hazif.ex_writeReg != 0 && !hazif.branch == 1) begin
			hazif.hazard = 1; 			
		end else if (hazif.mem_writeReg == hazif.rsel1 && hazif.mem_writeReg != 0 && !hazif.branch == 1) begin
			hazif.hazard = 1; 
		end else if (hazif.mem_writeReg == hazif.rsel2 && hazif.mem_writeReg != 0 && !hazif.branch == 1)begin
			hazif.hazard = 1; 		
		end else begin
			hazif.hazard = 0; 
		end
	end


	always_comb begin 
		if (hazif.instrOp == BEQ && hazif.equal == 1 /*&& hazif.rsel1 != 0*/) begin
			hazif.branch = 1; 
		end else if (hazif.instrOp == BNE && hazif.equal == 0 /*&& hazif.rsel1 != 0*/) begin
			hazif.branch = 1; 
		end else begin
			hazif.branch = 0; 
		end 
	end

	always_comb begin
		hazif.jump = (hazif.instrOp == J | hazif.instrOp == JAL);
	end


endmodule : hazard_unit

