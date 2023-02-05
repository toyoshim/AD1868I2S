// Copyright 2023 Takashi Toyoshima <toyoshim@gmail.com>.
// Use of this source code is governed by a BSD-style license that can be found
// in the LICENSE file.

// MCLK: 24.576 MHz
// BCLK:  6.144 MHz
// LR  : 96     KHZ
// I2S format.
module I2sEncoder(i_rst_x, i_mclk, i_data_l, i_data_r, o_bclk, o_lrclk, o_sdata);

	input i_rst_x;
	input i_mclk;
	input[15:0] i_data_l;
	input[15:0] i_data_r;

	output o_bclk;
	output o_lrclk;
	output o_sdata;
	
	reg [1:0] r_clkdiv;
	reg [5:0] r_count;
	reg [15:0] r_data_l;
	reg [15:0] r_data_r;
	
	wire w_clk;
	
	assign w_clk = !r_clkdiv[1];
	assign o_bclk = r_clkdiv[1];
	assign o_lrclk = r_count[5];
	
	always @ (posedge i_mclk or negedge i_rst_x) begin
		if (!i_rst_x) begin
			r_clkdiv <= 2'b00;
		end else begin
			r_clkdiv <= r_clkdiv + 2'b01;
		end
	end
	
	always @ (posedge w_clk or negedge i_rst_x) begin
		if (!i_rst_x) begin
			r_count <= 6'b000000;
		end else begin
			r_count <= r_count + 6'b000001;
		end
	end

	always @ (posedge w_clk) begin
		if (r_count == 6'b000000) begin
			r_data_l <= i_data_l;
			r_data_r <= i_data_r;
		end
	end

	function select;
		input [31:0] data;
		input [5:0] count;
		begin
			case (count)
				6'b000001: select = data[31];
				6'b000010: select = data[30];
				6'b000011: select = data[29];
				6'b000100: select = data[28];
				6'b000101: select = data[27];
				6'b000110: select = data[26];
				6'b000111: select = data[25];
				6'b001000: select = data[24];
				6'b001001: select = data[23];
				6'b001010: select = data[22];
				6'b001011: select = data[21];
				6'b001100: select = data[20];
				6'b001101: select = data[19];
				6'b001110: select = data[18];
				6'b001111: select = data[17];
				6'b010000: select = data[16];
				6'b100001: select = data[15];
				6'b100010: select = data[14];
				6'b100011: select = data[13];
				6'b100100: select = data[12];
				6'b100101: select = data[11];
				6'b100110: select = data[10];
				6'b100111: select = data[9];
				6'b101000: select = data[8];
				6'b101001: select = data[7];
				6'b101010: select = data[6];
				6'b101011: select = data[5];
				6'b101100: select = data[4];
				6'b101101: select = data[3];
				6'b101110: select = data[2];
				6'b101111: select = data[1];
				6'b110000: select = data[0];
				default: select = 1'b0;
			endcase
		end
	endfunction

	assign o_sdata = select({r_data_l, r_data_r}, r_count);

endmodule
