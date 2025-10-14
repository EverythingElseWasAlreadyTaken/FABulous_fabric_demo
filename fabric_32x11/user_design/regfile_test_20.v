// RegFile primitive test design - Configurable RegFile instances
// Tests 1-20 RegFile_32x4 primitives in the FPGA (parameterizable)
// Each RegFile has 32 entries x 4 bits = 128 bits storage
// Total: NUM_REGFILES x 128 bits of register file storage

module regfile_test_20 #(
    parameter NUM_REGFILES = 20  // Number of RegFiles to instantiate (1-20)
)(
    input wire clk,
    input wire [27:0] io_in,
    output wire [27:0] io_out
);

    // Parameter validation and calculation
    localparam NUM_COMB_REGFILES = NUM_REGFILES / 2;
    localparam NUM_REG_REGFILES = NUM_REGFILES - NUM_COMB_REGFILES;

    // I/O Mapping:
    // io_in[0]     = reset
    // io_in[1]     = write enable (gated by RegFile select)
    // io_in[6:2]   = write address (5 bits, 0-31)
    // io_in[10:7]  = write data (4 bits)
    // io_in[15:11] = read address A (5 bits, 0-31)
    // io_in[20:16] = read address B (5 bits, 0-31)
    // io_in[25:21] = RegFile select for write/read (5 bits, 0-NUM_REGFILES-1)
    // io_in[26]    = read port select (0=A, 1=B)
    // io_in[27]    = read mode select (0=combinational, 1=registered)
    //
    // io_out[3:0]  = read data from selected RegFile and port
    // io_out[8:4]  = echo RegFile select
    // io_out[27:9] = unused

    wire reset = io_in[0];
    wire w_en = io_in[1];
    wire [4:0] w_addr = io_in[6:2];
    wire [3:0] w_data = io_in[10:7];
    wire [4:0] a_addr = io_in[15:11];
    wire [4:0] b_addr = io_in[20:16];
    wire [4:0] rf_sel = io_in[25:21];
    wire port_sel = io_in[26];
    wire mode_sel = io_in[27];

    // Output arrays for NUM_REGFILES RegFiles
    wire [3:0] ad_comb [0:19];  // Combinational read port A (max 20)
    wire [3:0] bd_comb [0:19];  // Combinational read port B (max 20)
    wire [3:0] ad_reg [0:19];   // Registered read port A (max 20)
    wire [3:0] bd_reg [0:19];   // Registered read port B (max 20)

