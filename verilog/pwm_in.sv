module pwm_in(
    input signal,
    input micro_clk,
    output logic [9:0] uptime
)
    logic [9:0] count;
    logic signal_1;
    always_ff @(posedge micro_clk) begin
        signal_1<=signal;
        if (signal) begin
            count<=count+1;
        end
        if (!signal&&signal_1) begin
            uptime<=count;
            count<=0;
        end
    end
endmodule