onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /icache_tb/CLK
add wave -noupdate /icache_tb/nRST
add wave -noupdate -divider DataPath
add wave -noupdate -divider Outputs
add wave -noupdate /icache_tb/dcif/imemaddr
add wave -noupdate /icache_tb/dcif/imemREN
add wave -noupdate -divider Inputs
add wave -noupdate /icache_tb/dcif/imemload
add wave -noupdate /icache_tb/dcif/ihit
add wave -noupdate -divider Ram
add wave -noupdate -divider Outputs
add wave -noupdate /icache_tb/cif/iREN
add wave -noupdate /icache_tb/cif/iaddr
add wave -noupdate -divider Inputs
add wave -noupdate /icache_tb/cif/iload
add wave -noupdate /icache_tb/cif/iwait
add wave -noupdate -divider icache
add wave -noupdate /icache_tb/DUT/addresses
add wave -noupdate /icache_tb/DUT/next_addresses
add wave -noupdate /icache_tb/DUT/data
add wave -noupdate /icache_tb/DUT/next_data
add wave -noupdate -divider Ram
add wave -noupdate /icache_tb/RAM_TEST/count
add wave -noupdate /icache_tb/RAM_TEST/rstate
add wave -noupdate /icache_tb/RAM_TEST/q
add wave -noupdate /icache_tb/RAM_TEST/addr
add wave -noupdate /icache_tb/RAM_TEST/wren
add wave -noupdate /icache_tb/RAM_TEST/en
add wave -noupdate /icache_tb/RAM_TEST/ramif/ramREN
add wave -noupdate /icache_tb/RAM_TEST/ramif/ramWEN
add wave -noupdate /icache_tb/RAM_TEST/ramif/ramaddr
add wave -noupdate /icache_tb/RAM_TEST/ramif/ramstore
add wave -noupdate /icache_tb/RAM_TEST/ramif/ramload
add wave -noupdate /icache_tb/RAM_TEST/ramif/ramstate
add wave -noupdate /icache_tb/RAM_TEST/ramif/memREN
add wave -noupdate /icache_tb/RAM_TEST/ramif/memWEN
add wave -noupdate /icache_tb/RAM_TEST/ramif/memaddr
add wave -noupdate /icache_tb/RAM_TEST/ramif/memstore
add wave -noupdate /icache_tb/RAM_TEST/altsyncram_component/wren_a
add wave -noupdate /icache_tb/RAM_TEST/altsyncram_component/wren_b
add wave -noupdate /icache_tb/RAM_TEST/altsyncram_component/rden_a
add wave -noupdate /icache_tb/RAM_TEST/altsyncram_component/rden_b
add wave -noupdate /icache_tb/RAM_TEST/altsyncram_component/data_a
add wave -noupdate /icache_tb/RAM_TEST/altsyncram_component/data_b
add wave -noupdate /icache_tb/RAM_TEST/altsyncram_component/address_a
add wave -noupdate /icache_tb/RAM_TEST/altsyncram_component/address_b
add wave -noupdate /icache_tb/RAM_TEST/altsyncram_component/clock0
add wave -noupdate /icache_tb/RAM_TEST/altsyncram_component/clock1
add wave -noupdate /icache_tb/RAM_TEST/altsyncram_component/clocken0
add wave -noupdate /icache_tb/RAM_TEST/altsyncram_component/clocken1
add wave -noupdate /icache_tb/RAM_TEST/altsyncram_component/clocken2
add wave -noupdate /icache_tb/RAM_TEST/altsyncram_component/clocken3
add wave -noupdate /icache_tb/RAM_TEST/altsyncram_component/aclr0
add wave -noupdate /icache_tb/RAM_TEST/altsyncram_component/aclr1
add wave -noupdate /icache_tb/RAM_TEST/altsyncram_component/byteena_a
add wave -noupdate /icache_tb/RAM_TEST/altsyncram_component/byteena_b
add wave -noupdate /icache_tb/RAM_TEST/altsyncram_component/addressstall_a
add wave -noupdate /icache_tb/RAM_TEST/altsyncram_component/addressstall_b
add wave -noupdate /icache_tb/RAM_TEST/altsyncram_component/q_a
add wave -noupdate /icache_tb/RAM_TEST/altsyncram_component/q_b
add wave -noupdate /icache_tb/RAM_TEST/altsyncram_component/eccstatus
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2000 ps} 0}
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
WaveRestoreZoom {50300 ps} {76300 ps}
