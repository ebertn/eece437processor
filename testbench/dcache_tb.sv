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


    test PROG (CLK, nRST, dcif1, cif1, dcif2, cif2);

    dcache DUT1 (CLK, nRST, dcif1, cif1);
	dcache DUT2 (CLK, nRST, dcif2, cif2);
	
	cache_control_if #(.CPUS(2)) ccif (cif1, cif2);

 	cpu_ram_if prif ();

    ram RAM (CLK, nRST, prif);

	memory_control CC (CLK, nRST, ccif);

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


endmodule


program test(
    input logic CLK,
    output logic nRST,
    datapath_cache_if dcif1,
    caches_if cif1, 
	datapath_cache_if dcif2,
    caches_if cif2

);

    import cpu_types_pkg::*;

    logic past_lru;

    task print_passed;
        input logic print;

        if (print) begin
            $display("Passed");
        end
    endtask : print_passed

    task test_read1;
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
        cif1.dwait = 1;
        cif1.dload = 32'b0;
        dcif1.dmemREN = 0;
        dcif1.dmemWEN = 0;
        hit = 0;

        // Make request
        dcif1.dmemREN = 1;
        dcif1.dmemaddr = req; //{req[31:3], req[2:0] & 3'b011};

        @(negedge CLK);
		
        if (dcif1.dhit) begin
            // Hit
            //assert(dcif.dmemload == ram_data) print_passed(print);
            assert(dcif1.dmemload == ram_data[0]) print_passed(print);
            assert(DUT1.frames[0][req.idx].valid && DUT1.frames[0][req.idx].tag == req.tag && DUT1.frames[0][req.idx].data[req.blkoff] == ram_data[0] || DUT1.frames[1][req.idx].valid && DUT1.frames[1][req.idx].tag == req.tag && DUT1.frames[1][req.idx].data[req.blkoff] == ram_data[0]) print_passed(print);
            hit = 1;
            assert(expected_hit == hit) print_passed(print);
            @(posedge CLK);
            cif1.dwait = 1;
            dcif1.dmemREN = 0;
            dcif1.dmemWEN = 0;
            return;
        end

        @(posedge CLK);
        hit = 0; // miss
        assert(expected_hit == hit) print_passed(print);

        if(DUT1.state == DUT1.WRITE_BACK1) begin
            // WRITE_BACK1
            assert(DUT1.frames[DUT1.lru][req.idx].dirty == 1) print_passed(print);
            // Wait
            assert(cif1.dWEN == 1) print_passed(print);
            assert(cif1.daddr == {req[31:3], 1'b0, req[1:0]}) print_passed(print);
            assert(cif1.dwait == 1) print_passed(print);

            cif1.dwait = 0;

            @(posedge CLK);
            // Hit
            assert(DUT1.state == DUT1.WRITE_BACK2) print_passed(print);

            cif1.dwait = 1;
            @(negedge CLK);

            // WRITE_BACK2
            // Wait
            assert(cif1.dWEN == 1) print_passed(print);
            assert(cif1.daddr == {req[31:3], 1'b0, req[1:0]}) print_passed(print);
            assert(cif1.dwait == 1) print_passed(print);

            cif1.dwait = 0;

            @(posedge CLK);
            // Hit
            assert(DUT1.state == DUT1.ALLOCATE1) print_passed(print);

            cif1.dwait = 1;
            @(negedge CLK);
        end

        // ALLOCATE1
        // Wait
        assert(cif1.dREN == 1) print_passed(print);
        assert(cif1.daddr == {req[31:3], 1'b0, req[1:0]}) print_passed(print);
        assert(cif1.dwait == 1) print_passed(print);

        cif1.dwait = 0;
        cif1.dload = ram_data[0];

        @(posedge CLK);
        // Hit
        assert(DUT1.state == DUT1.ALLOCATE2) print_passed(print);
        assert(DUT1.frames[DUT1.lru][req.idx].data[0] == cif1.dload) print_passed(print);

        cif1.dwait = 1;
        @(negedge CLK);

        // ALLOCATE2
        // Wait
        assert(cif1.dREN == 1) print_passed(print);
        assert(cif1.daddr == {req[31:3], 1'b1, req[1:0]}) print_passed(print);
        assert(cif1.dwait == 1) print_passed(print);
        past_lru = DUT1.lru;

        @(posedge CLK);
        cif1.dwait = 0;
        cif1.dload = ram_data[1];

        @(posedge CLK);
        // Hit
        assert(dcif1.dhit == 1) print_passed(print);
        assert(dcif1.dmemload == ram_data[0]) print_passed(print);

        cif1.dwait = 1;
        dcif1.dmemREN = 0;
        dcif1.dmemWEN = 0;

//            @(posedge CLK);

        assert(DUT1.state == DUT1.COMPARE_TAG) print_passed(print);
        assert(past_lru == !DUT1.lru) print_passed(print);
        assert(DUT1.frames[!DUT1.lru][req.idx].valid == 1) print_passed(print);
        assert(DUT1.frames[!DUT1.lru][req.idx].dirty == 0) print_passed(print);
        assert(DUT1.frames[!DUT1.lru][req.idx].tag == req.tag) print_passed(print);
        assert(DUT1.frames[!DUT1.lru][req.idx].data[1] == cif1.dload) print_passed(print);

        // COMPARE_TAG
    endtask : test_read1

    task test_write1;
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
        cif1.dwait = 1;
        cif1.dload = 32'b0;
        dcif1.dmemREN = 0;
        dcif1.dmemWEN = 0;
        hit = 0;

        // Make request
        dcif1.dmemWEN = 1;
        dcif1.dmemaddr = req; //{req[31:3], req[2:0] & 3'b011};
        dcif1.dmemstore = store_val;

        @(negedge CLK);

        if (dcif1.dhit) begin
            // Hit
            //assert(dcif.dmemload == ram_data) print_passed(print);
            hit = 1;
            assert(expected_hit == hit) print_passed(print);
            @(posedge CLK);
            assert(DUT1.frames[0][req.idx].dirty == 1 && DUT1.frames[0][req.idx].valid && DUT1.frames[0][req.idx].tag == req.tag && DUT1.frames[0][req.idx].data[req.blkoff] == store_val || DUT1.frames[1][req.idx].dirty == 1 && DUT1.frames[1][req.idx].valid && DUT1.frames[1][req.idx].tag == req.tag && DUT1.frames[1][req.idx].data[req.blkoff] == store_val) print_passed(print);
            assert(dcif1.dmemload == store_val) print_passed(print);
            cif1.dwait = 1;
            dcif1.dmemREN = 0;
            dcif1.dmemWEN = 0;
            return;
        end

        @(posedge CLK);
        hit = 0; // miss
        assert(expected_hit == hit) print_passed(print);

        if(DUT1.state == DUT1.WRITE_BACK1) begin
            // WRITE_BACK1
            assert(DUT1.frames[DUT1.lru][req.idx].dirty == 1) print_passed(print);
            // Wait
            assert(cif1.dWEN == 1) print_passed(print);
            assert(cif1.daddr == {req[31:3], 1'b0, req[1:0]}) print_passed(print);
            assert(cif1.dwait == 1) print_passed(print);

            cif1.dwait = 0;

            @(posedge CLK);
            // Hit
            assert(DUT1.state == DUT1.WRITE_BACK2) print_passed(print);

            cif1.dwait = 1;
            @(negedge CLK);

            // WRITE_BACK2
            // Wait
            assert(cif1.dWEN == 1) print_passed(print);
            assert(cif1.daddr == {req[31:3], 1'b0, req[1:0]}) print_passed(print);
            assert(cif1.dwait == 1) print_passed(print);

            cif1.dwait = 0;

            @(posedge CLK);
            // Hit
            assert(DUT1.state == DUT1.ALLOCATE1) print_passed(print);

            cif1.dwait = 1;
            @(negedge CLK);
        end

        // ALLOCATE1
        // Wait
        assert(cif1.dREN == 1) print_passed(print);
        assert(cif1.daddr == {req[31:3], 1'b0, req[1:0]}) print_passed(print);
        assert(cif1.dwait == 1) print_passed(print);

        cif1.dwait = 0;
        cif1.dload = ram_data[0];

        @(posedge CLK);
        // Hit
        assert(DUT1.state == DUT1.ALLOCATE2) print_passed(print);
        assert(DUT1.frames[DUT1.lru][req.idx].data[0] == cif1.dload) print_passed(print);

        cif1.dwait = 1;
        @(negedge CLK);

        // ALLOCATE2
        // Wait
        assert(cif1.dREN == 1) print_passed(print);
        assert(cif1.daddr == {req[31:3], 1'b1, req[1:0]}) print_passed(print);
        assert(cif1.dwait == 1) print_passed(print);
        past_lru = DUT1.lru;

        @(posedge CLK);
        cif1.dwait = 0;
        cif1.dload = ram_data[1];

        @(posedge CLK);
        // Hit
        assert(dcif1.dhit == 1) print_passed(print);
        assert(dcif1.dmemload == store_val) print_passed(print);

        cif1.dwait = 1;
        dcif1.dmemREN = 0;
        dcif1.dmemWEN = 0;

        assert(DUT1.state == DUT1.COMPARE_TAG) print_passed(print);
        assert(past_lru == !DUT1.lru) print_passed(print);
        assert(DUT1.frames[!DUT1.lru][req.idx].valid == 1) print_passed(print);
        assert(DUT1.frames[!DUT1.lru][req.idx].dirty == 0) print_passed(print);
        assert(DUT1.frames[!DUT1.lru][req.idx].tag == req.tag) print_passed(print);
        assert(DUT1.frames[!DUT1.lru][req.idx].data[1] == cif1.dload) print_passed(print);

        // COMPARE_TAG
    endtask : test_write1

    task test_read2;
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
        cif2.dwait = 1;
        cif2.dload = 32'b0;
        dcif2.dmemREN = 0;
        dcif2.dmemWEN = 0;
        hit = 0;

        // Make request
        dcif2.dmemREN = 1;
        dcif2.dmemaddr = req; //{req[31:3], req[2:0] & 3'b011};

        @(negedge CLK);
		
        if (dcif2.dhit) begin
            // Hit
            //assert(dcif.dmemload == ram_data) print_passed(print);
            assert(dcif2.dmemload == ram_data[0]) print_passed(print);
            assert(DUT2.frames[0][req.idx].valid && DUT2.frames[0][req.idx].tag == req.tag && DUT2.frames[0][req.idx].data[req.blkoff] == ram_data[0] || DUT2.frames[1][req.idx].valid && DUT2.frames[1][req.idx].tag == req.tag && DUT2.frames[1][req.idx].data[req.blkoff] == ram_data[0]) print_passed(print);
            hit = 1;
            assert(expected_hit == hit) print_passed(print);
            @(posedge CLK);
            cif2.dwait = 1;
            dcif2.dmemREN = 0;
            dcif2.dmemWEN = 0;
            return;
        end

        @(posedge CLK);
        hit = 0; // miss
        assert(expected_hit == hit) print_passed(print);

        if(DUT2.state == DUT2.WRITE_BACK1) begin
            // WRITE_BACK1
            assert(DUT2.frames[DUT2.lru][req.idx].dirty == 1) print_passed(print);
            // Wait
            assert(cif2.dWEN == 1) print_passed(print);
            assert(cif2.daddr == {req[31:3], 1'b0, req[1:0]}) print_passed(print);
            assert(cif2.dwait == 1) print_passed(print);

            cif2.dwait = 0;

            @(posedge CLK);
            // Hit
            assert(DUT2.state == DUT2.WRITE_BACK2) print_passed(print);

            cif2.dwait = 1;
            @(negedge CLK);

            // WRITE_BACK2
            // Wait
            assert(cif2.dWEN == 1) print_passed(print);
            assert(cif2.daddr == {req[31:3], 1'b0, req[1:0]}) print_passed(print);
            assert(cif2.dwait == 1) print_passed(print);

            cif2.dwait = 0;

            @(posedge CLK);
            // Hit
            assert(DUT2.state == DUT2.ALLOCATE1) print_passed(print);

            cif2.dwait = 1;
            @(negedge CLK);
        end

        // ALLOCATE1
        // Wait
        assert(cif2.dREN == 1) print_passed(print);
        assert(cif2.daddr == {req[31:3], 1'b0, req[1:0]}) print_passed(print);
        assert(cif2.dwait == 1) print_passed(print);

        cif2.dwait = 0;
        cif2.dload = ram_data[0];

        @(posedge CLK);
        // Hit
        assert(DUT2.state == DUT2.ALLOCATE2) print_passed(print);
        assert(DUT2.frames[DUT2.lru][req.idx].data[0] == cif1.dload) print_passed(print);

        cif2.dwait = 1;
        @(negedge CLK);

        // ALLOCATE2
        // Wait
        assert(cif2.dREN == 1) print_passed(print);
        assert(cif2.daddr == {req[31:3], 1'b1, req[1:0]}) print_passed(print);
        assert(cif2.dwait == 1) print_passed(print);
        past_lru = DUT2.lru;

        @(posedge CLK);
        cif2.dwait = 0;
        cif2.dload = ram_data[1];

        @(posedge CLK);
        // Hit
        assert(dcif2.dhit == 1) print_passed(print);
        assert(dcif2.dmemload == ram_data[0]) print_passed(print);

        cif2.dwait = 1;
        dcif2.dmemREN = 0;
        dcif2.dmemWEN = 0;

//            @(posedge CLK);

        assert(DUT2.state == DUT2.COMPARE_TAG) print_passed(print);
        assert(past_lru == !DUT2.lru) print_passed(print);
        assert(DUT2.frames[!DUT2.lru][req.idx].valid == 1) print_passed(print);
        assert(DUT2.frames[!DUT2.lru][req.idx].dirty == 0) print_passed(print);
        assert(DUT2.frames[!DUT2.lru][req.idx].tag == req.tag) print_passed(print);
        assert(DUT2.frames[!DUT2.lru][req.idx].data[1] == cif2.dload) print_passed(print);

        // COMPARE_TAG
    endtask : test_read2

    task test_write2;
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
        cif2.dwait = 1;
        cif2.dload = 32'b0;
        dcif2.dmemREN = 0;
        dcif2.dmemWEN = 0;
        hit = 0;

        // Make request
        dcif2.dmemWEN = 1;
        dcif2.dmemaddr = req; //{req[31:3], req[2:0] & 3'b011};
        dcif2.dmemstore = store_val;

        @(negedge CLK);

        if (dcif2.dhit) begin
            // Hit
            //assert(dcif.dmemload == ram_data) print_passed(print);
            hit = 1;
            assert(expected_hit == hit) print_passed(print);
            @(posedge CLK);
            assert(DUT2.frames[0][req.idx].dirty == 1 && DUT2.frames[0][req.idx].valid && DUT2.frames[0][req.idx].tag == req.tag && DUT2.frames[0][req.idx].data[req.blkoff] == store_val || DUT2.frames[1][req.idx].dirty == 1 && DUT2.frames[1][req.idx].valid && DUT2.frames[1][req.idx].tag == req.tag && DUT2.frames[1][req.idx].data[req.blkoff] == store_val) print_passed(print);
            assert(dcif2.dmemload == store_val) print_passed(print);
            cif2.dwait = 1;
            dcif2.dmemREN = 0;
            dcif2.dmemWEN = 0;
            return;
        end

        @(posedge CLK);
        hit = 0; // miss
        assert(expected_hit == hit) print_passed(print);

        if(DUT2.state == DUT2.WRITE_BACK1) begin
            // WRITE_BACK1
            assert(DUT2.frames[DUT2.lru][req.idx].dirty == 1) print_passed(print);
            // Wait
            assert(cif2.dWEN == 1) print_passed(print);
            assert(cif2.daddr == {req[31:3], 1'b0, req[1:0]}) print_passed(print);
            assert(cif2.dwait == 1) print_passed(print);

            cif2.dwait = 0;

            @(posedge CLK);
            // Hit
            assert(DUT2.state == DUT2.WRITE_BACK2) print_passed(print);

            cif2.dwait = 1;
            @(negedge CLK);

            // WRITE_BACK2
            // Wait
            assert(cif2.dWEN == 1) print_passed(print);
            assert(cif2.daddr == {req[31:3], 1'b0, req[1:0]}) print_passed(print);
            assert(cif2.dwait == 1) print_passed(print);

            cif2.dwait = 0;

            @(posedge CLK);
            // Hit
            assert(DUT2.state == DUT2.ALLOCATE1) print_passed(print);

            cif2.dwait = 1;
            @(negedge CLK);
        end

        // ALLOCATE1
        // Wait
        assert(cif2.dREN == 1) print_passed(print);
        assert(cif2.daddr == {req[31:3], 1'b0, req[1:0]}) print_passed(print);
        assert(cif2.dwait == 1) print_passed(print);

        cif2.dwait = 0;
        cif2.dload = ram_data[0];

        @(posedge CLK);
        // Hit
        assert(DUT2.state == DUT2.ALLOCATE2) print_passed(print);
        assert(DUT2.frames[DUT2.lru][req.idx].data[0] == cif2.dload) print_passed(print);

        cif2.dwait = 1;
        @(negedge CLK);

        // ALLOCATE2
        // Wait
        assert(cif2.dREN == 1) print_passed(print);
        assert(cif2.daddr == {req[31:3], 1'b1, req[1:0]}) print_passed(print);
        assert(cif2.dwait == 1) print_passed(print);
        past_lru = DUT2.lru;

        @(posedge CLK);
        cif2.dwait = 0;
        cif2.dload = ram_data[1];

        @(posedge CLK);
        // Hit
        assert(dcif2.dhit == 1) print_passed(print);
        assert(dcif2.dmemload == store_val) print_passed(print);

        cif2.dwait = 1;
        dcif2.dmemREN = 0;
        dcif2.dmemWEN = 0;

        assert(DUT2.state == DUT2.COMPARE_TAG) print_passed(print);
        assert(past_lru == !DUT2.lru) print_passed(print);
        assert(DUT2.frames[!DUT2.lru][req.idx].valid == 1) print_passed(print);
        assert(DUT2.frames[!DUT2.lru][req.idx].dirty == 0) print_passed(print);
        assert(DUT2.frames[!DUT2.lru][req.idx].tag == req.tag) print_passed(print);
        assert(DUT2.frames[!DUT2.lru][req.idx].data[1] == cif2.dload) print_passed(print);

        // COMPARE_TAG
    endtask : test_write2


    parameter PERIOD = 10;
    int test_num;
    string test_name;

    dcachef_t req;
	dcachef_t req2;
    word_t [1:0] ram_data;
	word_t [1:0] ram_data2;
    word_t store_val;
	word_t store_val2;
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
        test_read1(0, test_num, test_name, req, ram_data, 0, hit);
        $display("Hit = %b", hit);
        print_passed(1);

        @(posedge CLK);


        /*=======================================================
        ==                  Test Num 1
        ========================================================*/
 		test_num = 1;
        test_name = "Test Write to Cache 1, Read From Cache 2, Write to From Cache 2 (S->M, S->I)";
        $display("Test %d: %s", test_num, test_name);
 		req.tag = 26'h25;
        req.idx = 3'h4;
        req.blkoff = 1'b0;
        req.bytoff = 2'b00;
        store_val = 32'hF3F3F3F3;
        ram_data[0] = 32'hAEAEAEAE;
        ram_data[1] = 32'hBCBCBCBC;

        test_write1(0, test_num, test_name, req, store_val, ram_data, 0, hit);

		@(posedge CLK);

		test_read2(0, test_num, test_name, req, ram_data, 0, hit);

		@(posedge CLK);
		store_val2 = 32'hDDDDDDDD;
		ram_data2[0] = 32'hAAAAAAAA;
        ram_data2[1] = 32'hFFFFFFFA; 
		test_write2(0, test_num, test_name, req, store_val2, ram_data2, 0, hit);

		@(posedge CLK);


		/*=======================================================
        ==                  Test Num 2
        ========================================================*/
 		test_num = 2;
  		test_name = "Test Write to Cache 2, Read From Cache 1, Write to From Cache 2 (M->I, I->M)";
       
        $display("Test %d: %s", test_num, test_name);
 		req.tag = 26'h25;
        req.idx = 3'h4;
        req.blkoff = 1'b0;
        req.bytoff = 2'b00;
        store_val = 32'hF3F3F3F3;
        ram_data[0] = 32'hAEAEAEAE;
        ram_data[1] = 32'hBCBCBCBC;

        test_write1(0, test_num, test_name, req, store_val, ram_data, 0, hit);

		@(posedge CLK);

		test_read2(0, test_num, test_name, req, ram_data, 0, hit);

		@(posedge CLK);
		store_val2 = 32'hDDDDDDDD;
		ram_data2[0] = 32'hAAAAAAAA;
        ram_data2[1] = 32'hFFFFFFFA; 
		test_write2(0, test_num, test_name, req, store_val2, ram_data2, 0, hit);

		@(posedge CLK);

		/*=======================================================
        ==                  Test Num 2
        ========================================================*/
 		test_num = 3;
        test_name = "Test Read From Cache 1 after Reading From Cache 2, Write to From Cache 2 (M->S, I->S)";
        $display("Test %d: %s", test_num, test_name);
 		req.tag = 26'h25;
        req.idx = 3'h4;
        req.blkoff = 1'b0;
        req.bytoff = 2'b00;
        store_val = 32'hF3F3F3F3;
        ram_data[0] = 32'hAEAEAEAE;
        ram_data[1] = 32'hBCBCBCBC;

        test_write1(0, test_num, test_name, req, store_val, ram_data, 0, hit);

		@(posedge CLK);

		test_read2(0, test_num, test_name, req, ram_data, 0, hit);

		@(posedge CLK);
		store_val2 = 32'hDDDDDDDD;
		ram_data2[0] = 32'hAAAAAAAA;
        ram_data2[1] = 32'hFFFFFFFA; 
		test_write2(0, test_num, test_name, req, store_val2, ram_data2, 0, hit);

		@(posedge CLK);

        /*=======================================================
        ==                  Test Num 1
        ========================================================*/
        /*test_num += 1;
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
*/
        /*=======================================================
        ==                  Test Num 2
        ========================================================*/
        /*test_num += 1;
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
*/
        /*=======================================================
        ==                  Test Num 3
        ========================================================*/
        /*@(posedge CLK);
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
        @(posedge CLK);*/

        /*=======================================================
        ==                  Test Num 4
        ========================================================*/
        /*test_num += 1;
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
*/
        /*=======================================================
        ==                  Test Num 5
        ========================================================*/
        /*test_num += 1;
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

        @(posedge CLK);*/

  /*=======================================================
        ==                  Test Num 6
        ========================================================*/
       /* test_num += 1;
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

        @(posedge CLK);*/

    end



endprogram : test
