onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /control_unit_tb/CLK
add wave -noupdate /control_unit_tb/PROG/test_num
add wave -noupdate /control_unit_tb/cuif/iHit
add wave -noupdate /control_unit_tb/cuif/Equal
add wave -noupdate /control_unit_tb/cuif/dHit
add wave -noupdate /control_unit_tb/cuif/PcSrc
add wave -noupdate /control_unit_tb/cuif/Halt
add wave -noupdate /control_unit_tb/cuif/PcCountEn
add wave -noupdate /control_unit_tb/cuif/iMemRe
add wave -noupdate /control_unit_tb/cuif/dMemRe
add wave -noupdate /control_unit_tb/cuif/dMemWr
add wave -noupdate /control_unit_tb/cuif/RegDst
add wave -noupdate /control_unit_tb/cuif/MemToReg
add wave -noupdate /control_unit_tb/cuif/regWEN
add wave -noupdate /control_unit_tb/cuif/UpperImm
add wave -noupdate /control_unit_tb/cuif/AluSrc
add wave -noupdate /control_unit_tb/cuif/ExtOp
add wave -noupdate /control_unit_tb/cuif/JType
add wave -noupdate /control_unit_tb/cuif/RegZero
add wave -noupdate /control_unit_tb/cuif/JReg
add wave -noupdate /control_unit_tb/cuif/InstrOp
add wave -noupdate /control_unit_tb/cuif/InstrFunc
add wave -noupdate /control_unit_tb/cuif/AluOp
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {356 ns} 0}
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
WaveRestoreZoom {0 ns} {1 us}
