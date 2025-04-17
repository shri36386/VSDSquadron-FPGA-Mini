module top (
    input wire clk,              // Main clock input (e.g., 12 MHz)
    input wire rst,              // Asynchronous reset
    input wire echo,             // Echo input from HC-SR04
    output wire trigger,         // Trigger pulse output
    output wire led              // LED output (to blink based on distance)
);

    wire [31:0] duration;

    // Generate trigger pulse every 50ms
    trigger_gen u_trigger (
        .clk(clk),
        .rst(rst),
        .trigger(trigger)
    );

    // Time echo pulse duration
    echo_timer u_echo (
        .clk(clk),
        .rst(rst),
        .echo(echo),
        .duration(duration)
    );

    // Control LED based on measured distance
    led_ctrl u_led (
        .clk(clk),
        .rst(rst),
        .duration(duration),
        .led_out(led)     // LED output based on duration
    );

endmodule
