
//
// Verific Verilog Description of module top_level
//

module top_level (Button1, Button2, CLK_50, led, SPI_outgoing, SPI_incoming, 
            SPI_CLK, CS);
    input Button1 /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_INPUT=TRUE */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(3)
    input Button2 /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_INPUT=TRUE */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(3)
    input CLK_50 /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_INPUT=TRUE */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(4)
    output [3:0]led /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_OUTPUT=TRUE */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(5)
    output SPI_outgoing /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_OUTPUT=TRUE */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(25)
    input SPI_incoming /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_INPUT=TRUE */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(26)
    input SPI_CLK /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_INPUT=TRUE */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(27)
    input CS /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_INPUT=TRUE */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(27)
    
    wire [31:0]n157_2;
    wire [8:0]n191;
    wire [31:0]n157;
    wire [31:0]n157_3;
    wire [8:0]n346;
    wire [3:0]n246_2;
    wire [3:0]n246_3;
    wire [3:0]n246_4;
    
    wire \data_ready~O ;
    wire [9:0]n221;
    
    wire \sub_27/add_2/n12 , \sub_27/add_2/n14 , \sub_27/add_2/n16 , \add_73/n2 ;
    wire [10:0]\led_sig/n29 ;
    
    wire \led_sig/add_16/n10 , \add_15/n4 ;
    wire [3:0]debug_out;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(14)
    wire [100:0]\deb1d/deb ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(75)
    
    wire deb1, count;
    wire [100:0]\deb2d/deb ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(75)
    
    wire deb2, \sub_27/add_2/n10 , button1_ps;
    wire [31:0]\b1_cont/state ;   // C:\Users\caleb\.efinity\project\test_project\button_press.sv(5)
    
    wire \b1_cont/pre_out , \sub_27/add_2/n8 , button2_ps;
    wire [31:0]\b2_cont/state ;   // C:\Users\caleb\.efinity\project\test_project\button_press.sv(5)
    
    wire \b2_cont/pre_out , \add_15/n16 , \add_15/n14 , \add_15/n12 , 
        \add_15/n10 , \add_15/n8 , \add_15/n6 ;
    wire [31:0]clk_div;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(17)
    wire [31:0]\comms/data_loaded ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(121)
    wire [4:0]\comms/addr ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(122)
    
    wire data_ready, \add_73/n14 , \add_73/n12 , \add_73/n10 , \add_73/n8 , 
        \add_73/n6 , \sub_27/add_2/n6 ;
    wire [10:0]\led_sig/counter ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(85)
    
    wire \led_sig/add_16/n2 , \sub_27/add_2/n2 , \add_73/n4 , \sub_27/add_2/n4 ;
    wire [10:0]period;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(6)
    
    wire \led_sig/add_16/n8 , \led_sig/add_16/n6 , \led_sig/add_16/n18 , 
        \led_sig/add_16/n16 , \led_sig/add_16/n14 , \led_sig/add_16/n12 , 
        \led_sig/add_16/n4 , \comms/gen_clk~O , ceg_net2, \clk_div[4]~O , 
        \deb1d/reduce_or_4/n5 , \CLK_50~O , \deb2d/reduce_or_4/n5 , \b1_cont/next_out , 
        \b2_cont/next_out ;
    wire [31:0]SPI_data_out;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(31)
    
    wire \comms/gen_clk , \comms/equal_5/n9 , \comms/n539 , n271, \comms/n546 , 
        \comms/n551 , \comms/n556 , \led_sig/n27 , n243, n244, n245, 
        n246, n247, n248, n249, n250, n251, n252, n253, n254, 
        n255, n256, n257, n258, n259, n260, n261, n262, n263, 
        n264, n265, n266, n267, n268, n269, n270, \led_sig/div[8]~O ;
    
    assign SPI_outgoing = led[3] /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_OUTPUT=TRUE */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(25)
    EFX_GBUFCE CLKBUF__3 (.CE(1'b1), .I(data_ready), .O(\data_ready~O )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_GBUFCE, CE_POLARITY=1'b1 */ ;
    defparam CLKBUF__3.CE_POLARITY = 1'b1;
    EFX_LUT4 LUT__611 (.I0(n243), .I1(\comms/addr [2]), .O(n244)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h4444 */ ;
    defparam LUT__611.LUTMASK = 16'h4444;
    EFX_FF \debug_out[0]~FF  (.D(debug_out[0]), .CE(ceg_net2), .CLK(\CLK_50~O ), 
           .SR(1'b0), .Q(debug_out[0])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b0, CE_POLARITY=1'b0, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(70)
    defparam \debug_out[0]~FF .CLK_POLARITY = 1'b1;
    defparam \debug_out[0]~FF .CE_POLARITY = 1'b0;
    defparam \debug_out[0]~FF .SR_POLARITY = 1'b1;
    defparam \debug_out[0]~FF .D_POLARITY = 1'b0;
    defparam \debug_out[0]~FF .SR_SYNC = 1'b1;
    defparam \debug_out[0]~FF .SR_VALUE = 1'b0;
    defparam \debug_out[0]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \deb1d/deb[0]~FF  (.D(Button1), .CE(1'b1), .CLK(\clk_div[4]~O ), 
           .SR(1'b0), .Q(\deb1d/deb [0])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(79)
    defparam \deb1d/deb[0]~FF .CLK_POLARITY = 1'b1;
    defparam \deb1d/deb[0]~FF .CE_POLARITY = 1'b1;
    defparam \deb1d/deb[0]~FF .SR_POLARITY = 1'b1;
    defparam \deb1d/deb[0]~FF .D_POLARITY = 1'b1;
    defparam \deb1d/deb[0]~FF .SR_SYNC = 1'b1;
    defparam \deb1d/deb[0]~FF .SR_VALUE = 1'b0;
    defparam \deb1d/deb[0]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \deb1~FF  (.D(\deb1d/reduce_or_4/n5 ), .CE(1'b1), .CLK(\clk_div[4]~O ), 
           .SR(1'b0), .Q(deb1)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(79)
    defparam \deb1~FF .CLK_POLARITY = 1'b1;
    defparam \deb1~FF .CE_POLARITY = 1'b1;
    defparam \deb1~FF .SR_POLARITY = 1'b1;
    defparam \deb1~FF .D_POLARITY = 1'b1;
    defparam \deb1~FF .SR_SYNC = 1'b1;
    defparam \deb1~FF .SR_VALUE = 1'b0;
    defparam \deb1~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \count~FF  (.D(count), .CE(1'b1), .CLK(\data_ready~O ), .SR(1'b0), 
           .Q(count)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b0, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(40)
    defparam \count~FF .CLK_POLARITY = 1'b1;
    defparam \count~FF .CE_POLARITY = 1'b1;
    defparam \count~FF .SR_POLARITY = 1'b1;
    defparam \count~FF .D_POLARITY = 1'b0;
    defparam \count~FF .SR_SYNC = 1'b1;
    defparam \count~FF .SR_VALUE = 1'b0;
    defparam \count~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \deb1d/deb[1]~FF  (.D(\deb1d/deb [0]), .CE(1'b1), .CLK(\clk_div[4]~O ), 
           .SR(1'b0), .Q(\deb1d/deb [1])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(79)
    defparam \deb1d/deb[1]~FF .CLK_POLARITY = 1'b1;
    defparam \deb1d/deb[1]~FF .CE_POLARITY = 1'b1;
    defparam \deb1d/deb[1]~FF .SR_POLARITY = 1'b1;
    defparam \deb1d/deb[1]~FF .D_POLARITY = 1'b1;
    defparam \deb1d/deb[1]~FF .SR_SYNC = 1'b1;
    defparam \deb1d/deb[1]~FF .SR_VALUE = 1'b0;
    defparam \deb1d/deb[1]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \deb1d/deb[2]~FF  (.D(\deb1d/deb [1]), .CE(1'b1), .CLK(\clk_div[4]~O ), 
           .SR(1'b0), .Q(\deb1d/deb [2])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(79)
    defparam \deb1d/deb[2]~FF .CLK_POLARITY = 1'b1;
    defparam \deb1d/deb[2]~FF .CE_POLARITY = 1'b1;
    defparam \deb1d/deb[2]~FF .SR_POLARITY = 1'b1;
    defparam \deb1d/deb[2]~FF .D_POLARITY = 1'b1;
    defparam \deb1d/deb[2]~FF .SR_SYNC = 1'b1;
    defparam \deb1d/deb[2]~FF .SR_VALUE = 1'b0;
    defparam \deb1d/deb[2]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \deb1d/deb[3]~FF  (.D(\deb1d/deb [2]), .CE(1'b1), .CLK(\clk_div[4]~O ), 
           .SR(1'b0), .Q(\deb1d/deb [3])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(79)
    defparam \deb1d/deb[3]~FF .CLK_POLARITY = 1'b1;
    defparam \deb1d/deb[3]~FF .CE_POLARITY = 1'b1;
    defparam \deb1d/deb[3]~FF .SR_POLARITY = 1'b1;
    defparam \deb1d/deb[3]~FF .D_POLARITY = 1'b1;
    defparam \deb1d/deb[3]~FF .SR_SYNC = 1'b1;
    defparam \deb1d/deb[3]~FF .SR_VALUE = 1'b0;
    defparam \deb1d/deb[3]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \deb1d/deb[4]~FF  (.D(\deb1d/deb [3]), .CE(1'b1), .CLK(\clk_div[4]~O ), 
           .SR(1'b0), .Q(\deb1d/deb [4])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(79)
    defparam \deb1d/deb[4]~FF .CLK_POLARITY = 1'b1;
    defparam \deb1d/deb[4]~FF .CE_POLARITY = 1'b1;
    defparam \deb1d/deb[4]~FF .SR_POLARITY = 1'b1;
    defparam \deb1d/deb[4]~FF .D_POLARITY = 1'b1;
    defparam \deb1d/deb[4]~FF .SR_SYNC = 1'b1;
    defparam \deb1d/deb[4]~FF .SR_VALUE = 1'b0;
    defparam \deb1d/deb[4]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \deb1d/deb[5]~FF  (.D(\deb1d/deb [4]), .CE(1'b1), .CLK(\clk_div[4]~O ), 
           .SR(1'b0), .Q(\deb1d/deb [5])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(79)
    defparam \deb1d/deb[5]~FF .CLK_POLARITY = 1'b1;
    defparam \deb1d/deb[5]~FF .CE_POLARITY = 1'b1;
    defparam \deb1d/deb[5]~FF .SR_POLARITY = 1'b1;
    defparam \deb1d/deb[5]~FF .D_POLARITY = 1'b1;
    defparam \deb1d/deb[5]~FF .SR_SYNC = 1'b1;
    defparam \deb1d/deb[5]~FF .SR_VALUE = 1'b0;
    defparam \deb1d/deb[5]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \deb2d/deb[0]~FF  (.D(Button2), .CE(1'b1), .CLK(\clk_div[4]~O ), 
           .SR(1'b0), .Q(\deb2d/deb [0])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(79)
    defparam \deb2d/deb[0]~FF .CLK_POLARITY = 1'b1;
    defparam \deb2d/deb[0]~FF .CE_POLARITY = 1'b1;
    defparam \deb2d/deb[0]~FF .SR_POLARITY = 1'b1;
    defparam \deb2d/deb[0]~FF .D_POLARITY = 1'b1;
    defparam \deb2d/deb[0]~FF .SR_SYNC = 1'b1;
    defparam \deb2d/deb[0]~FF .SR_VALUE = 1'b0;
    defparam \deb2d/deb[0]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \deb2~FF  (.D(\deb2d/reduce_or_4/n5 ), .CE(1'b1), .CLK(\clk_div[4]~O ), 
           .SR(1'b0), .Q(deb2)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(79)
    defparam \deb2~FF .CLK_POLARITY = 1'b1;
    defparam \deb2~FF .CE_POLARITY = 1'b1;
    defparam \deb2~FF .SR_POLARITY = 1'b1;
    defparam \deb2~FF .D_POLARITY = 1'b1;
    defparam \deb2~FF .SR_SYNC = 1'b1;
    defparam \deb2~FF .SR_VALUE = 1'b0;
    defparam \deb2~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \deb2d/deb[1]~FF  (.D(\deb2d/deb [0]), .CE(1'b1), .CLK(\clk_div[4]~O ), 
           .SR(1'b0), .Q(\deb2d/deb [1])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(79)
    defparam \deb2d/deb[1]~FF .CLK_POLARITY = 1'b1;
    defparam \deb2d/deb[1]~FF .CE_POLARITY = 1'b1;
    defparam \deb2d/deb[1]~FF .SR_POLARITY = 1'b1;
    defparam \deb2d/deb[1]~FF .D_POLARITY = 1'b1;
    defparam \deb2d/deb[1]~FF .SR_SYNC = 1'b1;
    defparam \deb2d/deb[1]~FF .SR_VALUE = 1'b0;
    defparam \deb2d/deb[1]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \deb2d/deb[2]~FF  (.D(\deb2d/deb [1]), .CE(1'b1), .CLK(\clk_div[4]~O ), 
           .SR(1'b0), .Q(\deb2d/deb [2])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(79)
    defparam \deb2d/deb[2]~FF .CLK_POLARITY = 1'b1;
    defparam \deb2d/deb[2]~FF .CE_POLARITY = 1'b1;
    defparam \deb2d/deb[2]~FF .SR_POLARITY = 1'b1;
    defparam \deb2d/deb[2]~FF .D_POLARITY = 1'b1;
    defparam \deb2d/deb[2]~FF .SR_SYNC = 1'b1;
    defparam \deb2d/deb[2]~FF .SR_VALUE = 1'b0;
    defparam \deb2d/deb[2]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \deb2d/deb[3]~FF  (.D(\deb2d/deb [2]), .CE(1'b1), .CLK(\clk_div[4]~O ), 
           .SR(1'b0), .Q(\deb2d/deb [3])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(79)
    defparam \deb2d/deb[3]~FF .CLK_POLARITY = 1'b1;
    defparam \deb2d/deb[3]~FF .CE_POLARITY = 1'b1;
    defparam \deb2d/deb[3]~FF .SR_POLARITY = 1'b1;
    defparam \deb2d/deb[3]~FF .D_POLARITY = 1'b1;
    defparam \deb2d/deb[3]~FF .SR_SYNC = 1'b1;
    defparam \deb2d/deb[3]~FF .SR_VALUE = 1'b0;
    defparam \deb2d/deb[3]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \deb2d/deb[4]~FF  (.D(\deb2d/deb [3]), .CE(1'b1), .CLK(\clk_div[4]~O ), 
           .SR(1'b0), .Q(\deb2d/deb [4])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(79)
    defparam \deb2d/deb[4]~FF .CLK_POLARITY = 1'b1;
    defparam \deb2d/deb[4]~FF .CE_POLARITY = 1'b1;
    defparam \deb2d/deb[4]~FF .SR_POLARITY = 1'b1;
    defparam \deb2d/deb[4]~FF .D_POLARITY = 1'b1;
    defparam \deb2d/deb[4]~FF .SR_SYNC = 1'b1;
    defparam \deb2d/deb[4]~FF .SR_VALUE = 1'b0;
    defparam \deb2d/deb[4]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \deb2d/deb[5]~FF  (.D(\deb2d/deb [4]), .CE(1'b1), .CLK(\clk_div[4]~O ), 
           .SR(1'b0), .Q(\deb2d/deb [5])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(79)
    defparam \deb2d/deb[5]~FF .CLK_POLARITY = 1'b1;
    defparam \deb2d/deb[5]~FF .CE_POLARITY = 1'b1;
    defparam \deb2d/deb[5]~FF .SR_POLARITY = 1'b1;
    defparam \deb2d/deb[5]~FF .D_POLARITY = 1'b1;
    defparam \deb2d/deb[5]~FF .SR_SYNC = 1'b1;
    defparam \deb2d/deb[5]~FF .SR_VALUE = 1'b0;
    defparam \deb2d/deb[5]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \button1_ps~FF  (.D(\b1_cont/pre_out ), .CE(1'b1), .CLK(\CLK_50~O ), 
           .SR(1'b0), .Q(button1_ps)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\button_press.sv(40)
    defparam \button1_ps~FF .CLK_POLARITY = 1'b1;
    defparam \button1_ps~FF .CE_POLARITY = 1'b1;
    defparam \button1_ps~FF .SR_POLARITY = 1'b1;
    defparam \button1_ps~FF .D_POLARITY = 1'b1;
    defparam \button1_ps~FF .SR_SYNC = 1'b1;
    defparam \button1_ps~FF .SR_VALUE = 1'b0;
    defparam \button1_ps~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \b1_cont/state[0]~FF  (.D(deb1), .CE(1'b1), .CLK(\CLK_50~O ), 
           .SR(1'b0), .Q(\b1_cont/state [0])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b0, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\button_press.sv(40)
    defparam \b1_cont/state[0]~FF .CLK_POLARITY = 1'b1;
    defparam \b1_cont/state[0]~FF .CE_POLARITY = 1'b1;
    defparam \b1_cont/state[0]~FF .SR_POLARITY = 1'b1;
    defparam \b1_cont/state[0]~FF .D_POLARITY = 1'b0;
    defparam \b1_cont/state[0]~FF .SR_SYNC = 1'b1;
    defparam \b1_cont/state[0]~FF .SR_VALUE = 1'b0;
    defparam \b1_cont/state[0]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \b1_cont/pre_out~FF  (.D(\b1_cont/next_out ), .CE(1'b1), .CLK(\CLK_50~O ), 
           .SR(1'b0), .Q(\b1_cont/pre_out )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\button_press.sv(40)
    defparam \b1_cont/pre_out~FF .CLK_POLARITY = 1'b1;
    defparam \b1_cont/pre_out~FF .CE_POLARITY = 1'b1;
    defparam \b1_cont/pre_out~FF .SR_POLARITY = 1'b1;
    defparam \b1_cont/pre_out~FF .D_POLARITY = 1'b1;
    defparam \b1_cont/pre_out~FF .SR_SYNC = 1'b1;
    defparam \b1_cont/pre_out~FF .SR_VALUE = 1'b0;
    defparam \b1_cont/pre_out~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \button2_ps~FF  (.D(\b2_cont/pre_out ), .CE(1'b1), .CLK(\CLK_50~O ), 
           .SR(1'b0), .Q(button2_ps)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\button_press.sv(40)
    defparam \button2_ps~FF .CLK_POLARITY = 1'b1;
    defparam \button2_ps~FF .CE_POLARITY = 1'b1;
    defparam \button2_ps~FF .SR_POLARITY = 1'b1;
    defparam \button2_ps~FF .D_POLARITY = 1'b1;
    defparam \button2_ps~FF .SR_SYNC = 1'b1;
    defparam \button2_ps~FF .SR_VALUE = 1'b0;
    defparam \button2_ps~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \b2_cont/state[0]~FF  (.D(deb2), .CE(1'b1), .CLK(\CLK_50~O ), 
           .SR(1'b0), .Q(\b2_cont/state [0])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b0, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\button_press.sv(40)
    defparam \b2_cont/state[0]~FF .CLK_POLARITY = 1'b1;
    defparam \b2_cont/state[0]~FF .CE_POLARITY = 1'b1;
    defparam \b2_cont/state[0]~FF .SR_POLARITY = 1'b1;
    defparam \b2_cont/state[0]~FF .D_POLARITY = 1'b0;
    defparam \b2_cont/state[0]~FF .SR_SYNC = 1'b1;
    defparam \b2_cont/state[0]~FF .SR_VALUE = 1'b0;
    defparam \b2_cont/state[0]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \b2_cont/pre_out~FF  (.D(\b2_cont/next_out ), .CE(1'b1), .CLK(\CLK_50~O ), 
           .SR(1'b0), .Q(\b2_cont/pre_out )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\button_press.sv(40)
    defparam \b2_cont/pre_out~FF .CLK_POLARITY = 1'b1;
    defparam \b2_cont/pre_out~FF .CE_POLARITY = 1'b1;
    defparam \b2_cont/pre_out~FF .SR_POLARITY = 1'b1;
    defparam \b2_cont/pre_out~FF .D_POLARITY = 1'b1;
    defparam \b2_cont/pre_out~FF .SR_SYNC = 1'b1;
    defparam \b2_cont/pre_out~FF .SR_VALUE = 1'b0;
    defparam \b2_cont/pre_out~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \clk_div[0]~FF  (.D(clk_div[0]), .CE(1'b1), .CLK(\CLK_50~O ), 
           .SR(1'b0), .Q(clk_div[0])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b0, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(70)
    defparam \clk_div[0]~FF .CLK_POLARITY = 1'b1;
    defparam \clk_div[0]~FF .CE_POLARITY = 1'b1;
    defparam \clk_div[0]~FF .SR_POLARITY = 1'b1;
    defparam \clk_div[0]~FF .D_POLARITY = 1'b0;
    defparam \clk_div[0]~FF .SR_SYNC = 1'b1;
    defparam \clk_div[0]~FF .SR_VALUE = 1'b0;
    defparam \clk_div[0]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \clk_div[1]~FF  (.D(n157_2[1]), .CE(1'b1), .CLK(\CLK_50~O ), 
           .SR(1'b0), .Q(clk_div[1])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(70)
    defparam \clk_div[1]~FF .CLK_POLARITY = 1'b1;
    defparam \clk_div[1]~FF .CE_POLARITY = 1'b1;
    defparam \clk_div[1]~FF .SR_POLARITY = 1'b1;
    defparam \clk_div[1]~FF .D_POLARITY = 1'b1;
    defparam \clk_div[1]~FF .SR_SYNC = 1'b1;
    defparam \clk_div[1]~FF .SR_VALUE = 1'b0;
    defparam \clk_div[1]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \clk_div[2]~FF  (.D(n157_3[2]), .CE(1'b1), .CLK(\CLK_50~O ), 
           .SR(1'b0), .Q(clk_div[2])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(70)
    defparam \clk_div[2]~FF .CLK_POLARITY = 1'b1;
    defparam \clk_div[2]~FF .CE_POLARITY = 1'b1;
    defparam \clk_div[2]~FF .SR_POLARITY = 1'b1;
    defparam \clk_div[2]~FF .D_POLARITY = 1'b1;
    defparam \clk_div[2]~FF .SR_SYNC = 1'b1;
    defparam \clk_div[2]~FF .SR_VALUE = 1'b0;
    defparam \clk_div[2]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \clk_div[3]~FF  (.D(n157[3]), .CE(1'b1), .CLK(\CLK_50~O ), 
           .SR(1'b0), .Q(clk_div[3])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(70)
    defparam \clk_div[3]~FF .CLK_POLARITY = 1'b1;
    defparam \clk_div[3]~FF .CE_POLARITY = 1'b1;
    defparam \clk_div[3]~FF .SR_POLARITY = 1'b1;
    defparam \clk_div[3]~FF .D_POLARITY = 1'b1;
    defparam \clk_div[3]~FF .SR_SYNC = 1'b1;
    defparam \clk_div[3]~FF .SR_VALUE = 1'b0;
    defparam \clk_div[3]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \clk_div[4]~FF  (.D(n157[4]), .CE(1'b1), .CLK(\CLK_50~O ), 
           .SR(1'b0), .Q(clk_div[4])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(70)
    defparam \clk_div[4]~FF .CLK_POLARITY = 1'b1;
    defparam \clk_div[4]~FF .CE_POLARITY = 1'b1;
    defparam \clk_div[4]~FF .SR_POLARITY = 1'b1;
    defparam \clk_div[4]~FF .D_POLARITY = 1'b1;
    defparam \clk_div[4]~FF .SR_SYNC = 1'b1;
    defparam \clk_div[4]~FF .SR_VALUE = 1'b0;
    defparam \clk_div[4]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \clk_div[5]~FF  (.D(n157[5]), .CE(1'b1), .CLK(\CLK_50~O ), 
           .SR(1'b0), .Q(clk_div[5])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(70)
    defparam \clk_div[5]~FF .CLK_POLARITY = 1'b1;
    defparam \clk_div[5]~FF .CE_POLARITY = 1'b1;
    defparam \clk_div[5]~FF .SR_POLARITY = 1'b1;
    defparam \clk_div[5]~FF .D_POLARITY = 1'b1;
    defparam \clk_div[5]~FF .SR_SYNC = 1'b1;
    defparam \clk_div[5]~FF .SR_VALUE = 1'b0;
    defparam \clk_div[5]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \clk_div[6]~FF  (.D(n157[6]), .CE(1'b1), .CLK(\CLK_50~O ), 
           .SR(1'b0), .Q(clk_div[6])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(70)
    defparam \clk_div[6]~FF .CLK_POLARITY = 1'b1;
    defparam \clk_div[6]~FF .CE_POLARITY = 1'b1;
    defparam \clk_div[6]~FF .SR_POLARITY = 1'b1;
    defparam \clk_div[6]~FF .D_POLARITY = 1'b1;
    defparam \clk_div[6]~FF .SR_SYNC = 1'b1;
    defparam \clk_div[6]~FF .SR_VALUE = 1'b0;
    defparam \clk_div[6]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \clk_div[7]~FF  (.D(n157[7]), .CE(1'b1), .CLK(\CLK_50~O ), 
           .SR(1'b0), .Q(clk_div[7])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(70)
    defparam \clk_div[7]~FF .CLK_POLARITY = 1'b1;
    defparam \clk_div[7]~FF .CE_POLARITY = 1'b1;
    defparam \clk_div[7]~FF .SR_POLARITY = 1'b1;
    defparam \clk_div[7]~FF .D_POLARITY = 1'b1;
    defparam \clk_div[7]~FF .SR_SYNC = 1'b1;
    defparam \clk_div[7]~FF .SR_VALUE = 1'b0;
    defparam \clk_div[7]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \clk_div[8]~FF  (.D(n157[8]), .CE(1'b1), .CLK(\CLK_50~O ), 
           .SR(1'b0), .Q(clk_div[8])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(70)
    defparam \clk_div[8]~FF .CLK_POLARITY = 1'b1;
    defparam \clk_div[8]~FF .CE_POLARITY = 1'b1;
    defparam \clk_div[8]~FF .SR_POLARITY = 1'b1;
    defparam \clk_div[8]~FF .D_POLARITY = 1'b1;
    defparam \clk_div[8]~FF .SR_SYNC = 1'b1;
    defparam \clk_div[8]~FF .SR_VALUE = 1'b0;
    defparam \clk_div[8]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \comms/data_loaded[0]~FF  (.D(SPI_data_out[0]), .CE(\comms/equal_5/n9 ), 
           .CLK(\comms/gen_clk~O ), .SR(1'b0), .Q(\comms/data_loaded [0])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b0, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(158)
    defparam \comms/data_loaded[0]~FF .CLK_POLARITY = 1'b1;
    defparam \comms/data_loaded[0]~FF .CE_POLARITY = 1'b0;
    defparam \comms/data_loaded[0]~FF .SR_POLARITY = 1'b1;
    defparam \comms/data_loaded[0]~FF .D_POLARITY = 1'b1;
    defparam \comms/data_loaded[0]~FF .SR_SYNC = 1'b1;
    defparam \comms/data_loaded[0]~FF .SR_VALUE = 1'b0;
    defparam \comms/data_loaded[0]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \comms/addr[1]~FF  (.D(\comms/n539 ), .CE(1'b1), .CLK(\comms/gen_clk~O ), 
           .SR(CS), .Q(\comms/addr [1])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(158)
    defparam \comms/addr[1]~FF .CLK_POLARITY = 1'b1;
    defparam \comms/addr[1]~FF .CE_POLARITY = 1'b1;
    defparam \comms/addr[1]~FF .SR_POLARITY = 1'b1;
    defparam \comms/addr[1]~FF .D_POLARITY = 1'b1;
    defparam \comms/addr[1]~FF .SR_SYNC = 1'b1;
    defparam \comms/addr[1]~FF .SR_VALUE = 1'b0;
    defparam \comms/addr[1]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \data_ready~FF  (.D(\comms/equal_5/n9 ), .CE(1'b1), .CLK(\comms/gen_clk~O ), 
           .SR(1'b0), .Q(data_ready)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b0, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(158)
    defparam \data_ready~FF .CLK_POLARITY = 1'b1;
    defparam \data_ready~FF .CE_POLARITY = 1'b1;
    defparam \data_ready~FF .SR_POLARITY = 1'b1;
    defparam \data_ready~FF .D_POLARITY = 1'b0;
    defparam \data_ready~FF .SR_SYNC = 1'b1;
    defparam \data_ready~FF .SR_VALUE = 1'b0;
    defparam \data_ready~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \comms/addr[0]~FF  (.D(\comms/addr [0]), .CE(1'b1), .CLK(\comms/gen_clk~O ), 
           .SR(CS), .Q(\comms/addr [0])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b0, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(158)
    defparam \comms/addr[0]~FF .CLK_POLARITY = 1'b1;
    defparam \comms/addr[0]~FF .CE_POLARITY = 1'b1;
    defparam \comms/addr[0]~FF .SR_POLARITY = 1'b1;
    defparam \comms/addr[0]~FF .D_POLARITY = 1'b0;
    defparam \comms/addr[0]~FF .SR_SYNC = 1'b1;
    defparam \comms/addr[0]~FF .SR_VALUE = 1'b0;
    defparam \comms/addr[0]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \comms/data_loaded[1]~FF  (.D(SPI_data_out[1]), .CE(\comms/equal_5/n9 ), 
           .CLK(\comms/gen_clk~O ), .SR(1'b0), .Q(\comms/data_loaded [1])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b0, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(158)
    defparam \comms/data_loaded[1]~FF .CLK_POLARITY = 1'b1;
    defparam \comms/data_loaded[1]~FF .CE_POLARITY = 1'b0;
    defparam \comms/data_loaded[1]~FF .SR_POLARITY = 1'b1;
    defparam \comms/data_loaded[1]~FF .D_POLARITY = 1'b1;
    defparam \comms/data_loaded[1]~FF .SR_SYNC = 1'b1;
    defparam \comms/data_loaded[1]~FF .SR_VALUE = 1'b0;
    defparam \comms/data_loaded[1]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \comms/data_loaded[2]~FF  (.D(SPI_data_out[2]), .CE(\comms/equal_5/n9 ), 
           .CLK(\comms/gen_clk~O ), .SR(1'b0), .Q(\comms/data_loaded [2])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b0, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(158)
    defparam \comms/data_loaded[2]~FF .CLK_POLARITY = 1'b1;
    defparam \comms/data_loaded[2]~FF .CE_POLARITY = 1'b0;
    defparam \comms/data_loaded[2]~FF .SR_POLARITY = 1'b1;
    defparam \comms/data_loaded[2]~FF .D_POLARITY = 1'b1;
    defparam \comms/data_loaded[2]~FF .SR_SYNC = 1'b1;
    defparam \comms/data_loaded[2]~FF .SR_VALUE = 1'b0;
    defparam \comms/data_loaded[2]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \comms/data_loaded[3]~FF  (.D(SPI_data_out[3]), .CE(\comms/equal_5/n9 ), 
           .CLK(\comms/gen_clk~O ), .SR(1'b0), .Q(\comms/data_loaded [3])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b0, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(158)
    defparam \comms/data_loaded[3]~FF .CLK_POLARITY = 1'b1;
    defparam \comms/data_loaded[3]~FF .CE_POLARITY = 1'b0;
    defparam \comms/data_loaded[3]~FF .SR_POLARITY = 1'b1;
    defparam \comms/data_loaded[3]~FF .D_POLARITY = 1'b1;
    defparam \comms/data_loaded[3]~FF .SR_SYNC = 1'b1;
    defparam \comms/data_loaded[3]~FF .SR_VALUE = 1'b0;
    defparam \comms/data_loaded[3]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \comms/data_loaded[7]~FF  (.D(SPI_data_out[7]), .CE(\comms/equal_5/n9 ), 
           .CLK(\comms/gen_clk~O ), .SR(1'b0), .Q(\comms/data_loaded [7])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b0, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(158)
    defparam \comms/data_loaded[7]~FF .CLK_POLARITY = 1'b1;
    defparam \comms/data_loaded[7]~FF .CE_POLARITY = 1'b0;
    defparam \comms/data_loaded[7]~FF .SR_POLARITY = 1'b1;
    defparam \comms/data_loaded[7]~FF .D_POLARITY = 1'b1;
    defparam \comms/data_loaded[7]~FF .SR_SYNC = 1'b1;
    defparam \comms/data_loaded[7]~FF .SR_VALUE = 1'b0;
    defparam \comms/data_loaded[7]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \comms/data_loaded[8]~FF  (.D(SPI_data_out[8]), .CE(\comms/equal_5/n9 ), 
           .CLK(\comms/gen_clk~O ), .SR(1'b0), .Q(\comms/data_loaded [8])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b0, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(158)
    defparam \comms/data_loaded[8]~FF .CLK_POLARITY = 1'b1;
    defparam \comms/data_loaded[8]~FF .CE_POLARITY = 1'b0;
    defparam \comms/data_loaded[8]~FF .SR_POLARITY = 1'b1;
    defparam \comms/data_loaded[8]~FF .D_POLARITY = 1'b1;
    defparam \comms/data_loaded[8]~FF .SR_SYNC = 1'b1;
    defparam \comms/data_loaded[8]~FF .SR_VALUE = 1'b0;
    defparam \comms/data_loaded[8]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \comms/data_loaded[9]~FF  (.D(SPI_data_out[9]), .CE(\comms/equal_5/n9 ), 
           .CLK(\comms/gen_clk~O ), .SR(1'b0), .Q(\comms/data_loaded [9])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b0, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(158)
    defparam \comms/data_loaded[9]~FF .CLK_POLARITY = 1'b1;
    defparam \comms/data_loaded[9]~FF .CE_POLARITY = 1'b0;
    defparam \comms/data_loaded[9]~FF .SR_POLARITY = 1'b1;
    defparam \comms/data_loaded[9]~FF .D_POLARITY = 1'b1;
    defparam \comms/data_loaded[9]~FF .SR_SYNC = 1'b1;
    defparam \comms/data_loaded[9]~FF .SR_VALUE = 1'b0;
    defparam \comms/data_loaded[9]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \comms/data_loaded[10]~FF  (.D(SPI_data_out[10]), .CE(\comms/equal_5/n9 ), 
           .CLK(\comms/gen_clk~O ), .SR(1'b0), .Q(\comms/data_loaded [10])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b0, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(158)
    defparam \comms/data_loaded[10]~FF .CLK_POLARITY = 1'b1;
    defparam \comms/data_loaded[10]~FF .CE_POLARITY = 1'b0;
    defparam \comms/data_loaded[10]~FF .SR_POLARITY = 1'b1;
    defparam \comms/data_loaded[10]~FF .D_POLARITY = 1'b1;
    defparam \comms/data_loaded[10]~FF .SR_SYNC = 1'b1;
    defparam \comms/data_loaded[10]~FF .SR_VALUE = 1'b0;
    defparam \comms/data_loaded[10]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \comms/addr[2]~FF  (.D(\comms/n546 ), .CE(1'b1), .CLK(\comms/gen_clk~O ), 
           .SR(CS), .Q(\comms/addr [2])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(158)
    defparam \comms/addr[2]~FF .CLK_POLARITY = 1'b1;
    defparam \comms/addr[2]~FF .CE_POLARITY = 1'b1;
    defparam \comms/addr[2]~FF .SR_POLARITY = 1'b1;
    defparam \comms/addr[2]~FF .D_POLARITY = 1'b1;
    defparam \comms/addr[2]~FF .SR_SYNC = 1'b1;
    defparam \comms/addr[2]~FF .SR_VALUE = 1'b0;
    defparam \comms/addr[2]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \comms/addr[3]~FF  (.D(\comms/n551 ), .CE(1'b1), .CLK(\comms/gen_clk~O ), 
           .SR(CS), .Q(\comms/addr [3])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(158)
    defparam \comms/addr[3]~FF .CLK_POLARITY = 1'b1;
    defparam \comms/addr[3]~FF .CE_POLARITY = 1'b1;
    defparam \comms/addr[3]~FF .SR_POLARITY = 1'b1;
    defparam \comms/addr[3]~FF .D_POLARITY = 1'b1;
    defparam \comms/addr[3]~FF .SR_SYNC = 1'b1;
    defparam \comms/addr[3]~FF .SR_VALUE = 1'b0;
    defparam \comms/addr[3]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \comms/addr[4]~FF  (.D(\comms/n556 ), .CE(1'b1), .CLK(\comms/gen_clk~O ), 
           .SR(CS), .Q(\comms/addr [4])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(158)
    defparam \comms/addr[4]~FF .CLK_POLARITY = 1'b1;
    defparam \comms/addr[4]~FF .CE_POLARITY = 1'b1;
    defparam \comms/addr[4]~FF .SR_POLARITY = 1'b1;
    defparam \comms/addr[4]~FF .D_POLARITY = 1'b1;
    defparam \comms/addr[4]~FF .SR_SYNC = 1'b1;
    defparam \comms/addr[4]~FF .SR_VALUE = 1'b0;
    defparam \comms/addr[4]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \led_sig/counter[2]~FF  (.D(\led_sig/n29 [2]), .CE(1'b1), .CLK(\led_sig/div[8]~O ), 
           .SR(\led_sig/n27 ), .Q(\led_sig/counter [2])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(100)
    defparam \led_sig/counter[2]~FF .CLK_POLARITY = 1'b1;
    defparam \led_sig/counter[2]~FF .CE_POLARITY = 1'b1;
    defparam \led_sig/counter[2]~FF .SR_POLARITY = 1'b1;
    defparam \led_sig/counter[2]~FF .D_POLARITY = 1'b1;
    defparam \led_sig/counter[2]~FF .SR_SYNC = 1'b1;
    defparam \led_sig/counter[2]~FF .SR_VALUE = 1'b0;
    defparam \led_sig/counter[2]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \led_sig/counter[1]~FF  (.D(\led_sig/n29 [1]), .CE(1'b1), .CLK(\led_sig/div[8]~O ), 
           .SR(\led_sig/n27 ), .Q(\led_sig/counter [1])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(100)
    defparam \led_sig/counter[1]~FF .CLK_POLARITY = 1'b1;
    defparam \led_sig/counter[1]~FF .CE_POLARITY = 1'b1;
    defparam \led_sig/counter[1]~FF .SR_POLARITY = 1'b1;
    defparam \led_sig/counter[1]~FF .D_POLARITY = 1'b1;
    defparam \led_sig/counter[1]~FF .SR_SYNC = 1'b1;
    defparam \led_sig/counter[1]~FF .SR_VALUE = 1'b0;
    defparam \led_sig/counter[1]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \led_sig/counter[0]~FF  (.D(\led_sig/counter [0]), .CE(1'b1), 
           .CLK(\led_sig/div[8]~O ), .SR(\led_sig/n27 ), .Q(\led_sig/counter [0])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b0, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(100)
    defparam \led_sig/counter[0]~FF .CLK_POLARITY = 1'b1;
    defparam \led_sig/counter[0]~FF .CE_POLARITY = 1'b1;
    defparam \led_sig/counter[0]~FF .SR_POLARITY = 1'b1;
    defparam \led_sig/counter[0]~FF .D_POLARITY = 1'b0;
    defparam \led_sig/counter[0]~FF .SR_SYNC = 1'b1;
    defparam \led_sig/counter[0]~FF .SR_VALUE = 1'b0;
    defparam \led_sig/counter[0]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \led_sig/counter[3]~FF  (.D(\led_sig/n29 [3]), .CE(1'b1), .CLK(\led_sig/div[8]~O ), 
           .SR(\led_sig/n27 ), .Q(\led_sig/counter [3])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(100)
    defparam \led_sig/counter[3]~FF .CLK_POLARITY = 1'b1;
    defparam \led_sig/counter[3]~FF .CE_POLARITY = 1'b1;
    defparam \led_sig/counter[3]~FF .SR_POLARITY = 1'b1;
    defparam \led_sig/counter[3]~FF .D_POLARITY = 1'b1;
    defparam \led_sig/counter[3]~FF .SR_SYNC = 1'b1;
    defparam \led_sig/counter[3]~FF .SR_VALUE = 1'b0;
    defparam \led_sig/counter[3]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \led_sig/counter[4]~FF  (.D(\led_sig/n29 [4]), .CE(1'b1), .CLK(\led_sig/div[8]~O ), 
           .SR(\led_sig/n27 ), .Q(\led_sig/counter [4])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(100)
    defparam \led_sig/counter[4]~FF .CLK_POLARITY = 1'b1;
    defparam \led_sig/counter[4]~FF .CE_POLARITY = 1'b1;
    defparam \led_sig/counter[4]~FF .SR_POLARITY = 1'b1;
    defparam \led_sig/counter[4]~FF .D_POLARITY = 1'b1;
    defparam \led_sig/counter[4]~FF .SR_SYNC = 1'b1;
    defparam \led_sig/counter[4]~FF .SR_VALUE = 1'b0;
    defparam \led_sig/counter[4]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \led_sig/counter[5]~FF  (.D(\led_sig/n29 [5]), .CE(1'b1), .CLK(\led_sig/div[8]~O ), 
           .SR(\led_sig/n27 ), .Q(\led_sig/counter [5])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(100)
    defparam \led_sig/counter[5]~FF .CLK_POLARITY = 1'b1;
    defparam \led_sig/counter[5]~FF .CE_POLARITY = 1'b1;
    defparam \led_sig/counter[5]~FF .SR_POLARITY = 1'b1;
    defparam \led_sig/counter[5]~FF .D_POLARITY = 1'b1;
    defparam \led_sig/counter[5]~FF .SR_SYNC = 1'b1;
    defparam \led_sig/counter[5]~FF .SR_VALUE = 1'b0;
    defparam \led_sig/counter[5]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \led_sig/counter[6]~FF  (.D(\led_sig/n29 [6]), .CE(1'b1), .CLK(\led_sig/div[8]~O ), 
           .SR(\led_sig/n27 ), .Q(\led_sig/counter [6])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(100)
    defparam \led_sig/counter[6]~FF .CLK_POLARITY = 1'b1;
    defparam \led_sig/counter[6]~FF .CE_POLARITY = 1'b1;
    defparam \led_sig/counter[6]~FF .SR_POLARITY = 1'b1;
    defparam \led_sig/counter[6]~FF .D_POLARITY = 1'b1;
    defparam \led_sig/counter[6]~FF .SR_SYNC = 1'b1;
    defparam \led_sig/counter[6]~FF .SR_VALUE = 1'b0;
    defparam \led_sig/counter[6]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \led_sig/counter[7]~FF  (.D(\led_sig/n29 [7]), .CE(1'b1), .CLK(\led_sig/div[8]~O ), 
           .SR(\led_sig/n27 ), .Q(\led_sig/counter [7])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(100)
    defparam \led_sig/counter[7]~FF .CLK_POLARITY = 1'b1;
    defparam \led_sig/counter[7]~FF .CE_POLARITY = 1'b1;
    defparam \led_sig/counter[7]~FF .SR_POLARITY = 1'b1;
    defparam \led_sig/counter[7]~FF .D_POLARITY = 1'b1;
    defparam \led_sig/counter[7]~FF .SR_SYNC = 1'b1;
    defparam \led_sig/counter[7]~FF .SR_VALUE = 1'b0;
    defparam \led_sig/counter[7]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \led_sig/counter[8]~FF  (.D(\led_sig/n29 [8]), .CE(1'b1), .CLK(\led_sig/div[8]~O ), 
           .SR(\led_sig/n27 ), .Q(\led_sig/counter [8])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(100)
    defparam \led_sig/counter[8]~FF .CLK_POLARITY = 1'b1;
    defparam \led_sig/counter[8]~FF .CE_POLARITY = 1'b1;
    defparam \led_sig/counter[8]~FF .SR_POLARITY = 1'b1;
    defparam \led_sig/counter[8]~FF .D_POLARITY = 1'b1;
    defparam \led_sig/counter[8]~FF .SR_SYNC = 1'b1;
    defparam \led_sig/counter[8]~FF .SR_VALUE = 1'b0;
    defparam \led_sig/counter[8]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \led_sig/counter[9]~FF  (.D(\led_sig/n29 [9]), .CE(1'b1), .CLK(\led_sig/div[8]~O ), 
           .SR(\led_sig/n27 ), .Q(\led_sig/counter [9])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(100)
    defparam \led_sig/counter[9]~FF .CLK_POLARITY = 1'b1;
    defparam \led_sig/counter[9]~FF .CE_POLARITY = 1'b1;
    defparam \led_sig/counter[9]~FF .SR_POLARITY = 1'b1;
    defparam \led_sig/counter[9]~FF .D_POLARITY = 1'b1;
    defparam \led_sig/counter[9]~FF .SR_SYNC = 1'b1;
    defparam \led_sig/counter[9]~FF .SR_VALUE = 1'b0;
    defparam \led_sig/counter[9]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \led_sig/counter[10]~FF  (.D(\led_sig/n29 [10]), .CE(1'b1), .CLK(\led_sig/div[8]~O ), 
           .SR(\led_sig/n27 ), .Q(\led_sig/counter [10])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(100)
    defparam \led_sig/counter[10]~FF .CLK_POLARITY = 1'b1;
    defparam \led_sig/counter[10]~FF .CE_POLARITY = 1'b1;
    defparam \led_sig/counter[10]~FF .SR_POLARITY = 1'b1;
    defparam \led_sig/counter[10]~FF .D_POLARITY = 1'b1;
    defparam \led_sig/counter[10]~FF .SR_SYNC = 1'b1;
    defparam \led_sig/counter[10]~FF .SR_VALUE = 1'b0;
    defparam \led_sig/counter[10]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \period[5]~FF  (.D(n346[3]), .CE(ceg_net2), .CLK(\CLK_50~O ), 
           .SR(1'b0), .Q(period[5])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b0, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(70)
    defparam \period[5]~FF .CLK_POLARITY = 1'b1;
    defparam \period[5]~FF .CE_POLARITY = 1'b0;
    defparam \period[5]~FF .SR_POLARITY = 1'b1;
    defparam \period[5]~FF .D_POLARITY = 1'b1;
    defparam \period[5]~FF .SR_SYNC = 1'b1;
    defparam \period[5]~FF .SR_VALUE = 1'b0;
    defparam \period[5]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \period[6]~FF  (.D(n346[4]), .CE(ceg_net2), .CLK(\CLK_50~O ), 
           .SR(1'b0), .Q(period[6])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b0, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(70)
    defparam \period[6]~FF .CLK_POLARITY = 1'b1;
    defparam \period[6]~FF .CE_POLARITY = 1'b0;
    defparam \period[6]~FF .SR_POLARITY = 1'b1;
    defparam \period[6]~FF .D_POLARITY = 1'b1;
    defparam \period[6]~FF .SR_SYNC = 1'b1;
    defparam \period[6]~FF .SR_VALUE = 1'b0;
    defparam \period[6]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \period[7]~FF  (.D(n346[5]), .CE(ceg_net2), .CLK(\CLK_50~O ), 
           .SR(1'b0), .Q(period[7])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b0, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(70)
    defparam \period[7]~FF .CLK_POLARITY = 1'b1;
    defparam \period[7]~FF .CE_POLARITY = 1'b0;
    defparam \period[7]~FF .SR_POLARITY = 1'b1;
    defparam \period[7]~FF .D_POLARITY = 1'b1;
    defparam \period[7]~FF .SR_SYNC = 1'b1;
    defparam \period[7]~FF .SR_VALUE = 1'b0;
    defparam \period[7]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \period[8]~FF  (.D(n346[6]), .CE(ceg_net2), .CLK(\CLK_50~O ), 
           .SR(1'b0), .Q(period[8])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b0, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(70)
    defparam \period[8]~FF .CLK_POLARITY = 1'b1;
    defparam \period[8]~FF .CE_POLARITY = 1'b0;
    defparam \period[8]~FF .SR_POLARITY = 1'b1;
    defparam \period[8]~FF .D_POLARITY = 1'b1;
    defparam \period[8]~FF .SR_SYNC = 1'b1;
    defparam \period[8]~FF .SR_VALUE = 1'b0;
    defparam \period[8]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \period[9]~FF  (.D(n346[7]), .CE(ceg_net2), .CLK(\CLK_50~O ), 
           .SR(1'b0), .Q(period[9])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b0, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(70)
    defparam \period[9]~FF .CLK_POLARITY = 1'b1;
    defparam \period[9]~FF .CE_POLARITY = 1'b0;
    defparam \period[9]~FF .SR_POLARITY = 1'b1;
    defparam \period[9]~FF .D_POLARITY = 1'b1;
    defparam \period[9]~FF .SR_SYNC = 1'b1;
    defparam \period[9]~FF .SR_VALUE = 1'b0;
    defparam \period[9]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \period[10]~FF  (.D(n346[8]), .CE(ceg_net2), .CLK(\CLK_50~O ), 
           .SR(1'b0), .Q(period[10])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b0, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(70)
    defparam \period[10]~FF .CLK_POLARITY = 1'b1;
    defparam \period[10]~FF .CE_POLARITY = 1'b0;
    defparam \period[10]~FF .SR_POLARITY = 1'b1;
    defparam \period[10]~FF .D_POLARITY = 1'b1;
    defparam \period[10]~FF .SR_SYNC = 1'b1;
    defparam \period[10]~FF .SR_VALUE = 1'b0;
    defparam \period[10]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \debug_out[1]~FF  (.D(n246_2[1]), .CE(ceg_net2), .CLK(\CLK_50~O ), 
           .SR(1'b0), .Q(debug_out[1])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b0, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(70)
    defparam \debug_out[1]~FF .CLK_POLARITY = 1'b1;
    defparam \debug_out[1]~FF .CE_POLARITY = 1'b0;
    defparam \debug_out[1]~FF .SR_POLARITY = 1'b1;
    defparam \debug_out[1]~FF .D_POLARITY = 1'b1;
    defparam \debug_out[1]~FF .SR_SYNC = 1'b1;
    defparam \debug_out[1]~FF .SR_VALUE = 1'b0;
    defparam \debug_out[1]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \debug_out[2]~FF  (.D(n246_3[2]), .CE(ceg_net2), .CLK(\CLK_50~O ), 
           .SR(1'b0), .Q(debug_out[2])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b0, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(70)
    defparam \debug_out[2]~FF .CLK_POLARITY = 1'b1;
    defparam \debug_out[2]~FF .CE_POLARITY = 1'b0;
    defparam \debug_out[2]~FF .SR_POLARITY = 1'b1;
    defparam \debug_out[2]~FF .D_POLARITY = 1'b1;
    defparam \debug_out[2]~FF .SR_SYNC = 1'b1;
    defparam \debug_out[2]~FF .SR_VALUE = 1'b0;
    defparam \debug_out[2]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \debug_out[3]~FF  (.D(n246_4[3]), .CE(ceg_net2), .CLK(\CLK_50~O ), 
           .SR(1'b0), .Q(debug_out[3])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b0, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(70)
    defparam \debug_out[3]~FF .CLK_POLARITY = 1'b1;
    defparam \debug_out[3]~FF .CE_POLARITY = 1'b0;
    defparam \debug_out[3]~FF .SR_POLARITY = 1'b1;
    defparam \debug_out[3]~FF .D_POLARITY = 1'b1;
    defparam \debug_out[3]~FF .SR_SYNC = 1'b1;
    defparam \debug_out[3]~FF .SR_VALUE = 1'b0;
    defparam \debug_out[3]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_ADD \sub_27/add_2/i6  (.I0(period[7]), .I1(1'b1), .CI(\sub_27/add_2/n10 ), 
            .O(n221[5]), .CO(\sub_27/add_2/n12 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(67)
    defparam \sub_27/add_2/i6 .I0_POLARITY = 1'b1;
    defparam \sub_27/add_2/i6 .I1_POLARITY = 1'b1;
    EFX_ADD \sub_27/add_2/i7  (.I0(period[8]), .I1(1'b1), .CI(\sub_27/add_2/n12 ), 
            .O(n221[6]), .CO(\sub_27/add_2/n14 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(67)
    defparam \sub_27/add_2/i7 .I0_POLARITY = 1'b1;
    defparam \sub_27/add_2/i7 .I1_POLARITY = 1'b1;
    EFX_ADD \sub_27/add_2/i8  (.I0(period[9]), .I1(1'b1), .CI(\sub_27/add_2/n14 ), 
            .O(n221[7]), .CO(\sub_27/add_2/n16 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(67)
    defparam \sub_27/add_2/i8 .I0_POLARITY = 1'b1;
    defparam \sub_27/add_2/i8 .I1_POLARITY = 1'b1;
    EFX_ADD \add_73/i1  (.I0(clk_div[1]), .I1(clk_div[0]), .CI(1'b0), 
            .O(n157_2[1]), .CO(\add_73/n2 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(53)
    defparam \add_73/i1 .I0_POLARITY = 1'b1;
    defparam \add_73/i1 .I1_POLARITY = 1'b1;
    EFX_ADD \led_sig/add_16/i5  (.I0(\led_sig/counter [5]), .I1(1'b0), .CI(\led_sig/add_16/n8 ), 
            .O(\led_sig/n29 [5]), .CO(\led_sig/add_16/n10 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(99)
    defparam \led_sig/add_16/i5 .I0_POLARITY = 1'b1;
    defparam \led_sig/add_16/i5 .I1_POLARITY = 1'b1;
    EFX_ADD \sub_27/add_2/i9  (.I0(period[10]), .I1(1'b1), .CI(\sub_27/add_2/n16 ), 
            .O(n221[8])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(67)
    defparam \sub_27/add_2/i9 .I0_POLARITY = 1'b1;
    defparam \sub_27/add_2/i9 .I1_POLARITY = 1'b1;
    EFX_ADD \add_15/i2  (.I0(debug_out[1]), .I1(debug_out[0]), .CI(1'b0), 
            .CO(\add_15/n4 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(63)
    defparam \add_15/i2 .I0_POLARITY = 1'b1;
    defparam \add_15/i2 .I1_POLARITY = 1'b1;
    EFX_ADD \sub_27/add_2/i5  (.I0(period[6]), .I1(1'b0), .CI(\sub_27/add_2/n8 ), 
            .O(n221[4]), .CO(\sub_27/add_2/n10 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(67)
    defparam \sub_27/add_2/i5 .I0_POLARITY = 1'b1;
    defparam \sub_27/add_2/i5 .I1_POLARITY = 1'b1;
    EFX_ADD \sub_27/add_2/i4  (.I0(period[5]), .I1(1'b0), .CI(\sub_27/add_2/n6 ), 
            .O(n221[3]), .CO(\sub_27/add_2/n8 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(67)
    defparam \sub_27/add_2/i4 .I0_POLARITY = 1'b1;
    defparam \sub_27/add_2/i4 .I1_POLARITY = 1'b1;
    EFX_ADD \add_15/i9  (.I0(period[10]), .I1(1'b0), .CI(\add_15/n16 ), 
            .O(n191[8])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(63)
    defparam \add_15/i9 .I0_POLARITY = 1'b1;
    defparam \add_15/i9 .I1_POLARITY = 1'b1;
    EFX_ADD \add_15/i8  (.I0(period[9]), .I1(1'b0), .CI(\add_15/n14 ), 
            .O(n191[7]), .CO(\add_15/n16 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(63)
    defparam \add_15/i8 .I0_POLARITY = 1'b1;
    defparam \add_15/i8 .I1_POLARITY = 1'b1;
    EFX_ADD \add_15/i7  (.I0(period[8]), .I1(1'b0), .CI(\add_15/n12 ), 
            .O(n191[6]), .CO(\add_15/n14 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(63)
    defparam \add_15/i7 .I0_POLARITY = 1'b1;
    defparam \add_15/i7 .I1_POLARITY = 1'b1;
    EFX_ADD \add_15/i6  (.I0(period[7]), .I1(1'b0), .CI(\add_15/n10 ), 
            .O(n191[5]), .CO(\add_15/n12 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(63)
    defparam \add_15/i6 .I0_POLARITY = 1'b1;
    defparam \add_15/i6 .I1_POLARITY = 1'b1;
    EFX_ADD \add_15/i5  (.I0(period[6]), .I1(1'b1), .CI(\add_15/n8 ), 
            .O(n191[4]), .CO(\add_15/n10 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(63)
    defparam \add_15/i5 .I0_POLARITY = 1'b1;
    defparam \add_15/i5 .I1_POLARITY = 1'b1;
    EFX_ADD \add_15/i4  (.I0(period[5]), .I1(1'b1), .CI(\add_15/n6 ), 
            .O(n191[3]), .CO(\add_15/n8 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(63)
    defparam \add_15/i4 .I0_POLARITY = 1'b1;
    defparam \add_15/i4 .I1_POLARITY = 1'b1;
    EFX_ADD \add_15/i3  (.I0(debug_out[2]), .I1(1'b0), .CI(\add_15/n4 ), 
            .CO(\add_15/n6 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(63)
    defparam \add_15/i3 .I0_POLARITY = 1'b1;
    defparam \add_15/i3 .I1_POLARITY = 1'b1;
    EFX_ADD \add_73/i8  (.I0(clk_div[8]), .I1(1'b0), .CI(\add_73/n14 ), 
            .O(n157[8])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(53)
    defparam \add_73/i8 .I0_POLARITY = 1'b1;
    defparam \add_73/i8 .I1_POLARITY = 1'b1;
    EFX_ADD \add_73/i7  (.I0(clk_div[7]), .I1(1'b0), .CI(\add_73/n12 ), 
            .O(n157[7]), .CO(\add_73/n14 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(53)
    defparam \add_73/i7 .I0_POLARITY = 1'b1;
    defparam \add_73/i7 .I1_POLARITY = 1'b1;
    EFX_ADD \add_73/i6  (.I0(clk_div[6]), .I1(1'b0), .CI(\add_73/n10 ), 
            .O(n157[6]), .CO(\add_73/n12 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(53)
    defparam \add_73/i6 .I0_POLARITY = 1'b1;
    defparam \add_73/i6 .I1_POLARITY = 1'b1;
    EFX_ADD \add_73/i5  (.I0(clk_div[5]), .I1(1'b0), .CI(\add_73/n8 ), 
            .O(n157[5]), .CO(\add_73/n10 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(53)
    defparam \add_73/i5 .I0_POLARITY = 1'b1;
    defparam \add_73/i5 .I1_POLARITY = 1'b1;
    EFX_ADD \add_73/i4  (.I0(clk_div[4]), .I1(1'b0), .CI(\add_73/n6 ), 
            .O(n157[4]), .CO(\add_73/n8 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(53)
    defparam \add_73/i4 .I0_POLARITY = 1'b1;
    defparam \add_73/i4 .I1_POLARITY = 1'b1;
    EFX_ADD \add_73/i3  (.I0(clk_div[3]), .I1(1'b0), .CI(\add_73/n4 ), 
            .O(n157[3]), .CO(\add_73/n6 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(53)
    defparam \add_73/i3 .I0_POLARITY = 1'b1;
    defparam \add_73/i3 .I1_POLARITY = 1'b1;
    EFX_ADD \sub_27/add_2/i3  (.I0(debug_out[2]), .I1(1'b1), .CI(\sub_27/add_2/n4 ), 
            .CO(\sub_27/add_2/n6 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(67)
    defparam \sub_27/add_2/i3 .I0_POLARITY = 1'b1;
    defparam \sub_27/add_2/i3 .I1_POLARITY = 1'b1;
    EFX_ADD \led_sig/add_16/i1  (.I0(\led_sig/counter [1]), .I1(\led_sig/counter [0]), 
            .CI(1'b0), .O(\led_sig/n29 [1]), .CO(\led_sig/add_16/n2 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(99)
    defparam \led_sig/add_16/i1 .I0_POLARITY = 1'b1;
    defparam \led_sig/add_16/i1 .I1_POLARITY = 1'b1;
    EFX_ADD \sub_27/add_2/i1  (.I0(debug_out[0]), .I1(1'b0), .CI(n271), 
            .CO(\sub_27/add_2/n2 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(67)
    defparam \sub_27/add_2/i1 .I0_POLARITY = 1'b1;
    defparam \sub_27/add_2/i1 .I1_POLARITY = 1'b1;
    EFX_ADD \add_73/i2  (.I0(clk_div[2]), .I1(1'b0), .CI(\add_73/n2 ), 
            .O(n157_3[2]), .CO(\add_73/n4 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(53)
    defparam \add_73/i2 .I0_POLARITY = 1'b1;
    defparam \add_73/i2 .I1_POLARITY = 1'b1;
    EFX_ADD \sub_27/add_2/i2  (.I0(debug_out[1]), .I1(1'b1), .CI(\sub_27/add_2/n2 ), 
            .CO(\sub_27/add_2/n4 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(67)
    defparam \sub_27/add_2/i2 .I0_POLARITY = 1'b1;
    defparam \sub_27/add_2/i2 .I1_POLARITY = 1'b1;
    EFX_ADD \led_sig/add_16/i10  (.I0(\led_sig/counter [10]), .I1(1'b0), 
            .CI(\led_sig/add_16/n18 ), .O(\led_sig/n29 [10])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(99)
    defparam \led_sig/add_16/i10 .I0_POLARITY = 1'b1;
    defparam \led_sig/add_16/i10 .I1_POLARITY = 1'b1;
    EFX_ADD \led_sig/add_16/i4  (.I0(\led_sig/counter [4]), .I1(1'b0), .CI(\led_sig/add_16/n6 ), 
            .O(\led_sig/n29 [4]), .CO(\led_sig/add_16/n8 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(99)
    defparam \led_sig/add_16/i4 .I0_POLARITY = 1'b1;
    defparam \led_sig/add_16/i4 .I1_POLARITY = 1'b1;
    EFX_ADD \led_sig/add_16/i3  (.I0(\led_sig/counter [3]), .I1(1'b0), .CI(\led_sig/add_16/n4 ), 
            .O(\led_sig/n29 [3]), .CO(\led_sig/add_16/n6 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(99)
    defparam \led_sig/add_16/i3 .I0_POLARITY = 1'b1;
    defparam \led_sig/add_16/i3 .I1_POLARITY = 1'b1;
    EFX_ADD \led_sig/add_16/i9  (.I0(\led_sig/counter [9]), .I1(1'b0), .CI(\led_sig/add_16/n16 ), 
            .O(\led_sig/n29 [9]), .CO(\led_sig/add_16/n18 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(99)
    defparam \led_sig/add_16/i9 .I0_POLARITY = 1'b1;
    defparam \led_sig/add_16/i9 .I1_POLARITY = 1'b1;
    EFX_ADD \led_sig/add_16/i8  (.I0(\led_sig/counter [8]), .I1(1'b0), .CI(\led_sig/add_16/n14 ), 
            .O(\led_sig/n29 [8]), .CO(\led_sig/add_16/n16 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(99)
    defparam \led_sig/add_16/i8 .I0_POLARITY = 1'b1;
    defparam \led_sig/add_16/i8 .I1_POLARITY = 1'b1;
    EFX_ADD \led_sig/add_16/i7  (.I0(\led_sig/counter [7]), .I1(1'b0), .CI(\led_sig/add_16/n12 ), 
            .O(\led_sig/n29 [7]), .CO(\led_sig/add_16/n14 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(99)
    defparam \led_sig/add_16/i7 .I0_POLARITY = 1'b1;
    defparam \led_sig/add_16/i7 .I1_POLARITY = 1'b1;
    EFX_ADD \led_sig/add_16/i6  (.I0(\led_sig/counter [6]), .I1(1'b0), .CI(\led_sig/add_16/n10 ), 
            .O(\led_sig/n29 [6]), .CO(\led_sig/add_16/n12 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(99)
    defparam \led_sig/add_16/i6 .I0_POLARITY = 1'b1;
    defparam \led_sig/add_16/i6 .I1_POLARITY = 1'b1;
    EFX_ADD \led_sig/add_16/i2  (.I0(\led_sig/counter [2]), .I1(1'b0), .CI(\led_sig/add_16/n2 ), 
            .O(\led_sig/n29 [2]), .CO(\led_sig/add_16/n4 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(99)
    defparam \led_sig/add_16/i2 .I0_POLARITY = 1'b1;
    defparam \led_sig/add_16/i2 .I1_POLARITY = 1'b1;
    EFX_LUT4 LUT__612 (.I0(\comms/data_loaded [8]), .I1(\comms/data_loaded [9]), 
            .I2(\comms/addr [0]), .I3(\comms/addr [1]), .O(n245)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h5300 */ ;
    defparam LUT__612.LUTMASK = 16'h5300;
    EFX_LUT4 LUT__613 (.I0(n245), .I1(\comms/addr [3]), .O(n246)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h1111 */ ;
    defparam LUT__613.LUTMASK = 16'h1111;
    EFX_LUT4 LUT__614 (.I0(\comms/data_loaded [0]), .I1(\comms/data_loaded [1]), 
            .I2(\comms/addr [0]), .I3(\comms/addr [1]), .O(n247)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h5300 */ ;
    defparam LUT__614.LUTMASK = 16'h5300;
    EFX_LUT4 LUT__615 (.I0(\comms/data_loaded [2]), .I1(\comms/data_loaded [3]), 
            .I2(\comms/addr [1]), .I3(\comms/addr [0]), .O(n248)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h0503 */ ;
    defparam LUT__615.LUTMASK = 16'h0503;
    EFX_LUT4 LUT__616 (.I0(n247), .I1(n248), .I2(\comms/addr [2]), .I3(\comms/addr [3]), 
            .O(n249)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h1000 */ ;
    defparam LUT__616.LUTMASK = 16'h1000;
    EFX_LUT4 LUT__617 (.I0(n246), .I1(n244), .I2(n249), .I3(\comms/addr [4]), 
            .O(n250)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'hf800 */ ;
    defparam LUT__617.LUTMASK = 16'hf800;
    EFX_LUT4 LUT__618 (.I0(\comms/data_loaded [0]), .I1(\comms/data_loaded [8]), 
            .I2(\comms/addr [0]), .I3(\comms/addr [3]), .O(n251)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'ha0cf */ ;
    defparam LUT__618.LUTMASK = 16'ha0cf;
    EFX_LUT4 LUT__619 (.I0(\comms/data_loaded [9]), .I1(\comms/data_loaded [1]), 
            .I2(\comms/addr [0]), .I3(n251), .O(n252)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'hfc0a */ ;
    defparam LUT__619.LUTMASK = 16'hfc0a;
    EFX_LUT4 LUT__620 (.I0(\comms/addr [1]), .I1(n252), .I2(\comms/addr [4]), 
            .I3(n244), .O(n253)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h0d00 */ ;
    defparam LUT__620.LUTMASK = 16'h0d00;
    EFX_LUT4 LUT__621 (.I0(\comms/data_loaded [2]), .I1(\comms/data_loaded [7]), 
            .I2(\comms/addr [1]), .I3(\comms/addr [0]), .O(n254)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h0503 */ ;
    defparam LUT__621.LUTMASK = 16'h0503;
    EFX_LUT4 LUT__622 (.I0(n247), .I1(n254), .I2(\comms/addr [2]), .O(n255)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h0101 */ ;
    defparam LUT__622.LUTMASK = 16'h0101;
    EFX_LUT4 LUT__623 (.I0(n250), .I1(n253), .I2(n255), .O(led[3])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'hfefe */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(138)
    defparam LUT__623.LUTMASK = 16'hfefe;
    EFX_LUT4 LUT__624 (.I0(\led_sig/counter [4]), .I1(debug_out[2]), .O(n256)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h4444 */ ;
    defparam LUT__624.LUTMASK = 16'h4444;
    EFX_LUT4 LUT__625 (.I0(\led_sig/counter [3]), .I1(\led_sig/counter [2]), 
            .I2(debug_out[1]), .I3(debug_out[0]), .O(n257)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h8eaf */ ;
    defparam LUT__625.LUTMASK = 16'h8eaf;
    EFX_LUT4 LUT__626 (.I0(debug_out[2]), .I1(\led_sig/counter [4]), .I2(period[5]), 
            .I3(\led_sig/counter [5]), .O(n258)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'hb0bb */ ;
    defparam LUT__626.LUTMASK = 16'hb0bb;
    EFX_LUT4 LUT__627 (.I0(\led_sig/counter [5]), .I1(period[5]), .I2(\led_sig/counter [6]), 
            .I3(period[6]), .O(n259)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'hb0bb */ ;
    defparam LUT__627.LUTMASK = 16'hb0bb;
    EFX_LUT4 LUT__628 (.I0(n256), .I1(n257), .I2(n258), .I3(n259), .O(n260)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h4f00 */ ;
    defparam LUT__628.LUTMASK = 16'h4f00;
    EFX_LUT4 LUT__629 (.I0(period[6]), .I1(\led_sig/counter [6]), .I2(period[7]), 
            .I3(\led_sig/counter [7]), .O(n261)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'hb0bb */ ;
    defparam LUT__629.LUTMASK = 16'hb0bb;
    EFX_LUT4 LUT__630 (.I0(\led_sig/counter [7]), .I1(period[7]), .I2(\led_sig/counter [8]), 
            .I3(period[8]), .O(n262)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'hb0bb */ ;
    defparam LUT__630.LUTMASK = 16'hb0bb;
    EFX_LUT4 LUT__631 (.I0(period[8]), .I1(\led_sig/counter [8]), .I2(period[9]), 
            .I3(\led_sig/counter [9]), .O(n263)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'hb0bb */ ;
    defparam LUT__631.LUTMASK = 16'hb0bb;
    EFX_LUT4 LUT__632 (.I0(n260), .I1(n261), .I2(n262), .I3(n263), .O(n264)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h4f00 */ ;
    defparam LUT__632.LUTMASK = 16'h4f00;
    EFX_LUT4 LUT__633 (.I0(\led_sig/counter [9]), .I1(period[9]), .O(n265)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h4444 */ ;
    defparam LUT__633.LUTMASK = 16'h4444;
    EFX_LUT4 LUT__634 (.I0(\led_sig/counter [10]), .I1(period[10]), .I2(n264), 
            .I3(n265), .O(led[0])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h222b */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(101)
    defparam LUT__634.LUTMASK = 16'h222b;
    EFX_LUT4 LUT__636 (.I0(button1_ps), .I1(button2_ps), .O(ceg_net2)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h1111 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(7)
    defparam LUT__636.LUTMASK = 16'h1111;
    EFX_LUT4 LUT__610 (.I0(\comms/data_loaded [10]), .I1(\comms/data_loaded [7]), 
            .I2(\comms/addr [1]), .I3(\comms/addr [0]), .O(n243)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h0503 */ ;
    defparam LUT__610.LUTMASK = 16'h0503;
    EFX_LUT4 LUT__637 (.I0(\deb1d/deb [2]), .I1(\deb1d/deb [3]), .I2(\deb1d/deb [4]), 
            .I3(\deb1d/deb [5]), .O(n266)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h0001 */ ;
    defparam LUT__637.LUTMASK = 16'h0001;
    EFX_LUT4 LUT__638 (.I0(\deb1d/deb [0]), .I1(\deb1d/deb [1]), .I2(n266), 
            .O(\deb1d/reduce_or_4/n5 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'hefef */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(78)
    defparam LUT__638.LUTMASK = 16'hefef;
    EFX_LUT4 LUT__639 (.I0(\deb2d/deb [2]), .I1(\deb2d/deb [3]), .I2(\deb2d/deb [4]), 
            .I3(\deb2d/deb [5]), .O(n267)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h0001 */ ;
    defparam LUT__639.LUTMASK = 16'h0001;
    EFX_LUT4 LUT__640 (.I0(\deb2d/deb [0]), .I1(\deb2d/deb [1]), .I2(n267), 
            .O(\deb2d/reduce_or_4/n5 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'hefef */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(78)
    defparam LUT__640.LUTMASK = 16'hefef;
    EFX_LUT4 LUT__641 (.I0(deb1), .I1(\b1_cont/state [0]), .O(\b1_cont/next_out )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h1111 */ ;   // C:\Users\caleb\.efinity\project\test_project\button_press.sv(27)
    defparam LUT__641.LUTMASK = 16'h1111;
    EFX_LUT4 LUT__642 (.I0(deb2), .I1(\b2_cont/state [0]), .O(\b2_cont/next_out )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h1111 */ ;   // C:\Users\caleb\.efinity\project\test_project\button_press.sv(27)
    defparam LUT__642.LUTMASK = 16'h1111;
    EFX_LUT4 LUT__643 (.I0(count), .I1(debug_out[0]), .O(SPI_data_out[0])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h4444 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(37)
    defparam LUT__643.LUTMASK = 16'h4444;
    EFX_LUT4 LUT__644 (.I0(CLK_50), .I1(SPI_CLK), .I2(CS), .O(\comms/gen_clk )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'hacac */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(144)
    defparam LUT__644.LUTMASK = 16'hacac;
    EFX_LUT4 LUT__645 (.I0(\comms/addr [1]), .I1(\comms/addr [0]), .O(n268)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h8888 */ ;
    defparam LUT__645.LUTMASK = 16'h8888;
    EFX_LUT4 LUT__646 (.I0(n268), .I1(\comms/addr [2]), .I2(\comms/addr [3]), 
            .I3(\comms/addr [4]), .O(\comms/equal_5/n9 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h7fff */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(116)
    defparam LUT__646.LUTMASK = 16'h7fff;
    EFX_LUT4 LUT__647 (.I0(\comms/addr [1]), .I1(\comms/addr [0]), .O(\comms/n539 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h6666 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(44)
    defparam LUT__647.LUTMASK = 16'h6666;
    EFX_LUT4 LUT__648 (.I0(count), .I1(debug_out[1]), .O(SPI_data_out[1])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h4444 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(37)
    defparam LUT__648.LUTMASK = 16'h4444;
    EFX_LUT4 LUT__649 (.I0(count), .I1(debug_out[2]), .O(SPI_data_out[2])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h4444 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(37)
    defparam LUT__649.LUTMASK = 16'h4444;
    EFX_LUT4 LUT__650 (.I0(count), .I1(debug_out[3]), .O(SPI_data_out[3])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'heeee */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(37)
    defparam LUT__650.LUTMASK = 16'heeee;
    EFX_LUT4 LUT__651 (.I0(count), .I1(debug_out[3]), .O(SPI_data_out[7])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h4444 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(37)
    defparam LUT__651.LUTMASK = 16'h4444;
    EFX_LUT4 LUT__652 (.I0(debug_out[0]), .I1(count), .O(SPI_data_out[8])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'heeee */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(37)
    defparam LUT__652.LUTMASK = 16'heeee;
    EFX_LUT4 LUT__653 (.I0(count), .I1(debug_out[1]), .O(SPI_data_out[9])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'heeee */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(37)
    defparam LUT__653.LUTMASK = 16'heeee;
    EFX_LUT4 LUT__654 (.I0(count), .I1(debug_out[2]), .O(SPI_data_out[10])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'heeee */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(37)
    defparam LUT__654.LUTMASK = 16'heeee;
    EFX_LUT4 LUT__655 (.I0(n268), .I1(\comms/addr [2]), .O(\comms/n546 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h6666 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(44)
    defparam LUT__655.LUTMASK = 16'h6666;
    EFX_LUT4 LUT__656 (.I0(n268), .I1(\comms/addr [2]), .I2(\comms/addr [3]), 
            .O(\comms/n551 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h7878 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(44)
    defparam LUT__656.LUTMASK = 16'h7878;
    EFX_LUT4 LUT__657 (.I0(n268), .I1(\comms/addr [2]), .I2(\comms/addr [3]), 
            .I3(\comms/addr [4]), .O(\comms/n556 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h7f80 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(44)
    defparam LUT__657.LUTMASK = 16'h7f80;
    EFX_LUT4 LUT__658 (.I0(\led_sig/counter [4]), .I1(\led_sig/counter [5]), 
            .I2(\led_sig/counter [6]), .I3(\led_sig/counter [7]), .O(n269)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'he000 */ ;
    defparam LUT__658.LUTMASK = 16'he000;
    EFX_LUT4 LUT__659 (.I0(n269), .I1(\led_sig/counter [8]), .I2(\led_sig/counter [9]), 
            .I3(\led_sig/counter [10]), .O(\led_sig/n27 )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h8000 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(96)
    defparam LUT__659.LUTMASK = 16'h8000;
    EFX_LUT4 LUT__660 (.I0(n221[3]), .I1(n191[3]), .I2(button2_ps), .O(n346[3])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'hacac */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(69)
    defparam LUT__660.LUTMASK = 16'hacac;
    EFX_LUT4 LUT__661 (.I0(n221[4]), .I1(n191[4]), .I2(button2_ps), .O(n346[4])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'hacac */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(69)
    defparam LUT__661.LUTMASK = 16'hacac;
    EFX_LUT4 LUT__662 (.I0(n221[5]), .I1(n191[5]), .I2(button2_ps), .O(n346[5])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'hacac */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(69)
    defparam LUT__662.LUTMASK = 16'hacac;
    EFX_LUT4 LUT__663 (.I0(n221[6]), .I1(n191[6]), .I2(button2_ps), .O(n346[6])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'hacac */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(69)
    defparam LUT__663.LUTMASK = 16'hacac;
    EFX_LUT4 LUT__664 (.I0(n221[7]), .I1(n191[7]), .I2(button2_ps), .O(n346[7])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'hacac */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(69)
    defparam LUT__664.LUTMASK = 16'hacac;
    EFX_LUT4 LUT__665 (.I0(n221[8]), .I1(n191[8]), .I2(button2_ps), .O(n346[8])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'hacac */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(69)
    defparam LUT__665.LUTMASK = 16'hacac;
    EFX_LUT4 LUT__666 (.I0(debug_out[0]), .I1(button2_ps), .I2(debug_out[1]), 
            .O(n246_2[1])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h9696 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(69)
    defparam LUT__666.LUTMASK = 16'h9696;
    EFX_LUT4 LUT__667 (.I0(debug_out[0]), .I1(button2_ps), .I2(debug_out[2]), 
            .I3(debug_out[1]), .O(n246_3[2])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'hd2b4 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(69)
    defparam LUT__667.LUTMASK = 16'hd2b4;
    EFX_LUT4 LUT__668 (.I0(debug_out[0]), .I1(debug_out[1]), .I2(debug_out[2]), 
            .I3(button2_ps), .O(n270)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'hfe7f */ ;
    defparam LUT__668.LUTMASK = 16'hfe7f;
    EFX_LUT4 LUT__669 (.I0(n270), .I1(debug_out[3]), .O(n246_4[3])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h9999 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(69)
    defparam LUT__669.LUTMASK = 16'h9999;
    EFX_LUT4 LUT__672 (.I0(debug_out[1]), .O(led[2])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h5555, EFX_ATTRIBUTE_INSTANCE__IS_LUT_SOP_INF_INV=TRUE */ ;
    defparam LUT__672.LUTMASK = 16'h5555;
    EFX_LUT4 LUT__673 (.I0(debug_out[0]), .O(led[1])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h5555, EFX_ATTRIBUTE_INSTANCE__IS_LUT_SOP_INF_INV=TRUE */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(50)
    defparam LUT__673.LUTMASK = 16'h5555;
    EFX_GBUFCE CLKBUF__2 (.CE(1'b1), .I(\comms/gen_clk ), .O(\comms/gen_clk~O )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_GBUFCE, CE_POLARITY=1'b1 */ ;
    defparam CLKBUF__2.CE_POLARITY = 1'b1;
    EFX_GBUFCE CLKBUF__1 (.CE(1'b1), .I(clk_div[4]), .O(\clk_div[4]~O )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_GBUFCE, CE_POLARITY=1'b1 */ ;
    defparam CLKBUF__1.CE_POLARITY = 1'b1;
    EFX_GBUFCE CLKBUF__0 (.CE(1'b1), .I(CLK_50), .O(\CLK_50~O )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_GBUFCE, CE_POLARITY=1'b1 */ ;
    defparam CLKBUF__0.CE_POLARITY = 1'b1;
    EFX_ADD \AUX_ADD_CI__sub_27/add_2/i1  (.I0(1'b1), .I1(1'b1), .CI(1'b0), 
            .CO(n271)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // C:\Users\caleb\.efinity\project\test_project\top_level.sv(67)
    defparam \AUX_ADD_CI__sub_27/add_2/i1 .I0_POLARITY = 1'b1;
    defparam \AUX_ADD_CI__sub_27/add_2/i1 .I1_POLARITY = 1'b1;
    EFX_GBUFCE CLKBUF__4 (.CE(1'b1), .I(clk_div[8]), .O(\led_sig/div[8]~O )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_GBUFCE, CE_POLARITY=1'b1 */ ;
    defparam CLKBUF__4.CE_POLARITY = 1'b1;
    
endmodule

//
// Verific Verilog Description of module EFX_GBUFCE_67e4cd9e_0
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_67e4cd9e_0
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_FF_67e4cd9e_0
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_FF_67e4cd9e_1
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_FF_67e4cd9e_2
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_FF_67e4cd9e_3
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_ADD_67e4cd9e_0
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_67e4cd9e_1
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_67e4cd9e_2
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_67e4cd9e_3
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_67e4cd9e_4
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_67e4cd9e_5
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_67e4cd9e_6
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_67e4cd9e_7
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_67e4cd9e_8
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_67e4cd9e_9
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_67e4cd9e_10
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_67e4cd9e_11
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_67e4cd9e_12
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_67e4cd9e_13
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_67e4cd9e_14
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_67e4cd9e_15
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_67e4cd9e_16
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_67e4cd9e_17
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_67e4cd9e_18
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_67e4cd9e_19
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_67e4cd9e_20
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_67e4cd9e_21
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_67e4cd9e_22
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_67e4cd9e_23
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_67e4cd9e_24
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_67e4cd9e_25
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_67e4cd9e_26
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_67e4cd9e_27
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_67e4cd9e_28
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_67e4cd9e_29
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_67e4cd9e_30
// module not written out since it is a black box. 
//

