package InterfaceLogTableFxdP;

interface InterfaceLogTableFxdP#(
   type input_type,
   type out_type
);

    method Action run(input_type input_val );

    method ActionValue#(out_type) get  ();
 
endinterface: InterfaceLogTableFxdP

endpackage: InterfaceLogTableFxdP