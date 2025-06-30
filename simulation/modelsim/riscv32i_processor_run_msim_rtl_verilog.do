transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/satvi/Code/ENTC/Verilog/riscv32i_processor/src/decode {C:/Users/satvi/Code/ENTC/Verilog/riscv32i_processor/src/decode/alu_decoder_cu.sv}
vlog -sv -work work +incdir+C:/Users/satvi/Code/ENTC/Verilog/riscv32i_processor/src/execute {C:/Users/satvi/Code/ENTC/Verilog/riscv32i_processor/src/execute/reg_file.sv}
vlog -sv -work work +incdir+C:/Users/satvi/Code/ENTC/Verilog/riscv32i_processor/src/decode {C:/Users/satvi/Code/ENTC/Verilog/riscv32i_processor/src/decode/decode.sv}
vlog -sv -work work +incdir+C:/Users/satvi/Code/ENTC/Verilog/riscv32i_processor/src/decode {C:/Users/satvi/Code/ENTC/Verilog/riscv32i_processor/src/decode/main_decoder_cu.sv}
vlog -sv -work work +incdir+C:/Users/satvi/Code/ENTC/Verilog/riscv32i_processor/src/execute {C:/Users/satvi/Code/ENTC/Verilog/riscv32i_processor/src/execute/imm_gen.sv}
vlog -sv -work work +incdir+C:/Users/satvi/Code/ENTC/Verilog/riscv32i_processor/src/execute {C:/Users/satvi/Code/ENTC/Verilog/riscv32i_processor/src/execute/alu.sv}
vlog -sv -work work +incdir+C:/Users/satvi/Code/ENTC/Verilog/riscv32i_processor/src/wb {C:/Users/satvi/Code/ENTC/Verilog/riscv32i_processor/src/wb/wb.sv}
vlog -sv -work work +incdir+C:/Users/satvi/Code/ENTC/Verilog/riscv32i_processor/src/top {C:/Users/satvi/Code/ENTC/Verilog/riscv32i_processor/src/top/riscv_top.sv}
vlog -sv -work work +incdir+C:/Users/satvi/Code/ENTC/Verilog/riscv32i_processor/src/fetch {C:/Users/satvi/Code/ENTC/Verilog/riscv32i_processor/src/fetch/instr_mem.sv}
vlog -sv -work work +incdir+C:/Users/satvi/Code/ENTC/Verilog/riscv32i_processor/src/mem {C:/Users/satvi/Code/ENTC/Verilog/riscv32i_processor/src/mem/data_mem.sv}

vlog -sv -work work +incdir+C:/Users/satvi/Code/ENTC/Verilog/riscv32i_processor/tb {C:/Users/satvi/Code/ENTC/Verilog/riscv32i_processor/tb/tb_riscv_top.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  tb_riscv_top

add wave *
view structure
view signals
run -all
