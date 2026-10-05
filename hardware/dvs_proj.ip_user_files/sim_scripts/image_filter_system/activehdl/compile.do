transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib activehdl/xilinx_vip
vlib activehdl/xpm
vlib activehdl/axi_infrastructure_v1_1_0
vlib activehdl/axi_vip_v1_1_21
vlib activehdl/processing_system7_vip_v1_0_23
vlib activehdl/work
vlib activehdl/axi_datamover_v5_1_37
vlib activehdl/axi_sg_v4_1_21
vlib activehdl/axi_dma_v7_1_36
vlib activehdl/generic_baseblocks_v2_1_2
vlib activehdl/axi_register_slice_v2_1_35
vlib activehdl/fifo_generator_v13_2_13
vlib activehdl/axi_data_fifo_v2_1_35
vlib activehdl/axi_crossbar_v2_1_37
vlib activehdl/proc_sys_reset_v5_0_17
vlib activehdl/xlconcat_v2_1_7
vlib activehdl/axi_lite_ipif_v3_0_4
vlib activehdl/axi_timer_v2_0_37
vlib activehdl/axi_protocol_converter_v2_1_36
vlib activehdl/axi_clock_converter_v2_1_34
vlib activehdl/blk_mem_gen_v8_4_11
vlib activehdl/axi_dwidth_converter_v2_1_36
vlib activehdl/xil_defaultlib

vmap xilinx_vip activehdl/xilinx_vip
vmap xpm activehdl/xpm
vmap axi_infrastructure_v1_1_0 activehdl/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_21 activehdl/axi_vip_v1_1_21
vmap processing_system7_vip_v1_0_23 activehdl/processing_system7_vip_v1_0_23
vmap work activehdl/work
vmap axi_datamover_v5_1_37 activehdl/axi_datamover_v5_1_37
vmap axi_sg_v4_1_21 activehdl/axi_sg_v4_1_21
vmap axi_dma_v7_1_36 activehdl/axi_dma_v7_1_36
vmap generic_baseblocks_v2_1_2 activehdl/generic_baseblocks_v2_1_2
vmap axi_register_slice_v2_1_35 activehdl/axi_register_slice_v2_1_35
vmap fifo_generator_v13_2_13 activehdl/fifo_generator_v13_2_13
vmap axi_data_fifo_v2_1_35 activehdl/axi_data_fifo_v2_1_35
vmap axi_crossbar_v2_1_37 activehdl/axi_crossbar_v2_1_37
vmap proc_sys_reset_v5_0_17 activehdl/proc_sys_reset_v5_0_17
vmap xlconcat_v2_1_7 activehdl/xlconcat_v2_1_7
vmap axi_lite_ipif_v3_0_4 activehdl/axi_lite_ipif_v3_0_4
vmap axi_timer_v2_0_37 activehdl/axi_timer_v2_0_37
vmap axi_protocol_converter_v2_1_36 activehdl/axi_protocol_converter_v2_1_36
vmap axi_clock_converter_v2_1_34 activehdl/axi_clock_converter_v2_1_34
vmap blk_mem_gen_v8_4_11 activehdl/blk_mem_gen_v8_4_11
vmap axi_dwidth_converter_v2_1_36 activehdl/axi_dwidth_converter_v2_1_36
vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xilinx_vip  -sv2k12 "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l processing_system7_vip_v1_0_23 -l work -l axi_datamover_v5_1_37 -l axi_sg_v4_1_21 -l axi_dma_v7_1_36 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l proc_sys_reset_v5_0_17 -l xlconcat_v2_1_7 -l axi_lite_ipif_v3_0_4 -l axi_timer_v2_0_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l blk_mem_gen_v8_4_11 -l axi_dwidth_converter_v2_1_36 \
"C:/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"C:/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"C:/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"C:/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"C:/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"C:/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"C:/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/axi_vip_if.sv" \
"C:/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/clk_vip_if.sv" \
"C:/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm  -sv2k12 "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l processing_system7_vip_v1_0_23 -l work -l axi_datamover_v5_1_37 -l axi_sg_v4_1_21 -l axi_dma_v7_1_36 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l proc_sys_reset_v5_0_17 -l xlconcat_v2_1_7 -l axi_lite_ipif_v3_0_4 -l axi_timer_v2_0_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l blk_mem_gen_v8_4_11 -l axi_dwidth_converter_v2_1_36 \
"C:/Xilinx/2025.1/Vivado/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/Xilinx/2025.1/Vivado/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"C:/Xilinx/2025.1/Vivado/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93  \
"C:/Xilinx/2025.1/Vivado/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work axi_infrastructure_v1_1_0  -v2k5 "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l processing_system7_vip_v1_0_23 -l work -l axi_datamover_v5_1_37 -l axi_sg_v4_1_21 -l axi_dma_v7_1_36 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l proc_sys_reset_v5_0_17 -l xlconcat_v2_1_7 -l axi_lite_ipif_v3_0_4 -l axi_timer_v2_0_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l blk_mem_gen_v8_4_11 -l axi_dwidth_converter_v2_1_36 \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_21  -sv2k12 "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l processing_system7_vip_v1_0_23 -l work -l axi_datamover_v5_1_37 -l axi_sg_v4_1_21 -l axi_dma_v7_1_36 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l proc_sys_reset_v5_0_17 -l xlconcat_v2_1_7 -l axi_lite_ipif_v3_0_4 -l axi_timer_v2_0_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l blk_mem_gen_v8_4_11 -l axi_dwidth_converter_v2_1_36 \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/f16f/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work processing_system7_vip_v1_0_23  -sv2k12 "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l processing_system7_vip_v1_0_23 -l work -l axi_datamover_v5_1_37 -l axi_sg_v4_1_21 -l axi_dma_v7_1_36 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l proc_sys_reset_v5_0_17 -l xlconcat_v2_1_7 -l axi_lite_ipif_v3_0_4 -l axi_timer_v2_0_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l blk_mem_gen_v8_4_11 -l axi_dwidth_converter_v2_1_36 \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \

