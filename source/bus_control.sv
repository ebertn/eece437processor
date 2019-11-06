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
	enum {REQUEST, ARBITRATE, SNOOP, MEMORY_WB, INVALIDATE, REPLY, MEMORY_READ, COMPLETE} state, next_state; 
	logic next_arbitraitor, arbitraitor; 
	logic [1:0] next_ccwait, next_dwait, next_ccinv;  
	word_t [1:0] next_ccsnoopaddr, next_dload; 
	word_t next_cif_daddr;
	word_t next_cif_dstore;
 	word_t return_val, next_return_val; 
	logic next_bus_dREN, next_bus_dWEN; 
	word_t next_bus_daddr, next_bus_store;

	always_ff @(posedge CLK, negedge nRST) begin
		if(nRST == 0) begin
			state <= REQUEST;
			arbitraitor <= 0; 
			ccif.ccwait <= '0; 
			ccif.ccsnoopaddr <= '0; 
//			ccif.dstore <= '0;
//			ccif.daddr <= '0;
			//ccif.dwait <= 2'b11;
			ccif.ccinv <= '0; 
			return_val <= '0; 
			/*bmif.dstore <= '0;
			bmif.dWEN <= 0; 
			bmif.daddr <= '0;
			bmif.dREN <= 0; 
			*/
		end else begin
			state <= next_state; 
			arbitraitor <= next_arbitraitor; 
			ccif.ccwait <= next_ccwait; 
			ccif.ccsnoopaddr <= next_ccsnoopaddr; 
//			ccif.dstore <= next_cif_dstore;
//			ccif.daddr <= next_cif_daddr; // Need to create new signal to latch, cant use ccif
			//ccif.dwait <= next_dwait;
			ccif.ccinv <= next_ccinv; 
			return_val <= next_return_val; 
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
		next_ccwait = ccif.ccwait; 
		next_ccsnoopaddr = ccif.ccsnoopaddr; 
		//next_cif_dstore = ccif.dstore;
		//next_cif_daddr = ccif.daddr;
		//next_dwait = ccif.dwait;
		next_ccinv = ccif.ccinv; 
		next_return_val = return_val;
		
//		next_bus_store = bmif.dstore;
//		next_bus_dWEN = bmif.dWEN;
//		next_bus_daddr = bmif.daddr;
//		next_bus_dREN = bmif.dREN;
		ccif.dwait = '1;
		//bmif.dstore = '0;
		//bmif.dWEN = '0;
		bmif.daddr = '0;
		//bmif.dREN = '0;

		casez(state)
			
			REQUEST: begin
				if(ccif.dREN[0] == 1 || ccif.dWEN[0] == 1 
					|| ccif.ccwrite[0] == 1) begin
					next_arbitraitor = 0; 
					next_state = ARBITRATE; 
				end else if (ccif.dREN[1] == 1 || ccif.dWEN[1] == 1 
					|| ccif.ccwrite[1] == 1) begin
					next_arbitraitor = 1; 
					next_state = ARBITRATE; 	
				end else begin
					next_state = REQUEST; 
				end
			end
			
			ARBITRATE: begin
				bmif.daddr = '0;
				//next_ccwait[arbitraitor] = 0;
				//next_ccwait[1-arbitraitor] = 1;
				if(ccif.dREN[arbitraitor] == 1 || ccif.ccwait[arbitraitor] == 1) begin
					next_state = SNOOP; 
				end else begin
					next_state = MEMORY_WB; 
				end 
			end 
	
			SNOOP: begin
				next_ccsnoopaddr[0] = ccif.daddr[arbitraitor];
				next_ccsnoopaddr[1] = ccif.daddr[arbitraitor];
				if (ccif.cctrans[0] == 1 && ccif.cctrans[1] == 1) begin
					next_state = SNOOP; 
				end else if (ccif.dREN[arbitraitor] == 1) begin
					next_state = REPLY;
				end else begin
					next_state = INVALIDATE; 
				end 
			end 
			
			MEMORY_WB: begin // Make this work
//				next_bus_dWEN = 1;
//				next_bus_daddr = ccif.daddr[arbitraitor];
//				next_bus_store  = ccif.dstore[arbitraitor];
//				next_dwait = 0;
//				next_return_val = ccif.dload[arbitraitor];
//				next_state = COMPLETE;

				bmif.dWEN = 1;
				bmif.daddr = ccif.daddr[arbitraitor];
				bmif.dstore = ccif.dstore[arbitraitor];
				next_return_val = ccif.dload[arbitraitor];
				if(!bmif.dwait) begin
					ccif.dwait[arbitraitor] = 0;
					next_state = COMPLETE;
				end else begin
					ccif.dwait[arbitraitor] = 1;
					next_state = MEMORY_WB;
				end
			end 
			
			INVALIDATE: begin
				next_ccinv[arbitraitor] = 1; 
				next_state = REQUEST; 
			end 
			
			REPLY: begin
				if(ccif.ccwrite[1-arbitraitor] == 1) begin
					next_return_val = ccif.dstore[1-arbitraitor];
					next_state = COMPLETE; 
				end else begin
					next_state = MEMORY_READ; 
				end
			end 
		
			MEMORY_READ: begin
				next_bus_dREN = 1;
				next_return_val = bmif.dload; 
				if (ccif.dwait[arbitraitor] == 0) begin
					next_state = MEMORY_READ; 
				end else begin
					next_state = COMPLETE; 
				end 
			end 

			COMPLETE: begin
				next_dload[arbitraitor] = return_val; 
				next_state = REQUEST;
			end 
		

		endcase
	end
				


endmodule 