`ifdef SYNTHESIS
    // Generate NUM_REGFILES RegFile instances
    // Split: NUM_COMB_REGFILES combinational + NUM_REG_REGFILES registered
    genvar i;
    generate
        // Combinational RegFiles (0 to NUM_COMB_REGFILES-1)
        for (i = 0; i < NUM_COMB_REGFILES; i = i + 1) begin : gen_regfile_comb
            RegFile_32x4 #(
                .AD_reg(1'b0),  // Combinational read on port A
                .BD_reg(1'b0)   // Combinational read on port B
            ) regfile_inst (
                // Write port (broadcast to all)
                .D0(w_data[0]),
                .D1(w_data[1]),
                .D2(w_data[2]),
                .D3(w_data[3]),
                .W_ADR0(w_addr[0]),
                .W_ADR1(w_addr[1]),
                .W_ADR2(w_addr[2]),
                .W_ADR3(w_addr[3]),
                .W_ADR4(w_addr[4]),
                .W_en(w_en & ~reset & (rf_sel == i[4:0])),

                // Read port A
                .AD0(ad_comb[i][0]),
                .AD1(ad_comb[i][1]),
                .AD2(ad_comb[i][2]),
                .AD3(ad_comb[i][3]),
                .A_ADR0(a_addr[0]),
                .A_ADR1(a_addr[1]),
                .A_ADR2(a_addr[2]),
                .A_ADR3(a_addr[3]),
                .A_ADR4(a_addr[4]),

                // Read port B
                .BD0(bd_comb[i][0]),
                .BD1(bd_comb[i][1]),
                .BD2(bd_comb[i][2]),
                .BD3(bd_comb[i][3]),
                .B_ADR0(b_addr[0]),
                .B_ADR1(b_addr[1]),
                .B_ADR2(b_addr[2]),
                .B_ADR3(b_addr[3]),
                .B_ADR4(b_addr[4]),

                .CLK(clk)
            );
            // Tie off registered outputs for combinational RegFiles
            assign ad_reg[i] = 4'b0;
            assign bd_reg[i] = 4'b0;
        end

        // Registered RegFiles (NUM_COMB_REGFILES to NUM_REGFILES-1)
        for (i = NUM_COMB_REGFILES; i < NUM_REGFILES; i = i + 1) begin : gen_regfile_reg
            RegFile_32x4 #(
                .AD_reg(1'b1),  // Registered read on port A
                .BD_reg(1'b1)   // Registered read on port B
            ) regfile_inst (
                // Write port (broadcast to all)
                .D0(w_data[0]),
                .D1(w_data[1]),
                .D2(w_data[2]),
                .D3(w_data[3]),
                .W_ADR0(w_addr[0]),
                .W_ADR1(w_addr[1]),
                .W_ADR2(w_addr[2]),
                .W_ADR3(w_addr[3]),
                .W_ADR4(w_addr[4]),
                .W_en(w_en & ~reset & (rf_sel == i[4:0])),

                // Read port A
                .AD0(ad_reg[i][0]),
                .AD1(ad_reg[i][1]),
                .AD2(ad_reg[i][2]),
                .AD3(ad_reg[i][3]),
                .A_ADR0(a_addr[0]),
                .A_ADR1(a_addr[1]),
                .A_ADR2(a_addr[2]),
                .A_ADR3(a_addr[3]),
                .A_ADR4(a_addr[4]),

                // Read port B
                .BD0(bd_reg[i][0]),
                .BD1(bd_reg[i][1]),
                .BD2(bd_reg[i][2]),
                .BD3(bd_reg[i][3]),
                .B_ADR0(b_addr[0]),
                .B_ADR1(b_addr[1]),
                .B_ADR2(b_addr[2]),
                .B_ADR3(b_addr[3]),
                .B_ADR4(b_addr[4]),

                .CLK(clk)
            );
            // Tie off combinational outputs for registered RegFiles
            assign ad_comb[i] = 4'b0;
            assign bd_comb[i] = 4'b0;
        end

        // Tie off unused RegFiles (NUM_REGFILES to 19)
        for (i = NUM_REGFILES; i < 20; i = i + 1) begin : gen_unused_regfiles
            assign ad_comb[i] = 4'b0;
            assign bd_comb[i] = 4'b0;
            assign ad_reg[i] = 4'b0;
            assign bd_reg[i] = 4'b0;
        end
    endgenerate

`else
    // Simulation version with bus ports
    genvar i;
    generate
        // Combinational RegFiles
        for (i = 0; i < NUM_COMB_REGFILES; i = i + 1) begin : gen_regfile_comb
            RegFile_32x4 regfile_inst (
                // Write port
                .D(w_data),
                .W_ADR(w_addr),
                .W_en(w_en & ~reset & (rf_sel == i[4:0])),

                // Read port A
                .AD(ad_comb[i]),
                .A_ADR(a_addr),

                // Read port B
                .BD(bd_comb[i]),
                .B_ADR(b_addr),

                .UserCLK(clk),
                .ConfigBits(2'b00) // Both ports combinational
            );
            // Tie off registered outputs
            assign ad_reg[i] = 4'b0;
            assign bd_reg[i] = 4'b0;
        end

        // Registered RegFiles
        for (i = NUM_COMB_REGFILES; i < NUM_REGFILES; i = i + 1) begin : gen_regfile_reg
            RegFile_32x4 regfile_inst (
                // Write port
                .D(w_data),
                .W_ADR(w_addr),
                .W_en(w_en & ~reset & (rf_sel == i[4:0])),

                // Read port A
                .AD(ad_reg[i]),
                .A_ADR(a_addr),

                // Read port B
                .BD(bd_reg[i]),
                .B_ADR(b_addr),

                .UserCLK(clk),
                .ConfigBits(2'b11) // Both ports registered
            );
            // Tie off combinational outputs
            assign ad_comb[i] = 4'b0;
            assign bd_comb[i] = 4'b0;
        end

        // Tie off unused RegFiles (NUM_REGFILES to 19)
        for (i = NUM_REGFILES; i < 20; i = i + 1) begin : gen_unused_regfiles
            assign ad_comb[i] = 4'b0;
            assign bd_comb[i] = 4'b0;
            assign ad_reg[i] = 4'b0;
            assign bd_reg[i] = 4'b0;
        end
    endgenerate

`endif

    // Output muxing - select RegFile, port, and mode
    reg [3:0] selected_data;

    always @(*) begin
        if (rf_sel < NUM_REGFILES) begin
            if (mode_sel) begin
                // Registered mode
                if (port_sel)
                    selected_data = bd_reg[rf_sel];
                else
                    selected_data = ad_reg[rf_sel];
            end else begin
                // Combinational mode
                if (port_sel)
                    selected_data = bd_comb[rf_sel];
                else
                    selected_data = ad_comb[rf_sel];
            end
        end else begin
            selected_data = 4'b0;
        end
    end

    // Pack outputs
    assign io_out = {
        19'h00000,       // [27:9] unused
        rf_sel,          // [8:4] echo RegFile select
        selected_data    // [3:0] read data
    };

endmodule
