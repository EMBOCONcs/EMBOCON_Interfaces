#  Simulation Model Generator
#  Xilinx EDK 14.4 EDK_P.49d
#  Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
#
#  File     bfm_system.do (Mon Jun 17 16:02:30 2013)
#
vmap secureip "C:/Xilinx/14.4/Modelsim/secureip/"
vmap simprim "C:/Xilinx/14.4/Modelsim/simprim/"
vmap simprims_ver "C:/Xilinx/14.4/Modelsim/simprims_ver/"
vmap unimacro "C:/Xilinx/14.4/Modelsim/unimacro/"
vmap unimacro_ver "C:/Xilinx/14.4/Modelsim/unimacro_ver/"
vmap unisim "C:/Xilinx/14.4/Modelsim/unisim/"
vmap unisims_ver "C:/Xilinx/14.4/Modelsim/unisims_ver/"
vmap xilinxcorelib "C:/Xilinx/14.4/Modelsim/xilinxcorelib/"
vmap xilinxcorelib_ver "C:/Xilinx/14.4/Modelsim/xilinxcorelib_ver/"
vmap cdn_axi4_lite_master_bfm_wrap_v2_01_a "C:/Xilinx/14.4/Modelsim/edk/cdn_axi4_lite_master_bfm_wrap_v2_01_a/"
vmap axi_interconnect_v1_06_a "C:/Xilinx/14.4/Modelsim/edk/axi_interconnect_v1_06_a/"
vmap proc_common_v3_00_a "C:/Xilinx/14.4/Modelsim/edk/proc_common_v3_00_a/"
vmap axi_lite_ipif_v1_01_a "C:/Xilinx/14.4/Modelsim/edk/axi_lite_ipif_v1_01_a/"
vlib controller_v1_00_a
vmap controller_v1_00_a controller_v1_00_a
vlib work
vmap work work
vcom -novopt -93 -work controller_v1_00_a "C:/Users/asuardi/Desktop/CRANE_Vivado_HLS/EDK/pcores/controller_v1_00_a/hdl/vhdl/user_logic.vhd"
vcom -novopt -93 -work controller_v1_00_a "C:/Users/asuardi/Desktop/CRANE_Vivado_HLS/EDK/pcores/controller_v1_00_a/hdl/vhdl/controller.vhd"
vlog -novopt -incr -work work "bfm_system_bfm_processor_wrapper.v"
vlog -novopt -incr -work work "bfm_system_axi4lite_bus_wrapper.v"
vcom -novopt -93 -work work "bfm_system_controller_inst_wrapper.vhd"
vcom -novopt -93 -work work "bfm_system.vhd"
vcom -novopt -93 -work work "bfm_system_tb.vhd"
vlog -novopt -incr -work work "C:/Xilinx/14.4/ISE_DS/ISE/verilog/src/glbl.v" {+incdir+C:/Xilinx/14.4/ISE_DS/ISE/verilog/src/}
