`timescale 1ns / 1ps
module regfile(
    input wire clk,
               rst,
               regwrite,
    input wire [4:0] rs,
                     rt,
                     rd,
    input wire [31:0] writedata,
    output wire [31:0] A_readdat1,
                       B_readdat2
);

    reg [31:0] REG [0:31];
    integer i;

    //starts all registers at zero
    initial begin
        for (i = 0; i < 32; i = i + 1)
            REG[i] = 32'b0;
    end

    //writes data on the rising clock edge
    always @(posedge clk) begin
        if (rst) begin
            for (i = 0; i < 32; i = i + 1)
                REG[i] <= 32'b0;
        end
        else if (regwrite && rd != 5'd0) begin
            REG[rd] <= writedata;
        end
    end

    //reads register values
    assign A_readdat1 = REG[rs];
    assign B_readdat2 = REG[rt];

endmodule
