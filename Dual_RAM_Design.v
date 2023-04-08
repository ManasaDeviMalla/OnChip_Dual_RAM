`timescale 1ns / 1ps
module Dual_RAM_Design( clk, pci_clk, rnw, be, ra, wa, di, din_valid, do ) ; 
 input clk ; // System clock.
 input pci_clk ; // PCI clock for inputting data, di synchronously.
 input rnw ; // Sets one RAM in write only mode and the other RAM in read only mode.
 input din_valid ; // Data in (di) valid.
 input [7:0] be ; // Byte enable.
 input [2:0] ra, wa ; // Read/write address.
 input [63:0] di ; // Data input and
 output [63:0] do ; // Data output of dual RAM.
 wire switch_bank; // Declare net outputs.
 wire [63:0] do1 ;
 wire [63:0] do2 ;
 wire [63:0] do_next ;
// Declare registered outputs.
 reg [63:0] do; 
 reg rnw_delay ;
 // Configure ram1/ram2 for read and write mode respectively to start with.
 assign switch_bank = ~rnw; 
 //Instantiate 2 rams
 RAM ram1(.clk(clk), .pci_clk(pci_clk), .rnw(rnw),.be(be), .ra(ra), .wa(wa), .di(di), .din_valid(din_valid), .do(do1));
 RAM ram2(.clk(clk), .pci_clk(pci_clk), .rnw(switch_bank),.be(be), .ra(ra), .wa(wa), .di(di), .din_valid(din_valid), .do(do2));
 // Read ram2 or ram1
 assign do_next = (rnw_delay)? do2 : do1 ;
 
 always @ (posedge clk)
 begin
 rnw_delay <= rnw ; // Delay the rnw signal by one clock.
  do <= do_next ; // Register the selected RAM output.
 end 
endmodule
