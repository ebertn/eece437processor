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
 		
    //HAZARD UNIT
    hazard_if hazardif(); 
    hazard_unit HZ(hazardif);

    forward_if forwardif();
    forward_unit FUDUT(forwardif);

    // Instructions in IF stage
    j_t jt_if;
    assign jt_if = dpif.imemload;

    i_t it_if;
    assign it_if = dpif.imemload;

    r_t rt_if;
    assign rt_if = dpif.imemload;

    // Instructions in ID stage
    j_t jt;
    assign jt = ifidif.instr_out;

    i_t it;
    assign it = ifidif.instr_out;

    r_t rt;
    assign rt = ifidif.instr_out;

    // Instructions in EX stage
    j_t jt_ex;
    assign jt_ex = idexif.instr_out;

    i_t it_ex;
    assign it_ex = idexif.instr_out;

    r_t rt_ex;
    assign rt_ex = idexif.instr_out;

    // Instructions in MEM stage
    j_t jt_mem;
    assign jt_mem = exmemif.instr_out;

    i_t it_mem;
    assign it_mem = exmemif.instr_out;

    r_t rt_mem;
    assign rt_mem = exmemif.instr_out;

    // Instructions in WB stage
    j_t jt_wb;
    assign jt_wb = memwbif.instr_out;

    i_t it_wb;
    assign it_wb = memwbif.instr_out;

    r_t rt_wb;
    assign rt_wb = memwbif.instr_out;

    // Rt, Rd, 5'b31 Mux 
    //ID  
	//Changed where Jtype and RegDst come from 
    /*always_comb begin
        case ({memwbif.JType_out, memwbif.RegDst_out})
            2'b00: rfif.wsel = memwbif.rt_out;//rt.rt;
            2'b01: rfif.wsel = memwbif.rd_out;//rt.rd;
            2'b10: rfif.wsel = 5'd31;
            2'b11: rfif.wsel = 5'd31;
        endcase
    end*/ 
	always_comb begin
        case ({cuif.JType, cuif.RegDst})
            2'b00: idexif.writeReg_in = rt.rt;//rt.rt;
            2'b01: idexif.writeReg_in = rt.rd;//rt.rd;
            2'b10: idexif.writeReg_in = 5'd31;
            2'b11: idexif.writeReg_in = 5'd31;
        endcase
    end 
    assign rfif.wsel = memwbif.writeReg_out; 

    // Rs, 0 Mux 
    //ID
    always_comb begin
        case (cuif.RegZero)
            0: rfif.rsel1 = rt.rs;
            1: rfif.rsel1 = '0;
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
//    word_t ex_ext_ls;
//    assign ex_ext_ls = idexif.immext_in << 2;

    // if_ext_ls + (PC + 4) adder
    // ID
    word_t id_branchaddr;
    assign id_branchaddr = ifidif.pcplus4_out + if_ext_ls;

    // alu_out, dmemload Mux
    // WB
    word_t if_next_pc;
	/*
    always_comb begin
        case ({memwbif.JReg_out, memwbif.PcSrc_out})
            2'b00: if_next_pc = if_pcplus4; // PC + 4
            2'b01: if_next_pc = exmemif.branchaddr_out; // Branch
            2'b10: if_next_pc = rfif.rdat1; // JR
            2'b11: if_next_pc = if_ext_ls; // J/JAL
        endcase
    end*/
	//Changed for Hazard Detection
    logic [1:0] next_pc_src;
    assign next_pc_src = {cuif.JReg, (cuif.PcSrc && (hazardif.branch | hazardif.jump))};
	always_comb begin
        case (next_pc_src)
            2'b00: if_next_pc = if_pcplus4; // PC + 4
            2'b01: if_next_pc = id_branchaddr; // Branch
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

    // Forward A mux
    always_comb begin
        case (forwardif.forwardA)
            0: aluif.portA = idexif.rdat1_out;
            1: aluif.portA = rfif.wdat;
            2: aluif.portA = exmemif.aluOutport_out;
            3: aluif.portA = exmemif.aluOutport_out;
        endcase
    end

    // Forward B mux
    word_t forBmux;
    always_comb begin
        case (forwardif.forwardB)
            0: forBmux = idexif.rdat2_out;
            1: forBmux = rfif.wdat;
            2: forBmux = exmemif.aluOutport_out;
            3: forBmux = exmemif.aluOutport_out;
        endcase
    end

    // forBmux, extender_out Mux
    //EX
    always_comb begin
        case (idexif.AluSrc_out)
            0: aluif.portB = forBmux;
            1: aluif.portB = idexif.immext_out;
        endcase
    end

    // PC Inputs
    assign pcif.next_count = if_next_pc;
    assign pcif.countEn = (dpif.ihit | hazardif.branch | hazardif.jump) && !exmemif.Halt_out && (!hazardif.hazard || dpif.dhit);

    logic pipeline_reg_writeEN;
    assign pipeline_reg_writeEN = dpif.dhit || !hazardif.hazard && (dpif.ihit | hazardif.branch | hazardif.jump);

    // Datapath Outputs
    assign dpif.halt = memwbif.Halt_out;
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

    //assign ifidif.writeEN = dpif.ihit | dpif.dhit;
    //assign ifidif.flush = dpif.dmemREN | dpif.dmemWEN;
	assign ifidif.writeEN = pipeline_reg_writeEN;
	assign ifidif.flush = dpif.dhit || !hazardif.hazard && (hazardif.branch || hazardif.jump); //0; //(hazardif.branch | hazardif.jump) && !hazardif.hazard;
