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
    output clk_out,
    output refresh

    );
    // Set a value so that the output is a 1ms clock, will calculate later lmao:)
    // divider is a local variable
    reg [25:0] divider;
    
    initial begin
    divider = 0;
    end
    assign refresh = divider[10];
    assign clk_out = divider[25];
    
    always @(posedge clk) begin
        if (reset)
            divider = 0;
        else
            divider = divider + 1;
        end
endmodule
