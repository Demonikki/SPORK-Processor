module ProgramCounter_tb;
    bit   	clk,
            start,
            reset,
            halt,
            jump;
    reg   	[7:0] jump_value;
    wire		[15:0] PC;

//New instance of Program Counter
ProgramCounter p1(
	.clk		(clk),
	.start	(start),
	.jump		(jump),
	.halt		(halt),
	.jump_value (jump_value)		,
	.PC
	);

//Clock cycle every 5ns
always begin
	#5ns clk = 1;
	#5ns clk = 0;
end

//The actual cycles
initial begin
	#10ns start = 1;
	#20ns start = 0;
	#50ns jump = 1,	jump_value = 8;
	#10ns jump = 0;
	#50ns halt = 1;
	#10ns halt = 0;
	#20ns $stop;
end

endmodule
