(*
 *
 * File: digitalClone_workingCopy.st
 *
 * IEC 61131-3 Structured Text (ST) code generated for subsystem "digitalClone_workingCopy/Verification comparisons /CylController"
 *
 * Model name                      : digitalClone_workingCopy
 * Model version                   : 2.68
 * Model creator                   : endre
 * Model last modified by          : Tim
 * Model last modified on          : Wed Nov 16 20:55:35 2022
 * Model sample time               : 0.001s
 * Subsystem name                  : digitalClone_workingCopy/Verification comparisons /CylController
 * Subsystem sample time           : 0.001s
 * Simulink PLC Coder version      : 3.7 (R2022b) 13-May-2022
 * ST code generated on            : Thu Nov 17 00:28:45 2022
 *
 * Target IDE selection            : Beckhoff TwinCAT 3
 * Test Bench included             : No
 *
 *)
FUNCTION_BLOCK CylController
VAR_INPUT
    ssMethodType: SINT;
    EnablePFC: BOOL;
    PosRefm: LREAL;
    PosFbm: LREAL;
    propGain: LREAL;
    vRefms: LREAL;
    integralGain: LREAL;
    EnableIntegral: BOOL;
    maxPosError: LREAL;
END_VAR
VAR_OUTPUT
    xCylErrormm: LREAL;
    SetValue: LREAL;
END_VAR
VAR
    c_DiscreteTimeIntegrator_DS: LREAL;
    Delay_DSTATE: ARRAY [0..1] OF LREAL;
END_VAR
VAR_TEMP
    rtb_Reset: LREAL;
    rtb_u_FB: LREAL;
    rtb_Saturation1: LREAL;
END_VAR
CASE ssMethodType OF
    SS_INITIALIZE: 
        (* SystemInitialize for Atomic SubSystem: '<Root>/CylController' *)
        (* InitializeConditions for Delay: '<S1>/Delay' *)
        Delay_DSTATE[0] := 0.0;
        Delay_DSTATE[1] := 0.0;
        (* SystemInitialize for Atomic SubSystem: '<S1>/FB_ClosedLoopControl' *)
        (* InitializeConditions for DiscreteIntegrator: '<S2>/Discrete-Time Integrator' *)
        c_DiscreteTimeIntegrator_DS := 0.0;
        (* End of SystemInitialize for SubSystem: '<S1>/FB_ClosedLoopControl' *)
        (* End of SystemInitialize for SubSystem: '<Root>/CylController' *)
    SS_STEP: 
        (* Outputs for Atomic SubSystem: '<Root>/CylController' *)
        (* Outputs for Atomic SubSystem: '<S1>/FB_ResetIntegralController' *)
        (* MATLAB Function: '<S3>/ResetIntegralController' *)
        (* MATLAB Function 'CylController/FB_ResetIntegralController/ResetIntegralController': '<S4>:1' *)
        (* '<S4>:1:3' if abs(vRef) > 0 || abs(exCyl) > exCylMax *)
        IF ABS(vRefms) > 0.0 THEN 
            ;
            ;
        ELSIF ABS(Delay_DSTATE[0]) > (0.001 * maxPosError) THEN 
            ;
            ;
        ELSE 
            (* Outputs for Atomic SubSystem: '<S1>/FB_ClosedLoopControl' *)
            (* DiscreteIntegrator: '<S2>/Discrete-Time Integrator' *)
            (* '<S4>:1:5' else *)
            (* '<S4>:1:6' Reset = 1; *)
            c_DiscreteTimeIntegrator_DS := 0.0;
            (* End of Outputs for SubSystem: '<S1>/FB_ClosedLoopControl' *)
        END_IF;
        (* End of MATLAB Function: '<S3>/ResetIntegralController' *)
        (* End of Outputs for SubSystem: '<S1>/FB_ResetIntegralController' *)
        
        (* Outputs for Atomic SubSystem: '<S1>/FB_ClosedLoopControl' *)
        (* DiscreteIntegrator: '<S2>/Discrete-Time Integrator' *)
        IF c_DiscreteTimeIntegrator_DS >= 1.0 THEN 
            c_DiscreteTimeIntegrator_DS := 1.0;
        ELSIF c_DiscreteTimeIntegrator_DS <= -1.0 THEN 
            c_DiscreteTimeIntegrator_DS := -1.0;
        END_IF;
        (* Sum: '<S2>/Sum1' *)
        rtb_Reset := PosRefm - PosFbm;
        (* Switch: '<S2>/Switch' incorporates:
         *  Constant: '<S2>/Constant'
         *  DiscreteIntegrator: '<S2>/Discrete-Time Integrator' *)
        IF EnableIntegral THEN 
            rtb_u_FB := c_DiscreteTimeIntegrator_DS;
        ELSE 
            rtb_u_FB := 0.0;
        END_IF;
        (* End of Switch: '<S2>/Switch' *)
        
        (* Sum: '<S2>/Sum5' incorporates:
         *  Product: '<S2>/Product' *)
        rtb_u_FB := (propGain * rtb_Reset) + rtb_u_FB;
        (* Saturate: '<S2>/Saturation1' *)
        IF rtb_u_FB > 1.0 THEN 
            rtb_Saturation1 := 1.0;
        ELSIF rtb_u_FB >= -1.0 THEN 
            rtb_Saturation1 := rtb_u_FB;
        ELSE 
            rtb_Saturation1 := -1.0;
        END_IF;
        (* End of Saturate: '<S2>/Saturation1' *)
        
        (* Switch: '<S2>/Switch1' *)
        IF EnablePFC THEN 
            (* Outport: '<Root>/Set Value' *)
            SetValue := rtb_Saturation1;
        ELSE 
            (* Outport: '<Root>/Set Value' incorporates:
             *  Constant: '<S2>/Constant1' *)
            SetValue := 0.0;
        END_IF;
        (* End of Switch: '<S2>/Switch1' *)
        
        (* Update for DiscreteIntegrator: '<S2>/Discrete-Time Integrator' incorporates:
         *  Product: '<S2>/Divide'
         *  Product: '<S2>/Product2'
         *  Sum: '<S2>/Sum2'
         *  Sum: '<S2>/Sum3' *)
        c_DiscreteTimeIntegrator_DS := (((((rtb_Saturation1 - rtb_u_FB) / propGain) + rtb_Reset) * integralGain) * 0.001) + c_DiscreteTimeIntegrator_DS;
        IF c_DiscreteTimeIntegrator_DS >= 1.0 THEN 
            c_DiscreteTimeIntegrator_DS := 1.0;
        ELSIF c_DiscreteTimeIntegrator_DS <= -1.0 THEN 
            c_DiscreteTimeIntegrator_DS := -1.0;
        END_IF;
        (* End of Update for DiscreteIntegrator: '<S2>/Discrete-Time Integrator' *)
        (* End of Outputs for SubSystem: '<S1>/FB_ClosedLoopControl' *)
        
        (* Update for Delay: '<S1>/Delay' *)
        Delay_DSTATE[0] := Delay_DSTATE[1];
        Delay_DSTATE[1] := rtb_Reset;
        (* Outport: '<Root>/xCylError [mm]' incorporates:
         *  Gain: '<S1>/Gain' *)
        xCylErrormm := 1000.0 * rtb_Reset;
        (* End of Outputs for SubSystem: '<Root>/CylController' *)
END_CASE;
END_FUNCTION_BLOCK
VAR_GLOBAL CONSTANT
    SS_INITIALIZE: SINT := 0;
    SS_STEP: SINT := 1;
END_VAR