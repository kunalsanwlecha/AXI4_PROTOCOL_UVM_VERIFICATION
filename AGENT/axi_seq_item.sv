`ifndef AXI_SEQ_ITEM
`define AXI_SEQ_ITEM
`include "uvm_macros.svh"
import uvm_pkg::*;
typedef enum bit{AXI_READ, AXI_WRITE}axi_txn_t;
class axi_seq_item extends uvm_sequence_item;
  rand axi_txn_t txn_type; //differentiates read vs write

  //address
  rand bit [31:0] addr;     //covers AW and AR

  //write data
  rand bit [31:0] wdata;    //covers W
  rand bit [3:0] wstrb;

  //read data
  bit [31:0] rdata;

  //protection type
  rand bit [2:0] prot;     //drives awprot/arprot

  //response from slave
  bit [1:0] resp;         //captures bresp/rresp
  
  //other signals
  rand bit [3:0] awid;
  rand bit [3:0] wid;
  rand bit [3:0] arid;
  rand bit [3:0] awlen;
  rand bit [3:0] arlen;
  rand bit [2:0] awsize;
  rand bit [2:0] arsize;
  rand bit [1:0] awburst;
  rand bit [1:0] arburst;
  rand bit wlast;
  rand bit rlast;
  
  `uvm_object_utils_begin(axi_seq_item)
  `uvm_field_enum(axi_txn_t, txn_type, UVM_ALL_ON)
  `uvm_field_int(addr, UVM_ALL_ON)
  `uvm_field_int(wdata, UVM_ALL_ON)
  `uvm_field_int(wstrb, UVM_ALL_ON)
  `uvm_field_int(rdata, UVM_ALL_ON)
  `uvm_field_int(prot, UVM_ALL_ON)
  `uvm_field_int(resp, UVM_ALL_ON)
  `uvm_field_int(awid, UVM_ALL_ON)
  `uvm_field_int(wid, UVM_ALL_ON)
  `uvm_field_int(arid, UVM_ALL_ON)
  `uvm_field_int(awlen, UVM_ALL_ON)
  `uvm_field_int(awsize, UVM_ALL_ON)
  `uvm_field_int(arsize, UVM_ALL_ON)
  `uvm_field_int(awburst, UVM_ALL_ON)
  `uvm_field_int(arburst, UVM_ALL_ON)
  `uvm_field_int(wlast, UVM_ALL_ON)
  `uvm_field_int(rlast, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "axi_seq_item");
    super.new(name);
  endfunction

  constraint axi4_lite_c{
    awid == 0;
    wid == 0;
    arid == 0;
    awlen == 0;
    arlen == 0;
    //incr burst only
    awburst == 2'b01;
    arburst == 2'b01;
    //32-bit bus => 2
    soft awsize == 3'b010;
    soft arsize == 3'b010;
    wlast == 1;
    rlast == 1;
    addr inside {[0:127]};
  }
  constraint prot_c{prot inside {[0:7]};}
endclass
`endif
