(*
 *
 * File: digitalClone_Group2_1_wk.st
 *
 * IEC 61131-3 Structured Text (ST) code generated for subsystem "digitalClone_Group2_1_wk/Verification comparisons /cylControl/FeedForward"
 *
 * Model name                      : digitalClone_Group2_1_wk
 * Model version                   : 2.78
 * Model creator                   : endre
 * Model last modified by          : Tim
 * Model last modified on          : Fri Nov 18 11:46:34 2022
 * Model sample time               : 0s
 * Subsystem name                  : digitalClone_Group2_1_wk/Verification comparisons /cylControl/FeedForward
 * Subsystem sample time           : 0.001s
 * Simulink PLC Coder version      : 3.7 (R2022b) 13-May-2022
 * ST code generated on            : Fri Nov 18 12:40:22 2022
 *
 * Target IDE selection            : Beckhoff TwinCAT 3
 * Test Bench included             : No
 *
 *)
FUNCTION_BLOCK FeedForward
VAR_INPUT
    Enable: BOOL;
    vRef_ms: LREAL;
    maxFlow_lmin: LREAL;
    cylOpeningForward: LREAL;
    cylOpeningBackward: LREAL;
END_VAR
VAR_OUTPUT
    FeedfowardOutput: LREAL;
END_VAR
VAR_TEMP
    rtb_Switch: LREAL;
END_VAR
(* Outputs for Atomic SubSystem: '<Root>/FeedForward' *)
(* Switch: '<S1>/Switch1' *)
IF Enable THEN 
    (* Switch: '<S1>/Switch' incorporates:
     *  Constant: '<S1>/Constant'
     *  Product: '<S1>/Product1'
     *  Product: '<S1>/Product2'
     *  RelationalOperator: '<S1>/Relational Operator' *)
    IF vRef_ms >= 0.0 THEN 
        rtb_Switch := cylOpeningForward * vRef_ms;
    ELSE 
        rtb_Switch := vRef_ms * cylOpeningBackward;
    END_IF;
    (* End of Switch: '<S1>/Switch' *)
    
    (* Outport: '<Root>/FeedfowardOutput' incorporates:
     *  Constant: '<S1>/Constant2'
     *  Product: '<S1>/Divide'
     *  Product: '<S1>/Product' *)
    FeedfowardOutput := (60000.0 * rtb_Switch) / maxFlow_lmin;
ELSE 
    (* Outport: '<Root>/FeedfowardOutput' incorporates:
     *  Constant: '<S1>/Constant1' *)
    FeedfowardOutput := 0.0;
END_IF;
(* End of Switch: '<S1>/Switch1' *)
(* End of Outputs for SubSystem: '<Root>/FeedForward' *)
END_FUNCTION_BLOCK
