module traffic_light_4road (
    input clk,
    input reset,
    output reg red1, output reg yellow1, output reg green1,
    output reg red2, output reg yellow2, output reg green2,
    output reg red3, output reg yellow3, output reg green3,
    output reg red4, output reg yellow4, output reg green4
);
    // State encoding (3 bits)
    localparam S1_GREEN  = 3'd0;
    localparam S1_YELLOW = 3'd1;
    localparam S2_GREEN  = 3'd2;
    localparam S2_YELLOW = 3'd3;
    localparam S3_GREEN  = 3'd4;
    localparam S3_YELLOW = 3'd5;
    localparam S4_GREEN  = 3'd6;
    localparam S4_YELLOW = 3'd7;

    reg [2:0] state, next_state;

    // State register with asynchronous reset to Road1-green
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S1_GREEN;
        else
            state <= next_state;
    end

    // Next-state and output logic
    always @(*) begin
        // Default: all roads RED=1, green/yellow=0
        red1 = 1; yellow1 = 0; green1 = 0;
        red2 = 1; yellow2 = 0; green2 = 0;
        red3 = 1; yellow3 = 0; green3 = 0;
        red4 = 1; yellow4 = 0; green4 = 0;
        next_state = state;  // default stay

        case (state)
            S1_GREEN: begin
                red1 = 0; green1 = 1; yellow1 = 0;
                next_state = S1_YELLOW;
            end
            S1_YELLOW: begin
                red1 = 0; green1 = 0; yellow1 = 1;
                next_state = S2_GREEN;
            end
            S2_GREEN: begin
                red2 = 0; green2 = 1; yellow2 = 0;
                next_state = S2_YELLOW;
            end
            S2_YELLOW: begin
                red2 = 0; green2 = 0; yellow2 = 1;
                next_state = S3_GREEN;
            end
            S3_GREEN: begin
                red3 = 0; green3 = 1; yellow3 = 0;
                next_state = S3_YELLOW;
            end
            S3_YELLOW: begin
                red3 = 0; green3 = 0; yellow3 = 1;
                next_state = S4_GREEN;
            end
            S4_GREEN: begin
                red4 = 0; green4 = 1; yellow4 = 0;
                next_state = S4_YELLOW;
            end
            S4_YELLOW: begin
                red4 = 0; green4 = 0; yellow4 = 1;
                next_state = S1_GREEN;
            end
            default: begin
                // Should not occur; reset to safe state
                next_state = S1_GREEN;
            end
        endcase
    end
endmodule
