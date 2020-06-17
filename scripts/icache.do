onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider icache
add wave -noupdate -expand -group dut /icache_tb/DUT/state
add wave -noupdate -expand -group dut /icache_tb/DUT/req
add wave -noupdate -expand -group dut /icache_tb/DUT/frames
add wave -noupdate -divider {Datapath Interface}
add wave -noupdate -expand -group {Datapath Interface} -expand -group input /icache_tb/DUT/dcif/imemREN
add wave -noupdate -expand -group {Datapath Interface} -expand -group input /icache_tb/DUT/dcif/imemaddr
add wave -noupdate -expand -group {Datapath Interface} -expand -group {output } /icache_tb/DUT/dcif/ihit
add wave -noupdate -expand -group {Datapath Interface} -expand -group {output } /icache_tb/DUT/dcif/imemload
add wave -noupdate -divider {Memory Controller Interface}
add wave -noupdate -expand -group {Memory Controller Interface} -expand -group input /icache_tb/DUT/cif/iwait
add wave -noupdate -expand -group {Memory Controller Interface} -expand -group input /icache_tb/DUT/cif/iload
add wave -noupdate -expand -group {Memory Controller Interface} -expand -group output /icache_tb/DUT/cif/iREN
add wave -noupdate -expand -group {Memory Controller Interface} -expand -group output /icache_tb/DUT/cif/iaddr
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate /icache_tb/DUT/CLK
add wave -noupdate /icache_tb/DUT/nRST
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {15 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 221
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
WaveRestoreZoom {0 ns} {58 ns}
