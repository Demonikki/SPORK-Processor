module LUT(
	input[4:0] addr,
	output logic[15:0] Target
	);

always_comb
	case(addr)
		5'b00000:		Target = 16'h0;
		5'b00001:		Target = 16'h255;
		5'b00010:		Target = 16'h126;
		5'b00011:		Target = 16'h127;
		5'b00100:		Target = 16'h128;
		5'b00101:		Target = 16'h129;
		5'b00110:		Target = 16'h130;
		5'b00111:		Target = 16'h9;
		5'b01000:		Target = 16'h10;
		5'b01001:		Target = 16'h32;
		5'b01010:		Target = 16'h96;
		5'b10001:		Target = 16'h1;
		5'b10010:		Target = 16'h2;
		5'b10011:		Target = 16'h3;
		5'b10100:		Target = 16'h4;
		5'b10101:		Target = 16'h5;
		5'b10110:		Target = 16'h6;
		5'b10111:		Target = 16'h7;
		5'b11000:		Target = 16'h8;
		5'b11001:		Target = 16'h12;
		default:		Target = 16'h0;
	endcase // addr

endmodule // LUT