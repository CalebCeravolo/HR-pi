module ultrasonic_sensor (
    input logic clk,
    input logic rst, // have to trigger a reset very tiem triggers
    input logic trigger,
    input logic echo,
    output logic [15:0]distance,
    output logic trigger_out,
    output logic valid,
    output logic ready
);

enum logic [2:0] {IDLE, TRIGGERING, WAITING_FOR_ECHO, SENDING_DISTANCE} ps, ns;


logic [15:0] counter;


always_ff @ (posedge clk) begin
    if (rst) begin
        ps <= IDLE;
        counter <= '0;
    end
    else begin
        ps <= ns;
        if (ns != ps && ns != SENDING_DISTANCE) begin
            counter <= '0;         
        end else if (ps == TRIGGERING || ps == WAIT_ECHO_HIGH || ps == MEASURE_ECHO) begin
            counter <= counter + 1; 
        end
    end
end

always_comb begin 
    ns = ps;
    trigger_out = 0;
    ready = 0;
    valid = 0;
    if (ps == IDLE) begin
        trigger_out = 0;
        ready = 1;
        valid = 0;
        if (trigger)
            ns = TRIGGERING;
    end
    else if (ps == TRIGGERING) begin
        trigger_out = 1;
        ready = 0;
        valid = 0;
        if (counter > 10) begin
            trigger_out = 0;
            if (echo)
                ns = WAITING_FOR_ECHO;
            else if (counter > 36000) begin
                ns = IDLE;
            end
        end
    end
    else if (ps == WAITING_FOR_ECHO) begin
        trigger_out = 0;
        valid = 0;
        ready = 0;
        if (!echo) begin
            ns = SENDING_DISTANCE;
        end
        else if (counter > 36000) begin
            ns = IDLE;
        end
    end
    else if (ps == SENDING_DISTANCE) begin
        valid = 1;
        trigger_out = 0;
        ready = 0;
        ns = IDLE;
    end

end

assign distance = counter;


endmodule