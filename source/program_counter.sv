// control unit interface
`include "program_counter_if.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

module program_counter (
    input logic CLK, nRST,
    program_counter_if.pc pcif
);
    // import types
    import cpu_types_pkg::*;

    word_t next_pc;

    always_ff @(posedge CLK, negedge nRST) begin
        if (!nRST) begin
            pcif.count <= '0;
        end else begin
            pcif.count <= next_pc;
        end
    end

    always_comb begin
        next_pc = pcif.countEn ? {pcif.next_count[31:2], 2'b00} : pcif.count;
    end

endmodule : program_counter
