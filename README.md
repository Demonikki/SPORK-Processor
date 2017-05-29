# SPORK-Processor
## Verilog and System Verilog description of a custom 9-bit processor.
#### Ajay Singh (A12032729)  and Nikhilesh Sankar (A91081886)
CSE 141-L

Lab 3 README

For our assembler, we decided to create it in java because that was the language we were both most familiar with. Our assembler takes in an instruction file and outputs a 9 bit response conversion for each instruction. Our assembler has a large switch case statement for all of our instructions, and many helper methods to symbolize the different types of instructions we had. Many of our instructions were accumulator style (like Move and Get), but a couple (like load/store and add) were reg-reg style. Whatever the case, it all runs through the single switch case statement and outputs a 9 bit value to a file.


To run assembler, compile Assembler.java and run with command line args:

    java Assembler assemblyCodeFile.txt
  
  
Binary code will be outputted to `assembleCodeFile.txt_binary`.
