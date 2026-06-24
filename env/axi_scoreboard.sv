`ifndef AXI_SCOREBOARD
`define AXI_SCOREBOARD
`include "uvm_macros.svh"
import uvm_pkg::*;
class axi_scoreboard extends uvm_scoreboard;
  `uvm_component_utils (axi_scoreboard)
  axi_seq_item tr;
  uvm_analysis_imp #(axi_seq_item, axi_scoreboard)sb_imp;
  logic [7:0]mem [0:127]; //reference memory
  function new(string name = "axi_scoreboard", uvm_component parent);
    super.new(name, parent);
    sb_imp = new("sb_imp",this);
  endfunction
  function void write(axi_seq_item tr);
  if (tr.txn_type == AXI_WRITE) begin
    mem [tr.addr] = tr.wdata;
    `uvm_info("SB", $sformatf("write @%0d = %d", tr.addr,tr.wdata), UVM_LOW)
  end
  else begin
    if(tr.addr < 128) begin
      if(tr.rdata == mem[tr.addr])
        `uvm_error("SB", $sformatf("read mismatch @%0d exp %0d, got %0d", tr.addr,mem[tr.addr],tr.rdata))
      else
        `uvm_info("SB", $sformatf("READ PASS @%0d%0d", tr.addr,tr.rdata), UVM_LOW)
    end
    else
      `uvm_warning("SB", $sformatf("Read from unwritten addr %0d", tr.addr))
  end
endfunction
endclass
`endif
