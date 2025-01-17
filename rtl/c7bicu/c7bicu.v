module c7bicu
(
   input                 clk,
   input                 resetn,

   // ic1
   input                 ifu_icu_req_ic1,
   input  [31:3]         ifu_icu_addr_ic1,
   
   output                icu_ifu_ack_ic1,

   // ic2
   output                icu_ifu_data_valid_ic2,
   output [63:0]         icu_ifu_data_ic2,

   // outputs to tag RAMs
   output [1:0]          icu_ram_tag_en,
   output                icu_ram_tag_wr,
   output [9:0]          icu_ram_tag_addr,
   output [21:0]         icu_ram_tag_wdata0, // 22 bits: V, addr[31:11]
   output [21:0]         icu_ram_tag_wdata1, 

   // inputs from tag RAMs
   input  [21:0]         ram_icu_tag_rdata0,
   input  [21:0]         ram_icu_tag_rdata1,


   // outputs to data RAMs
   output [1:0]          icu_ram_data_en,
   output                icu_ram_data_wr,
   output [11:0]         icu_ram_data_addr0,
   output [11:0]         icu_ram_data_addr1,
   output [63:0]         icu_ram_data_wdata0,
   output [63:0]         icu_ram_data_wdata1,

   // inputs from data RAMs
   input  [63:0]         ram_icu_data_rdata0,
   input  [63:0]         ram_icu_data_rdata1,


   // interface with BIU
   output                icu_biu_req,
   output [31:3]         icu_biu_addr,
   output                icu_biu_single,

   input                 biu_icu_ack,
   input                 biu_icu_data_valid,
   input                 biu_icu_data_last,
   input  [63:0]         biu_icu_data,
   input                 biu_icu_fault

   );

   // icache allocation in progress
   wire ic_al_inprog;

   // not implemented yet
   assign ic_al_inprog = 1'b0;

   wire ic_hit_ic1;

   // cache lookup always granted immediately unless cacheline allocation
   assign icu_ifu_ack_ic1 = ~ic_al_inprog;

   wire [31:3] ic_lu_addr_ic2;

   dffrle_s #(29) ic_lu_addr_reg (
      .din   (ifu_icu_addr_ic1[31:3]),
      .en    (ifu_icu_req_ic1),
      .rst_l (resetn),
      .clk   (clk),
      .q     (ic_lu_addr_ic2),
      .se(), .si(), .so());


   //
   // itag
   //

   assign icu_ram_tag_addr[9:0] = ifu_icu_addr_ic1[14:5];
   assign icu_ram_tag_en = 2'b11;


   wire ic_tag_way0_v_ic2;
   wire ic_tag_way1_v_ic2;

   assign ic_tag_way0_v_ic2 = ram_icu_tag_rdata0[21];
   assign ic_tag_way1_v_ic2 = ram_icu_tag_rdata1[21];


   wire ic_tag_way0_match_ic2;
   wire ic_tag_way1_match_ic2;

   //compare tag with addr

   wire [31:11] tmp_tag; // convinence for checking the tag value
   assign tmp_tag = ifu_icu_addr_ic1[31:11];

   assign ic_tag_way0_match_ic2 = (ram_icu_tag_rdata0[20:0] == ic_lu_addr_ic2[31:11]) & ic_tag_way0_v_ic2;
   assign ic_tag_way1_match_ic2 = (ram_icu_tag_rdata1[20:0] == ic_lu_addr_ic2[31:11]) & ic_tag_way1_v_ic2;

   assign ic_hit_ic2 = ic_tag_way0_match_ic2 | ic_tag_way1_match_ic2;



   //
   // idata
   //
   
   assign icu_ram_data_addr0[11:0] = {ifu_icu_addr_ic1[14:5], ifu_icu_addr_ic1[4:3]};
   assign icu_ram_data_addr1[11:0] = {ifu_icu_addr_ic1[14:5], ifu_icu_addr_ic1[4:3]};

   // read all ways data out
   //assign icu_ram_data_en = {ic_tag_way1_match_ic2, ic_tag_way0_match_ic2};
   assign icu_ram_data_en = 2'b11; // read out both way of data

   assign icu_ifu_data_valid_ic2 = ic_tag_way0_match_ic2 | ic_tag_way1_match_ic2;

   assign icu_ifu_data_ic2 = ram_icu_data_rdata0 & {64{ic_tag_way0_match_ic2}} |
	                     ram_icu_data_rdata1 & {64{ic_tag_way1_match_ic2}};



   // Unused
   assign icu_ram_tag_wr = 1'b0;
   assign icu_ram_data_wr = 1'b0;

endmodule
   
