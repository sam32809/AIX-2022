`timescale 1ns / 1ps

module cnv(
input[11:0] 			row,col,
input[71:0] 			weight,
input [2457599:0] 		img, //input image
input					ctrl_data_run,
output[63:0] 			all_acc_o,
output					v_o
//output[15:0] frame_done
);

parameter WIDTH=320;
parameter HEIGHT=320;

wire[7:0] in_img[0:307199];//Input images
wire[20:0] acc_o[0:7];
reg[215:0] din;
reg[215:0] win[0:7];

reg vld_i=1'b1;
wire vld_o[0:15];
assign v_o = vld_o[0];
//-------------------------------------------
// DUT: MACs
//-------------------------------------------

mac u_mac_00(
./*input 		 */clk(clk), 
./*input 		 */rstn(rstn), 
./*input 		 */vld_i(vld_i), 
./*input [215:0] */win(win[0]), 
./*input [215:0]  */din(din),
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


//-------------------------------------------------
// Output
//-------------------------------------------------

assign all_acc_o = {acc_o[7][20:13]
,acc_o[6][20:13],acc_o[5][20:13],acc_o[4][20:13],acc_o[3][20:13],acc_o[2][20:13]
,acc_o[1][20:13],acc_o[0][20:13]};


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
		
		din[79:72] = (is_first_row | is_first_col) ? 8'd0 : in_img[WIDTH*HEIGHT + (row-1) * WIDTH + (col-1)];
        din[87:80] = (is_first_row               ) ? 8'd0 : in_img[WIDTH*HEIGHT + (row-1) * WIDTH +  col   ];
        din[95:88] = (is_first_row | is_last_col ) ? 8'd0 : in_img[WIDTH*HEIGHT + (row-1) * WIDTH + (col+1)];
        din[103:96] = (               is_first_col) ? 8'd0 : in_img[WIDTH*HEIGHT + row    * WIDTH + (col-1)];
        din[111:104] =                                        in_img[WIDTH*HEIGHT + row    * WIDTH +  col   ];
        din[119:112] = (               is_last_col ) ? 8'd0 : in_img[WIDTH*HEIGHT + row    * WIDTH + (col+1)];
        din[127:120] = (is_last_row | is_first_col ) ? 8'd0 : in_img[WIDTH*HEIGHT + (row+1) * WIDTH + (col-1)];
        din[135:128] = (is_last_row                ) ? 8'd0 : in_img[WIDTH*HEIGHT + (row+1) * WIDTH +  col   ];
        din[143:136] = (is_last_row | is_last_col  ) ? 8'd0 : in_img[WIDTH*HEIGHT + (row+1) * WIDTH + (col+1)];
		
		din[151:144] = (is_first_row | is_first_col) ? 8'd0 : in_img[2*WIDTH*HEIGHT + (row-1) * WIDTH + (col-1)];
        din[159:152] = (is_first_row               ) ? 8'd0 : in_img[2*WIDTH*HEIGHT + (row-1) * WIDTH +  col   ];
        din[167:160] = (is_first_row | is_last_col ) ? 8'd0 : in_img[2*WIDTH*HEIGHT + (row-1) * WIDTH + (col+1)];
        din[175:168] = (               is_first_col) ? 8'd0 : in_img[2*WIDTH*HEIGHT +  row    * WIDTH + (col-1)];
        din[183:176] =                                        in_img[2*WIDTH*HEIGHT +  row    * WIDTH +  col   ];
        din[191:184] = (               is_last_col ) ? 8'd0 : in_img[2*WIDTH*HEIGHT +  row    * WIDTH + (col+1)];
        din[199:192] = (is_last_row | is_first_col ) ? 8'd0 : in_img[2*WIDTH*HEIGHT + (row+1) * WIDTH + (col-1)];
        din[207:200] = (is_last_row                ) ? 8'd0 : in_img[2*WIDTH*HEIGHT + (row+1) * WIDTH +  col   ];
        din[215:208] = (is_last_row | is_last_col  ) ? 8'd0 : in_img[2*WIDTH*HEIGHT + (row+1) * WIDTH + (col+1)];
    end
end



endmodule