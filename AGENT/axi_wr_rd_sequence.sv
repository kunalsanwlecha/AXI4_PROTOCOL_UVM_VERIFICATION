`ifndef AXI_WR_RD_SEQUENCE
`define AXI_WR_RD_SEQUENCE
`include "uvm_macros.svh"
import uvm_pkg::*;
class axi_wr_rd_sequence extends axi_base_sequence;
  `uvm_object_utils(axi_wr_rd_sequence)
  function new(string name = "axi_wr_rd_sequence");
    super.new(name);
  endfunction
  task body();
    axi_write_sequence wr_seq;
    axi_read_sequence rd_seq;
    wr_seq = axi_write_sequence::type_id::create("wr_seq");
    rd_seq = axi_read_sequence::type_id::create("rd_seq");
    wr_seq.start(m_sequencer);
    rd_seq.start(m_sequencer);
  endtask
endclass
`endif
