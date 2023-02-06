// Copyright 2023 Takashi Toyoshima <toyoshim@gmail.com>.
// Use of this source code is governed by a BSD-style license that can be found
// in the LICENSE file.

module SampleLatch(i_clk, i_data, i_ad_latch, i_i2s_latch, o_data);
	input i_clk;
	input i_data;
	input i_ad_latch;
	input i_i2s_latch;
	output [17:0] o_data;
	
	reg [17:0] r_shift;
	reg [16:0] r_latch;
	reg [16:0] r_data;
	
	assign o_data = { r_data, 1'b0 };
	
	always @ (posedge i_clk) begin
		r_shift <= { r_shift[16:0], i_data };
		if (i_ad_latch) begin
			r_latch <= r_shift[17:1];
		end
		if (i_i2s_latch) begin
			r_data <= r_latch;
		end
	end
endmodule
