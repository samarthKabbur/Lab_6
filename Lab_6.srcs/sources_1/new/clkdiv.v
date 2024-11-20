`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2024 05:41:11 PM
// Design Name: 
// Module Name: stopwatch_main
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


module clkdiv(
    input clk,
    input reset,
    output clk_out

    );
    // Set a value so that the output is a 1ms clock
    // Counter is a local variable
    reg [10:0] counter;
    
    initial begin
    counter = 0;
    end
    
    always @(posedge clk) begin
        if (reset)
            counter = 0;
        else
            counter = counter + 1;
        end
endmodule