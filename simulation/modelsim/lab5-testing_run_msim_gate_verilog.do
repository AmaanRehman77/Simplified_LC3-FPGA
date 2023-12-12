transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {lab5-testing.vo}

vlog -sv -work work +incdir+C:/Users/amaan/Documents/ECE\ 385/Lab\ 5/Lab\ 5\ -\ Test/Lab5provided_sp2023 {C:/Users/amaan/Documents/ECE 385/Lab 5/Lab 5 - Test/Lab5provided_sp2023/testbench_W2.sv}

vsim -t 1ps +transport_int_delays +transport_path_delays -L altera_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L gate_work -L work -voptargs="+acc"  testbench_W2

add wave *
view structure
view signals
run 1000 ns
