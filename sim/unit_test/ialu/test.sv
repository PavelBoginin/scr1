class base_test extends uvm_test;

	`uvm_component_utils(base_test)

	ialu_cfg cfg;
	ialu_env env;

	extern function new(string name = "base_test", uvm_component parent);
	extern function void build_phase(uvm_phase phase);

endclass

function base_test::new(string name = "base_test", uvm_component parent);
	super.new(name, parent);
endfunction

function void base_test::build_phase(uvm_phase phase);
	env = ialu_env::type_id::create("env", this);
	cfg = ialu_cfg::type_id::create("cfg");
	if (!uvm_config_db #(virtual ialu_if)::get(this, "", "vif", cfg.vif)) begin
		`uvm_fatal(get_full_name(), "Interface not found")
	end
	cfg.active = 1;
	uvm_config_db#(ialu_cfg)::set(this, "*", "cfg", cfg);
endfunction

class test extends base_test;

	`uvm_component_utils(test)

	ialu_seq seq;
	int number;

	extern function new(string name = "test", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);

endclass

function test::new(string name = "test", uvm_component parent);
	super.new(name, parent);
endfunction

function void test::build_phase(uvm_phase phase);
	super.build_phase(phase);
	seq = ialu_seq::type_id::create("seq");
	if (!($value$plusargs("NUMBER=%d",number))) begin
		number = 10;
	end
	seq.number = number;
endfunction

task test::run_phase(uvm_phase phase);
	phase.raise_objection(this);
	seq.start(env.agent.sequencer);
	#10ns;
	phase.drop_objection(this);
endtask