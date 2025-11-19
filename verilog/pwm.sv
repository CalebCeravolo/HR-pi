module pwm(clk, sig, period);
    input clk;
    output sig;
    input logic [10:0] period;
    logic [10:0] counter;
    logic [8:0] div;
    initial begin
        counter=0;
        div=0;
    end
    // 50Mhz/2^9 approx equals a 10us clock period
    always_ff @(posedge clk) begin
        div<=div+1'b1;
    end
    always_ff @(posedge div[8]) begin
        if (counter>=2000) // 2000 *10 us = 20ms
            counter<=0;
        else 
            counter<=counter+1'b1;
    end
    assign sig = (counter<period);
endmodule