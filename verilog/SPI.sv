/*
SPI data transmission module set up for Raspberry pi 5, but likely works for others
Latches incoming data on the positive edge of the clock, then changes the outgoing bit on
the negative edge. 
*/


module SPI #(parameter data_length = 64) (
    input logic [data_length-1:0] data_out, // Input data to send out on interface
    output logic [data_length-1:0] data_in, // Input data, when valid data_ready goes high
    input incoming, // Incoming bit of information
    output logic outgoing, // Outgoing bit of information
    input clk, // Serial clock from raspberry pi
    input CS,  // Chip select signal
    output logic data_ready // Signal for telling when input data reg is valid
    );

    // Logic for grabbing and setting the incoming data
    logic [data_length-1:0] data_in_buffer, new_data;

    // Logic for preparing the outgoing data
    logic [data_length-1:0] data_loaded, data_inv;

    // Address logic
    logic [$clog2(data_length)-1:0] addr, next_addr, addr_eff;
    initial begin
        addr=0;
    end


    always_comb begin
        for (int i = 0; i < data_length; i++)
            data_inv[i]=data_loaded[data_length-1-i];
        // addr_eff = |restart ? 0 : addr;
        next_addr = addr+1'b1;

        new_data = {data_in_buffer[data_length-2:0], incoming};
        outgoing = data_inv[addr];
    end 
    always_ff @(negedge clk or posedge CS) begin
        if (CS) begin
            addr<=0;
        end
        else begin
            addr<=next_addr;
            // if (next_addr==0) begin
            //     data_loaded<=data_out;
            // end
        end
    end

    always_ff @(negedge CS)
        data_loaded<=data_out;
    always_ff @(posedge clk) begin
        // done<=(next_addr==data_length-1);
        data_in_buffer<=new_data;
        if (addr==data_length-1) begin
            data_in<=new_data;
            data_ready<=1'b1;
        end
        else begin
            data_ready<=1'b0;
        end
    end
endmodule