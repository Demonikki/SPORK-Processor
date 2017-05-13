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
  bit [15:0] INPUTC;
  bit [3:0]  INPUTD;
  bit        CARRYOUT;
  bit        CARRYIN;

// DUT Outputs
  wire [15:0] OUT;
  wire        ZERO;
  wire        EQUAL;

	// Instantiate the Unit Under Test (UUT)
  ALU uut (
		.OP     (OP), 
		.INPUTA (INPUTA), 
		.INPUTB (INPUTB),
    .INPUTC (INPUTC),
    .INPUTD (INPUTD), 
		.OUT    (OUT), 
		.ZERO   (ZERO), 
		.EQUAL  (EQUAL),
    .CARRYOUT (CO),
    .CARRYIN  (CI)
	);

initial begin
// Wait 100 ns for global reset to finish
  #100ns;
        
// Add stimulus here
  INPUTA = 16'h0004;
  INPUTB = 16'h0004;
  #20ns  OP = kSUB;
  #20ns	 OP = kAND;
  #20ns  OP = kSLL;
  #20ns  OP = kSRL;
  #20ns  OP = kSRA;
  #20ns  OP = kGT;
  #20ns  OP = kLT;
  #20ns  OP = kSLG;
  #20ns  OP = kSRG;
  #20ns  OP = kSLO;
  #20ns  OP = kSRO;
  #20ns  OP = kNEG;
  #20ns $stop;
end
					 
endmodule