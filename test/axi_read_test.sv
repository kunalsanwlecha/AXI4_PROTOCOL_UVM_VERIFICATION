`ifndef AXI_READ_TEST
`define AXI_READ_TEST
`include "uvm_macros.svh"
import uvm_pkg::*;
class axi_read_test extends axi_base_test;
  `uvm_component_utils (axi_read_test)
  function new(string name = "axi_read_test", uvm_component parent);
    super.new(name, parent);
  endfunction
  task run_phase (uvm_phase phase);
    axi_read_sequence seq;
    phase.raise_objection(this);
    seq = axi_read_sequence::type_id::create("seq");
    seq.start(env.agt.seqr);
    phase.drop_objection(this);
  endtask
endclass
`endif
