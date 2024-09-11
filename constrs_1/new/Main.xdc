#button

set_property PACKAGE_PIN T17 [get_ports {BTNR}]
    set_property IOSTANDARD LVCMOS33 [get_ports {BTNR}]
set_property PACKAGE_PIN W19 [get_ports {BTNL}]
    set_property IOSTANDARD LVCMOS33 [get_ports {BTNL}]
    
#LEDs

set_property PACKAGE_PIN U16 [get_ports {LED[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED[0]}]
set_property PACKAGE_PIN E19 [get_ports {LED[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED[1]}]
    
    
    
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]