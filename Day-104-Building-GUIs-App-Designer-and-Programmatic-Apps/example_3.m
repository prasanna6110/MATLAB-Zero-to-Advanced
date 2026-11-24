% Day 104 · Building GUIs: App Designer and Programmatic Apps — The logic behind an app, tested without the window
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

% Good practice: keep the calculations in plain functions so they can be tested
% without clicking. The app's callbacks just call these functions.
inputs = struct('V', {230, 230, 415}, 'P_kW', {1.5, 5, 22}, 'pf', {0.9, 0.85, 0.88}, 'phases', {1, 1, 3});
for k = 1:numel(inputs)
    r = cable_current(inputs(k));
    fprintf('%d-phase, %5.1f kW at %d V: I = %6.2f A -> choose a %d A breaker\n', ...
        inputs(k).phases, inputs(k).P_kW, inputs(k).V, r.I, r.breaker);
end

function r = cable_current(in)
    if in.phases == 3
        r.I = in.P_kW*1e3 / (sqrt(3) * in.V * in.pf);
    else
        r.I = in.P_kW*1e3 / (in.V * in.pf);
    end
    sizes = [6 10 16 20 25 32 40 50 63 80 100];
    r.breaker = sizes(find(sizes >= 1.25*r.I, 1));
end
