
//This file defines the parameters used in the alu
package definitions;

// Instruction map
    const logic [3:0]kADD  = 4'b0000;
    const logic [3:0]kSUB  = 4'b0001;
    const logic [3:0]kSLL  = 4'b0010;
    const logic [3:0]kSRL  = 4'b0011;
    const logic [3:0]kSRA  = 4'b0100;
    const logic [3:0]kGT   = 4'b0101;
    const logic [3:0]kLT   = 4'b0110;
    const logic [3:0]kSLG  = 4'b0111;
    const logic [3:0]kSRG  = 4'b1000;
    const logic [3:0]kSLO  = 4'b1001;
    const logic [3:0]kSRO  = 4'b1010;
    const logic [3:0]kNEG  = 4'b1011;
    const logic [3:0]kRLZ  = 4'b1100;
    const logic [3:0]kSCO  = 4'b1101;
    const logic [3:0]kSEQ   = 4'b1110;
    const logic [3:0]kSQB  = 4'b1111;

    typedef enum logic[3:0] {
        ADD     = 4'h0,
        SUB     = 4'h1,
        SLL     = 4'h2,
        SRL     = 4'h3,
        SRA     = 4'h4,
        GT      = 4'h5,
        LT      = 4'h6,
        SLG     = 4'h7,
        SRG     = 4'h8,
        SLO     = 4'h9,
        SRO     = 4'h10,
        NEG     = 4'h11,
        RLZ      = 4'h12,
        SCP      = 4'h13,
        SEQ     = 4'h14,
        SQB     = 4'h15
    } op_mne;

endpackage // defintions