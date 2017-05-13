// Verilog Test Fixture for module: reg_file

module RegFile_tb;
  parameter DT = 4,	         // address width
            WT = 8;		     // data path width
// DUT Input Drivers		 // type "bit" self-initializes to 0
  bit           CLK;	     // bit can be only 0, 1 (no x or z)
  bit           RegWrite;    // write enable
  bit [ DT-1:0] srcA,		 // address pointer for ReadA out 
                srcB,		 // address pointer for ReadB out
                writeReg;	 // address pointer for writing writeValue in
  bit [ WT-1:0] writeValue;	 // data in

// DUT Outputs
  wire [WT-1:0] ReadA,	     // data out
                ReadB;	     // data out

// Instantiate the Unit Under Test (UUT)
  RegFile #(.W(WT),.D(DT)) uut(
	.CLK       (CLK) ,            // equivalent to .CLK(CLK),
	.RegWrite  (RegWrite) , 	      	 //   may omit external connector name if same
	.srcA      (srcA) , 		     //   as port name (SystemVerilog shorthand)
	.srcB      (srcB), 
	.writeReg  (writeReg) , 
	.writeValue(writeValue) , 
	.ReadA     (ReadA) , 
	.ReadB     (ReadB) 
	);

  initial begin			     // Initialize inputs to 0 already done for us by "bit"
    $monitor("RegWrite=%b, writeReg=%d, write_Value=%h, srcA=%d, srcB=%d, ReadA=%h, ReadB=%h",
	         RegWrite,writeReg,writeValue,srcA,srcB,ReadA,ReadB,,$time);
	#80ns;					 // wait 8 clock cycles for global reset elsewhere
        
// test write and readback
	srcA       =   'h1;		 // 'h automatically sizes constant to port width
    writeReg   =   'h1;
    writeValue =   'h67;
    RegWrite   =   'b1;
	#10ns;					 // wait 1 clock cycle
	writeReg   =   'h2;
	writeValue =   'hFE;
	#10ns;
	srcB       =   'h2;      
	#10ns;
	srcA       =   'h2;
//verify trying to write without RegWrite has no impact
	RegWrite   =   'b0;
	writeReg   =   'h2;
	writeValue =   'hAB;
	srcA       =   'h2;
	#20ns $stop;			 // ModelSim exits on $finish, so use $stop, instead
  end
  always begin
    #10ns CLK = 1;
    #10ns CLK = 0;
  end      
endmodule
