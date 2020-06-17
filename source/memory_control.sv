/*
  Eric Villasenor
  evillase@gmail.com

  this block is the coherence protocol
  and artibtration for ram
*/

// interface include
`include "cache_control_if.vh"
`include "bus_mem_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module memory_control (
    input logic CLK, nRST,
    cache_control_if.cc ccif
);
    // type import
    import cpu_types_pkg::*;

    // number of cpus for cc
    parameter CPUS = 2;

    bus_mem_if bmif();

    bus_control BC (CLK, nRST, bmif);

    logic last_instr_req, next_last_instr_req;
    logic data_hit, next_data_hit;

    always_ff @(posedge CLK, negedge nRST) begin
        if (!nRST) begin
            last_instr_req <= 0;
            data_hit <= 0;
        end else begin
            last_instr_req <= next_last_instr_req;
            data_hit <= next_data_hit;
        end
    end

    // Outputs
    assign bmif.ccif_dREN = ccif.dREN;
    assign bmif.ccif_dWEN = ccif.dWEN;
    assign bmif.ccif_halt = ccif.halt;
    assign bmif.ccif_flushed = ccif.flushed;
    assign bmif.ccif_dstore = ccif.dstore;
    assign bmif.ccif_daddr = ccif.daddr;
    assign bmif.ccif_ccwrite = ccif.ccwrite;
    assign bmif.ccif_cctrans = ccif.cctrans;

    // Inputs
    assign ccif.dwait = bmif.ccif_dwait;
    assign ccif.dload = bmif.ccif_dload;
    assign ccif.ccwait = bmif.ccif_ccwait;
    assign ccif.ccinv = bmif.ccif_ccinv;
    assign ccif.ccsnoopaddr = bmif.ccif_ccsnoopaddr;

    // Arbitrate
    always_comb begin
        // Defaults
        bmif.dload = '0;
        bmif.dwait = '1; //ccif.ramstate != ACCESS;//'0;

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

        next_last_instr_req = last_instr_req;
        next_data_hit = data_hit;

        if (ccif.dREN[last_instr_req] | ccif.dWEN[last_instr_req]) begin

        end else if (ccif.iREN[0] == 0 && ccif.iREN[1] == 1) begin
            ccif.iwait[1] = ccif.ramstate != ACCESS;
            ccif.iload[1] = ccif.ramload;
            ccif.ramaddr = ccif.iaddr[1];
            ccif.ramREN = ccif.iREN[1];
        end else if (ccif.iREN[1] == 0 && ccif.iREN[0] == 1) begin
            ccif.iwait[0] = ccif.ramstate != ACCESS;
            ccif.iload[0] = ccif.ramload;
            ccif.ramaddr = ccif.iaddr[0];
            ccif.ramREN = ccif.iREN[0];
        end else begin
            ccif.iwait[last_instr_req] = ccif.ramstate != ACCESS;
            ccif.iload[last_instr_req] = ccif.ramload;
            ccif.ramaddr = ccif.iaddr[last_instr_req];
            ccif.ramREN = ccif.iREN[last_instr_req];
        end



        if (ccif.iwait[0] == 0) begin
            next_last_instr_req = 1;
        end else if (ccif.iwait[1] == 0) begin
            next_last_instr_req = 0;
        end

        // Data Read / Write
        if ((bmif.dREN || bmif.dWEN)/* & !data_hit*/) begin
            {ccif.ramWEN, ccif.ramREN} = '0;
            bmif.dwait = ccif.ramstate != ACCESS/* & !data_hit*/;
            ccif.iwait[0] = 1;
            ccif.iwait[1] = 1;

            // Read
            bmif.dload = ccif.ramload;
            ccif.ramaddr = bmif.daddr;
            ccif.ramREN = bmif.dREN && !bmif.dWEN;

            if (ccif.ramstate == ACCESS) begin
                next_data_hit = 1;
            end

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
