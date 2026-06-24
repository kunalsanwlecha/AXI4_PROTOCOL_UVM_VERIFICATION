`ifndef AXI_WRITE_SEQUENCE_ALIGNED
`define AXI_WRITE_SEQUENCE_ALIGNED
`include "uvm_macros.svh"
import uvm_pkg::*;
class axi_write_sequence_aligned extends axi_base_sequence;
  `uvm_object_utils(axi_write_sequence_aligned)
  function new(string name = "axi_write_sequence_aligned");
    super.new(name);
  endfunction
  task body();
    req = axi_seq_item::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {
      txn_type == AXI_WRITE;
      addr % 4 == 0;
      wstrb == 4'b1111;
    });
    finish_item(req);
  endtask
endclass
`endif
