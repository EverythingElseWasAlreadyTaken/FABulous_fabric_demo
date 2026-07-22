// Include inside a testbench module after declaring CLK and Rx. Define
// UART_TB_COM_RATE before including this file to match a different UART
// receiver divider; the fixed tutorial fabrics use the default of 217.
`ifndef UART_TB_COM_RATE
`define UART_TB_COM_RATE 217
`endif

localparam integer UART_CLKS_PER_BIT = `UART_TB_COM_RATE;

// Transmit one 8-N-1 UART byte, least-significant bit first.
task automatic uart_send_byte(input [7:0] data);
    integer bit_index;
    begin
        Rx = 1'b0;
        repeat (UART_CLKS_PER_BIT) @(posedge CLK);
        for (bit_index = 0; bit_index < 8; bit_index = bit_index + 1) begin
            Rx = data[bit_index];
            repeat (UART_CLKS_PER_BIT) @(posedge CLK);
        end
        Rx = 1'b1;
        repeat (UART_CLKS_PER_BIT) @(posedge CLK);
    end
endtask
