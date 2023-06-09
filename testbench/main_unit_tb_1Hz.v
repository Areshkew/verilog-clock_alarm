`include "main_unit.v"
`timescale 1ns / 1ps

module tb();
  reg clk, 
      time_ow, // Time Overwrite
      alarmOne, // Alarms
      alarmTwo,
      alarmThree; 

  wire alarm_ring_one, alarm_ring_two, alarm_ring_three;    

  reg [3:0] sec_i_o, sec_i_t, min_i_o, min_i_t, hr_i_o, hr_i_t;
  wire [6:0] sec_o, sec_t, min_o, min_t, hr_o, hr_t;
  
  always #5  clk = ~clk; // Asumimos 10ns = 1s
  
  main_unit uut(clk,
                time_ow,
                alarmOne,
                alarmTwo,
                alarmThree,

                min_i_o, min_i_t, hr_i_o, hr_i_t,
                sec_o, sec_t, min_o, min_t, hr_o, hr_t,
                alarm_ring_one, alarm_ring_two, alarm_ring_three);
            
  initial
        begin
            clk = 0;
            time_ow = 1;
            
            // Minutes [ 31 ]
            min_i_t = 4'd3; min_i_o = 4'd1;
            
            // Hours [ 23 ]
            hr_i_t = 4'd2; hr_i_o = 4'd3; 

            #10
            time_ow = 0;

            //// - ALARM TEST ONE
            #10
            alarmOne = 1;

            // Minutes [ 33 ]
            min_i_t = 4'd3; min_i_o = 4'd3;
            
            // Hours [ 00]
            hr_i_t = 4'd0; hr_i_o = 4'd0; 

            #10
            alarmOne = 0;

            //// - ALARM TEST TWO
            #10
            alarmTwo = 1;

            // Minutes [ 40 ]
            min_i_t = 4'd4; min_i_o = 4'd0;
            
            // Hours [ 23 ]
            hr_i_t = 4'd2; hr_i_o = 4'd3; 

            #10
            alarmTwo = 0;

            //// - ALARM TEST Three
            #10
            alarmThree = 1;

            // Minutes [ 50 ]
            min_i_t = 4'd5; min_i_o = 4'd0;
            
            // Hours [ 23 ]
            hr_i_t = 4'd2; hr_i_o = 4'd3; 

            #10
            alarmThree = 0;

            #1000000
            $finish;
        end

  initial // Output
      begin  
        $dumpfile("tb_clock.vcd"); 
        $dumpvars(0, tb);

      end
endmodule