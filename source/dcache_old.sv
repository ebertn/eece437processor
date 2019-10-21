`include "cpu_types_pkg.vh"
`include "caches_if.vh"
`include "datapath_cache_if.vh"

module dcache (
    input logic CLK, nRST,
    datapath_cache_if.dcache dcif,
    caches_if.dcache cif
);

    import cpu_types_pkg::*;

//    // dcache format type
//    typedef struct packed {
//        logic [DTAG_W-1:0]  tag;
//        logic [DIDX_W-1:0]  idx;
//        logic [DBLK_W-1:0]  blkoff;
//        logic [DBYT_W-1:0]  bytoff;
//    } dcachef_t;

//    // dcache format widths
//    parameter DTAG_W    = 26;
//    parameter DIDX_W    = 3;
//    parameter DBLK_W    = 1;
//    parameter DBYT_W    = 2;
//    parameter DWAY_ASS  = 2;

//    //dcache frame
//    typedef struct packed {
//        logic valid;
//        logic dirty;
//        logic [DTAG_W - 1:0] tag;
//        word_t [1:0] data;
//    } dcache_frame;

    enum { ACCESS, ALLOCATE, ALLOCATE2, WRITE_BACK, WRITE_VICTIM } state, next_state;

    parameter NUM_BLOCKS_PER_SET = 8;
    parameter NUM_SETS = 2;

    dcachef_t req;
    dcache_frame [1:0][7:0] frames, next_frames;
    word_t victim_addr, next_victim_addr;
//    logic [DBLK_W-1:0] victim_blkoff, next_victim_blkoff;
    dcache_frame replacement_victim, next_replacement_victim; //writeback_addr, next_writeback_addr, writeback_data, next_writeback_data; // The value that is written when going to WRITE_BACK

    logic lru, next_lru;

    always_ff @(posedge CLK, negedge nRST) begin
        if (!nRST) begin
            frames <= '0;
            state <= ACCESS;
            lru <= 0;
            replacement_victim <= '0;
            victim_addr <= '0;
//            writeback_addr <= '0;
//            writeback_data <= '0;
        end else begin
            frames <= next_frames;
            state <= next_state;
            lru <= next_lru;
            replacement_victim <= next_replacement_victim;
            victim_addr <= next_victim_addr;
//            writeback_addr <= next_writeback_addr;
//            writeback_data <= next_writeback_data;
        end
    end

    assign req = dcif.dmemaddr;

    always_comb begin
        next_state = state;
        next_frames = frames;
        next_lru = lru;
        next_replacement_victim = replacement_victim;
        dcif.dhit = 0;
        dcif.dmemload = 32'hBAD1BAD1;
        cif.dREN = '0;
        cif.dWEN = '0;
        cif.daddr = '0;
        cif.dstore = '0;

        casez(state)
            ACCESS: begin
                if (dcif.dmemREN) begin
                    if(frames[0][req.idx].tag == req.tag && frames[0][req.idx].valid) begin
                        // Read hit in frames[0]
                        dcif.dhit = 1;
                        dcif.dmemload = frames[0][req.idx].data[req.blkoff];
                        next_lru = 1;
                        next_state = ACCESS;
                    end else if (frames[1][req.idx].tag == req.tag && frames[1][req.idx].valid) begin
                        // Read hit in frames[1]
                        dcif.dhit = 1;
                        dcif.dmemload = frames[1][req.idx].data[req.blkoff];
                        next_lru = 0;
                        next_state = ACCESS;
                    end else begin
                        // Read miss
                        next_state = ALLOCATE;
                    end
                end else if (dcif.dmemWEN) begin
                    if (frames[0][req.idx].tag == req.tag && frames[0][req.idx].valid) begin
                        // Write hit in frames[0]
                        dcif.dhit = 1;
                        next_frames[0][req.idx].data[req.blkoff] = dcif.dmemstore;
                        next_lru = 1;
                        next_state = ACCESS;
                    end else if (frames[1][req.idx].tag == req.tag && frames[1][req.idx].valid) begin
                        // Write hit in frames[1]
                        dcif.dhit = 1;
                        next_frames[0][req.idx].data[req.blkoff] = dcif.dmemstore;
                        next_lru = 0;
                        next_state = ACCESS;
                    end else begin
                        // Write miss
                        next_state = WRITE_BACK;
                    end
                end /*else begin
                    // Miss
                    next_state = ALLOCATE;
                end*/
            end

            ALLOCATE: begin
                if(cif.dwait) begin
                    // Access memory
                    cif.dREN = 1;
                    cif.daddr = {req[31:3], req[2:0] & 3'b011};
//                    next_victim_addr = {frames[lru][req.idx].tag, req.idx, 1'b0, 2'b00};
//                    next_replacement_victim = frames[lru][req.idx];
                end else begin
                    // Read hit in memory
                    // Update cache
                    next_frames[lru][req.idx].valid = 1;
                    next_frames[lru][req.idx].dirty = 0;
                    next_frames[lru][req.idx].tag = req.tag;
                    next_frames[lru][req.idx].data[0] = cif.dload;

                    // Update replacement info
//                    next_lru = !lru;

                    // hit/return in datapath
                    dcif.dhit = 0;
//                    dcif.dmemload = cif.dload;

                    // Write victim if dirty, otherwise go back to access
                    next_state = ALLOCATE2;
//                    if (replacement_victim.dirty) begin
//                        next_state = WRITE_VICTIM;
//                    end
                end
            end

            ALLOCATE2: begin
                if(cif.dwait) begin
                    // Access memory
                    cif.dREN = 1;
                    cif.daddr = req | 3'b100;
                    next_victim_addr = {frames[lru][req.idx].tag, req.idx, 1'b0, 2'b00};
                    next_replacement_victim = frames[lru][req.idx];
                end else begin
                    // Read hit in memory
                    // Update cache
                    next_frames[lru][req.idx].valid = 1;
                    next_frames[lru][req.idx].dirty = 0;
                    next_frames[lru][req.idx].tag = req.tag;
                    next_frames[lru][req.idx].data[1] = cif.dload;

                    // Update replacement info
                    next_lru = !lru;

                    // hit/return in datapath
                    dcif.dhit = 1;
                    dcif.dmemload = cif.dload;

                    // Write victim if dirty, otherwise go back to access
                    next_state = ACCESS;
                    if (replacement_victim.dirty) begin
                        next_state = WRITE_VICTIM;
                    end
                end
            end

            WRITE_BACK: begin
                if(cif.dwait) begin
                    // Access memory
                    cif.dWEN = 1;
                    cif.daddr = req;
                    cif.dstore = dcif.dmemstore;

                    next_victim_addr = {frames[lru][req.idx].tag, req.idx, 1'b0, 2'b00};
                    next_replacement_victim = frames[lru][req.idx];
                end else begin
                    // Write hit in memory
                    // Update cache
                    next_frames[lru][req.idx].valid = 1;
                    next_frames[lru][req.idx].dirty = 1;
                    next_frames[lru][req.idx].tag = req.tag;
                    next_frames[lru][req.idx].data[req.blkoff] = cif.dload;

                    // Update replacement info
                    next_lru = !lru;

                    // hit/return in datapath
                    dcif.dhit = 1;
                    dcif.dmemload = cif.dload;

                    // Write victim if dirty, otherwise go back to access
                    next_state = ACCESS;
                    if (replacement_victim.dirty) begin
                        next_state = WRITE_VICTIM;
                    end
                end
            end

//            next_victim_addr = {frames[lru][req.idx].tag, req.idx, req.blkoff, 2'b00};
//            next_replacement_victim = frames[lru][req.idx];
            WRITE_VICTIM: begin
                if(cif.dwait) begin
                    // Request to write victim to memory address "victim_addr"
                    cif.dWEN = 1;
                    cif.daddr = victim_addr;
                    cif.dstore = replacement_victim.data[victim_addr[3]]; //victim_addr[3] = block offset
                end else begin
                    // If
                    next_state = ACCESS;
                    if (victim_addr[3] == 0) begin
                        next_victim_addr[3] = 1;
                        next_state = WRITE_VICTIM;
                    end
                end
            end
        endcase
    end

endmodule

