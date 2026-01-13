module spectroFIFO (
    input logic [9:0] fifoData,
    input FIFO_EMPTY,
    input CLK,
    input RST,
    output FIFO_RD,
    output logic [9:0] dataOut,
    output logic dataValid
);

    always @(posedge CLK) begin
        if (RST) begin
            FIFO_RD    <= 1'b0;
            data_valid <= 1'b0;
        end else begin
            if (!FIFO_EMPTY) begin
                FIFO_RD    <= 1'b1;   // continuous read
                dataOut   <= fifoData;      // data is valid this cycle
                dataValid <= 1'b1;
            end else begin
                FIFO_RD    <= 1'b0;
                data_valid <= 1'b0;
            end
        end
    end
endmodule