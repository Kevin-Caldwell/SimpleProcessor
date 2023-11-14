vlib work
vlog ../ALU/ALU.sv
vsim ALU

log -r {/*}
add wave {/*}

radix unsigned

force {clk} 1 0ps, 0 10ps -r 20ps

force async_reset 1
force bus 8'b0
force func_sel 4'b0
force a_in 0
force b_in 0
force save_result 0

run 40ps

force async_reset 0