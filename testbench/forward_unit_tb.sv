// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

// interface include
`include "forward_if.vh"

`include "cpu_types_pkg.vh"

import cpu_types_pkg::*;

module forward_unit_tb;

    parameter PERIOD = 10;
	logic CLK = 0, nRST;

    // clock
    always #(PERIOD/2) CLK++;

    // forward Unit interface
    forward_if forwardif();

    // test program
    test PROG (CLK, nRST, forwardif);

    // DUT
    forward_unit huDUT (forwardif);

endmodule

program test (
    input logic CLK,
    output logic nRST,
  	forward_if forif);

    import cpu_types_pkg::*;

    //parameter PERIOD = 10;
    int test_num;
    string test_name;

    initial begin
        $display("Starting hazard unit testbench");
		forif.mem_dmemREN = 0; 
		forif.mem_dmemWEN = 0; 
		forif.wb_regWEN = 0; 
		forif.mem_regWEN = 0; 

		 @(posedge CLK);
		
        /*=======================================================
        ==                  Test Num 0
        ========================================================*/
        test_num = 0;
        test_name = "Test ex_writeReg == rsel1";
        $display("Test %d: %s", test_num, test_name);
		forif.wb_regWEN = 0; 
		forif.mem_regWEN = 1; 

        forif.mem_writeReg = 5;
        forif.wb_writeReg = 20;
        forif.rsel1 = 5;
        forif.rsel2 = 0;

        @(posedge CLK);

        //assert(orwardif.forwardA = 1;) $display("Passed");

        /*=======================================================
        ==                  Test Num 1
        ========================================================*/
        test_num += 1;
        test_name = "Test ex_writeReg != rsel1";
        $display("Test %d: %s", test_num, test_name);
		forif.wb_regWEN = 0; 
		forif.mem_regWEN = 1; 

        forif.mem_writeReg = 5;
        forif.wb_writeReg = 20;
        forif.rsel1 = 4;
        forif.rsel2 = 0;

        @(posedge CLK);

        //assert(forif.hazard == 0) $display("Passed");

        /*=======================================================
        ==                  Test Num 2
        ========================================================*/
        test_num += 1;
        test_name = "Test ex_writeReg == rsel2";
        $display("Test %d: %s", test_num, test_name);
		forif.wb_regWEN = 0; 
		forif.mem_regWEN = 1; 

		forif.mem_writeReg = 5;
        forif.wb_writeReg = 20;
        forif.rsel1 = 0;
        forif.rsel2 = 5;

        @(posedge CLK);

        //assert(hazif.hazard == 1) $display("Passed");

        /*=======================================================
        ==                  Test Num 3
        ========================================================*/
        test_num += 1;
        test_name = "Test ex_writeReg != rsel2";
        $display("Test %d: %s", test_num, test_name);
		forif.wb_regWEN = 0; 
		forif.mem_regWEN = 1; 

        forif.mem_writeReg = 5;
        forif.wb_writeReg = 20;
        forif.rsel1 = 0;
        forif.rsel2 = 4;

        @(posedge CLK);

        //assert(hazif.hazard == 0) $display("Passed");

        /*=======================================================
        ==                  Test Num 4
        ========================================================*/
        test_num += 1;
        test_name = "Test ex_writeReg == both";
        $display("Test %d: %s", test_num, test_name);
		forif.wb_regWEN = 0; 
		forif.mem_regWEN = 1; 

        forif.mem_writeReg = 5;
        forif.wb_writeReg = 20;
        forif.rsel1 = 5;
        forif.rsel2 = 5;

        @(posedge CLK);

        //assert(hazif.hazard == 1) $display("Passed");

        /*=======================================================
        ==                  Test Num 5
        ========================================================*/
        test_num += 1;
        test_name = "Test ex_writeReg != both";
        $display("Test %d: %s", test_num, test_name);
		forif.wb_regWEN = 0; 
		forif.mem_regWEN = 1; 

        forif.mem_writeReg = 5;
        forif.wb_writeReg = 20;
        forif.rsel1 = 4;
        forif.rsel2 = 4;

        @(posedge CLK);

        //assert(hazif.hazard == 0) $display("Passed");

        /*=======================================================
        ==                  Test Num 6
        ========================================================*/
        test_num += 1;
        test_name = "Test ex_writeReg != both";
        $display("Test %d: %s", test_num, test_name);
		forif.wb_regWEN = 1; 
		forif.mem_regWEN = 0; 

        forif.mem_writeReg = 20;
        forif.wb_writeReg = 5;
        forif.rsel1 = 4;
        forif.rsel2 = 4;

        @(posedge CLK);

        //assert(hazif.hazard == 0) $display("Passed");

        /*=======================================================
        ==                  Test Num 7
        ========================================================*/
        test_num += 1;
        test_name = "Test mem_writeReg == rsel1";
        $display("Test %d: %s", test_num, test_name);
		forif.wb_regWEN = 1; 
		forif.mem_regWEN = 0; 

        forif.mem_writeReg = 20;
        forif.wb_writeReg = 5;
        forif.rsel1 = 5;
        forif.rsel2 = 0;

        @(posedge CLK);

        //assert(hazif.hazard == 1) $display("Passed");

        /*=======================================================
        ==                  Test Num 8
        ========================================================*/
        test_num += 1;
        test_name = "Test mem_writeReg != rsel1";
        $display("Test %d: %s", test_num, test_name);
		forif.wb_regWEN = 1; 
		forif.mem_regWEN = 0; 

        forif.mem_writeReg = 20;
        forif.wb_writeReg = 5;
        forif.rsel1 = 4;
        forif.rsel2 = 0;

        @(posedge CLK);

        //assert(hazif.hazard == 0) $display("Passed");

        /*=======================================================
        ==                  Test Num 9
        ========================================================*/
        test_num += 1;
        test_name = "Test mem_writeReg == rsel2";
        $display("Test %d: %s", test_num, test_name);
		forif.wb_regWEN = 1; 
		forif.mem_regWEN = 0; 

        forif.mem_writeReg = 20;
        forif.wb_writeReg = 5;
        forif.rsel1 = 0;
        forif.rsel2 = 5;

        @(posedge CLK);

        //assert(hazif.hazard == 1) $display("Passed");

        /*=======================================================
        ==                  Test Num 10
        ========================================================*/
        test_num += 1;
        test_name = "Test mem_writeReg != rsel2";
        $display("Test %d: %s", test_num, test_name);
		forif.wb_regWEN = 1; 
		forif.mem_regWEN = 0; 
		
        forif.mem_writeReg = 20;
        forif.wb_writeReg = 5;
        forif.rsel1 = 0;
        forif.rsel2 = 4;

        @(posedge CLK);

        //assert(hazif.hazard == 0) $display("Passed");

        /*=======================================================
        ==                  Test Num 11
        ========================================================*/
        test_num += 1;
        test_name = "Test mem_writeReg == both";
        $display("Test %d: %s", test_num, test_name);
		forif.wb_regWEN = 1; 
		forif.mem_regWEN = 0; 

        forif.mem_writeReg = 20;
        forif.wb_writeReg = 5;
        forif.rsel1 = 5;
        forif.rsel2 = 5;

        @(posedge CLK);

        //assert(hazif.hazard == 1) $display("Passed");

        /*=======================================================
        ==                  Test Num 12
        ========================================================*/
        test_num += 1;
        test_name = "Test mem_writeReg != both";
        $display("Test %d: %s", test_num, test_name);
		forif.wb_regWEN = 1; 
		forif.mem_regWEN = 0; 
        forif.mem_writeReg = 20;
        forif.wb_writeReg = 5;
        forif.rsel1 = 4;
        forif.rsel2 = 4;

        @(posedge CLK);

        //assert(hazif.hazard == 0) $display("Passed");

 end

endprogram

