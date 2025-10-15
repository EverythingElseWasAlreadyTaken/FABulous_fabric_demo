`timescale 1ps/1ps
module regfile_test_20_tb;
    wire [27:0] I_top;
    wire [27:0] O_top;
    wire [27:0] I_top_gold;

    reg CLK = 1'b0;
    reg resetn = 1'b1;
    reg SelfWriteStrobe = 1'b0;
    reg [31:0] SelfWriteData = 1'b0;
    reg Rx = 1'b1;
    wire ComActive;
    wire ReceiveLED;
    reg s_clk = 1'b0;
    reg s_data = 1'b0;

    // Named signals for O_top (inputs to DUT)
    reg tb_reset;
    reg tb_w_en;
    reg [4:0] tb_w_addr;
    reg [3:0] tb_w_data;
    reg [4:0] tb_a_addr;
    reg [4:0] tb_b_addr;
    reg [4:0] tb_rf_sel;
    reg tb_mode_sel_a;
    reg tb_mode_sel_b;

    // Pack O_top from named signals
    assign O_top = {tb_mode_sel_b, tb_mode_sel_a, tb_rf_sel, tb_b_addr, tb_a_addr, tb_w_data, tb_w_addr, tb_w_en, tb_reset};

    // Named signals for I_top (outputs from DUT)
    wire [3:0] dut_port_a_data = I_top[3:0];
    wire [3:0] dut_port_b_data = I_top[7:4];
    wire [4:0] dut_rf_sel_echo = I_top[12:8];

    // Named signals for I_top_gold (outputs from gold model)
    wire [3:0] gold_port_a_data = I_top_gold[3:0];
    wire [3:0] gold_port_b_data = I_top_gold[7:4];
    wire [4:0] gold_rf_sel_echo = I_top_gold[12:8];

    // Instantiate both the fabric and the reference DUT
    eFPGA_top top_i (
        .NIO_I_top(I_top),
        .NIO_O_top(O_top),
        .CLK(CLK), .resetn(resetn),
        .SelfWriteStrobe(SelfWriteStrobe), .SelfWriteData(SelfWriteData),
        .Rx(Rx),
        .ComActive(ComActive),
        .ReceiveLED(ReceiveLED),
        .s_clk(s_clk),
        .s_data(s_data)
    );

    // Gold model - instantiate with parameter from plusargs or default to 20
    // The NUM_REGFILES parameter must match what's being tested for proper comb/reg split
`ifdef NUM_REGFILES_PARAM
    regfile_test_20 #(.NUM_REGFILES(`NUM_REGFILES_PARAM)) dut_i (
`else
    regfile_test_20 #(.NUM_REGFILES(20)) dut_i (
`endif
        .clk(CLK),
        .io_out(I_top_gold),
        .io_in(O_top)
    );

    localparam MAX_BITBYTES = 30000;
    reg [7:0] bitstream[0:MAX_BITBYTES-1];

    always #5000 CLK = (CLK === 1'b0);

    integer i, j, rf;
    reg have_errors = 1'b0;
    reg [3:0] expected_data;

    // Parameterizable test configuration
    integer num_regfiles = 20;  // Default: test all 20 RegFiles
    integer num_comb_regfiles;
    integer num_reg_regfiles;

    reg [2047:0] bitstream_hex_arg;
    reg [2047:0] output_waveform_arg;
    initial begin

        // Get number of RegFiles to test from command line
        if (!$value$plusargs("num_regfiles=%d", num_regfiles)) begin
            num_regfiles = 20;  // Default to all 20
        end

        // Validate and calculate split
        if (num_regfiles < 1 || num_regfiles > 20) begin
            $display("Error: num_regfiles must be between 1 and 20. Got: %0d", num_regfiles);
            $fatal;
        end

        // Split evenly between combinatorial and registered
        num_comb_regfiles = num_regfiles / 2;
        num_reg_regfiles = num_regfiles - num_comb_regfiles;

        if ($value$plusargs("output_waveform=%s", output_waveform_arg)) begin
            $dumpfile(output_waveform_arg);
            $dumpvars(0, regfile_test_20_tb);
            $display("Output waveform set to %s", output_waveform_arg);
        end

