transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/EE\ 371\ hwga/lab1 {C:/EE 371 hwga/lab1/FSM.sv}
vlog -sv -work work +incdir+C:/EE\ 371\ hwga/lab1 {C:/EE 371 hwga/lab1/display.sv}
vlog -sv -work work +incdir+C:/EE\ 371\ hwga/lab1 {C:/EE 371 hwga/lab1/counter.sv}
vlog -sv -work work +incdir+C:/EE\ 371\ hwga/lab1 {C:/EE 371 hwga/lab1/DE1_SoC.sv}

