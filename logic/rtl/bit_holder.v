// Copyright 2023 Takashi Toyoshima <toyoshim@gmail.com>.
// Use of this source code is governed by a BSD-style license that can be found
// in the LICENSE file.

module BitHolder(i_clk, i_en, i_data, o_data);

	input i_clk;
	input i_en;
	input i_data;

	output o_data;

	reg r_data;
	
	assign o_data = r_data;

	always @ (posedge i_clk) begin
		if (i_en) begin
			r_data <= i_data;
		end
	end

endmodule
