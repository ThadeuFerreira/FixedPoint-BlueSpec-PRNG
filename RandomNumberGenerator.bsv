
package RandomNumberGenerator;



interface IfcRandomNumberGenerator#(
   type seed_type,  // Seed type.
   type out_type    // Output word type.
);

   // Initialize the RNG.
   method Action initialize (seed_type s);

   // Get a number from RNG.
   method ActionValue#(out_type) get ();

endinterface: IfcRandomNumberGenerator



endpackage: RandomNumberGenerator

