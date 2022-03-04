`timescale 1ns / 1ps

module mac(
input clk, 
input rstn, 
input vld_i, 
input [71:0] win, 
input [71:0] din,
output[ 19:0] acc_o, 
output        vld_o
);

//----------------------------------------------------------------------
// Signals
//----------------------------------------------------------------------
wire[15:0] y00;
wire[15:0] y01;
wire[15:0] y02;
wire[15:0] y03;
wire[15:0] y04;
wire[15:0] y05;
wire[15:0] y06;
wire[15:0] y07;
wire[15:0] y08;


reg vld_i_d0, vld_i_d1, vld_i_d2, vld_i_d3, vld_i_d4;
//----------------------------------------------------------------------
// Components: Array of multipliers
//----------------------------------------------------------------------
mul u_mul_00(.clk(clk), .w(win[  7:  0]),.x(din[  7:  0]),.y(y00));
mul u_mul_01(.clk(clk), .w(win[ 15:  8]),.x(din[ 15:  8]),.y(y01));
mul u_mul_02(.clk(clk), .w(win[ 23: 16]),.x(din[ 23: 16]),.y(y02));
mul u_mul_03(.clk(clk), .w(win[ 31: 24]),.x(din[ 31: 24]),.y(y03));
mul u_mul_04(.clk(clk), .w(win[ 39: 32]),.x(din[ 39: 32]),.y(y04));
mul u_mul_05(.clk(clk), .w(win[ 47: 40]),.x(din[ 47: 40]),.y(y05));
mul u_mul_06(.clk(clk), .w(win[ 55: 48]),.x(din[ 55: 48]),.y(y06));
mul u_mul_07(.clk(clk), .w(win[ 63: 56]),.x(din[ 63: 56]),.y(y07));
mul u_mul_08(.clk(clk), .w(win[ 71: 64]),.x(din[ 71: 64]),.y(y08));
//----------------------------------------------------------------------
// Delays
//----------------------------------------------------------------------
always@(posedge clk, negedge rstn) begin
	if(!rstn) begin
	    vld_i_d0 <= 0;
		vld_i_d1 <= 0;
		vld_i_d2 <= 0;
		vld_i_d3 <= 0;
		vld_i_d4 <= 0;
	end
	else begin 
		vld_i_d0 <= vld_i   ;
		vld_i_d1 <= vld_i_d0;
		vld_i_d2 <= vld_i_d1;
		vld_i_d3 <= vld_i_d2;
		vld_i_d4 <= vld_i_d3;	
	end
end
//----------------------------------------------------------------------
// Adder tree
//----------------------------------------------------------------------
adder_tree u_adder_tree(
./*input 		*/clk(clk), 
./*input 		*/rstn(rstn),
./*input 		*/vld_i(vld_i_d4),
./*input [15:0] */mul_00(y00), 
./*input [15:0] */mul_01(y01), 
./*input [15:0] */mul_02(y02), 
./*input [15:0] */mul_03(y03), 
./*input [15:0] */mul_04(y04), 
./*input [15:0] */mul_05(y05), 
./*input [15:0] */mul_06(y06), 
./*input [15:0] */mul_07(y07),
./*input [15:0] */mul_08(y08), 
./*output[19:0] */acc_o(acc_o),
./*output       */vld_o(vld_o) 
);
endmodule