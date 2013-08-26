#  Simulation Model Generator
#  Xilinx EDK 14.4 EDK_P.49d
#  Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
#
#  File     axi4lite_bus_list.do (Mon Jun 17 16:02:30 2013)
#
#  Module   bfm_system_axi4lite_bus_wrapper
#  Instance axi4lite_bus
set binopt {-bin}
set hexopt {-hex}
if { [info exists PathSeparator] } { set ps $PathSeparator } else { set ps "/" }
if { ![info exists tbpath] } { set tbpath "${ps}bfm_system_tb${ps}dut" }

# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}INTERCONNECT_ACLK
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}INTERCONNECT_ARESETN
  eval add list $binopt $tbpath${ps}axi4lite_bus${ps}S_AXI_ARESET_OUT_N
  eval add list $binopt $tbpath${ps}axi4lite_bus${ps}M_AXI_ARESET_OUT_N
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}IRQ
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}S_AXI_ACLK
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}S_AXI_AWID
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}S_AXI_AWADDR
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}S_AXI_AWLEN
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}S_AXI_AWSIZE
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}S_AXI_AWBURST
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}S_AXI_AWLOCK
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}S_AXI_AWCACHE
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}S_AXI_AWPROT
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}S_AXI_AWQOS
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}S_AXI_AWUSER
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}S_AXI_AWVALID
  eval add list $binopt $tbpath${ps}axi4lite_bus${ps}S_AXI_AWREADY
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}S_AXI_WID
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}S_AXI_WDATA
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}S_AXI_WSTRB
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}S_AXI_WLAST
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}S_AXI_WUSER
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}S_AXI_WVALID
  eval add list $binopt $tbpath${ps}axi4lite_bus${ps}S_AXI_WREADY
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}S_AXI_BID
  eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}S_AXI_BRESP
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}S_AXI_BUSER
  eval add list $binopt $tbpath${ps}axi4lite_bus${ps}S_AXI_BVALID
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}S_AXI_BREADY
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}S_AXI_ARID
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}S_AXI_ARADDR
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}S_AXI_ARLEN
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}S_AXI_ARSIZE
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}S_AXI_ARBURST
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}S_AXI_ARLOCK
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}S_AXI_ARCACHE
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}S_AXI_ARPROT
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}S_AXI_ARQOS
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}S_AXI_ARUSER
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}S_AXI_ARVALID
  eval add list $binopt $tbpath${ps}axi4lite_bus${ps}S_AXI_ARREADY
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}S_AXI_RID
  eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}S_AXI_RDATA
  eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}S_AXI_RRESP
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}S_AXI_RLAST
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}S_AXI_RUSER
  eval add list $binopt $tbpath${ps}axi4lite_bus${ps}S_AXI_RVALID
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}S_AXI_RREADY
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}M_AXI_ACLK
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}M_AXI_AWID
  eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}M_AXI_AWADDR
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}M_AXI_AWLEN
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}M_AXI_AWSIZE
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}M_AXI_AWBURST
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}M_AXI_AWLOCK
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}M_AXI_AWCACHE
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}M_AXI_AWPROT
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}M_AXI_AWREGION
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}M_AXI_AWQOS
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}M_AXI_AWUSER
  eval add list $binopt $tbpath${ps}axi4lite_bus${ps}M_AXI_AWVALID
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}M_AXI_AWREADY
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}M_AXI_WID
  eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}M_AXI_WDATA
  eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}M_AXI_WSTRB
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}M_AXI_WLAST
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}M_AXI_WUSER
  eval add list $binopt $tbpath${ps}axi4lite_bus${ps}M_AXI_WVALID
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}M_AXI_WREADY
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}M_AXI_BID
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}M_AXI_BRESP
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}M_AXI_BUSER
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}M_AXI_BVALID
  eval add list $binopt $tbpath${ps}axi4lite_bus${ps}M_AXI_BREADY
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}M_AXI_ARID
  eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}M_AXI_ARADDR
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}M_AXI_ARLEN
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}M_AXI_ARSIZE
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}M_AXI_ARBURST
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}M_AXI_ARLOCK
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}M_AXI_ARCACHE
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}M_AXI_ARPROT
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}M_AXI_ARREGION
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}M_AXI_ARQOS
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}M_AXI_ARUSER
  eval add list $binopt $tbpath${ps}axi4lite_bus${ps}M_AXI_ARVALID
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}M_AXI_ARREADY
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}M_AXI_RID
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}M_AXI_RDATA
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}M_AXI_RRESP
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}M_AXI_RLAST
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}M_AXI_RUSER
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}M_AXI_RVALID
  eval add list $binopt $tbpath${ps}axi4lite_bus${ps}M_AXI_RREADY
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}S_AXI_CTRL_AWADDR
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}S_AXI_CTRL_AWVALID
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}S_AXI_CTRL_AWREADY
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}S_AXI_CTRL_WDATA
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}S_AXI_CTRL_WVALID
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}S_AXI_CTRL_WREADY
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}S_AXI_CTRL_BRESP
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}S_AXI_CTRL_BVALID
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}S_AXI_CTRL_BREADY
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}S_AXI_CTRL_ARADDR
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}S_AXI_CTRL_ARVALID
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}S_AXI_CTRL_ARREADY
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}S_AXI_CTRL_RDATA
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}S_AXI_CTRL_RRESP
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}S_AXI_CTRL_RVALID
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}S_AXI_CTRL_RREADY
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}INTERCONNECT_ARESET_OUT_N
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_AW_TRANS_SEQ
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_AW_ARB_GRANT
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_AR_TRANS_SEQ
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_AR_ARB_GRANT
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}DEBUG_AW_TRANS_QUAL
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_AW_ACCEPT_CNT
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_AW_ACTIVE_THREAD
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_AW_ACTIVE_TARGET
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_AW_ACTIVE_REGION
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_AW_ERROR
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_AW_TARGET
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}DEBUG_AR_TRANS_QUAL
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_AR_ACCEPT_CNT
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_AR_ACTIVE_THREAD
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_AR_ACTIVE_TARGET
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_AR_ACTIVE_REGION
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_AR_ERROR
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_AR_TARGET
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_B_TRANS_SEQ
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_R_BEAT_CNT
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_R_TRANS_SEQ
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_AW_ISSUING_CNT
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_AR_ISSUING_CNT
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_W_BEAT_CNT
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_W_TRANS_SEQ
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_BID_TARGET
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}DEBUG_BID_ERROR
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_RID_TARGET
# eval add list $binopt $tbpath${ps}axi4lite_bus${ps}DEBUG_RID_ERROR
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_SR_SC_ARADDR
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_SR_SC_ARADDRCONTROL
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_SR_SC_AWADDR
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_SR_SC_AWADDRCONTROL
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_SR_SC_BRESP
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_SR_SC_RDATA
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_SR_SC_RDATACONTROL
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_SR_SC_WDATA
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_SR_SC_WDATACONTROL
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_SC_SF_ARADDR
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_SC_SF_ARADDRCONTROL
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_SC_SF_AWADDR
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_SC_SF_AWADDRCONTROL
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_SC_SF_BRESP
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_SC_SF_RDATA
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_SC_SF_RDATACONTROL
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_SC_SF_WDATA
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_SC_SF_WDATACONTROL
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_SF_CB_ARADDR
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_SF_CB_ARADDRCONTROL
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_SF_CB_AWADDR
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_SF_CB_AWADDRCONTROL
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_SF_CB_BRESP
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_SF_CB_RDATA
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_SF_CB_RDATACONTROL
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_SF_CB_WDATA
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_SF_CB_WDATACONTROL
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_CB_MF_ARADDR
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_CB_MF_ARADDRCONTROL
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_CB_MF_AWADDR
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_CB_MF_AWADDRCONTROL
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_CB_MF_BRESP
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_CB_MF_RDATA
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_CB_MF_RDATACONTROL
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_CB_MF_WDATA
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_CB_MF_WDATACONTROL
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_MF_MC_ARADDR
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_MF_MC_ARADDRCONTROL
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_MF_MC_AWADDR
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_MF_MC_AWADDRCONTROL
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_MF_MC_BRESP
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_MF_MC_RDATA
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_MF_MC_RDATACONTROL
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_MF_MC_WDATA
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_MF_MC_WDATACONTROL
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_MC_MP_ARADDR
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_MC_MP_ARADDRCONTROL
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_MC_MP_AWADDR
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_MC_MP_AWADDRCONTROL
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_MC_MP_BRESP
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_MC_MP_RDATA
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_MC_MP_RDATACONTROL
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_MC_MP_WDATA
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_MC_MP_WDATACONTROL
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_MP_MR_ARADDR
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_MP_MR_ARADDRCONTROL
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_MP_MR_AWADDR
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_MP_MR_AWADDRCONTROL
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_MP_MR_BRESP
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_MP_MR_RDATA
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_MP_MR_RDATACONTROL
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_MP_MR_WDATA
# eval add list $hexopt $tbpath${ps}axi4lite_bus${ps}DEBUG_MP_MR_WDATACONTROL

