module top(
   input               clk,
   input               resetn,

   input               ifu_icu_req_ic1,
   input  [31:3]       ifu_icu_addr_ic1,
   
   output              icu_ifu_ack_ic1,

   // ic2
   output              icu_ifu_data_valid_ic2,
   output [63:0]       icu_ifu_data_ic2
   );

   // itag
   wire [1:0]          icu_ram_tag_en;
   wire                icu_ram_tag_wr;
   wire [9:0]          icu_ram_tag_addr;
   wire [21:0]         icu_ram_tag_wdata0; // 22 bits: V, addr[31:11]
   wire [21:0]         icu_ram_tag_wdata1; 

   wire [21:0]         ram_icu_tag_rdata0;
   wire [21:0]         ram_icu_tag_rdata1;

   // idata
   wire [1:0]          icu_ram_data_en;
   wire                icu_ram_data_wr;
   wire [11:0]         icu_ram_data_addr0;
   wire [11:0]         icu_ram_data_addr1;
   wire [63:0]         icu_ram_data_wdata0;
   wire [63:0]         icu_ram_data_wdata1;

   wire [63:0]         ram_icu_data_rdata0;
   wire [63:0]         ram_icu_data_rdata1;

   
   // interface with BIU
   wire                icu_biu_req;
   wire [31:3]         icu_biu_addr;
   wire                icu_biu_single;

   wire                biu_icu_ack;
   wire                biu_icu_data_valid;
   wire                biu_icu_data_last;
   wire [63:0]         biu_icu_data;
   wire                biu_icu_fault;




   //  biu
   //  axi_control
   //ar
   wire  [3:0]         arid;
   wire  [31:0]        araddr;
   wire  [7:0]         arlen;
   wire  [2:0]         arsize;
   wire  [1:0]         arburst;
   wire                arlock;
   wire  [3:0]         arcache;
   wire  [2:0]         arprot;
   wire                arvalid;
   wire                arready;
   //r
   wire  [3:0]         rid;
   wire  [63:0]        rdata;
   wire  [1:0]         rresp;
   wire                rlast;
   wire                rvalid;
   wire                rready;

   //aw
   wire [3:0]          awid;
   wire [31:0]         awaddr;
   wire [7:0]          awlen;
   wire [2:0]          awsize;
   wire [1:0]          awburst;
   wire                awlock;
   wire [3:0]          awcache;
   wire [2:0]          awprot;
   wire                awvalid;
   wire                awready;
   //w
   wire [3:0]          wid;
   wire [63:0]         wdata;
   wire [7:0]          wstrb;
   wire                wlast;
   wire                wvalid;
   wire                wready;
   //b
   wire [3:0]          bid;
   wire [1:0]          bresp;
   wire                bvalid;
   wire                bready;


   //ram
   wire [31:0]      ram_raddr;
   wire [63:0]      ram_rdata;
   wire             ram_ren;
   wire [31:0]      ram_waddr;
   wire [63:0]      ram_wdata;
   wire [7:0]       ram_wen;


   //
   wire             inst_req;
   wire [31:0]      inst_addr;
   wire             inst_cancel;

   wire             inst_ack;
   wire             inst_valid_f;
   wire [63:0]      inst_rdata_f;

   

   wire             lsu_biu_rd_req;
   wire [31:0]      lsu_biu_rd_addr;

   wire             biu_lsu_rd_ack;
   wire             biu_lsu_data_valid;
   wire [63:0]      biu_lsu_data;

   wire             lsu_biu_wr_req;
   wire [31:0]      lsu_biu_wr_addr;
   wire [63:0]      lsu_biu_wr_data;
   wire [7:0]       lsu_biu_wr_strb;

   wire             biu_lsu_write_done;


   wire biu_lsu_wr_aw_ack;
   wire biu_lsu_wr_w_ack;
   //

   c7bicu u_icu(
      .clk                         (clk                    ),
      .resetn                      (resetn                 ),

      .ifu_icu_req_ic1             (ifu_icu_req_ic1        ),
      .ifu_icu_addr_ic1            (ifu_icu_addr_ic1       ),
                                                          
      .icu_ifu_ack_ic1             (icu_ifu_ack_ic1        ),
                                                          
      .icu_ifu_data_valid_ic2      (icu_ifu_data_valid_ic2 ),
      .icu_ifu_data_ic2            (icu_ifu_data_ic2       ),


      .icu_ram_tag_en              (icu_ram_tag_en         ),
      .icu_ram_tag_wr              (icu_ram_tag_wr         ),
      .icu_ram_tag_addr            (icu_ram_tag_addr       ),
      .icu_ram_tag_wdata0          (icu_ram_tag_wdata0     ),
      .icu_ram_tag_wdata1          (icu_ram_tag_wdata1     ),
      .ram_icu_tag_rdata0          (ram_icu_tag_rdata0     ),
      .ram_icu_tag_rdata1          (ram_icu_tag_rdata1     ),

      .icu_ram_data_en             (icu_ram_data_en        ),
      .icu_ram_data_wr             (icu_ram_data_wr        ),
      .icu_ram_data_addr0          (icu_ram_data_addr0     ),
      .icu_ram_data_addr1          (icu_ram_data_addr1     ),
      .icu_ram_data_wdata0         (icu_ram_data_wdata0    ),
      .icu_ram_data_wdata1         (icu_ram_data_wdata1    ),
      .ram_icu_data_rdata0         (ram_icu_data_rdata0    ),
      .ram_icu_data_rdata1         (ram_icu_data_rdata1    ),


      .icu_biu_req                 (icu_biu_req            ),
      .icu_biu_addr                (icu_biu_addr           ),
      .icu_biu_single              (icu_biu_single         ),
                                                      
      .biu_icu_ack                 (biu_icu_ack            ),
      .biu_icu_data_valid          (biu_icu_data_valid     ),
      .biu_icu_data_last           (biu_icu_data_last      ),
      .biu_icu_data                (biu_icu_data           ),
      .biu_icu_fault               (biu_icu_fault          )

   );
   

   c7b_cache_rams u_cache_rams(
      .clk                         (clk                    ),

      .icu_ram_tag_en              (icu_ram_tag_en         ),
      .icu_ram_tag_wr              (icu_ram_tag_wr         ),
      .icu_ram_tag_addr            (icu_ram_tag_addr       ),
      .icu_ram_tag_wdata0          (icu_ram_tag_wdata0     ),
      .icu_ram_tag_wdata1          (icu_ram_tag_wdata1     ),
      .ram_icu_tag_rdata0          (ram_icu_tag_rdata0     ),
      .ram_icu_tag_rdata1          (ram_icu_tag_rdata1     ),

      .icu_ram_data_en             (icu_ram_data_en        ),
      .icu_ram_data_wr             (icu_ram_data_wr        ),
      .icu_ram_data_addr0          (icu_ram_data_addr0     ),
      .icu_ram_data_addr1          (icu_ram_data_addr1     ),
      .icu_ram_data_wdata0         (icu_ram_data_wdata0    ),
      .icu_ram_data_wdata1         (icu_ram_data_wdata1    ),
      .ram_icu_data_rdata0         (ram_icu_data_rdata0    ),
      .ram_icu_data_rdata1         (ram_icu_data_rdata1    )
   );


   // for testing purpose, set unused signals to 0s
   // addr with 32-bit, data width 64-bit
   assign inst_req = 1'b0;
   assign inst_addr = 32'b0;
   assign inst_cancel = 1'b0;

   assign lsu_biu_rd_req = 1'b0;
   assign lsu_biu_rd_addr = 32'b0;
   
   assign lsu_biu_wr_req = 1'b0;
   assign lsu_biu_wr_addr = 32'b0;
   assign lsu_biu_wr_data = 64'b0;
   assign lsu_biu_wr_strb = 8'b0;


   c7bbiu u_biu(
      .clk                (clk                  ),
      .resetn             (resetn               ),

      // IFU Interface
      .ifu_biu_rd_req     (inst_req             ),    
      .ifu_biu_rd_addr    (inst_addr            ),
      .ifu_biu_cancel     (inst_cancel          ),

      .biu_ifu_rd_ack     (inst_ack             ), 
      .biu_ifu_data_valid (inst_valid_f         ),
      .biu_ifu_data       (inst_rdata_f         ),


      // LSU Interface
      .lsu_biu_rd_req     (lsu_biu_rd_req       ),
      .lsu_biu_rd_addr    (lsu_biu_rd_addr      ),
                                             
      .biu_lsu_rd_ack     (biu_lsu_rd_ack       ), //
      .biu_lsu_data_valid (biu_lsu_data_valid   ),
      .biu_lsu_data       (biu_lsu_data         ),
                                             
      .lsu_biu_wr_aw_req  (lsu_biu_wr_req       ), // aw w are requested at the same time
      .lsu_biu_wr_addr    (lsu_biu_wr_addr      ),
      .lsu_biu_wr_w_req   (lsu_biu_wr_req       ),
      .lsu_biu_wr_data    (lsu_biu_wr_data      ),
      .lsu_biu_wr_strb    (lsu_biu_wr_strb      ),
      .lsu_biu_wr_last    (1'b1                 ),

      .biu_lsu_wr_aw_ack  (biu_lsu_wr_aw_ack    ), //
      .biu_lsu_wr_w_ack   (biu_lsu_wr_w_ack     ), //
      .biu_lsu_write_done (biu_lsu_write_done   ),

      // ICU Interface
      .icu_biu_req        (icu_biu_req          ),
      .icu_biu_addr       (icu_biu_addr         ),
      .icu_biu_single     (icu_biu_single       ),
                                             
      .biu_icu_ack        (biu_icu_ack          ),
      .biu_icu_data_valid (biu_icu_data_valid   ),
      .biu_icu_data_last  (biu_icu_data_last    ),
      .biu_icu_data       (biu_icu_data         ),
      .biu_icu_fault      (biu_icu_fault        ),
      

      // AXI Read Address Channel
      .ext_biu_ar_ready   (arready              ),
      .biu_ext_ar_valid   (arvalid              ),
      .biu_ext_ar_id      (arid                 ),
      .biu_ext_ar_addr    (araddr               ),
      .biu_ext_ar_len     (arlen                ),
      .biu_ext_ar_size    (arsize               ),
      .biu_ext_ar_burst   (arburst              ),
      .biu_ext_ar_lock    (arlock               ),
      .biu_ext_ar_cache   (arcache              ),
      .biu_ext_ar_prot    (arprot               ),

      // AXI Read Data Channel
      .biu_ext_r_ready    (rready               ),
      .ext_biu_r_valid    (rvalid               ),
      .ext_biu_r_id       (rid                  ),
      .ext_biu_r_data     (rdata                ),
      .ext_biu_r_last     (rlast                ),
      .ext_biu_r_resp     (rresp                ),

      // AXI Write address channel
      .ext_biu_aw_ready   (awready              ),
      .biu_ext_aw_valid   (awvalid              ),
      .biu_ext_aw_id      (awid                 ),
      .biu_ext_aw_addr    (awaddr               ),
      .biu_ext_aw_len     (awlen                ),
      .biu_ext_aw_size    (awsize               ),
      .biu_ext_aw_burst   (awburst              ),
      .biu_ext_aw_lock    (awlock               ),
      .biu_ext_aw_cache   (awcache              ),
      .biu_ext_aw_prot    (awprot               ),

      // AXI Write data channel
      .ext_biu_w_ready    (wready               ),
      .biu_ext_w_valid    (wvalid               ),
      .biu_ext_w_id       (wid                  ),
      .biu_ext_w_data     (wdata                ),
      .biu_ext_w_strb     (wstrb                ),
      .biu_ext_w_last     (wlast                ),

      // AXI Write response channel
      .biu_ext_b_ready    (bready               ),
      .ext_biu_b_valid    (bvalid               ),
      .ext_biu_b_id       (bid                  ),
      .ext_biu_b_resp     (bresp                ) 
   );


   axi_sram_bridge u_axi_ram_bridge(
      .aclk         (clk           ),
      .aresetn      (resetn            ),

      .ram_raddr    (ram_raddr         ),
      .ram_rdata    (ram_rdata         ),
      .ram_ren      (ram_ren           ),
      .ram_waddr    (ram_waddr         ),
      .ram_wdata    (ram_wdata         ),
      .ram_wen      (ram_wen           ),

      .m_awid       (awid            ),           
      .m_awaddr     (awaddr         ),
      .m_awlen      (awlen          ),
      .m_awsize     (awsize         ),
      .m_awburst    (awburst        ),
      .m_awlock     (awlock         ),
      .m_awcache    (awcache        ),
      .m_awprot     (awprot         ),
      .m_awvalid    (awvalid        ),
      .m_awready    (awready        ),
      .m_wid        (wid             ),
      .m_wdata      (wdata          ),
      .m_wstrb      (wstrb          ),
      .m_wlast      (wlast          ),
      .m_wvalid     (wvalid         ),
      .m_wready     (wready         ),
      .m_bid        (bid             ),
      .m_bresp      (bresp          ),
      .m_bvalid     (bvalid         ),
      .m_bready     (bready         ),
      
      .m_araddr     (araddr         ),
      .m_arburst    (arburst        ),
      .m_arcache    (arcache        ),
      .m_arid       (arid            ),
      .m_arlen      (arlen          ),
      .m_arlock     (arlock         ),
      .m_arprot     (arprot         ),
      .m_arready    (arready        ),
      .m_arsize     (arsize         ),
      .m_arvalid    (arvalid        ),

      .m_rdata      (rdata          ),
      .m_rid        (rid             ),
      .m_rlast      (rlast          ),
      .m_rready     (rready         ),
      .m_rresp      (rresp          ),
      .m_rvalid     (rvalid         ) 
      );


   sram ram(
      .clock        (clk         ),
      .rdaddress    (ram_raddr[15:3] ),
      .q            (ram_rdata       ),
      .rden         (ram_ren         ),
      .wraddress    (ram_waddr[15:3] ),
      .data         (ram_wdata       ),
      .byteena_a    (ram_wen         ),
      .wren         (|ram_wen        )
      );

endmodule

