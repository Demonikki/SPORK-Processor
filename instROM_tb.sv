module instROM_tb;    // unit testbench for your instruction ROM
  wire[8:0] inst;              // your instruction ROM's instruction output
  logic[15:0] PC;           // your dummy program counter
  instROM iR1(.InstAddress(PC),    // instantiate your instruction ROM
                       .InstOut(inst));         //      and connect its two ports 
 
  initial begin                           // walk through the first 64 (or more, or fewer) addresses
     for(PC=0; PC<64; PC++)
       #5ns $display("PC = %d  inst = %b",i,inst);
     $stop;
  end
 
endmodule