//    assign ifidif.flush = !hazardif.hazard && (dpif.dhit || hazardif.branch || hazardif.jump);

    //DEBUG BULLSHIT
    assign ifidif.next_pc_in = if_next_pc;  
  
    //ID/EX Inputs
    assign idexif.pcplus4_in = ifidif.pcplus4_out; 
    assign idexif.rdat1_in = rfif.rdat1; 
    assign idexif.rdat2_in = rfif.rdat2; 
    assign idexif.immext_in = extif.out;

    assign idexif.rt_in = rt.rt;
    assign idexif.rd_in = rt.rd;

    assign idexif.rsel1_in = rfif.rsel1;
    assign idexif.rsel2_in = rfif.rsel2;

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

    //assign idexif.writeEN = dpif.ihit | dpif.dhit;
    //assign idexif.flush = 0; //dpif.dmemREN | dpif.dmemWEN;
	assign idexif.writeEN = pipeline_reg_writeEN; //1; //!hazardif.hazard;
	assign idexif.flush = pipeline_reg_writeEN && hazardif.hazard && !dpif.dhit;
	
    //DEBUG BULLSHIT
    assign idexif.InstrOp_in = cuif.InstrOp; 
    assign idexif.InstrFunc_in = cuif.InstrFunc;
    assign idexif.rs_in = rt.rs; 
    assign idexif.instr_in = ifidif.instr_out; 
    assign idexif.next_pc_in = ifidif.next_pc_out; 
    assign idexif.imm_in = extif.out; 
    assign idexif.imm_16_in = it.imm; 
    assign idexif.shamt_in = rt.shamt; 

    //EX/MEM Inputs
    assign exmemif.pcplus4_in = idexif.pcplus4_out;
    //assign exmemif.branchaddr_in = ex_branchaddr;
    assign exmemif.aluOutport_in = aluif.outPort;
    assign exmemif.rdat2_in = forBmux;//idexif.rdat2_out;

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
 
    //assign exmemif.writeEN = dpif.ihit | dpif.dhit;
    //assign exmemif.flush = 0; //dpif.dmemREN | dpif.dmemWEN;
	assign exmemif.writeEN = pipeline_reg_writeEN; // /*!hazardif.hazard || dpif.ihit && */dpif.ihit || (!dpif.dmemWEN || dpif.dhit);//dpif.dhit;//1;//!hazardif.hazard;
   	assign exmemif.flush = 0; 
	assign exmemif.writeReg_in = idexif.writeReg_out; 

    //DEBUG BULLSHIT
    assign exmemif.InstrOp_in = idexif.InstrOp_out; 
    assign exmemif.InstrFunc_in = idexif.InstrFunc_out; 
    assign exmemif.rs_in = idexif.rs_out;  
    assign exmemif.instr_in = idexif.instr_out; 
    assign exmemif.next_pc_in = idexif.next_pc_out; 
    assign exmemif.imm_in =  idexif.imm_out;  
    assign exmemif.imm_16_in = idexif.imm_16_out; 
    assign exmemif.shamt_in = exmemif.shamt_out; 

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
    assign memwbif.Halt_in = exmemif.Halt_out; 

    //assign memwbif.writeEN = dpif.ihit | dpif.dhit;
    //assign memwbif.flush = 0;//dpif.dmemREN | dpif.dmemWEN;
	assign memwbif.writeEN = pipeline_reg_writeEN; //dpif.ihit || (!dpif.dmemREN || dpif.dhit);//!hazardif.hazard || dpif.ihit || dpif.dhit;//1;
    assign memwbif.flush = 0;
	assign memwbif.writeReg_in = exmemif.writeReg_out; 

    //DEBUG BULLSHIT
    assign memwbif.InstrOp_in = exmemif.InstrOp_out; 
    assign memwbif.InstrFunc_in = exmemif.InstrFunc_out; 
    assign memwbif.rs_in = exmemif.rs_out;  
    assign memwbif.instr_in = exmemif.instr_out; 
    assign memwbif.next_pc_in = exmemif.next_pc_out; 
    assign memwbif.imm_in =  exmemif.imm_out;  
    assign memwbif.imm_16_in = exmemif.imm_16_out; 
    assign memwbif.branchaddr_in = exmemif.branchaddr_out; 
    assign memwbif.shamt_in = memwbif.shamt_out; 

    // ALU Connection Inputs
    //assign aluif.portA = idexif.rdat1_out;
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

    // Hazard Unit Inputs
    assign hazardif.instrOp = it.opcode;
    assign hazardif.instrFunc = rt.funct;
    assign hazardif.equal = (rfif.rdat1 == rfif.rdat2);
    assign hazardif.rsel1 = rfif.rsel1; 
    assign hazardif.rsel2 = rfif.rsel2; 
    assign hazardif.mem_writeReg = exmemif.writeReg_out; 
    assign hazardif.ex_writeReg = idexif.writeReg_out;
    assign hazardif.dhit = dpif.dhit;
    assign hazardif.ex_regWEN = idexif.regWEN_out;
    assign hazardif.mem_regWEN = exmemif.regWEN_out;
    assign hazardif.ex_dmemREN = idexif.dMemREN_out;
    assign hazardif.ex_dmemWEN = idexif.dMemWEN_out;
    assign hazardif.mem_dmemWEN = exmemif.dMemWEN_out;
    assign hazardif.mem_dmemREN = exmemif.dMemREN_out;
    assign hazardif.id_dmemWEN = idexif.dMemWEN_in;
    assign hazardif.mem_instrOp = exmemif.InstrOp_out;
	//assign hazardif.ihit = dpif.ihit;

    // Forwarding Unit Inputs
    assign forwardif.rsel1 = idexif.rsel1_out;
    assign forwardif.rsel2 = idexif.rsel2_out;
    assign forwardif.mem_writeReg = exmemif.writeReg_out;
    assign forwardif.wb_writeReg = memwbif.writeReg_out;
    assign forwardif.mem_regWEN = exmemif.regWEN_out;
    assign forwardif.wb_regWEN = memwbif.regWEN_out;
//    assign forwardif.mem_dmemREN = idexif.dMemREN_out;
//    assign forwardif.mem_dmemWEN = idexif.dMemWEN_out;
    assign forwardif.mem_dmemREN = exmemif.dMemREN_out;
    assign forwardif.mem_dmemWEN = exmemif.dMemWEN_out;

endmodule : datapath
