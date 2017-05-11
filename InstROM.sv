// Company: 
// Engineer: 
// 
// Create Date:    15:50:22 11/02/2007 
// Design Name: 
// Module Name:    InstROM 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: This is a basic verilog module to behave as an instruction ROM
// 				 template.
//
// Dependencies: 
//
// Revision: 		2017.02.25
// Revision 0.01 - File Created
// Additional Comments: 
//
module InstROM(
  input       [ 7:0] i_addr,
  output 	  [ 8:0] o_value);

logic [8:0] instructions [0:2**7];
	 
 // Instructions have [4bit opcode][3bit rs or rt][2bit rt, immediate, or branch target]
	 
initial
begin
	$readmemb("instruct.txt", instructions);
end

assign o_value = instructions[i_addr]

endmodule
