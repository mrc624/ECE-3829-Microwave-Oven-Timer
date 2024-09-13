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
    input [7:0] sw,
    output reg flash_led,
    output [6:0] seg_out,
    output [3:0] an_out
    );
    
    parameter EMPTY = 5'b10001;
    parameter EMPTY_DISPLAY = 8'b0000_0000;
    
    //time variables 
    reg [7:0] set_time;
    reg [7:0] curr_time;
   
    //states
    reg [4:0] state;
    parameter SET_TIME = 1'b0;
    parameter LOADED_TIME = 1'b1;
    parameter COUNTING = 2'b10;
    parameter PAUSE = 2'b11;
   
    
    //handling the states and switching between them
    always @ (posedge (btnr | BTNL | count_done) ) begin
        if (BTNL) begin
            state <= SET_TIME;
        end else begin
            case (state)
                SET_TIME: state <= LOADED_TIME;
                LOADED_TIME: state <= COUNTING;
                COUNTING: begin
                    if (count_done) begin
                        state <= LOADED_TIME;
                    end else begin
                        state <= PAUSE;
                    end
                end
                PAUSE: state <= COUNTING;
            endcase
        end
    end
    
    //handling what happens between each state
    reg [7:0] disp = EMPTY_DISPLAY;
    reg count;
    reg load_time;
    reg count_done;
    reg [10:0] flash_count;
    always @ (posedge slow_clk) begin
        case (state)
            SET_TIME: begin
                set_time <= sw;
                load_time <= 0;
                count <= 0;
                count_done <= 0;
                disp <= EMPTY_DISPLAY;
            end
            LOADED_TIME: begin
                load_time <= 1;
                count <= 0;
                count_done <= 0;
                disp <= set_time;
                flash_count <= 0;
            end
            COUNTING: begin
                disp <= curr_time;
                load_time <= 0;
                if (curr_time == 0) begin
                    flash_count <= flash_count + 1;
                    if (flash_count < 500) begin
                       if (flash_count % 10 == 0) begin
                            flash_led <= 1;
                       end else begin
                            flash_led <= 0;
                       end 
                    end else begin
                        count_done <= 1;
                        flash_led <= 0;
                    end
                    count <= 0;
                end else begin
                    count <= 1;
                    count_done <= 0;
                end
            end
            PAUSE: begin
                count <= 0;
                load_time <= 0;
            end
        endcase
    end
    
    //handling the counting
    always @ (posedge slower_clk) begin
        if (count) begin
            curr_time <= curr_time - 1;
        end else if (load_time) begin
            curr_time <= set_time;
        end
    end
    
    //modules and reguired wires
    wire slow_clk;
    slow_clk U0 (clk, slow_clk);
    wire btnr;
    Debounce U1 (BTNR, clk, btnr);
    wire slower_clk;
    slower_clk U2 (clk, slower_clk);
    Display_8Bit U3 (disp, clk, seg_out, an_out);
    
endmodule
