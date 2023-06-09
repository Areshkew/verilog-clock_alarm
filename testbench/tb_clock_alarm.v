`include "Modules/clock_unit.v"
`include "Modules/alarm_unit.v"
`timescale 1ns / 1ps

module tb();
  reg clk, 
      time_ow, // Time Overwrite
      alarmOne; // Alarm

  wire alarm_ring;    

  reg [3:0] sec_i_o, sec_i_t, min_i_o, min_i_t, hr_i_o, hr_i_t;
  wire [3:0] sec_o, sec_t, min_o, min_t, hr_o, hr_t;
  
  always #5  clk = ~clk; // Asumimos 10ns = 1s
  
  clock uut(clk,
            sec_i_o, sec_i_t, min_i_o, min_i_t, hr_i_o, hr_i_t,
            sec_o, sec_t, min_o, min_t, hr_o, hr_t, 
            time_ow);
            
  alarm alarm1(clk, // CLK
              1'b0, // Reset

              min_i_t, min_i_o,
              hr_i_t, hr_i_o,

              min_t, min_o,
              hr_t, hr_o,

              alarmOne,
              alarm_ring
              );
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

            //// - ALARM TEST
            #10
            alarmOne = 1;

            // Minutes [ 33 ]
            min_i_t = 4'd3; min_i_o = 4'd3;
            
            // Hours [ 00]
            hr_i_t = 4'd0; hr_i_o = 4'd0; 

            #10
            alarmOne = 0;

            #1000000
            $finish;
        end

  initial // Output
      begin  
        $dumpfile("tb_clock.vcd"); 
        $dumpvars(0, tb);

      end
endmodule