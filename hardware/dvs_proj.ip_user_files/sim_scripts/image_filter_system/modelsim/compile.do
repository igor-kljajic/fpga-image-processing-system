vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xilinx_vip
vlib modelsim_lib/msim/xpm
vlib modelsim_lib/msim/axi_infrastructure_v1_1_0
vlib modelsim_lib/msim/axi_vip_v1_1_21
vlib modelsim_lib/msim/processing_system7_vip_v1_0_23
vlib modelsim_lib/msim/work
vlib modelsim_lib/msim/axi_datamover_v5_1_37
vlib modelsim_lib/msim/axi_sg_v4_1_21
vlib modelsim_lib/msim/axi_dma_v7_1_36
vlib modelsim_lib/msim/generic_baseblocks_v2_1_2
vlib modelsim_lib/msim/axi_register_slice_v2_1_35
vlib modelsim_lib/msim/fifo_generator_v13_2_13
vlib modelsim_lib/msim/axi_data_fifo_v2_1_35
vlib modelsim_lib/msim/axi_crossbar_v2_1_37
vlib modelsim_lib/msim/proc_sys_reset_v5_0_17
vlib modelsim_lib/msim/xlconcat_v2_1_7
vlib modelsim_lib/msim/axi_lite_ipif_v3_0_4
vlib modelsim_lib/msim/axi_timer_v2_0_37
vlib modelsim_lib/msim/axi_protocol_converter_v2_1_36
vlib modelsim_lib/msim/axi_clock_converter_v2_1_34
vlib modelsim_lib/msim/blk_mem_gen_v8_4_11
vlib modelsim_lib/msim/axi_dwidth_converter_v2_1_36
vlib modelsim_lib/msim/xil_defaultlib

vmap xilinx_vip modelsim_lib/msim/xilinx_vip
vmap xpm modelsim_lib/msim/xpm
vmap axi_infrastructure_v1_1_0 modelsim_lib/msim/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_21 modelsim_lib/msim/axi_vip_v1_1_21
vmap processing_system7_vip_v1_0_23 modelsim_lib/msim/processing_system7_vip_v1_0_23
vmap work modelsim_lib/msim/work
vmap axi_datamover_v5_1_37 modelsim_lib/msim/axi_datamover_v5_1_37
vmap axi_sg_v4_1_21 modelsim_lib/msim/axi_sg_v4_1_21
vmap axi_dma_v7_1_36 modelsim_lib/msim/axi_dma_v7_1_36
vmap generic_baseblocks_v2_1_2 modelsim_lib/msim/generic_baseblocks_v2_1_2
vmap axi_register_slice_v2_1_35 modelsim_lib/msim/axi_register_slice_v2_1_35
vmap fifo_generator_v13_2_13 modelsim_lib/msim/fifo_generator_v13_2_13
vmap axi_data_fifo_v2_1_35 modelsim_lib/msim/axi_data_fifo_v2_1_35
vmap axi_crossbar_v2_1_37 modelsim_lib/msim/axi_crossbar_v2_1_37
vmap proc_sys_reset_v5_0_17 modelsim_lib/msim/proc_sys_reset_v5_0_17
vmap xlconcat_v2_1_7 modelsim_lib/msim/xlconcat_v2_1_7
vmap axi_lite_ipif_v3_0_4 modelsim_lib/msim/axi_lite_ipif_v3_0_4
vmap axi_timer_v2_0_37 modelsim_lib/msim/axi_timer_v2_0_37
vmap axi_protocol_converter_v2_1_36 modelsim_lib/msim/axi_protocol_converter_v2_1_36
vmap axi_clock_converter_v2_1_34 modelsim_lib/msim/axi_clock_converter_v2_1_34
vmap blk_mem_gen_v8_4_11 modelsim_lib/msim/blk_mem_gen_v8_4_11
vmap axi_dwidth_converter_v2_1_36 modelsim_lib/msim/axi_dwidth_converter_v2_1_36
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xilinx_vip  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"C:/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"C:/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"C:/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"C:/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"C:/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"C:/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"C:/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/axi_vip_if.sv" \
"C:/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/clk_vip_if.sv" \
"C:/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"C:/Xilinx/2025.1/Vivado/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/Xilinx/2025.1/Vivado/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"C:/Xilinx/2025.1/Vivado/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm  -93  \
"C:/Xilinx/2025.1/Vivado/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work axi_infrastructure_v1_1_0  -incr -mfcu  "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_21  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/f16f/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work processing_system7_vip_v1_0_23  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \

vlog -work work  -incr -mfcu  "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ip/filter_system_processing_system7_0_0_1/sim/filter_system_processing_system7_0_0.v" \

vcom -work axi_datamover_v5_1_37  -93  \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/d44a/hdl/axi_datamover_v5_1_vh_rfs.vhd" \

