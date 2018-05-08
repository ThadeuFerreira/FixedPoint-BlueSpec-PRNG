/*
 * Generated by Bluespec Compiler, version 2014.07.A (build 34078, 2014-07-30)
 * 
 * On Tue May  8 13:45:03 -03 2018
 * 
 */

/* Generation options: keep-fires */
#ifndef __mkBoxMullerTb_h__
#define __mkBoxMullerTb_h__

#include "bluesim_types.h"
#include "bs_module.h"
#include "bluesim_primitives.h"
#include "bs_vcd.h"
#include "mkBoxMuller.h"
#include "mkLogTableFxdP.h"


/* Class declaration for the mkBoxMullerTb module */
class MOD_mkBoxMullerTb : public Module {
 
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
  MOD_Reg<tUInt64> INST__unnamed_;
  MOD_Wire<tUInt8> INST_abort;
  MOD_mkBoxMuller INST_boxmuller;
  MOD_Reg<tUInt32> INST_cont;
  MOD_Reg<tUInt64> INST_i;
  MOD_mkLogTableFxdP INST_mLUT;
  MOD_Reg<tUInt32> INST_n;
  MOD_Reg<tUInt8> INST_running;
  MOD_Reg<tUInt8> INST_start_reg;
  MOD_Reg<tUInt8> INST_start_reg_1;
  MOD_Wire<tUInt8> INST_start_reg_2;
  MOD_Wire<tUInt8> INST_start_wire;
  MOD_Reg<tUInt8> INST_state_can_overlap;
  MOD_Reg<tUInt8> INST_state_fired;
  MOD_Wire<tUInt8> INST_state_fired_1;
  MOD_ConfigReg<tUInt8> INST_state_mkFSMstate;
  MOD_Wire<tUInt8> INST_state_overlap_pw;
  MOD_Wire<tUInt8> INST_state_set_pw;
  MOD_Reg<tUWide> INST_tup;
  MOD_Reg<tUWide> INST_uniform_rand_num;
 
 /* Constructor */
 public:
  MOD_mkBoxMullerTb(tSimStateHdl simHdl, char const *name, Module *parent);
 
 /* Symbol init methods */
 private:
  void init_symbols_0();
 
 /* Reset signal definitions */
 private:
  tUInt8 PORT_RST_N;
 
 /* Port definitions */
 public:
 
