module echo_timer (
    input wire clk,
    input wire rst,
    input wire echo,
    output reg [31:0] duration
);

    reg prev_echo;
    reg measuring;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            duration <= 0;
            prev_echo <= 0;
            measuring <= 0;
        end else begin
            prev_echo <= echo;

            if (~prev_echo & echo) begin
                duration <= 0;
                measuring <= 1;
            end else if (prev_echo & ~echo) begin
                measuring <= 0;
            end else if (measuring) begin
                duration <= duration + 1;
            end
        end
    end

endmodule