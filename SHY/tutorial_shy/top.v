module top(

      input clk,
      input rstn,	  
      input                ena;   // write enable port 0
	  
      //Write address channel
      input   [I-1:0]     AWID,       // Address ID
      input   [A-1:0]     AWADDR,     // Address Write
      input   [L-1:0]     AWLEN,      // Transfer length
      input   [2:0]       AWSIZE,     // Transfer width
      input   [1:0]       AWBURST,    // Burst type
      input   [1:0]       AWLOCK,     // Atomic access information
      input   [3:0]       AWCACHE,    // Cachable/bufferable infor
      input   [2:0]       AWPROT,     // Protection info
      input               AWVALID,    // address/control valid handshake
      
      //Write data channel
      input   [I-1:0]     WID,        // Write ID
      input   [D-1:0]     WDATA,      // Write Data bus
      input   [M-1:0]     WSTRB,      // Write Data byte lane strobes
      input               WLAST,      // Last beat of a burst transfer
      input               WVALID,     // Write data valid
      
      //Write response channel
      input               BREADY,     // Response info ready (from Master)
      //Read address channel
      input   [I-1:0]     ARID,       // Read addr ID
      input   [A-1:0]     ARADDR,     // Address Read 
      input   [L-1:0]     ARLEN,      // Transfer length
      input   [2:0]       ARSIZE,     // Transfer width
      input   [1:0]       ARBURST,    // Burst type
      input   [1:0]       ARLOCK,     // Atomic access information
      input   [3:0]       ARCACHE,    // Cachable/bufferable infor
      input   [2:0]       ARPROT,     // Protection info
      input               ARVALID,    // address/control valid handshake
	  
	  
      input               RREADY,     // Read data ready (from Master) 

      input  [WL_ADDR-1:0] addr;  // read/write address port 0
      input  [WL_DATA-1:0] wdata; // write data port 0


      input  [MEM_DW-1:0] mem_do    // Read data from Imem



      input [W_SIZE-1 :0] q_width;
      input [W_SIZE-1 :0] q_height;
      input [W_DELAY-1:0] q_vsync_delay;
      input [W_DELAY-1:0] q_hsync_delay;
      input [W_FRAME_SIZE-1:0] q_frame_size;
      input q_start;


);

parameter WIDTH 	= 128;
parameter HEIGHT 	= 128;
localparam FRAME_SIZE = WIDTH * HEIGHT;
localparam FRAME_SIZE_W = $clog2(FRAME_SIZE);
parameter Ti = 9;	// Each CONV kernel do 9 multipliers at the same time	
parameter To = 16;	// Run 16 CONV kernels at the same time
parameter WI = 8;
parameter PARAM_BITS 	= 16;
parameter ACT_BITS		= 8;

// Block ram for weights
parameter N_DELAY 	    = 1;	
parameter N_CELL  		= 16;
parameter N_CELL_PARAM	= 16;
parameter W_CELL 		= $clog2(N_CELL);
parameter W_CELL_PARAM 	= $clog2(N_CELL_PARAM);	

reg [Ti*WI-1:0] win[0:To-1];			// Weight
reg [PARAM_BITS-1:0] scale[0:To-1];		// Scales (Batch normalization)
reg [PARAM_BITS-1:0] bias[0:To-1];		// Biases

//여기서부터 controller 전까진 몰루
localparam MEM_ADDRW = 22;
localparam MEM_DW = 8;
localparam A = 32;
localparam D = 32;
localparam I = 4;
localparam L = 8;
localparam M = D/8;

