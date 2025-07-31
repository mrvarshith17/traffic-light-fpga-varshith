// traffic_lights.v
module traffic_lights(
    input  wire clk,
    input  wire reset,
    // Road 1 → {2,3,4}
    output reg R1_L_red, R1_L_yellow, R1_L_green,
    output reg R1_S_red, R1_S_yellow, R1_S_green,
    output reg R1_R_red, R1_R_yellow, R1_R_green,
    // Road 2
    output reg R2_L_red, R2_L_yellow, R2_L_green,
    output reg R2_S_red, R2_S_yellow, R2_S_green,
    output reg R2_R_red, R2_R_yellow, R2_R_green,
    // Road 3
    output reg R3_L_red, R3_L_yellow, R3_L_green,
    output reg R3_S_red, R3_S_yellow, R3_S_green,
    output reg R3_R_red, R3_R_yellow, R3_R_green,
    // Road 4
    output reg R4_L_red, R4_L_yellow, R4_L_green,
    output reg R4_S_red, R4_S_yellow, R4_S_green,
    output reg R4_R_red, R4_R_yellow, R4_R_green
);

    // Phase definitions: green, yellow, buffer for 4 main groups
    localparam PH1_G = 0, PH1_Y = 1, BUF1 = 2,
               PH2_G = 3, PH2_Y = 4, BUF2 = 5,
               PH3_G = 6, PH3_Y = 7, BUF3 = 8,
               PH4_G = 9, PH4_Y = 10, BUF4 = 11;

    reg [3:0] state;
    reg [7:0] cnt, limit;

    // Timing parameters
    localparam T_GREEN  = 30;
    localparam T_YELLOW = 5;
    localparam T_BUF    = 5;

    // FSM sequential logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= PH1_G;
            cnt   <= 0;
        end else begin
            // choose duration
            if (state % 3 == 0)       limit = T_GREEN;  // G phases
            else if (state % 3 == 1)  limit = T_YELLOW; // Y phases
            else                       limit = T_BUF;    // Buffer

            if (cnt < limit - 1)
                cnt <= cnt + 1;
            else begin
                cnt <= 0;
                state <= (state == BUF4) ? PH1_G : state + 1;
            end
        end
    end

    // Output logic: default red, then override
    always @(*) begin
        // default all red
        {R1_L_red,R1_S_red,R1_R_red,
         R2_L_red,R2_S_red,R2_R_red,
         R3_L_red,R3_S_red,R3_R_red,
         R4_L_red,R4_S_red,R4_R_red} = {12{1'b1}};
        {R1_L_yellow,R1_S_yellow,R1_R_yellow,
         R2_L_yellow,R2_S_yellow,R2_R_yellow,
         R3_L_yellow,R3_S_yellow,R3_R_yellow,
         R4_L_yellow,R4_S_yellow,R4_R_yellow} = {12{1'b0}};
        {R1_L_green,R1_S_green,R1_R_green,
         R2_L_green,R2_S_green,R2_R_green,
         R3_L_green,R3_S_green,R3_R_green,
         R4_L_green,R4_S_green,R4_R_green} = {12{1'b0}};

        case(state)
            // Phase 1: R1_S, R1_L, R3_S, R3_L green/yellow
            PH1_G: begin R1_S_green=1; R1_S_red=0;
                     R1_L_green=1; R1_L_red=0;
                     R3_S_green=1; R3_S_red=0;
                     R3_L_green=1; R3_L_red=0; end
            PH1_Y: begin R1_S_yellow=1; R1_S_red=0;
                     R1_L_yellow=1; R1_L_red=0;
                     R3_S_yellow=1; R3_S_red=0;
                     R3_L_yellow=1; R3_L_red=0; end

            // Phase 2: R1_R, R2_R
            PH2_G: begin R1_R_green=1; R1_R_red=0;
                     R2_R_green=1; R2_R_red=0; end
            PH2_Y: begin R1_R_yellow=1; R1_R_red=0;
                     R2_R_yellow=1; R2_R_red=0; end

            // Phase 3: R2_S, R2_L, R4_S, R4_L
            PH3_G: begin R2_S_green=1; R2_S_red=0;
                     R2_L_green=1; R2_L_red=0;
                     R4_S_green=1; R4_S_red=0;
                     R4_L_green=1; R4_L_red=0; end
            PH3_Y: begin R2_S_yellow=1; R2_S_red=0;
                     R2_L_yellow=1; R2_L_red=0;
                     R4_S_yellow=1; R4_S_red=0;
                     R4_L_yellow=1; R4_L_red=0; end

            // Phase 4: R3_R, R4_R
            PH4_G: begin R3_R_green=1; R3_R_red=0;
                     R4_R_green=1; R4_R_red=0; end
            PH4_Y: begin R3_R_yellow=1; R3_R_red=0;
                     R4_R_yellow=1; R4_R_red=0; end
            default: ;
        endcase
    end
endmodule