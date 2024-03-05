//_\TLV_version 1d: tl-x.org, generated by SandPiper(TM) 1.14-2022/10/10-beta-Pro
//_\source top.tlv 41

//_\SV
   // Include Tiny Tapeout Lab.
   // Included URL: "https://raw.githubusercontent.com/os-fpga/Virtual-FPGA-Lab/35e36bd144fddd75495d4cbc01c4fc50ac5bde6f/tlv_lib/tiny_tapeout_lib.tlv"// Included URL: "https://raw.githubusercontent.com/os-fpga/Virtual-FPGA-Lab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlv_lib/fpga_includes.tlv"
//_\source top.tlv 93

//_\SV

// ================================================
// A simple Makerchip Verilog test bench driving random stimulus.
// Modify the module contents to your needs.
// ================================================

module top(input logic clk, input logic reset, input logic [31:0] cyc_cnt, output logic passed, output logic failed);
   // Tiny tapeout I/O signals.
   logic [7:0] ui_in, uo_out;
   
   logic [31:0] r;  // a random value
   always @(posedge clk) r <= 0;
   assign ui_in = r[7:0];
   
   logic ena = 1'b0;
   logic rst_n = ! reset;

   /*
   // Or, to provide specific inputs at specific times (as for lab C-TB) ...
   // BE SURE TO COMMENT THE ASSIGNMENT OF INPUTS ABOVE.
   // BE SURE TO DRIVE THESE ON THE B-PHASE OF THE CLOCK (ODD STEPS).
   // Driving on the rising clock edge creates a race with the clock that has unpredictable simulation behavior.
   initial begin
      #1  // Drive inputs on the B-phase.
         ui_in = 8'h0;
      #10 // Step 5 cycles, past reset.
         ui_in = 8'hFF;
      // ...etc.
   end
   */

   // Instantiate the Tiny Tapeout module.
   my_design tt(.*);

   assign passed = top.cyc_cnt > 60;
   assign failed = 1'b0;
endmodule


