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


module stopwatch_main(
    input clk,
    input reset,
    input [9:0] sw,
    output [3:0] an,
    output [6:0] sseg
    );
    
wire slow_clock;
wire [6:0] in0, in1, in2, in3;
// wire 

clkdiv c1(.clk(clk), .reset(reset), .clk_out(slow_clock));
BCD_converter c2(.seg(in0));
BCD_converter c3(.seg(in1));
BCD_converter c4(.seg(in2));
BCD_converter c5(.seg(in3));
state_machine c6(
    .clk(slow_clk),
    .in0(in0),
    .in1(in1),
    .in2(in2),
    .in3(in3),
    .an(an),
    .sseg(sseg)
    );
    
    
    
    
    
    
    
    
    
    
    
    
endmodule
