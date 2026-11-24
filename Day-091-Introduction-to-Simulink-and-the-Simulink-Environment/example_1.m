% Day 091 · Introduction to Simulink and the Simulink Environment — Open Simulink and the library from code
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

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
