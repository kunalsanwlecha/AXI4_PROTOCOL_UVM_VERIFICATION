`ifndef AXI_SLVERR_TEST
`define AXI_SLVERR_TEST
`include "uvm_macros.svh"
import uvm_pkg::*;
class axi_slverr_test extends axi_base_test;
  `uvm_component_utils(axi_slverr_test)
  function new(string name = "axi_slverr_test", uvm_component parent);
    super.new(name, parent);
  endfunction
  task run_phase(uvm_phase phase);
    axi_slverr_sequence seq;
    phase.raise_objection(this);
    seq = axi_slverr_sequence::type_id::create("seq");
    seq.start(env.agt.seqr);
    phase.drop_objection(this);
  endtask
endclass
`endif
