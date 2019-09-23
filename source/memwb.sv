
`include "memwb_if.vh"
`include "cpu_types_pkg.vh"
module memwb
(
	input logic CLK, 
	input logic nRST, 
	memwb_if.memwb memwb

); 
    import cpu_types_pkg::*;
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
			
			//DEBUG SHIT
			memwb.InstrOp_out <= BEQ; 
			memwb.InstrFunc_out <= SLLV; 
			memwb.rs_out <= 0; 
			memwb.instr_out <= 0; 
			memwb.next_pc_out <= 0; 
			memwb.imm_out <= 0;
			memwb.imm_16_out <= 0; 
			memwb.branchaddr_out <= 0; 
			memwb.shamt_out <= 0;
		end else begin
			if (memwb.writeEN) begin
				memwb.pcplus4_out <= memwb.pcplus4_in;  
				memwb.aluOutport_out <= memwb.aluOutport_in;
				memwb.dmemload_out <= memwb.dmemload_in;
	
				memwb.rt_out <= memwb.rt_in;
				memwb.rd_out <= memwb.rd_in;
	
				memwb.MemToReg_out <= memwb.MemToReg_in;  
				memwb.JType_out <= memwb.JType_in;  
				memwb.RegDst_out <= memwb.RegDst_in;
				memwb.regWEN_out <= memwb.regWEN_in;  
				memwb.PcSrc_out <= memwb.PcSrc_in;  
				memwb.JReg_out <= memwb.JReg_in;
	
	
				//DEBUG SHIT
				memwb.InstrOp_out <= memwb.InstrOp_in; 
				memwb.InstrFunc_out <= memwb.InstrFunc_in; 
				memwb.rs_out <= memwb.rs_in; 
				memwb.instr_out <= memwb.instr_in; 
				memwb.next_pc_out <= memwb.next_pc_in; 
				memwb.imm_out <= memwb.imm_in;
				memwb.imm_16_out <= memwb.imm_16_in; 
				memwb.branchaddr_out <= memwb.branchaddr_in; 
				memwb.shamt_out <= memwb.shamt_in;  
			end else begin
				memwb.pcplus4_out <= memwb.pcplus4_out;  
				memwb.aluOutport_out <= memwb.aluOutport_out;
				memwb.dmemload_out <= memwb.dmemload_out;
	
				memwb.rt_out <= memwb.rt_out;
				memwb.rd_out <= memwb.rd_out;
	
				memwb.MemToReg_out <= memwb.MemToReg_out;  
				memwb.JType_out <= memwb.JType_out;  
				memwb.RegDst_out <= memwb.RegDst_out;
				memwb.regWEN_out <= memwb.regWEN_out;  
				memwb.PcSrc_out <= memwb.PcSrc_out;  
				memwb.JReg_out <= memwb.JReg_out;
	
	
				//DEBUG SHIT
				memwb.InstrOp_out <= memwb.InstrOp_out; 
				memwb.InstrFunc_out <= memwb.InstrFunc_out; 
				memwb.rs_out <= memwb.rs_out; 
				memwb.instr_out <= memwb.instr_out; 
				memwb.next_pc_out <= memwb.next_pc_out; 
				memwb.imm_out <= memwb.imm_out;
				memwb.imm_16_out <= memwb.imm_16_out; 
				memwb.branchaddr_out <= memwb.branchaddr_out;
				memwb.shamt_out <= memwb.shamt_out; 
			end
		end 
	end 	

endmodule  