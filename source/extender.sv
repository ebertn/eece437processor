// control unit interface
`include "extender_if.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

module extender (
    extender_if.ext extif
);

always_comb begin
    if(extif.JType) begin
        case (extif.ExtOp)
            1'b0: extif.out = {5'b0, extif.imm26};
            1'b1: extif.out = {{5{extif.imm26[25]}}, extif.imm26};
        endcase
    end else begin
        case ({extif.ExtOp, extif.UpperImm})
            2'b00: extif.out = {16'b0, extif.imm16};
            2'b01: extif.out = {extif.imm16, 16'b0};
            2'b10: extif.out = {{16{extif.imm16[15]}}, extif.imm16};
            2'b11: extif.out = {extif.imm16, 16'b0};
        endcase
    end
end

endmodule : extender