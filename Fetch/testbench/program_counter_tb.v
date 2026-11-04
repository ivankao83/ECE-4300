`timescale 1ns / 1ps

module program_counter_tb();

reg clk_tb;
reg rst_tb;
reg [31:0] pc_in_tb;

wire [31:0] pc_out_tb;

program_counter DUT(
    .clk(clk_tb),
    .rst(rst_tb),
    .pc_in(pc_in_tb),
    .pc_out(pc_out_tb)
);

initial clk_tb = 0;
always #5 clk_tb = ~clk_tb;

initial begin

    rst_tb = 1;
    pc_in_tb = 32'd0;
    #10;

    rst_tb = 0;

    pc_in_tb = 32'd4;
    #10;

    pc_in_tb = 32'd8;
    #10;

    pc_in_tb = 32'd12;
    #10;

    pc_in_tb = 32'd16;
    #10;

    pc_in_tb = 32'd20;
    #10;

    pc_in_tb = 32'd24;
    #10;

    pc_in_tb = 32'd28;
    #10;

    pc_in_tb = 32'd32;
    #10;

    pc_in_tb = 32'd36;
    #10;

    $finish;

end

endmodule