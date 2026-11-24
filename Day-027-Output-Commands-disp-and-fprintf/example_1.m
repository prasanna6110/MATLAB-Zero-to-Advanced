% Day 027 · Output Commands: disp and fprintf — disp vs fprintf
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

V = 230; I = 4.567;
disp(V)
disp('Supply details:')
disp(['Current = ' num2str(I) ' A'])
fprintf('Voltage = %d V\n', V);
fprintf('Current = %.2f A and power = %.1f W\n', I, V*I);
fprintf('Very small: %e, compact: %g\n', 0.000123, 0.000123);
fprintf('Efficiency is 95%%\n');
fprintf('It''s done!\n');
