# Day 094 · Physical Modelling with Simscape and Simulink-Supported Hardware

_Simulink_

## Signal-flow vs physical modelling
In ordinary Simulink, lines are **signals** with a direction, and you must derive the equations yourself. **Simscape** (and **Simscape Electrical**, formerly SimPowerSystems) lets you draw the **physical network**: resistors, capacitors, inductors, sources, diodes, switches, motors, transformers, batteries, PV arrays. Lines are physical connections (like wires), and Simscape writes and solves the equations for you.

### Building an RLC circuit in Simscape
1. Type `ssc_new` (or start from a blank model and add the blocks below).
2. From *Simscape → Foundation Library → Electrical → Electrical Elements*: Resistor, Inductor, Capacitor, **Electrical Reference** (ground).
3. A source: *Electrical Sources → DC Voltage Source* (or Controlled Voltage Source driven by a Simulink Step through a **Simulink-PS Converter**).
4. A sensor: *Electrical Sensors → Current Sensor* (in series) or Voltage Sensor (in parallel), followed by a **PS-Simulink Converter** and a Scope.
5. Every Simscape network needs one **Solver Configuration** block connected to it.
6. Run. Use a stiff solver (`ode23t` or `ode15s`) for circuits with switches.

Simscape Electrical adds power-system and drives blocks: three-phase sources, transmission lines, circuit breakers, synchronous and induction machines, converters with IGBTs, PWM generators, PV arrays and batteries. It is the standard tool for **microgrid**, **inverter** and **motor drive** studies.

## Simulink-supported hardware
| Hardware | How |
|----------|-----|
| **Arduino**, **Raspberry Pi**, **ESP32**, **BeagleBone** | free *Support Packages* (APPS → Get Hardware Support Packages). Run the model on the board or in **External Mode** (tune parameters live) |
| **TI C2000, STM32** microcontrollers | Embedded Coder support for motor control and power electronics |
| **Speedgoat**, real-time targets | **Simulink Real-Time** for hardware-in-the-loop (HIL) testing |
| FPGAs | HDL Coder |
| Code generation | **Simulink Coder / Embedded Coder** turn a model into C/C++ code |

Typical student uses: blink an LED and read sensors on Arduino from Simulink; closed-loop DC motor speed control; data acquisition into MATLAB.

## Examples

### Example 1: A Simscape RLC circuit built from code  ([`example_1.m`](example_1.m))

```matlab
% MATLAB-ONLY: needs Simulink and Simscape
mdl = 'rlc_simscape';
new_system(mdl); open_system(mdl);
lib = 'fl_lib/Electrical/Electrical Elements/';
add_block([lib 'Resistor'],  [mdl '/R'], 'R', '10');
add_block([lib 'Inductor'],  [mdl '/L'], 'l', '0.1');
add_block([lib 'Capacitor'], [mdl '/C'], 'c', '100e-6');
add_block([lib 'Electrical Reference'], [mdl '/Gnd']);
add_block('fl_lib/Electrical/Electrical Sources/DC Voltage Source', [mdl '/Vdc'], 'v0', '24');
add_block('fl_lib/Electrical/Electrical Sensors/Current Sensor', [mdl '/Isense']);
add_block('nesl_utility/Solver Configuration', [mdl '/Solver']);
add_block('nesl_utility/PS-Simulink Converter', [mdl '/PS2SL']);
add_block('simulink/Sinks/Scope', [mdl '/Scope']);
% Physical connections use the port handles: LConn = left, RConn = right
ph = @(b) get_param([mdl '/' b], 'PortHandles');
add_line(mdl, ph('Vdc').LConn(1), ph('R').LConn(1));
add_line(mdl, ph('R').RConn(1), ph('L').LConn(1));
add_line(mdl, ph('L').RConn(1), ph('Isense').LConn(1));
add_line(mdl, ph('Isense').RConn(2), ph('C').LConn(1));
add_line(mdl, ph('C').RConn(1), ph('Vdc').RConn(1));
add_line(mdl, ph('Vdc').RConn(1), ph('Gnd').LConn(1));
add_line(mdl, ph('Solver').RConn(1), ph('Gnd').LConn(1));
add_line(mdl, ph('Isense').RConn(1), ph('PS2SL').LConn(1));
add_line(mdl, ph('PS2SL').Outport(1), ph('Scope').Inport(1));
set_param(mdl, 'Solver', 'ode23t', 'StopTime', '0.1');
sim(mdl);
```

### Example 2: The expected current of that circuit, from the equations  ([`example_2.m`](example_2.m))

```matlab
% A 24 V source switched onto series R-L-C at t = 0 (capacitor initially empty)
R = 10; L = 0.1; C = 100e-6; V = 24;
alpha = R/(2*L); w0 = 1/sqrt(L*C); wd = sqrt(w0^2 - alpha^2);
t = linspace(0, 0.1, 2000);
i = V/(wd*L) * exp(-alpha*t) .* sin(wd*t);        % underdamped closed-form solution
plot(t*1000, i, 'LineWidth', 1.5); grid on
xlabel('t (ms)'); ylabel('i (A)'); title('Current the Simscape Scope should show')
[ipk, k] = max(i);
fprintf('alpha = %.1f 1/s, w0 = %.1f rad/s, wd = %.1f rad/s\n', alpha, w0, wd);
fprintf('Peak current %.3f A at %.2f ms\n', ipk, t(k)*1000);
```

### Example 3: A DC motor model (what a Simscape motor block solves)  ([`example_3.m`](example_3.m))

```matlab
% Armature: L di/dt = V - R i - Ke w ;  Mechanics: J dw/dt = Kt i - b w - T_load
R = 1.2; L = 0.005; Ke = 0.05; Kt = 0.05; J = 2e-4; b = 1e-5; V = 12;
T_load = @(t) 0.02 * (t >= 0.6);                % a load torque applied at 0.6 s
f = @(t, s) [(V - R*s(1) - Ke*s(2))/L; (Kt*s(1) - b*s(2) - T_load(t))/J];
[t, S] = ode45(f, [0 1.2], [0; 0], odeset('MaxStep', 1e-3));
subplot(2, 1, 1); plot(t, S(:, 2)*60/(2*pi)); ylabel('Speed (rpm)'); grid on
subplot(2, 1, 2); plot(t, S(:, 1)); ylabel('Current (A)'); xlabel('t (s)'); grid on
fprintf('No-load speed %.0f rpm, loaded speed %.0f rpm\n', interp1(t, S(:, 2), 0.59)*60/(2*pi), S(end, 2)*60/(2*pi));
```

## Practice

1. Build the RLC circuit with Simscape blocks using the mouse and compare the current with the closed-form plot.
2. Change R to 100 Ω. What happens to the oscillation?
3. Install the Arduino Support Package and run the "blink" example model.
4. Find the *Simscape Electrical → Specialized Power Systems* library and list 5 power-system blocks.

---

[⬅ Day 093](../Day-093-Model-Based-Design-Subsystems-Transfer-Functions-and-MATLAB-Function-Blocks/README.md) · [🏠 Home](../README.md) · [Day 095 ➡](../Day-095-Simulink-Examples-Feedback-Control-with-a-PID-Controller/README.md)
