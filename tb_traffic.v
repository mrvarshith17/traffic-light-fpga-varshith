// tb_traffic.v
`timescale 1ns/1ps
module tb_traffic;
    reg clk = 0;
    reg reset;
    // Wires for movement signals
    wire R1_L_red, R1_L_yellow, R1_L_green;
    wire R1_S_red, R1_S_yellow, R1_S_green;
    wire R1_R_red, R1_R_yellow, R1_R_green;
    wire R2_L_red, R2_L_yellow, R2_L_green;
    wire R2_S_red, R2_S_yellow, R2_S_green;
    wire R2_R_red, R2_R_yellow, R2_R_green;
    wire R3_L_red, R3_L_yellow, R3_L_green;
    wire R3_S_red, R3_S_yellow, R3_S_green;
    wire R3_R_red, R3_R_yellow, R3_R_green;
    wire R4_L_red, R4_L_yellow, R4_L_green;
    wire R4_S_red, R4_S_yellow, R4_S_green;
    wire R4_R_red, R4_R_yellow, R4_R_green;

    // Instantiate DUT
    traffic_lights uut (
        .clk(clk), .reset(reset),
        .R1_L_red(R1_L_red), .R1_L_yellow(R1_L_yellow), .R1_L_green(R1_L_green),
        .R1_S_red(R1_S_red), .R1_S_yellow(R1_S_yellow), .R1_S_green(R1_S_green),
        .R1_R_red(R1_R_red), .R1_R_yellow(R1_R_yellow), .R1_R_green(R1_R_green),
        .R2_L_red(R2_L_red), .R2_L_yellow(R2_L_yellow), .R2_L_green(R2_L_green),
        .R2_S_red(R2_S_red), .R2_S_yellow(R2_S_yellow), .R2_S_green(R2_S_green),
        .R2_R_red(R2_R_red), .R2_R_yellow(R2_R_yellow), .R2_R_green(R2_R_green),
        .R3_L_red(R3_L_red), .R3_L_yellow(R3_L_yellow), .R3_L_green(R3_L_green),
        .R3_S_red(R3_S_red), .R3_S_yellow(R3_S_yellow), .R3_S_green(R3_S_green),
        .R3_R_red(R3_R_red), .R3_R_yellow(R3_R_yellow), .R3_R_green(R3_R_green),
        .R4_L_red(R4_L_red), .R4_L_yellow(R4_L_yellow), .R4_L_green(R4_L_green),
        .R4_S_red(R4_S_red), .R4_S_yellow(R4_S_yellow), .R4_S_green(R4_S_green),
        .R4_R_red(R4_R_red), .R4_R_yellow(R4_R_yellow), .R4_R_green(R4_R_green)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Waveform dump
        $dumpfile("traffic_lights.vcd");
        $dumpvars(0, tb_traffic);

        // Reset pulse
        reset = 1; #10;
        reset = 0;

        // Simulate for 1000 ns
        #1000 $finish;
    end
endmodule