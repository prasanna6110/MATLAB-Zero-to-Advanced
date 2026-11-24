% Day 092 · Building and Running Your First Simulink Model — Build the first-order model entirely from code
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

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
