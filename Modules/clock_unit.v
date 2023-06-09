module clock(clk_1hz, 
            sec_in_o, sec_in_t, min_in_o, min_in_t, hr_in_o, hr_in_t, // Input
            sec_out_o, sec_out_t, min_out_o, min_out_t, hr_out_o, hr_out_t, // Output
            time_ow);

  input clk_1hz, time_ow; //1 Hz clock (clock), Time overwrite (asynchronous reset)

  // Clock Units
  input [3:0] sec_in_o, sec_in_t; // Seconds Ones and Tens
  input [3:0] min_in_o, min_in_t; // Minutes Ones and Tens
  input [3:0] hr_in_o, hr_in_t; // Hour Ones and Tens

  output reg [3:0] sec_out_o, sec_out_t; // Seconds Ones and Tens
  output reg [3:0] min_out_o, min_out_t; // Minutes Ones and Tens
  output reg [3:0] hr_out_o, hr_out_t; // Hour Ones and Tens

  // If Time Overwrite is enabled the input hour will be set to clock hour.

  //------------------------------------------------------------------------------------------------------------
  // Seconds  Counter[MOD 5, MOD 9]
  always@(posedge clk_1hz or posedge time_ow) // Unidades
    begin
      if(time_ow)
        begin
          sec_out_o <= sec_in_o;
        end
      else
        begin
          sec_out_o <= (sec_out_o == 4'd9) ? 4'd0 : (sec_out_o + 4'd1);
        end
    end

  always@(posedge clk_1hz or posedge time_ow) // Decenas
    begin
      if(time_ow)
        begin
          sec_out_t <= sec_in_t;
        end
      else
        begin
          if(sec_out_o == 4'd9)
            begin
              sec_out_t <= ( (sec_out_t == 4'd5) & (sec_out_o == 4'd9) ) ? 4'd0 : (sec_out_t + 4'd1);
            end
        end
    end

  //------------------------------------------------------------------------------------------------------------
  // Minutes Counter[MOD 5, MOD 9]
  always@(posedge clk_1hz or posedge time_ow) // Unidades
    begin
      if(time_ow)
        begin
          min_out_o <= min_in_o;
        end
      else
        begin
          if((sec_out_t == 4'd5) & (sec_out_o == 4'd9))
            begin
              min_out_o <= (min_out_o == 4'd9) ? 4'd0 : (min_out_o + 4'd1);
            end
        end
    end

  always@(posedge clk_1hz or posedge time_ow) // Decenas
    begin
      if(time_ow)
        begin
          min_out_t <= min_in_t;
        end
      else
        begin
          if((sec_out_t == 4'd5) & (sec_out_o == 4'd9) & (min_out_o == 4'd9))
            begin
              min_out_t <= ( (min_out_t == 4'd5) & (min_out_o == 4'd9) ) ? 4'd0 : (min_out_t + 4'd1);
            end
        end
    end

  // //------------------------------------------------------------------------------------------------------------
  // // Hours Counter[MOD 2, MOD 9]
    always@(posedge clk_1hz or posedge time_ow) // Unidades
    begin
      if(time_ow)
        begin
          hr_out_o <= hr_in_o;
        end
      else
        begin
          if( (sec_out_t == 4'd5) & (sec_out_o == 4'd9) & (min_out_t == 4'd5) & (min_out_o == 4'd9))
            begin
              if(hr_out_t == 4'd2)
                hr_out_o <= (hr_out_o == 4'd3) ? 4'd0 : (hr_out_o + 4'd1);
              else
                hr_out_o <= (hr_out_o == 4'd9) ? 4'd0 : (hr_out_o + 4'd1);
            end
        end
    end
    
    always@(posedge clk_1hz or posedge time_ow) // Decenas
    begin
      if(time_ow)
        begin
          hr_out_t <= hr_in_t;
        end
      else
        begin
          if( (sec_out_t == 4'd5) & (sec_out_o == 4'd9) & (min_out_t == 4'd5) & (min_out_o == 4'd9) ) 
            begin
              if((hr_out_t == 4'd2) & (hr_out_o == 4'd3))
                hr_out_t <= ( (hr_out_t == 4'd2) & (hr_out_o == 4'd3)) ? 4'd0 : (hr_out_t + 4'd1);
              else if((hr_out_o == 4'd9))
                hr_out_t <= hr_out_t + 4'd1;
            end
        end
    end

endmodule