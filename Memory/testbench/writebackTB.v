
`timescale 1ns / 1ps

module writebackTB;

    reg [31:0] ReadData, ALUResult;
    reg [4:0] WriteReg;
    reg [1:0] WBControl;

    wire [31:0] WriteData;
    wire [4:0] WriteReg_out;
    wire RegWrite;

    //connects the Writeback stage
    writeback uut(
        .ReadData(ReadData),
        .ALUResult(ALUResult),
        .WriteReg(WriteReg),
        .WBControl(WBControl),
        .WriteData(WriteData),
        .WriteReg_out(WriteReg_out),
        .RegWrite(RegWrite)
    );

    initial begin
        // Test 1 - ALU result
        ReadData = 32'd25;
        ALUResult = 32'd10;
        WriteReg = 5'd2;
        WBControl = 2'b10;

        #10;
        $display("Test 1: ALU Result");
        $display("WriteData = %d", WriteData);

        // Test 2 - memory data
        WBControl = 2'b11;

        #10;
        $display("Test 2: Memory Data");
        $display("WriteData = %d", WriteData);

        // Test 3 - register write disabled
        WBControl = 2'b00;

        #10;
        $display("Test 3: RegWrite Disabled");
        $display("RegWrite = %b", RegWrite);

        $finish;
    end

endmodule
