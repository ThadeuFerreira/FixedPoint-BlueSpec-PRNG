
package FixedTb;



// Bluespec standard packages.
import StmtFSM::*;

// My packages.
import FixedPoint::*;
import FIFO::*;
import RandomNumberGenerator::*;
import WellPRNG::*;
import AirblueCommon::*;
import AirblueTypes::*;

//`define isDebug True  // uncomment this line to display error
`define cordicIters 16 // no. iterations cordic performs before giving result
`define cordicItersPerStage 8 // no. pipeline iters per stages


// Expoents for the number of outputs to be generated (2^N).
typedef 41 N_DEFAULT;      // For fast human conference.
    // NIST test. Empirically determined.


(* synthesize *)
module mkFixedTb (Empty);

     
   // Expoent of the number of outputs to be generated (2^N).
   Reg#(UInt#(64)) n <- mkReg (fromInteger (valueOf (N_DEFAULT)));
   
   // Output counter.
   Reg#(UInt#(64)) i <- mkReg (0);	
   Reg#(FixedPoint#(33,52))		uniform_rand_num <- mkReg(0);						
   FIFO#(FixedPoint#(33,52))        angle_q <- mkSizedFIFO(2);
   CosAndSin#(33,52,33,52)      cos_and_sin <- mkCosAndSin_Pipe(`cordicIters,`cordicItersPerStage);

   IfcRandomNumberGenerator#(Int32WORD, Int32WORD) rng <- mkWellPRNG  ();

  rule initialize(i == 0);
      rng.initialize (fromInteger (0));
      i <= 1;
  endrule

  rule interpolate(i > 0);

    Int32WORD v <-  rng.get()  ;
    
     //uniform_rand_num <= (0.000000000232830643653869628906)* fromUInt(unpack(v))*6.28; 
    uniform_rand_num <= 3.14159265359;
    angle_q.enq(uniform_rand_num);

  endrule

  rule calculate_adjustment_put(True);
    cos_and_sin.putAngle(angle_q.first);
    angle_q.deq;
  endrule

  rule printS(True);
    CosSinPair#(33,52) cos_sin_pair <- cos_and_sin.getCosSinPair;
    $display(i);
    $display("* -"); fxptWrite(10, uniform_rand_num) ; $display("" ); 
		$display("# -");fxptWrite( 10, cos_sin_pair.cos ) ; $display("" ); 
    $display("# -");fxptWrite( 10, cos_sin_pair.sin ) ; $display("" ); 
	    i <= i + 1;
  endrule
   
endmodule: mkFixedTb



endpackage: FixedTb
