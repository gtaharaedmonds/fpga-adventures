

proc generate {drv_handle} {
	xdefine_include_file $drv_handle "xparameters.h" "tile_fifo_axi" "NUM_INSTANCES" "DEVICE_ID"  "C_s00_axi_BASEADDR" "C_s00_axi_HIGHADDR"
}
