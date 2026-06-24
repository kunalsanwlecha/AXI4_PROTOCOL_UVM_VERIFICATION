`ifndef AXI_BASE_SEQUENCE
`define AXI_BASE_SEQUENCE
`include "uvm_macros.svh"
import uvm_pkg::*;
class axi_base_sequence extends uvm_sequence #(axi_seq_item);
  `uvm_object_utils (axi_base_sequence)
  axi_seq_item req;
  function new(string name = "axi_base_sequence");
    super.new(name);
  endfunction
  task body();
  endtask
endclass
`endif
