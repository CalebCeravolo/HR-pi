module encoder (input inA, // First encoder pin
                input inB, // Second encoder pin
                input inZ, // Extra output for zeroing 
                output [7:0] count = 0,// Output data array
                output direction // current direction. 0 for A triggered first, 1 for B triggered first
                );

    always @(posedge inA) begin
        count<=count+1'b1;
        if (inZ)
            count<=0;
        direction<=inB;
    end

endmodule