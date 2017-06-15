import definitions::*;
module Control(
	input [8:0] INSTRUCTION,
	input [3:0] OPCODE,
	input LASTBIT,
	output logic [1:0] ALU_OP,
	output logic [1:0] ALU_SRC_B,
	output logic OV_WRITE,
	output logic REG_WRITE,
	output logic BRANCH,
	output logic BRANCHCOND,
	output logic MEM_WRITE,
	output logic MEM_READ,
	output logic [3:0] REG_DST,
	output logic MEM_TO_REG,
	output logic REG_READ,
	output logic [3:0] SOURCE_REG_A,
	output logic [3:0] SOURCE_REG_B,
	output logic [3:0] SOURCE_REG_C,
	output logic HALT
	);
	always_comb begin
		case(OPCODE)
			0: begin
				REG_DST = 0; //all are don't cares aside from halt
				BRANCH = 0;
				BRANCHCOND = 0;
				ALU_SRC_B = 2; 
				ALU_OP = kADD;
				MEM_TO_REG = 0;
				MEM_READ = 0;
				MEM_WRITE = 0;
				REG_WRITE = 0;
				OV_WRITE = 0;
				REG_READ = 0;
				HALT = 1;
			end // 0:

			1: begin //right shift
				REG_DST = INSTRUCTION[4:1]; //
				BRANCH = 0;
				BRANCHCOND = 0;
				ALU_SRC_B = 2;
				case(LASTBIT)
					0: begin
						ALU_OP = kSRL;
					end // 0:
					1: begin
						ALU_OP = kSRA;
					end // 1:
				endcase // LASTBIT
				MEM_TO_REG = 1; //uses ALU result
				MEM_READ = 0;
				MEM_WRITE = 0;
				REG_READ = 1;
				REG_WRITE = 0;
				SOURCE_REG_A = INSTRUCTION[4:1];
				SOURCE_REG_B = 0;
				SOURCE_REG_C = 0;
				OV_WRITE = 1;
				HALT = 0;
			end // 1:

			2: begin //left shift
				REG_DST = INSTRUCTION[4:1]; //
				BRANCH = 0;
				BRANCHCOND = 0;
				ALU_SRC_B = 2;
				case(LASTBIT)
					0: begin
						ALU_OP = kSLL;
					end // 0:
					1: begin
						ALU_OP = kSLL;
					end // 1:
				endcase // LASTBIT
				MEM_TO_REG = 1; //uses ALU result
				MEM_READ = 0;
				MEM_WRITE = 0;
				REG_READ = 1;
				REG_WRITE = 0;
				SOURCE_REG_A = INSTRUCTION[4:1];
				SOURCE_REG_B = 0;
				SOURCE_REG_C = 0;
				OV_WRITE = 1;
				HALT = 0;
			end // 2:

			3: begin //move
				case(LASTBIT)
					0: begin
						REG_DST = INSTRUCTION[4:1];
					end // 0:
					1: begin
						REG_DST = 0;
					end // 1:
				endcase // LASTBIT
				BRANCH = 0;
				BRANCHCOND = 0;
				ALU_SRC_B = 2;
				ALU_OP = kADD; //don't care
				MEM_TO_REG = 0;
				MEM_READ = 0;
				MEM_WRITE = 0;
				REG_READ = 1;
				REG_WRITE = 1;
				case(LASTBIT)
					0: begin
						SOURCE_REG_A = 0;
					end // 0:
					1: begin
						SOURCE_REG_A = INSTRUCTION[4:1];
					end // 1:
				endcase // LASTBIT
				SOURCE_REG_B = 0;
				SOURCE_REG_C = 0;
				OV_WRITE = 1;
				HALT = 0;
			end // 3:

			4: begin //beq
				REG_DST = 12;
				BRANCH = 1;
				BRANCHCOND = 1;
				ALU_SRC_B = 2;
				ALU_OP = kSUB;
				MEM_TO_REG = 0;
				MEM_READ = 0;
				MEM_WRITE = 0;
				REG_READ = 1;
				REG_WRITE = 0;
				SOURCE_REG_A = INSTRUCTION[4:1];
				SOURCE_REG_B = 1;
				SOURCE_REG_C = 0;
				OV_WRITE = 1;
				HALT = 0;
			end // 4:

			5: begin //bgt
				REG_DST = 12;
				BRANCH = 1;
				BRANCHCOND = 1;
				ALU_SRC_B = 2;
				ALU_OP = kSUB;
				MEM_TO_REG = 0;
				MEM_READ = 0;
				MEM_WRITE = 0;
				REG_READ = 1;
				REG_WRITE = 0;
				SOURCE_REG_A = INSTRUCTION[4:1];
				SOURCE_REG_B = 1;
				SOURCE_REG_C = 0;
				OV_WRITE = 1;
				HALT = 0;
			end // 5:

			6: begin //blt
				REG_DST = 12;
				BRANCH = 1;
				BRANCHCOND = 1;
				ALU_SRC_B = 2;
				ALU_OP = kSUB;
				MEM_TO_REG = 0;
				MEM_READ = 0;
				MEM_WRITE = 0;
				REG_READ = 1;
				REG_WRITE = 0;
				SOURCE_REG_A = INSTRUCTION[4:1];
				SOURCE_REG_B = 1;
				SOURCE_REG_C = 0;
				OV_WRITE = 1;
				HALT = 0;
			end // 6:

			7: begin //Load/Store
				BRANCH = 0;
				BRANCHCOND = 0;
				ALU_SRC_B = 2;
				ALU_OP = kADD;
				case(LASTBIT)
					0: begin
						MEM_READ = 1;
						REG_WRITE = 1;
						REG_READ = 0;
						REG_DST = 2;
					end // 0:
					1: begin
						MEM_WRITE = 1;
						REG_WRITE = 0;
						REG_READ = 1;
						REG_DST = 0;
					end // 1:
				endcase // LASTBIT
				MEM_TO_REG = 1;
				SOURCE_REG_A = INSTRUCTION[4:1];
				SOURCE_REG_B = 0;
				SOURCE_REG_C = 0;
				OV_WRITE = 1;
				HALT = 0;
			end // 7:

			8: begin //Lookup
				REG_DST = 0;
				BRANCH = 0;
				BRANCHCOND = 0;
				ALU_SRC_B = 2;
				ALU_OP = kADD;
				MEM_TO_REG = 1;
				MEM_READ = 0;
				MEM_WRITE = 0;
				REG_READ = 0;
				REG_WRITE = 1;
				OV_WRITE = 1;
				HALT = 0;
			end // 8:

			9: begin //Add/Subtract
				REG_DST = 3; //
				BRANCH = 0;
				BRANCHCOND = 0;
				ALU_SRC_B = 2;
				case(LASTBIT)
					0: begin
						ALU_OP = kADD;
					end // 0:
					1: begin
						ALU_OP = kSUB;
					end // 1:
				endcase // LASTBIT
				MEM_TO_REG = 1; //uses ALU result
				MEM_READ = 0;
				MEM_WRITE = 0;
				REG_WRITE = 1;
				SOURCE_REG_A = INSTRUCTION[4:1];
				SOURCE_REG_B = 0;
				SOURCE_REG_C = 0;
				OV_WRITE = 1;
				HALT = 0;
			end // 9:

			10: begin //Check Sequence
				REG_DST = 5;
				BRANCH = 0;
				BRANCHCOND = 0;
				ALU_SRC_B = 2;
				ALU_OP = kSEQ;
				MEM_TO_REG = 0;
				MEM_READ = 0;
				MEM_WRITE = 0;
				REG_READ = 1;
				REG_WRITE = 1;
				SOURCE_REG_A = INSTRUCTION[4:1];
				SOURCE_REG_B = 4;
				SOURCE_REG_C = 5; //sequence is in R4, adds to R5
				OV_WRITE = 1;
				HALT = 0;
			end // 10:

			11: begin //Check Sequence Between
				REG_DST = 5;
				BRANCH = 0;
				BRANCHCOND = 0;
				ALU_SRC_B = 2;
				ALU_OP = kSQB;
				MEM_TO_REG = 0;
				MEM_READ = 0;
				MEM_WRITE = 0;
				REG_READ = 1;
				REG_WRITE = 1;
				SOURCE_REG_A = 4;
				SOURCE_REG_B = 7;
				SOURCE_REG_C = 8; //sequence is in R4, adds to R5, checks sequences in R7,R8
				OV_WRITE = 1;
				HALT = 0;
			end // 11:

			12: begin //Subtract Compare
				REG_DST = 5;
				BRANCH = 0;
				BRANCHCOND = 0;
				ALU_SRC_B = 2;
				ALU_OP = kSCP;
				MEM_TO_REG = 0;
				MEM_READ = 0;
				MEM_WRITE = 0;
				REG_READ = 1;
				REG_WRITE = 1;
				SOURCE_REG_A = 9;
				SOURCE_REG_B = 4;
				SOURCE_REG_C = 5; //sequence is in R4, adds to R5
				OV_WRITE = 1;
				HALT = 0;
			end // 0:

			13: begin //Remove Leading Zeroes
				REG_DST = 9;
				BRANCH = 0;
				BRANCHCOND = 0;
				ALU_SRC_B = 2;
				ALU_OP = kRLZ;
				MEM_TO_REG = 0;
				MEM_READ = 0;
				MEM_WRITE = 0;
				REG_READ = 1;
				REG_WRITE = 1;
				SOURCE_REG_A = 9;
				SOURCE_REG_B = 0;
				SOURCE_REG_C = 0;
				OV_WRITE = 1;
				HALT = 0;
			end // 1:

			14: begin //Shift Generate
				REG_DST = INSTRUCTION[4:1];
				BRANCH = 0;
				BRANCHCOND = 0;
				ALU_SRC_B = 2;
				case(LASTBIT)
					0: begin
						ALU_OP = kSRG;
					end // 0:
					1: begin
						ALU_OP = kSLG;
					end // 1:
				endcase // LASTBIT
				MEM_TO_REG = 0;
				MEM_READ = 0;
				MEM_WRITE = 0;
				REG_READ = 1;
				REG_WRITE = 1;
				SOURCE_REG_A = INSTRUCTION[4:1];
				SOURCE_REG_B = 0;
				SOURCE_REG_C = 0;
				OV_WRITE = 1;
				HALT = 0;
			end // 0:

			15: begin //Shift Overflow
				REG_DST = INSTRUCTION[4:1];
				BRANCH = 0;
				BRANCHCOND = 0;
				ALU_SRC_B = 2;
				case(LASTBIT)
					0: begin
						ALU_OP = kSRO;
					end // 0:
					1: begin
						ALU_OP = kSLO;
					end // 1:
				endcase // LASTBIT
				MEM_TO_REG = 0;
				MEM_READ = 0;
				MEM_WRITE = 0;
				REG_READ = 1;
				REG_WRITE = 1;
				SOURCE_REG_A = INSTRUCTION[4:1];
				SOURCE_REG_B = 0;
				SOURCE_REG_C = 0;
				OV_WRITE = 1;
				HALT = 0;
			end // 1:
		endcase
	end
endmodule // Control
