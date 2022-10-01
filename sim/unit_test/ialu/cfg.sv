class ialu_cfg extends uvm_object;

	`uvm_object_utils(ialu_cfg)

	virtual ialu_if vif;
	bit active = 1;

	extern function new(string name = "cfg");

endclass

function ialu_cfg::new(string name = "cfg");
	super.new(name);
endfunction