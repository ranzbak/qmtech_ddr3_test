# 
# Paul Honig 2020
#
# I/O Board
# Open AARS board V2
#
# Core board
# QMTech Artix-7XC7A100T Core Board

# Joystick 1
set_property PACKAGE_PIN N13 [get_ports {js1[5]}]       # Pot AY
set_property IOSTANDARD LVCMOS33 [get_ports {js1[5]}]
set_property PACKAGE_PIN N16 [get_ports {js1[9]}]       # Pot AX
set_property IOSTANDARD LVCMOS33 [get_ports {js1[9]}]
set_property PACKAGE_PIN P16 [get_ports {js1[4]}]       # Right
set_property IOSTANDARD LVCMOS33 [get_ports {js1[4]}]
set_property PACKAGE_PIN R16 [get_ports {js1[3]}]       # Left
set_property IOSTANDARD LVCMOS33 [get_ports {js1[3]}]
set_property PACKAGE_PIN T15 [get_ports {js1[7]}]       # +5V 
set_property IOSTANDARD LVCMOS33 [get_ports {js1[7]}]
set_property PACKAGE_PIN P14 [get_ports {js1[2]}]       # Down
set_property IOSTANDARD LVCMOS33 [get_ports {js1[2]}]
set_property PACKAGE_PIN R13 [get_ports {js1[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {js1[6]}]   # Fire
set_property PACKAGE_PIN R12 [get_ports {js1[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {js1[1]}]   # Up
# Dummy entries

set_property IOSTANDARD LVCMOS33 [get_ports {js1[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {js1[8]}]

# Joystick 2
set_property PACKAGE_PIN P9 [get_ports {js2[5]}]        # Pot AY
set_property IOSTANDARD LVCMOS33 [get_ports {js2[5]}]
set_property PACKAGE_PIN R11 [get_ports {js2[9]}]       # Pot AX
set_property IOSTANDARD LVCMOS33 [get_ports {js2[9]}]
set_property PACKAGE_PIN R10 [get_ports {js2[4]}]       # Right
set_property IOSTANDARD LVCMOS33 [get_ports {js2[4]}]
set_property PACKAGE_PIN R8 [get_ports {js2[3]}]        # Left
set_property IOSTANDARD LVCMOS33 [get_ports {js2[3]}]
set_property PACKAGE_PIN R7 [get_ports {js2[7]}]        # +5V
set_property IOSTANDARD LVCMOS33 [get_ports {js2[7]}]
set_property PACKAGE_PIN R6 [get_ports {js2[2]}]        # Down
set_property IOSTANDARD LVCMOS33 [get_ports {js2[2]}]
set_property PACKAGE_PIN R5 [get_ports {js2[6]}]        # Fire
set_property IOSTANDARD LVCMOS33 [get_ports {js2[6]}]
set_property PACKAGE_PIN M6 [get_ports {js2[1]}]        # Up
set_property IOSTANDARD LVCMOS33 [get_ports {js2[1]}]
# Dummy entries
set_property IOSTANDARD LVCMOS33 [get_ports {js2[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {js2[8]}]
