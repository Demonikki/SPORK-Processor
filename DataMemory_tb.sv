module DataMemory_tb;

    bit
        clk,
        ReadMem,
        WriteMem;
    reg [7:0] data_addr;
    reg [7:0] DataIn;
    wire [7:0] DataOut;

//New instance of Data memory
DataMemory d1 (
    .clk (clk),
    .ReadMem (ReadMem),
    .WriteMem (WriteMem),
    .data_addr (data_addr),
    .DataIn (DataIn),
    .DataOut (DataOut)
);

//Clock alternating every 5s
always begin
	#5ns clk = 1;
	#5ns clk = 0;
end

initial begin

	ReadMem = 0;
	WriteMem = 0;
	//starting at 20ns from beginning
	#20ns;

	//Write value 15 into address 0 in memory
	data_addr = 'b00000000;
	WriteMem = 1;
	DataIn = 'b00001111;

   #10ns;

	//Write value 4 into address 12
	data_addr = 'b00001100;
	WriteMem = 1;
	DataIn = 'b00000100;

	//On the next clock cycle
	#10ns;

	//Write value 6 into address 12
	data_addr = 'b00001100;
	WriteMem = 1;
	DataIn = 'b00000110;

    #10ns;
	//Read from address 0 (should be 15)
	data_addr = 'b00000000;
	ReadMem = 1; WriteMem = 0;
	//DataOut should hold the value 15

	//Next clock cycle
	#10ns;

	//Read from address 12 (should be 6)
	data_addr = 'b00001100;
	ReadMem = 1; WriteMem = 0;
	//DataOut should hold the value 6

	//stop
	#10ns $stop;

end

endmodule
