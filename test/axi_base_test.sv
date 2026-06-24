`ifndef AXI_BASE_TEST
`define AXI_BASE_TEST
`include "uvm_macros.svh"
import uvm_pkg::*;
class axi_base_test extends uvm_test;
  `uvm_component_utils (axi_base_test)
  axi_env env;
  function new(string name = "axi_base_test", uvm_component parent);
    super.new(name, parent);
  endfunction
  function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    env = axi_env::type_id::create("env",this);
  endfunction
endclass
`endif
