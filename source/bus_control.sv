`include "cpu_types_pkg.vh"
`include "caches_if.vh"
`include "cache_control_if.vh"
`include "bus_mem_if.vh"

module bus_control
(
	input logic CLK, nRST,
	//cache_control_if.cc ccif,
	bus_mem_if bmif
); 

	import cpu_types_pkg::*;
	enum {REQUEST, ARBITRATE, SNOOP, MEMORY_WB, REPLY, MEMORY_READ, COMPLETE, MODIFIED_WB1, MODIFIED_WB2} state, next_state;
	logic next_arbitraitor, arbitraitor; 
	logic [1:0] next_ccwait, next_dwait, next_ccinv;  
	word_t [1:0] next_ccsnoopaddr, next_dload; 
	word_t next_cif_daddr;
	word_t next_cif_dstore;
 	word_t return_val, next_return_val;
	word_t return_addr, next_return_addr;
	logic next_bus_dREN, next_bus_dWEN; 
	word_t next_bus_daddr, next_bus_store;

	always_ff @(posedge CLK, negedge nRST) begin
		if(nRST == 0) begin
			state <= REQUEST;
			arbitraitor <= 0;
			return_val <= '0;
			return_addr <= '0;
		end else begin
			state <= next_state; 
			arbitraitor <= next_arbitraitor;
			return_val <= next_return_val;
			return_addr <= next_return_addr;
		end 
	end

	always_comb begin
		next_state = state;
		next_arbitraitor = arbitraitor;
		next_return_val = return_val;
		next_return_addr = return_addr;

//		bmif.dstore = '0;
//		bmif.dWEN = '0;
//		bmif.daddr = '0;
//		bmif.dREN = '0;
//		bmif.ccif_dload = '0;
//		bmif.ccif_ccsnoopaddr = '0;

		bmif.ccif_dwait = '1;
		bmif.ccif_ccinv[0] = 0;
		bmif.ccif_ccinv[1] = 0;
//		bmif.ccif_ccwait[arbitraitor] = 0; //!(bmif.ccif_dREN[arbitraitor] | bmif.ccif_dWEN[arbitraitor]);//0;
//		bmif.ccif_ccwait[!arbitraitor] = bmif.ccif_dREN[arbitraitor] | bmif.ccif_dWEN[arbitraitor] | bmif.ccif_ccwrite[arbitraitor];
//
//		if(bmif.ccif_halt[0] && bmif.ccif_halt[1]) begin
//			// Both are flushing
//			bmif.ccif_ccwait[0] = 0;
//			bmif.ccif_ccwait[1] = 0;
//		end else if(bmif.ccif_halt[0] & !bmif.ccif_flushed[0]) begin
//			// cpu 0 is flushing
//			bmif.ccif_ccwait[0] = 1;
//			bmif.ccif_ccwait[1] = 0;
//		end else if(bmif.ccif_halt[1] & !bmif.ccif_flushed[1]) begin
//			// cpu 1 is flushing
//			bmif.ccif_ccwait[0] = 0;
//			bmif.ccif_ccwait[1] = 1;
//		end

		casez(state)
			REQUEST: begin
				bmif.dWEN = '0;
				bmif.dstore = '0;
				bmif.daddr = '0;
				bmif.dREN = '0;
				bmif.ccif_dload = '0;
//				bmif.ccif_ccwait[0] = 0;
//				bmif.ccif_ccwait[1] = 0;

				if(bmif.ccif_dREN[0] == 1 || bmif.ccif_dWEN[0] == 1
					|| bmif.ccif_ccwrite[0] == 1) begin
					next_state = ARBITRATE;
				end else if (bmif.ccif_dREN[1] == 1 || bmif.ccif_dWEN[1] == 1
					|| bmif.ccif_ccwrite[1] == 1) begin
					next_state = ARBITRATE;
				end else begin
					next_state = REQUEST;
				end
			end

			ARBITRATE: begin
				bmif.daddr = '0;

//				bmif.ccif_ccwait[0] = 0;
//				bmif.ccif_ccwait[1] = 0;

				if(bmif.ccif_dREN[0] == 1 || bmif.ccif_dWEN[0] == 1
					|| bmif.ccif_ccwrite[0] == 1) begin
					next_arbitraitor = 0;
				end else begin
					next_arbitraitor = 1;
				end

				if(bmif.ccif_dREN[next_arbitraitor] == 1 || bmif.ccif_ccwrite[next_arbitraitor] == 1) begin
					next_state = SNOOP;
				end else begin
					next_state = MEMORY_WB;
				end
			end

			SNOOP: begin
				bmif.ccif_ccsnoopaddr[0] = bmif.ccif_daddr[arbitraitor];
				bmif.ccif_ccsnoopaddr[1] = bmif.ccif_daddr[arbitraitor];
				if (bmif.ccif_dREN[arbitraitor] == 0 && bmif.ccif_ccwrite[arbitraitor]) begin
					// BusWB
					bmif.ccif_ccinv[!arbitraitor] = 1;
					//bmif.ccif_ccwait[!arbitraitor] = 1;
					bmif.ccif_dwait[arbitraitor] = 0;

