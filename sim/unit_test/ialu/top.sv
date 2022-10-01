`include "pkg.sv"

module top();

	import uvm_pkg::*;
	import ialu_pkg::*;

	logic clk;

	scr1_pipe_ialu dut (
						.clk(dif.clk),
						.rst_n(dif.rst),
						.exu2ialu_main_op1_i(dif.op1),
						.exu2ialu_main_op2_i(dif.op2),
						.exu2ialu_cmd_i(dif.cmd_i),
						.ialu2exu_main_res_o(dif.res)
						);

	ialu_if dif(.clk(clk));

	initial begin
		clk = 0;
		forever begin
			#10ns clk = ~clk;
		end
	end

	initial begin
		$dumpvars;
		$dumpfile("dump.vcd");
		uvm_config_db#(virtual ialu_if)::set(null, "uvm_test_top", "vif", dif);
		run_test();
	end

endmodule