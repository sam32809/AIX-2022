`timescale 1ns / 1ps

module cnv(
input[71:0] win[0:15],
//input[7:0] in_img[0:16383],
output all_acc_o[127:0],
output frame_done[15:0]
);

reg all_acc_o[127:0];
reg frame_done[15:0];

reg[19:0] acc_o[0:15];
reg[71:0] din;

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

/*
assign all_acc_o={acc_o[15][19:12],acc_o[14][19:12],acc_o[13][19:12],acc_o[12][19:12]
,acc_o[11][19:12],acc_o[10][19:12],acc_o[9][19:12],acc_o[8][19:12],acc_o[7][19:12]
,acc_o[6][19:12],acc_o[5][19:12],acc_o[4][19:12],acc_o[3][19:12],acc_o[2][19:12]
,acc_o[1][19:12],acc_o[0][19:12]};
*/

//-------------------------------------------------
//make din
//-------------------------------------------------
/*
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


always(@*)
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
*/


//-------------------------------------------
// DUT: bmp_image_writer.v
//-------------------------------------------


parameter INFILE    = "./tutorial/butterfly_08bit.hex";
parameter OUTFILE0  = "./tutorial/fmap00.bmp";
parameter OUTFILE1  = "./tutorial/fmap01.bmp";
parameter OUTFILE2  = "./tutorial/fmap02.bmp";
parameter OUTFILE3  = "./tutorial/fmap03.bmp";
parameter OUTFILE4  = "./tutorial/fmap04.bmp";
parameter OUTFILE5  = "./tutorial/fmap05.bmp";
parameter OUTFILE6  = "./tutorial/fmap06.bmp";
parameter OUTFILE7  = "./tutorial/fmap07.bmp";
parameter OUTFILE8  = "./tutorial/fmap08.bmp";
parameter OUTFILE9  = "./tutorial/fmap09.bmp";
parameter OUTFILE10  = "./tutorial/fmap10.bmp";
parameter OUTFILE11  = "./tutorial/fmap11.bmp";
parameter OUTFILE12  = "./tutorial/fmap12.bmp";
parameter OUTFILE13  = "./tutorial/fmap13.bmp";
parameter OUTFILE14  = "./tutorial/fmap14.bmp";
parameter OUTFILE15  = "./tutorial/fmap15.bmp";
parameter FRAME_SIZE = WIDTH * HEIGHT;
parameter WIDTH=128;
parameter HEIGHT=128;


// Read the input file to memory
initial begin
	$readmemh(INFILE, in_img ,0,FRAME_SIZE-1);
end

bmp_image_writer #(.OUTFILE(OUTFILE0))
u_out_fmap00(
./*input 	 */clk(clk),
./*input 	 */rstn(rstn),
./*input[7:0]*/din(acc_o[0][19:12]),
./*input 	 */vld(vld_o[0]),
./*output    */frame_done(frame_done[0])
);

bmp_image_writer #(.OUTFILE(OUTFILE1))
u_out_fmap01(
./*input 	 */clk(clk),
./*input 	 */rstn(rstn),
./*input[7:0]*/din(acc_o[1][19:12]),
./*input 	 */vld(vld_o[1]),
./*output    */frame_done(frame_done[1])
);

bmp_image_writer #(.OUTFILE(OUTFILE2))
u_out_fmap02(
./*input 	 */clk(clk),
./*input 	 */rstn(rstn),
./*input[7:0]*/din(acc_o[2][19:12]),
./*input 	 */vld(vld_o[2]),
./*output    */frame_done(frame_done[2])
);

bmp_image_writer #(.OUTFILE(OUTFILE3))
u_out_fmap03(
./*input 	 */clk(clk),
./*input 	 */rstn(rstn),
./*input[7:0]*/din(acc_o[3][19:12]),
./*input 	 */vld(vld_o[3]),
./*output    */frame_done(frame_done[3])
);

bmp_image_writer #(.OUTFILE(OUTFILE4))
u_out_fmap04(
./*input 	 */clk(clk),
./*input 	 */rstn(rstn),
./*input[7:0]*/din(acc_o[4][19:12]),
./*input 	 */vld(vld_o[4]),
./*output    */frame_done(frame_done[4])
);

bmp_image_writer #(.OUTFILE(OUTFILE5))
u_out_fmap05(
./*input 	 */clk(clk),
./*input 	 */rstn(rstn),
./*input[7:0]*/din(acc_o[5][19:12]),
./*input 	 */vld(vld_o[5]),
./*output    */frame_done(frame_done[5])
);

bmp_image_writer #(.OUTFILE(OUTFILE6))
u_out_fmap06(
./*input 	 */clk(clk),
./*input 	 */rstn(rstn),
./*input[7:0]*/din(acc_o[6][19:12]),
./*input 	 */vld(vld_o[6]),
./*output    */frame_done(frame_done[6])
);

bmp_image_writer #(.OUTFILE(OUTFILE7))
u_out_fmap07(
./*input 	 */clk(clk),
./*input 	 */rstn(rstn),
./*input[7:0]*/din(acc_o[7][19:12]),
./*input 	 */vld(vld_o[7]),
./*output    */frame_done(frame_done[7])
);

bmp_image_writer #(.OUTFILE(OUTFILE8))
u_out_fmap08(
./*input 	 */clk(clk),
./*input 	 */rstn(rstn),
./*input[7:0]*/din(acc_o[8][19:12]),
./*input 	 */vld(vld_o[8]),
./*output    */frame_done(frame_done[8])
);

bmp_image_writer #(.OUTFILE(OUTFILE9))
u_out_fmap09(
./*input 	 */clk(clk),
./*input 	 */rstn(rstn),
./*input[7:0]*/din(acc_o[9][19:12]),
./*input 	 */vld(vld_o[9]),
./*output    */frame_done(frame_done[9])
);

bmp_image_writer #(.OUTFILE(OUTFILE10))
u_out_fmap10(
./*input 	 */clk(clk),
./*input 	 */rstn(rstn),
./*input[7:0]*/din(acc_o[10][19:12]),
./*input 	 */vld(vld_o[10]),
./*output    */frame_done(frame_done[10])
);

bmp_image_writer #(.OUTFILE(OUTFILE11))
u_out_fmap11(
./*input 	 */clk(clk),
./*input 	 */rstn(rstn),
./*input[7:0]*/din(acc_o[11][19:12]),
./*input 	 */vld(vld_o[11]),
./*output    */frame_done(frame_done[11])
);

bmp_image_writer #(.OUTFILE(OUTFILE12))
u_out_fmap12(
./*input 	 */clk(clk),
./*input 	 */rstn(rstn),
./*input[7:0]*/din(acc_o[12][19:12]),
./*input 	 */vld(vld_o[12]),
./*output    */frame_done(frame_done[12])
);

bmp_image_writer #(.OUTFILE(OUTFILE13))
u_out_fmap13(
./*input 	 */clk(clk),
./*input 	 */rstn(rstn),
./*input[7:0]*/din(acc_o[13][19:12]),
./*input 	 */vld(vld_o[13]),
./*output    */frame_done(frame_done[13])
);

bmp_image_writer #(.OUTFILE(OUTFILE14))
u_out_fmap14(
./*input 	 */clk(clk),
./*input 	 */rstn(rstn),
./*input[7:0]*/din(acc_o[14][19:12]),
./*input 	 */vld(vld_o[14]),
./*output    */frame_done(frame_done[14])
);

bmp_image_writer #(.OUTFILE(OUTFILE15))
u_out_fmap15(
./*input 	 */clk(clk),
./*input 	 */rstn(rstn),
./*input[7:0]*/din(acc_o[15][19:12]),
./*input 	 */vld(vld_o[15]),
./*output    */frame_done(frame_done[15])
);






endmodule