add wave -position end  result:/top_tb/clk
add wave -position end  result:/top_tb/resetn

add wave -divider

add wave -position end  result:/top_tb/addr
add wave -position end  result:/top_tb/icu_ifu_ack_ic1
add wave -position end  result:/top_tb/icu_ifu_data_ic2
add wave -position end  result:/top_tb/icu_ifu_data_valid_ic2
add wave -position end  result:/top_tb/ifu_icu_addr_ic1
add wave -position end  result:/top_tb/u_top/u_icu/ic_lu_addr_ic2
add wave -position end  result:/top_tb/ifu_icu_req_ic1

add wave -divider

add wave -position end  result:/top_tb/u_top/u_icu/icu_ram_tag_addr
add wave -position end  result:/top_tb/u_top/u_icu/icu_ram_tag_en
add wave -position end  result:/top_tb/u_top/u_icu/icu_ram_tag_wdata0
add wave -position end  result:/top_tb/u_top/u_icu/icu_ram_tag_wdata1
add wave -position end  result:/top_tb/u_top/u_icu/icu_ram_tag_wr
add wave -position end  result:/top_tb/u_top/u_icu/ram_icu_tag_rdata0
add wave -position end  result:/top_tb/u_top/u_icu/ram_icu_tag_rdata1

add wave -divider

add wave -position end  result:/top_tb/u_top/u_icu/icu_ram_data_addr0
add wave -position end  result:/top_tb/u_top/u_icu/icu_ram_data_addr1
add wave -position end  result:/top_tb/u_top/u_icu/icu_ram_data_en
add wave -position end  result:/top_tb/u_top/u_icu/icu_ram_data_wdata0
add wave -position end  result:/top_tb/u_top/u_icu/icu_ram_data_wdata1
add wave -position end  result:/top_tb/u_top/u_icu/icu_ram_data_wr
add wave -position end  result:/top_tb/u_top/u_icu/ram_icu_data_rdata0
add wave -position end  result:/top_tb/u_top/u_icu/ram_icu_data_rdata1

add wave -divider

add wave -position end  result:/top_tb/u_top/u_icu/ic_tag_way0_v_ic2
add wave -position end  result:/top_tb/u_top/u_icu/ic_tag_way0_match_ic2
add wave -position end  result:/top_tb/u_top/u_icu/ic_tag_way1_v_ic2
add wave -position end  result:/top_tb/u_top/u_icu/ic_tag_way1_match_ic2

add wave -divider

add wave -position end  result:/top_tb/u_top/u_icu/tmp_tag
add wave -position end  result:/top_tb/u_top/u_icu/ic_hit_ic2

add wave -divider

add wave -position end  result:/top_tb/u_top/u_cache_rams/icu_ram_data_en
add wave -position end  result:/top_tb/u_top/u_cache_rams/ram_icu_data_rdata0
add wave -position end  result:/top_tb/u_top/u_cache_rams/icu_ram_data_addr0
add wave -position end  result:/top_tb/u_top/u_cache_rams/u_idata0/q
add wave -position end  result:/top_tb/u_top/u_cache_rams/u_idata0/rdaddress
add wave -position end  result:/top_tb/u_top/u_cache_rams/u_idata0/rden

add wave -divider

add wave -position end  result:/top_tb/u_top/u_icu/ic_lu_addr_ic2
add wave -position end  result:/top_tb/u_top/u_icu/ifu_icu_addr_ic1
add wave -position end  result:/top_tb/u_top/u_icu/ifu_icu_req_ic1

add wave -divider

add wave -position end  result:/top_tb/u_top/u_icu/ic_hit_ic2
add wave -position end  result:/top_tb/u_top/u_icu/ic_miss_ic2
add wave -position end  result:/top_tb/u_top/u_icu/lf_inprog_in
add wave -position end  result:/top_tb/u_top/u_icu/lf_inprog_q
add wave -position end  result:/top_tb/u_top/u_icu/icu_biu_req
add wave -position end  result:/top_tb/u_top/u_icu/biu_icu_ack
add wave -position end  result:/top_tb/u_top/u_icu/biu_rd_busy
add wave -position end  result:/top_tb/u_top/u_icu/biu_icu_data
add wave -position end  result:/top_tb/u_top/u_icu/biu_icu_data_last
add wave -position end  result:/top_tb/u_top/u_icu/biu_icu_data_valid

add wave -divider

