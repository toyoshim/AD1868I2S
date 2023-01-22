// Copyright 2023 Takashi Toyoshima <toyoshim@gmail.com>.
// Use of this source code is governed by a BSD-style license that can be found
// in the LICENSE file.

// MCLK: 24.576 MHz
// BCLK: 12.288 MHz
// 128fs, I2S format.
module I2sEncoder(i_rst_x, i_mclk, i_data_l, i_data_r, o_bclk, o_lrclk, o_sdata);

	input i_rst_x;
	input i_mclk;
	input[15:0] i_data_l;
	input[15:0] i_data_r;

	output o_bclk;
	output o_lrclk;
	output o_sdata;
	
	reg r_bclk;
	reg [6:0] r_count;
	
	wire w_clk;
	
	assign w_clk = !r_bclk;
	assign o_bclk = r_bclk;
	assign o_lrclk = r_count[6];
	
	always @ (posedge i_mclk or negedge i_rst_x) begin
		if (!i_rst_x) begin
			r_bclk <= 1'b0;
		end else begin
			r_bclk <= !r_bclk;
		end
	end
	
	always @ (posedge w_clk or negedge i_rst_x) begin
		if (!i_rst_x) begin
			r_count <= 7'b0000000;
		end else begin
			r_count <= r_count + 7'b0000001;
		end
	end

	function select;
		input [31:0] data;
		input [6:0] count;
		begin
			case (count)
				7'b0000001: select = data[31];
				7'b0000010: select = data[30];
				7'b0000011: select = data[29];
				7'b0000100: select = data[28];
				7'b0000101: select = data[27];
				7'b0000110: select = data[26];
				7'b0000111: select = data[25];
				7'b0001000: select = data[24];
				7'b0001001: select = data[23];
				7'b0001010: select = data[22];
				7'b0001011: select = data[21];
				7'b0001100: select = data[20];
				7'b0001101: select = data[19];
				7'b0001110: select = data[18];
				7'b0001111: select = data[17];
				7'b0010000: select = data[16];
				7'b1000001: select = data[15];
				7'b1000010: select = data[14];
				7'b1000011: select = data[13];
				7'b1000100: select = data[12];
				7'b1000101: select = data[11];
				7'b1000110: select = data[10];
				7'b1000111: select = data[9];
				7'b1001000: select = data[8];
				7'b1001001: select = data[7];
				7'b1001010: select = data[6];
				7'b1001011: select = data[5];
				7'b1001100: select = data[4];
				7'b1001101: select = data[3];
				7'b1001110: select = data[2];
				7'b1001111: select = data[1];
				7'b1010000: select = data[0];
				default: select = 1'b0;
			endcase
		end
	endfunction

	assign o_sdata = select({i_data_l, i_data_r}, r_count);

endmodule
