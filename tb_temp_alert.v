`timescale 1ns/1ns

module tb_temp_alert;
    reg [7:0] temperature;
    wire alert;

    // Instantiate the DUT
    temp_alert uut (
        .temperature(temperature),
        .alert(alert)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_temp_alert);

        temperature = 8'd45; #10;
        temperature = 8'd51; #10;
        temperature = 8'd50; #10;
        temperature = 8'd60; #10;
        temperature = 8'd30; #10;

        $finish;
    end
endmodule
