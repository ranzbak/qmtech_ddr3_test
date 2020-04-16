# 
# Paul Honig 2020
#
# I/O Board
# Open AARS board V2
#
# Core board
# QMTech Artix-7XC7A100T Core Board

# I2S audio interface MAX9850
set_property PACKAGE_PIN AC26 [get_ports o_i2c_lrclk]
set_property IOSTANDARD LVCMOS33 [get_ports o_i2c_lrclk]
set_property PACKAGE_PIN Y26 [get_ports o_i2c_sclk]
set_property IOSTANDARD LVCMOS33 [get_ports o_i2c_sclk]
set_property PACKAGE_PIN AA25 [get_ports o_i2c_s0]
set_property IOSTANDARD LVCMOS33 [get_ports o_i2c_s0]
