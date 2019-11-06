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
    caches_if cif0();
    // cif1 will not be used, but ccif expects it as an input
    caches_if cif1();
    cache_control_if #(.CPUS(2)) ccif (cif0, cif1);

    memory_control CC (CLK, nRST, ccif);

    // interface
    cpu_ram_if prif ();

    ram RAM (CLK, nRST, prif);

    // interface connections
    assign prif.memaddr = ccif.ramaddr;
    assign prif.memstore = ccif.ramstore;
    assign prif.memREN = ccif.ramREN;
    assign prif.memWEN = ccif.ramWEN;

    assign ccif.ramload = prif.ramload;
    assign ccif.ramstate = prif.ramstate;

    assign prif.ramWEN = prif.memWEN;
    assign prif.ramREN = prif.memREN;
    assign prif.ramaddr = prif.memaddr;
    assign prif.ramstore = prif.memstore;

//    assign halt = dcif0.flushed & dcif1.flushed;

    test PROG (CLK, nRST, cif0, cif1);
endmodule : bus_control_tb


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

        // Defaults
        cif0.dREN = '0;
        cif0.dWEN = '0;
        cif0.ccwrite = '0;
        cif0.dstore = '0;
        cif0.iREN = '0;
        cif0.iaddr = '0;

        cif1.dREN = '0;
        cif1.dWEN = '0;
        cif1.ccwrite = '0;
        cif1.dstore = '0;
        cif1.iREN = '0;
        cif1.iaddr = '0;

        /*=======================================================
        ==                  Test Num 0
        ========================================================*/
        test_num = 0;
        test_name = "Test write to memory";
        $display("Test %d: %s", test_num, test_name);
        cif0.dWEN = 1;
        cif0.daddr = 32'h25;
        cif0.dstore = 32'hDFDFDFDF;

        @(negedge cif0.dwait);
        @(posedge CLK);

//        assert(CC.BC.state == CC.BC.REQUEST) print_passed(1);
//        @(posedge CLK);
//        @(negedge cif0.dwait);
//        assert(CC.BC.state == CC.BC.ARBITRATE) print_passed(1);
//        assert(cif0.ccwait == 0) print_passed(1);
//        assert(cif0.ccwait == 1) print_passed(1);
//        @(posedge CLK);
//        assert(ccif.d== CC.BC.MEMORY_WB) print_passed(1);
//        assert(CC.BC.state == CC.BC.MEMORY_WB) print_passed(1);

        /*=======================================================
         ==                  Test Num 1
        ========================================================*/
        test_num += 1;
        test_name = "Test write to memory Cont";
        $display("Test %d: %s", test_num, test_name);
        cif0.dWEN = 1;
        cif0.daddr = 32'h25;
        cif0.dstore = 32'hDFDFDFDF;
//        assert(BC.state == BC.A) print_passed(1);
        @(posedge CLK);

    end






endprogram : test
