`timescale 1 ns / 1 ns
`include "cpu_types_pkg.vh"
`include "caches_if.vh"
`include "datapath_cache_if.vh"
`include "cpu_ram_if.vh"
`include "system_if.vh"
import cpu_types_pkg::*;

module bus_control_tb;

    parameter PERIOD = 10;
    logic CLK = 0, nRST;

    always #(PERIOD/2) CLK++;

    // coherence interface
    caches_if                 cif0();
    // cif1 will not be used, but ccif expects it as an input
    caches_if                 cif1();
    cache_control_if    #(.CPUS(2))       ccif (cif0, cif1);

    test PROG (CLK, nRST, cif0, cif1);

    bus_control               BC (CLK, nRST, ccif);
    memory_control            CC (CLK, nRST, ccif);
endmodule


program test(
    input logic CLK,
    output logic nRST,
    caches_if cif0,
    caches_if cif1
);

    import cpu_types_pkg::*;


    task print_passed;
        input logic print;

        if (print) begin
            $display("Passed");
        end
    endtask : print_passed

    parameter PERIOD = 10;
    int test_num;
    string test_name;

    initial begin

        @(posedge CLK);
        nRST = 0;
        @(posedge CLK);
        nRST = 1;

        /*=======================================================
        ==                  Test Num 0
        ========================================================*/
        test_num = 0;
        test_name = "Test write to memory";
        $display("Test %d: %s", test_num, test_name);
        cif0.dWEN = 1;
        cif0.daddr = 32'h25;
        cif0.dstore = 32'hDFDFDFDF;
        assert(BC.state == BC.REQUEST) print_passed(1);
        @(posedge CLK);

    end






endprogram : test
