
module top_level
    (
            input GCLK, 
            input pwmCLK,
            output logic [2:0] RGB_1, 
            output logic [2:0] RGB_2, 
            output SPI_outgoing, 
            input SPI_incoming, 
            input SPI_CLK, 
            input CS, 
            output [9:0] GPIO, 
            input Enc1inA, 
            input Enc1inB, 
            input spectroClock,
            input [9:0] spectroChannel0_DATA,
            input [9:0] spectroChannel1_DATA,
            input [9:0] spectroChannel2_DATA,
            input [9:0] spectroChannel3_DATA,
            input spectroChannel0_FIFO_EMPTY,
            input spectroChannel1_FIFO_EMPTY,
            input spectroChannel2_FIFO_EMPTY,
            input spectroChannel3_FIFO_EMPTY,
            output spectroChannel0_RST,
            output spectroChannel1_RST,
            output spectroChannel2_RST,
            output spectroChannel3_RST,
            output logic spectroChannel0_FIFO_RD,
            output logic spectroChannel1_FIFO_RD,
            output logic spectroChannel2_FIFO_RD,
            output logic spectroChannel3_FIFO_RD,
            output logic spectroChannel0_ENA,
            output logic spectroChannel1_ENA,
            output logic spectroChannel2_ENA,
            output logic spectroChannel3_ENA,
            output logic spectroSlave,
            output logic spectroClock_ENA
    );
    assign {spectroChannel0_ENA, spectroChannel1_ENA,spectroChannel2_ENA,spectroChannel3_ENA, spectroClock_ENA} = 5'b11111;
    logic [20:0] period;
    localparam NUM_BINS = 640;
    localparam BIN_WIDTH = 1280/NUM_BINS;
    reg [19+BIN_WIDTH:0] pixelBins [NUM_BINS-1:0];
    // Spectrometer control
    spectro #(.NUM_BINS(NUM_BINS)) spc (.spectroChannel0_DATA, .spectroChannel0_ENA, .spectroChannel0_FIFO_EMPTY, .spectroChannel0_FIFO_RD,
                .spectroChannel1_DATA, .spectroChannel1_ENA, .spectroChannel1_FIFO_EMPTY, .spectroChannel1_FIFO_RD,
                .spectroChannel2_DATA, .spectroChannel2_ENA, .spectroChannel2_FIFO_EMPTY, .spectroChannel2_FIFO_RD,
                .spectroChannel3_DATA, .spectroChannel3_ENA, .spectroChannel3_FIFO_EMPTY, .spectroChannel3_FIFO_RD,
                .clk(spectroClock), .pixelBins);
    // Button Inputs
    logic button1_ps, button2_ps;
    logic deb1, deb2;
    debounce deb1d (.in(Button1), .out(deb1), .clk(clk_div[4]));
    debounce deb2d (.in(Button2), .out(deb2), .clk(clk_div[4]));
    posedge_trigger #(.stabilize(1)) b1_cont (.in(~deb1), .out(button1_ps), .clk(GCLK), .reset(1'b0));
    posedge_trigger #(.stabilize(1)) b2_cont (.in(~deb2), .out(button2_ps), .clk(GCLK), .reset(1'b0));
    
    // Debug signals
    logic [3:0] debug_out;
    assign RGB_1[2:1]=0;
    // assign RGB_2=3'b001;
    logic [25:0] debug_2_out;

    //Clock Division
    logic [31:0] clk_div;
    always_ff @(posedge GCLK)
        clk_div<=clk_div+1'b1;
    initial begin
        clk_div=0;
        period=1001;
        debug_out=0;
        motor_periods='{numMotorPins{20'd1}};
        motor_uptimes='{numMotorPins{20'd20000}};
        //count<=0;
    end

    // SPI Control
    logic data_ready;
    localparam spi_data_width = 32;
    logic [spi_data_width-1:0] SPI_data_in;
    logic [spi_data_width-1:0] SPI_data_out;

    /* Control for the motors. Signal decoding
        For motor:
        |  Command select | Motor Select |         PWM Period (10us)/pwm uptime               |
        |31|30|29|28|27|26|25|24|23|22|21|20|19|18|17|16|15|14|13|12|11|10|9|8|7|6|5|4|3|2|1|0|


        For data trans:
        |  Command select |                                                   |   Data Addr   |            
        |31|30|29|28|27|26|25|24|23|22|21|20|19|18|17|16|15|14|13|12|11|10|9|8|7|6|5|4|3|2|1|0|

        Commands:
            Set PWM uptime:
            00000000
            Set PWM period:
            00000002
            Send Data:
            00000001

            Data Addr:
            000000: Debug
                10-0: Period
                
            000001: Encoder
                7-0: Current cycle count
                8: direction

        
    */
    SPI #(.data_length(spi_data_width)) comms (.data_out(SPI_data_out), .data_in(SPI_data_in), 
                    .incoming(SPI_incoming), .outgoing(SPI_outgoing),
                    .clk(SPI_CLK), .CS, .data_ready);
    // Data control
    logic [7:0] data_addr;
    logic [4:0] motor_addr;
    logic [20:0] new_pwm_period;
    logic [20:0] new_pwm_uptime;
    logic [5:0] command;
    logic set_pwm_period, set_pwm_uptime, send_data;
    logic [7:0] data_addr_reg;
    logic [9:0] binAddr = 0;
    always_comb begin
        case (data_addr_reg)
            0: SPI_data_out = SPI_data_in; // Period of debug led
            1: SPI_data_out = {{enc1_dir},{enc1_count}};  // Encoder 1 data
            2: SPI_data_out = 32'b11111111111111110000000000000000; // Debug
            3: SPI_data_out = pixelBins[binAddr];
            default: SPI_data_out = period;
        endcase
    end
    // Data decoding
    assign command = SPI_data_in[31:26];
    assign set_pwm_period = command == 8'd2;
    assign set_pwm_uptime = command == 8'd0;
    assign send_data = command == 8'b1;
    assign data_addr = SPI_data_in[7:0];
    assign motor_addr = SPI_data_in[25:21];
    assign new_pwm_uptime = SPI_data_in[20:0];
    assign new_pwm_period = SPI_data_in[20:0];

    // Data loading
    localparam load_length = 2;
    logic [load_length-1:0] load_period;
    logic load_it, data_ready_d;
    posedge_trigger load_logic (.in(data_ready), .out(load_it), .clk(GCLK), .reset(0));
    always_ff @(posedge GCLK) begin
        // load_period[load_length-1:0]<={load_period[load_length-2:0], load_it};
        if (load_it) begin
            if (set_pwm_period) begin
                period<=new_pwm_period;
                motor_periods[motor_addr]<=new_pwm_period;
                
            end
            if (set_pwm_uptime) begin
                motor_uptimes[motor_addr]<=new_pwm_uptime;
            end
            if (send_data) begin
                data_addr_reg<=data_addr;
                if (data_addr==3)
                    binAddr<=binAddr+1'b1;
            end
        end
    end

    // Encoder Control
    logic inA1, inB1, inZ1;
    assign inA1 = Enc1inA;
    assign inB1 = Enc1inB;
    assign inZ1 = 1'b0;
    logic enc1_dir;
    logic [15:0] enc1_count;

    encoder motorC (.inA(inA1), .inB(inB1), .inZ(inZ1), .clk(GCLK), .count(enc1_count), .direction(enc1_dir));

    // PWM setup
    localparam numMotorPins = 6;
    logic [20:0] motor_periods [numMotorPins-1:0];
    logic [20:0] motor_uptimes [numMotorPins-1:0];
    genvar i;
    logic pwm1usCLK;
    always_ff @(posedge pwmCLK)
        pwm1usCLK<=~pwm1usCLK;
    assign RGB_2 = {GPIO[2], GPIO[1], GPIO[0]};
    generate;
        for (i=0; i<numMotorPins; i++) begin : pwm_signals
            pwm motor_sig (.clk(pwm1usCLK), .sig(GPIO[i]), .period(motor_periods[i]), .uptime(motor_uptimes[i]));
        end
    endgenerate

    // Test LED
    assign RGB_1[0] = Enc1inA;
    // pwm led_sig (.clk(GCLK), .sig(RGB_1[0]), .period(period));
endmodule


module debounce #(parameter length = 6) (in, out, clk);
    input in, clk;
    output logic out;
    logic [length-1:0] deb;
    always_ff @(posedge clk) begin
        deb<={deb[length-2:0], in};
        out<=|deb;
    end
endmodule
