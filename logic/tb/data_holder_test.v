// Copyright 2023 Takashi Toyoshima <toyoshim@gmail.com>.
// Use of this source code is governed by a BSD-style license that can be found
// in the LICENSE file.

`timescale 100ps/100ps

module DataHolderTest;
  reg r_clk;
  reg r_latch;
  reg r_data_l;
  reg r_data_r;

  wire [15:0] w_data_l;
  wire [15:0] w_data_r;

  DataHolder dut(
    .i_clk(r_clk),
    .i_latch(r_latch),
    .i_data_l(r_data_l),
    .i_data_r(r_data_r),
    .o_data_l(w_data_l),
    .o_data_r(w_data_r));

  always #1 r_clk = !r_clk;

  initial begin
    $dumpfile("data_holder_test.vcd");
    $dumpvars(0, dut);

    r_clk <= 1'b0;
    r_latch <= 1'b1;
    r_data_l = 1'b0;
    r_data_r = 1'b0;

    #2

    r_latch <= 1'b0;

    #28

    r_data_l <= 1'b1;
    #2
    r_data_l <= 1'b0;
    #2

    r_latch <= 1'b1;

    r_data_l <= 1'b1;
    #2
    r_data_l <= 1'b0;
    #2
    r_data_l <= 1'b1;
    #2
    r_data_l <= 1'b0;
    #2
    r_data_l <= 1'b1;
    #2
    r_data_l <= 1'b0;
    #2
    r_data_r <= 1'b1;
    #2
    r_data_r <= 1'b0;
    #2
    r_data_r <= 1'b1;
    #2
    r_data_r <= 1'b0;
    #2
    r_data_r <= 1'b1;
    #2
    r_data_r <= 1'b0;
    #2
    r_data_r <= 1'b1;
    #2
    r_data_r <= 1'b0;
    #2
    r_data_l <= 1'b0;
    r_data_r <= 1'b0;
    #4

    r_latch <= 1'b0;

    #28

    r_data_r <= 1'b1;
    #2
    r_data_r <= 1'b0;
    #2

    r_latch <= 1'b1;

    r_data_r <= 1'b1;
    #2
    r_data_r <= 1'b0;
    #2
    r_data_r <= 1'b1;
    #2
    r_data_r <= 1'b0;
    #2
    r_data_r <= 1'b1;
    #2
    r_data_r <= 1'b0;
    #2

    r_data_l <= 1'b1;
    #2
    r_data_l <= 1'b0;
    #2
    r_data_l <= 1'b1;
    #2
    r_data_l <= 1'b0;
    #2
    r_data_l <= 1'b1;
    #2
    r_data_l <= 1'b0;
    #2
    r_data_l <= 1'b1;
    #2
    r_data_l <= 1'b0;
    #2
    r_data_l <= 1'b0;
    r_data_r <= 1'b0;
    #4

    r_latch <= 1'b0;

    $finish;
  end
endmodule
