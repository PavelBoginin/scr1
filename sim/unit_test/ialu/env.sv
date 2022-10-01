class ialu_env extends uvm_env;

	`uvm_component_utils(ialu_env)

	ialu_agent agent;
	ialu_sb sb;

	extern function new(string name = "env", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);

endclass

function ialu_env::new(string name = "env", uvm_component parent);
	super.new(name, parent);
endfunction

function void ialu_env::build_phase(uvm_phase phase);
	agent = ialu_agent::type_id::create("agent", this);
	sb = ialu_sb::type_id::create("scoreboard", this);
endfunction

function void ialu_env::connect_phase(uvm_phase phase);
	agent.monitor.ap.connect(sb.fifo.analysis_export);
endfunction