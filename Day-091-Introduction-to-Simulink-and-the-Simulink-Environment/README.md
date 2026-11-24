# Day 091 · Introduction to Simulink and the Simulink Environment

_Simulink_

## What is Simulink?
**Simulink** is a graphical environment inside MATLAB for modelling and simulating **dynamic systems** with **block diagrams**. Instead of writing equations as code, you connect blocks (integrators, gains, sums, transfer functions, sources, scopes) with lines that carry **signals**. It is used for control systems, power electronics, electrical drives, communication systems, automotive and aerospace systems, and for generating code for embedded hardware.

## Starting Simulink
- Type `simulink` in the Command Window, or **HOME → Simulink**.
- The **Simulink Start Page** opens: choose **Blank Model** (or a template).
- Models are saved as **`.slx`** files.

## The Simulink window
| Part | What it is |
|------|------------|
| **Canvas** | where you build the block diagram |
| **Library Browser** | all blocks, grouped: Sources, Sinks, Continuous, Discrete, Math Operations, Signal Routing, Ports & Subsystems, User-Defined Functions, Simscape … |
| **Toolstrip** | SIMULATION tab: Stop Time, **Run**, Step forward/back; MODELING tab: Model Settings (solver), Update Model |
| **Model Browser** | the hierarchy of subsystems |
| **Property Inspector** | parameters of the selected block |
| **Data Inspector / Scope** | view and compare simulation results |

## Most used blocks
| Library | Blocks |
|---------|--------|
| Sources | Step, Constant, Sine Wave, Ramp, Pulse Generator, Clock, From Workspace, Signal Builder/Editor |
| Sinks | Scope, Display, To Workspace, Out1, XY Graph |
| Continuous | Integrator, Derivative, Transfer Fcn, State-Space, PID Controller, Transport Delay |
| Discrete | Unit Delay, Discrete Transfer Fcn, Zero-Order Hold, Discrete PID |
| Math Operations | Gain, Sum, Product, Abs, Math Function, Trigonometric Function, MinMax |
| Signal Routing | Mux, Demux, Switch, Bus Creator, Goto/From, Manual Switch |
| Discontinuities | Saturation, Dead Zone, Relay, Rate Limiter |
| User-Defined | MATLAB Function, Fcn |

## Working with blocks (the mouse way)
- **Add** a block: drag it from the Library Browser, or click the canvas and **type its name** (quick insert).
- **Connect**: drag from an output port (>) to an input port, or select the source block, hold **Ctrl** and click the destination.
- **Branch** a signal: right-drag (or Ctrl+drag) from an existing line.
- **Parameters**: double-click a block.
- **Rotate / flip**: Ctrl+R / Ctrl+I. **Label a signal**: double-click the line.

## Solver settings (MODELING → Model Settings → Solver)
- **Stop time** of the simulation.
- **Variable-step** solvers (`ode45` default, `ode23t`, `ode15s` for stiff systems such as power electronics) or **fixed-step** solvers (`ode4`, needed for code generation and real-time hardware).
- Max step size and tolerances control the accuracy.

> **GNU Octave note:** Simulink is a MathWorks product and does not run in Octave. Every Simulink example in this course is marked MATLAB-ONLY. Each day also has a runnable MATLAB/Octave script that computes the same result with `ode45`, so you can check your model's output.

## Examples

### Example 1: Open Simulink and the library from code  ([`example_1.m`](example_1.m))

```matlab
% MATLAB-ONLY: needs Simulink
simulink                         % opens the Start Page (or the Library Browser)
mdl = 'first_model';
new_system(mdl);                 % a new, empty model in memory
open_system(mdl);                % show it
get_param(mdl, 'Solver')         % the default solver, usually 'VariableStepAuto' / ode45
set_param(mdl, 'StopTime', '10');
save_system(mdl);                % creates first_model.slx in the current folder
close_system(mdl);
delete('first_model.slx');
```

### Example 2: The system we will model, solved with code  ([`example_2.m`](example_2.m))

```matlab
% dy/dt = (u - y) / tau, u = unit step at t = 1 s  (a first-order lag)
% In Simulink: Step -> Sum(+ -) -> Gain(1/tau) -> Integrator -> Scope, with y fed back to the Sum.
tau = 0.8;
u = @(t) double(t >= 1);
[t, y] = ode45(@(t, y) (u(t) - y)/tau, [0 6], 0, odeset('MaxStep', 0.01));
plot(t, y, 'LineWidth', 1.5); hold on
plot(t, u(t), 'k--'); hold off; grid on
xlabel('t (s)'); legend('y(t)', 'step input u(t)', 'Location', 'southeast')
title('What the Scope of the Simulink model should show')
fprintf('y reaches 63.2%% of the step at t = %.2f s (1 + tau = %.2f)\n', interp1(y, t, 0.632), 1 + tau);
```

## Practice

1. Open Simulink, create a Blank Model and find the Integrator, Gain, Sum, Step and Scope blocks in the Library Browser.
2. Use the quick-insert method (click the canvas and type) to add a Sine Wave block.
3. Open Model Settings and note the default solver and stop time.
4. Save your model as `practice1.slx`, close it and reopen it with `open_system('practice1')`.

---

[⬅ Day 090](../Day-090-Laplace-and-Fourier-Transforms/README.md) · [🏠 Home](../README.md) · [Day 092 ➡](../Day-092-Building-and-Running-Your-First-Simulink-Model/README.md)