 /* Publicly accessible definitions */
 public:
  tUInt8 DEF_WILL_FIRE___me_check_16;
  tUInt8 DEF_CAN_FIRE___me_check_16;
  tUInt8 DEF_WILL_FIRE___me_check_15;
  tUInt8 DEF_CAN_FIRE___me_check_15;
  tUInt8 DEF_WILL_FIRE___me_check_14;
  tUInt8 DEF_CAN_FIRE___me_check_14;
  tUInt8 DEF_WILL_FIRE___me_check_13;
  tUInt8 DEF_CAN_FIRE___me_check_13;
  tUInt8 DEF_WILL_FIRE___me_check_12;
  tUInt8 DEF_CAN_FIRE___me_check_12;
  tUInt8 DEF_WILL_FIRE___me_check_11;
  tUInt8 DEF_CAN_FIRE___me_check_11;
  tUInt8 DEF_WILL_FIRE___me_check_10;
  tUInt8 DEF_CAN_FIRE___me_check_10;
  tUInt8 DEF_WILL_FIRE___me_check_9;
  tUInt8 DEF_CAN_FIRE___me_check_9;
  tUInt8 DEF_WILL_FIRE___me_check_8;
  tUInt8 DEF_CAN_FIRE___me_check_8;
  tUInt8 DEF_WILL_FIRE___me_check_7;
  tUInt8 DEF_CAN_FIRE___me_check_7;
  tUInt8 DEF_WILL_FIRE___me_check_6;
  tUInt8 DEF_CAN_FIRE___me_check_6;
  tUInt8 DEF_WILL_FIRE___me_check_5;
  tUInt8 DEF_CAN_FIRE___me_check_5;
  tUInt8 DEF_WILL_FIRE_RL_auto_finish;
  tUInt8 DEF_CAN_FIRE_RL_auto_finish;
  tUInt8 DEF_WILL_FIRE_RL_auto_start;
  tUInt8 DEF_CAN_FIRE_RL_auto_start;
  tUInt8 DEF_WILL_FIRE_RL_fsm_start;
  tUInt8 DEF_CAN_FIRE_RL_fsm_start;
  tUInt8 DEF_WILL_FIRE_RL_idle_l69c9_1;
  tUInt8 DEF_CAN_FIRE_RL_idle_l69c9_1;
  tUInt8 DEF_WILL_FIRE_RL_idle_l69c9;
  tUInt8 DEF_CAN_FIRE_RL_idle_l69c9;
  tUInt8 DEF_WILL_FIRE_RL_action_l112c13;
  tUInt8 DEF_CAN_FIRE_RL_action_l112c13;
  tUInt8 DEF_WILL_FIRE_RL_action_l105c13;
  tUInt8 DEF_CAN_FIRE_RL_action_l105c13;
  tUInt8 DEF_WILL_FIRE_RL_action_l103c17;
  tUInt8 DEF_CAN_FIRE_RL_action_l103c17;
  tUInt8 DEF_WILL_FIRE_RL_action_l102c17;
  tUInt8 DEF_CAN_FIRE_RL_action_l102c17;
  tUInt8 DEF_WILL_FIRE_RL_action_l97c13;
  tUInt8 DEF_CAN_FIRE_RL_action_l97c13;
  tUInt8 DEF_WILL_FIRE_RL_action_l95c13;
  tUInt8 DEF_CAN_FIRE_RL_action_l95c13;
  tUInt8 DEF_WILL_FIRE_RL_action_l91c13;
  tUInt8 DEF_CAN_FIRE_RL_action_l91c13;
  tUInt8 DEF_WILL_FIRE_RL_action_l89c22;
  tUInt8 DEF_CAN_FIRE_RL_action_l89c22;
  tUInt8 DEF_WILL_FIRE_RL_action_l88c22;
  tUInt8 DEF_CAN_FIRE_RL_action_l88c22;
  tUInt8 DEF_WILL_FIRE_RL_action_l83c12;
  tUInt8 DEF_CAN_FIRE_RL_action_l83c12;
  tUInt8 DEF_WILL_FIRE_RL_action_l79c9;
  tUInt8 DEF_CAN_FIRE_RL_action_l79c9;
  tUInt8 DEF_WILL_FIRE_RL_action_l75c9;
  tUInt8 DEF_CAN_FIRE_RL_action_l75c9;
  tUInt8 DEF_WILL_FIRE_RL_action_l71c9;
  tUInt8 DEF_CAN_FIRE_RL_action_l71c9;
  tUInt8 DEF_WILL_FIRE_RL_restart;
  tUInt8 DEF_CAN_FIRE_RL_restart;
  tUInt8 DEF_WILL_FIRE_RL_state_every;
  tUInt8 DEF_CAN_FIRE_RL_state_every;
  tUInt8 DEF_WILL_FIRE_RL_state_fired__dreg_update;
  tUInt8 DEF_CAN_FIRE_RL_state_fired__dreg_update;
  tUInt8 DEF_WILL_FIRE_RL_state_handle_abort;
  tUInt8 DEF_CAN_FIRE_RL_state_handle_abort;
  tUInt8 DEF_WILL_FIRE_RL_start_reg__dreg_update;
  tUInt8 DEF_CAN_FIRE_RL_start_reg__dreg_update;
  tUInt64 DEF_b__h10297;
 
