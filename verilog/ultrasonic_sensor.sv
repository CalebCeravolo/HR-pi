module ultrasonic_sensor (
    input logic clk,
    input logic rst, // have to trigger a reset very tiem triggers
    input logic trigger,
    input logic echo,
    output logic [15:0]distance,
    output logic trigger_out
);
    logic [15:0] count_distance;
    // Keep everything in 1 always_ff block
    always_ff  @ (posedge clk) begin
        if (rst | trigger)
            count_distance <= '0;
            // Try to use else statements as little as possible
        else if (echo)
            count_distance <= count_distance + 1;
        else 
            // redundant
            count_distance <= count_distance;
    end

    // Keep this as an integer value and we can use floating point math on the raspberry pi for higher accuracy
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

        // There's no point having this else statement, it'll just add more latency to the hardware
        else if (trigger_counter > 10) begin

            // Why does this show up twice?
            trigger_out <= 0;   // Keep trigger high for a short duration
            trigger_out <= 0;   
        end 
        else begin
            trigger_counter <= trigger_counter+1;

            // This is redundant. Looks like you're trying to do combinational logic
            trigger_out <= trigger_out;
        end
    end



endmodule