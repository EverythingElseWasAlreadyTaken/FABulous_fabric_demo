 // NumberOfConfigBits: 0
module E_term_switch_matrix
    (
        input  E1END0,
        input  E1END1,
        input  E1END2,
        input  E1END3,
        input  E2MID0,
        input  E2MID1,
        input  E2MID2,
        input  E2MID3,
        input  E2MID4,
        input  E2MID5,
        input  E2MID6,
        input  E2MID7,
        input  E2END0,
        input  E2END1,
        input  E2END2,
        input  E2END3,
        input  E2END4,
        input  E2END5,
        input  E2END6,
        input  E2END7,
        input  EE4END0,
        input  EE4END1,
        input  EE4END2,
        input  EE4END3,
        input  EE4END4,
        input  EE4END5,
        input  EE4END6,
        input  EE4END7,
        input  EE4END8,
        input  EE4END9,
        input  EE4END10,
        input  EE4END11,
        input  EE4END12,
        input  EE4END13,
        input  EE4END14,
        input  EE4END15,
        input  E6END0,
        input  E6END1,
        input  E6END2,
        input  E6END3,
        input  E6END4,
        input  E6END5,
        input  E6END6,
        input  E6END7,
        input  E6END8,
        input  E6END9,
        input  E6END10,
        input  E6END11,
        output  W1BEG0,
        output  W1BEG1,
        output  W1BEG2,
        output  W1BEG3,
        output  W2BEG0,
        output  W2BEG1,
        output  W2BEG2,
        output  W2BEG3,
        output  W2BEG4,
        output  W2BEG5,
        output  W2BEG6,
        output  W2BEG7,
        output  W2BEGb0,
        output  W2BEGb1,
        output  W2BEGb2,
        output  W2BEGb3,
        output  W2BEGb4,
        output  W2BEGb5,
        output  W2BEGb6,
        output  W2BEGb7,
        output  WW4BEG0,
        output  WW4BEG1,
        output  WW4BEG2,
        output  WW4BEG3,
        output  WW4BEG4,
        output  WW4BEG5,
        output  WW4BEG6,
        output  WW4BEG7,
        output  WW4BEG8,
        output  WW4BEG9,
        output  WW4BEG10,
        output  WW4BEG11,
        output  WW4BEG12,
        output  WW4BEG13,
        output  WW4BEG14,
        output  WW4BEG15,
        output  W6BEG0,
        output  W6BEG1,
        output  W6BEG2,
        output  W6BEG3,
        output  W6BEG4,
        output  W6BEG5,
        output  W6BEG6,
        output  W6BEG7,
        output  W6BEG8,
        output  W6BEG9,
        output  W6BEG10,
        output  W6BEG11
 //global
);
parameter GND0 = 1'b0;
parameter GND = 1'b0;
parameter VCC0 = 1'b1;
parameter VCC = 1'b1;
parameter VDD0 = 1'b1;
parameter VDD = 1'b1;


 //The configuration bits (if any) are just a long shift register
 //This shift register is padded to an even number of flops/latches
 //switch matrix multiplexer W1BEG0 MUX-1
assign W1BEG0 = E1END3;

 //switch matrix multiplexer W1BEG1 MUX-1
assign W1BEG1 = E1END2;

 //switch matrix multiplexer W1BEG2 MUX-1
assign W1BEG2 = E1END1;

 //switch matrix multiplexer W1BEG3 MUX-1
assign W1BEG3 = E1END0;

 //switch matrix multiplexer W2BEG0 MUX-1
assign W2BEG0 = E2MID7;

 //switch matrix multiplexer W2BEG1 MUX-1
assign W2BEG1 = E2MID6;

 //switch matrix multiplexer W2BEG2 MUX-1
assign W2BEG2 = E2MID5;

 //switch matrix multiplexer W2BEG3 MUX-1
assign W2BEG3 = E2MID4;

 //switch matrix multiplexer W2BEG4 MUX-1
assign W2BEG4 = E2MID3;

 //switch matrix multiplexer W2BEG5 MUX-1
