#  Simulation Model Generator
#  Xilinx EDK 14.4 EDK_P.49d
#  Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
#
#  File     controller_inst_list.do (Mon Jun 17 16:02:30 2013)
#
#  Module   bfm_system_controller_inst_wrapper
#  Instance controller_inst
set binopt {-bin}
set hexopt {-hex}
if { [info exists PathSeparator] } { set ps $PathSeparator } else { set ps "/" }
if { ![info exists tbpath] } { set tbpath "${ps}bfm_system_tb${ps}dut" }

# eval add list $binopt $tbpath${ps}controller_inst${ps}S_AXI_ACLK
# eval add list $binopt $tbpath${ps}controller_inst${ps}S_AXI_ARESETN
# eval add list $hexopt $tbpath${ps}controller_inst${ps}S_AXI_AWADDR
# eval add list $binopt $tbpath${ps}controller_inst${ps}S_AXI_AWVALID
# eval add list $hexopt $tbpath${ps}controller_inst${ps}S_AXI_WDATA
# eval add list $hexopt $tbpath${ps}controller_inst${ps}S_AXI_WSTRB
# eval add list $binopt $tbpath${ps}controller_inst${ps}S_AXI_WVALID
# eval add list $binopt $tbpath${ps}controller_inst${ps}S_AXI_BREADY
# eval add list $hexopt $tbpath${ps}controller_inst${ps}S_AXI_ARADDR
# eval add list $binopt $tbpath${ps}controller_inst${ps}S_AXI_ARVALID
# eval add list $binopt $tbpath${ps}controller_inst${ps}S_AXI_RREADY
  eval add list $binopt $tbpath${ps}controller_inst${ps}S_AXI_ARREADY
  eval add list $hexopt $tbpath${ps}controller_inst${ps}S_AXI_RDATA
  eval add list $hexopt $tbpath${ps}controller_inst${ps}S_AXI_RRESP
  eval add list $binopt $tbpath${ps}controller_inst${ps}S_AXI_RVALID
  eval add list $binopt $tbpath${ps}controller_inst${ps}S_AXI_WREADY
  eval add list $hexopt $tbpath${ps}controller_inst${ps}S_AXI_BRESP
  eval add list $binopt $tbpath${ps}controller_inst${ps}S_AXI_BVALID
  eval add list $binopt $tbpath${ps}controller_inst${ps}S_AXI_AWREADY

