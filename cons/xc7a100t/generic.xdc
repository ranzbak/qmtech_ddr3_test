#
# Paul Honig 2020
#
# I/O Board
# Open AARS board V2
#
# Core board
# QMTech Artix-7XC7A100T Core Board

# Indicate the SPI path count to the Flash chip
# This uses 4 SPI lanes during programming
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]

# Disable errors when finding unassigned pins

# Core board

# Clock oscillator
set_property PACKAGE_PIN U22 [get_ports i_clk]
set_property IOSTANDARD LVCMOS33 [get_ports i_clk]
# Reset button
# Included here to be complete
#set_property PACKAGE_PIN AE16 [get_ports i_sw1_n]
#set_property IOSTANDARD LVCMOS33 [get_ports i_sw1_n]
# Reset button
# Core board LED
set_property PACKAGE_PIN J19 [get_ports o_core_led]
set_property IOSTANDARD LVCMOS33 [get_ports o_core_led]

set_false_path -hold -from [get_clocks -of_objects [get_pins my_sdram/my_sdram_ctrl/u_mig_7series_1_1/u_mig_7series_1_1_mig/u_ddr3_infrastructure/gen_mmcm.mmcm_i/CLKFBOUT]] -to [get_clocks -of_objects [get_pins ui_clk_inst/O]]

create_clock -period 10.000 -name VIRTUAL_clk_pll_i -waveform {0.000 5.000}
set_output_delay -clock [get_clocks VIRTUAL_clk_pll_i] -min -add_delay -0.200 [get_ports o_core_led]
set_output_delay -clock [get_clocks VIRTUAL_clk_pll_i] -max -add_delay 0.200 [get_ports o_core_led]
create_clock -period 70.000 -name VIRTUAL_clk_28 -waveform {0.000 30.000}
set_output_delay -clock [get_clocks VIRTUAL_clk_28] -min -add_delay -0.200 [get_ports {o_leds[*]}]
set_output_delay -clock [get_clocks VIRTUAL_clk_28] -max -add_delay -0.200 [get_ports {o_leds[*]}]
set_output_delay -clock [get_clocks VIRTUAL_clk_pll_i] -min -add_delay -0.200 [get_ports ddr3_reset_n]
set_output_delay -clock [get_clocks VIRTUAL_clk_pll_i] -max -add_delay -0.200 [get_ports ddr3_reset_n]
set_output_delay -clock [get_clocks VIRTUAL_clk_pll_i] -min -add_delay -0.200 [get_ports init_calib_complete]
set_output_delay -clock [get_clocks VIRTUAL_clk_pll_i] -max -add_delay -0.200 [get_ports init_calib_complete]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets ui_clk]

set_false_path -from [get_pins -hierarchical -regexp {.*my_sdram/my_sdram_ctrl/u_mig_7series_1_1/u_mig_7series_1_1_mig/temp_mon_enabled.u_tempmon/xadc_supplied_temperature.temperature_reg\[[0-9]*\]/C.*}] -to [get_pins -hierarchical -regexp {.*my_sdram/my_sdram_ctrl/u_mig_7series_1_1/u_mig_7series_1_1_mig/temp_mon_enabled.u_tempmon/device_temp_sync_r1_reg\[[0-9]*\]/D.*}]
