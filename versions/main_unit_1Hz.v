`include "Modules/clock_unit.v"
`include "Modules/alarm_unit.v"
`include "Modules/seg_display.v"

module main_unit(clk_1Hz, 
            time_ow, // Time Overwrite
            alarmOne, // Alarm One
            alarmTwo, // Alarm Two
            alarmThree, // Alarm Three

            min_i_o, min_i_t, hr_i_o, hr_i_t, // Time Input

            sec_display_o, sec_display_t, min_display_o, min_display_t, hr_display_o, hr_display_t, // Time output
            alarm_ring_one,
            alarm_ring_two,
            alarm_ring_three // Alarm Output
            );

    input clk_1Hz, 
        time_ow, // Time Overwrite
        alarmOne, // Alarm One
        alarmTwo, // Alarm Two
        alarmThree; // Alarm Three

     output [6:0] sec_display_t, sec_display_o,
                 min_display_t, min_display_o,
                 hr_display_t, hr_display_o; // Output time 7 Seg

    output alarm_ring_one, alarm_ring_two, alarm_ring_three; // Alarm Ring

    input [3:0] min_i_o, min_i_t, hr_i_o, hr_i_t; // Input time
    wire [3:0] sec_o, sec_t, min_o, min_t, hr_o, hr_t; // Output time


    clock uut(clk_1Hz,
            4'd0, 4'd0, min_i_o, min_i_t, hr_i_o, hr_i_t,
            sec_o, sec_t, min_o, min_t, hr_o, hr_t, 
            time_ow);
            
    alarm alarm1(clk_1Hz, // CLK
                1'b0, // Reset

                min_i_t, min_i_o,
                hr_i_t, hr_i_o,

                min_t, min_o,
                hr_t, hr_o,

                alarmOne,
                alarm_ring_one
                );

    alarm alarm2(clk_1Hz, // CLK
                1'b0, // Reset

                min_i_t, min_i_o,
                hr_i_t, hr_i_o,

                min_t, min_o,
                hr_t, hr_o,

                alarmTwo,
                alarm_ring_two
                );

    alarm alarm3(clk_1Hz, // CLK
                1'b0, // Reset

                min_i_t, min_i_o,
                hr_i_t, hr_i_o,

                min_t, min_o,
                hr_t, hr_o,

                alarmThree,
                alarm_ring_three
                );


    // 7 Segment Display
    seg_display seconds_t(clk_1Hz, sec_t, sec_display_t);
    seg_display seconds_o(clk_1Hz, sec_o, sec_display_o);

    seg_display minutes_t(clk_1Hz, min_t, min_display_t);
    seg_display minutes_o(clk_1Hz, min_o, min_display_o);

    seg_display hours_t(clk_1Hz, hr_t, hr_display_t);
    seg_display hours_o(clk_1Hz, hr_o, hr_display_o);

endmodule