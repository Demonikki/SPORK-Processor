
import definitions::*;	               // brings in package called definitions
module ALU_tb;

// DUT Inputs
  bit [ 1:0] OP;					   // type "bit" self-initializes to 0
  bit [15:0] INPUTA;
  bit [15:0] INPUTB;
  bit [15:0] INPUTC;
  bit [3:0]  INPUTD;
  logic      CARRYOUT;
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
		.CO (CARRYOUT),
		.CI (CARRYIN)
	);

initial begin
// Wait 100 ns for global reset to finish
  #100ns;
        
// Add stimulus here
  INPUTA = 16'h0004;
  INPUTB = 16'h0004;
  #20ns  OP = kSUB;
  #20ns	OP = kADD;
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