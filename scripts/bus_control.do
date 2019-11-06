onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group Instructions /bus_control_tb/CC/ccif/iwait
add wave -noupdate -expand -group Instructions /bus_control_tb/CC/ccif/iREN
add wave -noupdate -expand -group Instructions /bus_control_tb/CC/ccif/iload
add wave -noupdate -expand -group Instructions /bus_control_tb/CC/ccif/iaddr
add wave -noupdate -expand -group Data -radix binary -expand /bus_control_tb/CC/ccif/dwait
add wave -noupdate -expand -group Data -radix binary -expand /bus_control_tb/CC/ccif/dREN
add wave -noupdate -expand -group Data -radix binary -expand /bus_control_tb/CC/ccif/dWEN
add wave -noupdate -expand -group Data /bus_control_tb/CC/ccif/dload
add wave -noupdate -expand -group Data /bus_control_tb/CC/ccif/dstore
add wave -noupdate -expand -group Data /bus_control_tb/CC/ccif/daddr
add wave -noupdate -expand -group Data /bus_control_tb/CC/ccif/ccwait
add wave -noupdate -expand -group Data /bus_control_tb/CC/ccif/ccinv
add wave -noupdate -expand -group Data /bus_control_tb/CC/ccif/ccwrite
add wave -noupdate -expand -group Data /bus_control_tb/CC/ccif/cctrans
add wave -noupdate -expand -group Data /bus_control_tb/CC/ccif/ccsnoopaddr
add wave -noupdate -expand -group bmif /bus_control_tb/CC/bmif/daddr
add wave -noupdate -expand -group bmif /bus_control_tb/CC/bmif/dstore
add wave -noupdate -expand -group bmif /bus_control_tb/CC/bmif/dload
add wave -noupdate -expand -group bmif /bus_control_tb/CC/bmif/dWEN
add wave -noupdate -expand -group bmif /bus_control_tb/CC/bmif/dREN
add wave -noupdate -expand -group bmif /bus_control_tb/CC/bmif/dwait
add wave -noupdate -expand -group Ram /bus_control_tb/CC/ccif/ramstate
add wave -noupdate -expand -group Ram /bus_control_tb/CC/ccif/ramWEN
add wave -noupdate -expand -group Ram /bus_control_tb/CC/ccif/ramREN
add wave -noupdate -expand -group Ram /bus_control_tb/CC/ccif/ramaddr
add wave -noupdate -expand -group Ram /bus_control_tb/CC/ccif/ramstore
add wave -noupdate -expand -group Ram /bus_control_tb/CC/ccif/ramload
add wave -noupdate -expand -group {Bus Controller} /bus_control_tb/CC/BC/next_arbitraitor
add wave -noupdate -expand -group {Bus Controller} /bus_control_tb/CC/BC/state
add wave -noupdate /bus_control_tb/CLK
add wave -noupdate /bus_control_tb/nRST
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {40148 ps} 0}
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
WaveRestoreZoom {0 ps} {185 ns}
