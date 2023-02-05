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
	
	wire [15:0] w_data_l;
	wire [15:0] w_data_r;
	wire [15:0] w_en;

	reg [4:0] r_count;
	reg r_latch_d;
	reg r_data;
	
	assign o_data_l = w_data_l;
	assign o_data_r = w_data_r;
	
	always @ (posedge i_clk) begin
		r_latch_d <= i_latch;
	end

	always @ (posedge i_clk) begin
		if (r_latch_d & !i_latch) begin
			r_count <= 5'b00000;
		end else begin
			r_count <= r_count + 5'b00001;
		end
	end
	
	assign w_en = {
		r_count == 5'b01101,  // 13
		r_count == 5'b01110,  // 14
		r_count == 5'b01111,  // 15
		r_count == 5'b10000,  // 16
		r_count == 5'b10001,  // 17
		r_count == 5'b10010,  // 18
		r_count == 5'b10011,  // 19
		r_count == 5'b10100,  // 20
		r_count == 5'b10101,  // 21
		r_count == 5'b10110,  // 22
		r_count == 5'b10111,  // 23
		r_count == 5'b11000,  // 24
		r_count == 5'b11001,  // 25
		r_count == 5'b11010,  // 26
		r_count == 5'b11011,  // 27
		r_count == 5'b11100   // 28
	};

	generate
		genvar i;
		for (i = 0; i < 16; i = i + 1) begin: data
			BitHolder l(i_clk, w_en[i], i_data_l, w_data_l[i]);
			BitHolder r(i_clk, w_en[i], i_data_r, w_data_r[i]);
		end
	endgenerate

endmodule
