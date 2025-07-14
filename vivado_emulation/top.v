`timescale 1ns / 1ps
module top #(
    parameter NUM_USED_IOS       = 16

) (
    input  clk,
    input  reset,
    input  s_clk,
    input  s_data,
    input  uart_tx_in,

    output [7:0] led,
    input [1:0] sw
);


    //Signal declarations
    wire resetn;
    wire locked;

    wire [NUM_USED_IOS-1:0] I_top;
    wire [NUM_USED_IOS-1:0] O_top;
    wire [NUM_USED_IOS-1:0] T_top;
    wire clk_efpga;
    wire heartbeat;
    wire rx_led;

    assign resetn = !reset & locked;

    // reset and enable to dip switches
    assign O_top[1:0] = sw;
    // counter MSB to leds
    assign led[7:2] = I_top[15:9];
    assign led[1] = rx_led;
    assign led[0] = heartbeat;

    reg [29:0] ctr;


    clk_wiz_0 clk_inst
    (
    // Clock out ports
    .clk_out1(clk_efpga),
    // Status and control signals
    .reset(reset),
    .locked(locked),
    // Clock in ports
    .clk_in1(clk)
    );

    always @(posedge clk_efpga) ctr <= ctr + 1'b1;
    assign heartbeat = ctr[25];

    eFPGA_top #(
    ) eFPGA_top_inst (

        .A_config_C    (),
        .B_config_C    (),
        .I_top         (I_top),
        .O_top         (O_top),
        .T_top         (T_top),
        .CLK           (clk_efpga),
        .resetn        (resetn),

        //Config related ports
        .SelfWriteStrobe(),
        .SelfWriteData  (),
        .s_clk          (s_clk),
        .s_data         (s_data),
        .ComActive      (),
        .Rx             (uart_tx_in),
        .ReceiveLED     (rx_led)
    );


endmodule
