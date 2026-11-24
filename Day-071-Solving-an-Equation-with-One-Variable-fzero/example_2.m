% Day 071 · Solving an Equation with One Variable: fzero — Solving engineering equations
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

% 1) Diode circuit: 5 = 1000*I + 0.0259*ln(I/1e-12)
diode = @(I) 1000*I + 0.0259*log(I/1e-12) - 5;
I = fzero(diode, [1e-6 5e-3]);
fprintf('Diode current %.4f mA, diode voltage %.4f V\n', I*1000, 5 - 1000*I);
% 2) Time for an RC circuit to charge to 90%
tau = 0.47;
t90 = fzero(@(t) 1 - exp(-t/tau) - 0.9, 1);
fprintf('Reaches 90%% at t = %.4f s (= %.3f tau)\n', t90, t90/tau);
% 3) Kepler-type equation: E - 0.3 sin E = 1.2
E = fzero(@(E) E - 0.3*sin(E) - 1.2, 1);
fprintf('E = %.6f rad\n', E);
