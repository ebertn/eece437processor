// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

// interface include
`include "hazard_if.vh"

`include "cpu_types_pkg.vh"

import cpu_types_pkg::*;

module hazard_unit_tb;

    parameter PERIOD = 10;
    logic CLK = 0, nRST;

    // clock
    always #(PERIOD/2) CLK++;

    // Hazard Unit interface
    hazard_if hazardif();

    // test program
    test PROG (CLK, nRST, hazardif);

    // DUT
    hazard_unit huDUT (hazardif);

endmodule

program test (
    input logic CLK,
    output logic nRST,
    hazard_if hazif);

    import cpu_types_pkg::*;

    parameter PERIOD = 10;
    int test_num;
    string test_name;

    initial begin
        $display("Starting hazard unit testbench");

        /*=======================================================
        ==                  Test Num 0
        ========================================================*/
        test_num = 0;
        test_name = "Test ex_writeReg == rsel1";
        $display("Test %d: %s", test_num, test_name);

        hazif.ex_writeReg = 5;
        hazif.mem_writeReg = 20;
        hazif.rsel1 = 5;
        hazif.rsel2 = 0;

        @(posedge CLK);

        assert(hazif.hazard == 1) $display("Passed");

        /*=======================================================
        ==                  Test Num 1
        ========================================================*/
        test_num += 1;
        test_name = "Test ex_writeReg != rsel1";
        $display("Test %d: %s", test_num, test_name);

        hazif.ex_writeReg = 5;
        hazif.mem_writeReg = 20;
        hazif.rsel1 = 4;
        hazif.rsel2 = 0;

        @(posedge CLK);

        assert(hazif.hazard == 0) $display("Passed");

        /*=======================================================
        ==                  Test Num 2
        ========================================================*/
        test_num += 1;
        test_name = "Test ex_writeReg == rsel2";
        $display("Test %d: %s", test_num, test_name);

        hazif.ex_writeReg = 5;
        hazif.mem_writeReg = 20;
        hazif.rsel1 = 0;
        hazif.rsel2 = 5;

        @(posedge CLK);

        assert(hazif.hazard == 1) $display("Passed");

        /*=======================================================
        ==                  Test Num 3
        ========================================================*/
        test_num += 1;
        test_name = "Test ex_writeReg != rsel2";
        $display("Test %d: %s", test_num, test_name);

        hazif.ex_writeReg = 5;
        hazif.mem_writeReg = 20;
        hazif.rsel1 = 0;
        hazif.rsel2 = 4;

        @(posedge CLK);

        assert(hazif.hazard == 0) $display("Passed");

        /*=======================================================
        ==                  Test Num 4
        ========================================================*/
        test_num += 1;
        test_name = "Test ex_writeReg == both";
        $display("Test %d: %s", test_num, test_name);

        hazif.ex_writeReg = 5;
        hazif.mem_writeReg = 20;
        hazif.rsel1 = 5;
        hazif.rsel2 = 5;

        @(posedge CLK);

        assert(hazif.hazard == 1) $display("Passed");

        /*=======================================================
        ==                  Test Num 5
        ========================================================*/
        test_num += 1;
        test_name = "Test ex_writeReg != both";
        $display("Test %d: %s", test_num, test_name);

        hazif.ex_writeReg = 5;
        hazif.mem_writeReg = 20;
        hazif.rsel1 = 4;
        hazif.rsel2 = 4;

        @(posedge CLK);

        assert(hazif.hazard == 0) $display("Passed");

        /*=======================================================
        ==                  Test Num 6
        ========================================================*/
        test_num += 1;
        test_name = "Test ex_writeReg != both";
        $display("Test %d: %s", test_num, test_name);

        hazif.ex_writeReg = 5;
        hazif.mem_writeReg = 20;
        hazif.rsel1 = 4;
        hazif.rsel2 = 4;

        @(posedge CLK);

        assert(hazif.hazard == 0) $display("Passed");

        /*=======================================================
        ==                  Test Num 7
        ========================================================*/
        test_num += 1;
        test_name = "Test mem_writeReg == rsel1";
        $display("Test %d: %s", test_num, test_name);

        hazif.ex_writeReg = 20;
        hazif.mem_writeReg = 5;
        hazif.rsel1 = 5;
        hazif.rsel2 = 0;

        @(posedge CLK);

        assert(hazif.hazard == 1) $display("Passed");

        /*=======================================================
        ==                  Test Num 8
        ========================================================*/
        test_num += 1;
        test_name = "Test mem_writeReg != rsel1";
        $display("Test %d: %s", test_num, test_name);

        hazif.ex_writeReg = 20;
        hazif.mem_writeReg = 5;
        hazif.rsel1 = 4;
        hazif.rsel2 = 0;

        @(posedge CLK);

        assert(hazif.hazard == 0) $display("Passed");

        /*=======================================================
        ==                  Test Num 9
        ========================================================*/
        test_num += 1;
        test_name = "Test mem_writeReg == rsel2";
        $display("Test %d: %s", test_num, test_name);

        hazif.ex_writeReg = 20;
        hazif.mem_writeReg = 5;
        hazif.rsel1 = 0;
        hazif.rsel2 = 5;

        @(posedge CLK);

        assert(hazif.hazard == 1) $display("Passed");

        /*=======================================================
        ==                  Test Num 10
        ========================================================*/
        test_num += 1;
        test_name = "Test mem_writeReg != rsel2";
        $display("Test %d: %s", test_num, test_name);

        hazif.ex_writeReg = 20;
        hazif.mem_writeReg = 5;
        hazif.rsel1 = 0;
        hazif.rsel2 = 4;

        @(posedge CLK);

        assert(hazif.hazard == 0) $display("Passed");

        /*=======================================================
        ==                  Test Num 11
        ========================================================*/
        test_num += 1;
        test_name = "Test mem_writeReg == both";
        $display("Test %d: %s", test_num, test_name);

        hazif.ex_writeReg = 20;
        hazif.mem_writeReg = 5;
        hazif.rsel1 = 5;
        hazif.rsel2 = 5;

        @(posedge CLK);

        assert(hazif.hazard == 1) $display("Passed");

        /*=======================================================
        ==                  Test Num 12
        ========================================================*/
        test_num += 1;
        test_name = "Test mem_writeReg != both";
        $display("Test %d: %s", test_num, test_name);

        hazif.ex_writeReg = 20;
        hazif.mem_writeReg = 5;
        hazif.rsel1 = 4;
        hazif.rsel2 = 4;

        @(posedge CLK);

        assert(hazif.hazard == 0) $display("Passed");

        /*=======================================================
        ==                  Test Num 13
        ========================================================*/
        test_num += 1;
        test_name = "Test instrOp == BEQ && equal == 1 ";
        $display("Test %d: %s", test_num, test_name);

        hazif.instrOp = BEQ;
        hazif.equal = 1;

        @(posedge CLK);

        assert(hazif.branch == 1) $display("Passed");

        /*=======================================================
        ==                  Test Num 14
        ========================================================*/
        test_num += 1;
        test_name = "Test instrOp == BEQ && equal == 0 ";
        $display("Test %d: %s", test_num, test_name);

        hazif.instrOp = BEQ;
        hazif.equal = 0;

        @(posedge CLK);

        assert(hazif.branch == 0) $display("Passed");

        /*=======================================================
        ==                  Test Num 15
        ========================================================*/
        test_num += 1;
        test_name = "Test instrOp == BNE && equal == 1 ";
        $display("Test %d: %s", test_num, test_name);

        hazif.instrOp = BNE;
        hazif.equal = 1;

        @(posedge CLK);

        assert(hazif.branch == 0) $display("Passed");


        /*=======================================================
        ==                  Test Num 16
        ========================================================*/
        test_num += 1;
        test_name = "Test instrOp == BNE && equal == 0 ";
        $display("Test %d: %s", test_num, test_name);

        hazif.instrOp = BNE;
        hazif.equal = 0;

        @(posedge CLK);

        assert(hazif.branch == 1) $display("Passed");

        /*=======================================================
        ==                  Test Num 17
        ========================================================*/
        test_num += 1;
        test_name = "Test instrOp == J";
        $display("Test %d: %s", test_num, test_name);

        hazif.instrOp = J;

        @(posedge CLK);

        assert(hazif.jump == 1) $display("Passed");

        /*=======================================================
        ==                  Test Num 17
        ========================================================*/
        test_num += 1;
        test_name = "Test instrOp == JAL";
        $display("Test %d: %s", test_num, test_name);

        hazif.instrOp = JAL;

        @(posedge CLK);	

        assert(hazif.jump == 1) $display("Passed");

//        /*=======================================================
//        ==                  Test Num 18
//        ========================================================*/
//        test_num += 1;
//        test_name = "Test instrOp == JR";
//        $display("Test %d: %s", test_num, test_name);
//
//        hazif.instrOp = JR;
//
//        @(posedge CLK);
//
//        assert(hazif.jump == 1) $display("Passed");

        /*=======================================================
        ==                  Test Num 18
        ========================================================*/
        test_num += 1;
        test_name = "Test instrOp == Any other signal";
        $display("Test %d: %s", test_num, test_name);

        hazif.instrOp = ANDI;

        @(posedge CLK);

        assert(hazif.jump == 0) $display("Passed");
    end

endprogram : test