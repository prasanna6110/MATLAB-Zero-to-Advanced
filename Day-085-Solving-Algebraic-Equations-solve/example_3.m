% Day 085 · Solving Algebraic Equations: solve — Solving a formula for any variable
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

% Needs: Symbolic Math Toolbox
syms R L C f w0 V P I
f_res = 1/(2*sym(pi)*sqrt(L*C));
C_needed = solve(f == f_res, C)                 % C for a resonant frequency f
double(subs(C_needed, [f L], [50 0.1]))         % farad for 50 Hz with 100 mH
I_from_P = solve(P == I^2*R, I)                 % two signs
syms Ts k                                       % temperature after time t (cooling law)
syms T0 Ta t positive
T = Ta + (T0 - Ta)*exp(-k*t);
t_needed = solve(T == Ts, t)