 /* Local definitions */
 private:
  tUInt64 DEF_v__h35084;
  tUWide DEF_ab__h34742;
  tUWide DEF_x__h42813;
  tUWide DEF_ab__h37025;
  tUWide DEF_x__h42165;
  tUInt32 DEF_in2_i__h29123;
  tUWide DEF_IF_cont_8_BIT_31_9_THEN_NEG_cont_8_CONCAT_0_0__ETC___d66;
  tUWide DEF_IF_cont_8_BIT_31_9_THEN_NEG_cont_8_CONCAT_0_0__ETC___d63;
  tUWide DEF__10_MUL_10_MUL_10_MUL_10_MUL_10_MUL_10_MUL_10_M_ETC___d323;
  tUWide DEF__10_MUL_10_MUL_10_MUL_10_MUL_10_MUL_10_MUL_10_M_ETC___d322;
  tUWide DEF__10_MUL_10_MUL_10_MUL_10_MUL_10_MUL_10_MUL_10_M_ETC___d314;
  tUWide DEF__10_MUL_10_MUL_10_MUL_10_MUL_10_MUL_10_MUL_10_M_ETC___d313;
  tUWide DEF__10_MUL_10_MUL_10_MUL_10_MUL_10_MUL_10_MUL_10_M_ETC___d305;
  tUWide DEF__10_MUL_10_MUL_10_MUL_10_MUL_10_MUL_10_MUL_10_M_ETC___d304;
  tUWide DEF__10_MUL_10_MUL_10_MUL_10_MUL_10_MUL_10_MUL_0_CO_ETC___d296;
  tUWide DEF__10_MUL_10_MUL_10_MUL_10_MUL_10_MUL_10_MUL_0_CO_ETC___d295;
  tUWide DEF__10_MUL_10_MUL_10_MUL_10_MUL_10_MUL_0_CONCAT_0__ETC___d287;
  tUWide DEF__10_MUL_10_MUL_10_MUL_10_MUL_10_MUL_0_CONCAT_0__ETC___d286;
  tUWide DEF__10_MUL_10_MUL_10_MUL_10_MUL_0_CONCAT_0_CONCAT__ETC___d278;
  tUWide DEF__10_MUL_10_MUL_10_MUL_10_MUL_0_CONCAT_0_CONCAT__ETC___d277;
  tUWide DEF__10_MUL_10_MUL_10_MUL_0_CONCAT_0_CONCAT_IF_SEXT_ETC___d269;
  tUWide DEF__10_MUL_10_MUL_10_MUL_0_CONCAT_0_CONCAT_IF_SEXT_ETC___d268;
  tUWide DEF__10_MUL_10_MUL_0_CONCAT_0_CONCAT_IF_SEXT_mLUT_g_ETC___d260;
  tUWide DEF__10_MUL_10_MUL_0_CONCAT_0_CONCAT_IF_SEXT_mLUT_g_ETC___d259;
  tUWide DEF__10_MUL_0_CONCAT_0_CONCAT_IF_SEXT_mLUT_get_24_B_ETC___d251;
  tUWide DEF__10_MUL_0_CONCAT_0_CONCAT_IF_SEXT_mLUT_get_24_B_ETC___d250;
  tUWide DEF__10_MUL_10_MUL_10_MUL_10_MUL_10_MUL_10_MUL_10_M_ETC___d220;
  tUWide DEF__10_MUL_10_MUL_10_MUL_10_MUL_10_MUL_10_MUL_10_M_ETC___d219;
  tUWide DEF__10_MUL_10_MUL_10_MUL_10_MUL_10_MUL_10_MUL_10_M_ETC___d211;
  tUWide DEF__10_MUL_10_MUL_10_MUL_10_MUL_10_MUL_10_MUL_10_M_ETC___d210;
  tUWide DEF__10_MUL_10_MUL_10_MUL_10_MUL_10_MUL_10_MUL_10_M_ETC___d202;
  tUWide DEF__10_MUL_10_MUL_10_MUL_10_MUL_10_MUL_10_MUL_10_M_ETC___d201;
  tUWide DEF__10_MUL_10_MUL_10_MUL_10_MUL_10_MUL_10_MUL_0_CO_ETC___d193;
  tUWide DEF__10_MUL_10_MUL_10_MUL_10_MUL_10_MUL_10_MUL_0_CO_ETC___d192;
  tUWide DEF__10_MUL_10_MUL_10_MUL_10_MUL_10_MUL_0_CONCAT_0__ETC___d184;
  tUWide DEF__10_MUL_10_MUL_10_MUL_10_MUL_10_MUL_0_CONCAT_0__ETC___d183;
  tUWide DEF__10_MUL_10_MUL_10_MUL_10_MUL_0_CONCAT_0_CONCAT__ETC___d175;
  tUWide DEF__10_MUL_10_MUL_10_MUL_10_MUL_0_CONCAT_0_CONCAT__ETC___d174;
  tUWide DEF__10_MUL_10_MUL_10_MUL_0_CONCAT_0_CONCAT_IF_SEXT_ETC___d166;
  tUWide DEF__10_MUL_10_MUL_10_MUL_0_CONCAT_0_CONCAT_IF_SEXT_ETC___d165;
  tUWide DEF__10_MUL_10_MUL_0_CONCAT_0_CONCAT_IF_SEXT_unifor_ETC___d157;
  tUWide DEF__10_MUL_10_MUL_0_CONCAT_0_CONCAT_IF_SEXT_unifor_ETC___d156;
  tUWide DEF__10_MUL_0_CONCAT_0_CONCAT_IF_SEXT_uniform_rand__ETC___d148;
  tUWide DEF__10_MUL_0_CONCAT_0_CONCAT_IF_SEXT_uniform_rand__ETC___d147;
  tUWide DEF_IF_NOT_IF_cont_8_BIT_31_9_THEN_NEG_cont_8_CONC_ETC___d78;
  tUWide DEF__0_CONCAT_IF_SEXT_mLUT_get_24_BITS_64_TO_32_25__ETC___d318;
  tUWide DEF__0_CONCAT_IF_SEXT_mLUT_get_24_BITS_64_TO_32_25__ETC___d309;
  tUWide DEF__0_CONCAT_IF_SEXT_mLUT_get_24_BITS_64_TO_32_25__ETC___d300;
  tUWide DEF__0_CONCAT_IF_SEXT_mLUT_get_24_BITS_64_TO_32_25__ETC___d291;
  tUWide DEF__0_CONCAT_IF_SEXT_mLUT_get_24_BITS_64_TO_32_25__ETC___d282;
  tUWide DEF__0_CONCAT_IF_SEXT_mLUT_get_24_BITS_64_TO_32_25__ETC___d273;
  tUWide DEF__0_CONCAT_IF_SEXT_mLUT_get_24_BITS_64_TO_32_25__ETC___d264;
  tUWide DEF__0_CONCAT_IF_SEXT_mLUT_get_24_BITS_64_TO_32_25__ETC___d255;
  tUWide DEF__0_CONCAT_IF_SEXT_mLUT_get_24_BITS_64_TO_32_25__ETC___d247;
  tUWide DEF__0_CONCAT_IF_SEXT_uniform_rand_num_17_BITS_64_T_ETC___d215;
  tUWide DEF__0_CONCAT_IF_SEXT_uniform_rand_num_17_BITS_64_T_ETC___d206;
  tUWide DEF__0_CONCAT_IF_SEXT_uniform_rand_num_17_BITS_64_T_ETC___d197;
  tUWide DEF__0_CONCAT_IF_SEXT_uniform_rand_num_17_BITS_64_T_ETC___d188;
  tUWide DEF__0_CONCAT_IF_SEXT_uniform_rand_num_17_BITS_64_T_ETC___d179;
  tUWide DEF__0_CONCAT_IF_SEXT_uniform_rand_num_17_BITS_64_T_ETC___d170;
  tUWide DEF__0_CONCAT_IF_SEXT_uniform_rand_num_17_BITS_64_T_ETC___d161;
  tUWide DEF__0_CONCAT_IF_SEXT_uniform_rand_num_17_BITS_64_T_ETC___d152;
  tUWide DEF__0_CONCAT_IF_SEXT_uniform_rand_num_17_BITS_64_T_ETC___d144;
  tUWide DEF__0_CONCAT_IF_SEXT_mLUT_get_24_BITS_64_TO_32_25__ETC___d244;
  tUWide DEF__0_CONCAT_IF_SEXT_uniform_rand_num_17_BITS_64_T_ETC___d141;
  tUWide DEF__0_CONCAT_0_CONCAT_IF_SEXT_mLUT_get_24_BITS_64__ETC___d324;
  tUWide DEF__0_CONCAT_0_CONCAT_IF_SEXT_mLUT_get_24_BITS_64__ETC___d315;
  tUWide DEF__0_CONCAT_0_CONCAT_IF_SEXT_mLUT_get_24_BITS_64__ETC___d306;
  tUWide DEF__0_CONCAT_0_CONCAT_IF_SEXT_mLUT_get_24_BITS_64__ETC___d297;
  tUWide DEF__0_CONCAT_0_CONCAT_IF_SEXT_mLUT_get_24_BITS_64__ETC___d288;
  tUWide DEF__0_CONCAT_0_CONCAT_IF_SEXT_mLUT_get_24_BITS_64__ETC___d279;
  tUWide DEF__0_CONCAT_0_CONCAT_IF_SEXT_mLUT_get_24_BITS_64__ETC___d270;
  tUWide DEF__0_CONCAT_0_CONCAT_IF_SEXT_mLUT_get_24_BITS_64__ETC___d261;
  tUWide DEF__0_CONCAT_0_CONCAT_IF_SEXT_mLUT_get_24_BITS_64__ETC___d252;
  tUWide DEF__0_CONCAT_0_CONCAT_IF_SEXT_uniform_rand_num_17__ETC___d221;
  tUWide DEF__0_CONCAT_0_CONCAT_IF_SEXT_uniform_rand_num_17__ETC___d212;
  tUWide DEF__0_CONCAT_0_CONCAT_IF_SEXT_uniform_rand_num_17__ETC___d203;
  tUWide DEF__0_CONCAT_0_CONCAT_IF_SEXT_uniform_rand_num_17__ETC___d194;
  tUWide DEF__0_CONCAT_0_CONCAT_IF_SEXT_uniform_rand_num_17__ETC___d185;
  tUWide DEF__0_CONCAT_0_CONCAT_IF_SEXT_uniform_rand_num_17__ETC___d176;
  tUWide DEF__0_CONCAT_0_CONCAT_IF_SEXT_uniform_rand_num_17__ETC___d167;
  tUWide DEF__0_CONCAT_0_CONCAT_IF_SEXT_uniform_rand_num_17__ETC___d158;
  tUWide DEF__0_CONCAT_0_CONCAT_IF_SEXT_uniform_rand_num_17__ETC___d149;
  tUWide DEF_IF_cont_8_BIT_31_9_THEN_NEG_cont_8_CONCAT_0_0__ETC___d75;
  tUWide DEF_y__h45064;
  tUWide DEF_y__h44973;
  tUWide DEF_y__h44882;
  tUWide DEF_y__h44791;
  tUWide DEF_y__h44700;
  tUWide DEF_y__h44609;
  tUWide DEF_y__h44518;
  tUWide DEF_y__h44427;
  tUWide DEF_digit__h44208;
  tUWide DEF_y__h43908;
  tUWide DEF_y__h43817;
  tUWide DEF_y__h43726;
  tUWide DEF_y__h43635;
  tUWide DEF_y__h43544;
  tUWide DEF_y__h43453;
  tUWide DEF_y__h43362;
  tUWide DEF_y__h43271;
  tUWide DEF_digit__h43052;
  tUWide DEF__0_CONCAT_IF_SEXT_mLUT_get_24_BITS_64_TO_32_25__ETC___d243;
  tUWide DEF__0_CONCAT_IF_SEXT_uniform_rand_num_17_BITS_64_T_ETC___d140;
  tUWide DEF_tx__h45003;
  tUWide DEF_tx__h44912;
  tUWide DEF_tx__h44821;
  tUWide DEF_tx__h44730;
  tUWide DEF_tx__h44639;
  tUWide DEF_tx__h44548;
  tUWide DEF_tx__h44457;
  tUWide DEF_tx__h44366;
  tUWide DEF_tx__h44275;
  tUWide DEF_tx__h43847;
  tUWide DEF_tx__h43756;
  tUWide DEF_tx__h43665;
  tUWide DEF_tx__h43574;
  tUWide DEF_tx__h43483;
  tUWide DEF_tx__h43392;
  tUWide DEF_tx__h43301;
  tUWide DEF_tx__h43210;
  tUWide DEF_tx__h43119;
  tUWide DEF__0_CONCAT_IF_IF_cont_8_BIT_31_9_THEN_NEG_cont_8_ETC___d74;
  tUWide DEF_digit__h44914;
  tUWide DEF_digit__h44823;
  tUWide DEF_digit__h44732;
  tUWide DEF_digit__h44641;
  tUWide DEF_digit__h44550;
  tUWide DEF_digit__h44459;
  tUWide DEF_digit__h44368;
  tUWide DEF_digit__h44277;
  tUWide DEF_digit__h43758;
  tUWide DEF_digit__h43667;
  tUWide DEF_digit__h43576;
  tUWide DEF_digit__h43485;
  tUWide DEF_digit__h43394;
  tUWide DEF_digit__h43303;
  tUWide DEF_digit__h43212;
  tUWide DEF_digit__h43121;
  tUWide DEF_digit__h45005;
  tUWide DEF_digit__h43849;
  tUWide DEF__0_CONCAT_tup_12_BITS_127_TO_96_13___d114;
 
