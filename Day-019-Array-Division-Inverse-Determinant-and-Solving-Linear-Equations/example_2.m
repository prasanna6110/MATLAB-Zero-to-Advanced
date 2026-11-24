% Day 019 · Array Division: Inverse, Determinant and Solving Linear Equations — Mesh analysis of a DC circuit
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

% Three meshes. Write KVL for each mesh as R * I = V
%   mesh 1: (2+4)I1 - 4 I2         = 12
%   mesh 2: -4 I1 + (4+6+3)I2 - 3 I3 = 0
%   mesh 3:        -3 I2 + (3+5) I3 = -6
R = [ 6 -4  0
     -4 13 -3
      0 -3  8];
V = [12; 0; -6];
I = R \ V;
fprintf('I1 = %.4f A, I2 = %.4f A, I3 = %.4f A\n', I);
fprintf('Current in the 4 ohm resistor (I1 - I2) = %.4f A\n', I(1) - I(2));
