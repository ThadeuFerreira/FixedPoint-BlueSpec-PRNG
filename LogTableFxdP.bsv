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
    
    function SqrtTFx33 mlog2 (SqrtTFx33 val);
        Int32WORD bitVal = val.f;
        //bitVal = reverseBits(bitVal);
        let zeros = countZerosMSB(bitVal);    
            
        //SqrtTFx33 output_val =  0.69314718*(val*0.000000011920928955078125 - 126.94269504);
        SqrtTFx33 output_val = fromUInt(zeros);
        Int32WORD fval = bitVal << (zeros + 1);
        output_val.f = -fval -1 ;
        //output_val.f = truncate(pack(bitVal));
        
        return output_val;
    endfunction:mlog2
       

    method Action run(SqrtTFx33 input_val );
        if(flag)
        action            
            result <= mlog2(input_val);
            cycle <= cycle + 1;
            flag <= False;
        endaction
        else
        action            
            flag <= True;
        endaction

    endmethod:run

    method ActionValue#(SqrtTFx33) get (  ); 
        
        let resp = result;
        return resp;
    endmethod:get


endmodule



endpackage
