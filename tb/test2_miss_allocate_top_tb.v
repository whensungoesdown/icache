
`timescale 1ns / 1ps
//`timescale 1ns / 1ns

module top_tb(
   );

   reg clk;
   reg resetn;

   wire [31:0]        addr;

   reg                ifu_icu_req_ic1;
   reg [31:3]         ifu_icu_addr_ic1;

   wire               icu_ifu_ack_ic1;

   // ic2
   wire               icu_ifu_data_valid_ic2;
   wire [63:0]        icu_ifu_data_ic2;

   
   assign addr = 'h00010100;

   reg flag;

   initial
      begin
	 $display("Start ...");
	 clk = 1'b1;
	 resetn = 1'b0;
	 ifu_icu_req_ic1 = 1'b0;
	 ifu_icu_addr_ic1 = 'h0;
 
	 //u_top.biu_icu_ack <= 1'b0;
	 //u_top.biu_icu_data_last <= 1'b0;
	 //u_top.biu_icu_data_valid <= 1'b0;

	 flag = 1'b0;
	 
	 resetn <= #32 1'b1;

	 //#8;
	 ifu_icu_req_ic1 <= #40 1'b1;
	 //ifu_icu_addr_ic1 <= #40 addr[31:3]; // addr is x at the this moment, dont know why
	 ifu_icu_addr_ic1 <= #40 'h2021;

	 //#10;
	 ifu_icu_req_ic1 <= #50 1'b0;
	 ifu_icu_addr_ic1 <= #50 'h0;
	 
      end

   always #5 clk=~clk;
   

   top u_top (
      .clk                     (clk                    ),
      .resetn                  (resetn                 ),

      .ifu_icu_req_ic1         (ifu_icu_req_ic1        ),
      .ifu_icu_addr_ic1        (ifu_icu_addr_ic1       ),
                                                      
      .icu_ifu_ack_ic1         (icu_ifu_ack_ic1        ),
                                                      
      .icu_ifu_data_valid_ic2  (icu_ifu_data_valid_ic2 ),
      .icu_ifu_data_ic2        (icu_ifu_data_ic2       )

      );

   always @(posedge clk)
      begin
	 $display("+");
	 $display("reset %b", resetn);

         // a trick of using flag to make biu_icu_ack only be signaled for 1 cycle
//	 if (1'b1 == u_top.icu_biu_req && flag == 1'b0) 
//	 begin
//		u_top.biu_icu_ack <= 1'b1;
//		flag = 1'b1;
//		u_top.biu_icu_ack <= #10 1'b0;
//         end

	 if (1'b1 == u_top.biu_icu_ack) 
	 begin
//		u_top.biu_icu_data <= 'hbbbbbbbbbbbbbbbb;		 
//		u_top.biu_icu_data_valid <= 1'b1;
//		u_top.biu_icu_data_valid <= #10 1'b0;
//
//		u_top.biu_icu_data <= #20 'hcccccccccccccccc;		 
//		u_top.biu_icu_data_valid <= #20 1'b1;
//		u_top.biu_icu_data_valid <= #30 1'b0;
//
//		u_top.biu_icu_data <= #40 'hdddddddddddddddd;		 
//		u_top.biu_icu_data_valid <= #40 1'b1;
//		u_top.biu_icu_data_valid <= #50 1'b0;
//
//		u_top.biu_icu_data <= #60 'heeeeeeeeeeeeeeee;		 
//		u_top.biu_icu_data_valid <= #60 1'b1;
//		u_top.biu_icu_data_valid <= #70 1'b0;
//		u_top.biu_icu_data_last <= #60 1'b1;
//		u_top.biu_icu_data_last <= #70 1'b0;



		// query icache again
	 	ifu_icu_req_ic1 <= #150 1'b1;
	 	//ifu_icu_addr_ic1 <= #40 addr[31:3]; // addr is x at the this moment, dont know why
	 	ifu_icu_addr_ic1 <= #150 'h2022;

	 	//#10;
	 	ifu_icu_req_ic1 <= #160 1'b0;
	 	ifu_icu_addr_ic1 <= #160 'h0;
		flag <= #160 1'b0;
         end


	 // icache request after cacheline allocation, the cache line should be valid
	 if (1'b1 == u_top.icu_ifu_data_valid_ic2 &&
	     64'hdddddddddddddddd === icu_ifu_data_ic2 
            )
	 begin
		 $display("\nPASS!\n");
		 $display("\033[0;32m");
                 $display("**************************************************");
                 $display("*                                                *");
                 $display("*      * * *       *        * * *     * * *      *");
                 $display("*      *    *     * *      *         *           *");
                 $display("*      * * *     *   *      * * *     * * *      *");
                 $display("*      *        * * * *          *         *     *");
                 $display("*      *       *       *    * * *     * * *      *");
                 $display("*                                                *");
                 $display("**************************************************");
                 $display("\n");
                 $display("\033[0m");
		 $finish;
	 end
	 //else
	 //begin
	 //        $display("\nFAIL!\n");
	 //        $display("\033[0;31m");
         //        $display("**************************************************");
         //        $display("*                                                *");
         //        $display("*      * * *       *         ***      *          *");
         //        $display("*      *          * *         *       *          *");
         //        $display("*      * * *     *   *        *       *          *");
         //        $display("*      *        * * * *       *       *          *");
         //        $display("*      *       *       *     ***      * * *      *");
         //        $display("*                                                *");
         //        $display("**************************************************");
         //        $display("\n");
         //        $display("\033[0m");
	 //        $finish;
	 //end

      end

   always @(negedge clk)
      begin
	 $display("-");
	 $display("reset %b", resetn);


       end	



   
endmodule // top_tb
