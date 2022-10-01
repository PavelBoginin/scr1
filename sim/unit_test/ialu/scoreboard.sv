class ialu_sb extends uvm_scoreboard;

	`uvm_component_utils(ialu_sb)

	ialu_item txn;
	uvm_tlm_analysis_fifo #(ialu_item) fifo;

	extern function new(string name = "sb", uvm_component parent);
	extern task run_phase(uvm_phase phase);
	extern task grab();
	extern task compare();

endclass

function ialu_sb::new(string name = "sb", uvm_component parent);
	super.new(name, parent);
	fifo = new("fifo", this);
endfunction

task ialu_sb::run_phase(uvm_phase phase);
	forever begin
		grab();
		compare();
	end
endtask

task ialu_sb::grab();
	fifo.get(txn);
	if (txn.cmd == SCR1_IALU_CMD_ADD) begin
		`uvm_info(get_full_name(), $sformatf("ADD operation: \nOP1 = %d \nOP2 = %d \nRES = %d", txn.op1, txn.op2, txn.res), UVM_MEDIUM)
	end
	else begin
		`uvm_info(get_full_name(), $sformatf("SUB operation: \nOP1 = %d \nOP2 = %d \nRES = %d", txn.op1, txn.op2, txn.res), UVM_MEDIUM)
	end
endtask

task ialu_sb::compare();
	if (txn.cmd == SCR1_IALU_CMD_ADD && txn.res == {1'b0, txn.op1} + {1'b0, txn.op2}) begin
		`uvm_info(get_full_name(), "TEST PASSED", UVM_MEDIUM)
	end
	else if (txn.cmd == SCR1_IALU_CMD_ADD && txn.res != {1'b0, txn.op1} + {1'b0, txn.op2}) begin
		`uvm_error(get_full_name(), "TEST FAILED")
	end
	else if (txn.cmd == SCR1_IALU_CMD_SUB && txn.res == {1'b0, txn.op1} - {1'b0, txn.op2}) begin
		`uvm_info(get_full_name(), "TEST PASSED", UVM_MEDIUM)
	end
	else if (txn.cmd == SCR1_IALU_CMD_SUB && txn.res != {1'b0, txn.op1} - {1'b0, txn.op2}) begin
		`uvm_error(get_full_name(), "TEST FAILED")
	end
endtask