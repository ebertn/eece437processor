onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {dcache out}
add wave -noupdate -expand -group {dcache dut} /dcache_tb/DUT/state
add wave -noupdate -expand -group {dcache dut} /dcache_tb/DUT/req
add wave -noupdate -expand -group {dcache dut} /dcache_tb/DUT/frames
add wave -noupdate -expand -group {dcache dut} /dcache_tb/DUT/victim_addr
add wave -noupdate -expand -group {dcache dut} /dcache_tb/DUT/replacement_victim
add wave -noupdate -expand -group {dcache dut} /dcache_tb/DUT/lru
add wave -noupdate -divider {Datapath Interface}
add wave -noupdate -expand -group {Datapath Interface} -expand -group {Output } /dcache_tb/dcif/dhit
add wave -noupdate -expand -group {Datapath Interface} -expand -group {Output } /dcache_tb/dcif/dmemload
add wave -noupdate -expand -group {Datapath Interface} -expand -group {Input } /dcache_tb/dcif/dmemREN
add wave -noupdate -expand -group {Datapath Interface} -expand -group {Input } /dcache_tb/dcif/dmemWEN
add wave -noupdate -expand -group {Datapath Interface} -expand -group {Input } /dcache_tb/dcif/dmemstore
add wave -noupdate -expand -group {Datapath Interface} -expand -group {Input } /dcache_tb/dcif/dmemaddr
add wave -noupdate -divider {Cache Memory Interface}
add wave -noupdate -expand -group {Cache Memory Interface} -expand -group Input /dcache_tb/DUT/cif/dwait
add wave -noupdate -expand -group {Cache Memory Interface} -expand -group Input /dcache_tb/DUT/cif/dload
add wave -noupdate -expand -group {Cache Memory Interface} -expand -group Output /dcache_tb/DUT/cif/dREN
add wave -noupdate -expand -group {Cache Memory Interface} -expand -group Output /dcache_tb/DUT/cif/dWEN
add wave -noupdate -expand -group {Cache Memory Interface} -expand -group Output /dcache_tb/DUT/cif/dstore
add wave -noupdate -expand -group {Cache Memory Interface} -expand -group Output /dcache_tb/DUT/cif/daddr
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate /dcache_tb/CLK
add wave -noupdate /dcache_tb/nRST
add wave -noupdate -radix unsigned /dcache_tb/PROG/test_num
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {479 ns} 0}
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
WaveRestoreZoom {0 ns} {1250 ns}
