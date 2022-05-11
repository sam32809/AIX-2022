`timescale 1ns / 1ps

module max_pooling(
    	input clk,
	input [21:0] input1,
	input [21:0] input2,
	input [21:0] input3,
	input [21:0] input4,
	input enable,
    	output reg signed [21:0] output1,
	output reg maxpooling_done
    );
	 
	 reg [7:0] inputArray [0:7];
	
	reg [21:0] initial_Max = 22'b1000000000000000000000;
	reg [21:0] tempOutput;
	
	always @ (posedge clk) begin
		if(enable) begin
			if($signed(initial_Max) < $signed(input1)) begin
				if($signed(input2) < $signed(input1)) begin
					if($signed(input3) < $signed(input1)) begin
						if($signed(input4) < $signed(input1)) begin
							output1 <= input1;
							maxpooling_done <= 1;
						end
						else begin
							output1 <= input4;
							maxpooling_done <= 1;
						end
					end
					else begin
						if($signed(input3) < $signed(input4)) begin
							output1 <= input4;
							maxpooling_done <= 1;
						end
						else begin
							output1 <= input3;
							maxpooling_done <= 1;
						end
					end
				end
				else begin
					if($signed(input3) < $signed(input2)) begin
						if($signed(input4) < $signed(input2)) begin
							output1 <= input2;
							maxpooling_done <= 1;
						end
						else begin
							output1 <= input4;
							maxpooling_done <= 1;
						end
					end
					else begin
						if($signed(input3) < $signed(input4)) begin
							output1 <= input4;
							maxpooling_done <= 1;
						end
						else begin
							output1 <= input3;
							maxpooling_done <= 1;
						end
					end
				end
			end
			else begin
				output1 <= initial_Max;
				maxpooling_done <= 1;
			end
		end
		else begin
			output1 <= 0;
			maxpooling_done <= 0;
		end
	end


endmodule