vlog -work work  -v2k5 "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l processing_system7_vip_v1_0_23 -l work -l axi_datamover_v5_1_37 -l axi_sg_v4_1_21 -l axi_dma_v7_1_36 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l proc_sys_reset_v5_0_17 -l xlconcat_v2_1_7 -l axi_lite_ipif_v3_0_4 -l axi_timer_v2_0_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l blk_mem_gen_v8_4_11 -l axi_dwidth_converter_v2_1_36 \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ip/filter_system_processing_system7_0_0_1/sim/filter_system_processing_system7_0_0.v" \

vcom -work axi_datamover_v5_1_37 -93  \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/d44a/hdl/axi_datamover_v5_1_vh_rfs.vhd" \

vcom -work axi_sg_v4_1_21 -93  \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/b193/hdl/axi_sg_v4_1_rfs.vhd" \

vcom -work axi_dma_v7_1_36 -93  \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/cb19/hdl/axi_dma_v7_1_vh_rfs.vhd" \

vcom -work work -93  \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ip/filter_system_axi_dma_0_0_1/sim/filter_system_axi_dma_0_0.vhd" \

vlog -work generic_baseblocks_v2_1_2  -v2k5 "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l processing_system7_vip_v1_0_23 -l work -l axi_datamover_v5_1_37 -l axi_sg_v4_1_21 -l axi_dma_v7_1_36 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l proc_sys_reset_v5_0_17 -l xlconcat_v2_1_7 -l axi_lite_ipif_v3_0_4 -l axi_timer_v2_0_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l blk_mem_gen_v8_4_11 -l axi_dwidth_converter_v2_1_36 \
"../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/0c28/hdl/generic_baseblocks_v2_1_vl_rfs.v" \

vlog -work axi_register_slice_v2_1_35  -v2k5 "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l processing_system7_vip_v1_0_23 -l work -l axi_datamover_v5_1_37 -l axi_sg_v4_1_21 -l axi_dma_v7_1_36 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l proc_sys_reset_v5_0_17 -l xlconcat_v2_1_7 -l axi_lite_ipif_v3_0_4 -l axi_timer_v2_0_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l blk_mem_gen_v8_4_11 -l axi_dwidth_converter_v2_1_36 \
"../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/c5b7/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work fifo_generator_v13_2_13  -v2k5 "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l processing_system7_vip_v1_0_23 -l work -l axi_datamover_v5_1_37 -l axi_sg_v4_1_21 -l axi_dma_v7_1_36 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l proc_sys_reset_v5_0_17 -l xlconcat_v2_1_7 -l axi_lite_ipif_v3_0_4 -l axi_timer_v2_0_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l blk_mem_gen_v8_4_11 -l axi_dwidth_converter_v2_1_36 \
"../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/dc46/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_13 -93  \
"../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/dc46/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_13  -v2k5 "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l processing_system7_vip_v1_0_23 -l work -l axi_datamover_v5_1_37 -l axi_sg_v4_1_21 -l axi_dma_v7_1_36 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l proc_sys_reset_v5_0_17 -l xlconcat_v2_1_7 -l axi_lite_ipif_v3_0_4 -l axi_timer_v2_0_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l blk_mem_gen_v8_4_11 -l axi_dwidth_converter_v2_1_36 \
"../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/dc46/hdl/fifo_generator_v13_2_rfs.v" \

