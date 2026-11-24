% Day 011 · Using the Colon in Addressing Arrays and the end Keyword — Selecting data from a measurement table
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

% Each row: [hour, voltage, current, power factor]
data = [ 1 231 12.1 0.92
         2 229 14.8 0.90
         3 226 18.5 0.86
         4 228 16.0 0.88
         5 232 11.2 0.93];
hours = data(:, 1)';
voltage = data(:, 2)';
pf = data(:, end)';
fprintf('Voltages : %s\n', mat2str(voltage));
fprintf('PF hours 2-4: %s\n', mat2str(pf(2:4)));
P = data(:, 2) .* data(:, 3) .* data(:, 4);  % real power in W for every hour
disp([hours' round(P)])           % hour and power side by side
