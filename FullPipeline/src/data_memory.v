`timescale 1ns / 1ps
//Reads and writes data for the Memory stage
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

        //loads the values from data.mem
        $readmemb("data.mem", DMEM);

        //initializes the remaining memory locations
        for (i = 6; i < 256; i = i + 1)
            DMEM[i] = i;

        //displays the initial values
        for (i = 0; i < 10; i = i + 1)
            $display("DMEM[%0d] = %0d", i, DMEM[i]);
    end

    //writes data on the rising clock edge
    always @(posedge clk) begin
        if (memwrite)
            DMEM[addr[7:0]] <= write_data;
    end

    //reads data when MemRead is enabled
    always @(*) begin
        if (memread)
            read_data = DMEM[addr[7:0]];
        else
            read_data = 32'b0;
    end

endmodule
