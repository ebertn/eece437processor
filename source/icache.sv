
`include "cpu_types_pkg.vh"
`include "caches_if.vh"
`include "datapath_cache_if.vh"

module icache (
	input logic CLK, nRST, 
	datapath_cache_if.icache dcif,
	caches_if.icache cif
); 

	import cpu_types_pkg::*;

//	typedef struct packed {
//		logic [ITAG_W-1:0]  tag;
//		logic [IIDX_W-1:0]  idx;
//		logic [IBYT_W-1:0]  bytoff;
//	} icachef_t;

//	// icache format widths
//	parameter ITAG_W    = 26;
//	parameter IIDX_W    = 4;
//	parameter IBLK_W    = 0; // <- important
//	parameter IBYT_W    = 2;

	//icache frame
//	typedef struct packed {
//		logic valid;
//		logic [ITAG_W - 1:0] tag;
//		word_t data;
//	} icache_frame;

	enum { ACCESS, MISS } state, next_state;

	icachef_t req;
	icache_frame [15:0] frames, next_frames;

	always_ff @(posedge CLK, negedge nRST) begin
		if (!nRST) begin
			frames <= '0;
			state <= ACCESS;
		end else begin
			frames <= next_frames;
			state <= next_state;
		end
	end

	assign req = dcif.imemaddr;
// What the above means (probably)
//	assign req.idx = dcif.imemaddr[5:2];
//	assign req.tag = dcif.imemaddr[31:4];
//	assign req.bytoff = dcif.imemaddr[1:0]; // Not sure if this is ever used

	always_comb begin
		next_state = state;
		next_frames = frames;
		dcif.ihit = '0;
		dcif.imemload = 32'hBAD1BAD1;
		cif.iREN = '0;
		cif.iaddr = '0;

		casez(state)
			ACCESS: begin
				if (dcif.imemREN && frames[req.idx].tag == req.tag && frames[req.idx].valid) begin
					// Hit
					dcif.ihit = 1;
					dcif.imemload = frames[req.idx].data;
					next_state = ACCESS;
				end else if (dcif.imemREN) begin
					// Miss
					next_state = MISS;
				end
			end

			MISS: begin
				if(cif.iwait) begin
					// Access memory
					cif.iREN = 1;
					cif.iaddr = req;
				end else begin
					// Hit in memory
					// Update cache
					next_frames[req.idx].valid = 1;
					next_frames[req.idx].tag = req.tag;
					next_frames[req.idx].data = cif.iload;

					// hit in datapath
					dcif.ihit = 1;
					dcif.imemload = cif.iload;
					next_state = ACCESS;
				end
			end
		endcase
	end
	
endmodule

