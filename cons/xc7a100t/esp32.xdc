# 
# Paul Honig 2020
#
# I/O Board
# Open AARS board V2
#
# Core board
# QMTech Artix-7XC7A100T Core Board

# SPI

# clock
set_property PACKAGE_PIN D5 [get_ports i_vspi_clk]
set_property IOSTANDARD LVCMOS33 [get_ports i_vspi_clk]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets {i_vspi_clk_IBUF}]

# data
set_property PACKAGE_PIN D1 [get_ports i_vspi_mosi]
set_property IOSTANDARD LVCMOS33 [get_ports i_vspi_mosi]
set_property PACKAGE_PIN B1 [get_ports io_vspi_miso]
set_property IOSTANDARD LVCMOS33 [get_ports io_vspi_miso]
set_property PACKAGE_PIN E2 [get_ports i_vspi_cs]
set_property IOSTANDARD LVCMOS33 [get_ports i_vspi_cs]

# FPGA to ESP32 Interrupt pin
set_property PACKAGE_PIN N3 [get_ports o_esp_int] 
set_property IOSTANDARD LVCMOS33 [get_ports o_esp_int]

# I2C pins
# Bus to the ADV7511 and the Max9850
set_property PACKAGE_PIN M2 [get_ports i_i2c_scl] 
set_property IOSTANDARD LVCMOS33 [get_ports i_i2c_scl]
set_property PACKAGE_PIN N2 [get_ports io_i2c_sda] 
set_property IOSTANDARD LVCMOS33 [get_ports io_i2c_sda]