onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Victory_testbench/clk
add wave -noupdate /Victory_testbench/reset
add wave -noupdate /Victory_testbench/L
add wave -noupdate /Victory_testbench/R
add wave -noupdate /Victory_testbench/led9
add wave -noupdate /Victory_testbench/led1
add wave -noupdate /Victory_testbench/winner
add wave -noupdate {/Victory_testbench/winner[6]}
add wave -noupdate {/Victory_testbench/winner[5]}
add wave -noupdate {/Victory_testbench/winner[4]}
add wave -noupdate {/Victory_testbench/winner[3]}
add wave -noupdate {/Victory_testbench/winner[2]}
add wave -noupdate {/Victory_testbench/winner[1]}
add wave -noupdate {/Victory_testbench/winner[0]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
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
