
`include "memwb_if.vh"

module memwb
(
	input logic CLK, 
	input logic nRST, 
	memwb_if.memwb memwb

); 

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
		end else begin
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
		end 
	end 	

endmodule  