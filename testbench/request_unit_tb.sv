// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

// interface include
`include "request_unit_if.vh"

`include "cpu_types_pkg.vh"

import cpu_types_pkg::*;

module request_unit_tb;

    parameter PERIOD = 10;
    logic CLK = 0, nRST;

    // clock
    always #(PERIOD/2) CLK++;

    // Request Unit interface
    request_unit_if ruif();

    // test program
    test PROG (CLK, nRST, ruif);

    // DUT
    request_unit ruDUT (CLK, nRST, ruif);

endmodule

program test (
    input logic CLK,
    output logic nRST,
    request_unit_if ruif);

    import cpu_types_pkg::*;

    parameter PERIOD = 10;
    int test_num;
    string test_name;

    initial begin
        $display("Starting memory control testbench");

        test_num = -1;
        test_name = "Test Asynchronous Reset";
        $display("Test %d: %s", test_num, test_name);

        nRST = 0;
        @(posedge CLK)

        assert(ruif.imemREN == '0) $display("Passed");
        assert(ruif.dmemREN == '0) $display("Passed");
        assert(ruif.dmemWEN == '0) $display("Passed");

        nRST = 1;
        @(posedge CLK);

        /*=======================================================
        ==                  Test Num 0
        ========================================================*/
        test_num += 1;
        test_name = "Test hits are 0";
        $display("Test %d: %s", test_num, test_name);

        ruif.ihit = 0;
        ruif.dhit = 0;
        ruif.iMemRe = 0;
        ruif.dMemRe = 0;
        ruif.dMemWr = 0;

        @(posedge CLK);

        assert(ruif.imemREN == 1) $display("Passed");
        assert(ruif.dmemREN == '0) $display("Passed");
        assert(ruif.dmemWEN == '0) $display("Passed");

        /*=======================================================
        ==                  Test Num 1
        ========================================================*/
        test_num += 1;
        test_name = "Test dmemREN when dMemRe = 1 & ihit = 1";
        $display("Test %d: %s", test_num, test_name);

        ruif.ihit = 1;
        ruif.dhit = 0;
        ruif.iMemRe = 1;
        ruif.dMemRe = 1;
        ruif.dMemWr = 0;

        @(posedge CLK);

        assert(ruif.imemREN == 1) $display("Passed");
        assert(ruif.dmemREN == 1) $display("Passed");
        assert(ruif.dmemWEN == 0) $display("Passed");

        /*=======================================================
        ==                  Test Num 2
        ========================================================*/
        test_num += 1;
        test_name = "Test dmemWEN when dMemWr = 1 & ihit = 1";
        $display("Test %d: %s", test_num, test_name);

        ruif.ihit = 1;
        ruif.dhit = 0;
        ruif.iMemRe = 1;
        ruif.dMemRe = 0;
        ruif.dMemWr = 1;

        @(posedge CLK);

        assert(ruif.imemREN == 1) $display("Passed");
        assert(ruif.dmemREN == 0) $display("Passed");
        assert(ruif.dmemWEN == 1) $display("Passed");

        /*=======================================================
        ==                  Test Num 3
        ========================================================*/
        test_num += 1;
        test_name = "Test dmemWEN & dmemREN when dMemWr = 1 & dMemRe = 1 & ihit = 1";
        $display("Test %d: %s", test_num, test_name);

        ruif.ihit = 1;
        ruif.dhit = 0;
        ruif.iMemRe = 1;
        ruif.dMemRe = 1;
        ruif.dMemWr = 1;

        @(posedge CLK);

        assert(ruif.imemREN == 1) $display("Passed");
        assert(ruif.dmemREN == 1) $display("Passed");
        assert(ruif.dmemWEN == 1) $display("Passed");

        /*=======================================================
        ==                  Test Num 4
        ========================================================*/
        test_num += 1;
        test_name = "Test dhit = 1 & ihit = 1";
        $display("Test %d: %s", test_num, test_name);

        ruif.ihit = 1;
        ruif.dhit = 1;
        ruif.iMemRe = 1;
        ruif.dMemRe = 1;
        ruif.dMemWr = 1;

        @(posedge CLK);

        assert(ruif.imemREN == 1) $display("Passed");
        assert(ruif.dmemREN == 1) $display("Passed");
        assert(ruif.dmemWEN == 1) $display("Passed");

        /*=======================================================
        ==                  Test Num 5
        ========================================================*/
        test_num += 1;
        test_name = "Test dhit = 1 & ihit = 0";
        $display("Test %d: %s", test_num, test_name);

        ruif.ihit = 0;
        ruif.dhit = 1;
        ruif.iMemRe = 1;
        ruif.dMemRe = 1;
        ruif.dMemWr = 1;

        @(posedge CLK);

        assert(ruif.imemREN == 1) $display("Passed");
        assert(ruif.dmemREN == 0) $display("Passed");
        assert(ruif.dmemWEN == 0) $display("Passed");

        /*=======================================================
        ==                  Test Num 6
        ========================================================*/
        test_num += 1;
        test_name = "Coverage Base";
        $display("Test %d: %s", test_num, test_name);

        ruif.ihit = 0;
        ruif.dhit = 0;
        ruif.iMemRe = 0;
        ruif.dMemRe = 0;
        ruif.dMemWr = 0;

        @(posedge CLK);

        /*=======================================================
        ==                  Test Num 7
        ========================================================*/
        test_num += 1;
        test_name = "Coverage Up";
        $display("Test %d: %s", test_num, test_name);

        ruif.ihit = 1;
        ruif.dhit = 1;
        ruif.iMemRe = 1;
        ruif.dMemRe = 1;
        ruif.dMemWr = 1;

        @(posedge CLK);

        /*=======================================================
        ==                  Test Num 8
        ========================================================*/

        test_num += 1;
        test_name = "Test Asynchronous Reset";
        $display("Test %d: %s", test_num, test_name);

        nRST = 0;
        @(posedge CLK)

        nRST = 1;
        @(posedge CLK);


    end

endprogram : test