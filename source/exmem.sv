`include "exmem_if.vh"
`include "cpu_types_pkg.vh"
module exmem
(
	input logic CLK,
	input logic nRST, 
	exmem_if.exmem exmem

); 
    import cpu_types_pkg::*;

	// Outputs
	word_t next_pcplus4_out, next_branchaddr_out, next_aluOutport_out, next_rdat2_out;
	regbits_t next_rt_out, next_rd_out;
	logic next_Atomic_out, next_MemToReg_out, next_JType_out, next_RegDst_out, next_regWEN_out, next_PcSrc_out, next_JReg_out, next_Halt_out, next_dMemWEN_out, next_dMemREN_out;

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
			exmem.pcplus4_out <= '0;
			//exmem.branchaddr_out <= '0;
			exmem.aluOutport_out <= '0;
			exmem.rdat2_out <= '0;

			exmem.rt_out <= '0;
			exmem.rd_out <= '0;

			exmem.Atomic_out <= 0;
			exmem.MemToReg_out <= 0; 
 			exmem.JType_out <= 0; 
			exmem.RegDst_out <= 0; 
			exmem.regWEN_out <= 0;
			exmem.PcSrc_out <= 0; 
			exmem.JReg_out <= 0; 
			exmem.Halt_out <= 0; 
			exmem.dMemWEN_out <= 0; 
			exmem.dMemREN_out <= 0; 

			//DEBUG BULLSHIT
			exmem.InstrOp_out <= BEQ; 
			exmem.InstrFunc_out <= SLLV; 
			exmem.rs_out <= 0; 
			exmem.instr_out <= 0; 
			exmem.next_pc_out <= 0; 
			exmem.imm_out <= 0;
			exmem.imm_16_out <= 0; 
			exmem.shamt_out <= 0;

			//HAZARD BULLSHIT
			exmem.writeReg_out <= 0; 

		end else begin
			exmem.pcplus4_out <= next_pcplus4_out;
			//exmem.branchaddr_out <= next_branchaddr_out;
			exmem.aluOutport_out <= next_aluOutport_out;
			exmem.rdat2_out <= next_rdat2_out;

			exmem.rt_out <= next_rt_out;
			exmem.rd_out <= next_rd_out;

			exmem.Atomic_out <= next_Atomic_out;
			exmem.MemToReg_out <= next_MemToReg_out;
			exmem.JType_out <= next_JType_out;
			exmem.RegDst_out <= next_RegDst_out;
			exmem.regWEN_out <= next_regWEN_out;
			exmem.PcSrc_out <= next_PcSrc_out;
			exmem.JReg_out <= next_JReg_out;
			exmem.Halt_out <= next_Halt_out;
			exmem.dMemWEN_out <= next_dMemWEN_out;
			exmem.dMemREN_out <= next_dMemREN_out;

			//DEBUG BULLSHIT
			exmem.InstrOp_out <= next_InstrOp_out;
			exmem.InstrFunc_out <= next_InstrFunc_out;
			exmem.rs_out <= next_rs_out;
			exmem.instr_out <= next_instr_out;
			exmem.next_pc_out <= next_next_pc_out;
			exmem.imm_out <= next_imm_out;
			exmem.imm_16_out <= next_imm_16_out;
			exmem.shamt_out <= next_shamt_out;

			//HAZARD BULLSHIT
			exmem.writeReg_out <= next_writeReg_out;
		end
	end

	always_comb begin
		if (exmem.flush) begin
			next_pcplus4_out = '0;
			//next_branchaddr_out = '0;
			next_aluOutport_out = '0;
			next_rdat2_out = '0;

			next_rt_out = '0;
			next_rd_out = '0;

			next_Atomic_out = '0;
			next_MemToReg_out = 0;
			next_JType_out = 0;
			next_RegDst_out = 0;
			next_regWEN_out = 0;
			next_PcSrc_out = 0;
			next_JReg_out = 0;
			next_Halt_out = 0;
			next_dMemWEN_out = 0;
			next_dMemREN_out = 0;

			//DEBUG BULLSHIT
			next_InstrOp_out = BEQ;
			next_InstrFunc_out = SLLV;
			next_rs_out = 0;
			next_instr_out = 0;
			next_next_pc_out = 0;
			next_imm_out = 0;
			next_imm_16_out = 0;
			next_shamt_out = 0;

			//HAZARD BULLSHIT
			next_writeReg_out = 0;

		end else begin
			next_pcplus4_out = exmem.pcplus4_out;
			//next_branchaddr_out = exmem.branchaddr_out;
			next_aluOutport_out = exmem.aluOutport_out;
			next_rdat2_out = exmem.rdat2_out;

			next_rt_out = exmem.rt_out;
			next_rd_out = exmem.rd_out;

			next_Atomic_out = exmem.Atomic_out;
			next_MemToReg_out = exmem.MemToReg_out;
			next_JType_out = exmem.JType_out;
			next_RegDst_out = exmem.RegDst_out;
			next_regWEN_out = exmem.regWEN_out;
			next_PcSrc_out = exmem.PcSrc_out;
			next_JReg_out = exmem.JReg_out;
			next_Halt_out = exmem.Halt_out;
			next_dMemWEN_out = exmem.dMemWEN_out;
			next_dMemREN_out = exmem.dMemREN_out;

			//DEBUG BULLSHIT
			next_InstrOp_out = exmem.InstrOp_out;
			next_InstrFunc_out = exmem.InstrFunc_out;
			next_rs_out = exmem.rs_out;
			next_instr_out = exmem.instr_out;
			next_next_pc_out = exmem.next_pc_out;
			next_imm_out = exmem.imm_out;
			next_imm_16_out = exmem.imm_16_out;
			next_shamt_out = exmem.shamt_out;

			// HAZARD BULLSHIT
			next_writeReg_out = exmem.writeReg_out;

			if(exmem.writeEN) begin
				next_pcplus4_out = exmem.pcplus4_in;
				//next_branchaddr_out = exmem.branchaddr_in;
				next_aluOutport_out = exmem.aluOutport_in;
				next_rdat2_out = exmem.rdat2_in;

				next_rt_out = exmem.rt_in;
				next_rd_out = exmem.rd_in;

				next_Atomic_out = exmem.Atomic_in;
				next_MemToReg_out = exmem.MemToReg_in;
				next_JType_out = exmem.JType_in;
				next_RegDst_out = exmem.RegDst_in;
				next_regWEN_out = exmem.regWEN_in;
				next_PcSrc_out = exmem.PcSrc_in;
				next_JReg_out = exmem.JReg_in;
				next_Halt_out = exmem.Halt_in;
				next_dMemWEN_out = exmem.dMemWEN_in;
				next_dMemREN_out = exmem.dMemREN_in;

				// DEBUG BULLSHIT
				next_InstrOp_out = exmem.InstrOp_in;
				next_InstrFunc_out = exmem.InstrFunc_in;
				next_rs_out = exmem.rs_in;
				next_instr_out = exmem.instr_in;
				next_next_pc_out = exmem.next_pc_in;
				next_imm_out = exmem.imm_in;
				next_imm_16_out = exmem.imm_16_in;
				next_shamt_out = exmem.shamt_in;

				// HAZARD BULLSHIT
				next_writeReg_out = exmem.writeReg_in;
			end
		end
	end

endmodule : exmem
