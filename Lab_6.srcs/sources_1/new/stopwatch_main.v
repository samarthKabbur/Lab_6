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
    input [9:0] switch,
    output [3:0] an,
    output [6:0] sseg
    );
    
wire slow_clock;
wire [6:0] in0, in1, in2, in3;
wire [3:0] time0, time1, time2, time3;
// wire 

clkdiv c1(.clk(clk), .reset(reset), .clk_out(slow_clock));
BCD_converter c2(.seg(in0), .sw(time0));
BCD_converter c3(.seg(in1), .sw(time1));
BCD_converter c4(.seg(in2), .sw(time2));
BCD_converter c5(.seg(in3), .sw(time3));
state_machine c6(
    .clk(slow_clock),
    .in0(in0),
    .in1(in1),
    .in2(in2),
    .in3(in3),
    .switch(switch),
    .an(an),
    .sseg(sseg),
    .counter({time3, time2, time1, time0})
    
    );
    
    
    
    
    
    
    
    
    
    
    
    
endmodule
