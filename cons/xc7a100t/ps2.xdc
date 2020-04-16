# 
# Paul Honig 2020
#
# I/O Board
# Open AARS board V2
#
# Core board
# QMTech Artix-7XC7A100T Core Board

# PS/2 port 1 (keyboard)
set_property PACKAGE_PIN W23 [get_ports i_ps2_1_clk]
set_property IOSTANDARD LVCMOS33 [get_ports i_ps2_1_clk]
set_property PACKAGE_PIN Y23 [get_ports i_ps2_1_dat]
set_property IOSTANDARD LVCMOS33 [get_ports i_ps2_1_dat]

# PS/2 port 2 (Mouse)
set_property PACKAGE_PIN W23 [get_ports i_ps2_2_clk]
set_property IOSTANDARD LVCMOS33 [get_ports i_ps2_2_clk]
set_property PACKAGE_PIN AB26 [get_ports i_ps2_2_dat]
set_property IOSTANDARD LVCMOS33 [get_ports i_ps2_2_dat]