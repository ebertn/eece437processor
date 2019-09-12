// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

// interface include
`include "cache_control_if.vh"
`include "caches_if.vh"

`include "cpu_types_pkg.vh"

import cpu_types_pkg::*;

module memory_control_tb;

    parameter PERIOD = 10;
    logic CLK = 0, nRST;

    // clock
    always #(PERIOD/2) CLK++;

    // coherence interface
    caches_if                 cif0();
    // cif1 will not be used, but ccif expects it as an input
    caches_if                 cif1();
    cache_control_if    #(.CPUS(1))       ccif (cif0, cif1);
    cpu_ram_if ramif();
    // test program
    test PROG (CLK, nRST, ccif);

    // DUT
    memory_control  mcDUT (CLK, nRST, ccif);
    ram             ramDUT (CLK, nRST, ramif);

    assign ramif.ramREN = ccif.ramREN;
    assign ramif.ramWEN = ccif.ramWEN;
    assign ramif.ramaddr = ccif.ramaddr;
    assign ramif.ramstore = ccif.ramstore;
    //assign ramif.ramload = ccif.ramload;
    assign ccif.ramload = ramif.ramload;
    //assign ramif.ramstate = ccif.ramstate;
    assign ccif.ramstate = ramif.ramstate;

endmodule : memory_control_tb

program test (input logic CLK,
    output logic nRST,
    cache_control_if ccif);

    import cpu_types_pkg::*;

    parameter PERIOD = 10;
    int test_num;
    string test_name;

    initial begin
        $display("Starting memory control testbench");

		test_num = -1;
        nRST = 0;
        @(posedge CLK)
        nRST = 1;

		@(posedge CLK);

		cif0.dWEN = 0;
        cif0.dREN = 0;
		cif0.iREN = 0;

		@(posedge CLK);

		// TEST 0
        test_num = 0;
		//run_test(test_num, "Test data write", CLK, 0, '0, 32'h25, cif0);
        test_name = "Test data write";
        $display("Test %d: %s", test_num, test_name);

        cif0.iREN = 0;
		cif0.dREN = 0;
        cif0.dWEN = 1;
        cif0.daddr = '0;
        cif0.dstore = 32'h25;

        @(posedge CLK);
		@(posedge CLK);

		cif0.dREN = 1;
        cif0.dWEN = 0;

		$display("dload: %h", cif0.dload);
        assert(cif0.dload == 32'h25) $display("Passed");

		@(posedge CLK) 
		@(posedge CLK)

        cif0.iREN = 0;
		cif0.dREN = 0;
        cif0.dWEN = 0;

		// TEST 1
        test_num += 1;
		//run_test(test_num, "Test data write", CLK, 0, '0, 32'h25, cif0);
        test_name = "Coverage data base";
        $display("Test %d: %s", test_num, test_name);

        cif0.iREN = 0;
		cif0.dREN = 0;
        cif0.dWEN = 1;
        cif0.daddr = '0;
        cif0.dstore = '0;

        @(posedge CLK);
		@(posedge CLK);

		cif0.dREN = 1;
        cif0.dWEN = 0;

		$display("dload: %h", cif0.dload);
        assert(cif0.dload == '0) $display("Passed");

		@(posedge CLK) 
		@(posedge CLK)

        cif0.iREN = 0;
		cif0.dREN = 0;
        cif0.dWEN = 0;

		// TEST 2
        test_num += 1;
		//run_test(test_num, "Test data write", CLK, 0, '0, 32'h25, cif0);
        test_name = "Coverage instr base";
        $display("Test %d: %s", test_num, test_name);

        cif0.iREN = 1;
		cif0.dREN = 0;
        cif0.dWEN = 0;
        cif0.iaddr = '0;

        @(posedge CLK);
		@(posedge CLK);

		$display("iload: %h", cif0.iload);
        assert(cif0.iload == '0) $display("Passed");

		@(posedge CLK) 
		@(posedge CLK)

        cif0.iREN = 0;
		cif0.dREN = 0;
        cif0.dWEN = 0;

		// TEST 3
        test_num += 1;
		//run_test(test_num, "Test data write", CLK, 0, '0, 32'h25, cif0);
        test_name = "Coverage data up";
        $display("Test %d: %s", test_num, test_name);

        cif0.iREN = 0;
		cif0.dREN = 0;
        cif0.dWEN = 1;
        cif0.daddr = '1;
        cif0.dstore = '1;

        @(posedge CLK);
		@(posedge CLK);

		cif0.dREN = 1;
        cif0.dWEN = 0;

		$display("dload: %h", cif0.dload);
        assert(cif0.dload == '1) $display("Passed");

		@(posedge CLK) 
		@(posedge CLK) 

        cif0.iREN = 0;
		cif0.dREN = 0;
        cif0.dWEN = 0;

		// TEST 4
        test_num += 1;
		//run_test(test_num, "Test data write", CLK, 0, '0, 32'h25, cif0);
        test_name = "Coverage instr up";
        $display("Test %d: %s", test_num, test_name);

        cif0.iREN = 1;
		cif0.dREN = 0;
        cif0.dWEN = 0;
        cif0.iaddr = '1;

        @(posedge CLK);
		@(posedge CLK);

		$display("iload: %h", cif0.iload);
        assert(cif0.iload == '1) $display("Passed");

		@(posedge CLK) 
		@(posedge CLK) 

        cif0.iREN = 0;
		cif0.dREN = 0;
        cif0.dWEN = 0;

		// TEST 5
        test_num += 1;
		//run_test(test_num, "Test data write", CLK, 0, '0, 32'h25, cif0);
        test_name = "Coverage data down";
        $display("Test %d: %s", test_num, test_name);

        cif0.iREN = 0;
		cif0.dREN = 0;
        cif0.dWEN = 1;
        cif0.daddr = '0;
        cif0.dstore = '0;

        @(posedge CLK);
		@(posedge CLK);

		cif0.dREN = 1;
        cif0.dWEN = 0;

		$display("dload: %h", cif0.dload);
        assert(cif0.dload == '0) $display("Passed");

		@(posedge CLK) 
		@(posedge CLK) 

        cif0.iREN = 0;
		cif0.dREN = 0;
        cif0.dWEN = 0;

		// TEST 6
        test_num += 1;
		//run_test(test_num, "Test data write", CLK, 0, '0, 32'h25, cif0);
        test_name = "Coverage instr down";
        $display("Test %d: %s", test_num, test_name);

        cif0.iREN = 1;
		cif0.dREN = 0;
        cif0.dWEN = 0;
        cif0.iaddr = '0;

        @(posedge CLK);
		@(posedge CLK);

		$display("iload: %h", cif0.iload);
        assert(cif0.iload == '0) $display("Passed");

		@(posedge CLK) 
		@(posedge CLK) 

        cif0.iREN = 0;
		cif0.dREN = 0;
        cif0.dWEN = 0;
	
		//@(posedge CLK)

		// TEST 1
        /*test_num += 1;
        test_name = "Write all 0s to data";
        $display("Test %d: %s", test_num, test_name);

        cif0.iREN = 0;
		cif0.dREN = 0;
        cif0.dWEN = 1;
		cif0.daddr = '0;
        cif0.dstore = '0;

        @(posedge CLK)

        cif0.dWEN = 0;
        cif0.dREN = 1;
		
		$display("dload: %h", cif0.dload);
        assert(cif0.dload == '0) $display("Passed");

        @(posedge CLK);

		cif0.dWEN = 0;
        cif0.dREN = 0;
		cif0.iREN = 0;

		@(posedge CLK);

        test_num += 1;
        test_name = "Write all Fs to data";
        $display("Test %d: %s", test_num, test_name);

        cif0.iREN = 1;
		cif0.dREN = 0;
        cif0.dWEN = 1;
        cif0.daddr = '0;
        cif0.dstore = 32'hFFFFFFFF;

        @(posedge CLK)

        cif0.dWEN = 0;
        cif0.dREN = 1;

        assert(cif0.dload == 32'hFFFFFFFF) $display("Passed");

		@(posedge CLK)

        test_num += 1;
        test_name = "Write 1 to addr 0";
        $display("Test %d: %s", test_num, test_name);

        cif0.iREN = 0;
		cif0.dREN = 0;
        cif0.dWEN = 1;
        cif0.daddr = '0;
        cif0.dstore = 1;

        @(posedge CLK)

        cif0.dWEN = 0;
        cif0.dREN = 1;

        assert(cif0.dload == 1) $display("Passed");

        @(posedge CLK);

        test_num += 1;
        test_name = "Write 2 to addr 4";
        $display("Test %d: %s", test_num, test_name);

        cif0.iREN = 1;
		cif0.dREN = 0;
        cif0.dWEN = 1;
        cif0.daddr = 4;
        cif0.dstore = 32'hFFFFFFFF;

        @(posedge CLK)

        cif0.dWEN = 0;
        cif0.dREN = 1;
		
		$display("daddr: %h", cif0.daddr);
		$display("dload: %h", cif0.dload);
        assert(cif0.dload == 2) $display("Passed");

        @(posedge CLK);

        test_num += 1;
        test_name = "Priority test";
        $display("Test %d: %s", test_num, test_name);

        cif0.iREN = 1;
		cif0.dREN = 0;
        cif0.dWEN = 1;
        cif0.daddr = '0;
        cif0.dstore = 32'hFFFFFFFF;

        @(posedge CLK)

        cif0.dWEN = 0;
        cif0.dREN = 1;

        assert(cif0.dload == 32'hFFFFFFFF) $display("Passed");*/


		dump_memory();
		

    end

task automatic dump_memory();
    string filename = "memcpu.hex";
    int memfd;

    cif0.daddr = 0;
    cif0.dWEN = 0;
    cif0.dREN = 0;

    memfd = $fopen(filename,"w");
    if (memfd)
      $display("Starting memory dump.");
    else
      begin $display("Failed to open %s.",filename); $finish; end

    for (int unsigned i = 0; memfd && i < 16384; i++)
    begin
      int chksum = 0;
      bit [7:0][7:0] values;
      string ihex;

      cif0.daddr = i << 2;
      cif0.dREN = 1;
      repeat (4) @(posedge CLK);
      if (cif0.dload === 0)
        continue;
      values = {8'h04,16'(i),8'h00,cif0.dload};
      foreach (values[j])
        chksum += values[j];
      chksum = 16'h100 - chksum;
      ihex = $sformatf(":04%h00%h%h",16'(i),cif0.dload,8'(chksum));
      $fdisplay(memfd,"%s",ihex.toupper());
    end //for
    if (memfd)
    begin
      cif0.dREN = 0;
      $fdisplay(memfd,":00000001FF");
      $fclose(memfd);
      $display("Finished memory dump.");
    end
  endtask

endprogram : test
