module pwm(input clk, // System clock, intended 50mhz. A different clock speed means a different pwm period
           output sig, // Output signal
           input logic [10:0] period // Period of signal with range of 0-2000
           );
    logic [10:0] counter; // Counter counting current part of period
    logic [8:0] div;      // Clock divider
    initial begin
        counter=0;
        div=0;
    end
    // 50Mhz/2^9 approx equals a 10us clock period
    always_ff @(posedge clk) begin
        div<=div+1'b1;
    end
    always_ff @(posedge div[8]) begin
        if (counter>=2000) // 2000 (period in clock cycles)*10 us (time per clock cycle) = 20ms (period in time)
            counter<=0;
        else 
            counter<=counter+1'b1;
    end
    assign sig = (counter<period);
endmodule