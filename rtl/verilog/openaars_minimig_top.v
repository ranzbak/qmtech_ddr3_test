`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2020 11:06:00 PM
// Design Name: 
// Module Name: openaars_minimig_top
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


module openaars_minimig_top(
    // Core board pins
    input i_clk,
    output reg o_core_led
    
    );
    
    // System wires
    wire clk;
    wire locked;
    
   // Clock IP
   clk_wiz_0 instance_name
   (
        // Clock out ports
        .clk_out100(clk),      // output clk_out100
        // Status and control signals
        .locked(locked),       // output locked
        // Clock in ports
        .clk_in50(i_clk)       // input clk_in50
    );
    
    // Enable LED on the board as test
    always @(posedge clk) begin
        // Turn on LED
        o_core_led <= 1'b0;
    end
    
endmodule
