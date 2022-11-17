(*
 *
 * File: digitalClone_Group2_1_wk.st
 *
 * IEC 61131-3 Structured Text (ST) code generated for subsystem "digitalClone_Group2_1_wk/Verification comparisons /WinchAngle"
 *
 * Model name                      : digitalClone_Group2_1_wk
 * Model version                   : 2.73
 * Model creator                   : endre
 * Model last modified by          : Tim
 * Model last modified on          : Thu Nov 17 17:26:36 2022
 * Model sample time               : 0s
 * Subsystem name                  : digitalClone_Group2_1_wk/Verification comparisons /WinchAngle
 * Subsystem sample time           : 0.001s
 * Simulink PLC Coder version      : 3.7 (R2022b) 13-May-2022
 * ST code generated on            : Thu Nov 17 17:38:42 2022
 *
 * Target IDE selection            : Beckhoff TwinCAT 3
 * Test Bench included             : No
 *
 *)
FUNCTION_BLOCK WinchAngle
VAR_INPUT
    xCyl: LREAL;
    winchAngleRad: LREAL;
    hZero: LREAL;
    wheelHeight: LREAL;
    totalDistance: LREAL;
    spoolRadius: LREAL;
END_VAR
VAR_OUTPUT
    ropeLength: LREAL;
    height: LREAL;
END_VAR
VAR_TEMP
    rtb_Sqrt: LREAL;
END_VAR
(* Outputs for Atomic SubSystem: '<Root>/WinchAngle' *)
(* Sum: '<S1>/Sum1' *)
rtb_Sqrt := totalDistance - xCyl;
(* Product: '<S1>/Product' *)
ropeLength := winchAngleRad * spoolRadius;
(* Outport: '<Root>/height' incorporates:
 *  Math: '<S1>/Math Function'
 *  Math: '<S1>/Math Function1'
 *  Sqrt: '<S1>/Sqrt'
 *  Sum: '<S1>/Sum'
 *  Sum: '<S1>/Sum2' *)
height := (ropeLength - SQRT((wheelHeight * wheelHeight) + (rtb_Sqrt * rtb_Sqrt))) - hZero;
(* End of Outputs for SubSystem: '<Root>/WinchAngle' *)
END_FUNCTION_BLOCK
