
module InstROM(
  input       [ 15:0] i_addr,
  output 	  [ 8:0] o_value);

logic [8:0] instructions [0:2**7];

 // Instructions have [4bit opcode][3bit rs or rt][2bit rt, immediate, or branch target]

initial
begin
	$readmemb("instruct.txt", instructions);
end

assign o_value = instructions[i_addr];

endmodule
