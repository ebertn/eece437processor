/*
  Eric Villasenor
  evillase@gmail.com

  register file test bench
*/

// mapped needs this
`include "register_file_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module register_file_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  register_file_if rfif ();
  // test program
  test PROG (CLK, nRST, rfif);
  // DUT
`ifndef MAPPED
  register_file DUT(CLK, nRST, rfif);
`else
  register_file DUT(
    .\rfif.rdat2 (rfif.rdat2),
    .\rfif.rdat1 (rfif.rdat1),
    .\rfif.wdat (rfif.wdat),
    .\rfif.rsel2 (rfif.rsel2),
    .\rfif.rsel1 (rfif.rsel1),
    .\rfif.wsel (rfif.wsel),
    .\rfif.WEN (rfif.WEN),
    .\nRST (nRST),
    .\CLK (CLK)
  );
`endif

endmodule

/*input logic CLK,
	input logic nRST, 
	register_file_if.rf rfif*/

program test(input logic CLK,
	output logic nRST, 
	register_file_if.tb rfif);

parameter PERIOD = 10;
int test_num;

initial begin
	$monitor("Starting testbench");

	nRST = 0;
	#(PERIOD);
	nRST = 1;

	test_num = 0;
	$monitor("Test asynchronous reset of registers");

	rfif.wdat = '1;
	rfif.rsel2 = '1;
	rfif.rsel1 = '1;
	rfif.wsel = '1;
	rfif.WEN = '1;

	#(2*PERIOD);
	nRST = 0;
	#(PERIOD);
//      @(posedge CLK)
	nRST = 1;

	#(PERIOD);
	
	test_num = 1;
	$monitor("Test writes to register 0");
	rfif.WEN = 1;
	rfif.wsel = 0;
	rfif.wdat = '1;
//      assert()
	#(2*PERIOD);

	nRST = 0;
	#(PERIOD);
	nRST = 1;

	test_num = 2;
	$monitor("Test Verify writes and reads to registers");
	
	for (int i = 0; i < 32; i++) begin
		rfif.WEN = 1;
		rfif.wsel = i;
		rfif.wdat = i;
		#(PERIOD);
		rfif.rsel1 = i;
		rfif.rsel2 = i;
	end

	$monitor("Test toggle all");

	for (int i = 0; i < 32; i++) begin
		rfif.WEN = 1;
		rfif.wsel = i;
		rfif.rsel1 = i;
		rfif.rsel2 = i;
		rfif.wdat = '0;
		#(PERIOD);
	end

	for (int i = 0; i < 32; i++) begin
		rfif.WEN = 1;
		rfif.wsel = i;
		rfif.rsel1 = i;
		rfif.rsel2 = i;
		rfif.wdat = '1;
		#(PERIOD);
	end
	
end

endprogram
