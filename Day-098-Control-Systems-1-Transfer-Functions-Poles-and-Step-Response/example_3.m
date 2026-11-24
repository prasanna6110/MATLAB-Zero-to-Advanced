% Day 098 · Control Systems 1: Transfer Functions, Poles and Step Response — stepinfo and lsim (MATLAB)
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

% MATLAB-ONLY: stepinfo is not in GNU Octave's control package
s = tf('s');
G = 25 / (s^2 + 4*s + 25);
info = stepinfo(G)
t = 0:0.01:6;
u = double(t >= 1) - double(t >= 3);       % a pulse input
lsim(G, u, t); grid on
damp(G)
