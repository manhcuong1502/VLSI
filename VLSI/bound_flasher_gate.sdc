# Set the current design
current_design bound_flasher

create_clock -name "clk" -add -period 5.0 -waveform {0.0 2.5} [get_ports clk]

set_input_delay  -clock [get_clocks clk] -add_delay 2.5 [get_ports flick]
set_input_delay  -clock [get_clocks clk] -add_delay 2.5 [get_ports reset]
set_output_delay -clock [get_clocks clk] -add_delay 2.5 [get_ports leds]

set_max_fanout 15.000 [current_design]

set_max_transition 1.2 [current_design]
