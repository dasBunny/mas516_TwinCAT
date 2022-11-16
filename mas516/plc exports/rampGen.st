(*
 *
 * File: digitalClone_workingCopy.st
 *
 * IEC 61131-3 Structured Text (ST) code generated for subsystem "digitalClone_workingCopy/Verification comparisons /Subsystem"
 *
 * Model name                      : digitalClone_workingCopy
 * Model version                   : 2.68
 * Model creator                   : endre
 * Model last modified by          : Tim
 * Model last modified on          : Wed Nov 16 20:55:35 2022
 * Model sample time               : 0.001s
 * Subsystem name                  : digitalClone_workingCopy/Verification comparisons /Subsystem
 * Subsystem sample time           : 0.001s
 * Simulink PLC Coder version      : 3.7 (R2022b) 13-May-2022
 * ST code generated on            : Wed Nov 16 21:48:29 2022
 *
 * Target IDE selection            : Beckhoff TwinCAT 3
 * Test Bench included             : No
 *
 *)
FUNCTION_BLOCK Subsystem
VAR_INPUT
    ssMethodType: SINT;
    Enable: BOOL;
    x0m: LREAL;
    v0ms: LREAL;
    Position_SPm: LREAL;
    Velocity_SPms: LREAL;
    t0s: LREAL;
    tRamps: LREAL;
    tHoldPoss: LREAL;
    StartAuto: BOOL;
    StopAuto: BOOL;
END_VAR
VAR_OUTPUT
    PosRef: LREAL;
    VelRef: LREAL;
END_VAR
VAR
    c_DiscreteTimeIntegrator_DS: LREAL;
END_VAR
VAR_TEMP
    Error: DINT;
    tHold: LREAL;
    x1: LREAL;
    x4: LREAL;
    rtb_Time: LREAL;
    rtb_Saturation3: LREAL;
    a_tmp: LREAL;
    a_tmp_tmp: LREAL;
    a_tmp_0: LREAL;
    a_tmp_tmp_0: LREAL;
    a_tmp_tmp_1: LREAL;
    a_tmp_tmp_2: LREAL;
    x1_tmp: LREAL;
    x4_tmp: LREAL;
