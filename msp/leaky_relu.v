`timescale 1ns / 1ps

module leaky_relu(
input [31:0] x,
output [31:0 ]y,
parameter alpha = 10
);

assign y=(x[31]==0)? x : x/10;

endmodule
