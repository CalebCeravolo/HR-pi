module posedge_trigger #(parameter stabilize = 0) (in, out, clk, reset);
	input logic in, clk, reset;
	output logic out;
	logic prev_state;
	logic pre_out;
	logic stable_out;
	always_ff @(posedge clk) begin
		if (reset) begin
			{prev_state, pre_out, stable_out}<=0;
		end
		else begin
			prev_state <= in;
			pre_out        <= in & ~prev_state;  // generate 1-cycle pulse on rising edge
			stable_out<=pre_out;
		end 
    end 
	assign out = stabilize ? stable_out : pre_out;
endmodule

module level_trigger #(parameter stabilize = 0) (in, out, clk, reset);
	input logic in, clk, reset;
	output logic out;
	logic prev_state;
	logic pre_out;
	logic stable_out;
	always_ff @(posedge clk) begin
		if (reset) begin
			{prev_state, pre_out, stable_out}<=0;
		end
		else begin
			prev_state <= in;
			pre_out        <= in~^prev_state;  // generate 1-cycle pulse on edge
			stable_out<=pre_out;
		end 
    end 
	assign out = stabilize ? stable_out : pre_out;
endmodule
