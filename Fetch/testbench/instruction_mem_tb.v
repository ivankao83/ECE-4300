`timescale 1ns / 1ps

module instruction_mem_tb();

reg [31:0] pc_out_tb;
wire [31:0] instrmem_out_tb;

instruction_mem DUT(
    .pc_out(pc_out_tb),
    .instrmem_out(instrmem_out_tb)
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