# 
# Paul Honig 2020
#
# I/O Board
# Open AARS board V2
#
# Core board
# QMTech Artix-7XC7A100T Core Board

# CLOCK AND ENABLE SIGNALS
set_property PACKAGE_PIN G26 [get_ports o_adv_de]
set_property IOSTANDARD LVCMOS33 [get_ports o_adv_de]
set_property PACKAGE_PIN L23 [get_ports o_adv_clk]
set_property IOSTANDARD LVCMOS33 [get_ports o_adv_clk]
set_property DRIVE 8 [get_ports o_adv_clk]

# SYNC SIGNALS
set_property PACKAGE_PIN D25 [get_ports o_hsync]
set_property IOSTANDARD LVCMOS33 [get_ports o_hsync]
set_property PACKAGE_PIN D26 [get_ports o_vsync]
set_property IOSTANDARD LVCMOS33 [get_ports o_vsync]

# RED PIXEL DATA
set_property PACKAGE_PIN E1 [get_ports {o_r[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports o_r[0]]
set_property PACKAGE_PIN C1 [get_ports {o_r[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports o_r[1]]
set_property PACKAGE_PIN E5 [get_ports {o_r[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports o_r[2]]
set_property PACKAGE_PIN C4 [get_ports {o_r[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports o_r[3]]
set_property PACKAGE_PIN B2 [get_ports {o_r[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports o_r[4]]
set_property PACKAGE_PIN A3 [get_ports {o_r[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports o_r[5]]
set_property PACKAGE_PIN B4 [get_ports {o_r[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports o_r[6]]
set_property PACKAGE_PIN B5 [get_ports {o_r[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports o_r[7]]

# GREEN PIXEL DATA
set_property PACKAGE_PIN M26 [get_ports {o_g[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports o_g[0]]
set_property PACKAGE_PIN P26 [get_ports {o_g[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports o_g[1]]
set_property PACKAGE_PIN H9 [get_ports {o_g[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports o_g[2]]
set_property PACKAGE_PIN H2 [get_ports {o_g[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports o_g[3]]
set_property PACKAGE_PIN J4 [get_ports {o_g[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports o_g[4]]
set_property PACKAGE_PIN G2 [get_ports {o_g[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports o_g[5]]
set_property PACKAGE_PIN G4 [get_ports {o_g[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports o_g[6]]
set_property PACKAGE_PIN F2 [get_ports {o_g[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports o_g[7]]

# BLUE PIXEL DATA
set_property PACKAGE_PIN E23 [get_ports {o_b[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports o_b[0]]
set_property PACKAGE_PIN F22 [get_ports {o_b[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports o_b[1]]
set_property PACKAGE_PIN J26 [get_ports {o_b[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports o_b[2]]
set_property PACKAGE_PIN G21 [get_ports {o_b[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports o_b[3]]
set_property PACKAGE_PIN H22 [get_ports {o_b[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports o_b[4]]
set_property PACKAGE_PIN J21 [get_ports {o_b[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports o_b[5]]
set_property PACKAGE_PIN K26 [get_ports {o_b[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports o_b[6]]
set_property PACKAGE_PIN K23 [get_ports {o_b[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports o_b[7]]
