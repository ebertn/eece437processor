`include "cpu_types_pkg.vh"
`include "caches_if.vh"
`include "cache_control_if.vh"
`include "bus_mem_if.vh"

module bus_control
(
	input logic CLK, nRST,
	cache_control_if.cc ccif,
	bus_mem_if.bus_con bmif
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
			//ccif.ccwait <= '0;
			//ccif.ccsnoopaddr <= '0;
//			ccif.dstore <= '0;
//			ccif.daddr <= '0;
			//ccif.dwait <= 2'b11;
			//ccif.ccinv <= '0;
			return_val <= '0;
			return_addr <= '0;
			/*bmif.dstore <= '0;
			bmif.dWEN <= 0; 
			bmif.daddr <= '0;
			bmif.dREN <= 0; 
			*/
		end else begin
			state <= next_state; 
			arbitraitor <= next_arbitraitor; 
			//ccif.ccwait <= next_ccwait;
			//ccif.ccsnoopaddr <= next_ccsnoopaddr;
//			ccif.dstore <= next_cif_dstore;
//			ccif.daddr <= next_cif_daddr; // Need to create new signal to latch, cant use ccif
			//ccif.dwait <= next_dwait;
			//ccif.ccinv <= next_ccinv;
			return_val <= next_return_val;
			return_addr <= next_return_addr;
			/*bmif.dstore <= next_bus_store;
			bmif.dWEN <= next_bus_dWEN; 
			bmif.daddr <= next_bus_daddr; 
			bmif.dREN <= next_bus_dREN; 
			*/
			
		end 
	end

	always_comb begin
		next_state = state; 
		next_arbitraitor = arbitraitor;  
		//next_ccwait = ccif.ccwait;
		//next_ccsnoopaddr = ccif.ccsnoopaddr;
		//next_cif_dstore = ccif.dstore;
		//next_cif_daddr = ccif.daddr;
		//next_dwait = ccif.dwait;
		//next_ccinv = ccif.ccinv;
		next_return_val = return_val;
		next_return_addr = return_addr;

//		next_bus_store = bmif.dstore;
//		next_bus_dWEN = bmif.dWEN;
//		next_bus_daddr = bmif.daddr;
//		next_bus_dREN = bmif.dREN;
		ccif.dwait = '1;
		ccif.ccinv[0] = 0;
		ccif.ccinv[1] = 0;
		ccif.ccwait[arbitraitor] = 0; //!(ccif.dREN[arbitraitor] | ccif.dWEN[arbitraitor]);//0;
		ccif.ccwait[!arbitraitor] = ccif.dREN[arbitraitor] | ccif.dWEN[arbitraitor] | ccif.ccwrite[arbitraitor];

		if(ccif.halt[0] && ccif.halt[1]) begin
			// Both are flushing
			ccif.ccwait[0] = 0;
			ccif.ccwait[1] = 0;
		end else if(ccif.halt[0] & !ccif.flushed[0]) begin
			// cpu 0 is flushing
			ccif.ccwait[0] = 1;
			ccif.ccwait[1] = 0;
		end else if(ccif.halt[1] & !ccif.flushed[1]) begin
			// cpu 1 is flushing
			ccif.ccwait[0] = 0;
			ccif.ccwait[1] = 1;
		end
		//ccif.ccinv = '0;
		//bmif.dstore = '0;
		//bmif.dWEN = '0;
		//bmif.daddr = '0;
		//bmif.dREN = '0;

		casez(state)
			REQUEST: begin
				bmif.dWEN = '0;
				bmif.dstore = '0;
				bmif.daddr = '0;
				bmif.dREN = '0;
				ccif.dload = '0;
				//ccif.ccwait[0] = 0;
				//ccif.ccwait[1] = 0;

				if(ccif.dREN[0] == 1 || ccif.dWEN[0] == 1 
					|| ccif.ccwrite[0] == 1) begin
					next_state = ARBITRATE;
				end else if (ccif.dREN[1] == 1 || ccif.dWEN[1] == 1 
					|| ccif.ccwrite[1] == 1) begin
					next_state = ARBITRATE;
				end else begin
					next_state = REQUEST; 
				end
			end
			
			ARBITRATE: begin
				bmif.daddr = '0;

				//ccif.ccwait[0] = 0;
				//ccif.ccwait[1] = 0;

				if(ccif.dREN[0] == 1 || ccif.dWEN[0] == 1
					|| ccif.ccwrite[0] == 1) begin
					next_arbitraitor = 0;
				end else begin
					next_arbitraitor = 1;
				end
	
				if(ccif.dREN[next_arbitraitor] == 1 || ccif.ccwrite[next_arbitraitor] == 1) begin
					next_state = SNOOP; 
				end else begin
					next_state = MEMORY_WB; 
				end 
			end 
	
			SNOOP: begin
				ccif.ccsnoopaddr[0] = ccif.daddr[arbitraitor];
				ccif.ccsnoopaddr[1] = ccif.daddr[arbitraitor];
				if (ccif.dREN[arbitraitor] == 0 && ccif.ccwrite[arbitraitor]) begin
					// BusWB
					ccif.ccinv[!arbitraitor] = 1;
					//ccif.ccwait[!arbitraitor] = 1;
					ccif.dwait[arbitraitor] = 0;

					next_state = REQUEST;
//					if(ccif.ccwrite[!arbitraitor] == 1) begin
					if(ccif.cctrans[!arbitraitor] == 1) begin // Changed when transitioned from ccwrite -> cctrans
						next_state = MODIFIED_WB1;
					end

//				end else if (ccif.dREN[arbitraitor] == 1 && ccif.ccwrite[!arbitraitor] == 1) begin
				end else if (ccif.dREN[arbitraitor] == 1 && ccif.cctrans[!arbitraitor] == 1) begin// Changed when transitioned from ccwrite -> cctrans

					// BusRd
					next_state = MODIFIED_WB1;
				end else begin
					next_state = MEMORY_READ;
				end
			end 
			
			MEMORY_WB: begin // Make this work
				bmif.dWEN = 1;
				bmif.daddr = ccif.daddr[arbitraitor];
				bmif.dstore = ccif.dstore[arbitraitor];
				next_return_val = ccif.dload[arbitraitor];
				next_return_addr = ccif.daddr[arbitraitor];
				if(!bmif.dwait) begin
					ccif.dwait[arbitraitor] = 0;
					/*if(ccif.dWEN[arbitraitor] == 1 || ccif.dREN[arbitraitor] == 1) begin
						next_state = MEMORY_WB;
					end else begin
						next_state = REQUEST;
					end*/
					next_state = REQUEST;
				end else begin
					ccif.dwait[arbitraitor] = 1;
					next_state = MEMORY_WB;
				end
			end 
			
			/*INVALIDATE: begin
				next_ccinv[arbitraitor] = 1; 
				next_state = REQUEST; 
			end*/
			
			/*REPLY: begin
				ccif.ccsnoopaddr[0] = ccif.daddr[arbitraitor];
				ccif.ccsnoopaddr[1] = ccif.daddr[arbitraitor];
				if(ccif.ccwrite[1-arbitraitor] == 1) begin
					next_return_val = ccif.dstore[1-arbitraitor];
					next_state = COMPLETE;
				end else begin
					next_state = MEMORY_READ; 
				end
			end*/

			MODIFIED_WB1: begin
				bmif.dWEN = 1;
				bmif.dREN = 0;
				bmif.daddr = ccif.daddr[!arbitraitor];
				bmif.dstore = ccif.dstore[!arbitraitor];
				if (!bmif.dwait) begin
					ccif.dwait[!arbitraitor] = 0;
                    next_state = MODIFIED_WB2;
				end
			end

			MODIFIED_WB2: begin
				bmif.dWEN = 1;
				bmif.dREN = 0;
				bmif.daddr = ccif.daddr[!arbitraitor];
				bmif.dstore = ccif.dstore[!arbitraitor];
				if (!bmif.dwait) begin
					ccif.dwait[!arbitraitor] = 0;

					ccif.ccinv[!arbitraitor] = 1;
					if(ccif.dREN) begin
						next_state = MEMORY_READ;
					end else begin
						next_state = REQUEST;
					end
				end
			end
		
			MEMORY_READ: begin
				//next_bus_dREN = 1;
				next_return_val = bmif.dload;
				next_return_addr = ccif.daddr[arbitraitor];

				ccif.dwait = '1;

				bmif.dWEN = 0;
				bmif.dREN = 1;
				bmif.daddr = ccif.daddr[arbitraitor];
				bmif.dstore = '0; //ccif.dstore[arbitraitor];
				if (!bmif.dwait) begin
					next_state = COMPLETE;
				end else begin
					next_state = MEMORY_READ;
				end 
			end 

			COMPLETE: begin
				ccif.dwait[arbitraitor] = 0;
				bmif.daddr = return_addr;
				ccif.dload[arbitraitor] = return_val;
				bmif.dREN = 0;
				bmif.dWEN = 0;
				/*if(ccif.dWEN[arbitraitor] == 1 || ccif.dREN[arbitraitor] == 1) begin
					next_state = COMPLETE;
				end else begin
					next_state = REQUEST;
				end*/
				next_state = REQUEST;
			end 
		endcase
	end
				


endmodule 
