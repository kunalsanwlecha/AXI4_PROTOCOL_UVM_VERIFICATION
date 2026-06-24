`ifndef AXI_DRIVER
`define AXI_DRIVER
`include "uvm_macros.svh"
import uvm_pkg::*;
class axi_driver extends uvm_driver #(axi_seq_item);
  `uvm_component_utils (axi_driver)

  virtual axi_interface.master vif;
  axi_seq_item req;

  function new(string name = "axi_driver", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase (uvm_phase phase);
    if(!uvm_config_db#(virtual axi_interface.master)::get(this,"", "vif", vif))
      `uvm_fatal("NOVIF", "Virtual interface not set for driver");
  endfunction

  task run_phase (uvm_phase phase);
    reset_signals();
    forever begin
      seq_item_port.get_next_item(req);
      if(req.txn_type == AXI_WRITE)
        drive_write(req);
      else
        drive_read(req);
      seq_item_port.item_done();
    end
  endtask
  task reset_signals();
    vif.awvalid <= 0;
    vif.wvalid <= 0;
    vif.bready <= 0;
    vif.arvalid <= 0;
    vif.rready <= 0;
    wait(vif.aresetn == 1);
    @(posedge vif.aclk);
  endtask

  task drive_write(axi_seq_item tr);
    `uvm_info("DRV", "Drive transaction start", UVM_MEDIUM)
    //AW CHANNEL
    `uvm_info("DRV", "AW channel", UVM_MEDIUM)
    vif.awvalid <= 1'b1;
    vif.awaddr <= tr.addr;
    vif.awid <= tr.awid;
    vif.awlen <= tr.awlen;
    vif.awsize <= tr.awsize;
    vif.awburst <= tr.awburst;
    @(posedge vif.aclk);
    wait(vif.awready);
    vif.awvalid <= 0;

    //W channel
    @(posedge vif.aclk);
    `uvm_info("DRV", "W channel", UVM_MEDIUM)
    vif.wvalid <= 1'b1;
    vif.wdata <= tr.wdata;
    vif.wstrb <= tr.wstrb;
    vif.wid <= tr.wid;
    vif.wlast <= tr.wlast;
    @(posedge vif.aclk);
    wait(vif.wready);
    @(posedge vif.aclk);
    vif.wvalid <= 0;
    vif.wlast <= 0;
    `uvm_info("DRV", $sformatf("addr = %0d, data = %0d", req.addr, req.wdata), UVM_MEDIUM)
    
    `uvm_info("DRV", "B channel", UVM_MEDIUM)
    vif.bready <= 1;
    tr.resp = vif.bresp;
    @(posedge vif.aclk);
    //B response
    `uvm_info("DRV", "Getting B response", UVM_MEDIUM)
    wait(vif.bvalid);
    @(posedge vif.aclk);
    vif.bready <= 0;
    `uvm_info("DRV", "WRITE TRANSACTION END", UVM_MEDIUM)
  endtask:drive_write
  task drive_read(axi_seq_item tr);
    vif.rready <= 1;
    //AR CHANNEL
    `uvm_info("DRV", "AR channel", UVM_MEDIUM)
    vif.araddr <= tr.addr;
    vif.arid <= tr.arid;
    vif.arlen <= tr.arlen;
    vif.arsize <= tr.arsize;
    vif.arburst <= tr.arburst;
    vif.arvalid <= 1;
    wait(vif.arready);
    @(posedge vif.aclk);
    vif.arvalid <= 0;

    //R CHANNEL
    `uvm_info("DRV", "R channel", UVM_MEDIUM)
    wait(vif.rvalid);
    tr.rdata = vif.rdata;
    tr.resp = vif.rresp;
    @(posedge vif.aclk);
    vif.rready <= 0;
    `uvm_info("DRV", $sformatf("READ COMPLETE: addr= %0d, data %0d", vif.araddr, vif.rdata), UVM_MEDIUM)
  endtask
endclass
`endif
