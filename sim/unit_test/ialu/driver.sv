class ialu_driver extends uvm_driver #(ialu_item);

	`uvm_component_utils(ialu_driver)

	virtual ialu_if vif;
	ialu_cfg cfg;

	extern function new(string name = "driver", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task drive();

endclass

function ialu_driver::new(string name = "driver", uvm_component parent);
	super.new(name, parent);
endfunction

function void ialu_driver::build_phase(uvm_phase phase);
	if (!uvm_config_db #(ialu_cfg)::get(this, "", "cfg", cfg)) begin
		`uvm_fatal(get_full_name(), "Config not found")
	end
	vif = cfg.vif;
endfunction

task ialu_driver::run_phase(uvm_phase phase);
	drive();
endtask

task ialu_driver::drive();
	forever begin
		seq_item_port.get_next_item(req);
		@(posedge vif.clk) begin
			vif.op1 <= req.op1;
			vif.op2 <= req.op2;
			vif.cmd <= req.cmd;
		end
		seq_item_port.item_done();
	end
endtask