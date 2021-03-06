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

`define ALI_DEBUG

module openaars_minimig_top(
    // Core board
    input          i_clk,        // Main clock from the oscillator 
    input          i_rst_n,
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
    
    output         init_calib_complete,
    
    // Open AARS pins
    output [7:0]   o_leds
    );
    
    // System wires
    wire           clk;
    wire           ui_clk;
    wire           clk_28;
    wire           clk_28_90;
    wire           clk_7;
    //wire           clk200;
    wire           locked;
    
    //// Core board LED ////
    reg             r_core_led = 1'b0;
    
    //// Open AARS wires ////
    reg   [7:0]     r_leds = 8'b1;  
    
    //// Wrapper interface ////
    reg     [31:0]  r_Addr;   // Address bus (Upper part not used)
    reg             r_CS;     // Chip select 
    reg             r_L;      // Low byte [0:7]
    reg             r_U;      // High byte [8:15] 
    reg             r_WE;     // Write enable
    reg     [15:0]  r_WR;     // Data to write 16-bit
    wire    [15:0]  w_RD;     // Data to read 16-bit
    wire    [47:0]  w_RD48;   // Data to read additional 48-bit
    wire            w_ready;  // Transaction ready

    // Pattern generator
    reg             r_flip_pat = 1'b0; // Flip the pattern
    
    // Clock IP
    clk_wiz_0 instance_name
    (
        // Clock out ports
        .clk_out200(clk),   // output clk_out200
        .clk_out28(), // output clk_out28
        // Status and control signals
        .locked(locked),       // output locked
        // Clock in ports
        .clk_in50(i_clk)
    );

    
    // Enable LED on the board as test
    always @(posedge ui_clk) begin
        // Turn on LED
        r_core_led <= 1'b1;
    end

    // Devide ui_clk by 7 to get +-28.54 MHz clock
    // wire w_clk_28_;
    BUFR #(
        .BUFR_DIVIDE("7")
    ) ui_clk_inst (
        .O(clk_28),
        .CE(1'b1),
        .CLR(1'b0),
        .I(ui_clk)
    );

    // BUFMR BUFMR_inst (
    //     .O(clk_28),
    //     .I(w_clk_28_)
    // );
    
    // SDRAM wrapper
    sdram_ddr_wrapper my_sdram (
        .clk(clk),
        .clk_rtl(clk_28),
        .i_rst(~locked),
        .o_ui_clk(ui_clk),
        
        //// SRAM like interface ////
        // cpu (Fast memory)
        .wrap_Addr(r_Addr),     // Address bus (Upper part not used)
        .wrap_CS(r_CS),         // Chip select 
        .wrap_L(r_L),           // Low byte [0:7]
        .wrap_U(r_U),           // High byte [8:15] 
        .wrap_WE(r_WE),         // Write enable
        .wrap_WR(r_WR),         // Data to write
        .wrap_RD(w_RD),         // Data to read
        .wrap_RD48(w_RD48),     // Data to read 48-bits extra
        .wrap_big_r(r_flip_pat),      // When asserted, read 64-bit instead of 16
        .wrap_ready(w_ready),   // Transaction ready

        
        //// SDRAM DDR3 ////
        
        // DDR3 Inouts
        .ddr3_dq(ddr3_dq),        
        .ddr3_dqs_n(ddr3_dqs_n),
        .ddr3_dqs_p(ddr3_dqs_p),
      
        // DDR3 Outputs
        .ddr3_addr(ddr3_addr),
        .ddr3_ba(ddr3_ba),
        .ddr3_ras_n(ddr3_ras_n),
        .ddr3_cas_n(ddr3_cas_n),
        .ddr3_we_n(ddr3_we_n),
        .ddr3_reset_n(ddr3_reset_n),
        .ddr3_ck_p(ddr3_ck_p),
        .ddr3_ck_n(ddr3_ck_n),
        .ddr3_cke(ddr3_cke),
        
        .ddr3_dm(ddr3_dm),
        
        .ddr3_odt(ddr3_odt),
        
        .init_calib_complete(init_calib_complete)
    );

    //// Test machine ////
    
    // Test machine states
    localparam STATE_IDLE       = 0;
    localparam STATE_WRITE      = 1;
    localparam STATE_WRITE_DONE = 2;
    localparam STATE_READ       = 3;
    localparam STATE_READ_DONE  = 4;


    // Test machine
    reg [4:0] test_state = STATE_IDLE;
    reg [28:0] r_cur_addr = 29'b0;
    reg [15:0] v_pattern;

    //always @(posedge ui_clk) begin
    always @(posedge clk_28) begin
        case (test_state)
            STATE_IDLE: begin
                if (w_ready == 1'b1) begin
                    test_state <= STATE_WRITE;
                end
            end
            STATE_WRITE: begin
                r_CS <= 1'b1;
                r_WR <= (r_flip_pat == 1'b0 ? r_cur_addr[15:0] : ~r_cur_addr[15:0]);
                r_Addr <= {3'b000, r_cur_addr};
                r_WE <= 1'b1;
                r_L <= 1'b1;
                r_U <= 1'b1;
                if (w_ready == 1'b0) begin
                    test_state <= STATE_WRITE_DONE;
                end
            end
            STATE_WRITE_DONE: begin
                // Deassert signals
                if(w_ready == 1'b0) begin
                    r_CS <= 1'b0;
                    r_WR <= 16'h0;
                    r_Addr <= 32'b0;
                    r_L <= 1'b0;
                    r_U <= 1'b0;
                    r_WE <= 1'b0;
                end

                // When writing is done, proceed to the next stage
                if (w_ready == 1'b1) begin
                    test_state <= STATE_READ;
                end
            end
            STATE_READ: begin
                r_CS <= 1'b1;
                r_Addr <= {3'b000, r_cur_addr};
                r_WE <= 1'b0;
                r_L <= 1'b1;
                r_U <= 1'b1;
                
                if (w_ready == 1'b0) begin
                    test_state <= STATE_READ_DONE;
                end
            end
            STATE_READ_DONE: begin
                // Deassert signals
                if (w_ready == 1'b0) begin
                    r_CS <= 1'b0;
                    r_Addr <= 32'b0;
                    r_L <= 1'b0;
                    r_U <= 1'b0;
                end

                // When the data is ready to be read
                // Compare it to the data put in
                if (w_ready == 1'b1 ) begin
                    r_leds[0] <= 1'b1;
                    r_leds[1] <= 1'b1;

                    v_pattern = (r_flip_pat == 1'b0 ? r_cur_addr[15:0] : ~r_cur_addr[15:0]);
                    if (v_pattern == w_RD) begin
                        r_leds[0] <= 1'b0;
                    end else begin
                        r_leds[1] <= 1'b0;
                    end
                    
                    if (r_cur_addr < 29'hfffffff) begin
                        r_cur_addr <= r_cur_addr + 1;
                    end else begin
                        r_cur_addr <= r_cur_addr - 29'hfffffff;
                        r_flip_pat <= ~r_flip_pat;
                    end

                    test_state <= STATE_WRITE;
                end
            end
        endcase
    end

`ifdef ALI_DEBUG
    /*
     * ILA debug core
     */
    ila_0 your_instance_name (
        .clk(ui_clk), // input wire clk

        .probe0(r_cur_addr),                              // input wire [31:0] probe0
        .probe1(r_CS),                                    // input wire [0:0]  probe1
        .probe2(r_L),                                     // input wire [0:0]  probe2
        .probe3(r_U),                                     // input wire [0:0]  probe3
        .probe4(r_WR),                                    // input wire [15:0] probe4
        .probe5(my_sdram.my_sdram_ctrl.r_WE),             // input wire        probe5
        .probe6({w_RD, w_RD48}),                          // input wire [63:0] probe6
        .probe7(test_state),                              // input wire [5:0]  probe7
        .probe8(my_sdram.my_sdram_ctrl.cache_state),      // input with [5:0]  probe8
        .probe9(v_pattern),                               // input wire        probe9
        // .probe10(my_sdram.my_sdram_ctrl.v_byte_found[0]), // input wire        probe10
        .probe10(clk_28),                                 // input wire        probe10
        .probe11(w_ready),                                // input wire        probe11
        .probe12(o_leds[1]),                              // input wire        probe12
        .probe13(r_Addr),                                 // input wire [31:0] probe13
        .probe14(my_sdram.my_sdram_ctrl.cache_e_data[0]), // input wire [127:0]  probe14
        .probe15(my_sdram.my_sdram_ctrl.cache_e_data[1]), // input wire [127:0]  probe15
        .probe16(my_sdram.my_sdram_ctrl.cache_e_data[2]), // input wire [127:0]  probe16
        .probe17(my_sdram.my_sdram_ctrl.cache_e_data[3])  // input wire [127:0]  probe17
    );
`endif
    
    
    /*
     * Assign registers to output
     */
    assign o_core_led = r_core_led;
    assign o_leds     = r_leds;
    
endmodule
