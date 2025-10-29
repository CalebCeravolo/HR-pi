module top_level(Button1, Button2, CLK_50, led, 
                SPI_outgoing, SPI_incoming, SPI_CLK, CS);
    input wire Button1, Button2;
    input wire CLK_50;
    output logic [3:0] led;
    logic [10:0] period;
    logic button1_ps, button2_ps;
    logic deb1, deb2;
    debounce deb1d (.in(Button1), .out(deb1), .clk(clk_div[4]));
    debounce deb2d (.in(Button2), .out(deb2), .clk(clk_div[4]));
    logic deb1, deb2;
    button_press b1_cont (.in(~deb1), .out(button1_ps), .clk(CLK_50), .reset(0));
    button_press b2_cont (.in(~deb2), .out(button2_ps), .clk(CLK_50), .reset(0));
    logic [3:0] debug_out;
    //assign led[3]=CS;
    logic [25:0] debug_2_out;
    logic [31:0] clk_div;
    initial begin
        clk_div=0;
        period=0;
        debug_out=0;
        count<=0;
    end
    
    output logic SPI_outgoing;
    input logic SPI_incoming;
    input logic SPI_CLK, CS;
    logic data_ready;
    localparam spi_width = 32;
    logic [spi_width-1:0] SPI_data_in;
    logic [spi_width-1:0] SPI_data_out;
    logic [spi_width-1:0] d_out [1:0];
    assign d_out[0] = {4{2{debug_out}}};
    assign d_out[1] = {8'd5,8'd6,8'd7,8'd8};
    
    logic count;
    assign SPI_data_out = d_out[count];
    always_ff @(posedge data_ready) begin
        count<=count+1'b1;
    end
    
    //assign SPI_outgoing = 1'b1;

    SPI #(.data_length(spi_width)) comms (.data_out(SPI_data_out), .data_in(SPI_data_in), 
                .incoming(SPI_incoming), .outgoing(SPI_outgoing),
                .clk(SPI_CLK),.clk2(CLK_50), .CS, .data_ready);


    pwm led_sig (.clk(CLK_50), .sig(led[0]), .period(period));
    assign led[2:1]=~debug_out;
    assign led[3] = SPI_outgoing;
    always_ff @(posedge CLK_50) begin
        clk_div<=clk_div+1'b1;
        //led[1] <= |debug_out;
        //led[2] <= button2_ps;
        //led[3] <= |period;
        // if (done)
        //     debug_2_out<='1;
        // else
        //     if (debug_2_out>0)
        //         debug_2_out<=debug_2_out-1'b1;
        if (button1_ps) begin
            period<=period+100;
            debug_out<=debug_out+1'b1;
        end
        if (button2_ps) begin
            period<=period-100;
            debug_out<=debug_out-1'b1;
        end
    end
endmodule
module debounce(in, out, clk);
    input in, clk;
    output logic out;
    logic [100:0] deb;
    always_ff @(posedge clk) begin
        deb<={deb[4:0], in};
        out<=|deb;
    end
endmodule
module pwm(clk, sig, period);
    input clk;
    output sig;
    input logic [10:0] period;
    logic [10:0] counter;
    logic [8:0] div;
    initial begin
        counter=0;
        div=0;
    end
    // 50Mhz/2^9 approx equals a 10us clock period
    always_ff @(posedge clk) begin
        div<=div+1'b1;
    end
    always_ff @(posedge div[8]) begin
        if (counter>=2000) // 2000 *10 us = 20ms
            counter<=0;
        else 
            counter<=counter+1'b1;
    end
    assign sig = (counter>=period);
endmodule

module SPI #(parameter data_length = 64) (data_out, data_in, incoming, outgoing, clk, clk2, CS, data_ready);
    output logic outgoing, data_ready;
    output logic [data_length-1:0] data_in;
    input logic clk, clk2, CS, incoming;
    input logic [data_length-1:0] data_out;
    logic fin;
    logic posedge_clk;
    logic negedge_CS, posedge_CS;
    button_press pos_clk (.in(clk), .out(posedge_clk), .clk(clk2), .reset(0));
    button_press pos_cs (.in(!CS), .out(posedge_CS), .clk(clk2), .reset(0));
    button_press neg_cs (.in(!CS), .out(negedge_CS), .clk(clk2), .reset(0));
    // Signifying the final address has been reached
    assign fin = (addr==(data_length-1));

    //enum {waiting, communicating} state, next_state;
    logic [data_length-1:0] data_in_buffer, new_data;
    
    logic [data_length-1:0] data_loaded, data_inv;
    logic [$clog2(data_length)-1:0] addr, next_addr;
    initial begin
        addr=0;
    end
    
    always_comb begin
        for (int i = 0; i < data_length; i++)
            data_inv[i]=data_loaded[data_length-1-i];
        //next_state = state;
        next_addr = addr+1'b1;
        new_data = {data_in_buffer[data_length-2:0], incoming};
        // If the address has reached the end of the string and there's no
        // new info, go to the start and idle
        // if (fin&&(!load)) begin
        //     next_addr = 0;
        // end c:\Users\caleb\Scripts\Robotics\HR-pi
        outgoing=data_inv[addr];
        if (CS) 
            next_addr = 0;
    end
    logic done;
    logic gen_clk;
    assign gen_clk = CS ? clk2 : clk;
    always_ff @(posedge clk) begin
        addr<=next_addr;
        if (!CS) begin
            data_in_buffer<=new_data;
        end
        if (addr==data_length-1) begin
            data_in<=new_data;
            data_loaded<=data_out;
            data_ready<=1'b1;
        end
        else begin
            data_ready<=1'b0;
        end
    end
endmodule


// module i2c(outgoing, incoming, SDA, SCL, done);
//     inout SDA;
//     input SCL;
//     input logic [7:0] outgoing;
//     output logic [7:0] incoming;
//     output logic done;
//     assign SDA = (state==transmitting) ? outgoing_bit : 1'bz;
//     enum {receiving, transmitting, ending} state, next_state;
//     logic [2:0] current_addr;
//     logic outgoing_bit, incoming_bit;
//     assign outgoing_bit = outgoing[current_addr];
//     logic [7:0] end_message;
//     assign end_message = 8'hFF;
//     initial begin
//         current_addr=0;
//         done = 0;
//     end

//     always_ff @(posedge SCL) begin
        
//         if (current_addr==3'd7)
//             case (state)
//                 transmitting: begin
//                     state<=ending;
//                     outgoing_bit<=1'b1;
//                 end

//             endcase
//         else
//             current_addr<=current_addr+1'b1;

//         case (state)
//             receiving: begin
//                 incoming <={incoming[6:0], SDA};
//             end
//         endcase
//     end

// endmodule