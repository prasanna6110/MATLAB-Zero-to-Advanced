% Day 001 · What is MATLAB? Installation and the MATLAB Desktop — MATLAB as a smart calculator
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

% Power in a resistor: P = V^2 / R
V = 230;          % volts
R = 50;           % ohms
P = V^2 / R       % no semicolon -> MATLAB prints the result
I = V / R;        % semicolon -> the result is calculated but NOT printed
disp(I)
% Area and circumference of a circle
r = 3.5;
area = pi * r^2
circumference = 2 * pi * r
