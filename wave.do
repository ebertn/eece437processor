onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider -height 30 Datapath
add wave -noupdate -divider Instructions
add wave -noupdate -color Orange /system_tb/DUT/CPU/DP/jt.opcode
add wave -noupdate -group {j type} -radix hexadecimal /system_tb/DUT/CPU/DP/jt.addr
add wave -noupdate -group {i type} -color Cyan -radix unsigned /system_tb/DUT/CPU/DP/it.rs
add wave -noupdate -group {i type} -color Cyan -radix unsigned /system_tb/DUT/CPU/DP/it.rt
add wave -noupdate -group {i type} -color Green -radix decimal /system_tb/DUT/CPU/DP/it.imm
add wave -noupdate -group {r type} -color Cyan -radix unsigned /system_tb/DUT/CPU/DP/rt.rs
add wave -noupdate -group {r type} -color Cyan -radix unsigned /system_tb/DUT/CPU/DP/rt.rt
add wave -noupdate -group {r type} -color Cyan -radix unsigned /system_tb/DUT/CPU/DP/rt.rd
add wave -noupdate -group {r type} -color Green /system_tb/DUT/CPU/DP/rt.shamt
add wave -noupdate -group {r type} -color Magenta -radixenum numeric /system_tb/DUT/CPU/DP/rt.funct
add wave -noupdate -divider {Datapath Interface}
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
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/rfif/WEN
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/rfif/wsel
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/rfif/rsel1
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/rfif/rsel2
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/rfif/wdat
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/rfif/rdat1
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/rfif/rdat2
add wave -noupdate -divider ALU
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/aluif/negative
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/aluif/overflow
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/aluif/zero
add wave -noupdate -expand -group ALU -radix hexadecimal /system_tb/DUT/CPU/DP/aluif/portA
add wave -noupdate -expand -group ALU -radix hexadecimal /system_tb/DUT/CPU/DP/aluif/portB
add wave -noupdate -expand -group ALU -radix hexadecimal /system_tb/DUT/CPU/DP/aluif/outPort
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/aluif/aluOp
add wave -noupdate -divider {Control Unit}
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/Equal
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/PcSrc
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/Halt
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/iMemRe
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/dMemRe
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/dMemWr
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
add wave -noupdate -divider {Program Counter}
add wave -noupdate -expand -group {Program Counter} -color Orange -radix hexadecimal /system_tb/DUT/CPU/DP/pcif/count
add wave -noupdate -expand -group {Program Counter} -radix hexadecimal /system_tb/DUT/CPU/DP/pcif/next_count
add wave -noupdate -expand -group {Program Counter} /system_tb/DUT/CPU/DP/pcif/countEn
add wave -noupdate -divider Extender
add wave -noupdate -group Extender /system_tb/DUT/CPU/DP/extif/JType
add wave -noupdate -group Extender /system_tb/DUT/CPU/DP/extif/ExtOp
add wave -noupdate -group Extender /system_tb/DUT/CPU/DP/extif/UpperImm
add wave -noupdate -group Extender -radix hexadecimal /system_tb/DUT/CPU/DP/extif/out
add wave -noupdate -group Extender -radix decimal /system_tb/DUT/CPU/DP/extif/imm16
add wave -noupdate -group Extender -radix hexadecimal /system_tb/DUT/CPU/DP/extif/imm26
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -color White /system_tb/DUT/CPU/DP/CLK
add wave -noupdate -color Red /system_tb/DUT/CPU/DP/nRST
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {245911 ps} 0}
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
WaveRestoreZoom {0 ps} {1050 ns}
