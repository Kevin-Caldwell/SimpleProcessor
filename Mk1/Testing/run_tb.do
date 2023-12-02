vlib work
project compileall
vlog Testing/processor_tb.sv
vsim work.processor_tb

add wave -position insertpoint sim:/processor_tb/*
radix hexadecimal
run 80ps