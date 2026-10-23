`timescale 1ns / 1ps

module signExt(
input wire [15:0] immediate,
output wire [31:0] extended
);

// replicates the MSB by 16 then concatenates with immediate to make 32 bits    
    assign extended = {{16{immediate[15]}}, immediate};
    
endmodule
