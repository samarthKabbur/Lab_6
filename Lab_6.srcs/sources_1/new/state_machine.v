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
    input reset,
    input [9:0] switch,
    input [6:0] in0,
    input [6:0] in1,
    input [6:0] in2,
    input [6:0] in3,
    output reg [3:0] an,
    output reg [3:0] sseg,
    output reg [15:0] counter
    );
    
    reg [1:0] state;
    reg [1:0] next_state;
    wire [1:0] mode;
    wire [7:0] load_value;
    
    assign load_value = {
        switch[9], 
        switch[8],
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
    always @(posedge clk or posedge reset) begin
        case (mode)
            2'b00: 
            begin
                if (reset)
                    counter = 0;
                else
                    counter = counter + 1;
            end
            2'b01: 
            begin
                if (reset)
                    counter = load_value;
                else
                    counter = counter + 1;
            end
            2'b10: 
            begin
                if (reset)
                    counter = 14'b10011100001111;
                else
                    counter = counter - 1;
            end
            2'b11: 
            begin
                if (reset)
                    counter = load_value;
                else
                    counter = counter - 1;
            end
        endcase
    end
    
    // turn on one anode at a time
    // with a 4ms refresh rate; 15hz, there will be slight flickering
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
    
endmodule



