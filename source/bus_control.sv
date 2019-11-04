`include "cpu_types_pkg.vh"
`include "caches_if.vh"
`include "cache_control_if.vh"

module bus_control
(
	input logic CLK, nRST, 
	 cache_control_if.cc ccif
	 caches_if.caches cif
); 

	import cpu_types_pkg::*;
	enum {REQUEST, ARBITRATE, SNOOP, MEMORY_WB, INVALIDATE, REPLY, MEMORY_READ, COMPLETE} state, next_state; 
	logic next_arbitraitor, arbitraitor; 
	logic [1:0] next_ccwait, next_dwait, next_ccinv;  
	word_t [1:0] next_ccsnoopaddr, next_dload; 
	word_t next_cif_daddr,	next_cif_dstore;  
 	word_t return_val, next_return_val; 

	always_ff @(posedge CLK, negedge nRST) begin
		if(nRST == 0) begin
			state <= REQUEST;
			arbitraitor <= 0; 
			ccif.ccwait <= '0; 
			ccif.ccsnoopaddr <= '0; 
			cif.dstore <= '0; 
			cif.daddr <= '0; 
			ccif.dwait <= 2'b11; 
			ccif.ccinv <= '0; 
			return_val <= '0; 
			ccif.dload <= '0; 
		end else begin
			state <= next_state; 
			arbitraitor <= next_arbitraitor; 
			ccif.ccwait <= next_ccwait; 
			ccif.ccsnoopaddr <= next_ccsnoopaddr; 
			cif.dstore <= next_cif_dstore
			cif.daddr <= next_cif_daddr; 
			ccif.dwait <= next_dwait; 
			ccif.ccinv <= next_ccinv; 
			return_val <= next_return_val; 
			ccif.dload <= next_dload; 
		end 
	end

	always_comb begin
		next_state = state; 
		next_arbitraitor = arbitraitor;  
		next_ccwait = ccif.ccwait; 
		next_ccsnoopaddr = ccif.ccsnoopaddr; 
		next_cif_dstore = cif.dstore; 
		next_cif_daddr = cif.daddr; 
		next_dwait = ccif.dwait; 
		next_ccinv = ccif.ccinv; 
		next_return_val = return_val;
		next_dload = ccif.dload;  

		casez(state) begin
			
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
				next_ccwait[arbitraitor] = 0; 
				next_ccwait[1-arbitraitor] = 1;
				if(ccif.dREN[arbitraitor] == 1 || ccif.ccwait[arbitraitor] == 1) begin
					next_state = SNOOP; 
				end else begin
					next_state = MEMORY_WB; 
				end 
			end 
	
			SNOOP: begin
				next_ccsnoopaddr[0] == ccif.daddr[arbitraitor]; 
				next_ccsnoopaddr[1] == ccif.daddr[arbitraitor]; 
				if (ccif.cctrans[0] == 1 && ccif.cctrans[1] == 1) begin
					next_state = SNOOP; 
				end else if (ccif.dREN[arbitraitor] == 1) begin
					next_state == REPLY; 
				end else begin
					next_state = INVALIDATE; 
				end 
			end 
			
			MEMORY_WB: begin
				next_cif_daddr = ccif.daddr[arbitraitor]; 
				next_cif_dstore = ccif.dstore[arbitraitor]; 
				next_dwait = 0;
				next_return_val = cif.dload; 
				next_state = COMPLETE; 
			end 
			
			INVALIDATE: begin
				next_ccinv[arbitraitor] = 1; 
				next_state = REQUEST; 
			end 
			
			REPLY: begin
				if(ccif.ccwrite[1-arbitraitor] == 1) begin
					return_val = ccif.dstore[1-arbitraitor]; 
					next_state = COMPLETE; 
				end else begin
					next_state = MEMORY_READ; 
				end
			end 
		
			MEMORY_READ: begin
				next_return_val = cif.dload; 
				if (cif.dwait == 0) begin
					next_state = MEMORY_READ; 
				end else begin
					next_state = COMPLETE; 
				end 
			end 

			COMPLETE: begin
				next_dload [arbitraitor] = return_val; 
				next_state = REQUEST;
			end 
		

		endcase
	end
				


endmodule 
