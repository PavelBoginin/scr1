interface ialu_if(input logic clk, input logic rst);

	`include "scr1_arch_description.svh"
	`include "scr1_riscv_isa_decoding.svh"

	import cmd_pkg::*;

	logic [`SCR1_XLEN-1:0]   op1;
	logic [`SCR1_XLEN-1:0]   op2;
	logic [`SCR1_XLEN-1:0]   res;
	type_scr1_ialu_cmd_sel_ee cmd;
	type_scr1_ialu_cmd_sel_e cmd_i;

	assign cmd_i = type_scr1_ialu_cmd_sel_e'(cmd);

endinterface