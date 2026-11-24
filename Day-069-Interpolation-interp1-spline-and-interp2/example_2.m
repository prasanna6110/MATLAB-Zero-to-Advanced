% Day 069 · Interpolation: interp1, spline and interp2 — Looking up a table: transformer efficiency
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

load_pct = [10 25 50 75 100 125];
eff = [93.1 96.5 97.9 98.2 98.1 97.8];
query = [40 60 90 110];
eff_q = interp1(load_pct, eff, query, 'pchip');
for k = 1:numel(query)
    fprintf('Efficiency at %3d%% load: %.2f %%\n', query(k), eff_q(k));
end
interp1(load_pct, eff, 150)                 % NaN outside the table
interp1(load_pct, eff, 150, 'linear', 'extrap')   % extrapolated: use with care
% Find the load for best efficiency on a fine grid
fine = 10:0.1:125;
[best, k] = max(interp1(load_pct, eff, fine, 'spline'));
fprintf('Best efficiency %.2f %% near %.1f %% load\n', best, fine(k));
