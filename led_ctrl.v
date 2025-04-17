module led_ctrl (
    input wire clk,
    input wire rst,
    input wire [31:0] duration,
    output reg led_out
);

    // Threshold for ~5cm (distance < 5 cm = duration < 3500 cycles)
    parameter THRESHOLD = 3500;

    always @(posedge clk or posedge rst) begin
        if (rst)
            led_out <= 1; // LED OFF by default (Active-low logic)
        else begin
            if (duration < THRESHOLD)
                led_out <= ~led_out; // Toggle LED if distance < 5 cm
            else
                led_out <= 1;    // Turn off LED (HIGH = OFF for active-low LED)
        end
    end

endmodule
