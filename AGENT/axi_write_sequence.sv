`ifndef AXI_WRITE_SEQUENCE
`define AXI_WRITE_SEQUENCE
`include "uvm_macros.svh"
import uvm_pkg::*;
class axi_write_sequence extends axi_base_sequence;
  `uvm_object_utils(axi_write_sequence)
  function new(string name = "axi_write_sequence");
    super.new(name);
  endfunction
  task body();
    req = axi_seq_item::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {
      txn_type == AXI_WRITE;
    });
    finish_item(req);
  endtask
endclass
`endif
