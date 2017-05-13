////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:12:37 10/27/2011
// Design Name:   ALU
// Module Name:   /department/home/leporter/Xilinx/lab_basics/ALU_tb.v
// Project Name:  lab_basics
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
import definitions::*;	               // brings in package called definitions
module ALU_tb;

// DUT Inputs
  bit [ 1:0] OP;					   // type "bit" self-initializes to 0
  bit [15:0] INPUTA;
  bit [15:0] INPUTB;

// DUT Outputs
  wire [15:0] OUT;
  wire        ZERO;
  wire        EQUAL;

	// Instantiate the Unit Under Test (UUT)
  ALU uut (
		.OP, 
		.INPUTA, 
		.INPUTB, 
		.OUT, 
		.ZERO, 
		.EQUAL
	);

initial begin
// Wait 100 ns for global reset to finish
  #100ns;
        
// Add stimulus here
  INPUTA = 16'h0004;
  INPUTB = 16'h0004;
  #20ns  OP = kSUB;
  #20ns	 OP = kAND;
  #20ns	 INPUTB = 16'h0003;
  OP = kXOR;
  #20ns $stop;
end
					 
endmodule

