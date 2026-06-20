## Clock
set_property PACKAGE_PIN W5 [get_ports clk_50m]
set_property IOSTANDARD LVCMOS33 [get_ports clk_50m]

## Reset Button
set_property PACKAGE_PIN U18 [get_ports rst_btn]

## Traffic LEDs
set_property PACKAGE_PIN U16 [get_ports NS_G]
set_property PACKAGE_PIN E19 [get_ports NS_Y]
set_property PACKAGE_PIN U19 [get_ports NS_R]

set_property PACKAGE_PIN V19 [get_ports EW_G]
set_property PACKAGE_PIN W18 [get_ports EW_Y]
set_property PACKAGE_PIN U15 [get_ports EW_R]

## Pedestrian LEDs
set_property PACKAGE_PIN V14 [get_ports PED_WALK]
set_property PACKAGE_PIN V13 [get_ports PED_DONT]