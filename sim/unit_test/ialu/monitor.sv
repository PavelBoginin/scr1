class ialu_monitor extends uvm_monitor;

	`uvm_component_utils(ialu_monitor)

	virtual ialu_if vif;
	ialu_cfg cfg;
	ialu_item txn;
	uvm_analysis_port#(ialu_item) ap;

	extern function new(string name = "monitor", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task collect();

endclass

function ialu_monitor::new(string name = "monitor", uvm_component parent);
	super.new(name, parent);
	ap = new("ap", this);
endfunction

function void ialu_monitor::build_phase(uvm_phase phase);
	if (!uvm_config_db #(ialu_cfg)::get(this, "", "cfg", cfg)) begin
		`uvm_fatal(get_full_name(), "Config not found")
	end
	vif = cfg.vif;
endfunction

task ialu_monitor::run_phase(uvm_phase phase);
	collect();
endtask

task ialu_monitor::collect();
	forever begin
		txn = ialu_item::type_id::create("txn");
		@(negedge vif.clk) begin
			txn.op1 = vif.op1;
			txn.op2 = vif.op2;
			txn.res = vif.res;
			txn.cmd = vif.cmd;
			ap.write(txn);
		end
	end
endtask