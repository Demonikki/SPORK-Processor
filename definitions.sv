//This file defines the parameters used in the alu
package definitions;

// Instruction map
    const logic [2:0]kADD  = 2'b000;
    const logic [2:0]kSUB  = 2'b001;
    const logic [2:0]kSLL  = 2'b010;
    const logic [2:0]kSLU  = 2'b011;
    const logic [2:0]kSLR  = 2'b100;
    const logic [2:0]kGT   = 2'b101;
    const logic [2:0]kEQ   = 2'b110;
    const logic [2:0]kNEG  = 2'b111;

    typedef enum logic[2:0] {
        ADD     = 2'h0,
        SUB     = 2'h1
        SLL     = 2'h2,
        SRA     = 2'h3,
        SRL     = 2'h4,
        GT      = 2'h5,
        EQ      = 2'h6,
        NEG     = 2'h7
    } op_mne;

endpackage // defintions
