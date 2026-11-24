% Day 092 · Building and Running Your First Simulink Model — A mass-spring-damper with two integrators, built from code
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

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
