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

    alu_if aluif ();
    alu aluDUT(aluif);

    control_unit_if cuif ();
    control_unit cuDUT(cuif);

    program_counter_if pcif ();
    program_counter pcDUT(CLK, nRST, pcif);

    extender_if extif();
    extender extDUT(extif);

    ifid_if ifidif();
    ifid ifidDUT(CLK, nRST, ifidif);
    
    idex_if idexif(); 
    idex idexFAG(CLK, nRST, idexif); 
 
    exmem_if exmemif(); 
    exmem exmemFAG(CLK, nRST, exmemif); 

    memwb_if memwbif(); 
    memwb memwbFAG(CLK, nRST, memwbif); 
    
    j_t jt;
    assign jt = ifidif.instr_out;

    i_t it;
    assign it = ifidif.instr_out;

    r_t rt;
    assign rt = ifidif.instr_out;

    // Rt, Rd, 5'b31 Mux 
    //ID
    always_comb begin
        case ({memwbif.JType_out, memwbif.RegDst_out})
            2'b00: rfif.wsel = memwbif.rt_out;//rt.rt;
            2'b01: rfif.wsel = memwbif.rd_out;//rt.rd;
            2'b10: rfif.wsel = 5'd31;
            2'b11: rfif.wsel = 5'd31;
        endcase
    end

    // Rs, 0 Mux 
    //ID
    always_comb begin
        case (cuif.RegZero)
            0: rfif.rsel1 = rt.rs;
            1: rfif.rsel1 = '0;
        endcase
    end

    // rdat2, extender_out Mux 
    //EX
    always_comb begin
        case (idexif.AluSrc_out)
            0: aluif.portB = idexif.rdat2_out;
            1: aluif.portB = idexif.immext_out; // TODO: Create extender
        endcase
    end

    // alu_out, dmemload Mux
    // WB
    word_t wb_data_out;
    always_comb begin
        case (memwbif.MemToReg_out)
            0: wb_data_out = memwbif.aluOutport_out;
            1: wb_data_out = memwbif.dmemload_out;
        endcase
    end

    // PC + 4 Adder
    // IF
    word_t if_pcplus4;
    assign if_pcplus4 = pcif.count + 32'd4;

    // extif.out shift left 2
    // IF
    word_t if_ext_ls;
    assign if_ext_ls = extif.out << 2;

    // idexif.immext_out shift left 2
    // EX
    word_t ex_ext_ls;
    assign ex_ext_ls = idexif.immext_out << 2;

    // ex_ext_ls + (PC + 4) adder
    // EX
    word_t ex_branchaddr;
    assign ex_branchaddr = idexif.pcplus4_out + ex_ext_ls;

    // alu_out, dmemload Mux
    // WB
    word_t if_next_pc;
    always_comb begin
        case ({memwbif.JReg_out, memwbif.PcSrc_out})
            2'b00: if_next_pc = if_pcplus4; // PC + 4
            2'b01: if_next_pc = exmemif.branchaddr_out; // Branch
            2'b10: if_next_pc = rfif.rdat1; // JR
            2'b11: if_next_pc = if_ext_ls; // J/JAL
        endcase
    end

    // wb_data_out, memwbif.pcplus4_out Mux
    // ID
    always_comb begin
        case (memwbif.JType_out)
            0: rfif.wdat = wb_data_out;
            1: rfif.wdat = memwbif.pcplus4_out;
        endcase
    end

    // PC Inputs
    assign pcif.next_count = if_next_pc;
    assign pcif.countEn = dpif.ihit && !exmemif.Halt_out;

    // Datapath Outputs
    assign dpif.halt = exmemif.Halt_out;
    assign dpif.imemREN = 1'b1;
    assign dpif.dmemREN = exmemif.dMemREN_out;
    assign dpif.dmemWEN = exmemif.dMemWEN_out;
    assign dpif.imemaddr = pcif.count;
    assign dpif.dmemstore = exmemif.rdat2_out;
    assign dpif.dmemaddr = exmemif.aluOutport_out;

    // Register File Inputs
    assign rfif.rsel2 = rt.rt;
    assign rfif.WEN = memwbif.regWEN_out;
    
    // IF/ID Inputs
    assign ifidif.instr_in = dpif.imemload; 
    assign ifidif.pcplus4_in = if_pcplus4; 
  
    //ID/EX Inputs
    assign idexif.pcplus4_in = ifidif.pcplus4_out; 
    assign idexif.rdat1_in = rfif.rdat1; 
    assign idexif.rdat2_in = rfif.rdat2; 
    assign idexif.immext_in = extif.out;

    assign idexif.rt_in = rt.rt;
    assign idexif.rd_in = rt.rd;

    assign idexif.MemToReg_in = cuif.MemToReg; 
    assign idexif.AluOp_in = cuif.AluOp; 
    assign idexif.AluSrc_in = cuif.AluSrc; 
    assign idexif.JType_in = cuif.JType; 
    assign idexif.RegDst_in = cuif.RegDst; 
    assign idexif.regWEN_in = cuif.regWEN;     
    assign idexif.PcSrc_in = cuif.PcSrc; 
    assign idexif.JReg_in = cuif.JReg; 
    assign idexif.Halt_in = cuif.Halt; 
    assign idexif.dMemWEN_in = cuif.dMemWEN; 
    assign idexif.dMemREN_in = cuif.dMemREN; 

    //EX/MEM Inputs
    assign exmemif.pcplus4_in = idexif.pcplus4_out;
    assign exmemif.branchaddr_in = ex_branchaddr;
    assign exmemif.aluOutport_in = aluif.outPort;
    assign exmemif.rdat2_in = idexif.rdat2_out;

    assign exmemif.rt_in = idexif.rt_out;
    assign exmemif.rd_in = idexif.rd_out;

    assign exmemif.MemToReg_in = idexif.MemToReg_out;
    assign exmemif.JType_in = idexif.JType_out; 
    assign exmemif.RegDst_in = idexif.RegDst_out; 
    assign exmemif.regWEN_in = idexif.regWEN_out;     
    assign exmemif.PcSrc_in = idexif.PcSrc_out; 
    assign exmemif.JReg_in = idexif.JReg_out; 
    assign exmemif.Halt_in = idexif.Halt_out; 
    assign exmemif.dMemWEN_in = idexif.dMemWEN_out; 
    assign exmemif.dMemREN_in = idexif.dMemREN_out;

    //MEM/WB Inputs
 
    assign memwbif.pcplus4_in = exmemif.pcplus4_out; 
    assign memwbif.aluOutport_in = exmemif.aluOutport_out;
    assign memwbif.dmemload_in = dpif.dmemload;

    assign memwbif.rt_in = exmemif.rt_out;
    assign memwbif.rd_in = exmemif.rd_out;

    assign memwbif.MemToReg_in = exmemif.MemToReg_out;
    assign memwbif.JType_in = exmemif.JType_out; 
    assign memwbif.RegDst_in = exmemif.RegDst_out; 
    assign memwbif.regWEN_in = exmemif.regWEN_out;     
    assign memwbif.PcSrc_in = exmemif.PcSrc_out; 
    assign memwbif.JReg_in = exmemif.JReg_out;

    // ALU Connection Inputs
    assign aluif.portA = idexif.rdat1_out;
    assign aluif.aluOp = idexif.AluOp_out;

    // Control Unit Inputs
    assign cuif.Equal = rfif.rdat1 == rfif.rdat2;
    assign cuif.InstrOp = rt.opcode;
    assign cuif.InstrFunc = rt.funct;

    // Extender Inputs
    assign extif.imm16 = it.imm;
    assign extif.imm26 = jt.addr;
    assign extif.JType = cuif.JType;
    assign extif.ExtOp = cuif.ExtOp;
    assign extif.UpperImm = cuif.UpperImm;

endmodule : datapath
