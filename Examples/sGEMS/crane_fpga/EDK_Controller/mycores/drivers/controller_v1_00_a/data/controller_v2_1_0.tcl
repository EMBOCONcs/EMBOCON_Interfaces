##############################################################################
## Filename:          C:\Users\asuardi\Desktop\CRANE_Vivado_HLS\EDK/drivers/controller_v1_00_a/data/controller_v2_1_0.tcl
## Description:       Microprocess Driver Command (tcl)
## Date:              Mon Jun 17 15:21:03 2013 (by Create and Import Peripheral Wizard)
##############################################################################

#uses "xillib.tcl"

proc generate {drv_handle} {
  xdefine_include_file $drv_handle "xparameters.h" "controller" "NUM_INSTANCES" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR" 
}
