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
//	cpu_ram_if ramif ();

	test PROG (CLK, nRST, dcif, cif);

	icache DUT (CLK, nRST, dcif, cif); 
//	ram RAM_TEST(CLK, nRST, ramif);

endmodule


program test(
	input logic CLK, 
	output logic nRST, 
	datapath_cache_if dcif,
	caches_if cif
);

	import cpu_types_pkg::*;

	task print_passed;
		input logic print;

		if (print) begin
			$display("Passed");
		end
	endtask : print_passed

	task query_hit_miss;
		input logic print;
		input int test_num;
		input string test_name;
		input icachef_t req;
		input word_t ram_data;
		input logic expected_hit;
		output logic hit;

		if (print) begin
			$display("Test %d: %s", test_num, test_name);
		end

		// Defaults
		cif.iwait = 1;
		cif.iload = 32'b0;
		hit = 0;

		// Make request
		dcif.imemREN = 1;
		dcif.imemaddr = req;

		@(negedge CLK);

		if (dcif.ihit) begin
			$display("Hit");
			// Hit
			assert(dcif.imemload == ram_data) print_passed(print);
			assert(DUT.frames[req.idx].valid == 1) print_passed(print);
			assert(DUT.frames[req.idx].tag == req.tag) print_passed(print);
			assert(DUT.frames[req.idx].data == ram_data) print_passed(print);
			hit = 1;
			assert(expected_hit == hit) print_passed(print);
			return;
		end

		@(posedge CLK);
		hit = 0; // miss
		assert(expected_hit == hit) print_passed(print);

		assert(cif.iREN == 1) print_passed(print);
		assert(cif.iaddr == req) print_passed(print);

		// Wait some time
		@(posedge CLK);
		@(posedge CLK);

		// Set ram values
		cif.iwait = 0;
		cif.iload = ram_data;

		@(negedge CLK);

		assert(dcif.ihit == 1) print_passed(print);
		assert(dcif.imemload == ram_data) print_passed(print);

		// Wait for frame to write
		@(posedge CLK);

		assert(DUT.frames[req.idx].valid == 1) print_passed(print);
		assert(DUT.frames[req.idx].tag == req.tag) print_passed(print);
		assert(DUT.frames[req.idx].data == ram_data) print_passed(print);
	endtask

	parameter PERIOD = 10;
	int test_num;
	string test_name;

	icachef_t req;
	word_t ram_data;
	logic hit;

	initial begin

	@(posedge CLK);
    nRST = 0; 
	@(posedge CLK);
	nRST = 1;

		/*=======================================================
		==                  Test Num 0
		========================================================*/
		test_num = 0;
		test_name = "Test miss";
		req.tag = 26'h25;
		req.idx = 4'h4;
		req.bytoff = 2'b00;
		ram_data = 32'hAEAEAEAE;
		query_hit_miss(1, test_num, test_name, req, ram_data, 0, hit);

		/*=======================================================
		==                  Test Num 1
		========================================================*/
		test_num += 1;
		test_name = "Test hit";
		req.tag = 26'h25;
		req.idx = 4'h4;
		req.bytoff = 2'b00;
		ram_data = 32'hAEAEAEAE;
		query_hit_miss(1, test_num, test_name, req, ram_data, 1, hit);

		/*=======================================================
		==                  Test Num 2
		========================================================*/
		test_num += 1;
		test_name = "Test compulsory, conflict, and capacity misses";
		req.tag = 26'h25;
		req.idx = 4'h0;
		req.bytoff = 2'b00;
		ram_data = 32'hAEAEAEAE;
		$display("Test %d: %s", test_num, test_name);
		@(posedge CLK);
		nRST = 0;
		@(posedge CLK);
		nRST = 1;

		// Fill cache - compulsory misses
		for (int i = 0; i < 16; i++) begin
			query_hit_miss(0, test_num, test_name, req, ram_data, 0, hit);
			req.idx += 1;
		end
		req.tag = 26'h26;
		// Conflict and Capacity misses
		for (int i = 0; i < 16; i++) begin
			query_hit_miss(0, test_num, test_name, req, ram_data, 0, hit);
			req.idx += 1;
		end
		req.idx = 0; 
		for (int i = 0; i < 16; i++) begin
			query_hit_miss(0, test_num, test_name, req, ram_data, 0, hit);
			req.idx += 1;
		end
		print_passed(1);

//		=======================================================
//		==                  Test Num 3
//		========================================================
		test_num += 1;
		test_name = "Test coverage";
		req.tag = '0;
		req.idx = 4'h0;
		req.bytoff = 2'b00;
		ram_data = '0;
		
		$display("Test %d: %s", test_num, test_name);
		@(posedge CLK);
		nRST = 0;
		@(posedge CLK);
		nRST = 1;

		req.idx = 4'h0;
		req.tag = '0;
		req.bytoff = '0;
		ram_data = '0;
		// Fill cache - compulsory misses
		for (int i = 0; i < 16; i++) begin
			query_hit_miss(0, test_num, test_name, req, ram_data, 0, hit);
			req.idx += 1;
		end
		req.idx = 4'h0;
		req.tag = '1;
		req.bytoff = '1;
		ram_data = '1;
		// Conflict and Capacity misses
		for (int i = 0; i < 16; i++) begin
			query_hit_miss(0, test_num, test_name, req, ram_data, 0, hit);
			req.idx += 1;
		end
		req.idx = 4'h0;
		req.tag = '0;
		req.bytoff = '0;
		ram_data = '0;
		// Conflict and Capacity misses
		for (int i = 0; i < 16; i++) begin
			$display("i = %d", i);
			query_hit_miss(0, test_num, test_name, req, ram_data, 0, hit);
			req.idx += 1;
		end
		print_passed(1);
		@(posedge CLK);

		

	end

endprogram : test
