module memwb
(
	input logic CLK, 
	input logic nRST, 
	memwb_if memwb

); 



	always_ff @(posedge CLK, negedge nRST)begin
		if (nRST = 0) begin
			memwb.pcplus4_out <= 0;  
			memwb.aluOutport_out <= 0;  
			memwb.MemToReg_out <= 0;  
			memwb.JType_out <= 0;  
			memwb.RegDst_out <= 0;  
			memwb.regWEN_out <= 0;  
			memwb.PcSrc_out <= 0;  
			memwb.JReg_out <= 0;  
		end else begin
			memwb.pcplus4_out <= memwb.pcplus4_in;  
			memwb.aluOutport_out <= memwb.aluOutport_in;  
			memwb.MemToReg_out <= memwb.MemToReg_in;  
			memwb.JType_out <= memwb.JType_in;  
			memwb.RegDst_out <= memwb.RegDst_in  
			memwb.regWEN_out <= memwb.regWEN_in;  
			memwb.PcSrc_out <= memwb.PcSrc_in;  
			memwb.JReg_out <= memwb.JReg_in; 
		end 
	end 	

endmodule  