transcript on

vlib work

vlog -sv +incdir+./ +incdir+../../../src/core/pipeline +incdir+../../../src/includes ../../../src/includes/*.svh ../../../src/core/pipeline/scr1_pipe_ialu.sv ./top.sv  

vsim -t 1ns -voptargs="+acc" +UVM_TESTNAME=test +NUMBER=20 top

add wave            /top/dif/clk
add wave            /top/dif/rst
add wave -radix hex /top/dif/cmd
add wave -radix hex /top/dif/op1
add wave -radix hex /top/dif/op2
add wave -radix hex /top/dif/res

configure wave -timelineunits ns

run -all

wave zoom full