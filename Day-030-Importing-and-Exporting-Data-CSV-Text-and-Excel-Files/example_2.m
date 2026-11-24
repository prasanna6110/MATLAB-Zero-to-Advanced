% Day 030 · Importing and Exporting Data: CSV, Text and Excel Files — Skipping a header line
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

fid = fopen('readings.csv', 'w');
fprintf(fid, 'time_s,voltage_V,current_A\n');      % a header line
fprintf(fid, '%g,%g,%g\n', [0 1 2 3; 230 229 231 228; 5.1 5.3 5.0 5.4]);
fclose(fid);
M = dlmread('readings.csv', ',', 1, 0);             % start at row 1 (0-based), skip the header
disp(M)
S = importdata('readings.csv');                     % numbers + header text
disp(S.colheaders)
P = M(:, 2) .* M(:, 3);
fprintf('Average power %.1f W\n', mean(P));
delete('readings.csv');
