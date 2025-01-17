
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

   initial
      begin
	 $display("Start ...");
	 clk = 1'b1;
	 resetn = 1'b0;
	 ifu_icu_req_ic1 = 1'b0;
	 ifu_icu_addr_ic1 = 'h0;
 
	 
	 resetn <= #32 1'b1;

	 //#8;
	 ifu_icu_req_ic1 <= #40 1'b1;
	 //ifu_icu_addr_ic1 <= #40 addr[31:3]; // addr is x at the this moment, dont know why
	 ifu_icu_addr_ic1 <= #40 'h2020;

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

	 if (1'b1 == u_top.icu_ifu_data_valid_ic2 &&
	     64'haaaaaaaaaaaaaaaa === icu_ifu_data_ic2 
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
