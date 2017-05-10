module ProgramCounter (
    input   clk,
            start,
            reset,
            halt,
            jump,
    output logic [7:0] jump_value,
    output logic [15:0] PC
	 );

    always_ff @(posedge clk) begin
        if(start)
            PC <= 0;
        else if (jump)
            PC <= 15;
        else if (!halt)
            PC <= PC + 1;
        else
            PC <= PC;
        end
endmodule
