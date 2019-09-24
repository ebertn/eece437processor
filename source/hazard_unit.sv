

`include "hazard_if.vh"
`include "cpu_types_pkg.vh"

module hazard_unit
(
	hazard_if hazif
); 

	import cpu_types_pkg::*;
	always_comb begin
		if (hazif.ex_writeReg == hazif.resel1)  begin 
			hazard = 1; 
		end else if (hazif.ex_writeReg == hazif.resel2) begin
			hazard = 1; 			
		end else if (hazif.mem_writeReg == hazif.resel1) begin
			hazard = 1; 
		end else if (hazif.mem_writeReg == hazif.resel2)begin
			hazard = 1; 		
		end else begin
			hazard = 0; 
		end
	end


	always_comb begin 
		if (hazif.instrOp == BEQ && hazif.equal == 1) begin
			hazif.branch = 1; 
		end else if (hazif.instrOp == BNE && hazif.equal == 0) begin
			hazif.branch = 1; 
		end else begin
			hazif.branch = 0; 
		end 
	end 


endmodule

