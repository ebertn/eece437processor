
`include "idex_if.vh"
`include "cpu_types_pkg.vh"

module idex
(
	input logic CLK, 
	input logic nRST, 
	idex_if.idex idex

); 

    // import types
    import cpu_types_pkg::*;
	
	always_ff @(posedge CLK, negedge nRST) begin	
		if (nRST == 0) begin
			idex.pcplus4_out <= 0;  
			idex.rdat1_out <= 0;  
			idex.rdat2_out <= 0; 
 			idex.immext_out <= 0;

			idex.rt_out <= '0;
			idex.rd_out <= '0;

 			idex.MemToReg_out <= 0; 
 			idex.AluOp_out <= ALU_SLL; 
			idex.AluSrc_out <= 0; 
			idex.JType_out <= 0;
			idex.RegDst_out <= 0;  
			idex.regWEN_out <= 0;  
			idex.PcSrc_out <= 0;  
			idex.JReg_out <= 0; 
			idex.Halt_out <= 0; 
			idex.dMemWEN_out <= 0; 
			idex.dMemREN_out <= 0; 
		end else begin
			idex.pcplus4_out <= idex.pcplus4_in; 
			idex.rdat1_out <= idex.rdat1_in; 
			idex.rdat2_out <= idex.rdat2_in; 
 			idex.immext_out <= idex.immext_in;

			idex.rt_out <= idex.rt_in;
			idex.rd_out <= idex.rd_in;

 			idex.MemToReg_out <= idex.MemToReg_in; 
 			idex.AluOp_out <= idex.AluOp_in; 
			idex.AluSrc_out <= idex.AluSrc_in; 
			idex.JType_out <= idex.JType_in;
			idex.RegDst_out <= idex.RegDst_in; 
			idex.regWEN_out <= idex.regWEN_in;  
			idex.PcSrc_out <= idex.PcSrc_in;  
			idex.JReg_out <= idex.JReg_in; 
			idex.Halt_out <= idex.Halt_in; 
			idex.dMemWEN_out <= idex.dMemWEN_in;  
			idex.dMemREN_out <= idex.dMemREN_in; 
		end 
	end

endmodule

	