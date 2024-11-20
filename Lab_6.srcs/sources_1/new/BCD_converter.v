`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Samarth Kabbur and Neev Mehra
// 
// Create Date: 10/07/2024 06:06:40 PM
// Design Name: 
// Module Name: display
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
module BCD_converter(
    input [3:0] sw,
    output [6:0] seg
    );
    
    wire w = sw[3];
    wire x = sw[2];
    wire y = sw[1];
    wire z = sw[0];
    
    // defining wires for "and" signals
    wire [16:0] ands;
    
    // defining wires for "not" signals
    wire w_not, x_not, y_not, z_not;
    
    not n0(w_not, w);
    not n1(x_not, x);
    not n2(y_not, y);
    not n3(z_not, z);
    
    // Instantiating gates as per the equations
    
        // seg0
    and g0(ands[0], w_not, x_not, y_not, z);
    and g1(ands[1], w_not, x, y_not, z_not);
    or h0(seg[0], ands[0], ands[1]);
    
    
        // seg1 
    and g2(ands[2], x, y_not, z);
    and g3(ands[3], x, y, z_not);
    or h1(seg[1], ands[2], ands[3]);
    
        // seg2
    and g4(seg[2], w_not, x_not, y, z_not);
    
        // seg3
    and g5(ands[5], x, y_not, z_not);
    and g6(ands[6], x_not, y_not, z);
    and g7(ands[7], w_not, x, y, z);
    or h2(seg[3], ands[5], ands[6], ands[7]);
    
        // seg4
    and g8(ands[8], x, y_not);
    or h3(seg[4], ands[8], z);
    
         // seg5
    and g12(ands[12], x_not, y);
    and g13(ands[13], w_not, x_not, z);
    or h4(seg[5], ands[12], ands[13]);
    
        // seg6
    and g15(ands[15], x, y, z);
    and g16(ands[16], w_not, x_not, y_not);
    or h5(seg[6], ands[15], ands[16]);
endmodule