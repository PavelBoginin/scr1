class ialu_agent extends uvm_agent;

	`uvm_component_utils(ialu_agent)

	ialu_cfg cfg;
	ialu_driver driver;
	ialu_monitor monitor;
	ialu_sequencer sequencer;

	extern function new(string name = "agent", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);

endclass

function ialu_agent::new(string name = "agent", uvm_component parent);
	super.new(name, parent);
endfunction

function void ialu_agent::build_phase(uvm_phase phase);
	if (!uvm_config_db #(ialu_cfg)::get(this, "", "cfg", cfg)) begin
		`uvm_fatal(get_full_name(), "Config not found")
	end
	monitor = ialu_monitor::type_id::create("monitor", this);
	if (cfg.active) begin
		driver = ialu_driver::type_id::create("driver", this);
		sequencer = ialu_sequencer::type_id::create("sequencer", this);
	end
endfunction

function void ialu_agent::connect_phase(uvm_phase phase);
	if (cfg.active) begin
		driver.seq_item_port.connect(sequencer.seq_item_export);
	end
endfunction