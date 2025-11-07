module top_level(Button1, Button2, CLK_50, led, 
                SPI_outgoing, SPI_incoming, SPI_CLK, CS, GPIO);
    input wire Button1, Button2;
    output [23:0] GPIO;
    input wire CLK_50;
    output logic [3:0] led;
    logic [10:0] period;
    logic button1_ps, button2_ps;
    logic deb1, deb2;
    debounce deb1d (.in(Button1), .out(deb1), .clk(clk_div[4]));
    debounce deb2d (.in(Button2), .out(deb2), .clk(clk_div[4]));
    button_press b1_cont (.in(~deb1), .out(button1_ps), .clk(CLK_50), .reset(0));
    button_press b2_cont (.in(~deb2), .out(button2_ps), .clk(CLK_50), .reset(0));
    logic [3:0] debug_out;
    //assign led[3]=CS;
    logic [25:0] debug_2_out;
    logic [31:0] clk_div;
    initial begin
        clk_div=0;
        period=1001;
        debug_out=0;
        motor_periods='{24{0}};
        //count<=0;
    end
    //assign GPIO='1;
    output logic SPI_outgoing;
    input logic SPI_incoming;
    input logic SPI_CLK, CS;
    logic data_ready;
    localparam spi_data_width = 32;
    logic [spi_data_width-1:0] SPI_data_in;
    logic [spi_data_width-1:0] SPI_data_out;
    logic [spi_data_width-1:0] d_out [1:0];
    // assign d_out[0] = {4{2{debug_out}}};
    // assign d_out[1] = {{8'd5},{8'd6},{8'd7},{8'd8}};
    
    //logic count;
    assign SPI_data_out = SPI_data_in;
    // always_ff @(negedge data_ready) begin
    //     count<=count+1'b1;
    // end
    
    //assign SPI_outgoing = 1'b1;
    SPI #(.data_length(spi_data_width)) comms (.data_out(SPI_data_out), .data_in(SPI_data_in), 
                .incoming(SPI_incoming), .outgoing(SPI_outgoing),
                .clk(SPI_CLK), .CS, .data_ready);
    logic [10:0] motor_periods [23:0];
    genvar i;
    generate;
        for (i=0; i<6; i++) begin : pwm_signals
            pwm motor_sig (.clk(CLK_50), .sig(GPIO[i]), .period(motor_periods[i]));
        end
    endgenerate
    pwm led_sig (.clk(CLK_50), .sig(led[0]), .period(period));
    //assign led[3:1]=period;

    // Control for the motors. Signal decoding
    /*
    Pattern for signal decoding:
    |  Motor select         |     pwm signal                 |              TBD           |
    |31|30|29|28|27|26|25|24|23|22|21|20|19|18|17|16|15|14|13|12|11|10|9|8|7|6|5|4|3|2|1|0|
    */
    assign led[1] = 1'b1;
    logic [7:0] motor_addr;
    logic [10:0] new_pwm_period;
    assign motor_addr = SPI_data_in[31:24];
    assign new_pwm_period = SPI_data_in[23:13];
    logic load_period;
    button_press load_logic (.in(data_ready), .out(load_period), .clk(CLK_50), .reset(0));
    always_ff @(posedge CLK_50) begin
        if (load_period) begin
            period<=new_pwm_period;
            motor_periods[motor_addr]<=new_pwm_period;
        end
    end
    // always_ff @(posedge data_ready) begin
    //     period<=new_pwm_period;
    //     motor_periods[motor_addr]<=new_pwm_period;
    // end
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
            //period<=period+100;
            debug_out<=debug_out+1'b1;
        end
        if (button2_ps) begin
            //period<=period-100;
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
    assign sig = (counter<period);
endmodule

module SPI #(parameter data_length = 64) (
    input logic [data_length-1:0] data_out, // Input data to send out on interface
    output logic [data_length-1:0] data_in, // Input data, when valid data_ready goes high
    input incoming, // Incoming bit of information
    output logic outgoing, // Outgoing bit of information
    input clk, // Serial clock from raspberry pi
    input CS,  // Chip select signal
    output logic data_ready // Signal for telling when input data reg is valid
    );
    // Outgoing
    // output logic outgoing, data_ready;
    // output logic [data_length-1:0] data_in;
    logic [data_length-1:0] data_in_buffer, new_data;
    // input logic clk, clk2, CS, incoming;
    // input logic [data_length-1:0] data_out;
    logic fin;
    logic posedge_clk;
    //button_press pos_clk (.in(clk), .out(posedge_clk), .clk(clk2), .reset(0));
    // Signifying the final address has been reached
    assign fin = (addr==(data_length-1));

    //enum {waiting, communicating} state, next_state;
    
    
    logic [data_length-1:0] data_loaded, data_inv;
    logic [$clog2(data_length)-1:0] addr, next_addr, addr_eff;
    initial begin
        addr=0;
    end
    
    always_comb begin
        for (int i = 0; i < data_length; i++)
            data_inv[i]=data_loaded[data_length-1-i];
        //next_state = state;
        addr_eff = |restart ? 0 : addr;
        next_addr = addr_eff+1'b1;
        new_data = {data_in_buffer[data_length-2:0], incoming};
        outgoing=data_inv[addr_eff];
        // if (CS) 
        //     next_addr = 0;
    end 
    logic done;
    logic [1:0] restart;
    always_ff @(posedge clk, CS) begin
        if (CS)
            restart<=2'b10;
        else if (clk)
            restart<=(restart!=0 ? restart-1'b1 : 0);
    end


    always_ff @(negedge clk) begin
        //done<=(next_addr==data_length-1);
        data_in_buffer<=new_data;
        if ((addr==data_length-1)) begin
            data_in<=new_data;
            data_ready<=1'b1;
        end
        else begin
            data_ready<=1'b0;
        end
    end
    always_ff @(posedge clk) begin
        addr<=next_addr;
        if (addr==data_length-1) begin
            data_loaded<=data_out;
        end
    end
endmodule