onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {CPU 0}
add wave -noupdate -divider Fetch
add wave -noupdate -color Orange -label opcode -radix symbolic -radixshowbase 0 /system_tb/DUT/CPU/DP0/jt_if.opcode
add wave -noupdate -color {Dark Orchid} -label funct /system_tb/DUT/CPU/DP0/rt_if.funct
add wave -noupdate -expand -group {Instruction IF} -label jt -expand /system_tb/DUT/CPU/DP0/jt_if
add wave -noupdate -expand -group {Instruction IF} -label it /system_tb/DUT/CPU/DP0/it_if
add wave -noupdate -expand -group {Instruction IF} -label rt /system_tb/DUT/CPU/DP0/rt_if
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP0/pcif/countEn
add wave -noupdate -group {Program Counter} -color {Blue Violet} -radix unsigned /system_tb/DUT/CPU/DP0/pcif/count
add wave -noupdate -group {Program Counter} -radix unsigned /system_tb/DUT/CPU/DP0/pcif/next_count
add wave -noupdate -group {Next PC Mux} -radix unsigned /system_tb/DUT/CPU/DP0/next_pc_src
add wave -noupdate -group {Next PC Mux} -label {pc + 4} -radix unsigned /system_tb/DUT/CPU/DP0/if_pcplus4
add wave -noupdate -group {Next PC Mux} -label {branch addr} -radix unsigned /system_tb/DUT/CPU/DP0/id_branchaddr
add wave -noupdate -group {Next PC Mux} -label {JR jump addr (rfif.rdat1)} -radix unsigned /system_tb/DUT/CPU/DP0/rfif/rdat1
add wave -noupdate -group {Next PC Mux} -label {J/JAL jump addr} -radix unsigned /system_tb/DUT/CPU/DP0/if_ext_ls
add wave -noupdate -group {Next PC Mux} -radix unsigned /system_tb/DUT/CPU/DP0/pcif/next_count
add wave -noupdate -group {DP0 Fetch} /system_tb/DUT/CPU/DP0/dpif/ihit
add wave -noupdate -group {DP0 Fetch} /system_tb/DUT/CPU/DP0/dpif/dhit
add wave -noupdate -divider {IFID Register}
add wave -noupdate -group {IFID Register} /system_tb/DUT/CPU/DP0/ifidif/writeEN
add wave -noupdate -group {IFID Register} /system_tb/DUT/CPU/DP0/ifidif/flush
add wave -noupdate -group {IFID Register} -group Other /system_tb/DUT/CPU/DP0/ifidif/pcplus4_in
add wave -noupdate -group {IFID Register} -group Other /system_tb/DUT/CPU/DP0/ifidif/pcplus4_out
add wave -noupdate -group {IFID Register} -group Other /system_tb/DUT/CPU/DP0/ifidif/instr_in
add wave -noupdate -group {IFID Register} -group Other /system_tb/DUT/CPU/DP0/ifidif/instr_out
add wave -noupdate -group {IFID Register} -group Other /system_tb/DUT/CPU/DP0/ifidif/next_pc_in
add wave -noupdate -group {IFID Register} -group Other /system_tb/DUT/CPU/DP0/ifidif/next_pc_out
add wave -noupdate -divider Decode
add wave -noupdate -color Orange -label opcode /system_tb/DUT/CPU/DP0/rt.opcode
add wave -noupdate -color {Dark Orchid} -label funct /system_tb/DUT/CPU/DP0/rt.funct
add wave -noupdate -group {Instruction ID} /system_tb/DUT/CPU/DP0/jt
add wave -noupdate -group {Instruction ID} /system_tb/DUT/CPU/DP0/it
add wave -noupdate -group {Instruction ID} /system_tb/DUT/CPU/DP0/rt
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP0/rfDUT/registers
add wave -noupdate -group {Register File} {/system_tb/DUT/CPU/DP0/rfDUT/registers[7]}
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP0/rfif/WEN
add wave -noupdate -group {Register File} -radix unsigned /system_tb/DUT/CPU/DP0/rfif/wsel
add wave -noupdate -group {Register File} -radix unsigned /system_tb/DUT/CPU/DP0/rfif/rsel1
add wave -noupdate -group {Register File} -radix unsigned /system_tb/DUT/CPU/DP0/rfif/rsel2
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP0/rfif/wdat
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP0/rfif/rdat1
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP0/rfif/rdat2
add wave -noupdate -group Extender /system_tb/DUT/CPU/DP0/extif/JType
add wave -noupdate -group Extender /system_tb/DUT/CPU/DP0/extif/ExtOp
add wave -noupdate -group Extender /system_tb/DUT/CPU/DP0/extif/UpperImm
add wave -noupdate -group Extender /system_tb/DUT/CPU/DP0/extif/out
add wave -noupdate -group Extender /system_tb/DUT/CPU/DP0/extif/imm16
add wave -noupdate -group Extender /system_tb/DUT/CPU/DP0/extif/imm26
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP0/cuif/Equal
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP0/cuif/PcSrc
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP0/cuif/Halt
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP0/cuif/dMemREN
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP0/cuif/dMemWEN
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP0/cuif/RegDst
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP0/cuif/MemToReg
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP0/cuif/regWEN
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP0/cuif/UpperImm
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP0/cuif/AluSrc
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP0/cuif/ExtOp
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP0/cuif/JType
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP0/cuif/RegZero
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP0/cuif/JReg
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP0/cuif/InstrOp
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP0/cuif/InstrFunc
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP0/cuif/AluOp
add wave -noupdate -group {Hazard Unit} -color Orange /system_tb/DUT/CPU/DP0/hazardif/hazard
add wave -noupdate -group {Hazard Unit} -color Turquoise /system_tb/DUT/CPU/DP0/hazardif/branch
add wave -noupdate -group {Hazard Unit} -color {Orange Red} /system_tb/DUT/CPU/DP0/hazardif/jump
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP0/hazardif/equal
add wave -noupdate -group {Hazard Unit} -group Inputs -radix unsigned /system_tb/DUT/CPU/DP0/hazardif/rsel1
add wave -noupdate -group {Hazard Unit} -group Inputs -radix unsigned /system_tb/DUT/CPU/DP0/hazardif/rsel2
add wave -noupdate -group {Hazard Unit} -group Inputs -radix unsigned /system_tb/DUT/CPU/DP0/hazardif/mem_writeReg
add wave -noupdate -group {Hazard Unit} -group Inputs -radix unsigned /system_tb/DUT/CPU/DP0/hazardif/ex_writeReg
add wave -noupdate -group {Hazard Unit} -group Inputs /system_tb/DUT/CPU/DP0/hazardif/dhit
add wave -noupdate -group {Hazard Unit} -group Inputs /system_tb/DUT/CPU/DP0/hazardif/ex_regWEN
add wave -noupdate -group {Hazard Unit} -group Inputs /system_tb/DUT/CPU/DP0/hazardif/mem_regWEN
add wave -noupdate -group {Hazard Unit} -group Inputs /system_tb/DUT/CPU/DP0/hazardif/ex_dmemREN
add wave -noupdate -group {Hazard Unit} -group Inputs /system_tb/DUT/CPU/DP0/hazardif/id_dmemWEN
add wave -noupdate -group {Hazard Unit} -group Inputs /system_tb/DUT/CPU/DP0/hazardif/instrOp
add wave -noupdate -group {Hazard Unit} -group Inputs /system_tb/DUT/CPU/DP0/hazardif/mem_instrOp
add wave -noupdate -group {Hazard Unit} -group Inputs /system_tb/DUT/CPU/DP0/hazardif/instrFunc
add wave -noupdate -divider {IDEX Register}
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP0/idexif/writeEN
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP0/idexif/flush
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/pcplus4_in
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/rdat1_in
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/rdat2_in
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/immext_in
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/rt_in
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/rd_in
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/rsel1_in
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/rsel2_in
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/AluOp_in
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/MemToReg_in
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/AluSrc_in
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/JType_in
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/RegDst_in
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/regWEN_in
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/PcSrc_in
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/JReg_in
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/Halt_in
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/dMemWEN_in
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/dMemREN_in
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/pcplus4_out
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/rdat1_out
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/rdat2_out
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/immext_out
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/rt_out
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/rd_out
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/rsel1_out
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/rsel2_out
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/AluOp_out
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/MemToReg_out
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/AluSrc_out
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/JType_out
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/RegDst_out
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/regWEN_out
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/PcSrc_out
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/JReg_out
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/Halt_out
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/dMemWEN_out
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/dMemREN_out
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/InstrOp_in
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/InstrFunc_in
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/InstrOp_out
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/InstrFunc_out
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/rs_in
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/rs_out
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/instr_in
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/instr_out
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/next_pc_in
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/next_pc_out
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/imm_in
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/imm_out
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/imm_16_in
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/imm_16_out
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/shamt_in
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/shamt_out
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/writeReg_in
add wave -noupdate -group {IDEX Register} -group Other /system_tb/DUT/CPU/DP0/idexif/writeReg_out
add wave -noupdate -divider Execute
add wave -noupdate -color Orange -label opcode /system_tb/DUT/CPU/DP0/rt_ex.opcode
add wave -noupdate -color {Dark Orchid} -label funct /system_tb/DUT/CPU/DP0/rt_ex.funct
add wave -noupdate -group {Instruction EX} /system_tb/DUT/CPU/DP0/jt_ex
add wave -noupdate -group {Instruction EX} /system_tb/DUT/CPU/DP0/it_ex
add wave -noupdate -group {Instruction EX} /system_tb/DUT/CPU/DP0/rt_ex
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP0/aluif/negative
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP0/aluif/overflow
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP0/aluif/zero
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP0/aluif/portA
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP0/aluif/portB
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP0/aluif/outPort
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP0/aluif/aluOp
add wave -noupdate -group {Control Signals EX} /system_tb/DUT/CPU/DP0/idexif/AluOp_out
add wave -noupdate -group {Control Signals EX} /system_tb/DUT/CPU/DP0/idexif/AluSrc_out
add wave -noupdate -group {Forwarding Unit} /system_tb/DUT/CPU/DP0/forwardif/forwardA
add wave -noupdate -group {Forwarding Unit} /system_tb/DUT/CPU/DP0/forwardif/forwardB
add wave -noupdate -group {Forwarding Unit} /system_tb/DUT/CPU/DP0/forwardif/rsel1
add wave -noupdate -group {Forwarding Unit} /system_tb/DUT/CPU/DP0/forwardif/rsel2
add wave -noupdate -group {Forwarding Unit} /system_tb/DUT/CPU/DP0/forwardif/mem_writeReg
add wave -noupdate -group {Forwarding Unit} /system_tb/DUT/CPU/DP0/forwardif/wb_writeReg
add wave -noupdate -group {Forwarding Unit} /system_tb/DUT/CPU/DP0/forwardif/mem_regWEN
add wave -noupdate -group {Forwarding Unit} /system_tb/DUT/CPU/DP0/forwardif/wb_regWEN
add wave -noupdate -group {Forwarding Unit} /system_tb/DUT/CPU/DP0/forwardif/mem_dmemREN
add wave -noupdate -group {Forwarding Unit} /system_tb/DUT/CPU/DP0/forwardif/mem_dmemWEN
add wave -noupdate -divider {EXMEM Register}
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP0/exmemif/writeEN
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP0/exmemif/flush
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/pcplus4_in
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/branchaddr_in
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/aluOutport_in
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/rdat2_in
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/rt_in
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/rd_in
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/MemToReg_in
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/JType_in
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/RegDst_in
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/regWEN_in
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/PcSrc_in
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/JReg_in
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/Halt_in
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/dMemWEN_in
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/dMemREN_in
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/pcplus4_out
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/branchaddr_out
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/aluOutport_out
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/rdat2_out
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/rt_out
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/rd_out
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/MemToReg_out
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/JType_out
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/RegDst_out
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/regWEN_out
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/PcSrc_out
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/JReg_out
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/Halt_out
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/dMemWEN_out
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/dMemREN_out
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/InstrOp_in
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/InstrFunc_in
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/InstrOp_out
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/InstrFunc_out
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/rs_in
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/rs_out
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/instr_in
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/instr_out
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/next_pc_in
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/next_pc_out
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/imm_in
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/imm_out
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/imm_16_in
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/imm_16_out
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/shamt_in
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/shamt_out
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/writeReg_in
add wave -noupdate -group {EXMEM Register} -group Other /system_tb/DUT/CPU/DP0/exmemif/writeReg_out
add wave -noupdate -divider Memory
add wave -noupdate -color Orange -label opcode /system_tb/DUT/CPU/DP0/rt_mem.opcode
add wave -noupdate -color {Dark Orchid} -label funct /system_tb/DUT/CPU/DP0/rt_mem.funct
add wave -noupdate -group {Instruction MEM} /system_tb/DUT/CPU/DP0/jt_mem
add wave -noupdate -group {Instruction MEM} /system_tb/DUT/CPU/DP0/it_mem
add wave -noupdate -group {Instruction MEM} -expand /system_tb/DUT/CPU/DP0/rt_mem
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP0/dpif/ihit
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP0/dpif/dhit
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP0/dpif/dmemREN
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP0/dpif/dmemWEN
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP0/dpif/dmemload
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP0/dpif/dmemstore
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP0/dpif/dmemaddr
add wave -noupdate -divider {MEMWB Register}
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP0/memwbif/writeEN
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP0/memwbif/flush
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/pcplus4_in
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/aluOutport_in
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/dmemload_in
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/rt_in
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/rd_in
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/MemToReg_in
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/JType_in
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/RegDst_in
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/regWEN_in
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/PcSrc_in
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/JReg_in
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/Halt_in
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/pcplus4_out
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/aluOutport_out
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/dmemload_out
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/rt_out
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/rd_out
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/MemToReg_out
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/JType_out
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/RegDst_out
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/regWEN_out
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/PcSrc_out
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/JReg_out
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/Halt_out
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/InstrOp_in
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/InstrFunc_in
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/InstrOp_out
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/InstrFunc_out
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/rs_in
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/rs_out
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/instr_in
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/instr_out
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/next_pc_in
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/next_pc_out
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/imm_in
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/imm_out
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/branchaddr_in
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/branchaddr_out
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/imm_16_in
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/imm_16_out
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/shamt_in
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/shamt_out
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/writeReg_in
add wave -noupdate -group {MEMWB Register} -group Other /system_tb/DUT/CPU/DP0/memwbif/writeReg_out
add wave -noupdate -divider {Write Back}
add wave -noupdate -color Orange -label opcode /system_tb/DUT/CPU/DP0/rt_wb.opcode
add wave -noupdate -color {Dark Orchid} -label funct /system_tb/DUT/CPU/DP0/rt_wb.funct
add wave -noupdate -group {Instruction WB} /system_tb/DUT/CPU/DP0/jt_wb
add wave -noupdate -group {Instruction WB} /system_tb/DUT/CPU/DP0/it_wb
add wave -noupdate -group {Instruction WB} -expand /system_tb/DUT/CPU/DP0/rt_wb
add wave -noupdate /system_tb/DUT/CPU/DP0/wb_data_out
add wave -noupdate -divider Caches
add wave -noupdate -group {Instruction Cache} /system_tb/DUT/CPU/cif0/iwait
add wave -noupdate -group {Instruction Cache} /system_tb/DUT/CPU/cif0/iREN
add wave -noupdate -group {Instruction Cache} /system_tb/DUT/CPU/cif0/iload
add wave -noupdate -group {Instruction Cache} /system_tb/DUT/CPU/cif0/iaddr
add wave -noupdate -group {Data Cache} /system_tb/DUT/CPU/cif0/dwait
add wave -noupdate -group {Data Cache} /system_tb/DUT/CPU/cif0/dREN
add wave -noupdate -group {Data Cache} /system_tb/DUT/CPU/cif0/dWEN
add wave -noupdate -group {Data Cache} /system_tb/DUT/CPU/cif0/dload
add wave -noupdate -group {Data Cache} /system_tb/DUT/CPU/cif0/dstore
add wave -noupdate -group {Data Cache} /system_tb/DUT/CPU/cif0/daddr
add wave -noupdate -group {Data Cache} /system_tb/DUT/CPU/cif0/ccwait
add wave -noupdate -group {Data Cache} /system_tb/DUT/CPU/cif0/ccinv
add wave -noupdate -group {Data Cache} /system_tb/DUT/CPU/cif0/ccwrite
add wave -noupdate -group {Data Cache} /system_tb/DUT/CPU/cif0/cctrans
add wave -noupdate -group {Data Cache} /system_tb/DUT/CPU/cif0/ccsnoopaddr
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -divider {CPU 1}
add wave -noupdate -divider Fetch
add wave -noupdate -color Orange -label opcode -radix symbolic -radixshowbase 0 /system_tb/DUT/CPU/DP1/jt_if.opcode
add wave -noupdate -color {Dark Orchid} -label funct /system_tb/DUT/CPU/DP1/rt_if.funct
add wave -noupdate -expand -group {Instruction IF 1} -label jt /system_tb/DUT/CPU/DP1/jt_if
add wave -noupdate -expand -group {Instruction IF 1} -label it /system_tb/DUT/CPU/DP1/it_if
add wave -noupdate -expand -group {Instruction IF 1} -label rt /system_tb/DUT/CPU/DP1/rt_if
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP1/pcif/countEn
add wave -noupdate -group {Program Counter} -color {Blue Violet} -radix unsigned /system_tb/DUT/CPU/DP1/pcif/count
add wave -noupdate -group {Program Counter} -radix unsigned /system_tb/DUT/CPU/DP1/pcif/next_count
add wave -noupdate -group {Next PC Mux} -radix unsigned /system_tb/DUT/CPU/DP1/next_pc_src
add wave -noupdate -group {Next PC Mux} -radix unsigned /system_tb/DUT/CPU/DP1/if_pcplus4
add wave -noupdate -group {Next PC Mux} -radix unsigned /system_tb/DUT/CPU/DP1/id_branchaddr
add wave -noupdate -group {Next PC Mux} -radix unsigned /system_tb/DUT/CPU/DP1/rfif/rdat1
add wave -noupdate -group {Next PC Mux} -radix unsigned /system_tb/DUT/CPU/DP1/if_ext_ls
add wave -noupdate -group {Next PC Mux} -radix unsigned /system_tb/DUT/CPU/DP1/pcif/next_count
add wave -noupdate -group {DP1 Fetch} /system_tb/DUT/CPU/DP1/dpif/ihit
add wave -noupdate -group {DP1 Fetch} /system_tb/DUT/CPU/DP1/dpif/dhit
add wave -noupdate -divider {IFID Register}
add wave -noupdate -group {IFID Register} /system_tb/DUT/CPU/DP1/ifidif/writeEN
add wave -noupdate -group {IFID Register} /system_tb/DUT/CPU/DP1/ifidif/flush
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/ifidif/pcplus4_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/ifidif/pcplus4_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/ifidif/instr_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/ifidif/instr_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/ifidif/next_pc_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/ifidif/next_pc_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/pcplus4_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/rdat1_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/rdat2_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/immext_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/rt_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/rd_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/rsel1_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/rsel2_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/AluOp_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/MemToReg_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/AluSrc_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/JType_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/RegDst_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/regWEN_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/PcSrc_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/JReg_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/Halt_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/dMemWEN_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/dMemREN_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/pcplus4_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/rdat1_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/rdat2_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/immext_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/rt_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/rd_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/rsel1_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/rsel2_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/AluOp_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/MemToReg_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/AluSrc_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/JType_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/RegDst_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/regWEN_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/PcSrc_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/JReg_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/Halt_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/dMemWEN_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/dMemREN_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/InstrOp_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/InstrFunc_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/InstrOp_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/InstrFunc_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/rs_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/rs_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/instr_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/instr_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/next_pc_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/next_pc_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/imm_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/imm_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/imm_16_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/imm_16_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/shamt_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/shamt_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/writeReg_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/idexif/writeReg_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/pcplus4_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/branchaddr_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/aluOutport_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/rdat2_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/rt_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/rd_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/MemToReg_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/JType_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/RegDst_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/regWEN_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/PcSrc_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/JReg_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/Halt_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/dMemWEN_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/dMemREN_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/pcplus4_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/branchaddr_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/aluOutport_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/rdat2_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/rt_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/rd_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/MemToReg_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/JType_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/RegDst_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/regWEN_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/PcSrc_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/JReg_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/Halt_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/dMemWEN_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/dMemREN_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/InstrOp_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/InstrFunc_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/InstrOp_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/InstrFunc_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/rs_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/rs_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/instr_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/instr_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/next_pc_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/next_pc_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/imm_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/imm_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/imm_16_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/imm_16_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/shamt_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/shamt_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/writeReg_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/exmemif/writeReg_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/pcplus4_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/aluOutport_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/dmemload_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/rt_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/rd_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/MemToReg_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/JType_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/RegDst_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/regWEN_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/PcSrc_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/JReg_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/Halt_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/pcplus4_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/aluOutport_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/dmemload_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/rt_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/rd_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/MemToReg_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/JType_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/RegDst_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/regWEN_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/PcSrc_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/JReg_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/Halt_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/InstrOp_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/InstrFunc_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/InstrOp_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/InstrFunc_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/rs_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/rs_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/instr_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/instr_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/next_pc_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/next_pc_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/imm_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/imm_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/branchaddr_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/branchaddr_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/imm_16_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/imm_16_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/shamt_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/shamt_out
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/writeReg_in
add wave -noupdate -group Other /system_tb/DUT/CPU/DP1/memwbif/writeReg_out
add wave -noupdate -divider Decode
add wave -noupdate -color Orange -label opcode /system_tb/DUT/CPU/DP1/rt.opcode
add wave -noupdate -color {Dark Orchid} -label funct /system_tb/DUT/CPU/DP1/rt.funct
add wave -noupdate -group {Instruction ID} /system_tb/DUT/CPU/DP1/jt
add wave -noupdate -group {Instruction ID} /system_tb/DUT/CPU/DP1/it
add wave -noupdate -group {Instruction ID} /system_tb/DUT/CPU/DP1/rt
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP1/rfDUT/registers
add wave -noupdate -group {Register File} {/system_tb/DUT/CPU/DP1/rfDUT/registers[7]}
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP1/rfif/WEN
add wave -noupdate -group {Register File} -radix unsigned /system_tb/DUT/CPU/DP1/rfif/wsel
add wave -noupdate -group {Register File} -radix unsigned /system_tb/DUT/CPU/DP1/rfif/rsel1
add wave -noupdate -group {Register File} -radix unsigned /system_tb/DUT/CPU/DP1/rfif/rsel2
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP1/rfif/wdat
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP1/rfif/rdat1
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP1/rfif/rdat2
add wave -noupdate -group Extender /system_tb/DUT/CPU/DP1/extif/JType
add wave -noupdate -group Extender /system_tb/DUT/CPU/DP1/extif/ExtOp
add wave -noupdate -group Extender /system_tb/DUT/CPU/DP1/extif/UpperImm
add wave -noupdate -group Extender /system_tb/DUT/CPU/DP1/extif/out
add wave -noupdate -group Extender /system_tb/DUT/CPU/DP1/extif/imm16
add wave -noupdate -group Extender /system_tb/DUT/CPU/DP1/extif/imm26
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP1/cuif/Equal
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP1/cuif/PcSrc
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP1/cuif/Halt
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP1/cuif/dMemREN
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP1/cuif/dMemWEN
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP1/cuif/RegDst
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP1/cuif/MemToReg
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP1/cuif/regWEN
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP1/cuif/UpperImm
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP1/cuif/AluSrc
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP1/cuif/ExtOp
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP1/cuif/JType
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP1/cuif/RegZero
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP1/cuif/JReg
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP1/cuif/InstrOp
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP1/cuif/InstrFunc
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP1/cuif/AluOp
add wave -noupdate -group {Hazard Unit} -color Orange /system_tb/DUT/CPU/DP1/hazardif/hazard
add wave -noupdate -group {Hazard Unit} -color Turquoise /system_tb/DUT/CPU/DP1/hazardif/branch
add wave -noupdate -group {Hazard Unit} -color {Orange Red} /system_tb/DUT/CPU/DP1/hazardif/jump
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP1/hazardif/equal
add wave -noupdate -group Inputs -radix unsigned /system_tb/DUT/CPU/DP1/hazardif/rsel1
add wave -noupdate -group Inputs -radix unsigned /system_tb/DUT/CPU/DP1/hazardif/rsel2
add wave -noupdate -group Inputs -radix unsigned /system_tb/DUT/CPU/DP1/hazardif/mem_writeReg
add wave -noupdate -group Inputs -radix unsigned /system_tb/DUT/CPU/DP1/hazardif/ex_writeReg
add wave -noupdate -group Inputs /system_tb/DUT/CPU/DP1/hazardif/dhit
add wave -noupdate -group Inputs /system_tb/DUT/CPU/DP1/hazardif/ex_regWEN
add wave -noupdate -group Inputs /system_tb/DUT/CPU/DP1/hazardif/mem_regWEN
add wave -noupdate -group Inputs /system_tb/DUT/CPU/DP1/hazardif/ex_dmemREN
add wave -noupdate -group Inputs /system_tb/DUT/CPU/DP1/hazardif/id_dmemWEN
add wave -noupdate -group Inputs /system_tb/DUT/CPU/DP1/hazardif/instrOp
add wave -noupdate -group Inputs /system_tb/DUT/CPU/DP1/hazardif/mem_instrOp
add wave -noupdate -group Inputs /system_tb/DUT/CPU/DP1/hazardif/instrFunc
add wave -noupdate -divider {IDEX Register}
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP1/idexif/writeEN
add wave -noupdate -group {IDEX Register} /system_tb/DUT/CPU/DP1/idexif/flush
add wave -noupdate -divider Execute
add wave -noupdate -color Orange -label opcode /system_tb/DUT/CPU/DP1/rt_ex.opcode
add wave -noupdate -color {Dark Orchid} -label funct /system_tb/DUT/CPU/DP1/rt_ex.funct
add wave -noupdate -group {Instruction EX} /system_tb/DUT/CPU/DP1/jt_ex
add wave -noupdate -group {Instruction EX} /system_tb/DUT/CPU/DP1/it_ex
add wave -noupdate -group {Instruction EX} /system_tb/DUT/CPU/DP1/rt_ex
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP1/aluif/negative
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP1/aluif/overflow
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP1/aluif/zero
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP1/aluif/portA
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP1/aluif/portB
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP1/aluif/outPort
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP1/aluif/aluOp
add wave -noupdate -group {Control Signals EX} /system_tb/DUT/CPU/DP1/idexif/AluOp_out
add wave -noupdate -group {Control Signals EX} /system_tb/DUT/CPU/DP1/idexif/AluSrc_out
add wave -noupdate -group {Forwarding Unit} /system_tb/DUT/CPU/DP1/forwardif/forwardA
add wave -noupdate -group {Forwarding Unit} /system_tb/DUT/CPU/DP1/forwardif/forwardB
add wave -noupdate -group {Forwarding Unit} /system_tb/DUT/CPU/DP1/forwardif/rsel1
add wave -noupdate -group {Forwarding Unit} /system_tb/DUT/CPU/DP1/forwardif/rsel2
add wave -noupdate -group {Forwarding Unit} /system_tb/DUT/CPU/DP1/forwardif/mem_writeReg
add wave -noupdate -group {Forwarding Unit} /system_tb/DUT/CPU/DP1/forwardif/wb_writeReg
add wave -noupdate -group {Forwarding Unit} /system_tb/DUT/CPU/DP1/forwardif/mem_regWEN
add wave -noupdate -group {Forwarding Unit} /system_tb/DUT/CPU/DP1/forwardif/wb_regWEN
add wave -noupdate -group {Forwarding Unit} /system_tb/DUT/CPU/DP1/forwardif/mem_dmemREN
add wave -noupdate -group {Forwarding Unit} /system_tb/DUT/CPU/DP1/forwardif/mem_dmemWEN
add wave -noupdate -divider {EXMEM Register}
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP1/exmemif/writeEN
add wave -noupdate -group {EXMEM Register} /system_tb/DUT/CPU/DP1/exmemif/flush
add wave -noupdate -divider Memory
add wave -noupdate -color Orange -label opcode /system_tb/DUT/CPU/DP1/rt_mem.opcode
add wave -noupdate -color {Dark Orchid} -label funct /system_tb/DUT/CPU/DP1/rt_mem.funct
add wave -noupdate -group {Instruction MEM} /system_tb/DUT/CPU/DP1/jt_mem
add wave -noupdate -group {Instruction MEM} /system_tb/DUT/CPU/DP1/it_mem
add wave -noupdate -group {Instruction MEM} /system_tb/DUT/CPU/DP1/rt_mem
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP1/dpif/ihit
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP1/dpif/dhit
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP1/dpif/dmemREN
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP1/dpif/dmemWEN
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP1/dpif/dmemload
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP1/dpif/dmemstore
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP1/dpif/dmemaddr
add wave -noupdate -divider {MEMWB Register}
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP1/memwbif/writeEN
add wave -noupdate -group {MEMWB Register} /system_tb/DUT/CPU/DP1/memwbif/flush
add wave -noupdate -divider {Write Back}
add wave -noupdate -color Orange -label opcode /system_tb/DUT/CPU/DP1/rt_wb.opcode
add wave -noupdate -color {Dark Orchid} -label funct /system_tb/DUT/CPU/DP1/rt_wb.funct
add wave -noupdate -group {Instruction WB} /system_tb/DUT/CPU/DP1/jt_wb
add wave -noupdate -group {Instruction WB} /system_tb/DUT/CPU/DP1/it_wb
add wave -noupdate -group {Instruction WB} /system_tb/DUT/CPU/DP1/rt_wb
add wave -noupdate /system_tb/DUT/CPU/DP1/wb_data_out
add wave -noupdate -divider Caches
add wave -noupdate -group {Instruction Cache} /system_tb/DUT/CPU/cif1/iwait
add wave -noupdate -group {Instruction Cache} /system_tb/DUT/CPU/cif1/iREN
add wave -noupdate -group {Instruction Cache} /system_tb/DUT/CPU/cif1/iload
add wave -noupdate -group {Instruction Cache} /system_tb/DUT/CPU/cif1/iaddr
add wave -noupdate -group {Data Cache} /system_tb/DUT/CPU/cif1/dwait
add wave -noupdate -group {Data Cache} /system_tb/DUT/CPU/cif1/dREN
add wave -noupdate -group {Data Cache} /system_tb/DUT/CPU/cif1/dWEN
add wave -noupdate -group {Data Cache} /system_tb/DUT/CPU/cif1/dload
add wave -noupdate -group {Data Cache} /system_tb/DUT/CPU/cif1/dstore
add wave -noupdate -group {Data Cache} /system_tb/DUT/CPU/cif1/daddr
add wave -noupdate -group {Data Cache} /system_tb/DUT/CPU/cif1/ccwait
add wave -noupdate -group {Data Cache} /system_tb/DUT/CPU/cif1/ccinv
add wave -noupdate -group {Data Cache} /system_tb/DUT/CPU/cif1/ccwrite
add wave -noupdate -group {Data Cache} /system_tb/DUT/CPU/cif1/cctrans
add wave -noupdate -group {Data Cache} /system_tb/DUT/CPU/cif1/ccsnoopaddr
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -color Cyan /system_tb/DUT/CPU/DP0/dpif/halt
add wave -noupdate -color White /system_tb/DUT/CPU/DP0/CLK
add wave -noupdate -color Red /system_tb/DUT/CPU/DP0/nRST
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {23289809844 ps} 0}
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
WaveRestoreZoom {23289671600 ps} {23290143600 ps}
