`timescale 1ns / 1ps
module Dual_RAM_Design_TB(do);
 output [63:0]do;
 reg clk, pci_clk , rnw , din_valid ;
 reg [7:0] be ;
 reg [2:0] ra, wa ;
 reg [63:0] di ;
Dual_RAM_Design uut( clk, pci_clk, rnw, be, ra, wa, di, din_valid, do ) ; 

always #10 clk <= ~clk ;
always #10 pci_clk <= ~pci_clk ;

task task1_wr_ram1();
begin
// Write first block of data into ram1.
     rnw = 1'b1 ; din_valid = 1'b1 ;  be = 8'h00; 
     wa = 3'd0; di = 64'h0 ;
 #17 wa = 3'd1; di = 64'h123456789abcdef0 ;  
 #20 wa = 3'd2; di = 64'h7E6A4719E7B99682 ;
 #20 wa = 3'd3; di = 64'h7631CF8A8ACF3176 ;
 #20 wa = 3'd4; di = 64'h6AE782B9477E1996 ;
 #20 wa = 3'd5; di = 64'h5BA5A55B5BA5A55B ;
 #20 wa = 3'd6; di = 64'h4782196A96E77EB9 ;
 #20 wa = 3'd7; di = 64'h318A76CFCF768A31 ;
 #20;
 end
endtask

task task2_rd_ram1_wr_ram2();
begin
// Write second block of data into ram2. Simultaneously read from ram1.
  #40 rnw = 1'b0 ; 
      ra = 3'd0; wa = 3'd0; di = 64'h5BA5A55B5BA5A55B ;
  #20 ra = 3'd1; wa = 3'd1; di = 64'h4782196A96E77EB9 ;
  #20 ra = 3'd2; wa = 3'd2; di = 64'h318A76CFCF768A31 ;
  #20 ra = 3'd3; wa = 3'd3; di = 64'h19B96A827E9647E7 ;
  #20 ra = 3'd4; wa = 3'd4; di = 64'h7E6A4719E7B99682 ;
  #20 ra = 3'd5; wa = 3'd5; di = 64'h7631CF8A8ACF3176 ;
  #20 ra = 3'd6; wa = 3'd6; di = 64'h6AE782B9477E1996 ;
  #20 ra = 3'd7; wa = 3'd7; di = 64'h5BA5A55B5BA5A55B ;
  #40;
end
endtask

task task3_rd_ram2();
begin
// Read fourth block of data from ram1.
  #40 rnw = 1 ; 
   ra = 3'd0;  
   #20 ra = 3'd1;
   #20 ra = 3'd2;
   #20 ra = 3'd3;
   #20 ra = 3'd4;
   #20 ra = 3'd5;
   #20 ra = 3'd6;
   #20 ra = 3'd7;
   #100;
end
endtask

initial begin
 clk = 1'b0 ;
 pci_clk = 1'b0 ;
 task1_wr_ram1();
 #20;
 task2_rd_ram1_wr_ram2();
 #20;
 task3_rd_ram2();
 $stop ;
end 
endmodule
