module sequential_16bit_en(input wire clk, input wire [27:0] io_in, output wire [27:0] io_out);
    wire rst = io_in[0];
    wire en = io_in[1];
    reg [26:0] ctr;

    always @(posedge clk)
        if (en)
            if (rst)
                ctr <= 0;
            else
                ctr <= ctr + 1'b1;
        else
            ctr <= ctr;

    // assign io_out = ctr[25:10]; // Just for emulation!
    assign io_out = ctr; // For simulation!
endmodule