/*
//AXI Master IF0 for input/out access
wire  [I-1:0]     i_AWID;       // Address ID
wire  [A-1:0]     i_AWADDR;     // Address Write
wire  [L-1:0]     i_AWLEN;      // Transfer length
wire  [2:0]       i_AWSIZE;     // Transfer width
wire  [1:0]       i_AWBURST;    // Burst type
wire  [1:0]       i_AWLOCK;     // Atomic access information
wire  [3:0]       i_AWCACHE;    // Cachable/bufferable infor
wire  [2:0]       i_AWPROT;     // Protection info
wire              i_AWVALID;    // address/control valid handshake
wire              i_AWREADY;
wire  [I-1:0]     i_WID;        // Write ID
wire  [D-1:0]     i_WDATA;      // Write Data bus
wire  [M-1:0]     i_WSTRB;      // Write Data byte lane strobes
wire              i_WLAST;      // Last beat of a burst transfer
wire              i_WVALID;     // Write data valid
wire              i_WREADY;     // Write data ready
wire [I-1:0]      i_BID;        // buffered response ID
wire [1:0]        i_BRESP;      // Buffered write response
wire              i_BVALID;     // Response info valid
wire              i_BREADY;     // Response info ready (to slave)
wire  [I-1:0]     i_ARID;       // Read addr ID
wire  [A-1:0]     i_ARADDR;     // Address Read 
wire  [L-1:0]     i_ARLEN;      // Transfer length
wire  [2:0]       i_ARSIZE;     // Transfer width
wire  [1:0]       i_ARBURST;    // Burst type
wire  [1:0]       i_ARLOCK;     // Atomic access information
wire  [3:0]       i_ARCACHE;    // Cachable/bufferable infor
wire  [2:0]       i_ARPROT;     // Protection info
wire              i_ARVALID;    // address/control valid handshake
wire              i_ARREADY;
wire  [I-1:0]     i_RID;        // Read ID
wire  [D-1:0]     i_RDATA;      // Read data bus
wire  [1:0]       i_RRESP;      // Read response
wire              i_RLAST;      // Last beat of a burst transfer
wire              i_RVALID;     // Read data valid 
wire              i_RREADY;     // Read data ready (to Slave)
*/

// Memory ports for input (activation)
wire [MEM_ADDRW-1:0]   mem_addr;
wire                   mem_we;
wire [MEM_DW-1:0]      mem_di;
wire [MEM_DW-1:0]      mem_do;

//--------------------------------------------------------------------------------
//AXI Slave External Memory: Input
//--------------------------------------------------------------------------------
axi_sram_if #(  //New
   .MEM_ADDRW(MEM_ADDRW), .MEM_DW(MEM_DW),
   .A(A), .I(I), .L(L), .D(D), .M(M))
u_axi_ext_mem_if_input(
   .ACLK(clk), .ARESETn(rstn),

   //AXI Slave IF
   .ARID    (ARID),   // Read addr ID
   .ARADDR  (ARADDR),   // Address Read 
   .ARLEN   (ARLEN),   // Transfer length
   .ARSIZE  (ARSIZE),   // Transfer width
   .ARBURST (ARBURST),   // Burst type
   .ARLOCK  (ARLOCK),   // Atomic access information
   .ARCACHE (ARCACHE),   // Cachable/bufferable infor
   .ARPROT  (ARPROT),   // Protection info
   .ARVALID (ARVALID),   // address/control valid handshake
   .ARREADY (ARREADY),
   .RID     (RID),   // Read ID
   .RDATA   (RDATA),   // Read data bus
   .RRESP   (RRESP),   // Read response
   .RLAST   (RLAST),   // Last beat of a burst transfer
   .RVALID  (RVALID),   // Read data valid 
   .RREADY  (RREADY),   // Read data ready (to Slave)

   //Interface to SRAM 
   .mem_addr   (mem_addr),
   .mem_we     (mem_we),
   .mem_di     (mem_di),
   .mem_do     (mem_do)
);

//------------------------------------------------------------------------------------
// Input
//IMEM for SIM
// Inputs
/*
sram #(
   .FILE_NAME(INFILE),
   .SIZE(2**MEM_ADDRW),
   .WL_ADDR(MEM_ADDRW),
   .WL_DATA(MEM_DW))
u_ext_mem_input (
   .clk   (clk),
   .rst   (rstn),
   .addr  (mem_addr),
   .wdata (mem_di),
   .rdata (mem_do),
   .ena   (1'b0)     // Read only
   );
*/  
  
//--------------------------------------------------------------------------------
//AXI Slave External Memory: Output
//--------------------------------------------------------------------------------
axi_sram_if #(  //New
   .MEM_ADDRW(MEM_ADDRW), .MEM_DW(MEM_DW),
   .A(A), .I(I), .L(L), .D(D), .M(M))
u_axi_ext_mem_if_output (
   .ACLK(clk), .ARESETn(rstn),

   //AXI Slave IF
   .AWID    (AWID),       // Address ID
   .AWADDR  (AWADDR),     // Address Write
   .AWLEN   (AWLEN),      // Transfer length
   .AWSIZE  (AWSIZE),    // Transfer width
   .AWBURST (AWBURST),   // Burst type
   .AWLOCK  (AWLOCK),   // Atomic access information
   .AWCACHE (AWCACHE),   // Cachable/bufferable infor
   .AWPROT  (AWPROT),   // Protection info
   .AWVALID (AWVALID),   // address/control valid handshake
   .AWREADY (AWREADY),
   .WID     (WID),   // Write ID
   .WDATA   (WDATA),   // Write Data bus
   .WSTRB   (WSTRB),   // Write Data byte lane strobes
   .WLAST   (WLAST),   // Last beat of a burst transfer
   .WVALID  (WVALID),   // Write data valid
   .WREADY  (WREADY),    // Write data ready
   .BID     (BID),   // buffered response ID
   .BRESP   (BRESP),   // Buffered write response
   .BVALID  (BVALID),   // Response info valid
   .BREADY  (BREADY),   // Response info ready (to slave)

   //Interface to SRAM 
   .mem_addr   (mem_w_addr),
   .mem_we     (mem_w_we),
   .mem_di     (mem_w_di),
   .mem_do     (mem_w_do)
);

