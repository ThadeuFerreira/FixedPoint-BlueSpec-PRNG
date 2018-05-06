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

function SqrtTFx33 fLUT(SqrtTFx33 input_val);
    SqrtTFx33 retval;
    if(input_val > fromReal(0.5)) begin
        retval = 1111;
        end
    else begin
        retval = 0;
    end
        return retval;

endfunction:fLUT

(* synthesize *)
module mkLogTableFxdP (InterfaceLogTableFxdP#(SqrtTFx33,SqrtTFx33));
    Reg#(Int32WORD) v1 <- mkReg(0);
    method SqrtTFx33 get ( SqrtTFx33 input_val );      
        SqrtTFx33 output_val = fLUT(input_val);
        
        return output_val;
    endmethod:get


endmodule



endpackage
