
`timescale 1ns / 1ps

module mux(
    input wire [31:0] read_data,
    input wire [31:0] alu_result,
    input wire memtoreg,

    output reg [31:0] write_data
);

always @(*) begin
    if (memtoreg == 1'b1)
        write_data = read_data;
    else
        write_data = alu_result;
end

endmodule
