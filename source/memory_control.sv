/*
  Eric Villasenor
  evillase@gmail.com

  this block is the coherence protocol
  and artibtration for ram
*/

// interface include
`include "cache_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module memory_control (
    input CLK, nRST,
    cache_control_if.cc ccif
);
    // type import
    import cpu_types_pkg::*;

    // number of cpus for cc
    parameter CPUS = 1;

    always_comb begin
        for (int i = 0; i < CPUS; i++) begin
			// Defaults
			ccif.dload[i] = '0;
			ccif.dwait[i] = '0;
	
			ccif.iload[i] = '0;
			ccif.iwait[i] = '0;
			ccif.iload[i] = '0;

			ccif.ramstore = '0;
			ccif.ramaddr = '0;
			ccif.ramREN = '0;
			ccif.ramWEN = '0;

			// Instruction read		
            ccif.iwait[i] = ccif.ramstate != ACCESS;
           
            ccif.iload[i] = ccif.ramload;
            ccif.ramaddr = ccif.iaddr[i];
            ccif.ramREN = ccif.iREN[i];

            if (ccif.dREN[i] || ccif.dWEN[i]) begin
               
                {ccif.ramWEN, ccif.ramREN} = '0;
                ccif.dwait[i] = ccif.ramstate != ACCESS;
                ccif.iwait[i] = 1;

                // Read
                ccif.dload[i] = ccif.ramload;
                ccif.ramaddr = ccif.daddr[i];
                ccif.ramREN = ccif.dREN[i] && !ccif.dWEN[i];

                if (ccif.dWEN[i]) begin
                    // Write
                    ccif.ramWEN = 1;
                    ccif.ramstore = ccif.dstore[i];
                    ccif.ramaddr = ccif.daddr[i];
                end
            end
        end

    end

endmodule : memory_control
