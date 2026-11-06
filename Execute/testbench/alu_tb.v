`timescale 1ns / 1ps
/*
Tests alu.v
*/
module alu_test;
// Inputs
reg [31:0] a;
reg [31:0] b;
reg [2:0] control;
// Outputs
wire [31:0] result;
wire zero;
// Instantiate the Unit Under Test (UUT)
alu uut (
.a(a), 
.b(b), 
.control(control), 
.result(result), 
.zero(zero)
);
initial begin
a = 'b1010; // 10
b = 'b0111; // 7
control = 'b011;
$display("A = %b\t B = %b", a, b);
$monitor("ALUop = %b\t result = %b\t zero = %b", control, result, zero);
#1 
control = 'b100;
#1 
control = 'b010;
#1 
control = 'b111; // result = 0 check slt
#1 
control = 'b011;
#1 
control = 'b110;
#1 
control = 'b001; // result = 'b1111, check or
#1 
control = 'b000; // result = 'b10, check and
#1
 // Test SLT with a negative number
#1;
a = -32'sd5;
b = 32'd3;
control = 3'b111; // -5 < 3? Yes

// Test SLT with negative B
#1;
a = 32'd5;
b = -32'sd3;
control = 3'b111; // 5 < -3? No

#1;
$finish;
end
      
endmodule
