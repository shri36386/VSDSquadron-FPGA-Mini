module trigger_gen (
    input wire clk,
    input wire rst,
    output reg trigger
);

    parameter CLK_FREQ = 12000000;
    parameter PULSE_WIDTH = 120;
    parameter PERIOD = 600000;

    reg [31:0] count;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 0;
            trigger <= 0;
        end else begin
            if (count < PULSE_WIDTH)
                trigger <= 1;
            else
                trigger <= 0;

            if (count >= PERIOD)
                count <= 0;
            else
                count <= count + 1;
        end
    end

endmodule