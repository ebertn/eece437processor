onerror {resume}
quietly virtual signal -install /system_tb/DUT/RAM { (context /system_tb/DUT/RAM )&{ramiframload_0 , ramiframload_1 , ramiframload_2 , ramiframload_3 , ramiframload_4 , ramiframload_5 , ramiframload_6 , ramiframload_7 , ramiframload_8 , ramiframload_9 , ramiframload_10 , ramiframload_11 , ramiframload_12 , ramiframload_13 , ramiframload_14 , ramiframload_15 , ramiframload_16 , ramiframload_17 , ramiframload_18 , ramiframload_19 , ramiframload_20 , ramiframload_21 , ramiframload_22 , ramiframload_23 , ramiframload_24 , ramiframload_25 , ramiframload_26 , ramiframload_27 , ramiframload_28 , ramiframload_29 , ramiframload_30 , ramiframload_31 }} ramiframload
quietly virtual signal -install /system_tb/DUT/RAM { (context /system_tb/DUT/RAM )&{ramiframload_31 , ramiframload_30 , ramiframload_29 , ramiframload_28 , ramiframload_27 , ramiframload_26 , ramiframload_25 , ramiframload_24 , ramiframload_23 , ramiframload_22 , ramiframload_21 , ramiframload_20 , ramiframload_19 , ramiframload_18 , ramiframload_17 , ramiframload_16 , ramiframload_15 , ramiframload_14 , ramiframload_13 , ramiframload_12 , ramiframload_11 , ramiframload_10 , ramiframload_9 , ramiframload_8 , ramiframload_7 , ramiframload_6 , ramiframload_5 , ramiframload_4 , ramiframload_3 , ramiframload_2 , ramiframload_1 , ramiframload_0 }} ramiframload001
quietly virtual signal -install /system_tb/DUT/RAM { (context /system_tb/DUT/RAM )&{ramstore , ramstore1 , ramstore2 , ramstore3 , ramstore4 , ramstore5 , ramstore6 , ramstore7 , ramstore8 , ramstore9 , ramstore10 , ramstore11 , ramstore12 , ramstore13 , ramstore14 , ramstore15 , ramstore16 , ramstore17 , ramstore18 , ramstore19 , ramstore20 , ramstore21 , ramstore22 , ramstore23 , ramstore24 , ramstore25 , ramstore26 , ramstore27 , ramstore28 , ramstore29 , ramstore30 , ramstore31 }} ramstore_
quietly virtual signal -install /system_tb/DUT/RAM { (context /system_tb/DUT/RAM )&{ramstore31 , ramstore30 , ramstore29 , ramstore28 , ramstore27 , ramstore26 , ramstore25 , ramstore24 , ramstore23 , ramstore22 , ramstore21 , ramstore20 , ramstore19 , ramstore18 , ramstore17 , ramstore16 , ramstore15 , ramstore14 , ramstore13 , ramstore12 , ramstore11 , ramstore10 , ramstore9 , ramstore8 , ramstore7 , ramstore6 , ramstore5 , ramstore4 , ramstore3 , ramstore2 , ramstore1 , ramstore }} ramstore_001
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider -height 30 Datapath
add wave -noupdate -divider Instructions
add wave -noupdate -divider {Program Counter}
add wave -noupdate -divider {Datapath Interface}
add wave -noupdate -divider {Register File}
add wave -noupdate -divider ALU
add wave -noupdate -divider {Control Unit}
add wave -noupdate -divider {Request Unit}
add wave -noupdate -divider Extender
add wave -noupdate -divider {Mapped Ram}
add wave -noupdate {/system_tb/DUT/RAM/\ramif.ramaddr }
add wave -noupdate {/system_tb/DUT/RAM/\ramif.ramWEN }
add wave -noupdate {/system_tb/DUT/RAM/\ramif.ramREN }
add wave -noupdate /system_tb/DUT/RAM/ramiframload001
add wave -noupdate /system_tb/DUT/RAM/ramstore_001
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
quietly WaveActivateNextPane
add wave -noupdate -color White /system_tb/DUT/CPU/DP/CLK
add wave -noupdate -color Red /system_tb/DUT/CPU/DP/nRST
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {42206 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 162
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
WaveRestoreZoom {0 ps} {118 ns}