vlog -work axi_data_fifo_v2_1_35  -v2k5 "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l processing_system7_vip_v1_0_23 -l work -l axi_datamover_v5_1_37 -l axi_sg_v4_1_21 -l axi_dma_v7_1_36 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l proc_sys_reset_v5_0_17 -l xlconcat_v2_1_7 -l axi_lite_ipif_v3_0_4 -l axi_timer_v2_0_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l blk_mem_gen_v8_4_11 -l axi_dwidth_converter_v2_1_36 \
"../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/4846/hdl/axi_data_fifo_v2_1_vl_rfs.v" \

vlog -work axi_crossbar_v2_1_37  -v2k5 "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l processing_system7_vip_v1_0_23 -l work -l axi_datamover_v5_1_37 -l axi_sg_v4_1_21 -l axi_dma_v7_1_36 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l proc_sys_reset_v5_0_17 -l xlconcat_v2_1_7 -l axi_lite_ipif_v3_0_4 -l axi_timer_v2_0_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l blk_mem_gen_v8_4_11 -l axi_dwidth_converter_v2_1_36 \
"../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/a1a7/hdl/axi_crossbar_v2_1_vl_rfs.v" \

vlog -work work  -v2k5 "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l processing_system7_vip_v1_0_23 -l work -l axi_datamover_v5_1_37 -l axi_sg_v4_1_21 -l axi_dma_v7_1_36 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l proc_sys_reset_v5_0_17 -l xlconcat_v2_1_7 -l axi_lite_ipif_v3_0_4 -l axi_timer_v2_0_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l blk_mem_gen_v8_4_11 -l axi_dwidth_converter_v2_1_36 \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ip/filter_system_ps7_0_axi_periph_upgraded_ipi_imp_xbar_0/sim/filter_system_ps7_0_axi_periph_upgraded_ipi_imp_xbar_0.v" \

vcom -work proc_sys_reset_v5_0_17 -93  \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/9438/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work work -93  \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ip/filter_system_rst_ps7_0_100M_0_1/sim/filter_system_rst_ps7_0_100M_0.vhd" \

vlog -work work  -v2k5 "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l processing_system7_vip_v1_0_23 -l work -l axi_datamover_v5_1_37 -l axi_sg_v4_1_21 -l axi_dma_v7_1_36 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l proc_sys_reset_v5_0_17 -l xlconcat_v2_1_7 -l axi_lite_ipif_v3_0_4 -l axi_timer_v2_0_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l blk_mem_gen_v8_4_11 -l axi_dwidth_converter_v2_1_36 \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ip/filter_system_axi_mem_intercon_upgraded_ipi_imp_xbar_0/sim/filter_system_axi_mem_intercon_upgraded_ipi_imp_xbar_0.v" \

vlog -work xlconcat_v2_1_7  -v2k5 "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l processing_system7_vip_v1_0_23 -l work -l axi_datamover_v5_1_37 -l axi_sg_v4_1_21 -l axi_dma_v7_1_36 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l proc_sys_reset_v5_0_17 -l xlconcat_v2_1_7 -l axi_lite_ipif_v3_0_4 -l axi_timer_v2_0_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l blk_mem_gen_v8_4_11 -l axi_dwidth_converter_v2_1_36 \
"../../../../dvs_proj.srcs/sources_1/bd/image_filter_system/ipshared/9c1a/hdl/xlconcat_v2_1_vl_rfs.v" \

vlog -work work  -v2k5 "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l processing_system7_vip_v1_0_23 -l work -l axi_datamover_v5_1_37 -l axi_sg_v4_1_21 -l axi_dma_v7_1_36 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l proc_sys_reset_v5_0_17 -l xlconcat_v2_1_7 -l axi_lite_ipif_v3_0_4 -l axi_timer_v2_0_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l blk_mem_gen_v8_4_11 -l axi_dwidth_converter_v2_1_36 \
"../../../bd/image_filter_system/ip/filter_system_xlconcat_0_0_1/sim/filter_system_xlconcat_0_0.v" \

vcom -work axi_lite_ipif_v3_0_4 -93  \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \

vcom -work axi_timer_v2_0_37 -93  \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/05e8/hdl/axi_timer_v2_0_vh_rfs.vhd" \

