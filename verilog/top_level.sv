
module top_level(Button1, Button2, CLK_50, led, 
                SPI_outgoing, SPI_incoming, SPI_CLK, CS, GPIO);
    input wire Button1, Button2;
    output [23:0] GPIO;
    input wire CLK_50;
    output logic [3:0] led;
    logic [10:0] period;

    // Button Inputs
    logic button1_ps, button2_ps;
    logic deb1, deb2;
    debounce deb1d (.in(Button1), .out(deb1), .clk(clk_div[4]));
    debounce deb2d (.in(Button2), .out(deb2), .clk(clk_div[4]));
    button_press b1_cont (.in(~deb1), .out(button1_ps), .clk(CLK_50), .reset(0));
    button_press b2_cont (.in(~deb2), .out(button2_ps), .clk(CLK_50), .reset(0));

    // Debug signals
    logic [3:0] debug_out;
    //assign led[3]=CS;
    logic [25:0] debug_2_out;

    //Clock Division
    logic [31:0] clk_div;
    always_ff @(posedge CLK_50)
        clk_div<=clk_div+1'b1;
    initial begin
        clk_div=0;
        period=1001;
        debug_out=0;
        motor_periods='{24{11'd1}};
        //count<=0;
    end

    // SPI Control
    output logic SPI_outgoing;
    input logic SPI_incoming;
    input logic SPI_CLK, CS;
    logic data_ready;
    localparam spi_data_width = 32;
    logic [spi_data_width-1:0] SPI_data_in;
    logic [spi_data_width-1:0] SPI_data_out;
    logic [spi_data_width-1:0] d_out [1:0];

    /* Control for the motors. Signal decoding
        ****OLD**** Pattern for signal decoding:
        |  Motor select         |     pwm signal                 |              TBD           |
        |31|30|29|28|27|26|25|24|23|22|21|20|19|18|17|16|15|14|13|12|11|10|9|8|7|6|5|4|3|2|1|0|

        New pattern
        For motor:
        |  Command select       |     N/A      | Motor select          |     pwm signal       |
        |31|30|29|28|27|26|25|24|23|22|21|20|19|18|17|16|15|14|13|12|11|10|9|8|7|6|5|4|3|2|1|0|

        For data trans:
        |  Command select       |    Data Addr          |            
        |31|30|29|28|27|26|25|24|23|22|21|20|19|18|17|16|15|14|13|12|11|10|9|8|7|6|5|4|3|2|1|0|

        Commands:

        Drive Motor:
        0000000
        Send Data:
        0000001

        Data Addr:
        000000: Encoder
            7-0: Current cycle count
            8: direction

        What 
    */

    SPI #(.data_length(spi_data_width)) comms (.data_out(SPI_data_out), .data_in(SPI_data_in), 
                .incoming(SPI_incoming), .outgoing(SPI_outgoing),
                .clk(SPI_CLK), .CS, .data_ready);


    // Data control
    logic [7:0] data_addr;
    logic [31:0] preDout [2];
    logic [7:0] enc1_count;
    logic [7:0] motor_addr;
    logic [10:0] new_pwm_period;

    // Data decoding
    assign data_addr = SPI_data_in[23:16];
    assign d_out = preDout[data_addr];
    assign motor_addr = SPI_data_in[31:24];
    assign new_pwm_period = SPI_data_in[23:13];

    // Data loading
    logic load_period;
    button_press load_logic (.in(data_ready), .out(load_period), .clk(CLK_50), .reset(0));
    always_ff @(posedge CLK_50) begin
        if (load_period) begin
            period<=new_pwm_period;
            motor_periods[motor_addr]<=new_pwm_period;
        end
    end

    // Encoder Control
    assign preDout[1] = {{enc1_dir}, {enc1_count}}; 
    input logic inA1, inB1, inZ1;
    logic enc1_dir;
    encoder motorC (.inA(inA1), .inB(inB1), .inZ(inZ1), .count(enc1_count), .direction(enc1_dir));

    // PWM setup
    logic [10:0] motor_periods [23:0];
    genvar i;
    generate;
        for (i=0; i<6; i++) begin : pwm_signals
            pwm motor_sig (.clk(CLK_50), .sig(GPIO[i]), .period(motor_periods[i]));
        end
    endgenerate

    // Test LED
    pwm led_sig (.clk(CLK_50), .sig(led[0]), .period(period));
endmodule


module debounce(in, out, clk);
    input in, clk;
    output logic out;
    logic [5:0] deb;
    always_ff @(posedge clk) begin
        deb<={deb[4:0], in};
        out<=|deb;
    end
endmodule
