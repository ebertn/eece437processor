`timescale 1 ns / 1 ns
`include "cpu_types_pkg.vh"
`include "caches_if.vh"
`include "datapath_cache_if.vh"
`include "cpu_ram_if.vh"
`include "system_if.vh"
import cpu_types_pkg::*;

module dcache_tb;

    parameter PERIOD = 10;
    logic CLK = 0, nRST;

    always #(PERIOD/2) CLK++;

    datapath_cache_if dcif ();
    caches_if cif ();
//	cpu_ram_if ramif ();

    test PROG (CLK, nRST, dcif, cif);

    dcache DUT (CLK, nRST, dcif, cif);
//	ram RAM_TEST(CLK, nRST, ramif);

endmodule


program test(
    input logic CLK,
    output logic nRST,
    datapath_cache_if dcif,
    caches_if cif
);

    import cpu_types_pkg::*;

    logic past_lru;

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
        input dcachef_t req;
        input word_t [1:0] ram_data;
        input logic expected_hit;
        output logic hit;

        if (print) begin
            $display("Test %d: %s", test_num, test_name);
        end

        // Defaults
        cif.dwait = 1;
        cif.dload = 32'b0;
        dcif.dmemREN = 0;
        dcif.dmemWEN = 0;
        hit = 0;

        // Make request
        dcif.dmemREN = 1;
        dcif.dmemaddr = req; //{req[31:3], req[2:0] & 3'b011};

        @(negedge CLK);

        if (dcif.dhit) begin
            $display("Hit");
            // Hit
            //assert(dcif.dmemload == ram_data) print_passed(print);
            @(posedge CLK);
            assert(DUT.frames[!DUT.lru][req.idx].valid) print_passed(print);
            assert(DUT.frames[!DUT.lru][req.idx].tag == req.tag) print_passed(print);
            assert(DUT.frames[!DUT.lru][req.idx].data == ram_data) print_passed(print);
            hit = 1;
            assert(expected_hit == hit) print_passed(print);
            @(posedge CLK);
            return;
        end

        @(posedge CLK);
        hit = 0; // miss
        assert(expected_hit == hit) print_passed(print);

        if(DUT.state == DUT.ALLOCATE1) begin
            // ALLOCATE1
            // Wait
            assert(cif.dREN == 1) print_passed(print);
            assert(cif.daddr == req) print_passed(print);
            assert(cif.dwait == 1) print_passed(print);

            cif.dwait = 0;
            cif.dload = ram_data[1];

            @(posedge CLK);
            // Hit
            assert(DUT.state == DUT.ALLOCATE2) print_passed(print);
            assert(DUT.frames[DUT.lru][req.idx].data[0] == cif.dload) print_passed(print);

            cif.dwait = 1;
            @(negedge CLK);

            // ALLOCATE2
            // Wait
            assert(cif.dREN == 1) print_passed(print);
            assert(cif.daddr == (req + 32'd4)) print_passed(print);
            assert(cif.dwait == 1) print_passed(print);

            past_lru = DUT.lru;
            cif.dwait = 0;
            cif.dload = ram_data[1];

            @(posedge CLK);
            // Hit
            assert(dcif.dhit == 1) print_passed(print);
            assert(dcif.dmemload == ram_data[0]) print_passed(print);

            @(posedge CLK);

            assert(DUT.state == DUT.COMPARE_TAG) print_passed(print);
            assert(past_lru == !DUT.lru) print_passed(print);
            assert(DUT.frames[!DUT.lru][req.idx].valid == 1) print_passed(print);
            assert(DUT.frames[!DUT.lru][req.idx].dirty == 0) print_passed(print);
            assert(DUT.frames[!DUT.lru][req.idx].tag == req.tag) print_passed(print);
            assert(DUT.frames[!DUT.lru][req.idx].data[1] == cif.dload) print_passed(print);

            // COMPARE_TAG
            assert(dcif.dhit == 1) print_passed(print);
        end else if (DUT.state == DUT.WRITE_BACK1) begin

        end else begin
            assert(0) $error("Neither in ALLOCATE1 nor WRITE_BACK1");
        end
    endtask : query_hit_miss

    parameter PERIOD = 10;
    int test_num;
    string test_name;

    dcachef_t req;
    word_t [1:0] ram_data;
    logic hit;

    initial begin

        @(posedge CLK);
        nRST = 0;
        @(posedge CLK);
        nRST = 1;

        req = '0;

        /*=======================================================
        ==                  Test Num 0
        ========================================================*/
        test_num = 0;
        test_name = "Test miss";
        req.tag = 26'h25;
        req.idx = 3'h4;
        req.blkoff = 1'b0;
        req.bytoff = 2'b00;
        ram_data[0] = 32'hAEAEAEAE;
        ram_data[1] = 32'hBCBCBCBC;
        query_hit_miss(1, test_num, test_name, req, ram_data, 0, hit);

//        /*=======================================================
//        ==                  Test Num 1
//        ========================================================*/
//        test_num += 1;
//        test_name = "Test hit";
//        req.tag = 26'h25;
//        req.idx = 3'h4;
//        req.blkoff = 1'b0;
//        req.bytoff = 2'b00;
//        ram_data[0] = 32'hAEAEAEAE;
//        ram_data[1] = 32'hBCBCBCBC;
//        query_hit_miss(1, test_num, test_name, req, ram_data, 1, hit);
//
//        /*=======================================================
//        ==                  Test Num 2
//        ========================================================*/
//        test_num += 1;
//        test_name = "Test compulsory, conflict, and capacity misses";
//        req.tag = 26'h25;
//        req.idx = 3'h0;
//        req.blkoff = 1'b0;
//        req.bytoff = 2'b00;
//        ram_data[0] = 32'hAEAEAEAE;
//        ram_data[1] = 32'hBCBCBCBC;
//        $display("Test %d: %s", test_num, test_name);
//        @(posedge CLK);
//        nRST = 0;
//        @(posedge CLK);
//        nRST = 1;
//
//        // Fill cache - compulsory misses
//        for (int i = 0; i < 8; i++) begin
//            query_hit_miss(1, test_num, test_name, req, ram_data, 0, hit);
//            req.idx += 1;
//        end
////
////		=======================================================
////		==                  Test Num 3
////		========================================================
//        test_num += 1;
//        test_name = "Test coverage";
//        req.tag = '0;
//        req.idx = 4'h0;
//        req.bytoff = 2'b00;
//        ram_data = '0;
//        $display("Test %d: %s", test_num, test_name);
//        @(posedge CLK);
//        nRST = 0;
//        @(posedge CLK);
//        nRST = 1;
//
//        req.idx = 4'h0;
//        req.tag = '0;
//        req.bytoff = '0;
//        ram_data = '0;
//        // Fill cache - compulsory misses
//        for (int i = 0; i < 16; i++) begin
//            query_hit_miss(0, test_num, test_name, req, ram_data, 0, hit);
//            req.idx += 1;
//        end
//        req.idx = 4'h0;
//        req.tag = '1;
//        req.bytoff = '1;
//        ram_data = '1;
//        // Conflict and Capacity misses
//        for (int i = 0; i < 16; i++) begin
//            query_hit_miss(0, test_num, test_name, req, ram_data, 0, hit);
//            req.idx += 1;
//        end
//        req.idx = 4'h0;
//        req.tag = '0;
//        req.bytoff = '0;
//        ram_data = '0;
//        // Conflict and Capacity misses
//        for (int i = 0; i < 16; i++) begin
//            $display("i = %d", i);
//            query_hit_miss(0, test_num, test_name, req, ram_data, 0, hit);
//            req.idx += 1;
//        end
//        print_passed(1);
//        @(posedge CLK);

    end


endprogram : test
