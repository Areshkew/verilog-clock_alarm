// Divider For 5CSEMA5F31C6N 
// 50 MHz to 1Hz

module frecDivider(clk_50MHz, clk_1Hz);
    reg [24:0] counter;       // 25-bit counter for dividing the clock
    output reg clk_1Hz;       // 1 Hz clock output
    input clk_50MHz;          // 50 MHz clock input
    
    initial begin
        counter = 0;          // Initialize the counter to 0
        clk_1Hz = 0;          // Initialize the output clock to 0
    end
    
    always @(posedge clk_50MHz) begin
        if (counter == 0) begin
            counter <= 49999999;    // If 24999999 not work, set the counter value to divide by 50 million (50 MHz / 50M = 1 Hz) (49999999)
            clk_1Hz <= ~clk_1Hz;    // Toggle the output clock
        end else begin
            counter <= counter - 1; // Decrement the counter
        end
    end
endmodule