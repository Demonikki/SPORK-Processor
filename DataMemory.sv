module DataMemory (

    input clk,
    input [7:0] data_addr,
    input ReadMem,
    input WriteMem,
    input [7:0] DataIn,
    output logic[7:0] DataOut);

    //representation of memory
    logic [7:0] memory[256];

    always_comb
        if(ReadMem) begin
            DataOut = memory[data_addr];
        end
        else
            DataOut = 16'bZ;
				
    always_ff @ (posedge clk)
        if(WriteMem) begin
            memory[data_addr] = DataIn;
        end
endmodule

