% Day 066 · Polynomial Arithmetic: conv, deconv, polyder, polyint and residue — Adding, multiplying and dividing polynomials
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

a = [3 15 0 -10 -3 15 -40];
b = [3 0 -2 -6];
b_padded = [zeros(1, numel(a) - numel(b)) b];
sum_ab = a + b_padded
prod_ab = conv(a, b)
[q, r] = deconv(a, b)
check = conv(b, q) + r - a      % should be all zeros
