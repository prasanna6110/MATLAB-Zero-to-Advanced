% Day 002 · Working in the Command Window and Arithmetic with Scalars — Engineering calculations
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

% 1) Equivalent of three resistors in parallel
R1 = 10; R2 = 20; R3 = 40;
Req = 1 / (1/R1 + 1/R2 + 1/R3)
% 2) Compound interest: amount after n years
P = 50000; r = 0.07; n = 5;
A = P * (1 + r)^n
% 3) Kinetic energy of a 1200 kg car at 25 m/s
m = 1200; v = 25;
KE = 0.5 * m * v^2
