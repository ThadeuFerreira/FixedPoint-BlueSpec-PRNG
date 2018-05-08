// Copyright (c) 2013 Bluespec, Inc.  All rights reserved.
// $Revision: 32843 $
// $Date: 2013-12-16 16:25:57 +0000 (Mon, 16 Dec 2013) $

package LogTableFxdP;

import ClientServer ::*;
import FIFO ::*;
import FIFO ::*;
import FIFOF ::*;
import FixedPoint ::*;
import GetPut ::*;
import Real ::*;
import StmtFSM ::*;
import Vector ::*;
import InterfaceLogTableFxdP::*;

typedef FixedPoint#(32,32) SqrtTFx;
typedef Bit#(32) Int32WORD;
typedef FixedPoint#(33,32) SqrtTFx33;


(* synthesize *)
module mkLogTableFxdP (InterfaceLogTableFxdP#(SqrtTFx33,SqrtTFx33));
    Reg#(int) cycle <- mkReg(0);
    Reg#(Bool) flag <- mkReg(True);

    Reg#(SqrtTFx33)		x <- mkReg(0);


    Reg#(SqrtTFx33)		result <- mkReg(0);
    
    function SqrtTFx33 logTable (SqrtTFx33 i);
        SqrtTFx33 retval;
        if((i >= fromReal(0.9))&&(i < fromReal(1)) )
        begin
            retval = fromReal(-0.10536051565782630123); 
        end
        else if((i >= fromReal(0.8))&&(i < fromReal(0.9)) ) 
        begin
            retval = fromReal(-0.22314355131420975577); 
        end
        else if((i >= fromReal(0.7))&&(i < fromReal(0.8)) ) 
        begin
            retval = fromReal(-0.35667494393873237891); 
        end
        else if((i >= fromReal(0.6))&&(i < fromReal(0.7)) ) 
        begin
            retval = fromReal(-0.51082562376599068321); 
        end
        else if((i >= fromReal(0.5))&&(i < fromReal(0.6)) ) 
        begin
            retval = fromReal(-0.69314718055994530942); 
        end
        else if((i >= fromReal(0.4))&&(i < fromReal(0.5)) ) 
        begin
            retval = fromReal(-0.91629073187415506518); 
        end
        else if((i >= fromReal(0.3))&&(i < fromReal(0.4)) ) 
        begin
            retval = fromReal(-1.20397280432593599262); 
        end
        else if((i >= fromReal(0.2))&&(i < fromReal(0.3)) ) 
        begin
            retval = fromReal(-1.6094379124341003746); 
        end
        else if((i >= fromReal(0.1))&&(i < fromReal(2)) ) 
        begin
            retval = fromReal(-2.30258509299404568402); 
        end
        else if((i > fromReal(0))&&(i < fromReal(0.1)) ) 
        begin
            retval = fromReal(-2.30258509299404568402*1000); 
        end
        else begin
            retval = fromReal(0);
        end
        return retval;
    endfunction:logTable
 

    method Action run(SqrtTFx33 input_val );
        if(flag)
        action            
            result <= logTable(input_val);
            cycle <= cycle + 1;
            flag <= False;
        endaction
        else
        action            
            flag <= True;
        endaction

    endmethod:run

    method ActionValue#(SqrtTFx33) get (  ); 
        

        return result;
    endmethod:get


endmodule



endpackage
