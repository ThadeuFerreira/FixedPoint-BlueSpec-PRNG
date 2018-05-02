
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

typedef FixedPoint#(32,32) SqrtTFx;

(* synthesize *)
module mkFixedTb (Empty);


	// Expoent of the number of outputs to be generated (2^N).
	Reg#(UInt#(64)) n <- mkReg (fromInteger (valueOf (N_DEFAULT)));

	// Output counter.
	Reg#(UInt#(64)) i <- mkReg (0);	
	Reg#(SqrtTFx)		uniform_rand_num <- mkReg(0);						
	FIFO#(SqrtTFx)        angle_q <- mkSizedFIFO(2);
	CosAndSin#(32,32,32,32)      cos_and_sin <- mkCosAndSin_Pipe(`cordicIters,`cordicItersPerStage);
	FIFO#(FPComplex#(32,32))         angle_adjust_q <- mkLFIFO;

	Server#(SqrtTFx,Tuple2#(SqrtTFx,Bool)) sqrt <- mkFixedPointSquareRooter(1);

	IfcRandomNumberGenerator#(Int32WORD, Int32WORD) rng <- mkWellPRNG  ();

	rule getCosPair(i>1);
		CosSinPair#(32,32) cos_sin_pair <- cos_and_sin.getCosSinPair;
		//fxptWrite( 10, cos_sin_pair.cos ) ; $display("" ); 
		$display("rule getCosPair, i = %d\n", i);		
		$display("rule getCosPair, cos_sin_pair.cos = ");
		fxptWrite( 10, cos_sin_pair.cos ) ; $display("" ); 
		$display("rule getCosPair, cos_sin_pair.sin = ");
		$display("# -");fxptWrite( 10, cos_sin_pair.sin ) ; $display("" ); 
	endrule

	rule getRandomNumber(i>1);
		$display("rule getRandomNumber, uniform_rand_num = ");
		fxptWrite(10, uniform_rand_num); $display("" ); 
	endrule

	rule putSquare(i>1);
		let  val = fromUInt(i*i);
		$display("rule putSquare, i = %d\n", i);
		fxptWrite( 10, val) ; $display("" ); 
		sqrt.request.put(val);
	endrule

	rule getSquare(i>1);
		//let resp <- sqrt.response.get;
		//$display(i);   
		$display("rule getSquare, i = %d\n", i);
		let resp <- sqrt.response.get();
		let val = tpl_1(resp);
		$display("rule getSquare, val = ");
		fxptWrite( 10, val) ; $display(""); 
	endrule

	rule initialize(i == 0);
		rng.initialize (fromInteger (0));
		i <= 1;
	endrule

	rule interpolate(i > 0 );
		Int32WORD v <-  rng.get();
		uniform_rand_num <= (0.000000000232830643653869628906)* fromUInt(unpack(v)); 
		i <= i + 1;
		$display("rule interpolate i = %d\n",i);

		angle_q.enq(uniform_rand_num);
	endrule

	rule calculate_adjustment_put(True);
		cos_and_sin.putAngle(angle_q.first);
		angle_q.deq;
	endrule


	rule finalRule(i >= 100);
		$display("FIM");
		$finish();
	endrule

endmodule: mkFixedTb



endpackage: FixedTb
