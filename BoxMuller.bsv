
package BoxMuller;



// Bluespec standard packages.
import StmtFSM::*;

// My packages.
import FixedPoint::*;
import FIFO::*;
import RandomNumberGenerator::*;
import BoxMullerInterface::*;
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

typedef UInt#(64) SqrtT;
typedef FixedPoint#(32,32) SqrtTFx;
typedef Tuple3#(Int32WORD, Int32WORD, SqrtTFx) TupleUInt32; 

(* synthesize *)
module mkBoxMuller (IfcBoxMullerInterface#(Int32WORD, TupleUInt32, SqrtTFx));
    IfcRandomNumberGenerator#(Int32WORD, Int32WORD) rgn1 <- mkWellPRNG();
    IfcRandomNumberGenerator#(Int32WORD, Int32WORD) rgn2 <- mkWellPRNG();

    Reg#(SqrtTFx)		valsqrIn <- mkReg(0);
    Reg#(SqrtTFx)		valsqrOut <- mkReg(0);
    Reg#(TupleUInt32)	randtuple <- mkRegU;					

	Server#(SqrtTFx,Tuple2#(SqrtTFx,Bool)) sqrtfxm <- mkFixedPointSquareRooter(1);
    FIFOF#(SqrtTFx) fCheck <- mkLFIFOF;

    Reg#(int) cycle <- mkReg(0);
    Reg#(Bool) flag <- mkReg(False);

    rule counter;
        cycle <= cycle + 1;
    endrule

    function Action putSqrt();
        action
            sqrtfxm.request.put(valsqrIn);            
        endaction
    endfunction

    function Action getSqrt();
        action
            Tuple2#(SqrtTFx,Bool) retval <- sqrtfxm.response.get();
            valsqrOut <= tpl_1(retval);
        endaction
    endfunction

    Stmt test =
    seq
        $display("Cycles 1 = %d\n",cycle);  
        putSqrt();
        $display("Cycles 2 = %d\n",cycle); 
        getSqrt();
        $display("Cycles 3 = %d\n",cycle);  
    endseq;

    FSM testFSM <- mkFSM(test);

    method Action initialize (Int32WORD s1, Int32WORD s2);
        rgn1.initialize(s1);
        rgn2.initialize(s2);
    endmethod:initialize    

    method ActionValue#(TupleUInt32) get (SqrtTFx nfx );
         
        let v1 <- rgn1.get;
        let v2 <- rgn2.get; 
            
        valsqrIn  <=  nfx;           
        testFSM.start;   
          
        return tuple3(v1,v2, valsqrOut);
    endmethod:get

    

endmodule: mkBoxMuller



endpackage: BoxMuller
