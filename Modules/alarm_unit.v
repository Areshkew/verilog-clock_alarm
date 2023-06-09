module alarm(clk, 
            rst, // Reset

            set_m_t, set_m_o, set_h_t, set_h_o, // Alarm Time set
            time_m_t, time_m_o, time_h_t, time_h_o, // Clock time

            set_time, // Signal for assigning time
            ring);

  input clk, rst, set_time;
  output reg ring;
  
  // Input alarm
  input [3:0] set_m_t, set_m_o, // Minutes
              set_h_t, set_h_o; // Hours

  input [3:0] time_m_t, time_m_o, 
              time_h_t, time_h_o; // clock Time

  // Alarm Hours and Minutes
  reg [3:0] alarm_m_t, alarm_m_o, // Minutes
              alarm_h_t, alarm_h_o; // Hours

  // Alarm Ring Counter
  reg [5:0] sec_ring;
  reg alarm_enabled;

  // Set Alarm
  always@(posedge clk or posedge rst or posedge set_time)
    begin
      if(rst)
        begin
          alarm_m_t <= 4'd0;
          alarm_m_o <= 4'd0;
          alarm_h_t <= 4'd0;
          alarm_h_o <= 4'd0;
          alarm_enabled <= 1'b0;
        end
      else if(set_time)
        begin
          alarm_m_t <= set_m_t;
          alarm_m_o <= set_m_o;
          alarm_h_t <= set_h_t;
          alarm_h_o <= set_h_o;
          alarm_enabled <= 1'b1;
          ring <= 0;
        end
    end

  // Alarm Ring - COUNTER MOD 60
  always@(posedge clk) 
    begin
      if(!ring)
        begin
          sec_ring <= 6'd0;
        end
      else
        begin
          sec_ring <= (sec_ring == 6'd59) ? 6'd0 : (sec_ring + 6'd1);
        end
    end

  // Control Alarm
  always@(posedge clk)
    begin
      if(sec_ring == 6'd59)
        begin
          ring <= 0;
        end

      if((time_m_t == alarm_m_t) & (time_m_o == alarm_m_o) & (time_h_t == alarm_h_t) & (time_h_o == alarm_h_o) & (alarm_enabled)) // Check if time to alarm
        begin
          ring <= 1;
        end
    end
    
endmodule