module spectro #(parameter NUM_BINS = 1280 // Max 1280 min 1
        )(
            input [9:0] spectroChannel0_DATA,
            input [9:0] spectroChannel1_DATA,
            input [9:0] spectroChannel2_DATA,
            input [9:0] spectroChannel3_DATA,
            output spectroChannel0_ENA,
            output spectroChannel1_ENA,
            output spectroChannel2_ENA,
            output spectroChannel3_ENA,
            output logic spectroChannel0_FIFO_RD,
            output logic spectroChannel1_FIFO_RD,
            output logic spectroChannel2_FIFO_RD,
            output logic spectroChannel3_FIFO_RD,
            input spectroChannel0_FIFO_EMPTY,
            input spectroChannel1_FIFO_EMPTY,
            input spectroChannel2_FIFO_EMPTY,
            input spectroChannel3_FIFO_EMPTY,
            input clk,
            output reg [19+BIN_WIDTH:0] pixelBins [NUM_BINS-1:0]
        );
    // localparam ; 
    
    localparam BIN_WIDTH = 1280/NUM_BINS;
    // reg [9:0] pixels [1279:0][1023:0];
    
    reg [4:0] pBuffs [3:0];
    reg [4:0] nBuffs [3:0];
    logic evenKernel [3:0] = '{default:0};
    logic [2:0] nBuffA=0, pBuffA=0;
    logic [$clog2(NUM_BINS)-1:0] x_addr [3:0] = '{default:0};
    logic [$clog2(NUM_BINS)-1:0] new_x_addr [3:0] = '{default:0};
    logic stage [3:0]='{default:0};
    logic dataValid [3:0];
    logic [$clog2(NUM_BINS)-1:0] binAddr [3:0];
    wire [9:0] fifoData [3:0];
    // logic [7:0] y_addr = 0, new_y_addr;
    assign binAddr[0] = (x_addr[0]+(evenKernel[0] ? 0+stage[0] : 7-stage[0]))/BIN_WIDTH;
    assign binAddr[1] = (x_addr[1]+(evenKernel[1] ? 2+stage[1] : 5-stage[1]))/BIN_WIDTH;
    assign binAddr[2] = (x_addr[2]+(evenKernel[2] ? 4+stage[2] : 3-stage[2]))/BIN_WIDTH;
    assign binAddr[3] = (x_addr[3]+(evenKernel[3] ? 6+stage[3] : 1-stage[3]))/BIN_WIDTH;
    logic firstRow=1'b1;
    always_ff @(posedge clk) begin
        for (int i=0; i<4; i++) begin
            if (dataValid[i]) begin
                pixelBins[binAddr[i]]<=pixelBins[binAddr[i]]+((firstRow&&(binAddr[i]%BIN_WIDTH==0)) ? fifoData[i] : 0);
                stage[i]<=~stage[i];
                if (stage[i]==1)begin
                    x_addr[i]<=new_x_addr[i];
                    evenKernel[i]<=~evenKernel[i];
                end
            end 
        end
        // if (dataValid[0]) begin
        //     pixelBins[binAddr[0]]<=pixelBins[binAddr[0]]+fifoData[0];
        //     x_addr[0]<=new_x_addr[0];
        //     stage[0]<=~stage[0];
        //     if (stage[0]==1)
        //         evenKernel[0]<=~evenKernel[0];
        // end
        // if (dataValid[1]) begin
        //     pixelBins[binAddr[1]]<=pixelBins[binAddr[1]]+fifoData[1];
        //     x_addr[1]<=new_x_addr[1];
        //     stage<=~stage;
        //     if (stage==1)
        //         evenKernel<=~evenKernel;
        // end
        // if (dataValid[2]) begin
        //     pixelBins[binAddr[2]]<=pixelBins[binAddr[2]]+fifoData[2];
        //     x_addr[2]<=new_x_addr[2];
        //     stage<=~stage;
        //     if (stage==1)
        //         evenKernel<=~evenKernel;
        // end
        // if (dataValid[3]) begin
        //     pixelBins[binAddr[3]]<=pixelBins[binAddr[3]]+fifoData[3];
        //     x_addr[3]<=new_x_addr[3];
        //     stage<=~stage;
        //     if (stage==1)
        //         evenKernel<=~evenKernel;
        // end
    end
    
    spectroFIFO ch0 (.fifoData(spectroChannel0_DATA), .FIFO_EMPTY(spectroChannel0_FIFO_EMPTY), .CLK(clk), .RST(1'b0), .FIFO_RD(spectroChannel0_FIFO_RD), .dataValid(dataValid[0]), .dataOut(fifoData[0]));
    spectroFIFO ch1 (.fifoData(spectroChannel1_DATA), .FIFO_EMPTY(spectroChannel1_FIFO_EMPTY), .CLK(clk), .RST(1'b0), .FIFO_RD(spectroChannel1_FIFO_RD), .dataValid(dataValid[1]), .dataOut(fifoData[1]));
    spectroFIFO ch2 (.fifoData(spectroChannel2_DATA), .FIFO_EMPTY(spectroChannel2_FIFO_EMPTY), .CLK(clk), .RST(1'b0), .FIFO_RD(spectroChannel2_FIFO_RD), .dataValid(dataValid[2]), .dataOut(fifoData[2]));
    spectroFIFO ch3 (.fifoData(spectroChannel3_DATA), .FIFO_EMPTY(spectroChannel3_FIFO_EMPTY), .CLK(clk), .RST(1'b0), .FIFO_RD(spectroChannel3_FIFO_RD), .dataValid(dataValid[3]), .dataOut(fifoData[3]));
    always_comb begin
        new_x_addr[0] = (x_addr[0]==1272) ? 0 : x_addr[0] + 8;
        new_x_addr[1] = (x_addr[1]==1272) ? 0 : x_addr[1] + 8;
        new_x_addr[2] = (x_addr[2]==1272) ? 0 : x_addr[2] + 8;
        new_x_addr[3] = (x_addr[3]==1272) ? 0 : x_addr[3] + 8;
        // new_y_addr = (new_x_addr==0) ? y_addr+1 : 0;
    end
    
    
endmodule // spectro