// Outputs
sram #(
   .SIZE(2**MEM_ADDRW),
   .WL_ADDR(MEM_ADDRW),
   .WL_DATA(MEM_DW))
u_ext_mem_output (
   .clk   (clk),
   .rst   (resetn),
   .addr  (mem_w_addr),
   .wdata (mem_w_di),
   .rdata (mem_w_do),
   .ena   (mem_w_we)
   );

//controller

parameter W_SIZE  = 12;					// Max 4K QHD (3840x1920).
parameter W_FRAME_SIZE  = 2 * W_SIZE + 1;	// Max 4K QHD (3840x1920).
parameter W_DELAY = 12;
parameter VSYNC_DELAY = 150;
parameter HSYNC_DELAY = 150;


wire 			     ctrl_vsync_run;
wire [W_DELAY-1:0]	 ctrl_vsync_cnt;
wire 				 ctrl_hsync_run;
wire [W_DELAY-1:0]	 ctrl_hsync_cnt;
wire 				 ctrl_data_run;
wire [W_SIZE-1:0] 	 row;
wire [W_SIZE-1:0] 	 col;
wire [W_FRAME_SIZE-1:0]data_count;
wire end_frame;


cnn_ctrl u_cnn_ctrl(
.clk(clk),
.rstn(rstn),
// Inputs
.q_width(q_width),
.q_height(q_height),
.q_vsync_delay(q_vsync_delay),
.q_hsync_delay(q_hsync_delay),
.q_frame_size(q_frame_size),
.q_start(q_start),
//output
.o_ctrl_vsync_run(ctrl_vsync_run),
.o_ctrl_vsync_cnt(ctrl_vsync_cnt),
.o_ctrl_hsync_run(ctrl_hsync_run),
.o_ctrl_hsync_cnt(ctrl_hsync_cnt),
.o_ctrl_data_run(ctrl_data_run),
.o_row(row),
.o_col(col),
.o_data_count(data_count),
.o_end_frame(end_frame)
);

//line loader
line_loader #(
    .AXI_WIDTH_AD(A),
    .AXI_WIDTH_ID(4),
    .AXI_WIDTH_DA(D),
    .AXI_WIDTH_DS(M),
    .AXI_LITE_WIDTH_AD(8),        // axi lite address width
    .AXI_LITE_WIDTH_DA(32),        // axi lite data width
    .AXI_LITE_WIDTH_DS(4) // data strobe width
)
u_line_loader
 (
    .ap_clk(clk),
    .ap_rst_n(rstn),
    // AXI MASTER 
    .m_axi_memory_bus_AWVALID(AWVALID),
    .m_axi_memory_bus_AWREADY(AWREADY),
    .m_axi_memory_bus_AWADDR(AWADDR),
    .m_axi_memory_bus_AWID(AWID),
    .m_axi_memory_bus_AWLEN(AWLEN),
    .m_axi_memory_bus_AWSIZE(AWSIZE),
    .m_axi_memory_bus_AWBURST(AWBURST),
    .m_axi_memory_bus_AWLOCK(AWLOCK),
    .m_axi_memory_bus_AWCACHE(AWCACHE),
    .m_axi_memory_bus_AWPROT(AWPROT),
    .m_axi_memory_bus_AWQOS(), // AWQOS unused
    .m_axi_memory_bus_AWREGION(), // AWREGION unused
    .m_axi_memory_bus_AWUSER(), // AWUSER unused
    .m_axi_memory_bus_WVALID(WVALID),
    .m_axi_memory_bus_WREADY(WREADY),
    .m_axi_memory_bus_WDATA(WDATA),
    .m_axi_memory_bus_WSTRB(WSTRB),
    .m_axi_memory_bus_WLAST(WLAST),
    .m_axi_memory_bus_WID(WID),
    .m_axi_memory_bus_WUSER(), // WUSER unused
    .m_axi_memory_bus_ARVALID(ARVALID),
    .m_axi_memory_bus_ARREADY(ARREADY),
    .m_axi_memory_bus_ARADDR(ARADDR),
    .m_axi_memory_bus_ARID(ARID),
    .m_axi_memory_bus_ARLEN(ARLEN),
    .m_axi_memory_bus_ARSIZE(ARSIZE),
    .m_axi_memory_bus_ARBURST(ARBURST),
    .m_axi_memory_bus_ARLOCK(ARLOCK),
    .m_axi_memory_bus_ARCACHE(ARCACHE),
    .m_axi_memory_bus_ARPROT(ARPROT),
    .m_axi_memory_bus_ARQOS(), // ARQOS unused
    .m_axi_memory_bus_ARREGION(), // ARREGION unused
    .m_axi_memory_bus_ARUSER(), // ARUSER unused
    .m_axi_memory_bus_RVALID(RVALID),
    .m_axi_memory_bus_RREADY(RREADY),
    .m_axi_memory_bus_RDATA(RDATA),
    .m_axi_memory_bus_RLAST(RLAST),
    .m_axi_memory_bus_RID(RID),
    .m_axi_memory_bus_RUSER(), // RUSER unused
    .m_axi_memory_bus_RRESP(RRESP),
    .m_axi_memory_bus_BVALID(BVALID),
    .m_axi_memory_bus_BREADY(BREADY),
    .m_axi_memory_bus_BRESP(BRESP),
    .m_axi_memory_bus_BID(BID),
    .m_axi_memory_bus_BUSER(), // BUSER unused
    
    .o_ctrl_vsync_run(ctrl_vsync_run),
    .o_ctrl_hsync_run(ctrl_hsync_run),
    .img(img),
    .load_start(load_start),
    .load_done(load_done)
);



