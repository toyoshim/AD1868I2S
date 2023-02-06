// Copyright 2023 Takashi Toyoshima <toyoshim@gmail.com>.
// Use of this source code is governed by a BSD-style license that can be found
// in the LICENSE file.

module epm3064_2(i_sync_clk, i_i2s_bclk, i_ad_latch_pulse, i_ad_data_l, i_i2s_latch, i_i2s_data_r, o_i2s_lrclk, o_i2s_sdata, o_i2s_latch);
	input i_sync_clk;  //  1.536 MHz
	input i_i2s_bclk;

	input i_ad_latch_pulse;
	input i_ad_data_l;
	input i_i2s_latch;
	input [17:0] i_i2s_data_r;

	output o_i2s_lrclk;
	output o_i2s_sdata;
	output o_i2s_latch;
	
	wire [17:0] w_i2s_data_l;
	
	SampleLatch data_r(
		.i_clk(i_sync_clk),
		.i_data(i_ad_data_l),
		.i_ad_latch(i_ad_latch_pulse),
		.i_i2s_latch(o_i2s_latch),
		.o_data(w_i2s_data_l));

	I2sEncoder i2s_encoder(
		.i_rst_x  (1'b1),
		.i_bclk   (i_i2s_bclk),
      .i_data_l (w_i2s_data_l[17:2]),
      .i_data_r (i_i2s_data_r[17:2]),
      .o_lrclk  (o_i2s_lrclk),
      .o_sdata  (o_i2s_sdata),
      .o_latch  (o_i2s_latch));

endmodule
