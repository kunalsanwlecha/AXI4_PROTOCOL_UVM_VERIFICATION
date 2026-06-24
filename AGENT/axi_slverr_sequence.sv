`ifndef AXI_SLVERR_SEQUENCE
`define AXI_SLVERR_SEQUENCE
`include "uvm_macros.svh"
import uvm_pkg::*;
class axi_slverr_sequence extends axi_base_sequence;
  `uvm_object_utils (axi_slverr_sequence)
  function new(string name = "axi_slverr_sequence");
    super.new(name);
  endfunction
  task body();
    axi_seq_item tr;
    `uvm_info(get_type_name(), "starting SLVERR sequence", UVM_MEDIUM)
    tr = axi_seq_item::type_id::create("tr");
    repeat (10) begin
      start_item(tr);
      assert(tr.randomize() with{
        txn_type == AXI_WRITE;
        //addr inside {[32'hFFFF_0000: 32'hFFFF_FFFF]}; //illegal range
        awsize == 3'b011;
      });
      finish_item(tr);
    end
  endtask
endclass
`endif
