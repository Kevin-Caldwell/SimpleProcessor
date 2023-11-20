vlib work
vlog ../processor.sv
vlog ../decoder.sv
vlog ../ALU/**
vsim processor -suppress 3839

log -r {/*}
add wave {/*}

radix hexadecimal

force clock 1 0ps, 0 1ps -r 2ps

force reset 1
force machine_code 12'b000_000_000_000
force dataIN 8'b0000_0000
force start 0

run 2ps

force start 1
force machine_code 12'b001_001_000_000
force dataIN 8'b0000_1010
force reset 0

run 2ps

force start 0

run 4ps

force start 1
force machine_code 12'b000_001_010_000

run 2ps

force start 0

run 10ps

force start 1
force machine_code 12'b011_001_010_000

run 2ps

force start 0

run 10ps

force start 1
force machine_code 12'b011_001_010_000

run 2ps

force start 0

run 10ps

force start 1
force machine_code 12'b011_001_010_000

run 2ps

force start 0

run 10ps

