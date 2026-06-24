`ifndef AXI_ALIGNED_WR_TEST
`define AXI_ALIGNED_WR_TEST
`include "uvm_macros.svh"
import uvm_pkg::*;
class axi_aligned_wr_test extends axi_base_test;
  `uvm_component_utils (axi_aligned_wr_test)
  function new(string name = "axi_aligned_wr_test", uvm_component parent);
    super.new(name, parent);
  endfunction
  task run_phase (uvm_phase phase);
    axi_write_sequence_aligned seq;
    phase.raise_objection(this);
    seq = axi_write_sequence_aligned::type_id::create("seq");
    seq.start(env.agt.seqr);
    phase.drop_objection(this);
  endtask
endclass
`endif
