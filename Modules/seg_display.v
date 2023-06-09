module seg_display(clk, bcd, display);
    input clk;
    input [3:0] bcd;
    output reg [6:0] display;

    always @(posedge clk) begin

        case(bcd)
            4'b0000: display = 7'b0000001; // 0
            4'b0001: display = 7'b1001111; // 1
            4'b0010: display = 7'b0010010; // 2
            4'b0011: display = 7'b0000110; // 3
            4'b0100: display = 7'b1001100; // 4
            4'b0101: display = 7'b0100100; // 5
            4'b0110: display = 7'b0100000; // 6
            4'b0111: display = 7'b0001111; // 7
            4'b1000: display = 7'b0000000; // 8
            4'b1001: display = 7'b0000100; // 9
            default: display = 7'b1111111; // OFF 
        endcase

    end
endmodule