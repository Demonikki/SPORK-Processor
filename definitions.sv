//This file defines the parameters used in the alu
package definitions;

// Instruction map
    const logic [3:0]kADD  = 4'b0000;
    const logic [3:0]kSUB  = 4'b0001;
    const logic [3:0]kSLL  = 4'b0010;
    const logic [3:0]kSLU  = 4'b0011;
    const logic [3:0]kSLR  = 4'b0100;
    const logic [3:0]kGT   = 4'b0101;
    const logic [3:0]kEQ   = 4'b0110;
    const logic [3:0]kNEG  = 4'b0111;

    typedef enum logic[3:0] {
        ADD     = 4'h0,
        SUB     = 4'h1,
        SLL     = 4'h2,
        SRA     = 4'h3,
        SRL     = 4'h4,
        GT      = 4'h5,
        EQ      = 4'h6,
        NEG     = 4'h7
    } op_mne;

endpackage // defintions