vcom -work axi_sg_v4_1_21  -93  \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/b193/hdl/axi_sg_v4_1_rfs.vhd" \

vcom -work axi_dma_v7_1_36  -93  \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/cb19/hdl/axi_dma_v7_1_vh_rfs.vhd" \

vcom -work work  -93  \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ip/filter_system_axi_dma_0_0_1/sim/filter_system_axi_dma_0_0.vhd" \

vlog -work generic_baseblocks_v2_1_2  -incr -mfcu  "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/0c28/hdl/generic_baseblocks_v2_1_vl_rfs.v" \

vlog -work axi_register_slice_v2_1_35  -incr -mfcu  "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/c5b7/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work fifo_generator_v13_2_13  -incr -mfcu  "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/dc46/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_13  -93  \
"../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/dc46/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_13  -incr -mfcu  "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/dc46/hdl/fifo_generator_v13_2_rfs.v" \

vlog -work axi_data_fifo_v2_1_35  -incr -mfcu  "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/4846/hdl/axi_data_fifo_v2_1_vl_rfs.v" \

vlog -work axi_crossbar_v2_1_37  -incr -mfcu  "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/a1a7/hdl/axi_crossbar_v2_1_vl_rfs.v" \

vlog -work work  -incr -mfcu  "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ip/filter_system_ps7_0_axi_periph_upgraded_ipi_imp_xbar_0/sim/filter_system_ps7_0_axi_periph_upgraded_ipi_imp_xbar_0.v" \

vcom -work proc_sys_reset_v5_0_17  -93  \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/9438/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work work  -93  \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ip/filter_system_rst_ps7_0_100M_0_1/sim/filter_system_rst_ps7_0_100M_0.vhd" \

vlog -work work  -incr -mfcu  "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ip/filter_system_axi_mem_intercon_upgraded_ipi_imp_xbar_0/sim/filter_system_axi_mem_intercon_upgraded_ipi_imp_xbar_0.v" \

vlog -work xlconcat_v2_1_7  -incr -mfcu  "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../dvs_proj.srcs/sources_1/bd/image_filter_system/ipshared/9c1a/hdl/xlconcat_v2_1_vl_rfs.v" \

vlog -work work  -incr -mfcu  "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../bd/image_filter_system/ip/filter_system_xlconcat_0_0_1/sim/filter_system_xlconcat_0_0.v" \

vcom -work axi_lite_ipif_v3_0_4  -93  \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \

vcom -work axi_timer_v2_0_37  -93  \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/05e8/hdl/axi_timer_v2_0_vh_rfs.vhd" \

vcom -work work  -93  \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ip/filter_system_axi_timer_0_0/sim/filter_system_axi_timer_0_0.vhd" \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ip/image_filter_system_acc_image_filter_0_0/sim/image_filter_system_acc_image_filter_0_0.vhd" \

vlog -work axi_protocol_converter_v2_1_36  -incr -mfcu  "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/f0b6/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \

vlog -work work  -incr -mfcu  "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ip/image_filter_system_ps7_0_axi_periph_imp_auto_pc_0/sim/image_filter_system_ps7_0_axi_periph_imp_auto_pc_0.v" \

vlog -work axi_clock_converter_v2_1_34  -incr -mfcu  "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/9a28/hdl/axi_clock_converter_v2_1_vl_rfs.v" \

vlog -work blk_mem_gen_v8_4_11  -incr -mfcu  "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/a32c/simulation/blk_mem_gen_v8_4.v" \

vlog -work axi_dwidth_converter_v2_1_36  -incr -mfcu  "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/db4c/hdl/axi_dwidth_converter_v2_1_vl_rfs.v" \

vlog -work work  -incr -mfcu  "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ipshared/6cfa/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../DVS_projekat.gen/sources_1/bd/filter_system/ipshared/ec67/hdl" "+incdir+../../../../dvs_proj.gen/sources_1/bd/image_filter_system/ipshared/ec67/hdl" "+incdir+C:/Xilinx/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ip/image_filter_system_axi_mem_intercon_imp_auto_us_0/sim/image_filter_system_axi_mem_intercon_imp_auto_us_0.v" \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ip/image_filter_system_axi_mem_intercon_imp_auto_us_1/sim/image_filter_system_axi_mem_intercon_imp_auto_us_1.v" \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/ip/image_filter_system_axi_mem_intercon_imp_auto_pc_0/sim/image_filter_system_axi_mem_intercon_imp_auto_pc_0.v" \

vcom -work work  -93  \
"../../../../DVS_projekat_novi_dopuna_timer.gen/sources_1/bd/filter_system/sim/image_filter_system.vhd" \

vlog -work work \
"glbl.v"

