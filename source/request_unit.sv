// control unit interface
`include "request_unit_if.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

module request_unit (
    input logic CLK, nRST,
    request_unit_if.ru ruif
);
    // import types
    import cpu_types_pkg::*;

    logic next_dmemWEN, next_dmemREN; //next_imemREN

    always_ff @(posedge CLK, negedge nRST) begin
        if (!nRST) begin
            ruif.imemREN <= '0;
            ruif.dmemWEN <= '0;
            ruif.dmemREN <= '0;
        end else begin
            ruif.imemREN <= 1;
            ruif.dmemWEN <= next_dmemWEN;
            ruif.dmemREN <= next_dmemREN;
        end
    end

    always_comb begin
        next_dmemWEN = ruif.dmemWEN;
        next_dmemREN = ruif.dmemREN;

        //next_imemREN = 1; Set above for coverage (dumb)

        if(ruif.ihit) begin
            next_dmemWEN = ruif.dMemWr;
            next_dmemREN = ruif.dMemRe;
        end else if(ruif.dhit) begin
            next_dmemWEN = 0;
            next_dmemREN = 0;
        end
    end

endmodule : request_unit
