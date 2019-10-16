onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /forward_unit_tb/CLK
add wave -noupdate /forward_unit_tb/nRST
add wave -noupdate /forward_unit_tb/forwardif/rsel1
add wave -noupdate /forward_unit_tb/forwardif/rsel2
add wave -noupdate /forward_unit_tb/forwardif/mem_writeReg
add wave -noupdate /forward_unit_tb/forwardif/wb_writeReg
add wave -noupdate /forward_unit_tb/forwardif/forwardA
add wave -noupdate /forward_unit_tb/forwardif/forwardB
add wave -noupdate /forward_unit_tb/forwardif/mem_regWEN
add wave -noupdate /forward_unit_tb/forwardif/wb_regWEN
add wave -noupdate /forward_unit_tb/forwardif/mem_dmemREN
add wave -noupdate /forward_unit_tb/forwardif/mem_dmemWEN
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {37 ns} 0}
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
WaveRestoreZoom {0 ns} {142 ns}
