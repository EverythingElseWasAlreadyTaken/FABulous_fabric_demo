 //Generative IO BEL for N_IO_GenIO
 //This is a generated file, please don't edit!

module N_IO_GenIO
    #(
        parameter NoConfigBits=0
    )
    (
        output  NIO_O,
        input  NIO_I,
        (* FABulous, EXTERNAL *) input  NIO_O_top,
        (* FABulous, EXTERNAL *) output  NIO_I_top
    );


assign NIO_O = NIO_O_top;
assign NIO_I_top = NIO_I;

endmodule
