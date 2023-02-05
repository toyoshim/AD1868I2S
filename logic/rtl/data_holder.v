// Copyright 2023 Takashi Toyoshima <toyoshim@gmail.com>.
// Use of this source code is governed by a BSD-style license that can be found
// in the LICENSE file.

// Practical input signal on 054986A;
// LR/LL :  L  L  L  L  L  L  L  L  L  L  L  L  L  L  L  L  H  H  H  H  H  H  H  H  H  H  H  H  H  H  H  H
// DR/DL : NA NA NA NA NA NA NA NA NA NA NA NA NA NA 17 16 15 14 13 12 11 10  9  8  7  6  5  4  3  2  1  0
// DATA[17:0] is signed value, and DATA[0] seems always 0, and practical sampling width is 17-bits.
module DataHolder(i_clk, i_latch, i_data_l, i_data_r, o_data_l, o_data_r);

	input i_clk;
	input i_latch;
	input i_data_r;
	input i_data_l;

	output [15:0] o_data_l;
	output [15:0] o_data_r;
	
	wire w_latchl;

	reg r_latch_d;
	reg [17:0] r_shift_l;
	reg [17:0] r_shift_r;
	reg [17:0] r_data_l;
	reg [17:0] r_data_r;
	
	assign w_latch = r_latch_d & !i_latch;
	assign o_data_l = r_data_l[17:2];
	assign o_data_r = r_data_r[17:2];
	
	always @ (posedge i_clk) begin
		r_latch_d <= i_latch;
	end
	
	always @ (posedge i_clk) begin
		r_shift_l <= { r_shift_l[16:0], i_data_l };
		r_shift_r <= { r_shift_r[16:0], i_data_r };
		if (w_latch) begin
			r_data_l <= r_shift_l;
			r_data_r <= r_shift_r;
		end
	end

endmodule
