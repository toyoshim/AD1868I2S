// Copyright 2023 Takashi Toyoshima <toyoshim@gmail.com>.
// Use of this source code is governed by a BSD-style license that can be found
// in the LICENSE file.

module epm3064_1(i_ad_clk, i_i2s_mclk, i_ad_latch, i_ad_data_r, i_i2s_latch, o_i2s_data_r, o_i2s_bclk, o_sync_clk, o_ad_latch_pulse);
	input i_ad_clk;      //  1.536 MHz
	input i_i2s_mclk;    // 24.576 MHz

	input i_ad_latch;
	input i_ad_data_r;
	input i_i2s_latch;

	output [17:0] o_i2s_data_r;
	output o_i2s_bclk;
	output o_sync_clk;
	output o_ad_latch_pulse;
	
	reg [1:0] r_ad_clk;
	reg r_ad_latch;
	reg [1:0] r_i2s_bclk;
	
	assign o_sync_clk = r_ad_clk[1];
	assign o_ad_latch_pulse = r_ad_latch & !i_ad_latch;
	assign o_i2s_bclk = r_i2s_bclk[1];
	
	always @ (posedge i_i2s_mclk) begin
		r_ad_clk <= { r_ad_clk[0], i_ad_clk };
		r_i2s_bclk <= r_i2s_bclk + 2'b01;
	end
	
	always @ (posedge o_sync_clk) begin
		r_ad_latch <= i_ad_latch;
	end
	
	SampleLatch data_r(
		.i_clk(o_sync_clk),
		.i_data(i_ad_data_r),
		.i_ad_latch(o_ad_latch_pulse),
		.i_i2s_latch(i_i2s_latch),
		.o_data(o_i2s_data_r));
endmodule
