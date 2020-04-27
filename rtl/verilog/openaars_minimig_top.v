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
    // Core board
    input          i_clk,        // Main clock from the oscillator 
    output         o_core_led,   // LED 
     
    // DDR3 Inouts
    inout [15:0]   ddr3_dq,
    inout [1:0]    ddr3_dqs_n,
    inout [1:0]    ddr3_dqs_p,
  
    // DDR3 Outputs
    output [13:0]  ddr3_addr,
    output [2:0]   ddr3_ba,
    output         ddr3_ras_n,
    output         ddr3_cas_n,
    output         ddr3_we_n,
    output         ddr3_reset_n,
    output [0:0]   ddr3_ck_p,
    output [0:0]   ddr3_ck_n,
    output [0:0]   ddr3_cke,
    
    output [1:0]   ddr3_dm,
    
    output [0:0]   ddr3_odt,
    
    output         tg_compare_error,
    output         init_calib_complete,
    
    // Open AARS pins
    output [7:0]   o_leds
    );
    
    // System wires
    wire           clk;
    //wire           clk200;
    wire           locked;
    
    // Core board LED
    reg             r_core_led = 1'b0;
    
    /*
     * DDR interface
     */
    reg   [27:0]    app_addr = 28'h0;
    reg   [2:0]     app_cmd = 3'h0;
    reg             app_en = 1'b0;
    reg   [127:0]   app_wdf_data = 128'h0;
    reg             app_wdf_end = 1'b0;
    reg             app_wdf_wren = 1'b0;
    wire  [127:0]   app_rd_data;
    wire            app_rd_data_end;
    wire            app_rd_data_valid;
    wire            app_rdy;
    wire            app_wdf_rdy;
    reg             app_sr_req = 1'b0;
    reg             app_ref_req = 1'b0;
    reg             app_zq_req = 1'b0;
    wire            app_sr_active;
    wire            app_ref_ack;
    wire            app_zq_ack;
    wire            ui_clk;
    wire            ui_clk_sync_rst;
    wire  [15:0]    app_wdf_mask = 16'h0000;
    
    /*
     * Open AARS wires
     */
    reg   [7:0]     r_leds = 8'h0;  
    
   // Clock IP
   clk_wiz_0 instance_name
   (
        // Clock out ports
        //.clk_out166(clk),      // output clk_out100
        .clk_out200(clk),   // output clk_out200
        // Status and control signals
        .locked(locked),       // output locked
        // Clock in ports
        .clk_in50(i_clk)       // input clk_in50
    );
    
    // Enable LED on the board as test
    always @(posedge clk) begin
        // Turn on LED
        r_core_led <= 1'b0;
        // Turn on all LEDS
        r_leds <= 8'h0;
    end
    
    // Instantiating the DDR3 controller
    mig_7series_1_1 u_mig_7series_1_1 (

    // Memory interface ports
    .ddr3_addr                      (ddr3_addr),  // output [13:0]		ddr3_addr
    .ddr3_ba                        (ddr3_ba),  // output [2:0]		ddr3_ba
    .ddr3_cas_n                     (ddr3_cas_n),  // output			ddr3_cas_n
    .ddr3_ck_n                      (ddr3_ck_n),  // output [0:0]		ddr3_ck_n
    .ddr3_ck_p                      (ddr3_ck_p),  // output [0:0]		ddr3_ck_p
    .ddr3_cke                       (ddr3_cke),  // output [0:0]		ddr3_cke
    .ddr3_ras_n                     (ddr3_ras_n),  // output			ddr3_ras_n
    .ddr3_reset_n                   (ddr3_reset_n),  // output			ddr3_reset_n
    .ddr3_we_n                      (ddr3_we_n),  // output			ddr3_we_n
    .ddr3_dq                        (ddr3_dq),  // inout [15:0]		ddr3_dq
    .ddr3_dqs_n                     (ddr3_dqs_n),  // inout [1:0]		ddr3_dqs_n
    .ddr3_dqs_p                     (ddr3_dqs_p),  // inout [1:0]		ddr3_dqs_p
    .init_calib_complete            (init_calib_complete),  // output			init_calib_complete
      
    .ddr3_dm                        (ddr3_dm),  // output [1:0]		ddr3_dm
    .ddr3_odt                       (ddr3_odt),  // output [0:0]		ddr3_odt
    // Application interface ports
    .app_addr                       (app_addr),  // input [27:0]		app_addr
    .app_cmd                        (app_cmd),  // input [2:0]		app_cmd
    .app_en                         (app_en),  // input				app_en
    .app_wdf_data                   (app_wdf_data),  // input [127:0]		app_wdf_data
    .app_wdf_end                    (app_wdf_end),  // input				app_wdf_end
    .app_wdf_wren                   (app_wdf_wren),  // input				app_wdf_wren
    .app_rd_data                    (app_rd_data),  // output [127:0]		app_rd_data
    .app_rd_data_end                (app_rd_data_end),  // output			app_rd_data_end
    .app_rd_data_valid              (app_rd_data_valid),  // output			app_rd_data_valid
    .app_rdy                        (app_rdy),  // output			app_rdy
    .app_wdf_rdy                    (app_wdf_rdy),  // output			app_wdf_rdy
    .app_sr_req                     (app_sr_req),  // input			app_sr_req
    .app_ref_req                    (app_ref_req),  // input			app_ref_req
    .app_zq_req                     (app_zq_req),  // input			app_zq_req
    .app_sr_active                  (app_sr_active),  // output			app_sr_active
    .app_ref_ack                    (app_ref_ack),  // output			app_ref_ack
    .app_zq_ack                     (app_zq_ack),  // output			app_zq_ack
    .ui_clk                         (ui_clk),  // output			ui_clk
    .ui_clk_sync_rst                (ui_clk_sync_rst),  // output			ui_clk_sync_rst
    .app_wdf_mask                   (app_wdf_mask),  // input [15:0]		app_wdf_mask
    // System Clock Ports
    .sys_clk_i                      (clk),
    .sys_rst                        (1'b0) // input sys_rst
    );
    
    /*
     * Assign registers to output
     */
    assign o_core_led = r_core_led;
    assign o_leds     = r_leds;
    
endmodule
