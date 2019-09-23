
`include "ifid_if.vh"
module ifid 
(
	input logic CLK, 
	input logic nRST, 
	ifid_if.ifid ifid

); 

	always_ff @(posedge CLK, negedge nRST) begin
		if (!nRST | ifid.flush) begin
			ifid.pcplus4_out <= 0; 
			ifid.instr_out <= 0; 
			ifid.next_pc_out <= 0; 
		end else begin
			ifid.pcplus4_out <= ifid.pcplus4_out;
			ifid.instr_out <= ifid.instr_out;
			ifid.next_pc_out <= ifid.next_pc_out; 

			if (ifid.writeEN) begin
				ifid.pcplus4_out <= ifid.pcplus4_in;
				ifid.instr_out <= ifid.instr_in;
				ifid.next_pc_out <= ifid.next_pc_in; 
			end
		end
	end

endmodule 
