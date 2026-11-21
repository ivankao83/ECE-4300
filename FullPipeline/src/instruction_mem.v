`timescale 1ns / 1ps
//Stores the instructions for the Fetch stage
module instruction_mem(
    input wire [31:0] pc_out,
    output wire [31:0] instrmem_out
);

    //stores 32-bit instructions
    reg [31:0] memory [0:36];

    //loads the instructions from instr.mem
    initial begin
        $readmemb("instr.mem", memory);
    end

    //uses the PC to select the instruction
    assign instrmem_out = (pc_out >= 32'd96) ? 32'h80000000 : memory[pc_out[7:2]];

endmodule
