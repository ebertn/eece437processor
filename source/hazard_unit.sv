

`include "hazard_if.vh"
`include "cpu_types_pkg.vh"

module hazard_unit
(
	hazard_if hazif
); 

	import cpu_types_pkg::*;

    always_comb begin
        hazif.hazard = 0;
		/*if (hazif.ex_dmemREN &&
            ((hazif.ex_writeReg == hazif.rsel1) ||
			(hazif.ex_writeReg == hazif.rsel2))) begin
			// LW
            hazif.hazard = 1;
			hazif.hazardifstatement = 0;
		end else*/ if (hazif.mem_dmemREN) begin
			// LW
            hazif.hazard = 1;
		end else if (hazif.mem_dmemWEN) begin
			// SW
			hazif.hazard = 1;
//		end
		end else if ((hazif.instrOp == BEQ || hazif.instrOp == BNE) &&
			(!hazif.ex_dmemWEN && // ISNT SW
			(hazif.ex_writeReg == hazif.rsel1 && hazif.ex_writeReg != 0 ||
			hazif.ex_writeReg == hazif.rsel2 && hazif.ex_writeReg != 0) ||
			!hazif.mem_dmemWEN && // ISNT SW
			(hazif.mem_writeReg == hazif.rsel1 && hazif.mem_writeReg != 0 ||
			hazif.mem_writeReg == hazif.rsel2 && hazif.mem_writeReg != 0))) begin
			hazif.hazard = 1;
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
		// Probs need JR
		hazif.jump = (hazif.instrOp == J | hazif.instrOp == JAL | (hazif.instrFunc == JR & hazif.instrOp == RTYPE));
	end


endmodule : hazard_unit

