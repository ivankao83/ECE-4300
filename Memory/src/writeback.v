
`timescale 1ns / 1ps

//Selects the data that goes back to Decode
module writeback(
    input wire [31:0] ReadData,
    input wire [31:0] ALUResult,
    input wire [4:0] WriteReg,
    input wire [1:0] WBControl,

    output wire [31:0] WriteData,
    output wire [4:0] WriteReg_out,
    output wire RegWrite
);

    //selects memory data or ALU result
    mux mux5(
        .read_data(ReadData),
        .alu_result(ALUResult),
        .memtoreg(WBControl[0]),
        .write_data(WriteData)
    );

    //passes the register and control signal to Decode
    assign WriteReg_out = WriteReg;
    assign RegWrite = WBControl[1];

endmodule
