onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider DCache1
add wave -noupdate -group dcif1 /dcache_tb/dcif1/halt
add wave -noupdate -group dcif1 /dcache_tb/dcif1/ihit
add wave -noupdate -group dcif1 /dcache_tb/dcif1/imemREN
add wave -noupdate -group dcif1 /dcache_tb/dcif1/imemload
add wave -noupdate -group dcif1 /dcache_tb/dcif1/imemaddr
add wave -noupdate -group dcif1 /dcache_tb/dcif1/dhit
add wave -noupdate -group dcif1 /dcache_tb/dcif1/datomic
add wave -noupdate -group dcif1 /dcache_tb/dcif1/dmemREN
add wave -noupdate -group dcif1 /dcache_tb/dcif1/dmemWEN
add wave -noupdate -group dcif1 /dcache_tb/dcif1/flushed
add wave -noupdate -group dcif1 /dcache_tb/dcif1/dmemload
add wave -noupdate -group dcif1 /dcache_tb/dcif1/dmemstore
add wave -noupdate -group dcif1 /dcache_tb/dcif1/dmemaddr
add wave -noupdate -group cif1 /dcache_tb/cif1/iwait
add wave -noupdate -group cif1 /dcache_tb/cif1/dwait
add wave -noupdate -group cif1 /dcache_tb/cif1/iREN
add wave -noupdate -group cif1 /dcache_tb/cif1/dREN
add wave -noupdate -group cif1 /dcache_tb/cif1/dWEN
add wave -noupdate -group cif1 /dcache_tb/cif1/iload
add wave -noupdate -group cif1 /dcache_tb/cif1/dload
add wave -noupdate -group cif1 /dcache_tb/cif1/dstore
add wave -noupdate -group cif1 /dcache_tb/cif1/iaddr
add wave -noupdate -group cif1 /dcache_tb/cif1/daddr
add wave -noupdate -group cif1 /dcache_tb/cif1/ccwait
add wave -noupdate -group cif1 /dcache_tb/cif1/ccinv
add wave -noupdate -group cif1 /dcache_tb/cif1/ccwrite
add wave -noupdate -group cif1 /dcache_tb/cif1/cctrans
add wave -noupdate -group cif1 /dcache_tb/cif1/ccsnoopaddr
add wave -noupdate /dcache_tb/DUT1/state
add wave -noupdate /dcache_tb/DUT1/next_state
add wave -noupdate /dcache_tb/DUT1/req
add wave -noupdate /dcache_tb/DUT1/snoop_req
add wave -noupdate -subitemconfig {{/dcache_tb/DUT1/frames[1]} -expand {/dcache_tb/DUT1/frames[0]} -expand} /dcache_tb/DUT1/frames
add wave -noupdate /dcache_tb/DUT1/next_frames
add wave -noupdate /dcache_tb/DUT1/lru
add wave -noupdate /dcache_tb/DUT1/next_lru
add wave -noupdate /dcache_tb/DUT1/index
add wave -noupdate /dcache_tb/DUT1/next_index
add wave -noupdate /dcache_tb/DUT1/hit_count
add wave -noupdate /dcache_tb/DUT1/next_hit_count
add wave -noupdate /dcache_tb/DUT1/miss_count
add wave -noupdate /dcache_tb/DUT1/next_miss_count
add wave -noupdate /dcache_tb/DUT1/miss_hit_flag
add wave -noupdate /dcache_tb/DUT1/next_miss_hit_flag
add wave -noupdate -divider DCache2
add wave -noupdate -group dcif2 /dcache_tb/dcif2/halt
add wave -noupdate -group dcif2 /dcache_tb/dcif2/ihit
add wave -noupdate -group dcif2 /dcache_tb/dcif2/imemREN
add wave -noupdate -group dcif2 /dcache_tb/dcif2/imemload
add wave -noupdate -group dcif2 /dcache_tb/dcif2/imemaddr
add wave -noupdate -group dcif2 /dcache_tb/dcif2/dhit
add wave -noupdate -group dcif2 /dcache_tb/dcif2/datomic
add wave -noupdate -group dcif2 /dcache_tb/dcif2/dmemREN
add wave -noupdate -group dcif2 /dcache_tb/dcif2/dmemWEN
add wave -noupdate -group dcif2 /dcache_tb/dcif2/flushed
add wave -noupdate -group dcif2 /dcache_tb/dcif2/dmemload
add wave -noupdate -group dcif2 /dcache_tb/dcif2/dmemstore
add wave -noupdate -group dcif2 /dcache_tb/dcif2/dmemaddr
add wave -noupdate -group cif2 /dcache_tb/cif2/iwait
add wave -noupdate -group cif2 /dcache_tb/cif2/dwait
add wave -noupdate -group cif2 /dcache_tb/cif2/iREN
add wave -noupdate -group cif2 /dcache_tb/cif2/dREN
add wave -noupdate -group cif2 /dcache_tb/cif2/dWEN
add wave -noupdate -group cif2 /dcache_tb/cif2/iload
add wave -noupdate -group cif2 /dcache_tb/cif2/dload
add wave -noupdate -group cif2 /dcache_tb/cif2/dstore
add wave -noupdate -group cif2 /dcache_tb/cif2/iaddr
add wave -noupdate -group cif2 /dcache_tb/cif2/daddr
add wave -noupdate -group cif2 /dcache_tb/cif2/ccwait
add wave -noupdate -group cif2 /dcache_tb/cif2/ccinv
add wave -noupdate -group cif2 /dcache_tb/cif2/ccwrite
add wave -noupdate -group cif2 /dcache_tb/cif2/cctrans
add wave -noupdate -group cif2 /dcache_tb/cif2/ccsnoopaddr
add wave -noupdate /dcache_tb/DUT2/state
add wave -noupdate /dcache_tb/DUT2/next_state
add wave -noupdate /dcache_tb/DUT2/req
add wave -noupdate /dcache_tb/DUT2/snoop_req
add wave -noupdate /dcache_tb/DUT2/frames
add wave -noupdate /dcache_tb/DUT2/next_frames
add wave -noupdate /dcache_tb/DUT2/lru
add wave -noupdate /dcache_tb/DUT2/next_lru
add wave -noupdate /dcache_tb/DUT2/index
add wave -noupdate /dcache_tb/DUT2/next_index
add wave -noupdate /dcache_tb/DUT2/hit_count
add wave -noupdate /dcache_tb/DUT2/next_hit_count
add wave -noupdate /dcache_tb/DUT2/miss_count
add wave -noupdate /dcache_tb/DUT2/next_miss_count
add wave -noupdate /dcache_tb/DUT2/miss_hit_flag
add wave -noupdate /dcache_tb/DUT2/next_miss_hit_flag
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate /dcache_tb/CLK
add wave -noupdate /dcache_tb/nRST
add wave -noupdate -radix unsigned /dcache_tb/PROG/test_num
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {79715 ps} 0}
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
WaveRestoreZoom {0 ps} {246750 ps}
