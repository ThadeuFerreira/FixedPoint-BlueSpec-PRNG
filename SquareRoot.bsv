// Copyright (c) 2013 Bluespec, Inc.  All rights reserved.
// $Revision: 32843 $
// $Date: 2013-12-16 16:25:57 +0000 (Mon, 16 Dec 2013) $

package SquareRoot;

import ClientServer ::*;
import FIFO ::*;
import FIFO ::*;
import FIFOF ::*;
import FixedPoint ::*;
import GetPut ::*;
import Real ::*;
import StmtFSM ::*;
import Vector ::*;

export mkSquareRooter;
export mkFixedPointSquareRooter;

module mkSquareRooter#(Integer n)(Server#(UInt#(m),Tuple2#(UInt#(m),Bool)))
   provisos(
      Div#(m, 2, m2),
      // m must be even for this implementation to work
      Mul#(m2, 2, m),
      // per request of bsc
      Add#(a__, 2, m),
      Log#(TAdd#(1, m), TLog#(TAdd#(m, 1)))
      );

   FIFO#(UInt#(m)) fRequest <- mkLFIFO;
   FIFO#(Tuple2#(UInt#(m),Bool)) fResponse <- mkLFIFO;

   FIFO#(Tuple4#(Maybe#(Bit#(m)),Bit#(m),Bit#(m),Bit#(m))) fFirst <- mkLFIFO;

   rule start;
      let op <- toGet(fRequest).get;  
      let s = pack(op);
      Bit#(m) r = 0;
      Bit#(m) b = reverseBits(extend(2'b10));

      let s0 = countZerosMSB(s);
      let b0 = countZerosMSB(b);
      if (s0 > 0) begin
         let shift = (s0 - b0);
         if ((shift & 1) == 1)
            shift = shift + 1;
         b = b >> shift;
      end

      fFirst.enq(tuple4(tagged Invalid,s,r,b));
   endrule

   FIFO#(Tuple4#(Maybe#(Bit#(m)),Bit#(m),Bit#(m),Bit#(m))) fThis = fFirst;
   FIFO#(Tuple4#(Maybe#(Bit#(m)),Bit#(m),Bit#(m),Bit#(m))) fNext;

   for (Integer i = 0; i < valueOf(m2)/n+1; i = i + 1) begin
      fNext <- mkLFIFO;
      rule work;
         //match {.res, .s, .r, .b} <- toGet(fThis).get;
         let x <- toGet(fThis).get;
         Maybe#(Bit#(m)) res = tpl_1(x);
         Bit#(m) s = tpl_2(x);
         Bit#(m) r = tpl_3(x);
         Bit#(m) b = tpl_4(x);

         for (Integer j = 0; j < n; j = j + 1) begin
            if ((i + j) <= valueOf(m2)) begin
               if (res matches tagged Invalid) begin
                  if (b == 0) begin
                     res = tagged Valid r;
                  end
                  else begin
                     let sum = r + b;

                     if (s >= sum) begin
                        s = s - sum;
                        r = (r >> 1) + b;
                     end
                     else begin
                        r = r >> 1;
                     end

                     b = b >> 2;
                  end
               end
            end
         end

         fNext.enq(tuple4(res,s,r,b));
      endrule
      fThis = fNext;
   end

   rule finish;
      match {.res, .s, .r, .b} <- toGet(fThis).get;

      fResponse.enq(tuple2(unpack(fromMaybe(0,res)),(s != 0)));
   endrule

   interface request = toPut(fRequest);
   interface response = toGet(fResponse);

endmodule

