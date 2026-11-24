% Day 103 · Object-Oriented Programming: classdef, Properties and Methods — Using the value class Phasor
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

I1 = Phasor(10, -30);
I2 = Phasor(5, 45);
Itotal = I1 + I2;                   % uses the plus method
fprintf('I1 + I2 = %s A\n', Itotal.polar());
Z = Phasor(20, 36.87);
V = Z * I1;                          % uses mtimes
fprintf('V = Z * I1 = %s V\n', V.polar());
copy = I1;  copy.Value = 0;          % a value class: the copy is independent
fprintf('I1 is unchanged: %s\n', I1.polar());
