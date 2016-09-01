
package FixedTb;



// Bluespec standard packages.
import StmtFSM::*;

// My packages.
import FixedPoint::*;
import RandomNumberGenerator::*;
import WellPRNG::*;


// Expoents for the number of outputs to be generated (2^N).
typedef 41 N_DEFAULT;      // For fast human conference.
    // NIST test. Empirically determined.


(* synthesize *)
module mkFixedTb (Empty);

     
   // Expoent of the number of outputs to be generated (2^N).
   Reg#(UInt#(64)) n <- mkReg (fromInteger (valueOf (N_DEFAULT)));
   
   // Output counter.
   Reg#(UInt#(64)) i <- mkReg (0);

   IfcRandomNumberGenerator#(Int32WORD, Int32WORD) rng <- mkWellPRNG  ();
   
  // Reg#(UInt#(32)) v <- mkReg (0);
   Stmt verify_stmt =
   seq
      

     rng.initialize (fromInteger (0));
      
      // Generate 2^N outputs.
      // Format: <Output Number> <Output Value in C Style Hex>

	//$display("#==================================================================");
	//$display("# FixedPoint test");
	//$display("#==================================================================");
	

      while (i < (1 << n))
	 action
	 	Int32WORD v <-  rng.get()  ;
		FixedPoint#(33,33) x = (0.000000000232830643653869)* fromUInt(unpack(v)); 
		fxptWrite( 10, x ) ; $display("" ); 
	    i <= i + 1;
	 endaction
      $finish();
   endseq;
   
   mkAutoFSM (verify_stmt);
   
endmodule: mkFixedTb



endpackage: FixedTb