 /* Rules */
 public:
  void RL_start_reg__dreg_update();
  void RL_state_handle_abort();
  void RL_state_fired__dreg_update();
  void RL_state_every();
  void RL_restart();
  void RL_action_l71c9();
  void RL_action_l75c9();
  void RL_action_l79c9();
  void RL_action_l83c12();
  void RL_action_l88c22();
  void RL_action_l89c22();
  void RL_action_l91c13();
  void RL_action_l95c13();
  void RL_action_l97c13();
  void RL_action_l102c17();
  void RL_action_l103c17();
  void RL_action_l105c13();
  void RL_action_l112c13();
  void RL_idle_l69c9();
  void RL_idle_l69c9_1();
  void RL_fsm_start();
  void RL_auto_start();
  void RL_auto_finish();
  void __me_check_5();
  void __me_check_6();
  void __me_check_7();
  void __me_check_8();
  void __me_check_9();
  void __me_check_10();
  void __me_check_11();
  void __me_check_12();
  void __me_check_13();
  void __me_check_14();
  void __me_check_15();
  void __me_check_16();
 
 /* Methods */
 public:
 
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
  void dump_VCD(tVCDDumpType dt, unsigned int levels, MOD_mkBoxMullerTb &backing);
  void vcd_defs(tVCDDumpType dt, MOD_mkBoxMullerTb &backing);
  void vcd_prims(tVCDDumpType dt, MOD_mkBoxMullerTb &backing);
  void vcd_submodules(tVCDDumpType dt, unsigned int levels, MOD_mkBoxMullerTb &backing);
};

#endif /* ifndef __mkBoxMullerTb_h__ */
