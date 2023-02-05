// Copyright 2023 Takashi Toyoshima <toyoshim@gmail.com>.
// Use of this source code is governed by a BSD-style license that can be found
// in the LICENSE file.

module AD1868I2C(i_ad_clk, i_i2s_mclk, i_ad_data_l, i_ad_latch_l, i_ad_data_r, i_ad_latch_r, o_i2s_bclk, o_i2s_lrclk, o_i2s_sdata);
	input i_ad_clk;      //  1.536 MHz
	input i_i2s_mclk;    // 24.576 MHz

	input i_ad_data_l;
	input i_ad_data_r;
	input i_ad_latch_l;
	input i_ad_latch_r;  // not used (expect i_ad_latch_l == i_ad_latch_r)

	output o_i2s_bclk;
	output o_i2s_lrclk;
	output o_i2s_sdata;
	
	wire [15:0] w_data_l;
	wire [15:0] w_data_r;
	
	reg [1:0] r_ad_clk;
	
	always @ (posedge i_i2s_mclk) begin
		r_ad_clk <= { r_ad_clk[0], i_ad_clk };
	end

	DataHolder data_holder(
		.i_clk    (r_ad_clk[1]),
		.i_latch  (i_ad_latch_l),
		.i_data_l (i_ad_data_l),
		.i_data_r (i_ad_data_r),
		.o_data_l (w_data_l),
		.o_data_r (w_data_r));
	
	I2sEncoder i2s_encoder(
		.i_rst_x  (1'b1),
		.i_mclk   (i_i2s_mclk),
		.i_data_l (w_data_l),
		.i_data_r (w_data_r),
		.o_bclk   (o_i2s_bclk),
		.o_lrclk  (o_i2s_lrclk),
		.o_sdata  (o_i2s_sdata));
endmodule