//convultion calculation
cnv cnv0(
./*input[11:0]					*/row(row),
./*input[11:0]					*/col(col),
./*input[To*Ti-1:0]				*/weight(weight),
./*input[8*WIDTH*HEIGHT-1:0]	*/img(img),
./*output[ACT_BITS*To-1:0]		*/all_acc_o(all_acc),
./*output						*/v_o(v_o)
);

//memory control
// Weight/bias/scale buffer's signals
// weight
reg 			     weight_buf_en; 	   // primary enable
reg 			     weight_buf_en_d; 	   // primary enable
reg 			     weight_buf_en_2d; 	   // primary enable
reg 			     weight_buf_we; 	   // primary synchronous write enable
reg [W_CELL-1:0]     weight_buf_addr;      // address for read/write
reg [W_CELL-1:0]     weight_buf_addr_d;	   // 1-cycle delay address
reg [W_CELL-1:0]     weight_buf_addr_2d;   // 2-cycle delay address
wire[Ti*WI-1:0]      weight_buf_dout;      // Output for weights
// bias/scale
reg 			       param_buf_en; 	     // primary enable
reg 			       param_buf_en_d; 	     // primary enable
reg 			       param_buf_en_2d; 	     // primary enable
reg 			       param_buf_we; 	     // primary synchronous write enable
reg [W_CELL_PARAM-1:0] param_buf_addr;   	 // address for read/write
reg [W_CELL_PARAM-1:0] param_buf_addr_d;	 // 1-cycle delay address
reg [W_CELL_PARAM-1:0] param_buf_addr_2d;	 // 2-cycle delay address
wire[PARAM_BITS-1:0]   param_buf_dout_bias;  // Output for biases
wire[PARAM_BITS-1:0]   param_buf_dout_scale; // Output for scales

wire frame_done[0:To-1];
integer ch_idx;

// fmap buffer
reg [FRAME_SIZE_W-1:0] pixel_count;
reg layer_done;

