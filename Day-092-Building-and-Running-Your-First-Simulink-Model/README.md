# Day 092 · Building and Running Your First Simulink Model

_Simulink_

## Modelling a differential equation with an Integrator
The trick: the **Integrator** block turns dy/dt into y. So build the right-hand side of dy/dt = f(t, y, u) from blocks, feed it **into** the integrator, and take y **out** of it, feeding y back where the equation needs it.

### Step by step: dy/dt = (u - y)/τ with a step input
1. New **Blank Model**. Set **Stop Time = 6**.
2. Add: **Step** (Sources), **Sum** (Math Operations), **Gain** (Math Operations), **Integrator** (Continuous), **Scope** (Sinks).
3. Double-click **Sum** → set *List of signs* to `|+-`.
4. Double-click **Gain** → Gain = `1/tau` (MATLAB evaluates workspace variables: run `tau = 0.8` first, or use Model Explorer / Model Workspace).
5. **Step**: Step time = 1, Initial value = 0, Final value = 1.
6. Connect: Step → Sum (+), Sum → Gain → Integrator → Scope.
7. Branch the Integrator output back to the Sum's **minus** input.
8. Click **Run**. Double-click the Scope to see y(t).

### Second-order systems
Use **two integrators** in series: the first gives ẏ from ÿ, the second gives y from ẏ. Build ÿ = (F - c·ẏ - k·y)/m with gains and a sum, exactly like on Day 75.

## Getting results into MATLAB
- **To Workspace** block (variable `simout` or a name you choose), or **Out1** ports, or right-click a signal → **Log Selected Signals**.
- Run from code: `out = sim('model_name');` then `out.tout`, `out.yout`, or `out.get('y')`.
- Signal logging results appear in the **Simulation Data Inspector**.

## Examples

### Example 1: Build the first-order model entirely from code  ([`example_1.m`](example_1.m))

```matlab
% MATLAB-ONLY: needs Simulink
mdl = 'lag_model';
tau = 0.8;                                        %#ok used by the Gain block
new_system(mdl); open_system(mdl);
add_block('simulink/Sources/Step',            [mdl '/Step'], 'Time', '1', 'Before', '0', 'After', '1');
add_block('simulink/Math Operations/Sum',     [mdl '/Sum'], 'Inputs', '|+-');
add_block('simulink/Math Operations/Gain',    [mdl '/Gain'], 'Gain', '1/tau');
add_block('simulink/Continuous/Integrator',   [mdl '/Integrator']);
add_block('simulink/Sinks/Scope',             [mdl '/Scope']);
add_block('simulink/Sinks/To Workspace',      [mdl '/ToWS'], 'VariableName', 'y', 'SaveFormat', 'Array');
add_line(mdl, 'Step/1', 'Sum/1');
add_line(mdl, 'Sum/1', 'Gain/1');
add_line(mdl, 'Gain/1', 'Integrator/1');
add_line(mdl, 'Integrator/1', 'Scope/1');
add_line(mdl, 'Integrator/1', 'ToWS/1');
add_line(mdl, 'Integrator/1', 'Sum/2');          % the feedback path
Simulink.BlockDiagram.arrangeSystem(mdl);        % tidy the layout
out = sim(mdl, 'StopTime', '6');
y = out.get('y');
plot(out.tout, y); grid on; title('Simulink result')
fprintf('Final value %.4f\n', y(end));
close_system(mdl, 0);
```

### Example 2: A mass-spring-damper with two integrators, built from code  ([`example_2.m`](example_2.m))

```matlab
% MATLAB-ONLY: needs Simulink
% m x'' + c x' + k x = F (step of 1 N)
m = 1; c = 0.6; k = 4;                            %#ok used by the blocks
mdl = 'msd_model';
new_system(mdl);
add_block('simulink/Sources/Step',          [mdl '/Force'], 'Time', '0');
add_block('simulink/Math Operations/Sum',   [mdl '/Sum'], 'Inputs', '+--');
add_block('simulink/Math Operations/Gain',  [mdl '/InvMass'], 'Gain', '1/m');
add_block('simulink/Continuous/Integrator', [mdl '/Int_v']);
add_block('simulink/Continuous/Integrator', [mdl '/Int_x']);
add_block('simulink/Math Operations/Gain',  [mdl '/Damping'], 'Gain', 'c');
add_block('simulink/Math Operations/Gain',  [mdl '/Spring'], 'Gain', 'k');
add_block('simulink/Sinks/To Workspace',    [mdl '/x_out'], 'VariableName', 'x', 'SaveFormat', 'Array');
add_line(mdl, 'Force/1', 'Sum/1');
add_line(mdl, 'Sum/1', 'InvMass/1');
add_line(mdl, 'InvMass/1', 'Int_v/1');
add_line(mdl, 'Int_v/1', 'Int_x/1');
add_line(mdl, 'Int_v/1', 'Damping/1');
add_line(mdl, 'Int_x/1', 'Spring/1');
add_line(mdl, 'Damping/1', 'Sum/2');
add_line(mdl, 'Spring/1', 'Sum/3');
add_line(mdl, 'Int_x/1', 'x_out/1');
out = sim(mdl, 'StopTime', '15');
plot(out.tout, out.get('x')); grid on; xlabel('t (s)'); ylabel('x (m)')
close_system(mdl, 0);
```

### Example 3: The same mass-spring-damper with ode45 (check your model)  ([`example_3.m`](example_3.m))

```matlab
m = 1; c = 0.6; k = 4; F = 1;
[t, X] = ode45(@(t, s) [s(2); (F - c*s(2) - k*s(1))/m], [0 15], [0; 0]);
plot(t, X(:, 1), 'LineWidth', 1.5); grid on
xlabel('t (s)'); ylabel('x (m)'); title('Expected Scope output')
fprintf('Peak %.4f m, final %.4f m (F/k = %.4f)\n', max(X(:, 1)), X(end, 1), F/k);
```

## Practice

1. Build the first-order model with the mouse following the steps in the notes, and run it.
2. Change τ in the workspace and re-run. Does the Scope update?
3. Build the mass-spring-damper with the mouse and compare its Scope with the `ode45` plot.
4. Add a **To Workspace** block and plot the result in MATLAB.

---

[⬅ Day 091](../Day-091-Introduction-to-Simulink-and-the-Simulink-Environment/README.md) · [🏠 Home](../README.md) · [Day 093 ➡](../Day-093-Model-Based-Design-Subsystems-Transfer-Functions-and-MATLAB-Function-Blocks/README.md)
