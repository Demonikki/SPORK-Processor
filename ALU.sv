// combinational (unclocked) unsigned ALU w/ carry-in and carry-out

import definitions::*;            // includes package "definitions"
module ALU(
  input        [ 2:0] OP,         // ALU opcode, part of microcode
  input bit           CI,             // shift or carry in from right (LSB side)
  input        [ 7:0] INPUTA,       // data inputs
                      INPUTB,
                      INPUTC,
  input        [ 3:0] INPUTD,
  output logic [ 7:0] OUT,          // or:  output reg [ 7:0] OUT,
  output logic        CO,             // shift or carry out to left (MSB side)
                      ZERO,       // 1: OUT = 0
  output              EQUAL,        // 1: INPUTA = INPUTB
  output bit 			 flagA
  //temporary register
  
  //reg    		[ 4:0] temp
    );


  assign EQUAL = (INPUTA == INPUTB) ? 1'b1 : 1'b0;   // are inputs equal?
  op_mne op_mnemonic;       // type enum: used for convenient waveform viewing


  always_comb begin
  
  //default values
  
  flagA = 0;
  ZERO = 0;
  CO = 1'b0;
  OUT = 0;
  //done = 0;
  
  case(OP)

    //Simple
		kADD    : {CO,OUT} = INPUTA+INPUTB+CI;    // A+B+CI
		kSUB    : {CO,OUT} = INPUTA-INPUTB+CI;  // A-B+CI
    //kSLL    : {CO,OUT} = {INPUTA,CI};     // shift A left, bringing in CI & driving CO

		kSLL    : {CO, OUT} = INPUTA << 1;
      kSRL    : {CO, OUT} = INPUTA >> 1;
      kSRA    : {CO, OUT} =$signed(INPUTA >>> 1);
      kGT     : {CO, OUT} = INPUTA > INPUTB;
      kLT     : {CO, OUT} = INPUTA < INPUTB;


      kSLG    : 	begin
						{CO, OUT} = INPUTA << 1;
						end
                            
      kSRG    : 	{OUT, CO} = INPUTA >> 1;
						
                            
      kSLO    : 	begin
						OUT = INPUTA << 1;
						OUT[0] = CI;
						end
                     
							
      kSRO    : 	begin
						OUT = INPUTA >> 1;
						OUT[7] = CI;
						end
                            
      kNEG    : 	OUT = 0 - INPUTA;
		
      /*                      
      kRLZ    : 	begin
						while (INPUTA[7] == 0) 
										begin
											INPUTA << 1;	
										end
						{CO, OUT} = INPUTA;
						end
      */   
		
      kSCP    : 
										if( (INPUTB - INPUTC) > 0) 
										begin
											OUT = INPUTB - INPUTC;
											CO = 1;
										end
										else 
										begin
											//temp = INPUTB - INPUTC;
											if(INPUTA > 0) begin
												flagA = 1;
												begin
													OUT = INPUTB - INPUTC + 255;
												end
											end
											else begin
												OUT = 0;
												CO = 0;
											end
										end
										
                       
									 
      kSEQ    : 			begin		
		
										if(INPUTA[7:4] == INPUTD)
											OUT = OUT + 1;
                              
										if(INPUTA[6:3] == INPUTD)
											OUT = OUT + 1; 
                              
										if(INPUTA[5:2] == INPUTD)
											OUT = OUT + 1;
                              
										if(INPUTA[4:1] == INPUTD)
											OUT = OUT + 1;
                              
										if(INPUTA[3:0] == INPUTD)
											OUT = OUT + 1;
								end
								
											
      kSQB    : begin
										if({INPUTA[2:0], INPUTB[7]} == INPUTD)
											OUT = OUT + 1;
										
										if({INPUTA[1:0], INPUTB[7:6]} == INPUTD)
											OUT = OUT + 1;
										
										if({INPUTA[0], INPUTB[7:5]} == INPUTD)
											OUT = OUT + 1;
					 end						
						
						
    default : {CO,OUT} = 9'b0;
  endcase
  case(OUT)
    8'b0    : ZERO = 1'b1;
    default : ZERO = 1'b0;
  endcase
//$display("ALU Out %d \n",OUT);
    op_mnemonic = op_mne'(OP);

  end


endmodule
