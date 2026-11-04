`timescale 1ns / 1ps

module adder_tb();

reg [31:0] pc_out_tb;
wire [31:0] next_pc_tb;

adder DUT(
    .pc_out(pc_out_tb),
    .next_pc(next_pc_tb)
);

initial begin

    pc_out_tb = 32'd0;
    #10;

    pc_out_tb = 32'd4;
    #10;

    pc_out_tb = 32'd8;
    #10;

    pc_out_tb = 32'd12;
    #10;
    
    pc_out_tb = 32'd16;
    #10;

    pc_out_tb = 32'd20;
    #10;

    pc_out_tb = 32'd24;
    #10;

    pc_out_tb = 32'd28;
    #10;

    pc_out_tb = 32'd32;
    #10;

    pc_out_tb = 32'd36;
    #10;
    $finish;

end

endmodule
