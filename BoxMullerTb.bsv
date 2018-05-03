
package BoxMullerTb;



// Bluespec standard packages.
import StmtFSM::*;

// My packages.
import FixedPoint::*;
import FIFO::*;
import RandomNumberGenerator::*;
import BoxMullerInterface::*;
import WellPRNG::*;
import BoxMuller::*;
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

// Expoents for the number of outputs to be generated (2^N).
typedef 30 N_DEFAULT;      // For fast human conference.
typedef 31 N_SMALL_CRUSH;  // TestU01 Small Crush Battery. Empirically determined.
typedef 41 N_CRUSH;        // TestU01 Crush Battery. TestU01 user guide fails! Empirically determined.
typedef 62 N_BIG_CRUSH;    // TestU01 Big Crush Battery. TestU01 user guide fails!
typedef 34 N_DIEHARD;      // Marsaglia's DIEHARD. Empirically determined.
typedef 10 N_NIST; // NIST test. Empirically determined.
typedef 4  VIZUAL;

(* synthesize *)
module mkBoxMullerTb (Empty);
       
    // Expoent of the number of outputs to be generated (2^N).
    Reg#(UInt#(32)) n <- mkReg (fromInteger (valueOf (N_DEFAULT)));
    
    // Output counter.
    Reg#(UInt#(64)) i <- mkReg (0);
    Reg#(SqrtTFx) _ii <- mkReg (0);
    Reg#(TupleUInt32) tup <- mkRegU;
    Reg#(int) cont <- mkReg (0);
    IfcBoxMullerInterface#(Int32WORD, TupleUInt32, SqrtTFx) boxmuller <- mkBoxMuller();


    function Stmt functionOfSeq(  );
        return seq                     
                    action 
                        _ii <= fromInt(cont)*fromInt(cont);
                        $display ("cont = %d\n", cont);
                        $display("### ", fshow(_ii) , " ###\n");
                    endaction
                    action
                        let temptup <- boxmuller.get(_ii);  
                        tup <= temptup;
                    endaction      
                    action           
                        $display ("Numbers %d - %d", tpl_1(tup), tpl_2(tup));
                        fxptWrite( 10, tpl_3(tup)); 
                   
                        $display("");
                        $display("*** ", fshow(tpl_3(tup)) , " ***\n");
                    endaction
                    action 
                        i <= i + 1;
                        cont <= cont +1;
                    endaction
                endseq;
    endfunction

    Stmt verify_stmt =
        seq        
        // Get TestU01 test type and set N.
        action        
            n <= fromInteger (valueOf (VIZUAL));        
        endaction
        
        action
            boxmuller.initialize (fromInteger(0), fromInteger(56249));
        endaction

        $display("#==================================================================");

            
        while (i < (1 << n))  seq       
           functionOfSeq(  );    
               
        endseq
        
      
    endseq;
   
    mkAutoFSM (verify_stmt);

endmodule: mkBoxMullerTb

endpackage: BoxMullerTb
