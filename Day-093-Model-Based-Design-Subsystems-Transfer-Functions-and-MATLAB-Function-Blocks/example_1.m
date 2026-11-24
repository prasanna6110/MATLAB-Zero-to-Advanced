% Day 093 · Model-Based Design: Subsystems, Transfer Functions and MATLAB Function Blocks — A transfer-function model and a parameter sweep from code
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

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
