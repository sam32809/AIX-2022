`timescale 1ns / 1ps

module mac(
input clk, 
input rstn, 
input vld_i, 
input [215:0] win, 
input [215:0] din,
output[ 20:0] acc_o, 
output        vld_o
);

//----------------------------------------------------------------------
// Signals
//----------------------------------------------------------------------
reg[15:0] y00;
reg[15:0] y01;
reg[15:0] y02;
reg[15:0] y03;
reg[15:0] y04;
reg[15:0] y05;
reg[15:0] y06;
reg[15:0] y07;
reg[15:0] y08;
reg[15:0] y09;
reg[15:0] y10;
reg[15:0] y11;
reg[15:0] y12;
reg[15:0] y13;
reg[15:0] y14;
reg[15:0] y15;
reg[15:0] y16;
reg[15:0] y17;
reg[15:0] y18;
reg[15:0] y19;
reg[15:0] y20;
reg[15:0] y21;
reg[15:0] y22;
reg[15:0] y23;
reg[15:0] y24;
reg[15:0] y25;
reg[15:0] y26;


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
mul u_mul_09(.clk(clk), .w(win[ 79: 72]),.x(din[ 79: 72]),.y(y09));
mul u_mul_10(.clk(clk), .w(win[ 87: 80]),.x(din[ 87: 80]),.y(y10));
mul u_mul_11(.clk(clk), .w(win[ 95: 88]),.x(din[ 95: 88]),.y(y11));
mul u_mul_12(.clk(clk), .w(win[103: 96]),.x(din[103: 96]),.y(y12));
mul u_mul_13(.clk(clk), .w(win[111:104]),.x(din[111:104]),.y(y13));
mul u_mul_14(.clk(clk), .w(win[119:112]),.x(din[119:112]),.y(y14));
mul u_mul_15(.clk(clk), .w(win[127:120]),.x(din[127:120]),.y(y15));
mul u_mul_16(.clk(clk), .w(win[135:128]),.x(din[135:128]),.y(y16));
mul u_mul_17(.clk(clk), .w(win[143:136]),.x(din[143:136]),.y(y17));
mul u_mul_18(.clk(clk), .w(win[151:144]),.x(din[151:144]),.y(y18));
mul u_mul_19(.clk(clk), .w(win[159:152]),.x(din[159:152]),.y(y19));
mul u_mul_20(.clk(clk), .w(win[167:160]),.x(din[167:160]),.y(y20));
mul u_mul_21(.clk(clk), .w(win[175:168]),.x(din[175:168]),.y(y21));
mul u_mul_22(.clk(clk), .w(win[183:176]),.x(din[183:176]),.y(y22));
mul u_mul_23(.clk(clk), .w(win[191:184]),.x(din[191:184]),.y(y23));
mul u_mul_24(.clk(clk), .w(win[199:192]),.x(din[199:192]),.y(y24));
mul u_mul_25(.clk(clk), .w(win[207:200]),.x(din[207:200]),.y(y25));
mul u_mul_26(.clk(clk), .w(win[215:208]),.x(din[215:208]),.y(y26));
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
./*input [15:0] */mul_09(y09), 
./*input [15:0] */mul_10(y10), 
./*input [15:0] */mul_11(y11), 
./*input [15:0] */mul_12(y12), 
./*input [15:0] */mul_13(y13), 
./*input [15:0] */mul_14(y14), 
./*input [15:0] */mul_15(y15), 
./*input [15:0] */mul_16(y16),
./*input [15:0] */mul_17(y17), 
./*input [15:0] */mul_18(y18), 
./*input [15:0] */mul_19(y19), 
./*input [15:0] */mul_20(y20), 
./*input [15:0] */mul_21(y21), 
./*input [15:0] */mul_22(y22), 
./*input [15:0] */mul_23(y23), 
./*input [15:0] */mul_24(y24), 
./*input [15:0] */mul_25(y25),
./*input [15:0] */mul_26(y26),  
./*output[19:0] */acc_o(acc_o),
./*output       */vld_o(vld_o) 
);
endmodule