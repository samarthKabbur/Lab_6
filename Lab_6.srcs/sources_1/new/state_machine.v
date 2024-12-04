`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2024 06:10:03 PM
// Design Name: 
// Module Name: state_machine
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module state_machine(
    input clk,
    input refresh,
    input reset,
    input start,
    input [9:0] switch,
    input [6:0] in0,
    input [6:0] in1,
    input [6:0] in2,
    input [6:0] in3,
    output reg [3:0] an,
    output reg [6:0] sseg,
    output reg [15:0] counter
    );
    
    reg [1:0] state;
    reg [1:0] next_state;
    wire [1:0] mode;
    wire [7:0] load_value;
    reg start_count = 0;
    reg [7:0] huge_load = 0;
    reg [2:0] button_debounce = 0;
    
    assign load_value = {
        switch[7], 
        switch[6],
        switch[5], 
        switch[4],
        switch[3], 
        switch[2],
        switch[1], 
        switch[0]
    };
    assign mode = {switch[9], switch[8]};
// keep in mind clk is being fed slow_clock, which updates each millisecond
    always @(posedge clk) begin
        if (reset) begin
            case (mode)
                2'b00: counter <= 0;
                2'b01: counter <= {huge_load, 8'b0};
                2'b10: counter <= 16'b1001100110011001;
                2'b11: counter <= {huge_load, 8'b10011001};
            endcase
            start_count <= 0;
        end
        else begin
            case (mode)
                2'b00: 
                    begin
                    if (start_count) counter[3:0] <= counter[3:0] + 1;
                    if (counter[3:0] == 4'b1010) begin counter[3:0] <= 4'b0000; counter[7:4] <= counter[7:4] + 1; end
                    if (counter[7:4] == 4'b1010) begin counter[7:4] <= 4'b0000; counter[11:8]<= counter[11:8] + 1; end
                    if (counter[11:8] == 4'b1010) begin counter[11:8] <= 4'b0000; counter[15:12]<= counter[15:12] + 1; end
                    if (counter[15:12] == 4'b1010) begin start_count <= 0; counter <= 16'b1001100110011001; end
                    end
                2'b01: 
                    begin
                    if (start_count) counter[3:0] <= counter[3:0] + 1;
                    if (counter[3:0] == 4'b1010) begin counter[3:0] <= 4'b0000; counter[7:4] <= counter[7:4] + 1; end
                    if (counter[7:4] == 4'b1010) begin counter[7:4] <= 4'b0000; counter[11:8]<= counter[11:8] + 1; end
                    if (counter[11:8] == 4'b1010) begin counter[11:8] <= 4'b0000; counter[15:12]<= counter[15:12] + 1; end
                    if (counter[15:12] == 4'b1010) begin start_count <= 0; counter <= 16'b1001100110011001; end
                    end
                2'b10: 
                    begin
                    if (start_count) counter[3:0] <= counter[3:0] - 1;
                    if (counter[3:0] == 4'b1111) begin counter[3:0] <= 4'b1001; counter[7:4] <= counter[7:4] - 1; end
                    if (counter[7:4] == 4'b1111) begin counter[7:4] <= 4'b1001; counter[11:8]<= counter[11:8] - 1; end
                    if (counter[11:8] == 4'b1111) begin counter[11:8] <= 4'b1001; counter[15:12]<= counter[15:12] - 1; end
                    if (counter == 4'b1111) begin start_count <= 0; counter <= 0; end
                    end
                2'b11: 
                    begin
                    if (start_count) counter[3:0] <= counter[3:0] - 1;
                    if (counter[3:0] == 4'b1111) begin counter[3:0] <= 4'b1001; counter[7:4] <= counter[7:4] - 1; end
                    if (counter[7:4] == 4'b1111) begin counter[7:4] <= 4'b1001; counter[11:8]<= counter[11:8] - 1; end
                    if (counter[11:8] == 4'b1111) begin counter[11:8] <= 4'b1001; counter[15:12]<= counter[15:12] - 1; end
                    if (counter == 4'b1111) begin start_count <= 0; counter <= 0; end
                    end
            endcase
            button_debounce <= {button_debounce[1:0], start};
            if (button_debounce == 3'b111) start_count <= !start_count;
            
        end   
    end 
    // turn on one anode at a time
    // with a 4ms refresh rate; 15hz, there will be slight flickering
    always @(posedge refresh) begin
        huge_load = load_value;
        if (huge_load[7:4] > 4'b1001) huge_load[7:4] <= 4'b1001;
        if (huge_load[3:0] > 4'b1001) huge_load[3:0] <= 4'b1001;
        state <= next_state;
    end
    
    always @(*) begin
        case (state)
            2'b00: an = 4'b1110;
            2'b01: an = 4'b1101;
            2'b10: an = 4'b1011;
            2'b11: an = 4'b0111;
        endcase     
    end
    
    always @(*) begin
        case (state)
            2'b00: sseg = in0;
            2'b01: sseg = in1;
            2'b10: sseg = in2;
            2'b11: sseg = in3;
        endcase
    end   
    
    always @(*) begin
        case (state)
            2'b00: next_state = 2'b01;
            2'b01: next_state = 2'b10;
            2'b10: next_state = 2'b11;
            2'b11: next_state = 2'b00;
        endcase
     end 
endmodule