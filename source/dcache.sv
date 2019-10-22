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

    enum { COMPARE_TAG, ALLOCATE1, ALLOCATE2, WRITE_BACK1, WRITE_BACK2, FLUSH_INIT, FLUSH_WRITE_DATA0, 
		FLUSH_WRITE_DATA1, FLUSH_SECOND, FLUSH_WRITE2_DATA0, FLUSH_WRITE2_DATA1, FLUSH_FINISH } state, next_state;

    parameter NUM_BLOCKS_PER_SET = 8;
    parameter NUM_SETS = 2;

    dcachef_t req;
    dcache_frame [1:0][7:0] frames, next_frames;
    logic lru, next_lru;
	integer index, next_index; 

    always_ff @(posedge CLK, negedge nRST) begin
        if (!nRST) begin
            frames <= '0;
            state <= COMPARE_TAG;
            lru <= 0;
			index <= 0; 
        end else begin
            frames <= next_frames;
            state <= next_state;
            lru <= next_lru;
			index <= next_index; 
        end
    end

    assign req = dcif.dmemaddr;

    always_comb begin
        next_state = state;
        next_frames = frames;
        next_lru = lru;
        dcif.dhit = 0;
        dcif.dmemload = 32'hBAD1BAD1;
        cif.dREN = '0;
        cif.dWEN = '0;
        cif.daddr = '0;
        cif.dstore = '0;
		next_index = index; 
		dcif.flushed = 0; 

        casez(state)
            COMPARE_TAG: begin	
				if (dcif.halt == 1) begin 
					next_state = FLUSH_INIT; 
					next_index = 0; 
                end else if(frames[0][req.idx].tag == req.tag && frames[0][req.idx].valid) begin
                    // Hit in set 0
                    dcif.dhit = 1;
                    dcif.dmemload = frames[0][req.idx].data[req.blkoff];

                    if (dcif.dmemWEN) begin
                        dcif.dmemload = dcif.dmemstore;
                        next_frames[0][req.idx].data[req.blkoff] = dcif.dmemstore;
                        next_frames[0][req.idx].dirty = 1;
                    end
                end else if (frames[1][req.idx].tag == req.tag && frames[1][req.idx].valid) begin
                    // Hit in set 1
                    dcif.dhit = 1;
                    dcif.dmemload = frames[1][req.idx].data[req.blkoff];

                    if (dcif.dmemWEN) begin
                        dcif.dmemload = dcif.dmemstore;
                        next_frames[1][req.idx].data[req.blkoff] = dcif.dmemstore;
                        next_frames[1][req.idx].dirty = 1;
                    end
				
                end else begin
                    next_state = frames[lru][req.idx].dirty ? WRITE_BACK1 : ALLOCATE1;
                end
            end

            ALLOCATE1: begin
			 if(cif.dwait) begin
                    // Access memory
                    cif.dREN = 1;
                    cif.daddr = req;
                    next_state = ALLOCATE1;
				
                end else begin
                    // Read hit in memory
                    // Update cache
//                    next_frames[lru][req.idx].valid = 1;
//                    next_frames[lru][req.idx].dirty = 0;
//                    next_frames[lru][req.idx].tag = req.tag;
                    next_frames[lru][req.idx].data[0] = cif.dload;

                    // Go to allocate second word
                    next_state = ALLOCATE2;
                end
            end

            ALLOCATE2: begin
				 if(cif.dwait) begin
                    // Access memory
                    cif.dREN = 1;
                    cif.daddr = req + 32'd4;
                    next_state = ALLOCATE2;
	
                end else begin
                    // Read hit in memory
                    // Update cache
                    next_frames[lru][req.idx].valid = 1;
                    next_frames[lru][req.idx].dirty = 0;
                    next_frames[lru][req.idx].tag = req.tag;
                    next_frames[lru][req.idx].data[1] = cif.dload;

                    dcif.dhit = 1;
                    dcif.dmemload = frames[lru][req.idx].data[0];

                    // Update replacement info
                    next_lru = !lru;

                    // Since mem is ready, go to COMPARE_TAG
                    next_state = COMPARE_TAG;
                end
            end

            WRITE_BACK1: begin
				if(cif.dwait) begin
                    // Access memory
                    cif.dWEN = 1;
                    cif.daddr = req;
                    cif.dstore = frames[lru][req.idx].data[0];
				
                end else begin
                    // Write hit in memory
                    next_state = WRITE_BACK2;
                end
            end

            WRITE_BACK2: begin
				 if(cif.dwait) begin
                    // Access memory
                    cif.dWEN = 1;
                    cif.daddr = req + 32'd4;
                    cif.dstore = frames[lru][req.idx].data[1];
                end else begin
                    // Write hit in memory
                    next_state = ALLOCATE1;
                end
            end

			FLUSH_INIT: begin
				if (index == 8) begin
					next_state = FLUSH_SECOND;
					next_index = 0; 
				end else if(frames[0][index].dirty) begin
					next_state = FLUSH_WRITE_DATA0; 
				end	else begin
					next_index = index + 1; 
					next_state = FLUSH_INIT; 
				end						
			end

			FLUSH_WRITE_DATA0:begin
				 if(cif.dwait) begin
                    cif.dWEN = 1;
                    cif.daddr = {frames[0][index].tag, index, 1'b0, 2'b00}; 
                    cif.dstore = frames[0][index].data[0];  
                end else begin
                    next_state =  FLUSH_WRITE_DATA1; 
                end
			end  

			FLUSH_WRITE_DATA1:begin
				if(cif.dwait) begin
                    cif.dWEN = 1;
                    cif.daddr = {frames[0][index].tag, index, 1'b1, 2'b00}; 
                    cif.dstore = frames[0][index].data[1];  
                end else begin
                    next_state =  FLUSH_INIT; 
					next_index = index + 1;
                end
			end 
 		
			FLUSH_SECOND:begin
				if (index == 8) begin
					next_state = FLUSH_FINISH;
					next_index = 0; 
				end else if(frames[1][index].dirty) begin
					next_state = FLUSH_WRITE2_DATA0; 
				end	else begin
					next_index = index + 1; 
					next_state = FLUSH_SECOND; 
				end						
			end

			FLUSH_WRITE2_DATA0: begin
				if(cif.dwait) begin
                    cif.dWEN = 1;
                    cif.daddr = {frames[1][index].tag, index, 1'b0, 2'b00}; 
                    cif.dstore = frames[1][index].data[0];  
                end else begin
                    next_state =  FLUSH_WRITE2_DATA1; 
                end
			end
			
			FLUSH_WRITE2_DATA1: begin
				if(cif.dwait) begin
                    cif.dWEN = 1;
                    cif.daddr = {frames[1][index].tag, index, 1'b1, 2'b00}; 
                    cif.dstore = frames[1][index].data[1];  
                end else begin	
					next_index = index + 1; 
                    next_state =  FLUSH_SECOND; 
                end
			end 
 	
			FLUSH_FINISH: begin
				next_index = 0; 
				dcif.flushed = 1; 
			end 
				
        endcase
    end

endmodule

