module TopLevel(
	input clk, start,
	output logic halt	//halt signal
);

/* Wires */

//clk, start, halt are inputs to TopLevel
wire reset;
wire jump;
wire [15:0] PC;
wire [7:0] jump_value;
wire[8:0] instruction;	//9-bit instruction
wire reg_read, reg_write, mem_read, mem_write, mem_to_reg;



/* Initialising modules */
ProgramCounter pc_module(
	.clk,
	.start,
	.reset,
	.halt,
	.jump,
	.jump_value,
	.PC
);


InstROM ir_module(
	.instr_address(PC)	      //the PC is the instruction's address
	.instr_out(instruction) 	//store instr_out into instruction
);

initial begin 
	wait(start)
	#1000ns halt = 1;
end // initial
endmodule // TopLevel
