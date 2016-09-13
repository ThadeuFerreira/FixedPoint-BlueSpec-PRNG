
package FixedTb;



// Bluespec standard packages.
import StmtFSM::*;

// My packages.
import FixedPoint::*;
import FIFO::*;
import RandomNumberGenerator::*;
import WellPRNG::*;
import Complex::*;
import AirblueCommon::*;
import AirblueTypes::*;
import SquareRoot::*;
import ClientServer::*;
import FIFOF::*;
import GetPut::*;
import UnitAppendList :: * ;
import BUtils::*;
import Assert::*;


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
   Reg#(UInt#(32)) i <- mkReg (0);	
   Reg#(FixedPoint#(33,52))		uniform_rand_num <- mkReg(0);						
   FIFO#(FixedPoint#(33,52))        angle_q <- mkSizedFIFO(2);
   CosAndSin#(33,52,33,52)      cos_and_sin <- mkCosAndSin_Pipe(`cordicIters,`cordicItersPerStage);
   FIFO#(FPComplex#(33,52))                                        angle_adjust_q <- mkLFIFO;

   Server#(FixedPoint#(33,52),Tuple2#(FixedPoint#(33,52),Bool)) sqrt <- mkFixedPointSquareRooter(1);

   IfcRandomNumberGenerator#(Int32WORD, Int32WORD) rng <- mkWellPRNG  ();

  rule putRequest(i>1);
    CosSinPair#(33,52) cos_sin_pair <- cos_and_sin.getCosSinPair;
    //fxptWrite( 10, cos_sin_pair.cos ) ; $display("" ); 
    $display(i);
    FixedPoint#(33, 52)  val = fromUInt(i*i);
     fxptWrite( 10, val) ; $display("" ); 
   FixedPoint#(33, 52) angle_adjustment = fromUInt(i);
    sqrt.request.put(angle_adjustment);
  endrule

  rule getResponse(i>1 && i < 100);
    //let resp <- sqrt.response.get;
   // $display(i);   
   $display("**");
   let resp <- sqrt.response.get;
    let val = tpl_1(resp);
    fxptWrite( 10, val) ; $display("" ); 
   endrule

  rule initialize(i == 0);
      rng.initialize (fromInteger (0));
      i <= 1;
  endrule

  rule interpolate(i > 0 && i < 100);
    Int32WORD v <-  rng.get();
    uniform_rand_num <= (0.000000000232830643653869628906)* fromUInt(unpack(v)); 
    //uniform_rand_num <= 0.00001*fromUInt(i);
    fxptWrite( 10, uniform_rand_num) ; $display("" ); 
     i <= i + 1;

     $display(i);

    angle_q.enq(uniform_rand_num);
  endrule

 rule calculate_adjustment_put(True);
    cos_and_sin.putAngle(angle_q.first);
    angle_q.deq;
  endrule

 // rule printS(True);
     //CosSinPair#(33,52) cos_sin_pair <- cos_and_sin.getCosSinPair;
    //$display(i);
    //$display("* -"); fxptWrite(10, uniform_rand_num) ; $display("" ); 
		//fxptWrite( 10, cos_sin_pair.cos ) ; $display("" ); 
   // $display("# -");fxptWrite( 10, cos_sin_pair.sin ) ; $display("" ); 


 //endrule

  rule finalRule(i >= 100);
    $display("FIM");
    $finish();
  endrule

 // rule printC(True);
   //            $write(" * angle correction cmplx:");
     //       fpcmplxWrite(5, angle_adjust_q.first);
       //     $display("");
         //         angle_adjust_q.deq;
  //endrule
   
endmodule: mkFixedTb



endpackage: FixedTb