vcom -work work -93  \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ip/filter_system_axi_timer_0_0/sim/filter_system_axi_timer_0_0.vhd" \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ip/image_filter_system_acc_image_filter_0_0/sim/image_filter_system_acc_image_filter_0_0.vhd" \

vlog -work axi_protocol_converter_v2_1_36  -v2k5 "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l processing_system7_vip_v1_0_23 -l work -l axi_datamover_v5_1_37 -l axi_sg_v4_1_21 -l axi_dma_v7_1_36 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l proc_sys_reset_v5_0_17 -l xlconcat_v2_1_7 -l axi_lite_ipif_v3_0_4 -l axi_timer_v2_0_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l blk_mem_gen_v8_4_11 -l axi_dwidth_converter_v2_1_36 \
"../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/f0b6/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \

vlog -work work  -v2k5 "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l processing_system7_vip_v1_0_23 -l work -l axi_datamover_v5_1_37 -l axi_sg_v4_1_21 -l axi_dma_v7_1_36 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l proc_sys_reset_v5_0_17 -l xlconcat_v2_1_7 -l axi_lite_ipif_v3_0_4 -l axi_timer_v2_0_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l blk_mem_gen_v8_4_11 -l axi_dwidth_converter_v2_1_36 \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ip/image_filter_system_ps7_0_axi_periph_imp_auto_pc_0/sim/image_filter_system_ps7_0_axi_periph_imp_auto_pc_0.v" \

vlog -work axi_clock_converter_v2_1_34  -v2k5 "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l processing_system7_vip_v1_0_23 -l work -l axi_datamover_v5_1_37 -l axi_sg_v4_1_21 -l axi_dma_v7_1_36 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l proc_sys_reset_v5_0_17 -l xlconcat_v2_1_7 -l axi_lite_ipif_v3_0_4 -l axi_timer_v2_0_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l blk_mem_gen_v8_4_11 -l axi_dwidth_converter_v2_1_36 \
"../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/9a28/hdl/axi_clock_converter_v2_1_vl_rfs.v" \

vlog -work blk_mem_gen_v8_4_11  -v2k5 "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l processing_system7_vip_v1_0_23 -l work -l axi_datamover_v5_1_37 -l axi_sg_v4_1_21 -l axi_dma_v7_1_36 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l proc_sys_reset_v5_0_17 -l xlconcat_v2_1_7 -l axi_lite_ipif_v3_0_4 -l axi_timer_v2_0_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l blk_mem_gen_v8_4_11 -l axi_dwidth_converter_v2_1_36 \
"../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/a32c/simulation/blk_mem_gen_v8_4.v" \

vlog -work axi_dwidth_converter_v2_1_36  -v2k5 "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l processing_system7_vip_v1_0_23 -l work -l axi_datamover_v5_1_37 -l axi_sg_v4_1_21 -l axi_dma_v7_1_36 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l proc_sys_reset_v5_0_17 -l xlconcat_v2_1_7 -l axi_lite_ipif_v3_0_4 -l axi_timer_v2_0_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l blk_mem_gen_v8_4_11 -l axi_dwidth_converter_v2_1_36 \
"../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/db4c/hdl/axi_dwidth_converter_v2_1_vl_rfs.v" \

vlog -work work  -v2k5 "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_21 -l processing_system7_vip_v1_0_23 -l work -l axi_datamover_v5_1_37 -l axi_sg_v4_1_21 -l axi_dma_v7_1_36 -l generic_baseblocks_v2_1_2 -l axi_register_slice_v2_1_35 -l fifo_generator_v13_2_13 -l axi_data_fifo_v2_1_35 -l axi_crossbar_v2_1_37 -l proc_sys_reset_v5_0_17 -l xlconcat_v2_1_7 -l axi_lite_ipif_v3_0_4 -l axi_timer_v2_0_37 -l axi_protocol_converter_v2_1_36 -l axi_clock_converter_v2_1_34 -l blk_mem_gen_v8_4_11 -l axi_dwidth_converter_v2_1_36 \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ip/image_filter_system_axi_mem_intercon_imp_auto_us_0/sim/image_filter_system_axi_mem_intercon_imp_auto_us_0.v" \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ip/image_filter_system_axi_mem_intercon_imp_auto_us_1/sim/image_filter_system_axi_mem_intercon_imp_auto_us_1.v" \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ip/image_filter_system_axi_mem_intercon_imp_auto_pc_0/sim/image_filter_system_axi_mem_intercon_imp_auto_pc_0.v" \

vcom -work work -93  \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/sim/image_filter_system.vhd" \

vlog -work work \
"glbl.v"

