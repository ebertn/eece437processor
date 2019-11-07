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

    bus_mem_if bmif();

    bus_control BC (CLK, nRST, ccif, bmif);

    logic last_instr_req, next_last_instr_req;

    always_ff @(posedge CLK, negedge nRST) begin
        if (!nRST) begin
            last_instr_req <= 0;
        end else begin
            last_instr_req <= next_last_instr_req;
        end
    end

    // Arbitrate
    always_comb begin
        // Defaults
        bmif.dload = '0;
        bmif.dwait = ccif.ramstate != ACCESS;//'0;

        ccif.iload[0] = '0;
        ccif.iload[1] = '0;
        ccif.iwait[0] = '1;
        ccif.iwait[1] = '1;
        //ccif.iload[0] = '0;
        //ccif.iload[1] = '0;

        ccif.ramstore = '0;
        ccif.ramaddr = '0;
        ccif.ramREN = '0;
        ccif.ramWEN = '0;
		 

        // Instruction read
       //if (ccif.ramstate == ACCESS && !(bmif.dREN || bmif.dWEN)) begin
            // Toggle between processors on instruction read
       	 	next_last_instr_req = !last_instr_req;
		//end 

        ccif.iwait[last_instr_req] = ccif.ramstate != ACCESS;
        ccif.iload[last_instr_req] = ccif.ramload;
        ccif.ramaddr = ccif.iaddr[last_instr_req];
        ccif.ramREN = ccif.iREN[last_instr_req];

        // Data Read / Write
        if (bmif.dREN || bmif.dWEN) begin
            {ccif.ramWEN, ccif.ramREN} = '0;
            bmif.dwait = ccif.ramstate != ACCESS;
            ccif.iwait[0] = 1;
            ccif.iwait[1] = 1;

            // Read
            bmif.dload = ccif.ramload;
            ccif.ramaddr = bmif.daddr;
            ccif.ramREN = bmif.dREN && !bmif.dWEN;

            if (bmif.dWEN) begin
                // Write
                ccif.ramWEN = 1;
                ccif.ramstore = bmif.dstore;
                ccif.ramaddr = bmif.daddr;
            end
        end
    end

//    always_comb begin
//        for (int i = 0; i < CPUS; i++) begin
//            // Defaults
//            ccif.dload[i] = '0;
//            ccif.dwait[i] = '0;
//
//            ccif.iload[i] = '0;
//            ccif.iwait[i] = '0;
//            ccif.iload[i] = '0;
//
//            ccif.ramstore = '0;
//            ccif.ramaddr = '0;
//            ccif.ramREN = '0;
//            ccif.ramWEN = '0;
//
//            // Instruction read
//            ccif. iwait[i] = ccif.ramstate != ACCESS;
//            ccif.iload[i] = ccif.ramload;
//            ccif.ramaddr = ccif.iaddr[i];
//            ccif.ramREN = ccif.iREN[i];
//
//            if (ccif.dREN[i] || ccif.dWEN[i]) begin
//                {ccif.ramWEN, ccif.ramREN} = '0;
//                ccif.dwait[i] = ccif.ramstate != ACCESS;
//                ccif.iwait[i] = 1;
//
//                // Read
//                ccif.dload[i] = ccif.ramload;
//                ccif.ramaddr = ccif.daddr[i];
//                ccif.ramREN = ccif.dREN[i] && !ccif.dWEN[i];
//
//                if (ccif.dWEN[i]) begin
//                    // Write
//                    ccif.ramWEN = 1;
//                    ccif.ramstore = ccif.dstore[i];
//                    ccif.ramaddr = ccif.daddr[i];
//                end
//            end
//        end
//
//    end

endmodule : memory_control
