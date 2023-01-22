# Clock information fyi though TimeQuest doesn't support timing analysis on this device family.
create_clock -name ad_clk -period 8MHz [get_ports i_ad_clk]
create_clock -name i2s_mclk -period 24.576MHz [get_ports i_i2s_mclk]
create_generated_clock -name i2s_bclk -source [get_ports i_i2s_mclk] -divide_by 2 [get_pins I2sEncoder:i2s_encoder|r_bclk]
