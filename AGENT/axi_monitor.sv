`ifndef AXI_MONITOR
`define AXI_MONITOR
`include "uvm_macros.svh"
import uvm_pkg::*;
class axi_monitor extends uvm_monitor;
  `uvm_component_utils (axi_monitor)
  virtual axi_interface.master vif;
  uvm_analysis_port #(axi_seq_item)mon_ap;
  function new(string name = "axi_monitor", uvm_component parent);
    super.new(name, parent);
    mon_ap = new("mon_ap",this);
  endfunction

  function void build_phase (uvm_phase phase);
    if(!uvm_config_db#(virtual axi_interface.master)::get(this,"", "vif", vif))
      `uvm_fatal("NOVIF", "No interface for axi_monitor");
  endfunction

  task run_phase (uvm_phase phase);
    fork
      collect_write();
      collect_read();
    join
  endtask

  task collect_write();
    axi_seq_item tr;
    forever begin
      @(posedge vif.aclk);
      if(vif.awvalid && vif.awready) begin
        tr = axi_seq_item::type_id::create("tr");
        tr.txn_type = AXI_WRITE;
        tr.addr = vif.awaddr;

        //wait for W
        do @(posedge vif.aclk); while(!(vif.wvalid && vif.wready));
        tr.wdata = vif.wdata;
        tr.wstrb = vif.wstrb;

        //waif for B
        do @(posedge vif.aclk); while(!(vif.wvalid && vif.wready));

        tr.resp = vif.bresp;
        mon_ap.write(tr);
      end
    end
  endtask

  task collect_read();
    axi_seq_item tr;
    forever begin
      @(posedge vif.aclk);
      if(vif.arvalid && vif.arready) begin
        tr = axi_seq_item::type_id::create("tr");
        tr.txn_type = AXI_READ;
        tr.addr = vif.araddr;

        //wait for R
        do @(posedge vif.aclk); while(!(vif.rvalid && vif.rready));
        tr.rdata = vif.rdata;
        tr.resp = vif.rresp;

        mon_ap.write(tr);
      end
    end
  endtask
endclass
`endif
