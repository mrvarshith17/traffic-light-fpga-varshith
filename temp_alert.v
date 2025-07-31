// temp_alert.v
module temp_alert(
    input [7:0] temperature,
    output reg alert
);
    always @(*) begin
        if (temperature > 8'd50)
            alert = 1'b1;
        else
            alert = 1'b0;
    end
endmodule
