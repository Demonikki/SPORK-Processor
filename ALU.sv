// combinational (unclocked) unsigned ALU w/ carry-in and carry-out

import definitions::*;            // includes package "definitions"
module ALU(
  input        [ 2:0] OP,         // ALU opcode, part of microcode
  input               CI,             // shift or carry in from right (LSB side)
  input        [ 7:0] INPUTA,       // data inputs
                      INPUTB,
                      INPUTC,
               [ 3:0] INPUTD,
  output logic [ 7:0] OUT,          // or:  output reg [ 7:0] OUT,
  output logic        CO,             // shift or carry out to left (MSB side)
                      ZERO,       // 1: OUT = 0
  output              EQUAL,        // 1: INPUTA = INPUTB

  //temporary register
  reg           [ 4:0] temp,
                [ 7:0] temp8
    );

  assign EQUAL = (INPUTA == INPUTB) ? 1'b1 : 1'b0;   // are inputs equal?
  op_mne op_mnemonic;       // type enum: used for convenient waveform viewing

  always_comb begin
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
      kEQ     : {CO, OUT} = INPUTA == INPUTB;
      kSLG    : {CO, OUT} = {
                            temp = INPUTA[7];
                            INPUTA << 1;
                            }
      kSRG    : {CO, OUT} = {
                            temp = INPUTA[0];
                            INPUTA >> 1;
                            }
      kSLO    : {CO, OUT} = {
                            INPUTA << 1;
                            INPUTA[0] = temp;
                            }
      kSRO    : {CO, OUT} = {
                            INPUT >> 1;
                            INPUTA[7] = temp;
                            }
      kNEG    : {CO, OUT} = {
                            0 - INPUTA;
                            }
      kRLZ    : {CO, OUT} = {
                            while (INPUTA[7] == 0)
                                INPUTA << 1;
                            }
      kSCP    : {CO, OUT} = {
                            if((INPUTB - INPUTC) > 0){
                              INPUTB = INPUTB - INPUTC;
                            } else{
                              if(INPUTA > 0){
                                INPUTA = INPUTA - 1;
                                INPUTB = INPUTB - INPUTC + 255;
                              } else{
                                done = 1;
                              }
                            }
                            }
      kSEQ    : {CO, OUT} = {
                            if(INPUTA[7:4] == INPUTD){
                              temp = temp + 1;
                              }
                            if(INPUTA[6:3] == INPUTD){
                              temp = temp + 1;
                              }
                            if(INPUTA[5:2] == INPUTD){
                              temp = temp + 1;
                              }
                            if(INPUTA[4:1] == INPUTD){
                              temp = temp + 1;
                              }
                            if(INPUTA[3:0] == INPUTD){
                              temp = temp + 1;
                              }

                            }
      kSQB    : {CO, OUT} = {
                            if(INPUTA[2:0]+INPUTB[7] == INPUTD){
                              temp = temp + 1;
                            }
                            if(INPUTA[1:0]+INPUTB[7:6] == INPUTD){
                              temp = temp + 1;
                            }
                            if(INPUTA[0]+INPUTB[7:5] == INPUTD){
                              temp = temp + 1;
                            }
      //
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
