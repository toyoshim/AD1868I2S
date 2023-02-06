// Copyright 2023 Takashi Toyoshima <toyoshim@gmail.com>.
// Use of this source code is governed by a BSD-style license that can be found
// in the LICENSE file.

`timescale 100ps/100ps

module SampleLatchTest;
  reg r_clk;
  reg r_data;
  reg r_ad_latch;
  reg r_ad_latch_d;
  reg r_i2s_latch;

  wire [17:0] w_data;
  wire w_ad_latch;

  always @ (posedge r_clk) begin
    r_ad_latch_d <= r_ad_latch;
  end

  assign w_ad_latch = r_ad_latch_d & !r_ad_latch;

  SampleLatch dut(
    .i_clk(r_clk),
    .i_data(r_data),
    .i_ad_latch(w_ad_latch),
    .i_i2s_latch(r_i2s_latch),
    .o_data(w_data));

  always #1 r_clk = !r_clk;

  initial begin
    $dumpfile("sample_latch_test.vcd");
    $dumpvars(0, dut);
    $dumpvars(0, r_ad_latch);

    r_clk <= 1'b0;
    r_data = 1'b0;
    r_ad_latch <= 1'b1;
    r_i2s_latch <= 1'b0;

    #2

    r_ad_latch <= 1'b0;

    #28

    r_data <= 1'b1;
    #2
    r_data <= 1'b0;
    #2

    r_ad_latch <= 1'b1;

    r_data <= 1'b1;
    #2
    r_data <= 1'b0;
    #2
    r_data <= 1'b1;
    #2
    r_data <= 1'b0;
    #2
    r_data <= 1'b1;
    #2
    r_data <= 1'b0;
    #2
    r_data <= 1'b1;
    #2
    r_data <= 1'b0;
    #2
    r_data <= 1'b1;
    #2
    r_data <= 1'b0;
    #2
    r_data <= 1'b1;
    #2
    r_data <= 1'b0;
    #2
    r_data <= 1'b1;
    #2
    r_data <= 1'b0;
    #2
    r_data <= 1'b0;
    #4

    r_ad_latch <= 1'b0;

    #28

    r_data <= 1'b1;
    #2
    r_data <= 1'b0;
    #2

    r_ad_latch <= 1'b1;

    r_data <= 1'b1;
    #2
    r_data <= 1'b0;
    #2
    r_data <= 1'b1;
    #2
    r_data <= 1'b0;
    #2
    r_data <= 1'b1;
    #2
    r_data <= 1'b0;
    #1
    r_i2s_latch <= 1'b1;
    #1

    r_data <= 1'b1;
    #1
    r_i2s_latch <= 1'b0;
    #1
    r_data <= 1'b0;
    #2
    r_data <= 1'b1;
    #2
    r_data <= 1'b0;
    #2
    r_data <= 1'b1;
    #2
    r_data <= 1'b0;
    #2
    r_data <= 1'b1;
    #2
    r_data <= 1'b0;
    #2
    r_data <= 1'b0;
    #4

    r_ad_latch <= 1'b0;

    $finish;
  end
endmodule
