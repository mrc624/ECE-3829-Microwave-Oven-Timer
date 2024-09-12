`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2024 09:40:28 PM
// Design Name: 
// Module Name: Utility
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


module Debounce(
    input btn,
    input TEN_MHZ_CLK,
    output reg debounced
    );
    
    slow_mid_clk U0 (TEN_MHZ_CLK, clk);
    
    always @ (posedge clk) begin
        if (debounced != btn) begin
            debounced = btn;
        end
    end
    
endmodule

module slower_clk(
    input clk_in,
    output reg clk_out
    );

reg [27:0] period_count = 0;
always @ (posedge clk_in)
    if (period_count!= 100000000)
    begin
        period_count<= period_count + 1;
        clk_out <= 0; //clk_out gets 0.
    end
    else
    begin
        period_count <= 0;
        clk_out <= 1;
    end

endmodule

module slow_mid_clk(
    input clk_in,
    output reg clk_out
    );

reg [24:0] period_count = 0;
always @ (posedge clk_in)
    if (period_count!= 10000000)
    begin
        period_count<= period_count + 1;
        clk_out <= 0; //clk_out gets 0.
    end
    else
    begin
        period_count <= 0;
        clk_out <= 1;
    end

endmodule

module slow_clk(
    input clk_in,
    output reg clk_out
    );

reg [20:0] period_count = 0;
always @ (posedge clk_in)
    if (period_count!= 1000000)
    begin
        period_count<= period_count + 1;
        clk_out <= 0; //clk_out gets 0.
    end
    else
    begin
        period_count <= 0;
        clk_out <= 1;
    end

endmodule