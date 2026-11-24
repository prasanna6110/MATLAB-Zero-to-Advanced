% Day 087 · Symbolic Integration: int — RMS and average values exactly
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

% Needs: Symbolic Math Toolbox
syms t Vm w T positive
v = Vm*sin(w*t);
T0 = 2*pi/w;
Vrms = simplify(sqrt(int(v^2, t, 0, T0) / T0))     % Vm/sqrt(2)
Vavg_half = simplify(int(v, t, 0, T0/2) / (T0/2))  % 2 Vm / pi
% Energy stored in an inductor: integral of v*i
syms L I0 tau positive
i = I0*(1 - exp(-t/tau));
E_final = limit(int(L*diff(i, t)*i, t, 0, T), T, Inf)