// Weight
always@(*) begin
    weight_buf_en   = 1'b0;
    weight_buf_we   = 1'b0;
    weight_buf_addr = {W_CELL{1'b0}};
    if(ctrl_vsync_run) begin
        if(ctrl_vsync_cnt < To + 1) begin // 2 cycle delay spram : To + 1, 1 cycle delay spram : To
            weight_buf_en   = 1'b1;
            weight_buf_we   = 1'b0;
            weight_buf_addr = ctrl_vsync_cnt[W_CELL-1:0];
        end
    end
end

// Scale/bias
always@(*) begin
    param_buf_en   = 1'b0;
    param_buf_we   = 1'b0;
    param_buf_addr = {W_CELL{1'b0}};
    if(ctrl_vsync_run) begin
        if(ctrl_vsync_cnt < To + 1) begin // 2 cycle delay spram : To + 1, 1 cycle delay spram : To
            param_buf_en   = 1'b1;
            param_buf_we   = 1'b0;
            param_buf_addr = ctrl_vsync_cnt[W_CELL-1:0];
        end
    end
end

// one-cycle, two_cycle delay
always@(posedge clk, negedge rstn)begin
    if(~rstn) begin
        weight_buf_en_d   <= 1'b0;
        weight_buf_en_2d   <= 1'b0;
        weight_buf_addr_d <= {W_CELL{1'b0}};	
        weight_buf_addr_2d <= {W_CELL{1'b0}};	
        param_buf_en_d 	  <= 1'b0;
        param_buf_en_2d 	  <= 1'b0;
        param_buf_addr_d  <= {W_CELL{1'b0}};
        param_buf_addr_2d  <= {W_CELL{1'b0}};
    end
    else begin		
        weight_buf_en_d   <= weight_buf_en; 
        weight_buf_en_2d   <= weight_buf_en_d; 
        weight_buf_addr_d <= weight_buf_addr;
        weight_buf_addr_2d <= weight_buf_addr_d;
        param_buf_en_d 	  <= param_buf_en;	 
        param_buf_en_2d 	  <= param_buf_en_d;	 
        param_buf_addr_d  <= param_buf_addr;
        param_buf_addr_2d  <= param_buf_addr_d;
    end
end


 // two_cycle delay
always@(posedge clk, negedge rstn)begin
    if(~rstn) begin
        for(ch_idx = 0; ch_idx <To; ch_idx=ch_idx+1) begin
            win[ch_idx]  <= {(Ti*WI){1'b0}};
            scale[ch_idx] <= {PARAM_BITS{1'b0}};
            bias[ch_idx] <= {PARAM_BITS{1'b0}};
        end
    end
    else begin
        // Weight
        if(weight_buf_en_2d)
            win[weight_buf_addr_2d] <= weight_buf_dout;
        // Scale/bias
        if(param_buf_en_2d) begin
            bias[param_buf_addr_2d] <= param_buf_dout_bias; 
            scale[param_buf_addr_2d] <= param_buf_dout_scale;
        end
    end
end

// Weight buffer
spram_wrapper_weight #(.DW(Ti*WI),.AW(W_CELL),.DEPTH(N_CELL))
u_buf_weight(
    .clk (clk            ), // Clock input
    .cs  (weight_buf_en  ), // RAM enable (select)
    .addr(weight_buf_addr), // Address input(word addressing)
    .wdata (/*unused*/     ), // Data input
    .we  (weight_buf_we  ), // Write enable
    .rdata (weight_buf_dout)  // Data output
);

// Bias buffer
spram_wrapper_bias #(.DW(PARAM_BITS),.AW(W_CELL),.DEPTH(N_CELL))
u_buf_bias(
    .clk (clk            ), // Clock input
    .cs  (param_buf_en  ), // RAM enable (select)
    .addr(param_buf_addr), // Address input(word addressing)
    .wdata (/*unused*/     ), // Data input
    .we  (param_buf_we  ), // Write enable
    .rdata (param_buf_dout_bias)  // Data output
);

// Scale buffer
spram_wrapper_scale #(.DW(PARAM_BITS),.AW(W_CELL),.DEPTH(N_CELL))
u_buf_scale(
    .clk (clk            ), // Clock input
    .cs  (param_buf_en  ), // RAM enable (select)
    .addr(param_buf_addr), // Address input(word addressing)
    .wdata (/*unused*/     ), // Data input
    .we  (param_buf_we  ), // Write enable
    .rdata (param_buf_dout_scale)  // Data output
);


//-------------------------------------------------
// Output buffers.
//-------------------------------------------------
// store the mac results
dpram_wrapper #(.DW(To*ACT_BITS), .AW(FRAME_SIZE_W),.DEPTH(FRAME_SIZE))
u_buf_fmap(
   .clk   (clk   ),
   .ena   (v_o), 
   .wea   (v_o), 
   .addra (pixel_count), 
   .enb   (layer_done),	// for read
   .addrb (addrb ),  // for read
   .dia   (all_acc_o), 
   .dob   (dob )   // for read
);


//-------------------------------------------------
// Update the output buffers.
//-------------------------------------------------
always@(posedge clk, negedge rstn) begin
    if(!rstn) begin
        pixel_count <= 0;
        layer_done <= 0;
    end else begin
        if(q_start) begin
            pixel_count <= 0;
            layer_done <= 0;			
        end
        else begin
            if(v_o) begin
                if(pixel_count == FRAME_SIZE-1) begin
                    pixel_count <= 0;
                    layer_done <= 1'b1;
                end
                else begin
                    pixel_count <= pixel_count + 1;
                end
            end
        end
    end
end









endmodule