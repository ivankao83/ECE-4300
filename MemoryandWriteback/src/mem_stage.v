
`timescale 1ns / 1ps

//Connects the modules for the Memory stage
//Takes the results from Execute and passes them to Writeback

module mem_stage(
    input wire clk,
    input wire [31:0] ALUResult,
    input wire [31:0] WriteData,
    input wire [4:0] WriteReg,
    input wire [1:0] WBControl,
    input wire MemWrite, MemRead, Branch, Zero,

    output wire [31:0] ReadData,
    output wire [31:0] ALUResult_out,
    output wire [4:0] WriteReg_out,
    output wire [1:0] WBControl_out,
    output wire PCSrc
);

    //internal wires to connect the modules
    wire [31:0] read_data_in;
    wire regwrite, memtoreg;

    //checks if a branch should happen
    AND AND_4(
        .membranch(Branch),
        .zero(Zero),
        .PCSrc(PCSrc)
    );

    //reads or writes data in memory
    data_memory data_memory4(
        .clk(clk),
        .addr(ALUResult),
        .write_data(WriteData),
        .memwrite(MemWrite),
        .memread(MemRead),
        .read_data(read_data_in)
    );

    //stores the results for Writeback
    latch mem_wb4(
        .clk(clk),
        .control_wb_in(WBControl),
        .read_data_in(read_data_in),
        .alu_result_in(ALUResult),
        .write_reg_in(WriteReg),

        //outputs
        .regwrite(regwrite),
        .memtoreg(memtoreg),
        .read_data(ReadData),
        .mem_alu_result(ALUResult_out),
        .mem_write_reg(WriteReg_out)
    );

    //combines the WB control signals
    assign WBControl_out = {regwrite, memtoreg};

endmodule