module mkFixedPointSquareRooter#(Integer n)(Server#(FixedPoint#(isize,fsize),Tuple2#(FixedPoint#(isize,fsize),Bool)))
   provisos(
      Add#(isize,fsize,m),
      // per request of bsc
      Mul#(TDiv#(m, 2), 2, m),
      Add#(a__, 2, m),
      Add#(b__, TLog#(TAdd#(1, m)), TAdd#(TLog#(m), 1)),
      Log#(TAdd#(1, m), TLog#(TAdd#(m, 1))),
      Add#(c__, TLog#(TAdd#(m, 1)), TAdd#(TLog#(m), 1))
      );

   FIFO#(FixedPoint#(isize,fsize)) fRequest <- mkLFIFO;
   FIFO#(Tuple2#(FixedPoint#(isize,fsize),Bool)) fResponse <- mkLFIFO;

   Server#(UInt#(m),Tuple2#(UInt#(m),Bool)) sqrt <- mkSquareRooter(n);
   FIFO#(Int#(TAdd#(TLog#(m),1))) fShift <- mkLFIFO;

   rule start;
      let op <- toGet(fRequest).get;
      UInt#(m) value = unpack({op.i,op.f});

      let zeros = countZerosMSB(pack(value));
      Int#(TAdd#(TLog#(m),1)) shift;

      // if (fsize + zeros) is not even, round zeros down
      if (valueOf(fsize) % 2 == 0)
         zeros = zeros & (~1);
      else
         zeros = (zeros & 1) == 0 ? zeros - 1 : zeros;

      // align input
      value = value << zeros;

      // A conversion to UInt behaves like the value was multiplied by 2**fsize.
      // Then, the value is shifted by zeros, which multiplies it by 2**zeros.
      // Therefore, after computing the square root of the resulting value,
      // it must be divided by sqrt(2**(fsize + zeros)) = 2**((fsize + zeros) / 2)
      shift = extend(unpack(pack( (zeros + fromInteger(valueOf(fsize))) >> 1 )));

      // Converting the value back from UInt to FixedPoint will already divide it
      // by 2**fsize, therefore this is excluded from the shift
      shift = shift - fromInteger(valueOf(fsize));

      sqrt.request.put(value);
      fShift.enq(shift);
   endrule

   rule finish;
      match {.result, .inexact} <- sqrt.response.get;
      let shift <- toGet(fShift).get;

      // shift result as necessary
      if (shift >= 0)
         result = result >> shift;
      else  // invert direction if shift is negative
         result = result << (-shift);

      FixedPoint#(isize,fsize) fx;
      fx.i = truncateLSB(pack(result));
      fx.f = truncate(pack(result));

      fResponse.enq(tuple2(fx,inexact));
   endrule

   interface request = toPut(fRequest);
   interface response = toGet(fResponse);

endmodule

//typedef UInt#(32) SqrtT;
typedef UInt#(64) SqrtT;
typedef FixedPoint#(32,32) SqrtTFx;

module mkTb(Empty);
   Server#(SqrtT,Tuple2#(SqrtT,Bool)) sqrtm <- mkSquareRooter(1);
   Server#(SqrtTFx,Tuple2#(SqrtTFx,Bool)) sqrtfxm <- mkFixedPointSquareRooter(1);
   FIFOF#(Tuple4#(SqrtT,SqrtT,SqrtTFx,SqrtTFx)) fCheck <- mkLFIFOF;

   function Action testSqrtPipe(Real n);
      action
         SqrtT ni = fromInteger(trunc(n));
         SqrtT ri = fromInteger(round(sqrt(n)));
         SqrtTFx nfx = fromReal(n);
         SqrtTFx rfx = fromReal(sqrt(n));
         sqrtm.request.put(ni);
         sqrtfxm.request.put(nfx);
         fCheck.enq(tuple4(ni,ri,nfx,rfx));
      endaction
   endfunction

   Stmt test =
   seq
      testSqrtPipe(1);
      testSqrtPipe(2);
      testSqrtPipe(4);
      testSqrtPipe(10);
      //testSqrtPipe(123456789);
      testSqrtPipe('h2000000);
      testSqrtPipe('h3d80000);
      testSqrtPipe('h3ef9db0);
      testSqrtPipe('h3ffffff);
      testSqrtPipe('h3ffc000);
      testSqrtPipe('hfffffffe_00000000);
      testSqrtPipe('hf0000000_00000000);
      testSqrtPipe('hffff0000_00000000);
      testSqrtPipe('hfffe0000);

      testSqrtPipe(536870912.9375);
      testSqrtPipe(1073741824.96875);
      testSqrtPipe(0.5);
      testSqrtPipe(0.25);

      while (fCheck.notEmpty)
         noAction;
   endseq;

   rule check;
      match {.n,.r,.nfx,.rfx} <- toGet(fCheck).get;
      match {.rr, .inexact} <- sqrtm.response.get;
      match {.rrfx, .inexactfx} <- sqrtfxm.response.get;

      if (r != rr) begin
         $display("sqrt(%d) = %d (expected %d)", n, rr, r);
      end
      else begin
         $display("sqrt(%d) = %d", n, rr);
      end

      if (rfx != rrfx) begin
         $display("sqrtfx(", fshow(nfx), ") = ", fshow(rrfx), " (expected ", fshow(rfx) ,")");
      end
      else begin
         $display("sqrtfx(", fshow(nfx), ") = ", fshow(rrfx));
      end
   endrule

   mkAutoFSM(test);

endmodule

endpackage
