# Day 095 · Simulink Examples: Feedback Control with a PID Controller

_Simulink_

## A closed-loop control system in Simulink
```
 reference r ──►(Σ)── e ──► [ PID ] ── u ──► [ Plant ] ──┬──► y ──► Scope
                 ▲−                                        │
                 └─────────────────────────────────────────┘
```
1. **Step** (the set point r) → **Sum** (`|+-`) → **PID Controller** → **Transfer Fcn** (the plant) → **Scope**.
2. Feed the plant output back to the minus input of the Sum.
3. Double-click the PID block: set P, I, D, or press **Tune...** to open the **PID Tuner**, which finds gains for a chosen response time and robustness automatically.
4. Add **Saturation** after the PID to model actuator limits (and enable anti-windup in the PID block).

## Judging the response
| Measure | Meaning |
|---------|---------|
| Rise time | time to go from 10% to 90% of the final value |
| Overshoot | how far above the final value it goes (%) |
| Settling time | time to stay within ±2% of the final value |
| Steady-state error | final difference between r and y |

Effects of the gains: **P** makes the response faster but alone leaves an error (for most plants) and adds overshoot; **I** removes the steady-state error but can add overshoot; **D** adds damping (less overshoot) but amplifies noise.

The same analysis can be done in MATLAB code with the Control System Toolbox (`pid`, `feedback`, `step`, `stepinfo`, Day 98) or by simulating the equations yourself, as in the runnable example below.

## Examples

### Example 1: PID control loop built in Simulink from code  ([`example_1.m`](example_1.m))

```matlab
% MATLAB-ONLY: needs Simulink
mdl = 'pid_loop';
new_system(mdl);
add_block('simulink/Sources/Step',               [mdl '/Ref'], 'Time', '0', 'After', '1');
add_block('simulink/Math Operations/Sum',        [mdl '/Err'], 'Inputs', '|+-');
add_block('simulink/Continuous/PID Controller',  [mdl '/PID'], 'P', '6', 'I', '4', 'D', '0.8', 'N', '100');
add_block('simulink/Continuous/Transfer Fcn',    [mdl '/Plant'], 'Numerator', '[1]', 'Denominator', '[1 3 2]');
add_block('simulink/Sinks/To Workspace',         [mdl '/y'], 'VariableName', 'y', 'SaveFormat', 'Array');
add_line(mdl, 'Ref/1', 'Err/1');  add_line(mdl, 'Err/1', 'PID/1');
add_line(mdl, 'PID/1', 'Plant/1'); add_line(mdl, 'Plant/1', 'y/1');
add_line(mdl, 'Plant/1', 'Err/2');
out = sim(mdl, 'StopTime', '6');
plot(out.tout, out.get('y')); grid on; title('PID closed loop (Simulink)')
close_system(mdl, 0);
```

### Example 2: The same PID loop simulated step by step in plain MATLAB  ([`example_2.m`](example_2.m))

```matlab
% Plant 1/(s^2 + 3s + 2), PID gains as in the Simulink model, unity feedback
Kp = 6; Ki = 4; Kd = 0.8;
dt = 1e-4; t = 0:dt:6; r = 1;
x = [0; 0]; integ = 0; e_prev = r;               % plant states y, y'
y = zeros(size(t));
for k = 1:numel(t)
    y(k) = x(1);
    e = r - y(k);
    integ = integ + e*dt;
    deriv = (e - e_prev)/dt;  e_prev = e;
    if k == 1, deriv = 0; end                      % avoid the derivative kick at t = 0
    u = Kp*e + Ki*integ + Kd*deriv;
    x = x + dt * [x(2); u - 3*x(2) - 2*x(1)];      % Euler step of the plant
end
plot(t, y, 'LineWidth', 1.5); grid on; xlabel('t (s)'); ylabel('y'); title('PID loop simulated in code')
final = y(end); os = 100*(max(y) - final)/final;
ts = t(find(abs(y - final) > 0.02*final, 1, 'last'));
fprintf('Final value %.4f, overshoot %.1f %%, settling time (2%%) %.2f s\n', final, os, ts);
```

### Example 3: Comparing P, PI and PID on the same plant  ([`example_3.m`](example_3.m))

```matlab
gains = [6 0 0; 6 4 0; 6 4 0.8];
names = {'P only', 'PI', 'PID'};
dt = 1e-3; t = 0:dt:8;
hold on
for g = 1:3
    Kp = gains(g, 1); Ki = gains(g, 2); Kd = gains(g, 3);
    x = [0; 0]; integ = 0; e_prev = 1; y = zeros(size(t));
    for k = 1:numel(t)
        y(k) = x(1); e = 1 - y(k);
        integ = integ + e*dt;
        d = (e - e_prev)/dt; e_prev = e; if k == 1, d = 0; end
        u = Kp*e + Ki*integ + Kd*d;
        x = x + dt*[x(2); u - 3*x(2) - 2*x(1)];
    end
    plot(t, y, 'DisplayName', names{g});
    fprintf('%-6s: final %.3f, steady-state error %.3f, peak %.3f\n', names{g}, y(end), 1 - y(end), max(y));
end
hold off; grid on; legend show; xlabel('t (s)')
```

## Practice

1. Build the PID loop with the mouse, then press **Tune...** in the PID block and accept the suggested gains.
2. Add a Saturation block (limits ±5) after the PID. How does the response change?
3. Add a step disturbance at the plant input at t = 3 s and watch the controller reject it.
4. In the code version, try Kd = 0 and Kd = 2. What happens to the overshoot?

---

[⬅ Day 094](../Day-094-Physical-Modelling-with-Simscape-and-Simulink-Supported-Hardware/README.md) · [🏠 Home](../README.md) · [Day 096 ➡](../Day-096-Signal-Processing-1-Sampling-FFT-and-the-Frequency-Spectrum/README.md)
