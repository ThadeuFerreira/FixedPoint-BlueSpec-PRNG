package WellPRNG;

import Vector::*;
import StmtFSM::*;

// My packages.
import RandomNumberGenerator::*;


//////// CONSTANT DEFINITION ///////////////////////////////
typedef  32     W;
typedef  16 	R;
typedef  0 	P;
typedef  13	M1;
typedef  9 	M2;
typedef  5 	M3;

// Standard w-bit word.
typedef Bit#(W) Int32WORD;

typedef Vector#(R, Int32WORD) WSTATE;


typedef struct {
	WSTATE state;
	Bit#(32) state_i;
	Bit#(32) z0;
	Bit#(32) z1;
	Bit#(32) z2;
} GlobalPram;

function Int32WORD mat0pos(Int32WORD t, Int32WORD v);
	Int32WORD ret = v^(v>>t);
	return ret;
endfunction: mat0pos

function Int32WORD mat0neg(Int32WORD t, Int32WORD v);
	Int32WORD ret = v^(v<<(-t));
	return ret;
endfunction: mat0neg

function Int32WORD mat3neg(Int32WORD t, Int32WORD v);
	Int32WORD ret = (v<<(-(t)));
	return ret;
endfunction: mat3neg

function Int32WORD mat4neg(Int32WORD t, Bit#(32) b, Int32WORD v);
	Int32WORD ret = v ^ ((v<<(-t)) & b);
	return ret;
endfunction: mat4neg



function GlobalPram  wellRNG512a(WSTATE state, Int32WORD state_i, Int32WORD  z0, Int32WORD  z1, Int32WORD z2);
	GlobalPram ret;
	z0 = state[(state_i+15)&'h0000000f];
	z1 = mat0neg(-16,state[state_i]) ^ mat0neg(-15, state[state_i+13 & 'h0000000f]);
	z2 = mat0pos(11,state[(state_i+9)&'h000000f]);
	state[state_i] = z1 ^ z2;
	state[(state_i+15)&'h000000f] = mat0neg (-2,z0)     ^ mat0neg(-18,z1)    ^ mat3neg(-28,z2) ^ mat4neg(-5,'hda442d24,state[state_i]) ;
	state_i = (state_i+15)&'h0000000f;
	
	ret.z0 = z0;
	ret.z1 = z1;
	ret.z2 = z2;
	ret.state = state;
	ret.state_i = state_i;	
	ret.state = state;
	return ret;
endfunction: wellRNG512a


(* synthesize *)
module mkWellPRNG (IfcRandomNumberGenerator#(Int32WORD, Int32WORD));

   Reg#(Bit#(32)) state_i <- mkRegU;
   Reg#(Bit#(32)) z0 <- mkRegU;
   Reg#(Bit#(32)) z1 <- mkRegU;
   Reg#(Bit#(32)) z2 <- mkRegU;

   //Reg#(WSTATE) state <- mkReg (replicate(0));
   Vector#(16,Reg#(Bit#(32))) state <- replicateM( mkRegU );

   method Action initialize (Int32WORD  s);
	state[0] <=      s + 72852922;
	state[1] <=      s + 41699578;
	state[2] <=      s + 56707026;
	state[3] <=      33717249;
	state[4] <=      18306974;
	state[5] <=      30824004;
	state[6] <=      42901955;
	state[7] <=      80465302;
	state[8] <=      94968136;
	state[9] <=      41480876;
	state[10] <=      57870066;
	state[11] <=      37220400;
	state[12] <=      14597146;
	state[13] <=      1165159;
	state[14] <=      99349121;
	state[15] <=      68083911;	
   endmethod: initialize

   method ActionValue#(Int32WORD ) get () ;

	WSTATE mystate = readVReg(state);
	//$display("! %d %d %d %d %d %d", state[state_i], state_i, z0, z1, z2);
        
	GlobalPram param = wellRNG512a( mystate,  state_i,  z0,   z1,  z2);

	z0 <= param.z0;
	z1 <= param.z1;
	z2 <= param.z2;
	state_i <= param.state_i;
	writeVReg(state, param.state);

	return state[state_i];
   endmethod: get

endmodule: mkWellPRNG

endpackage: WellPRNG
