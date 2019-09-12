// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

// interface include
`include "control_unit_if.vh"

`include "cpu_types_pkg.vh"

import cpu_types_pkg::*;

module control_unit_tb;

    parameter PERIOD = 10;
    logic CLK = 0, nRST;

    // clock
    always #(PERIOD/2) CLK++;

    // Control Unit interface
    control_unit_if cuif();

    // test program
    test PROG (cuif);

    // DUT
    control_unit  cuDUT (cuif);

endmodule : memory_control_tb

program test (
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

        // TEST 0
        test_num = 0;
        //run_test(test_num, "Test data write", CLK, 0, '0, 32'h25, cif0);
        test_name = "Test data write";
        $display("Test %d: %s", test_num, test_name);

    end
endprogram : test

task setDefaults()