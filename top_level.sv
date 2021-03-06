module top_level(
	input clk, start,
	output logic done
);

RAM data_mem();
ROM instr_rom();
rf reg_file();
LOGIC ALU();
initial begin 
	wait(start)
	#1000ns done = 1;
end // initial
endmodule // top_level
