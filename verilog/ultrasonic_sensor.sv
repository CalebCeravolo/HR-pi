module ultrasonic_sensor (
    input logic clk,
    input logic rst, // have to trigger a reset very tiem triggers
    input logic trigger,
    input logic echo,
    output logic [15:0]distance,
    output logic trigger_out
);
    logic [15:0] count_distance;
    always_ff  @ (posedge clk) begin
        if (rst | trigger)
            count_distance <= '0;
        else if (echo)
            count_distance <= count_distance + 1;
        else 
            count_distance <= count_distance;
    end

    assign distance = (count_distance * 17) / 1000; // Speed of sound is approximately 0.034 cm/us, divide by 2 for round trip

    logic [3:0]trigger_counter;
    always_ff @ (posedge clk) begin
        if (rst) begin
            trigger_counter <= '0;
            trigger_out <= 0;
        end
        else if (trigger) begin
            trigger_out <= 1;
            trigger_counter <= '0;
        end
        else if (trigger_counter > 10) begin
            trigger_out <= 0;   // Keep trigger high for a short duration
            trigger_out <= 0;   
        end 
        else begin
            trigger_counter <= trigger_counter+1;
            trigger_out <= trigger_out;
        end
    end



endmodule