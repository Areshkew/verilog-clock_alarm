`include "Modules/clock.v"
`timescale 1ns / 1ps

module tb();
  reg clk, time_ow;
  reg [3:0] sec_i_o, sec_i_t, min_i_o, min_i_t, hr_i_o, hr_i_t;
  wire [3:0] sec_o, sec_t, min_o, min_t, hr_o, hr_t;
  
  always #5  clk = ~clk; // Asumimos 10ns = 1s
  
  clock_unit uut(clk,
            sec_i_o, sec_i_t, min_i_o, min_i_t, hr_i_o, hr_i_t,
            sec_o, sec_t, min_o, min_t, hr_o, hr_t, 
            time_ow);
            
  initial
        begin
            clk = 0;
            time_ow = 1;

            // Seconds [ 00 ]
            sec_i_t = 4'd0; sec_i_o = 4'd0;
            
            // Minutes [ 31 ]
            min_i_t = 4'd3; min_i_o = 4'd1;
            
            // Hours [ 23 ]
            hr_i_t = 4'd2; hr_i_o = 4'd3; 

            #10
            time_ow = 0;
            #1000000
            $finish;
        end

  initial // Output
      begin  
        $dumpfile("tb_clock.vcd"); 
        $dumpvars(0, tb);

      end
endmodule