module #(parameter stabilize = 0) posedge_trigger (in, out, clk, reset);
	input logic in, clk, reset;
	logic prev_state;
	logic pre_out;
	logic stable_out;
	always_ff @(posedge clk) begin
		if (reset) begin
			{prev_state, pre_out, stable_out}<=0;
		end
		else begin
			prev_state <= in;
			pre_out        <= data_ready & ~prev_state;  // generate 1-cycle pulse on rising edge
			stable_out<=pre_out;
		end 
    end 
	assign out = stabilize ? stable_out : pre_out;
endmodule