// Provide a wrapper module to debounce input signals if requested.
// The Tiny Tapeout top-level module.
// This simply debounces and synchronizes inputs.
// Debouncing is based on a counter. A change to any input will only be recognized once ALL inputs
// are stable for a certain duration. This approach uses a single counter vs. a counter for each
// bit.
module tt_um_template (
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    /*   // The FPGA is based on TinyTapeout 3 which has no bidirectional I/Os (vs. TT6 for the ASIC).
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    */
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
    
    // Synchronize.
    logic [9:0] inputs_ff, inputs_sync;
    always @(posedge clk) begin
        inputs_ff <= {ui_in, ena, rst_n};
        inputs_sync <= inputs_ff;
    end

    // Debounce.
    `define DEBOUNCE_MAX_CNT 14'h3fff
    logic [9:0] inputs_candidate, inputs_captured;
    logic sync_rst_n = inputs_sync[0];
    logic [13:0] cnt;
    always @(posedge clk) begin
        if (!sync_rst_n)
           cnt <= `DEBOUNCE_MAX_CNT;
        else if (inputs_sync != inputs_candidate) begin
           // Inputs changed before stablizing.
           cnt <= `DEBOUNCE_MAX_CNT;
           inputs_candidate <= inputs_sync;
        end
        else if (cnt > 0)
           cnt <= cnt - 14'b1;
        else begin
           // Cnt == 0. Capture candidate inputs.
           inputs_captured <= inputs_candidate;
        end
    end
    logic [7:0] clean_ui_in;
    logic clean_ena, clean_rst_n;
    assign {clean_ui_in, clean_ena, clean_rst_n} = inputs_captured;

    my_design my_design (
        .ui_in(clean_ui_in),
        
        .ena(clean_ena),
        .rst_n(clean_rst_n),
        .*);
endmodule
//_\SV



// =======================
// The Tiny Tapeout module
// =======================

module my_design (
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    /*   // The FPGA is based on TinyTapeout 3 which has no bidirectional I/Os (vs. TT6 for the ASIC).
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    */
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
   wire reset = ! rst_n;

// ---------- Generated Code Inlined Here (before 1st \TLV) ----------
// Generated by SandPiper(TM) 1.14-2022/10/10-beta-Pro from Redwood EDA, LLC.
// (Installed here: /usr/local/mono/sandpiper/distro.)
// Redwood EDA, LLC does not claim intellectual property rights to this file and provides no warranty regarding its correctness or quality.


// For silencing unused signal messages.
`define BOGUS_USE(ignore)


genvar digit, input_label, leds, switch;


//
// Signals declared top-level.
//

// For $slideswitch.
logic [7:0] L0_slideswitch_a0;

// For $sseg_decimal_point_n.
logic L0_sseg_decimal_point_n_a0;

// For $sseg_digit_n.
logic [7:0] L0_sseg_digit_n_a0;

// For $sseg_segment_n.
logic [6:0] L0_sseg_segment_n_a0;

// For /fpga_pins/fpga|my_design$cnt.
logic FpgaPins_Fpga_MY_DESIGN_cnt_a1,
      FpgaPins_Fpga_MY_DESIGN_cnt_a2;

// For /fpga_pins/fpga|my_design$dice_digit.
logic [3:0] FpgaPins_Fpga_MY_DESIGN_dice_digit_a2;

// For /fpga_pins/fpga|my_design$out.
logic [7:0] FpgaPins_Fpga_MY_DESIGN_out_a1,
            FpgaPins_Fpga_MY_DESIGN_out_a2;

// For /fpga_pins/fpga|my_design$reset.
logic FpgaPins_Fpga_MY_DESIGN_reset_a0,
      FpgaPins_Fpga_MY_DESIGN_reset_a1;




   //
   // Scope: /fpga_pins
   //


      //
      // Scope: /fpga
      //


         //
         // Scope: |my_design
         //

            // Staging of $cnt.
            always_ff @(posedge clk) FpgaPins_Fpga_MY_DESIGN_cnt_a2 <= FpgaPins_Fpga_MY_DESIGN_cnt_a1;

            // Staging of $out.
            always_ff @(posedge clk) FpgaPins_Fpga_MY_DESIGN_out_a2[7:0] <= FpgaPins_Fpga_MY_DESIGN_out_a1[7:0];

            // Staging of $reset.
            always_ff @(posedge clk) FpgaPins_Fpga_MY_DESIGN_reset_a1 <= FpgaPins_Fpga_MY_DESIGN_reset_a0;








//
// Debug Signals
//

   if (1) begin : DEBUG_SIGS_GTKWAVE

      (* keep *) logic [7:0] \@0$slideswitch ;
      assign \@0$slideswitch = L0_slideswitch_a0;
      (* keep *) logic  \@0$sseg_decimal_point_n ;
      assign \@0$sseg_decimal_point_n = L0_sseg_decimal_point_n_a0;
      (* keep *) logic [7:0] \@0$sseg_digit_n ;
      assign \@0$sseg_digit_n = L0_sseg_digit_n_a0;
      (* keep *) logic [6:0] \@0$sseg_segment_n ;
      assign \@0$sseg_segment_n = L0_sseg_segment_n_a0;

      //
      // Scope: /digit[0:0]
      //
      for (digit = 0; digit <= 0; digit++) begin : \/digit 

         //
         // Scope: /leds[7:0]
         //
         for (leds = 0; leds <= 7; leds++) begin : \/leds 
            (* keep *) logic  \//@0$viz_lit ;
            assign \//@0$viz_lit = L1_Digit[digit].L2_Leds[leds].L2_viz_lit_a0;
         end
      end

      //
      // Scope: /fpga_pins
      //
      if (1) begin : \/fpga_pins 

         //
         // Scope: /fpga
         //
         if (1) begin : \/fpga 

            //
            // Scope: |my_design
            //
            if (1) begin : P_my_design
               (* keep *) logic  \///@1$cnt ;
               assign \///@1$cnt = FpgaPins_Fpga_MY_DESIGN_cnt_a1;
               (* keep *) logic [3:0] \///@2$dice_digit ;
               assign \///@2$dice_digit = FpgaPins_Fpga_MY_DESIGN_dice_digit_a2;
               (* keep *) logic [7:0] \///@1$out ;
               assign \///@1$out = FpgaPins_Fpga_MY_DESIGN_out_a1;
               (* keep *) logic  \///@0$reset ;
               assign \///@0$reset = FpgaPins_Fpga_MY_DESIGN_reset_a0;
            end
         end
      end

      //
      // Scope: /switch[7:0]
      //
      for (switch = 0; switch <= 7; switch++) begin : \/switch 
         (* keep *) logic  \/@0$viz_switch ;
         assign \/@0$viz_switch = L1_Switch[switch].L1_viz_switch_a0;
      end


   end

// ---------- Generated Code Ends ----------
//_\TLV
   /* verilator lint_off UNOPTFLAT */
   // Connect Tiny Tapeout I/Os to Virtual FPGA Lab.
   //_\source /raw.githubusercontent.com/osfpga/VirtualFPGALab/35e36bd144fddd75495d4cbc01c4fc50ac5bde6f/tlvlib/tinytapeoutlib.tlv 76   // Instantiated from top.tlv, 162 as: m5+tt_connections()
      assign L0_slideswitch_a0[7:0] = ui_in;
      assign L0_sseg_segment_n_a0[6:0] = ~ uo_out[6:0];
      assign L0_sseg_decimal_point_n_a0 = ~ uo_out[7];
      assign L0_sseg_digit_n_a0[7:0] = 8'b11111110;
   //_\end_source

   // Instantiate the Virtual FPGA Lab.
   //_\source /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv 307   // Instantiated from top.tlv, 165 as: m5+board(/top, /fpga, 7, $, , my_design)
      
      //_\source /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv 355   // Instantiated from /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv, 309 as: m4+thanks(m5__l(309)m5_eval(m5_get(BOARD_THANKS_ARGS)))
         //_/thanks
            
      //_\end_source
      
   
      // Board VIZ.
   
      // Board Image.
      
      //_/fpga_pins
         
         //_/fpga
            //_\source top.tlv 48   // Instantiated from /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv, 340 as: m4+my_design.
               //_|my_design
                  //_@0
                     assign FpgaPins_Fpga_MY_DESIGN_reset_a0 = reset && ui_in[7];
                     //$random_in = *ui_in[7];
                  //_@1
                     assign FpgaPins_Fpga_MY_DESIGN_cnt_a1 = FpgaPins_Fpga_MY_DESIGN_reset_a1 ? 1'b0 : (FpgaPins_Fpga_MY_DESIGN_cnt_a2);
                     assign FpgaPins_Fpga_MY_DESIGN_out_a1[7:0] = FpgaPins_Fpga_MY_DESIGN_reset_a1 == 1'b1 ? 8'b0:
                                            FpgaPins_Fpga_MY_DESIGN_out_a2[7:0];
            
            
                  //_@2
                     assign FpgaPins_Fpga_MY_DESIGN_dice_digit_a2[3:0] = FpgaPins_Fpga_MY_DESIGN_out_a2[3:0];
                     assign uo_out =
                         FpgaPins_Fpga_MY_DESIGN_dice_digit_a2 == 4'h0 ? 8'b00111111: // 0 =10
                         FpgaPins_Fpga_MY_DESIGN_dice_digit_a2 == 4'h1 ? 8'b00000110:
                         FpgaPins_Fpga_MY_DESIGN_dice_digit_a2 == 4'h2 ? 8'b01011011:
                         FpgaPins_Fpga_MY_DESIGN_dice_digit_a2 == 4'h3 ? 8'b01001111:
                         FpgaPins_Fpga_MY_DESIGN_dice_digit_a2 == 4'h4 ? 8'b01100110:
                         FpgaPins_Fpga_MY_DESIGN_dice_digit_a2 == 4'h5 ? 8'b01101101:
                         FpgaPins_Fpga_MY_DESIGN_dice_digit_a2 == 4'h6 ? 8'b01111101:
                         FpgaPins_Fpga_MY_DESIGN_dice_digit_a2 == 4'h7 ? 8'b00000111:
                         FpgaPins_Fpga_MY_DESIGN_dice_digit_a2 == 4'h8 ? 8'b01111111:
                         FpgaPins_Fpga_MY_DESIGN_dice_digit_a2 == 4'h9 ? 8'b01101111:
                         FpgaPins_Fpga_MY_DESIGN_dice_digit_a2 == 4'h0 ? 8'b10111111: // 0. = 20
                         FpgaPins_Fpga_MY_DESIGN_dice_digit_a2 == 4'h1 ? 8'b10000110: // 1. = 11
                         FpgaPins_Fpga_MY_DESIGN_dice_digit_a2 == 4'h2 ? 8'b11011011: // 2. = 12
                         FpgaPins_Fpga_MY_DESIGN_dice_digit_a2 == 4'h3 ? 8'b11001111: // 3. = 13
                         FpgaPins_Fpga_MY_DESIGN_dice_digit_a2 == 4'h4 ? 8'b11100110: // 4. = 14
                         FpgaPins_Fpga_MY_DESIGN_dice_digit_a2 == 4'h5 ? 8'b11101101: // 5. = 15
                         FpgaPins_Fpga_MY_DESIGN_dice_digit_a2 == 4'h6 ? 8'b11111101: // 6. = 16
                         FpgaPins_Fpga_MY_DESIGN_dice_digit_a2 == 4'h7 ? 8'b10000111: // 7. = 17
                         FpgaPins_Fpga_MY_DESIGN_dice_digit_a2 == 4'h8 ? 8'b11111111: // 8. = 18
                         FpgaPins_Fpga_MY_DESIGN_dice_digit_a2 == 4'h9 ? 8'b11101111: // 9. = 19
                                        8'b0;
            
            
            
               // Note that pipesignals assigned here can be found under /fpga_pins/fpga.
               // ERROR: No macro cal_viz defined.   // Instantiated from top.tlv, 87 as: m5+cal_viz(@2, /fpga)
            
            
               // Connect Tiny Tapeout outputs. Note that uio_ outputs are not available in the Tiny-Tapeout-3-based FPGA boards.
               assign uo_out = 8'b0;
               
               
            //_\end_source
   
      // LEDs.
      
   
      // 7-Segment
      //_\source /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv 395   // Instantiated from /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv, 346 as: m4+fpga_sseg.
         for (digit = 0; digit <= 0; digit++) begin : L1_Digit //_/digit
            
            for (leds = 0; leds <= 7; leds++) begin : L2_Leds //_/leds

               // For $viz_lit.
               logic L2_viz_lit_a0;

               assign L2_viz_lit_a0 = (! L0_sseg_digit_n_a0[digit]) && ! ((leds == 7) ? L0_sseg_decimal_point_n_a0 : L0_sseg_segment_n_a0[leds % 7]);
               
            end
         end
      //_\end_source
   
      // slideswitches
      //_\source /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv 454   // Instantiated from /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv, 349 as: m4+fpga_switch.
         for (switch = 0; switch <= 7; switch++) begin : L1_Switch //_/switch

            // For $viz_switch.
            logic L1_viz_switch_a0;

            assign L1_viz_switch_a0 = L0_slideswitch_a0[switch];
            
         end
      //_\end_source
   
      // pushbuttons
      
   //_\end_source
   // Label the switch inputs [0..7] (1..8 on the physical switch panel) (top-to-bottom).
   //_\source /raw.githubusercontent.com/osfpga/VirtualFPGALab/35e36bd144fddd75495d4cbc01c4fc50ac5bde6f/tlvlib/tinytapeoutlib.tlv 82   // Instantiated from top.tlv, 167 as: m5+tt_input_labels_viz(⌈"Value[0]", "Value[1]", "Value[2]", "Value[3]", "Op[0]", "Op[1]", "Op[2]", "="⌉)
      for (input_label = 0; input_label <= 7; input_label++) begin : L1_InputLabel //_/input_label
         
      end
   //_\end_source

//_\SV
endmodule


// Undefine macros defined by SandPiper.
`undef BOGUS_USE
