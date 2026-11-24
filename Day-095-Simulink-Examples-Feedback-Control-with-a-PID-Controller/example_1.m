% Day 095 · Simulink Examples: Feedback Control with a PID Controller — PID control loop built in Simulink from code
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

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
