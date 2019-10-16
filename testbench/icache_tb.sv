`timescale 1 ns / 1 ns
`include "cpu_types_pkg.vh"
`include "caches_if.vh"
`include "datapath_cache_if.vh"
`include "cpu_ram_if.vh"
`include "system_if.vh"
import cpu_types_pkg::*;

module icache_tb; 

	parameter PERIOD = 10;
	logic CLK = 0, nRST;

	always #(PERIOD/2) CLK++;

	datapath_cache_if dcif (); 
 	caches_if cif (); 
	cpu_ram_if ramif (); 

	test PROG (CLK, nRST, dcif, cif);

	icache DUT (CLK, nRST, dcif, cif); 
	ram RAM_TEST(CLK, nRST, ramif); 

endmodule


program test(
	input logic CLK, 
	output logic nRST, 
	datapath_cache_if.cache dcif,
	caches_if cif
); 
	
	import cpu_types_pkg::*;

	int test_num;
    string test_name;

    initial begin
	@(posedge CLK);
    nRST = 0; 
	@(posedge CLK);
	nRST = 1;	
	dcif.imemaddr = 0;
	dcif.imemREN  = 0; 
 	@(posedge CLK);
	@(posedge CLK);
	@(posedge CLK);
	dcif.imemaddr = 1;
	dcif.imemREN  = 1;  
 	@(posedge CLK);
	@(posedge CLK);
	@(posedge CLK);

	end
endprogram
