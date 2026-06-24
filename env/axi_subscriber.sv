`ifndef AXI_SUBSCRIBER
`define AXI_SUBSCRIBER
`include "uvm_macros.svh"
import uvm_pkg::*;
class axi_subscriber extends uvm_subscriber #(axi_seq_item);
  `uvm_component_utils (axi_subscriber)
  virtual axi_interface vif;
  axi_seq_item tr;
  uvm_analysis_imp #(axi_seq_item, axi_subscriber)sbr_imp;
  covergroup axi4_lite_write;
    awaddr_cov: coverpoint vif.awaddr{bins lowrange_addr = {[0:40]};
      bins midrange_addr = {[41:90]};
      bins highrange_addr = {[91:127]};}
    awvalid_cov: coverpoint vif.awvalid{bins awvalid = {[0:1]};}
    awready_cov: coverpoint vif.awready{bins awready = {[0:1]};}
    
    wvalid_cov: coverpoint vif.wvalid{bins wvalid = {[0:1]};}
    wready_cov: coverpoint vif.wready{bins wready = {[0:1]};}
    
    bvalid_cov: coverpoint vif.bvalid{bins bvalid = {[0:1]};}
    bready_cov: coverpoint vif.bready{bins bready = {[0:1]};}
    
    awsize_cov: coverpoint vif.awsize{bins awsize = {2'b10};}
    awburst_cov: coverpoint vif.awburst{
      ignore_bins FIXED = {2'b00};
      bins INCR = {2'b01};
      ignore_bins WRAP = {2'b10};
    }
  endgroup
  covergroup axi4_lite_read;
    araddr_cov: coverpoint vif.araddr{bins lowrange_addr = {[0:40]};
      bins midrange_addr = {[41:90]};
      bins highrange_addr = {[91:127]};}
    arvalid_cov: coverpoint vif.arvalid{bins arvalid = {[0:1]};}
    arready_cov: coverpoint vif.arready{bins arready = {[0:1]};}
    
    rvalid_cov: coverpoint vif.rvalid{bins rvalid = {[0:1]};}
    rready_cov: coverpoint vif.rready{bins rready = {[0:1]};}
    
    arsize_cov: coverpoint vif.awsize{bins arsize = {2'b10};}
    arburst_cov: coverpoint vif.arburst{
      ignore_bins FIXED = {2'b00};
      bins INCR = {2'b01};
      ignore_bins WRAP = {2'b10};
    }
  endgroup
  covergroup axi4_lite_wstrb;
    wstrb_cov: coverpoint vif.wstrb{
      bins full_word= {4'b1111};
      ignore_bins zero = {4'b0000};
    }
  endgroup
  covergroup axi4_lite_resp;
    bresp_cov: coverpoint vif.bresp{
      bins OKAY = {2'b00};
      ignore_bins SLVERR = {2'b10};
      ignore_bins DECERR = {2'b11};
      ignore_bins EXOKAY = {2'b01};
    }

    rresp_cov: coverpoint vif.rresp{
      bins OKAY = {2'b00};
      ignore_bins SLVERR = {2'b10};
      ignore_bins DECERR = {2'b11};
      ignore_bins EXOKAY = {2'b01};
    }
  endgroup

  function new(string name = "axi_subscriber", uvm_component parent);
    super.new(name, parent);
    sbr_imp new("sbr_imp",this);
    axi4_lite_write = new();
    axi4_lite_read = new();
    axi4_lite_wstrb = new();
    axi4_lite_resp = new();
  endfunction
  
  function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    if(!uvm_config_db#(virtual axi_interface)::get(this,"", "vif",vif))
      `uvm_fatal("NOVIF", "Virtual Interface not set for subscriber")
  endfunction
      
  function void write(axi_seq_item tr);
  axi4_lite_write.sample();
  axi4_lite_read.sample();
  axi4_lite_wstrb.sample();
  axi4_lite_resp.sample();
endfunction
endclass
`endif
