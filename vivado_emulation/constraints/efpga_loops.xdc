set_disable_timing [get_pins -hierarchical *Q_reg*]
set_disable_timing [get_pins -filter {REF_PIN_NAME =~ "*BEG*"} -of_objects [get_cells -hierarchical -quiet -filter {NAME =~ "*switch_matrix*"}]]
set_property ALLOW_COMBINATORIAL_LOOPS true [get_nets -hierarchical -filter {NAME =~ *BEG*}]
