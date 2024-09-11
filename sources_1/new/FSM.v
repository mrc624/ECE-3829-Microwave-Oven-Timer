`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2024 03:11:45 PM
// Design Name: 
// Module Name: FSM
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


module FSM(
    input clk,
    input BTNR,
    input BTNL,
    output [1:0] LED,
    output [6:0] seg_out,
    output [3:0] an_out
    );
    
    parameter EMPTY = 5'b10001;
    
    assign LED[0] = BTNR;
    assign LED[1] = BTNL;
    
    
endmodule
