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

    datapath_cache_if dcif1 ();
    caches_if cif1 ();

    datapath_cache_if dcif2 ();
    caches_if cif2 ();
//	
//	cpu_ram_if ramif ();

    test PROG (CLK, nRST, dcif1, cif1, dcif2, cif2);

    dcache DUT1 (CLK, nRST, dcif1, cif1);
	dcache DUT1 (CLK, nRST, dcif2, cif2);
	
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

    task test_read;
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
            // Hit
            //assert(dcif.dmemload == ram_data) print_passed(print);
            assert(dcif.dmemload == ram_data[0]) print_passed(print);
            assert(DUT.frames[0][req.idx].valid && DUT.frames[0][req.idx].tag == req.tag && DUT.frames[0][req.idx].data[req.blkoff] == ram_data[0] || DUT.frames[1][req.idx].valid && DUT.frames[1][req.idx].tag == req.tag && DUT.frames[1][req.idx].data[req.blkoff] == ram_data[0]) print_passed(print);
            hit = 1;
            assert(expected_hit == hit) print_passed(print);
            @(posedge CLK);
            cif.dwait = 1;
            dcif.dmemREN = 0;
            dcif.dmemWEN = 0;
            return;
        end

        @(posedge CLK);
        hit = 0; // miss
        assert(expected_hit == hit) print_passed(print);

        if(DUT.state == DUT.WRITE_BACK1) begin
            // WRITE_BACK1
            assert(DUT.frames[DUT.lru][req.idx].dirty == 1) print_passed(print);
            // Wait
            assert(cif.dWEN == 1) print_passed(print);
            assert(cif.daddr == {req[31:3], 1'b0, req[1:0]}) print_passed(print);
            assert(cif.dwait == 1) print_passed(print);

            cif.dwait = 0;

            @(posedge CLK);
            // Hit
            assert(DUT.state == DUT.WRITE_BACK2) print_passed(print);

            cif.dwait = 1;
            @(negedge CLK);

            // WRITE_BACK2
            // Wait
            assert(cif.dWEN == 1) print_passed(print);
            assert(cif.daddr == {req[31:3], 1'b0, req[1:0]}) print_passed(print);
            assert(cif.dwait == 1) print_passed(print);

            cif.dwait = 0;

            @(posedge CLK);
            // Hit
            assert(DUT.state == DUT.ALLOCATE1) print_passed(print);

            cif.dwait = 1;
            @(negedge CLK);
        end

        // ALLOCATE1
        // Wait
        assert(cif.dREN == 1) print_passed(print);
        assert(cif.daddr == {req[31:3], 1'b0, req[1:0]}) print_passed(print);
        assert(cif.dwait == 1) print_passed(print);

        cif.dwait = 0;
        cif.dload = ram_data[0];

        @(posedge CLK);
        // Hit
        assert(DUT.state == DUT.ALLOCATE2) print_passed(print);
        assert(DUT.frames[DUT.lru][req.idx].data[0] == cif.dload) print_passed(print);

        cif.dwait = 1;
        @(negedge CLK);

        // ALLOCATE2
        // Wait
        assert(cif.dREN == 1) print_passed(print);
        assert(cif.daddr == {req[31:3], 1'b1, req[1:0]}) print_passed(print);
        assert(cif.dwait == 1) print_passed(print);
        past_lru = DUT.lru;

        @(posedge CLK);
        cif.dwait = 0;
        cif.dload = ram_data[1];

        @(posedge CLK);
        // Hit
        assert(dcif.dhit == 1) print_passed(print);
        assert(dcif.dmemload == ram_data[0]) print_passed(print);

        cif.dwait = 1;
        dcif.dmemREN = 0;
        dcif.dmemWEN = 0;

//            @(posedge CLK);

        assert(DUT.state == DUT.COMPARE_TAG) print_passed(print);
        assert(past_lru == !DUT.lru) print_passed(print);
        assert(DUT.frames[!DUT.lru][req.idx].valid == 1) print_passed(print);
        assert(DUT.frames[!DUT.lru][req.idx].dirty == 0) print_passed(print);
        assert(DUT.frames[!DUT.lru][req.idx].tag == req.tag) print_passed(print);
        assert(DUT.frames[!DUT.lru][req.idx].data[1] == cif.dload) print_passed(print);

        // COMPARE_TAG
    endtask : test_read

    task test_write;
        input logic print;
        input int test_num;
        input string test_name;
        input dcachef_t req;
        input word_t store_val;
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
        dcif.dmemWEN = 1;
        dcif.dmemaddr = req; //{req[31:3], req[2:0] & 3'b011};
        dcif.dmemstore = store_val;

        @(negedge CLK);

        if (dcif.dhit) begin
            // Hit
            //assert(dcif.dmemload == ram_data) print_passed(print);
            hit = 1;
            assert(expected_hit == hit) print_passed(print);
            @(posedge CLK);
            assert(DUT.frames[0][req.idx].dirty == 1 && DUT.frames[0][req.idx].valid && DUT.frames[0][req.idx].tag == req.tag && DUT.frames[0][req.idx].data[req.blkoff] == store_val || DUT.frames[1][req.idx].dirty == 1 && DUT.frames[1][req.idx].valid && DUT.frames[1][req.idx].tag == req.tag && DUT.frames[1][req.idx].data[req.blkoff] == store_val) print_passed(print);
            assert(dcif.dmemload == store_val) print_passed(print);
            cif.dwait = 1;
            dcif.dmemREN = 0;
            dcif.dmemWEN = 0;
            return;
        end

        @(posedge CLK);
        hit = 0; // miss
        assert(expected_hit == hit) print_passed(print);

        if(DUT.state == DUT.WRITE_BACK1) begin
            // WRITE_BACK1
            assert(DUT.frames[DUT.lru][req.idx].dirty == 1) print_passed(print);
            // Wait
            assert(cif.dWEN == 1) print_passed(print);
            assert(cif.daddr == {req[31:3], 1'b0, req[1:0]}) print_passed(print);
            assert(cif.dwait == 1) print_passed(print);

            cif.dwait = 0;

            @(posedge CLK);
            // Hit
            assert(DUT.state == DUT.WRITE_BACK2) print_passed(print);

            cif.dwait = 1;
            @(negedge CLK);

            // WRITE_BACK2
            // Wait
            assert(cif.dWEN == 1) print_passed(print);
            assert(cif.daddr == {req[31:3], 1'b0, req[1:0]}) print_passed(print);
            assert(cif.dwait == 1) print_passed(print);

            cif.dwait = 0;

            @(posedge CLK);
            // Hit
            assert(DUT.state == DUT.ALLOCATE1) print_passed(print);

            cif.dwait = 1;
            @(negedge CLK);
        end

        // ALLOCATE1
        // Wait
        assert(cif.dREN == 1) print_passed(print);
        assert(cif.daddr == {req[31:3], 1'b0, req[1:0]}) print_passed(print);
        assert(cif.dwait == 1) print_passed(print);

        cif.dwait = 0;
        cif.dload = ram_data[0];

        @(posedge CLK);
        // Hit
        assert(DUT.state == DUT.ALLOCATE2) print_passed(print);
        assert(DUT.frames[DUT.lru][req.idx].data[0] == cif.dload) print_passed(print);

        cif.dwait = 1;
        @(negedge CLK);

        // ALLOCATE2
        // Wait
        assert(cif.dREN == 1) print_passed(print);
        assert(cif.daddr == {req[31:3], 1'b1, req[1:0]}) print_passed(print);
        assert(cif.dwait == 1) print_passed(print);
        past_lru = DUT.lru;

        @(posedge CLK);
        cif.dwait = 0;
        cif.dload = ram_data[1];

        @(posedge CLK);
        // Hit
        assert(dcif.dhit == 1) print_passed(print);
        assert(dcif.dmemload == store_val) print_passed(print);

        cif.dwait = 1;
        dcif.dmemREN = 0;
        dcif.dmemWEN = 0;

        assert(DUT.state == DUT.COMPARE_TAG) print_passed(print);
        assert(past_lru == !DUT.lru) print_passed(print);
        assert(DUT.frames[!DUT.lru][req.idx].valid == 1) print_passed(print);
        assert(DUT.frames[!DUT.lru][req.idx].dirty == 0) print_passed(print);
        assert(DUT.frames[!DUT.lru][req.idx].tag == req.tag) print_passed(print);
        assert(DUT.frames[!DUT.lru][req.idx].data[1] == cif.dload) print_passed(print);

        // COMPARE_TAG
    endtask : test_write

    parameter PERIOD = 10;
    int test_num;
    string test_name;

    dcachef_t req;
    word_t [1:0] ram_data;
    word_t store_val;
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
        test_name = "Test read miss";
        $display("Test %d: %s", test_num, test_name);
        req.tag = 26'h25;
        req.idx = 3'h4;
        req.blkoff = 1'b0;
        req.bytoff = 2'b00;
        ram_data[0] = 32'hAEAEAEAE;
        ram_data[1] = 32'hBCBCBCBC;
        test_read(0, test_num, test_name, req, ram_data, 0, hit);
        $display("Hit = %b", hit);
        print_passed(1);

        @(posedge CLK);

        /*=======================================================
        ==                  Test Num 1
        ========================================================*/
        test_num += 1;
        test_name = "Test read hit";
        $display("Test %d: %s", test_num, test_name);
        req.tag = 26'h25;
        req.idx = 3'h4;
        req.blkoff = 1'b0;
        req.bytoff = 2'b00;
        ram_data[0] = 32'hAEAEAEAE;
        ram_data[1] = 32'hBCBCBCBC;
        test_read(0, test_num, test_name, req, ram_data, 1, hit);
        $display("Hit = %b", hit);
        print_passed(1);

        @(posedge CLK)

        /*=======================================================
        ==                  Test Num 2
        ========================================================*/
        test_num += 1;
        test_name = "Test read compulsory, conflict, and capacity misses";
        $display("Test %d: %s", test_num, test_name);
        req.tag = 26'h25;
        req.idx = 3'h0;
        req.blkoff = 1'b0;
        req.bytoff = 2'b00;
        @(posedge CLK);
        nRST = 0;
        @(posedge CLK);
        nRST = 1;

        // Fill cache - compulsory misses
        for (int i = 0; i < 8; i++) begin
            ram_data[0] = i;
            ram_data[1] = i + 1;
            test_read(0, test_num, test_name, req, ram_data, 0, hit);
            req.idx += 1;
        end

        req.idx = 3'h1;
        req.tag = 26'h26;
        // Fill cache - compulsory misses
        for (int i = 8; i < 16; i++) begin
            ram_data[0] = i;
            ram_data[1] = i + 1;
            test_read(0, test_num, test_name, req, ram_data, 0, hit);
            req.idx += 1;
        end
        print_passed(1);
        @(posedge CLK);

        /*=======================================================
        ==                  Test Num 3
        ========================================================*/
        @(posedge CLK);
        nRST = 0;
        @(posedge CLK);
        nRST = 1;

        test_num += 1;
        test_name = "Test write miss";
        $display("Test %d: %s", test_num, test_name);
        req.tag = 26'h25;
        req.idx = 3'h4;
        req.blkoff = 1'b0;
        req.bytoff = 2'b00;
        store_val = 32'hF3F3F3F3;
        ram_data[0] = 32'hAEAEAEAE;
        ram_data[1] = 32'hBCBCBCBC;

        test_write(0, test_num, test_name, req, store_val, ram_data, 0, hit);
        $display("Hit = %b", hit);
        print_passed(1);
        @(posedge CLK);

        /*=======================================================
        ==                  Test Num 4
        ========================================================*/
        test_num += 1;
        test_name = "Test write hit";
        $display("Test %d: %s", test_num, test_name);
        req.tag = 26'h25;
        req.idx = 3'h4;
        req.blkoff = 1'b0;
        req.bytoff = 2'b00;
        store_val = 32'hF3F3F3F3;
        ram_data[0] = 32'hAEAEAEAE;
        ram_data[1] = 32'hBCBCBCBC;

        test_write(0, test_num, test_name, req, store_val, ram_data, 1, hit);
        $display("Hit = %b", hit);
        print_passed(1);
        @(posedge CLK);

        /*=======================================================
        ==                  Test Num 5
        ========================================================*/
        test_num += 1;
        test_name = "Test read hit dirty";
        $display("Test %d: %s", test_num, test_name);
        req.tag = 26'h25;
        req.idx = 3'h4;
        req.blkoff = 1'b0;
        req.bytoff = 2'b00;
        ram_data[0] = store_val;
        ram_data[1] = 32'hBCBCBCBC;
        test_read(0, test_num, test_name, req, ram_data, 1, hit);
        $display("Hit = %b", hit);
        print_passed(1);

        @(posedge CLK);

  /*=======================================================
        ==                  Test Num 6
        ========================================================*/
        test_num += 1;
        test_name = "Test read Coherence";
        $display("Test %d: %s", test_num, test_name);
        req.tag = 26'h25;
        req.idx = 3'h4;
        req.blkoff = 1'b0;
        req.bytoff = 2'b00;
        ram_data[0] = store_val;
        ram_data[1] = 32'hBCBCBCBC;
        test_read(0, test_num, test_name, req, ram_data, 1, hit);
        $display("Hit = %b", hit);
        print_passed(1);

        @(posedge CLK);

    end



endprogram : test
