module spectro (
                input channel0,
                input channel1,
                input channel2, 
                input channel3,
                input lvdsClk,
                input intTrig,
                input clk
);
    localparam NUM_BINS = 1280; // Max 1280 min 1

    // reg [9:0] pixels [1279:0][1023:0];
    reg [9:0] bins [NUM_BINS-1:0];
    reg [4:0] pBuffs [3:0];
    reg [4:0] nBuffs [3:0];
    logic evenKernel = 0;
    logic [2:0] nBuffA=0, pBuffA=0;
    logic [10:0] x_addr = 0, new_x_addr;
    logic stage=0;
    logic [7:0] y_addr = 0, new_x_addr;
    posedge_trigger end_int (.in(intTrig), .out(int_end))
    logic [1:0] load_en;
    always_comb begin
        new_x_addr = (x_addr==1279) ? 0 : x_addr+1;
        new_y_addr = (new_x_addr==0) ? y_addr+1 : 0;
    end
    always_ff @(posedge lvdsClk) begin
        pBuffs[0][pBuffA]<=channel0;
        pBuffs[1][pBuffA]<=channel1;
        pBuffs[2][pBuffA]<=channel2;
        pBuffs[3][pBuffA]<=channel3;
        pBuffA<=(pBuffA!=4) ? (pBuffA+1) : 0;
    end
    always_ff @(negedge lvdsClk) begin
        nBuffs[0][nBuffA]<=channel0;
        nBuffs[1][nBuffA]<=channel1;
        nBuffs[2][nBuffA]<=channel2;
        nBuffs[3][nBuffA]<=channel3;
        if (load_en==2'b10) begin
            pixels[x_addr+(evenKernel ? 0+stage : 7-stage)][y_addr]<={{pBuffs[0][0]},{nBuffs[0][0]},
                                    {pBuffs[0][1]},{nBuffs[0][1]},
                                    {pBuffs[0][2]},{nBuffs[0][2]},
                                    {pBuffs[0][3]},{nBuffs[0][3]},
                                    {pBuffs[0][4]},{nBuffs[0][4]}};
            pixels[x_addr+(evenKernel ? 2+stage : 5-stage)][y_addr]<={{pBuffs[1][0]},{nBuffs[1][0]},
                                    {pBuffs[1][1]},{nBuffs[1][1]},
                                    {pBuffs[1][2]},{nBuffs[1][2]},
                                    {pBuffs[1][3]},{nBuffs[1][3]},
                                    {pBuffs[1][4]},{nBuffs[1][4]}};
        end
        if (load_en==2'b01) begin
            pixels[x_addr+(evenKernel ? 4+stage : 7-stage)][y_addr]<={
                                        {pBuffs[0][0]},{nBuffs[0][0]},
                                        {pBuffs[0][1]},{nBuffs[0][1]},
                                        {pBuffs[0][2]},{nBuffs[0][2]},
                                        {pBuffs[0][3]},{nBuffs[0][3]},
                                        {pBuffs[0][4]},{nBuffs[0][4]}
                                        };
            pixels[x_addr+(evenKernel ? 6+stage : 5-stage)][y_addr]<={
                                        {pBuffs[1][0]},{nBuffs[1][0]},
                                        {pBuffs[1][1]},{nBuffs[1][1]},
                                        {pBuffs[1][2]},{nBuffs[1][2]},
                                        {pBuffs[1][3]},{nBuffs[1][3]},
                                        {pBuffs[1][4]},{nBuffs[1][4]}
                                        };
            stage<=~stage;
        end
        nBuffA<=(nBuffA+1);
        load_en<=load_en>>1;
        if (nBuffA==4) begin
            nBuffA<=0;
            load_en<=2'b10;
        end
    end
    
endmodule
