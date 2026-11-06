`timescale 1ns / 1ps
/*
Takes in 6 bit of s_extendout with alu_op and outputs select, which is the control.
for alu.v This bridges machine language with assembly language.
*/

module alu_control(
    input wire [5:0] funct,
    input wire [1:0] aluop,
    output reg [2:0] select
);

// alu op parameters
parameter Rtype = 2'b10;
parameter lwsw = 2'b00;
parameter Itype = 2'b01;   // branch equal
parameter unknown = 2'b11; // for invalid opcode, ALUop = 2'b11

// alu control inputs
parameter ALUadd = 3'b010,
          ALUsub = 3'b110,    
          ALUand = 3'b000,
          ALUor  = 3'b001,
          ALUslt = 3'b111,
          ALUx   = 3'b011; // part of the control for invalid opcode

// Funct Field
parameter FUNCTadd = 6'b100000,
          FUNCTsub = 6'b100010,
          FUNCTand = 6'b100100,
          FUNCTor  = 6'b100101,
          FUNCTslt = 6'b101010;

always@(*) begin

    if (aluop == Rtype) begin
        case(funct)
            FUNCTadd: select = ALUadd;
            FUNCTsub: select = ALUsub;
            FUNCTand: select = ALUand;
            FUNCTor:  select = ALUor;
            FUNCTslt: select = ALUslt;
            default:  select = ALUx; 
        endcase
    end

    else if (aluop == lwsw) begin
        select = ALUadd;
    end

    else if (aluop == Itype) begin
        select = ALUsub;
    end
    
    else begin
        select = ALUx;
    end
    
end

endmodule
