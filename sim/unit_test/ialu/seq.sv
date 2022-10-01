class ialu_seq extends uvm_sequence #(ialu_item);

	`uvm_object_utils(ialu_seq)

	int number;

	extern function new(string name = "seq");
	extern task body();

endclass

function ialu_seq::new(string name = "seq");
	super.new(name);
endfunction

task ialu_seq::body();
	`uvm_info(get_type_name(), "Start sequence", UVM_MEDIUM)
	repeat (number) begin
		`uvm_do(req)
	end
	`uvm_info(get_type_name(), "End sequence", UVM_MEDIUM)
endtask

typedef uvm_sequencer #(ialu_item) ialu_sequencer;