`ifndef EMULATION

        if ($value$plusargs("bitstream_hex=%s", bitstream_hex_arg)) begin
            $readmemh(bitstream_hex_arg, bitstream);
            $display("Read bitstream hex from %s", bitstream_hex_arg);
        end else begin
            $display("Error: No bitstream provided as $plusargs bitstream_hex.");
            $fatal;
        end


        #100;
        resetn = 1'b0;
        #10000;
        resetn = 1'b1;
        #10000;
        repeat (20) @(posedge CLK);
        #2500;
        for (i = 0; i < MAX_BITBYTES; i = i + 4) begin
            SelfWriteData <= {bitstream[i], bitstream[i+1], bitstream[i+2], bitstream[i+3]};
            repeat (2) @(posedge CLK);
            SelfWriteStrobe <= 1'b1;
            @(posedge CLK);
            SelfWriteStrobe <= 1'b0;
            repeat (2) @(posedge CLK);
        end
`endif
        repeat (100) @(posedge CLK);

        $display("=== RegFile Test - Testing %0d RegFile Instances ===", num_regfiles);
        $display("Testing %0d combinatorial RegFiles (0-%0d) and %0d registered RegFiles (%0d-%0d)",
                 num_comb_regfiles, num_comb_regfiles-1,
                 num_reg_regfiles, num_comb_regfiles, num_regfiles-1);

        // Phase 1: Reset
        tb_reset = 1'b1;
        tb_w_en = 1'b0;
        tb_w_addr = 5'd0;
        tb_w_data = 4'd0;
        tb_a_addr = 5'd0;
        tb_b_addr = 5'd0;
        tb_rf_sel = 5'd0;
        tb_mode_sel_a = 1'b0;
        tb_mode_sel_b = 1'b0;
        repeat (5) @(posedge CLK);
        $display("Reset asserted");
        tb_reset = 1'b0; // Deassert reset
        repeat (5) @(posedge CLK);

        // Phase 2: Write unique test patterns to selected RegFiles
        // Each RegFile gets a unique pattern based on its ID
        $display("\nPhase 2: Writing unique patterns to %0d RegFiles...", num_regfiles);
        for (rf = 0; rf < num_regfiles; rf = rf + 1) begin
            $display("  Writing to RegFile %0d:", rf);
            tb_rf_sel = rf[4:0];
            tb_mode_sel_a = 1'b0;
            tb_mode_sel_b = 1'b0;
            tb_a_addr = 5'd0;
            tb_b_addr = 5'd0;

            // Write to addresses 0-15 in each RegFile
            for (i = 0; i < 16; i = i + 1) begin
                // Write data = (rf[3:0] + i[3:0]) & 0xF
                // This creates unique patterns for each RegFile
                expected_data = (rf + i) & 4'hF;
                tb_w_addr = i[4:0];
                tb_w_data = expected_data;
                tb_w_en = 1'b1;
                @(posedge CLK);
                $display("    addr[%0d] = 0x%X", i, expected_data);
            end
            $display("  RegFile %0d complete", rf);
        end

        // Disable write
        tb_w_en = 1'b0;
        repeat (5) @(posedge CLK);

        // Phase 3: Read back from all combinatorial RegFiles
        $display("\nPhase 3: Reading from combinatorial RegFiles (0-%0d)...", num_comb_regfiles-1);
        for (rf = 0; rf < num_comb_regfiles; rf = rf + 1) begin
            $display("  Testing RegFile %0d (combinatorial):", rf);
            tb_rf_sel = rf[4:0];
            tb_mode_sel_a = 1'b0;  // Combinatorial mode for port A
            tb_mode_sel_b = 1'b0;  // Combinatorial mode for port B

            // Test both ports sequentially (single port at a time for basic verification)
            for (i = 0; i < 16; i = i + 1) begin
                expected_data = (rf + i) & 4'hF;
                tb_a_addr = i[4:0];
                tb_b_addr = 5'd0;
                @(negedge CLK);
                $display("    Port A addr[%0d]: fabric=0x%X gold=0x%X expect=0x%X %s",
                         i, dut_port_a_data, gold_port_a_data, expected_data,
                         (dut_port_a_data === expected_data) ? "PASS" : "FAIL");
                if (dut_port_a_data !== expected_data)
                    have_errors = 1'b1;
            end

            for (i = 0; i < 16; i = i + 1) begin
                expected_data = (rf + i) & 4'hF;
                tb_a_addr = 5'd0;
                tb_b_addr = i[4:0];
                @(negedge CLK);
                $display("    Port B addr[%0d]: fabric=0x%X gold=0x%X expect=0x%X %s",
                         i, dut_port_b_data, gold_port_b_data, expected_data,
                         (dut_port_b_data === expected_data) ? "PASS" : "FAIL");
                if (dut_port_b_data !== expected_data)
                    have_errors = 1'b1;
            end
        end

        repeat (5) @(posedge CLK);

        // Phase 4: Read back from all registered RegFiles
        $display("\nPhase 4: Reading from registered RegFiles (%0d-%0d)...", num_comb_regfiles, num_regfiles-1);
        for (rf = num_comb_regfiles; rf < num_regfiles; rf = rf + 1) begin
            $display("  Testing RegFile %0d (registered):", rf);
            tb_rf_sel = rf[4:0];
            tb_mode_sel_a = 1'b1;  // Registered mode for port A
            tb_mode_sel_b = 1'b1;  // Registered mode for port B

            // Test port A
            for (i = 0; i < 16; i = i + 1) begin
                expected_data = (rf + i) & 4'hF;
                tb_a_addr = i[4:0];
                tb_b_addr = 5'd0;
                @(posedge CLK);  // Wait for registered output
                @(negedge CLK);
                $display("    Port A addr[%0d]: fabric=0x%X gold=0x%X expect=0x%X %s",
                         i, dut_port_a_data, gold_port_a_data, expected_data,
                         (dut_port_a_data === expected_data) ? "PASS" : "FAIL");
                if (dut_port_a_data !== expected_data)
                    have_errors = 1'b1;
            end

            // Test port B
            for (i = 0; i < 16; i = i + 1) begin
                expected_data = (rf + i) & 4'hF;
                tb_a_addr = 5'd0;
                tb_b_addr = i[4:0];
                @(posedge CLK);  // Wait for registered output
                @(negedge CLK);

                $display("    Port B addr[%0d]: fabric=0x%X gold=0x%X expect=0x%X %s",
                         i, dut_port_b_data, gold_port_b_data, expected_data,
                         (dut_port_b_data === expected_data) ? "PASS" : "FAIL");

                if (dut_port_b_data !== expected_data)
                    have_errors = 1'b1;
            end
        end

        // Phase 5: True simultaneous dual-port read test (combinatorial RegFiles only)
        $display("\nPhase 5: Testing TRUE simultaneous dual-port reads (comb RegFiles only)...");
        for (rf = 0; rf < num_comb_regfiles; rf = rf + 1) begin
            $display("  RegFile %0d: Testing simultaneous dual-port access", rf);
            tb_rf_sel = rf[4:0];
            tb_mode_sel_a = 1'b0;  // Combinatorial mode for port A
            tb_mode_sel_b = 1'b0;  // Combinatorial mode for port B

            // Test multiple address combinations with BOTH ports reading simultaneously
            // Both outputs are available at the same time - no multiplexing needed!
            for (i = 0; i < 16; i = i + 2) begin
                for (j = i + 1; j < 16; j = j + 2) begin
                    reg [3:0] expected_a, expected_b;
                    expected_a = (rf + i) & 4'hF;
                    expected_b = (rf + j) & 4'hF;

                    // Set both addresses: a_addr=i, b_addr=j
                    tb_a_addr = i[4:0];
                    tb_b_addr = j[4:0];
                    #100;  // Small delay for combinatorial logic to settle
                           // Global clock period is 10,000 time units, so 100ps
                           // is small enough to avoid any clock edge

                    // Read BOTH ports simultaneously - true dual-port!
                    if (dut_port_a_data !== expected_a || dut_port_b_data !== expected_b) begin
                        $display("    FAIL: Simultaneous dual-port read - A[%0d]=0x%X (exp 0x%X), B[%0d]=0x%X (exp 0x%X)",
                                 i, dut_port_a_data, expected_a, j, dut_port_b_data, expected_b);
                        have_errors = 1'b1;
                    end
                end
            end
            $display("  RegFile %0d dual-port test complete - tested %0d address pairs", rf, 8*7/2);
        end

        // Phase 6: Write-read immediate readback test
        $display("\nPhase 6: Testing write-read timing for immediate readback (addresses 16-31)...");
        for (rf = 0; rf < num_regfiles; rf = rf + 1) begin
            $display("  Testing RegFile %0d...", rf);
            tb_rf_sel = rf[4:0];

            for (i = 16; i < 32; i = i + 1) begin
                // Write new value
                expected_data = (~(rf + i)) & 4'hF;
                tb_w_addr = i[4:0];
                tb_w_data = expected_data;
                tb_w_en = 1'b1;
                tb_mode_sel_a = 1'b0;
                tb_mode_sel_b = 1'b0;
                tb_a_addr = 5'd0;
                tb_b_addr = 5'd0;
                @(posedge CLK);

                // Immediately read back (combinatorial for rf<num_comb, registered for rf>=num_comb)
                tb_w_en = 1'b0;
                tb_a_addr = i[4:0];
                tb_mode_sel_a = (rf >= num_comb_regfiles) ? 1'b1 : 1'b0;
                tb_mode_sel_b = (rf >= num_comb_regfiles) ? 1'b1 : 1'b0;
                if (rf >= num_comb_regfiles)
                    @(posedge CLK);
                @(negedge CLK);

                if (dut_port_a_data !== expected_data) begin
                    $display("    FAIL: RF%0d addr[%0d] read=0x%X expect=0x%X",
                             rf, i, dut_port_a_data, expected_data);
                    have_errors = 1'b1;
                end
            end
            $display("  RegFile %0d complete", rf);
        end

        // Phase 7: Final fabric vs gold comparison (using dual-port reads)
        $display("\nPhase 7: Final fabric vs gold comparison...");
        for (rf = 0; rf < num_regfiles; rf = rf + 1) begin
            reg rf_errors;
            rf_errors = 1'b0;
            $display("  Comparing RegFile %0d...", rf);
            tb_rf_sel = rf[4:0];
            tb_mode_sel_a = (rf >= num_comb_regfiles) ? 1'b1 : 1'b0;
            tb_mode_sel_b = (rf >= num_comb_regfiles) ? 1'b1 : 1'b0;
            tb_b_addr = 5'd0;

            for (i = 0; i < 32; i = i + 1) begin
                // Read from port A (also reads port B but we only check port A here)
                tb_a_addr = i[4:0];
                if (rf >= num_comb_regfiles)
                    @(posedge CLK);
                @(negedge CLK);

                // Compare port A data bits
                $display("    addr[%0d]: fabric=0x%X gold=0x%X %s",
                         i, dut_port_a_data, gold_port_a_data,
                         (dut_port_a_data === gold_port_a_data) ? "PASS" : "FAIL");

                if (dut_port_a_data !== gold_port_a_data) begin
                    have_errors = 1'b1;
                    rf_errors = 1'b1;
                end
            end
            $display("  RegFile %0d comparison complete - %s", rf,
                     rf_errors ? "ERRORS FOUND" : "PASS");
        end
        $display("  All fabric vs gold comparisons complete");

        // Summary
        $display("\n=== Test Summary ===");
        $display("RegFiles tested: %0d", num_regfiles);
        $display("combinatorial RegFiles (0-%0d): %0d", num_comb_regfiles-1, num_comb_regfiles);
        $display("Registered RegFiles (%0d-%0d): %0d", num_comb_regfiles, num_regfiles-1, num_reg_regfiles);
        $display("Total addresses tested: %0d", num_regfiles * 32);
        $display("Total read operations: %0d", num_regfiles * 32 * 2); // Both ports

        if (have_errors) begin
            $display("\n*** REGFILE TEST FAILED - Errors detected ***\n");
            $fatal;
        end else begin
            $display("\n*** REGFILE TEST PASSED - All %0d RegFiles working correctly ***\n", num_regfiles);
            $finish;
        end
    end

endmodule
