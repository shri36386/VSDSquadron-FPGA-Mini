module buzzer_ctrl (
    input wire clk,
    input wire rst,
    input wire [31:0] duration,
    output reg buzzer_out
);

    parameter THRESHOLD = 3500;

    always @(posedge clk or posedge rst) begin
        if (rst)
            buzzer_out <= 1;
        else begin
            if (duration < THRESHOLD)
                buzzer_out <= ~clk;
            else
                buzzer_out <= 1;
        end
    end

endmodule