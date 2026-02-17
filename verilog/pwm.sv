module pwm (
           input clk, // System clock, intended 1Mhz
           output sig, // Output signal
           input logic [20:0] period, // Period of signal with range of 0-2000
           input logic [20:0] uptime
           );
    logic [20:0] counter; // Counter counting current part of period
    // logic [9:0] div;      // Clock divider
    initial begin
        counter=0;
        // div=0;
    end
    // 100Mhz/2^10 approx equals a 10us clock period
    // always_ff @(posedge clk) begin
    //     div<=div+1'b1;
    // end
    always_ff @(posedge clk) begin
        if (counter>=period) // 2000 (period in clock cycles)*1 us (time per clock cycle) = 2ms (period in time)
            counter<=0;
        else 
            counter<=counter+1'b1;
    end
    assign sig = (counter<uptime);
endmodule