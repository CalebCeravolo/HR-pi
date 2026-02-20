module encoder (input inA, // First encoder pin
                input inB, // Second encoder pin
                input inZ, // Extra output for zeroing 
                input clk, // System clock
                output logic [15:0] count,// Output data array
                output logic direction // current direction. 0 for A triggered first, 1 for B triggered first
                );
    initial count = 0;
    logic [15:0] next_count;
    logic A, B, Z, dA, dB, dZ;
    debounce #(.length(50)) debA (.in(inA), .out(dA), .clk);
    debounce #(.length(50)) debB (.in(inB), .out(dB), .clk);
    // debounce #(.length(50)) debZ (.in(inZ), .out(dZ), .clk);

    posedge_trigger #(.stabilize(1)) da (.in(dA), .out(A), .clk(clk), .reset(0));
    // posedge_trigger #(.stabilize(1)) db (.in(inB), .out(B), .clk(CLOCK_50), .reset(0));
    // posedge_trigger #(.stabilize(1)) dz (.in(dZ), .out(Z), .clk(clk), .reset(0));
    assign next_count = (inB ? count-1'b1 : count+1'b1);
    always_ff @(posedge clk) begin
        if (A) begin
            count<= next_count;
            direction<=dB;
        end
        if (inZ)
            count<=0;
    end

endmodule