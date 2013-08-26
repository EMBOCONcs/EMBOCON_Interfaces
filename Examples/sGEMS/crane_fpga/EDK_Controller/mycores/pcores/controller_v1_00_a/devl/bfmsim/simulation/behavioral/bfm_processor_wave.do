#  Simulation Model Generator
#  Xilinx EDK 14.4 EDK_P.49d
#  Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
#
#  File     bfm_processor_wave.do (Mon Jun 17 16:02:30 2013)
#
#  Module   bfm_system_bfm_processor_wrapper
#  Instance bfm_processor
set binopt {-logic}
set hexopt {-literal -hex}
if { [info exists PathSeparator] } { set ps $PathSeparator } else { set ps "/" }
if { ![info exists tbpath] } { set tbpath "${ps}bfm_system_tb${ps}dut" }

  eval add wave -noupdate -divider {"bfm_processor"}
# eval add wave -noupdate $binopt $tbpath${ps}bfm_processor${ps}M_AXI_LITE_ACLK
# eval add wave -noupdate $binopt $tbpath${ps}bfm_processor${ps}M_AXI_LITE_ARESETN
  eval add wave -noupdate $hexopt $tbpath${ps}bfm_processor${ps}M_AXI_LITE_AWADDR
  eval add wave -noupdate $hexopt $tbpath${ps}bfm_processor${ps}M_AXI_LITE_AWPROT
  eval add wave -noupdate $binopt $tbpath${ps}bfm_processor${ps}M_AXI_LITE_AWVALID
# eval add wave -noupdate $binopt $tbpath${ps}bfm_processor${ps}M_AXI_LITE_AWREADY
  eval add wave -noupdate $hexopt $tbpath${ps}bfm_processor${ps}M_AXI_LITE_WDATA
  eval add wave -noupdate $hexopt $tbpath${ps}bfm_processor${ps}M_AXI_LITE_WSTRB
  eval add wave -noupdate $binopt $tbpath${ps}bfm_processor${ps}M_AXI_LITE_WVALID
# eval add wave -noupdate $binopt $tbpath${ps}bfm_processor${ps}M_AXI_LITE_WREADY
# eval add wave -noupdate $hexopt $tbpath${ps}bfm_processor${ps}M_AXI_LITE_BRESP
# eval add wave -noupdate $binopt $tbpath${ps}bfm_processor${ps}M_AXI_LITE_BVALID
  eval add wave -noupdate $binopt $tbpath${ps}bfm_processor${ps}M_AXI_LITE_BREADY
  eval add wave -noupdate $hexopt $tbpath${ps}bfm_processor${ps}M_AXI_LITE_ARADDR
  eval add wave -noupdate $hexopt $tbpath${ps}bfm_processor${ps}M_AXI_LITE_ARPROT
  eval add wave -noupdate $binopt $tbpath${ps}bfm_processor${ps}M_AXI_LITE_ARVALID
# eval add wave -noupdate $binopt $tbpath${ps}bfm_processor${ps}M_AXI_LITE_ARREADY
# eval add wave -noupdate $hexopt $tbpath${ps}bfm_processor${ps}M_AXI_LITE_RDATA
# eval add wave -noupdate $hexopt $tbpath${ps}bfm_processor${ps}M_AXI_LITE_RRESP
# eval add wave -noupdate $binopt $tbpath${ps}bfm_processor${ps}M_AXI_LITE_RVALID
  eval add wave -noupdate $binopt $tbpath${ps}bfm_processor${ps}M_AXI_LITE_RREADY