//					next_state = REQUEST;
					next_state = SNOOP; // Stay in snoop until ccwrite goes low
//					if(bmif.ccif_ccwrite[!arbitraitor] == 1) begin
					if(bmif.ccif_cctrans[!arbitraitor] == 1) begin // Changed when transitioned from ccwrite -> cctrans
						next_state = MODIFIED_WB1;
					end

//				end else if (bmif.ccif_dREN[arbitraitor] == 1 && bmif.ccif_ccwrite[!arbitraitor] == 1) begin
				/*end else if (bmif.ccif_dREN[arbitraitor] == 0 && bmif.ccif_ccwrite[arbitraitor] == 0) begin
					next_state = REQUEST;
				*/end else if (bmif.ccif_dREN[arbitraitor] == 1 && bmif.ccif_cctrans[!arbitraitor] == 1) begin// Changed when transitioned from ccwrite -> cctrans
					// BusRd
					next_state = MODIFIED_WB1;
				end else /*if (bmif.ccif_dREN[arbitraitor] == 1 && bmif.ccif_cctrans[!arbitraitor] == 0)*/ begin
					next_state = MEMORY_READ;
				end /*else begin
					next_state = REQUEST;
				end*/
			end

			MEMORY_WB: begin // Make this work
				bmif.dWEN = 1;
				bmif.daddr = bmif.ccif_daddr[arbitraitor];
				bmif.dstore = bmif.ccif_dstore[arbitraitor];
				next_return_val = bmif.ccif_dload[arbitraitor];
				next_return_addr = bmif.ccif_daddr[arbitraitor];
				if(!bmif.dwait) begin
					bmif.ccif_dwait[arbitraitor] = 0;
					next_state = REQUEST;
				end else begin
					bmif.ccif_dwait[arbitraitor] = 1;
					next_state = MEMORY_WB;
				end
			end

			MODIFIED_WB1: begin
				bmif.dWEN = 1;
				bmif.dREN = 0;
				bmif.daddr = bmif.ccif_daddr[!arbitraitor];
				bmif.dstore = bmif.ccif_dstore[!arbitraitor];
				if (!bmif.dwait) begin
					bmif.ccif_dwait[!arbitraitor] = 0;
                    next_state = MODIFIED_WB2;
				end
			end

			MODIFIED_WB2: begin
				bmif.dWEN = 1;
				bmif.dREN = 0;
				bmif.daddr = bmif.ccif_daddr[!arbitraitor];
				bmif.dstore = bmif.ccif_dstore[!arbitraitor];
				if (!bmif.dwait) begin
					bmif.ccif_dwait[!arbitraitor] = 0;

					bmif.ccif_ccinv[!arbitraitor] = 1;
					if(bmif.ccif_dREN) begin
						next_state = MEMORY_READ;
					end else begin
						next_state = REQUEST;
					end
				end
			end

			MEMORY_READ: begin
				//next_bus_dREN = 1;
				next_return_val = bmif.dload;
				next_return_addr = bmif.ccif_daddr[arbitraitor];

				//bmif.ccif_dwait = '1;

				bmif.dWEN = 0;
				bmif.dREN = 1;
				bmif.daddr = bmif.ccif_daddr[arbitraitor];
				//bmif.dstore = '0; //bmif.ccif_dstore[arbitraitor];
				if (!bmif.dwait) begin
					next_state = COMPLETE;
				end else begin
					next_state = MEMORY_READ;
				end
			end

			COMPLETE: begin
				bmif.ccif_dwait[arbitraitor] = 0;
				bmif.daddr = return_addr;
				bmif.ccif_dload[arbitraitor] = return_val;
				bmif.dREN = 0;
				bmif.dWEN = 0;
				next_state = REQUEST;
			end

			default: begin
				next_state = REQUEST;
			end
		endcase
	end

	always_comb begin
		bmif.ccif_ccwait = '0;
		bmif.ccif_ccwait[arbitraitor] = 0; //!(bmif.ccif_dREN[arbitraitor] | bmif.ccif_dWEN[arbitraitor]);//0;
		bmif.ccif_ccwait[!arbitraitor] = bmif.ccif_dREN[arbitraitor] | bmif.ccif_dWEN[arbitraitor] | bmif.ccif_ccwrite[arbitraitor];

		if(bmif.ccif_halt[0] && bmif.ccif_halt[1]) begin
			// Both are flushing
			bmif.ccif_ccwait[0] = 0;
			bmif.ccif_ccwait[1] = 0;
		end else if(bmif.ccif_halt[0] & !bmif.ccif_flushed[0]) begin
			// cpu 0 is flushing
			bmif.ccif_ccwait[0] = 1;
			bmif.ccif_ccwait[1] = 0;
		end else if(bmif.ccif_halt[1] & !bmif.ccif_flushed[1]) begin
			// cpu 1 is flushing
			bmif.ccif_ccwait[0] = 0;
			bmif.ccif_ccwait[1] = 1;
		end
	end
				


endmodule : bus_control
