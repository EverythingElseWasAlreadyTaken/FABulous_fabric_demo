(* FABulous, BelMap,
INIT0=0,
INIT1=1,
INIT2=2,
INIT3=3
*)
module Config_access #(parameter NoConfigBits = 4)(
    // ConfigBits has to be adjusted manually (we don't use an arithmetic parser for the value)
    // Pin0
    (* FABulous, EXTERNAL *)output [3:0] C_bit, // EXTERNAL
    // GLOBAL all primitive pins that are connected to the switch matrix have to go before the GLOBAL label
    (* FABulous, GLOBAL *)input [NoConfigBits-1:0] ConfigBits
);
    // we just wire configuration bits to fabric top
    assign C_bit = ConfigBits;

endmodule
