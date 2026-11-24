% Day 025 · Complex Numbers and Phasors — A series RLC circuit with AC supply
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

V = 230;  f = 50;  w = 2*pi*f;
R = 10;  L = 50e-3;  C = 100e-6;
Z = R + 1j*w*L + 1/(1j*w*C);
I = V / Z;
fprintf('Impedance Z = %.2f %+.2fj ohm (|Z| = %.2f, angle %.2f deg)\n', real(Z), imag(Z), abs(Z), rad2deg(angle(Z)));
fprintf('Current |I| = %.3f A at %.2f deg\n', abs(I), rad2deg(angle(I)));
S = V * conj(I);
fprintf('P = %.1f W, Q = %.1f VAR, |S| = %.1f VA, pf = %.3f\n', real(S), imag(S), abs(S), cos(angle(S)));
