/*
  Eric Villasenor
  evillase@gmail.com

  datapath contains register file, control, hazard,
  muxes, and glue logic for processor
*/

// data path interface
`include "datapath_cache_if.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

module datapath (
    input logic CLK, nRST,
    datapath_cache_if.dp dpif
);
    // import types
    import cpu_types_pkg::*;

    // pc init
    parameter PC_INIT = 0;

    register_file_if rfif ();
    register_file rfDUT(CLK, nRST, rfif);

    request_unit_if ruif ();
    request_unit ruDUT(CLK, nRST, ruif);

    alu_if aluif ();
    alu aluDUT(aluif);

    control_unit_if cuif ();
    control_unit cuDUT(cuif);

    program_counter_if pcif ();
    program_counter pcDUT(CLK, nRST, pcif);

    extender_if extif();
    extender extDUT(extif);

    j_t jt;
    assign jt = dpif.imemload;

    i_t it;
    assign it = dpif.imemload;

    r_t rt;
    assign rt = dpif.imemload;

    // Rt, Rd, 5'b31 Mux
    always_comb begin
        case ({cuif.JType, cuif.RegDst})
            2'b00: rfif.wsel = rt.rt;
            2'b01: rfif.wsel = rt.rd;
            2'b10: rfif.wsel = 5'd31;
            2'b11: rfif.wsel = 5'd31;
        endcase
    end

    // Rs, 0 Mux
    always_comb begin
        case (cuif.RegZero)
            0: rfif.rsel1 = rt.rs;
            1: rfif.rsel1 = '0;
        endcase
    end

    // rdat2, extender_out Mux
    always_comb begin
        case (cuif.AluSrc)
            0: aluif.portB = rfif.rdat2;
            1: aluif.portB = extif.out; // TODO: Create extender
        endcase
    end

    // alu_out, dmemload Mux
    word_t data_out;
    always_comb begin
        case (cuif.MemToReg)
            0: data_out = aluif.outPort;
            1: data_out = dpif.dmemload;
        endcase
    end

    // PC + 4 Adder
    word_t PC_plus4;
    assign PC_plus4 = pcif.count + 32'd4;

    // extif.out shift left 2
    word_t ext_ls;
    assign ext_ls = extif.out << 2;

    // ext_ls + (PC + 4) adder
    word_t PC_plus_ext;
    assign PC_plus_ext = PC_plus4 + ext_ls;

    // alu_out, dmemload Mux
    word_t next_PC;
    always_comb begin
        case ({cuif.JReg, cuif.PcSrc})
            2'b00: next_PC = PC_plus4; // PC + 4
            2'b01: next_PC = PC_plus_ext; // Branch
            2'b10: next_PC = rfif.rdat1; // JR
            2'b11: next_PC = ext_ls; // J/JAL
        endcase
    end

    // PC Inputs
    assign pcif.next_count = next_PC;
    assign pcif.countEn = dpif.ihit && !dpif.halt;
    //assign dpif.imemaddr = pcif.pc;

    // Request Unit Inputs
    assign ruif.iMemRe = cuif.iMemRe;
    assign ruif.dMemWr = cuif.dMemWr;
    assign ruif.dMemRe = cuif.dMemRe;
    assign ruif.ihit = dpif.ihit;
    assign ruif.dhit = dpif.dhit;

    // Datapath Inputs
    assign dpif.halt = cuif.Halt;
    assign dpif.imemREN = ruif.imemREN;
    assign dpif.dmemREN = ruif.dmemREN;
    assign dpif.dmemWEN = ruif.dmemWEN;
    assign dpif.imemaddr = pcif.count;
    assign dpif.dmemstore = rfif.rdat2;
    assign dpif.dmemaddr = aluif.outPort;

    // Register File Inputs
    assign rfif.rsel2 = rt.rt;
    assign rfif.WEN = cuif.regWEN;

    // ALU Connections
    assign aluif.portA = rfif.rdat1;
    assign aluif.aluOp = cuif.AluOp;

    // Control Unit Inputs
    assign cuif.Equal = aluif.zero;
    assign cuif.InstrOp = rt.opcode;
    assign cuif.InstrFunc = rt.funct;

    // Extender Inputs
    assign extif.imm16 = it.imm;
    assign extif.imm26 = jt.addr;
    assign extif.JType = cuif.JType;
    assign extif.ExtOp = cuif.ExtOp;
    assign extif.UpperImm = cuif.UpperImm;

    // next_PC, data_out Mux
    always_comb begin
        case (cuif.JType)
            0: rfif.wdat = data_out;
            1: rfif.wdat = PC_plus4;//next_PC;
        endcase
    end

endmodule : datapath
