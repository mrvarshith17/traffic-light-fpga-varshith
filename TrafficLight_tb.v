`timescale 1ns/1ps
module TrafficLight_tb;
  reg clk;
  reg reset;
  wire red1, yellow1, green1;
  wire red2, yellow2, green2;
  wire red3, yellow3, green3;
  wire red4, yellow4, green4;

  // Instantiate the traffic light controller module
  traffic_light_4road dut (
    .clk(clk),
    .reset(reset),
    .red1(red1), .yellow1(yellow1), .green1(green1),
    .red2(red2), .yellow2(yellow2), .green2(green2),
    .red3(red3), .yellow3(yellow3), .green3(green3),
    .red4(red4), .yellow4(yellow4), .green4(green4)
  );

  initial begin
    // Dump waveform to a file for GTKWave
    $dumpfile("traffic_light.vcd");
    $dumpvars(0, TrafficLight_tb);
    // Run long enough to see two full cycles of 8 states (8 states * 10ns each = 80ns; here we use 200ns)
    #200 $finish;
  end

  initial begin
    // Initialize clock and assert reset briefly
    clk = 0;
    reset = 1;
    #10 reset = 0;
  end

  // 10 ns clock period: toggle every 5ns
  always #5 clk = ~clk;
endmodule
