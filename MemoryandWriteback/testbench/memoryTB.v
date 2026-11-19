
`timescale 1ns / 1ps

module memoryTB;

    reg clk;
    reg [31:0] ALUResult, WriteData;
    reg [4:0] WriteReg;
    reg [1:0] WBControl;
    reg MemWrite, MemRead, Branch, Zero;

    wire [31:0] ReadData, ALUResult_out;
    wire [4:0] WriteReg_out;
    wire [1:0] WBControl_out;
    wire PCSrc;

    //connects the Memory stage
    mem_stage uut (
        .clk(clk),
        .ALUResult(ALUResult),
        .WriteData(WriteData),
        .WriteReg(WriteReg),
        .WBControl(WBControl),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .Branch(Branch),
        .Zero(Zero),
        .ReadData(ReadData),
        .ALUResult_out(ALUResult_out),
        .WriteReg_out(WriteReg_out),
        .WBControl_out(WBControl_out),
        .PCSrc(PCSrc)
    );

    //clock changes every 5 ns
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        //start with memory read
        ALUResult = 32'h00000004;
        WriteData = 32'h12345678;
        WriteReg = 5'h02;
        WBControl = 2'b01;
        MemWrite = 0;
        MemRead = 1;
        Branch = 0;
        Zero = 0;

        // Test 1 - memory read
        #12;
        $display("Test 1: Mem Read");
        $display("ReadData = %h", ReadData);

        // Test 2 - memory write
        @(negedge clk);
        MemWrite = 1;
        MemRead = 0;

        //wait for the write to happen
        @(posedge clk);
        #1;
        $display("Test 2: Mem Write");
        $display("WriteData = %h", WriteData);

        // Test 3 - read back the data
        @(negedge clk);
        MemWrite = 0;
        MemRead = 1;

        @(posedge clk);
        #1;
        $display("Test 3: Read Back");
        $display("ReadData = %h", ReadData);

        // Test 4 - branch
        @(negedge clk);
        Branch = 1;
        Zero = 1;

        #1;
        $display("Test 4: Branch");
        $display("PCSrc = %b", PCSrc);

        #10;
        $finish;
    end

endmodule