END_VAR
CASE ssMethodType OF
    SS_INITIALIZE: 
        (* SystemInitialize for Atomic SubSystem: '<Root>/Subsystem' *)
        (* InitializeConditions for DiscreteIntegrator: '<S2>/Discrete-Time Integrator' *)
        c_DiscreteTimeIntegrator_DS := 0.0;
        (* End of SystemInitialize for SubSystem: '<Root>/Subsystem' *)
    SS_STEP: 
        (* Outputs for Atomic SubSystem: '<Root>/Subsystem' *)
        (* MATLAB Function: '<S2>/MATLAB Function' incorporates:
         *  DiscreteIntegrator: '<S2>/Discrete-Time Integrator' *)
        (* MATLAB Function 'Subsystem/MotionReferenceTime/MATLAB Function': '<S4>:1' *)
        (* '<S4>:1:3' if StartClock == 1 && ~StopClock *)
        IF StartAuto AND ( NOT StopAuto) THEN 
            (* '<S4>:1:4' Time = Clock; *)
            rtb_Time := c_DiscreteTimeIntegrator_DS;
        ELSE 
            (* '<S4>:1:5' else *)
            (* '<S4>:1:6' Time = 0.0; *)
            rtb_Time := 0.0;
        END_IF;
        (* End of MATLAB Function: '<S2>/MATLAB Function' *)
        
        (* Outputs for Atomic SubSystem: '<S1>/RampMotionProfileGenerator' *)
        (* Saturate: '<S3>/Saturation3' *)
        IF Position_SPm > 0.5 THEN 
            rtb_Saturation3 := 0.5;
        ELSIF Position_SPm >= 0.0 THEN 
            rtb_Saturation3 := Position_SPm;
        ELSE 
            rtb_Saturation3 := 0.0;
        END_IF;
        (* End of Saturate: '<S3>/Saturation3' *)
        
        (* Saturate: '<S3>/Saturation2' *)
        IF Velocity_SPms > 0.12 THEN 
            PosRef := 0.12;
        ELSIF Velocity_SPms >= 0.0 THEN 
            PosRef := Velocity_SPms;
        ELSE 
            PosRef := 0.0;
        END_IF;
        (* End of Saturate: '<S3>/Saturation2' *)
        
        (* MATLAB Function: '<S3>/RampSignal' *)
        (* MATLAB Function 'Subsystem/RampMotionProfileGenerator/RampSignal': '<S5>:1' *)
        (* '<S5>:1:2' x_SP = x_ref - x0; *)
        (* '<S5>:1:3' vs=v_ref; *)
        (* '<S5>:1:4' slopeExt=v0-vs; *)
        (* '<S5>:1:5' slopeRetr=-vs-v0; *)
        (* '<S5>:1:7' as = vs/tRamp; *)
        (* '<S5>:1:8' s_acc=(vs^2-v0^2)/as; *)
        (* '<S5>:1:10' tHold=(x_SP-s_acc)/vs; *)
        tHold := ((rtb_Saturation3 - x0m) - (((PosRef * PosRef) - (v0ms * v0ms)) / (PosRef / tRamps))) / PosRef;
        (* '<S5>:1:12' if tHold < 0 *)
        IF tHold < 0.0 THEN 
            (* '<S5>:1:13' Error = 1; *)
            Error := 1;
        ELSE 
            (* '<S5>:1:14' else *)
            (* '<S5>:1:15' Error = 0; *)
            Error := 0;
        END_IF;
        (* '<S5>:1:18' t1=tRamp; *)
        (* '<S5>:1:19' t2=tHold; *)
        (* '<S5>:1:20' t3=tRamp; *)
        (* '<S5>:1:21' t4=tWait; *)
        (* '<S5>:1:22' t5=t1; *)
        (* '<S5>:1:23' t6=t2; *)
        (* '<S5>:1:24' t7=t3; *)
        (* '<S5>:1:26' x1 = x0 + v0*((t0+t1)-t0)-(slopeExt/t1)*((t0+t1)-t0)^2/2; *)
        a_tmp_tmp := t0s + tRamps;
        a_tmp := a_tmp_tmp - t0s;
        x1_tmp := (v0ms - PosRef) / tRamps;
        x1 := ((a_tmp * v0ms) + x0m) - ((x1_tmp * (a_tmp * a_tmp)) / 2.0);
        (* '<S5>:1:27' x2 = x1 + vs*((t0+t1+t2)-(t0+t1)); *)
        (* '<S5>:1:28' x4 = x_ref - v0*((t0+t1+t2+t3+t4+t5)-(t0+t1+t2+t3+t4))+(slopeRetr/t5)*((t0+t1+t2+t3+t4+t5)-(t0+t1+t2+t3+t4))^2/2; *)
        a_tmp_tmp_0 := a_tmp_tmp + tHold;
        a_tmp_tmp_1 := a_tmp_tmp_0 + tRamps;
        a_tmp := a_tmp_tmp_1 + tHoldPoss;
        a_tmp_tmp_2 := a_tmp + tRamps;
        a_tmp_0 := a_tmp_tmp_2 - a_tmp;
        x4_tmp := (( -PosRef) - v0ms) / tRamps;
        x4 := (rtb_Saturation3 - (a_tmp_0 * v0ms)) + ((x4_tmp * (a_tmp_0 * a_tmp_0)) / 2.0);
        (* '<S5>:1:29' x5 = x4-vs*((t0+t1+t2+t3+t4+t5+t6)-(t0+t1+t2+t3+t4+t5)); *)
        (* '<S5>:1:31' if Error == 1 *)
        IF Error = 1 THEN 
            (* '<S5>:1:32' x = x0; *)
            rtb_Saturation3 := x0m;
            (* '<S5>:1:33' v = v0; *)
            PosRef := v0ms;
        ELSIF (rtb_Time >= 0.0) AND (rtb_Time < t0s) THEN 
            (* '<S5>:1:34' elseif t>=0 && t<t0 *)
            (* '<S5>:1:35' x = x0; *)
            rtb_Saturation3 := x0m;
            (* '<S5>:1:36' v = v0; *)
            PosRef := v0ms;
        ELSIF (rtb_Time >= t0s) AND (rtb_Time < a_tmp_tmp) THEN 
            (* '<S5>:1:37' elseif t>=t0 && t<(t0+t1) *)
            (* '<S5>:1:38' x = x0 + v0*(t-t0)-(slopeExt/t1)*(t-t0)^2/2; *)
            rtb_Time := rtb_Time - t0s;
            rtb_Saturation3 := ((rtb_Time * v0ms) + x0m) - ((x1_tmp * (rtb_Time * rtb_Time)) / 2.0);
            (* '<S5>:1:39' v = v0-(slopeExt/t1)*(t-t0); *)
            PosRef := v0ms - (x1_tmp * rtb_Time);
        ELSIF (rtb_Time >= a_tmp_tmp) AND (rtb_Time < a_tmp_tmp_0) THEN 
            (* '<S5>:1:40' elseif t>=(t0+t1) && t<(t0+t1+t2) *)
            (* '<S5>:1:41' x = x1 + vs*(t-(t0+t1)); *)
            rtb_Saturation3 := ((rtb_Time - a_tmp_tmp) * PosRef) + x1;
            (* '<S5>:1:42' v = vs; *)
        ELSIF (rtb_Time >= a_tmp_tmp_0) AND (rtb_Time < a_tmp_tmp_1) THEN 
            (* '<S5>:1:43' elseif t>=(t0+t1+t2) && t<(t0+t1+t2+t3) *)
            (* '<S5>:1:44' x = x2+vs*(t-(t0+t1+t2))+(slopeExt/t3)*(t-(t0+t1+t2))^2/2; *)
            rtb_Time := rtb_Time - a_tmp_tmp_0;
            rtb_Saturation3 := ((((a_tmp_tmp_0 - a_tmp_tmp) * PosRef) + x1) + (rtb_Time * PosRef)) + ((x1_tmp * (rtb_Time * rtb_Time)) / 2.0);
            (* '<S5>:1:45' v = vs+(slopeExt/t3)*(t-(t0+t1+t2)); *)
            PosRef := (rtb_Time * x1_tmp) + PosRef;
        ELSIF (rtb_Time >= a_tmp_tmp_1) AND (rtb_Time < a_tmp) THEN 
            (* '<S5>:1:46' elseif t>=(t0+t1+t2+t3) && t<(t0+t1+t2+t3+t4) *)
            (* '<S5>:1:47' x = x_ref; *)
            (* '<S5>:1:48' v = v0; *)
            PosRef := v0ms;
        ELSIF (rtb_Time >= a_tmp) AND (rtb_Time < a_tmp_tmp_2) THEN 
            (* '<S5>:1:49' elseif t>=(t0+t1+t2+t3+t4) && t<(t0+t1+t2+t3+t4+t5) *)
            (* '<S5>:1:50' x = x_ref - v0*(t-(t0+t1+t2+t3+t4))+(slopeRetr/t5)*(t-(t0+t1+t2+t3+t4))^2/2; *)
            a_tmp := rtb_Time - a_tmp;
            rtb_Saturation3 := (rtb_Saturation3 - (a_tmp * v0ms)) + ((x4_tmp * (a_tmp * a_tmp)) / 2.0);
            (* '<S5>:1:51' v = v0+(slopeRetr/t5)*(t-(t0+t1+t2+t3+t4)); *)
            PosRef := (a_tmp * x4_tmp) + v0ms;
        ELSE 
            rtb_Saturation3 := a_tmp_tmp_2 + tHold;
            IF (rtb_Time >= a_tmp_tmp_2) AND (rtb_Time < rtb_Saturation3) THEN 
                (* '<S5>:1:52' elseif t>=(t0+t1+t2+t3+t4+t5) && t<(t0+t1+t2+t3+t4+t5+t6) *)
                (* '<S5>:1:53' x = x4-vs*(t-(t0+t1+t2+t3+t4+t5)); *)
                rtb_Saturation3 := x4 - ((rtb_Time - a_tmp_tmp_2) * PosRef);
                (* '<S5>:1:54' v = -vs; *)
                PosRef :=  -PosRef;
            ELSIF (rtb_Time >= rtb_Saturation3) AND (rtb_Time < (rtb_Saturation3 + tRamps)) THEN 
                (* '<S5>:1:55' elseif t>=(t0+t1+t2+t3+t4+t5+t6) && t<(t0+t1+t2+t3+t4+t5+t6+t7) *)
                (* '<S5>:1:56' x = x5-vs*(t-(t0+t1+t2+t3+t4+t5+t6))-(slopeRetr/t3)*(t-(t0+t1+t2+t3+t4+t5+t6))^2/2; *)
                rtb_Time := rtb_Time - rtb_Saturation3;
                rtb_Saturation3 := ((x4 - ((rtb_Saturation3 - a_tmp_tmp_2) * PosRef)) - (rtb_Time * PosRef)) - ((x4_tmp * (rtb_Time * rtb_Time)) / 2.0);
                (* '<S5>:1:57' v = -vs-(slopeRetr/t3)*(t-(t0+t1+t2+t3+t4+t5+t6)); *)
                PosRef := ( -PosRef) - (rtb_Time * x4_tmp);
            ELSE 
                (* '<S5>:1:58' else *)
                (* '<S5>:1:59' x = x0; *)
                rtb_Saturation3 := x0m;
                (* '<S5>:1:60' v = v0; *)
                PosRef := v0ms;
            END_IF;
        END_IF;
        (* End of MATLAB Function: '<S3>/RampSignal' *)
        
        (* Switch: '<S3>/Switch' *)
        (* '<S5>:1:63' T = t0+t1+t2+t3+t4+t5+t6+t7; *)
        IF  NOT Enable THEN 
            PosRef := v0ms;
        END_IF;
        (* End of Switch: '<S3>/Switch' *)
        
        (* Saturate: '<S3>/Saturation' *)
        IF PosRef > 150.0 THEN 
            (* Outport: '<Root>/VelRef' *)
            VelRef := 150.0;
        ELSIF PosRef >= -150.0 THEN 
            (* Outport: '<Root>/VelRef' *)
            VelRef := PosRef;
        ELSE 
            (* Outport: '<Root>/VelRef' *)
            VelRef := -150.0;
        END_IF;
        (* End of Saturate: '<S3>/Saturation' *)
        
        (* Switch: '<S3>/Switch1' *)
        IF Enable THEN 
            PosRef := rtb_Saturation3;
        ELSE 
            PosRef := x0m;
        END_IF;
        (* End of Switch: '<S3>/Switch1' *)
        
        (* Saturate: '<S3>/Saturation1' *)
        IF PosRef > 500.0 THEN 
            (* Outport: '<Root>/PosRef' *)
            PosRef := 500.0;
        ELSIF PosRef < 0.0 THEN 
            (* Outport: '<Root>/PosRef' *)
            PosRef := 0.0;
        END_IF;
        (* End of Saturate: '<S3>/Saturation1' *)
        (* End of Outputs for SubSystem: '<S1>/RampMotionProfileGenerator' *)
        
        (* Update for DiscreteIntegrator: '<S2>/Discrete-Time Integrator' *)
        c_DiscreteTimeIntegrator_DS := c_DiscreteTimeIntegrator_DS + 0.001;
        (* End of Outputs for SubSystem: '<Root>/Subsystem' *)
END_CASE;
END_FUNCTION_BLOCK
VAR_GLOBAL CONSTANT
    SS_INITIALIZE: SINT := 0;
    SS_STEP: SINT := 1;
END_VAR
