`timescale 1ps/1ps

// Configure the 10x10 fabric through UART Rx, then compare it with the
// reference counter.
module sequential_16bit_en_uart_tb;
    localparam MAX_BITBYTES = 16384;

    wire [15:0] I_top;
    wire [15:0] T_top;
    reg  [15:0] O_top = 0;
    wire [31:0] A_cfg;
    wire [31:0] B_cfg;
    wire [15:0] I_top_gold;
    wire [15:0] oeb_gold;
    wire [15:0] T_top_gold;

    reg CLK = 1'b0;
    reg resetn = 1'b1;
    reg SelfWriteStrobe = 1'b0;
    reg [31:0] SelfWriteData = 1'b0;
    reg Rx = 1'b1;
    wire ComActive;
    wire ReceiveLED;
    reg s_clk = 1'b0;
    reg s_data = 1'b0;

`include "../../common/tb/uart_tasks.vh"

    eFPGA_top top_i (
        .I_top(I_top),
        .T_top(T_top),
        .O_top(O_top),
        .A_config_C(A_cfg),
        .B_config_C(B_cfg),
        .CLK(CLK),
        .resetn(resetn),
        .SelfWriteStrobe(SelfWriteStrobe),
        .SelfWriteData(SelfWriteData),
        .Rx(Rx),
        .ComActive(ComActive),
        .ReceiveLED(ReceiveLED),
        .s_clk(s_clk),
        .s_data(s_data)
    );

    sequential_16bit_en dut_i (
        .clk(CLK),
        .io_out(I_top_gold),
        .io_oeb(oeb_gold),
        .io_in(O_top)
    );

    assign T_top_gold = ~oeb_gold;

    reg [7:0] bitstream [0:MAX_BITBYTES-1];
    reg [2047:0] bitstream_hex_arg;
    reg [2047:0] output_waveform_arg;
    reg have_errors = 1'b0;
    integer i;

    always #5000 CLK = (CLK === 1'b0);

    initial begin
        if ($value$plusargs("output_waveform=%s", output_waveform_arg)) begin
            $dumpfile(output_waveform_arg);
            $dumpvars(0, sequential_16bit_en_uart_tb);
            $display("Output waveform set to %s", output_waveform_arg);
        end

        if (!$value$plusargs("bitstream_hex=%s", bitstream_hex_arg)) begin
            $display("Error: No bitstream provided as +bitstream_hex=<file>.");
            $fatal;
        end
        $readmemh(bitstream_hex_arg, bitstream);
        $display("Read bitstream hex from %s", bitstream_hex_arg);

        #100;
        resetn = 1'b0;
        #10000;
        resetn = 1'b1;
        repeat (20) @(posedge CLK);

        // Command bit 7 clear selects binary (mode 2) in the default auto mode.
        uart_send_byte(8'h00);
        uart_send_byte(8'hAA);
        uart_send_byte(8'hFF);
        uart_send_byte(8'h02);

        // The UART receiver completes the command on the stop-bit edge; its
        // configuration FSM asserts ComActive on the following clock.
        repeat (2) @(posedge CLK);
        if (!ComActive) begin
            $display("Error: UART configuration command was not accepted.");
            $fatal;
        end

        for (i = 0; i < MAX_BITBYTES; i = i + 1)
            uart_send_byte(bitstream[i]);

        repeat (100) @(posedge CLK);

        O_top = 16'b0000_0000_0000_0011;
        repeat (5) @(posedge CLK);
        O_top = 16'b0000_0000_0000_0010;
        for (i = 0; i < 100; i = i + 1) begin
            @(negedge CLK);
            $display("fabric(I_top) = 0x%X gold = 0x%X, fabric(T_top) = 0x%X gold = 0x%X", I_top, I_top_gold, T_top, T_top_gold);
            if (I_top !== I_top_gold || T_top !== T_top_gold)
                have_errors = 1'b1;
        end

        if (have_errors)
            $fatal;
        else
            $finish;
    end
endmodule
