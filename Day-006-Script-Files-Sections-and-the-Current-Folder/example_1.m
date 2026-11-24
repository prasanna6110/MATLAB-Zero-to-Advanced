% Day 006 · Script Files, Sections and the Current Folder — A complete script with sections
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

%% Section 1: inputs
clc; clear;
L = 0.5;          % inductance in henry
C = 20e-6;        % capacitance in farad
R = 10;           % resistance in ohm

%% Section 2: resonance of a series RLC circuit
f0 = 1 / (2 * pi * sqrt(L * C));       % resonant frequency
Q  = (1 / R) * sqrt(L / C);            % quality factor
BW = f0 / Q;                           % bandwidth

%% Section 3: results
fprintf('Resonant frequency f0 = %.2f Hz\n', f0);
fprintf('Quality factor     Q  = %.2f\n', Q);
fprintf('Bandwidth          BW = %.2f Hz\n', BW);
