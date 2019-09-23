`include "exmem_if.vh"

module exmem
(
	input logic CLK,
	input logic nRST, 
	exmem_if.exmem exmem

); 

	always_ff @(posedge CLK, negedge nRST) begin
		if (!nRST | exmem.flush) begin
			exmem.pcplus4_out <= '0;
			exmem.branchaddr_out <= '0;
			exmem.aluOutport_out <= '0;
			exmem.rdat2_out <= '0;

			exmem.rt_out <= '0;
			exmem.rd_out <= '0;

			exmem.MemToReg_out <= 0; 
 			exmem.JType_out <= 0; 
			exmem.RegDst_out <= 0; 
			exmem.regWEN_out <= 0;
			exmem.PcSrc_out <= 0; 
			exmem.JReg_out <= 0; 
			exmem.Halt_out <= 0; 
			exmem.dMemWEN_out <= 0; 
			exmem.dMemREN_out <= 0; 
		end else begin
			exmem.pcplus4_out <= exmem.pcplus4_out;
			exmem.branchaddr_out <= exmem.branchaddr_out;
			exmem.aluOutport_out <= exmem.aluOutport_out;
			exmem.rdat2_out <= exmem.rdat2_out;

			exmem.rt_out <= exmem.rt_out;
			exmem.rd_out <= exmem.rd_out;

			exmem.MemToReg_out <= exmem.MemToReg_out;
			exmem.JType_out <= exmem.JType_out;
			exmem.RegDst_out <= exmem.RegDst_out;
			exmem.regWEN_out <= exmem.regWEN_out;
			exmem.PcSrc_out <= exmem.PcSrc_out;
			exmem.JReg_out <= exmem.JReg_out;
			exmem.Halt_out <= exmem.Halt_out;
			exmem.dMemWEN_out <= exmem.dMemWEN_out;
			exmem.dMemREN_out <= exmem.dMemREN_out;

			if(exmem.writeEN) begin
				exmem.pcplus4_out <= exmem.pcplus4_in;
				exmem.branchaddr_out <= exmem.branchaddr_in;
				exmem.aluOutport_out <= exmem.aluOutport_in;
				exmem.rdat2_out <= exmem.rdat2_in;

				exmem.rt_out <= exmem.rt_in;
				exmem.rd_out <= exmem.rd_in;

				exmem.MemToReg_out <= exmem.MemToReg_in;
				exmem.JType_out <= exmem.JType_in;
				exmem.RegDst_out <= exmem.RegDst_in;
				exmem.regWEN_out <= exmem.regWEN_in;
				exmem.PcSrc_out <= exmem.PcSrc_in;
				exmem.JReg_out <= exmem.JReg_in;
				exmem.Halt_out <= exmem.Halt_in;
				exmem.dMemWEN_out <= exmem.dMemWEN_in;
				exmem.dMemREN_out <= exmem.dMemREN_in;
			end
		end
	end

endmodule 
