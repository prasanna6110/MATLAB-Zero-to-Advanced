% Day 025 · Complex Numbers and Phasors — Complex number basics
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

z1 = 3 + 4i;
z2 = 1 - 2i;
z1 + z2
z1 * z2
z1 / z2
abs(z1)
rad2deg(angle(z1))
conj(z1)
[theta, r] = cart2pol(real(z1), imag(z1))
roots([1 2 5])                 % a quadratic with complex roots
