
`include "ifid_if.vh"
`include "cpu_types_pkg.vh"
module ifid 
(
	input logic CLK, 
	input logic nRST, 
	ifid_if.ifid ifid

);

// import types
import cpu_types_pkg::*;

word_t next_pcplus4_out, next_instr_out, next_next_pc_out;

//	always_ff @(posedge CLK, negedge nRST) begin
//		if (!nRST | ifid.flush) begin
//			ifid.pcplus4_out <= 0;
//			ifid.instr_out <= 0;
//			ifid.next_pc_out <= 0;
//		end else begin
//			ifid.pcplus4_out <= ifid.pcplus4_out;
//			ifid.instr_out <= ifid.instr_out;
//			ifid.next_pc_out <= ifid.next_pc_out;
//
//			if (ifid.writeEN) begin
//				ifid.pcplus4_out <= ifid.pcplus4_in;
//				ifid.instr_out <= ifid.instr_in;
//				ifid.next_pc_out <= ifid.next_pc_in;
//			end
//		end
//	end

	always_ff @(posedge CLK, negedge nRST) begin
		if (!nRST) begin
			ifid.pcplus4_out <= 0;
			ifid.instr_out <= 0;
			ifid.next_pc_out <= 0;
		end else begin
			ifid.pcplus4_out <= next_pcplus4_out;
			ifid.instr_out <= next_instr_out;
			ifid.next_pc_out <= next_next_pc_out;
		end
	end

	always_comb begin
		if(ifid.flush) begin
			next_pcplus4_out = 0;
			next_instr_out = 0;
			next_next_pc_out = 0;
		end else begin
			next_pcplus4_out = ifid.pcplus4_out;
			next_instr_out = ifid.instr_out;
			next_next_pc_out = ifid.next_pc_out;

			if (ifid.writeEN) begin
				next_pcplus4_out = ifid.pcplus4_in;
				next_instr_out = ifid.instr_in;
				next_next_pc_out = ifid.next_pc_in;
			end
		end
	end

endmodule : ifid
