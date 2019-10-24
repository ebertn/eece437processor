
`include "memwb_if.vh"
`include "cpu_types_pkg.vh"
module memwb
(
	input logic CLK, 
	input logic nRST, 
	memwb_if.memwb memwb

); 
    import cpu_types_pkg::*;

	// Outputs
	word_t next_pcplus4_out, next_aluOutport_out, next_dmemload_out;
	regbits_t next_rt_out, next_rd_out;
	logic next_MemToReg_out, next_JType_out, next_RegDst_out, next_regWEN_out, next_PcSrc_out, next_JReg_out, next_Halt_out;

	//DEBUG BULLSHIT
	opcode_t next_InstrOp_out;
	funct_t next_InstrFunc_out;
	regbits_t next_rs_out;
	word_t next_instr_out, next_next_pc_out, next_imm_out, next_branchaddr_out;
	logic [15:0] next_imm_16_out;
	logic [4:0] next_shamt_out;

	//HAZARD BULLSHIT
	regbits_t next_writeReg_out;

	always_ff @(posedge CLK, negedge nRST)begin
		if (!nRST) begin
			memwb.pcplus4_out <= '0;  
			memwb.aluOutport_out <= '0;
			memwb.dmemload_out <= '0;

			memwb.rt_out <= '0;
			memwb.rd_out <= '0;

			memwb.MemToReg_out <= 0;  
			memwb.JType_out <= 0;  
			memwb.RegDst_out <= 0;  
			memwb.regWEN_out <= 0;  
			memwb.PcSrc_out <= 0;  
			memwb.JReg_out <= 0;
			memwb.Halt_out <= 0; 
			
			//DEBUG BULLSHIT
			memwb.InstrOp_out <= BEQ; 
			memwb.InstrFunc_out <= SLLV; 
			memwb.rs_out <= 0; 
			memwb.instr_out <= 0; 
			memwb.next_pc_out <= 0; 
			memwb.imm_out <= 0;
			memwb.imm_16_out <= 0; 
			memwb.branchaddr_out <= 0; 
			memwb.shamt_out <= 0;

			//HAZARD BULLSHIT
			memwb.writeReg_out <= 0; 	
			
		end else begin
			memwb.pcplus4_out <= next_pcplus4_out;
			memwb.aluOutport_out <= next_aluOutport_out;
			memwb.dmemload_out <= next_dmemload_out;

			memwb.rt_out <= next_rt_out;
			memwb.rd_out <= next_rd_out;

			memwb.MemToReg_out <= next_MemToReg_out;
			memwb.JType_out <= next_JType_out;
			memwb.RegDst_out <= next_RegDst_out;
			memwb.regWEN_out <= next_regWEN_out;
			memwb.PcSrc_out <= next_PcSrc_out;
			memwb.JReg_out <= next_JReg_out;
			memwb.Halt_out <= next_Halt_out;

	
			//DEBUG BULLSHIT
			memwb.InstrOp_out <= next_InstrOp_out;
			memwb.InstrFunc_out <= next_InstrFunc_out;
			memwb.rs_out <= next_rs_out;
			memwb.instr_out <= next_instr_out;
			memwb.next_pc_out <= next_next_pc_out;
			memwb.imm_out <= next_imm_out;
			memwb.imm_16_out <= next_imm_16_out;
			memwb.branchaddr_out <= next_branchaddr_out;
			memwb.shamt_out <= next_shamt_out;

			//HAZARD BULLSHIT
			memwb.writeReg_out <= next_writeReg_out;
		end 
	end

	always_comb begin
		if (memwb.flush) begin
			next_pcplus4_out = '0;
			next_aluOutport_out = '0;
			next_dmemload_out = '0;
			
			next_rt_out = '0;
			next_rd_out = '0;
			
			next_MemToReg_out = 0;
			next_JType_out = 0;
			next_RegDst_out = 0;
			next_regWEN_out = 0;
			next_PcSrc_out = 0;
			next_JReg_out = 0;
			next_Halt_out = 0;
			
			// DEBUG BULLSHIT
			next_InstrOp_out = BEQ;
			next_InstrFunc_out = SLLV;
			next_rs_out = 0;
			next_instr_out = 0;
			next_next_pc_out = 0;
			next_imm_out = 0;
			next_imm_16_out = 0;
			next_branchaddr_out = 0;
			next_shamt_out = 0;
			
			// HAZARD BULLSHIT
			next_writeReg_out = 0;

		end else begin
			next_pcplus4_out = memwb.pcplus4_out;
			next_aluOutport_out = memwb.aluOutport_out;
			next_dmemload_out = memwb.dmemload_out;

			next_rt_out = memwb.rt_out;
			next_rd_out = memwb.rd_out;

			next_MemToReg_out = memwb.MemToReg_out;
			next_JType_out = memwb.JType_out;
			next_RegDst_out = memwb.RegDst_out;
			next_regWEN_out = memwb.regWEN_out;
			next_PcSrc_out = memwb.PcSrc_out;
			next_JReg_out = memwb.JReg_out;
			next_Halt_out = memwb.Halt_out;


			// DEBUG BULLSHIT
			next_InstrOp_out = memwb.InstrOp_out;
			next_InstrFunc_out = memwb.InstrFunc_out;
			next_rs_out = memwb.rs_out;
			next_instr_out = memwb.instr_out;
			next_next_pc_out = memwb.next_pc_out;
			next_imm_out = memwb.imm_out;
			next_imm_16_out = memwb.imm_16_out;
			next_branchaddr_out = memwb.branchaddr_out;
			next_shamt_out = memwb.shamt_out;

			// HAZARD BULLSHIT
			next_writeReg_out = memwb.writeReg_out;

			if (memwb.writeEN) begin
				next_pcplus4_out = memwb.pcplus4_in;
				next_aluOutport_out = memwb.aluOutport_in;
				next_dmemload_out = memwb.dmemload_in;

				next_rt_out = memwb.rt_in;
				next_rd_out = memwb.rd_in;

				next_MemToReg_out = memwb.MemToReg_in;
				next_JType_out = memwb.JType_in;
				next_RegDst_out = memwb.RegDst_in;
				next_regWEN_out = memwb.regWEN_in;
				next_PcSrc_out = memwb.PcSrc_in;
				next_JReg_out = memwb.JReg_in;
				next_Halt_out = memwb.Halt_in;

				// DEBUG BULLSHIT
				next_InstrOp_out = memwb.InstrOp_in;
				next_InstrFunc_out = memwb.InstrFunc_in;
				next_rs_out = memwb.rs_in;
				next_instr_out = memwb.instr_in;
				next_next_pc_out = memwb.next_pc_in;
				next_imm_out = memwb.imm_in;
				next_imm_16_out = memwb.imm_16_in;
				next_branchaddr_out = memwb.branchaddr_in;
				next_shamt_out = memwb.shamt_in;

				// HAZARD BULLSHIT
				next_writeReg_out = memwb.writeReg_in;
			end
		end
	end

endmodule : memwb