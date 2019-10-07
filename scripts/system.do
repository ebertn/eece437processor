onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Fetch
add wave -noupdate -color Orange -label opcode -radix symbolic -radixshowbase 0 /system_tb/DUT/CPU/DP/jt_if.opcode
add wave -noupdate -color {Dark Orchid} -label funct /system_tb/DUT/CPU/DP/rt_if.funct
add wave -noupdate -group {Instruction IF} -label jt /system_tb/DUT/CPU/DP/jt_if
add wave -noupdate -group {Instruction IF} -label it /system_tb/DUT/CPU/DP/it_if
add wave -noupdate -group {Instruction IF} -label rt /system_tb/DUT/CPU/DP/rt_if
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP/pcif/countEn
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP/pcif/count
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP/pcif/next_count
add wave -noupdate -group {Next PC Mux} -radix unsigned /system_tb/DUT/CPU/DP/next_pc_src
add wave -noupdate -group {Next PC Mux} -label {pc + 4} /system_tb/DUT/CPU/DP/if_pcplus4
add wave -noupdate -group {Next PC Mux} -label {branch addr} /system_tb/DUT/CPU/DP/id_branchaddr
add wave -noupdate -group {Next PC Mux} -label {JR jump addr (rfif.rdat1)} /system_tb/DUT/CPU/DP/rfif/rdat1
add wave -noupdate -group {Next PC Mux} -label {J/JAL jump addr} /system_tb/DUT/CPU/DP/if_ext_ls
add wave -noupdate -group {Next PC Mux} /system_tb/DUT/CPU/DP/pcif/next_count
add wave -noupdate -group {DP Fetch} /system_tb/DUT/CPU/DP/dpif/ihit
add wave -noupdate -group {DP Fetch} /system_tb/DUT/CPU/DP/dpif/dhit
add wave -noupdate -group {DP Fetch} /system_tb/DUT/CPU/dcif/imemload
add wave -noupdate -group {DP Fetch} /system_tb/DUT/CPU/dcif/imemaddr
add wave -noupdate -group {DP Fetch} /system_tb/DUT/CPU/dcif/imemREN
add wave -noupdate -divider {IFID Register}
add wave -noupdate -group {IFID Register} /system_tb/DUT/CPU/DP/ifidif/writeEN
add wave -noupdate -group {IFID Register} /system_tb/DUT/CPU/DP/ifidif/flush
add wave -noupdate -group {IFID Register} /system_tb/DUT/CPU/DP/ifidif/pcplus4_in
add wave -noupdate -group {IFID Register} /system_tb/DUT/CPU/DP/ifidif/pcplus4_out
add wave -noupdate -group {IFID Register} /system_tb/DUT/CPU/DP/ifidif/instr_in
add wave -noupdate -group {IFID Register} /system_tb/DUT/CPU/DP/ifidif/instr_out
add wave -noupdate -group {IFID Register} /system_tb/DUT/CPU/DP/ifidif/next_pc_in
add wave -noupdate -group {IFID Register} /system_tb/DUT/CPU/DP/ifidif/next_pc_out
add wave -noupdate -divider Decode
add wave -noupdate -color Orange -label opcode /system_tb/DUT/CPU/DP/rt.opcode
add wave -noupdate -color {Dark Orchid} -label funct /system_tb/DUT/CPU/DP/rt.funct
add wave -noupdate -group {Instruction ID} /system_tb/DUT/CPU/DP/jt
add wave -noupdate -group {Instruction ID} /system_tb/DUT/CPU/DP/it
add wave -noupdate -group {Instruction ID} /system_tb/DUT/CPU/DP/rt
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/rfif/WEN
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/rfif/wsel
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/rfif/rsel1
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/rfif/rsel2
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/rfif/wdat
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/rfif/rdat1
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/rfif/rdat2
add wave -noupdate -group Extender /system_tb/DUT/CPU/DP/extif/JType
add wave -noupdate -group Extender /system_tb/DUT/CPU/DP/extif/ExtOp
add wave -noupdate -group Extender /system_tb/DUT/CPU/DP/extif/UpperImm
add wave -noupdate -group Extender /system_tb/DUT/CPU/DP/extif/out
add wave -noupdate -group Extender /system_tb/DUT/CPU/DP/extif/imm16
add wave -noupdate -group Extender /system_tb/DUT/CPU/DP/extif/imm26
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/Equal
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/PcSrc
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/Halt
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/dMemREN
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/dMemWEN
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/RegDst
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/MemToReg
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/regWEN
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/UpperImm
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/AluSrc
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/ExtOp
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/JType
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/RegZero
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/JReg
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/InstrOp
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/InstrFunc
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/AluOp
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/hazardif/rsel1
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/hazardif/rsel2
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/hazardif/mem_writeReg
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/hazardif/ex_writeReg
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/hazardif/hazard
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/hazardif/equal
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/hazardif/branch
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/hazardif/jump
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/hazardif/dhit
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/hazardif/ex_regWEN
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/hazardif/mem_regWEN
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/hazardif/ex_dmemREN
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/hazardif/id_dmemWEN
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/hazardif/hazardifstatement
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/hazardif/instrOp
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/hazardif/mem_instrOp
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/hazardif/instrFunc
add wave -noupdate -divider {IDEX Register}
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/writeEN
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/flush
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/pcplus4_in
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/rdat1_in
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/rdat2_in
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/immext_in
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/rt_in
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/rd_in
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/rsel1_in
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/rsel2_in
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/AluOp_in
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/MemToReg_in
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/AluSrc_in
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/JType_in
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/RegDst_in
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/regWEN_in
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/PcSrc_in
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/JReg_in
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/Halt_in
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/dMemWEN_in
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/dMemREN_in
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/pcplus4_out
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/rdat1_out
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/rdat2_out
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/immext_out
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/rt_out
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/rd_out
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/rsel1_out
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/rsel2_out
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/AluOp_out
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/MemToReg_out
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/AluSrc_out
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/JType_out
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/RegDst_out
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/regWEN_out
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/PcSrc_out
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/JReg_out
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/Halt_out
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/dMemWEN_out
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/dMemREN_out
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/InstrOp_in
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/InstrFunc_in
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/InstrOp_out
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/InstrFunc_out
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/rs_in
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/rs_out
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/instr_in
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/instr_out
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/next_pc_in
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/next_pc_out
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/imm_in
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/imm_out
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/imm_16_in
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/imm_16_out
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/shamt_in
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/shamt_out
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/writeReg_in
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP/idexif/writeReg_out
add wave -noupdate -divider Execute
add wave -noupdate -color Orange -label opcode /system_tb/DUT/CPU/DP/rt_ex.opcode
add wave -noupdate -color {Dark Orchid} -label funct /system_tb/DUT/CPU/DP/rt_ex.funct
add wave -noupdate -group {Instruction EX} /system_tb/DUT/CPU/DP/jt_ex
add wave -noupdate -group {Instruction EX} /system_tb/DUT/CPU/DP/it_ex
add wave -noupdate -group {Instruction EX} /system_tb/DUT/CPU/DP/rt_ex
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/negative
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/overflow
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/zero
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/portA
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/portB
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/outPort
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/aluOp
add wave -noupdate -group {Control Signals EX} /system_tb/DUT/CPU/DP/idexif/AluOp_out
add wave -noupdate -group {Control Signals EX} /system_tb/DUT/CPU/DP/idexif/AluSrc_out
add wave -noupdate -group {Forwarding Unit} /system_tb/DUT/CPU/DP/forwardif/forwardA
add wave -noupdate -group {Forwarding Unit} /system_tb/DUT/CPU/DP/forwardif/forwardB
add wave -noupdate -group {Forwarding Unit} /system_tb/DUT/CPU/DP/forwardif/rsel1
add wave -noupdate -group {Forwarding Unit} /system_tb/DUT/CPU/DP/forwardif/rsel2
add wave -noupdate -group {Forwarding Unit} /system_tb/DUT/CPU/DP/forwardif/mem_writeReg
add wave -noupdate -group {Forwarding Unit} /system_tb/DUT/CPU/DP/forwardif/wb_writeReg
add wave -noupdate -group {Forwarding Unit} /system_tb/DUT/CPU/DP/forwardif/mem_regWEN
add wave -noupdate -group {Forwarding Unit} /system_tb/DUT/CPU/DP/forwardif/wb_regWEN
add wave -noupdate -group {Forwarding Unit} /system_tb/DUT/CPU/DP/forwardif/mem_dmemREN
add wave -noupdate -group {Forwarding Unit} /system_tb/DUT/CPU/DP/forwardif/mem_dmemWEN
add wave -noupdate -divider {EXMEM Register}
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/writeEN
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/flush
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/pcplus4_in
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/branchaddr_in
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/aluOutport_in
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/rdat2_in
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/rt_in
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/rd_in
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/MemToReg_in
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/JType_in
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/RegDst_in
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/regWEN_in
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/PcSrc_in
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/JReg_in
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/Halt_in
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/dMemWEN_in
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/dMemREN_in
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/pcplus4_out
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/branchaddr_out
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/aluOutport_out
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/rdat2_out
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/rt_out
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/rd_out
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/MemToReg_out
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/JType_out
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/RegDst_out
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/regWEN_out
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/PcSrc_out
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/JReg_out
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/Halt_out
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/dMemWEN_out
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/dMemREN_out
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/InstrOp_in
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/InstrFunc_in
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/InstrOp_out
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/InstrFunc_out
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/rs_in
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/rs_out
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/instr_in
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/instr_out
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/next_pc_in
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/next_pc_out
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/imm_in
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/imm_out
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/imm_16_in
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/imm_16_out
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/shamt_in
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/shamt_out
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/writeReg_in
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP/exmemif/writeReg_out
add wave -noupdate -divider Memory
add wave -noupdate -color Orange -label opcode /system_tb/DUT/CPU/DP/rt_mem.opcode
add wave -noupdate -color {Dark Orchid} -label funct /system_tb/DUT/CPU/DP/rt_mem.funct
add wave -noupdate -group {Instruction MEM} /system_tb/DUT/CPU/DP/jt_mem
add wave -noupdate -group {Instruction MEM} /system_tb/DUT/CPU/DP/it_mem
add wave -noupdate -group {Instruction MEM} -expand /system_tb/DUT/CPU/DP/rt_mem
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/ihit
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/dhit
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/dmemREN
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/dmemWEN
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/dmemload
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/dmemstore
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/dmemaddr
add wave -noupdate -divider {MEMWB Register}
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/writeEN
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/flush
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/pcplus4_in
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/aluOutport_in
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/dmemload_in
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/rt_in
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/rd_in
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/MemToReg_in
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/JType_in
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/RegDst_in
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/regWEN_in
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/PcSrc_in
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/JReg_in
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/Halt_in
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/pcplus4_out
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/aluOutport_out
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/dmemload_out
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/rt_out
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/rd_out
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/MemToReg_out
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/JType_out
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/RegDst_out
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/regWEN_out
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/PcSrc_out
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/JReg_out
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/Halt_out
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/InstrOp_in
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/InstrFunc_in
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/InstrOp_out
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/InstrFunc_out
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/rs_in
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/rs_out
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/instr_in
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/instr_out
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/next_pc_in
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/next_pc_out
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/imm_in
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/imm_out
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/branchaddr_in
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/branchaddr_out
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/imm_16_in
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/imm_16_out
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/shamt_in
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/shamt_out
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/writeReg_in
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP/memwbif/writeReg_out
add wave -noupdate -divider {Write Back}
add wave -noupdate -color Orange -label opcode /system_tb/DUT/CPU/DP/rt_wb.opcode
add wave -noupdate -color {Dark Orchid} -label funct /system_tb/DUT/CPU/DP/rt_wb.funct
add wave -noupdate -group {Instruction WB} /system_tb/DUT/CPU/DP/jt_wb
add wave -noupdate -group {Instruction WB} /system_tb/DUT/CPU/DP/it_wb
add wave -noupdate -group {Instruction WB} -expand /system_tb/DUT/CPU/DP/rt_wb
add wave -noupdate /system_tb/DUT/CPU/DP/wb_data_out
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -color Cyan /system_tb/DUT/CPU/DP/dpif/halt
add wave -noupdate -color White /system_tb/DUT/CPU/DP/CLK
add wave -noupdate -color Red /system_tb/DUT/CPU/DP/nRST
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {519543 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 195
configure wave -valuecolwidth 132
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {2722 ns}
