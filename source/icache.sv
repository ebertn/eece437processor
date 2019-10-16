
`include "cpu_types_pkg.vh"
`include "caches_if.vh"
`include "datapath_cache_if.vh"

module icache (
	input logic CLK, nRST, 
	datapath_cache_if.cache dcif,
	caches_if cif
); 

	import cpu_types_pkg::*;
	 	

	word_t [15:0] addresses, data;
	word_t [15:0] next_addresses, next_data;  

	always_ff @(posedge CLK, negedge nRST) begin
		if (nRST == 0) begin
			addresses <= '0; 
			data <= '0; 
		end else begin
			addresses <= next_addresses; 
			data <= next_data; 
		end
	end
	

	always_comb begin
		next_addresses = addresses; 
		next_data = data; 
		dcif.ihit = 0; 
		dcif.imemload = '0; 
		cif.iREN = 0;  
	
		if (addresses[dcif.imemaddr[5:2]][31] == 0 && dcif.imemREN == 1) begin //Miss
			next_addresses[dcif.imemaddr[5:2]] = {1'b1,5'b00000, dcif.imemaddr[31:6]};
			cif.iREN = 1; 
			cif.iaddr = dcif.imemaddr; 
			dcif.imemload = cif.iload; 
			next_data[dcif.imemaddr[5:2]] = cif.iload; 
		end else if(addresses[dcif.imemaddr[5:2]][31] == 1 && dcif.imemREN == 1) begin //Hit
			dcif.ihit = 1;
			dcif.imemload = data[dcif.imemaddr[5:2]]; 
		end 
			
			   
			 
	end
	
endmodule

