
`timescale 1ns / 1ps

module data_memory_tb;

    reg clk;
    reg [31:0] addr;
    reg [31:0] write_data;
    reg memread;
    reg memwrite;

    wire [31:0] read_data;

    // Instantiate data memory
    data_memory uut (
        .clk(clk),
        .addr(addr),
        .write_data(write_data),
        .memread(memread),
        .memwrite(memwrite),
        .read_data(read_data)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Initialize inputs
        addr = 0;
        write_data = 0;
        memread = 0;
        memwrite = 0;

        // Test 1: Read DMEM[0]
        #10;
        memread = 1;
        addr = 0;
        #5;
        $display("Read DMEM[0]: %0d", read_data);

        // Test 2: Read DMEM[5]
        addr = 20;
        #5;
        $display("Read DMEM[5]: %0d", read_data);

        // Test 3: Write 100 to DMEM[6]
        addr = 24;
        write_data = 100;
        memread = 0;
        memwrite = 1;
        #10;

        // Stop writing and read the same location
        memwrite = 0;
        memread = 1;
        #1;
        $display("Read DMEM[6] after writing 100: %0d", read_data);

        #10;
        $finish;
    end

endmodule
