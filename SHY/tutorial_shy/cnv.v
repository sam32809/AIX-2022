`timescale 1ns / 1ps

module cnv(
input[71:0] weight,
input [131071:0] img, //input image
output[127:0] all_acc_o,
output[15:0] frame_done
);

wire[7:0] in_img[0:16383];//Input image
wire[19:0] acc_o[0:15];
reg[71:0] din;
reg[71:0] win[0:15];

reg vld_i=1'b1;
wire vld_o[0:15];
//-------------------------------------------
// DUT: MACs
//-------------------------------------------

mac u_mac_00(
./*input 		 */clk(clk), 
./*input 		 */rstn(rstn), 
./*input 		 */vld_i(vld_i), 
./*input [127:0] */win(win[0]), 
./*input [127:0] */din(din),
./*output[ 19:0] */acc_o(acc_o[0]), 
./*output        */vld_o(vld_o[0])
);
mac u_mac_01(
./*input 		 */clk(clk), 
./*input 		 */rstn(rstn), 
./*input 		 */vld_i(vld_i), 
./*input [127:0] */win(win[1]), 
./*input [127:0] */din(din),
./*output[ 19:0] */acc_o(acc_o[1]), 
./*output        */vld_o(vld_o[1])
);
mac u_mac_02(
./*input 		 */clk(clk), 
./*input 		 */rstn(rstn), 
./*input 		 */vld_i(vld_i), 
./*input [127:0] */win(win[2]), 
./*input [127:0] */din(din),
./*output[ 19:0] */acc_o(acc_o[2]), 
./*output        */vld_o(vld_o[2])
);
mac u_mac_03(
./*input 		 */clk(clk), 
./*input 		 */rstn(rstn), 
./*input 		 */vld_i(vld_i), 
./*input [127:0] */win(win[3]), 
./*input [127:0] */din(din),
./*output[ 19:0] */acc_o(acc_o[3]), 
./*output        */vld_o(vld_o[3])
);
mac u_mac_04(
./*input 		 */clk(clk), 
./*input 		 */rstn(rstn), 
./*input 		 */vld_i(vld_i), 
./*input [127:0] */win(win[4]), 
./*input [127:0] */din(din),
./*output[ 19:0] */acc_o(acc_o[4]), 
./*output        */vld_o(vld_o[4])
);
mac u_mac_05(
./*input 		 */clk(clk), 
./*input 		 */rstn(rstn), 
./*input 		 */vld_i(vld_i), 
./*input [127:0] */win(win[5]), 
./*input [127:0] */din(din),
./*output[ 19:0] */acc_o(acc_o[5]), 
./*output        */vld_o(vld_o[5])
);
mac u_mac_06(
./*input 		 */clk(clk), 
./*input 		 */rstn(rstn), 
./*input 		 */vld_i(vld_i), 
./*input [127:0] */win(win[6]), 
./*input [127:0] */din(din),
./*output[ 19:0] */acc_o(acc_o[6]), 
./*output        */vld_o(vld_o[6])
);
mac u_mac_07(
./*input 		 */clk(clk), 
./*input 		 */rstn(rstn), 
./*input 		 */vld_i(vld_i), 
./*input [127:0] */win(win[7]), 
./*input [127:0] */din(din),
./*output[ 19:0] */acc_o(acc_o[7]), 
./*output        */vld_o(vld_o[7])
);
mac u_mac_08(
./*input 		 */clk(clk), 
./*input 		 */rstn(rstn), 
./*input 		 */vld_i(vld_i), 
./*input [127:0] */win(win[8]), 
./*input [127:0] */din(din),
./*output[ 19:0] */acc_o(acc_o[8]), 
./*output        */vld_o(vld_o[8])
);
mac u_mac_09(
./*input 		 */clk(clk), 
./*input 		 */rstn(rstn), 
./*input 		 */vld_i(vld_i), 
./*input [127:0] */win(win[9]), 
./*input [127:0] */din(din),
./*output[ 19:0] */acc_o(acc_o[9]), 
./*output        */vld_o(vld_o[9])
);
mac u_mac_10(
./*input 		 */clk(clk), 
./*input 		 */rstn(rstn), 
./*input 		 */vld_i(vld_i), 
./*input [127:0] */win(win[10]), 
./*input [127:0] */din(din),
./*output[ 19:0] */acc_o(acc_o[10]), 
./*output        */vld_o(vld_o[10])
);
mac u_mac_11(
./*input 		 */clk(clk), 
./*input 		 */rstn(rstn), 
./*input 		 */vld_i(vld_i), 
./*input [127:0] */win(win[11]), 
./*input [127:0] */din(din),
./*output[ 19:0] */acc_o(acc_o[11]), 
./*output        */vld_o(vld_o[11])
);
mac u_mac_12(
./*input 		 */clk(clk), 
./*input 		 */rstn(rstn), 
./*input 		 */vld_i(vld_i), 
./*input [127:0] */win(win[12]), 
./*input [127:0] */din(din),
./*output[ 19:0] */acc_o(acc_o[12]), 
./*output        */vld_o(vld_o[12])
);
mac u_mac_13(
./*input 		 */clk(clk), 
./*input 		 */rstn(rstn), 
./*input 		 */vld_i(vld_i), 
./*input [127:0] */win(win[13]), 
./*input [127:0] */din(din),
./*output[ 19:0] */acc_o(acc_o[13]), 
./*output        */vld_o(vld_o[13])
);
mac u_mac_14(
./*input 		 */clk(clk), 
./*input 		 */rstn(rstn), 
./*input 		 */vld_i(vld_i), 
./*input [127:0] */win(win[14]), 
./*input [127:0] */din(din),
./*output[ 19:0] */acc_o(acc_o[14]), 
./*output        */vld_o(vld_o[14])
);
mac u_mac_15(
./*input 		 */clk(clk), 
./*input 		 */rstn(rstn), 
./*input 		 */vld_i(vld_i), 
./*input [127:0] */win(win[15]), 
./*input [127:0] */din(din),
./*output[ 19:0] */acc_o(acc_o[15]), 
./*output        */vld_o(vld_o[15])
);

//-------------------------------------------------
// Output
//-------------------------------------------------

wire[127:0] all_acc_o = {acc_o[15][19:12],acc_o[14][19:12],acc_o[13][19:12],acc_o[12][19:12]
,acc_o[11][19:12],acc_o[10][19:12],acc_o[9][19:12],acc_o[8][19:12],acc_o[7][19:12]
,acc_o[6][19:12],acc_o[5][19:12],acc_o[4][19:12],acc_o[3][19:12],acc_o[2][19:12]
,acc_o[1][19:12],acc_o[0][19:12]};


//-------------------------------------------------
//make din
//-------------------------------------------------

wire is_first_row = (row == 0) ? 1'b1 : 1'b0;
wire is_last_row = (row == HEIGHT-1) ? 1'b1 : 1'b0;
wire is_first_col = (col == 0) ? 1'b1 : 1'b0;
wire is_last_col = (col == WIDTH-1) ? 1'b1 : 1'b0;


generate 
    genvar j;
    for (j = 0; j < HEIGHT*WIDTH; j = j + 1) begin
        assign in_img[j] = img[8*(j+1)-1-:8];
    end
endgenerate


always @*
 begin
    vld_i = 1'b0;
    if(ctrl_data_run) begin
        vld_i = 1'b1;
        din[ 7: 0] = (is_first_row | is_first_col) ? 8'd0 : in_img[(row-1) * WIDTH + (col-1)];
        din[15: 8] = (is_first_row               ) ? 8'd0 : in_img[(row-1) * WIDTH +  col   ];
        din[23:16] = (is_first_row | is_last_col ) ? 8'd0 : in_img[(row-1) * WIDTH + (col+1)];
        din[31:24] = (               is_first_col) ? 8'd0 : in_img[ row    * WIDTH + (col-1)];
        din[39:32] =                                        in_img[ row    * WIDTH +  col   ];
        din[47:40] = (               is_last_col ) ? 8'd0 : in_img[ row    * WIDTH + (col+1)];
        din[55:48] = (is_last_row | is_first_col ) ? 8'd0 : in_img[(row+1) * WIDTH + (col-1)];
        din[63:56] = (is_last_row                ) ? 8'd0 : in_img[(row+1) * WIDTH +  col   ];
        din[71:64] = (is_last_row | is_last_col  ) ? 8'd0 : in_img[(row+1) * WIDTH + (col+1)];
    end
end



endmodule