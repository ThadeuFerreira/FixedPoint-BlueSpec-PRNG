/*
 * Generated by Bluespec Compiler, version 2014.07.A (build 34078, 2014-07-30)
 * 
 * On Tue May  8 22:06:28 -03 2018
 * 
 */

/* Generation options: keep-fires */
#ifndef __mkLogTableFxdP_h__
#define __mkLogTableFxdP_h__

#include "bluesim_types.h"
#include "bs_module.h"
#include "bluesim_primitives.h"
#include "bs_vcd.h"


/* Class declaration for the mkLogTableFxdP module */
class MOD_mkLogTableFxdP : public Module {
 
 /* Clock handles */
 private:
  tClock __clk_handle_0;
 
 /* Clock gate handles */
 public:
  tUInt8 *clk_gate[0];
 
 /* Instantiation parameters */
 public:
 
 /* Module state */
 public:
  MOD_Reg<tUInt32> INST_cycle;
  MOD_Reg<tUInt8> INST_flag;
  MOD_Reg<tUWide> INST_result;
  MOD_Reg<tUWide> INST_x;
 
 /* Constructor */
 public:
  MOD_mkLogTableFxdP(tSimStateHdl simHdl, char const *name, Module *parent);
 
 /* Symbol init methods */
 private:
  void init_symbols_0();
 
 /* Reset signal definitions */
 private:
  tUInt8 PORT_RST_N;
 
 /* Port definitions */
 public:
  tUInt8 PORT_EN_run;
  tUInt8 PORT_EN_get;
  tUWide PORT_run_input_val;
  tUInt8 PORT_RDY_run;
  tUWide PORT_get;
  tUInt8 PORT_RDY_get;
 
 /* Publicly accessible definitions */
 public:
  tUInt8 DEF_WILL_FIRE_get;
  tUInt8 DEF_WILL_FIRE_run;
  tUInt8 DEF_CAN_FIRE_get;
  tUInt8 DEF_CAN_FIRE_run;
 
 /* Local definitions */
 private:
  tUWide DEF__0_CONCAT_IF_run_input_val_BIT_31_THEN_0_ELSE_I_ETC___d73;
  tUWide DEF_get__avValue1;
 
 /* Rules */
 public:
 
 /* Methods */
 public:
  void METH_run(tUWide ARG_run_input_val);
  tUInt8 METH_RDY_run();
  tUWide METH_get();
  tUInt8 METH_RDY_get();
 
 /* Reset routines */
 public:
  void reset_RST_N(tUInt8 ARG_rst_in);
 
 /* Static handles to reset routines */
 public:
 
 /* Pointers to reset fns in parent module for asserting output resets */
 private:
 
 /* Functions for the parent module to register its reset fns */
 public:
 
 /* Functions to set the elaborated clock id */
 public:
  void set_clk_0(char const *s);
 
 /* State dumping routine */
 public:
  void dump_state(unsigned int indent);
 
 /* VCD dumping routines */
 public:
  unsigned int dump_VCD_defs(unsigned int levels);
  void dump_VCD(tVCDDumpType dt, unsigned int levels, MOD_mkLogTableFxdP &backing);
  void vcd_defs(tVCDDumpType dt, MOD_mkLogTableFxdP &backing);
  void vcd_prims(tVCDDumpType dt, MOD_mkLogTableFxdP &backing);
};

#endif /* ifndef __mkLogTableFxdP_h__ */
