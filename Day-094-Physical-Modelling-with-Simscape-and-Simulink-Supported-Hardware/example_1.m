% Day 094 · Physical Modelling with Simscape and Simulink-Supported Hardware — A Simscape RLC circuit built from code
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

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
