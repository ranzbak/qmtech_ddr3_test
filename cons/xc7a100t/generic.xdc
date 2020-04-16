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
set_property SEVERITY {Warning} [get_drc_checks NSTD-1]
set_property SEVERITY {Warning} [get_drc_checks UCIO-1]

# Core board

# Clock oscillator
set_property PACKAGE_PIN U22 [get_ports i_clk]
set_property IOSTANDARD LVCMOS33 [get_ports i_clk]
# Reset button
# Included here to be complete 
#set_property PACKAGE_PIN AE16 [get_ports i_sw1_n]
#set_property IOSTANDARD LVCMOS33 [get_ports i_sw1_n]
# Reset button
set_property PACKAGE_PIN H19 [get_ports i_sw2_n]
set_property IOSTANDARD LVCMOS33 [get_ports i_sw2_n]
# Core board LED
set_property PACKAGE_PIN J19 [get_ports o_core_led]
set_property IOSTANDARD LVCMOS33 [get_ports o_core_led]