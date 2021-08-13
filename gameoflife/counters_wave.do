onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /counters_testbench/clock
add wave -noupdate /counters_testbench/reset
add wave -noupdate /counters_testbench/dir
add wave -noupdate /counters_testbench/led
add wave -noupdate /counters_testbench/score
add wave -noupdate /counters_testbench/i
add wave -noupdate /counters_testbench/freset
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {76 ps} 0}
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
configure wave -gridperiod 100
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1 ns}
