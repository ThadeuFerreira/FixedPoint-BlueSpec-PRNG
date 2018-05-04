package Tb;
import FIFO::*;
import GetPut::*;
import ClientServer::*;
// A struct representing a 2-dimensional ’coordinate’
typedef struct { int x; int y; } Coord
deriving (Bits);
// An interface, and a module with that interface
module mkTransformer (Server#(Coord, Coord));
FIFO#(Coord) fi <- mkFIFO;
FIFO#(Coord) fo <- mkFIFO;
Coord delta1 = Coord { x: 100, y: 100 };
let   delta2 = Coord { x: 100,  y: 100 };
rule transform;
Coord c = fi.first();  fi.deq();
c.x = c.x + delta1.x + delta2.x;
c.y = c.y + delta1.y + delta2.y;
fo.enq (c);
endrule
interface request = toPut (fi);
interface response = toGet (fo);
endmodule: mkTransformer
// ----------------------------------------------------------------
(* synthesize *)
module mkTb (Empty);
Reg#(int) cycle <- mkReg (0);
Reg#(int) rx <- mkReg (0);
Reg#(int) ry <- mkReg (0);
Server#(Coord, Coord) s <- mkTransformer;
rule count_cycles;
cycle <= cycle + 1;
if (cycle > 15) $finish(0);
endrule
rule source(cycle<8);
let c = Coord { x: rx,  y: ry };
s.request.put (c);
rx <= rx + 1;
ry <= ry + 1;
$display ("%0d: rule source, sending Coord { x: %0d, y: %0d }", cycle, rx, ry);
endrule
rule sink;
let c <- s.response.get ();
$display ("%0d: rule sink, returned value is Coord { x: %0d, y: %0d }", cycle, c.x, c.y);
endrule
endmodule: mkTb
endpackage: Tb