assign W2BEG5 = E2MID2;

 //switch matrix multiplexer W2BEG6 MUX-1
assign W2BEG6 = E2MID1;

 //switch matrix multiplexer W2BEG7 MUX-1
assign W2BEG7 = E2MID0;

 //switch matrix multiplexer W2BEGb0 MUX-1
assign W2BEGb0 = E2END7;

 //switch matrix multiplexer W2BEGb1 MUX-1
assign W2BEGb1 = E2END6;

 //switch matrix multiplexer W2BEGb2 MUX-1
assign W2BEGb2 = E2END5;

 //switch matrix multiplexer W2BEGb3 MUX-1
assign W2BEGb3 = E2END4;

 //switch matrix multiplexer W2BEGb4 MUX-1
assign W2BEGb4 = E2END3;

 //switch matrix multiplexer W2BEGb5 MUX-1
assign W2BEGb5 = E2END2;

 //switch matrix multiplexer W2BEGb6 MUX-1
assign W2BEGb6 = E2END1;

 //switch matrix multiplexer W2BEGb7 MUX-1
assign W2BEGb7 = E2END0;

 //switch matrix multiplexer WW4BEG0 MUX-1
assign WW4BEG0 = EE4END15;

 //switch matrix multiplexer WW4BEG1 MUX-1
assign WW4BEG1 = EE4END14;

 //switch matrix multiplexer WW4BEG2 MUX-1
assign WW4BEG2 = EE4END13;

 //switch matrix multiplexer WW4BEG3 MUX-1
assign WW4BEG3 = EE4END12;

 //switch matrix multiplexer WW4BEG4 MUX-1
assign WW4BEG4 = EE4END11;

 //switch matrix multiplexer WW4BEG5 MUX-1
assign WW4BEG5 = EE4END10;

 //switch matrix multiplexer WW4BEG6 MUX-1
assign WW4BEG6 = EE4END9;

 //switch matrix multiplexer WW4BEG7 MUX-1
assign WW4BEG7 = EE4END8;

 //switch matrix multiplexer WW4BEG8 MUX-1
assign WW4BEG8 = EE4END7;

 //switch matrix multiplexer WW4BEG9 MUX-1
assign WW4BEG9 = EE4END6;

 //switch matrix multiplexer WW4BEG10 MUX-1
assign WW4BEG10 = EE4END5;

 //switch matrix multiplexer WW4BEG11 MUX-1
assign WW4BEG11 = EE4END4;

 //switch matrix multiplexer WW4BEG12 MUX-1
assign WW4BEG12 = EE4END3;

 //switch matrix multiplexer WW4BEG13 MUX-1
assign WW4BEG13 = EE4END2;

 //switch matrix multiplexer WW4BEG14 MUX-1
assign WW4BEG14 = EE4END1;

 //switch matrix multiplexer WW4BEG15 MUX-1
assign WW4BEG15 = EE4END0;

 //switch matrix multiplexer W6BEG0 MUX-1
assign W6BEG0 = E6END11;

 //switch matrix multiplexer W6BEG1 MUX-1
assign W6BEG1 = E6END10;

 //switch matrix multiplexer W6BEG2 MUX-1
assign W6BEG2 = E6END9;

 //switch matrix multiplexer W6BEG3 MUX-1
assign W6BEG3 = E6END8;

 //switch matrix multiplexer W6BEG4 MUX-1
assign W6BEG4 = E6END7;

 //switch matrix multiplexer W6BEG5 MUX-1
assign W6BEG5 = E6END6;

 //switch matrix multiplexer W6BEG6 MUX-1
assign W6BEG6 = E6END5;

 //switch matrix multiplexer W6BEG7 MUX-1
assign W6BEG7 = E6END4;

 //switch matrix multiplexer W6BEG8 MUX-1
assign W6BEG8 = E6END3;

 //switch matrix multiplexer W6BEG9 MUX-1
assign W6BEG9 = E6END2;

 //switch matrix multiplexer W6BEG10 MUX-1
assign W6BEG10 = E6END1;

 //switch matrix multiplexer W6BEG11 MUX-1
assign W6BEG11 = E6END0;


endmodule