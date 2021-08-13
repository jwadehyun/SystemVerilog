onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /cells_testbench/clock
add wave -noupdate /cells_testbench/freset
add wave -noupdate /cells_testbench/cell0
add wave -noupdate /cells_testbench/cell1
add wave -noupdate /cells_testbench/cell2
add wave -noupdate /cells_testbench/cell3
add wave -noupdate /cells_testbench/cell4
add wave -noupdate /cells_testbench/cell5
add wave -noupdate /cells_testbench/cell6
add wave -noupdate /cells_testbench/cell7
add wave -noupdate /cells_testbench/cell8
add wave -noupdate /cells_testbench/next
add wave -noupdate /cells_testbench/dut/ps
add wave -noupdate /cells_testbench/dut/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {459 ps} 0} {{Cursor 2} {359 ps} 0}
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
