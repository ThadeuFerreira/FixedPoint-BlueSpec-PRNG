package BoxMullerInterface;



interface IfcBoxMullerInterface#(
   type seed_type,  // Seed type.
   type out_type,    // Output word type.
   type input_type
);

   // Initialize the RNG.
   method Action initialize (seed_type s1, seed_type s2);

   // Get a number from RNG.
   method ActionValue#(out_type) get (input_type val);

endinterface: IfcBoxMullerInterface



endpackage: BoxMullerInterface