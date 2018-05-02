
package BoxMullerTb;



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


typedef FixedPoint#(32,32) SqrtTFx;

(* synthesize *)
module mkBoxMullerTb (Empty);
    Reg#(UInt#(32)) i <- mkReg (0);

    rule runRule(True);
        i <= i + 1;
    endrule

	rule finalRule(i >= 100);
		$display("FIM");
		$finish();
	endrule

endmodule: mkBoxMullerTb



endpackage: BoxMullerTb
