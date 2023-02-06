// Copyright 2023 Takashi Toyoshima <toyoshim@gmail.com>.
// Use of this source code is governed by a BSD-style license that can be found
// in the LICENSE file.

`timescale 100ps/100ps

module I2sEncoderTest;
  reg r_rst_x;
  reg r_bclk;
  reg [15:0] r_data_l;
  reg [15:0] r_data_r;

  wire w_lrclk;
  wire w_sdata;
  wire w_latch;

  I2sEncoder dut(
    .i_rst_x(r_rst_x),
    .i_bclk(r_bclk),
    .i_data_l(r_data_l),
    .i_data_r(r_data_r),
    .o_lrclk(w_lrclk),
    .o_sdata(w_sdata),
    .o_latch(w_latch));

  always #1 r_bclk = !r_bclk;

  initial begin
    $dumpfile("i2s_encoder_test.vcd");
    $dumpvars(0, dut);

    r_bclk <= 1'b0;
    r_data_l <= 16'b1111000011110000;
    r_data_r <= 16'b0000111100001111;
    r_rst_x <= 1'b0;
    #1
    r_rst_x <= 1'b1;

    #768
    $finish;
  end
endmodule
