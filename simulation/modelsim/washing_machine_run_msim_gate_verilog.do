transcript on
if ![file isdirectory verilog_libs] {
	file mkdir verilog_libs
}

vlib verilog_libs/maxv_ver
vmap maxv_ver ./verilog_libs/maxv_ver
vlog -vlog01compat -work maxv_ver {c:/intelfpga_lite/22.1std/quartus/eda/sim_lib/maxv_atoms.v}

if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {washing_machine.vo}

