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

   // for testbech
   //wire                biu_icu_ack;
   reg                biu_icu_ack;
   //wire                biu_icu_data_valid;
   reg                biu_icu_data_valid;
   //wire                biu_icu_data_last;
   reg                biu_icu_data_last;
   //wire [63:0]         biu_icu_data;
   reg [63:0]         biu_icu_data;
   wire                biu_icu_fault;


   // tmp
   //assign icu_biu_req = 1'b0;
   //assign icu_biu_addr = 'h0;
   //assign icu_biu_single = 1'b0;

   //assign biu_icu_ack = 1'b0;
   //assign biu_icu_data_valid = 1'b0;
   //assign biu_icu_data_last = 1'b0;
   //assign biu_icu_data = 'h0;
   assign biu_icu_fault = 1'b0;


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

endmodule

