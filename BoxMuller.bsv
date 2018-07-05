
package BoxMuller;



// Bluespec standard packages.
import StmtFSM::*;

// My packages.
import FixedPoint::*;
import FIFO::*;
import RandomNumberGenerator::*;
import BoxMullerInterface::*;
import LogTableFxdP::*;
import InterfaceLogTableFxdP::*;
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
typedef FixedPoint#(33,32) SqrtTFx33;
typedef Tuple4#(Int32WORD, Int32WORD, SqrtTFx, SqrtTFx) TupleUInt32; 

(* synthesize *)
module mkBoxMuller (IfcBoxMullerInterface#(Int32WORD, TupleUInt32, SqrtTFx));
    IfcRandomNumberGenerator#(Int32WORD, Int32WORD) rgn1 <- mkWellPRNG();
    IfcRandomNumberGenerator#(Int32WORD, Int32WORD) rgn2 <- mkWellPRNG();

    Reg#(Int32WORD) v1 <- mkReg(0);
    Reg#(Int32WORD) v2 <- mkReg(0);
    Reg#(SqrtTFx)		valsqrIn <- mkReg(1024);
    Reg#(SqrtTFx)		valsqrOut <- mkReg(1);
    Reg#(TupleUInt32)	randtuple <- mkRegU;					

	Server#(SqrtTFx,Tuple2#(SqrtTFx,Bool)) sqrtfxm <- mkFixedPointSquareRooter(1);
    InterfaceLogTableFxdP#(SqrtTFx33,SqrtTFx33) mLUT <- mkLogTableFxdP();
    Reg#(SqrtTFx33)		r1 <- mkReg(0);
    Reg#(SqrtTFx33)		r2 <- mkReg(0);
    Reg#(SqrtTFx33)		x_1 <- mkReg(0);
    Reg#(SqrtTFx33)		x_2 <- mkReg(0);
    FIFOF#(SqrtTFx) fCheck <- mkLFIFOF;

    Reg#(int) cycle <- mkReg(0);
    Reg#(Bool) flag <- mkReg(True);

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
        putSqrt();        
        getSqrt();       
 
    endseq;

    FSM testFSM <- mkFSM(test);

    method Action initialize (Int32WORD s1, Int32WORD s2);
        rgn1.initialize(s1);
        rgn2.initialize(s2);
    endmethod:initialize  

    method Action run (SqrtTFx nfx );  
        if(flag)
        action
            let vt1 <- rgn1.get;
            let vt2 <- rgn2.get; 
            r1 <= (0.000000000232830643653869628906)* fromUInt(unpack(vt1));
            r2 <= (0.000000000232830643653869628906)* fromUInt(unpack(vt2));
            SqrtTFx33 x1 = r1*(2.0) -1.0;
            SqrtTFx33 x2 = r2*(2.0) -1.0;
            x_1 <= x1;
            x_2 <= x2;
            let w = x1*x1 + x2*x2;
            mLUT.run(w);
            let sw <- mLUT.get();
            let sw2  =  2.0*(sw); 
            let sw3 = sw2/w;   
            SqrtTFx tva;
            tva.i = nfx.i;
            tva.f = nfx.f;
            valsqrIn <= tva;

            testFSM.start; 
            cycle <= cycle + 1; 
            flag <= False;            
        endaction
        else
        action            
            flag <= True;
        endaction
    endmethod:run

    method ActionValue#(TupleUInt32) get ( );      
        
        
        let tpl4 = tuple4(v1,v2, valsqrOut, valsqrOut);
        return tpl4;
    
        
    endmethod:get

    

endmodule: mkBoxMuller



endpackage: BoxMuller
