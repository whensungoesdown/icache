module c7bbiu(
   input               clk,
   input               resetn,

   // IFU Interface
   input               ifu_biu_rd_req,
   input  [31:0]       ifu_biu_rd_addr,
   input               ifu_biu_cancel,   
   
   output              biu_ifu_rd_ack,
   output              biu_ifu_data_valid,
   output [63:0]       biu_ifu_data,
   //output              biu_ifu_fault,


   // LSU Interface
   input               lsu_biu_rd_req,
   input  [31:0]       lsu_biu_rd_addr,

   output              biu_lsu_rd_ack, 
   output              biu_lsu_data_valid,
   output [63:0]       biu_lsu_data,

   input               lsu_biu_wr_aw_req,
   input  [31:0]       lsu_biu_wr_addr,
   input               lsu_biu_wr_w_req,
   input  [63:0]       lsu_biu_wr_data,
   input  [ 7:0]       lsu_biu_wr_strb,
   input               lsu_biu_wr_last,
  
   output              biu_lsu_wr_aw_ack, 
   output              biu_lsu_wr_w_ack, 
   output              biu_lsu_write_done,  

   //output              biu_lsu_fault,

   // ICU Interface
   input               icu_biu_req,
   input  [31:3]       icu_biu_addr,
   input               icu_biu_single,

   output              biu_icu_ack,
   output              biu_icu_data_valid,
   output              biu_icu_data_last,
   output [63:0]       biu_icu_data,
   output              biu_icu_fault,


   // AXI Read Address Channel
   input            ext_biu_ar_ready,
   output           biu_ext_ar_valid,
   output [3:0]     biu_ext_ar_id,
   output [31:0]    biu_ext_ar_addr,
   output [7:0]     biu_ext_ar_len,
   output [2:0]     biu_ext_ar_size,
   output [1:0]     biu_ext_ar_burst,
   output           biu_ext_ar_lock,
   output [3:0]     biu_ext_ar_cache,
   output [2:0]     biu_ext_ar_prot,

   // AXI Read Data Channel
   output           biu_ext_r_ready,
   input            ext_biu_r_valid,
   input  [3:0]     ext_biu_r_id,
   input  [63:0]    ext_biu_r_data,
   input            ext_biu_r_last,
   input  [1:0]     ext_biu_r_resp,

   // AXI Write address channel
   input            ext_biu_aw_ready,
   output           biu_ext_aw_valid,
   output [3:0]     biu_ext_aw_id,
   output [31:0]    biu_ext_aw_addr,
   output [7:0]     biu_ext_aw_len,
   output [2:0]     biu_ext_aw_size,
   output [1:0]     biu_ext_aw_burst,
   output           biu_ext_aw_lock,
   output [3:0]     biu_ext_aw_cache,
   output [2:0]     biu_ext_aw_prot,

   // AXI Write data channel
   input            ext_biu_w_ready,
   output           biu_ext_w_valid,
   output [3:0]     biu_ext_w_id,
   output [63:0]    biu_ext_w_data,
   output [7:0]     biu_ext_w_strb,
   output           biu_ext_w_last,

   // AXI Write response channel
   output           biu_ext_b_ready,
   input            ext_biu_b_valid,
   input  [3:0]     ext_biu_b_id   ,
   input  [1:0]     ext_biu_b_resp 
);

   wire                axi_ar_ready;

   wire                arb_rd_val;
   wire [3:0]          arb_rd_id;
   wire [31:0]         arb_rd_addr;
   wire [7:0]          arb_rd_len;
   wire [2:0]          arb_rd_size;
   wire [1:0]          arb_rd_burst;
   wire                arb_rd_lock;
   wire [3:0]          arb_rd_cache;
   wire [2:0]          arb_rd_prot;
   //wire                arb_rd_master;
   //wire                arb_rd_inner;
   //wire                arb_rd_share;


   wire                axi_aw_ready;
   wire                axi_w_ready;

   wire                arb_wr_aw_val; 
   wire [3:0]          arb_wr_aw_id;  
   wire [31:0]         arb_wr_aw_addr;
   wire [7:0]          arb_wr_aw_len; 
   wire [2:0]          arb_wr_aw_size;
   wire [1:0]          arb_wr_aw_burst;
   wire                arb_wr_aw_lock;
   wire [3:0]          arb_wr_aw_cache;
   wire [2:0]          arb_wr_aw_prot;

   wire                arb_wr_w_val; 
   wire [3:0]          arb_wr_w_id;
   wire [63:0]         arb_wr_w_data;
   wire [7:0]          arb_wr_w_strb;
   wire                arb_wr_w_last;

   // Read data from the AXI interface
   wire [63:0]         axi_rdata;
   wire                axi_rdata_ifu_val;
   wire                axi_rdata_ifu_val_qual;
   wire                axi_rdata_lsu_val; 
   wire                axi_rdata_icu_val;
   wire                axi_rdata_last;

   // Write data to the AXI interface
   wire                axi_write_lsu_val;


   c7bbiu_rd_arb u_read_arbiter(
      .clk             (clk             ),
      .resetn          (resetn          ),

      .axi_ar_ready    (axi_ar_ready    ),

      .ifu_biu_rd_req  (ifu_biu_rd_req  ),
      .biu_ifu_rd_ack  (biu_ifu_rd_ack  ),
      .ifu_biu_rd_addr (ifu_biu_rd_addr ),

      .lsu_biu_rd_req  (lsu_biu_rd_req  ),
      .biu_lsu_rd_ack  (biu_lsu_rd_ack  ),
      .lsu_biu_rd_addr (lsu_biu_rd_addr ),

      .icu_biu_req     (icu_biu_req     ),
      .biu_icu_ack     (biu_icu_ack     ),
      .icu_biu_addr    (icu_biu_addr    ),
      .icu_biu_single  (icu_biu_single  ),

      //.axi_rdata_ifu_val    (axi_rdata_ifu_val ),
      //.axi_rdata_lsu_val    (axi_rdata_lsu_val ),

      .arb_rd_val      (arb_rd_val      ), 
      .arb_rd_id       (arb_rd_id       ),
      .arb_rd_addr     (arb_rd_addr     ), 
      .arb_rd_len      (arb_rd_len      ),
      .arb_rd_size     (arb_rd_size     ),
      .arb_rd_burst    (arb_rd_burst    ),
      .arb_rd_lock     (arb_rd_lock     ),
      .arb_rd_cache    (arb_rd_cache    ),
      .arb_rd_prot     (arb_rd_prot     )
   );



   c7bbiu_wr_arb u_write_arbiter(
      .clk             (clk             ),
      .resetn          (resetn          ),

      .axi_aw_ready    (axi_aw_ready    ),
      .axi_w_ready     (axi_w_ready     ),

      // now, only one requester
      .lsu_biu_wr_aw_req (lsu_biu_wr_aw_req ),
      .biu_lsu_wr_aw_ack (biu_lsu_wr_aw_ack ),
      .lsu_biu_wr_w_req  (lsu_biu_wr_w_req  ),
      .biu_lsu_wr_w_ack  (biu_lsu_wr_w_ack  ),

      .lsu_biu_wr_addr (lsu_biu_wr_addr ),
      .lsu_biu_wr_data (lsu_biu_wr_data ),
      .lsu_biu_wr_strb (lsu_biu_wr_strb ),
      .lsu_biu_wr_last (lsu_biu_wr_last ),

      .arb_wr_aw_val   (arb_wr_aw_val   ), 
      .arb_wr_aw_id    (arb_wr_aw_id    ),
      .arb_wr_aw_addr  (arb_wr_aw_addr  ), 
      .arb_wr_aw_len   (arb_wr_aw_len   ),
      .arb_wr_aw_size  (arb_wr_aw_size  ),
      .arb_wr_aw_burst (arb_wr_aw_burst ),
      .arb_wr_aw_lock  (arb_wr_aw_lock  ),
      .arb_wr_aw_cache (arb_wr_aw_cache ),
      .arb_wr_aw_prot  (arb_wr_aw_prot  ),

      .arb_wr_w_val    (arb_wr_w_val    ), 
      .arb_wr_w_id     (arb_wr_w_id     ), 
      .arb_wr_w_data   (arb_wr_w_data   ),
      .arb_wr_w_strb   (arb_wr_w_strb   ),
      .arb_wr_w_last   (arb_wr_w_last   )
   );


   

   c7bbiu_axi_interface u_axi_interface(
      .clk             (clk          ),
      .resetn          (resetn       ),

      // Arbitrated read signals
      .arb_rd_val           (arb_rd_val        ), 
      .arb_rd_id            (arb_rd_id         ),
      .arb_rd_addr          (arb_rd_addr       ), 
      .arb_rd_burst         (arb_rd_burst      ),
      .arb_rd_len           (arb_rd_len        ),
      .arb_rd_size          (arb_rd_size       ),
      .arb_rd_lock          (arb_rd_lock       ),
      .arb_rd_cache         (arb_rd_cache      ),
      .arb_rd_prot          (arb_rd_prot       ),

      .axi_ar_ready         (axi_ar_ready      ),

      // AXI Read Address Channel
      .ext_biu_ar_ready	    (ext_biu_ar_ready  ),
      .biu_ext_ar_valid	    (biu_ext_ar_valid  ),
      .biu_ext_ar_id        (biu_ext_ar_id     ),
      .biu_ext_ar_addr      (biu_ext_ar_addr   ),
      .biu_ext_ar_len       (biu_ext_ar_len    ),
      .biu_ext_ar_size      (biu_ext_ar_size   ),
      .biu_ext_ar_burst     (biu_ext_ar_burst  ),
      .biu_ext_ar_lock      (biu_ext_ar_lock   ),
      .biu_ext_ar_cache     (biu_ext_ar_cache  ),
      .biu_ext_ar_prot      (biu_ext_ar_prot   ),

      // AXI Read Data Channel
      .biu_ext_r_ready      (biu_ext_r_ready   ),
      .ext_biu_r_valid      (ext_biu_r_valid   ),
      .ext_biu_r_id         (ext_biu_r_id      ),
      .ext_biu_r_data       (ext_biu_r_data    ),
      .ext_biu_r_last       (ext_biu_r_last    ),
      .ext_biu_r_resp       (ext_biu_r_resp    ),

      // Arbitrated write signals
      .arb_wr_aw_val        (arb_wr_aw_val     ),
      .arb_wr_aw_id         (arb_wr_aw_id      ),
      .arb_wr_aw_addr       (arb_wr_aw_addr    ),
      .arb_wr_aw_len        (arb_wr_aw_len     ),
      .arb_wr_aw_size       (arb_wr_aw_size    ),
      .arb_wr_aw_burst      (arb_wr_aw_burst   ),
      .arb_wr_aw_lock       (arb_wr_aw_lock    ),
      .arb_wr_aw_cache      (arb_wr_aw_cache   ),
      .arb_wr_aw_prot       (arb_wr_aw_prot    ),

      .axi_aw_ready         (axi_aw_ready      ),

      .arb_wr_w_val         (arb_wr_w_val      ),
      .arb_wr_w_id          (arb_wr_w_id       ),
      .arb_wr_w_data        (arb_wr_w_data     ),
      .arb_wr_w_strb        (arb_wr_w_strb     ),
      .arb_wr_w_last        (arb_wr_w_last     ),

      .axi_w_ready          (axi_w_ready       ),

      // AXI Write address channel
      .ext_biu_aw_ready     (ext_biu_aw_ready  ),
      .biu_ext_aw_valid     (biu_ext_aw_valid  ),
      .biu_ext_aw_id        (biu_ext_aw_id     ),
      .biu_ext_aw_addr      (biu_ext_aw_addr   ),
      .biu_ext_aw_len       (biu_ext_aw_len    ),
      .biu_ext_aw_size      (biu_ext_aw_size   ),
      .biu_ext_aw_burst     (biu_ext_aw_burst  ),
      .biu_ext_aw_lock      (biu_ext_aw_lock   ),
      .biu_ext_aw_cache     (biu_ext_aw_cache  ),
      .biu_ext_aw_prot      (biu_ext_aw_prot   ),

      // AXI Write data channel
      .ext_biu_w_ready      (ext_biu_w_ready   ),
      .biu_ext_w_valid      (biu_ext_w_valid   ),
      .biu_ext_w_id         (biu_ext_w_id      ),
      .biu_ext_w_data       (biu_ext_w_data    ),
      .biu_ext_w_strb       (biu_ext_w_strb    ),
      .biu_ext_w_last       (biu_ext_w_last    ),

      // AXI Write response channel
      .biu_ext_b_ready      (biu_ext_b_ready   ),
      .ext_biu_b_valid      (ext_biu_b_valid   ),
      .ext_biu_b_id         (ext_biu_b_id      ),
      .ext_biu_b_resp       (ext_biu_b_resp    ),

      // Read data from the AXI interface
      .axi_rdata            (axi_rdata         ), 
      .axi_rdata_ifu_val    (axi_rdata_ifu_val ),
      .axi_rdata_lsu_val    (axi_rdata_lsu_val ),
      .axi_rdata_icu_val    (axi_rdata_icu_val ),
      .axi_rdata_last       (axi_rdata_last    ), 

      // Write data to the AXI interface
      .axi_write_lsu_val    (axi_write_lsu_val )
   );


   //
   // ifu cancel(ignore) next coming data
   //

   wire ifu_cancel_q;

   dffrle_s #(1) ifu_cancel_reg (
      .din   (ifu_biu_cancel),
      .clk   (clk),
      .rst_l (resetn),
      .en    (ifu_biu_cancel | axi_rdata_ifu_val),
      .q     (ifu_cancel_q), 
      .se(), .si(), .so());

   assign axi_rdata_ifu_val_qual = axi_rdata_ifu_val & ~ifu_cancel_q;


   assign biu_ifu_data_valid = axi_rdata_ifu_val_qual;
   assign biu_ifu_data = axi_rdata;

   assign biu_lsu_data_valid = axi_rdata_lsu_val;
   assign biu_lsu_data = axi_rdata;

   assign biu_lsu_write_done = axi_write_lsu_val;

   assign biu_icu_data_valid = axi_rdata_icu_val;
   assign biu_icu_data = axi_rdata;
   assign biu_icu_data_last = axi_rdata_last;
   assign biu_icu_fault = 1'b0;
endmodule
