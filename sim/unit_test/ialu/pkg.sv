package cmd_pkg;

`ifdef SCR1_RVM_EXT
localparam SCR1_IALU_CMD_ALL_NUM_E    = 23;
`else // ~SCR1_RVM_EXT
localparam SCR1_IALU_CMD_ALL_NUM_E    = 15;
`endif // ~SCR1_RVM_EXT
localparam SCR1_IALU_CMD_WIDTH_E      = $clog2(SCR1_IALU_CMD_ALL_NUM_E);
typedef enum logic [SCR1_IALU_CMD_WIDTH_E-1:0] {
    SCR1_IALU_CMD_NONE  = '0,   // IALU disable
    SCR1_IALU_CMD_AND,          // op1 & op2
    SCR1_IALU_CMD_OR,           // op1 | op2
    SCR1_IALU_CMD_XOR,          // op1 ^ op2
    SCR1_IALU_CMD_ADD,          // op1 + op2
    SCR1_IALU_CMD_SUB,          // op1 - op2
    SCR1_IALU_CMD_SUB_LT,       // op1 < op2
    SCR1_IALU_CMD_SUB_LTU,      // op1 u< op2
    SCR1_IALU_CMD_SUB_EQ,       // op1 = op2
    SCR1_IALU_CMD_SUB_NE,       // op1 != op2
    SCR1_IALU_CMD_SUB_GE,       // op1 >= op2
    SCR1_IALU_CMD_SUB_GEU,      // op1 u>= op2
    SCR1_IALU_CMD_SLL,          // op1 << op2
    SCR1_IALU_CMD_SRL,          // op1 >> op2
    SCR1_IALU_CMD_SRA           // op1 >>> op2
`ifdef SCR1_RVM_EXT
    ,
    SCR1_IALU_CMD_MUL,          // low(unsig(op1) * unsig(op2))
    SCR1_IALU_CMD_MULHU,        // high(unsig(op1) * unsig(op2))
    SCR1_IALU_CMD_MULHSU,       // high(op1 * unsig(op2))
    SCR1_IALU_CMD_MULH,         // high(op1 * op2)
    SCR1_IALU_CMD_DIV,          // op1 / op2
    SCR1_IALU_CMD_DIVU,         // op1 u/ op2
    SCR1_IALU_CMD_REM,          // op1 % op2
    SCR1_IALU_CMD_REMU          // op1 u% op2
`endif  // SCR1_RVM_EXT
} type_scr1_ialu_cmd_sel_ee;

endpackage

`include "scr1_pipe_ialu.sv"
`include "if.sv"

package ialu_pkg;

	import cmd_pkg::*;

	`include "uvm_macros.svh"
	import uvm_pkg::*;
	`include "cfg.sv"
	`include "item.sv"
	`include "seq.sv"
	`include "driver.sv"
	`include "monitor.sv"
	`include "agent.sv"
	`include "scoreboard.sv"
	`include "env.sv"
	`include "test.sv"

endpackage