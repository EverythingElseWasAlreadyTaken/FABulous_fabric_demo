module sequential_16bit_en(input wire clk, input wire [15:0] io_in, output wire [15:0] io_out, io_oeb);
    wire rst = io_in[0];
    wire en = io_in[1];
    reg [13:0] ctr;

    always @(posedge clk)
        if (en)
            if (rst)
                ctr <= 0;
            else
                ctr <= ctr + 1'b1;
        else
            ctr <= ctr;

    assign io_out = {2'b0, ctr}; // pass thru reset for debugging
    assign io_oeb = 16'b1;
endmodule
