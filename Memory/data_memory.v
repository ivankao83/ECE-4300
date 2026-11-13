`timescale 1ns / 1ps

/*Instantiates and serves as the data mememory. 
Its inputs are alu_result, rdata2out, memwrite, and memread, which stem from the EX/MEM latch.
The output, read_data, goes to the MEM/WB latch. 
If memread is true, then read_data is re-assigned as the value in current address. If memwrite is true,
then read_data is unaltered, and instead, the value in the current address is changed to rdata2out. 
*/

module data_memory(
    input wire clk,
    input wire [31:0] addr,
    input wire [31:0] write_data,
    input wire memread,
    input wire memwrite,
    output reg [31:0] read_data
);

reg [31:0] DMEM [0:255];

integer i;

initial begin
    
    read_data = 32'b0;

    //load the memory with our data.txt
    $readmemb("data.txt", DMEM);
    //Uncomment and edit the below if you need a different path to read data.txt
    //$readmemb("ECE-4300/Memory/data.txt", DMEM);

    for (i = 6; i < 256; i = i + 1)
        DMEM[i] = i;   

    $display("DEM[i]");

    for (i = 0; i < 6; i = i + 1)
        $display("\tDMEM[%0d] = %0b", i, DMEM[i]);

    for (i = 6; i < 10; i = i + 1)
        $display("\tDMEM[%0d] = %0b", i, DMEM[i]);

end

//memory write sequential so using non blocking
always @(posedge clk) begin
    if (memwrite)
        DMEM[addr[9:2]] <= write_data;
end

//memory read is combinational so blocking =
always @(*) begin
    if (memread)
        read_data = DMEM[addr[9:2]];
    else
        read_data = 32'b0;
end

endmodule
