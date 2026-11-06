`timescale 1ns / 1ps

//top mux
module top_mux(
    input wire [31:0] a,
    input wire [31:0] b,
    input wire alusrc,
    output wire [31:0] y
);

    assign y = alusrc ? a : b;

endmodule


// bottom mux
module bottom_mux(
    input wire [4:0] a,
    input wire [4:0] b,
    input wire sel,
    output wire [4:0] y
);

    assign y = sel ? a : b;

endmodule
