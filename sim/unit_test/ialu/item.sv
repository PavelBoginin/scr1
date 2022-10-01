class ialu_item extends uvm_sequence_item;

	`include "scr1_arch_description.svh"
	`include "scr1_riscv_isa_decoding.svh"

	`uvm_object_utils(ialu_item)

	rand bit signed [`SCR1_XLEN-1:0]      op1;
	rand bit signed [`SCR1_XLEN-1:0]      op2;
	rand bit signed [`SCR1_XLEN-1:0]      res;
	rand type_scr1_ialu_cmd_sel_ee        cmd;

	constraint c_cmd { cmd inside {SCR1_IALU_CMD_ADD, SCR1_IALU_CMD_SUB}; }

	constraint c_ops { op1 < 32'h10000000;
					   op2 < 32'h10000000;
					   op1 > op2; }

	extern function new(string name = "item");

endclass

function ialu_item::new(string name = "item");
	super.new(name);
endfunction