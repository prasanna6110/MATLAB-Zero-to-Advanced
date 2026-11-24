# Day 093 · Model-Based Design: Subsystems, Transfer Functions and MATLAB Function Blocks

_Simulink_

## Model-based design
**Model-based design** means the model is the centre of the project: you **design** with it, **simulate** to test the design, **tune** parameters, **verify** requirements, and finally **generate code** from it for the real hardware. The same model is reused at every step.

## Tools for bigger models
| Feature | Use |
|---------|-----|
| **Subsystem** | select blocks → right-click → *Create Subsystem from Selection* (Ctrl+G). Groups blocks into one block with In/Out ports. Keeps big models readable |
| **Masked subsystem** | right-click → *Mask → Create Mask*: give the subsystem its own parameter dialog and icon |
| **Transfer Fcn** block | enter numerator and denominator, e.g. `[1]`, `[0.5 1]` for 1/(0.5s + 1) |
| **State-Space** block | A, B, C, D matrices |
| **MATLAB Function** block | write MATLAB code that runs inside the model (e.g. a control law, a lookup) |
| **Lookup Table** blocks | measured characteristics (efficiency maps, PV curves) |
| **Model Workspace / Data Dictionary** | store parameters with the model |
| **Referenced models** | reuse a whole model as a block in others |
| **Variant Subsystems** | switch between designs |

## Running simulations from scripts
```matlab
for K = [1 2 5]
    set_param('mdl/Gain', 'Gain', num2str(K));
    out = sim('mdl');
    ...
end
```
Or use `Simulink.SimulationInput` objects and `parsim` to run many simulations in parallel. This is how you do **parameter sweeps**, sensitivity studies and Monte Carlo runs.

## Examples

### Example 1: A transfer-function model and a parameter sweep from code  ([`example_1.m`](example_1.m))

```matlab
% MATLAB-ONLY: needs Simulink
mdl = 'tf_sweep';
new_system(mdl);
add_block('simulink/Sources/Step',             [mdl '/Step'], 'Time', '0');
add_block('simulink/Math Operations/Sum',      [mdl '/Err'], 'Inputs', '|+-');
add_block('simulink/Math Operations/Gain',     [mdl '/K'], 'Gain', 'K');
add_block('simulink/Continuous/Transfer Fcn',  [mdl '/Plant'], 'Numerator', '[1]', 'Denominator', '[1 3 2]');
add_block('simulink/Sinks/To Workspace',       [mdl '/y'], 'VariableName', 'y', 'SaveFormat', 'Array');
add_line(mdl, 'Step/1', 'Err/1');  add_line(mdl, 'Err/1', 'K/1');
add_line(mdl, 'K/1', 'Plant/1');   add_line(mdl, 'Plant/1', 'y/1');
add_line(mdl, 'Plant/1', 'Err/2');
hold on
for K = [1 5 20]
    set_param([mdl '/K'], 'Gain', num2str(K));
    out = sim(mdl, 'StopTime', '8');
    plot(out.tout, out.get('y'), 'DisplayName', sprintf('K = %d', K));
end
hold off; grid on; legend show; title('Closed loop with different gains')
close_system(mdl, 0);
```

### Example 2: The same closed-loop sweep computed with ode45  ([`example_2.m`](example_2.m))

```matlab
% Plant 1/(s^2 + 3s + 2) with proportional gain K and unity feedback:
% y'' + 3y' + 2y = K (r - y),  r = 1
hold on
for K = [1 5 20]
    [t, Y] = ode45(@(t, s) [s(2); K*(1 - s(1)) - 3*s(2) - 2*s(1)], [0 8], [0; 0]);
    plot(t, Y(:, 1), 'DisplayName', sprintf('K = %d', K));
    fprintf('K = %2d: final value %.3f (theory K/(K+2) = %.3f), overshoot %.1f %%\n', K, Y(end, 1), K/(K + 2), 100*max(0, max(Y(:, 1)) - K/(K+2))/(K/(K+2)));
end
hold off; grid on; legend show; xlabel('t (s)')
```

### Example 3: What a MATLAB Function block contains  ([`example_3.m`](example_3.m))

```matlab
% A MATLAB Function block holds a function like this one. Simulink calls it at every
% time step with the block's input signals and uses the returned values as outputs.
% Here it is tested as an ordinary function on some sample inputs.
p_load = 4.0;                       % kW
p_pv = [1.0 2.5 6.0 6.0 9.0];       % kW of solar at five moments
soc  = [10  50  50  95  40];        % % state of charge at those moments
for k = 1:numel(soc)
    [p_bat, mode] = battery_logic(p_load, p_pv(k), soc(k));
    fprintf('PV %.1f kW, SOC %3d %%: battery power %+5.2f kW (%s)\n', p_pv(k), soc(k), p_bat, mode);
end

function [p_bat, mode] = battery_logic(p_load, p_pv, soc)
% Inputs: load power, PV power (kW) and state of charge (%). Output: battery power (+ = discharge)
    p_net = p_load - p_pv;
    if p_net > 0 && soc > 20
        p_bat = min(p_net, 3);  mode = 'discharging';
    elseif p_net < 0 && soc < 90
        p_bat = max(p_net, -3); mode = 'charging';
    else
        p_bat = 0;              mode = 'idle';
    end
end
```

## Practice

1. Group the blocks of your mass-spring-damper (Day 92) into a subsystem with one input (force) and one output (position).
2. Mask the subsystem so m, c and k can be typed in a dialog.
3. Replace the integrator chain with a single **Transfer Fcn** block `1/(m s² + c s + k)` and compare.
4. Write a script that runs your model for 5 values of a parameter and plots all results.

---

[⬅ Day 092](../Day-092-Building-and-Running-Your-First-Simulink-Model/README.md) · [🏠 Home](../README.md) · [Day 094 ➡](../Day-094-Physical-Modelling-with-Simscape-and-Simulink-Supported-Hardware/README.md)