add wave -position end  result:/top_tb/u_top/u_icu/lfb0_in
add wave -position end  result:/top_tb/u_top/u_icu/lfb1_in
add wave -position end  result:/top_tb/u_top/u_icu/lfb2_in
add wave -position end  result:/top_tb/u_top/u_icu/lfb3_in
add wave -position end  result:/top_tb/u_top/u_icu/lfb0_q
add wave -position end  result:/top_tb/u_top/u_icu/lfb1_q
add wave -position end  result:/top_tb/u_top/u_icu/lfb2_q
add wave -position end  result:/top_tb/u_top/u_icu/lfb3_q
add wave -position end  result:/top_tb/u_top/u_icu/lfb_cnt_in
add wave -position end  result:/top_tb/u_top/u_icu/lfb_cnt_q
add wave -position end  result:/top_tb/u_top/u_icu/lu_inprog_in
add wave -position end  result:/top_tb/u_top/u_icu/lu_inprog_q

add wave -divider

add wave -position end  result:/top_tb/u_top/u_icu/ic_lfb_hit_data
add wave -position end  result:/top_tb/u_top/u_icu/ic_lfb_hit_data_valid

add wave -divider

add wave -position end  result:/top_tb/u_top/u_icu/biu_icu_data_last
add wave -position end  result:/top_tb/u_top/u_biu/u_axi_interface/ext_biu_r_last
add wave -position end  result:/top_tb/u_top/u_axi_ram_bridge/m_rlast
add wave -position end  result:/top_tb/u_top/u_axi_ram_bridge/busy
add wave -position end  result:/top_tb/u_top/u_axi_ram_bridge/m_arburst
add wave -position end  result:/top_tb/u_top/u_axi_ram_bridge/m_arburst_q
add wave -position end  result:/top_tb/u_top/u_axi_ram_bridge/ar_enter
add wave -position end  result:/top_tb/u_top/u_biu/arb_rd_burst
add wave -position end  result:/top_tb/u_top/u_biu/icu_biu_addr
add wave -position end  result:/top_tb/u_top/u_biu/icu_biu_req
add wave -position end  result:/top_tb/u_top/u_biu/icu_biu_single


add wave -divider

add wave -position end  result:/top_tb/u_top/u_axi_ram_bridge/m_araddr
add wave -position end  result:/top_tb/u_top/u_axi_ram_bridge/m_arburst
add wave -position end  result:/top_tb/u_top/u_axi_ram_bridge/m_arburst_q
add wave -position end  result:/top_tb/u_top/u_axi_ram_bridge/m_arcache
add wave -position end  result:/top_tb/u_top/u_axi_ram_bridge/m_arid
add wave -position end  result:/top_tb/u_top/u_axi_ram_bridge/m_arid_q
add wave -position end  result:/top_tb/u_top/u_axi_ram_bridge/m_arlen
add wave -position end  result:/top_tb/u_top/u_axi_ram_bridge/m_arlock
add wave -position end  result:/top_tb/u_top/u_axi_ram_bridge/m_arprot
add wave -position end  result:/top_tb/u_top/u_axi_ram_bridge/m_arready
add wave -position end  result:/top_tb/u_top/u_axi_ram_bridge/m_arsize
add wave -position end  result:/top_tb/u_top/u_axi_ram_bridge/m_arvalid

add wave -divider

add wave -position end  result:/top_tb/u_top/u_axi_ram_bridge/rd_burst_cnt_in
add wave -position end  result:/top_tb/u_top/u_axi_ram_bridge/rd_burst_cnt_q
add wave -position end  result:/top_tb/u_top/u_axi_ram_bridge/araddr_in
add wave -position end  result:/top_tb/u_top/u_axi_ram_bridge/araddr_q
add wave -position end  result:/top_tb/u_top/u_axi_ram_bridge/ram_raddr
add wave -position end  result:/top_tb/u_top/u_axi_ram_bridge/ram_rdata
add wave -position end  result:/top_tb/u_top/u_axi_ram_bridge/ram_ren
add wave -position end  result:/top_tb/u_top/u_axi_ram_bridge/m_rlast
add wave -position end  result:/top_tb/u_top/u_axi_ram_bridge/m_rvalid
add wave -position end  result:/top_tb/u_top/u_axi_ram_bridge/rdata_valid

add wave -divider

add wave -position end  result:/top_tb/u_top/ram/q
add wave -position end  result:/top_tb/u_top/ram/rdaddress
add wave -position end  result:/top_tb/u_top/ram/rden

add wave -divider
