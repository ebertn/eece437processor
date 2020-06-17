
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
	//word_t next_pcplus4_out, next_rdat1_out, next_rdat2_out, next_immext_out, next_rt_out, next_rd_out, next_rsel1_out, next_rsel2_out, next_MemToReg_out, next_AluOp_out, next_AluSrc_out, next_JType_out, next_RegDst_out, next_regWEN_out, next_PcSrc_out, next_JReg_out, next_Halt_out, next_dMemWEN_out, next_dMemREN_out, next_InstrOp_out, next_InstrFunc_out, next_rs_out, next_instr_out, next_next_pc_out, next_imm_out, next_imm_16_out, next_shamt_out, next_writeReg_out;

	// Outputs
	word_t next_pcplus4_out, next_rdat1_out, next_rdat2_out, next_immext_out;
	regbits_t next_rt_out, next_rd_out, next_rsel1_out, next_rsel2_out;
	aluop_t next_AluOp_out;
	logic next_Atomic_out, next_MemToReg_out, next_AluSrc_out, next_JType_out, next_RegDst_out, next_regWEN_out, next_PcSrc_out, next_JReg_out, next_Halt_out, next_dMemWEN_out, next_dMemREN_out;

	//DEBUG BULLSHIT
	opcode_t next_InstrOp_out;
	funct_t next_InstrFunc_out;
	regbits_t next_rs_out;
	word_t next_instr_out, next_next_pc_out, next_imm_out;
	logic [15:0] next_imm_16_out;
	logic [4:0] next_shamt_out;

	//HAZARD BULLSHIT
	regbits_t next_writeReg_out;
	
	always_ff @(posedge CLK, negedge nRST) begin	
		if (!nRST) begin
			idex.pcplus4_out <= '0;
			idex.rdat1_out <= '0;
			idex.rdat2_out <= '0;
 			idex.immext_out <= '0;

			idex.rt_out <= '0;
			idex.rd_out <= '0;

			idex.rsel1_out <= '0;
			idex.rsel2_out <= '0;

			idex.Atomic_out <= '0;
 			idex.MemToReg_out <= '0;
 			idex.AluOp_out <= ALU_SLL;
			idex.AluSrc_out <= '0;
			idex.JType_out <= '0;
			idex.RegDst_out <= '0;
			idex.regWEN_out <= '0;
			idex.PcSrc_out <= '0;
			idex.JReg_out <= '0;
			idex.Halt_out <= '0;
			idex.dMemWEN_out <= '0;
			idex.dMemREN_out <= '0;

			//DEBUG BULLSHIT
			idex.InstrOp_out <= BEQ;
			idex.InstrFunc_out <= SLLV;
			idex.rs_out <= '0;
			idex.instr_out <= '0;
			idex.next_pc_out <= '0;
			idex.imm_out <= '0;
			idex.imm_16_out <= '0;
			idex.shamt_out <= '0;

			//HAZARD BULLSHIT
			idex.writeReg_out <= '0;
		end else begin
			idex.pcplus4_out <= next_pcplus4_out;
			idex.rdat1_out <= next_rdat1_out;
			idex.rdat2_out <= next_rdat2_out;
			idex.immext_out <= next_immext_out;
			idex.rt_out <= next_rt_out;
			idex.rd_out <= next_rd_out;
			idex.rsel1_out <= next_rsel1_out;
			idex.rsel2_out <= next_rsel2_out;

			idex.Atomic_out <= next_Atomic_out;
			idex.MemToReg_out <= next_MemToReg_out;
			idex.AluOp_out <= next_AluOp_out;
			idex.AluSrc_out <= next_AluSrc_out;
			idex.JType_out <= next_JType_out;
			idex.RegDst_out <= next_RegDst_out;
			idex.regWEN_out <= next_regWEN_out;
			idex.PcSrc_out <= next_PcSrc_out;
			idex.JReg_out <= next_JReg_out;
			idex.Halt_out <= next_Halt_out;
			idex.dMemWEN_out <= next_dMemWEN_out;
			idex.dMemREN_out <= next_dMemREN_out;
			idex.InstrOp_out <= next_InstrOp_out;
			idex.InstrFunc_out <= next_InstrFunc_out;
			idex.rs_out <= next_rs_out;
			idex.instr_out <= next_instr_out;
			idex.next_pc_out <= next_next_pc_out;
			idex.imm_out <= next_imm_out;
			idex.imm_16_out <= next_imm_16_out;
			idex.shamt_out <= next_shamt_out;
			idex.writeReg_out <= next_writeReg_out;
		end 
	end

	always_comb begin
		next_pcplus4_out = idex.pcplus4_out;
		next_rdat1_out = idex.rdat1_out;
		next_rdat2_out = idex.rdat2_out;
		next_immext_out = idex.immext_out;

		next_rt_out = idex.rt_out;
		next_rd_out = idex.rd_out;

		next_rsel1_out = idex.rsel1_out;
		next_rsel2_out = idex.rsel2_out;

		next_Atomic_out = idex.Atomic_out;
		next_MemToReg_out = idex.MemToReg_out;
		next_AluOp_out = idex.AluOp_out;
		next_AluSrc_out = idex.AluSrc_out;
		next_JType_out = idex.JType_out;
		next_RegDst_out = idex.RegDst_out;
		next_regWEN_out = idex.regWEN_out;
		next_PcSrc_out = idex.PcSrc_out;
		next_JReg_out = idex.JReg_out;
		next_Halt_out = idex.Halt_out;
		next_dMemWEN_out = idex.dMemWEN_out;
		next_dMemREN_out = idex.dMemREN_out;

		// DEBUG
		next_InstrOp_out = idex.InstrOp_out;
		next_InstrFunc_out = idex.InstrFunc_out;
		next_rs_out = idex.rs_out;
		next_instr_out = idex.instr_out;
		next_next_pc_out = idex.next_pc_out;
		next_imm_out = idex.imm_out;
		next_imm_16_out = idex.imm_16_out;
		next_shamt_out = idex.shamt_out;

		// HAZARD BULLSHIT
		next_writeReg_out = idex.writeReg_out;

		if (idex.flush) begin
			next_pcplus4_out = '0;
			next_rdat1_out = '0;
			next_rdat2_out = '0;
			next_immext_out = '0;

			next_rt_out = '0;
			next_rd_out = '0;

			next_rsel1_out = '0;
			next_rsel2_out = '0;

			next_Atomic_out = '0;
			next_MemToReg_out = '0;
			next_AluOp_out = ALU_SLL;
			next_AluSrc_out = '0;
			next_JType_out = '0;
			next_RegDst_out = '0;
			next_regWEN_out = '0;
			next_PcSrc_out = '0;
			next_JReg_out = '0;
			next_Halt_out = '0;
			next_dMemWEN_out = '0;
			next_dMemREN_out = '0;

			//DEBUG BULLSHIT
			next_InstrOp_out = BEQ;
			next_InstrFunc_out = SLLV;
			next_rs_out = '0;
			next_instr_out = '0;
			next_next_pc_out = '0;
			next_imm_out = '0;
			next_imm_16_out = '0;
			next_shamt_out = '0;

			//HAZARD BULLSHIT
			next_writeReg_out = '0;
		end else begin
			if (idex.writeEN) begin
				next_pcplus4_out = idex.pcplus4_in;
				next_rdat1_out = idex.rdat1_in;
				next_rdat2_out = idex.rdat2_in;
				next_immext_out = idex.immext_in;
				next_rt_out = idex.rt_in;
				next_rd_out = idex.rd_in;
				next_rsel1_out = idex.rsel1_in;
				next_rsel2_out = idex.rsel2_in;

				next_Atomic_out = idex.Atomic_in;
				next_MemToReg_out = idex.MemToReg_in;
				next_AluOp_out = idex.AluOp_in;
				next_AluSrc_out = idex.AluSrc_in;
				next_JType_out = idex.JType_in;
				next_RegDst_out = idex.RegDst_in;
				next_regWEN_out = idex.regWEN_in;
				next_PcSrc_out = idex.PcSrc_in;
				next_JReg_out = idex.JReg_in;
				next_Halt_out = idex.Halt_in;
				next_dMemWEN_out = idex.dMemWEN_in;
				next_dMemREN_out = idex.dMemREN_in;
				next_InstrOp_out = idex.InstrOp_in;
				next_InstrFunc_out = idex.InstrFunc_in;
				next_rs_out = idex.rs_in;
				next_instr_out = idex.instr_in;
				next_next_pc_out = idex.next_pc_in;
				next_imm_out = idex.imm_in;
				next_imm_16_out = idex.imm_16_in;
				next_shamt_out = idex.shamt_in;
				next_writeReg_out = idex.writeReg_in;
			end
		end
	end

endmodule : idex

	