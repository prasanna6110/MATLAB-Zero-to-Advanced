% Day 014 · Logical Indexing: Selecting Data with Conditions — Cleaning measured data
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

readings = [229 231 NaN 228 999 230 -1 232 NaN 227];
valid = readings(~isnan(readings) & readings > 0 & readings < 300);
fprintf('Valid readings: %s\n', mat2str(valid));
fprintf('Mean voltage  : %.2f V\n', mean(valid));
fprintf('Bad samples   : %d\n', numel(readings) - numel(valid));
% Replace the bad ones with the mean instead of removing them
fixed = readings;
bad = isnan(fixed) | fixed <= 0 | fixed >= 300;
fixed(bad) = round(mean(valid));
disp(fixed)
