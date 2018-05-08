package BoxMullerTb;



// Bluespec standard packages.
import StmtFSM::*;

// My packages.
import FixedPoint::*;
import FIFO::*;
import RandomNumberGenerator::*;
import BoxMullerInterface::*;
import InterfaceLogTableFxdP::*;
import WellPRNG::*;
import BoxMuller::*;
import LogTableFxdP::*;
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

typedef FixedPoint#(33,32) SqrtTFx33;

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
    InterfaceLogTableFxdP#(SqrtTFx33,SqrtTFx33) mLUT <- mkLogTableFxdP();
    Reg#(SqrtTFx33)		uniform_rand_num <- mkReg(0);

    

		


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
           action 
                _ii <= fromInt(cont)*fromInt(cont);
                
            endaction            
                
            boxmuller.run(_ii);
            boxmuller.run(0);
            
            action
                let temptup <- boxmuller.get();  
                tup <= temptup;                
            endaction      
            $display("*", $time);            
                         
            action
            	Int32WORD v = tpl_1(tup);
                uniform_rand_num <= (0.000000000232830643653869628906)* fromUInt(unpack(v));                       
            endaction
            
            mLUT.run(uniform_rand_num);
            mLUT.run(0);
            
            action
                let logv <- mLUT.get();   
                $display("# -");fxptWrite( 10, uniform_rand_num ) ; $display("" );             
                $display("! -");fxptWrite( 10, logv ) ; $display("" );

            endaction    

            action    
                i <= i + 1;                     
                cont <= cont +1;
            endaction
              
               
        endseq
        
      
    endseq;
   
    mkAutoFSM (verify_stmt);

endmodule: mkBoxMullerTb

endpackage: BoxMullerTb