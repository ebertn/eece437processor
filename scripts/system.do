onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider -height 30 Datapath
add wave -noupdate -divider Instructions
add wave -noupdate -group {j type} -radix hexadecimal /system_tb/DUT/CPU/DP/jt.addr
add wave -noupdate -group {i type} -color Cyan -radix unsigned /system_tb/DUT/CPU/DP/it.rs
add wave -noupdate -group {i type} -color Cyan -radix unsigned /system_tb/DUT/CPU/DP/it.rt
add wave -noupdate -group {i type} -color Green -radix decimal /system_tb/DUT/CPU/DP/it.imm
add wave -noupdate -group {r type} -color Cyan -radix unsigned /system_tb/DUT/CPU/DP/rt.rs
add wave -noupdate -group {r type} -color Cyan -radix unsigned /system_tb/DUT/CPU/DP/rt.rt
add wave -noupdate -group {r type} -color Cyan -radix unsigned /system_tb/DUT/CPU/DP/rt.rd
add wave -noupdate -group {r type} -color Green /system_tb/DUT/CPU/DP/rt.shamt
add wave -noupdate -divider {Program Counter}
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/halt
add wave -noupdate -color Cyan /system_tb/DUT/CPU/DP/cuif/Halt
add wave -noupdate -expand -group {Program Counter} -color Orange -radix hexadecimal /system_tb/DUT/CPU/DP/pcif/count
add wave -noupdate -expand -group {Program Counter} -radix hexadecimal /system_tb/DUT/CPU/DP/pcif/next_count
add wave -noupdate -expand -group {Program Counter} /system_tb/DUT/CPU/DP/pcif/countEn
add wave -noupdate -divider {Datapath Interface}
add wave -noupdate /system_tb/DUT/CPU/ccif/ramstate
add wave -noupdate -group {Datapath Interface} /system_tb/DUT/CPU/DP/dpif/halt
add wave -noupdate -group {Datapath Interface} /system_tb/DUT/CPU/DP/dpif/ihit
add wave -noupdate -group {Datapath Interface} /system_tb/DUT/CPU/DP/dpif/imemREN
add wave -noupdate -group {Datapath Interface} /system_tb/DUT/CPU/DP/dpif/imemload
add wave -noupdate -group {Datapath Interface} /system_tb/DUT/CPU/DP/dpif/imemaddr
add wave -noupdate -group {Datapath Interface} /system_tb/DUT/CPU/DP/dpif/dhit
add wave -noupdate -group {Datapath Interface} /system_tb/DUT/CPU/DP/dpif/datomic
add wave -noupdate -group {Datapath Interface} /system_tb/DUT/CPU/DP/dpif/dmemREN
add wave -noupdate -group {Datapath Interface} /system_tb/DUT/CPU/DP/dpif/dmemWEN
add wave -noupdate -group {Datapath Interface} /system_tb/DUT/CPU/DP/dpif/flushed
add wave -noupdate -group {Datapath Interface} /system_tb/DUT/CPU/DP/dpif/dmemload
add wave -noupdate -group {Datapath Interface} /system_tb/DUT/CPU/DP/dpif/dmemstore
add wave -noupdate -group {Datapath Interface} /system_tb/DUT/CPU/DP/dpif/dmemaddr
add wave -noupdate -divider {Register File}
add wave -noupdate -expand -group {Register File} /system_tb/DUT/CPU/DP/rfDUT/registers
add wave -noupdate -expand -group {Register File} -expand -group Other /system_tb/DUT/CPU/DP/rfif/WEN
add wave -noupdate -expand -group {Register File} -expand -group Other -radix unsigned /system_tb/DUT/CPU/DP/rfif/wsel
add wave -noupdate -expand -group {Register File} -expand -group Other -radix unsigned /system_tb/DUT/CPU/DP/rfif/rsel1
add wave -noupdate -expand -group {Register File} -expand -group Other -radix unsigned /system_tb/DUT/CPU/DP/rfif/rsel2
add wave -noupdate -expand -group {Register File} -expand -group Other /system_tb/DUT/CPU/DP/rfif/wdat
add wave -noupdate -expand -group {Register File} -expand -group Other /system_tb/DUT/CPU/DP/rfif/rdat1
add wave -noupdate -expand -group {Register File} -expand -group Other /system_tb/DUT/CPU/DP/rfif/rdat2
add wave -noupdate -divider ALU
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/aluif/negative
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/aluif/overflow
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/aluif/zero
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/aluif/portA
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/aluif/portB
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/aluif/outPort
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/aluif/aluOp
add wave -noupdate -divider {Control Unit}
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/Equal
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/Halt
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/RegDst
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/MemToReg
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/regWEN
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/UpperImm
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/AluSrc
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/ExtOp
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/JType
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/RegZero
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/JReg
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/PcSrc
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/InstrOp
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/InstrFunc
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/AluOp
add wave -noupdate -divider Extender
add wave -noupdate -group Extender /system_tb/DUT/CPU/DP/extif/JType
add wave -noupdate -group Extender /system_tb/DUT/CPU/DP/extif/ExtOp
add wave -noupdate -group Extender /system_tb/DUT/CPU/DP/extif/UpperImm
add wave -noupdate -group Extender -radix hexadecimal /system_tb/DUT/CPU/DP/extif/out
add wave -noupdate -group Extender -radix decimal /system_tb/DUT/CPU/DP/extif/imm16
add wave -noupdate -group Extender -radix hexadecimal /system_tb/DUT/CPU/DP/extif/imm26
add wave -noupdate -divider {Pipeline Registers}
add wave -noupdate -group ifid /system_tb/DUT/CPU/DP/ifidif/pcplus4_in
add wave -noupdate -group ifid /system_tb/DUT/CPU/DP/ifidif/pcplus4_out
add wave -noupdate -group ifid /system_tb/DUT/CPU/DP/ifidif/instr_in
add wave -noupdate -group ifid /system_tb/DUT/CPU/DP/ifidif/instr_out
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/idexif/pcplus4_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/idexif/rdat1_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/idexif/rdat2_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/idexif/immext_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/idexif/rt_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/idexif/rd_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/idexif/AluOp_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/idexif/MemToReg_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/idexif/AluSrc_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/idexif/JType_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/idexif/RegDst_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/idexif/regWEN_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/idexif/PcSrc_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/idexif/JReg_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/idexif/Halt_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/idexif/dMemWEN_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/idexif/dMemREN_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/idexif/pcplus4_out
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/idexif/rdat1_out
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/idexif/rdat2_out
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/idexif/immext_out
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/idexif/rt_out
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/idexif/rd_out
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/idexif/AluOp_out
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/idexif/MemToReg_out
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/idexif/AluSrc_out
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/idexif/JType_out
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/idexif/RegDst_out
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/idexif/regWEN_out
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/idexif/PcSrc_out
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/idexif/JReg_out
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/idexif/Halt_out
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/idexif/dMemWEN_out
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/idexif/dMemREN_out
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/exmemif/pcplus4_in
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/exmemif/branchaddr_in
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/exmemif/aluOutport_in
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/exmemif/rdat2_in
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/exmemif/rt_in
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/exmemif/rd_in
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/exmemif/MemToReg_in
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/exmemif/JType_in
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/exmemif/RegDst_in
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/exmemif/regWEN_in
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/exmemif/PcSrc_in
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/exmemif/JReg_in
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/exmemif/Halt_in
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/exmemif/dMemWEN_in
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/exmemif/dMemREN_in
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/exmemif/pcplus4_out
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/exmemif/branchaddr_out
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/exmemif/aluOutport_out
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/exmemif/rdat2_out
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/exmemif/rt_out
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/exmemif/rd_out
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/exmemif/MemToReg_out
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/exmemif/JType_out
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/exmemif/RegDst_out
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/exmemif/regWEN_out
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/exmemif/PcSrc_out
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/exmemif/JReg_out
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/exmemif/Halt_out
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/exmemif/dMemWEN_out
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/exmemif/dMemREN_out
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/memwbif/pcplus4_in
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/memwbif/aluOutport_in
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/memwbif/dmemload_in
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/memwbif/rt_in
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/memwbif/rd_in
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/memwbif/MemToReg_in
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/memwbif/JType_in
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/memwbif/RegDst_in
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/memwbif/regWEN_in
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/memwbif/PcSrc_in
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/memwbif/JReg_in
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/memwbif/pcplus4_out
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/memwbif/aluOutport_out
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/memwbif/dmemload_out
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/memwbif/rt_out
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/memwbif/rd_out
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/memwbif/MemToReg_out
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/memwbif/JType_out
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/memwbif/RegDst_out
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/memwbif/regWEN_out
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/memwbif/PcSrc_out
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/memwbif/JReg_out
add wave -noupdate -divider {Hazard Unit}
add wave -noupdate /system_tb/DUT/CPU/DP/hazardif/rsel1
add wave -noupdate /system_tb/DUT/CPU/DP/hazardif/rsel2
add wave -noupdate /system_tb/DUT/CPU/DP/hazardif/mem_writeReg
add wave -noupdate /system_tb/DUT/CPU/DP/hazardif/ex_writeReg
add wave -noupdate /system_tb/DUT/CPU/DP/hazardif/hazard
add wave -noupdate /system_tb/DUT/CPU/DP/hazardif/equal
add wave -noupdate /system_tb/DUT/CPU/DP/hazardif/branch
add wave -noupdate /system_tb/DUT/CPU/DP/hazardif/instrOp
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -color Magenta -radixenum symbolic /system_tb/DUT/CPU/DP/rt.funct
add wave -noupdate -color Orange /system_tb/DUT/CPU/DP/jt.opcode
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -color White /system_tb/DUT/CPU/DP/CLK
add wave -noupdate -color Red /system_tb/DUT/CPU/DP/nRST
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {622888 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {1361779073 ps} {1362180049 ps}
