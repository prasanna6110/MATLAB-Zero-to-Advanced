% Day 074 · Ordinary Differential Equations: ode45 — Answers at chosen times and solver options
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

f = @(t, y) -2*y + sin(3*t);
tout = 0:0.5:3;                               % only these times are returned
[t, y] = ode45(f, tout, 1);
disp([t y])
opts = odeset('RelTol', 1e-9, 'AbsTol', 1e-12);
[~, y2] = ode45(f, tout, 1, opts);
fprintf('Difference between default and tight tolerances: %.2e\n', max(abs(y - y2)));
% Population with a varying growth rate, solved with ode23
[t3, p] = ode23(@(t, p) 0.3*(1 + 0.5*sin(t)).*p.*(1 - p/1000), [0 30], 10);
fprintf('Population after 30 days: %.1f (steps used: %d)\n', p(end), numel(t3));
