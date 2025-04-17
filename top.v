`timescale 1ns / 1ps

module top (
    input wire clk,
    input wire rst,
    input wire echo,
    output wire trigger,
    output wire buzzer
);

    wire [31:0] duration;

    trigger_gen u_trigger (
        .clk(clk),
        .rst(rst),
        .trigger(trigger)
    );

    echo_timer u_echo (
        .clk(clk),
        .rst(rst),
        .echo(echo),
        .duration(duration)
    );

    buzzer_ctrl u_buzzer (
        .clk(clk),
        .rst(rst),
        .duration(duration),
        .buzzer_out(buzzer)
    );

endmodule