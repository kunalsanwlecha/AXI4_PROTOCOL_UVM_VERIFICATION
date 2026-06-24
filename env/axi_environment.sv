`ifndef AXI_ENVIRONMENT
`define AXI_ENVIRONMENT
`include "uvm_macros.svh"
import uvm_pkg::*;
class axi_env extends uvm_env;
  `uvm_component_utils (axi_env)
  axi_agent agt;
  axi_scoreboard scb;
  axi_subscriber sbr;
  function new(string name = "axi_env", uvm_component parent);
    super.new(name, parent);
  endfunction
  function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    agt = axi_agent::type_id::create("agt",this);
    scb = axi_scoreboard::type_id::create("scb",this);
    sbr = axi_subscriber::type_id::create("sbr",this);
  endfunction
  function void connect_phase(uvm_phase phase);
    agt.mon.mon_ap.connect(scb.sb_imp);
    agt.mon.mon_ap.connect(sbr.sbr_imp);
  endfunction
endclass
`endif
